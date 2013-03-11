Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFA7W-0006G8-3Y
 for kexec@lists.infradead.org; Mon, 11 Mar 2013 21:18:59 +0000
Message-ID: <513E4A3E.3060405@citrix.com>
Date: Mon, 11 Mar 2013 21:18:54 +0000
From: Andrew Cooper <andrew.cooper3@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 5/8] kexec: extend hypercall with improved
 load/unload ops
References: <20130308152334.GA11057@debian70-amd64.local.net-space.pl>
 <513A1FE1.9040407@citrix.com>
 <20130308214547.GC11057@debian70-amd64.local.net-space.pl>
 <513A765B.8000709@citrix.com>
 <20130311111720.GA13175@debian70-amd64.local.net-space.pl>
 <513DDA5A.7090409@citrix.com>
 <20130311133037.GB13175@debian70-amd64.local.net-space.pl>
 <513DDF66.7060108@citrix.com>
 <20130311141316.GC13175@debian70-amd64.local.net-space.pl>
 <513DE9CE.9050303@citrix.com>
 <20130311204541.GA13567@debian70-amd64.local.net-space.pl>
In-Reply-To: <20130311204541.GA13567@debian70-amd64.local.net-space.pl>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, David Vrabel <david.vrabel@citrix.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 11/03/13 20:45, Daniel Kiper wrote:
> On Mon, Mar 11, 2013 at 02:27:26PM +0000, Andrew Cooper wrote:
>> On 11/03/13 14:13, Daniel Kiper wrote:
>>> On Mon, Mar 11, 2013 at 01:43:02PM +0000, David Vrabel wrote:
>>>> On 11/03/13 13:30, Daniel Kiper wrote:
>>>>> On Mon, Mar 11, 2013 at 01:21:30PM +0000, David Vrabel wrote:
>>>>>> On 11/03/13 11:17, Daniel Kiper wrote:
>>>>>>> Heh... It looks that there is a misunderstanding. At first I thought
>>>>>>> that David was going to replace purgatory functionality by switching
>>>>>>> from 64-bit to 32-bit in kexec_reloc. But later I realized that
>>>>>>> I missed Xen 64-bit/dom 32-bit case. Now I agree that this switch
>>>>>>> must stay as is. However, now I think that there is another
>>>>>>> small mistake which should be fixed. Please look above.
>>>>>> Which mistake?  I'm not sure what you're referring to.
>>>>> I thought about that:
>>>>>
>>>>> if ( image->arch == EM_386 )
>>>>>   reloc_flags |= KEXEC_RELOC_FLAG_COMPAT;
>>>>>
>>>>> It should be change to:
>>>>>
>>>>> if ( is_pv_32on64_domain(dom0) )
>>>>>   reloc_flags |= KEXEC_RELOC_FLAG_COMPAT;
>>>> This isn't a mistake but a deliberate improvement to the old interface.
>>> I am still not convinced.
>>>
>>>> It is clearer and more useful for this sub-architecture to be explicitly
>>>> supplied in the kexec_load call than implicitly through some other
>>>> side-channel.
>>> First of all you do not need to pass any info about architecure to
>>> new kernel or something like that (please check my previous emails).
>> Yes - you really do.  Guessing the architecture of a blob of code is
>> insane, and any current interface which relies on this guessing is
>> broken by design.
> Which interface do you mean? Old Xen? kexec-tools? purgatory?
>
> Why do you need to enforce architecture? purgatory starts new kernel
> image like BIOS does it. What is wrong with that? Do you set something
> in BIOS to differentiate between 32-bit and 64-bit system?

Fine, but that is irrelevant.  Purgatory can do whatever it wants as
soon as it is running.

What Xen cares about is entering into the binary blob in the correct
operating mode.  This binary blob will usually be purgatory but can be
any executable image loaded using the new interface.

If that image claims to be a 32bit image, Xen will enter it in 32bit
mode.  If it claims to be 64bit, Xen will enter it in 64bit mode.  If it
is being stupid and claiming to be 32bit when it is in fact 64bit (or
vice versa) then it has only itself to blame.

What is absolutely unacceptable (which is the case in the current
interface) is for Xen to assume that the entry point for the blob is the
same operating mode as dom0.

Just because "this happens to be the case when using kexec-tools at the
moment" is no reason nor excuse to functionally break the interface.

~Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

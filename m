Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UF3hL-0007fv-AT
 for kexec@lists.infradead.org; Mon, 11 Mar 2013 14:27:32 +0000
Message-ID: <513DE9CE.9050303@citrix.com>
Date: Mon, 11 Mar 2013 14:27:26 +0000
From: Andrew Cooper <andrew.cooper3@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 5/8] kexec: extend hypercall with improved
 load/unload ops
References: <20130308122149.GH10740@debian70-amd64.local.net-space.pl>
 <5139EF2F.2060107@citrix.com>
 <20130308152334.GA11057@debian70-amd64.local.net-space.pl>
 <513A1FE1.9040407@citrix.com>
 <20130308214547.GC11057@debian70-amd64.local.net-space.pl>
 <513A765B.8000709@citrix.com>
 <20130311111720.GA13175@debian70-amd64.local.net-space.pl>
 <513DDA5A.7090409@citrix.com>
 <20130311133037.GB13175@debian70-amd64.local.net-space.pl>
 <513DDF66.7060108@citrix.com>
 <20130311141316.GC13175@debian70-amd64.local.net-space.pl>
In-Reply-To: <20130311141316.GC13175@debian70-amd64.local.net-space.pl>
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

On 11/03/13 14:13, Daniel Kiper wrote:
> On Mon, Mar 11, 2013 at 01:43:02PM +0000, David Vrabel wrote:
>> On 11/03/13 13:30, Daniel Kiper wrote:
>>> On Mon, Mar 11, 2013 at 01:21:30PM +0000, David Vrabel wrote:
>>>> On 11/03/13 11:17, Daniel Kiper wrote:
>>>>> Heh... It looks that there is a misunderstanding. At first I thought
>>>>> that David was going to replace purgatory functionality by switching
>>>>> from 64-bit to 32-bit in kexec_reloc. But later I realized that
>>>>> I missed Xen 64-bit/dom 32-bit case. Now I agree that this switch
>>>>> must stay as is. However, now I think that there is another
>>>>> small mistake which should be fixed. Please look above.
>>>> Which mistake?  I'm not sure what you're referring to.
>>> I thought about that:
>>>
>>> if ( image->arch == EM_386 )
>>>   reloc_flags |= KEXEC_RELOC_FLAG_COMPAT;
>>>
>>> It should be change to:
>>>
>>> if ( is_pv_32on64_domain(dom0) )
>>>   reloc_flags |= KEXEC_RELOC_FLAG_COMPAT;
>> This isn't a mistake but a deliberate improvement to the old interface.
> I am still not convinced.
>
>> It is clearer and more useful for this sub-architecture to be explicitly
>> supplied in the kexec_load call than implicitly through some other
>> side-channel.
> First of all you do not need to pass any info about architecure to
> new kernel or something like that (please check my previous emails).

Yes - you really do.  Guessing the architecture of a blob of code is
insane, and any current interface which relies on this guessing is
broken by design.

> If any then there is another questions. What do you do if you need
> second or third argument?. You redefine kexec interface once again.
> For what? Additionally, currently there are a lot of stuff passed
> to new kernel via purgatory. And purgatory is called by your
> interface too...
>
>> If we go with what you suggest then you prevent kexec from being used
>> by: a) PVH dom0s; b) suitably privileged service domains; c) 32-bit
> Maybe for PVH should be different check. However,
> until now we do not have it in Xen yet.
>
>> guests wanting to load an image with a 64-bit entry point; and d)
> Once again:
>
> old_kernel (Xen) -> purgatory (native mode) -> new_kernel
>
> purgatory architecture is same as kexec-tools architecture. If you
> use dom0 i386 it means that kexec-tools is (and must be) i386 too.
> We do not support Xen i386 anymore. It means that my condition is
> correct.
>
> Daniel

And what happens when kexec-tools is using ia32-libs under a 64bit dom0?
That would also break.

The logic is very simple.

If the blob passed in kexec_load claims to be 32bit, Xen will switch
into 32bit mode before executing it.  If the blob claims to be 64 bit
then Xen will stay in 64bit mode before executing it.

This way, purgatory from any kind of multi-arch setup in dom0 will work,
as well as all of the other usecases which your suggestion breaks.

~Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

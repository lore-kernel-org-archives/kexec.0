Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFNDY-00045z-E3
 for kexec@lists.infradead.org; Tue, 12 Mar 2013 11:18:06 +0000
Date: Tue, 12 Mar 2013 12:17:55 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [PATCH 5/8] kexec: extend hypercall with improved
 load/unload ops
Message-ID: <20130312111755.GB13567@debian70-amd64.local.net-space.pl>
References: <20130308214547.GC11057@debian70-amd64.local.net-space.pl>
 <513A765B.8000709@citrix.com>
 <20130311111720.GA13175@debian70-amd64.local.net-space.pl>
 <513DDA5A.7090409@citrix.com>
 <20130311133037.GB13175@debian70-amd64.local.net-space.pl>
 <513DDF66.7060108@citrix.com>
 <20130311141316.GC13175@debian70-amd64.local.net-space.pl>
 <513DE9CE.9050303@citrix.com>
 <20130311204541.GA13567@debian70-amd64.local.net-space.pl>
 <513E4A3E.3060405@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <513E4A3E.3060405@citrix.com>
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
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, David Vrabel <david.vrabel@citrix.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Mon, Mar 11, 2013 at 09:18:54PM +0000, Andrew Cooper wrote:
> On 11/03/13 20:45, Daniel Kiper wrote:
> > On Mon, Mar 11, 2013 at 02:27:26PM +0000, Andrew Cooper wrote:
> >> On 11/03/13 14:13, Daniel Kiper wrote:
> >>> On Mon, Mar 11, 2013 at 01:43:02PM +0000, David Vrabel wrote:
> >>>> On 11/03/13 13:30, Daniel Kiper wrote:
> >>>>> On Mon, Mar 11, 2013 at 01:21:30PM +0000, David Vrabel wrote:
> >>>>>> On 11/03/13 11:17, Daniel Kiper wrote:
> >>>>>>> Heh... It looks that there is a misunderstanding. At first I thought
> >>>>>>> that David was going to replace purgatory functionality by switching
> >>>>>>> from 64-bit to 32-bit in kexec_reloc. But later I realized that
> >>>>>>> I missed Xen 64-bit/dom 32-bit case. Now I agree that this switch
> >>>>>>> must stay as is. However, now I think that there is another
> >>>>>>> small mistake which should be fixed. Please look above.
> >>>>>> Which mistake?  I'm not sure what you're referring to.
> >>>>> I thought about that:
> >>>>>
> >>>>> if ( image->arch == EM_386 )
> >>>>>   reloc_flags |= KEXEC_RELOC_FLAG_COMPAT;
> >>>>>
> >>>>> It should be change to:
> >>>>>
> >>>>> if ( is_pv_32on64_domain(dom0) )
> >>>>>   reloc_flags |= KEXEC_RELOC_FLAG_COMPAT;
> >>>> This isn't a mistake but a deliberate improvement to the old interface.
> >>> I am still not convinced.
> >>>
> >>>> It is clearer and more useful for this sub-architecture to be explicitly
> >>>> supplied in the kexec_load call than implicitly through some other
> >>>> side-channel.
> >>> First of all you do not need to pass any info about architecure to
> >>> new kernel or something like that (please check my previous emails).
> >> Yes - you really do.  Guessing the architecture of a blob of code is
> >> insane, and any current interface which relies on this guessing is
> >> broken by design.
> > Which interface do you mean? Old Xen? kexec-tools? purgatory?
> >
> > Why do you need to enforce architecture? purgatory starts new kernel
> > image like BIOS does it. What is wrong with that? Do you set something
> > in BIOS to differentiate between 32-bit and 64-bit system?
>
> Fine, but that is irrelevant.  Purgatory can do whatever it wants as
> soon as it is running.
>
> What Xen cares about is entering into the binary blob in the correct
> operating mode.  This binary blob will usually be purgatory but can be
> any executable image loaded using the new interface.

Now it is clear. If you would like to enforce arch of blob as whole
instead of kernel image itself then David's condition is OK.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

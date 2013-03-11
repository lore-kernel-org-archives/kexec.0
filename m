Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UF0ja-0006yd-Op
 for kexec@lists.infradead.org; Mon, 11 Mar 2013 11:17:40 +0000
Date: Mon, 11 Mar 2013 12:17:20 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [PATCH 5/8] kexec: extend hypercall with improved
 load/unload ops
Message-ID: <20130311111720.GA13175@debian70-amd64.local.net-space.pl>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-6-git-send-email-david.vrabel@citrix.com>
 <20130308112301.GE10740@debian70-amd64.local.net-space.pl>
 <5139CE3C.8070801@citrix.com>
 <20130308122149.GH10740@debian70-amd64.local.net-space.pl>
 <5139EF2F.2060107@citrix.com>
 <20130308152334.GA11057@debian70-amd64.local.net-space.pl>
 <513A1FE1.9040407@citrix.com>
 <20130308214547.GC11057@debian70-amd64.local.net-space.pl>
 <513A765B.8000709@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <513A765B.8000709@citrix.com>
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

On Fri, Mar 08, 2013 at 11:38:03PM +0000, Andrew Cooper wrote:
> On 08/03/13 21:45, Daniel Kiper wrote:
> > On Fri, Mar 08, 2013 at 05:29:05PM +0000, Andrew Cooper wrote:
> >> <snip>
> >>>> The tools know what mode the image must be called it and it can tell the
> >>>> hypervisor and the hypervisor can trivial setup the correct mode.
> >>>>
> >>>> I propose:
> >>>>
> >>>> * Tools say: "here's an image, call it in mode X".
> >>>>
> >>>> You suggest:
> >>>>
> >>>> * Hypervisor implicitly says through some unspecified side channel: "I
> >>>> only call images in mode Y".
> >>> Purgatory is clearly defined. Please look into kexec-tools/purgatory.
> >>> It is integral part of kexec infrastructure.
> >> Purgatory might be well defined, but that is not relevant here.
> >>
> >> The kexec syscall and hypercall basically amount to "Here is a blob.
> >> Its architecture is $X and its entry point is $Y"
> > kexec syscall use architecture information to check that given
> > image could be executed on given platform. That is all.
>
> And how is 'could' distinguished?
>
> A basic sanity check at load time of "is $X an operating mode I can get
> to at some point in the future" is fine, and useful to eliminate the
> case of trying to load something claiming to be an ARM blob on an x86
> machine.
>
> However, the entry point given can only possibly work in one operating
> mode.  If $X is i386 and Xen jumps to it with long mode enabled, then it
> will crash very quickly.  Conversely, if $X is x86_64 and Xen jumps to
> it in protected mode, another crash will occur.

It always works because purgatory sets "native mode". It means that machine
before execution of new kernel is in state like it would be after BIOS
initialization. It is assumption for all architectures and it is always
done by purgatory.

> >> (Give or take some reconstruction)
> > What does this reconstruction? Hypervisor?
>
> Under the current implementation, the dom0 kernel.  Under the new
> planned implementation, Xen.

What do you mean by reconstruction? Setting to "native mode"?

[...]

> >> The fact that this currently works in the common case of having the
> >> crash kernel with the same architecture as the dom0 kernel is by luck
> >> rather than good guidance.
> > OK, I agree but in this case following part of patch 5/8:
> >
> > if ( image->arch == EM_386 )
> >   reloc_flags |= KEXEC_RELOC_FLAG_COMPAT;
> >
> > should be change to:
> >
> > if ( is_pv_32on64_domain(dom0) )
> >   reloc_flags |= KEXEC_RELOC_FLAG_COMPAT;
>
> No - specifically not.  This is the whole problem we are trying to avoid.
>
> The current running architecture of dom0 has no place trying to
> second-guess the intended architecture of the blob.
>
> What happens if I as the user am currently running a 32bit dom0 on 64
> bit Xen, and want to load a 64bit blob to jump to?
>
> Under your suggestion, I as the user have to declare it to be a 32bit
> blob and write a 32->64 shim at the beginning of it.  Under Davids
> suggestion, all I as the user have to do is to tell Xen that it is
> indeed a 64bit image.

You forgot about purgatory code. Just reminder:

old_kernel (Xen) -> purgatory (native mode) -> new_kernel

purgatory architecture is same as kexec-tools architecture. If you
use dom0 i386 it means that kexec-tools is (and must be) i386 too.
We do not support Xen i386 anymore. It means that my condition is
correct.

> >> Furthmore, the design of the interface should not be deliberately
> >> crippled because the common user of it "can deal with it like this";
> > If something is good and tested in many ways, on many architectures,
> > very long time, why not use it? What is the difference between Xen
> > and other architectures?
>
> argumentum ad antiquitatem
>
> Not that I wish to jibe at kexec-tools, but to point out the fallacy of
> an argument on that basis.
>
>
> About "good and tested", the current kexec handover mechanism is insane,
> and is frankly a miracle it ever worked in the first place.
>
> Lets take the example of a 32bit dom0 on 64bit Xen and a 32bit crash kernel
>
> (The following is to the best of my understanding, so apologies if I
> have misunderstood bits)
>
> 1) /sbin/kexec bundles a 32bit kernel and initrd, along with purgatory
> etc and makes a kexec system call
> 2) dom0 copies the segments into regular kalloc()'d chunks
> 3) dom0 constructs a control page, bundles some control state together
> and makes a kexec hypercall
> 4) Xen saves the control data and overwrites the dom0 provided virtual
> addresses
>
> In the case of a crash
>
> 1) Xen writes crash notes and shuts down as fast as possible
> 2) Because dom0 is 32bit, Xen sets up 32bit mode non-pae 1:1mapped and
> 3a) might die there and then because the control page living in dom0
> kalloc()'d space might now be above the 4GB boundary
> 3b) be lucky that the control page is below the 4GB and
> 4) Execute the control page which sets up 32bit mode non-pae 1:1mapped
> (on a different set of pagetables/GDT etc)
> 5) Works to reconstruct the image in the crash region which
> 6a) might copy in the wrong block because of 32bit truncation issues
> 7) Jump to the beginning of purgatory which sets up 32bit mode
>
> And amongst all of that, I am still unsure of whether there are other
> issues because of an "unsigned long page_list[]" in the 64bit hypervisor
> being different from the "unsigned long page_list[]" used by the 32bit
> control page.  In machine_kexec_load() in the hypervisor, we make no
> sanity checks against the assertions of the comments.
>
>
> In the proposed new interface, we do not need to set up the correct
> state for purgatory, jump into the dom0 control page which re-sets up
> different equivalent state, just to reconstruct the image and jump to it.
>
> As for the different architecture of Xen, I hope the above shows exacly
> why it is different, and why it is dangerous to use assumptions based on
> is_pv_32on64_domain(dom0)
>
> >
> >> kexec-tools is not the only potential consumer of this interface.
> > Potentialy yes but as I know (correct me if I am wrong) kexec-tools
> > is only one tool, until now, which uses kexec syscall/hypercall.
> > If we use this tool we should align to widely accepted rules.
> > If we do not like them then we should convince maintainers that
> > our approach is better or write our own tool with our own rules.
> > But then we should not call it kexec.
> >
> > Daniel
>
> I see no reason why Davids proposed interface is incompatible with
> kexec-tools.  Do you?

Heh... It looks that there is a misunderstanding. At first I thought
that David was going to replace purgatory functionality by switching
from 64-bit to 32-bit in kexec_reloc. But later I realized that
I missed Xen 64-bit/dom 32-bit case. Now I agree that this switch
must stay as is. However, now I think that there is another
small mistake which should be fixed. Please look above.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

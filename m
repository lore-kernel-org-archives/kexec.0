Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UE56z-0001vn-Pr
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 21:45:58 +0000
Date: Fri, 8 Mar 2013 22:45:47 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [PATCH 5/8] kexec: extend hypercall with improved
 load/unload ops
Message-ID: <20130308214547.GC11057@debian70-amd64.local.net-space.pl>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-6-git-send-email-david.vrabel@citrix.com>
 <20130308112301.GE10740@debian70-amd64.local.net-space.pl>
 <5139CE3C.8070801@citrix.com>
 <20130308122149.GH10740@debian70-amd64.local.net-space.pl>
 <5139EF2F.2060107@citrix.com>
 <20130308152334.GA11057@debian70-amd64.local.net-space.pl>
 <513A1FE1.9040407@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <513A1FE1.9040407@citrix.com>
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

On Fri, Mar 08, 2013 at 05:29:05PM +0000, Andrew Cooper wrote:
> <snip>
> >> The tools know what mode the image must be called it and it can tell the
> >> hypervisor and the hypervisor can trivial setup the correct mode.
> >>
> >> I propose:
> >>
> >> * Tools say: "here's an image, call it in mode X".
> >>
> >> You suggest:
> >>
> >> * Hypervisor implicitly says through some unspecified side channel: "I
> >> only call images in mode Y".
> > Purgatory is clearly defined. Please look into kexec-tools/purgatory.
> > It is integral part of kexec infrastructure.
>
> Purgatory might be well defined, but that is not relevant here.
>
> The kexec syscall and hypercall basically amount to "Here is a blob.
> Its architecture is $X and its entry point is $Y"

kexec syscall use architecture information to check that given
image could be executed on given platform. That is all.

> (Give or take some reconstruction)

What does this reconstruction? Hypervisor?

> Xen should not be making any assumptions about these things.
>
> As it currently stands, Xen will assume that KEXEC_load from a pv_32on64
> domain is an i386 image, while a KEXEC_load from a 64bit PV domain is an
> x86_64 image.

I do not understand. First you write that "Xen should not be making any
assumptions about these things" and in the next sentence you state
that "Xen will assume that...". What do you mean by that?

And why do you force users to use image for one architecture (in this case
subarchitecture)? I (as a user) would like to have a choice.

> The fact that this currently works in the common case of having the
> crash kernel with the same architecture as the dom0 kernel is by luck
> rather than good guidance.

OK, I agree but in this case following part of patch 5/8:

if ( image->arch == EM_386 )
  reloc_flags |= KEXEC_RELOC_FLAG_COMPAT;

should be change to:

if ( is_pv_32on64_domain(dom0) )
  reloc_flags |= KEXEC_RELOC_FLAG_COMPAT;

> Furthmore, the design of the interface should not be deliberately
> crippled because the common user of it "can deal with it like this";

If something is good and tested in many ways, on many architectures,
very long time, why not use it? What is the difference between Xen
and other architectures?

> kexec-tools is not the only potential consumer of this interface.

Potentialy yes but as I know (correct me if I am wrong) kexec-tools
is only one tool, until now, which uses kexec syscall/hypercall.
If we use this tool we should align to widely accepted rules.
If we do not like them then we should convince maintainers that
our approach is better or write our own tool with our own rules.
But then we should not call it kexec.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

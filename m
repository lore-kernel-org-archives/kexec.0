Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvrDg-0001K3-65
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 15:17:33 +0000
Date: Thu, 17 Jan 2013 16:17:12 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 1/3] kexec: extend hypercall with improved load/unload ops
Message-ID: <20130117151712.GE2871@host-192-168-1-59.local.net-space.pl>
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
 <1358353746-1899-2-git-send-email-david.vrabel@citrix.com>
 <20130117122803.GC2871@host-192-168-1-59.local.net-space.pl>
 <50F80FB2.9080107@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50F80FB2.9080107@citrix.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Thu, Jan 17, 2013 at 02:50:26PM +0000, David Vrabel wrote:
> Can you trim your replies?  It's too hard to find your comments otherwise.

OK.

> On 17/01/13 12:28, Daniel Kiper wrote:
> > On Wed, Jan 16, 2013 at 04:29:04PM +0000, David Vrabel wrote:
> >> From: David Vrabel <david.vrabel@citrix.com>
> >>
> >> In the existing kexec hypercall, the load and unload ops depend on
> >> internals of the Linux kernel (the page list and code page provided by
> >> the kernel).  The code page is used to transition between Xen context
> >> and the image so using kernel code doesn't make sense and will not
> >> work for PVH guests.
> >>
> >> Add replacement KEXEC_CMD_kexec_load_v2 and KEXEC_CMD_kexec_unload_v2
> >> ops that no longer require a code page to be provided by the guest --
> >> Xen now provides the code for calling the image directly.
> >>
> [...]
> >> +    if ( image->class == KEXEC_CLASS_32 )
> >> +        compat_machine_kexec(image->entry_maddr);
> >
> > Why do you need that?
>
> image->class controls whether the processor is in 32-bit or 64-bit mode
> when calling the image.  The current implementation only allows images
> to be executed with the same class as dom0.
>
> It's called class because that's the term ELF uses in the ELF header.

As I correctly understand this sets processor mode before new kernel exection.
If yes then it is not needed. Purgatory code (from kexec-tools) does all
needed things. Please check.

> >> +        if ( seg.dest_maddr < kexec_crash_area.start
> >> +             || seg.dest_maddr + seg.size > kexec_crash_area.start + kexec_crash_area.size)
> >> +            return -EINVAL;
> >
> > This way you are breaking regular kexec support which
> > does not use prealocated area. As I said earlier you
> > should use kexec code from Linux Kernel (with relevant
> > changes). It has all needed stuff and you do not need
> > to reinvent the wheel.
>
> Yeah. I did say it was a prototype.

OK. I could not find any comment that this feature will be implemented too.
I prefer to say about my thoughts know than later break your work.

> >> +#define KEXEC_CMD_kexec_load_v2        4
> >> +typedef struct xen_kexec_load_v2 {
> >> +    uint8_t type;  /* One of KEXEC_TYPE_* */
> >> +    uint8_t class; /* One of KEXEC_CLASS_* */
> >
> > Why do not use one member called flags (uint32_t or uint64_t)?
> > This way you could add quite easily new flags in the future.
>
> Neither type nor class are flags.

type could be passed as flags (as kexec Linux Kernel implementation does)
which gives us more flexibility if we need more flags in the future.
class is not needed as I stated above.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

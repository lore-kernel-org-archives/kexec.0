Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OQ3ZD-0001RV-9P
	for kexec@lists.infradead.org; Sat, 19 Jun 2010 19:19:00 +0000
References: <20100619132633.GA24277@basil.fritz.box>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 19 Jun 2010 12:18:52 -0700
In-Reply-To: <20100619132633.GA24277@basil.fritz.box> (Andi Kleen's message of
	"Sat\, 19 Jun 2010 15\:26\:33 +0200")
Message-ID: <m1mxuqu8yr.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec_load manpage
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
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-man@vger.kernel.org, Kexec Mailing List <kexec@lists.infradead.org>, mtk.manpages@gmail.com

Andi Kleen <andi@firstfloor.org> writes:

> Here are the beginnings of a kexec_load manpage.
>
> Probably needs some more review from Eric and may need some additional
> information.
>
> The syscall is actually only usable with a kernel patch to export
> the header I just sent separately.

The syscall has been used for years with a separate non-kernel header.


Eric


> Also added the kexec subcall to reboot(2)
>
> -Andi
>
> diff --git a/man2/kexec_load.2 b/man2/kexec_load.2
> new file mode 100644
> index 0000000..f486641
> --- /dev/null
> +++ b/man2/kexec_load.2
> @@ -0,0 +1,94 @@
> +.TH KEXEC_LOAD 2 2010-06-16 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +kexec_load \- Load a new kernel for later execution.
> +.SH SYNOPSIS
> +.b #include <linux/kexec.h>
> +.br
> +.BI "long kexec_load(unsigned long " entry ", unsigned long " nr_segments ","
> +.br
> +.BI       "struct kexec_segment *" segments ", unsigned long " flags ");"
> +.SH DESCRIPTION
> +.BR kexec_load 
> +loads a new kernel that can be executed later
> +by 
> +.I reboot(2).
> +An alternative approach is to specify
> +.B KEXEC_ON_CRASH
> +in the 
> +.I flags
> +argument and then the new kernel will be automatically executed on a 
> +system crash. 
> +.\" XXX figure out how this is really used 
> +With 
> +.B KEXEC_PRESERVE_CONTEXT 
> +specified in 
> +.I flags
> +kexec will preserve the system hard and 
> +software state before executing the kexec kernel. This 
> +could be used for system suspend.
> +
> +.I flags
> +also contains the architecture of the executed kernel or
> +be 
> +.I KEXEC_ARCH_DEFAULT
> +for the current architecture.
> +Valid architectures are 
> +.I KEXEC_ARCH_I386,
> +.I KEXEC_ARCH_X86_64,
> +.I KEXEC_ARCH_PPC,
> +.I KEXEC_ARCH_PPC64,
> +.I KEXEC_ARCH_IA_64,
> +.I KEXEC_ARCH_ARM,
> +.I KEXEC_ARCH_S390,
> +.I KEXEC_ARCH_SH,
> +.I KEXEC_ARCH_MIPS,
> +.I KEXEC_ARCH_MIPS_LE.
> +The architecture must be executable on the CPU of the system.
> +
> +.I entry 
> +is the virtual entry address in the kernel image.

Physical.

> +.I nr_segments
> +is the number of segments pointed to by the 
> +.I segments
> +pointer. 
> +.I segments 
> +is an array of 
> +.I struct kexec_segment
> +structures which define the kernel layout:
> +.in +4n
> +.nf
> +
> +struct kexec_segment {
> +	void   *buf;	/* Buffer in user space */
> +	size_t  bufsz;	/* Buffer length in user space */
> +	void   *mem;	/* Virtual address of kernel */
> +	size_t  memsz;	/* Virtual address length */

There are again physical addresses.

There is an expectation that at hand off from sys_kexec that
virtual and physical addresses will be identity mapped.  But
this isn't the old Alpha booting convention where you have
a virtual address and then you have to parse the page table
to figure out where your kernel was actually loaded.

> +};
> +.fi
> +.in
> +.PP
> +.\" XXX elaborate on this
> +The kernel image defined by
> +.I segments
> +is copied from the calling process into previously reserved memory.
> +.SH CONFORMING TO
> +This system call is Linux-specific.
> +.SH NOTES
> +kexec_load is currently not defined in glibc. To call it use:
> +.in +4n
> +.nf
> +#define _GNU_SOURCE
> +#include <syscall.h>
> +#include <asm/unistd.h>
> +#include <linux/kexec.h>
> +
> +ret = syscall(__NR_kexec_load, entry, nr_segments, segments, flags);
> +.fi
> +.in
> +.PP
> +.I linux/kexec.h as a exported header is only available in 2.6.38
> +and later kernels, in earlier kernels the constants need to be copied
> +out of the kernel source.
> +.SH SEE ALSO
> +.BR syscall (2),
> +.BR reboot (2)
> diff --git a/man2/reboot.2 b/man2/reboot.2
> index 253bd34..87204b1 100644
> --- a/man2/reboot.2
> +++ b/man2/reboot.2
> @@ -139,6 +139,11 @@ For the i386 architecture, the additional argument does not do
>  anything at present (2.1.122), but the type of reboot can be
>  determined by kernel command-line arguments ("reboot=...") to be
>  either warm or cold, and either hard or through the BIOS.
> +.TP
> +.B LINUX_REBOOT_KEXEC
> +executes a kernel that has been loaded earlier
> +with 
> +.I kexec_load(2).
>  .SH "RETURN VALUE"
>  For the values of
>  .I cmd
> @@ -177,4 +182,5 @@ and should not be used in programs intended to be portable.
>  .BR capabilities (7),
>  .BR ctrlaltdel (8),
>  .BR halt (8),
> -.BR reboot (8)
> +.BR reboot (8),
> +.BR kexec_load (2)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

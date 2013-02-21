Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8epq-0007PR-0B
 for kexec@lists.infradead.org; Thu, 21 Feb 2013 22:41:50 +0000
Date: Thu, 21 Feb 2013 23:41:41 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 5/8] kexec: extend hypercall with improved load/unload ops
Message-ID: <20130221224141.GB18464@host-192-168-1-59.local.net-space.pl>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-6-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1361468894-18655-6-git-send-email-david.vrabel@citrix.com>
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
Cc: kexec@lists.infradead.org, xen-devel@lists.xen.org

On Thu, Feb 21, 2013 at 05:48:11PM +0000, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
>
> In the existing kexec hypercall, the load and unload ops depend on
> internals of the Linux kernel (the page list and code page provided by
> the kernel).  The code page is used to transition between Xen context
> and the image so using kernel code doesn't make sense and will not
> work for PVH guests.
>
> Add replacement KEXEC_CMD_kexec_load and KEXEC_CMD_kexec_unload ops
> that no longer require a code page to be provided by the guest -- Xen
> now provides the code for calling the image directly.
>
> The new load op looks similar to the Linux kexec_load system call and
> allows the guest to provide the image data to be loaded.  The guest
> specifies the architecture of the image which may be a 32-bit subarch
> of the hypervisor's architecture (i.e., an EM_386 image on an
> EM_X86_64 hypervisor).
>
> The toolstack can now load images without kernel involvement.  This is
> required for supporting kexec when using a dom0 with an upstream
> kernel.
>
> Crash images are copied directly into the crash region on load.
> Default images are copied into Xen heap pages and a list of source and
> destination machine addresses is created.  This is list is used in
> kexec_reloc() to relocate the image to its destination.
>
> The old load and unload sub-ops are still available (as
> KEXEC_CMD_load_v1 and KEXEC_CMD_unload_v1) and are implemented on top
> of the new infrastructure.
>
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>

[...]

> diff --git a/xen/arch/x86/x86_64/kexec_reloc.S b/xen/arch/x86/x86_64/kexec_reloc.S
> new file mode 100644
> index 0000000..e68842c
> --- /dev/null
> +++ b/xen/arch/x86/x86_64/kexec_reloc.S
> @@ -0,0 +1,229 @@
> +/*
> + * Relocate a kexec_image to its destination and call it.
> + *
> + * Copyright (C) 2013 Citrix Systems R&D Ltd.
> + *
> + * Portions derived from Linux's arch/x86/kernel/relocate_kernel_64.S.
> + *
> + *   Copyright (C) 2002-2005 Eric Biederman  <ebiederm@xmission.com>
> + *
> + * This source code is licensed under the GNU General Public License,
> + * Version 2.  See the file COPYING for more details.
> + */
> +#include <xen/config.h>
> +
> +#include <asm/asm_defns.h>
> +#include <asm/msr.h>
> +#include <asm/page.h>
> +#include <asm/machine_kexec.h>
> +
> +/* The unrelocated physical address of a symbol. */
> +#define SYM_PHYS(sym)          ((sym) - __XEN_VIRT_START)
> +
> +/* Load physical address of symbol into register and relocate it. */
> +#define RELOCATE_SYM(sym,reg)  mov $SYM_PHYS(sym), reg ; \
> +                               add xen_phys_start(%rip), reg
> +
> +#define DBG(c) \
> +1:      mov     $0x3f8+5, %dx ; \
> +        inb     %dx, %al     ; \
> +        test    $0x20, %al   ; \
> +        je      1b           ; \
> +        mov     $0x3f8, %dx  ; \
> +        mov     $c, %al      ; \
> +        outb    %al, %dx     ;

Nice feature but I think that it is dangerous to write
to serial port unconditionally. There are a lot of machines
in the wild which do not have coms these days. Maybe it should be
enabled if Xen is compiled with debug feature. Then serial port
address should be established on the base of console argument.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

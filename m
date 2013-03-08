Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDvOH-0000K2-Ed
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 11:23:11 +0000
Date: Fri, 8 Mar 2013 12:23:01 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 5/8] kexec: extend hypercall with improved load/unload ops
Message-ID: <20130308112301.GE10740@debian70-amd64.local.net-space.pl>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
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
> +
> +        .text
> +	.align PAGE_SIZE
> +        .code64
> +
> +ENTRY(kexec_reloc)
> +        /* %rdi - code_page maddr */
> +        /* %rsi - page table maddr */
> +        /* %rdx - indirection page maddr */
> +        /* %rcx - entry maddr */
> +        /* %r8 - flags */
> +
> +        mov %rdx, %rbx
> +
> +        DBG('A')
> +
> +        /* Setup stack. */
> +        RELOCATE_SYM(reloc_stack, %rax)
> +        mov %rax, %rsp
> +
> +        DBG('B')
> +
> +        wbinvd
> +        movq %cr4, %rax
> +        andq $~(X86_CR4_PGE|X86_CR4_PCE|X86_CR4_MCE), %rax
> +        movq %rax, %cr4
> +
> +        /* Load reloc page table. */
> +        movq %rsi, %cr3
> +
> +        DBG('C')
> +
> +        /* Jump to identity mapped code. */
> +        movq %rdi, %r9
> +        addq $(identity_mapped - kexec_reloc), %r9
> +
> +        DBG('D')
> +
> +        jmp *%r9
> +
> +identity_mapped:
> +        DBG('E')
> +
> +        pushq %rcx
> +        pushq %rbx
> +        pushq %rsi
> +        pushq %rdi
> +
> +        movq %rbx, %rdi
> +        call swap_pages
> +
> +        popq %rdi
> +        popq %rsi
> +        popq %rbx
> +        popq %rcx
> +
> +        DBG('F')
> +
> +        /* Need to switch to 32-bit mode? */
> +        testq $KEXEC_RELOC_FLAG_COMPAT, %r8
> +        jnz call_32_bit

Why do you need that? This is not needed because purgatory code
from kexec-tools always switches to 32-bit mode. Please check
kexec-tools/purgatory/arch/x86_64/entry64.S.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

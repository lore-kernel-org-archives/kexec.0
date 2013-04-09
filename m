Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPfgw-0004Zb-Bx
 for kexec@lists.infradead.org; Tue, 09 Apr 2013 21:02:59 +0000
Date: Tue, 9 Apr 2013 23:02:41 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 5/8] kexec: extend hypercall with improved load/unload ops
Message-ID: <20130409210241.GB31533@debian70-amd64.local.net-space.pl>
References: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
 <1365447593-11988-6-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1365447593-11988-6-git-send-email-david.vrabel@citrix.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Ian Jackson <Ian.Jackson@eu.citrix.com>, kexec@lists.infradead.org, Ian Campbell <Ian.Campbell@citrix.com>, xen-devel@lists.xen.org

On Mon, Apr 08, 2013 at 07:59:50PM +0100, David Vrabel wrote:
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
> Default images are copied into domheap pages and a list of source and
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
> index 0000000..9d09c35
> --- /dev/null
> +++ b/xen/arch/x86/x86_64/kexec_reloc.S
> @@ -0,0 +1,215 @@
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
> +        .text
> +        .align PAGE_SIZE
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

movq?

> +
> +        /* Setup stack. */
> +        RELOCATE_SYM(reloc_stack, %rax)
> +        mov %rax, %rsp

Ditto?

> +
> +        /* Load reloc page table. */
> +        movq %rsi, %cr3

...because at least you use movq here...
...etc...

> +
> +        /* Jump to identity mapped code. */
> +        movq %rdi, %r9
> +        addq $(identity_mapped - kexec_reloc), %r9
> +
> +        jmp *%r9

jmpq *(identity_mapped - kexec_reloc)(%rdi)

> +
> +identity_mapped:
> +        pushq %rcx
> +        pushq %rbx
> +        pushq %rsi
> +        pushq %rdi
> +
> +        /*
> +         * Set cr0 to a known state:
> +         *  - Paging enabled
> +         *  - Alignment check disabled
> +         *  - Write protect disabled
> +         *  - No task switch
> +         *  - Don't do FP software emulation.
> +         *  - Proctected mode enabled
> +         */
> +        movq    %cr0, %rax
> +        andq    $~(X86_CR0_AM | X86_CR0_WP | X86_CR0_TS | X86_CR0_EM), %rax
> +        orl     $(X86_CR0_PG | X86_CR0_PE), %eax
> +        movq    %rax, %cr0
> +
> +        /*
> +         * Set cr4 to a known state:
> +         *  - physical address extension enabled
> +         */
> +        movq    $X86_CR4_PAE, %rax
> +        movq    %rax, %cr4
> +
> +        movq %rbx, %rdi
> +        call relocate_pages
> +
> +        popq %rdi
> +        popq %rsi
> +        popq %rbx
> +        popq %rcx
> +
> +        /* Need to switch to 32-bit mode? */
> +        testq $KEXEC_RELOC_FLAG_COMPAT, %r8
> +        jnz call_32_bit
> +
> +call_64_bit:
> +        /* Call the image entry point.  This should never return. */
> +        call *%rcx
> +        ud2
> +
> +call_32_bit:
> +        /* Relocate compatibility mode entry point address. */
> +        movl %edi, %eax
> +        addl $(compatibility_mode - kexec_reloc), %eax

leal (compatibility_mode - kexec_reloc)(%edi), %eax

> +        movl %eax, compatibility_mode_far(%rip)
> +
> +        /* setup idt */
> +        lidt compat_mode_idt(%rip)
> +
> +        /* Load compat GDT. */
> +        movq %rdi, %rax
> +        addq $(compat_mode_gdt - kexec_reloc), %rax

leaq (compat_mode_gdt - kexec_reloc)(%rdi), %rax

[...]

> diff --git a/xen/common/kexec.c b/xen/common/kexec.c

[...]

> -static int kexec_load_unload_compat(unsigned long op,
> -                                    XEN_GUEST_HANDLE_PARAM(void) uarg)
> +static int kexec_load_v1_compat(XEN_GUEST_HANDLE_PARAM(void) uarg)
>  {
>  #ifdef CONFIG_COMPAT
>      compat_kexec_load_v1_t compat_load;
> @@ -808,49 +1011,113 @@ static int kexec_load_unload_compat(unsigned long op,
>      load.type = compat_load.type;
>      XLAT_kexec_image(&load.image, &compat_load.image);
>
> -    return kexec_load_unload_internal(op, &load);
> -#else /* CONFIG_COMPAT */
> +    return kexec_do_load_v1(&load, 1);
> +#else

Why did you removed comment?

>      return 0;

Why not -ENOSYS?

> -#endif /* CONFIG_COMPAT */
> +#endif

Why did you removed comment?

[...]

> +static int kexec_unload_v1_compat(XEN_GUEST_HANDLE_PARAM(void) uarg)
> +{
> +#ifdef CONFIG_COMPAT
> +    compat_kexec_load_v1_t compat_load;
> +    xen_kexec_unload_t unload;
> +
> +    if ( copy_from_guest(&compat_load, uarg, 1) )
> +        return -EFAULT;
> +
> +    unload.type = compat_load.type;
> +    return kexec_do_unload(&unload);
> +#else
> +    return 0;

Why not -ENOSYS?

> +#endif
> +}

Please check other similar places too.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

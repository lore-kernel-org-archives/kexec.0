Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80290E77187
	for <kexec@archiver.kernel.org>; Wed, 18 Dec 2024 21:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eemwxPBUQQnuKi6Ni9InUTU4xiKW8PAjr9B1QQE9H80=; b=giJJh7Sr5tByttXSBgN+Ti6kOO
	FEU3i7UxwagTtWCxe2N/V6IoCBuDUyAIaJ+MwJkcbFzMEgWIVt9Y4TfnYXOBFnBFSyR34Nq/T8R3s
	EdPSQ/OgIyXiLcAUiwsEtsEcKuaR2DhLW0pWULSTuMK/bYy812PjkqXprD+J4EvYDDs2mJ8p3KOCn
	Ct4df0ncwt+1okajz1+pz5xXII76vg6z9OiGTE5nvwMyyxhgY8rnTu3DBQcDndKFIpQylwlo7kr1v
	lwmCoIaJAk4OKt7RH8tRbE2xql9rEir2w9Xm0xyq77KqpepgxfVES/yCUgoUzJfAigbBo5TyBLTUY
	3TvK5QGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tO1W3-000000007q1-1YMq;
	Wed, 18 Dec 2024 21:23:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tO1Vy-000000007oL-0ym4
	for kexec@lists.infradead.org;
	Wed, 18 Dec 2024 21:23:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BFC995C646C;
	Wed, 18 Dec 2024 21:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1826EC4CECD;
	Wed, 18 Dec 2024 21:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734557008;
	bh=i2XzAr51u4AIpLkgYrJyjMJECE+5GpDM/80cTO8rEfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObvzeYoW9kQlSHEA6hVVSSKs5yjBgoe0qO9GWbj2vI7Xd+E6DpEni+nXjVYGsxrjI
	 pE9l1o0g3PKy9MDEXYKraifnjIgNWs6J1UDA65rKOmdk7/vUvZhHWipDlHbfF6cEob
	 oYoKKXC/jGat+7ubzabLe0nsBjua6mFR3tGcL3umkdhRoiQdsuBc0RMajE9CqAVrVL
	 4x3V9dn2VTqGV3A9buukp6JLBTDpjodTYtUa8tA1JI9QDBDr4+l57EB/c0o+8RmloA
	 GZUnR4/3+FgGVz4/EmBwXdUE/uuQjRkTPDQ82ChtyvJZ0bYf21RoXdTOZxJ2CSxM5d
	 RksVfbqkk6Ovg==
Date: Wed, 18 Dec 2024 13:23:26 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Nathan Chancellor <nathan@kernel.org>, kexec@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de
Subject: Re: [PATCH v5 07/20] x86/kexec: Invoke copy of relocate_kernel()
 instead of the original
Message-ID: <20241218212326.44qff3i5n6cxuu5d@jpoimboe>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-8-dwmw2@infradead.org>
 <20241214230818.GA677337@ax162>
 <24d843d2ceb09acdae494ee9a17ec94bf8bb4e4f.camel@infradead.org>
 <20241216054942.GA25019@ax162>
 <79ea9c10ae4f1dae16be8c05bb7b7e6b72512f10.camel@infradead.org>
 <9ee61d2b89b4cecd10ece64002bf2c06648e1de7.camel@infradead.org>
 <20241218090305.y4o62pmdwq32732h@jpoimboe>
 <5857ef047402c3ded29d4c024f8fdc32608f1696.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5857ef047402c3ded29d4c024f8fdc32608f1696.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241218_132330_454743_351D19AF 
X-CRM114-Status: GOOD (  23.08  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Dec 18, 2024 at 10:44:25AM +0100, David Woodhouse wrote:
> > At some point we had discussed placing the code in .rodata, was it the
> > alternative preventing that?
> 
> No, the alternative seems to be fine, and it's all in the .data section
> now (since the kernel does write some variables there which are then
> accessed %rip-relative from the code itself).

The linker script does place it in .data, but objtool runs on the object
file before linking, where it's still in an executable section
(.text..relocate_kernel).

How about something like below?

  - move text to .data..relocate_kernel
  - remove objtool annotations
  - replace the alternative with a runtime check

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5081d0b9e290..126d777a5695 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -61,6 +61,7 @@ struct kimage;
 extern unsigned long kexec_va_control_page;
 extern unsigned long kexec_pa_table_page;
 extern unsigned long kexec_pa_swap_page;
+extern unsigned int kexec_preserve_mce;
 extern gate_desc kexec_debug_idt[];
 extern unsigned char kexec_debug_exc_vectors[];
 extern uint16_t kexec_debug_8250_port;
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 853f3cdc7c75..751adeea0db8 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -363,6 +363,8 @@ int machine_kexec_prepare(struct kimage *image)
 	if (image->type == KEXEC_TYPE_DEFAULT)
 		kexec_pa_swap_page = page_to_pfn(image->swap_page) << PAGE_SHIFT;
 
+	kexec_preserve_mce = boot_cpu_has(X86_FEATURE_TDX_GUEST);
+
 	prepare_debug_idt((unsigned long)__pa(control_page),
 			  (unsigned long)kexec_debug_exc_vectors - reloc_start);
 
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 4dca50141586..04b7a9f11e98 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -24,8 +24,8 @@
 #define PAGE_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
 
 /*
- * The .text..relocate_kernel and .data..relocate_kernel sections are copied
- * into the control page, and the remainder of the page is used as the stack.
+ * The .data..relocate_kernel section is copied into the control page, and the
+ * remainder of the page is used as the stack.
  */
 
 	.section .data..relocate_kernel,"a";
@@ -41,6 +41,7 @@ SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 SYM_DATA(kexec_debug_8250_mmio32, .quad 0)
 SYM_DATA(kexec_debug_8250_port, .word 0)
+SYM_DATA(kexec_preserve_mce, .word 0)
 
 #ifdef CONFIG_KEXEC_DEBUG
 	.balign 16
@@ -60,12 +61,14 @@ SYM_DATA_END(kexec_debug_idt)
 
 #endif /* CONFIG_KEXEC_DEBUG */
 
-	.section .text..relocate_kernel,"ax";
+/*
+ * This code is copied rather than called in place.  It's free to use indirect
+ * branches and bare returns, and doesn't need ORC unwinding data.  Keep it in
+ * a data section so objtool doesn't see it.
+ */
+
 	.code64
 SYM_TYPED_FUNC_START(relocate_kernel)
-	UNWIND_HINT_END_OF_STACK
-	UNWIND_HINT_FUNC
-	ANNOTATE_NOENDBR
 	/*
 	 * %rdi indirection_page
 	 * %rsi pa_control_page
@@ -124,12 +127,10 @@ SYM_TYPED_FUNC_START(relocate_kernel)
 	/* jump to identity mapped page */
 	addq	$identity_mapped, %rsi
 	subq	$__relocate_kernel_start, %rsi
-	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rsi
 SYM_CODE_END(relocate_kernel)
 
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
-	UNWIND_HINT_END_OF_STACK
 	/*
 	 * %rdi	indirection page
 	 * %rdx start address
@@ -199,7 +200,11 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * PAE is always set in the original CR4.
 	 */
 	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
-	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUEST
+	movw	kexec_preserve_mce(%rip), %ax
+	testw	%ax, %ax
+	jz	.Lwrite_cr4
+	orl	$X86_CR4_MCE, %r13d
+.Lwrite_cr4:
 	movq	%r13, %cr4
 
 	/* Flush the TLB (needed?) */
@@ -250,7 +255,6 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	xorl	%r14d, %r14d
 	xorl	%r15d, %r15d
 
-	ANNOTATE_UNRET_SAFE
 	ret
 	int3
 
@@ -264,7 +268,6 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* push the existing entry point onto the callee's stack */
 	pushq	%rdx
 
-	ANNOTATE_RETPOLINE_SAFE
 	call	*%rdx
 
 	/* get the re-entry point of the peer system */
@@ -276,7 +279,6 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 
 	/* Find start (and end) of this physical mapping of control page */
 	leaq	(%rip), %r8
-	ANNOTATE_NOENDBR
 	andq	$PAGE_MASK, %r8
 	lea	PAGE_SIZE(%r8), %rsp
 	movq	$1, %r11	/* Ensure preserve_context flag is set */
@@ -285,14 +287,11 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	addq	$virtual_mapped, %rax
 	subq	$__relocate_kernel_start, %rax
 	pushq	%rax
-	ANNOTATE_UNRET_SAFE
 	ret
 	int3
 SYM_CODE_END(identity_mapped)
 
 SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
-	UNWIND_HINT_END_OF_STACK
-	ANNOTATE_NOENDBR // RET target, above
 	movq	saved_rsp(%rip), %rsp
 	movq	saved_cr4(%rip), %rax
 	movq	%rax, %cr4
@@ -317,14 +316,12 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	popq	%r12
 	popq	%rbp
 	popq	%rbx
-	ANNOTATE_UNRET_SAFE
 	ret
 	int3
 SYM_CODE_END(virtual_mapped)
 
 	/* Do the copies */
 SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
-	UNWIND_HINT_END_OF_STACK
 	/*
 	 * %rdi indirection page
 	 * %r11 preserve_context
@@ -387,7 +384,6 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	lea	PAGE_SIZE(%rax), %rsi
 	jmp	.Lloop
 .Ldone:
-	ANNOTATE_UNRET_SAFE
 	ret
 	int3
 SYM_CODE_END(swap_pages)
@@ -404,8 +400,6 @@ SYM_CODE_END(swap_pages)
 #define LSR             5       /*  Line Status               */
 
 SYM_CODE_START_LOCAL_NOALIGN(pr_char_8250)
-	UNWIND_HINT_FUNC
-	ANNOTATE_NOENDBR
 	addw	$LSR, %dx
 	xchg	%al, %ah
 .Lxmtrdy_loop:
@@ -420,15 +414,11 @@ SYM_CODE_START_LOCAL_NOALIGN(pr_char_8250)
 	xchg	%al, %ah
 	outb	%al, %dx
 pr_char_null:
-	ANNOTATE_NOENDBR
 
-	ANNOTATE_UNRET_SAFE
 	ret
 SYM_CODE_END(pr_char_8250)
 
 SYM_CODE_START_LOCAL_NOALIGN(pr_char_8250_mmio32)
-	UNWIND_HINT_FUNC
-	ANNOTATE_NOENDBR
 .Lxmtrdy_loop_mmio:
 	movb	(LSR*4)(%rdx), %ah
 	testb	$XMTRDY, %ah
@@ -438,7 +428,6 @@ SYM_CODE_START_LOCAL_NOALIGN(pr_char_8250_mmio32)
 
 .Lready_mmio:
 	movb	%al, (%rdx)
-	ANNOTATE_UNRET_SAFE
 	ret
 SYM_CODE_END(pr_char_8250_mmio32)
 
@@ -463,7 +452,6 @@ SYM_CODE_END(pr_char_8250_mmio32)
 
 /* Print the nybble in %bl, clobber %rax */
 SYM_CODE_START_LOCAL_NOALIGN(pr_nybble)
-	UNWIND_HINT_FUNC
 	movb	%bl, %al
 	nop
 	andb	$0x0f, %al
@@ -471,33 +459,26 @@ SYM_CODE_START_LOCAL_NOALIGN(pr_nybble)
 	cmpb	$0x3a, %al
 	jb	1f
 	addb	$('a' - '0' - 10), %al
-	ANNOTATE_RETPOLINE_SAFE
 1:	jmp	*%rsi
 SYM_CODE_END(pr_nybble)
 
 SYM_CODE_START_LOCAL_NOALIGN(pr_qword)
-	UNWIND_HINT_FUNC
 	movq	$16, %rcx
 1:	rolq	$4, %rbx
 	call	pr_nybble
 	loop	1b
 	movb	$'\n', %al
-	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rsi
 SYM_CODE_END(pr_qword)
 
 .macro print_reg a, b, c, d, r
 	movb	$\a, %al
-	ANNOTATE_RETPOLINE_SAFE
 	call	*%rsi
 	movb	$\b, %al
-	ANNOTATE_RETPOLINE_SAFE
 	call	*%rsi
 	movb	$\c, %al
-	ANNOTATE_RETPOLINE_SAFE
 	call	*%rsi
 	movb	$\d, %al
-	ANNOTATE_RETPOLINE_SAFE
 	call	*%rsi
 	movq	\r, %rbx
 	call	pr_qword
@@ -506,7 +487,6 @@ SYM_CODE_END(pr_qword)
 SYM_CODE_START_NOALIGN(kexec_debug_exc_vectors)
 	/* Each of these is 6 bytes. */
 .macro vec_err exc
-	UNWIND_HINT_ENTRY
 	. = kexec_debug_exc_vectors + (\exc * KEXEC_DEBUG_EXC_HANDLER_SIZE)
 	nop
 	nop
@@ -515,14 +495,12 @@ SYM_CODE_START_NOALIGN(kexec_debug_exc_vectors)
 .endm
 
 .macro vec_noerr exc
-	UNWIND_HINT_ENTRY
 	. = kexec_debug_exc_vectors + (\exc * KEXEC_DEBUG_EXC_HANDLER_SIZE)
 	pushq	$0
 	pushq	$\exc
 	jmp	exc_handler
 .endm
 
-	ANNOTATE_NOENDBR
 	vec_noerr 0 // #DE
 	vec_noerr 1 // #DB
 	vec_noerr 2 // #NMI
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 63ff60a11be5..9c2abfd6ea26 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -100,7 +100,6 @@ const_pcpu_hot = pcpu_hot;
 #define KEXEC_RELOCATE_KERNEL					\
 	. = ALIGN(0x100);					\
 	__relocate_kernel_start = .;				\
-	*(.text..relocate_kernel);				\
 	*(.data..relocate_kernel);				\
 	__relocate_kernel_end = .;
 


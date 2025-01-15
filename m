Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8174C02180
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 19:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Lfnf5OQV/O8wFKeVcDBQagu82mNw6Nx1vxvLmuyV88=; b=tRMQpf50BaQNt799D5jii8DBAe
	5j+PxLT5d/bDyb6qCpD9enYy7rIZieW1IuVv0g7z7ugfeHDE64BoVvGiA1/JRvl02GN5gALb1A7IG
	fzDLI1N5kGVGhJt18RP8Q+4DK3uHOfVe7p/g8VyvvXJEBSnmrQuLPkftRFfCc8MFWHe6ayS26MPHR
	QCVXcql14nH1aud51fyooX7mNiNhV02iHRwrIgIAkpGfJ/sUVl3k4fzztVcaNQiUdVvijGRg/Comh
	VacoT0xWXmiKeGSssWAUCv4y3+0yv6Raw86mGK2PrPBrT3y6v8jcLTytl0iwT2cBKv8DeNNsNj7sz
	ezrXFicg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8rO-0000000CsC6-2kxY;
	Wed, 15 Jan 2025 19:15:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qW-0000000CrwW-0zJz
	for kexec@bombadil.infradead.org;
	Wed, 15 Jan 2025 19:14:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0Lfnf5OQV/O8wFKeVcDBQagu82mNw6Nx1vxvLmuyV88=; b=O1G029fJGrVbz1TpuH8Q5lS7O/
	xX029hUh7UlzrN6qDj3NkLOtdGsiP1CFat0uSvH7Kxo8pwEdTUTJ5VAK+lODrDNlz+BhWehmSIlAu
	Zo4652XtGwzYXLIFDFAPDJ34jlAbkMjnoHulVXDPLkuqtxQkO3WPRLRPy7ltk9aDBVjbTWYViivqw
	3K+nlFN75OCUcK2Dj/w9oJhz+CZVO1e7vS7XfyRAtBB9RQD1h2OiAbb/DFwRUmBkX1nh11py0xiAr
	X3M/sm9gslMQ/SfDsr+wEhY9rNlVFE4bVBxk9o3QFNRWyEIH5KPDFu1JsCmpZIB9l4oinbodCb/aJ
	n5juTMOQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qS-0000000AvMb-07Gl;
	Wed, 15 Jan 2025 19:14:29 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tY8qO-00000002Uw1-3wfb;
	Wed, 15 Jan 2025 19:14:24 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v6 3/7] x86/kexec: Debugging support: Load an IDT and basic exception entry points
Date: Wed, 15 Jan 2025 19:09:32 +0000
Message-ID: <20250115191423.587774-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250115191423.587774-1-dwmw2@infradead.org>
References: <20250115191423.587774-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
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

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kexec.h         |  5 ++
 arch/x86/kernel/machine_kexec_64.c   | 23 ++++++++
 arch/x86/kernel/relocate_kernel_64.S | 82 ++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 8ad187462b68..ec7636f4f86a 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -8,6 +8,9 @@
 # define PA_PGD			2
 # define PA_SWAP_PAGE		3
 # define PAGES_NR		4
+#else
+/* Size of each exception handler referenced by the IDT */
+# define KEXEC_DEBUG_EXC_HANDLER_SIZE	6 /* pushi, pushi, 2-byte jmp */
 #endif
 
 # define KEXEC_CONTROL_PAGE_SIZE	4096
@@ -58,6 +61,8 @@ struct kimage;
 extern unsigned long kexec_va_control_page;
 extern unsigned long kexec_pa_table_page;
 extern unsigned long kexec_pa_swap_page;
+extern gate_desc kexec_debug_idt[];
+extern unsigned char kexec_debug_exc_vectors[];
 #endif
 
 /*
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a68f5a0a9f37..535438375568 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -304,6 +304,26 @@ static void load_segments(void)
 		);
 }
 
+static void prepare_debug_idt(unsigned long control_page, unsigned long vec_ofs)
+{
+#ifdef CONFIG_KEXEC_DEBUG
+	gate_desc idtentry = { 0 };
+	int i;
+
+	idtentry.bits.p = 1;
+	idtentry.bits.type = GATE_TRAP;
+	idtentry.segment = __KERNEL_CS;
+	idtentry.offset_low = (control_page & 0xFFFF) + vec_ofs;
+	idtentry.offset_middle = (control_page >> 16) & 0xFFFF;
+	idtentry.offset_high = control_page >> 32;
+
+	for (i = 0; i < 16; i++) {
+		kexec_debug_idt[i] = idtentry;
+		idtentry.offset_low += KEXEC_DEBUG_EXC_HANDLER_SIZE;
+	}
+#endif
+}
+
 int machine_kexec_prepare(struct kimage *image)
 {
 	void *control_page = page_address(image->control_code_page);
@@ -321,6 +341,9 @@ int machine_kexec_prepare(struct kimage *image)
 	if (image->type == KEXEC_TYPE_DEFAULT)
 		kexec_pa_swap_page = page_to_pfn(image->swap_page) << PAGE_SHIFT;
 
+	prepare_debug_idt((unsigned long)__pa(control_page),
+			  (unsigned long)kexec_debug_exc_vectors - reloc_start);
+
 	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
 	set_memory_rox((unsigned long)control_page, 1);
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c62f03808f18..f5b134a81827 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -49,6 +49,12 @@ SYM_DATA_START_LOCAL(kexec_debug_gdt)
 	.quad   0x00af9a000000ffff      /* __KERNEL_CS */
 	.quad   0x00cf92000000ffff      /* __KERNEL_DS */
 SYM_DATA_END_LABEL(kexec_debug_gdt, SYM_L_LOCAL, kexec_debug_gdt_end)
+
+	.balign 8
+SYM_DATA_START(kexec_debug_idt)
+	.skip 0x100, 0x00
+SYM_DATA_END(kexec_debug_idt)
+
 #endif /* CONFIG_KEXEC_DEBUG */
 
 	.section .text..relocate_kernel,"ax";
@@ -113,6 +119,11 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	jmp	*%rsi
 SYM_CODE_END(relocate_kernel)
 
+#ifdef DEBUG
+	UNWIND_HINT_UNDEFINED
+	.balign 0x100	/* relocate_kernel will be overwritten with an IDT */
+#endif
+
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	UNWIND_HINT_END_OF_STACK
 	/*
@@ -140,6 +151,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* Test that we can load segments */
 	movq	%ds, %rax
 	movq	%rax, %ds
+
+	/* Now an IDTR on the stack to load the IDT the kernel created */
+	leaq	kexec_debug_idt(%rip), %rsi
+	pushq	%rsi
+	pushw	$0xff
+	lidt	(%rsp)
+	addq	$10, %rsp
+
+	//int3
 #endif /* CONFIG_KEXEC_DEBUG */
 
 	/*
@@ -367,3 +387,65 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	ret
 	int3
 SYM_CODE_END(swap_pages)
+
+#ifdef CONFIG_KEXEC_DEBUG
+SYM_CODE_START_NOALIGN(kexec_debug_exc_vectors)
+	/* Each of these is 6 bytes. */
+.macro vec_err exc
+	UNWIND_HINT_ENTRY
+	. = kexec_debug_exc_vectors + (\exc * KEXEC_DEBUG_EXC_HANDLER_SIZE)
+	nop
+	nop
+	pushq	$\exc
+	jmp	exc_handler
+.endm
+
+.macro vec_noerr exc
+	UNWIND_HINT_ENTRY
+	. = kexec_debug_exc_vectors + (\exc * KEXEC_DEBUG_EXC_HANDLER_SIZE)
+	pushq	$0
+	pushq	$\exc
+	jmp	exc_handler
+.endm
+
+	ANNOTATE_NOENDBR
+	vec_noerr 0 // #DE
+	vec_noerr 1 // #DB
+	vec_noerr 2 // #NMI
+	vec_noerr 3 // #BP
+	vec_noerr 4 // #OF
+	vec_noerr 5 // #BR
+	vec_noerr 6 // #UD
+	vec_noerr 7 // #NM
+	vec_err 8   // #DF
+	vec_noerr 9
+	vec_err 10 // #TS
+	vec_err 11 // #NP
+	vec_err 12 // #SS
+	vec_err 13 // #GP
+	vec_err 14 // #PF
+	vec_noerr 15
+SYM_CODE_END(kexec_debug_exc_vectors)
+
+SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
+	pushq	%rax
+	pushq	%rdx
+	movw	$0x3f8, %dx
+	movb	$'A', %al
+	outb	%al, %dx
+	popq	%rdx
+	popq	%rax
+
+	/* Only return from int3 */
+	cmpq	$3, (%rsp)
+	jne	.Ldie
+
+	addq	$16, %rsp
+	iretq
+
+.Ldie:
+	hlt
+	jmp	.Ldie
+
+SYM_CODE_END(exc_handler)
+#endif /* CONFIG_KEXEC_DEBUG */
-- 
2.47.0



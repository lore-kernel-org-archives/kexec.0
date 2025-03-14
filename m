Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C7FC35FF1
	for <kexec@archiver.kernel.org>; Fri, 14 Mar 2025 17:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XiU2A8Hf++dNsHgUZJbi/FS+hirzyzKI9tlEDEk267E=; b=vqCWwRzm2CIezIzEeEV88QzP4q
	kxB3/WjZSqubQuiui1eO69uixpicOi1cwOeIMh5EE26hPMBDtog/pjoLzkmMz2yKKxKxv5kXcI/BD
	8fGnd6GQmRJTlWYig3u1eoIaoUlBF1jArD3gon+mtBYv6Y/FrWIy66s2OHFMpq8f63gXnl+2oOwkq
	7Glc1550sxYwjHf+Toyrv6iKyRFzSfsgzi20ZHI3HfW+JqAK/7hXUHfWV8D30/bVTpoQ/3sOP4bwb
	TqKnIkKha58DNqwTTR4y6c+p/yhLQ8BCy9xq7rZ3qGST7ASWP/AyZ/oF2jZD026TpXhbzUWcw6PFm
	fve66kNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tf-0000000EsP7-3zTq;
	Fri, 14 Mar 2025 17:32:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8te-0000000EsN4-1hBU
	for kexec@bombadil.infradead.org;
	Fri, 14 Mar 2025 17:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XiU2A8Hf++dNsHgUZJbi/FS+hirzyzKI9tlEDEk267E=; b=qwvTc2uY27wXLSW8SnjfbZSPNf
	XAx+8qyapF9t8uM9JwqFtY4otTLYNWpp74MkZJFNsDshKBXbD4iPWBhriarGMwWdct1OTlUfFtuPy
	E0frzIt+40jJPGf8Ogc2tLscxKdFROaavwx5bOS5Qte33Z7bAkSzkEnJHXB/J+fWlFaaMlWhuGbOl
	0bGReU5nf9pB/mgIKtpfgHAxfpZiBz/ji2hY9F8nRlcq6R3jazyZMKHOWVt41vJudQEU3Iu5jxRgm
	JtZCcXiUb+K/kvxk2oH2d1Zq0dkrctHQnr9KmwV7QTD1Mix3WDWvZ6WXsZ1vV0mTvl8gsaCxQ+4xT
	0vht+9Uw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tb-00000002vUB-3fgc;
	Fri, 14 Mar 2025 17:32:32 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tY-0000000CsVp-3WmP;
	Fri, 14 Mar 2025 17:32:28 +0000
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
Subject: [PATCH v8 2/7] x86/kexec: Debugging support: Dump registers on exception
Date: Fri, 14 Mar 2025 17:27:34 +0000
Message-ID: <20250314173226.3062535-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314173226.3062535-1-dwmw2@infradead.org>
References: <20250314173226.3062535-1-dwmw2@infradead.org>
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

The actual serial output function is a no-op for now.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 121 +++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index b07c55019ce5..c2f73998d1b6 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -379,6 +379,69 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	int3
 SYM_CODE_END(swap_pages)
 
+/*
+ * Generic 'print character' routine (as yet unimplemented)
+ *  - %al: Character to be printed (may clobber %rax)
+ *  - %rdx: MMIO address or port.
+ */
+SYM_CODE_START_LOCAL_NOALIGN(pr_char)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	ANNOTATE_UNRET_SAFE
+	ret
+SYM_CODE_END(pr_char)
+
+/*
+ * Load pr_char function pointer into %rsi and load %rdx with whatever
+ * that function wants to see there (typically port/MMIO address).
+ */
+.macro	pr_setup
+	/* No output; pr_char just returns */
+	leaq	pr_char(%rip), %rsi
+.endm
+
+/* Print the nybble in %bl, clobber %rax */
+SYM_CODE_START_LOCAL_NOALIGN(pr_nybble)
+	UNWIND_HINT_FUNC
+	movb	%bl, %al
+	nop
+	andb	$0x0f, %al
+	addb 	$0x30, %al
+	cmpb	$0x3a, %al
+	jb	1f
+	addb	$('a' - '0' - 10), %al
+	ANNOTATE_RETPOLINE_SAFE
+1:	jmp	*%rsi
+SYM_CODE_END(pr_nybble)
+
+SYM_CODE_START_LOCAL_NOALIGN(pr_qword)
+	UNWIND_HINT_FUNC
+	movq	$16, %rcx
+1:	rolq	$4, %rbx
+	call	pr_nybble
+	loop	1b
+	movb	$'\n', %al
+	ANNOTATE_RETPOLINE_SAFE
+	jmp	*%rsi
+SYM_CODE_END(pr_qword)
+
+.macro print_reg a, b, c, d, r
+	movb	$\a, %al
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rsi
+	movb	$\b, %al
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rsi
+	movb	$\c, %al
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rsi
+	movb	$\d, %al
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rsi
+	movq	\r, %rbx
+	call	pr_qword
+.endm
+
 SYM_CODE_START_NOALIGN(kexec_debug_exc_vectors)
 	/* Each of these is 6 bytes. */
 .macro vec_err exc
@@ -422,17 +485,63 @@ SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
 	VALIDATE_UNRET_END
 
 	pushq	%rax
+	pushq	%rbx
+	pushq	%rcx
 	pushq	%rdx
-	movw	$0x3f8, %dx
-	movb	$'A', %al
-	outb	%al, %dx
-	popq	%rdx
-	popq	%rax
+	pushq	%rsi
+
+	/* Stack frame */
+#define EXC_SS		0x58 /* Architectural... */
+#define EXC_RSP		0x50
+#define EXC_EFLAGS	0x48
+#define EXC_CS		0x40
+#define EXC_RIP		0x38
+#define EXC_ERRORCODE	0x30 /* Either architectural or zero pushed by handler */
+#define EXC_EXCEPTION	0x28 /* Pushed by handler entry point */
+#define EXC_RAX		0x20 /* Pushed just above in exc_handler */
+#define EXC_RBX		0x18
+#define EXC_RCX		0x10
+#define EXC_RDX		0x08
+#define EXC_RSI		0x00
+
+	/* Set up %rdx/%rsi for debug output */
+	pr_setup
+
+	/* rip and exception info */
+	print_reg 'E', 'x', 'c', ':', EXC_EXCEPTION(%rsp)
+	print_reg 'E', 'r', 'r', ':', EXC_ERRORCODE(%rsp)
+	print_reg 'r', 'i', 'p', ':', EXC_RIP(%rsp)
+	print_reg 'r', 's', 'p', ':', EXC_RSP(%rsp)
+
+	/* We spilled these to the stack */
+	print_reg 'r', 'a', 'x', ':', EXC_RAX(%rsp)
+	print_reg 'r', 'b', 'x', ':', EXC_RBX(%rsp)
+	print_reg 'r', 'c', 'x', ':', EXC_RCX(%rsp)
+	print_reg 'r', 'd', 'x', ':', EXC_RDX(%rsp)
+	print_reg 'r', 's', 'i', ':', EXC_RSI(%rsp)
+
+	/* Other registers untouched */
+	print_reg 'r', 'd', 'i', ':', %rdi
+	print_reg 'r', '8', ' ', ':', %r8
+	print_reg 'r', '9', ' ', ':', %r9
+	print_reg 'r', '1', '0', ':', %r10
+	print_reg 'r', '1', '1', ':', %r11
+	print_reg 'r', '1', '2', ':', %r12
+	print_reg 'r', '1', '3', ':', %r13
+	print_reg 'r', '1', '4', ':', %r14
+	print_reg 'r', '1', '5', ':', %r15
+	print_reg 'c', 'r', '2', ':', %cr2
 
 	/* Only return from int3 */
-	cmpq	$3, (%rsp)
+	cmpq	$3, EXC_EXCEPTION(%rsp)
 	jne	.Ldie
 
+	popq	%rsi
+	popq	%rdx
+	popq	%rcx
+	popq	%rbx
+	popq	%rax
+
 	addq	$16, %rsp
 	iretq
 
-- 
2.48.1



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E40E6ADCE
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 22:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p6nY0MqUdf1P9uopFxDVE2/tcFa/fWVkj9Ig2+H4ywM=; b=S+mc9HkzeshlxZ71COFnM5Dp7A
	u6wFBfcPLAyBwuP2yX/FXKCkFCM1L7TxK0NjUmAHI0yY/Xfa7H1IBJ2Nj9k+OH+hU4xWYQlJOLQ03
	Fbgkt5IyhlpHJpK7AsZrP5zP/n3B9kZxTo0A1BDtisbugE+2lhNmzDpCsAOm2J2/sNDzBVQVLUPcl
	Al1FAk7QfdkmbFNQQBXdKIPx1R0a7+CYF8Aj1ZZNMxQ2jXuPVaEi71cu97Aj+WNefFpmtDXI0Wd+p
	5LwylgwKAOpc+H06ZkMTonDfZqf6mQNvapb8EQr5fu6iak+MJudAneKzljefxmdVQ40945LNvYPGt
	mJj/z1Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcR0-00000003RQE-4AoH;
	Fri, 22 Nov 2024 22:47:30 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQw-00000003RL1-150v
	for kexec@bombadil.infradead.org;
	Fri, 22 Nov 2024 22:47:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=p6nY0MqUdf1P9uopFxDVE2/tcFa/fWVkj9Ig2+H4ywM=; b=qxKUp010qnr2xUv2WEZk2EODFm
	jy1AblzHSPGfKfPB1FQlMN96+BoifoWUal7RbRHmHpTJ2SAOjo0tc0xe+G4//I7WQl+Jin1Y0ejP/
	tGq2mrI1+zITB+m/EqVtTH0GfPrtq0yKGRFiKLWhxIRHIo94gNSgo+Bzsw3usdCidIp4qhvNP4GhZ
	QTSDNIo81E8i3YQxdCbd3R58ats/BDEfo56K0/ZtytISBcLLc3wk9Yw+Ner5cw1NLuM8OOxE6gun/
	Tg3B+WVmHCDjBZ0Ka2SSHoLgd089Ob1hdwMeIbHEuesWEOBpZG+Cod+gybg8tx7zgRf0s5swZl5AO
	N41CjXFw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQt-00000008PI7-27yK;
	Fri, 22 Nov 2024 22:47:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iij-2Bxx;
	Fri, 22 Nov 2024 22:47:19 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org
Subject: [RFC PATCH v2 15/16] x86/kexec: Debugging support: Dump registers on exception
Date: Fri, 22 Nov 2024 22:38:24 +0000
Message-ID: <20241122224715.171751-16-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122224715.171751-1-dwmw2@infradead.org>
References: <20241122224715.171751-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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
 arch/x86/kernel/relocate_kernel_64.S | 83 +++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 4ace2577afc6..67f6853c7abe 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -400,6 +400,55 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 SYM_CODE_END(swap_pages)
 
 #ifdef DEBUG
+/*
+ * This allows other types of serial ports to be used.
+ *  - %al: Character to be printed (no clobber %rax)
+ *  - %rdx: MMIO address or port.
+ */
+.macro pr_char
+	outb	%al, %dx
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
+1:	pr_char
+	ANNOTATE_UNRET_SAFE
+	ret
+SYM_CODE_END(pr_nybble)
+
+SYM_CODE_START_LOCAL_NOALIGN(pr_qword)
+	UNWIND_HINT_FUNC
+	movq	$16, %rcx
+1:	rolq	$4, %rbx
+	call	pr_nybble
+	loop	1b
+	movb	$'\n', %al
+	pr_char
+	ANNOTATE_UNRET_SAFE
+	ret
+SYM_CODE_END(pr_qword)
+
+.macro print_reg a, b, c, d, r
+	movb	$\a, %al
+	pr_char
+	movb	$\b, %al
+	pr_char
+	movb	$\c, %al
+	pr_char
+	movb	$\d, %al
+	pr_char
+	movq	\r, %rbx
+	call	pr_qword
+.endm
+
 SYM_CODE_START_LOCAL_NOALIGN(exc_vectors)
 	/* Each of these is 6 bytes. */
 .macro vec_err exc
@@ -439,11 +488,39 @@ SYM_CODE_END(exc_vectors)
 
 SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
 	pushq	%rax
+	pushq	%rbx
+	pushq	%rcx
 	pushq	%rdx
+
 	movw	$0x3f8, %dx
-	movb	$'A', %al
-	outb	%al, %dx
+
+	/* rip and exception info */
+	print_reg 'E', 'x', 'c', ':', 32(%rsp)
+	print_reg 'E', 'r', 'r', ':', 40(%rsp)
+	print_reg 'r', 'i', 'p', ':', 48(%rsp)
+
+	/* We spilled these to the stack */
+	print_reg 'r', 'a', 'x', ':', 24(%rsp)
+	print_reg 'r', 'b', 'x', ':', 16(%rsp)
+	print_reg 'r', 'c', 'x', ':', 8(%rsp)
+	print_reg 'r', 'd', 'x', ':', (%rsp)
+
+	/* Other registers */
+	print_reg 'r', 's', 'i', ':', %rsi
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
+
 	popq	%rdx
+	popq	%rcx
+	popq	%rbx
 	popq	%rax
 
 	/* Only return from int3 */
@@ -456,6 +533,6 @@ SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
 .Ldie:
 	hlt
 	jmp	.Ldie
-
+	int3
 SYM_CODE_END(exc_handler)
 #endif /* DEBUG */
-- 
2.47.0



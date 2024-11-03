Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A328D10C0D
	for <kexec@archiver.kernel.org>; Sun,  3 Nov 2024 05:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AKnbIZa4bwoWyIDtEVeDUt4Q6mRwITcj7Po2pGnPuIg=; b=OaclTwth39DfmG
	9ztwpIwx10XMVjYwmZy/yt4CwLHdiivpX+PawfucyiQ2gxsCdYH8X0cOnsq5FzYrBDKJp9kars2Dq
	56JVOmIiOlp1cRxwhTUUcmPNyAKN25uT4vbKzeiPiH3KaoNw+8/FXIYdSY8LJHzEtOxQ5QfoC/N6K
	mR4vYdP8uT0WB/QMsqC2zksnMPmAscHJnA1nA5cDU8V30jIDVX+51bCrPCRSQ3vHwVhsZb4B7gRgo
	WBd9Whp5lq4Z/YW5bHCwqWINXdKGDpdIG4JszbdauxM4OyiLrEooI8auKJt8Tu6lWjofxkiEVhNAM
	QXrOodSQkDWA50pkjdIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLj-0000000AzWR-310v;
	Sun, 03 Nov 2024 05:40:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLe-0000000AzVh-2l5g
	for kexec@bombadil.infradead.org;
	Sun, 03 Nov 2024 05:40:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dGAv5y7FEjvooP2pbPjjc8JKyfn+Npp1FyrVMwjJKLE=; b=cQVqYs3png18QmlyZAXVop7fPA
	oDBY5zwVYTsZ+PWiEiiYE4NfvupfI5P7WV1J7XMBIeqlbxQbqJw+N2ggGyNjaMv0neEgjqOqLE78v
	LmSUiFsD0juDKLrWReXTbQPB2ddhy3I9DZ5Pei1Bzgg8zvS30S79aSa0NAlzrCukM1sJC2u3BgVOa
	1xI48Yd8SBkqsuyIbsTx6LZf7GSs64OJfkhDdg4pl9oiIkisbcS6aHTHispbbUQDF5ppews8FAd8t
	eVI1Ju9jCs5YI7eudgXFjzw0XGhzm2MiC5L3NDZ5Q4pEY0RUxz70QR56/5UySiRHCGTIUhL30t6ma
	eEzWdCuA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLa-0000000HSiO-2fAR;
	Sun, 03 Nov 2024 05:40:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t7TLb-0000000FvLT-00Gs;
	Sun, 03 Nov 2024 05:40:23 +0000
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
	Simon Horman <horms@kernel.org>
Subject: [RFC PATCH 6/7] x86/kexec: Debugging support: Dump registers on exception
Date: Sun,  3 Nov 2024 05:35:31 +0000
Message-ID: <20241103054019.3795299-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241103054019.3795299-1-dwmw2@infradead.org>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 80 ++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 2a2a6e693e18..1c18cffe5229 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -398,6 +398,53 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
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
+/* Print the byte in %bl, clobber %rax */
+SYM_CODE_START_LOCAL_NOALIGN(pr_byte)
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
+SYM_CODE_END(pr_byte)
+
+SYM_CODE_START_LOCAL_NOALIGN(pr_qword)
+	movq	$16, %rcx
+1:	rolq	$4, %rbx
+	call	pr_byte
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
@@ -437,11 +484,39 @@ SYM_CODE_END(exc_vectors)
 
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
@@ -454,7 +529,6 @@ SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
 .Ldie:
 	hlt
 	jmp	.Ldie
-
 SYM_CODE_END(exc_handler)
 
 .Lreloc_kernel_gdt:
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

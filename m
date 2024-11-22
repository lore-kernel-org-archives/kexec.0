Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5BAE6ADD1
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i2Ix5g+A/s6rVJXMB+lf9O3jUtCCFkDMNyc2WtM36JM=; b=uZjk3bsq7rvKD9OfHSYjMsNmKy
	2r1FHhNdKzyfqy/J8+Vm5aHcV8vTki093jIX1wWJWM4MJsrkZpl5AVq5Q/nHrHZSDV8o+GIHEwgzT
	aLS8QuqRGmiA7TvpdgE082KBg1vKilXupgqAzNKddA6amwVTerpLunSawhXzENKPwZEB+Z7wH+XoH
	GoqIwBtXRLVNnnFmTiSqKgOAVTtQDqJCBpj1rEiSoUcn3FjjuGUQSYILeaTp+ODWxFXO776w9dCDg
	tUXFDGZf9/rL6M2GsjApXIdn0F63YBF+jFOCHMBbgGiTYz+BOApI5pXDp2dCORqB0izoEkt3wAiK/
	z4qizxbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQy-00000003RNG-2Md8;
	Fri, 22 Nov 2024 22:47:28 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQv-00000003RL0-3tFW
	for kexec@bombadil.infradead.org;
	Fri, 22 Nov 2024 22:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=i2Ix5g+A/s6rVJXMB+lf9O3jUtCCFkDMNyc2WtM36JM=; b=qcrkkUW+O+/LLv5VlEXxqoKLUq
	vqS/kjBYrGoaV3SjGC0ZScvV8oYy/boURhybxSSDQXD+Tp8FemmCIWF5XEzKcx6W4bFHN+UydTbml
	iWfPdQTa9cIDlbkR5SJ7MPCttKEufeYq6l/VjTS4OVEw7QlriyfOg68wB5UwlfKLcks39Xs5gnvOz
	IN20cSOlitZHRRd7x7Naq+yFXBgwefuXdIiTmarYgXcKtHGABNxW5ODj84J7V9AUiP01TFVMsLakU
	7t9WNZ8qnvUdRwXJBaldpbwt87xi/+Jq3TP3bqPmMHEo98AEYsKZ33PJmdbG5p07douIckQr5hM7k
	BhkuZG0w==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQt-00000008PI5-15Yv;
	Fri, 22 Nov 2024 22:47:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iiU-18nA;
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
Subject: [RFC PATCH v2 10/16] x86/kexec: Eliminate writes through kernel mapping of relocate_kernel page
Date: Fri, 22 Nov 2024 22:38:19 +0000
Message-ID: <20241122224715.171751-11-dwmw2@infradead.org>
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

All writes to the relocate_kernel control page are now done *after* the
%cr3 switch via simple %rip-relative addressing, which means the DATA()
macro with its pointer arithmetic can also now be removed.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 29 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index b9ad3ef0b982..5c6456467f08 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -61,21 +61,24 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	pushq %r15
 	pushf
 
-	movq	%rsp, saved_rsp(%rip)
-	movq	%cr0, %rax
-	movq	%rax, saved_cr0(%rip)
-	movq	%cr3, %rax
-	movq	%rax, saved_cr3(%rip)
-	movq	%cr4, %rax
-	movq	%rax, saved_cr4(%rip)
-
-	/* Save CR4. Required to enable the right paging mode later. */
-	movq	%rax, %r13
-
 	/* zero out flags, and disable interrupts */
 	pushq $0
 	popfq
 
+	/* Switch to the identity mapped page tables */
+	movq	%cr3, %rax
+	movq	kexec_pa_table_page(%rip), %r9
+	movq	%r9, %cr3
+
+	/* Save %rsp and CRs. */
+	movq    %rsp, saved_rsp(%rip)
+	movq	%rax, saved_cr3(%rip)
+	movq	%cr0, %rax
+	movq	%rax, saved_cr0(%rip)
+	/* Leave CR4 in %r13 to enable the right paging mode later. */
+	movq	%cr4, %r13
+	movq	%r13, saved_cr4(%rip)
+
 	/* Save SME active flag */
 	movq	%r8, %r12
 
@@ -85,10 +88,6 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
 
-	/* Switch to the identity mapped page tables */
-	movq	kexec_pa_table_page(%rip), %r9
-	movq	%r9, %cr3
-
 	/* Physical address of control page */
 	movq    %rsi, %r8
 
-- 
2.47.0



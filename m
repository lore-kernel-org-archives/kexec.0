Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879EBE77177
	for <kexec@archiver.kernel.org>; Thu,  5 Dec 2024 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DHyuUfLXwZ8dNR2vFEDqrk7NrFvfuBvjwmzlKRQQKmc=; b=cy8fo8hwSvGEYel/WSXFCuz4Tf
	RDYNrLG6fyYNtb1fCL+G0CxIP9O3EJCtMxNorBOGu/p+fW1Nm+LEig3wFNV5+4xLDnOc1TA/ba1kh
	LSJtFWMPvU4xcte9g1RDfGOGLsWNt3PTzjBu0h1Od7vHzhvXxNPwcjZNLgoR0dmX5tXxxSjlvzekJ
	98e3sz/IoimrUZo1mJXmMfnG/pWyNUtwtfjeRX4o/paUUEhuxK9snAUY0nTTJW2HfM8YSr4lTQXii
	6J+IHAEqgQrHbUVDzp0clIKwCkK48rwySQBfUX9rztXiWm3UaM/2ssYpcNaMVtQ0G/+mF/7xOKkOX
	YAa/ykdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDsw-0000000GYzB-143F;
	Thu, 05 Dec 2024 15:35:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrQ-0000000GYRl-2b8N
	for kexec@bombadil.infradead.org;
	Thu, 05 Dec 2024 15:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DHyuUfLXwZ8dNR2vFEDqrk7NrFvfuBvjwmzlKRQQKmc=; b=kkTag37Brihmz++oUOdAGFVxIE
	T0NpDJA9yrf4Mt4Gik9Be1mUoqY4CWMFAZaMpIvHP22fByx4Do6ZXD3gq3d6nVa5+hUdVcOmjBSKh
	tQD4iOCVccBvD+NuF8cZoY8fY1mDURbROHwIG3gMf9/J5jS2awjsmsyHvFhMqvLZupJryRprqB4hM
	8s2VwdwOwhSqiLl9XUdw4FfB0c5zX2O9LSAeH2BH7wsnXND/utG1coqpzNdSs059qNaTEcG0msf72
	WOpn4Q+o5EMaQPPY1tsW/LlkZX37uAZn+S8br4PB2cfuuPyCYdz5DWUpkPOYZG/T5g6K6XQbEcb5w
	SsJAR+cQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrM-0000000DDp1-1sRT;
	Thu, 05 Dec 2024 15:33:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyLb-1z0t;
	Thu, 05 Dec 2024 15:33:45 +0000
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
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v5 07/20] x86/kexec: Invoke copy of relocate_kernel() instead of the original
Date: Thu,  5 Dec 2024 15:05:13 +0000
Message-ID: <20241205153343.3275139-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205153343.3275139-1-dwmw2@infradead.org>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
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

This currently calls set_memory_x() from machine_kexec_prepare() just
like the 32-bit version does. That's actually a bit earlier than I'd
like, as it leaves the page RWX all the time the image is even *loaded*.

Subsequent commits will eliminate all the writes to the page between the
point it's marked executable in machine_kexec_prepare() the time that
relocate_kernel() is running and has switched to the identmap %cr3, so
that it can be ROX. But that can't happen until it's moved to the .data
section of the kernel, and *that* can't happen until we start executing
the copy instead of executing it in place in the kernel .text. So break
the circular dependency in those commits by letting it be RWX for now.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c   | 30 ++++++++++++++++++++++------
 arch/x86/kernel/relocate_kernel_64.S |  5 ++++-
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 3a4cbac1a0c6..9567347f7a9b 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -157,7 +157,12 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd,
 	pmd_t *pmd;
 	pte_t *pte;
 
-	vaddr = (unsigned long)relocate_kernel;
+	/*
+	 * For the transition to the identity mapped page tables, the control
+	 * code page also needs to be mapped at the virtual address it starts
+	 * off running from.
+	 */
+	vaddr = (unsigned long)__va(control_page);
 	paddr = control_page;
 	pgd += pgd_index(vaddr);
 	if (!pgd_present(*pgd)) {
@@ -311,11 +316,17 @@ int machine_kexec_prepare(struct kimage *image)
 
 	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
 
+	set_memory_x((unsigned long)control_page, 1);
+
 	return 0;
 }
 
 void machine_kexec_cleanup(struct kimage *image)
 {
+	void *control_page = page_address(image->control_code_page);
+
+	set_memory_nx((unsigned long)control_page, 1);
+
 	free_transition_pgtable(image);
 }
 
@@ -325,6 +336,11 @@ void machine_kexec_cleanup(struct kimage *image)
  */
 void machine_kexec(struct kimage *image)
 {
+	unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
+					     unsigned long page_list,
+					     unsigned long start_address,
+					     unsigned int preserve_context,
+					     unsigned int host_mem_enc_active);
 	unsigned long page_list[PAGES_NR];
 	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
@@ -371,6 +387,8 @@ void machine_kexec(struct kimage *image)
 		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
 						<< PAGE_SHIFT);
 
+	relocate_kernel_ptr = control_page;
+
 	/*
 	 * The segment registers are funny things, they have both a
 	 * visible and an invisible part.  Whenever the visible part is
@@ -390,11 +408,11 @@ void machine_kexec(struct kimage *image)
 	native_gdt_invalidate();
 
 	/* now call it */
-	image->start = relocate_kernel((unsigned long)image->head,
-				       (unsigned long)page_list,
-				       image->start,
-				       image->preserve_context,
-				       host_mem_enc_active);
+	image->start = relocate_kernel_ptr((unsigned long)image->head,
+					   (unsigned long)page_list,
+					   image->start,
+					   image->preserve_context,
+					   host_mem_enc_active);
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 50cc33f2ecb7..b48bd82843fd 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -39,6 +39,7 @@
 #define CP_PA_TABLE_PAGE	DATA(0x20)
 #define CP_PA_SWAP_PAGE		DATA(0x28)
 #define CP_PA_BACKUP_PAGES_MAP	DATA(0x30)
+#define CP_VA_CONTROL_PAGE	DATA(0x38)
 
 	.text
 	.align PAGE_SIZE
@@ -99,6 +100,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	%r9, CP_PA_TABLE_PAGE(%r11)
 	movq	%r10, CP_PA_SWAP_PAGE(%r11)
 	movq	%rdi, CP_PA_BACKUP_PAGES_MAP(%r11)
+	movq	%r11, CP_VA_CONTROL_PAGE(%r11)
 
 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
@@ -235,7 +237,8 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	movq	$virtual_mapped, %rax
+	movq	CP_VA_CONTROL_PAGE(%r8), %rax
+	addq	$(virtual_mapped - relocate_kernel), %rax
 	pushq	%rax
 	ANNOTATE_UNRET_SAFE
 	ret
-- 
2.47.0



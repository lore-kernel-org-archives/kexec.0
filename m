Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09046E6ADD3
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 22:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P2hLAbS9aCZfZzJ8RdHeHtH4P2lTFUxdp5gm5fCBSTI=; b=232eAiEBRjX0UtDGI8HmAYls/P
	jcIrNiFM/zdGIW42W1suAFlMNvlm07bpf0ufS7k4MXBSEvAFkz8lLiosjf0gSFXgbMrPxPyjCJBbK
	JeH/DvyK0I4uOkVBV8NVsfYPTuGYqIrjJ7HXo3NE+LX0mLdmwf/8IWELVfTBz+OoLO84G88rxiu12
	c7lCynagNszOTurBoNg0qTluIpcqM1S/eobnaFdLprWqoOdexHf3t0H5iH5Dltp20Z3/0n3MEP6SW
	EoLtVp5ZrcZhefW6Enp82o/tzfR+Vbuxi1nQHpN98bwQlTu3RIF5QP2Oyht2W/oG1ja2z6ZteMtAU
	kLcG7LWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQz-00000003ROS-3IFx;
	Fri, 22 Nov 2024 22:47:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQv-00000003RKy-495m
	for kexec@bombadil.infradead.org;
	Fri, 22 Nov 2024 22:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=P2hLAbS9aCZfZzJ8RdHeHtH4P2lTFUxdp5gm5fCBSTI=; b=mn8XfcvFRp84epY7aROG7lolY5
	H/CXZilSX26nd32rba3o+48Ck9TjbmqLQz/8S2OSEIeScjAJjmQf542irJeZphGexEzoJc841V/8+
	ut3FQM0Us76nypopKkCpS6kKrapTYS235zIzr8KcrFGWCl7DylX6g0aQWgpye2xPmgMOaucQR4Lpv
	dwnbMkXCdf5wEJx42+9SNI/ZbUCWiGTq4PFb8cICxMnMgdVeG04QoFENphicizFqO2V3B+Bh6cSMq
	5JZ7kSK/F7NpY4RsFwjQW6duIKh2XSoGnjv7PHI1zlQDlbcmL0ASY76Q719upyJ0oxfL5CrEavQcn
	rBZTfmvA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQs-00000000ma6-01Ef;
	Fri, 22 Nov 2024 22:47:22 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iiF-0I92;
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
Subject: [RFC PATCH v2 05/16] x86/kexec: Invoke copy of relocate_kernel() instead of the original
Date: Fri, 22 Nov 2024 22:38:14 +0000
Message-ID: <20241122224715.171751-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122224715.171751-1-dwmw2@infradead.org>
References: <20241122224715.171751-1-dwmw2@infradead.org>
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
 arch/x86/kernel/machine_kexec_64.c   | 28 +++++++++++++++++++++-------
 arch/x86/kernel/relocate_kernel_64.S |  5 ++++-
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 9c9ac606893e..3aeb225a0b36 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -156,8 +156,8 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 	pmd_t *pmd;
 	pte_t *pte;
 
-	vaddr = (unsigned long)relocate_kernel;
-	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
+	vaddr = (unsigned long)page_address(image->control_code_page) + PAGE_SIZE;
+	paddr = __pa(vaddr);
 	pgd += pgd_index(vaddr);
 	if (!pgd_present(*pgd)) {
 		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);
@@ -296,6 +296,7 @@ static void load_segments(void)
 
 int machine_kexec_prepare(struct kimage *image)
 {
+	void *control_page = page_address(image->control_code_page) + PAGE_SIZE;
 	unsigned long start_pgtable;
 	int result;
 
@@ -307,11 +308,17 @@ int machine_kexec_prepare(struct kimage *image)
 	if (result)
 		return result;
 
+	set_memory_x((unsigned long)control_page, 1);
+
 	return 0;
 }
 
 void machine_kexec_cleanup(struct kimage *image)
 {
+	void *control_page = page_address(image->control_code_page) + PAGE_SIZE;
+
+	set_memory_nx((unsigned long)control_page, 1);
+
 	free_transition_pgtable(image);
 }
 
@@ -321,6 +328,11 @@ void machine_kexec_cleanup(struct kimage *image)
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
@@ -369,6 +381,8 @@ void machine_kexec(struct kimage *image)
 		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
 						<< PAGE_SHIFT);
 
+	relocate_kernel_ptr = control_page;
+
 	/*
 	 * The segment registers are funny things, they have both a
 	 * visible and an invisible part.  Whenever the visible part is
@@ -388,11 +402,11 @@ void machine_kexec(struct kimage *image)
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
index 92d5dbed3097..70539b1b9545 100644
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



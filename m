Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01189D3B7F8
	for <kexec@archiver.kernel.org>; Mon, 25 Nov 2024 10:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2KYpJXwt13x4N+ajVW5Oqi+oou49IAbt1MaBworvAhs=; b=3nj5fW2RMliER0SaUPi1mVYijI
	YFjuu35ea+Y+CG88WOnpMkEJ3Gh0EJYsC7nCQNJs14E15uIG+Sc1K4BIqZc9tcjA7FKemCCTMn3mA
	gnJfQ2wEMFuvEHLQQKQYaa5idCPtcdW9afwt2+wWeei/G/rMWxa8FWyUA2sSmEEWS/enFysZalIf7
	8+PkETuNx/AsZWvFM8gG41EX+zhKUIkZKKQDrv59NSexgzYDt+rKwpKC2NgMl6e2twFtGuWUWxdB5
	iMnfFs9OXgASpJhbtRU0q7QtZU+EN0F0QmReaQGA7eRdiBSSJAsZgBesZ+jyAtowEIviRpbuZhJ+y
	IUKHkuow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWAU-00000007ihJ-1f48;
	Mon, 25 Nov 2024 10:18:10 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW12-00000007gFZ-2iFs
	for kexec@bombadil.infradead.org;
	Mon, 25 Nov 2024 10:08:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2KYpJXwt13x4N+ajVW5Oqi+oou49IAbt1MaBworvAhs=; b=ukH0KavRLXOhiClu5O7lkVqYLf
	S4UXY4FT8FThU4mieWJUkdv9PpQv211c5j5mYccTEyJtVwwMuEg7kDhX59XI5u9RzQgD09Xv4y/s4
	pJDPxYquEbT7HvPsN0TjjD6hDhftihgP7/NFpv10uSRiccCvQ1KBeeS7uU9m2Ii6QwTyP5Sf5jvBk
	CEW7DpAjLehWNgLH6WjeYGTwKDTcXFdRhscbY7MTBeGH+xpAbTTRaxWzDg/yjVV63Pf26Wb6Odjjd
	UW+Tcna7igaYeFuBtfdAKqUxm8QjnhPdOT71V/TV8fZ0qUF4WZu/2fj+hEYf4GQ5fnGQ6+ppQGigB
	GfM+hfLw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-0000000Bir0-0PTQ;
	Mon, 25 Nov 2024 10:08:22 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-000000000lJ-2oha;
	Mon, 25 Nov 2024 10:08:21 +0000
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
Subject: [RFC PATCH v3 10/20] x86/kexec: Add data section to relocate_kernel
Date: Mon, 25 Nov 2024 09:54:40 +0000
Message-ID: <20241125100815.2512-11-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125100815.2512-1-dwmw2@infradead.org>
References: <20241125100815.2512-1-dwmw2@infradead.org>
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

Now that the relocate_kernel page is handled sanely by a linker script
we can have actual data, and just use %rip-relative addressing to access
it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c   |  8 +++-
 arch/x86/kernel/relocate_kernel_64.S | 62 ++++++++++++++--------------
 arch/x86/kernel/vmlinux.lds.S        |  1 +
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 76a45a76e0fe..60232517f368 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -349,6 +349,7 @@ void machine_kexec(struct kimage *image)
 					     unsigned long start_address,
 					     unsigned int preserve_context,
 					     unsigned int host_mem_enc_active);
+	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
 	unsigned long page_list[PAGES_NR];
 	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
@@ -395,7 +396,12 @@ void machine_kexec(struct kimage *image)
 		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
 						<< PAGE_SHIFT);
 
-	relocate_kernel_ptr = control_page;
+	/*
+	 * Allow for the possibility that relocate_kernel might not be at
+	 * the very start of the page.
+	 */
+	relocate_kernel_ptr = control_page + (unsigned long)relocate_kernel -
+		reloc_start;
 
 	/*
 	 * The segment registers are funny things, they have both a
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 01138f862c59..469af51589ee 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -23,23 +23,21 @@
 #define PAGE_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
 
 /*
- * control_page + KEXEC_CONTROL_CODE_MAX_SIZE
- * ~ control_page + PAGE_SIZE are used as data storage and stack for
- * jumping back
+ * The .text.relocate_kernel and .data.relocate_kernel sections are copied
+ * into the control page, and the remainder of the page is used as the stack.
  */
-#define DATA(offset)		(KEXEC_CONTROL_CODE_MAX_SIZE+(offset))
 
+	.section .data.relocate_kernel,"a";
 /* Minimal CPU state */
-#define RSP			DATA(0x0)
-#define CR0			DATA(0x8)
-#define CR3			DATA(0x10)
-#define CR4			DATA(0x18)
-
-/* other data */
-#define CP_PA_TABLE_PAGE	DATA(0x20)
-#define CP_PA_SWAP_PAGE		DATA(0x28)
-#define CP_PA_BACKUP_PAGES_MAP	DATA(0x30)
-#define CP_VA_CONTROL_PAGE	DATA(0x38)
+SYM_DATA_LOCAL(saved_rsp, .quad 0)
+SYM_DATA_LOCAL(saved_cr0, .quad 0)
+SYM_DATA_LOCAL(saved_cr3, .quad 0)
+SYM_DATA_LOCAL(saved_cr4, .quad 0)
+	/* other data */
+SYM_DATA_LOCAL(va_control_page, .quad 0)
+SYM_DATA_LOCAL(pa_table_page, .quad 0)
+SYM_DATA_LOCAL(pa_swap_page, .quad 0)
+SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
 	.section .text.relocate_kernel,"ax";
 	.code64
@@ -63,14 +61,13 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	pushq %r15
 	pushf
 
-	movq	PTR(VA_CONTROL_PAGE)(%rsi), %r11
-	movq	%rsp, RSP(%r11)
+	movq	%rsp, saved_rsp(%rip)
 	movq	%cr0, %rax
-	movq	%rax, CR0(%r11)
+	movq	%rax, saved_cr0(%rip)
 	movq	%cr3, %rax
-	movq	%rax, CR3(%r11)
+	movq	%rax, saved_cr3(%rip)
 	movq	%cr4, %rax
-	movq	%rax, CR4(%r11)
+	movq	%rax, saved_cr4(%rip)
 
 	/* Save CR4. Required to enable the right paging mode later. */
 	movq	%rax, %r13
@@ -83,10 +80,11 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	%r8, %r12
 
 	/*
-	 * get physical address of control page now
+	 * get physical and virtual address of control page now
 	 * this is impossible after page table switch
 	 */
 	movq	PTR(PA_CONTROL_PAGE)(%rsi), %r8
+	movq	PTR(VA_CONTROL_PAGE)(%rsi), %r11
 
 	/* get physical address of page table now too */
 	movq	PTR(PA_TABLE_PAGE)(%rsi), %r9
@@ -95,10 +93,10 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	PTR(PA_SWAP_PAGE)(%rsi), %r10
 
 	/* save some information for jumping back */
-	movq	%r9, CP_PA_TABLE_PAGE(%r11)
-	movq	%r10, CP_PA_SWAP_PAGE(%r11)
-	movq	%rdi, CP_PA_BACKUP_PAGES_MAP(%r11)
-	movq	%r11, CP_VA_CONTROL_PAGE(%r11)
+	movq	%r9, pa_table_page(%rip)
+	movq	%r10, pa_swap_page(%rip)
+	movq	%rdi, pa_backup_pages_map(%rip)
+	movq	%r11, va_control_page(%rip)
 
 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
@@ -229,13 +227,13 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* get the re-entry point of the peer system */
 	movq	0(%rsp), %rbp
 	leaq	relocate_kernel(%rip), %r8
-	movq	CP_PA_SWAP_PAGE(%r8), %r10
-	movq	CP_PA_BACKUP_PAGES_MAP(%r8), %rdi
-	movq	CP_PA_TABLE_PAGE(%r8), %rax
+	movq	pa_swap_page(%rip), %r10
+	movq	pa_backup_pages_map(%rip), %rdi
+	movq	pa_table_page(%rip), %rax
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	movq	CP_VA_CONTROL_PAGE(%r8), %rax
+	movq	va_control_page(%rip), %rax
 	addq	$(virtual_mapped - relocate_kernel), %rax
 	pushq	%rax
 	ANNOTATE_UNRET_SAFE
@@ -246,11 +244,11 @@ SYM_CODE_END(identity_mapped)
 SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR // RET target, above
-	movq	RSP(%r8), %rsp
-	movq	CR4(%r8), %rax
+	movq	saved_rsp(%rip), %rsp
+	movq	saved_cr4(%rip), %rax
 	movq	%rax, %cr4
-	movq	CR3(%r8), %rax
-	movq	CR0(%r8), %r8
+	movq	saved_cr3(%rip), %rax
+	movq	saved_cr0(%rip), %r8
 	movq	%rax, %cr3
 	movq	%r8, %cr0
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1ff23a4bbf03..5d036fab1251 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -101,6 +101,7 @@ const_pcpu_hot = pcpu_hot;
 	. = ALIGN(0x100);					\
 	__relocate_kernel_start = .;				\
 	*(.text.relocate_kernel);				\
+	*(.data.relocate_kernel);				\
 	__relocate_kernel_end = .;
 
 ASSERT(__relocate_kernel_end - __relocate_kernel_start <= KEXEC_CONTROL_CODE_MAX_SIZE,
-- 
2.47.0



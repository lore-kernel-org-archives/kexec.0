Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD2AE7717A
	for <kexec@archiver.kernel.org>; Thu,  5 Dec 2024 15:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hXa9QbU7K/rGf6uo0zUn9z43mlN4qPKbq20MGDTTVdM=; b=Uq4sMNGxKjfebxgMLWYjZsUN01
	2ueDDnnfSVsMmp1ddoddJ3zukAxJGlF5TXiPagQdqH25l+L0/HwqAc7O2aPjBmI9eFEk41IJvi+MG
	2Cwj2ZtehsCf1nepqp4XSE5kZUHGHq11CAy6Kodi9eZuLcBixvhWNIZnMBlHD75juDV2wLyruuuE7
	GT7a8OXmq3ErwuiUjcbDCM7UNzVwDTLoGT/1OGKTpjU+8TEcOkYfCgRo/LY8KVr6YMY1GJQe+xcX2
	tx0vJWvCtLJ/o+0VqXkpir2HKUpfwiEgkYJUcVvRjcxrIlUsdkyWU000kw8g9kdov7J+GhhRcoj6k
	6Uy4hc9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDsy-0000000GZ2I-0g4X;
	Thu, 05 Dec 2024 15:35:24 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrQ-0000000GYRo-2bZ5
	for kexec@bombadil.infradead.org;
	Thu, 05 Dec 2024 15:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hXa9QbU7K/rGf6uo0zUn9z43mlN4qPKbq20MGDTTVdM=; b=EDnvUCuPw9/dxMuvn27HuBanDg
	sNKPh55q5T0dN7wMNx9PIePN727itFtNY4gI8wUJlP9HYZOU0LOHhclyKMTqT3S0D8AKSfR7I68tx
	DNKoqz2kcxBxlWgSrzd/HMmsvU6hlccUfKFtG6QTTD+7dPWgwvENh2e1/tZAAF1EIbRr7sYAIisAm
	Ft/ALhY2F7GiPIBic8BtY+z42MaB8UFSHcWS2uUAG6or+6lNdPT0hYvcxUMoA1j3ZvlXB3hcNX6l4
	VQ8eiUJC0aoA7mUYbRN8PnANHT1xnFrjqGYGXDU3Ofrxy0hv6oCoVNAyZFNej2ZviNQXkcwoNDU5e
	XyuyevXw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrM-0000000DDoz-1UzT;
	Thu, 05 Dec 2024 15:33:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyLR-1g2P;
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
Subject: [PATCH v5 05/20] x86/kexec: Allocate PGD for x86_64 transition page tables separately
Date: Thu,  5 Dec 2024 15:05:11 +0000
Message-ID: <20241205153343.3275139-6-dwmw2@infradead.org>
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

Now that commit d0ceea662d45 ("x86/mm: Add _PAGE_NOPTISHADOW bit to
avoid updating userspace page tables") stops kernel_ident_mapping_init()
from scribbling over the end of a 4KiB PGD by assuming the following
4KiB will be a userspace PGD, there's no good reason for the kexec PGD
to be part of a single 8KiB allocation with the control_code_page.

(It's not clear that that was the reason for x86_64 kexec doing it that
way in the first place either; there were no comments to that effect and
it seems to have been the case even before PTI came along. It looks like
it was just a happy accident which prevented memory corruption on kexec.)

Either way, it definitely isn't needed now. Just allocate the PGD
separately on x86_64, like i386 already does.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kexec.h       | 18 +++++++++---
 arch/x86/kernel/machine_kexec_64.c | 45 ++++++++++++++++--------------
 2 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index ae5482a2f0ca..ccb8ff37fa9d 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -16,6 +16,7 @@
 # define PAGES_NR		4
 #endif
 
+# define KEXEC_CONTROL_PAGE_SIZE	4096
 # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
 
 #ifndef __ASSEMBLY__
@@ -43,7 +44,6 @@ struct kimage;
 /* Maximum address we can use for the control code buffer */
 # define KEXEC_CONTROL_MEMORY_LIMIT TASK_SIZE
 
-# define KEXEC_CONTROL_PAGE_SIZE	4096
 
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_386
@@ -58,9 +58,6 @@ struct kimage;
 /* Maximum address we can use for the control pages */
 # define KEXEC_CONTROL_MEMORY_LIMIT     (MAXMEM-1)
 
-/* Allocate one page for the pdp and the second for the code */
-# define KEXEC_CONTROL_PAGE_SIZE  (4096UL + 4096UL)
-
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_X86_64
 #endif
@@ -145,6 +142,19 @@ struct kimage_arch {
 };
 #else
 struct kimage_arch {
+	/*
+	 * This is a kimage control page, as it must not overlap with either
+	 * source or destination address ranges.
+	 */
+	pgd_t *pgd;
+	/*
+	 * The virtual mapping of the control code page itself is used only
+	 * during the transition, while the current kernel's pages are all
+	 * in place. Thus the intermediate page table pages used to map it
+	 * are not control pages, but instead just normal pages obtained
+	 * with get_zeroed_page(). And have to be tracked (below) so that
+	 * they can be freed.
+	 */
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 9c9ac606893e..7223c38a8708 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -146,7 +146,8 @@ static void free_transition_pgtable(struct kimage *image)
 	image->arch.pte = NULL;
 }
 
-static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
+static int init_transition_pgtable(struct kimage *image, pgd_t *pgd,
+				   unsigned long control_page)
 {
 	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
 	unsigned long vaddr, paddr;
@@ -157,7 +158,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 	pte_t *pte;
 
 	vaddr = (unsigned long)relocate_kernel;
-	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
+	paddr = control_page;
 	pgd += pgd_index(vaddr);
 	if (!pgd_present(*pgd)) {
 		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);
@@ -216,7 +217,7 @@ static void *alloc_pgt_page(void *data)
 	return p;
 }
 
-static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
+static int init_pgtable(struct kimage *image, unsigned long control_page)
 {
 	struct x86_mapping_info info = {
 		.alloc_pgt_page	= alloc_pgt_page,
@@ -225,12 +226,12 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 		.kernpg_flag	= _KERNPG_TABLE_NOENC,
 	};
 	unsigned long mstart, mend;
-	pgd_t *level4p;
 	int result;
 	int i;
 
-	level4p = (pgd_t *)__va(start_pgtable);
-	clear_page(level4p);
+	image->arch.pgd = alloc_pgt_page(image);
+	if (!image->arch.pgd)
+		return -ENOMEM;
 
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		info.page_flag   |= _PAGE_ENC;
@@ -244,8 +245,8 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 		mstart = pfn_mapped[i].start << PAGE_SHIFT;
 		mend   = pfn_mapped[i].end << PAGE_SHIFT;
 
-		result = kernel_ident_mapping_init(&info,
-						 level4p, mstart, mend);
+		result = kernel_ident_mapping_init(&info, image->arch.pgd,
+						   mstart, mend);
 		if (result)
 			return result;
 	}
@@ -260,8 +261,8 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 		mstart = image->segment[i].mem;
 		mend   = mstart + image->segment[i].memsz;
 
-		result = kernel_ident_mapping_init(&info,
-						 level4p, mstart, mend);
+		result = kernel_ident_mapping_init(&info, image->arch.pgd,
+						   mstart, mend);
 
 		if (result)
 			return result;
@@ -271,15 +272,19 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	 * Prepare EFI systab and ACPI tables for kexec kernel since they are
 	 * not covered by pfn_mapped.
 	 */
-	result = map_efi_systab(&info, level4p);
+	result = map_efi_systab(&info, image->arch.pgd);
 	if (result)
 		return result;
 
-	result = map_acpi_tables(&info, level4p);
+	result = map_acpi_tables(&info, image->arch.pgd);
 	if (result)
 		return result;
 
-	return init_transition_pgtable(image, level4p);
+	/*
+	 * This must be last because the intermediate page table pages it
+	 * allocates will not be control pages and may overlap the image.
+	 */
+	return init_transition_pgtable(image, image->arch.pgd, control_page);
 }
 
 static void load_segments(void)
@@ -296,14 +301,14 @@ static void load_segments(void)
 
 int machine_kexec_prepare(struct kimage *image)
 {
-	unsigned long start_pgtable;
+	unsigned long control_page;
 	int result;
 
 	/* Calculate the offsets */
-	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
+	control_page = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
 
 	/* Setup the identity mapped 64bit page table */
-	result = init_pgtable(image, start_pgtable);
+	result = init_pgtable(image, control_page);
 	if (result)
 		return result;
 
@@ -357,13 +362,12 @@ void machine_kexec(struct kimage *image)
 #endif
 	}
 
-	control_page = page_address(image->control_code_page) + PAGE_SIZE;
+	control_page = page_address(image->control_code_page);
 	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
-	page_list[PA_TABLE_PAGE] =
-	  (unsigned long)__pa(page_address(image->control_code_page));
+	page_list[PA_TABLE_PAGE] = (unsigned long)__pa(image->arch.pgd);
 
 	if (image->type == KEXEC_TYPE_DEFAULT)
 		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
@@ -573,8 +577,7 @@ static void kexec_mark_crashkres(bool protect)
 
 	/* Don't touch the control code page used in crash_kexec().*/
 	control = PFN_PHYS(page_to_pfn(kexec_crash_image->control_code_page));
-	/* Control code page is located in the 2nd page. */
-	kexec_mark_range(crashk_res.start, control + PAGE_SIZE - 1, protect);
+	kexec_mark_range(crashk_res.start, control - 1, protect);
 	control += KEXEC_CONTROL_PAGE_SIZE;
 	kexec_mark_range(control, crashk_res.end, protect);
 }
-- 
2.47.0



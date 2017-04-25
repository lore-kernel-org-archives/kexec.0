Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d2wXE-0006po-Iv
 for kexec@lists.infradead.org; Tue, 25 Apr 2017 09:13:26 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH 1/2] x86/mm/ident_map: Add PUD level 1GB page support
Date: Tue, 25 Apr 2017 17:13:01 +0800
Message-Id: <1493111582-28261-1-git-send-email-xlpang@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Yinghai Lu <yinghai@kernel.org>, x86@kernel.org, Xunlei Pang <xlpang@redhat.com>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

The current kernel_ident_mapping_init() creates the identity
mapping using 2MB page(PMD level), this patch adds the 1GB
page(PUD level) support.

This is useful on large machines to save some reserved memory
(as paging structures) in the kdump case when kexec setups up
identity mappings before booting into the new kernel.

We will utilize this new support in the following patch.

Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 arch/x86/boot/compressed/pagetable.c |  2 +-
 arch/x86/include/asm/init.h          |  3 ++-
 arch/x86/kernel/machine_kexec_64.c   |  2 +-
 arch/x86/mm/ident_map.c              | 13 ++++++++++++-
 arch/x86/power/hibernate_64.c        |  2 +-
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/pagetable.c b/arch/x86/boot/compressed/pagetable.c
index 56589d0..1d78f17 100644
--- a/arch/x86/boot/compressed/pagetable.c
+++ b/arch/x86/boot/compressed/pagetable.c
@@ -70,7 +70,7 @@ static void *alloc_pgt_page(void *context)
  * Due to relocation, pointers must be assigned at run time not build time.
  */
 static struct x86_mapping_info mapping_info = {
-	.pmd_flag       = __PAGE_KERNEL_LARGE_EXEC,
+	.page_flag       = __PAGE_KERNEL_LARGE_EXEC,
 };
 
 /* Locates and clears a region for a new top level page table. */
diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 737da62..46eab1a 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -4,8 +4,9 @@
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
 	void *context;			 /* context for alloc_pgt_page */
-	unsigned long pmd_flag;		 /* page flag for PMD entry */
+	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
 	unsigned long offset;		 /* ident mapping offset */
+	bool use_pud_page;		/* PUD level 1GB page support */
 };
 
 int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 085c3b3..1d4f2b0 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -113,7 +113,7 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	struct x86_mapping_info info = {
 		.alloc_pgt_page	= alloc_pgt_page,
 		.context	= image,
-		.pmd_flag	= __PAGE_KERNEL_LARGE_EXEC,
+		.page_flag	= __PAGE_KERNEL_LARGE_EXEC,
 	};
 	unsigned long mstart, mend;
 	pgd_t *level4p;
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 04210a2..0ad0280 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -13,7 +13,7 @@ static void ident_pmd_init(struct x86_mapping_info *info, pmd_t *pmd_page,
 		if (pmd_present(*pmd))
 			continue;
 
-		set_pmd(pmd, __pmd((addr - info->offset) | info->pmd_flag));
+		set_pmd(pmd, __pmd((addr - info->offset) | info->page_flag));
 	}
 }
 
@@ -30,6 +30,17 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 		if (next > end)
 			next = end;
 
+		if (info->use_pud_page) {
+			pud_t pudval;
+
+			if (pud_present(*pud))
+				continue;
+
+			pudval = __pud((addr - info->offset) | info->page_flag);
+			set_pud(pud, pudval);
+			continue;
+		}
+
 		if (pud_present(*pud)) {
 			pmd = pmd_offset(pud, 0);
 			ident_pmd_init(info, pmd, addr, next);
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 6a61194..a6e21fe 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -104,7 +104,7 @@ static int set_up_temporary_mappings(void)
 {
 	struct x86_mapping_info info = {
 		.alloc_pgt_page	= alloc_pgt_page,
-		.pmd_flag	= __PAGE_KERNEL_LARGE_EXEC,
+		.page_flag	= __PAGE_KERNEL_LARGE_EXEC,
 		.offset		= __PAGE_OFFSET,
 	};
 	unsigned long mstart, mend;
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

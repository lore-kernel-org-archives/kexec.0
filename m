Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7O9Z-00007C-8r
 for kexec@lists.infradead.org; Mon, 09 Sep 2019 18:12:45 +0000
Received: by mail-qt1-x842.google.com with SMTP id n7so17276805qtb.6
 for <kexec@lists.infradead.org>; Mon, 09 Sep 2019 11:12:41 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v4 11/17] arm64: trans_pgd: pass allocator
 trans_pgd_create_copy
Date: Mon,  9 Sep 2019 14:12:15 -0400
Message-Id: <20190909181221.309510-12-pasha.tatashin@soleen.com>
In-Reply-To: <20190909181221.309510-1-pasha.tatashin@soleen.com>
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com

Make trans_pgd_create_copy and its subroutines to use allocator that is
passed as an argument

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  7 ++++--
 arch/arm64/kernel/hibernate.c      |  6 ++++-
 arch/arm64/mm/trans_pgd.c          | 35 +++++++++++++++---------------
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index 53f67ec84cdc..61a725fe1093 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -25,8 +25,11 @@ struct trans_pgd_info {
 	void *trans_alloc_arg;
 };
 
-int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
-			  unsigned long end);
+/*
+ * Create trans_pgd and copy linear map [start, end)
+ */
+int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
+			  unsigned long start, unsigned long end);
 
 /*
  * Add map entry to trans_pgd for a base-size page at PTE level.
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 9b75b680ab70..36eccf63629c 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -322,13 +322,17 @@ int swsusp_arch_resume(void)
 	phys_addr_t phys_hibernate_exit;
 	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
 					  void *, phys_addr_t, phys_addr_t);
+	struct trans_pgd_info trans_info = {
+		.trans_alloc_page	= hibernate_page_alloc,
+		.trans_alloc_arg	= (void *)GFP_ATOMIC,
+	};
 
 	/*
 	 * Restoring the memory image will overwrite the ttbr1 page tables.
 	 * Create a second copy of just the linear map, and use this when
 	 * restoring.
 	 */
-	rc = trans_pgd_create_copy(&tmp_pg_dir, PAGE_OFFSET, 0);
+	rc = trans_pgd_create_copy(&trans_info, &tmp_pg_dir, PAGE_OFFSET, 0);
 	if (rc)
 		goto out;
 
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 7521d558a0b9..dfde87159840 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -57,14 +57,14 @@ static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 	}
 }
 
-static int copy_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long start,
-		    unsigned long end)
+static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
+		    pmd_t *src_pmdp, unsigned long start, unsigned long end)
 {
 	pte_t *src_ptep;
 	pte_t *dst_ptep;
 	unsigned long addr = start;
 
-	dst_ptep = (pte_t *)get_safe_page(GFP_ATOMIC);
+	dst_ptep = trans_alloc(info);
 	if (!dst_ptep)
 		return -ENOMEM;
 	pmd_populate_kernel(&init_mm, dst_pmdp, dst_ptep);
@@ -78,8 +78,8 @@ static int copy_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long start,
 	return 0;
 }
 
-static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
-		    unsigned long end)
+static int copy_pmd(struct trans_pgd_info *info, pud_t *dst_pudp,
+		    pud_t *src_pudp, unsigned long start, unsigned long end)
 {
 	pmd_t *src_pmdp;
 	pmd_t *dst_pmdp;
@@ -87,7 +87,7 @@ static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
 	unsigned long addr = start;
 
 	if (pud_none(READ_ONCE(*dst_pudp))) {
-		dst_pmdp = (pmd_t *)get_safe_page(GFP_ATOMIC);
+		dst_pmdp = trans_alloc(info);
 		if (!dst_pmdp)
 			return -ENOMEM;
 		pud_populate(&init_mm, dst_pudp, dst_pmdp);
@@ -102,7 +102,7 @@ static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
 		if (pmd_none(pmd))
 			continue;
 		if (pmd_table(pmd)) {
-			if (copy_pte(dst_pmdp, src_pmdp, addr, next))
+			if (copy_pte(info, dst_pmdp, src_pmdp, addr, next))
 				return -ENOMEM;
 		} else {
 			set_pmd(dst_pmdp,
@@ -113,7 +113,8 @@ static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
 	return 0;
 }
 
-static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
+static int copy_pud(struct trans_pgd_info *info, pgd_t *dst_pgdp,
+		    pgd_t *src_pgdp, unsigned long start,
 		    unsigned long end)
 {
 	pud_t *dst_pudp;
@@ -122,7 +123,7 @@ static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 	unsigned long addr = start;
 
 	if (pgd_none(READ_ONCE(*dst_pgdp))) {
-		dst_pudp = (pud_t *)get_safe_page(GFP_ATOMIC);
+		dst_pudp = trans_alloc(info);
 		if (!dst_pudp)
 			return -ENOMEM;
 		pgd_populate(&init_mm, dst_pgdp, dst_pudp);
@@ -137,7 +138,7 @@ static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 		if (pud_none(pud))
 			continue;
 		if (pud_table(pud)) {
-			if (copy_pmd(dst_pudp, src_pudp, addr, next))
+			if (copy_pmd(info, dst_pudp, src_pudp, addr, next))
 				return -ENOMEM;
 		} else {
 			set_pud(dst_pudp,
@@ -148,8 +149,8 @@ static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 	return 0;
 }
 
-static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
-			    unsigned long end)
+static int copy_page_tables(struct trans_pgd_info *info, pgd_t *dst_pgdp,
+			    unsigned long start, unsigned long end)
 {
 	unsigned long next;
 	unsigned long addr = start;
@@ -160,25 +161,25 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(READ_ONCE(*src_pgdp)))
 			continue;
-		if (copy_pud(dst_pgdp, src_pgdp, addr, next))
+		if (copy_pud(info, dst_pgdp, src_pgdp, addr, next))
 			return -ENOMEM;
 	} while (dst_pgdp++, src_pgdp++, addr = next, addr != end);
 
 	return 0;
 }
 
-int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
-			  unsigned long end)
+int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **dst_pgdp,
+			  unsigned long start, unsigned long end)
 {
 	int rc;
-	pgd_t *trans_pgd = (pgd_t *)get_safe_page(GFP_ATOMIC);
+	pgd_t *trans_pgd = trans_alloc(info);
 
 	if (!trans_pgd) {
 		pr_err("Failed to allocate memory for temporary page tables.\n");
 		return -ENOMEM;
 	}
 
-	rc = copy_page_tables(trans_pgd, start, end);
+	rc = copy_page_tables(info, trans_pgd, start, end);
 	if (!rc)
 		*dst_pgdp = trans_pgd;
 
-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

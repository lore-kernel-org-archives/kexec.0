Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mR0Zj-00CaI5-9z
 for kexec@lists.infradead.org; Thu, 16 Sep 2021 23:13:53 +0000
Received: by mail-qv1-xf31.google.com with SMTP id u4so5306903qvb.6
 for <kexec@lists.infradead.org>; Thu, 16 Sep 2021 16:13:50 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v17 15/15] arm64: trans_pgd: remove trans_pgd_map_page()
Date: Thu, 16 Sep 2021 19:13:25 -0400
Message-Id: <20210916231325.125533-16-pasha.tatashin@soleen.com>
In-Reply-To: <20210916231325.125533-1-pasha.tatashin@soleen.com>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com, tyhicks@linux.microsoft.com, kernelfans@gmail.com, akpm@linux-foundation.org, madvenka@linux.microsoft.com

The intend of trans_pgd_map_page() was to map contiguous range of VA
memory to the memory that is getting relocated during kexec. However,
since we are now using linear map instead of contiguous range this
function is not needed

Suggested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  5 +--
 arch/arm64/mm/trans_pgd.c          | 57 ------------------------------
 2 files changed, 1 insertion(+), 61 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index 7b04d32b102c..033d400a4ea4 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -15,7 +15,7 @@
 /*
  * trans_alloc_page
  *	- Allocator that should return exactly one zeroed page, if this
- *	  allocator fails, trans_pgd_create_copy() and trans_pgd_map_page()
+ *	  allocator fails, trans_pgd_create_copy() and trans_pgd_idmap_page()
  *	  return -ENOMEM error.
  *
  * trans_alloc_arg
@@ -30,9 +30,6 @@ struct trans_pgd_info {
 int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
 			  unsigned long start, unsigned long end);
 
-int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
-		       void *page, unsigned long dst_addr, pgprot_t pgprot);
-
 int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
 			 unsigned long *t0sz, void *page);
 
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 26bd8f2d95af..d7da8ca40d2e 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -217,63 +217,6 @@ int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **dst_pgdp,
 	return rc;
 }
 
-/*
- * Add map entry to trans_pgd for a base-size page at PTE level.
- * info:	contains allocator and its argument
- * trans_pgd:	page table in which new map is added.
- * page:	page to be mapped.
- * dst_addr:	new VA address for the page
- * pgprot:	protection for the page.
- *
- * Returns 0 on success, and -ENOMEM on failure.
- */
-int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
-		       void *page, unsigned long dst_addr, pgprot_t pgprot)
-{
-	pgd_t *pgdp;
-	p4d_t *p4dp;
-	pud_t *pudp;
-	pmd_t *pmdp;
-	pte_t *ptep;
-
-	pgdp = pgd_offset_pgd(trans_pgd, dst_addr);
-	if (pgd_none(READ_ONCE(*pgdp))) {
-		p4dp = trans_alloc(info);
-		if (!pgdp)
-			return -ENOMEM;
-		pgd_populate(NULL, pgdp, p4dp);
-	}
-
-	p4dp = p4d_offset(pgdp, dst_addr);
-	if (p4d_none(READ_ONCE(*p4dp))) {
-		pudp = trans_alloc(info);
-		if (!pudp)
-			return -ENOMEM;
-		p4d_populate(NULL, p4dp, pudp);
-	}
-
-	pudp = pud_offset(p4dp, dst_addr);
-	if (pud_none(READ_ONCE(*pudp))) {
-		pmdp = trans_alloc(info);
-		if (!pmdp)
-			return -ENOMEM;
-		pud_populate(NULL, pudp, pmdp);
-	}
-
-	pmdp = pmd_offset(pudp, dst_addr);
-	if (pmd_none(READ_ONCE(*pmdp))) {
-		ptep = trans_alloc(info);
-		if (!ptep)
-			return -ENOMEM;
-		pmd_populate_kernel(NULL, pmdp, ptep);
-	}
-
-	ptep = pte_offset_kernel(pmdp, dst_addr);
-	set_pte(ptep, pfn_pte(virt_to_pfn(page), pgprot));
-
-	return 0;
-}
-
 /*
  * The page we want to idmap may be outside the range covered by VA_BITS that
  * can be built using the kernel's p?d_populate() helpers. As a one off, for a
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

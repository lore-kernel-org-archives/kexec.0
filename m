Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i0VPC-0004Ca-1b
 for kexec@lists.infradead.org; Wed, 21 Aug 2019 18:32:23 +0000
Received: by mail-qt1-x843.google.com with SMTP id k13so4213488qtm.12
 for <kexec@lists.infradead.org>; Wed, 21 Aug 2019 11:32:21 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v3 10/17] arm64,
 trans_pgd: adjust trans_pgd_create_copy interface
Date: Wed, 21 Aug 2019 14:31:57 -0400
Message-Id: <20190821183204.23576-11-pasha.tatashin@soleen.com>
In-Reply-To: <20190821183204.23576-1-pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
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

Make trans_pgd_create_copy inline with the other functions in
trans_pgd: use the trans_pgd_info argument, and also use the
trans_pgd_create_empty.

Note, that the functions that are called by trans_pgd_create_copy are
not yet adjusted to be compliant with trans_pgd: they do not yet use
the provided allocator, do not check for generic errors, and do not yet
use the flags in info argument.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  7 ++++++-
 arch/arm64/kernel/hibernate.c      | 31 ++++++++++++++++++++++++++++--
 arch/arm64/mm/trans_pgd.c          | 17 ++++++----------
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index 26e5a63676b5..f4a5f255d4a7 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -43,7 +43,12 @@ struct trans_pgd_info {
 /* Create and empty trans_pgd page table */
 int trans_pgd_create_empty(struct trans_pgd_info *info, pgd_t **trans_pgd);
 
-int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
+/*
+ * Create trans_pgd and copy entries from from_table to trans_pgd in range
+ * [start, end)
+ */
+int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
+			  pgd_t *from_table, unsigned long start,
 			  unsigned long end);
 
 /*
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 8c2641a9bb09..8bb602e91065 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -323,15 +323,42 @@ int swsusp_arch_resume(void)
 	phys_addr_t phys_hibernate_exit;
 	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
 					  void *, phys_addr_t, phys_addr_t);
+	struct trans_pgd_info trans_info = {
+		.trans_alloc_page	= hibernate_page_alloc,
+		.trans_alloc_arg	= (void *)GFP_ATOMIC,
+		/*
+		 * Resume will overwrite areas that may be marked read only
+		 * (code, rodata). Clear the RDONLY bit from the temporary
+		 * mappings we use during restore.
+		 */
+		.trans_flags		= TRANS_MKWRITE,
+	};
+
+	/*
+	 * debug_pagealloc will removed the PTE_VALID bit if the page isn't in
+	 * use by the resume kernel. It may have been in use by the original
+	 * kernel, in which case we need to put it back in our copy to do the
+	 * restore.
+	 *
+	 * Before marking this entry valid, check the pfn should be mapped.
+	 */
+	if (debug_pagealloc_enabled())
+		trans_info.trans_flags |= (TRANS_MKVALID | TRANS_CHECKPFN);
 
 	/*
 	 * Restoring the memory image will overwrite the ttbr1 page tables.
 	 * Create a second copy of just the linear map, and use this when
 	 * restoring.
 	 */
-	rc = trans_pgd_create_copy(&tmp_pg_dir, PAGE_OFFSET, 0);
-	if (rc)
+	rc = trans_pgd_create_copy(&trans_info, &tmp_pg_dir, init_mm.pgd,
+				   PAGE_OFFSET, 0);
+	if (rc) {
+		if (rc == -ENOMEM)
+			pr_err("Failed to allocate memory for temporary page tables.\n");
+		else if (rc == -ENXIO)
+			pr_err("Tried to set PTE for PFN that does not exist\n");
 		goto out;
+	}
 
 	/*
 	 * We need a zero page that is zero before & after resume in order to
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index ece797aa1841..7d8734709b61 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -176,22 +176,17 @@ int trans_pgd_create_empty(struct trans_pgd_info *info, pgd_t **trans_pgd)
 	return 0;
 }
 
-int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
+int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
+			  pgd_t *from_table, unsigned long start,
 			  unsigned long end)
 {
 	int rc;
-	pgd_t *trans_pgd = (pgd_t *)get_safe_page(GFP_ATOMIC);
 
-	if (!trans_pgd) {
-		pr_err("Failed to allocate memory for temporary page tables.\n");
-		return -ENOMEM;
-	}
-
-	rc = copy_page_tables(trans_pgd, start, end);
-	if (!rc)
-		*dst_pgdp = trans_pgd;
+	rc = trans_pgd_create_empty(info, trans_pgd);
+	if (rc)
+		return rc;
 
-	return rc;
+	return copy_page_tables(*trans_pgd, start, end);
 }
 
 int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

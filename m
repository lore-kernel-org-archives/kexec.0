Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X7mXB-0003Ii-7V
 for kexec@lists.infradead.org; Thu, 17 Jul 2014 14:19:45 +0000
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 18 Jul 2014 00:19:21 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E69962BB0052
 for <kexec@lists.infradead.org>; Fri, 18 Jul 2014 00:19:17 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6HDuXc34456754
 for <kexec@lists.infradead.org>; Thu, 17 Jul 2014 23:56:33 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6HEJHiN026249
 for <kexec@lists.infradead.org>; Fri, 18 Jul 2014 00:19:17 +1000
Subject: [PATCH 2/2] makedumpfile: vtop address translation support for
 vmalloc region in PPC64 arch
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 17 Jul 2014 19:49:15 +0530
Message-ID: <20140717141915.8955.94105.stgit@localhost.localdomain>
In-Reply-To: <20140717141827.8955.95825.stgit@localhost.localdomain>
References: <20140717141827.8955.95825.stgit@localhost.localdomain>
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
To: Kexec-ml <kexec@lists.infradead.org>, Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Ken'ichi <oomichi@mxs.nes.nec.co.jp>

This patch adds virtual to physical address translation support
for vmalloc region in PPC64 architecture.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/ppc64.c   |   84 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 makedumpfile.h |    3 ++
 2 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index dabf2e7..609aaa2 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -224,6 +224,69 @@ ppc64_vmemmap_to_phys(unsigned long vaddr)
 	return paddr;
 }
 
+static unsigned long long
+ppc64_vtop_level4(unsigned long vaddr)
+{
+	ulong *level4, *level4_dir;
+        ulong *page_dir, *page_middle;
+        ulong *page_table;
+        unsigned long long level4_pte, pgd_pte;
+	unsigned long long pmd_pte, pte;
+	unsigned long long paddr = NOT_PADDR;
+
+	level4 = (ulong *)info->kernel_pgd;
+	level4_dir = (ulong *)((ulong *)level4 + L4_OFFSET(vaddr));
+	if (!readmem(VADDR, PAGEBASE(level4), info->page_buf, PAGESIZE())) {
+		ERRMSG("Can't read level4 page: 0x%llx\n", PAGEBASE(level4));
+		return NOT_PADDR;
+	}
+	level4_pte = ULONG((info->page_buf + PAGEOFFSET(level4_dir)));
+	if (!level4_pte)
+		return NOT_PADDR;
+
+	/* Sometimes we don't have level3 pagetable entries */
+        if (info->l3_index_size != 0) {
+                page_dir = (ulong *)((ulong *)level4_pte + PGD_OFFSET_L4(vaddr));
+		if (!readmem(VADDR, PAGEBASE(level4_pte), info->page_buf, PAGESIZE())) {
+			ERRMSG("Can't read PGD page: 0x%llx\n", PAGEBASE(level4_pte));
+			return NOT_PADDR;
+		}
+                pgd_pte = ULONG((info->page_buf + PAGEOFFSET(page_dir)));
+                if (!pgd_pte)
+                        return NOT_PADDR;
+        } else {
+                pgd_pte = level4_pte;
+        }
+
+	page_middle = (ulong *)((ulong *)pgd_pte + PMD_OFFSET_L4(vaddr));
+	if (!readmem(VADDR, PAGEBASE(pgd_pte), info->page_buf, PAGESIZE())) {
+		ERRMSG("Can't read PMD page: 0x%llx\n", PAGEBASE(pgd_pte));
+		return NOT_PADDR;
+	}
+        pmd_pte = ULONG((info->page_buf + PAGEOFFSET(page_middle)));
+	if (!(pmd_pte))
+		return NOT_PADDR;
+
+	page_table = (ulong *)(pmd_pte & ~(info->l2_masked_bits))
+			+ (BTOP(vaddr) & (info->ptrs_per_l1 - 1));
+	if (!readmem(VADDR, PAGEBASE(pmd_pte), info->page_buf, PAGESIZE())) {
+		ERRMSG("Can't read page table: 0x%llx\n", PAGEBASE(pmd_pte));
+		return NOT_PADDR;
+	}
+        pte = ULONG((info->page_buf + PAGEOFFSET(page_table)));
+	if (!(pte & _PAGE_PRESENT)) {
+		ERRMSG("Page not present!\n");
+		return NOT_PADDR;
+	}
+
+	if (!pte)
+		return NOT_PADDR;
+
+	paddr = PAGEBASE(PTOB(pte >> info->pte_shift)) + PAGEOFFSET(vaddr);
+
+	return paddr;
+}
+
 int
 set_ppc64_max_physmem_bits(void)
 {
@@ -347,10 +410,18 @@ vaddr_to_paddr_ppc64(unsigned long vaddr)
 {
 	unsigned long long paddr;
 
+	if ((info->flag_vmemmap)
+	    && (vaddr >= info->vmemmap_start)) {
+		return ppc64_vmemmap_to_phys(vaddr);
+	}
+
 	paddr = vaddr_to_paddr_general(vaddr);
 	if (paddr != NOT_PADDR)
 		return paddr;
 
+	if (!is_vmalloc_addr_ppc64(vaddr))
+		return (vaddr - info->kernel_start);
+
 	if ((SYMBOL(vmap_area_list) == NOT_FOUND_SYMBOL)
 	    || (OFFSET(vmap_area.va_start) == NOT_FOUND_STRUCTURE)
 	    || (OFFSET(vmap_area.list) == NOT_FOUND_STRUCTURE)) {
@@ -360,19 +431,8 @@ vaddr_to_paddr_ppc64(unsigned long vaddr)
 			return NOT_PADDR;
 		}
 	}
-	if (!is_vmalloc_addr_ppc64(vaddr))
-		return (vaddr - info->kernel_start);
-
-	if ((info->flag_vmemmap)
-	    && (vaddr >= info->vmemmap_start)) {
-		return ppc64_vmemmap_to_phys(vaddr);
-	}
 
-	/*
-	 * TODO: Support vmalloc translation.
-	 */
-	ERRMSG("This makedumpfile does not support vmalloc translation.\n");
-	return NOT_PADDR;
+	return ppc64_vtop_level4(vaddr);
 }
 
 #endif /* powerpc64 */
diff --git a/makedumpfile.h b/makedumpfile.h
index 7816241..778f36f 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -158,6 +158,9 @@ isAnon(unsigned long mapping)
 	return ((unsigned long)mapping & PAGE_MAPPING_ANON) != 0;
 }
 
+#define PTOB(X)			(((unsigned long long)(X)) << info->page_shift)
+#define BTOP(X)			(((unsigned long long)(X)) >> info->page_shift)
+
 #define PAGESIZE()		(info->page_size)
 #define PAGESHIFT()		(info->page_shift)
 #define PAGEOFFSET(X)		(((unsigned long long)(X)) & (PAGESIZE() - 1))


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

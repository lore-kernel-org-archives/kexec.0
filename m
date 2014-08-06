Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XFB3N-0000H9-OB
 for kexec@lists.infradead.org; Wed, 06 Aug 2014 23:55:35 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2 2/2] makedumpfile: vtop address translation support
 for vmalloc region in PPC64 arch
Date: Wed, 6 Aug 2014 23:50:50 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9724AFE9@BPXM01GP.gisp.nec.co.jp>
References: <20140728141253.3399.4397.stgit@localhost.localdomain>
 <20140728141346.3399.14993.stgit@localhost.localdomain>
In-Reply-To: <20140728141346.3399.14993.stgit@localhost.localdomain>
Content-Language: ja-JP
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
To: "hbathini@linux.vnet.ibm.com" <hbathini@linux.vnet.ibm.com>
Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Kenichi Oomichi <oomichi@mxs.nes.nec.co.jp>

>This patch adds virtual to physical address translation support
>for vmalloc region in PPC64 architecture.
>
>Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>---
> arch/ppc64.c   |  100 +++++++++++++++++++++++++++++++++++++++++++++++++-------
> makedumpfile.h |    3 ++
> 2 files changed, 91 insertions(+), 12 deletions(-)
>
>diff --git a/arch/ppc64.c b/arch/ppc64.c
>index 8c7eaa7..8bb90d9 100644
>--- a/arch/ppc64.c
>+++ b/arch/ppc64.c
>@@ -24,6 +24,8 @@
> #include "../elf_info.h"
> #include "../makedumpfile.h"
>
>+static char *page_buf; /* Page buffer to read page tables */
>+
> /*
>  * This function traverses vmemmap list to get the count of vmemmap regions
>  * and populates the regions' info in info->vmemmap_list[]
>@@ -224,6 +226,83 @@ ppc64_vmemmap_to_phys(unsigned long vaddr)
> 	return paddr;
> }
>
>+static unsigned long long
>+ppc64_vtop_level4(unsigned long vaddr)
>+{
>+	ulong *level4, *level4_dir;
>+	ulong *page_dir, *page_middle;
>+	ulong *page_table;
>+	unsigned long long level4_pte, pgd_pte;
>+	unsigned long long pmd_pte, pte;
>+	unsigned long long paddr = NOT_PADDR;
>+
>+	if (page_buf == NULL) {
>+		/*
>+		 * This is the first vmalloc address translation request
>+		 */
>+		page_buf = (char *)calloc(1, PAGESIZE());

Hmm, the v2 way can't free this buffer at the appropriate time, sorry.
Could you put it back in struct DumpInfo like v1 and free it at the
end of main() ?


Thanks
Atsushi Kumagai

>+		if (page_buf == NULL) {
>+			ERRMSG("Can't allocate memory to read page tables. %s\n",
>+			       strerror(errno));
>+			return NOT_PADDR;
>+		}
>+	}
>+
>+	level4 = (ulong *)info->kernel_pgd;
>+	level4_dir = (ulong *)((ulong *)level4 + L4_OFFSET(vaddr));
>+	if (!readmem(VADDR, PAGEBASE(level4), page_buf, PAGESIZE())) {
>+		ERRMSG("Can't read level4 page: 0x%llx\n", PAGEBASE(level4));
>+		return NOT_PADDR;
>+	}
>+	level4_pte = ULONG((page_buf + PAGEOFFSET(level4_dir)));
>+	if (!level4_pte)
>+		return NOT_PADDR;
>+
>+	/*
>+	 * Sometimes we don't have level3 pagetable entries
>+	 */
>+	if (info->l3_index_size != 0) {
>+		page_dir = (ulong *)((ulong *)level4_pte + PGD_OFFSET_L4(vaddr));
>+		if (!readmem(VADDR, PAGEBASE(level4_pte), page_buf, PAGESIZE())) {
>+			ERRMSG("Can't read PGD page: 0x%llx\n", PAGEBASE(level4_pte));
>+			return NOT_PADDR;
>+		}
>+		pgd_pte = ULONG((page_buf + PAGEOFFSET(page_dir)));
>+		if (!pgd_pte)
>+			return NOT_PADDR;
>+	} else {
>+		pgd_pte = level4_pte;
>+	}
>+
>+	page_middle = (ulong *)((ulong *)pgd_pte + PMD_OFFSET_L4(vaddr));
>+	if (!readmem(VADDR, PAGEBASE(pgd_pte), page_buf, PAGESIZE())) {
>+		ERRMSG("Can't read PMD page: 0x%llx\n", PAGEBASE(pgd_pte));
>+		return NOT_PADDR;
>+	}
>+	pmd_pte = ULONG((page_buf + PAGEOFFSET(page_middle)));
>+	if (!(pmd_pte))
>+		return NOT_PADDR;
>+
>+	page_table = (ulong *)(pmd_pte & ~(info->l2_masked_bits))
>+			+ (BTOP(vaddr) & (info->ptrs_per_l1 - 1));
>+	if (!readmem(VADDR, PAGEBASE(pmd_pte), page_buf, PAGESIZE())) {
>+		ERRMSG("Can't read page table: 0x%llx\n", PAGEBASE(pmd_pte));
>+		return NOT_PADDR;
>+	}
>+	pte = ULONG((page_buf + PAGEOFFSET(page_table)));
>+	if (!(pte & _PAGE_PRESENT)) {
>+		ERRMSG("Page not present!\n");
>+		return NOT_PADDR;
>+	}
>+
>+	if (!pte)
>+		return NOT_PADDR;
>+
>+	paddr = PAGEBASE(PTOB(pte >> info->pte_shift)) + PAGEOFFSET(vaddr);
>+
>+	return paddr;
>+}
>+
> int
> set_ppc64_max_physmem_bits(void)
> {
>@@ -347,10 +426,18 @@ vaddr_to_paddr_ppc64(unsigned long vaddr)
> {
> 	unsigned long long paddr;
>
>+	if ((info->flag_vmemmap)
>+	    && (vaddr >= info->vmemmap_start)) {
>+		return ppc64_vmemmap_to_phys(vaddr);
>+	}
>+
> 	paddr = vaddr_to_paddr_general(vaddr);
> 	if (paddr != NOT_PADDR)
> 		return paddr;
>
>+	if (!is_vmalloc_addr_ppc64(vaddr))
>+		return (vaddr - info->kernel_start);
>+
> 	if ((SYMBOL(vmap_area_list) == NOT_FOUND_SYMBOL)
> 	    || (OFFSET(vmap_area.va_start) == NOT_FOUND_STRUCTURE)
> 	    || (OFFSET(vmap_area.list) == NOT_FOUND_STRUCTURE)) {
>@@ -360,19 +447,8 @@ vaddr_to_paddr_ppc64(unsigned long vaddr)
> 			return NOT_PADDR;
> 		}
> 	}
>-	if (!is_vmalloc_addr_ppc64(vaddr))
>-		return (vaddr - info->kernel_start);
>
>-	if ((info->flag_vmemmap)
>-	    && (vaddr >= info->vmemmap_start)) {
>-		return ppc64_vmemmap_to_phys(vaddr);
>-	}
>-
>-	/*
>-	 * TODO: Support vmalloc translation.
>-	 */
>-	ERRMSG("This makedumpfile does not support vmalloc translation.\n");
>-	return NOT_PADDR;
>+	return ppc64_vtop_level4(vaddr);
> }
>
> #endif /* powerpc64 */
>diff --git a/makedumpfile.h b/makedumpfile.h
>index 8510b8f..dba3a0c 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -158,6 +158,9 @@ isAnon(unsigned long mapping)
> 	return ((unsigned long)mapping & PAGE_MAPPING_ANON) != 0;
> }
>
>+#define PTOB(X)			(((unsigned long long)(X)) << PAGESHIFT())
>+#define BTOP(X)			(((unsigned long long)(X)) >> PAGESHIFT())
>+
> #define PAGESIZE()		(info->page_size)
> #define PAGESHIFT()		(info->page_shift)
> #define PAGEOFFSET(X)		(((unsigned long long)(X)) & (PAGESIZE() - 1))
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

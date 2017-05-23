Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dD2ev-0004Sb-VV
 for kexec@lists.infradead.org; Tue, 23 May 2017 05:47:08 +0000
Date: Tue, 23 May 2017 07:46:40 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [makedumpfile PATCH] Fix the use of Xen physical and machine addresses
Message-ID: <20170523074640.10a0d0b6@hananiah.suse.cz>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org

There is currently some support for physical-to-machine translation in
makedumpfile, but it is inconsistent.

Most importantly, vaddr_to_paddr() may return either a physical address
or a machine address:

1. If the return value is calculated directly (by subtracting direct
   mapping offset, or by consulting ELF headers), then it is a guest
   physical address (as seen by the Linux kernel).

2. If the return value is taken from page tables, then it is a machine
   address (as seen by the CPU).

Interestingly, makedumpfile never uses guest physical addresses, except
in __exclude_unnecessary_pages(), which already performs the required
ptom conversion explicitly.

So, the best solution is to treat PADDR as "the address seen by the CPU"
(be it on bare metal or under Xen) and get rid of MADDR_XEN. For addresses
that are translated directly, vaddr_to_paddr() return value must be
converted using ptom_xen(), but this call is in fact merely moved from
readmem().

This patch has been tested on a few bare metal and Xen dumps (x86_64 and
x86).

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 arch/ia64.c    |  8 +++++---
 arch/x86.c     | 19 +++++++++++++------
 arch/x86_64.c  | 19 ++++++++++++-------
 makedumpfile.c | 45 ++++++++-------------------------------------
 makedumpfile.h |  2 +-
 5 files changed, 39 insertions(+), 54 deletions(-)

diff --git a/arch/ia64.c b/arch/ia64.c
index e629f94..6c33cc7 100644
--- a/arch/ia64.c
+++ b/arch/ia64.c
@@ -243,6 +243,8 @@ vtop_ia64(unsigned long vaddr)
 	if (!is_vmalloc_addr_ia64(vaddr)) {
 		paddr = vaddr - info->kernel_start +
 			(info->phys_base & KERNEL_TR_PAGE_MASK);
+		if (is_xen_memory())
+			paddr = ptom_xen(paddr);
 		return paddr;
 	}
 
@@ -301,7 +303,7 @@ kvtop_xen_ia64(unsigned long kvaddr)
 
 	dirp = SYMBOL(frametable_pg_dir) - DIRECTMAP_VIRT_START;
 	dirp += ((addr >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1)) * sizeof(unsigned long long);
-	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
+	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
 		return NOT_PADDR;
 
 	dirp = entry & _PFN_MASK;
@@ -309,7 +311,7 @@ kvtop_xen_ia64(unsigned long kvaddr)
 		return NOT_PADDR;
 
 	dirp += ((addr >> PMD_SHIFT) & (PTRS_PER_PMD - 1)) * sizeof(unsigned long long);
-	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
+	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
 		return NOT_PADDR;
 
 	dirp = entry & _PFN_MASK;
@@ -317,7 +319,7 @@ kvtop_xen_ia64(unsigned long kvaddr)
 		return NOT_PADDR;
 
 	dirp += ((addr >> PAGESHIFT()) & (PTRS_PER_PTE - 1)) * sizeof(unsigned long long);
-	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
+	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
 		return NOT_PADDR;
 
 	if (!(entry & _PAGE_P))
diff --git a/arch/x86.c b/arch/x86.c
index 1b4d2b6..3fdae93 100644
--- a/arch/x86.c
+++ b/arch/x86.c
@@ -233,8 +233,11 @@ vaddr_to_paddr_x86(unsigned long vaddr)
 {
 	unsigned long long paddr;
 
-	if ((paddr = vtop_x86_remap(vaddr)) != NOT_PADDR)
+	if ((paddr = vtop_x86_remap(vaddr)) != NOT_PADDR) {
+		if (is_xen_memory())
+			paddr = ptom_xen(paddr);
 		return paddr;
+	}
 
 	if ((paddr = vaddr_to_paddr_general(vaddr)) != NOT_PADDR)
 		return paddr;
@@ -247,8 +250,12 @@ vaddr_to_paddr_x86(unsigned long vaddr)
 		ERRMSG("Can't get necessary information for vmalloc translation.\n");
 		return NOT_PADDR;
 	}
-	if (!is_vmalloc_addr_x86(vaddr))
-		return (vaddr - info->kernel_start);
+	if (!is_vmalloc_addr_x86(vaddr)) {
+		paddr = vaddr - info->kernel_start;
+		if (is_xen_memory())
+			paddr = ptom_xen(paddr);
+		return paddr;
+	}
 
 	if (vt.mem_flags & MEMORY_X86_PAE) {
 		paddr = vtop_x86_PAE(vaddr);
@@ -280,7 +287,7 @@ kvtop_xen_x86(unsigned long kvaddr)
 	if ((dirp = kvtop_xen_x86(SYMBOL(pgd_l3))) == NOT_PADDR)
 		return NOT_PADDR;
 	dirp += pgd_index_PAE(kvaddr) * sizeof(unsigned long long);
-	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
+	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
 		return NOT_PADDR;
 
 	if (!(entry & _PAGE_PRESENT))
@@ -288,7 +295,7 @@ kvtop_xen_x86(unsigned long kvaddr)
 
 	dirp = entry & ENTRY_MASK;
 	dirp += pmd_index(kvaddr) * sizeof(unsigned long long);
-	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
+	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
 		return NOT_PADDR;
 
 	if (!(entry & _PAGE_PRESENT))
@@ -301,7 +308,7 @@ kvtop_xen_x86(unsigned long kvaddr)
 
 	dirp = entry & ENTRY_MASK;
 	dirp += pte_index(kvaddr) * sizeof(unsigned long long);
-	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
+	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
 		return NOT_PADDR;
 
 	if (!(entry & _PAGE_PRESENT)) {
diff --git a/arch/x86_64.c b/arch/x86_64.c
index e978a36..daa2e86 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -112,7 +112,7 @@ get_machdep_info_x86_64(void)
 		ERRMSG("Can't get p2m_mfn address.\n");
 		return FALSE;
 	}
-	if (!readmem(MADDR_XEN, pfn_to_paddr(p2m_mfn),
+	if (!readmem(PADDR, pfn_to_paddr(p2m_mfn),
 		     &frame_mfn, PAGESIZE())) {
 		ERRMSG("Can't read p2m_mfn.\n");
 		return FALSE;
@@ -126,7 +126,7 @@ get_machdep_info_x86_64(void)
 		if (!frame_mfn[i])
 			break;
 
-		if (!readmem(MADDR_XEN, pfn_to_paddr(frame_mfn[i]), &buf,
+		if (!readmem(PADDR, pfn_to_paddr(frame_mfn[i]), &buf,
 		    PAGESIZE())) {
 			ERRMSG("Can't get frame_mfn[%d].\n", i);
 			return FALSE;
@@ -154,7 +154,7 @@ get_machdep_info_x86_64(void)
 		if (!frame_mfn[i])
 			break;
 
-		if (!readmem(MADDR_XEN, pfn_to_paddr(frame_mfn[i]),
+		if (!readmem(PADDR, pfn_to_paddr(frame_mfn[i]),
 		    &info->p2m_mfn_frame_list[i * MFNS_PER_FRAME],
 		    mfns[i] * sizeof(unsigned long))) {
 			ERRMSG("Can't get p2m_mfn_frame_list.\n");
@@ -211,6 +211,11 @@ vtop4_x86_64(unsigned long vaddr)
 	 * Get PGD.
 	 */
 	page_dir = SYMBOL(init_level4_pgt) - __START_KERNEL_map + info->phys_base;
+	if (is_xen_memory()) {
+		page_dir = ptom_xen(page_dir);
+		if (page_dir == NOT_PADDR)
+			return NOT_PADDR;
+	}
 	page_dir += pml4_index(vaddr) * sizeof(unsigned long);
 	if (!readmem(PADDR, page_dir, &pml4, sizeof pml4)) {
 		ERRMSG("Can't get pml4 (page_dir:%lx).\n", page_dir);
@@ -303,7 +308,7 @@ kvtop_xen_x86_64(unsigned long kvaddr)
 	if ((dirp = kvtop_xen_x86_64(SYMBOL(pgd_l4))) == NOT_PADDR)
 		return NOT_PADDR;
 	dirp += pml4_index(kvaddr) * sizeof(unsigned long long);
-	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
+	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
 		return NOT_PADDR;
 
 	if (!(entry & _PAGE_PRESENT))
@@ -311,7 +316,7 @@ kvtop_xen_x86_64(unsigned long kvaddr)
 
 	dirp = entry & ENTRY_MASK;
 	dirp += pgd_index(kvaddr) * sizeof(unsigned long long);
-	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
+	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
 		return NOT_PADDR;
 
 	if (!(entry & _PAGE_PRESENT))
@@ -323,7 +328,7 @@ kvtop_xen_x86_64(unsigned long kvaddr)
 
 	dirp = entry & ENTRY_MASK;
 	dirp += pmd_index(kvaddr) * sizeof(unsigned long long);
-	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
+	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
 		return NOT_PADDR;
 
 	if (!(entry & _PAGE_PRESENT))
@@ -335,7 +340,7 @@ kvtop_xen_x86_64(unsigned long kvaddr)
 
 	dirp = entry & ENTRY_MASK;
 	dirp += pte_index(kvaddr) * sizeof(unsigned long long);
-	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
+	if (!readmem(PADDR, dirp, &entry, sizeof(entry)))
 		return NOT_PADDR;
 
 	if (!(entry & _PAGE_PRESENT)) {
diff --git a/makedumpfile.c b/makedumpfile.c
index 301772a..954a772 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -149,7 +149,7 @@ ptom_xen(unsigned long long paddr)
 	}
 	maddr = pfn_to_paddr(info->p2m_mfn_frame_list[mfn_idx])
 		+ sizeof(unsigned long) * frame_idx;
-	if (!readmem(MADDR_XEN, maddr, &mfn, sizeof(mfn))) {
+	if (!readmem(PADDR, maddr, &mfn, sizeof(mfn))) {
 		ERRMSG("Can't get mfn.\n");
 		return NOT_PADDR;
 	}
@@ -211,7 +211,7 @@ get_dom0_mapnr()
 		unsigned i;
 
 		maddr = pfn_to_paddr(info->p2m_mfn_frame_list[mfn_idx]);
-		if (!readmem(MADDR_XEN, maddr, &mfns, sizeof(mfns))) {
+		if (!readmem(PADDR, maddr, &mfns, sizeof(mfns))) {
 			ERRMSG("Can't read %ld domain-0 mfns at 0x%llu\n",
 				(long)MFNS_PER_FRAME, maddr);
 			return FALSE;
@@ -924,7 +924,7 @@ int
 readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size)
 {
 	size_t read_size, size_orig = size;
-	unsigned long long paddr, maddr = NOT_PADDR;
+	unsigned long long paddr;
 	unsigned long long pgaddr;
 	void *pgbuf;
 	struct cache_entry *cached;
@@ -937,25 +937,9 @@ next_page:
 			    addr);
 			goto error;
 		}
-		if (is_xen_memory()) {
-			if ((maddr = ptom_xen(paddr)) == NOT_PADDR) {
-				ERRMSG("Can't convert a physical address(%llx) to machine address.\n",
-				    paddr);
-				return FALSE;
-			}
-			paddr = maddr;
-		}
 		break;
 	case PADDR:
 		paddr = addr;
-		if (is_xen_memory()) {
-			if ((maddr  = ptom_xen(paddr)) == NOT_PADDR) {
-				ERRMSG("Can't convert a physical address(%llx) to machine address.\n",
-				    paddr);
-				return FALSE;
-			}
-			paddr = maddr;
-		}
 		break;
 	case VADDR_XEN:
 		if ((paddr = kvtop_xen(addr)) == NOT_PADDR) {
@@ -964,9 +948,6 @@ next_page:
 			goto error;
 		}
 		break;
-	case MADDR_XEN:
-		paddr = addr;
-		break;
 	default:
 		ERRMSG("Invalid address type (%d).\n", type_addr);
 		goto error;
@@ -5493,18 +5474,10 @@ exclude_zero_pages_cyclic(struct cycle *cycle)
 		if (!is_dumpable(info->bitmap2, pfn, cycle))
 			continue;
 
-		if (is_xen_memory()) {
-			if (!readmem(MADDR_XEN, paddr, buf, info->page_size)) {
-				ERRMSG("Can't get the page data(pfn:%llx, max_mapnr:%llx).\n",
-				    pfn, info->max_mapnr);
-				return FALSE;
-			}
-		} else {
-			if (!readmem(PADDR, paddr, buf, info->page_size)) {
-				ERRMSG("Can't get the page data(pfn:%llx, max_mapnr:%llx).\n",
-				    pfn, info->max_mapnr);
-				return FALSE;
-			}
+		if (!readmem(PADDR, paddr, buf, info->page_size)) {
+			ERRMSG("Can't get the page data(pfn:%llx, max_mapnr:%llx).\n",
+			    pfn, info->max_mapnr);
+			return FALSE;
 		}
 		if (is_zero_page(buf, info->page_size)) {
 			if (clear_bit_on_2nd_bitmap(pfn, cycle))
@@ -7145,11 +7118,9 @@ int
 read_pfn(mdf_pfn_t pfn, unsigned char *buf)
 {
 	unsigned long long paddr;
-	int type_addr;
 
 	paddr = pfn_to_paddr(pfn);
-	type_addr = is_xen_memory() ? MADDR_XEN : PADDR;
-	if (!readmem(type_addr, paddr, buf, info->page_size)) {
+	if (!readmem(PADDR, paddr, buf, info->page_size)) {
 		ERRMSG("Can't get the page data.\n");
 		return FALSE;
 	}
diff --git a/makedumpfile.h b/makedumpfile.h
index e32e567..1158487 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -130,7 +130,6 @@ enum {
 	VADDR,
 	PADDR,
 	VADDR_XEN,
-	MADDR_XEN
 };
 
 /*
@@ -2151,6 +2150,7 @@ mdf_pfn_t get_num_dumpable_cyclic(void);
 mdf_pfn_t get_num_dumpable_cyclic_withsplit(void);
 int get_loads_dumpfile_cyclic(void);
 int initial_xen(void);
+unsigned long long ptom_xen(unsigned long long paddr);
 unsigned long long get_free_memory_size(void);
 int calculate_cyclic_buffer_size(void);
 int prepare_splitblock_table(void);
-- 
2.12.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

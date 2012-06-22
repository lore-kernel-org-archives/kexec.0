Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Si687-0006Ik-TR
 for kexec@lists.infradead.org; Fri, 22 Jun 2012 15:50:41 +0000
Received: from sanpedro.osd.mch.fsc.net (sanpedro.osd.mch.fsc.net
 [172.17.20.6])
 by sanpedro.mch.fsc.net (Postfix) with ESMTP id C6C279680A7
 for <kexec@lists.infradead.org>; Fri, 22 Jun 2012 17:50:37 +0200 (CEST)
From: Norbert Trapp <Norbert.Trapp@ts.fujitsu.com>
Subject: [PATCH 3/3] makedumpfile: Xen4: exclude Xen user domain pages for Xen4
Date: Fri, 22 Jun 2012 17:50:37 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <201206221750.37729.Norbert.Trapp@ts.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

use a faster way to go through the page table for determining the
domU pages and add 1GB page discovery. Cannot use info->dom0_mapnr
because max_pfn symbol is not in kcore note. Add exclude_xen4_user_domain
function in makedumpfile.c with lots of DEBUG_MSG calls for testing.

Signed-off-by: Norbert Trapp <norbert.trapp@ts.fujitsu.com>
---
 arch/x86_64.c  |  139 +++++++++++++++++++++--------
 makedumpfile.c |  272 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 371 insertions(+), 40 deletions(-)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index da61fd8..a44da09 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -329,61 +329,108 @@ is_direct(unsigned long kvaddr, unsigned long long *entry)
 /*
  * for Xen extraction
  */
+char *pml4_page;
+char *pgd_page;
+char *pmd_page;
+char *pte_page;
+
+int pml4_page_read = 0;
+unsigned long long last_pgd_read = 0;
+unsigned long long last_pmd_read = 0;
+unsigned long long last_pte_read = 0;
+
 unsigned long long
 kvtop_xen_x86_64(unsigned long kvaddr)
 {
-	unsigned long long dirp, entry;
-
-	if (!is_xen_vaddr(kvaddr))
-		return NOT_PADDR;
-
+	unsigned long long entry = 0;
+	unsigned long long pml4_entry, pml4_dirp;
+	unsigned long long pgd_entry, pgd_dirp;
+	unsigned long long pmd_entry, pmd_dirp;
+	unsigned long long pgd_idx = 0;
+	unsigned long pml4_idx = 0;
+	unsigned long pmd_idx = 0;
+	int reason;
+
+	if (!is_xen_vaddr(kvaddr)) {
+		reason = 1;
+		goto not_paddr;
+	}
 	if (is_xen_text(kvaddr, &entry))
 		return entry;
-
 	if (is_direct(kvaddr, &entry))
 		return entry;
+	pml4_idx = pml4_index(kvaddr);
+	if (pml4_page_read == 0) {
+		if (!readmem(MADDR_XEN, kvtop_xen_x86_64(SYMBOL(pgd_l4)), pml4_page, PAGESIZE())) {
+			reason = 2;
+			goto not_paddr;
+		}
+		pml4_page_read = 1;
+	}
+	pml4_entry = *(unsigned long long *)(pml4_page + pml4_idx * sizeof(unsigned long long));
 
-	if ((dirp = kvtop_xen_x86_64(SYMBOL(pgd_l4))) == NOT_PADDR)
-		return NOT_PADDR;
-	dirp += pml4_index(kvaddr) * sizeof(unsigned long long);
-	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
-		return NOT_PADDR;
-
-	if (!(entry & _PAGE_PRESENT))
-		return NOT_PADDR;
-
-	dirp = entry & ENTRY_MASK;
-	dirp += pgd_index(kvaddr) * sizeof(unsigned long long);
-	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
-		return NOT_PADDR;
-
-	if (!(entry & _PAGE_PRESENT))
-		return NOT_PADDR;
-
-	dirp = entry & ENTRY_MASK;
-	dirp += pmd_index(kvaddr) * sizeof(unsigned long long);
-	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
-		return NOT_PADDR;
+	if (!(pml4_entry & _PAGE_PRESENT)) {
+		reason = 3;
+		goto not_paddr;
+	}
+	pml4_dirp = pml4_entry & ENTRY_MASK;
+	if (pml4_dirp != last_pgd_read) {
+		if (!readmem(MADDR_XEN, pml4_dirp, pgd_page, PAGESIZE())) {
+			reason = 4;
+			goto not_paddr;
+		}
+		last_pgd_read = pml4_dirp;
+	}
+	pgd_idx = pgd_index(kvaddr);
+	pgd_entry = *(unsigned long long *)(pgd_page + pgd_idx * sizeof(unsigned long long));
+	if (!(pgd_entry & _PAGE_PRESENT)) {
+		reason = 5;
+		goto not_paddr;
+	}
+	if (pgd_entry & _PAGE_PSE) { // 1GB page
+		pgd_entry = (pgd_entry & ENTRY_MASK) + (kvaddr & ((1UL << PGDIR_SHIFT) - 1));
+		return pgd_entry;
+	}
+	pgd_dirp = pgd_entry & ENTRY_MASK;
 
-	if (!(entry & _PAGE_PRESENT))
-		return NOT_PADDR;
+	if (pgd_dirp != last_pmd_read) {
+		pmd_dirp = pgd_dirp;
+		if (!readmem(MADDR_XEN, pgd_dirp, pmd_page, PAGESIZE())) {
+			reason = 6;
+			goto not_paddr;
+		}
+		last_pmd_read = pgd_dirp;
+	}
+	pmd_idx = pmd_index(kvaddr);
+	pmd_entry = *(unsigned long long *)(pmd_page + pmd_idx * sizeof(unsigned long long));
+	if (!(pmd_entry & _PAGE_PRESENT)) {
+		reason = 7;
+		goto not_paddr;
+	}
 
-	if (entry & _PAGE_PSE) {
-		entry = (entry & ENTRY_MASK) + (kvaddr & ((1UL << PMD_SHIFT) - 1));
-		return entry;
+	if (pmd_entry & _PAGE_PSE) { // 2MB page
+		return (PAGEBASE(pmd_entry) & ENTRY_MASK) + (kvaddr & ~_2MB_PAGE_MASK);
 	}
-	dirp = entry & ENTRY_MASK;
-	dirp += pte_index(kvaddr) * sizeof(unsigned long long);
-	if (!readmem(MADDR_XEN, dirp, &entry, sizeof(entry)))
-		return NOT_PADDR;
+	pmd_dirp = pmd_entry & ENTRY_MASK;
+	if (pmd_dirp != last_pte_read) {
+		if (!readmem(MADDR_XEN, pmd_dirp, pte_page, PAGESIZE())) {
+			reason = 8;
+			goto not_paddr;
+		}
+	}
+	entry = *(unsigned long long *)(pte_page + pte_index(kvaddr) * sizeof(unsigned long long));
 
 	if (!(entry & _PAGE_PRESENT)) {
-		return NOT_PADDR;
+		reason = 9;
+		goto not_paddr;
 	}
 
 	entry = (entry & ENTRY_MASK) + (kvaddr & ((1UL << PTE_SHIFT) - 1));
-
 	return entry;
+not_paddr:
+	DEBUG_MSG("kvtop_xen: NOT_PADDR page 0x%llx from kavaddr: 0x%lx reason: %d\n",
+		entry, kvaddr, reason);
+	return NOT_PADDR;
 }
 
 int get_xen_info_x86_64(void)
@@ -396,6 +443,22 @@ int get_xen_info_x86_64(void)
 		ERRMSG("Can't get pml4.\n");
 		return FALSE;
 	}
+	if ((pml4_page = (char *)malloc(PAGESIZE())) == NULL) {
+		ERRMSG("Can't malloc pml4_page.\n");
+		return FALSE;
+	}
+	if ((pgd_page = (char *)malloc(PAGESIZE())) == NULL) {
+		ERRMSG("Can't malloc pgd_page.\n");
+		return FALSE;
+	}
+	if ((pmd_page = (char *)malloc(PAGESIZE())) == NULL) {
+		ERRMSG("Can't malloc pmd_page.\n");
+		return FALSE;
+	}
+	if ((pte_page = (char *)malloc(PAGESIZE())) == NULL) {
+		ERRMSG("Can't malloc pte_page.\n");
+		return FALSE;
+	}
 
 	if (SYMBOL(frame_table) == NOT_FOUND_SYMBOL) {
 		if (info->elf_machine != EM_X86_64) {
diff --git a/makedumpfile.c b/makedumpfile.c
index 7398f17..aa15622 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2430,7 +2430,7 @@ get_mem_map(void)
 {
 	int ret;
 
-	if (is_xen_memory()) {
+	if (is_xen_memory() && (info->xen_major_version < 4)) {
 		if (!get_dom0_mapnr()) {
 			ERRMSG("Can't domain-0 pfn.\n");
 			return FALSE;
@@ -5728,7 +5728,7 @@ is_select_domain(unsigned int id)
 }
 
 int
-exclude_xen_user_domain(void)
+exclude_xen3_user_domain(void)
 {
 	int i;
 	unsigned int count_info, _domain;
@@ -5799,6 +5799,274 @@ exclude_xen_user_domain(void)
 	return TRUE;
 }
 
+/*
+ * defines copied from xen mm.h
+ */
+#define BITS_PER_BYTE (8)
+#define BITS_PER_LONG (BITS_PER_BYTE * sizeof(long))
+#define PG_shift(idx) (BITS_PER_LONG - (idx))
+#define PG_mask(x, idx) (x ## UL << PG_shift(idx))
+#define PGC_xen_heap        PG_mask(1, 2)
+#define PGC_allocated       PG_mask(1, 1)
+#define PGC_state_free      PG_mask(3, 9)
+#define PGC_state           PG_mask(3, 9)
+#define PGC_state_inuse     PG_mask(0, 9)
+#define PGC_broken          PG_mask(1, 7)
+
+int
+exclude_xen4_user_domain(void)
+{
+	int i;
+	unsigned long deleted_pages, total_deleted_pages = 0;
+	unsigned long state_free, total_state_free = 0;
+	unsigned long xen_heap, total_xen_heap = 0;
+	unsigned long allocated, total_allocated = 0;
+	unsigned long selected_domain, total_selected_domain = 0;
+	unsigned long not_selected_domain, total_not_selected_domain = 0;
+	unsigned long not_a_page, total_not_a_page = 0;
+	unsigned long page_not_readable, total_page_not_readable = 0;
+	unsigned long unknown_page_type, total_unknown_page_type = 0;
+	unsigned long not_a_page_offset, total_not_a_page_offset = 0;
+	unsigned long broken_pages, total_broken_pages = 0;
+	unsigned long page_in_use, total_page_in_use = 0;
+	unsigned long count_info;
+	unsigned int  _domain;
+	unsigned long page_info_addr, first_page_info_addr;
+	unsigned long long pfn, prev_pfn, pfn_end;
+	unsigned long long first_pfn;
+	unsigned long long num_pages, total_num_pages, num_pfn_done, num_one_percent_pfn;
+	unsigned long long phys_start, phys_end;
+	unsigned long type_info;
+	char page_info_local[SIZE(page_info)];
+	char *page_info_mem;
+	int page_info_cntr = 0;
+	int retval;
+	unsigned long long paddr;
+	off_t offset = 0;
+	const off_t failed = (off_t)-1;
+	unsigned int num_pt_loads;
+
+	/*
+	 * NOTE: the first half of bitmap is not used for Xen extraction
+	 */
+	first_pfn = 0;
+
+	if ((page_info_mem = (char *)malloc(SIZE(page_info) * 128)) == NULL) {
+		ERRMSG("Can't allocate memory for the page_info memory. %s\n", strerror(errno));
+		return FALSE;
+	}
+	print_progress(PROGRESS_XEN_DOMAIN, 0, 1);
+	DEBUG_MSG("\nmakedumpfile: exclude_xen4_user_domain start\n");
+#ifdef XEN_VIRT_START
+	DEBUG_MSG("XEN_VIRT_START       : 0x%016lx\n", XEN_VIRT_START);
+#endif
+#ifdef XEN_VIRT_END
+	DEBUG_MSG("XEN_VIRT_END         : 0x%016lx\n", XEN_VIRT_END);
+#endif
+	DEBUG_MSG("DIRECTMAP_VIRT_START : 0x%016lx\n", DIRECTMAP_VIRT_START);
+	DEBUG_MSG("DIRECTMAP_VIRT_END   : 0x%016lx\n", DIRECTMAP_VIRT_END);
+#ifdef FRAMETABLE_VIRT_START
+	DEBUG_MSG("FRAMETABLE_VIRT_START: 0x%016lx\n", FRAMETABLE_VIRT_START);
+#endif
+#ifdef FRAMETABLE_VIRT_END
+	DEBUG_MSG("FRAMETABLE_VIRT_END  : 0x%016lx\n", FRAMETABLE_VIRT_END);
+#endif
+#ifdef FRAMETABLE_SIZE
+	DEBUG_MSG("FRAMETABLE_SIZE      : 0x%016lx\n", FRAMETABLE_SIZE);
+#endif
+	DEBUG_MSG("frame_table_vaddr    : 0x%016lx\n", info->frame_table_vaddr);
+	DEBUG_MSG("SIZE(page_info)      : 0x%016lx\n", SIZE(page_info));
+	DEBUG_MSG("PAGESIZE()           : 0x%016lx\n", PAGESIZE());
+	num_pfn_done = 0;
+	total_num_pages = 0;
+	num_pt_loads = get_num_pt_loads();
+
+	DEBUG_MSG("exclude_xen4_user_domain: %d memory LOAD sections\n", num_pt_loads);
+	DEBUG_MSG("section phys_start   phys_end pfn_start  pfn_end  num_pfn\n");
+	for (i = 0; i < num_pt_loads; i++) {
+		get_pt_load(i, &phys_start, &phys_end, NULL, NULL);
+		pfn     = paddr_to_pfn(phys_start);
+		pfn_end = paddr_to_pfn(phys_end);
+		total_num_pages += pfn_end - pfn;
+		DEBUG_MSG("%3d 0x%016llx 0x%016llx %10llu %10llu %10llu\n",
+			i, phys_start, phys_end, pfn, pfn_end, pfn_end - pfn);
+	}
+	DEBUG_MSG("exclude_xen4_user_domain total_num_pages: %llu\n", total_num_pages);
+	DEBUG_MSG("exclude_xen4_user_domain total size of pages: 0x%llx\n", total_num_pages * SIZE(page_info));
+	num_one_percent_pfn = total_num_pages / 100;
+	paddr = 0;
+	for (i = 0; i < num_pt_loads; i++) {
+		get_pt_load(i, &phys_start, &phys_end, NULL, NULL);
+		pfn     = paddr_to_pfn(phys_start);
+		pfn_end = paddr_to_pfn(phys_end);
+		num_pages    = pfn_end - pfn;
+		page_info_cntr = 0;
+		first_page_info_addr = info->frame_table_vaddr + pfn * SIZE(page_info);
+		deleted_pages = 0;
+		state_free = 0;
+		page_in_use = 0;
+		xen_heap = 0;
+		allocated = 0;
+		selected_domain = 0;
+		not_selected_domain = 0;
+		not_a_page = 0;
+		not_a_page_offset = 0;
+		page_not_readable = 0;
+		unknown_page_type = 0;
+		broken_pages = 0;
+
+		DEBUG_MSG("exclude_xen4_user_domain: i: %d/%d pfn_start: 0x%llx pfn_end: 0x%llx num_pfn: %llu\n",
+			i, num_pt_loads, pfn, pfn_end, pfn_end - pfn);
+		while (pfn < pfn_end) {
+			num_pfn_done++;
+			if (((message_level & ML_PRINT_DEBUG_MSG) == 0) && ((num_pfn_done % num_one_percent_pfn) == 0)) {
+				print_progress(PROGRESS_XEN_DOMAIN, num_pfn_done, total_num_pages);
+			}
+			page_info_addr = info->frame_table_vaddr + pfn * SIZE(page_info);
+			retval = TRUE;
+			while (1 == 1) {
+				paddr = kvtop_xen(page_info_addr);
+				if (paddr == NOT_PADDR) {
+					ERRMSG("NOT a physical address(%llx) for pfn %llu\n", paddr, pfn);
+					not_a_page++;
+					retval = FALSE;
+					break;
+				}
+				if (!(offset = paddr_to_offset(paddr))) {
+					ERRMSG("Can't convert a physical address(%llx) to offset.\n", paddr);
+					not_a_page_offset++;
+					retval = FALSE;
+					break;
+				}
+				if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
+					ERRMSG("Can't seek the dump memory(%s). %s\n", info->name_memory, strerror(errno));
+					page_not_readable++;
+					retval = FALSE;
+					break;
+				}
+				if (read(info->fd_memory, page_info_local, SIZE(page_info)) != SIZE(page_info)) {
+					ERRMSG("Can't read the dump memory(%s). %s\n", info->name_memory, strerror(errno));
+					page_not_readable++;
+					retval = FALSE;
+					break;
+				}
+				retval = TRUE;
+				break;
+			}
+			if (retval == FALSE) {
+				ERRMSG("retval == False\n");
+				deleted_pages++;
+				clear_bit_on_2nd_bitmap(pfn);
+				pfn++;
+				continue;
+			}
+			count_info = *((unsigned long *)(page_info_local + OFFSET(page_info.count_info)));
+			_domain = *((unsigned int *)(page_info_local + OFFSET(page_info._domain)));
+			type_info = *((unsigned long *)(page_info_local + 0x10));
+			if (count_info & PGC_xen_heap) {
+				xen_heap++;
+				pfn++;
+				continue;
+			}
+			if (count_info & PGC_allocated) {
+				allocated++;
+				if (_domain == 0) {
+					pfn++;
+					continue;
+				}
+				if (is_select_domain(_domain)) {
+					selected_domain++;
+					pfn++;
+					continue;
+				} else {
+					not_selected_domain++;
+					prev_pfn = pfn;
+					clear_bit_on_2nd_bitmap(pfn);
+					pfn++;
+					deleted_pages++;
+					continue;
+				}
+			}
+			if ((count_info & PGC_state) == PGC_state_inuse) {
+				page_in_use++;
+				pfn++;
+				continue;
+			}
+			if ((count_info & PGC_state) == PGC_state_free) {
+				state_free++;
+				clear_bit_on_2nd_bitmap(pfn);
+				pfn++;
+				deleted_pages++;
+				continue;
+			}
+			if (count_info & PGC_broken) {
+				clear_bit_on_2nd_bitmap(pfn);
+				pfn++;
+				broken_pages++;
+				deleted_pages++;
+				continue;
+			}
+			unknown_page_type++;
+			//clear_bit_on_2nd_bitmap(pfn);
+			pfn++;
+		}
+		total_deleted_pages += deleted_pages;
+		total_not_a_page += not_a_page;
+		total_not_a_page_offset += not_a_page_offset;
+		total_state_free += state_free;
+		total_page_in_use += page_in_use;
+		total_xen_heap += xen_heap;
+		total_allocated += allocated;
+		total_selected_domain += selected_domain;
+		total_not_selected_domain += not_selected_domain;
+		total_unknown_page_type += unknown_page_type;
+		total_broken_pages += broken_pages;
+		DEBUG_MSG("deleted pages               : %10lu of %10llu %3llu%%\n",
+			deleted_pages, num_pages, deleted_pages * 100 / num_pages);
+		DEBUG_MSG("       unused page          : %10lu\n", state_free);
+		DEBUG_MSG("       not dom0 domain page : %10lu\n", not_selected_domain);
+		DEBUG_MSG("       page address invalid : %10lu\n", not_a_page);
+		DEBUG_MSG("       not a page offset    : %10lu\n", not_a_page_offset);
+		DEBUG_MSG("       page not readable    : %10lu\n", page_not_readable);
+		DEBUG_MSG("       broken page          : %10lu\n", broken_pages);
+		DEBUG_MSG("saved pages                 : %10llu of %10llu %3llu%%\n",
+			num_pages - deleted_pages, num_pages, (num_pages - deleted_pages) * 100 / num_pages);
+		DEBUG_MSG("       page in use          : %10lu\n", page_in_use);
+		DEBUG_MSG("       xen heap page        : %10lu\n", xen_heap);
+		DEBUG_MSG("       dom0 page            : %10lu\n", selected_domain);
+		DEBUG_MSG("       unknown type page    : %10lu\n", unknown_page_type);
+	}
+	/*
+	 * print [100 %]
+	 */
+	print_progress(PROGRESS_XEN_DOMAIN, 1, 1);
+	DEBUG_MSG("\n");
+	DEBUG_MSG("total deleted pages               : %10lu of %10llu %3llu%%\n",
+		total_deleted_pages, total_num_pages, total_deleted_pages * 100 / total_num_pages);
+	DEBUG_MSG("       total unused page          : %10lu\n", total_state_free);
+	DEBUG_MSG("       total not dom0 domain page : %10lu\n", total_not_selected_domain);
+	DEBUG_MSG("       total page address invalid : %10lu\n", total_not_a_page);
+	DEBUG_MSG("       total not a page offset    : %10lu\n", total_not_a_page_offset);
+	DEBUG_MSG("       total page not readable    : %10lu\n", total_page_not_readable);
+	DEBUG_MSG("       total broken page          : %10lu\n", total_broken_pages);
+	DEBUG_MSG("total saved pages                 : %10llu of %10llu %3llu%%\n",
+		total_num_pages - total_deleted_pages, total_num_pages, (total_num_pages - total_deleted_pages) * 100 / total_num_pages);
+	DEBUG_MSG("       total page in use          : %10lu\n", total_page_in_use);
+	DEBUG_MSG("       total xen heap page        : %10lu\n", total_xen_heap);
+	DEBUG_MSG("       total dom0 page            : %10lu\n", total_selected_domain);
+	DEBUG_MSG("       total unknown type page    : %10lu\n", total_unknown_page_type);
+	return TRUE;
+}
+
+int
+exclude_xen_user_domain(void)
+{
+	if (info->xen_major_version < 4)
+		return exclude_xen3_user_domain();
+	else
+		return exclude_xen4_user_domain();
+}
+
 int
 initial_xen(void)
 {
-- 
1.6.0.2

With kind regards

Norbert Trapp
PDG ES&S SWE OS 6

FUJITSU
Fujitsu Technology Solutions GmbH
Domagkstrasse 28, D-80807 Muenchen, Germany
E-mail: Norbert.Trapp@xxxxxxxxxxxxxx
Web: ts.fujitsu.com
Company details: ts.fujitsu.com/imprint
Please be advised that neither Fujitsu, its affiliates, its employees or agents accept liability for any errors,
omissions or damages caused by delays of receipt or by any virus infection in this message or its attachments,
or which may otherwise arise as a result of this e-mail transmission.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

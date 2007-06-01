Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hu39w-0000qJ-5l
	for kexec@lists.infradead.org; Fri, 01 Jun 2007 05:11:43 -0400
Subject: [RFC] makedumpfile-1.1.4-rc: ia64 DISCONTIGMEM support
Message-Id: <20070601181114oomichi@mail.jp.nec.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Fri, 1 Jun 2007 18:11:14 +0900
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Bernhard Walle <bwalle@suse.de>


Hi,

The attached patch is for the development, and it isn't stable yet.
This patch can be applied to makedumpfile version 1.1.3.
If you find some problems in this patch, please let me know.
If there aren't any problems, I will release a new makedumpfile
by next weekend.

Changelog:
1. Add __FUNCTION__ to ERRMSG.
  The function name is added to ERRMSG.
2. Add ia64_vtop().
  The translation function from a virtual address to a
  physical address is added for ia64.
  The patch was provided by Bernhard Walle.
3. Add ia64 DISCONTIGMEM support.
  A new makedumpfile supports ia64 DISCONTIGMEM.
4. Cleanup README.
  The destination of BUG REPORT is changed to kexec-ml.
  The item REQUIREMENTS is added.
5. Fix DISCONTIGMEM bitmap.
  This patch fixes the problem that it cannot output the part
  of bitmap on DISCONTIGMEM kernel.
6. Fix ELF output with overlapping sections.
  The patch was provided by Bernhard Walle.


Thanks
Ken'ichi Ohmichi


------------------------------------------------------------------------

Signed-off-by: Bernhard Walle <bwalle@suse.de>
Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---

diff -puN backup/v1.1.3/Makefile makedumpfile/Makefile
--- backup/v1.1.3/Makefile	2007-04-13 15:44:55.000000000 +0900
+++ makedumpfile/Makefile	2007-06-01 13:05:24.000000000 +0900
@@ -1,7 +1,7 @@
 # makedumpfile
 
-VERSION=1.1.3
-DATE=13 April 2007
+VERSION=1.1.4-rc
+DATE=01 June 2007
 
 CC	= gcc
 CFLAGS = -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
diff -puN backup/v1.1.3/README makedumpfile/README
--- backup/v1.1.3/README	2007-04-13 15:44:55.000000000 +0900
+++ makedumpfile/README	2007-06-01 13:05:19.000000000 +0900
@@ -3,6 +3,10 @@
  makdumpfile's README
 ======================
 
+* REQUIREMENTS
+  Please download the following library file and install it:
+  - elfutils-0.125.tar.gz
+
 * BUILD & INSTALL
   1.Get the latest makedumpfile from the following site:
     https://sourceforge.net/projects/makedumpfile/
@@ -14,7 +18,7 @@
     # make; make install
 
 * SUPPORTED KERNELS
-  makedumpfile (version 1.1.3) supports the following kernels.
+  makedumpfile (version 1.1.4-rc) supports the following kernels.
 
          |      FLATMEM      |   DISCONTIGMEM    |     SPARSEMEM
          |-------------------+-------------------+-------------------
@@ -22,9 +26,9 @@
   Version| x86| _64|ia64|  64| x86| _64|ia64|  64| x86| _64|ia64|  64
   -------+----+----+----+----+----+----+----+----+----+----+----+----
   2.6.15 | OK | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --
-  2.6.16 | OK | OK | -- |    | -- | OK | -- | -- | -- |    | -- |
+  2.6.16 | OK | OK | -- |    | -- | OK | OK | -- | -- |    | -- |
   2.6.17 | OK | OK | -- |    | -- | OK | -- | -- | -- | OK | -- |
-  2.6.18 | OK | OK | -- | OK | -- | OK |TODO| -- | -- | OK | OK | OK
+  2.6.18 | OK | OK | -- | OK | -- | OK | OK | -- | -- | OK | OK | OK
   2.6.19 | OK | OK | -- | OK | OK | OK |TODO| -- | OK | OK | OK | OK
   2.6.20 | OK | OK | -- | KP | OK | OK |TODO| -- | OK | OK | OK | KP
   21-rc5 | OK | OK | -- | OK | OK | OK |TODO| -- | OK | OK | OK | OK
@@ -41,11 +45,12 @@
 
 * REFERENCES
   https://sourceforge.net/projects/makedumpfile/
-  http://lists.osdl.org/pipermail/fastboot/
+  http://lists.infradead.org/pipermail/kexec/
+  https://lists.linux-foundation.org/pipermail/fastboot/
 
 * BUG REPORT
   If finding some bugs, please send the information to the following:
   Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
   Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>
-  Fastboot-ml <fastboot@lists.osdl.org>
+  kexec-ml <kexec@lists.infradead.org>
 
diff -puN backup/v1.1.3/ia64.c makedumpfile/ia64.c
--- backup/v1.1.3/ia64.c	2007-04-13 15:44:45.000000000 +0900
+++ makedumpfile/ia64.c	2007-05-31 12:03:18.000000000 +0900
@@ -17,6 +17,18 @@
 
 #include "makedumpfile.h"
 
+
+/*
+ *  vmalloc() starting address is either the traditional 0xa000000000000000 or
+ *  bumped up in 2.6 to 0xa000000200000000.
+ */
+int
+is_vmalloc_addr_ia64(struct DumpInfo *info, unsigned long vaddr)
+{
+	return ((vaddr >= info->vmalloc_start) &&
+			(vaddr < (ulong)KERNEL_UNCACHED_BASE));
+}
+
 int
 get_phys_base_ia64(struct DumpInfo *info)
 {
@@ -45,8 +57,231 @@ get_machdep_info_ia64(struct DumpInfo *i
 	info->section_size_bits = _SECTION_SIZE_BITS;
 	info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
 
+	/*
+	 * Get kernel_start and vmalloc_start.
+	 */
+	if (SYMBOL(_stext) == NOT_FOUND_SYMBOL)
+		return FALSE;
+
+	info->kernel_start = SYMBOL(_stext);
+
+	if (VADDR_REGION(info->kernel_start) == KERNEL_VMALLOC_REGION)
+		info->vmalloc_start = info->kernel_start + 4*1024UL*1024UL*1024UL;
+	else
+		info->vmalloc_start = KERNEL_VMALLOC_BASE;
+
+	/*
+	 * Check the pgtable (3 Levels or 4 Levels).
+	 */
+	if (!strncmp(SRCFILE(pud_t), STR_PUD_T_4L, strlen(STR_PUD_T_4L)))
+		info->mem_flags |= MEMORY_PAGETABLE_4L;
+
+	else if (!strncmp(SRCFILE(pud_t), STR_PUD_T_3L, strlen(STR_PUD_T_3L)))
+		info->mem_flags |= MEMORY_PAGETABLE_3L;
+
+	else
+		MSG("Can't distinguish the pgtable.\n");
+
 	return TRUE;
 }
 
+unsigned long
+ia64_vtop3(struct DumpInfo *info, unsigned long long vaddr)
+{
+	unsigned long paddr, temp, page_dir, pgd_pte, page_middle, pmd_pte;
+	unsigned long page_table, pte;
+
+	/*
+	 * Translate a virtual address to a physical address
+	 * by using 3 levels paging.
+	 */
+	if (SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of swapper_pg_dir.\n");
+		return 0x0;
+	}
+
+	/*
+	 * Get PGD
+	 */
+	temp = vaddr & MASK_PGD_3L;
+	temp = temp >> (PGDIR_SHIFT_3L - 3);
+	page_dir = SYMBOL(swapper_pg_dir) + temp;
+	if (!readmem(info, page_dir, &pgd_pte, sizeof pgd_pte)) {
+		ERRMSG("Can't get pgd_pte (page_dir:%lx).\n", page_dir);
+		return 0x0;
+	}
+
+	/*
+	 * Get PMD
+	 */
+	temp = vaddr & MASK_PMD;
+	temp = temp >> (PMD_SHIFT - 3);
+	page_middle = pgd_pte + temp;
+	/*
+	 * Convert physical address to virtual address
+	 */
+	page_middle = paddr_to_vaddr(info, page_middle);
+	if (!readmem(info, page_middle, &pmd_pte, sizeof pmd_pte)) {
+		ERRMSG("Can't get pmd_pte (page_middle:%lx).\n", page_middle);
+		return 0x0;
+	}
+
+	/*
+	 * Get PTE
+	 */
+	temp = vaddr & MASK_PTE;
+	temp = temp >> (PAGE_SHIFT - 3);
+	page_table = pmd_pte + temp;
+	/*
+	 * Convert physical address to virtual address
+	 */
+	page_table = paddr_to_vaddr(info, page_table);
+	if (!readmem(info, page_table, &pte, sizeof pte)) {
+		ERRMSG("Can't get pte (page_table:%lx).\n", page_table);
+		return 0x0;
+	}
+
+	/*
+	 * Get physical address
+	 */
+	temp = vaddr & MASK_POFFSET;
+	paddr = (pte & _PAGE_PPN_MASK) + temp;
+
+	return paddr;
+}
+
+unsigned long
+ia64_vtop4(struct DumpInfo *info, unsigned long long vaddr)
+{
+	unsigned long paddr, temp, page_dir, pgd_pte, page_upper, pud_pte;
+	unsigned long page_middle, pmd_pte, page_table, pte;
+
+	/*
+	 * Translate a virtual address to a physical address
+	 * by using 4 levels paging.
+	 */
+	if (SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of swapper_pg_dir.\n");
+		return 0x0;
+	}
+
+	/*
+	 * Get PGD
+	 */
+	temp = vaddr & MASK_PGD_4L;
+	temp = temp >> (PGDIR_SHIFT_4L - 3);
+	page_dir = SYMBOL(swapper_pg_dir) + temp;
+	if (!readmem(info, page_dir, &pgd_pte, sizeof pgd_pte)) {
+		ERRMSG("Can't get pgd_pte (page_dir:%lx).\n", page_dir);
+		return 0x0;
+	}
+
+	/*
+	 * Get PUD
+	 */
+	temp = vaddr & MASK_PUD;
+	temp = temp >> (PUD_SHIFT - 3);
+	page_upper = pgd_pte + temp;
+	/*
+	 * Convert physical address to virtual address
+	 */
+	page_upper = paddr_to_vaddr(info, page_upper);
+	if (!readmem(info, page_upper, &pud_pte, sizeof pud_pte)) {
+		ERRMSG("Can't get pud_pte (page_upper:%lx).\n", page_upper);
+		return 0x0;
+	}
+
+	/*
+	 * Get PMD
+	 */
+	temp = vaddr & MASK_PMD;
+	temp = temp >> (PMD_SHIFT - 3);
+	page_middle = pud_pte + temp;
+	/*
+	 * Convert physical address to virtual address
+	 */
+	page_middle = paddr_to_vaddr(info, page_middle);
+	if (!readmem(info, page_middle, &pmd_pte, sizeof pmd_pte)) {
+		ERRMSG("Can't get pmd_pte (page_middle:%lx).\n", page_middle);
+		return 0x0;
+	}
+
+	/*
+	 * Get PTE
+	 */
+	temp = vaddr & MASK_PTE;
+	temp = temp >> (PAGE_SHIFT - 3);
+	page_table = pmd_pte + temp;
+	/*
+	 * Convert physical address to virtual address
+	 */
+	page_table = paddr_to_vaddr(info, page_table);
+	if (!readmem(info, page_table, &pte, sizeof pte)) {
+		ERRMSG("Can't get pte (page_table:%lx).\n", page_table);
+		return 0x0;
+	}
+
+	/*
+	 * Get physical address
+	 */
+	temp = vaddr & MASK_POFFSET;
+	paddr = (pte & _PAGE_PPN_MASK) + temp;
+
+	return paddr;
+}
+
+unsigned long
+ia64_vtop(struct DumpInfo *info, unsigned long long vaddr)
+{
+	unsigned long paddr;
+
+	if (VADDR_REGION(vaddr) != KERNEL_VMALLOC_REGION) {
+		ERRMSG("vaddr(%llx) is not KERNEL_VMALLOC_REGION.\n", vaddr);
+		return 0x0;
+	}
+	paddr = vaddr_to_paddr(info, vaddr);
+	if (paddr)
+		return paddr;
+
+	if (!is_vmalloc_addr_ia64(info, vaddr)) {
+		paddr = vaddr - info->kernel_start +
+			(info->phys_base & KERNEL_TR_PAGE_MASK);
+		return paddr;
+	}
+
+	if (info->mem_flags & MEMORY_PAGETABLE_4L)
+		return ia64_vtop4(info, vaddr);
+	else
+		return ia64_vtop3(info, vaddr);
+}
+
+/*
+ * Convert Virtual Address to File Offest.
+ */
+off_t
+vaddr_to_offset_ia64(struct DumpInfo *info, unsigned long long vaddr)
+{
+	unsigned long paddr;
+
+	switch (VADDR_REGION(vaddr)) {
+		case KERNEL_CACHED_REGION:
+			paddr = vaddr - (ulong)(KERNEL_CACHED_BASE);
+			break;
+
+		case KERNEL_UNCACHED_REGION:
+			paddr = vaddr - (ulong)(KERNEL_UNCACHED_BASE);
+			break;
+
+		case KERNEL_VMALLOC_REGION:
+			paddr = ia64_vtop(info, vaddr);
+			break;
+
+		default:
+			ERRMSG("Unknown region (%ld)\n", VADDR_REGION(vaddr));
+			return 0x0;
+	}
+	return paddr_to_offset(info, paddr);
+}
+
 #endif /* ia64 */
 
diff -puN backup/v1.1.3/makedumpfile.c makedumpfile/makedumpfile.c
--- backup/v1.1.3/makedumpfile.c	2007-04-13 15:44:55.000000000 +0900
+++ makedumpfile/makedumpfile.c	2007-05-31 12:03:18.000000000 +0900
@@ -16,8 +16,7 @@
 
 /*
  * TODO
- * 1. (ia64) DISCONTIGMEM support.
- * 2. (i386) fill PT_LOAD headers with appropriate virtual addresses.
+ * 1. (i386) fill PT_LOAD headers with appropriate virtual addresses.
  */
 
 #include "makedumpfile.h"
@@ -26,6 +25,7 @@ struct symbol_table	symbol_table;
 struct size_table	size_table;
 struct offset_table	offset_table;
 struct array_table	array_table;
+struct srcfile_table	srcfile_table;
 
 struct dwarf_info	dwarf_info;
 struct vm_table		*vt = 0;
@@ -65,6 +65,71 @@ paddr_to_offset(struct DumpInfo *info, u
 }
 
 /*
+ * Sames as paddr_to_offset() but makes sure that the specified offset (hint)
+ * in the segment.
+ */
+off_t
+paddr_to_offset2(struct DumpInfo *info, unsigned long long paddr, off_t hint)
+{
+	int i;
+	off_t offset;
+	unsigned long long len;
+	struct pt_load_segment *pls;
+
+	for (i = offset = 0; i < info->num_load_memory; i++) {
+		pls = &info->pt_load_segments[i];
+		len = pls->phys_end - pls->phys_start;
+		if ((paddr >= pls->phys_start)
+		    && (paddr < pls->phys_end)
+		    && (hint >= pls->file_offset)
+		    && (hint < pls->file_offset + len)) {
+			offset = (off_t)(paddr - pls->phys_start) +
+				pls->file_offset;
+				break;
+		}
+	}
+	return offset;
+}
+
+unsigned long long
+vaddr_to_paddr(struct DumpInfo *info, unsigned long long vaddr)
+{
+	int i;
+	unsigned long long paddr;
+	struct pt_load_segment *pls;
+
+	for (i = paddr = 0; i < info->num_load_memory; i++) {
+		pls = &info->pt_load_segments[i];
+		if ((vaddr >= pls->virt_start)
+		    && (vaddr < pls->virt_end)) {
+			paddr = (off_t)(vaddr - pls->virt_start) +
+				pls->phys_start;
+				break;
+		}
+	}
+	return paddr;
+}
+
+unsigned long long
+paddr_to_vaddr(struct DumpInfo *info, unsigned long long paddr)
+{
+	int i;
+	unsigned long long vaddr;
+	struct pt_load_segment *pls;
+
+	for (i = vaddr = 0; i < info->num_load_memory; i++) {
+		pls = &info->pt_load_segments[i];
+		if ((paddr >= pls->phys_start)
+		    && (paddr < pls->phys_end)) {
+			vaddr = (off_t)(paddr - pls->phys_start) +
+				pls->virt_start;
+				break;
+		}
+	}
+	return vaddr;
+}
+
+/*
  * Convert Virtual Address to File Offest.
  *  If this function returns 0x0, File Offset isn't found.
  *  The File Offset 0x0 is the ELF header.
@@ -735,6 +800,7 @@ get_elf_info(struct DumpInfo *info)
 	 *   capture(2nd)-kernel, the problem will happen.
 	 */
 	info->page_size = sysconf(_SC_PAGE_SIZE);
+	info->page_shift = ffs(info->page_size) - 1;
 
 	info->max_mapnr = get_max_mapnr(info);
 
@@ -1102,6 +1168,15 @@ is_search_symbol(int cmd)
 		return FALSE;
 }
 
+int
+is_search_srcfile(int cmd)
+{
+	if (cmd == DWARF_INFO_GET_TYPEDEF_SRCNAME)
+		return TRUE;
+	else
+		return FALSE;
+}
+
 static void
 search_structure(Dwarf *dwarfd, Dwarf_Die *die, int *found)
 {
@@ -1151,6 +1226,49 @@ search_structure(Dwarf *dwarfd, Dwarf_Di
 }
 
 static void
+search_srcfile(Dwarf *dwarfd, Dwarf_Die *die, int *found)
+{
+	int tag = 0, rtag = 0;
+	char *src_name = NULL;
+	const char *name;
+
+	switch (dwarf_info.cmd) {
+	case DWARF_INFO_GET_TYPEDEF_SRCNAME:
+		rtag = DW_TAG_typedef;
+		break;
+	}
+
+	/*
+	 * If we get to here then we don't have any more
+	 * children, check to see if this is a relevant tag
+	 */
+	do {
+		tag  = dwarf_tag(die);
+		name = dwarf_diename(die);
+
+		if ((tag != rtag) || (!name)
+		    || strcmp(name, dwarf_info.decl_name))
+			continue;
+
+		src_name = (char *)dwarf_decl_file(die);
+
+		if (!src_name)
+			break;
+
+	} while (!dwarf_siblingof(die, die));
+
+	if (!src_name)
+		return;
+
+	/*
+	 * Found the demanded one.
+	 */
+	strncpy(dwarf_info.src_name, src_name, LEN_SRCFILE);
+
+	*found = TRUE;
+}
+
+static void
 search_symbol(Dwarf *dwarfd, Dwarf_Die *die, int *found)
 {
 	int tag;
@@ -1211,6 +1329,9 @@ search_die_tree(Dwarf *dwarfd, Dwarf_Die
 
 	else if (is_search_symbol(dwarf_info.cmd))
 		search_symbol(dwarfd, die, found);
+
+	else if (is_search_srcfile(dwarf_info.cmd))
+		search_srcfile(dwarfd, die, found);
 }
 
 int
@@ -1351,6 +1472,23 @@ get_array_length(char *name01, char *nam
 	return dwarf_info.array_length;
 }
 
+/*
+ * Get the source filename.
+ */
+int
+get_source_filename(char *decl_name, char *src_name, int cmd)
+{
+	dwarf_info.cmd = cmd;
+	dwarf_info.decl_name = decl_name;
+
+	if (!get_debug_info())
+		return FALSE;
+
+	strncpy(src_name, dwarf_info.src_name, LEN_SRCFILE);
+
+	return TRUE;
+}
+
 int
 get_symbol_info(struct DumpInfo *info)
 {
@@ -1364,6 +1502,7 @@ get_symbol_info(struct DumpInfo *info)
 	SYMBOL_INIT(system_utsname, "system_utsname");
 	SYMBOL_INIT(init_uts_ns, "init_uts_ns");
 	SYMBOL_INIT(_stext, "_stext");
+	SYMBOL_INIT(swapper_pg_dir, "swapper_pg_dir");
 	SYMBOL_INIT(phys_base, "phys_base");
 	SYMBOL_INIT(node_online_map, "node_online_map");
 	SYMBOL_INIT(node_data, "node_data");
@@ -1415,6 +1554,8 @@ get_structure_info(struct DumpInfo *info
 	OFFSET_INIT(pglist_data.node_start_pfn, "pglist_data","node_start_pfn");
 	OFFSET_INIT(pglist_data.node_spanned_pages, "pglist_data",
 	    "node_spanned_pages");
+	OFFSET_INIT(pglist_data.pgdat_next, "pglist_data",
+	    "pgdat_next");
 
 	/*
 	 * Get offsets of the zone's members.
@@ -1443,6 +1584,14 @@ get_structure_info(struct DumpInfo *info
 }
 
 int
+get_srcfile_info(struct DumpInfo *info)
+{
+	TYPEDEF_SRCFILE_INIT(pud_t, "pud_t");
+
+	return TRUE;
+}
+
+int
 is_sparsemem_extreme(struct DumpInfo *info)
 {
 	if (ARRAY_LENGTH(mem_section)
@@ -1462,7 +1611,12 @@ get_mem_type(struct DumpInfo *info)
 	    || (OFFSET(page._count) == NOT_FOUND_STRUCTURE)
 	    || (OFFSET(page.mapping) == NOT_FOUND_STRUCTURE)) {
 		ret = NOT_FOUND_MEMTYPE;
-	} else if ((SYMBOL(node_data) != NOT_FOUND_SYMBOL)
+	} else if ((((SYMBOL(node_data) != NOT_FOUND_SYMBOL)
+	        && (ARRAY_LENGTH(node_data) != NOT_FOUND_STRUCTURE))
+	    || ((SYMBOL(pgdat_list) != NOT_FOUND_SYMBOL)
+	        && (OFFSET(pglist_data.pgdat_next) != NOT_FOUND_STRUCTURE))
+	    || ((SYMBOL(pgdat_list) != NOT_FOUND_SYMBOL)
+	        && (ARRAY_LENGTH(pgdat_list) != NOT_FOUND_STRUCTURE)))
 	    && (SIZE(pglist_data) != NOT_FOUND_STRUCTURE)
 	    && (OFFSET(pglist_data.node_mem_map) != NOT_FOUND_STRUCTURE)
 	    && (OFFSET(pglist_data.node_start_pfn) != NOT_FOUND_STRUCTURE)
@@ -1507,6 +1661,9 @@ generate_config(struct DumpInfo *info)
 	if (!get_structure_info(info))
 		return FALSE;
 
+	if (!get_srcfile_info(info))
+		return FALSE;
+
 	if ((SYMBOL(system_utsname) == NOT_FOUND_SYMBOL)
 	    && (SYMBOL(init_uts_ns) == NOT_FOUND_SYMBOL)) {
 		ERRMSG("Can't get the symbol of system_utsname.\n");
@@ -1539,6 +1696,7 @@ generate_config(struct DumpInfo *info)
 	WRITE_SYMBOL("system_utsname", system_utsname);
 	WRITE_SYMBOL("init_uts_ns", init_uts_ns);
 	WRITE_SYMBOL("_stext", _stext);
+	WRITE_SYMBOL("swapper_pg_dir", swapper_pg_dir);
 	WRITE_SYMBOL("phys_base", phys_base);
 	WRITE_SYMBOL("node_online_map", node_online_map);
 	WRITE_SYMBOL("node_data", node_data);
@@ -1572,6 +1730,8 @@ generate_config(struct DumpInfo *info)
 	    pglist_data.node_start_pfn);
 	WRITE_MEMBER_OFFSET("pglist_data.node_spanned_pages",
 	    pglist_data.node_spanned_pages);
+	WRITE_MEMBER_OFFSET("pglist_data.pgdat_next",
+	    pglist_data.pgdat_next);
 	WRITE_MEMBER_OFFSET("zone.free_pages", zone.free_pages);
 	WRITE_MEMBER_OFFSET("zone.free_area", zone.free_area);
 	WRITE_MEMBER_OFFSET("zone.vm_stat", zone.vm_stat);
@@ -1589,6 +1749,11 @@ generate_config(struct DumpInfo *info)
 
 	WRITE_ARRAY_LENGTH("zone.free_area", zone.free_area);
 
+	/*
+	 * write the source file of 1st kernel
+	 */
+	WRITE_SRCFILE("pud_t", pud_t);
+
 	return TRUE;
 }
 
@@ -1631,6 +1796,7 @@ read_config_basic_info(struct DumpInfo *
 			break;
 	}
 	info->page_size = page_size;
+	info->page_shift = ffs(info->page_size) - 1;
 
 	if (!get_release || !info->page_size) {
 		ERRMSG("Invalid format in %s", info->name_configfile);
@@ -1701,6 +1867,30 @@ read_config_structure(struct DumpInfo *i
 }
 
 int
+read_config_string(struct DumpInfo *info, char *str_in, char *str_out)
+{
+	char buf[BUFSIZE_FGETS];
+	unsigned int i;
+
+	if (fseek(info->file_configfile, 0, SEEK_SET) < 0) {
+		ERRMSG("Can't seek the config file(%s). %s\n",
+		    info->name_configfile, strerror(errno));
+		return FALSE;
+	}
+
+	while (fgets(buf, BUFSIZE_FGETS, info->file_configfile)) {
+		i = strlen(buf);
+		if (buf[i - 1] == '\n')
+			buf[i - 1] = '\0';
+		if (strncmp(buf, str_in, strlen(str_in)) == 0) {
+			strncpy(str_out, buf + strlen(str_in), BUFSIZE_FGETS - strlen(str_in));
+			break;
+		}
+	}
+	return TRUE;
+}
+
+int
 read_config(struct DumpInfo *info)
 {
 	if (!read_config_basic_info(info))
@@ -1713,6 +1903,7 @@ read_config(struct DumpInfo *info)
 	READ_SYMBOL("system_utsname", system_utsname);
 	READ_SYMBOL("init_uts_ns", init_uts_ns);
 	READ_SYMBOL("_stext", _stext);
+	READ_SYMBOL("swapper_pg_dir", swapper_pg_dir);
 	READ_SYMBOL("phys_base", phys_base);
 	READ_SYMBOL("node_online_map", node_online_map);
 	READ_SYMBOL("node_data", node_data);
@@ -1739,6 +1930,8 @@ read_config(struct DumpInfo *info)
 	    pglist_data.node_start_pfn);
 	READ_MEMBER_OFFSET("pglist_data.node_spanned_pages",
 	    pglist_data.node_spanned_pages);
+	READ_MEMBER_OFFSET("pglist_data.pgdat_next",
+	    pglist_data.pgdat_next);
 	READ_MEMBER_OFFSET("zone.free_pages", zone.free_pages);
 	READ_MEMBER_OFFSET("zone.free_area", zone.free_area);
 	READ_MEMBER_OFFSET("zone.vm_stat", zone.vm_stat);
@@ -1752,6 +1945,8 @@ read_config(struct DumpInfo *info)
 	READ_ARRAY_LENGTH("mem_section", mem_section);
 	READ_ARRAY_LENGTH("zone.free_area", zone.free_area);
 
+	READ_SRCFILE("pud_t", pud_t);
+
 	return TRUE;
 }
 
@@ -1837,6 +2032,7 @@ next_online_node(int first)
 unsigned long
 next_online_pgdat(struct DumpInfo *info, int node)
 {
+	int i;
 	unsigned long pgdat;
 
 	/*
@@ -1883,6 +2079,33 @@ pgdat2:
 
 pgdat3:
 	/*
+	 * linux-2.6.16 or before
+	 */
+	if ((SYMBOL(pgdat_list) == NOT_FOUND_SYMBOL)
+	    || (OFFSET(pglist_data.pgdat_next) == NOT_FOUND_STRUCTURE))
+		goto pgdat4;
+
+	if (!readmem(info, SYMBOL(pgdat_list), &pgdat, sizeof pgdat))
+		goto pgdat4;
+
+	if (!is_kvaddr(pgdat))
+		goto pgdat4;
+
+	if (node == 0)
+		return pgdat;
+
+	for (i = 1; i <= node; i++) {
+		if (!readmem(info, pgdat + OFFSET(pglist_data.pgdat_next),
+		    &pgdat, sizeof pgdat))
+			goto pgdat4;
+
+		if (!is_kvaddr(pgdat))
+			goto pgdat4;
+	}
+	return pgdat;
+
+pgdat4:
+	/*
 	 * Get the pglist_data structure from symbol "contig_page_data".
 	 */
 	if (SYMBOL(contig_page_data) == NOT_FOUND_SYMBOL)
@@ -1942,17 +2165,9 @@ get_mm_flatmem(struct DumpInfo *info)
 int
 get_mm_discontigmem(struct DumpInfo *info)
 {
-	int num_nodes, node;
+	int i, j, num_nodes, node, num_mem_map;
 	unsigned long pgdat, mem_map, pfn_start, pfn_end, node_spanned_pages;
-
-	info->num_mem_map = vt->numnodes;
-
-	if ((info->mem_map_data = (struct mem_map_data *)
-	    malloc(sizeof(struct mem_map_data)*info->num_mem_map)) == NULL) {
-		ERRMSG("Can't allocate memory for the mem_map_data. %s\n",
-		    strerror(errno));
-		return FALSE;
-	}
+	struct mem_map_data temp_mmd, mmd[vt->numnodes];
 
 	/*
 	 * Get the first node_id.
@@ -1982,7 +2197,10 @@ get_mm_discontigmem(struct DumpInfo *inf
 			return FALSE;
 		}
 		pfn_end = pfn_start + node_spanned_pages;
-		dump_mem_map(info, pfn_start, pfn_end, mem_map, num_nodes - 1);
+
+		mmd[num_nodes - 1].pfn_start = pfn_start;
+		mmd[num_nodes - 1].pfn_end   = pfn_end;
+		mmd[num_nodes - 1].mem_map   = mem_map;
 
 		/*
 		 * Get pglist_data of the next node.
@@ -1998,6 +2216,79 @@ get_mm_discontigmem(struct DumpInfo *inf
 			}
 		}
 	}
+
+	/*
+	 * Sort mem_map by pfn_start.
+	 */
+	for (i = 0; i < vt->numnodes - 1; i++) {
+		for (j = i + 1; j < vt->numnodes; j++) {
+			if (mmd[j].pfn_start < mmd[i].pfn_start) {
+				temp_mmd = mmd[j];
+				mmd[j] = mmd[i];
+				mmd[i] = temp_mmd;
+			}
+		}
+	}
+
+	/*
+	 * Calculate the number of mem_map.
+	 */
+	info->num_mem_map = vt->numnodes;
+	if (mmd[0].pfn_start != 0)
+		info->num_mem_map++;
+
+	for (i = 0; i < vt->numnodes - 1; i++) {
+		if (mmd[i].pfn_end > mmd[i + 1].pfn_start) {
+			ERRMSG("The mem_map overlapped.\n");
+			ERRMSG("mmd[%d].pfn_end   = %llx\n", i, mmd[i].pfn_end);
+			ERRMSG("mmd[%d].pfn_start = %llx\n", i + 1, mmd[i + 1].pfn_start);
+			return FALSE;
+		} else if (mmd[i].pfn_end == mmd[i + 1].pfn_start)
+			/*
+			 * Continuous mem_map
+			 */
+			continue;
+
+		/*
+		 * Discontinuous mem_map
+		 */
+		info->num_mem_map++;
+	}
+	if (mmd[vt->numnodes - 1].pfn_end != info->max_mapnr)
+		info->num_mem_map++;
+
+	if ((info->mem_map_data = (struct mem_map_data *)
+	    malloc(sizeof(struct mem_map_data)*info->num_mem_map)) == NULL) {
+		ERRMSG("Can't allocate memory for the mem_map_data. %s\n",
+		    strerror(errno));
+		return FALSE;
+	}
+
+	/*
+	 * Create mem_map data.
+	 */
+	num_mem_map = 0;
+	if (mmd[0].pfn_start != 0) {
+		dump_mem_map(info, 0, mmd[0].pfn_start, NOT_MEMMAP_ADDR,
+		    num_mem_map);
+		num_mem_map++;
+	}
+	for (i = 0; i < vt->numnodes; i++) {
+		dump_mem_map(info, mmd[i].pfn_start, mmd[i].pfn_end,
+		    mmd[i].mem_map, num_mem_map);
+		num_mem_map++;
+		if ((i < vt->numnodes - 1)
+		    && (mmd[i].pfn_end != mmd[i + 1].pfn_start)) {
+			dump_mem_map(info, mmd[i].pfn_end, mmd[i +1].pfn_start,
+			    NOT_MEMMAP_ADDR, num_mem_map);
+			num_mem_map++;
+		}
+	}
+	i = vt->numnodes - 1;
+	if (mmd[i].pfn_end != info->max_mapnr)
+		dump_mem_map(info, mmd[i].pfn_end, info->max_mapnr,
+		    NOT_MEMMAP_ADDR, num_mem_map);
+
 	return TRUE;
 }
 
@@ -2205,11 +2496,14 @@ initial(struct DumpInfo *info)
 		}
 		if (!get_structure_info(info))
 			return FALSE;
+
+		if (!get_srcfile_info(info))
+			return FALSE;
 	}
-	if (!check_release(info))
+	if (!get_machdep_info(info))
 		return FALSE;
 
-	if (!get_machdep_info(info))
+	if (!check_release(info))
 		return FALSE;
 
 	if (!get_numnodes(info))
@@ -3382,8 +3676,8 @@ print_progress(unsigned long current, un
 	} else
 		progress = 100;
 
-	ERRMSG("\r");
-	ERRMSG("[%3d %%]", progress);
+	MSG("\r");
+	MSG("[%3d %%]", progress);
 }
 
 int
@@ -3462,7 +3756,6 @@ write_elf_pages(struct DumpInfo *info)
 
 	off_seg_load  = info->offset_load_dumpfile;
 	cd_seg.offset = info->offset_load_dumpfile;
-	off_memory = 0;
 
 	if (info->flag_elf64) { /* ELF64 */
 		cd_hdr.offset = sizeof(Elf64_Ehdr) + sizeof(Elf64_Phdr);
@@ -3488,7 +3781,7 @@ write_elf_pages(struct DumpInfo *info)
 			}
 			if (load64.p_type != PT_LOAD)
 				continue;
-
+			off_memory= load64.p_offset;
 			paddr     = load64.p_paddr;
 			pfn_start = load64.p_paddr / page_size;
 			pfn_end   = (load64.p_paddr+ load64.p_memsz)/page_size;
@@ -3501,6 +3794,7 @@ write_elf_pages(struct DumpInfo *info)
 			}
 			if (load32.p_type != PT_LOAD)
 				continue;
+			off_memory= load32.p_offset;
 			paddr     = load32.p_paddr;
 			pfn_start = load32.p_paddr / page_size;
 			pfn_end   = (load32.p_paddr+ load32.p_memsz)/page_size;
@@ -3588,7 +3882,7 @@ write_elf_pages(struct DumpInfo *info)
 			/*
 			 * Write a PT_LOAD segment.
 			 */
-			off_memory = paddr_to_offset(info, paddr);
+			off_memory = paddr_to_offset2(info, paddr, off_memory);
 			if (!off_memory) {
 				ERRMSG("Can't convert physaddr(%llx) to a offset.\n",
 				    paddr);
@@ -3680,7 +3974,7 @@ write_elf_pages(struct DumpInfo *info)
 		/*
 		 * Write a PT_LOAD segment.
 		 */
-		off_memory = paddr_to_offset(info, paddr);
+		off_memory = paddr_to_offset2(info, paddr, off_memory);
 		if (!off_memory) {
 			ERRMSG("Can't convert physaddr(%llx) to a offset.\n",
 			    paddr);
@@ -4196,7 +4490,7 @@ main(int argc, char *argv[])
 			dwarf_info.vmlinux_name = optarg;
 			break;
 		case '?':
-			ERRMSG("Commandline parameter is invalid.\n");
+			MSG("Commandline parameter is invalid.\n");
 			print_usage();
 			goto out;
 		}
@@ -4214,7 +4508,7 @@ main(int argc, char *argv[])
 		 * Check parameters to generate the configuration file.
 		 */
 		if (argc != optind) {
-			ERRMSG("Commandline parameter is invalid.\n");
+			MSG("Commandline parameter is invalid.\n");
 			print_usage();
 			goto out;
 		}
@@ -4222,7 +4516,7 @@ main(int argc, char *argv[])
 		    || info->flag_elf_dumpfile || info->flag_read_config
 		    || !info->flag_vmlinux || info->flag_flatten
 		    || info->flag_rearrange) {
-			ERRMSG("Commandline parameter is invalid.\n");
+			MSG("Commandline parameter is invalid.\n");
 			print_usage();
 			goto out;
 		}
@@ -4232,13 +4526,13 @@ main(int argc, char *argv[])
 		 */
 		if ((info->dump_level < MIN_DUMP_LEVEL)
 		    || (MAX_DUMP_LEVEL < info->dump_level)) {
-			ERRMSG("Dump_level is invalid.\n");
+			MSG("Dump_level is invalid.\n");
 			print_usage();
 			goto out;
 		}
 		if ((info->flag_compress && info->flag_elf_dumpfile)
 		    || (info->flag_vmlinux && info->flag_read_config)) {
-			ERRMSG("Commandline parameter is invalid.\n");
+			MSG("Commandline parameter is invalid.\n");
 			print_usage();
 			goto out;
 		}
@@ -4270,7 +4564,7 @@ main(int argc, char *argv[])
 			info->name_dumpfile = argv[optind];
 
 		} else {
-			ERRMSG("Commandline parameter is invalid.\n");
+			MSG("Commandline parameter is invalid.\n");
 			print_usage();
 			goto out;
 		}
@@ -4348,11 +4642,11 @@ main(int argc, char *argv[])
 	}
 	retcd = COMPLETED;
 out:
-	ERRMSG("\n");
+	MSG("\n");
 	if (retcd == COMPLETED)
 		MSG("makedumpfile Completed.\n");
 	else
-		ERRMSG("makedumpfile Failed.\n");
+		MSG("makedumpfile Failed.\n");
 
 	if (info->fd_memory)
 		close(info->fd_memory);
diff -puN backup/v1.1.3/makedumpfile.h makedumpfile/makedumpfile.h
--- backup/v1.1.3/makedumpfile.h	2007-04-13 15:44:55.000000000 +0900
+++ makedumpfile/makedumpfile.h	2007-05-31 12:03:18.000000000 +0900
@@ -64,6 +64,12 @@ enum {
 #define LSEEKED_PDESC	(2)
 #define LSEEKED_PDATA	(3)
 
+/*
+ * Memory flags
+ */
+#define MEMORY_PAGETABLE_4L	(1 << 0)
+#define MEMORY_PAGETABLE_3L	(1 << 1)
+
 static inline int
 test_bit(int nr, unsigned long addr)
 {
@@ -268,6 +274,29 @@ do { \
 } while (0)
 
 /*
+ * for source file name
+ */
+#define SRCFILE(X)		(srcfile_table.X)
+#define	TYPEDEF_SRCFILE_INIT(decl_name, str_decl_name) \
+do { \
+	get_source_filename(str_decl_name, SRCFILE(decl_name), DWARF_INFO_GET_TYPEDEF_SRCNAME); \
+} while (0)
+
+#define WRITE_SRCFILE(str_decl_name, decl_name) \
+do { \
+	if (strlen(SRCFILE(decl_name))) { \
+		fprintf(info->file_configfile, "%s%s\n", \
+		    STR_SRCFILE(str_decl_name), SRCFILE(decl_name)); \
+	} \
+} while (0)
+
+#define READ_SRCFILE(str_decl_name, decl_name) \
+do { \
+	if (!read_config_string(info, STR_SRCFILE(str_decl_name), SRCFILE(decl_name))) \
+		return FALSE; \
+} while (0)
+
+/*
  * kernel version
  */
 #define VERSION_2_6_15		(15)
@@ -289,6 +318,7 @@ do { \
 #define STR_SIZE(X)	"SIZE("X")="
 #define STR_OFFSET(X)	"OFFSET("X")="
 #define STR_LENGTH(X)	"LENGTH("X")="
+#define STR_SRCFILE(X)	"SRCFILE("X")="
 
 /*
  * common value
@@ -367,6 +397,37 @@ do { \
 #define _SECTION_SIZE_BITS	(30)
 #define _MAX_PHYSMEM_BITS	(50)
 #define SIZEOF_NODE_ONLINE_MAP	(32)
+
+/*
+ * 3 Levels paging
+ */
+#define _PAGE_PPN_MASK		(((1UL << _MAX_PHYSMEM_BITS) - 1) & ~0xfffUL)
+#define PAGE_SHIFT		(info->page_shift)
+#define PTRS_PER_PTD_SHIFT	(PAGE_SHIFT - 3)
+
+#define PMD_SHIFT		(PAGE_SHIFT + PTRS_PER_PTD_SHIFT)
+#define PGDIR_SHIFT_3L		(PMD_SHIFT  + PTRS_PER_PTD_SHIFT)
+
+#define MASK_POFFSET	((1UL << PAGE_SHIFT) - 1)
+#define MASK_PTE	((1UL << PMD_SHIFT) - 1) &~((1UL << PAGE_SHIFT) - 1)
+#define MASK_PMD	((1UL << PGDIR_SHIFT_3L) - 1) &~((1UL << PMD_SHIFT) - 1)
+#define MASK_PGD_3L	((1UL << REGION_SHIFT) - 1) & (~((1UL << PGDIR_SHIFT_3L) - 1))
+
+/*
+ * 4 Levels paging
+ */
+#define PUD_SHIFT		(PMD_SHIFT + PTRS_PER_PTD_SHIFT)
+#define PGDIR_SHIFT_4L		(PUD_SHIFT + PTRS_PER_PTD_SHIFT)
+
+#define MASK_PUD   	((1UL << REGION_SHIFT) - 1) & (~((1UL << PUD_SHIFT) - 1))
+#define MASK_PGD_4L	((1UL << REGION_SHIFT) - 1) & (~((1UL << PGDIR_SHIFT_4L) - 1))
+
+/*
+ * Key for distinguishing PGTABLE_3L or PGTABLE_4L.
+ */
+#define STR_PUD_T_3L	"include/asm-generic/pgtable-nopud.h"
+#define STR_PUD_T_4L	"include/asm/page.h"
+
 #endif          /* ia64 */
 
 /*
@@ -398,14 +459,20 @@ int get_machdep_info_ppc64();
 #ifdef __ia64__ /* ia64 */
 int get_phys_base_ia64();
 int get_machdep_info_ia64();
+off_t vaddr_to_offset_ia64();
 #define get_machdep_info(X)	get_machdep_info_ia64(X)
 #define get_phys_base(X)	get_phys_base_ia64(X)
-#define vaddr_to_offset(X, Y)	vaddr_to_offset_general(X, Y)
-#define VADDR_REGION(X)		((X) >> REGION_SHIFT)
+#define vaddr_to_offset(X, Y)	vaddr_to_offset_ia64(X, Y)
+#define VADDR_REGION(X)		(((unsigned long)(X)) >> REGION_SHIFT)
 #endif          /* ia64 */
 
 #define MSG(x...)	fprintf(stderr, x)
-#define ERRMSG(x...)	fprintf(stderr, x)
+#define ERRMSG(x...) \
+do { \
+	fprintf(stderr, __FUNCTION__); \
+	fprintf(stderr, ": "); \
+	fprintf(stderr, x); \
+} while (0)
 
 struct pt_load_segment {
 	loff_t			file_offset;
@@ -486,11 +553,14 @@ struct DumpInfo {
 	int		flag_rearrange;      /* flag of creating dumpfile from
 						flattened format */
 	long		page_size;           /* size of page */
+	long		page_shift;
 	unsigned long long	max_mapnr;   /* number of page descriptor */
 	unsigned long   section_size_bits;
 	unsigned long   max_physmem_bits;
 	unsigned long   sections_per_root;
 	unsigned long	phys_base;
+	unsigned long   kernel_start;
+	unsigned long   vmalloc_start;
 
 	/*
 	 * diskdimp info:
@@ -514,6 +584,7 @@ struct DumpInfo {
 	 */
 	unsigned int		num_mem_map;
 	struct mem_map_data	*mem_map_data;
+	unsigned int		mem_flags;
 
 	/*
 	 * Dump memory image info:
@@ -555,6 +626,7 @@ struct symbol_table {
 	unsigned long	system_utsname;
 	unsigned long	init_uts_ns;
 	unsigned long	_stext;
+	unsigned long	swapper_pg_dir;
 	unsigned long	phys_base;
 	unsigned long	node_online_map;
 	unsigned long	node_data;
@@ -593,6 +665,7 @@ struct offset_table {
 		long	node_mem_map;
 		long	node_start_pfn;
 		long	node_spanned_pages;
+		long	pgdat_next;
 	} pglist_data;
 	struct free_area {
 		long	free_list;
@@ -622,10 +695,19 @@ struct array_table {
 	} zone;
 };
 
+#define LEN_SRCFILE				(50)
+struct srcfile_table {
+	/*
+	 * typedef
+	 */
+	char	pud_t[LEN_SRCFILE];
+};
+
 extern struct symbol_table	symbol_table;
 extern struct size_table	size_table;
 extern struct offset_table	offset_table;
 extern struct array_table	array_table;
+extern struct srcfile_table	srcfile_table;
 
 /*
  * Debugging information
@@ -636,6 +718,7 @@ extern struct array_table	array_table;
 #define DWARF_INFO_GET_MEMBER_ARRAY_LENGTH	(4)
 #define DWARF_INFO_GET_SYMBOL_ARRAY_LENGTH	(5)
 #define DWARF_INFO_CHECK_SYMBOL_ARRAY_TYPE	(6)
+#define DWARF_INFO_GET_TYPEDEF_SRCNAME		(7)
 
 struct dwarf_info {
 	unsigned int	cmd;		/* IN */
@@ -644,10 +727,17 @@ struct dwarf_info {
 	char	*struct_name;		/* IN */
 	char	*symbol_name;		/* IN */
 	char	*member_name;		/* IN */
+	char	*decl_name;		/* IN */
 	long	struct_size;		/* OUT */
 	long	member_offset;		/* OUT */
 	long	array_length;		/* OUT */
+	char	src_name[LEN_SRCFILE];	/* OUT */
 };
 
 extern struct dwarf_info	dwarf_info;
 
+int readmem();
+off_t paddr_to_offset();
+unsigned long long vaddr_to_paddr();
+unsigned long long paddr_to_vaddr();
+
_

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

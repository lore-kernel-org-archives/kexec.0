Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HsUKw-0006mC-Sa
	for kexec@lists.infradead.org; Sun, 27 May 2007 21:48:01 -0400
Date: Mon, 28 May 2007 10:49:49 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: [RFC] makedumpfile: xen extraction
Message-Id: <20070528091114.529F.ODA@valinux.co.jp>
MIME-Version: 1.0
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
Cc: oomichi@mxs.nes.nec.co.jp

Hi,

I think the part of xen hypervisor and domain-0 is enough to analyze
a cause of system crash in almost of all cases under xen environment.
Thus extracting the part of xen and domain-0 from /proc/vmcore under
the second kernel is useful to reduce down time.

The attached patch enables makedumpfile to extract the part of xen and
domain-0 from vmcore.
I implemented this function as an option of makedumpfile since many
parts of makedumpfile can be used for implement of this function
and the aim of this function is same as the aim of makedumpfile.

usage: -X option is added for this funtion. -E and "-x xen-syms" must be
       specified with -X.
       "makedumpfile -XE -x xen-syms [-D] vmcore output-vmcore"

This patch is for makedumpfile-1.1.3.

This patch supports x86-PAE and ia64 now.
(x86 and x86_64 is easy to support. I'd like to get feedbacks before
implement many architectures.)

The output-vmcore can be analyzed by "crash" command for both of
xen hypervisor and domain-0.

Your comments are welcome.

Thanks.
Itsuro Oda

-------------------------------------------------------------------------------
Index: Makefile
===================================================================
RCS file: /cvsroot/xen_ia64/people/oda/makedumpfile-1.1.3/Makefile,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -r1.1 -r1.2
--- Makefile	26 Apr 2007 02:32:30 -0000	1.1
+++ Makefile	16 May 2007 04:09:39 -0000	1.2
@@ -6,7 +6,7 @@
 CC	= gcc
 CFLAGS = -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
 	  -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'
-CFLAGS_ARCH	= -g -O2 -Wall
+CFLAGS_ARCH	= -g -O2 -Wall -D_FILE_OFFSET_BITS=64
 
 ARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
 			       -e s/arm.*/arm/ -e s/sa110/arm/ \
Index: ia64.c
===================================================================
RCS file: /cvsroot/xen_ia64/people/oda/makedumpfile-1.1.3/ia64.c,v
retrieving revision 1.1
retrieving revision 1.6
diff -u -r1.1 -r1.6
--- ia64.c	26 Apr 2007 02:32:30 -0000	1.1
+++ ia64.c	27 May 2007 23:46:07 -0000	1.6
@@ -48,5 +48,94 @@
 	return TRUE;
 }
 
+/*
+ * for Xen extraction
+ */
+unsigned long long
+kvtop_xen_ia64(struct DumpInfo *info, unsigned long kvaddr)
+{
+	unsigned long long addr, dirp, entry;
+
+	if (!is_xen_vaddr(kvaddr))
+		return 0;
+
+	if (is_direct(kvaddr))
+		return (unsigned long)kvaddr - DIRECTMAP_VIRT_START;
+
+	if (!is_frame_table_vaddr(kvaddr))
+		return 0;
+
+	addr = kvaddr - VIRT_FRAME_TABLE_ADDR;
+
+	dirp = SYMBOL(frametable_pg_dir) - DIRECTMAP_VIRT_START;
+	dirp += ((addr >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1)) * sizeof(unsigned long long);
+	if (!readpmem(info, dirp, &entry, sizeof(entry)))
+		return FALSE;
+ 
+	dirp = entry & _PFN_MASK;
+	if (!dirp)
+		return 0;
+	dirp += ((addr >> PMD_SHIFT) & (PTRS_PER_PMD - 1)) * sizeof(unsigned long long);
+	if (!readpmem(info, dirp, &entry, sizeof(entry)))
+		return FALSE;
+
+	dirp = entry & _PFN_MASK;
+	if (!dirp)
+		return 0;
+	dirp += ((addr >> PAGESHIFT()) & (PTRS_PER_PTE - 1)) * sizeof(unsigned long long);
+	if (!readpmem(info, dirp, &entry, sizeof(entry)))
+		return FALSE;
+
+	if (!(entry & _PAGE_P))
+		return 0;
+
+	entry = (entry & _PFN_MASK) + (addr & ((1UL << PAGESHIFT()) - 1));
+
+	return entry;
+}
+
+int
+get_xen_info_ia64(struct DumpInfo *info)
+{
+	unsigned long xen_start, xen_end, xen_heap_start;
+	int i;
+
+	info->frame_table_vaddr = VIRT_FRAME_TABLE_ADDR; /* "frame_table" is same value */
+
+	if (SYMBOL(xenheap_phys_end) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
+		return FALSE;
+	}
+	if (!readmem_xen(info, SYMBOL(xenheap_phys_end), &xen_end,
+	      sizeof(xen_end), "Can't get the value of xenheap_phys_end.\n"))
+		return FALSE;
+
+	if (SYMBOL(xen_pstart) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of xen_pstart.\n");
+		return FALSE;
+	}
+	if (!readmem_xen(info, SYMBOL(xen_pstart), &xen_start,
+	      sizeof(xen_start), "Can't get the value of xen_pstart.\n"))
+		return FALSE;
+
+	info->xen_heap_end = (xen_end >> PAGESHIFT());
+	info->xen_heap_start = (xen_start >> PAGESHIFT());
+
+	if (SYMBOL(xen_heap_start) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of xen_heap_start.\n");
+		return FALSE;
+	}
+	if (!readmem_xen(info, SYMBOL(xen_heap_start), &xen_heap_start,
+	      sizeof(xen_heap_start), "Can't get the value of xen_heap_start.\n"))
+		return FALSE;
+
+	for (i = 0; i < info->num_domain; i++) {
+		info->domain_list[i].pickled_id = (unsigned int)
+			(info->domain_list[i].domain_addr - xen_heap_start);
+	}
+
+	return TRUE;
+}
+
 #endif /* ia64 */
 
Index: makedumpfile.c
===================================================================
RCS file: /cvsroot/xen_ia64/people/oda/makedumpfile-1.1.3/makedumpfile.c,v
retrieving revision 1.1
retrieving revision 1.14
diff -u -r1.1 -r1.14
--- makedumpfile.c	26 Apr 2007 02:32:30 -0000	1.1
+++ makedumpfile.c	27 May 2007 23:46:07 -0000	1.14
@@ -108,6 +108,36 @@
 }
 
 int
+readpmem(struct DumpInfo *info, unsigned long long paddr, void *bufptr,
+    size_t size)
+{
+	off_t offset;
+	const off_t failed = (off_t)-1;
+
+	/*
+	 * Convert Physical Address to File Offset.
+	 */
+	if (!(offset = paddr_to_offset(info, paddr))) {
+		ERRMSG("Can't convert a physical address(%llx) to offset.\n",
+		    paddr);
+		return FALSE;
+	}
+	if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
+		ERRMSG("Can't seek the dump memory(%s). %s\n",
+		    info->name_memory, strerror(errno));
+		return FALSE;
+	}
+
+	if (read(info->fd_memory, bufptr, size) != size) {
+		ERRMSG("Can't read the dump memory(%s). %s\n",
+		    info->name_memory, strerror(errno));
+		return FALSE;
+	}
+
+	return size;
+}
+
+int
 readmem(struct DumpInfo *info, unsigned long long vaddr, void *bufptr,
     size_t size)
 {
@@ -4132,6 +4162,395 @@
 	return TRUE;
 }
 
+/*
+ * for Xen extraction
+ */
+int
+get_symbol_info_xen(struct DumpInfo *info)
+{
+	/* common symbol */
+	SYMBOL_INIT(dom_xen, "dom_xen");
+	SYMBOL_INIT(dom_io, "dom_io");
+	SYMBOL_INIT(domain_list, "domain_list");
+	SYMBOL_INIT(frame_table, "frame_table");
+	SYMBOL_INIT(alloc_bitmap, "alloc_bitmap");
+	SYMBOL_INIT(max_page, "max_page");
+	SYMBOL_INIT(xenheap_phys_end, "xenheap_phys_end");
+
+	/* architecture specific */
+	SYMBOL_INIT(pgd_l2, "idle_pg_table_l2");	/* x86 */
+	SYMBOL_INIT(pgd_l3, "idle_pg_table_l3");	/* x86-PAE */
+	SYMBOL_INIT(pgd_l4, "idle_pg_table_4");		/* x86_64 */
+	SYMBOL_INIT(xen_heap_start, "xen_heap_start");	/* ia64 */
+	SYMBOL_INIT(xen_pstart, "xen_pstart");		/* ia64 */
+	SYMBOL_INIT(frametable_pg_dir, "frametable_pg_dir");	/* ia64 */
+
+	return TRUE;
+}
+
+int
+get_structure_info_xen(struct DumpInfo *info)
+{
+	SIZE_INIT(page_info, "page_info");
+	OFFSET_INIT(page_info.count_info, "page_info", "count_info");
+	/* _domain is the first member of union u */
+	OFFSET_INIT(page_info._domain, "page_info", "u");
+
+	SIZE_INIT(domain, "domain");
+	OFFSET_INIT(domain.domain_id, "domain", "domain_id");
+	OFFSET_INIT(domain.next_in_list, "domain", "next_in_list");
+
+	return TRUE;
+}
+
+int
+readmem_xen(struct DumpInfo *info, unsigned long long vaddr, void *bufptr,
+    size_t size, char *errmsg)
+{
+	unsigned long long paddr;
+
+	if (!(paddr = kvtop_xen(info, vaddr)))
+		goto out;
+
+	if (!readpmem(info, paddr, bufptr, size))
+		goto out;
+
+	return size;
+out:
+	if (errmsg)
+		ERRMSG(errmsg);
+
+	return 0;
+}
+
+int
+get_xen_info(struct DumpInfo *info)
+{
+	unsigned long domain;
+	unsigned int domain_id;
+	int num_domain;
+
+	if (SYMBOL(alloc_bitmap) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of alloc_bitmap.\n");
+		return FALSE;
+	}
+        if (!readmem_xen(info, SYMBOL(alloc_bitmap), &info->alloc_bitmap,
+	      sizeof(info->alloc_bitmap), "Can't get the value of alloc_bitmap.\n"))
+		return FALSE;
+
+	if (SYMBOL(max_page) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of max_page.\n");
+		return FALSE;
+	}
+        if (!readmem_xen(info, SYMBOL(max_page), &info->max_page,
+	      sizeof(info->max_page), "Can't get the value of max_page.\n"))
+		return FALSE;
+
+	/* walk through domain_list */
+	if (SYMBOL(domain_list) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of domain_list.\n");
+		return FALSE;
+	}
+	if (!readmem_xen(info, SYMBOL(domain_list), &domain,
+	      sizeof(domain), "Can't get the value of domain_list.\n"))
+		return FALSE;
+
+	/* get numbers of domain first */
+	num_domain = 0;
+	while (domain) {
+		num_domain++;
+		if (!readmem_xen(info, domain + OFFSET(domain.next_in_list),
+		      &domain, sizeof(domain),
+		      "Can't get through the domain_list.\n"))
+			return FALSE;
+	}
+
+	if ((info->domain_list = (struct domain_list *)
+	      malloc(sizeof(struct domain_list) * (num_domain + 2))) == NULL) {
+		ERRMSG("Can't allcate memory for domain_list.\n");
+		return FALSE;
+	}
+
+	info->num_domain = num_domain + 2;
+
+	if (!readmem_xen(info, SYMBOL(domain_list), &domain,
+	      sizeof(domain), "Can't get the value of domain_list.\n"))
+		return FALSE;
+
+	num_domain = 0;
+	while (domain) {
+		if (!readmem_xen(info, domain + OFFSET(domain.domain_id),
+		      &domain_id, sizeof(domain_id),
+		      "Can't get the domain_id.\n"))
+			return FALSE;
+		info->domain_list[num_domain].domain_addr = domain;
+		info->domain_list[num_domain].domain_id = domain_id;
+		/* pickled_id is set by architecture specific */
+		num_domain++;
+
+		if (!readmem_xen(info, domain + OFFSET(domain.next_in_list),
+		      &domain, sizeof(domain),
+		      "Can't get through the domain_list.\n"))
+			return FALSE;
+	}
+
+	/* special domains */
+	if (SYMBOL(dom_xen) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of dom_xen.\n");
+		return FALSE;
+	}
+	if (!readmem_xen(info, SYMBOL(dom_xen), &domain, sizeof(domain),
+	      "Can't get the value of dom_xen.\n"))
+		return FALSE;
+	if (!readmem_xen(info, domain + OFFSET(domain.domain_id), &domain_id,
+	      sizeof(domain_id), "Can't get the value of dom_xen domain_id.\n"))
+		return FALSE;
+	info->domain_list[num_domain].domain_addr = domain;
+	info->domain_list[num_domain].domain_id = domain_id;
+	num_domain++;
+
+	if (SYMBOL(dom_io) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of dom_io.\n");
+		return FALSE;
+	}
+	if (!readmem_xen(info, SYMBOL(dom_io), &domain, sizeof(domain),
+	      "Can't get the value of dom_io.\n"))
+		return FALSE;
+	if (!readmem_xen(info, domain + OFFSET(domain.domain_id), &domain_id,
+	      sizeof(domain_id), "Can't get the value of dom_io domain_id.\n"))
+		return FALSE;
+	info->domain_list[num_domain].domain_addr = domain;
+	info->domain_list[num_domain].domain_id = domain_id;
+	
+	/* get architecture specific data */
+	if (!get_xen_info_arch(info))
+		return FALSE;
+
+	return TRUE;
+}
+
+void
+show_data_xen(struct DumpInfo *info)
+{
+	int i;
+
+	/* show data for debug */
+	MSG("\n");
+	MSG("SYMBOL(dom_xen): %lx\n", SYMBOL(dom_xen));
+	MSG("SYMBOL(dom_io): %lx\n", SYMBOL(dom_io));
+	MSG("SYMBOL(domain_list): %lx\n", SYMBOL(domain_list));
+	MSG("SYMBOL(xen_heap_start): %lx\n", SYMBOL(xen_heap_start));
+	MSG("SYMBOL(frame_table): %lx\n", SYMBOL(frame_table));
+	MSG("SYMBOL(alloc_bitmap): %lx\n", SYMBOL(alloc_bitmap));
+	MSG("SYMBOL(max_page): %lx\n", SYMBOL(max_page));
+	MSG("SYMBOL(pgd_l2): %lx\n", SYMBOL(pgd_l2));
+	MSG("SYMBOL(pgd_l3): %lx\n", SYMBOL(pgd_l3));
+	MSG("SYMBOL(pgd_l4): %lx\n", SYMBOL(pgd_l4));
+	MSG("SYMBOL(xenheap_phys_end): %lx\n", SYMBOL(xenheap_phys_end));
+	MSG("SYMBOL(xen_pstart): %lx\n", SYMBOL(xen_pstart));
+	MSG("SYMBOL(frametable_pg_dir): %lx\n", SYMBOL(frametable_pg_dir));
+
+	MSG("SIZE(page_info): %ld\n", SIZE(page_info));
+	MSG("OFFSET(page_info.count_info): %ld\n", OFFSET(page_info.count_info));
+	MSG("OFFSET(page_info._domain): %ld\n", OFFSET(page_info._domain));
+	MSG("SIZE(domain): %ld\n", SIZE(domain));
+	MSG("OFFSET(domain.domain_id): %ld\n", OFFSET(domain.domain_id));
+	MSG("OFFSET(domain.next_in_list): %ld\n", OFFSET(domain.next_in_list));
+
+	MSG("\n");
+	MSG("frame_table_vaddr: %lx\n", info->frame_table_vaddr);
+	MSG("xen_heap_start: %lx\n", info->xen_heap_start);
+	MSG("xen_heap_end:%lx\n", info->xen_heap_end);
+	MSG("alloc_bitmap: %lx\n", info->alloc_bitmap);
+	MSG("max_page: %lx\n", info->max_page);
+	MSG("num_domain: %d\n", info->num_domain);
+	for (i = 0; i < info->num_domain; i++) {
+		MSG(" %u: %x: %lx\n", info->domain_list[i].domain_id,
+			info->domain_list[i].pickled_id,
+			info->domain_list[i].domain_addr);
+	}
+}
+
+int
+allocated_in_map(struct DumpInfo *info, unsigned long pfn)
+{
+	static int cur_idx = -1;
+	static unsigned long cur_word;
+	int idx;
+
+	idx = pfn / PAGES_PER_MAPWORD;
+	if (idx != cur_idx) {
+		if (!readmem_xen(info, info->alloc_bitmap + idx * sizeof(unsigned long),
+			&cur_word, sizeof(cur_word), "Can't access alloc_bitmap.\n"))
+			return 0;
+		cur_idx = idx;
+	}
+
+	return !!(cur_word & (1UL << (pfn & (PAGES_PER_MAPWORD - 1))));
+}
+
+int
+is_select_domain(struct DumpInfo *info, unsigned int id)
+{
+	int i;
+
+	/* selected domain is fix to dom0 only now !!
+	   (yes... domain_list is not necessary right now, 
+		   it can get from "dom0" directly) */
+
+	for (i = 0; i < info->num_domain; i++) {
+		if (info->domain_list[i].domain_id == 0 &&
+		    info->domain_list[i].pickled_id == id)
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
+int
+create_dump_bitmap_xen(struct DumpInfo *info)
+{
+	unsigned int remain_size;
+	struct cache_data bm2;
+	unsigned long page_info_addr;
+	unsigned long pfn;
+	unsigned int count_info;
+	unsigned int _domain;
+	int i;
+	struct pt_load_segment *pls;
+	int ret = FALSE;
+
+	/* note: the first half of bitmap is not used for Xen extraction */
+	bm2.fd         = info->fd_bitmap;
+	bm2.file_name  = info->name_bitmap;
+	bm2.cache_size = BUFSIZE_BITMAP;
+	bm2.buf_size   = 0;
+	bm2.offset     = info->len_bitmap/2;
+	bm2.buf        = NULL;
+
+	if ((bm2.buf = calloc(1, BUFSIZE_BITMAP)) == NULL) {
+		ERRMSG("Can't allocate memory for 2nd-bitmap buffer. %s\n",
+		    strerror(errno));
+		goto out;
+	}
+
+	pfn = 0;
+	for (i = 0; i < info->num_load_memory; i++) {
+		pls = &info->pt_load_segments[i];
+
+		for (; pfn < (unsigned long)(pls->phys_start >> PAGESHIFT()); pfn++) { /* memory hole */
+			if ((pfn != 0) && (pfn%PFN_BUFBITMAP) == 0) {
+				bm2.buf_size = BUFSIZE_BITMAP;
+				if (!write_cache_bufsz(&bm2))
+					goto out;
+				memset(bm2.buf, 0, BUFSIZE_BITMAP);
+			}
+		}
+
+		for (; pfn < (unsigned long)(pls->phys_end >> PAGESHIFT()); pfn++) {
+
+			if ((pfn != 0) && (pfn%PFN_BUFBITMAP) == 0) {
+				bm2.buf_size = BUFSIZE_BITMAP;
+				if (!write_cache_bufsz(&bm2))
+					goto out;
+				memset(bm2.buf, 0, BUFSIZE_BITMAP);
+			}
+
+			if (!allocated_in_map(info, pfn))
+				continue;
+
+			page_info_addr = info->frame_table_vaddr + pfn * SIZE(page_info);
+			if (!readmem_xen(info,
+			      page_info_addr + OFFSET(page_info.count_info),
+		 	      &count_info, sizeof(count_info), NULL)) {
+				continue;	/* page_info may not exist */
+			}
+			if (!readmem_xen(info,
+			      page_info_addr + OFFSET(page_info._domain),
+			      &_domain, sizeof(_domain),
+			      "Can't get page_info._domain.\n"))
+				goto out;
+
+//			fprintf(stderr, "pfn: %lx\t%lx\t%lx\n", pfn, count_info, _domain);
+			/*
+			 * select:
+			 *  - anonymous (_domain == 0), or
+			 *  - xen heap area, or
+			 *  - selected domain page
+			 */
+			if (_domain == 0 ||
+				(info->xen_heap_start <= pfn && pfn < info->xen_heap_end) ||
+				((count_info & 0xffff) && is_select_domain(info, _domain))) {
+				set_bitmap(bm2.buf, pfn%PFN_BUFBITMAP, 1);
+			}
+		}
+	}
+
+	/*
+	 * Write the remainder of the bitmap.
+	 */
+	remain_size = info->len_bitmap - bm2.offset;
+	bm2.buf_size = remain_size;
+	if (!write_cache_bufsz(&bm2))
+		goto out;
+
+	ret = TRUE;
+out:
+	if (bm2.buf != NULL)
+		free(bm2.buf);
+
+	return ret;
+}
+
+int
+initial_xen(struct DumpInfo *info)
+{
+	if (!get_elf_info(info))
+		return FALSE;
+
+	if (!get_symbol_info_xen(info))
+		return FALSE;
+
+	if (!get_structure_info_xen(info))
+		return FALSE;
+
+	if (!get_xen_info(info))
+		return FALSE;
+
+	if (info->flag_debug)
+		show_data_xen(info);
+
+	return TRUE;
+}
+
+int
+handle_xen(struct DumpInfo *info)
+{
+	if (!open_files_for_creating_dumpfile(info))
+		goto out;
+
+	if (!initial_xen(info))
+		goto out;
+
+	if (!create_dump_bitmap_xen(info))
+		goto out;
+
+	if (!write_elf_header(info))
+		goto out;
+	if (!write_elf_pages(info))
+		goto out;
+
+	if (!close_files_for_creating_dumpfile(info))
+		goto out;
+
+	MSG("\n");
+	MSG("The dumpfile is saved to %s.\n", info->name_dumpfile);
+
+	return COMPLETED;
+out:
+	return FALSE;
+}
+
 int
 main(int argc, char *argv[])
 {
@@ -4152,7 +4571,7 @@
 	vt = &info->vm_table;
 
 	info->block_order = DEFAULT_ORDER;
-	while ((opt = getopt(argc, argv, "b:cDd:EFg:hi:Rvx:")) != -1) {
+	while ((opt = getopt(argc, argv, "b:cDd:EFg:hi:RvXx:")) != -1) {
 		switch (opt) {
 		case 'b':
 			info->block_order = atoi(optarg);
@@ -4191,6 +4610,9 @@
 		case 'v':
 			info->flag_show_version = 1;
 			break;
+		case 'X':
+			info->flag_xen = 1;
+			break;
 		case 'x':
 			info->flag_vmlinux = 1;
 			dwarf_info.vmlinux_name = optarg;
@@ -4282,6 +4704,18 @@
 		 */
 		ERRMSG("Elf library out of date!\n");
 		goto out;
+	}
+	if (info->flag_xen) {
+		if (!info->flag_elf_dumpfile) {
+			ERRMSG("-E must be specified with -X.\n");
+			goto out;
+		}
+		if (!info->flag_vmlinux) {
+			ERRMSG("-x xen-syms must be specified with -X.\n");
+			goto out;
+		}
+		info->dump_level = DL_EXCLUDE_XEN;
+		return handle_xen(info);
 	}
 	if (info->flag_generate_config) {
 		if (!open_files_for_generating_configfile(info))
Index: makedumpfile.h
===================================================================
RCS file: /cvsroot/xen_ia64/people/oda/makedumpfile-1.1.3/makedumpfile.h,v
retrieving revision 1.1
retrieving revision 1.13
diff -u -r1.1 -r1.13
--- makedumpfile.h	26 Apr 2007 02:32:30 -0000	1.1
+++ makedumpfile.h	27 May 2007 23:50:58 -0000	1.13
@@ -485,6 +485,7 @@
 						format to a standard out */
 	int		flag_rearrange;      /* flag of creating dumpfile from
 						flattened format */
+	int		flag_xen;
 	long		page_size;           /* size of page */
 	unsigned long long	max_mapnr;   /* number of page descriptor */
 	unsigned long   section_size_bits;
@@ -545,6 +546,18 @@
 	FILE			*file_configfile;
 	char			*name_configfile;	     /* config file */
 	char			release[65]; /*Can I define 65 automatically?*/
+
+	/*
+	 * for Xen extraction
+	 */
+	unsigned long xen_heap_start;	/* start mfn of xen heap area */
+	unsigned long xen_heap_end;	/* end mfn(+1) of xen heap area */
+	unsigned long frame_table_vaddr;
+	unsigned long max_page;
+	unsigned long alloc_bitmap;
+	unsigned long dom0;
+	int	num_domain;
+	struct domain_list *domain_list;
 };
 
 struct symbol_table {
@@ -560,6 +573,21 @@
 	unsigned long	node_data;
 	unsigned long	pgdat_list;
 	unsigned long	contig_page_data;
+
+	/* for Xen extraction */
+	unsigned long	dom_xen;
+	unsigned long	dom_io;
+	unsigned long	domain_list;
+	unsigned long	frame_table;
+	unsigned long	xen_heap_start;
+	unsigned long	pgd_l2;
+	unsigned long	pgd_l3;
+	unsigned long	pgd_l4;
+	unsigned long	xenheap_phys_end;
+	unsigned long	xen_pstart;
+	unsigned long	frametable_pg_dir;
+	unsigned long	max_page;
+	unsigned long	alloc_bitmap;
 };
 
 struct size_table {
@@ -569,6 +597,10 @@
 	long	zone;
 	long	free_area;
 	long	list_head;
+
+	/* for Xen extraction */
+	long	page_info;
+	long	domain;
 };
 
 struct offset_table {
@@ -601,6 +633,16 @@
 		long	next;
 		long	prev;
 	} list_head;
+
+	/* for Xen extraction */
+	struct page_info {
+		long	count_info;
+		long	_domain;
+	} page_info;
+	struct domain {
+		long	domain_id;
+		long	next_in_list;
+	} domain;
 };
 
 /*
@@ -651,3 +693,89 @@
 
 extern struct dwarf_info	dwarf_info;
 
+/*
+ * for Xen extraction
+ */
+struct domain_list {
+	unsigned long domain_addr;
+	unsigned int  domain_id;
+	unsigned int  pickled_id;
+};
+
+#define DL_EXCLUDE_XEN	DL_EXCLUDE_FREE
+#define PAGES_PER_MAPWORD (sizeof(unsigned long) * 8)
+
+extern int
+readpmem(struct DumpInfo *info, unsigned long long paddr, void *bufptr, size_t size);
+extern int
+readmem_xen(struct DumpInfo *info, unsigned long long vaddr, void *bufptr,
+	size_t size, char *errmsg);
+
+#ifdef __x86__
+#define HYPERVISOR_VIRT_START_PAE	(0xF5800000UL)
+#define HYPERVISOR_VIRT_START		(0xFC000000UL)
+#define HYPERVISOR_VIRT_END		(0xFFFFFFFFUL)
+#define DIRECTMAP_VIRT_START		(0xFF000000UL)
+#define DIRECTMAP_VIRT_END		(0xFFC00000UL)
+
+#define is_xen_vaddr(x) \
+	((x) >= HYPERVISOR_VIRT_START_PAE && (x) < HYPERVISOR_VIRT_END)
+#define is_direct(x) \
+	((x) >= DIRECTMAP_VIRT_START && (x) < DIRECTMAP_VIRT_END)
+
+#define PGDIR_SHIFT_3LEVEL   (30)
+#define PTRS_PER_PTE_3LEVEL  (512)
+#define PTRS_PER_PGD_3LEVEL  (4)
+#define PMD_SHIFT            (21)    /* only used by PAE translators */
+#define PTRS_PER_PMD         (512)   /* only used by PAE translators */
+#define PTE_SHIFT            (12)    /* only used by PAE translators */
+#define PTRS_PER_PTE         (512)   /* only used by PAE translators */
+
+#define _PAGE_PRESENT   0x001
+#define _PAGE_PSE       0x080
+
+#define ENTRY_MASK	(~0x8000000000000fffULL)
+
+unsigned long long kvtop_xen_x86(struct DumpInfo *info, unsigned long kvaddr);
+#define kvtop_xen(X, Y)	kvtop_xen_x86(X, Y)
+
+int get_xen_info_x86(struct DumpInfo *info);
+#define get_xen_info_arch(X) get_xen_info_x86(X)
+
+#endif	/* __x86__ */
+
+#ifdef __ia64__
+#define HYPERVISOR_VIRT_START	(0xe800000000000000)
+#define HYPERVISOR_VIRT_END	(0xf800000000000000)
+#define DEFAULT_SHAREDINFO_ADDR	(0xf100000000000000)
+#define PERCPU_PAGE_SIZE	65536
+#define PERCPU_ADDR		(DEFAULT_SHAREDINFO_ADDR - PERCPU_PAGE_SIZE)
+#define DIRECTMAP_VIRT_START	(0xf000000000000000)
+#define DIRECTMAP_VIRT_END	PERCPU_ADDR
+#define VIRT_FRAME_TABLE_ADDR	(0xf300000000000000)
+#define VIRT_FRAME_TABLE_END	(0xf400000000000000)
+
+#define is_xen_vaddr(x) \
+	((x) >= HYPERVISOR_VIRT_START && (x) < HYPERVISOR_VIRT_END)
+#define is_direct(x) \
+	((x) >= DIRECTMAP_VIRT_START && (x) < DIRECTMAP_VIRT_END)
+#define is_frame_table_vaddr(x) \
+	((x) >= VIRT_FRAME_TABLE_ADDR && (x) < VIRT_FRAME_TABLE_END)
+
+#define PGDIR_SHIFT	(PAGESHIFT() + 2 * (PAGESHIFT() - 3))
+#define PTRS_PER_PGD	(1UL << (PAGESHIFT() - 3))
+#define PMD_SHIFT	(PAGESHIFT() + (PAGESHIFT() - 3))
+#define PTRS_PER_PMD	(1UL << (PAGESHIFT() - 3))
+#define PTRS_PER_PTE	(1UL << (PAGESHIFT() - 3))
+
+#define IA64_MAX_PHYS_BITS	50
+#define _PAGE_P		(1)
+#define _PFN_MASK	(((1UL << IA64_MAX_PHYS_BITS) - 1) & ~0xfffUL)
+
+unsigned long long kvtop_xen_ia64(struct DumpInfo *info, unsigned long kvaddr);
+#define kvtop_xen(X, Y)	kvtop_xen_ia64(X, Y)
+
+int get_xen_info_ia64(struct DumpInfo *info);
+#define get_xen_info_arch(X) get_xen_info_ia64(X)
+
+#endif	/* __ia64 */
Index: x86.c
===================================================================
RCS file: /cvsroot/xen_ia64/people/oda/makedumpfile-1.1.3/x86.c,v
retrieving revision 1.1
retrieving revision 1.6
diff -u -r1.1 -r1.6
--- x86.c	26 Apr 2007 02:32:30 -0000	1.1
+++ x86.c	26 May 2007 01:19:01 -0000	1.6
@@ -43,5 +43,98 @@
 	return TRUE;
 }
 
+/*
+ * for Xen extraction
+ */
+unsigned long long
+kvtop_xen_x86(struct DumpInfo *info, unsigned long kvaddr)
+{
+	unsigned long long dirp, entry;
+
+	if (!is_xen_vaddr(kvaddr))
+		return 0;
+
+	if (is_direct(kvaddr))
+		return (unsigned long)kvaddr - DIRECTMAP_VIRT_START;
+
+	dirp = kvtop_xen_x86(info, SYMBOL(pgd_l3));
+	dirp += ((kvaddr >> PGDIR_SHIFT_3LEVEL) & (PTRS_PER_PGD_3LEVEL - 1)) * sizeof(unsigned long long);
+	if (!readpmem(info, dirp, &entry, sizeof(entry)))
+		return 0;
+ 
+	if (!(entry & _PAGE_PRESENT))
+		return 0;
+	dirp = entry & ENTRY_MASK;
+	dirp += ((kvaddr >> PMD_SHIFT) & (PTRS_PER_PMD - 1)) * sizeof(unsigned long long);
+	if (!readpmem(info, dirp, &entry, sizeof(entry)))
+		return 0;
+
+	if (!(entry & _PAGE_PRESENT))
+		return 0;
+	if (entry & _PAGE_PSE) {
+		entry = (entry & ENTRY_MASK) + (kvaddr & ((1UL << PMD_SHIFT) - 1));
+		return entry;
+	}
+	dirp = entry & ENTRY_MASK;
+	dirp += ((kvaddr >> PTE_SHIFT) & (PTRS_PER_PTE - 1)) * sizeof(unsigned long long);
+	if (!readpmem(info, dirp, &entry, sizeof(entry)))
+		return 0;
+
+	if (!(entry & _PAGE_PRESENT)) {
+		return 0;
+	}
+
+	entry = (entry & ENTRY_MASK) + (kvaddr & ((1UL << PTE_SHIFT) - 1));
+
+	return entry;
+}
+
+int get_xen_info_x86(struct DumpInfo *info)
+{
+	unsigned long frame_table_vaddr;
+	unsigned long xen_end;
+	int i;
+
+	if (SYMBOL(pgd_l2) == NOT_FOUND_SYMBOL &&
+	    SYMBOL(pgd_l3) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get pgd.\n");
+		return FALSE;
+	}
+
+	if (SYMBOL(pgd_l3) == NOT_FOUND_SYMBOL) {
+		ERRMSG("non-PAE not support right now.\n");
+		return FALSE;
+	}
+
+	if (SYMBOL(frame_table) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of frame_table.\n");
+		return FALSE;
+	}
+	if (!readmem_xen(info, SYMBOL(frame_table), &frame_table_vaddr,
+	      sizeof(frame_table_vaddr),
+	      "Can't get the value of frame_table.\n"))
+		return FALSE;
+
+	info->frame_table_vaddr = frame_table_vaddr;
+
+	if (SYMBOL(xenheap_phys_end) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
+		return FALSE;
+	}
+	if (!readmem_xen(info, SYMBOL(xenheap_phys_end), &xen_end,
+	      sizeof(xen_end), "Can't get the value of xenheap_phys_end.\n"))
+		return FALSE;
+
+	info->xen_heap_end = (xen_end >> PAGESHIFT());
+	info->xen_heap_start = 0;
+
+	/* pickled_id == domain addr for x86 */
+	for (i = 0; i < info->num_domain; i++) {
+		info->domain_list[i].pickled_id =
+			info->domain_list[i].domain_addr;
+	}
+
+	return TRUE;
+}
 #endif /* x86 */
-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

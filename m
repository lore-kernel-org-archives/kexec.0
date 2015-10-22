Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZpAY3-0001vm-C2
 for kexec@lists.infradead.org; Thu, 22 Oct 2015 07:44:36 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH V5] makedumpfile: exclude page structures of non-dumped
 pages
Date: Thu, 22 Oct 2015 07:35:55 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DF69B5@BPXM01GP.gisp.nec.co.jp>
References: <20151013170045.E803D1199FED@asylum.americas.sgi.com>
In-Reply-To: <20151013170045.E803D1199FED@asylum.americas.sgi.com>
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
To: Cliff Wickman <cpw@sgi.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Cliff,

I've reviewed this patch, please confirm the comments below.

>From: Cliff Wickman <cpw@sgi.com>
>
>Applies to the development branch as of 10/13/2015.
>
>This patch adds a -e option to makedumpfile.
>The -e option excludes kernel pages that contain nothing but kernel page
>structures for pages that are not being included in the dump.
>The -e option only works in non-cyclic mode, which its use implies.
>
>The -e requires the use of --work-dir, as it will create a pfn file in that
>work directory.  The --work-dir should probably be set up by the distro procedures
>which determine the mount point of the root device.
>This patch formerly applied after patch:
>  [PATCH V2] makedumpfile: make --work-dir easier to use
>but now it stands alone.
>
>I have tested on large memory systems to demonstrate the importance
>of this feature to such systems. See some numbers below.
>
>The most dramatic demonstration was on a 32TB system where the patch
>reduced the process from 2 hours to 26 minutes.  The size of the dump
>would probably have been over 30GB (but I ran out of disk space). It was
>reduced to 5.4GB.
>
>A page structure (56 bytes) exists for every 4096-byte page.
>This amounts to 3.67 million pages, or about 14GB, per terabyte of system memory!
>
>Without -e an idle 2-terabyte system can be dumped (compressed) to a file of
>about 3.6G.
>With -e that is reduced to about 456M.  And the time and space savings
>multiply for each additional terabyte of memory in the system.
>
>Experimental time/size results:  (basically idle systems)
>
>Memory Size	With -e			Without -e
>		(sec.)			(sec.)
>(using a sles11sp3 kernel that does not provide mmap of /proc/vmcore:)
>1TB		   52 244M		  257  1.7G
>2TB		  128 456M		  526  3.6G
>8TB		  780 1.6G		 3400 13.8G
>16TB		 2600 3.1G		 9800 (extrapolated, 2:40 is too long to wait)
>(using a sles11sp3 kernel that provides mmap of /proc/vmcore:)
>16TB		  900 3.8G		 not done
>32TB		 6000 5.4G		 not done
>(using a sles11sp3 kernel that provides mmap of /proc/vmcore:)
>32TB		 1600 5.4G		7300 (extrapolated)
>                                        (ran out of 19G space before 1/2 done)
>
>The only disadvantage is that various options of the crash 'kmem' command (that
>walk lists of page structures) will not work.
>Version 7.0.9 of crash is already patched to issue a warning about such commands
>when the dump is flagged DUMP_DH_EXCLUDED_VMEMMAP.
>
>
>Sorry that this patch is large.  The vmemmap page scan is done by some very large
>functions, and they are all interrelated. I didn't see any point to breaking
>them into several inter-dependent patches.
>
>---
> diskdump_mod.h |    1
> makedumpfile.c |  661 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> makedumpfile.h |   59 +++++
> print_info.c   |   10
> 4 files changed, 728 insertions(+), 3 deletions(-)
>
>Index: code/print_info.c
>===================================================================
>--- code.orig/print_info.c
>+++ code/print_info.c
>@@ -58,7 +58,7 @@ print_usage(void)
> 	MSG("\n");
> 	MSG("Usage:\n");
> 	MSG("  Creating DUMPFILE:\n");
>-	MSG("  # makedumpfile    [-c|-l|-p|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
>+	MSG("  # makedumpfile    [-c|-l|-p|-E] [-d DL] [-e] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
> 	MSG("    DUMPFILE\n");
> 	MSG("\n");
> 	MSG("  Creating DUMPFILE with filtered kernel data specified through filter config\n");
>@@ -113,6 +113,14 @@ print_usage(void)
> 	MSG("      -E option, because the ELF format does not support compressed data.\n");
> 	MSG("      THIS IS ONLY FOR THE CRASH UTILITY.\n");
> 	MSG("\n");
>+	MSG("  [-e]:\n");
>+	MSG("      Exclude page structures (vmemmap) for unused pages.\n");

I think *for filtered pages* or *for excluded pages* is proper for this description.

>+	MSG("      This greatly shortens the dump of a very large memory system.\n");
>+	MSG("      The --work-dir option must also be specified, as it will be used\n");
>+	MSG("      to hold bitmaps and a file of page numbers that are to be excluded.\n");
>+	MSG("      The -e option will cause a noncyclic dump procedure.\n");
>+
>+	MSG("\n");
> 	MSG("  [-d DL]:\n");
> 	MSG("      Specify the type of unnecessary page for analysis.\n");
> 	MSG("      Pages of the specified type are not copied to DUMPFILE. The page type\n");
>Index: code/makedumpfile.h
>===================================================================
>--- code.orig/makedumpfile.h
>+++ code/makedumpfile.h
>@@ -45,6 +45,9 @@
> #include "sadump_mod.h"
> #include <pthread.h>
>
>+#define VMEMMAPSTART 0xffffea0000000000UL
>+#define BITS_PER_WORD 64
>+
> /*
>  * Result of command
>  */
>@@ -496,6 +499,7 @@ do { \
> #define VMALLOC_END		(info->vmalloc_end)
> #define VMEMMAP_START		(info->vmemmap_start)
> #define VMEMMAP_END		(info->vmemmap_end)
>+#define PMASK			(0x7ffffffffffff000UL)
>
> #ifdef __aarch64__
> #define CONFIG_ARM64_PGTABLE_LEVELS	2
>@@ -609,15 +613,20 @@ do { \
> #define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
> #define PGDIR_MASK		(~(PGDIR_SIZE - 1))
> #define PTRS_PER_PGD		(512)
>+#define PGD_SHIFT		(39)
>+#define PUD_SHIFT		(30)
> #define PMD_SHIFT		(21)
> #define PMD_SIZE		(1UL << PMD_SHIFT)
> #define PMD_MASK		(~(PMD_SIZE - 1))
>+#define PTRS_PER_PUD		(512)
> #define PTRS_PER_PMD		(512)
> #define PTRS_PER_PTE		(512)
> #define PTE_SHIFT		(12)
>
> #define pml4_index(address) (((address) >> PML4_SHIFT) & (PTRS_PER_PML4 - 1))
> #define pgd_index(address)  (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
>+#define pgd4_index(address) (((address) >> PGD_SHIFT) & (PTRS_PER_PGD - 1))
>+#define pud_index(address)  (((address) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
> #define pmd_index(address)  (((address) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
> #define pte_index(address)  (((address) >> PTE_SHIFT) & (PTRS_PER_PTE - 1))
>
>@@ -783,7 +792,6 @@ do { \
> /*
>  * 4 Levels paging
>  */
>-#define PUD_SHIFT		(PMD_SHIFT + PTRS_PER_PTD_SHIFT)
> #define PGDIR_SHIFT_4L		(PUD_SHIFT + PTRS_PER_PTD_SHIFT)
>
> #define MASK_PUD   	((1UL << REGION_SHIFT) - 1) & (~((1UL << PUD_SHIFT) - 1))
>@@ -1686,6 +1694,51 @@ struct srcfile_table {
> 	char	pud_t[LEN_SRCFILE];
> };
>
>+/*
>+ * This structure records where the vmemmap page structures reside, and which
>+ * pfn's are represented by those page structures.
>+ * The actual pages containing the page structures are 2MB pages, so their pfn's
>+ * will all be multiples of 0x200.
>+ * The page structures are 7 64-bit words in length (0x38) so they overlap the
>+ * 2MB boundaries. Each page structure represents a 4k page.
>+ * A 4k page is here defined to be represented on a 2MB page if its page structure
>+ * 'ends' on that page (even if it began on the page before).
>+ */
>+struct vmap_pfns {
>+       struct vmap_pfns *next;
>+       struct vmap_pfns *prev;
>+       /*
>+        * These (start/end) are literal pfns of 2MB pages on which the page
>+        * structures reside, not start and end+1.
>+        */
>+       unsigned long vmap_pfn_start;
>+       unsigned long vmap_pfn_end;
>+       /*
>+        * These (start/end) are literal pfns represented on these pages, not
>+        * start and end+1.
>+        * The starting page struct is at least partly on the first page; the
>+        * ending page struct is entirely on the last page.
>+        */
>+       unsigned long rep_pfn_start;
>+       unsigned long rep_pfn_end;
>+};
>+
>+/* for saving a list of pfns to a buffer, and then to a file if necessary */
>+struct save_control {
>+       int sc_fd;
>+       char *sc_filename;
>+       char *sc_buf;
>+       long sc_buflen; /* length of buffer never changes */
>+       long sc_bufposition; /* offset of next slot for write, or next to be read */
>+       long sc_filelen; /* length of valid data written */
>+       long sc_fileposition; /* offset in file of next entry to be read */
>+};
>+/* one entry in the buffer and file */
>+struct sc_entry {
>+       unsigned long startpfn;
>+       unsigned long numpfns;
>+};
>+
> extern struct symbol_table	symbol_table;
> extern struct size_table	size_table;
> extern struct offset_table	offset_table;
>@@ -1850,6 +1903,9 @@ int get_xen_info_ia64(void);
> #define get_xen_info_arch(X) FALSE
> #endif	/* s390x */
>
>+#define PAGESHFT	12 /* assuming a 4k page */
>+#define PSE		128 /* bit 7 */
>+

Why don't you use PAGESHIFT() and _PAGE_PSE ?

> struct cycle {
> 	mdf_pfn_t start_pfn;
> 	mdf_pfn_t end_pfn;
>@@ -2011,6 +2067,7 @@ struct elf_prstatus {
> #define OPT_DEBUG               'D'
> #define OPT_DUMP_LEVEL          'd'
> #define OPT_ELF_DUMPFILE        'E'
>+#define OPT_EXCLUDE_UNUSED_VM	'e'
> #define OPT_FLATTEN             'F'
> #define OPT_FORCE               'f'
> #define OPT_GENERATE_VMCOREINFO 'g'
>Index: code/makedumpfile.c
>===================================================================
>--- code.orig/makedumpfile.c
>+++ code/makedumpfile.c
>@@ -32,10 +32,13 @@ struct offset_table	offset_table;
> struct array_table	array_table;
> struct number_table	number_table;
> struct srcfile_table	srcfile_table;
>+struct save_control	sc;
>
> struct vm_table		vt = { 0 };
> struct DumpInfo		*info = NULL;
> struct SplitBlock		*splitblock = NULL;
>+struct vmap_pfns	*gvmem_pfns;
>+int nr_gvmem_pfns;
>
> char filename_stdout[] = FILENAME_STDOUT;
>
>@@ -85,8 +88,10 @@ mdf_pfn_t pfn_free;
> mdf_pfn_t pfn_hwpoison;
>
> mdf_pfn_t num_dumped;
>+long blocksize;

I can't find the reason why you defined this, it can be replaced with
info->page_size. 
Further, it is also set in write_kdump_header() but it looks unnecessary.

> int retcd = FAILED;	/* return code */
>+int excludevmflag = 0;

Move this flag into DumpInfo like other flags, like info->flag_excludevm.

>
> #define INITIALIZE_LONG_TABLE(table, value) \
> do { \
>@@ -5736,6 +5741,320 @@ copy_bitmap(void)
> 	}
> }
>
>+/*
>+ * Initialize the structure for saving pfn's to be deleted.
>+ */
>+void
>+init_save_control()
>+{
>+	int flags;
>+	char *filename;
>+
>+	filename = malloc(50);
>+	*filename = '\0';
>+	strcpy(filename, info->working_dir);
>+	strcat(filename, "/");
>+	strcat(filename, "makedumpfilepfns");
>+	sc.sc_filename = filename;
>+	flags = O_RDWR|O_CREAT|O_TRUNC;
>+	if ((sc.sc_fd = open(sc.sc_filename, flags, S_IRUSR|S_IWUSR)) < 0) {
>+		fprintf(stderr, "Can't open the pfn file %s.\n",
>+			sc.sc_filename);

All of fprintf() in this patch should be changed to ERRMSG.

>+		exit(1);

Don't be lazy with error trapping.
This is applied also to other exit().

>+	}
>+	unlink(sc.sc_filename);
>+
>+	sc.sc_buf= malloc(blocksize);
>+	if (!sc.sc_buf) {
>+		fprintf(stderr, "Can't allocate a page for pfn buf.\n");
>+		exit(1);
>+	}
>+	sc.sc_buflen = blocksize;
>+	sc.sc_bufposition = 0;
>+	sc.sc_fileposition = 0;
>+	sc.sc_filelen = 0;
>+}
>+
>+/*
>+ * Save a starting pfn and number of pfns for later delete from bitmap.
>+ */
>+void
>+save_deletes(unsigned long startpfn, unsigned long numpfns)
>+{
>+	int i;
>+	struct sc_entry *scp;
>+
>+	if (sc.sc_bufposition == sc.sc_buflen) {
>+		i = write(sc.sc_fd, sc.sc_buf, sc.sc_buflen);
>+		if (i != sc.sc_buflen) {
>+			fprintf(stderr, "save: Can't write a page to %s\n",
>+				sc.sc_filename);
>+			exit(1);
>+		}
>+		sc.sc_filelen += sc.sc_buflen;
>+		sc.sc_bufposition = 0;
>+	}
>+	scp = (struct sc_entry *)(sc.sc_buf + sc.sc_bufposition);
>+	scp->startpfn = startpfn;
>+	scp->numpfns = numpfns;
>+	sc.sc_bufposition += sizeof(struct sc_entry);
>+}
>+
>+/*
>+ * Get a starting pfn and number of pfns for delete from bitmap.
>+ * Return 0 for success, 1 for 'no more'
>+ */
>+int
>+get_deletes(unsigned long *startpfn, unsigned long *numpfns)
>+{
>+	int i;
>+	struct sc_entry *scp;
>+
>+	if (sc.sc_fileposition >= sc.sc_filelen) {
>+		return 1;
>+	}
>+
>+	if (sc.sc_bufposition == sc.sc_buflen) {
>+		i = read(sc.sc_fd, sc.sc_buf, sc.sc_buflen);
>+		if (i <= 0) {
>+			fprintf(stderr, "Can't read a page from %s.\n", sc.sc_filename);
>+			exit(1);
>+		}
>+		sc.sc_bufposition = 0;
>+	}
>+	scp = (struct sc_entry *)(sc.sc_buf + sc.sc_bufposition);
>+	*startpfn = scp->startpfn;
>+	*numpfns = scp->numpfns;
>+	sc.sc_bufposition += sizeof(struct sc_entry);
>+	sc.sc_fileposition += sizeof(struct sc_entry);
>+	return 0;
>+}
>+
>+/*
>+ * Given a range of unused pfn's, check whether we can drop the vmemmap pages
>+ * that represent them.
>+ *  (pfn ranges are literally start and end, not start and end+1)
>+ *   see the array of vmemmap pfns and the pfns they represent: gvmem_pfns
>+ * Return 1 for delete, 0 for not to delete.
>+ */
>+int
>+find_vmemmap_pages(unsigned long startpfn, unsigned long endpfn, unsigned long *vmappfn,
>+									unsigned long *nmapnpfns)
>+{
>+	int i;
>+	long npfns_offset, vmemmap_offset, vmemmap_pfns, start_vmemmap_pfn;
>+	long npages, end_vmemmap_pfn;
>+	struct vmap_pfns *vmapp;
>+	int pagesize = info->page_size;
>+
>+	for (i = 0; i < nr_gvmem_pfns; i++) {
>+		vmapp = gvmem_pfns + i;
>+		if ((startpfn >= vmapp->rep_pfn_start) &&
>+		    (endpfn <= vmapp->rep_pfn_end)) {
>+			npfns_offset = startpfn - vmapp->rep_pfn_start;
>+			vmemmap_offset = npfns_offset * size_table.page;
>+			// round up to a page boundary
>+			if (vmemmap_offset % pagesize)
>+				vmemmap_offset += (pagesize - (vmemmap_offset % pagesize));
>+			vmemmap_pfns = vmemmap_offset / pagesize;
>+			start_vmemmap_pfn = vmapp->vmap_pfn_start + vmemmap_pfns;
>+			*vmappfn = start_vmemmap_pfn;
>+
>+			npfns_offset = endpfn - vmapp->rep_pfn_start;
>+			vmemmap_offset = npfns_offset * size_table.page;
>+			// round down to page boundary
>+			vmemmap_offset -= (vmemmap_offset % pagesize);
>+			vmemmap_pfns = vmemmap_offset / pagesize;
>+			end_vmemmap_pfn = vmapp->vmap_pfn_start + vmemmap_pfns;
>+			npages = end_vmemmap_pfn - start_vmemmap_pfn;
>+			if (npages == 0)
>+				return 0;
>+			*nmapnpfns = npages;
>+			return 1;
>+		}
>+	}
>+	return 0;
>+}
>+
>+/*
>+ * Find the big holes in bitmap2; they represent ranges for which
>+ * we do not need page structures.
>+ * Bitmap1 is a map of dumpable (i.e existing) pages.
>+ * They must only be pages that exist, so they will be 0 bits
>+ * in the 2nd bitmap but 1 bits in the 1st bitmap.
>+ * For speed, only worry about whole words full of bits.
>+ */
>+void
>+find_unused_vmemmap_pages(void)
>+{
>+	struct dump_bitmap *bitmap1 = info->bitmap1;
>+	struct dump_bitmap *bitmap2 = info->bitmap2;
>+	unsigned long long pfn;
>+	unsigned long *lp1, *lp2, startpfn, endpfn;
>+	unsigned long vmapstartpfn, vmapnumpfns;
>+	int i, sz, numpages=0, did_deletes;
>+	int startword, numwords, do_break=0;
>+	long deleted_pages = 0;
>+	off_t new_offset1, new_offset2;
>+
>+	/* read each block of both bitmaps */
>+	for (pfn = 0; pfn < info->max_mapnr; pfn += PFN_BUFBITMAP) { /* size in bits */
>+		numpages++;
>+		did_deletes = 0;
>+		new_offset1 = bitmap1->offset + BUFSIZE_BITMAP * (pfn / PFN_BUFBITMAP);
>+		if (lseek(bitmap1->fd, new_offset1, SEEK_SET) < 0 ) {
>+			ERRMSG("Can't seek the bitmap(%s). %s\n",
>+				bitmap1->file_name, strerror(errno));
>+			return;
>+		}
>+		if (read(bitmap1->fd, bitmap1->buf, BUFSIZE_BITMAP) != BUFSIZE_BITMAP) {
>+			ERRMSG("Can't read the bitmap(%s). %s\n",
>+				bitmap1->file_name, strerror(errno));
>+			return;
>+		}
>+		bitmap1->no_block = pfn / PFN_BUFBITMAP;
>+
>+		new_offset2 = bitmap2->offset + BUFSIZE_BITMAP * (pfn / PFN_BUFBITMAP);
>+		if (lseek(bitmap2->fd, new_offset2, SEEK_SET) < 0 ) {
>+			ERRMSG("Can't seek the bitmap(%s). %s\n",
>+				bitmap2->file_name, strerror(errno));
>+			return;
>+		}
>+		if (read(bitmap2->fd, bitmap2->buf, BUFSIZE_BITMAP) != BUFSIZE_BITMAP) {
>+			ERRMSG("Can't read the bitmap(%s). %s\n",
>+				bitmap2->file_name, strerror(errno));
>+			return;
>+		}
>+		bitmap2->no_block = pfn / PFN_BUFBITMAP;
>+
>+		/* process this one page of both bitmaps at a time */
>+		lp1 = (unsigned long *)bitmap1->buf;
>+		lp2 = (unsigned long *)bitmap2->buf;
>+		/* sz is words in the block */
>+		sz = BUFSIZE_BITMAP / sizeof(unsigned long);
>+		startword = -1;
>+		for (i = 0; i < sz; i++, lp1++, lp2++) {
>+			/* for each whole word in the block */
>+			/* deal in full 64-page chunks only */
>+			if (*lp1 == 0xffffffffffffffffUL) {
>+				if (*lp2 == 0) {
>+					/* we are in a series we want */
>+					if (startword == -1) {
>+						/* starting a new group */
>+						startword = i;
>+					}
>+				} else {
>+					/* we hit a used page */
>+					if (startword >= 0)
>+						do_break = 1;
>+				}
>+			} else {
>+				/* we hit a hole in real memory, or part of one */
>+				if (startword >= 0)
>+					do_break = 1;
>+			}
>+			if (do_break) {
>+				do_break = 0;
>+				if (startword >= 0) {
>+					numwords = i - startword;
>+					/* 64 bits represents 64 page structs, which
>+ 					   are not even one page of them (takes
>+					   at least 73) */
>+					if (numwords > 1) {
>+						startpfn = pfn +
>+							(startword * BITS_PER_WORD);
>+						/* pfn ranges are literally start and end,
>+						   not start and end + 1 */
>+						endpfn = startpfn +
>+							(numwords * BITS_PER_WORD) - 1;
>+						if (find_vmemmap_pages(startpfn, endpfn,
>+							&vmapstartpfn, &vmapnumpfns)) {
>+							save_deletes(vmapstartpfn,
>+								vmapnumpfns);
>+							deleted_pages += vmapnumpfns;
>+							did_deletes = 1;
>+						}
>+					}
>+				}
>+				startword = -1;
>+			}
>+		}
>+		if (startword >= 0) {
>+			numwords = i - startword;
>+			if (numwords > 1) {
>+				startpfn = pfn + (startword * BITS_PER_WORD);
>+				/* pfn ranges are literally start and end,
>+				   not start and end + 1 */
>+				endpfn = startpfn + (numwords * BITS_PER_WORD) - 1;
>+				if (find_vmemmap_pages(startpfn, endpfn,
>+							&vmapstartpfn, &vmapnumpfns)) {
>+					save_deletes(vmapstartpfn, vmapnumpfns);
>+					deleted_pages += vmapnumpfns;
>+					did_deletes = 1;
>+				}
>+			}
>+		}
>+	}
>+	PROGRESS_MSG("\nExcluded %ld unused vmemmap pages\n", deleted_pages);
>+
>+	return;
>+}
>+
>+/*
>+ * Retrieve the list of pfn's and delete them from bitmap2;
>+ */
>+void
>+delete_unused_vmemmap_pages(void)
>+{
>+	unsigned long startpfn, numpfns, pfn, i;
>+
>+	while (!get_deletes(&startpfn, &numpfns)) {
>+		for (i = 0, pfn = startpfn; i < numpfns; i++, pfn++) {
>+			clear_bit_on_2nd_bitmap_for_kernel(pfn, (struct cycle *)0);
>+			// note that this is never to be used in cyclic mode!
>+		}
>+	}
>+	return;
>+}
>+
>+/*
>+ * Finalize the structure for saving pfn's to be deleted.
>+ */
>+void
>+finalize_save_control()
>+{
>+	free(sc.sc_buf);
>+	close(sc.sc_fd);
>+	return;
>+}
>+
>+/*
>+ * Reset the structure for saving pfn's to be deleted so that it can be read
>+ */
>+void
>+reset_save_control()
>+{
>+	int i;
>+	if (sc.sc_bufposition == 0)
>+		return;
>+
>+	i = write(sc.sc_fd, sc.sc_buf, sc.sc_buflen);
>+	if (i != sc.sc_buflen) {
>+		fprintf(stderr, "reset: Can't write a page to %s\n",
>+			sc.sc_filename);
>+		exit(1);
>+	}
>+	sc.sc_filelen += sc.sc_bufposition;
>+
>+	if (lseek(sc.sc_fd, 0, SEEK_SET) < 0) {
>+		fprintf(stderr, "Can't seek the pfn file %s).", sc.sc_filename);
>+		exit(1);
>+	}
>+	sc.sc_fileposition = 0;
>+	sc.sc_bufposition = sc.sc_buflen; /* trigger 1st read */
>+	return;
>+}
>+
> int
> create_2nd_bitmap(struct cycle *cycle)
> {
>@@ -5815,6 +6134,15 @@ create_2nd_bitmap(struct cycle *cycle)
> 	if (!sync_2nd_bitmap())
> 		return FALSE;
>
>+	/* --exclude-unused-vm means exclude vmemmap page structures for unused pages */
>+	if (excludevmflag) {
>+		init_save_control();
>+		find_unused_vmemmap_pages();
>+		reset_save_control();
>+		delete_unused_vmemmap_pages();
>+		finalize_save_control();

sync_2nd_bitmap() is necessary here, otherwise the last chunk of bitmap
will not be reflected.

>+	}
>+
> 	return TRUE;
> }
>
>@@ -6229,8 +6557,13 @@ write_kdump_header(void)
> 	dh->max_mapnr      = MIN(info->max_mapnr, UINT_MAX);
> 	dh->nr_cpus        = get_nr_cpus();
> 	dh->bitmap_blocks  = divideup(info->len_bitmap, dh->block_size);
>+ 	blocksize = dh->block_size;
> 	memcpy(&dh->timestamp, &info->timestamp, sizeof(dh->timestamp));
> 	memcpy(&dh->utsname, &info->system_utsname, sizeof(dh->utsname));
>+
>+	if (excludevmflag)
>+		dh->status |= DUMP_DH_EXCLUDED_VMEMMAP;
>+
> 	if (info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
> 		dh->status |= DUMP_DH_COMPRESSED_ZLIB;
> #ifdef USELZO
>@@ -9183,6 +9516,315 @@ writeout_multiple_dumpfiles(void)
> 	return ret;
> }
>
>+/*
>+ * Scan the kernel page table for the pfn's of the page structs
>+ * Place them in array gvmem_pfns[nr_gvmem_pfns]
>+ */

find_vmemmap() is a function to walk the page table of x86_64,
it should be implemented in arch/x86_64.c.
Then, other arch's developers can implement their find_vmemmap().

>+void
>+find_vmemmap()
>+{
>+	int i, verbose = 0;

Don't leave a debug flag *verbose*, should use DEBUG_MSG().

>+	int pgd_index, pud_index;
>+	int start_range = 1;
>+	int num_pmds=0, num_pmds_valid=0;
>+	int break_in_valids, break_after_invalids;
>+	int do_break, done = 0;
>+	int last_valid=0, last_invalid=0;
>+	int pagestructsize, structsperhpage, hugepagesize;
>+	long page_structs_per_pud;
>+	long num_puds, groups = 0;
>+	long pgdindex, pudindex, pmdindex;
>+	long vaddr, vaddr_base;
>+	long rep_pfn_start = 0, rep_pfn_end = 0;
>+	unsigned long init_level4_pgt;
>+	unsigned long max_paddr, high_pfn;
>+	unsigned long pgd_addr, pud_addr, pmd_addr;
>+	unsigned long *pgdp, *pudp, *pmdp;
>+	unsigned long pud_page[PTRS_PER_PUD];
>+	unsigned long pmd_page[PTRS_PER_PMD];
>+	unsigned long vmap_offset_start = 0, vmap_offset_end = 0;
>+	unsigned long pmd, tpfn;
>+	unsigned long pvaddr = 0;
>+	unsigned long data_addr = 0, last_data_addr = 0, start_data_addr = 0;
>+	/*
>+	 * data_addr is the paddr of the page holding the page structs.
>+	 * We keep lists of contiguous pages and the pfn's that their
>+	 * page structs represent.
>+	 *  start_data_addr and last_data_addr mark start/end of those
>+	 *  contiguous areas.
>+	 * An area descriptor is vmap start/end pfn and rep start/end
>+	 *  of the pfn's represented by the vmap start/end.
>+	 */
>+	struct vmap_pfns *vmapp, *vmaphead = NULL, *cur, *tail;
>+
>+	init_level4_pgt = SYMBOL(init_level4_pgt);
>+	if (init_level4_pgt == NOT_FOUND_SYMBOL) {
>+		fprintf(stderr, "init_level4_pgt not found\n");
>+		return;
>+	}
>+	pagestructsize = size_table.page;
>+	hugepagesize = PTRS_PER_PMD * info->page_size;
>+	vaddr_base = info->vmemmap_start;
>+	vaddr = vaddr_base;
>+	max_paddr = get_max_paddr();
>+	/*
>+	 * the page structures are mapped at VMEMMAP_START (info->vmemmap_start)
>+	 * for max_paddr >> 12 page structures
>+	 */
>+	high_pfn = max_paddr >> 12;
>+	pgd_index = pgd4_index(vaddr_base);
>+	pud_index = pud_index(vaddr_base);
>+	pgd_addr = vaddr_to_paddr(init_level4_pgt); /* address of pgd */
>+	pgd_addr += pgd_index * sizeof(unsigned long);
>+	page_structs_per_pud = (PTRS_PER_PUD * PTRS_PER_PMD * info->page_size) /
>+									pagestructsize;
>+	num_puds = (high_pfn + page_structs_per_pud - 1) / page_structs_per_pud;
>+	pvaddr = VMEMMAP_START;
>+	structsperhpage = hugepagesize / pagestructsize;
>+
>+	/* outer loop is for pud entries in the pgd */
>+	for (pgdindex = 0, pgdp = (unsigned long *)pgd_addr; pgdindex < num_puds;
>+								pgdindex++, pgdp++) {
>+		/* read the pgd one word at a time, into pud_addr */
>+		if (!readmem(PADDR, (unsigned long long)pgdp, (void *)&pud_addr,
>+								sizeof(unsigned long))) {
>+			ERRMSG("Can't get pgd entry for slot %d.\n", pgd_index);
>+			return;
>+		}
>+		/* mask the pgd entry for the address of the pud page */
>+		pud_addr &= PMASK;
>+		/* read the entire pud page */
>+		if (!readmem(PADDR, (unsigned long long)pud_addr, (void *)pud_page,
>+					PTRS_PER_PUD * sizeof(unsigned long))) {
>+			ERRMSG("Can't get pud entry for pgd slot %ld.\n", pgdindex);
>+			return;
>+		}
>+		/* step thru each pmd address in the pud page */
>+		/* pudp points to an entry in the pud page */
>+		for (pudp = (unsigned long *)pud_page, pudindex = 0;
>+					pudindex < PTRS_PER_PUD; pudindex++, pudp++) {
>+			pmd_addr = *pudp & PMASK;
>+			/* read the entire pmd page */
>+			if (!readmem(PADDR, pmd_addr, (void *)pmd_page,
>+					PTRS_PER_PMD * sizeof(unsigned long))) {
>+				ERRMSG("Can't get pud entry for slot %ld.\n", pudindex);
>+				return;
>+			}
>+			/* pmdp points to an entry in the pmd */
>+			for (pmdp = (unsigned long *)pmd_page, pmdindex = 0;
>+					pmdindex < PTRS_PER_PMD; pmdindex++, pmdp++) {
>+				/* linear page position in this page table: */
>+				pmd = *pmdp;
>+				num_pmds++;
>+				tpfn = (pvaddr - VMEMMAP_START) /
>+							pagestructsize;
>+				if (tpfn >= high_pfn) {
>+					done = 1;
>+					break;
>+				}
>+				/*
>+				 * vmap_offset_start:
>+				 * Starting logical position in the
>+				 * vmemmap array for the group stays
>+				 * constant until a hole in the table
>+				 * or a break in contiguousness.
>+				 */
>+
>+				/*
>+				 * Ending logical position in the
>+				 * vmemmap array:
>+				 */
>+				vmap_offset_end += hugepagesize;
>+				do_break = 0;
>+				break_in_valids = 0;
>+				break_after_invalids = 0;
>+				/*
>+				 * We want breaks either when:
>+				 * - we hit a hole (invalid)
>+				 * - we discontiguous page is a string of valids
>+				 */
>+				if (pmd) {
>+					data_addr = (pmd & PMASK);
>+					if (start_range) {
>+						/* first-time kludge */
>+						start_data_addr = data_addr;
>+						last_data_addr = start_data_addr
>+							 - hugepagesize;
>+						start_range = 0;
>+					}
>+					if (last_invalid) {
>+						/* end of a hole */
>+						start_data_addr = data_addr;
>+						last_data_addr = start_data_addr
>+							 - hugepagesize;
>+						/* trigger update of offset */
>+						do_break = 1;
>+					}
>+					last_valid = 1;
>+					last_invalid = 0;
>+					/*
>+					 * we have a gap in physical
>+					 * contiguousness in the table.
>+					 */
>+					/* ?? consecutive holes will have
>+					   same data_addr */
>+					if (data_addr !=
>+						last_data_addr + hugepagesize) {
>+						do_break = 1;
>+						break_in_valids = 1;
>+					}
>+					if (verbose)
>+						printf("valid: pud %ld pmd %ld pfn %#lx"
>+							" pvaddr %#lx pfns %#lx-%lx"
>+							" start %#lx end %#lx\n",
>+							pudindex, pmdindex,
>+							data_addr >> 12,
>+							pvaddr, tpfn,
>+					tpfn + structsperhpage - 1,
>+					vmap_offset_start,
>+					vmap_offset_end);
>+					num_pmds_valid++;
>+					if (!(pmd & PSE)) {
>+						printf("vmemmap pmd not huge, abort\n");
>+						exit(1);
>+					}
>+				} else {
>+					if (last_valid) {
>+						/* this a hole after some valids */
>+						do_break = 1;
>+						break_in_valids = 1;
>+						break_after_invalids = 0;
>+					}
>+					last_valid = 0;
>+					last_invalid = 1;
>+					/*
>+					 * There are holes in this sparsely
>+					 * populated table; they are 2MB gaps
>+					 * represented by null pmd entries.
>+					 */
>+					if (verbose)
>+						printf("invalid: pud %ld pmd %ld %#lx"
>+							" pfns %#lx-%lx start %#lx end"
>+							" %#lx\n", pudindex, pmdindex,
>+							pvaddr, tpfn,
>+							tpfn + structsperhpage - 1,
>+							vmap_offset_start,
>+							vmap_offset_end);
>+				}
>+				if (do_break) {
>+					/* The end of a hole is not summarized.
>+					 * It must be the start of a hole or
>+					 * hitting a discontiguous series.
>+					 */
>+					if (break_in_valids || break_after_invalids) {
>+						/*
>+						 * calculate that pfns
>+						 * represented by the current
>+						 * offset in the vmemmap.
>+						 */
>+						/* page struct even partly on this page */
>+						rep_pfn_start = vmap_offset_start /
>+							pagestructsize;
>+						/* ending page struct entirely on
>+ 						   this page */
>+						rep_pfn_end = ((vmap_offset_end -
>+							hugepagesize) / pagestructsize);
>+ 						if (verbose)
>+							printf("vmap pfns %#lx-%lx "
>+							"represent pfns %#lx-%lx\n\n",
>+							start_data_addr >> PAGESHFT,
>+							last_data_addr >> PAGESHFT,
>+							rep_pfn_start, rep_pfn_end);
>+						groups++;
>+						vmapp = (struct vmap_pfns *)malloc(
>+								sizeof(struct vmap_pfns));
>+						/* pfn of this 2MB page of page structs */
>+						vmapp->vmap_pfn_start = start_data_addr
>+									>> PTE_SHIFT;
>+						vmapp->vmap_pfn_end = last_data_addr
>+									>> PTE_SHIFT;
>+						/* these (start/end) are literal pfns
>+ 						 * on this page, not start and end+1 */
>+						vmapp->rep_pfn_start = rep_pfn_start;
>+						vmapp->rep_pfn_end = rep_pfn_end;
>+
>+						if (!vmaphead) {
>+							vmaphead = vmapp;
>+							vmapp->next = vmapp;
>+							vmapp->prev = vmapp;
>+						} else {
>+							tail = vmaphead->prev;
>+							vmaphead->prev = vmapp;
>+							tail->next = vmapp;
>+							vmapp->next = vmaphead;
>+							vmapp->prev = tail;
>+						}
>+					}
>+
>+					/* update logical position at every break */
>+					vmap_offset_start =
>+						vmap_offset_end - hugepagesize;
>+					start_data_addr = data_addr;
>+				}
>+
>+				last_data_addr = data_addr;
>+				pvaddr += hugepagesize;
>+				/*
>+				 * pvaddr is current virtual address
>+				 *   eg 0xffffea0004200000 if
>+				 *    vmap_offset_start is 4200000
>+				 */
>+			}
>+		}
>+		tpfn = (pvaddr - VMEMMAP_START) / pagestructsize;
>+		if (tpfn >= high_pfn) {
>+			done = 1;
>+			break;
>+		}
>+	}
>+	rep_pfn_start = vmap_offset_start / pagestructsize;
>+	rep_pfn_end = (vmap_offset_end - hugepagesize) / pagestructsize;
>+ 	if (verbose)
>+		printf("vmap pfns %#lx-%lx represent pfns %#lx-%lx\n\n",
>+			start_data_addr >> PAGESHFT, last_data_addr >> PAGESHFT,
>+			rep_pfn_start, rep_pfn_end);
>+	groups++;
>+	vmapp = (struct vmap_pfns *)malloc(sizeof(struct vmap_pfns));
>+	vmapp->vmap_pfn_start = start_data_addr >> PTE_SHIFT;
>+	vmapp->vmap_pfn_end = last_data_addr >> PTE_SHIFT;
>+	vmapp->rep_pfn_start = rep_pfn_start;
>+	vmapp->rep_pfn_end = rep_pfn_end;
>+	if (!vmaphead) {
>+		vmaphead = vmapp;
>+		vmapp->next = vmapp;
>+		vmapp->prev = vmapp;
>+	} else {
>+		tail = vmaphead->prev;
>+		vmaphead->prev = vmapp;
>+		tail->next = vmapp;
>+		vmapp->next = vmaphead;
>+		vmapp->prev = tail;
>+	}
>+	if (verbose)
>+		printf("num_pmds: %d num_pmds_valid %d\n", num_pmds, num_pmds_valid);
>+
>+	/* transfer the linked list to an array */
>+	cur = vmaphead;
>+	gvmem_pfns = (struct vmap_pfns *)malloc(sizeof(struct vmap_pfns) * groups);
>+	i = 0;
>+	do {
>+		vmapp = gvmem_pfns + i;
>+		vmapp->vmap_pfn_start = cur->vmap_pfn_start;
>+		vmapp->vmap_pfn_end = cur->vmap_pfn_end;
>+		vmapp->rep_pfn_start = cur->rep_pfn_start;
>+		vmapp->rep_pfn_end = cur->rep_pfn_end;
>+		cur = cur->next;
>+		free(cur->prev);
>+		i++;
>+	} while (cur != vmaphead);
>+	nr_gvmem_pfns = i;
>+}
>+
> int
> create_dumpfile(void)
> {
>@@ -9195,9 +9837,16 @@ create_dumpfile(void)
> 		if (!get_elf_info(info->fd_memory, info->name_memory))
> 			return FALSE;
> 	}
>+	blocksize = info->page_size;
>+	if (!blocksize)
>+		blocksize = sysconf(_SC_PAGE_SIZE);
> 	if (!initial())
> 		return FALSE;
>
>+	/* create an array of translations from pfn to vmemmap pages */
>+	if (excludevmflag)
>+		find_vmemmap();
>+
> 	print_vtop();
>
> 	num_retry = 0;
>@@ -10418,7 +11067,7 @@ main(int argc, char *argv[])
>
> 	info->block_order = DEFAULT_ORDER;
> 	message_level = DEFAULT_MSG_LEVEL;
>-	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lpRvXx:", longopts,
>+	while ((opt = getopt_long(argc, argv, "b:cDd:eEFfg:hi:lpRvXx:", longopts,
> 	    NULL)) != -1) {
> 		switch (opt) {
> 		case OPT_BLOCK_ORDER:
>@@ -10462,6 +11111,10 @@ main(int argc, char *argv[])
> 			info->flag_read_vmcoreinfo = 1;
> 			info->name_vmcoreinfo = optarg;
> 			break;
>+		case OPT_EXCLUDE_UNUSED_VM:
>+			excludevmflag = 1;		/* exclude unused vmemmap pages */
>+			info->flag_cyclic = FALSE;	/* force create_2nd_bitmap */
>+			break;
> 		case OPT_DISKSET:
> 			if (!sadump_add_diskset_info(optarg))
> 				goto out;
>@@ -10540,6 +11193,12 @@ main(int argc, char *argv[])
> 	if (flag_debug)
> 		message_level |= ML_PRINT_DEBUG_MSG;
>
>+	if (excludevmflag && !info->working_dir) {
>+		MSG("\nError: -%c requires --work-dir\n", OPT_EXCLUDE_UNUSED_VM);

This message is good (but should be ERRMSG()), but

>+		print_usage();

it will be buried in *a flood of help message*.
Users may get confused that what is wrong, I think a simple message like
"Try `makedumpfile --help' for more information" is better.


Thanks,
Atsushi Kumagai

>+		return COMPLETED;
>+	}
>+
> 	if (info->flag_show_usage) {
> 		print_usage();
> 		return COMPLETED;
>Index: code/diskdump_mod.h
>===================================================================
>--- code.orig/diskdump_mod.h
>+++ code/diskdump_mod.h
>@@ -97,6 +97,7 @@ struct kdump_sub_header {
> 					/* paged is compressed with snappy */
> #define DUMP_DH_COMPRESSED_INCOMPLETE	0x8
> 					/* indicate an incomplete dumpfile */
>+#define DUMP_DH_EXCLUDED_VMEMMAP 0x10	/* unused vmemmap pages are excluded */
>
> /* descriptor of each page for vmcore */
> typedef struct page_desc {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

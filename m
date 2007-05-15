Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Ho5Cj-00027q-Hn
	for kexec@lists.infradead.org; Tue, 15 May 2007 18:10:42 -0400
Date: Wed, 16 May 2007 00:08:45 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] [makedumpfile] Implement memory regions on IA64
Message-ID: <20070515220845.GB823@suse.de>
References: <20070426193725.GA2586@suse.de>
	<20070511155950oomichi@mail.jp.nec.com>
	<20070514181521.GA1748@suse.de> <20070514214956.GA31603@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070514214956.GA31603@suse.de>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Jay Lan <jlan@sgi.com>, Kexec Mailing List <kexec@lists.infradead.org>

Hello,

* Bernhard Walle <bwalle@suse.de> [2007-05-14 23:49]:
> 
> I'm working on support for the 4 layer pagetable.

Here's my first attempt. It works with SLES 10, SP1 on a Tiger4
machine with 16 GiB of memory. (I had still problems with a big
SGI machine when creating the bitmap. I'm investigating this, too.)

The problem is not to implement the 4 layer page table, but to
*detect* it. crash uses the built-in configuration data in the kernel
image, and that's what I used in my patch. If you have a better and
still reliable method, I'm open to suggestions. :-)

Also, I only use the page table translation when the memory is
vmalloc'd. That's the same way crash does it and that should be
well-tested.

The patch requires your two patches. Please give me your feedback!
And I hope I didn't accidentally break the 3 layer page table.


Thanks,
   Bernhard



---
 ia64.c         |  148 +++++++++++++++++++++++++++++++++++++++++++++---
 makedumpfile.c |  174 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |   43 +++++++++++++-
 3 files changed, 354 insertions(+), 11 deletions(-)

--- a/ia64.c
+++ b/ia64.c
@@ -3,6 +3,9 @@
  *
  * Copyright (C) 2006  NEC Corporation
  *
+ * Some parts are taken and adapted from the crash-utility,
+ * (c) by RedHat Inc.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -17,6 +20,18 @@
 
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
@@ -51,18 +66,80 @@ get_machdep_info_ia64(struct DumpInfo *i
 }
 
 unsigned long
-ia64_vtop(struct DumpInfo *info, unsigned long long vaddr)
+ia64_vtop3(struct DumpInfo *info, unsigned long long vaddr)
 {
 	unsigned long paddr = 0, temp, page_dir, pgd_pte, page_middle, pmd_pte;
 	unsigned long page_table, pte;
 
-	if (VADDR_REGION(vaddr) != KERNEL_VMALLOC_REGION) {
-		ERRMSG("vaddr(%llx) is not KERNEL_VMALLOC_REGION.\n", vaddr);
+
+	/*
+	 * Translate a virtual address to a physical address
+	 * by using Layer 3 paging.
+	 */
+	if (SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of swapper_pg_dir.\n");
 		return paddr;
 	}
-	paddr = vaddr_to_paddr(info, vaddr);
-	if (paddr)
+
+	/*
+	 * Get PGD
+	 */
+	temp = vaddr & MASK_PGD_3L;
+	temp = temp >> (PGDIR_SHIFT_3L - 3);
+	page_dir = SYMBOL(swapper_pg_dir) + temp;
+	if (!readmem(info, page_dir, &pgd_pte, sizeof pgd_pte)) {
+		ERRMSG("Can't get pgd_pte (page_dir:%lx).\n", page_dir);
 		return paddr;
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
+		return paddr;
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
+		return paddr;
+	}
+
+	/*
+	 * Get physical address
+	 */
+	temp = vaddr & MASK_POFFSET;
+	paddr = (pte & _PAGE_PPN_MASK) + temp;
+	if (info->flag_debug) {
+		MSG("vaddr:%llx -> paddr:%lx\n", vaddr, paddr);
+	}
+
+	return paddr;
+}
+
+unsigned long
+ia64_vtop4(struct DumpInfo *info, unsigned long long vaddr)
+{
+	unsigned long paddr = 0, temp, page_dir, pgd_pte, page_upper,
+		      pud_pte, page_middle, pmd_pte;
+	unsigned long page_table, pte;
 
 	/*
 	 * Translate a virtual address to a physical address
@@ -76,8 +153,8 @@ ia64_vtop(struct DumpInfo *info, unsigne
 	/*
 	 * Get PGD
 	 */
-	temp = vaddr & MASK_PGD;
-	temp = temp >> (PGDIR_SHIFT - 3);
+	temp = vaddr & MASK_PGD_4L;
+	temp = temp >> (PGDIR_SHIFT_4L - 3);
 	page_dir = SYMBOL(swapper_pg_dir) + temp;
 	if (!readmem(info, page_dir, &pgd_pte, sizeof pgd_pte)) {
 		ERRMSG("Can't get pgd_pte (page_dir:%lx).\n", page_dir);
@@ -85,11 +162,26 @@ ia64_vtop(struct DumpInfo *info, unsigne
 	}
 
 	/*
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
+		return paddr;
+	}
+
+	/*
 	 * Get PMD
 	 */
 	temp = vaddr & MASK_PMD;
 	temp = temp >> (PMD_SHIFT - 3);
-	page_middle = pgd_pte + temp;
+	page_middle = pud_pte + temp;
 	/*
 	 * Convert physical address to virtual address
 	 */
@@ -126,6 +218,30 @@ ia64_vtop(struct DumpInfo *info, unsigne
 	return paddr;
 }
 
+unsigned long
+ia64_vtop(struct DumpInfo *info, unsigned long long vaddr)
+{
+	unsigned long paddr = 0;
+
+	if (VADDR_REGION(vaddr) != KERNEL_VMALLOC_REGION) {
+		ERRMSG("vaddr(%llx) is not KERNEL_VMALLOC_REGION.\n", vaddr);
+		return paddr;
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
+	if (info->mem_flags & MEMORY_4LAYER_PAGETABLE)
+		return ia64_vtop4(info, vaddr);
+	else
+		return ia64_vtop3(info, vaddr);
+}
 
 /*
  * Convert Virtual Address to File Offest.
@@ -170,5 +286,21 @@ vaddr_to_offset_ia64(struct DumpInfo *in
 	return offset;
 }
 
+int
+get_machdep_kernel_start_ia64(struct DumpInfo *info)
+{
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
+	return TRUE;
+}
+
 #endif /* ia64 */
 
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1420,6 +1420,174 @@ get_symbol_info(struct DumpInfo *info)
 	return TRUE;
 }
 
+
+int
+read_kernel_config(struct DumpInfo *info)
+{
+	int ii, ret, end, found=0;
+	unsigned long size, bufsz;
+	char *pos, *ln, *buf, *head, *tail, *val, *uncomp;
+	char line[512];
+	z_stream stream;
+	unsigned long kernel_config_data;
+
+	kernel_config_data = get_symbol_addr(info, "kernel_config_data");
+	if (kernel_config_data <= 0) {
+		ERRMSG("Can't read kernel cofiguration from kernel binary");
+		return FALSE;
+	}
+
+	/* We don't know how large IKCONFIG is, so we start with
+	 * 32k, if we can't find MAGIC_END assume we didn't read
+	 * enough, double it and try again.
+	 */
+	ii = 32;
+
+again:
+	size = ii * 1024;
+
+	if ((buf = (char *)malloc(size)) == NULL) {
+		MSG("cannot malloc IKCONFIG input buffer\n");
+		return FALSE;
+	}
+
+        if (!readmem(info, kernel_config_data, buf, size)) {
+		MSG("cannot read kernel_config_data\n");
+		goto out2;
+	}
+
+	/* Find the start */
+	if (strstr(buf, MAGIC_START))
+		head = buf + MAGIC_SIZE + 10; /* skip past MAGIC_START and gzip header */
+	else {
+		MSG("could not find MAGIC_START!\n");
+		goto out2;
+	}
+
+	tail = head;
+
+	end = strlen(MAGIC_END);
+
+	/* Find the end*/
+	while (tail < (buf + (size - 1))) {
+
+		if (strncmp(tail, MAGIC_END, end)==0) {
+			found = 1;
+			break;
+		}
+		tail++;
+	}
+
+	if (found) {
+		bufsz = tail - head;
+		size = 10 * bufsz;
+		if ((uncomp = (char *)malloc(size)) == NULL) {
+			MSG("cannot malloc IKCONFIG output buffer\n");
+			goto out2;
+		}
+	} else {
+		if (ii > 512) {
+			MSG("could not find MAGIC_END!\n");
+			goto out2;
+		} else {
+			free(buf);
+			ii *= 2;
+			goto again;
+		}
+	}
+
+
+	/* initialize zlib */
+	stream.next_in = (Bytef *)head;
+	stream.avail_in = (uInt)bufsz;
+
+	stream.next_out = (Bytef *)uncomp;
+	stream.avail_out = (uInt)size;
+
+	stream.zalloc = NULL;
+	stream.zfree = NULL;
+	stream.opaque = NULL;
+
+	ret = inflateInit2(&stream, -MAX_WBITS);
+	if (ret != Z_OK) {
+		ERRMSG("error while reading kernel config, inflateInit2 "
+				"returned %d\n", ret);
+		goto out1;
+	}
+
+	ret = inflate(&stream, Z_FINISH);
+
+	if (ret != Z_STREAM_END) {
+		inflateEnd(&stream);
+		if (ret == Z_NEED_DICT ||
+		   (ret == Z_BUF_ERROR && stream.avail_in == 0)) {
+			ERRMSG("error while reading kernel config, stream.avail_in = 0,"
+					"inflate returned %d\n", ret);
+			goto out1;
+		}
+		ERRMSG("error while reading kernel config, inflate returned"
+				"with %d\n", ret);
+		goto out1;
+	}
+	size = stream.total_out;
+
+	ret = inflateEnd(&stream);
+
+	pos = uncomp;
+
+	do {
+		ret = sscanf(pos, "%511[^\n]\n%n", line, &ii);
+		if (ret > 0) {
+			pos += ii;
+
+			ln = line;
+
+			/* skip leading whitespace */
+			while (is_blank(*ln))
+				ln++;
+
+			/* skip comments */
+			if (*ln == '#')
+				continue;
+
+			/* Find '=' */
+			if ((head = strchr(ln, '=')) != NULL) {
+				*head = '\0';
+				val = head + 1;
+
+				head--;
+
+				/* skip trailing whitespace */
+				while (is_blank(*head)) {
+					*head = '\0';
+					head--;
+				}
+
+				/* skip whitespace */
+				while (is_blank(*val))
+					val++;
+
+			} else /* Bad line, skip it */
+				continue;
+
+			if (strcmp(ln, "CONFIG_PGTABLE_4") == 0)
+				info->mem_flags |= MEMORY_4LAYER_PAGETABLE;
+		}
+	} while (ret > 0);
+
+
+	free(uncomp);
+	free(buf);
+	return TRUE;
+
+out1:
+	free(uncomp);
+out2:
+	free(buf);
+
+	return FALSE;
+}
+
 int
 get_structure_info(struct DumpInfo *info)
 {
@@ -2289,9 +2457,15 @@ initial(struct DumpInfo *info)
 			return FALSE;
 	}
 
+	if (!get_machdep_kernel_start(info))
+		return FALSE;
+
 	if (!check_release(info))
 		return FALSE;
 
+	if (!read_kernel_config(info))
+		return FALSE;
+
 	if (!get_machdep_info(info))
 		return FALSE;
 
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -29,6 +29,7 @@
 #include <libelf.h>
 #include <dwarf.h>
 #include <byteswap.h>
+#include <ctype.h>
 #include "diskdump_mod.h"
 
 /*
@@ -64,6 +65,19 @@ enum {
 #define LSEEKED_PDESC	(2)
 #define LSEEKED_PDATA	(3)
 
+/*
+ * Flags
+ */
+#define MEMORY_4LAYER_PAGETABLE	(1 << 0)
+
+/*
+ * For kernel configuration
+ */
+#define MAGIC_START  "IKCFG_ST"
+#define MAGIC_END    "IKCFG_ED"
+#define MAGIC_SIZE   (sizeof(MAGIC_START) - 1)
+
+
 static inline int
 test_bit(int nr, unsigned long addr)
 {
@@ -73,6 +87,12 @@ test_bit(int nr, unsigned long addr)
 	return ((mask & addr) != 0);
 }
 
+static inline int
+is_blank(int c)
+{
+	return c == ' ' || c == '\t';
+}
+
 #define isLRU(flags)		test_bit(PG_lru, flags)
 #define isPrivate(flags)	test_bit(PG_private, flags)
 #define isSwapCache(flags)	test_bit(PG_swapcache, flags)
@@ -376,12 +396,21 @@ do { \
 #define PTRS_PER_PTD_SHIFT	(PAGE_SHIFT - 3)
 
 #define PMD_SHIFT		(PAGE_SHIFT + PTRS_PER_PTD_SHIFT)
-#define PGDIR_SHIFT		(PMD_SHIFT  + PTRS_PER_PTD_SHIFT)
+#define PGDIR_SHIFT_3L		(PMD_SHIFT  + PTRS_PER_PTD_SHIFT)
 
 #define MASK_POFFSET	((1UL << PAGE_SHIFT) - 1)
 #define MASK_PTE	((1UL << PMD_SHIFT) - 1) &~((1UL << PAGE_SHIFT) - 1)
-#define MASK_PMD	((1UL << PGDIR_SHIFT) - 1) &~((1UL << PMD_SHIFT) - 1)
-#define MASK_PGD	((1UL << REGION_SHIFT) - 1) & (~((1UL << PGDIR_SHIFT) - 1))
+#define MASK_PMD	((1UL << PGDIR_SHIFT_3L) - 1) &~((1UL << PMD_SHIFT) - 1)
+#define MASK_PGD_3L	((1UL << REGION_SHIFT) - 1) & (~((1UL << PGDIR_SHIFT_3L) - 1))
+
+/*
+ * Layer 4 paging
+ */
+#define PUD_SHIFT		(PMD_SHIFT + PTRS_PER_PTD_SHIFT)
+#define PGDIR_SHIFT_4L		(PUD_SHIFT + PTRS_PER_PTD_SHIFT)
+
+#define MASK_PUD   	((1UL << REGION_SHIFT) - 1) & (~((1UL << PUD_SHIFT) - 1))
+#define MASK_PGD_4L	((1UL << REGION_SHIFT) - 1) & (~((1UL << PGDIR_SHIFT_4L) - 1))
 
 #endif          /* ia64 */
 
@@ -393,6 +422,7 @@ int get_machdep_info_x86();
 #define get_phys_base(X)	TRUE
 #define get_machdep_info(X)	get_machdep_info_x86(X)
 #define vaddr_to_offset(X, Y)	vaddr_to_offset_general(X,Y)
+#define get_machdep_kernel_start(X)	TRUE
 #endif /* x86 */
 
 #ifdef __x86_64__
@@ -402,6 +432,7 @@ off_t vaddr_to_offset_x86_64();
 #define get_phys_base(X)	get_phys_base_x86_64(X)
 #define get_machdep_info(X)	get_machdep_info_x86_64(X)
 #define vaddr_to_offset(X, Y)	vaddr_to_offset_x86_64(X, Y)
+#define get_machdep_kernel_start(X)	TRUE
 #endif /* x86_64 */
 
 #ifdef __powerpc__ /* powerpc */
@@ -409,16 +440,19 @@ int get_machdep_info_ppc64();
 #define get_machdep_info(X)	get_machdep_info_ppc64(X)
 #define get_phys_base(X)	TRUE
 #define vaddr_to_offset(X, Y)	vaddr_to_offset_general(X, Y)
+#define get_machdep_kernel_start(X)	TRUE
 #endif          /* powerpc */
 
 #ifdef __ia64__ /* ia64 */
 int get_phys_base_ia64();
 int get_machdep_info_ia64();
+int get_machdep_kernel_start_ia64();
 off_t vaddr_to_offset_ia64();
 #define get_machdep_info(X)	get_machdep_info_ia64(X)
 #define get_phys_base(X)	get_phys_base_ia64(X)
 #define vaddr_to_offset(X, Y)	vaddr_to_offset_ia64(X, Y)
 #define VADDR_REGION(X)		(((unsigned long)(X)) >> REGION_SHIFT)
+#define get_machdep_kernel_start(X)	get_machdep_kernel_start_ia64(X)
 #endif          /* ia64 */
 
 #define MSG(x...)	fprintf(stderr, x)
@@ -509,6 +543,8 @@ struct DumpInfo {
 	unsigned long   max_physmem_bits;
 	unsigned long   sections_per_root;
 	unsigned long	phys_base;
+	unsigned long   kernel_start;
+	unsigned long   vmalloc_start;
 
 	/*
 	 * diskdimp info:
@@ -532,6 +568,7 @@ struct DumpInfo {
 	 */
 	unsigned int		num_mem_map;
 	struct mem_map_data	*mem_map_data;
+	unsigned int		mem_flags;
 
 	/*
 	 * Dump memory image info:

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

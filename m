Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YrhQj-0007OS-KU
 for kexec@lists.infradead.org; Mon, 11 May 2015 06:43:11 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6gl7X008775
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:42:47 +0900 (JST)
Received: from mailsv4.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id t4B6gl716556 for <kexec@lists.infradead.org>;
 Mon, 11 May 2015 15:42:47 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6glUd013553
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:42:47 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 08/13] Remove the old logic of writing ELF pages.
Date: Mon, 11 May 2015 06:29:49 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA36C@BPXM01GP.gisp.nec.co.jp>
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

write_elf_pages() and related functions are no longer used,
remove them.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c | 297 ---------------------------------------------------------
 1 file changed, 297 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 7993e1d..c162cbc 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4724,58 +4724,6 @@ create_1st_bitmap(struct cycle *cycle)
  * Exclude the page filled with zero in case of creating an elf dumpfile.
  */
 int
-exclude_zero_pages(void)
-{
-	mdf_pfn_t pfn;
-	unsigned long long paddr;
-	struct dump_bitmap bitmap2;
-	struct timeval tv_start;
-	unsigned char buf[info->page_size];
-
-	initialize_2nd_bitmap(&bitmap2);
-
-	gettimeofday(&tv_start, NULL);
-
-	for (pfn = 0, paddr = pfn_to_paddr(pfn); pfn < info->max_mapnr;
-	    pfn++, paddr += info->page_size) {
-
-		print_progress(PROGRESS_ZERO_PAGES, pfn, info->max_mapnr);
-
-		if (!is_in_segs(paddr))
-			continue;
-
-		if (!is_dumpable(&bitmap2, pfn, NULL))
-			continue;
-
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
-		}
-		if (is_zero_page(buf, info->page_size)) {
-			if (clear_bit_on_2nd_bitmap(pfn, NULL))
-				pfn_zero++;
-		}
-	}
-
-	/*
-	 * print [100 %]
-	 */
-	print_progress(PROGRESS_ZERO_PAGES, info->max_mapnr, info->max_mapnr);
-	print_execution_time(PROGRESS_ZERO_PAGES, &tv_start);
-
-	return TRUE;
-}
-
-int
 exclude_zero_pages_cyclic(struct cycle *cycle)
 {
 	mdf_pfn_t pfn;
@@ -5428,60 +5376,6 @@ out:
 }
 
 int
-get_loads_dumpfile(void)
-{
-	int i, phnum, num_new_load = 0;
-	long page_size = info->page_size;
-	mdf_pfn_t pfn, pfn_start, pfn_end, num_excluded;
-	unsigned long frac_head, frac_tail;
-	Elf64_Phdr load;
-	struct dump_bitmap bitmap2;
-
-	initialize_2nd_bitmap(&bitmap2);
-
-	if (!(phnum = get_phnum_memory()))
-		return FALSE;
-
-	for (i = 0; i < phnum; i++) {
-		if (!get_phdr_memory(i, &load))
-			return FALSE;
-		if (load.p_type != PT_LOAD)
-			continue;
-
-		pfn_start = paddr_to_pfn(load.p_paddr);
-		pfn_end   = paddr_to_pfn(load.p_paddr + load.p_memsz);
-		frac_head = page_size - (load.p_paddr % page_size);
-		frac_tail = (load.p_paddr + load.p_memsz) % page_size;
-
-		num_new_load++;
-		num_excluded = 0;
-
-		if (frac_head && (frac_head != page_size))
-			pfn_start++;
-		if (frac_tail)
-			pfn_end++;
-
-		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
-			if (!is_dumpable(&bitmap2, pfn, NULL)) {
-				num_excluded++;
-				continue;
-			}
-
-			/*
-			 * If the number of the contiguous pages to be excluded
-			 * is 256 or more, those pages are excluded really.
-			 * And a new PT_LOAD segment is created.
-			 */
-			if (num_excluded >= PFN_EXCLUDED) {
-				num_new_load++;
-			}
-			num_excluded = 0;
-		}
-	}
-	return num_new_load;
-}
-
-int
 prepare_cache_data(struct cache_data *cd)
 {
 	cd->fd         = info->fd_dumpfile;
@@ -6116,197 +6010,6 @@ write_elf_load_segment(struct cache_data *cd_page, unsigned long long paddr,
 }
 
 int
-write_elf_pages(struct cache_data *cd_header, struct cache_data *cd_page)
-{
-	int i, phnum;
-	long page_size = info->page_size;
-	mdf_pfn_t pfn, pfn_start, pfn_end, num_excluded;
-	unsigned long long paddr;
-	mdf_pfn_t num_dumpable, per;
-	unsigned long long memsz, filesz;
-	unsigned long frac_head, frac_tail;
-	off_t off_seg_load, off_memory;
-	Elf64_Phdr load;
-	struct dump_bitmap bitmap2;
-	struct timeval tv_start;
-
-	if (!info->flag_elf_dumpfile)
-		return FALSE;
-
-	initialize_2nd_bitmap(&bitmap2);
-
-	num_dumpable = get_num_dumpable();
-	per = num_dumpable / 10000;
-	per = per ? per : 1;
-
-	off_seg_load    = info->offset_load_dumpfile;
-	cd_page->offset = info->offset_load_dumpfile;
-
-	if (!(phnum = get_phnum_memory()))
-		return FALSE;
-
-	gettimeofday(&tv_start, NULL);
-
-	for (i = 0; i < phnum; i++) {
-		if (!get_phdr_memory(i, &load))
-			return FALSE;
-
-		if (load.p_type != PT_LOAD)
-			continue;
-
-		off_memory= load.p_offset;
-		paddr     = load.p_paddr;
-		pfn_start = paddr_to_pfn(load.p_paddr);
-		pfn_end   = paddr_to_pfn(load.p_paddr + load.p_memsz);
-		frac_head = page_size - (load.p_paddr % page_size);
-		frac_tail = (load.p_paddr + load.p_memsz)%page_size;
-
-		num_excluded = 0;
-		memsz  = 0;
-		filesz = 0;
-		if (frac_head && (frac_head != page_size)) {
-			memsz  = frac_head;
-			filesz = frac_head;
-			pfn_start++;
-		}
-
-		if (frac_tail)
-			pfn_end++;
-
-		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
-			if (!is_dumpable(&bitmap2, pfn, NULL)) {
-				num_excluded++;
-				if ((pfn == pfn_end - 1) && frac_tail)
-					memsz += frac_tail;
-				else
-					memsz += page_size;
-				continue;
-			}
-
-			if ((num_dumped % per) == 0)
-				print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
-
-			num_dumped++;
-
-			/*
-			 * The dumpable pages are continuous.
-			 */
-			if (!num_excluded) {
-				if ((pfn == pfn_end - 1) && frac_tail) {
-					memsz  += frac_tail;
-					filesz += frac_tail;
-				} else {
-					memsz  += page_size;
-					filesz += page_size;
-				}
-				continue;
-			/*
-			 * If the number of the contiguous pages to be excluded
-			 * is 255 or less, those pages are not excluded.
-			 */
-			} else if (num_excluded < PFN_EXCLUDED) {
-				if ((pfn == pfn_end - 1) && frac_tail) {
-					memsz  += frac_tail;
-					filesz += (page_size*num_excluded
-					    + frac_tail);
-				}else {
-					memsz  += page_size;
-					filesz += (page_size*num_excluded
-					    + page_size);
-				}
-				num_excluded = 0;
-				continue;
-			}
-
-			/*
-			 * If the number of the contiguous pages to be excluded
-			 * is 256 or more, those pages are excluded really.
-			 * And a new PT_LOAD segment is created.
-			 */
-			load.p_memsz  = memsz;
-			load.p_filesz = filesz;
-			if (load.p_filesz)
-				load.p_offset = off_seg_load;
-			else
-				/*
-				 * If PT_LOAD segment does not have real data
-				 * due to the all excluded pages, the file
-				 * offset is not effective and it should be 0.
-				 */
-				load.p_offset = 0;
-
-			/*
-			 * Write a PT_LOAD header.
-			 */
-			if (!write_elf_phdr(cd_header, &load))
-				return FALSE;
-
-			/*
-			 * Write a PT_LOAD segment.
-			 */
-			if (load.p_filesz)
-				if (!write_elf_load_segment(cd_page, paddr,
-				    off_memory, load.p_filesz))
-					return FALSE;
-
-			load.p_paddr += load.p_memsz;
-#ifdef __x86__
-			/*
-			 * FIXME:
-			 *  (x86) Fill PT_LOAD headers with appropriate
-			 *        virtual addresses.
-			 */
-			if (load.p_paddr < MAXMEM)
-				load.p_vaddr += load.p_memsz;
-#else
-			load.p_vaddr += load.p_memsz;
-#endif /* x86 */
-			paddr  = load.p_paddr;
-			off_seg_load += load.p_filesz;
-
-			num_excluded = 0;
-			memsz  = page_size;
-			filesz = page_size;
-		}
-		/*
-		 * Write the last PT_LOAD.
-		 */
-		load.p_memsz  = memsz;
-		load.p_filesz = filesz;
-		load.p_offset = off_seg_load;
-
-		/*
-		 * Write a PT_LOAD header.
-		 */
-		if (!write_elf_phdr(cd_header, &load))
-			return FALSE;
-
-		/*
-		 * Write a PT_LOAD segment.
-		 */
-		if (load.p_filesz)
-			if (!write_elf_load_segment(cd_page, paddr,
-						    off_memory, load.p_filesz))
-				return FALSE;
-
-		off_seg_load += load.p_filesz;
-	}
-	if (!write_cache_bufsz(cd_header))
-		return FALSE;
-	if (!write_cache_bufsz(cd_page))
-		return FALSE;
-
-	/*
-	 * print [100 %]
-	 */
-	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable);
-	print_execution_time(PROGRESS_COPY, &tv_start);
-	PROGRESS_MSG("\n");
-
-	return TRUE;
-}
-
-int
 read_pfn(mdf_pfn_t pfn, unsigned char *buf)
 {
 	unsigned long long paddr;
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

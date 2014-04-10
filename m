Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WY9sg-0005AH-I5
 for kexec@lists.infradead.org; Thu, 10 Apr 2014 07:58:45 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [RFC PATCH]: merge identical code
Date: Thu, 10 Apr 2014 07:56:35 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971FFF3A@BPXM01GP.gisp.nec.co.jp>
References: <20140408123131.GA10111@kernel-host>
In-Reply-To: <20140408123131.GA10111@kernel-host>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "wangnan0@huawei.com" <wangnan0@huawei.com>
Cc: "horms@verge.net.au" <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "hui.geng@huawei.com" <hui.geng@huawei.com>

Hello Wang,

>Hi Kumagai,
>
>I found that in makedumpfile.c, there are many code like following:
>
>  if (info->flag_cyclic) {
>      proc_cyclic();
>  } else {
>      proc();
>  }
>
>The logical and code of proc_cyclic and proc are nearly identical.
>
>Do you want to merge them together?

Yes, I think we should do this work.

However, the similarity of them will be reduced since how to update
cyclic region is going to be changed in v1.5.6.
If you can carry out this work also for v1.5.6, I'll accept it.

You can use the current devel branch because it's almost v1.5.6.
(Formally, v1.5.6 will be released next week.)

https://sourceforge.net/p/makedumpfile/code/ci/devel/tree/


Thanks
Atsushi Kumagai

>
>Here is a patch merge write_elf_pages and write_elf_pages_cyclic, reduce
>nearly 200 lines of code.
>
>--->8---
>
From a95adc6debb0a6c0e0ecf0d402cbc28c5407d3a2 Mon Sep 17 00:00:00 2001
>From: Wang Nan <wangnan0@huawei.com>
>Date: Tue, 8 Apr 2014 20:12:52 +0800
>Subject: [PATCH] makedumpfile: merge write_elf_pages and _cyclic version
>
>In original code, both logic and code of write_elf_pages and
>write_elf_pages_cyclic are (nearly) identical. This patch merges them
>together.
>
>Signed-off-by: Wang Nan <wangnan0@huawei.com>
>Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>Cc: kexec@lists.infradead.org
>Cc: Geng Hui <hui.geng@huawei.com>
>Cc: Simon Horman <horms@verge.net.au>
>---
> makedumpfile.c |  224 +++++---------------------------------------------------
> 1 files changed, 20 insertions(+), 204 deletions(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index d71977a..d0a577d 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -5601,196 +5601,6 @@ write_elf_load_segment(struct cache_data *cd_page, unsigned long long paddr,
> }
>
> int
>-write_elf_pages(struct cache_data *cd_header, struct cache_data *cd_page)
>-{
>-	int i, phnum;
>-	long page_size = info->page_size;
>-	unsigned long long pfn, pfn_start, pfn_end, paddr, num_excluded;
>-	unsigned long long num_dumpable, per;
>-	unsigned long long memsz, filesz;
>-	unsigned long frac_head, frac_tail;
>-	off_t off_seg_load, off_memory;
>-	Elf64_Phdr load;
>-	struct dump_bitmap bitmap2;
>-	struct timeval tv_start;
>-
>-	if (!info->flag_elf_dumpfile)
>-		return FALSE;
>-
>-	initialize_2nd_bitmap(&bitmap2);
>-
>-	num_dumpable = get_num_dumpable();
>-	per = num_dumpable / 10000;
>-	per = per ? per : 1;
>-
>-	off_seg_load    = info->offset_load_dumpfile;
>-	cd_page->offset = info->offset_load_dumpfile;
>-
>-	if (!(phnum = get_phnum_memory()))
>-		return FALSE;
>-
>-	gettimeofday(&tv_start, NULL);
>-
>-	for (i = 0; i < phnum; i++) {
>-		if (!get_phdr_memory(i, &load))
>-			return FALSE;
>-
>-		if (load.p_type != PT_LOAD)
>-			continue;
>-
>-		off_memory= load.p_offset;
>-		paddr     = load.p_paddr;
>-		pfn_start = paddr_to_pfn(load.p_paddr);
>-		pfn_end   = paddr_to_pfn(load.p_paddr + load.p_memsz);
>-		frac_head = page_size - (load.p_paddr % page_size);
>-		frac_tail = (load.p_paddr + load.p_memsz)%page_size;
>-
>-		num_excluded = 0;
>-		memsz  = 0;
>-		filesz = 0;
>-		if (frac_head && (frac_head != page_size)) {
>-			memsz  = frac_head;
>-			filesz = frac_head;
>-			pfn_start++;
>-		}
>-
>-		if (frac_tail)
>-			pfn_end++;
>-
>-		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
>-			if (!is_dumpable(&bitmap2, pfn)) {
>-				num_excluded++;
>-				if ((pfn == pfn_end - 1) && frac_tail)
>-					memsz += frac_tail;
>-				else
>-					memsz += page_size;
>-				continue;
>-			}
>-
>-			if ((num_dumped % per) == 0)
>-				print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
>-
>-			num_dumped++;
>-
>-			/*
>-			 * The dumpable pages are continuous.
>-			 */
>-			if (!num_excluded) {
>-				if ((pfn == pfn_end - 1) && frac_tail) {
>-					memsz  += frac_tail;
>-					filesz += frac_tail;
>-				} else {
>-					memsz  += page_size;
>-					filesz += page_size;
>-				}
>-				continue;
>-			/*
>-			 * If the number of the contiguous pages to be excluded
>-			 * is 255 or less, those pages are not excluded.
>-			 */
>-			} else if (num_excluded < PFN_EXCLUDED) {
>-				if ((pfn == pfn_end - 1) && frac_tail) {
>-					memsz  += frac_tail;
>-					filesz += (page_size*num_excluded
>-					    + frac_tail);
>-				}else {
>-					memsz  += page_size;
>-					filesz += (page_size*num_excluded
>-					    + page_size);
>-				}
>-				num_excluded = 0;
>-				continue;
>-			}
>-
>-			/*
>-			 * If the number of the contiguous pages to be excluded
>-			 * is 256 or more, those pages are excluded really.
>-			 * And a new PT_LOAD segment is created.
>-			 */
>-			load.p_memsz  = memsz;
>-			load.p_filesz = filesz;
>-			if (load.p_filesz)
>-				load.p_offset = off_seg_load;
>-			else
>-				/*
>-				 * If PT_LOAD segment does not have real data
>-				 * due to the all excluded pages, the file
>-				 * offset is not effective and it should be 0.
>-				 */
>-				load.p_offset = 0;
>-
>-			/*
>-			 * Write a PT_LOAD header.
>-			 */
>-			if (!write_elf_phdr(cd_header, &load))
>-				return FALSE;
>-
>-			/*
>-			 * Write a PT_LOAD segment.
>-			 */
>-			if (load.p_filesz)
>-				if (!write_elf_load_segment(cd_page, paddr,
>-				    off_memory, load.p_filesz))
>-					return FALSE;
>-
>-			load.p_paddr += load.p_memsz;
>-#ifdef __x86__
>-			/*
>-			 * FIXME:
>-			 *  (x86) Fill PT_LOAD headers with appropriate
>-			 *        virtual addresses.
>-			 */
>-			if (load.p_paddr < MAXMEM)
>-				load.p_vaddr += load.p_memsz;
>-#else
>-			load.p_vaddr += load.p_memsz;
>-#endif /* x86 */
>-			paddr  = load.p_paddr;
>-			off_seg_load += load.p_filesz;
>-
>-			num_excluded = 0;
>-			memsz  = page_size;
>-			filesz = page_size;
>-		}
>-		/*
>-		 * Write the last PT_LOAD.
>-		 */
>-		load.p_memsz  = memsz;
>-		load.p_filesz = filesz;
>-		load.p_offset = off_seg_load;
>-
>-		/*
>-		 * Write a PT_LOAD header.
>-		 */
>-		if (!write_elf_phdr(cd_header, &load))
>-			return FALSE;
>-
>-		/*
>-		 * Write a PT_LOAD segment.
>-		 */
>-		if (load.p_filesz)
>-			if (!write_elf_load_segment(cd_page, paddr,
>-						    off_memory, load.p_filesz))
>-				return FALSE;
>-
>-		off_seg_load += load.p_filesz;
>-	}
>-	if (!write_cache_bufsz(cd_header))
>-		return FALSE;
>-	if (!write_cache_bufsz(cd_page))
>-		return FALSE;
>-
>-	/*
>-	 * print [100 %]
>-	 */
>-	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable);
>-	print_execution_time(PROGRESS_COPY, &tv_start);
>-	PROGRESS_MSG("\n");
>-
>-	return TRUE;
>-}
>-
>-int
> read_pfn(unsigned long long pfn, unsigned char *buf)
> {
> 	unsigned long long paddr;
>@@ -5889,7 +5699,7 @@ get_loads_dumpfile_cyclic(void)
> }
>
> int
>-write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>+write_elf_pages(struct cache_data *cd_header, struct cache_data *cd_page)
> {
> 	int i, phnum;
> 	long page_size = info->page_size;
>@@ -5900,6 +5710,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
> 	unsigned long frac_head, frac_tail;
> 	off_t off_seg_load, off_memory;
> 	Elf64_Phdr load;
>+	struct dump_bitmap bitmap2;
> 	struct timeval tv_start;
>
> 	if (!info->flag_elf_dumpfile)
>@@ -5919,10 +5730,14 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
> 	pfn_user = pfn_free = pfn_hwpoison = 0;
> 	pfn_memhole = info->max_mapnr;
>
>-	info->cyclic_start_pfn = 0;
>-	info->cyclic_end_pfn = 0;
>-	if (!update_cyclic_region(0))
>-		return FALSE;
>+	if (info->flag_cyclic) {
>+		info->cyclic_start_pfn = 0;
>+		info->cyclic_end_pfn = 0;
>+		if (!update_cyclic_region(0))
>+			return FALSE;
>+	} else {
>+		initialize_2nd_bitmap(&bitmap2);
>+	}
>
> 	if (!(phnum = get_phnum_memory()))
> 		return FALSE;
>@@ -5956,13 +5771,19 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
> 			pfn_end++;
>
> 		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
>+			int dumpable;
> 			/*
> 			 * Update target region and partial bitmap if necessary.
> 			 */
>-			if (!update_cyclic_region(pfn))
>+			if (info->flag_cyclic && (!update_cyclic_region(pfn)))
> 				return FALSE;
>
>-			if (!is_dumpable_cyclic(info->partial_bitmap2, pfn)) {
>+			if (info->flag_cyclic)
>+				dumpable = is_dumpable_cyclic(info->partial_bitmap2, pfn);
>+			else
>+				dumpable = is_dumpable(&bitmap2, pfn);
>+
>+			if (!dumpable) {
> 				num_excluded++;
> 				if ((pfn == pfn_end - 1) && frac_tail)
> 					memsz += frac_tail;
>@@ -7824,13 +7645,8 @@ writeout_dumpfile(void)
> 	if (info->flag_elf_dumpfile) {
> 		if (!write_elf_header(&cd_header))
> 			goto out;
>-		if (info->flag_cyclic) {
>-			if (!write_elf_pages_cyclic(&cd_header, &cd_page))
>-				goto out;
>-		} else {
>-			if (!write_elf_pages(&cd_header, &cd_page))
>-				goto out;
>-		}
>+		if (!write_elf_pages(&cd_header, &cd_page))
>+			goto out;
> 		if (!write_elf_eraseinfo(&cd_header))
> 			goto out;
> 	} else if (info->flag_cyclic) {
>--
>1.6.0.2
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

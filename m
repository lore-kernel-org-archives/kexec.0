Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zgI-0001zC-LS
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 08:00:51 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U80mi5004651
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:00:48 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U80m626726 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 17:00:48 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U80mcC017686
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:00:48 +0900 (JST)
Date: Thu, 30 Aug 2012 16:52:20 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 08/16] [PATCH v3 8/12] Implement the main routine of cyclic
 mode for ELF format.
Message-Id: <20120830165220.48a9aeb0fd19b00098e58409@mxc.nes.nec.co.jp>
In-Reply-To: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
References: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Thu, 23 Aug 2012 17:54:12 +0900
Subject: [PATCH 08/16] [PATCH v3 8/12] Implement the main routine of cyclic mode for ELF format.

Implement the function which write out ELF dumpfile cyclically.
The basic idea is same as the routine for kdump-compressed format.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |  243 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 238 insertions(+), 5 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index f31a3aa..1f499bb 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4306,9 +4306,16 @@ write_elf_header(struct cache_data *cd_header)
 	/*
 	 * Get the PT_LOAD number of the dumpfile.
 	 */
-	if (!(num_loads_dumpfile = get_loads_dumpfile())) {
-		ERRMSG("Can't get a number of PT_LOAD.\n");
-		goto out;
+	if (info->flag_cyclic) {
+		if (!(num_loads_dumpfile = get_loads_dumpfile_cyclic())) {
+			ERRMSG("Can't get a number of PT_LOAD.\n");
+			goto out;
+		}
+	} else {
+		if (!(num_loads_dumpfile = get_loads_dumpfile())) {
+			ERRMSG("Can't get a number of PT_LOAD.\n");
+			goto out;
+		}
 	}
 
 	if (is_elf64_memory()) { /* ELF64 */
@@ -4975,6 +4982,227 @@ get_loads_dumpfile_cyclic(void)
 }
 
 int
+write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
+{
+	int i, phnum;
+	long page_size = info->page_size;
+	unsigned char buf[info->page_size];
+	unsigned long long pfn, pfn_start, pfn_end, paddr, num_excluded;
+	unsigned long long num_dumpable, per, num_dumped=0;
+	unsigned long long memsz, filesz;
+	unsigned long frac_head, frac_tail;
+	off_t off_seg_load, off_memory;
+	Elf64_Phdr load;
+	struct timeval tv_start;
+
+	if (!info->flag_elf_dumpfile)
+		return FALSE;
+
+	num_dumpable = info->num_dumpable;
+	per = num_dumpable / 100;
+
+	off_seg_load   = info->offset_load_dumpfile;
+	cd_page->offset = info->offset_load_dumpfile;
+
+	/*
+	 * Reset counter for debug message.
+	 */
+	pfn_zero =  pfn_cache = pfn_cache_private = pfn_user = pfn_free = 0;
+	pfn_memhole = info->max_mapnr;
+
+	info->cyclic_start_pfn = 0;
+	info->cyclic_end_pfn = 0;
+	if (!update_cyclic_region(0))
+		return FALSE;
+
+	if (!(phnum = get_phnum_memory()))
+		return FALSE;
+
+	gettimeofday(&tv_start, NULL);
+
+	for (i = 0; i < phnum; i++) {
+		if (!get_phdr_memory(i, &load))
+			return FALSE;
+
+		if (load.p_type != PT_LOAD)
+			continue;
+
+		off_memory= load.p_offset;
+		paddr = load.p_paddr;
+		pfn_start = paddr_to_pfn(load.p_paddr);
+		pfn_end = paddr_to_pfn(load.p_paddr + load.p_memsz);
+		frac_head = page_size - (load.p_paddr % page_size);
+		frac_tail = (load.p_paddr + load.p_memsz)%page_size;
+
+		num_excluded = 0;
+		memsz  = 0;
+		filesz = 0;
+		if (frac_head && (frac_head != page_size)) {
+			memsz  = frac_head;
+			filesz = frac_head;
+			pfn_start++;
+		}
+
+		if (frac_tail)
+			pfn_end++;
+
+		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
+			/*
+			 * Update target region and partial bitmap if necessary.
+			 */
+			if (!update_cyclic_region(pfn))
+				return FALSE;
+
+			if (!is_dumpable_cyclic(info->partial_bitmap2, pfn)) {
+				num_excluded++;
+				if ((pfn == pfn_end - 1) && frac_tail)
+					memsz += frac_tail;
+				else
+					memsz += page_size;
+				continue;
+			}
+
+			/*
+			 * Exclude zero pages.
+			 */
+			if (info->dump_level & DL_EXCLUDE_ZERO) {
+				if (!read_pfn(pfn, buf))
+					return FALSE;
+				if (is_zero_page(buf, page_size)) {
+					pfn_zero++;
+					num_excluded++;
+					if ((pfn == pfn_end - 1) && frac_tail)
+						memsz += frac_tail;
+					else
+						memsz += page_size;
+					continue;
+				}
+			}
+
+			if ((num_dumped % per) == 0)
+				print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
+
+			num_dumped++;
+
+			/*
+			 * The dumpable pages are continuous.
+			 */
+			if (!num_excluded) {
+				if ((pfn == pfn_end - 1) && frac_tail) {
+					memsz  += frac_tail;
+					filesz += frac_tail;
+				} else {
+					memsz  += page_size;
+					filesz += page_size;
+				}
+				continue;
+				/*
+				 * If the number of the contiguous pages to be excluded
+				 * is 255 or less, those pages are not excluded.
+				 */
+			} else if (num_excluded < PFN_EXCLUDED) {
+				if ((pfn == pfn_end - 1) && frac_tail) {
+					memsz  += frac_tail;
+					filesz += (page_size*num_excluded
+						   + frac_tail);
+				}else {
+					memsz  += page_size;
+					filesz += (page_size*num_excluded
+						   + page_size);
+				}
+				num_excluded = 0;
+				continue;
+			}
+
+			/*
+			 * If the number of the contiguous pages to be excluded
+			 * is 256 or more, those pages are excluded really.
+			 * And a new PT_LOAD segment is created.
+			 */
+			load.p_memsz = memsz;
+			load.p_filesz = filesz;
+			if (load.p_filesz)
+				load.p_offset = off_seg_load;
+			else
+				/*
+				 * If PT_LOAD segment does not have real data
+				 * due to the all excluded pages, the file
+				 * offset is not effective and it should be 0.
+				 */
+				load.p_offset = 0;
+
+			/*
+			 * Write a PT_LOAD header.
+			 */
+			if (!write_elf_phdr(cd_header, &load))
+				return FALSE;
+
+			/*
+			 * Write a PT_LOAD segment.
+			 */
+			if (load.p_filesz)
+				if (!write_elf_load_segment(cd_page, paddr,
+							    off_memory, load.p_filesz))
+					return FALSE;
+
+			load.p_paddr += load.p_memsz;
+#ifdef __x86__
+			/*
+			 * FIXME:
+			 *  (x86) Fill PT_LOAD headers with appropriate
+			 * virtual addresses.
+			 */
+			if (load.p_paddr < MAXMEM)
+				load.p_vaddr += load.p_memsz;
+#else
+			load.p_vaddr += load.p_memsz;
+#endif /* x86 */
+			paddr  = load.p_paddr;
+			off_seg_load += load.p_filesz;
+
+			num_excluded = 0;
+			memsz  = page_size;
+			filesz = page_size;
+		}
+		/*
+		 * Write the last PT_LOAD.
+		 */
+		load.p_memsz = memsz;
+		load.p_filesz = filesz;
+		load.p_offset = off_seg_load;
+
+		/*
+		 * Write a PT_LOAD header.
+		 */
+		if (!write_elf_phdr(cd_header, &load))
+			return FALSE;
+
+		/*
+		 * Write a PT_LOAD segment.
+		 */
+		if (load.p_filesz)
+			if (!write_elf_load_segment(cd_page, paddr,
+						    off_memory, load.p_filesz))
+				return FALSE;
+
+		off_seg_load += load.p_filesz;
+	}
+	if (!write_cache_bufsz(cd_header))
+		return FALSE;
+	if (!write_cache_bufsz(cd_page))
+		return FALSE;
+
+	/*
+	 * print [100 %]
+	 */
+	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable);
+	print_execution_time(PROGRESS_COPY, &tv_start);
+	PROGRESS_MSG("\n");
+
+	return TRUE;
+}
+
+int
 write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 {
  	unsigned long long pfn, per, num_dumpable, num_dumped = 0;
@@ -6446,8 +6674,13 @@ writeout_dumpfile(void)
 	if (info->flag_elf_dumpfile) {
 		if (!write_elf_header(&cd_header))
 			goto out;
-		if (!write_elf_pages(&cd_header, &cd_page))
-			goto out;
+		if (info->flag_cyclic) {
+			if (!write_elf_pages_cyclic(&cd_header, &cd_page))
+				goto out;
+		} else {
+			if (!write_elf_pages(&cd_header, &cd_page))
+				goto out;
+		}
 		if (!write_elf_eraseinfo(&cd_header))
 			goto out;
 	} else if (info->flag_cyclic) {
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

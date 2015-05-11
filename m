Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YrhQL-0007HX-6x
 for kexec@lists.infradead.org; Mon, 11 May 2015 06:42:47 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.197])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6gRPO010004
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:42:27 +0900 (JST)
Received: from mailsv.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id t4B6gRc14142 for <kexec@lists.infradead.org>;
 Mon, 11 May 2015 15:42:27 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6gQeW016012
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:42:26 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 07/13] Integrate filtering process for ELF path.
Date: Mon, 11 May 2015 06:28:24 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA35F@BPXM01GP.gisp.nec.co.jp>
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

Also ELF path have duplicated codes, merge them.
In ELF case, zero pages have to be checked before writing process,
so move zero pages filtering into create_2nd_bitmap() like other
pages filtering.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c | 81 +++++++++++++++++-----------------------------------------
 1 file changed, 23 insertions(+), 58 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ae11bf1..7993e1d 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4788,6 +4788,9 @@ exclude_zero_pages_cyclic(struct cycle *cycle)
 		if (!is_in_segs(paddr))
 			continue;
 
+		if (!sync_2nd_bitmap())
+			return FALSE;
+
 		if (!is_dumpable(info->bitmap2, pfn, cycle))
 			continue;
 
@@ -5244,7 +5247,8 @@ create_2nd_bitmap(struct cycle *cycle)
 	 *	 should be fixed for creating an ELF header. That is slow
 	 *	 due to reading each page two times, but it is necessary.
 	 */
-	if ((info->dump_level & DL_EXCLUDE_ZERO) && info->flag_elf_dumpfile) {
+	if ((info->dump_level & DL_EXCLUDE_ZERO) &&
+	    (info->flag_elf_dumpfile || info->flag_mem_usage)) {
 		/*
 		 * 2nd-bitmap should be flushed at this time, because
 		 * exclude_zero_pages() checks 2nd-bitmap.
@@ -5252,7 +5256,7 @@ create_2nd_bitmap(struct cycle *cycle)
 		if (!sync_2nd_bitmap())
 			return FALSE;
 
-		if (!exclude_zero_pages()) {
+		if (!exclude_zero_pages_cyclic(cycle)) {
 			ERRMSG("Can't exclude pages filled with zero for creating an ELF dumpfile.\n");
 			return FALSE;
 		}
@@ -5599,16 +5603,9 @@ write_elf_header(struct cache_data *cd_header)
 	/*
 	 * Get the PT_LOAD number of the dumpfile.
 	 */
-	if (info->flag_cyclic) {
-		if (!(num_loads_dumpfile = get_loads_dumpfile_cyclic())) {
-			ERRMSG("Can't get a number of PT_LOAD.\n");
-			goto out;
-		}
-	} else {
-		if (!(num_loads_dumpfile = get_loads_dumpfile())) {
-			ERRMSG("Can't get a number of PT_LOAD.\n");
-			goto out;
-		}
+	if (!(num_loads_dumpfile = get_loads_dumpfile_cyclic())) {
+		ERRMSG("Can't get a number of PT_LOAD.\n");
+		goto out;
 	}
 
 	if (is_elf64_memory()) { /* ELF64 */
@@ -6328,7 +6325,6 @@ get_loads_dumpfile_cyclic(void)
 {
 	int i, phnum, num_new_load = 0;
 	long page_size = info->page_size;
-	unsigned char buf[info->page_size];
 	mdf_pfn_t pfn, pfn_start, pfn_end, num_excluded;
 	unsigned long frac_head, frac_tail;
 	Elf64_Phdr load;
@@ -6357,8 +6353,10 @@ get_loads_dumpfile_cyclic(void)
 			pfn_end++;
 
 		for_each_cycle(pfn_start, pfn_end, &cycle) {
-			if (!create_2nd_bitmap(&cycle))
-				return FALSE;
+			if (info->flag_cyclic) {
+				if (!create_2nd_bitmap(&cycle))
+					return FALSE;
+			}
 			for (pfn = MAX(pfn_start, cycle.start_pfn); pfn < cycle.end_pfn; pfn++) {
 				if (!is_dumpable(info->bitmap2, pfn, &cycle)) {
 					num_excluded++;
@@ -6366,20 +6364,6 @@ get_loads_dumpfile_cyclic(void)
 				}
 
 				/*
-				 * Exclude zero pages.
-				 */
-				if (info->dump_level & DL_EXCLUDE_ZERO) {
-					if (!read_pfn(pfn, buf))
-						return FALSE;
-					if (is_zero_page(buf, page_size)) {
-						num_excluded++;
-						continue;
-					}
-				}
-
-				info->num_dumpable++;
-
-				/*
 				 * If the number of the contiguous pages to be excluded
 				 * is 256 or more, those pages are excluded really.
 				 * And a new PT_LOAD segment is created.
@@ -6400,7 +6384,6 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 {
 	int i, phnum;
 	long page_size = info->page_size;
-	unsigned char buf[info->page_size];
 	mdf_pfn_t pfn, pfn_start, pfn_end, num_excluded, num_dumpable, per;
 	unsigned long long paddr;
 	unsigned long long memsz, filesz;
@@ -6423,9 +6406,11 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	/*
 	 * Reset counter for debug message.
 	 */
-	pfn_zero = pfn_cache = pfn_cache_private = 0;
-	pfn_user = pfn_free = pfn_hwpoison = 0;
-	pfn_memhole = info->max_mapnr;
+	if (info->flag_cyclic) {
+		pfn_zero = pfn_cache = pfn_cache_private = 0;
+		pfn_user = pfn_free = pfn_hwpoison = 0;
+		pfn_memhole = info->max_mapnr;
+	}
 
 	if (!(phnum = get_phnum_memory()))
 		return FALSE;
@@ -6462,8 +6447,10 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 			/*
 			 * Update target region and partial bitmap if necessary.
 			 */
-			if (!create_2nd_bitmap(&cycle))
-				return FALSE;
+			if (info->flag_cyclic) {
+				if (!create_2nd_bitmap(&cycle))
+					return FALSE;
+			}
 
 			for (pfn = MAX(pfn_start, cycle.start_pfn); pfn < cycle.end_pfn; pfn++) {
 				if (!is_dumpable(info->bitmap2, pfn, &cycle)) {
@@ -6475,23 +6462,6 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 					continue;
 				}
 
-				/*
-				 * Exclude zero pages.
-				 */
-				if (info->dump_level & DL_EXCLUDE_ZERO) {
-					if (!read_pfn(pfn, buf))
-						return FALSE;
-					if (is_zero_page(buf, page_size)) {
-						pfn_zero++;
-						num_excluded++;
-						if ((pfn == pfn_end - 1) && frac_tail)
-							memsz += frac_tail;
-						else
-							memsz += page_size;
-						continue;
-					}
-				}
-
 				if ((num_dumped % per) == 0)
 					print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
 
@@ -8202,13 +8172,8 @@ writeout_dumpfile(void)
 	if (info->flag_elf_dumpfile) {
 		if (!write_elf_header(&cd_header))
 			goto out;
-		if (info->flag_cyclic) {
-			if (!write_elf_pages_cyclic(&cd_header, &cd_page))
+		if (!write_elf_pages_cyclic(&cd_header, &cd_page))
 				goto write_cache_enospc;
-		} else {
-			if (!write_elf_pages(&cd_header, &cd_page))
-				goto write_cache_enospc;
-		}
 		if (!write_elf_eraseinfo(&cd_header))
 			goto out;
 	} else {
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

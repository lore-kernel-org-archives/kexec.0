Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YrhOO-0006tp-Kn
 for kexec@lists.infradead.org; Mon, 11 May 2015 06:40:45 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6eNRB008592
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:40:23 +0900 (JST)
Received: from mailsv3.nec.co.jp (imss62.nec.co.jp [10.7.69.157]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id t4B6eNv09184 for <kexec@lists.infradead.org>;
 Mon, 11 May 2015 15:40:23 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6eMgG011220
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:40:22 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 03/13] Integrate the entry point of is_dumpable().
Date: Mon, 11 May 2015 06:23:49 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA34B@BPXM01GP.gisp.nec.co.jp>
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

Integrate the entry point of is_dumpable() to make it unnecessary
to check the condition in caller side.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c | 35 +++++++++++++++++------------------
 makedumpfile.h | 22 ++++++++++++++++------
 sadump_info.c  |  8 ++++----
 3 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index f0ec741..41da4bf 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -236,8 +236,7 @@ is_in_same_page(unsigned long vaddr1, unsigned long vaddr2)
 }
 
 #define BITMAP_SECT_LEN 4096
-static inline int is_dumpable(struct dump_bitmap *, mdf_pfn_t);
-static inline int is_dumpable_cyclic(struct dump_bitmap *, mdf_pfn_t, struct cycle *cycle);
+static inline int is_dumpable(struct dump_bitmap *, mdf_pfn_t, struct cycle *cycle);
 unsigned long
 pfn_to_pos(mdf_pfn_t pfn)
 {
@@ -246,7 +245,7 @@ pfn_to_pos(mdf_pfn_t pfn)
 
 	desc_pos = info->valid_pages[pfn / BITMAP_SECT_LEN];
 	for (i = round(pfn, BITMAP_SECT_LEN); i < pfn; i++)
-		if (is_dumpable(info->bitmap_memory, i))
+		if (is_dumpable(info->bitmap_memory, i, NULL))
 			desc_pos++;
 
 	return desc_pos;
@@ -522,7 +521,7 @@ readpage_kdump_compressed(unsigned long long paddr, void *bufptr)
 	int ret;
 	unsigned long retlen;
 
-	if (!is_dumpable(info->bitmap_memory, paddr_to_pfn(paddr))) {
+	if (!is_dumpable(info->bitmap_memory, paddr_to_pfn(paddr), NULL)) {
 		ERRMSG("pfn(%llx) is excluded from %s.\n",
 				paddr_to_pfn(paddr), info->name_memory);
 		return FALSE;
@@ -3072,7 +3071,7 @@ initialize_bitmap_memory(void)
 	for (i = 1, pfn = 0; i < max_sect_len; i++) {
 		info->valid_pages[i] = info->valid_pages[i - 1];
 		for (j = 0; j < BITMAP_SECT_LEN; j++, pfn++)
-			if (is_dumpable(info->bitmap_memory, pfn))
+			if (is_dumpable(info->bitmap_memory, pfn, NULL))
 				info->valid_pages[i]++;
 	}
 
@@ -3599,7 +3598,7 @@ is_in_segs(unsigned long long paddr)
 		if (bitmap1.fd == 0)
 			initialize_1st_bitmap(&bitmap1);
 
-		return is_dumpable(&bitmap1, paddr_to_pfn(paddr));
+		return is_dumpable(&bitmap1, paddr_to_pfn(paddr), NULL);
 	}
 
 	if (paddr_to_offset(paddr))
@@ -4774,7 +4773,7 @@ exclude_zero_pages(void)
 		if (!is_in_segs(paddr))
 			continue;
 
-		if (!is_dumpable(&bitmap2, pfn))
+		if (!is_dumpable(&bitmap2, pfn, NULL))
 			continue;
 
 		if (is_xen_memory()) {
@@ -4818,7 +4817,7 @@ exclude_zero_pages_cyclic(struct cycle *cycle)
 		if (!is_in_segs(paddr))
 			continue;
 
-		if (!is_dumpable_cyclic(info->partial_bitmap2, pfn, cycle))
+		if (!is_dumpable(info->partial_bitmap2, pfn, cycle))
 			continue;
 
 		if (is_xen_memory()) {
@@ -5516,7 +5515,7 @@ get_loads_dumpfile(void)
 			pfn_end++;
 
 		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
-			if (!is_dumpable(&bitmap2, pfn)) {
+			if (!is_dumpable(&bitmap2, pfn, NULL)) {
 				num_excluded++;
 				continue;
 			}
@@ -6066,7 +6065,7 @@ get_num_dumpable(void)
 	initialize_2nd_bitmap(&bitmap2);
 
 	for (pfn = 0, num_dumpable = 0; pfn < info->max_mapnr; pfn++) {
-		if (is_dumpable(&bitmap2, pfn))
+		if (is_dumpable(&bitmap2, pfn, NULL))
 			num_dumpable++;
 	}
 	return num_dumpable;
@@ -6094,7 +6093,7 @@ get_num_dumpable_cyclic_withsplit(void)
 			exclude_zero_pages_cyclic(&cycle);
 
 		for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
-			if (is_dumpable_cyclic(info->partial_bitmap2, pfn, &cycle)) {
+			if (is_dumpable(info->partial_bitmap2, pfn, &cycle)) {
 				num_dumpable++;
 				dumpable_pfn_num++;
 			}
@@ -6128,7 +6127,7 @@ get_num_dumpable_cyclic(void)
 			exclude_zero_pages_cyclic(&cycle);
 
 		for(pfn=cycle.start_pfn; pfn<cycle.end_pfn; pfn++)
-			if (is_dumpable_cyclic(info->partial_bitmap2, pfn, &cycle))
+			if (is_dumpable(info->partial_bitmap2, pfn, &cycle))
 				num_dumpable++;
 	}
 
@@ -6235,7 +6234,7 @@ write_elf_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 			pfn_end++;
 
 		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
-			if (!is_dumpable(&bitmap2, pfn)) {
+			if (!is_dumpable(&bitmap2, pfn, NULL)) {
 				num_excluded++;
 				if ((pfn == pfn_end - 1) && frac_tail)
 					memsz += frac_tail;
@@ -6418,7 +6417,7 @@ get_loads_dumpfile_cyclic(void)
 			if (!exclude_unnecessary_pages_cyclic(&cycle))
 				return FALSE;
 			for (pfn = MAX(pfn_start, cycle.start_pfn); pfn < cycle.end_pfn; pfn++) {
-				if (!is_dumpable_cyclic(info->partial_bitmap2, pfn, &cycle)) {
+				if (!is_dumpable(info->partial_bitmap2, pfn, &cycle)) {
 					num_excluded++;
 					continue;
 				}
@@ -6524,7 +6523,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 				return FALSE;
 
 			for (pfn = MAX(pfn_start, cycle.start_pfn); pfn < cycle.end_pfn; pfn++) {
-				if (!is_dumpable_cyclic(info->partial_bitmap2, pfn, &cycle)) {
+				if (!is_dumpable(info->partial_bitmap2, pfn, &cycle)) {
 					num_excluded++;
 					if ((pfn == pfn_end - 1) && frac_tail)
 						memsz += frac_tail;
@@ -6784,7 +6783,7 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
 		/*
 		 * Check the excluded page.
 		 */
-		if (!is_dumpable(&bitmap2, pfn))
+		if (!is_dumpable(&bitmap2, pfn, NULL))
 			continue;
 
 		num_dumped++;
@@ -8575,7 +8574,7 @@ setup_splitting(void)
 				end_pfn  = info->max_mapnr;
 			} else {
 				for (j = 0; j < pfn_per_dumpfile; end_pfn++) {
-					if (is_dumpable(&bitmap2, end_pfn))
+					if (is_dumpable(&bitmap2, end_pfn, NULL))
 						j++;
 				}
 			}
@@ -9226,7 +9225,7 @@ reassemble_kdump_pages(void)
 
 		offset_ph_org = offset_first_ph;
 		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
-			if (!is_dumpable(&bitmap2, pfn))
+			if (!is_dumpable(&bitmap2, pfn, NULL))
 				continue;
 
 			num_dumped++;
diff --git a/makedumpfile.h b/makedumpfile.h
index 990c76f..303113d 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1741,7 +1741,16 @@ is_on(char *bitmap, mdf_pfn_t i)
 }
 
 static inline int
-is_dumpable(struct dump_bitmap *bitmap, mdf_pfn_t pfn)
+is_dumpable_buffer(struct dump_bitmap *bitmap, mdf_pfn_t pfn, struct cycle *cycle)
+{
+	if (pfn < cycle->start_pfn || cycle->end_pfn <= pfn)
+		return FALSE;
+	else
+		return is_on(bitmap->buf, pfn - cycle->start_pfn);
+}
+
+static inline int
+is_dumpable_file(struct dump_bitmap *bitmap, mdf_pfn_t pfn)
 {
 	off_t offset;
 	if (pfn == 0 || bitmap->no_block != pfn/PFN_BUFBITMAP) {
@@ -1757,12 +1766,13 @@ is_dumpable(struct dump_bitmap *bitmap, mdf_pfn_t pfn)
 }
 
 static inline int
-is_dumpable_cyclic(struct dump_bitmap *bitmap, mdf_pfn_t pfn, struct cycle *cycle)
+is_dumpable(struct dump_bitmap *bitmap, mdf_pfn_t pfn, struct cycle *cycle)
 {
-	if (pfn < cycle->start_pfn || cycle->end_pfn <= pfn)
-		return FALSE;
-	else
-		return is_on(bitmap->buf, pfn - cycle->start_pfn);
+	if (bitmap->fd == 0) {
+		return is_dumpable_buffer(bitmap, pfn, cycle);
+	} else {
+		return is_dumpable_file(bitmap, pfn);
+	}
 }
 
 static inline int
diff --git a/sadump_info.c b/sadump_info.c
index e2c4f03..47da45b 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -215,7 +215,7 @@ sadump_copy_1st_bitmap_from_memory(void)
 						      si->backup_offset -
 						      si->backup_src_start);
 
-			if (is_dumpable(info->bitmap_memory, backup_src_pfn))
+			if (is_dumpable(info->bitmap_memory, backup_src_pfn, NULL))
 				set_bit_on_1st_bitmap(pfn, NULL);
 			else
 				clear_bit_on_1st_bitmap(pfn, NULL);
@@ -805,7 +805,7 @@ sadump_initialize_bitmap_memory(void)
 		for (pfn = section * SADUMP_PF_SECTION_NUM;
 		     pfn < (section + 1) * SADUMP_PF_SECTION_NUM;
 		     ++pfn)
-			if (is_dumpable(bmp, pfn))
+			if (is_dumpable(bmp, pfn, NULL))
 				block_table[section]++;
 	}
 
@@ -981,7 +981,7 @@ readpage_sadump(unsigned long long paddr, void *bufptr)
 	if (pfn >= si->max_mapnr)
 		return FALSE;
 
-	if (!is_dumpable(info->bitmap_memory, pfn)) {
+	if (!is_dumpable(info->bitmap_memory, pfn, NULL)) {
 		ERRMSG("pfn(%llx) is excluded from %s.\n", pfn,
 		       info->name_memory);
 		return FALSE;
@@ -1146,7 +1146,7 @@ pfn_to_block(mdf_pfn_t pfn)
 		block = 0;
 
 	for (p = section * SADUMP_PF_SECTION_NUM; p < pfn; ++p)
-		if (is_dumpable(info->bitmap_memory, p))
+		if (is_dumpable(info->bitmap_memory, p, NULL))
 			block++;
 
 	return block;
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

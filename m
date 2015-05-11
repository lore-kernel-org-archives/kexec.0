Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YrhRB-0007Xi-Rr
 for kexec@lists.infradead.org; Mon, 11 May 2015 06:43:39 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6hGTc010477
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:43:16 +0900 (JST)
Received: from mailsv.nec.co.jp (imss63.nec.co.jp [10.7.69.158]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id t4B6hF717555 for <kexec@lists.infradead.org>;
 Mon, 11 May 2015 15:43:15 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6hF20016433
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:43:15 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 10/13] Adjust --split/--reassemble path to the new code.
Date: Mon, 11 May 2015 06:32:55 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA390@BPXM01GP.gisp.nec.co.jp>
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

Do small some fixes to adjust --split/--reassemble path to
the new code.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c | 177 +++++++++++++++++++++++----------------------------------
 1 file changed, 71 insertions(+), 106 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index c2c07fc..e58940b 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1033,7 +1033,7 @@ open_dump_bitmap(void)
 	char *tmpname;
 
 	/* Unnecessary to open */
-	if (!info->working_dir && !info->flag_mem_usage)
+	if (!info->working_dir && !info->flag_reassemble && !info->flag_mem_usage)
 		return TRUE;
 
 	tmpname = getenv("TMPDIR");
@@ -3256,7 +3256,7 @@ out:
 	if (!get_max_mapnr())
 		return FALSE;
 
-	if (info->working_dir || info->flag_mem_usage) {
+	if (info->working_dir || info->flag_reassemble || info->flag_mem_usage) {
 		/* Implemented as non-cyclic mode based on the file */
 		info->flag_cyclic = FALSE;
 		info->pfn_cyclic = info->max_mapnr;
@@ -5334,51 +5334,6 @@ free_bitmap_buffer(void)
 }
 
 int
-create_dump_bitmap(void)
-{
-	int ret = FALSE;
-
-	if (info->flag_cyclic) {
-		if (!prepare_bitmap2_buffer())
-			goto out;
-		if (info->flag_split) {
-			if (!prepare_splitblock_table())
-				goto out;
-
-			info->num_dumpable = get_num_dumpable_cyclic_withsplit();
-		} else {
-			info->num_dumpable = get_num_dumpable_cyclic();
-		}
-
-		if (!info->flag_elf_dumpfile)
-			free_bitmap2_buffer();
-
-	} else {
-		struct cycle cycle = {0};
-		first_cycle(0, info->max_mapnr, &cycle);
-		if (!prepare_bitmap_buffer())
-			goto out;
-
-		pfn_memhole = info->max_mapnr;
-		if (!create_1st_bitmap(&cycle))
-			goto out;
-
-		if (!create_2nd_bitmap(&cycle))
-			goto out;
-
-		info->num_dumpable = get_num_dumpable_cyclic();
-	}
-
-	ret = TRUE;
-out:
-	/* Should keep the buffer in the 1-cycle case. */
-	if (info->flag_cyclic)
-		free_bitmap_buffer();
-
-	return ret;
-}
-
-int
 prepare_cache_data(struct cache_data *cd)
 {
 	cd->fd         = info->fd_dumpfile;
@@ -5897,12 +5852,11 @@ mdf_pfn_t
 get_num_dumpable(void)
 {
 	mdf_pfn_t pfn, num_dumpable;
-	struct dump_bitmap bitmap2;
 
-	initialize_2nd_bitmap(&bitmap2);
+	initialize_2nd_bitmap(info->bitmap2);
 
 	for (pfn = 0, num_dumpable = 0; pfn < info->max_mapnr; pfn++) {
-		if (is_dumpable(&bitmap2, pfn, NULL))
+		if (is_dumpable(info->bitmap2, pfn, NULL))
 			num_dumpable++;
 	}
 	return num_dumpable;
@@ -5920,11 +5874,11 @@ get_num_dumpable_cyclic_withsplit(void)
 	struct cycle cycle = {0};
 	int pos = 0;
 
-	pfn_memhole = info->max_mapnr;
-
 	for_each_cycle(0, info->max_mapnr, &cycle) {
-		if (!create_2nd_bitmap(&cycle))
-			return FALSE;
+		if (info->flag_cyclic) {
+			if (!create_2nd_bitmap(&cycle))
+				return FALSE;
+		}
 
 		for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
 			if (is_dumpable(info->bitmap2, pfn, &cycle)) {
@@ -5945,7 +5899,7 @@ get_num_dumpable_cyclic_withsplit(void)
 }
 
 mdf_pfn_t
-get_num_dumpable_cyclic(void)
+get_num_dumpable_cyclic_single(void)
 {
 	mdf_pfn_t pfn, num_dumpable=0;
 	struct cycle cycle = {0};
@@ -5965,6 +5919,59 @@ get_num_dumpable_cyclic(void)
 	return num_dumpable;
 }
 
+mdf_pfn_t
+get_num_dumpable_cyclic(void)
+{
+	if (info->flag_split)
+		return get_num_dumpable_cyclic_withsplit();
+	else
+		return get_num_dumpable_cyclic_single();
+}
+
+int
+create_dump_bitmap(void)
+{
+	int ret = FALSE;
+
+	if (info->flag_split) {
+		if (!prepare_splitblock_table())
+			goto out;
+	}
+
+	if (info->flag_cyclic) {
+		if (!prepare_bitmap2_buffer())
+			goto out;
+
+		info->num_dumpable = get_num_dumpable_cyclic();
+
+		if (!info->flag_elf_dumpfile)
+			free_bitmap2_buffer();
+
+	} else {
+		struct cycle cycle = {0};
+		first_cycle(0, info->max_mapnr, &cycle);
+		if (!prepare_bitmap_buffer())
+			goto out;
+
+		pfn_memhole = info->max_mapnr;
+		if (!create_1st_bitmap(&cycle))
+			goto out;
+
+		if (!create_2nd_bitmap(&cycle))
+			goto out;
+
+		info->num_dumpable = get_num_dumpable_cyclic();
+	}
+
+	ret = TRUE;
+out:
+	/* Should keep the buffer in the 1-cycle case. */
+	if (info->flag_cyclic)
+		free_bitmap_buffer();
+
+	return ret;
+}
+
 int
 write_elf_load_segment(struct cache_data *cd_page, unsigned long long paddr,
 		       off_t off_memory, long long size)
@@ -6938,7 +6945,7 @@ close_dump_file(void)
 void
 close_dump_bitmap(void)
 {
-	if (!info->working_dir && !info->flag_mem_usage)
+	if (!info->working_dir && !info->flag_reassemble && !info->flag_mem_usage)
 		return;
 
 	if ((info->fd_bitmap = close(info->fd_bitmap)) < 0)
@@ -7946,13 +7953,16 @@ calculate_end_pfn_by_splitblock(mdf_pfn_t start_pfn,
 /*
  * calculate start_pfn and end_pfn in each output file.
  */
-static int setup_splitting_cyclic(void)
+static int setup_splitting(void)
 {
 	int i;
 	mdf_pfn_t start_pfn, end_pfn;
 	int cur_splitblock_num = 0;
 	start_pfn = end_pfn = 0;
 
+	if (info->num_dumpfile <= 1)
+		return FALSE;
+
 	for (i = 0; i < info->num_dumpfile - 1; i++) {
 		start_pfn = end_pfn;
 		end_pfn = calculate_end_pfn_by_splitblock(start_pfn,
@@ -7966,52 +7976,6 @@ static int setup_splitting_cyclic(void)
 	return TRUE;
 }
 
-int
-setup_splitting(void)
-{
-	int i;
-	mdf_pfn_t j, pfn_per_dumpfile;
-	mdf_pfn_t start_pfn, end_pfn;
-	mdf_pfn_t num_dumpable = get_num_dumpable();
-	struct dump_bitmap bitmap2;
-
-	if (info->num_dumpfile <= 1)
-		return FALSE;
-
-	if (info->flag_cyclic) {
-		int ret = FALSE;
-
-		if (!prepare_bitmap2_buffer()) {
-			free_bitmap_buffer();
-			return ret;
-		}
-		ret = setup_splitting_cyclic();
-		free_bitmap2_buffer();
-
-		return ret;
-        } else {
-		initialize_2nd_bitmap(&bitmap2);
-
-		pfn_per_dumpfile = num_dumpable / info->num_dumpfile;
-		start_pfn = end_pfn = 0;
-		for (i = 0; i < info->num_dumpfile; i++) {
-			start_pfn = end_pfn;
-			if (i == (info->num_dumpfile - 1)) {
-				end_pfn  = info->max_mapnr;
-			} else {
-				for (j = 0; j < pfn_per_dumpfile; end_pfn++) {
-					if (is_dumpable(&bitmap2, end_pfn, NULL))
-						j++;
-				}
-			}
-			SPLITTING_START_PFN(i) = start_pfn;
-			SPLITTING_END_PFN(i)   = end_pfn;
-		}
-	}
-
-	return TRUE;
-}
-
 /*
  * This function is for creating split dumpfiles by multiple
  * processes. Each child process should re-open a /proc/vmcore
@@ -8582,7 +8546,6 @@ reassemble_kdump_pages(void)
 	mdf_pfn_t pfn, start_pfn, end_pfn;
 	mdf_pfn_t num_dumpable;
 	unsigned long size_eraseinfo;
-	struct dump_bitmap bitmap2;
 	struct disk_dump_header dh;
 	struct page_desc pd, pd_zero;
 	struct cache_data cd_pd, cd_data;
@@ -8590,7 +8553,8 @@ reassemble_kdump_pages(void)
 	char *data = NULL;
 	unsigned long data_buf_size = info->page_size;
 
-	initialize_2nd_bitmap(&bitmap2);
+	if (!prepare_bitmap2_buffer())
+		return FALSE;
 
 	if (!read_disk_dump_header(&dh, SPLITTING_DUMPFILE(0)))
 		return FALSE;
@@ -8651,7 +8615,7 @@ reassemble_kdump_pages(void)
 
 		offset_ph_org = offset_first_ph;
 		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
-			if (!is_dumpable(&bitmap2, pfn, NULL))
+			if (!is_dumpable(info->bitmap2, pfn, NULL))
 				continue;
 
 			num_dumped++;
@@ -8760,6 +8724,7 @@ reassemble_kdump_pages(void)
 out:
 	free_cache_data(&cd_pd);
 	free_cache_data(&cd_data);
+	free_bitmap2_buffer();
 
 	if (data)
 		free(data);
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

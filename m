Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YrhQo-0007Qd-Kh
 for kexec@lists.infradead.org; Mon, 11 May 2015 06:43:15 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.192])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6gvCK008843
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:42:57 +0900 (JST)
Received: from mailsv3.nec.co.jp (imss62.nec.co.jp [10.7.69.157]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id t4B6gvt14803 for <kexec@lists.infradead.org>;
 Mon, 11 May 2015 15:42:57 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6fujx012155
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:42:56 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 09/13] Adjust --mem-usage path to the new code.
Date: Mon, 11 May 2015 06:32:00 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA381@BPXM01GP.gisp.nec.co.jp>
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

Some filtering codes were moved by previous commits,
also --mem-usage path should follow them.

In addition, this mode is changed to use the file based
bitmap to reduce the influence by its own memory consumption.

signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index c162cbc..c2c07fc 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1033,7 +1033,7 @@ open_dump_bitmap(void)
 	char *tmpname;
 
 	/* Unnecessary to open */
-	if (!info->working_dir)
+	if (!info->working_dir && !info->flag_mem_usage)
 		return TRUE;
 
 	tmpname = getenv("TMPDIR");
@@ -3256,7 +3256,7 @@ out:
 	if (!get_max_mapnr())
 		return FALSE;
 
-	if (info->working_dir) {
+	if (info->working_dir || info->flag_mem_usage) {
 		/* Implemented as non-cyclic mode based on the file */
 		info->flag_cyclic = FALSE;
 		info->pfn_cyclic = info->max_mapnr;
@@ -4672,7 +4672,8 @@ create_1st_bitmap_file(void)
 	pfn_bitmap1 = 0;
 	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
 
-		print_progress(PROGRESS_HOLES, i, num_pt_loads);
+		if (!info->flag_mem_usage)
+			print_progress(PROGRESS_HOLES, i, num_pt_loads);
 
 		pfn_start = paddr_to_pfn(phys_start);
 		pfn_end   = paddr_to_pfn(phys_end);
@@ -4690,8 +4691,10 @@ create_1st_bitmap_file(void)
 	/*
 	 * print 100 %
 	 */
-	print_progress(PROGRESS_HOLES, info->max_mapnr, info->max_mapnr);
-	print_execution_time(PROGRESS_HOLES, &tv_start);
+	if (!info->flag_mem_usage) {
+		print_progress(PROGRESS_HOLES, info->max_mapnr, info->max_mapnr);
+		print_execution_time(PROGRESS_HOLES, &tv_start);
+	}
 
 	if (!sync_1st_bitmap())
 		return FALSE;
@@ -5923,9 +5926,6 @@ get_num_dumpable_cyclic_withsplit(void)
 		if (!create_2nd_bitmap(&cycle))
 			return FALSE;
 
-		if (info->flag_mem_usage)
-			exclude_zero_pages_cyclic(&cycle);
-
 		for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
 			if (is_dumpable(info->bitmap2, pfn, &cycle)) {
 				num_dumpable++;
@@ -5957,9 +5957,6 @@ get_num_dumpable_cyclic(void)
 				return FALSE;
 		}
 
-		if (info->flag_mem_usage)
-			exclude_zero_pages_cyclic(&cycle);
-
 		for(pfn=cycle.start_pfn; pfn<cycle.end_pfn; pfn++)
 			if (is_dumpable(info->bitmap2, pfn, &cycle))
 				num_dumpable++;
@@ -6941,7 +6938,7 @@ close_dump_file(void)
 void
 close_dump_bitmap(void)
 {
-	if (!info->working_dir)
+	if (!info->working_dir && !info->flag_mem_usage)
 		return;
 
 	if ((info->fd_bitmap = close(info->fd_bitmap)) < 0)
@@ -9209,22 +9206,19 @@ static int get_sys_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
 int show_mem_usage(void)
 {
 	uint64_t vmcoreinfo_addr, vmcoreinfo_len;
+	struct cycle cycle = {0};
 
 	if (!is_crashkernel_mem_reserved()) {
 		ERRMSG("No memory is reserved for crashkenrel!\n");
 		return FALSE;
 	}
 
-
-	if (!info->flag_cyclic)
-		info->flag_cyclic = TRUE;
-
 	info->dump_level = MAX_DUMP_LEVEL;
 
 	if (!get_page_offset())
 		return FALSE;
 
-	if (!open_dump_memory())
+	if (!open_files_for_creating_dumpfile())
 		return FALSE;
 
 	if (!get_elf_loads(info->fd_memory, info->name_memory))
@@ -9239,13 +9233,19 @@ int show_mem_usage(void)
 	if (!initial())
 		return FALSE;
 
+	if (!prepare_bitmap_buffer())
+		return FALSE;
 
-	if (!prepare_bitmap2_buffer())
+	pfn_memhole = info->max_mapnr;
+	first_cycle(0, info->max_mapnr, &cycle);
+	if (!create_1st_bitmap(&cycle))
+		return FALSE;
+	if (!create_2nd_bitmap(&cycle))
 		return FALSE;
 
 	info->num_dumpable = get_num_dumpable_cyclic();
 
-	free_bitmap2_buffer();
+	free_bitmap_buffer();
 
 	print_mem_usage();
 
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

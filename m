Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WuE8n-0004F8-Aq
 for kexec@lists.infradead.org; Tue, 10 Jun 2014 04:58:34 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.197])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id s5A4wAfw004521
 for <kexec@lists.infradead.org>; Tue, 10 Jun 2014 13:58:10 +0900 (JST)
Received: from mailsv.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id s5A4wAv08144 for <kexec@lists.infradead.org>;
 Tue, 10 Jun 2014 13:58:10 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id s5A4w9OE019493
 for <kexec@lists.infradead.org>; Tue, 10 Jun 2014 13:58:09 +0900 (JST)
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 1/3] Remove the 1st bitmap buffer from the ELF path in
 cyclic mode.
Date: Tue, 10 Jun 2014 04:53:13 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE972196BB@BPXM01GP.gisp.nec.co.jp>
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

We can create the 2nd bitmap without creating the 1st bitmap by commit
363d53fc8, so we don't need to create the 1st bitmap in cyclic mode
in the ELF path since it isn't used. Thus, we can use the whole bitmap
buffer only for the 2nd bitmap like the kdump path.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.8 |  1 -
 makedumpfile.c | 88 ++++++----------------------------------------------------
 print_info.c   |  1 -
 3 files changed, 9 insertions(+), 81 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 529335c..25fe74e 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -371,7 +371,6 @@ The default value is 4.
 .TP
 \fB\-\-cyclic\-buffer\fR \fIbuffer_size\fR
 Specify the buffer size in kilo bytes for analysis in the cyclic mode.
-Actually, the double of \fIbuffer_size\fR kilo bytes will be allocated in memory.
 In the cyclic mode, the number of cycles is represented as:
 
     num_of_cycles = system_memory / (\fIbuffer_size\fR * 1024 * bit_per_bytes * page_size )
diff --git a/makedumpfile.c b/makedumpfile.c
index 34db997..f62e94c 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3195,24 +3195,7 @@ out:
 				MSG("Specified buffer size is larger than free memory.\n");
 				MSG("The buffer size for the cyclic mode will ");
 				MSG("be truncated to %lld byte.\n", free_memory);
-				/*
-				 * On conversion from ELF to ELF,
-				 * bufsize_cyclic is used to allocate
-				 * 1st and 2nd bitmap, so it should be
-				 * truncated to the half of
-				 * free_memory.
-				 *
-				 * On conversion from ELF to
-				 * kdump-compressed format, a whole
-				 * part of the 1st bitmap is created
-				 * first, so a whole part of
-				 * free_memory is used for the 2nd
-				 * bitmap.
-				 */
-				if (info->flag_elf_dumpfile)
-					info->bufsize_cyclic = free_memory / 2;
-				else
-					info->bufsize_cyclic = free_memory;
+				info->bufsize_cyclic = free_memory;
 			}
 		}
 
@@ -5016,38 +4999,6 @@ prepare_bitmap_buffer(void)
 }
 
 int
-prepare_bitmap_buffer_cyclic(void)
-{
-	unsigned long long tmp;
-
-	/*
-	 * Create 2 bitmaps (1st-bitmap & 2nd-bitmap) on block_size boundary.
-	 * The crash utility requires both of them to be aligned to block_size
-	 * boundary.
-	 */
-	tmp = divideup(divideup(info->max_mapnr, BITPERBYTE), info->page_size);
-	info->len_bitmap = tmp*info->page_size*2;
-
-	/*
-	 * Prepare partial bitmap buffers for cyclic processing.
-	 */
-	if ((info->partial_bitmap1 = (char *)malloc(info->bufsize_cyclic)) == NULL) {
-		ERRMSG("Can't allocate memory for the 1st-bitmap. %s\n",
-		       strerror(errno));
-		return FALSE;
-	}
-	if ((info->partial_bitmap2 = (char *)malloc(info->bufsize_cyclic)) == NULL) {
-		ERRMSG("Can't allocate memory for the 2nd-bitmap. %s\n",
-		       strerror(errno));
-		return FALSE;
-	}
-	initialize_bitmap_cyclic(info->partial_bitmap1);
-	initialize_bitmap_cyclic(info->partial_bitmap2);
-
-	return TRUE;
-}
-
-int
 prepare_bitmap1_buffer_cyclic(void)
 {
 	/*
@@ -5132,32 +5083,18 @@ free_bitmap2_buffer_cyclic()
 	}
 }
 
-void
-free_bitmap_buffer_cyclic()
-{
-	free_bitmap1_buffer_cyclic();
-	free_bitmap2_buffer_cyclic();
-}
-
 int
 create_dump_bitmap(void)
 {
 	int ret = FALSE;
 
 	if (info->flag_cyclic) {
+		if (!prepare_bitmap2_buffer_cyclic())
+			goto out;
+		info->num_dumpable = get_num_dumpable_cyclic();
 
-		if (info->flag_elf_dumpfile) {
-			if (!prepare_bitmap_buffer_cyclic())
-				goto out;
-
-			info->num_dumpable = get_num_dumpable_cyclic();
-		} else {
-			if (!prepare_bitmap2_buffer_cyclic())
-				goto out;
-
-			info->num_dumpable = get_num_dumpable_cyclic();
+		if (!info->flag_elf_dumpfile)
 			free_bitmap2_buffer_cyclic();
-		}
 
 	} else {
 		if (!prepare_bitmap_buffer())
@@ -6051,8 +5988,6 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 			/*
 			 * Update target region and partial bitmap if necessary.
 			 */
-			if (!create_1st_bitmap_cyclic(&cycle))
-				return FALSE;
 			if (!exclude_unnecessary_pages_cyclic(&cycle))
 				return FALSE;
 
@@ -6198,7 +6133,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	if (!write_cache_bufsz(cd_page))
 		return FALSE;
 
-	free_bitmap_buffer_cyclic();
+	free_bitmap2_buffer_cyclic();
 
 	/*
 	 * print [100 %]
@@ -9027,15 +8962,10 @@ calculate_cyclic_buffer_size(void) {
 	}
 
 	/*
-	 * free_size will be used to allocate 1st and 2nd bitmap, so it
-	 * should be 40% of free memory to keep the size of cyclic buffer
-	 * within 80% of free memory.
+	 *  We should keep the size of cyclic buffer within 80% of free memory
+	 *  for safety.
 	 */
-	if (info->flag_elf_dumpfile) {
-		limit_size = get_free_memory_size() * 0.4;
-	} else {
-		limit_size = get_free_memory_size() * 0.8;
-	}
+	limit_size = get_free_memory_size() * 0.8;
 	bitmap_size = info->max_mapnr / BITPERBYTE;
 
 	/* if --split was specified cyclic buffer allocated per dump file */
diff --git a/print_info.c b/print_info.c
index 104ec1c..7592690 100644
--- a/print_info.c
+++ b/print_info.c
@@ -191,7 +191,6 @@ print_usage(void)
 	MSG("\n");
 	MSG("  [--cyclic-buffer BUFFER_SIZE]:\n");
 	MSG("      Specify the buffer size in kilo bytes for analysis in the cyclic mode.\n");
-	MSG("      Actually, the double of BUFFER_SIZE kilo bytes will be allocated in memory.\n");
 	MSG("      In the cyclic mode, the number of cycles is represented as:\n");
 	MSG("\n");
 	MSG("          num_of_cycles = system_memory / \n");
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

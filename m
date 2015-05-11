Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YrhRO-0007eS-Hs
 for kexec@lists.infradead.org; Mon, 11 May 2015 06:43:51 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6hSbm009174
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:43:28 +0900 (JST)
Received: from mailsv4.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id t4B6hSX22573 for <kexec@lists.infradead.org>;
 Mon, 11 May 2015 15:43:28 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id t4B6hSBf013851
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 15:43:28 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 11/13] Adjust refiltering path to the new code.
Date: Mon, 11 May 2015 06:33:43 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA395@BPXM01GP.gisp.nec.co.jp>
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

Refiltering mode is used in 1st kernel environment, we can
expect enough space from TMPDIR to store the bitmap file.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c | 52 ++++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index e58940b..fe7670f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1033,7 +1033,8 @@ open_dump_bitmap(void)
 	char *tmpname;
 
 	/* Unnecessary to open */
-	if (!info->working_dir && !info->flag_reassemble && !info->flag_mem_usage)
+	if (!info->working_dir && !info->flag_reassemble && !info->flag_refiltering
+	    && !info->flag_mem_usage)
 		return TRUE;
 
 	tmpname = getenv("TMPDIR");
@@ -3198,13 +3199,6 @@ initial(void)
 			return FALSE;
 		}
 
-		if(info->flag_cyclic) {
-			info->flag_cyclic = FALSE;
-			MSG("Switched running mode from cyclic to non-cyclic,\n");
-			MSG("because the cyclic mode doesn't support refiltering\n");
-			MSG("kdump compressed format.\n");
-		}
-
 		info->phys_base = info->kh_memory->phys_base;
 		info->max_dump_level |= info->kh_memory->dump_level;
 
@@ -3256,7 +3250,8 @@ out:
 	if (!get_max_mapnr())
 		return FALSE;
 
-	if (info->working_dir || info->flag_reassemble || info->flag_mem_usage) {
+	if (info->working_dir || info->flag_reassemble || info->flag_refiltering
+	    || info->flag_mem_usage) {
 		/* Implemented as non-cyclic mode based on the file */
 		info->flag_cyclic = FALSE;
 		info->pfn_cyclic = info->max_mapnr;
@@ -3593,24 +3588,6 @@ set_bit_on_2nd_bitmap_for_kernel(mdf_pfn_t pfn, struct cycle *cycle)
 	return set_bit_on_2nd_bitmap(pfn, cycle);
 }
 
-static inline int
-is_in_segs(unsigned long long paddr)
-{
-	if (info->flag_refiltering || info->flag_sadump) {
-		static struct dump_bitmap bitmap1 = {0};
-
-		if (bitmap1.fd == 0)
-			initialize_1st_bitmap(&bitmap1);
-
-		return is_dumpable(&bitmap1, paddr_to_pfn(paddr), NULL);
-	}
-
-	if (paddr_to_offset(paddr))
-		return TRUE;
-	else
-		return FALSE;
-}
-
 int
 read_cache(struct cache_data *cd)
 {
@@ -4723,6 +4700,24 @@ create_1st_bitmap(struct cycle *cycle)
 	}
 }
 
+static inline int
+is_in_segs(unsigned long long paddr)
+{
+	if (info->flag_refiltering || info->flag_sadump) {
+		if (info->bitmap1->fd == 0) {
+			initialize_1st_bitmap(info->bitmap1);
+			create_1st_bitmap_file();
+		}
+
+		return is_dumpable(info->bitmap1, paddr_to_pfn(paddr), NULL);
+	}
+
+	if (paddr_to_offset(paddr))
+		return TRUE;
+	else
+		return FALSE;
+}
+
 /*
  * Exclude the page filled with zero in case of creating an elf dumpfile.
  */
@@ -6945,7 +6940,8 @@ close_dump_file(void)
 void
 close_dump_bitmap(void)
 {
-	if (!info->working_dir && !info->flag_reassemble && !info->flag_mem_usage)
+	if (!info->working_dir && !info->flag_reassemble && !info->flag_refiltering
+	    && !info->flag_mem_usage)
 		return;
 
 	if ((info->fd_bitmap = close(info->fd_bitmap)) < 0)
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

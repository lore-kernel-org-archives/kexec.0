Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YrhRd-0007pK-GI
 for kexec@lists.infradead.org; Mon, 11 May 2015 06:44:06 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 12/13] Adjust sadump path to the new code.
Date: Mon, 11 May 2015 06:34:49 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA39A@BPXM01GP.gisp.nec.co.jp>
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
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>

sadump feature is a kind of refiltering feature, it can use
TMPDIR for the bitmap file too.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index fe7670f..e64a7b4 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1034,7 +1034,7 @@ open_dump_bitmap(void)
 
 	/* Unnecessary to open */
 	if (!info->working_dir && !info->flag_reassemble && !info->flag_refiltering
-	    && !info->flag_mem_usage)
+	    && !info->flag_sadump && !info->flag_mem_usage)
 		return TRUE;
 
 	tmpname = getenv("TMPDIR");
@@ -3213,12 +3213,6 @@ initial(void)
 			return FALSE;
 		}
 
-		if(info->flag_cyclic) {
-			info->flag_cyclic = FALSE;
-			MSG("Switched running mode from cyclic to non-cyclic,\n");
-			MSG("because the cyclic mode doesn't support sadump format.\n");
-		}
-
 		set_page_size(sadump_page_size());
 
 		if (!sadump_initialize_bitmap_memory())
@@ -3251,7 +3245,7 @@ out:
 		return FALSE;
 
 	if (info->working_dir || info->flag_reassemble || info->flag_refiltering
-	    || info->flag_mem_usage) {
+	    || info->flag_sadump || info->flag_mem_usage) {
 		/* Implemented as non-cyclic mode based on the file */
 		info->flag_cyclic = FALSE;
 		info->pfn_cyclic = info->max_mapnr;
@@ -6941,7 +6935,7 @@ void
 close_dump_bitmap(void)
 {
 	if (!info->working_dir && !info->flag_reassemble && !info->flag_refiltering
-	    && !info->flag_mem_usage)
+	    && !info->flag_sadump && !info->flag_mem_usage)
 		return;
 
 	if ((info->fd_bitmap = close(info->fd_bitmap)) < 0)
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

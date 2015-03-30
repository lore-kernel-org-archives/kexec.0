Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YcRCu-0000bM-5g
 for kexec@lists.infradead.org; Mon, 30 Mar 2015 04:21:48 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 5/6] WIP: Communalize the function for creating 1st bitmap.
Date: Mon, 30 Mar 2015 04:09:54 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D9CACB@BPXM01GP.gisp.nec.co.jp>
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
Cc: "cpw@sgi.com" <cpw@sgi.com>

We use the same logic when creating 1st bitmap from memory hole
without bitmap file, but there are two separated functions for
different caller, let's communalize them.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c |   94 +++++++++++++++++++++----------------------------------
 1 files changed, 36 insertions(+), 58 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 605b6dc..691d6a5 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4696,58 +4696,15 @@ create_1st_bitmap_file(void)
 	return TRUE;
 }
 
+int
+create_bitmap_from_memhole(struct cycle *cycle, struct dump_bitmap *bitmap, int count_memhole,
+			   int (*set_bit)(mdf_pfn_t pfn, struct cycle *cycle));
 
 int
 create_1st_bitmap_buffer(struct cycle *cycle)
 {
-	int i;
-	mdf_pfn_t pfn;
-	unsigned long long phys_start, phys_end;
-	mdf_pfn_t pfn_start, pfn_end;
-	mdf_pfn_t pfn_start_roundup, pfn_end_round;
-	unsigned long pfn_start_byte, pfn_end_byte;
-
-	/*
-	 * At first, clear all the bits on the 1st-bitmap.
-	 */
-	initialize_bitmap(info->bitmap1);
-
-	/*
-	 * If page is on memory hole, set bit on the 1st-bitmap.
-	 * (note that this is not done in cyclic mode)
-	 */
-	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
-		pfn_start = MAX(paddr_to_pfn(phys_start), cycle->start_pfn);
-		pfn_end   = MIN(paddr_to_pfn(phys_end), cycle->end_pfn);
-
-		if (pfn_start >= pfn_end)
-			continue;
-
-		pfn_start_roundup = MIN(roundup(pfn_start, BITPERBYTE),
-					pfn_end);
-		pfn_end_round = MAX(round(pfn_end, BITPERBYTE), pfn_start);
-
-		for (pfn = pfn_start; pfn < pfn_start_roundup; pfn++) {
-			set_bit_on_1st_bitmap(pfn, cycle);
-		}
-
-		pfn_start_byte = (pfn_start_roundup - cycle->start_pfn) >> 3;
-		pfn_end_byte = (pfn_end_round - cycle->start_pfn) >> 3;
-
-		if (pfn_start_byte < pfn_end_byte) {
-			memset(info->bitmap1->buf + pfn_start_byte,
-			       0xff,
-			       pfn_end_byte - pfn_start_byte);
-		}
-
-		if (pfn_end_round >= pfn_start) {
-			for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
-				set_bit_on_1st_bitmap(pfn, cycle);
-			}
-		}
-	}
-
-	return TRUE;
+	return create_bitmap_from_memhole(cycle, info->bitmap1, TRUE,
+					  set_bit_on_1st_bitmap);
 }
 
 int
@@ -4853,28 +4810,41 @@ exclude_zero_pages_cyclic(struct cycle *cycle)
 	return TRUE;
 }
 
-static int
+int
 initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 {
+	return create_bitmap_from_memhole(cycle, info->bitmap2, FALSE,
+					  set_bit_on_2nd_bitmap_for_kernel);
+}
+
+int
+create_bitmap_from_memhole(struct cycle *cycle, struct dump_bitmap *bitmap, int count_memhole,
+			   int (*set_bit)(mdf_pfn_t pfn, struct cycle *cycle))
+{
 	int i;
 	mdf_pfn_t pfn;
 	unsigned long long phys_start, phys_end;
 	mdf_pfn_t pfn_start, pfn_end;
 	mdf_pfn_t pfn_start_roundup, pfn_end_round;
 	unsigned long pfn_start_byte, pfn_end_byte;
+	unsigned int num_pt_loads = get_num_pt_loads();
+	struct timeval tv_start;
 
 	/*
-	 * At first, clear all the bits on the 2nd-bitmap.
+	 * At first, clear all the bits on the bitmap.
 	 */
-	initialize_bitmap(info->bitmap2);
+	initialize_bitmap(bitmap);
 
 	/*
-	 * If page is on memory hole, set bit on the 2nd-bitmap.
+	 * If page is on memory hole, set bit on the bitmap.
 	 */
+	gettimeofday(&tv_start, NULL);
 	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
 		pfn_start = MAX(paddr_to_pfn(phys_start), cycle->start_pfn);
 		pfn_end = MIN(paddr_to_pfn(phys_end), cycle->end_pfn);
 
+		print_progress(PROGRESS_HOLES, i, num_pt_loads);
+
 		if (pfn_start >= pfn_end)
 			continue;
 
@@ -4883,29 +4853,37 @@ initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 		pfn_end_round = MAX(round(pfn_end, BITPERBYTE), pfn_start);
 
 		for (pfn = pfn_start; pfn < pfn_start_roundup; ++pfn) {
-			if (!set_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
+			if (!set_bit(pfn, cycle))
 				return FALSE;
-			pfn_memhole--;
+			if (count_memhole)
+				pfn_memhole--;
 		}
 
 		pfn_start_byte = (pfn_start_roundup - cycle->start_pfn) >> 3;
 		pfn_end_byte = (pfn_end_round - cycle->start_pfn) >> 3;
 
 		if (pfn_start_byte < pfn_end_byte) {
-			memset(info->bitmap2->buf + pfn_start_byte,
+			memset(bitmap->buf + pfn_start_byte,
 			       0xff,
 			       pfn_end_byte - pfn_start_byte);
-			pfn_memhole -= (pfn_end_byte - pfn_start_byte) << 3;
+			if (count_memhole)
+				pfn_memhole -= (pfn_end_byte - pfn_start_byte) << 3;
 		}
 
 		if (pfn_end_round >= pfn_start) {
 			for (pfn = pfn_end_round; pfn < pfn_end; ++pfn) {
-				if (!set_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
+				if (!set_bit(pfn, cycle))
 					return FALSE;
-				pfn_memhole--;
+				if (count_memhole)
+					pfn_memhole--;
 			}
 		}
 	}
+        /*
+         * print 100 %
+         */
+        print_progress(PROGRESS_HOLES, info->max_mapnr, info->max_mapnr);
+        print_execution_time(PROGRESS_HOLES, &tv_start);
 
 	return TRUE;
 }
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

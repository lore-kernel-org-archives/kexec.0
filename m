Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WuE9O-0004JA-58
 for kexec@lists.infradead.org; Tue, 10 Jun 2014 04:59:10 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id s5A4wmRS004878
 for <kexec@lists.infradead.org>; Tue, 10 Jun 2014 13:58:48 +0900 (JST)
Received: from mailsv3.nec.co.jp (imss63.nec.co.jp [10.7.69.158]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id s5A4wm408913 for <kexec@lists.infradead.org>;
 Tue, 10 Jun 2014 13:58:48 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id s5A4wmsH025338
 for <kexec@lists.infradead.org>; Tue, 10 Jun 2014 13:58:48 +0900 (JST)
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 2/3] Move counting pfn_memhole for cyclic mode.
Date: Tue, 10 Jun 2014 04:53:41 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE972196C0@BPXM01GP.gisp.nec.co.jp>
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

In cyclic mode, memory holes are checked in initialize_2nd_bitmap_cyclic()
in both the kdump path and the ELF path, so pfn_memhole should be
counted there.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index f62e94c..b8f1ec4 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4450,7 +4450,7 @@ int
 create_1st_bitmap_cyclic(struct cycle *cycle)
 {
 	int i;
-	mdf_pfn_t pfn, pfn_bitmap1;
+	mdf_pfn_t pfn;
 	unsigned long long phys_start, phys_end;
 	mdf_pfn_t pfn_start, pfn_end;
 	mdf_pfn_t pfn_start_roundup, pfn_end_round;
@@ -4465,7 +4465,6 @@ create_1st_bitmap_cyclic(struct cycle *cycle)
 	 * If page is on memory hole, set bit on the 1st-bitmap.
 	 * (note that this is not done in cyclic mode)
 	 */
-	pfn_bitmap1 = 0;
 	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
 		pfn_start = MAX(paddr_to_pfn(phys_start), cycle->start_pfn);
 		pfn_end   = MIN(paddr_to_pfn(phys_end), cycle->end_pfn);
@@ -4478,8 +4477,7 @@ create_1st_bitmap_cyclic(struct cycle *cycle)
 		pfn_end_round = MAX(round(pfn_end, BITPERBYTE), pfn_start);
 
 		for (pfn = pfn_start; pfn < pfn_start_roundup; pfn++) {
-			if (set_bit_on_1st_bitmap(pfn, cycle))
-				pfn_bitmap1++;
+			set_bit_on_1st_bitmap(pfn, cycle);
 		}
 
 		pfn_start_byte = (pfn_start_roundup - cycle->start_pfn) >> 3;
@@ -4489,18 +4487,14 @@ create_1st_bitmap_cyclic(struct cycle *cycle)
 			memset(info->partial_bitmap1 + pfn_start_byte,
 			       0xff,
 			       pfn_end_byte - pfn_start_byte);
-
-			pfn_bitmap1 += (pfn_end_byte - pfn_start_byte) * BITPERBYTE;
 		}
 
 		if (pfn_end_round >= pfn_start) {
 			for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
-				if (set_bit_on_1st_bitmap(pfn, cycle))
-					pfn_bitmap1++;
+				set_bit_on_1st_bitmap(pfn, cycle);
 			}
 		}
 	}
-	pfn_memhole -= pfn_bitmap1;
 
 	return TRUE;
 }
@@ -4589,9 +4583,11 @@ initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 					pfn_end);
 		pfn_end_round = MAX(round(pfn_end, BITPERBYTE), pfn_start);
 
-		for (pfn = pfn_start; pfn < pfn_start_roundup; ++pfn)
+		for (pfn = pfn_start; pfn < pfn_start_roundup; ++pfn) {
 			if (!set_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
 				return FALSE;
+			pfn_memhole--;
+		}
 
 		pfn_start_byte = (pfn_start_roundup - cycle->start_pfn) >> 3;
 		pfn_end_byte = (pfn_end_round - cycle->start_pfn) >> 3;
@@ -4600,12 +4596,14 @@ initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 			memset(info->partial_bitmap2 + pfn_start_byte,
 			       0xff,
 			       pfn_end_byte - pfn_start_byte);
+			pfn_memhole -= (pfn_end_byte - pfn_start_byte) << 3;
 		}
 
 		if (pfn_end_round >= pfn_start) {
 			for (pfn = pfn_end_round; pfn < pfn_end; ++pfn) {
 				if (!set_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
 					return FALSE;
+				pfn_memhole--;
 			}
 		}
 	}
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

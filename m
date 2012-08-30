Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zhH-000222-Jx
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 08:01:52 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.192])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U81nc4012614
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:01:49 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U81n628101 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 17:01:49 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U81n9l003906
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:01:49 +0900 (JST)
Date: Thu, 30 Aug 2012 16:53:35 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 09/16] [PATCH v3 9/12] Enabling --split option with cyclic
 mode.
Message-Id: <20120830165335.38c218860ae9c481fce1055c@mxc.nes.nec.co.jp>
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
Date: Thu, 23 Aug 2012 17:54:16 +0900
Subject: [PATCH 09/16] [PATCH v3 9/12] Enabling --split option with cyclic mode.

This patch enable cyclic mode to split the dump data to multiple dumpfiles.
At this time, the buffer of partial bitmap is prepared for each child process,
you need to consider the amount of memory usage.

This patch split the dump data based on only max_mapnr and num_dumpfile,
so the size of each split dumpfiles will be different by excluding
unnecessary pages.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |   42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 1f499bb..6dfd397 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5445,6 +5445,13 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 	start_pfn = info->cyclic_start_pfn;
 	end_pfn   = info->cyclic_end_pfn;
 
+	if (info->flag_split) {
+		if (start_pfn < info->split_start_pfn)
+			start_pfn = info->split_start_pfn;
+		if (end_pfn > info->split_end_pfn)
+			end_pfn = info->split_end_pfn;
+	}
+
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 
 		if ((num_dumped % per) == 0)
@@ -6730,22 +6737,31 @@ setup_splitting(void)
 	if (info->num_dumpfile <= 1)
 		return FALSE;
 
-	initialize_2nd_bitmap(&bitmap2);
+	if (info->flag_cyclic) {
+		for (i = 0; i < info->num_dumpfile; i++) {
+			SPLITTING_START_PFN(i) = divideup(info->max_mapnr, info->num_dumpfile) * i;
+			SPLITTING_END_PFN(i)   = divideup(info->max_mapnr, info->num_dumpfile) * (i + 1);
+		}
+		if (SPLITTING_END_PFN(i-1) > info->max_mapnr)
+			SPLITTING_END_PFN(i-1) = info->max_mapnr;
+        } else {
+		initialize_2nd_bitmap(&bitmap2);
 
-	pfn_per_dumpfile = num_dumpable / info->num_dumpfile;
-	start_pfn = end_pfn = 0;
-	for (i = 0; i < info->num_dumpfile; i++) {
-		start_pfn = end_pfn;
-		if (i == (info->num_dumpfile - 1)) {
-			end_pfn  = info->max_mapnr;
-		} else {
-			for (j = 0; j < pfn_per_dumpfile; end_pfn++) {
-				if (is_dumpable(&bitmap2, end_pfn))
-					j++;
+		pfn_per_dumpfile = num_dumpable / info->num_dumpfile;
+		start_pfn = end_pfn = 0;
+		for (i = 0; i < info->num_dumpfile; i++) {
+			start_pfn = end_pfn;
+			if (i == (info->num_dumpfile - 1)) {
+				end_pfn  = info->max_mapnr;
+			} else {
+				for (j = 0; j < pfn_per_dumpfile; end_pfn++) {
+					if (is_dumpable(&bitmap2, end_pfn))
+						j++;
+				}
 			}
+			SPLITTING_START_PFN(i) = start_pfn;
+			SPLITTING_END_PFN(i)   = end_pfn;
 		}
-		SPLITTING_START_PFN(i) = start_pfn;
-		SPLITTING_END_PFN(i)   = end_pfn;
 	}
 
 	return TRUE;
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

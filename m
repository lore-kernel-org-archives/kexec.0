Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkQuJ-0008I5-PM
 for kexec@lists.infradead.org; Fri, 29 Jun 2012 02:26:05 +0000
Received: from mailgate4.nec.co.jp ([10.7.69.184])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q5T2Pvtt010188
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 11:25:57 +0900 (JST)
Received: (from root@localhost) by mailgate4.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q5T2Pvf26246 for kexec@lists.infradead.org;
 Fri, 29 Jun 2012 11:25:57 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id q5T2PvmN026914
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 11:25:57 +0900 (JST)
Date: Fri, 29 Jun 2012 11:24:54 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC PATCH v2 9/10] Enabling --split option with cyclic processing.
Message-Id: <20120629112454.bce32ec9.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120629111320.694ec85b.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120629111320.694ec85b.kumagai-atsushi@mxc.nes.nec.co.jp>
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

This patch enable cyclic processing to split the dump data to multiple dumpfiles.
At this time, the buffer of partial bitmap is prepared for each child process,
you need to consider the amount of memory consumption.

This patch split the dump data based on only max_mapnr and num_dumpfile, so the size
of each splitted dumpfiles will be different by excluding unnecessary pages.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |   42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 5670bcf..be0e15e 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5432,6 +5432,13 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
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
@@ -6714,22 +6721,31 @@ setup_splitting(void)
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

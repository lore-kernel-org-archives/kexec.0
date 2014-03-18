Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WPkQM-0005ZV-9I
 for kexec@lists.infradead.org; Tue, 18 Mar 2014 03:10:43 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id C4D203EE0B6
 for <kexec@lists.infradead.org>; Tue, 18 Mar 2014 12:10:15 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id AF65245DEC2
 for <kexec@lists.infradead.org>; Tue, 18 Mar 2014 12:10:15 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 896A645DEBC
 for <kexec@lists.infradead.org>; Tue, 18 Mar 2014 12:10:15 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7115E1DB8047
 for <kexec@lists.infradead.org>; Tue, 18 Mar 2014 12:10:15 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 120121DB803B
 for <kexec@lists.infradead.org>; Tue, 18 Mar 2014 12:10:15 +0900 (JST)
Date: Tue, 18 Mar 2014 12:09:39 +0900 (JST)
Message-Id: <20140318.120939.49114730.d.hatayama@jp.fujitsu.com>
Subject: [PATCH] makedumpfile: --split: assign fair I/O workloads for each
 process
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>

When --split option is specified, fair I/O workloads should be
assigned for each process to maximize amount of performance
optimization by parallel processing.

However, the current implementation of setup_splitting() in cyclic
mode doesn't care about filtering at all; I/O workloads for each
process could be biased easily.

This patch deals with the issue by implementing the fair I/O workload
assignment as setup_splitting_cyclic().

Note: If --split is specified in cyclic mode, we do filtering three
times: in get_dumpable_pages_cyclic(), in setup_splitting_cyclic() and
in writeout_dumpfile(). Filtering takes about 10 minutes on system
with huge memory according to the benchmark on the past, so it might
be necessary to optimize filtering or setup_filtering_cyclic().

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 0bd8b55..d310891 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7885,26 +7885,60 @@ out:
 		return ret;
 }
 
+static int setup_splitting_cyclic(void)
+{
+	int i;
+	unsigned long long j, pfn_per_dumpfile;
+	unsigned long long start_pfn, end_pfn;
+
+	pfn_per_dumpfile = info->num_dumpable / info->num_dumpfile;
+	start_pfn = end_pfn = 0;
+
+	for (i = 0; i < info->num_dumpfile - 1; i++) {
+		struct cycle cycle;
+
+		start_pfn = end_pfn;
+		j = pfn_per_dumpfile;
+
+		for_each_cycle(start_pfn, info->max_mapnr, &cycle) {
+			if (!exclude_unnecessary_pages_cyclic(&cycle))
+				return FALSE;
+			while (j && end_pfn < cycle.end_pfn) {
+				if (is_dumpable_cyclic(info->partial_bitmap2,
+						       end_pfn, &cycle))
+					j--;
+				end_pfn++;
+			}
+			if (!j)
+				break;
+		}
+
+		SPLITTING_START_PFN(i) = start_pfn;
+		SPLITTING_END_PFN(i) = end_pfn;
+	}
+
+	SPLITTING_START_PFN(info->num_dumpfile - 1) = end_pfn;
+	SPLITTING_END_PFN(info->num_dumpfile - 1) = info->max_mapnr;
+
+	return TRUE;
+}
+
 int
 setup_splitting(void)
 {
 	int i;
 	unsigned long long j, pfn_per_dumpfile;
 	unsigned long long start_pfn, end_pfn;
-	unsigned long long num_dumpable = get_num_dumpable();
 	struct dump_bitmap bitmap2;
 
 	if (info->num_dumpfile <= 1)
 		return FALSE;
 
 	if (info->flag_cyclic) {
-		for (i = 0; i < info->num_dumpfile; i++) {
-			SPLITTING_START_PFN(i) = divideup(info->max_mapnr, info->num_dumpfile) * i;
-			SPLITTING_END_PFN(i)   = divideup(info->max_mapnr, info->num_dumpfile) * (i + 1);
-		}
-		if (SPLITTING_END_PFN(i-1) > info->max_mapnr)
-			SPLITTING_END_PFN(i-1) = info->max_mapnr;
+		return setup_splitting_cyclic();
         } else {
+		unsigned long long num_dumpable = get_num_dumpable();
+
 		initialize_2nd_bitmap(&bitmap2);
 
 		pfn_per_dumpfile = num_dumpable / info->num_dumpfile;
-- 
1.8.5.3



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSG05-0000V2-UR
 for kexec@lists.infradead.org; Tue, 25 Mar 2014 01:17:59 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: --split: assign fair I/O workloads for
 each process
Date: Tue, 25 Mar 2014 01:14:46 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F90A2@BPXM01GP.gisp.nec.co.jp>
References: <20140318.120939.49114730.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140318.120939.49114730.d.hatayama@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>
>When --split option is specified, fair I/O workloads should be
>assigned for each process to maximize amount of performance
>optimization by parallel processing.
>
>However, the current implementation of setup_splitting() in cyclic
>mode doesn't care about filtering at all; I/O workloads for each
>process could be biased easily.
>
>This patch deals with the issue by implementing the fair I/O workload
>assignment as setup_splitting_cyclic().
>
>Note: If --split is specified in cyclic mode, we do filtering three
>times: in get_dumpable_pages_cyclic(), in setup_splitting_cyclic() and
>in writeout_dumpfile(). Filtering takes about 10 minutes on system
>with huge memory according to the benchmark on the past, so it might
>be necessary to optimize filtering or setup_filtering_cyclic().

Sorry, I lost the result of that benchmark, could you give me the URL?
I'd like to confirm that the advantage of fair I/O will exceed the
10 minutes disadvantage.


Thanks
Atsushi Kumagai

>Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>---
> makedumpfile.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 41 insertions(+), 7 deletions(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 0bd8b55..d310891 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -7885,26 +7885,60 @@ out:
> 		return ret;
> }
>
>+static int setup_splitting_cyclic(void)
>+{
>+	int i;
>+	unsigned long long j, pfn_per_dumpfile;
>+	unsigned long long start_pfn, end_pfn;
>+
>+	pfn_per_dumpfile = info->num_dumpable / info->num_dumpfile;
>+	start_pfn = end_pfn = 0;
>+
>+	for (i = 0; i < info->num_dumpfile - 1; i++) {
>+		struct cycle cycle;
>+
>+		start_pfn = end_pfn;
>+		j = pfn_per_dumpfile;
>+
>+		for_each_cycle(start_pfn, info->max_mapnr, &cycle) {
>+			if (!exclude_unnecessary_pages_cyclic(&cycle))
>+				return FALSE;
>+			while (j && end_pfn < cycle.end_pfn) {
>+				if (is_dumpable_cyclic(info->partial_bitmap2,
>+						       end_pfn, &cycle))
>+					j--;
>+				end_pfn++;
>+			}
>+			if (!j)
>+				break;
>+		}
>+
>+		SPLITTING_START_PFN(i) = start_pfn;
>+		SPLITTING_END_PFN(i) = end_pfn;
>+	}
>+
>+	SPLITTING_START_PFN(info->num_dumpfile - 1) = end_pfn;
>+	SPLITTING_END_PFN(info->num_dumpfile - 1) = info->max_mapnr;
>+
>+	return TRUE;
>+}
>+
> int
> setup_splitting(void)
> {
> 	int i;
> 	unsigned long long j, pfn_per_dumpfile;
> 	unsigned long long start_pfn, end_pfn;
>-	unsigned long long num_dumpable = get_num_dumpable();
> 	struct dump_bitmap bitmap2;
>
> 	if (info->num_dumpfile <= 1)
> 		return FALSE;
>
> 	if (info->flag_cyclic) {
>-		for (i = 0; i < info->num_dumpfile; i++) {
>-			SPLITTING_START_PFN(i) = divideup(info->max_mapnr, info->num_dumpfile) * i;
>-			SPLITTING_END_PFN(i)   = divideup(info->max_mapnr, info->num_dumpfile) * (i + 1);
>-		}
>-		if (SPLITTING_END_PFN(i-1) > info->max_mapnr)
>-			SPLITTING_END_PFN(i-1) = info->max_mapnr;
>+		return setup_splitting_cyclic();
>         } else {
>+		unsigned long long num_dumpable = get_num_dumpable();
>+
> 		initialize_2nd_bitmap(&bitmap2);
>
> 		pfn_per_dumpfile = num_dumpable / info->num_dumpfile;
>--
>1.8.5.3
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

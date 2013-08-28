Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VEnuh-0002Ax-Gw
 for kexec@lists.infradead.org; Wed, 28 Aug 2013 22:08:33 +0000
Subject: [PATCH] makedumpfile: shorten cyclic unnecessary-page scans
Message-Id: <E1VEnuJ-0000KD-Oe@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 28 Aug 2013 17:08:07 -0500
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

From: Cliff Wickman <cpw@sgi.com>


When the kernel free pages are not detectable with the 'buddy' method
we do a scan for free pages.
In cyclic mode that scan was performed over all of memory for each
cycle region.

This patch records the pfn ranges of each node on the first such cycle.
Then ignores those nodes that are not within the cyclic region on 
subsequent scans.
This shortens these subsequent scans.

Diffed against makedumpfile-1.5.4
Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 makedumpfile.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 2 deletions(-)

Index: makedumpfile-1.5.4/makedumpfile.c
===================================================================
--- makedumpfile-1.5.4.orig/makedumpfile.c
+++ makedumpfile-1.5.4/makedumpfile.c
@@ -36,6 +36,16 @@ struct DumpInfo		*info = NULL;
 
 char filename_stdout[] = FILENAME_STDOUT;
 
+int nr_nodes;
+int node_free_pfns_recorded = 0;
+struct node_free_pfns {
+	unsigned long low_pfn;
+	unsigned long high_pfn;
+	long count;
+	int valid;
+};
+struct node_free_pfns *nfp, *nfp1;
+
 /*
  * The numbers of the excluded pages
  */
@@ -3609,7 +3619,7 @@ page_to_pfn(unsigned long page)
 }
 
 int
-reset_bitmap_of_free_pages(unsigned long node_zones)
+reset_bitmap_of_free_pages(unsigned long node_zones, int node)
 {
 
 	int order, i, migrate_type, migrate_types;
@@ -3653,6 +3663,18 @@ reset_bitmap_of_free_pages(unsigned long
 					retcd = ANALYSIS_FAILED;
 					return FALSE;
 				}
+				if (info->flag_cyclic) {
+					nfp1 = nfp + node;
+					nfp1->valid = 1;
+					nfp1->count++;
+					for (i = 0; i < (1<<order); i++) {
+						pfn = start_pfn + i;
+						if (pfn > nfp1->high_pfn)
+						    nfp1->high_pfn = pfn;
+						if (pfn < nfp1->low_pfn)
+						    nfp1->low_pfn = pfn;
+					}
+				}
 
 				if (!info->flag_cyclic ||
 				    ((start_pfn >= info->cyclic_start_pfn) &&
@@ -3990,8 +4012,31 @@ _exclude_free_page(void)
 			}
 			if (!spanned_pages)
 				continue;
-			if (!reset_bitmap_of_free_pages(zone))
+			/*don't scan for free pages outside of the cyclic area*/
+			if (info->flag_cyclic) {
+			  nfp1 = nfp + node;
+			  if (nfp1->valid) {
+			  	if (!nfp1->count) {
+				/* this node has no free pages */
+					continue;
+				}
+				if (nfp1->high_pfn < info->cyclic_start_pfn) {
+				/* we're at a node lower than the current
+ 				   cyclic region */
+					continue;
+				}
+			  	if (nfp1->low_pfn > info->cyclic_end_pfn) {
+				/* we're up to a node that is all higher than
+				   the current cyclic region */
+					return TRUE;
+				}
+			  }
+			}
+			if (!reset_bitmap_of_free_pages(zone, node))
 				return FALSE;
+			if (info->flag_cyclic) {
+			  nfp1 = nfp + node;
+			}
 		}
 		if (num_nodes < vt.numnodes) {
 			if ((node = next_online_node(node + 1)) < 0) {
@@ -5306,12 +5351,39 @@ get_num_dumpable(void)
 unsigned long long
 get_num_dumpable_cyclic(void)
 {
+	int i;
 	int cycle = 0;
 	int lastcycle = 0;
 	int newcycle = 1;
+	int node;
 	unsigned long long pfn, num_dumpable=0;
 
 	PROGRESS_MSG("Begin page counting phase.\n");
+	/* build a table for free page pfn's per node */
+	if ((node = next_online_node(0)) < 0) {
+		ERRMSG("Can't get first online node.\n");
+		exit(1);
+	}
+	nr_nodes = 1;
+	while (node >= 0) {
+		if ((node = next_online_node(node + 1)) < 0) {
+			node = -1;
+		} else {
+			nr_nodes++;
+		}
+	}
+	if ((nfp = (struct node_free_pfns *)
+		malloc(nr_nodes * sizeof(struct node_free_pfns))) == NULL) {
+		ERRMSG("Can't malloc %d structures.\n", nr_nodes);
+		exit(1);
+	}
+	for (i = 0, nfp1 = nfp; i < nr_nodes; i++, nfp1++) {
+		nfp1->valid = 0;
+		nfp1->count = 0;
+		nfp1->low_pfn = 0xffffffffffffffff;
+		nfp1->high_pfn = 0;
+	}
+
 	for (pfn = 0; pfn < info->max_mapnr; pfn++) {
 		if (newcycle)
 			PROGRESS_MSG("Scan cycle %d\n", cycle + 1);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

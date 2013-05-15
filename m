Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcggZ-0007rm-LL
 for kexec@lists.infradead.org; Wed, 15 May 2013 18:44:25 +0000
Subject: [PATCH] makedumpfile: buddy identification when noncyclic
Message-Id: <E1UcggB-0005hC-Bf@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 15 May 2013 13:43:59 -0500
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
To: kexec@lists.infradead.org
Cc: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp

From: Cliff Wickman <cpw@sgi.com>

The 'buddy' identification of free pages should be done for non-cyclical
dumps as well as cyclical.
Remove the cyclic test from this condition:
    if (info->flag_cyclic && (info->dump_level & DL_EXCLUDE_FREE))
I find this to speed the scan of page structures for a 1TB system from
60sec to 30sec.

And only do the exclude_free_page() procedure if free pages cannot be
identified using the buddy technique.

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 makedumpfile.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: makedumpfile.mmap/makedumpfile.c
===================================================================
--- makedumpfile.mmap.orig/makedumpfile.c
+++ makedumpfile.mmap/makedumpfile.c
@@ -2979,7 +2979,9 @@ out:
 	if (!get_value_for_old_linux())
 		return FALSE;
 
-	if (info->flag_cyclic && (info->dump_level & DL_EXCLUDE_FREE))
+	/* use buddy identification of free pages whether cyclic or not */
+	/* (this can reduce pages scan of 1TB memory from 60sec to 30sec) */
+	if (info->dump_level & DL_EXCLUDE_FREE)
 		setup_page_is_buddy();
 
 	if (info->mmap_region_size > 0 && initialize_mmap()) {
@@ -4154,6 +4156,7 @@ create_1st_bitmap(void)
 
 	/*
 	 * If page is on memory hole, set bit on the 1st-bitmap.
+	 * (note that this is not done in cyclic mode)
 	 */
 	pfn_bitmap1 = 0;
 	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
@@ -4341,9 +4344,9 @@ __exclude_unnecessary_pages(unsigned lon
 
 		/*
 		 * Exclude the free page managed by a buddy
+		 * Use buddy identification of free pages whether cyclic or not.
 		 */
 		if ((info->dump_level & DL_EXCLUDE_FREE)
-		    && info->flag_cyclic
 		    && info->page_is_buddy
 		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
 			int i, nr_pages = 1 << private;
@@ -4584,7 +4587,7 @@ create_2nd_bitmap(void)
 	/*
 	 * Exclude free pages.
 	 */
-	if (info->dump_level & DL_EXCLUDE_FREE)
+	if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
 		if (!exclude_free_page())
 			return FALSE;
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

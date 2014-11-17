Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XqFV2-0006n5-Qc
 for kexec@lists.infradead.org; Mon, 17 Nov 2014 06:09:21 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 2/2] makedumpfile: Change the part of the pfn counter for
 cache page.
Date: Mon, 17 Nov 2014 06:06:55 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D6886C@BPXM01GP.gisp.nec.co.jp>
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
Cc: "harshula@redhat.com" <harshula@redhat.com>

The current counter (pfn_cache and pfn_cache_private) are
used for different dump level. A non-private cache page will
be counted in pfn_cache when the dump level is 2 while it will
be counted in pfn_cache_private when the level is 4.

Rather than that, it would be better to use the counters for
different *type* of excluded pages.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 59c4952..283981f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4999,7 +4999,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 			pfn_counter = &pfn_free;
 		}
 		/*
-		 * Exclude the cache page without the private page.
+		 * Exclude the non-private cache page.
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_CACHE)
 		    && (isLRU(flags) || isSwapCache(flags))
@@ -5007,12 +5007,15 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 			pfn_counter = &pfn_cache;
 		}
 		/*
-		 * Exclude the cache page with the private page.
+		 * Exclude the cache page whether private or non-private.
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
 		    && (isLRU(flags) || isSwapCache(flags))
 		    && !isAnon(mapping)) {
-			pfn_counter = &pfn_cache_private;
+			if (isPrivate(flags))
+				pfn_counter = &pfn_cache_private;
+			else
+				pfn_counter = &pfn_cache;
 		}
 		/*
 		 * Exclude the data page of the user process.
@@ -8273,8 +8276,8 @@ print_report(void)
 	REPORT_MSG("Original pages  : 0x%016llx\n", pfn_original);
 	REPORT_MSG("  Excluded pages   : 0x%016llx\n", pfn_excluded);
 	REPORT_MSG("    Pages filled with zero  : 0x%016llx\n", pfn_zero);
-	REPORT_MSG("    Cache pages             : 0x%016llx\n", pfn_cache);
-	REPORT_MSG("    Cache pages + private   : 0x%016llx\n",
+	REPORT_MSG("    Non-private cache pages : 0x%016llx\n", pfn_cache);
+	REPORT_MSG("    Private cache pages     : 0x%016llx\n",
 	    pfn_cache_private);
 	REPORT_MSG("    User process data pages : 0x%016llx\n", pfn_user);
 	REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free);
@@ -8311,8 +8314,9 @@ print_mem_usage(void)
 	MSG("----------------------------------------------------------------------\n");
 
 	MSG("ZERO		%-16llu	yes		Pages filled with zero\n", pfn_zero);
-	MSG("CACHE		%-16llu	yes		Cache pages\n", pfn_cache);
-	MSG("CACHE_PRIVATE	%-16llu	yes		Cache pages + private\n",
+	MSG("NON_PRI_CACHE	%-16llu	yes		Cache pages without private flag\n",
+	    pfn_cache);
+	MSG("PRI_CACHE	%-16llu	yes		Cache pages with private flag\n",
 	    pfn_cache_private);
 	MSG("USER		%-16llu	yes		User process pages\n", pfn_user);
 	MSG("FREE		%-16llu	yes		Free pages\n", pfn_free);
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YTolA-0002Dy-If
 for kexec@lists.infradead.org; Fri, 06 Mar 2015 09:41:33 +0000
Message-Id: <4962021e022de9ceb07515bb9aab8bde61cd4f6b.1425634290.git.ptesarik@suse.cz>
In-Reply-To: <cover.1425634290.git.ptesarik@suse.cz>
References: <cover.1425634290.git.ptesarik@suse.cz>
From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 6 Mar 2015 10:26:13 +0100
Subject: [PATCH 4/4] cache: add hit/miss statistics to the final report
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Jan Willeke <willeke@de.ibm.com>

Add the most basic cache statistics (pages hit and missed). Note that
the hit rate is not printed if cache was not used to avoid division
by zero.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 makedumpfile.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index c62d035..d778139 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -39,6 +39,10 @@ struct SplitBlock		*splitblock = NULL;
 
 char filename_stdout[] = FILENAME_STDOUT;
 
+/* Cache statistics */
+static unsigned long long	cache_hit;
+static unsigned long long	cache_miss;
+
 static void first_cycle(mdf_pfn_t start, mdf_pfn_t max, struct cycle *cycle)
 {
 	cycle->start_pfn = round(start, info->pfn_cyclic);
@@ -645,6 +649,7 @@ next_page:
 	pgaddr = PAGEBASE(paddr);
 	pgbuf = cache_search(pgaddr);
 	if (!pgbuf) {
+		++cache_miss;
 		cached = cache_alloc(pgaddr);
 		if (!cached)
 			goto error;
@@ -661,7 +666,8 @@ next_page:
 				goto error_cached;
 		}
 		cache_add(cached);
-	}
+	} else
+		++cache_hit;
 
 	memcpy(bufptr, pgbuf + PAGEOFFSET(paddr), read_size);
 
@@ -8294,6 +8300,11 @@ print_report(void)
 	REPORT_MSG("--------------------------------------------------\n");
 	REPORT_MSG("Total pages     : 0x%016llx\n", info->max_mapnr);
 	REPORT_MSG("\n");
+	REPORT_MSG("Cache hit: %lld, miss: %lld", cache_hit, cache_miss);
+	if (cache_hit + cache_miss)
+		REPORT_MSG(", hit rate: %.1f%%",
+		    100.0 * cache_hit / (cache_hit + cache_miss));
+	REPORT_MSG("\n\n");
 }
 
 static void
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WW0rr-0004L7-RU
 for kexec@lists.infradead.org; Fri, 04 Apr 2014 09:57:00 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH 1/2] Generic handling of multi-page exclusions
Date: Fri,  4 Apr 2014 11:56:08 +0200
Message-Id: <95b0fca0e89f8c7f62533cd299266c45b2351a37.1396604782.git.ptesarik@suse.cz>
In-Reply-To: <cover.1396604782.git.ptesarik@suse.cz>
References: <cover.1396604782.git.ptesarik@suse.cz>
In-Reply-To: <cover.1396604782.git.ptesarik@suse.cz>
References: <cover.1396604782.git.ptesarik@suse.cz>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org

When multiple pages are excluded from the dump, store the extents in the
DumpInfo structure and filter them in the normal loop. By doing it this
way, there is no need to process the whole region in the same cycle.

I chose to store the start and end PFN, rather than just the number of
pages, because this algorithm is more robust in case the memory map does
not cover the full range.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 makedumpfile.c | 33 +++++++++++++++++----------------
 makedumpfile.h |  7 +++++++
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 5e81cc5..61ee886 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4683,6 +4683,16 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 			continue;
 
 		/*
+		 * If this is part of a multi-page exclusion, exclude this pfn.
+		 */
+		if (info->exclude_pfn_start <= pfn && pfn < info->exclude_pfn_end) {
+			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
+				(*info->exclude_pfn_counter)++;
+			info->exclude_pfn_start = pfn + 1;
+			continue;
+		}
+
+		/*
 		 * Exclude the memory hole.
 		 */
 		if (is_xen_memory()) {
@@ -4732,23 +4742,14 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		if ((info->dump_level & DL_EXCLUDE_FREE)
 		    && info->page_is_buddy
 		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
-			int i, nr_pages = 1 << private;
+			int nr_pages = 1 << private;
 
-			for (i = 0; i < nr_pages; ++i) {
-				/*
-				 * According to combination of
-				 * MAX_ORDER and size of cyclic
-				 * buffer, this clearing bit operation
-				 * can overrun the cyclic buffer.
-				 *
-				 * See check_cyclic_buffer_overrun()
-				 * for the detail.
-				 */
-				if (clear_bit_on_2nd_bitmap_for_kernel((pfn + i), cycle))
-					pfn_free++;
-			}
-			pfn += nr_pages - 1;
-			mem_map += (nr_pages - 1) * SIZE(page);
+			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
+				pfn_free++;
+
+			info->exclude_pfn_start = pfn + 1;
+			info->exclude_pfn_end = pfn + nr_pages;
+			info->exclude_pfn_counter = &pfn_free;
 		}
 		/*
 		 * Exclude the cache page without the private page.
diff --git a/makedumpfile.h b/makedumpfile.h
index 951ed1b..fc6e89a 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1078,6 +1078,13 @@ struct DumpInfo {
 	 */
 	int (*page_is_buddy)(unsigned long flags, unsigned int _mapcount,
 			     unsigned long private, unsigned int _count);
+
+	/*
+	 * for excluding multi-page regions
+	 */
+	unsigned long		exclude_pfn_start;
+	unsigned long		exclude_pfn_end;
+	unsigned long long	*exclude_pfn_counter;
 };
 extern struct DumpInfo		*info;
 
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

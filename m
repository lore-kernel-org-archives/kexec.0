Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WW7s5-0001r2-7g
 for kexec@lists.infradead.org; Fri, 04 Apr 2014 17:25:44 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH v2 2/3] Generic handling of multi-page exclusions
Date: Fri,  4 Apr 2014 19:25:08 +0200
Message-Id: <25702884512808755449395c1622f2aed7b3be00.1396632131.git.ptesarik@suse.cz>
In-Reply-To: <cover.1396632131.git.ptesarik@suse.cz>
References: <cover.1396632131.git.ptesarik@suse.cz>
In-Reply-To: <cover.1396632131.git.ptesarik@suse.cz>
References: <cover.1396632131.git.ptesarik@suse.cz>
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
mem_map_data structure, and check if anything is still pending on the
next invocation of __exclude_unnecessary_pages for the same mem_map.

The start PFN of the excluded extent is set to the end of the current
cycle (which is equal to the start of the next cycle, see update_cycle),
so only the part of the excluded region which falls beyond current cycle
buffer is valid. If the excluded region is completely processed in the
current cycle, the start PFN is even bigger than the end PFN. That
causes nothing to be done at the beginning of the next cycle.

There is no check whether the adjusted pfn_start is still within the
current cycle. Nothing bad happens if it isn't, because exclude_range()
is used again to exclude the remaining part, so even if the excluded
region happens to span more than two cycles, the code will still work
correctly.

Note that clear_bit_on_2nd_bitmap_for_kernel() accepts PFNs outside the
current cyclic range. It willreturn FALSE, so such PFNs are not counted.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 makedumpfile.c | 47 +++++++++++++++++++++++++++++++++--------------
 makedumpfile.h |  7 +++++++
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 81c687b..9ffb901 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2385,6 +2385,9 @@ dump_mem_map(unsigned long long pfn_start,
 	mmd->pfn_end   = pfn_end;
 	mmd->mem_map   = mem_map;
 
+	mmd->exclude_pfn_start = 0ULL;
+	mmd->exclude_pfn_end   = 0ULL;
+
 	DEBUG_MSG("mem_map (%d)\n", num_mm);
 	DEBUG_MSG("  mem_map    : %lx\n", mem_map);
 	DEBUG_MSG("  pfn_start  : %llx\n", pfn_start);
@@ -4657,6 +4660,21 @@ initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 	return TRUE;
 }
 
+static void
+exclude_range(unsigned long long *counter, struct mem_map_data *mmd,
+    unsigned long long pfn, unsigned long long endpfn, struct cycle *cycle)
+{
+	while (pfn < endpfn) {
+		if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
+			(*counter)++;
+		++pfn;
+	}
+
+	mmd->exclude_pfn_start = cycle ? cycle->end_pfn : ULONGLONG_MAX;
+	mmd->exclude_pfn_end = endpfn;
+	mmd->exclude_pfn_counter = counter;
+}
+
 int
 __exclude_unnecessary_pages(struct mem_map_data *mmd, struct cycle *cycle)
 {
@@ -4671,6 +4689,18 @@ __exclude_unnecessary_pages(struct mem_map_data *mmd, struct cycle *cycle)
 	unsigned long flags, mapping, private = 0;
 
 	/*
+	 * If a multi-page exclusion is pending, do it first
+	 */
+	if (mmd->exclude_pfn_start < mmd->exclude_pfn_end) {
+		exclude_range(mmd->exclude_pfn_counter, mmd,
+			mmd->exclude_pfn_start, mmd->exclude_pfn_end,
+			cycle);
+
+		mem_map += (mmd->exclude_pfn_end - pfn_start) * SIZE(page);
+		pfn_start = mmd->exclude_pfn_end;
+	}
+
+	/*
 	 * Refresh the buffer of struct page, when changing mem_map.
 	 */
 	pfn_read_start = ULONGLONG_MAX;
@@ -4734,21 +4764,10 @@ __exclude_unnecessary_pages(struct mem_map_data *mmd, struct cycle *cycle)
 		if ((info->dump_level & DL_EXCLUDE_FREE)
 		    && info->page_is_buddy
 		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
-			int i, nr_pages = 1 << private;
+			int nr_pages = 1 << private;
+
+			exclude_range(&pfn_free, mmd, pfn, pfn + nr_pages, cycle);
 
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
 			pfn += nr_pages - 1;
 			mem_map += (nr_pages - 1) * SIZE(page);
 		}
diff --git a/makedumpfile.h b/makedumpfile.h
index 951ed1b..dfad569 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -816,6 +816,13 @@ struct mem_map_data {
 	unsigned long long	pfn_start;
 	unsigned long long	pfn_end;
 	unsigned long	mem_map;
+
+	/*
+	 * for excluding multi-page regions
+	 */
+	unsigned long		exclude_pfn_start;
+	unsigned long		exclude_pfn_end;
+	unsigned long long	*exclude_pfn_counter;
 };
 
 struct dump_bitmap {
-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

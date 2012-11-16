Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZE44-0006Bc-UF
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 05:02:06 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 790303EE081
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:03 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5FAC845DEB6
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:03 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 490C845DEB2
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:03 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3CE661DB803F
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:03 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E5AF21DB8038
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:02 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 06/10] Exclude free pages by looking up mem_map array
Date: Fri, 16 Nov 2012 14:02:02 +0900
Message-ID: <20121116050202.8280.59537.stgit@localhost6.localdomain6>
In-Reply-To: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
References: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Add free page filtering logic in __exclude_unnecessary_pages.

Unlike other filtering levels, the number of free pages indicated by
buddy page is multiple. So I put this logic in the first position, in
front of page cache, to avoid filtering the pages that has already
been filtered as free pages.

Basically, this mem_map array logic is in cyclic mode only. The
exceptional case is that debug information necessary for mem_map logic
is not available enough. Then, it is switched to freelist logic.

In non cyclic mode, existing freelist logic is used.

Newly introduced page_is_buddy handler abstracts condition of buddy
page that varies depending on kernel versions. On the kernel versions
supported by makedumpfile, there are three kinds of buddy
conditions. Later patches will introduce them in order.

If failing to choose a correct page_is_buddy handler due to absence of
debug information, we switch the logic to freelist logic.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   45 ++++++++++++++++++++++++++++++++++++++++-----
 makedumpfile.h |    5 +++++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 1a0151c..0e44a8b 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -58,6 +58,8 @@ do { \
 		*ptr_long_table = value; \
 } while (0)
 
+static void setup_page_is_buddy(void);
+
 void
 initialize_tables(void)
 {
@@ -2841,6 +2843,9 @@ out:
 	if (!get_value_for_old_linux())
 		return FALSE;
 
+	if (info->flag_cyclic && (info->dump_level & DL_EXCLUDE_FREE))
+		setup_page_is_buddy();
+
 	return TRUE;
 }
 
@@ -3663,6 +3668,18 @@ exclude_free_page(void)
 	return TRUE;
 }
 
+static void
+setup_page_is_buddy(void)
+{
+	if (OFFSET(page.private) == NOT_FOUND_STRUCTURE)
+		goto out;
+
+out:
+	if (!info->page_is_buddy)
+		DEBUG_MSG("Can't select page_is_buddy handler; "
+			  "follow free lists instead of mem_map array.\n");
+}
+
 /*
  * If using a dumpfile in kdump-compressed format as a source file
  * instead of /proc/vmcore, 1st-bitmap of a new dumpfile must be
@@ -3873,8 +3890,8 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 	unsigned long long pfn_read_start, pfn_read_end, index_pg;
 	unsigned char page_cache[SIZE(page) * PGMM_CACHED];
 	unsigned char *pcache;
-	unsigned int _count;
-	unsigned long flags, mapping;
+	unsigned int _count, _mapcount = 0;
+	unsigned long flags, mapping, private = 0;
 
 	/*
 	 * Refresh the buffer of struct page, when changing mem_map.
@@ -3928,11 +3945,28 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		flags   = ULONG(pcache + OFFSET(page.flags));
 		_count  = UINT(pcache + OFFSET(page._count));
 		mapping = ULONG(pcache + OFFSET(page.mapping));
+		if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
+			_mapcount = UINT(pcache + OFFSET(page._mapcount));
+		if (OFFSET(page.private) != NOT_FOUND_STRUCTURE)
+			private = ULONG(pcache + OFFSET(page.private));
 
 		/*
+		 * Exclude the free page managed by a buddy
+		 */
+		if ((info->dump_level & DL_EXCLUDE_FREE)
+		    && info->flag_cyclic
+		    && info->page_is_buddy
+		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
+			int i;
+
+			for (i = 0; i < (1 << private); ++i)
+				clear_bit_on_2nd_bitmap_for_kernel(pfn + i);
+			pfn_free += i;
+		}
+		/*
 		 * Exclude the cache page without the private page.
 		 */
-		if ((info->dump_level & DL_EXCLUDE_CACHE)
+		else if ((info->dump_level & DL_EXCLUDE_CACHE)
 		    && (isLRU(flags) || isSwapCache(flags))
 		    && !isPrivate(flags) && !isAnon(mapping)) {
 			if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
@@ -4013,7 +4047,7 @@ exclude_unnecessary_pages_cyclic(void)
 	 */
 	copy_bitmap_cyclic();
 
-	if (info->dump_level & DL_EXCLUDE_FREE)
+	if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
 		if (!exclude_free_page())
 			return FALSE;
 
@@ -4022,7 +4056,8 @@ exclude_unnecessary_pages_cyclic(void)
 	 */
 	if (info->dump_level & DL_EXCLUDE_CACHE ||
 	    info->dump_level & DL_EXCLUDE_CACHE_PRI ||
-	    info->dump_level & DL_EXCLUDE_USER_DATA) {
+	    info->dump_level & DL_EXCLUDE_USER_DATA ||
+	    ((info->dump_level & DL_EXCLUDE_FREE) && info->page_is_buddy)) {
 
 		gettimeofday(&tv_start, NULL);
 
diff --git a/makedumpfile.h b/makedumpfile.h
index d69bcca..c236ece 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1037,6 +1037,11 @@ struct DumpInfo {
 	 */
 	int flag_sadump_diskset;
 	enum sadump_format_type flag_sadump;         /* sadump format type */
+	/*
+	 * for filtering free pages managed by buddy system:
+	 */
+	int (*page_is_buddy)(unsigned long flags, unsigned int _mapcount,
+			     unsigned long private, unsigned int _count);
 };
 extern struct DumpInfo		*info;
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

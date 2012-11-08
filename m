Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWOj4-0006B6-2V
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 09:48:44 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A47B33EE0BB
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:40 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8C8A545DEB5
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:40 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 75ABC45DEB2
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:40 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 684441DB803B
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:40 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 139421DB8038
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:40 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 06/10] Exclude free pages by looking up mem_map array
Date: Thu, 08 Nov 2012 18:48:39 +0900
Message-ID: <20121108094839.30421.85284.stgit@localhost6.localdomain6>
In-Reply-To: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
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
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp

Add free page filtering logic in __exclude_unnecessary_pages.

Unlike other filtering levels, the number of free pages indicated by
buddy page is multiple. So I put this logic in the first position to
skip the pages corresponding to free pages.

This mem_map array logic is used in cyclic mode only. In non cyclic
mode, existing freelist logic is used.

Newly introduced page_is_buddy handler abstracts condition of buddy
page that varies depending on kernel versions. On the kernel versions
supported by makedumpfile, there are three kinds of buddy
conditions. Later patches will introduce them in order.

If failing to choose a correct page_is_buddy handler, then we give up
free pages filtering.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   40 ++++++++++++++++++++++++++++++++--------
 makedumpfile.h |    5 +++++
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index cb64902..6358fc0 100644
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
@@ -2815,6 +2817,9 @@ out:
 	if (!get_value_for_old_linux())
 		return FALSE;
 
+	if (info->flag_cyclic && (info->dump_level & DL_EXCLUDE_FREE))
+		setup_page_is_buddy();
+
 	return TRUE;
 }
 
@@ -3637,6 +3642,13 @@ exclude_free_page(void)
 	return TRUE;
 }
 
+static void
+setup_page_is_buddy(void)
+{
+	MSG("Can't select page_is_buddy handler; "
+	    "filtering free pages is disabled.\n");
+}
+
 /*
  * If using a dumpfile in kdump-compressed format as a source file
  * instead of /proc/vmcore, 1st-bitmap of a new dumpfile must be
@@ -3847,8 +3859,8 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 	unsigned long long pfn_read_start, pfn_read_end, index_pg;
 	unsigned char page_cache[SIZE(page) * PGMM_CACHED];
 	unsigned char *pcache;
-	unsigned int _count;
-	unsigned long flags, mapping;
+	unsigned int _count, _mapcount;
+	unsigned long flags, mapping, private;
 
 	/*
 	 * Refresh the buffer of struct page, when changing mem_map.
@@ -3902,11 +3914,26 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		flags   = ULONG(pcache + OFFSET(page.flags));
 		_count  = UINT(pcache + OFFSET(page._count));
 		mapping = ULONG(pcache + OFFSET(page.mapping));
+		_mapcount = UINT(pcache + OFFSET(page._mapcount));
+		private = ULONG(pcache + OFFSET(page.private));
+
+		/*
+		 * Exclude the free page managed by a buddy
+		 */
+		if ((info->dump_level & DL_EXCLUDE_FREE)
+		    && info->flag_cyclic
+		    && info->page_is_buddy
+		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
+			int i;
 
+			for (i = 0; i < (1 << private); ++i)
+				clear_bit_on_2nd_bitmap_for_kernel(pfn + i);
+			pfn_free += i;
+		}
 		/*
 		 * Exclude the cache page without the private page.
 		 */
-		if ((info->dump_level & DL_EXCLUDE_CACHE)
+		else if ((info->dump_level & DL_EXCLUDE_CACHE)
 		    && (isLRU(flags) || isSwapCache(flags))
 		    && !isPrivate(flags) && !isAnon(mapping)) {
 			if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
@@ -3987,16 +4014,13 @@ exclude_unnecessary_pages_cyclic(void)
 	 */
 	copy_bitmap_cyclic();
 
-	if (info->dump_level & DL_EXCLUDE_FREE)
-		if (!exclude_free_page())
-			return FALSE;
-
 	/*
 	 * Exclude cache pages, cache private pages, user data pages, and free pages.
 	 */
 	if (info->dump_level & DL_EXCLUDE_CACHE ||
 	    info->dump_level & DL_EXCLUDE_CACHE_PRI ||
-	    info->dump_level & DL_EXCLUDE_USER_DATA) {
+	    info->dump_level & DL_EXCLUDE_USER_DATA ||
+	    info->dump_level & DL_EXCLUDE_FREE) {
 
 		gettimeofday(&tv_start, NULL);
 
diff --git a/makedumpfile.h b/makedumpfile.h
index fecb003..3ccc750 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1031,6 +1031,11 @@ struct DumpInfo {
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

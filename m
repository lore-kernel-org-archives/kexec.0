Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pz0-f49.google.com ([209.85.210.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkIgC-0005ZJ-Nn
 for kexec@lists.infradead.org; Thu, 28 Jun 2012 17:38:57 +0000
Received: by dadm1 with SMTP id m1so3477513dad.36
 for <kexec@lists.infradead.org>; Thu, 28 Jun 2012 10:38:55 -0700 (PDT)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RFC PATCH 07/10] Add excldue free pages by looking up mem_map array
Date: Fri, 29 Jun 2012 02:38:52 +0900
Message-ID: <20120628173852.19702.92618.stgit@fedora-machine>
In-Reply-To: <20120628173757.19702.75678.stgit@fedora-machine>
References: <20120628173757.19702.75678.stgit@fedora-machine>
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

Add free page filtering logic in the processing looking up mem_map
array. page_is_buddy handler is newly introduced, which abstracts
condition of determining buddy page that varies depending on kernel
versions. On makedumpfile suppoting range of kernel versions, there
are three kinds of page_is_buddy, which are introduced in later
patches. Also, _mapcount and private fields of page struct are newly
introduced, which are used in the page_is_buddy handlers.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   21 ++++++++++++++++++---
 makedumpfile.h |    6 ++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index d1eded0..37c371e 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3689,8 +3689,8 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 	unsigned long long pfn_read_start, pfn_read_end, index_pg;
 	unsigned char page_cache[SIZE(page) * PGMM_CACHED];
 	unsigned char *pcache;
-	unsigned int _count;
-	unsigned long flags, mapping;
+	unsigned int _count, _mapcount;
+	unsigned long flags, mapping, private;
 
 	/*
 	 * Refresh the buffer of struct page, when changing mem_map.
@@ -3738,11 +3738,26 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		flags   = ULONG(pcache + OFFSET(page.flags));
 		_count  = UINT(pcache + OFFSET(page._count));
 		mapping = ULONG(pcache + OFFSET(page.mapping));
+		_mapcount = UINT(pcache + OFFSET(page._mapcount));
+		private = ULONG(pcache + OFFSET(page.private));
 
+ 		/*
+		 * Exclude the free page managed by a buddy.
+		 */
+		if ((info->dump_level & DL_EXCLUDE_FREE_CONST)
+		    && info->page_is_buddy
+		    && info->page_is_buddy(flags, _mapcount, private,
+					   _count)) {
+			int i;
+
+			for (i = 0; i < (1<<private); ++i)
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
 			clear_bit_on_2nd_bitmap_for_kernel(pfn);
diff --git a/makedumpfile.h b/makedumpfile.h
index 404f00e..d867dfe 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -943,6 +943,12 @@ struct DumpInfo {
 	 */
 	int flag_sadump_diskset;
 	enum sadump_format_type flag_sadump;         /* sadump format type */
+
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

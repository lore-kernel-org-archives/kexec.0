Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zZm-0001jD-3B
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 07:54:07 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U7s3CU005920
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 16:54:03 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U7s3O06549 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 16:54:03 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U7s24h013216
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 16:54:02 +0900 (JST)
Date: Thu, 30 Aug 2012 16:47:01 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 03/16] [PATCH v3 3/12] Change the function related to
 excluding unnecessary pages.
Message-Id: <20120830164701.b64acec40a0bc1bac9b3457e@mxc.nes.nec.co.jp>
In-Reply-To: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
References: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Thu, 23 Aug 2012 17:49:16 +0900
Subject: [PATCH 03/16] [PATCH v3 3/12] Change the function related to excluding unnecessary pages.

Extend the function related to excluding unnecessary pages.
The function creates partial bitmap corresponding to range of target region
in cyclic mode.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |  100 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 11 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 30851c2..f706e29 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3266,9 +3266,9 @@ reset_bitmap_of_free_pages(unsigned long node_zones)
 				}
 				for (i = 0; i < (1<<order); i++) {
 					pfn = start_pfn + i;
-					clear_bit_on_2nd_bitmap_for_kernel(pfn);
+					if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
+						found_free_pages++;
 				}
-				found_free_pages += i;
 
 				previous = curr;
 				if (!readmem(VADDR, curr+OFFSET(list_head.next),
@@ -3302,7 +3302,7 @@ reset_bitmap_of_free_pages(unsigned long node_zones)
 		ERRMSG("Can't get free_pages.\n");
 		return FALSE;
 	}
-	if (free_pages != found_free_pages) {
+	if (free_pages != found_free_pages && !info->flag_cyclic) {
 		/*
 		 * On linux-2.6.21 or later, the number of free_pages is
 		 * sometimes different from the one of the list "free_area",
@@ -3642,6 +3642,39 @@ create_1st_bitmap(void)
 	return TRUE;
 }
 
+int
+create_1st_bitmap_cyclic()
+{
+	int i;
+	unsigned long long pfn, pfn_bitmap1;
+	unsigned long long phys_start, phys_end;
+	unsigned long long pfn_start, pfn_end;
+
+	/*
+	 * At first, clear all the bits on the 1st-bitmap.
+	 */
+	initialize_bitmap_cyclic(info->partial_bitmap1);
+
+	/*
+	 * If page is on memory hole, set bit on the 1st-bitmap.
+	 */
+	pfn_bitmap1 = 0;
+	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
+		pfn_start = paddr_to_pfn(phys_start);
+		pfn_end   = paddr_to_pfn(phys_end);
+
+		if (!is_in_segs(pfn_to_paddr(pfn_start)))
+			pfn_start++;
+		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
+			if (set_bit_on_1st_bitmap(pfn))
+				pfn_bitmap1++;
+		}
+	}
+	pfn_memhole -= pfn_bitmap1;
+
+	return TRUE;
+}
+
 /*
  * Exclude the page filled with zero in case of creating an elf dumpfile.
  */
@@ -3682,8 +3715,8 @@ exclude_zero_pages(void)
 			}
 		}
 		if (is_zero_page(buf, info->page_size)) {
-			clear_bit_on_2nd_bitmap(pfn);
-			pfn_zero++;
+			if (clear_bit_on_2nd_bitmap(pfn))
+				pfn_zero++;
 		}
 	}
 
@@ -3760,8 +3793,8 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		if ((info->dump_level & DL_EXCLUDE_CACHE)
 		    && (isLRU(flags) || isSwapCache(flags))
 		    && !isPrivate(flags) && !isAnon(mapping)) {
-			clear_bit_on_2nd_bitmap_for_kernel(pfn);
-			pfn_cache++;
+			if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
+				pfn_cache++;
 		}
 		/*
 		 * Exclude the cache page with the private page.
@@ -3769,16 +3802,16 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
 		    && (isLRU(flags) || isSwapCache(flags))
 		    && !isAnon(mapping)) {
-			clear_bit_on_2nd_bitmap_for_kernel(pfn);
-			pfn_cache_private++;
+			if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
+				pfn_cache_private++;
 		}
 		/*
 		 * Exclude the data page of the user process.
 		 */
 		else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
 		    && isAnon(mapping)) {
-			clear_bit_on_2nd_bitmap_for_kernel(pfn);
-			pfn_user++;
+			if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
+				pfn_user++;
 		}
 	}
 	return TRUE;
@@ -3815,6 +3848,51 @@ exclude_unnecessary_pages(void)
 	return TRUE;
 }
 
+void
+copy_bitmap_cyclic(void)
+{
+	memcpy(info->partial_bitmap2, info->partial_bitmap1, BUFSIZE_CYCLIC);
+}
+
+int
+exclude_unnecessary_pages_cyclic(void)
+{
+	unsigned int mm;
+	struct mem_map_data *mmd;
+
+	/*
+	 * Copy 1st-bitmap to 2nd-bitmap.
+	 */
+	copy_bitmap_cyclic();
+
+	if (info->dump_level & DL_EXCLUDE_FREE)
+		if (!exclude_free_page())
+			return FALSE;
+
+	/*
+	 * Exclude cache pages, cache private pages, user data pages, and free pages.
+	 */
+	if (info->dump_level & DL_EXCLUDE_CACHE ||
+	    info->dump_level & DL_EXCLUDE_CACHE_PRI ||
+	    info->dump_level & DL_EXCLUDE_USER_DATA) {
+		for (mm = 0; mm < info->num_mem_map; mm++) {
+
+			mmd = &info->mem_map_data[mm];
+
+			if (mmd->mem_map == NOT_MEMMAP_ADDR)
+				continue;
+
+			if (mmd->pfn_end >= info->cyclic_start_pfn || mmd->pfn_start <= info->cyclic_end_pfn) {
+				if (!__exclude_unnecessary_pages(mmd->mem_map,
+								 mmd->pfn_start, mmd->pfn_end))
+					return FALSE;
+			}
+		}
+	}
+
+	return TRUE;
+}
+
 int
 copy_bitmap(void)
 {
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

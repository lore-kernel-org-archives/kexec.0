Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1htIcW-0006yj-Uq
 for kexec@lists.infradead.org; Thu, 01 Aug 2019 21:28:22 +0000
Received: by mail-io1-xd44.google.com with SMTP id k20so147594843ios.10
 for <kexec@lists.infradead.org>; Thu, 01 Aug 2019 14:28:18 -0700 (PDT)
From: =?UTF-8?q?Don=20Brady=C2=A0?= <don.brady@delphix.com>
Subject: [RFC PATCH] makedumpfile: exclude ZFS file cache pages
Date: Thu,  1 Aug 2019 15:26:17 -0600
Message-Id: <20190801212617.9698-1-don.brady@delphix.com>
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
To: kexec@lists.infradead.org
Cc: Don Brady <don.brady@delphix.com>

From: Don Brady <don.brady@delphix.com>

ZFS caches pages for file data in its Adaptive Replacement Cache (ARC).
This cache is separate from the VFS page cache.  The amount of data
cached can be significant and it would be ideal to exclude it from the
crashdump file.  ZFS can tag these pages so they are easily identifiable
from within makedumpfile.

ref https://github.com/zfsonlinux/zfs/pull/8899/files

Below is a suggested patch that can work in tandem with the above ZFS
changes to exclude the ZFS ARC file data pages from a dump file.

Signed-off-by: Don Brady <don.brady@delphix.com>
---
 makedumpfile.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index d76a435..b760934 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -85,6 +85,7 @@ mdf_pfn_t pfn_zero;
 mdf_pfn_t pfn_memhole;
 mdf_pfn_t pfn_cache;
 mdf_pfn_t pfn_cache_private;
+mdf_pfn_t pfn_zfs_arc_pages;
 mdf_pfn_t pfn_user;
 mdf_pfn_t pfn_free;
 mdf_pfn_t pfn_hwpoison;
@@ -282,6 +283,20 @@ is_cache_page(unsigned long flags)
 	return FALSE;
 }
 
+#define	ZFS_ABD_FILE_CACHE	0x2F5ABDF11ECAC4E
+
+static int
+is_zfs_cache_page(unsigned long flags, unsigned long private)
+{
+	/*
+	 * ZFS cached file data resides in pages with a private tag
+	 */
+	if (isPrivate(flags) && private == ZFS_ABD_FILE_CACHE)
+		return TRUE;
+
+	return FALSE;
+}
+
 static inline unsigned long
 calculate_len_buf_out(long page_size)
 {
@@ -6048,6 +6063,13 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 			else
 				pfn_counter = &pfn_cache;
 		}
+		/*
+		 * Exclude ZFS ARC pages
+		 */
+		else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
+		    && is_zfs_cache_page(flags, private)) {
+			pfn_counter = &pfn_zfs_arc_pages;
+		}
 		/*
 		 * Exclude the data page of the user process.
 		 *  - anonymous pages
@@ -7551,6 +7573,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	if (info->flag_cyclic) {
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
 		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_zfs_arc_pages = 0;
 		pfn_memhole = info->max_mapnr;
 	}
 
@@ -8833,6 +8856,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		 */
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
 		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_zfs_arc_pages = 0;
 		pfn_memhole = info->max_mapnr;
 
 		/*
@@ -9777,7 +9801,8 @@ print_report(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
-	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline
+	    + pfn_zfs_arc_pages;
 	shrinking = (pfn_original - pfn_excluded) * 100;
 	shrinking = shrinking / pfn_original;
 
@@ -9788,6 +9813,9 @@ print_report(void)
 	REPORT_MSG("    Non-private cache pages : 0x%016llx\n", pfn_cache);
 	REPORT_MSG("    Private cache pages     : 0x%016llx\n",
 	    pfn_cache_private);
+	if (pfn_zfs_arc_pages != 0)
+		REPORT_MSG("    ZFS ARC file data pages : 0x%016llx\n",
+		    pfn_zfs_arc_pages);
 	REPORT_MSG("    User process data pages : 0x%016llx\n", pfn_user);
 	REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free);
 	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
@@ -9819,7 +9847,8 @@ print_mem_usage(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
-	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline
+	    + pfn_zfs_arc_pages;
 	shrinking = (pfn_original - pfn_excluded) * 100;
 	shrinking = shrinking / pfn_original;
 	total_size = info->page_size * pfn_original;
@@ -9833,6 +9862,9 @@ print_mem_usage(void)
 	    pfn_cache);
 	MSG("PRI_CACHE	%-16llu	yes		Cache pages with private flag\n",
 	    pfn_cache_private);
+	if (pfn_zfs_arc_pages != 0)
+		MSG("ZFS_CACHE	%-16llu	yes		ZFS ARC data pages\n",
+		    pfn_zfs_arc_pages);
 	MSG("USER		%-16llu	yes		User process pages\n", pfn_user);
 	MSG("FREE		%-16llu	yes		Free pages\n", pfn_free);
 	MSG("KERN_DATA	%-16llu	no		Dumpable kernel data \n",
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wdu0O-0002ze-D7
 for kexec@lists.infradead.org; Sat, 26 Apr 2014 04:14:25 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 2/4] makedumpfile: cleanup non-standard ULONGLONG_MAX macros
Date: Sat, 26 Apr 2014 12:07:07 +0800
Message-ID: <1398485229-43295-3-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1398485229-43295-1-git-send-email-wangnan0@huawei.com>
References: <1398485229-43295-1-git-send-email-wangnan0@huawei.com>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: Wang Nan <wangnan0@huawei.com>, Liu Hua <sdu.liu@huawei.com>, Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

Macro ULONGLONG_MAX is non-standard, the standard way to defining
maximum limitation of unsigned long long is ULLONG_MAX, which is defined
in <limits.h> by C standard.

This patch replace all ULONGLONG_MAX to ULLONG_MAX.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec@lists.infradead.org
Cc: Geng Hui <hui.geng@huawei.com>
Cc: Liu Hua <sdu.liu@huawei.com>

---
 common.h       |  3 +--
 makedumpfile.c | 10 +++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/common.h b/common.h
index 124f107..b86c57a 100644
--- a/common.h
+++ b/common.h
@@ -38,7 +38,6 @@
 # warning ULLONG_MAX should have been defined in <limits.h>
 # define ULLONG_MAX (LLONG_MAX * 2ULL + 1ULL)
 #endif
-#define ULONGLONG_MAX	ULLONG_MAX
 
 #define MAX(a,b)	((a) > (b) ? (a) : (b))
 #define MIN(a,b)	((a) < (b) ? (a) : (b))
@@ -52,7 +51,7 @@
  */
 #define NOT_MEMMAP_ADDR	(0x0)
 #define NOT_KV_ADDR	(0x0)
-#define NOT_PADDR	(ULONGLONG_MAX)
+#define NOT_PADDR	(ULLONG_MAX)
 
 #endif  /* COMMON_H */
 
diff --git a/makedumpfile.c b/makedumpfile.c
index ce4a866..33c378d 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3797,7 +3797,7 @@ unsigned long long
 page_to_pfn(unsigned long page)
 {
 	unsigned int num;
-	unsigned long long pfn = ULONGLONG_MAX;
+	unsigned long long pfn = ULLONG_MAX;
 	unsigned long long index = 0;
 	struct mem_map_data *mmd;
 
@@ -3813,9 +3813,9 @@ page_to_pfn(unsigned long page)
 		pfn = mmd->pfn_start + index;
 		break;
 	}
-	if (pfn == ULONGLONG_MAX) {
+	if (pfn == ULLONG_MAX) {
 		ERRMSG("Can't convert the address of page descriptor (%lx) to pfn.\n", page);
-		return ULONGLONG_MAX;
+		return ULLONG_MAX;
 	}
 	return pfn;
 }
@@ -3852,7 +3852,7 @@ reset_bitmap_of_free_pages(unsigned long node_zones, struct cycle *cycle)
 			for (;curr != head;) {
 				curr_page = curr - OFFSET(page.lru);
 				start_pfn = page_to_pfn(curr_page);
-				if (start_pfn == ULONGLONG_MAX)
+				if (start_pfn == ULLONG_MAX)
 					return FALSE;
 
 				if (!readmem(VADDR, curr+OFFSET(list_head.prev),
@@ -4678,7 +4678,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 	/*
 	 * Refresh the buffer of struct page, when changing mem_map.
 	 */
-	pfn_read_start = ULONGLONG_MAX;
+	pfn_read_start = ULLONG_MAX;
 	pfn_read_end   = 0;
 
 	for (pfn = pfn_start; pfn < pfn_end; pfn++, mem_map += SIZE(page)) {
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

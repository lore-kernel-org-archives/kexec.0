From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Fri,  8 Apr 2022 10:49:11 +0200
Subject: [PATCH 1/1] check that order of free pages falls within valid range
Message-ID: <20220408084911.181481-1-egorenar@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

This change makes __exclude_unnecessary_pages() more robust by
verifying that the order of a free page is valid before computing the size
of its memory block in the buddy system.

The order of a free page cannot be larger than (MAX_ORDER - 1) because
the array 'zone.free_area' is of size MAX_ORDER.

This situation is reproducible with some s390x dumps:

__exclude_unnecessary_pages: Invalid free page order: pfn=2690c0, order=52, max order=8

References:
- https://listman.redhat.com/archives/crash-utility/2021-September/009204.html
- https://www.kernel.org/doc/gorman/html/understand/understand009.html

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 makedumpfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ca4b0f1cb58f..56aa026e7b34 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6457,9 +6457,11 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		else if ((info->dump_level & DL_EXCLUDE_FREE)
 		    && info->page_is_buddy
 		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
-			if (private > 11) {
-				ERRMSG("Invalid buddy page order: pfn=%llx, _mapcount=%x, _count=%x, private=%lx\n", pfn, _mapcount, _count, private);
-				abort();
+			if (private >= ARRAY_LENGTH(zone.free_area)) {
+				ERRMSG("Invalid free page order: pfn=%llx, order=%lu, max order=%lu\n",
+				       pfn, private, ARRAY_LENGTH(zone.free_area) - 1);
+				free(page_cache);
+				return FALSE;
 			}
 			nr_pages = 1 << private;
 			pfn_counter = &pfn_free;
-- 
2.34.1



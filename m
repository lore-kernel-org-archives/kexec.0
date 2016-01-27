Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aOKmk-0000Z4-FL
 for kexec@lists.infradead.org; Wed, 27 Jan 2016 07:45:03 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.160])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id u0R7ieMp002898
 for <kexec@lists.infradead.org>; Wed, 27 Jan 2016 16:44:40 +0900 (JST)
Received: from mailsv3.nec.co.jp (imss61.nec.co.jp [10.7.69.156]) by
 mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC) with ESMTP
 id u0R7ido01795 for <kexec@lists.infradead.org>;
 Wed, 27 Jan 2016 16:44:39 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id u0R7i5xd001262
 for <kexec@lists.infradead.org>; Wed, 27 Jan 2016 16:44:39 +0900 (JST)
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH] makedumpfile: Looking up page.compound_order/compound_dtor
 to exclude hugepages.
Date: Wed, 27 Jan 2016 07:39:08 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E19E40@BPXM01GP.gisp.nec.co.jp>
Content-Language: ja-JP
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

This is for hugepage filtering on linux 4.4 and later.
Without this patch, hugepages wouldn't be removed correctly. Not only that,
irrelevant pages can be excluded.
This patch requires the kernel side fix which I've posted:

  https://lkml.org/lkml/2016/1/27/92

Any comments are helpful.

Thanks,
Atsushi Kumagai

-----------------------------------------------------------------------------
Required for kernel 4.4

Due to some changes in struct page, hugepages wouldn't be removed on
linux 4.4. makedumpfile reads page.lru.prev to get "order" (number of hugepages)
and page.lru.next to get "dtor" (destructor for hugepages) to detect hugepages,
but the offsets of the two symbol was changed in linux 4.4.

     kernel    |            order            |            dtor
    version    |      member    |   offset   |    member     |   offset
 --------------+----------------+------------+---------------+-----------
       - v3.19 |   lru.prev     |    as is   |   lru.next    |   as is
  v4.0 - v4.3  | compound_order | ==lru.prev | compound_dtor | ==lru.next
  v4.4 -       | compound_order | !=lru.prev | compound_dtor | !=lru.next

As above, OFFSET(page.compound_order) and OFFSET(page.compound_dtor) are
definitely necessary in VMCOREINFO on linux 4.4 and later. At least linux 4.4
doesn't export OFFSET(page.compound_order) and OFFSET(page.compound_dtor),
we have to give up hugepage filtering unless vmlinux is prepared.

Further, the content of page.compound_dtor was changed from direct address
of dtor to the ID of it in linux 4.4.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 makedumpfile.h |  5 ++--
 2 files changed, 65 insertions(+), 16 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b802446..cd6c4de 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -240,6 +240,15 @@ is_in_same_page(unsigned long vaddr1, unsigned long vaddr2)
 	return FALSE;
 }
 
+static inline int
+isHugetlb(dtor)
+{
+        return ((NUMBER(HUGETLB_PAGE_DTOR) != NOT_FOUND_NUMBER)
+		&& (NUMBER(HUGETLB_PAGE_DTOR) == dtor))
+                || ((SYMBOL(free_huge_page) != NOT_FOUND_SYMBOL)
+                    && (SYMBOL(free_huge_page) == dtor));
+}
+
 static inline unsigned long
 calculate_len_buf_out(long page_size)
 {
@@ -1614,6 +1623,8 @@ get_structure_info(void)
 	OFFSET_INIT(page.mapping, "page", "mapping");
 	OFFSET_INIT(page._mapcount, "page", "_mapcount");
 	OFFSET_INIT(page.private, "page", "private");
+	OFFSET_INIT(page.compound_dtor, "page", "compound_dtor");
+	OFFSET_INIT(page.compound_order, "page", "compound_order");
 
 	/*
 	 * Some vmlinux(s) don't have debugging information about
@@ -1720,6 +1731,8 @@ get_structure_info(void)
 			NUMBER(PG_head_mask) = 1UL << NUMBER(PG_head);
 	}
 
+	ENUM_NUMBER_INIT(HUGETLB_PAGE_DTOR, "HUGETLB_PAGE_DTOR");
+
 	ENUM_TYPE_SIZE_INIT(pageflags, "pageflags");
 
 	TYPEDEF_SIZE_INIT(nodemask_t, "nodemask_t");
@@ -2164,6 +2177,8 @@ write_vmcoreinfo_data(void)
 	WRITE_MEMBER_OFFSET("page.lru", page.lru);
 	WRITE_MEMBER_OFFSET("page._mapcount", page._mapcount);
 	WRITE_MEMBER_OFFSET("page.private", page.private);
+	WRITE_MEMBER_OFFSET("page.compound_dtor", page.compound_dtor);
+	WRITE_MEMBER_OFFSET("page.compound_order", page.compound_order);
 	WRITE_MEMBER_OFFSET("mem_section.section_mem_map",
 	    mem_section.section_mem_map);
 	WRITE_MEMBER_OFFSET("pglist_data.node_zones", pglist_data.node_zones);
@@ -2233,6 +2248,8 @@ write_vmcoreinfo_data(void)
 	WRITE_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
 	WRITE_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
 
+	WRITE_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
+
 	/*
 	 * write the source file of 1st kernel
 	 */
@@ -2499,6 +2516,8 @@ read_vmcoreinfo(void)
 	READ_MEMBER_OFFSET("page.lru", page.lru);
 	READ_MEMBER_OFFSET("page._mapcount", page._mapcount);
 	READ_MEMBER_OFFSET("page.private", page.private);
+	READ_MEMBER_OFFSET("page.compound_dtor", page.compound_dtor);
+	READ_MEMBER_OFFSET("page.compound_order", page.compound_order);
 	READ_MEMBER_OFFSET("mem_section.section_mem_map",
 	    mem_section.section_mem_map);
 	READ_MEMBER_OFFSET("pglist_data.node_zones", pglist_data.node_zones);
@@ -2568,6 +2587,8 @@ read_vmcoreinfo(void)
 	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
 	READ_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
 
+	READ_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
+
 	return TRUE;
 }
 
@@ -5487,6 +5508,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 	unsigned char page_cache[SIZE(page) * PGMM_CACHED];
 	unsigned char *pcache;
 	unsigned int _count, _mapcount = 0, compound_order = 0;
+	unsigned int order_offset, dtor_offset;
 	unsigned long flags, mapping, private = 0;
 	unsigned long compound_dtor;
 
@@ -5555,26 +5577,52 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		_count  = UINT(pcache + OFFSET(page._count));
 		mapping = ULONG(pcache + OFFSET(page.mapping));
 
-		if ((index_pg < PGMM_CACHED - 1) &&
-		    isCompoundHead(flags)) {
-			compound_order = ULONG(pcache + SIZE(page) + OFFSET(page.lru)
-					       + OFFSET(list_head.prev));
-			compound_dtor = ULONG(pcache + SIZE(page) + OFFSET(page.lru)
-					     + OFFSET(list_head.next));
+		if (OFFSET(page.compound_order) != NOT_FOUND_SYMBOL) {
+			order_offset = OFFSET(page.compound_order);
+		} else {
+			if (info->kernel_version < KERNEL_VERSION(4, 4, 0))
+				order_offset = OFFSET(page.lru) + OFFSET(list_head.prev);
+			else
+				order_offset = 0;
+		}
+
+		if (OFFSET(page.compound_dtor) != NOT_FOUND_SYMBOL) {
+			dtor_offset = OFFSET(page.compound_dtor);
+		} else {
+			if (info->kernel_version < KERNEL_VERSION(4, 4, 0))
+				dtor_offset = OFFSET(page.lru) + OFFSET(list_head.next);
+			else
+				dtor_offset = 0;
+		}
+
+		compound_order = 0;
+		compound_dtor = 0;
+		/*
+		 * The last pfn of the mem_map cache must not be compound page
+		 * since all compound pages are aligned to its page order and
+		 * PGMM_CACHED is a power of 2.
+		 */
+		if ((index_pg < PGMM_CACHED - 1) && isCompoundHead(flags)) {
+			if (order_offset)
+				compound_order = USHORT(pcache + SIZE(page) + order_offset);
+
+			if (dtor_offset) {
+				/*
+				 * compound_dtor has been changed from the address of descriptor
+				 * to the ID of it since linux-4.4.
+				 */
+				if (info->kernel_version >= KERNEL_VERSION(4, 4, 0)) {
+					compound_dtor = USHORT(pcache + SIZE(page) + dtor_offset);
+				} else {
+					compound_dtor = ULONG(pcache + SIZE(page) + dtor_offset);
+				}
+			}
 
 			if ((compound_order >= sizeof(unsigned long) * 8)
 			    || ((pfn & ((1UL << compound_order) - 1)) != 0)) {
 				/* Invalid order */
 				compound_order = 0;
 			}
-		} else {
-			/*
-			 * The last pfn of the mem_map cache must not be compound page
-			 * since all compound pages are aligned to its page order and
-			 * PGMM_CACHED is a power of 2.
-			 */
-			compound_order = 0;
-			compound_dtor = 0;
 		}
 
 		if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
diff --git a/makedumpfile.h b/makedumpfile.h
index e626be8..2912ee6 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -153,8 +153,6 @@ test_bit(int nr, unsigned long addr)
 #define isLRU(flags)		test_bit(NUMBER(PG_lru), flags)
 #define isPrivate(flags)	test_bit(NUMBER(PG_private), flags)
 #define isCompoundHead(flags)   (!!((flags) & NUMBER(PG_head_mask)))
-#define isHugetlb(dtor)         ((SYMBOL(free_huge_page) != NOT_FOUND_SYMBOL) \
-				 && (SYMBOL(free_huge_page) == dtor))
 #define isSwapCache(flags)	test_bit(NUMBER(PG_swapcache), flags)
 #define isHWPOISON(flags)	(test_bit(NUMBER(PG_hwpoison), flags) \
 				&& (NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER))
@@ -1481,6 +1479,8 @@ struct offset_table {
 		long	lru;
 		long	_mapcount;
 		long	private;
+		long	compound_dtor;
+		long	compound_order;
 	} page;
 	struct mem_section {
 		long	section_mem_map;
@@ -1676,6 +1676,7 @@ struct number_table {
 	long	KERNEL_IMAGE_SIZE;
 	long	SECTION_SIZE_BITS;
 	long	MAX_PHYSMEM_BITS;
+	long    HUGETLB_PAGE_DTOR;
 };
 
 struct srcfile_table {
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

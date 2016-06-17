Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bDqHW-0004Mc-Oj
 for kexec@lists.infradead.org; Fri, 17 Jun 2016 09:41:43 +0000
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v2] makedumpfile: support _count -> _refcount rename in struct
 page
Date: Fri, 17 Jun 2016 11:41:19 +0200
Message-Id: <1466156479-9659-1-git-send-email-vkuznets@redhat.com>
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
Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Minoru Usui <min-usui@ti.jp.nec.com>, David Anderson <anderson@redhat.com>

_count member was renamed to _refcount in linux commit 0139aa7b7fa12
("mm: rename _count, field of the struct page, to _refcount") and this
broke makedumpfile. The reason for making the change was to find all users
accessing it directly and not through the recommended API. I tried
suggesting to revert the change but failed, I see no other choice than to
start supporting both _count and _refcount in makedumpfile.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since 'v1':
- Make '_refcount' the default [Atsushi Kumagai]
---
 makedumpfile.c | 26 +++++++++++++++++++++-----
 makedumpfile.h |  3 ++-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 853b999..fd884d3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1579,7 +1579,14 @@ get_structure_info(void)
 	 */
 	SIZE_INIT(page, "page");
 	OFFSET_INIT(page.flags, "page", "flags");
-	OFFSET_INIT(page._count, "page", "_count");
+	OFFSET_INIT(page._refcount, "page", "_refcount");
+	if (OFFSET(page._refcount) == NOT_FOUND_STRUCTURE) {
+		info->flag_use_count = TRUE;
+		OFFSET_INIT(page._refcount, "page", "_count");
+	} else {
+		info->flag_use_count = FALSE;
+	}
+
 	OFFSET_INIT(page.mapping, "page", "mapping");
 	OFFSET_INIT(page._mapcount, "page", "_mapcount");
 	OFFSET_INIT(page.private, "page", "private");
@@ -2044,7 +2051,7 @@ get_mem_type(void)
 
 	if ((SIZE(page) == NOT_FOUND_STRUCTURE)
 	    || (OFFSET(page.flags) == NOT_FOUND_STRUCTURE)
-	    || (OFFSET(page._count) == NOT_FOUND_STRUCTURE)
+	    || (OFFSET(page._refcount) == NOT_FOUND_STRUCTURE)
 	    || (OFFSET(page.mapping) == NOT_FOUND_STRUCTURE)) {
 		ret = NOT_FOUND_MEMTYPE;
 	} else if ((((SYMBOL(node_data) != NOT_FOUND_SYMBOL)
@@ -2151,7 +2158,10 @@ write_vmcoreinfo_data(void)
 	 * write the member offset of 1st kernel
 	 */
 	WRITE_MEMBER_OFFSET("page.flags", page.flags);
-	WRITE_MEMBER_OFFSET("page._count", page._count);
+	if (info->flag_use_count)
+		WRITE_MEMBER_OFFSET("page._count", page._refcount);
+	else
+		WRITE_MEMBER_OFFSET("page._refcount", page._refcount);
 	WRITE_MEMBER_OFFSET("page.mapping", page.mapping);
 	WRITE_MEMBER_OFFSET("page.lru", page.lru);
 	WRITE_MEMBER_OFFSET("page._mapcount", page._mapcount);
@@ -2491,7 +2501,13 @@ read_vmcoreinfo(void)
 
 
 	READ_MEMBER_OFFSET("page.flags", page.flags);
-	READ_MEMBER_OFFSET("page._count", page._count);
+	READ_MEMBER_OFFSET("page._refcount", page._refcount);
+	if (OFFSET(page._refcount) == NOT_FOUND_STRUCTURE) {
+		info->flag_use_count = TRUE;
+		READ_MEMBER_OFFSET("page._count", page._refcount);
+	} else {
+		info->flag_use_count = FALSE;
+	}
 	READ_MEMBER_OFFSET("page.mapping", page.mapping);
 	READ_MEMBER_OFFSET("page.lru", page.lru);
 	READ_MEMBER_OFFSET("page._mapcount", page._mapcount);
@@ -5615,7 +5631,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		pcache  = page_cache + (index_pg * SIZE(page));
 
 		flags   = ULONG(pcache + OFFSET(page.flags));
-		_count  = UINT(pcache + OFFSET(page._count));
+		_count  = UINT(pcache + OFFSET(page._refcount));
 		mapping = ULONG(pcache + OFFSET(page.mapping));
 
 		if (OFFSET(page.compound_order) != NOT_FOUND_STRUCTURE) {
diff --git a/makedumpfile.h b/makedumpfile.h
index 251d4bf..533e5b8 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1100,6 +1100,7 @@ struct DumpInfo {
 	int		flag_nospace;	     /* the flag of "No space on device" error */
 	int		flag_vmemmap;        /* kernel supports vmemmap address space */
 	int		flag_excludevm;      /* -e - excluding unused vmemmap pages */
+	int		flag_use_count;      /* _refcount is named _count in struct page */
 	unsigned long	vaddr_for_vtop;      /* virtual address for debugging */
 	long		page_size;           /* size of page */
 	long		page_shift;
@@ -1483,7 +1484,7 @@ struct size_table {
 struct offset_table {
 	struct page {
 		long	flags;
-		long	_count;
+		long	_refcount;
 		long	mapping;
 		long	lru;
 		long	_mapcount;
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

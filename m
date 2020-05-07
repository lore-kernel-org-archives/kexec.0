Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUdt-0007sb-Io
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:44:06 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 14/43] mm: memblock: PKRAM: prevent memblock resize from
 clobbering preserved pages
Date: Wed,  6 May 2020 17:41:40 -0700
Message-Id: <1588812129-8596-15-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
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
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-doc@vger.kernel.org, gustavo@embeddedor.com, peterz@infradead.org, kexec@lists.infradead.org, paul.c.lai@intel.com, dave.hansen@linux.intel.com, mhocko@kernel.org, lei.l.li@intel.com, nivedita@alum.mit.edu, ziqian.lzq@antfin.com, hpa@zytor.com, ardb@kernel.org, ashok.raj@intel.com, bhe@redhat.com, corbet@lwn.net, masahiroy@kernel.org, rafael.j.wysocki@intel.com, hughd@google.com, willy@infradead.org, rppt@linux.ibm.com, mingo@redhat.com, vdavydov.dev@gmail.com, ying.huang@intel.com, Thomas.Lendacky@amd.com, kevin.tian@intel.com, jroedel@suse.de, keescook@chromium.org, dan.j.williams@intel.com, bp@alien8.de, zhiyuan.lv@intel.com, luto@kernel.org, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, dima@golovin.in, yang.shi@linux.alibaba.com, ndesaulniers@google.com, zhenzhong.duan@oracle.com, guro@fb.com, minchan@kernel.org, ebiederm@xmission.com, jason.zeng@intel.com, hannes@cmpxchg.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, daniel.kiper@oracle.com

The size of the memblock reserved array may be increased while preserved
pages are being reserved. When this happens, preserved pages that have
not yet been reserved are at risk for being clobbered when space for a
larger array is allocated.
When called from memblock_double_array(), a wrapper around
memblock_find_in_range() walks the preserved pages pagetable to find
sufficiently sized ranges without preserved pages and passes them to
memblock_find_in_range().

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  3 +++
 mm/memblock.c         | 15 +++++++++++++--
 mm/pkram.c            | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index edc5d8bef9d3..409022e1472f 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -62,6 +62,9 @@ struct page *pkram_load_page(struct pkram_stream *ps, unsigned long *index,
 ssize_t pkram_write(struct pkram_stream *ps, const void *buf, size_t count);
 size_t pkram_read(struct pkram_stream *ps, void *buf, size_t count);
 
+phys_addr_t pkram_memblock_find_in_range(phys_addr_t start, phys_addr_t end,
+					 phys_addr_t size, phys_addr_t align);
+
 #ifdef CONFIG_PKRAM
 extern unsigned long pkram_reserved_pages;
 void pkram_reserve(void);
diff --git a/mm/memblock.c b/mm/memblock.c
index c79ba6f9920c..69ae883b8d21 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -16,6 +16,7 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/pkram.h>
 
 #include <asm/sections.h>
 #include <linux/io.h>
@@ -349,6 +350,16 @@ phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
 	return ret;
 }
 
+phys_addr_t __init_memblock __memblock_find_in_range(phys_addr_t start,
+					phys_addr_t end, phys_addr_t size,
+					phys_addr_t align)
+{
+	if (IS_ENABLED(CONFIG_PKRAM))
+		return pkram_memblock_find_in_range(start, end, size, align);
+	else
+		return memblock_find_in_range(start, end, size, align);
+}
+
 static void __init_memblock memblock_remove_region(struct memblock_type *type, unsigned long r)
 {
 	type->total_size -= type->regions[r].size;
@@ -447,11 +458,11 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
 		if (type != &memblock.reserved)
 			new_area_start = new_area_size = 0;
 
-		addr = memblock_find_in_range(new_area_start + new_area_size,
+		addr = __memblock_find_in_range(new_area_start + new_area_size,
 						memblock.current_limit,
 						new_alloc_size, PAGE_SIZE);
 		if (!addr && new_area_size)
-			addr = memblock_find_in_range(0,
+			addr = __memblock_find_in_range(0,
 				min(new_area_start, memblock.current_limit),
 				new_alloc_size, PAGE_SIZE);
 
diff --git a/mm/pkram.c b/mm/pkram.c
index dd3c89614010..e49c9bcd3854 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1238,3 +1238,54 @@ void pkram_free_pgt(void)
 	__free_pages_core(virt_to_page(pkram_pgd), 0);
 	pkram_pgd = NULL;
 }
+
+static int __init_memblock pkram_memblock_find_cb(struct pkram_pg_state *st, unsigned long base, unsigned long size)
+{
+	unsigned long end = base + size;
+	unsigned long addr;
+
+	if (size < st->min_size)
+		return 0;
+
+	addr =  memblock_find_in_range(base, end, st->min_size, PAGE_SIZE);
+	if (!addr)
+		return 0;
+
+	st->retval = addr;
+	return 1;
+}
+
+/*
+ * It may be necessary to allocate a larger reserved memblock array
+ * while populating it with ranges of preserved pages.  To avoid
+ * trampling preserved pages that have not yet been added to the
+ * memblock reserved list this function implements a wrapper around
+ * memblock_find_in_range() that restricts searches to subranges
+ * that do not contain preserved pages.
+ */
+phys_addr_t __init_memblock pkram_memblock_find_in_range(phys_addr_t start,
+					phys_addr_t end, phys_addr_t size,
+					phys_addr_t align)
+{
+	struct pkram_pg_state st = {
+		.range_cb = pkram_memblock_find_cb,
+		.min_addr = start,
+		.max_addr = end,
+		.min_size = PAGE_ALIGN(size),
+		.find_holes = true,
+	};
+
+	if (!pkram_reservation_in_progress)
+		return memblock_find_in_range(start, end, size, align);
+
+	if (!pkram_pgd) {
+		WARN_ONCE(1, "No preserved pages pagetable\n");
+		return memblock_find_in_range(start, end, size, align);
+	}
+
+	WARN_ONCE(memblock_bottom_up(), "PKRAM: bottom up memblock allocation not yet supported\n");
+
+	pkram_walk_pgt_rev(&st, pkram_pgd);
+
+	return st.retval;
+}
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

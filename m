Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lne5x-00BhB7-8R
 for kexec@lists.infradead.org; Mon, 31 May 2021 09:20:27 +0000
From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 4/6] mm: rename the global section array to mem_sections
Date: Mon, 31 May 2021 17:19:06 +0800
Message-Id: <20210531091908.1738465-5-aisheng.dong@nxp.com>
In-Reply-To: <20210531091908.1738465-1-aisheng.dong@nxp.com>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
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
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, dongas86@gmail.com, Dong Aisheng <aisheng.dong@nxp.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

In order to distinguish the struct mem_section for a better code
readability and align with kernel doc [1] name below, change the
global mem section name to 'mem_sections' from 'mem_section'.

[1] Documentation/vm/memory-model.rst
"The `mem_section` objects are arranged in a two-dimensional array
called `mem_sections`."

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v1->v2:
 * no changes
---
 include/linux/mmzone.h | 10 +++++-----
 kernel/crash_core.c    |  4 ++--
 mm/sparse.c            | 16 ++++++++--------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a6bfde85ddb0..0ed61f32d898 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1302,9 +1302,9 @@ struct mem_section {
 #define SECTION_ROOT_MASK	(SECTIONS_PER_ROOT - 1)
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
-extern struct mem_section **mem_section;
+extern struct mem_section **mem_sections;
 #else
-extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
+extern struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
 #endif
 
 static inline unsigned long *section_to_usemap(struct mem_section *ms)
@@ -1315,12 +1315,12 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
 static inline struct mem_section *__nr_to_section(unsigned long nr)
 {
 #ifdef CONFIG_SPARSEMEM_EXTREME
-	if (!mem_section)
+	if (!mem_sections)
 		return NULL;
 #endif
-	if (!mem_section[SECTION_NR_TO_ROOT(nr)])
+	if (!mem_sections[SECTION_NR_TO_ROOT(nr)])
 		return NULL;
-	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
+	return &mem_sections[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
 }
 extern unsigned long __section_nr(struct mem_section *ms);
 extern size_t mem_section_usage_size(void);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 29cc15398ee4..fb1180d81b5a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -414,8 +414,8 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
 #ifdef CONFIG_SPARSEMEM
-	VMCOREINFO_SYMBOL_ARRAY(mem_section);
-	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
+	VMCOREINFO_SYMBOL_ARRAY(mem_sections);
+	VMCOREINFO_LENGTH(mem_sections, NR_SECTION_ROOTS);
 	VMCOREINFO_STRUCT_SIZE(mem_section);
 	VMCOREINFO_OFFSET(mem_section, section_mem_map);
 	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
diff --git a/mm/sparse.c b/mm/sparse.c
index d02ee6bb7cbc..6412010478f7 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -24,12 +24,12 @@
  * 1) mem_section	- memory sections, mem_map's for valid memory
  */
 #ifdef CONFIG_SPARSEMEM_EXTREME
-struct mem_section **mem_section;
+struct mem_section **mem_sections;
 #else
-struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
+struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
 	____cacheline_internodealigned_in_smp;
 #endif
-EXPORT_SYMBOL(mem_section);
+EXPORT_SYMBOL(mem_sections);
 
 #ifdef NODE_NOT_IN_PAGE_FLAGS
 /*
@@ -66,8 +66,8 @@ static void __init sparse_alloc_section_roots(void)
 
 	size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
 	align = 1 << (INTERNODE_CACHE_SHIFT);
-	mem_section = memblock_alloc(size, align);
-	if (!mem_section)
+	mem_sections = memblock_alloc(size, align);
+	if (!mem_sections)
 		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
 		      __func__, size, align);
 }
@@ -103,14 +103,14 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
 	 *
 	 * The mem_hotplug_lock resolves the apparent race below.
 	 */
-	if (mem_section[root])
+	if (mem_sections[root])
 		return 0;
 
 	section = sparse_index_alloc(nid);
 	if (!section)
 		return -ENOMEM;
 
-	mem_section[root] = section;
+	mem_sections[root] = section;
 
 	return 0;
 }
@@ -145,7 +145,7 @@ unsigned long __section_nr(struct mem_section *ms)
 #else
 unsigned long __section_nr(struct mem_section *ms)
 {
-	return (unsigned long)(ms - mem_section[0]);
+	return (unsigned long)(ms - mem_sections[0]);
 }
 #endif
 
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

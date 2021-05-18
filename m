Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH v2 2/2] mm: replace contig_page_data with node_data
Date: Tue, 18 May 2021 17:24:46 +0800
Message-ID: <20210518092446.16382-3-miles.chen@mediatek.com>
In-Reply-To: <20210518092446.16382-1-miles.chen@mediatek.com>
References: <20210518092446.16382-1-miles.chen@mediatek.com>
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
To: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Miles Chen <miles.chen@mediatek.com>, Kazu <k-hagio-ab@nec.com>

Replace contig_page_data with node_data. Change the definition
of NODE_DATA(nid) from (&contig_page_data) to (node_data[0]).

Remove contig_page_data from the tree.

Cc: Mike Rapoport <rppt@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Kazu <k-hagio-ab@nec.com>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 13 -------------
 arch/powerpc/kexec/core.c                      |  5 -----
 include/linux/gfp.h                            |  3 ---
 include/linux/mmzone.h                         |  3 +--
 kernel/crash_core.c                            |  1 -
 mm/memblock.c                                  |  2 --
 6 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 3861a25faae1..74185245c580 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -81,14 +81,6 @@ into that mem_map array.
 
 Used to map an address to the corresponding struct page.
 
-contig_page_data
-----------------
-
-Makedumpfile gets the pglist_data structure from this symbol, which is
-used to describe the memory layout.
-
-User-space tools use this to exclude free pages when dumping memory.
-
 mem_section|(mem_section, NR_SECTION_ROOTS)|(mem_section, section_mem_map)
 --------------------------------------------------------------------------
 
@@ -531,11 +523,6 @@ node_data|(node_data, MAX_NUMNODES)
 
 See above.
 
-contig_page_data
-----------------
-
-See above.
-
 vmemmap_list
 ------------
 
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index 56da5eb2b923..41f31dfb540c 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -68,13 +68,8 @@ void machine_kexec_cleanup(struct kimage *image)
 void arch_crash_save_vmcoreinfo(void)
 {
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
 	VMCOREINFO_SYMBOL(node_data);
 	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
-#endif
-#ifndef CONFIG_NEED_MULTIPLE_NODES
-	VMCOREINFO_SYMBOL(contig_page_data);
-#endif
 #if defined(CONFIG_PPC64) && defined(CONFIG_SPARSEMEM_VMEMMAP)
 	VMCOREINFO_SYMBOL(vmemmap_list);
 	VMCOREINFO_SYMBOL(mmu_vmemmap_psize);
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 11da8af06704..ba8c511c402f 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -493,9 +493,6 @@ static inline int gfp_zonelist(gfp_t flags)
  * This zone list contains a maximum of MAX_NUMNODES*MAX_NR_ZONES zones.
  * There are two zonelists per node, one for all zones with memory and
  * one containing just zones from the node the zonelist belongs to.
- *
- * For the normal case of non-DISCONTIGMEM systems the NODE_DATA() gets
- * optimized to &contig_page_data at compile-time.
  */
 static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 557918dcc755..c0769292187c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1043,9 +1043,8 @@ extern char numa_zonelist_order[];
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 
-extern struct pglist_data contig_page_data;
-#define NODE_DATA(nid)		(&contig_page_data)
 extern struct pglist_data *node_data[];
+#define NODE_DATA(nid)		(node_data[0])
 #define NODE_MEM_MAP(nid)	mem_map
 
 #else /* CONFIG_NEED_MULTIPLE_NODES */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 825284baaf46..d1e324be67f9 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -457,7 +457,6 @@ static int __init crash_save_vmcoreinfo_init(void)
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 	VMCOREINFO_SYMBOL(mem_map);
-	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
 #ifdef CONFIG_SPARSEMEM
 	VMCOREINFO_SYMBOL_ARRAY(mem_section);
diff --git a/mm/memblock.c b/mm/memblock.c
index ebddb57ea62d..7cfc9a9d6243 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -93,8 +93,6 @@
  */
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-struct pglist_data __refdata contig_page_data;
-EXPORT_SYMBOL(contig_page_data);
 struct pglist_data *node_data[MAX_NUMNODES];
 #endif
 
-- 
2.18.0
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

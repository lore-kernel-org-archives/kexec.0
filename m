Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T4w23-000254-7Z
 for kexec@lists.infradead.org; Fri, 24 Aug 2012 15:42:48 +0000
Subject: [PATCHv3 7/9] Support Xen4 virtuall address space layout
From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 24 Aug 2012 17:42:43 +0200
MIME-Version: 1.0
Message-Id: <201208241742.43576.ptesarik@suse.cz>
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
Cc: Norbert Trapp <Norbert.Trapp@ts.fujitsu.com>

Starting with Xen-4.0.0, the virtual memory layout on x86_64 has changed.
To support both Xen3 and Xen4, some of the former constants have to be
converted to a variable.

Note the addition of XEN_VIRT_END - even though the location of Xen code
and data changed, its size stayed at 1G, so we can compute the end of this
portion from the start point with the same formula for both versions.

A side-by-side comparison of the virtual address space for Xen3 and Xen4:

      Range       |             Xen3             |             Xen4
------------------+------------------------------+-----------------------------
0xffff800000000000|[256G] Read-only machine-to-phys translation table
0xffff803fffffffff|       (GUEST ACCESSIBLE)
------------------+------------------------------------------------------------
0xffff804000000000|[256G] Reserved for future shared info with the guest OS
0xffff807fffffffff|       (GUEST ACCESSIBLE)
------------------+------------------------------+-----------------------------
0xffff808000000000|[512G] Reserved for future use|[512G] ioremap for PCI
0xffff80ffffffffff|                              | mmconfig space
------------------+------------------------------+-----------------------------
0xffff810000000000|[512G] Guest linear page table
0xffff817fffffffff|
------------------+------------------------------------------------------------
0xffff818000000000|[512G] Shadow linear page table
0xffff81ffffffffff|
------------------+------------------------------------------------------------
0xffff820000000000|[512G] Per-domain mappings (e.g., GDT, LDT)
0xffff827fffffffff|
------------------+------------------------------------------------------------
0xffff828000000000|[16G] Machine-to-phys
0xffff8283ffffffff| translation table
------------------+------------------------------------------------------------
0xffff828400000000|[16G] Page-frame information
0xffff8287ffffffff| array
------------------+------------------------------------------------------------
0xffff828800000000|[16G] ioremap()/fixmap area
0xffff828bffffffff|
------------------+------------------------------+-----------------------------
0xffff828c00000000|[1G] Compatibility            |
0xffff828c3fffffff| machine-to-phys translation  |
                  | table                        |
------------------+------------------------------+
0xffff828c40000000|[1G] High read-only compat    |
0xffff828c7fffffff| machine-to-phys translation  |[256G] Machine-to-phys
                  | table                        |translation table
------------------+------------------------------+
0xffff828c80000000|[1G] Xen text, static data,   |
0xffff828cbfffffff| bss                          |
------------------+------------------------------+
0xffff828cc0000000|                              |
0xffff82bfffffffff|                              |
------------------+                              
+-----------------------------
0xffff82c000000000|                              |[16G] ioremap()/fixmap area
0xffff82c3ffffffff|                              |
------------------+                              
+-----------------------------
0xffff82c400000000|                              |[1G] Compatibility
0xffff82c43fffffff|                              | machine-to-phys translation
                  |                              | table
------------------+                              
+-----------------------------
0xffff82c440000000|[461G] Reserved for future use|[1G] High read-only compat
0xffff82c47fffffff|                              | machine-to-phys translation
                  |                              | table
------------------+                              
+-----------------------------
0xffff82c480000000|                              |[1G] Xen text, static data,
0xffff82c4bfffffff|                              | bss
------------------+                              
+-----------------------------
0xffff82c4c0000000|                              |[197G] Reserved for future
0xffff82f5ffffffff|                              | use
------------------+                              
+-----------------------------
0xffff82f600000000|                              |[40G] Page-frame information
0xffff82ffffffffff|                              | array
------------------+------------------------------+-----------------------------
0xffff830000000000|[1T] 1:1 direct mapping of all|
0xffff83ffffffffff| physical memory              |[5T] 1:1 direct mapping of
------------------+------------------------------+ all physical memory
0xffff840000000000|[4T] Reserved for future use  |
0xffff87ffffffffff|                              |
------------------+------------------------------+-----------------------------

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 arch/x86_64.c  |    9 +++++++++
 makedumpfile.h |   17 ++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -962,6 +962,10 @@ struct DumpInfo {
 	unsigned long *p2m_mfn_frame_list;
 	int	num_domain;
 	struct domain_list *domain_list;
+#if defined(__x86_64__)
+	unsigned long xen_virt_start;
+	unsigned long directmap_virt_end;
+#endif
 
 	/*
 	 * for splitting
@@ -1331,6 +1335,7 @@ struct domain_list {
 #define HYPERVISOR_VIRT_END		(0xFFFFFFFFUL)
 #define DIRECTMAP_VIRT_START		(0xFF000000UL)
 #define DIRECTMAP_VIRT_END		(0xFFC00000UL)
+#define FRAMETABLE_VIRT_START		(0xF6800000UL)
 
 #define is_xen_vaddr(x) \
 	((x) >= HYPERVISOR_VIRT_START_PAE && (x) < HYPERVISOR_VIRT_END)
@@ -1356,15 +1361,21 @@ int get_xen_info_x86(void);
 #define HYPERVISOR_VIRT_START (0xffff800000000000)
 #define HYPERVISOR_VIRT_END   (0xffff880000000000)
 #define DIRECTMAP_VIRT_START  (0xffff830000000000)
-#define DIRECTMAP_VIRT_END    (0xffff840000000000)
-#define XEN_VIRT_START        (0xffff828c80000000)
+#define DIRECTMAP_VIRT_END_V3 (0xffff840000000000)
+#define DIRECTMAP_VIRT_END_V4 (0xffff880000000000)
+#define DIRECTMAP_VIRT_END    (info->directmap_virt_end)
+#define XEN_VIRT_START_V3     (0xffff828c80000000)
+#define XEN_VIRT_START_V4     (0xffff82c480000000)
+#define XEN_VIRT_START        (info->xen_virt_start)
+#define XEN_VIRT_END          (XEN_VIRT_START + (1UL << 30))
+#define FRAMETABLE_VIRT_START 0xffff82f600000000
 
 #define is_xen_vaddr(x) \
 	((x) >= HYPERVISOR_VIRT_START && (x) < HYPERVISOR_VIRT_END)
 #define is_direct(x) \
 	((x) >= DIRECTMAP_VIRT_START && (x) < DIRECTMAP_VIRT_END)
 #define is_xen_text(x) \
-	((x) >= XEN_VIRT_START && (x) < DIRECTMAP_VIRT_START)
+	((x) >= XEN_VIRT_START && (x) < XEN_VIRT_END)
 
 unsigned long long kvtop_xen_x86_64(unsigned long kvaddr);
 #define kvtop_xen(X)	kvtop_xen_x86_64(X)
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -370,6 +370,15 @@ int get_xen_basic_info_x86_64(void)
 		info->xen_phys_start = info->xen_crash_info.v2->xen_phys_start;
 	}
 
+	if (info->xen_crash_info.com &&
+	    info->xen_crash_info.com->xen_major_version >= 4) {
+		info->xen_virt_start = XEN_VIRT_START_V4;
+		info->directmap_virt_end = DIRECTMAP_VIRT_END_V4;
+	} else {
+		info->xen_virt_start = XEN_VIRT_START_V3;
+		info->directmap_virt_end = DIRECTMAP_VIRT_END_V3;
+	}
+
 	if (SYMBOL(pgd_l4) == NOT_FOUND_SYMBOL) {
 		ERRMSG("Can't get pml4.\n");
 		return FALSE;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

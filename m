Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Si669-00063q-98
 for kexec@lists.infradead.org; Fri, 22 Jun 2012 15:48:38 +0000
Received: from sanpedro.osd.mch.fsc.net (sanpedro.osd.mch.fsc.net
 [172.17.20.6])
 by sanpedro.mch.fsc.net (Postfix) with ESMTP id 3D9B8966E00
 for <kexec@lists.infradead.org>; Fri, 22 Jun 2012 17:48:26 +0200 (CEST)
From: Norbert Trapp <Norbert.Trapp@ts.fujitsu.com>
Subject: [PATCH 2/3] makedumpfile: Xen4: copy Xen4 memory distribution symbol
 values from xen header file
Date: Fri, 22 Jun 2012 17:48:26 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <201206221748.26124.Norbert.Trapp@ts.fujitsu.com>
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

copied Xen4 memmory values from xen config.h file to makedumpfile.h
and added _XEN3 to the old Xen3 symbols. kvtop_xen_x86_64 in arch/x86_64.c
distinguishes between Xen3 and Xen4.

Signed-off-by: Norbert Trapp <norbert.trapp@ts.fujitsu.com>
---
 arch/x86_64.c  |  121 +++++++++++++++++++++++++++++++++++++++++--------------
 makedumpfile.h |   76 +++++++++++++++++++++++++++++------
 2 files changed, 154 insertions(+), 43 deletions(-)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index 6d2f9cc..da61fd8 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -278,6 +278,54 @@ vaddr_to_paddr_x86_64(unsigned long vaddr)
 	return paddr;
 }
 
+int
+is_xen_vaddr(unsigned long kvaddr)
+{
+	int retval;
+
+	if (info->xen_major_version < 4) {
+		retval = (kvaddr >= HYPERVISOR_VIRT_START_XEN3 && kvaddr < HYPERVISOR_VIRT_END_XEN3);
+		return retval;
+	}
+	retval = (kvaddr >= HYPERVISOR_VIRT_START && kvaddr < HYPERVISOR_VIRT_END);
+	return retval;
+}
+
+int
+is_xen_text(unsigned long kvaddr, unsigned long long *entry)
+{
+	int retval;
+
+	if (info->xen_major_version < 4) {
+		retval = (kvaddr >= XEN_VIRT_START_XEN3 && kvaddr < DIRECTMAP_VIRT_START_XEN3);
+		if (retval)
+			*entry = (unsigned long)kvaddr - XEN_VIRT_START_XEN3 + info->xen_phys_start;
+		return retval;
+	}
+	retval = (kvaddr >= XEN_VIRT_START && kvaddr < XEN_VIRT_START + GB(1));
+	if (retval)
+		*entry = (unsigned long)kvaddr - XEN_VIRT_START + info->xen_phys_start;
+	return retval;
+}
+
+int
+is_direct(unsigned long kvaddr, unsigned long long *entry)
+{
+	int retval;
+
+	if (info->xen_major_version < 4) {
+		retval = (kvaddr >= DIRECTMAP_VIRT_START_XEN3 && kvaddr < DIRECTMAP_VIRT_END_XEN3);
+		if (retval)
+			*entry = (unsigned long)kvaddr - DIRECTMAP_VIRT_START_XEN3;
+		return retval;
+	}
+	retval = (kvaddr >= DIRECTMAP_VIRT_START && kvaddr < DIRECTMAP_VIRT_END);
+	if (retval)
+		*entry = (unsigned long)kvaddr - DIRECTMAP_VIRT_START;
+	return retval;
+}
+
+
 /*
  * for Xen extraction
  */
@@ -289,11 +337,11 @@ kvtop_xen_x86_64(unsigned long kvaddr)
 	if (!is_xen_vaddr(kvaddr))
 		return NOT_PADDR;
 
-	if (is_xen_text(kvaddr))
-		return (unsigned long)kvaddr - XEN_VIRT_START + info->xen_phys_start;
+	if (is_xen_text(kvaddr, &entry))
+		return entry;
 
-	if (is_direct(kvaddr))
-		return (unsigned long)kvaddr - DIRECTMAP_VIRT_START;
+	if (is_direct(kvaddr, &entry))
+		return entry;
 
 	if ((dirp = kvtop_xen_x86_64(SYMBOL(pgd_l4))) == NOT_PADDR)
 		return NOT_PADDR;
@@ -350,34 +398,45 @@ int get_xen_info_x86_64(void)
 	}
 
 	if (SYMBOL(frame_table) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of frame_table.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR_XEN, SYMBOL(frame_table), &frame_table_vaddr,
-	    sizeof(frame_table_vaddr))) {
-		ERRMSG("Can't get the value of frame_table.\n");
-		return FALSE;
-	}
-	info->frame_table_vaddr = frame_table_vaddr;
-
-	if (SYMBOL(xenheap_phys_end) == NOT_FOUND_SYMBOL) {
-		ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
-	    sizeof(xen_end))) {
-		ERRMSG("Can't get the value of xenheap_phys_end.\n");
-		return FALSE;
+		if (info->elf_machine != EM_X86_64) {
+			ERRMSG("Can't get the symbol of frame_table.\n");
+			return FALSE;
+		}
+		info->frame_table_vaddr = FRAMETABLE_VIRT_START;
+	} else {
+		if (!readmem(VADDR_XEN, SYMBOL(frame_table), &frame_table_vaddr,
+		    sizeof(frame_table_vaddr))) {
+			ERRMSG("Can't get the value of frame_table.\n");
+			return FALSE;
+		}
+		info->frame_table_vaddr = frame_table_vaddr;
 	}
-	info->xen_heap_start = 0;
-	info->xen_heap_end   = paddr_to_pfn(xen_end);
-
-	/*
-	 * pickled_id == domain addr for x86_64
-	 */
-	for (i = 0; i < info->num_domain; i++) {
-		info->domain_list[i].pickled_id =
-			info->domain_list[i].domain_addr;
+	if (info->xen_major_version < 4) {
+		if (SYMBOL(xenheap_phys_end) == NOT_FOUND_SYMBOL) {
+			ERRMSG("Can't get the symbol of xenheap_phys_end.\n");
+			return FALSE;
+		}
+		if (!readmem(VADDR_XEN, SYMBOL(xenheap_phys_end), &xen_end,
+		    sizeof(xen_end))) {
+			ERRMSG("Can't get the value of xenheap_phys_end.\n");
+			return FALSE;
+		}
+		info->xen_heap_start = 0;
+		info->xen_heap_end   = paddr_to_pfn(xen_end);
+
+		/*
+		 * pickled_id == domain addr for x86_64
+		 */
+		for (i = 0; i < info->num_domain; i++) {
+			info->domain_list[i].pickled_id =
+				info->domain_list[i].domain_addr;
+		}
+	} else {
+		for (i = 0; i < info->num_domain; i++) {
+			info->domain_list[i].pickled_id =
+				((unsigned long)info->domain_list[i].domain_addr -
+				DIRECTMAP_VIRT_START) >> PAGESHIFT();
+		}
 	}
 
 	return TRUE;
diff --git a/makedumpfile.h b/makedumpfile.h
index d8d7779..0d8cc15 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1308,18 +1308,70 @@ int get_xen_info_x86(void);
 #define MAX_X86_64_FRAMES	(info->page_size / sizeof(unsigned long))
 
 #define PAGE_OFFSET_XEN_DOM0  (0xffff880000000000) /* different from linux */
-#define HYPERVISOR_VIRT_START (0xffff800000000000)
-#define HYPERVISOR_VIRT_END   (0xffff880000000000)
-#define DIRECTMAP_VIRT_START  (0xffff830000000000)
-#define DIRECTMAP_VIRT_END    (0xffff840000000000)
-#define XEN_VIRT_START        (0xffff828c80000000)
-
-#define is_xen_vaddr(x) \
-	((x) >= HYPERVISOR_VIRT_START && (x) < HYPERVISOR_VIRT_END)
-#define is_direct(x) \
-	((x) >= DIRECTMAP_VIRT_START && (x) < DIRECTMAP_VIRT_END)
-#define is_xen_text(x) \
-	((x) >= XEN_VIRT_START && (x) < DIRECTMAP_VIRT_START)
+#define HYPERVISOR_VIRT_START_XEN3 (0xffff800000000000)
+#define HYPERVISOR_VIRT_END_XEN3   (0xffff880000000000)
+#define DIRECTMAP_VIRT_START_XEN3  (0xffff830000000000)
+#define DIRECTMAP_VIRT_END_XEN3    (0xffff840000000000)
+#define XEN_VIRT_START_XEN3        (0xffff828c80000000)
+
+/* copied from xen-4..../xen/include/asm-x86/config.h */
+
+#define L1_PAGETABLE_SHIFT      12
+#define PAGE_SHIFT              L1_PAGETABLE_SHIFT
+
+#define PML4_ENTRY_BITS 39
+#define PML4_ENTRY_BYTES (1UL << PML4_ENTRY_BITS)
+#define GB(_gb) (_gb ## UL << 30)
+
+#define PML4_ADDR(_slot)        \
+    ((((_slot ## UL) >> 8) * 0xffff000000000000UL) | \
+    (_slot ## UL << PML4_ENTRY_BITS))
+
+#define HYPERVISOR_VIRT_START   (PML4_ADDR(256))
+#define HYPERVISOR_VIRT_END     (HYPERVISOR_VIRT_START + PML4_ENTRY_BYTES*16)
+#define RO_MPT_VIRT_START       (PML4_ADDR(256))
+#define MPT_VIRT_SIZE           (PML4_ENTRY_BYTES / 2)
+#define RO_MPT_VIRT_END         (RO_MPT_VIRT_START + MPT_VIRT_SIZE)
+/* Slot 257: ioremap for PCI mmconfig space for 2048 segments (512GB)
+ *     - full 16-bit segment support needs 44 bits
+ *     - since PML4 slot has 39 bits, we limit segments to 2048 (11-bits)
+ */
+#define PCI_MCFG_VIRT_START     (PML4_ADDR(257))
+#define PCI_MCFG_VIRT_END       (PCI_MCFG_VIRT_START + PML4_ENTRY_BYTES)
+/* Slot 258: linear page table (guest table). */
+#define LINEAR_PT_VIRT_START    (PML4_ADDR(258))
+#define LINEAR_PT_VIRT_END      (LINEAR_PT_VIRT_START + PML4_ENTRY_BYTES)
+/* Slot 259: linear page table (shadow table). */
+#define SH_LINEAR_PT_VIRT_START (PML4_ADDR(259))
+#define SH_LINEAR_PT_VIRT_END   (SH_LINEAR_PT_VIRT_START + PML4_ENTRY_BYTES)
+/* Slot 260: per-domain mappings. */
+#define PERDOMAIN_VIRT_START    (PML4_ADDR(260))
+#define PERDOMAIN_VIRT_END      (PERDOMAIN_VIRT_START + (PERDOMAIN_MBYTES<<20))
+#define PERDOMAIN_MBYTES        (PML4_ENTRY_BYTES >> (20 + PAGETABLE_ORDER))
+/* Slot 261: machine-to-phys conversion table (256GB). */
+#define RDWR_MPT_VIRT_START     (PML4_ADDR(261))
+#define RDWR_MPT_VIRT_END       (RDWR_MPT_VIRT_START + MPT_VIRT_SIZE)
+/* Slot 261: ioremap()/fixmap area (16GB). */
+#define IOREMAP_VIRT_START      RDWR_MPT_VIRT_END
+#define IOREMAP_VIRT_END        (IOREMAP_VIRT_START + GB(16))
+/* Slot 261: compatibility machine-to-phys conversion table (1GB). */
+#define RDWR_COMPAT_MPT_VIRT_START IOREMAP_VIRT_END
+#define RDWR_COMPAT_MPT_VIRT_END (RDWR_COMPAT_MPT_VIRT_START + GB(1))
+/* Slot 261: high read-only compat machine-to-phys conversion table (1GB). */
+#define HIRO_COMPAT_MPT_VIRT_START RDWR_COMPAT_MPT_VIRT_END
+#define HIRO_COMPAT_MPT_VIRT_END (HIRO_COMPAT_MPT_VIRT_START + GB(1))
+/* Slot 261: xen text, static data and bss (1GB). */
+#define XEN_VIRT_START          (HIRO_COMPAT_MPT_VIRT_END)
+#define XEN_VIRT_END            (XEN_VIRT_START + GB(1))
+/* Slot 261: page-frame information array (40GB). */
+#define FRAMETABLE_VIRT_END     DIRECTMAP_VIRT_START
+#define FRAMETABLE_SIZE         ((DIRECTMAP_SIZE >> PAGE_SHIFT) * \
+                                 SIZE(page_info))
+#define FRAMETABLE_VIRT_START   (FRAMETABLE_VIRT_END - FRAMETABLE_SIZE)
+/* Slot 262-271: A direct 1:1 mapping of all of physical memory. */
+#define DIRECTMAP_VIRT_START    (PML4_ADDR(262))
+#define DIRECTMAP_SIZE          (PML4_ENTRY_BYTES*10)
+#define DIRECTMAP_VIRT_END      (DIRECTMAP_VIRT_START + DIRECTMAP_SIZE)
 
 unsigned long long kvtop_xen_x86_64(unsigned long kvaddr);
 #define kvtop_xen(X)	kvtop_xen_x86_64(X)
-- 
1.6.0.2

With kind regards

Norbert Trapp
PDG ES&S SWE OS 6

FUJITSU
Fujitsu Technology Solutions GmbH
Domagkstrasse 28, D-80807 Muenchen, Germany
E-mail: Norbert.Trapp@xxxxxxxxxxxxxx
Web: ts.fujitsu.com
Company details: ts.fujitsu.com/imprint
Please be advised that neither Fujitsu, its affiliates, its employees or agents accept liability for any errors,
omissions or damages caused by delays of receipt or by any virus infection in this message or its attachments,
or which may otherwise arise as a result of this e-mail transmission.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

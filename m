Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YYT9E-0000zu-UU
 for kexec@lists.infradead.org; Thu, 19 Mar 2015 05:37:37 +0000
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
Subject: [PATCH v9 02/10] iommu/vt-d: Items required for kdump
Date: Thu, 19 Mar 2015 13:36:20 +0800
Message-Id: <1426743388-26908-3-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
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
To: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com, joro@8bytes.org, vgoyal@redhat.com, dyoung@redhat.com
Cc: jerry.hoemann@hp.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, lisa.mitchell@hp.com, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, zhen-hual@hp.com, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com

Add context entry functions needed for kdump.

Bill Sumner:
    Original version;

Li, Zhenhua:
    Changed the name of new functions, make them consistent with current
    context get/set functions.
    Remove the structure dve which is not used in new version.

Signed-off-by: Bill Sumner <billsumnerlinux@gmail.com>
Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel-iommu.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 76674a1..577d5de 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -40,6 +40,7 @@
 #include <linux/pci-ats.h>
 #include <linux/memblock.h>
 #include <linux/dma-contiguous.h>
+#include <linux/crash_dump.h>
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -211,6 +212,12 @@ get_context_addr_from_root(struct root_entry *root)
 		NULL);
 }
 
+static inline unsigned long
+get_context_phys_from_root(struct root_entry *root)
+{
+	return  root_present(root) ? (root->val & VTD_PAGE_MASK) : 0;
+}
+
 /*
  * low 64 bits:
  * 0: present
@@ -231,6 +238,32 @@ static inline bool context_present(struct context_entry *context)
 {
 	return (context->lo & 1);
 }
+
+static inline int context_fault_enable(struct context_entry *c)
+{
+	return((c->lo >> 1) & 0x1);
+}
+
+static inline int context_translation_type(struct context_entry *c)
+{
+	return((c->lo >> 2) & 0x3);
+}
+
+static inline u64 context_address_root(struct context_entry *c)
+{
+	return((c->lo >> VTD_PAGE_SHIFT));
+}
+
+static inline int context_address_width(struct context_entry *c)
+{
+	return((c->hi >> 0) & 0x7);
+}
+
+static inline int context_domain_id(struct context_entry *c)
+{
+	return((c->hi >> 8) & 0xffff);
+}
+
 static inline void context_set_present(struct context_entry *context)
 {
 	context->lo |= 1;
@@ -316,6 +349,29 @@ static inline int first_pte_in_page(struct dma_pte *pte)
 	return !((unsigned long)pte & ~VTD_PAGE_MASK);
 }
 
+
+#ifdef CONFIG_CRASH_DUMP
+
+/*
+ * Fix Crashdump failure caused by leftover DMA through a hardware IOMMU
+ *
+ * Fixes the crashdump kernel to deal with an active iommu and legacy
+ * DMA from the (old) panicked kernel in a manner similar to how legacy
+ * DMA is handled when no hardware iommu was in use by the old kernel --
+ * allow the legacy DMA to continue into its current buffers.
+ *
+ * In the crashdump kernel, this code:
+ * 1. skips disabling the IOMMU's translating.
+ * 2. Do not re-enable IOMMU's translating.
+ * 3. In kdump kernel, use the old root entry table.
+ * 4. Allocate pages for new context entry, copy data from old context entries
+ *    in the old kernel to the new ones.
+ *
+ */
+
+
+#endif /* CONFIG_CRASH_DUMP */
+
 /*
  * This domain is a statically identity mapping domain.
  *	1. This domain creats a static 1:1 mapping to all usable memory.
-- 
2.0.0-rc0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

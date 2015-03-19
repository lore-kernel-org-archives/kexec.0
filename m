Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YYT9Z-00016S-Bu
 for kexec@lists.infradead.org; Thu, 19 Mar 2015 05:37:58 +0000
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
Subject: [PATCH v9 05/10] iommu/vt-d: Add functions to load and save old re
Date: Thu, 19 Mar 2015 13:36:23 +0800
Message-Id: <1426743388-26908-6-git-send-email-zhen-hual@hp.com>
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

Add functions to load root entry table from old kernel, and to save updated
root entry table.
Add two member in struct intel_iommu, to store the RTA in old kernel, and
the mapped virt address of it.

We use the old RTA in dump kernel, and when the iommu->root_entry is used as
a cache in kdump kernel, its phys address will not be save to RTA register,
but when its data is changed, we will save the new data to old root entry table.

Li, Zhen-hua:
    The functions and logics.

Takao Indoh:
    Add __iommu_flush_cache.

Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 drivers/iommu/intel-iommu.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  5 +++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 7f3484a..1cb9780 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -373,6 +373,9 @@ static struct context_entry *device_to_existing_context_entry(
 				struct intel_iommu *iommu,
 				u8 bus, u8 devfn);
 
+static void __iommu_load_old_root_entry(struct intel_iommu *iommu);
+
+static void __iommu_update_old_root_entry(struct intel_iommu *iommu, int index);
 
 /*
  * A structure used to store the address allocated by ioremap();
@@ -4924,4 +4927,53 @@ int __iommu_free_mapped_mem(void)
 	return 0;
 }
 
+/*
+ * Load the old root entry table to new root entry table.
+ */
+static void __iommu_load_old_root_entry(struct intel_iommu *iommu)
+{
+	if ((!iommu)
+		|| (!iommu->root_entry)
+		|| (!iommu->root_entry_old_virt)
+		|| (!iommu->root_entry_old_phys))
+		return;
+	memcpy(iommu->root_entry, iommu->root_entry_old_virt, PAGE_SIZE);
+
+	__iommu_flush_cache(iommu, iommu->root_entry, PAGE_SIZE);
+}
+
+/*
+ * When the data in new root entry table is changed, this function
+ * must be called to save the updated data to old root entry table.
+ */
+static void __iommu_update_old_root_entry(struct intel_iommu *iommu, int index)
+{
+	u8 start;
+	unsigned long size;
+	void __iomem *to;
+	void *from;
+
+	if ((!iommu)
+		|| (!iommu->root_entry)
+		|| (!iommu->root_entry_old_virt)
+		|| (!iommu->root_entry_old_phys))
+		return;
+
+	if (index < -1 || index >= ROOT_ENTRY_NR)
+		return;
+
+	if (index == -1) {
+		start = 0;
+		size = ROOT_ENTRY_NR * sizeof(struct root_entry);
+	} else {
+		start = index * sizeof(struct root_entry);
+		size = sizeof(struct root_entry);
+	}
+	to = iommu->root_entry_old_virt;
+	from = iommu->root_entry;
+	memcpy(to + start, from + start, size);
+
+	__iommu_flush_cache(iommu, to + start, size);
+}
+
 #endif /* CONFIG_CRASH_DUMP */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8ffa523..8e29b97 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -329,6 +329,11 @@ struct intel_iommu {
 	spinlock_t	lock; /* protect context, domain ids */
 	struct root_entry *root_entry; /* virtual address */
 
+#ifdef CONFIG_CRASH_DUMP
+	void __iomem *root_entry_old_virt; /* mapped from old root entry */
+	unsigned long root_entry_old_phys; /* root entry in old kernel */
+#endif
+
 	struct iommu_flush flush;
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
-- 
2.0.0-rc0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

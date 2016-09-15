Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bkYCh-0007Ja-H3
 for kexec@lists.infradead.org; Thu, 15 Sep 2016 15:03:56 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 1/8] iommu/amd: Detect pre enabled translation
Date: Thu, 15 Sep 2016 23:03:19 +0800
Message-Id: <1473951806-25511-2-git-send-email-bhe@redhat.com>
In-Reply-To: <1473951806-25511-1-git-send-email-bhe@redhat.com>
References: <1473951806-25511-1-git-send-email-bhe@redhat.com>
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
To: joro@8bytes.org
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, Vincent.Wan@amd.com, iommu@lists.linux-foundation.org, dyoung@redhat.com

Add functions to check whether translation is already enabled in IOMMU.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu_init.c  | 25 +++++++++++++++++++++++++
 drivers/iommu/amd_iommu_proto.h |  1 +
 drivers/iommu/amd_iommu_types.h |  4 ++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 59741ea..9bf1a04 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -247,6 +247,26 @@ static int amd_iommu_enable_interrupts(void);
 static int __init iommu_go_to_state(enum iommu_init_state state);
 static void init_device_table_dma(void);
 
+
+bool translation_pre_enabled(struct amd_iommu *iommu)
+{
+	return (iommu->flags & AMD_IOMMU_FLAG_TRANS_PRE_ENABLED);
+}
+
+static void clear_translation_pre_enabled(struct amd_iommu *iommu)
+{
+        iommu->flags &= ~AMD_IOMMU_FLAG_TRANS_PRE_ENABLED;
+}
+
+static void init_translation_status(struct amd_iommu *iommu)
+{
+	u32 ctrl;
+
+	ctrl = readl(iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	if (ctrl & (1<<CONTROL_IOMMU_EN))
+		iommu->flags |= AMD_IOMMU_FLAG_TRANS_PRE_ENABLED;
+}
+
 static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
 				    u8 bank, u8 cntr, u8 fxn,
 				    u64 *value, bool is_write);
@@ -1283,6 +1303,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 
 	iommu->int_enabled = false;
 
+	init_translation_status(iommu);
+
+	if (translation_pre_enabled(iommu))
+		pr_warn("Translation is already enabled - trying to copy translation structures\n");
+
 	ret = init_iommu_from_acpi(iommu, h);
 	if (ret)
 		return ret;
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 0bd9eb3..f066e01 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -98,4 +98,5 @@ static inline bool iommu_feature(struct amd_iommu *iommu, u64 f)
 	return !!(iommu->features & f);
 }
 
+extern bool translation_pre_enabled(struct amd_iommu *iommu);
 #endif /* _ASM_X86_AMD_IOMMU_PROTO_H  */
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index caf5e38..7781953 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -384,6 +384,7 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 #define APERTURE_PAGE_INDEX(a)	(((a) >> 21) & 0x3fULL)
 
 
+
 /*
  * This struct is used to pass information about
  * incoming PPR faults around.
@@ -401,6 +402,8 @@ struct amd_iommu_fault {
 struct iommu_domain;
 struct irq_domain;
 
+#define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -524,6 +527,7 @@ struct amd_iommu {
 	struct irq_domain *ir_domain;
 	struct irq_domain *msi_domain;
 #endif
+	u32 flags;
 };
 
 #define ACPIHID_UID_LEN 256
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

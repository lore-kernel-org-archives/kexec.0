Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bxBfe-00015n-P0
 for kexec@lists.infradead.org; Thu, 20 Oct 2016 11:38:03 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 5/9] iommu/amd: copy old trans table from old kernel
Date: Thu, 20 Oct 2016 19:37:16 +0800
Message-Id: <1476963440-23039-6-git-send-email-bhe@redhat.com>
In-Reply-To: <1476963440-23039-1-git-send-email-bhe@redhat.com>
References: <1476963440-23039-1-git-send-email-bhe@redhat.com>
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

Here several things need be done:
- If iommu is pre-enabled in a normal kernel, just disable it and print
  warning.

- If failed to copy dev table of old kernel, continue to proceed as
  it does in normal kernel.

- Disable and Re-enable event/cmd buffer,  and install the copied DTE table
  to reg.

- Flush all caches

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu_init.c | 51 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index d4200e8..bc214fa 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -36,6 +36,7 @@
 #include <asm/io_apic.h>
 #include <asm/irq_remapping.h>
 
+#include <linux/crash_dump.h>
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
 #include "irq_remapping.h"
@@ -1481,9 +1482,12 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	iommu->int_enabled = false;
 
 	init_translation_status(iommu);
-
-	if (translation_pre_enabled(iommu))
-		pr_warn("Translation is already enabled - trying to copy translation structures\n");
+	if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
+		iommu_disable(iommu);
+		clear_translation_pre_enabled(iommu);
+		pr_warn("Translation was enabled for IOMMU:%d but we are not in kdump mode\n",
+			iommu->index);
+	}
 
 	ret = init_iommu_from_acpi(iommu, h);
 	if (ret)
@@ -1975,8 +1979,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 }
 
 /*
- * Init the device table to not allow DMA access for devices and
- * suppress all page faults
+ * Init the device table to not allow DMA access for devices
  */
 static void init_device_table_dma(void)
 {
@@ -2117,9 +2120,43 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 static void early_enable_iommus(void)
 {
 	struct amd_iommu *iommu;
+	bool is_pre_enabled = false;
 
-	for_each_iommu(iommu)
-		early_enable_iommu(iommu);
+	for_each_iommu(iommu) {
+		if (translation_pre_enabled(iommu)) {
+			is_pre_enabled = true;
+			break;
+		}
+	}
+
+	if (!is_pre_enabled) {
+		for_each_iommu(iommu)
+			early_enable_iommu(iommu);
+	} else {
+		pr_warn("Translation is already enabled - trying to copy translation structures\n");
+		if (copy_dev_tables()) {
+			pr_err("Failed to copy DEV table from previous kernel.\n");
+			/*
+			 * If failed to copy dev tables from old kernel, continue to proceed
+			 * as it does in normal kernel.
+			 */
+			for_each_iommu(iommu) {
+				clear_translation_pre_enabled(iommu);
+				early_enable_iommu(iommu);
+			}
+		} else {
+			pr_info("Copied DEV table from previous kernel.\n");
+			for_each_iommu(iommu) {
+				iommu_disable_command_buffer(iommu);
+				iommu_disable_event_buffer(iommu);
+				iommu_enable_command_buffer(iommu);
+				iommu_enable_event_buffer(iommu);
+				iommu_enable_ga(iommu);
+				iommu_set_device_table(iommu);
+				iommu_flush_all_caches(iommu);
+			}
+		}
+	}
 
 #ifdef CONFIG_IRQ_REMAP
 	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zf0An-00015D-7b
 for kexec@lists.infradead.org; Thu, 24 Sep 2015 06:38:29 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 07/10] iommu/amd: copy old dev tables and do not touch dev
 tables
Date: Thu, 24 Sep 2015 14:37:33 +0800
Message-Id: <1443076656-31776-8-git-send-email-bhe@redhat.com>
In-Reply-To: <1443076656-31776-1-git-send-email-bhe@redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
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
To: joro@8bytes.org, iommu@lists.linux-foundation.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>

Before old dev tables coping do not touch dev tables if translation is previously
enabled. And copy the dev tables/command buffer/event buffer from the old kernel
to newly allocated data structure.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu_init.c | 65 ++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index a334d14..4a68c5f 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -795,22 +795,24 @@ static void __init set_iommu_for_device(struct amd_iommu *iommu, u16 devid)
 static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 					   u16 devid, u32 flags, u32 ext_flags)
 {
-	if (flags & ACPI_DEVFLAG_INITPASS)
-		set_dev_entry_bit(devid, DEV_ENTRY_INIT_PASS);
-	if (flags & ACPI_DEVFLAG_EXTINT)
-		set_dev_entry_bit(devid, DEV_ENTRY_EINT_PASS);
-	if (flags & ACPI_DEVFLAG_NMI)
-		set_dev_entry_bit(devid, DEV_ENTRY_NMI_PASS);
-	if (flags & ACPI_DEVFLAG_SYSMGT1)
-		set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT1);
-	if (flags & ACPI_DEVFLAG_SYSMGT2)
-		set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT2);
-	if (flags & ACPI_DEVFLAG_LINT0)
-		set_dev_entry_bit(devid, DEV_ENTRY_LINT0_PASS);
-	if (flags & ACPI_DEVFLAG_LINT1)
-		set_dev_entry_bit(devid, DEV_ENTRY_LINT1_PASS);
-
-	amd_iommu_apply_erratum_63(devid);
+	if ( !translation_pre_enabled()) {
+		if (flags & ACPI_DEVFLAG_INITPASS)
+			set_dev_entry_bit(devid, DEV_ENTRY_INIT_PASS);
+		if (flags & ACPI_DEVFLAG_EXTINT)
+			set_dev_entry_bit(devid, DEV_ENTRY_EINT_PASS);
+		if (flags & ACPI_DEVFLAG_NMI)
+			set_dev_entry_bit(devid, DEV_ENTRY_NMI_PASS);
+		if (flags & ACPI_DEVFLAG_SYSMGT1)
+			set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT1);
+		if (flags & ACPI_DEVFLAG_SYSMGT2)
+			set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT2);
+		if (flags & ACPI_DEVFLAG_LINT0)
+			set_dev_entry_bit(devid, DEV_ENTRY_LINT0_PASS);
+		if (flags & ACPI_DEVFLAG_LINT1)
+			set_dev_entry_bit(devid, DEV_ENTRY_LINT1_PASS);
+
+		amd_iommu_apply_erratum_63(devid);
+	}
 
 	set_iommu_for_device(iommu, devid);
 }
@@ -894,7 +896,8 @@ static void __init set_device_exclusion_range(u16 devid, struct ivmd_header *m)
 		 * per device. But we can enable the exclusion range per
 		 * device. This is done here
 		 */
-		set_dev_entry_bit(devid, DEV_ENTRY_EX);
+		if (!translation_pre_enabled())
+			set_dev_entry_bit(devid, DEV_ENTRY_EX);
 		iommu->exclusion_start = m->range_start;
 		iommu->exclusion_length = m->range_length;
 	}
@@ -1493,7 +1496,8 @@ static int __init amd_iommu_init_pci(void)
 			break;
 	}
 
-	init_device_table_dma();
+	if (!translation_pre_enabled())
+		init_device_table_dma();
 
 	for_each_iommu(iommu)
 		iommu_flush_all_caches(iommu);
@@ -1786,14 +1790,20 @@ static void early_enable_iommus(void)
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu) {
-		iommu_disable(iommu);
-		iommu_init_flags(iommu);
-		iommu_set_device_table(iommu);
-		iommu_enable_command_buffer(iommu);
-		iommu_enable_event_buffer(iommu);
-		iommu_set_exclusion_range(iommu);
-		iommu_enable(iommu);
-		iommu_flush_all_caches(iommu);
+		 if ( !translation_pre_enabled() ) {
+			iommu_disable(iommu);
+			iommu_init_flags(iommu);
+			iommu_set_device_table(iommu);
+			iommu_enable_command_buffer(iommu);
+			iommu_enable_event_buffer(iommu);
+			iommu_set_exclusion_range(iommu);
+			iommu_enable(iommu);
+			iommu_flush_all_caches(iommu);
+		} else {
+			copy_dev_tables();
+			copy_command_buffer();
+			copy_event_buffer();
+		}
 	}
 }
 
@@ -2080,7 +2090,8 @@ static int __init early_amd_iommu_init(void)
 		goto out;
 
 	/* init the device table */
-	init_device_table();
+	if (!translation_pre_enabled())
+		init_device_table();
 
 out:
 	/* Don't leak any ACPI memory */
-- 
2.4.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

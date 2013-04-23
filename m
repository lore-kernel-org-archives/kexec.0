Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UUYhL-0002bj-Bj
 for kexec@lists.infradead.org; Tue, 23 Apr 2013 08:35:36 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B0C693EE0BC
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 17:35:25 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id A022445DEB5
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 17:35:25 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7C60A45DEBC
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 17:35:25 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 57778E08019
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 17:35:25 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 01E64E08001
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 17:35:25 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: [PATCH v2] intel-iommu: Disable translation if already enabled
Date: Tue, 23 Apr 2013 17:35:03 +0900
Message-Id: <1366706103-2640-1-git-send-email-indou.takao@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, dwmw2@infradead.org, joro@8bytes.org
Cc: wei@aristanetworks.com, kexec@lists.infradead.org

This patch disables translation(dma-remapping) before its initialization
if it is already enabled.

This is needed for kexec/kdump boot. If dma-remapping is enabled in the
first kernel, it need to be disabled before initializing its page table
during second kernel boot. Wei Hu also reported that this is needed
when second kernel boots with intel_iommu=off.

Basically iommu->gcmd is used to know whether translation is enabled or
disabled, but it is always zero at boot time even when translation is
enabled since iommu->gcmd is initialized without considering such a
case. Therefor this patch synchronizes iommu->gcmd value with global
command register when iommu structure is allocated.

Changelog:
v2:
- Change subject and patch description
- Disable translation after dmar_table_init() so that it works when
  intel_iommu=off is specified.

v1:
https://lkml.org/lkml/2013/3/20/707

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 drivers/iommu/dmar.c        |   11 ++++++++++-
 drivers/iommu/intel-iommu.c |   15 +++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index e5cdaf8..9f69352 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -645,7 +645,7 @@ out:
 int alloc_iommu(struct dmar_drhd_unit *drhd)
 {
 	struct intel_iommu *iommu;
-	u32 ver;
+	u32 ver, sts;
 	static int iommu_allocated = 0;
 	int agaw = 0;
 	int msagaw = 0;
@@ -695,6 +695,15 @@ int alloc_iommu(struct dmar_drhd_unit *drhd)
 		(unsigned long long)iommu->cap,
 		(unsigned long long)iommu->ecap);
 
+	/* Reflect status in gcmd */
+	sts = readl(iommu->reg + DMAR_GSTS_REG);
+	if (sts & DMA_GSTS_IRES)
+		iommu->gcmd |= DMA_GCMD_IRE;
+	if (sts & DMA_GSTS_TES)
+		iommu->gcmd |= DMA_GCMD_TE;
+	if (sts & DMA_GSTS_QIES)
+		iommu->gcmd |= DMA_GCMD_QIE;
+
 	raw_spin_lock_init(&iommu->register_lock);
 
 	drhd->iommu = iommu;
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0099667..414d2d2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3665,6 +3665,7 @@ static struct notifier_block device_nb = {
 int __init intel_iommu_init(void)
 {
 	int ret = 0;
+	struct dmar_drhd_unit *drhd;
 
 	/* VT-d is required for a TXT/tboot launch, so enforce that */
 	force_on = tboot_force_iommu();
@@ -3675,6 +3676,20 @@ int __init intel_iommu_init(void)
 		return 	-ENODEV;
 	}
 
+	/*
+	 * Disable translation if already enabled prior to OS handover.
+	 */
+	for_each_drhd_unit(drhd) {
+		struct intel_iommu *iommu;
+
+		if (drhd->ignored)
+			continue;
+
+		iommu = drhd->iommu;
+		if (iommu->gcmd & DMA_GCMD_TE)
+			iommu_disable_translation(iommu);
+	}
+
 	if (dmar_dev_scope_init() < 0) {
 		if (force_on)
 			panic("tboot: Failed to initialize DMAR device scope\n");
-- 
1.7.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

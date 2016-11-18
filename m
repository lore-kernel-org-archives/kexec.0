Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c7lwW-0001aS-MB
 for kexec@lists.infradead.org; Fri, 18 Nov 2016 16:23:18 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH v2] iommu/vt-d: Flush old iommu caches for kdump when the
 device gets context mapped
Date: Sat, 19 Nov 2016 00:23:45 +0800
Message-Id: <1479486225-9286-1-git-send-email-xlpang@redhat.com>
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
To: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: Don Brace <don.brace@microsemi.com>, Baoquan He <bhe@redhat.com>, Joseph Szczypek <jszczype@redhat.com>, kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, Xunlei Pang <xlpang@redhat.com>, linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@redhat.com>

We met the DMAR fault both on hpsa P420i and P421 SmartArray controllers
under kdump, it can be steadily reproduced on several different machines,
the dmesg log is like(running on 4.9.0-rc5+):
HP HPSA Driver (v 3.4.16-0)
hpsa 0000:02:00.0: using doorbell to reset controller
hpsa 0000:02:00.0: board ready after hard reset.
hpsa 0000:02:00.0: Waiting for controller to respond to no-op
DMAR: Setting identity map for device 0000:02:00.0 [0xe8000 - 0xe8fff]
DMAR: Setting identity map for device 0000:02:00.0 [0xf4000 - 0xf4fff]
DMAR: Setting identity map for device 0000:02:00.0 [0xbdf6e000 - 0xbdf6efff]
DMAR: Setting identity map for device 0000:02:00.0 [0xbdf6f000 - 0xbdf7efff]
DMAR: Setting identity map for device 0000:02:00.0 [0xbdf7f000 - 0xbdf82fff]
DMAR: Setting identity map for device 0000:02:00.0 [0xbdf83000 - 0xbdf84fff]
DMAR: DRHD: handling fault status reg 2
DMAR: [DMA Read] Request device [02:00.0] fault addr fffff000 [fault reason 06] PTE Read access is not set
hpsa 0000:02:00.0: controller message 03:00 timed out
hpsa 0000:02:00.0: no-op failed; re-trying

After some debugging, we found that the fault addr is from DMA initiated at
the driver probe stage after reset(not in-flight DMA), and the corresponding
pte entry value is correct, the fault is likely due to the old iommu caches
of the in-flight DMA before it.

Thus we need to flush the old cache after context mapping is setup for the
device, where the device is supposed to finish reset at its driver probe
stage and no in-flight DMA exists hereafter.

I'm not sure if the hardware is responsible for invalidating all the related
caches allocated in iommu hardware during reset, but seems not the case for hpsa,
actually many device drivers even have problems properly resetting the hardware.
Anyway flushing (again) by software in kdump mode when the device gets context
mapped which is a quite infrequent operation does little harm.

With this patch, the problematic machine can survive the kdump tests.

CC: Myron Stowe <myron.stowe@redhat.com>
CC: Joseph Szczypek <jszczype@redhat.com>
CC: Don Brace <don.brace@microsemi.com>
CC: Baoquan He <bhe@redhat.com>
CC: Dave Young <dyoung@redhat.com>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
v1 -> v2:
Flush caches using old domain id.

 drivers/iommu/intel-iommu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3965e73..653304d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2024,6 +2024,28 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	if (context_present(context))
 		goto out_unlock;
 
+	/*
+	 * For kdump cases, old valid entries may be cached due to the
+	 * in-flight DMA and copied pgtable, but there is no unmapping
+	 * behaviour for them, thus we need an explicit cache flush for
+	 * the newly-mapped device. For kdump, at this point, the device
+	 * is supposed to finish reset at its driver probe stage, so no
+	 * in-flight DMA will exist, and we don't need to worry anymore
+	 * hereafter.
+	 */
+	if (context_copied(context)) {
+		u16 did_old = context_domain_id(context);
+
+		if (did_old >= 0 && did_old < cap_ndoms(iommu->cap)) {
+			iommu->flush.flush_context(iommu, did_old,
+						   (((u16)bus) << 8) | devfn,
+						   DMA_CCMD_MASK_NOBIT,
+						   DMA_CCMD_DEVICE_INVL);
+			iommu->flush.flush_iotlb(iommu, did_old, 0, 0,
+						   DMA_TLB_DSI_FLUSH);
+		}
+	}
+
 	pgd = domain->pgd;
 
 	context_clear_entry(context);
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

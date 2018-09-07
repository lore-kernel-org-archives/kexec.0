Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fyByg-000561-2t
 for kexec@lists.infradead.org; Fri, 07 Sep 2018 08:19:12 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 3/4 v7] amd_iommu: remap the device table of IOMMU with the
 memory encryption mask for kdump
Date: Fri,  7 Sep 2018 16:18:04 +0800
Message-Id: <20180907081805.368-4-lijiang@redhat.com>
In-Reply-To: <20180907081805.368-1-lijiang@redhat.com>
References: <20180907081805.368-1-lijiang@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com, bhe@redhat.com, joro@8bytes.org, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com

In kdump kernel, it will copy the device table of IOMMU from the old device
table, which is encrypted when SME is enabled in the first kernel. So we
have to remap the old device table with the memory encryption mask.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 drivers/iommu/amd_iommu_init.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 84b3e4445d46..3931c7de7c69 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -902,12 +902,22 @@ static bool copy_device_table(void)
 		}
 	}
 
-	old_devtb_phys = entry & PAGE_MASK;
+	/*
+	 * When SME is enabled in the first kernel, the entry includes the
+	 * memory encryption mask(sme_me_mask), we must remove the memory
+	 * encryption mask to obtain the true physical address in kdump kernel.
+	 */
+	old_devtb_phys = __sme_clr(entry) & PAGE_MASK;
+
 	if (old_devtb_phys >= 0x100000000ULL) {
 		pr_err("The address of old device table is above 4G, not trustworthy!\n");
 		return false;
 	}
-	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+	old_devtb = (sme_active() && is_kdump_kernel())
+		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
+							dev_table_size)
+		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+
 	if (!old_devtb)
 		return false;
 
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5Qc5-0000Dg-3r
 for kexec@lists.infradead.org; Thu, 27 Sep 2018 07:21:31 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH v7 RESEND 3/4] iommu/amd: Remap the device table of IOMMU with
 the memory encryption mask for kdump
Date: Thu, 27 Sep 2018 15:19:53 +0800
Message-Id: <20180927071954.29615-4-lijiang@redhat.com>
In-Reply-To: <20180927071954.29615-1-lijiang@redhat.com>
References: <20180927071954.29615-1-lijiang@redhat.com>
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
Cc: thomas.lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, bp@suse.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

In kdump kernel, it will copy the device table of IOMMU from the old device
table, which is encrypted when SME is enabled in the first kernel. So we
have to remap the old device table with the memory encryption mask.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Joerg Roedel <jroedel@suse.de>
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

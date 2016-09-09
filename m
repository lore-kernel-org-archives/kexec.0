Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1biGuN-0002ph-46
 for kexec@lists.infradead.org; Fri, 09 Sep 2016 08:11:35 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] bnx2: Reset device during driver initialization
Date: Fri,  9 Sep 2016 16:11:07 +0800
Message-Id: <1473408667-7107-1-git-send-email-bhe@redhat.com>
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
To: netdev@vger.kernel.org
Cc: Dept-HSGLinuxNICDev@qlogic.com, sony.chacko@qlogic.com, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org

When system enters into kdump kernel because of kernel panic, it won't
shutdown devices. On-flight DMA will continue transferring data until
device driver initializes. All devices are supposed to reset during
driver initialization. And this property is used to fix the kdump
failure in system with intel iommu. Other systems with hardware iommu
should be similar. Please check commit 091d42e ("iommu/vt-d: Copy
translation tables from old kernel") and those commits around it.

But bnx2 driver doesn't reset device during driver initialization. The
device resetting is deferred to net device up stage. This will cause
hardware iommu handling failure on bnx2 device. And its resetting relies
on firmware. So in this patch move the firmware requesting code to earlier
bnx2_init_one(), then next call bnx2_reset_chip to reset device.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/net/ethernet/broadcom/bnx2.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index 8fc3f3c..d68a487 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -6356,10 +6356,6 @@ bnx2_open(struct net_device *dev)
 	struct bnx2 *bp = netdev_priv(dev);
 	int rc;
 
-	rc = bnx2_request_firmware(bp);
-	if (rc < 0)
-		goto out;
-
 	netif_carrier_off(dev);
 
 	bnx2_disable_int(bp);
@@ -8575,6 +8571,12 @@ bnx2_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, dev);
 
+	rc = bnx2_request_firmware(bp);
+	if (rc < 0)
+		goto error;
+
+
+	bnx2_reset_chip(bp, BNX2_DRV_MSG_CODE_RESET);
 	memcpy(dev->dev_addr, bp->mac_addr, ETH_ALEN);
 
 	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_SG |
@@ -8607,6 +8609,7 @@ bnx2_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 error:
+	bnx2_release_firmware(bp);
 	pci_iounmap(pdev, bp->regview);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

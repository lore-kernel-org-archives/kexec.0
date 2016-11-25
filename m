Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cA8pl-0000Zv-9U
 for kexec@lists.infradead.org; Fri, 25 Nov 2016 05:14:02 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v7 06/12] iommu: Add is_attach_deferred call-back to iommu-ops
Date: Fri, 25 Nov 2016 13:13:13 +0800
Message-Id: <1480050799-1237-7-git-send-email-bhe@redhat.com>
In-Reply-To: <1480050799-1237-1-git-send-email-bhe@redhat.com>
References: <1480050799-1237-1-git-send-email-bhe@redhat.com>
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
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, dyoung@redhat.com

This new call-back will be used to check if the domain attach need be
deferred for now. If yes, the domain attach/detach will return directly.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/iommu.c | 8 ++++++++
 include/linux/iommu.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9a2f196..0262eee 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1083,6 +1083,10 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	int ret;
+	if ((domain->ops->is_attach_deferred != NULL) &&
+	    domain->ops->is_attach_deferred(domain, dev))
+		return 0;
+
 	if (unlikely(domain->ops->attach_dev == NULL))
 		return -ENODEV;
 
@@ -1124,6 +1128,10 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
+	if ((domain->ops->is_attach_deferred != NULL) &&
+	    domain->ops->is_attach_deferred(domain, dev))
+		return;
+
 	if (unlikely(domain->ops->detach_dev == NULL))
 		return;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 436dc21..e179313 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -200,6 +200,7 @@ struct iommu_ops {
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
 
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
+	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
 
 	unsigned long pgsize_bitmap;
 };
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

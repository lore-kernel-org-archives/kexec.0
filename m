Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WaCUI-0005BK-Br
 for kexec@lists.infradead.org; Tue, 15 Apr 2014 23:09:58 +0000
From: Bill Sumner <bill.sumner@hp.com>
Subject: [PATCH 4/8] Update iommu_attach_domain() and its callers
Date: Tue, 15 Apr 2014 17:09:05 -0600
Message-Id: <1397603349-30930-5-git-send-email-bill.sumner@hp.com>
In-Reply-To: <1397603349-30930-1-git-send-email-bill.sumner@hp.com>
References: <1397603349-30930-1-git-send-email-bill.sumner@hp.com>
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
To: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, kexec@lists.infradead.org, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, zhenhua@hp.com, bill.sumner@hp.com

 Allow specification of the domain-id for the new domain.


Signed-off-by: Bill Sumner <bill.sumner@hp.com>
---
 drivers/iommu/intel-iommu.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4352731..0c00c2d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1003,7 +1003,8 @@ static struct dmar_domain *alloc_domain(void)
 }
 
 static int iommu_attach_domain(struct dmar_domain *domain,
-			       struct intel_iommu *iommu)
+			       struct intel_iommu *iommu,
+			       int domain_number)
 {
 	int num;
 	unsigned long ndomains;
@@ -1013,12 +1014,15 @@ static int iommu_attach_domain(struct dmar_domain *domain,
 
 	spin_lock_irqsave(&iommu->lock, flags);
 
-	num = find_first_zero_bit(iommu->domain_ids, ndomains);
-	if (num >= ndomains) {
-		spin_unlock_irqrestore(&iommu->lock, flags);
-		printk(KERN_ERR "IOMMU: no free domain ids\n");
-		return -ENOMEM;
-	}
+	if (domain_number < 0) {
+		num = find_first_zero_bit(iommu->domain_ids, ndomains);
+		if (num >= ndomains) {
+			spin_unlock_irqrestore(&iommu->lock, flags);
+			pr_err("IOMMU: no free domain ids\n");
+			return -ENOMEM;
+		}
+	} else
+		num = domain_number;
 
 	domain->id = num;
 	set_bit(num, iommu->domain_ids);
@@ -1629,6 +1633,7 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 	int bus = 0, devfn = 0;
 	int segment;
 	int ret;
+	int did = -1;   /* Default to "no domain_id supplied" */
 
 	domain = find_domain(pdev);
 	if (domain)
@@ -1675,7 +1680,7 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 	}
 	iommu = drhd->iommu;
 
-	ret = iommu_attach_domain(domain, iommu);
+	ret = iommu_attach_domain(domain, iommu, did);
 	if (ret) {
 		free_domain_mem(domain);
 		goto error;
@@ -1894,7 +1899,7 @@ static int __init si_domain_init(int hw)
 		return -EFAULT;
 
 	for_each_active_iommu(iommu, drhd) {
-		ret = iommu_attach_domain(si_domain, iommu);
+		ret = iommu_attach_domain(si_domain, iommu, (int) -1);
 		if (ret) {
 			domain_exit(si_domain);
 			return -EFAULT;
-- 
Bill Sumner <bill.sumner@hp.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

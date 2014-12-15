Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g2t2353.austin.hp.com ([15.217.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y0SMI-0006Pw-Iw
 for kexec@lists.infradead.org; Mon, 15 Dec 2014 09:54:32 +0000
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
Subject: [PATCH 01/10] iommu/vt-d: Update iommu_attach_domain() and its callers
Date: Mon, 15 Dec 2014 17:52:57 +0800
Message-Id: <1418637186-9988-2-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1418637186-9988-1-git-send-email-zhen-hual@hp.com>
References: <1418637186-9988-1-git-send-email-zhen-hual@hp.com>
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
To: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com, joro@8bytes.org, vgoyal@redhat.com, dyoung@redhat.com, billsumnerlinux@gmail.com, zhen-hual@hp.com
Cc: jerry.hoemann@hp.com, tom.vaden@hp.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, lisa.mitchell@hp.com, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, li.zhang6@hp.com

Allow specification of the domain-id for the new domain.
This patch only adds the 'did' parameter to iommu_attach_domain()
and modifies all of its callers to specify the default value of -1
which says "no did specified, allocate a new one".

This is no functional change from current behaviour -- just enables
a functional change to be made in a later patch.

Bill Sumner:
    Original version.

Li, Zhenhua:
    Minor change, add change to function __iommu_attach_domain.

Signed-off-by: Bill Sumner <billsumnerlinux@gmail.com>
Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel-iommu.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1232336..2dc6250 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1534,31 +1534,36 @@ static struct dmar_domain *alloc_domain(int flags)
 }
 
 static int __iommu_attach_domain(struct dmar_domain *domain,
-				 struct intel_iommu *iommu)
+				 struct intel_iommu *iommu,
+				 int domain_number)
 {
 	int num;
 	unsigned long ndomains;
 
 	ndomains = cap_ndoms(iommu->cap);
-	num = find_first_zero_bit(iommu->domain_ids, ndomains);
-	if (num < ndomains) {
-		set_bit(num, iommu->domain_ids);
-		iommu->domains[num] = domain;
-	} else {
-		num = -ENOSPC;
-	}
+	if (domain_number < 0) {
+		num = find_first_zero_bit(iommu->domain_ids, ndomains);
+		if (num < ndomains) {
+			set_bit(num, iommu->domain_ids);
+			iommu->domains[num] = domain;
+		} else {
+			num = -ENOSPC;
+		}
+	} else
+		num = domain_number;
 
 	return num;
 }
 
 static int iommu_attach_domain(struct dmar_domain *domain,
-			       struct intel_iommu *iommu)
+			       struct intel_iommu *iommu,
+			       int domain_number)
 {
 	int num;
 	unsigned long flags;
 
 	spin_lock_irqsave(&iommu->lock, flags);
-	num = __iommu_attach_domain(domain, iommu);
+	num = __iommu_attach_domain(domain, iommu, domain_number);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 	if (num < 0)
 		pr_err("IOMMU: no free domain ids\n");
@@ -1577,7 +1582,7 @@ static int iommu_attach_vm_domain(struct dmar_domain *domain,
 		if (iommu->domains[num] == domain)
 			return num;
 
-	return __iommu_attach_domain(domain, iommu);
+	return __iommu_attach_domain(domain, iommu, -1);
 }
 
 static void iommu_detach_domain(struct dmar_domain *domain,
@@ -2231,6 +2236,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	u16 dma_alias;
 	unsigned long flags;
 	u8 bus, devfn;
+	int did = -1;   /* Default to "no domain_id supplied" */
 
 	domain = find_domain(dev);
 	if (domain)
@@ -2264,7 +2270,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	domain = alloc_domain(0);
 	if (!domain)
 		return NULL;
-	domain->id = iommu_attach_domain(domain, iommu);
+	domain->id = iommu_attach_domain(domain, iommu, did);
 	if (domain->id < 0) {
 		free_domain_mem(domain);
 		return NULL;
@@ -2442,7 +2448,7 @@ static int __init si_domain_init(int hw)
 		return -EFAULT;
 
 	for_each_active_iommu(iommu, drhd) {
-		ret = iommu_attach_domain(si_domain, iommu);
+		ret = iommu_attach_domain(si_domain, iommu, -1);
 		if (ret < 0) {
 			domain_exit(si_domain);
 			return -EFAULT;
@@ -3866,7 +3872,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	iommu_enable_translation(iommu);
 
 	if (si_domain) {
-		ret = iommu_attach_domain(si_domain, iommu);
+		ret = iommu_attach_domain(si_domain, iommu, -1);
 		if (ret < 0 || si_domain->id != ret)
 			goto disable_iommu;
 		domain_attach_iommu(si_domain, iommu);
-- 
2.0.0-rc0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

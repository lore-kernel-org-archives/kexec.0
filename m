Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YgUXI-0006CY-Ei
 for kexec@lists.infradead.org; Fri, 10 Apr 2015 08:43:37 +0000
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
Subject: [PATCH v10 01/10] iommu/vt-d: New function to attach domain with id
Date: Fri, 10 Apr 2015 16:42:04 +0800
Message-Id: <1428655333-19504-2-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
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
To: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com, joro@8bytes.org, vgoyal@redhat.com, dyoung@redhat.com
Cc: jerry.hoemann@hp.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, lisa.mitchell@hp.com, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, zhen-hual@hp.com, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com

Allow specification of the domain-id for the new domain.
This patch only adds a new function iommu_attach_domain_with_id, it is like
the function iommu_attach_domain(), only adding a parameter "did".

Bill Sumner:
    (In older versions) Add new 'did' parameter to iommu_attach_domain();
    The caller of this function.

Li, Zhenhua:
    New function iommu_attach_domain_with_id(), instead of updating function
    iommu_attach_domain();

Signed-off-by: Bill Sumner <billsumnerlinux@gmail.com>
Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel-iommu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2d1e05b..3a93ce0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1558,6 +1558,16 @@ static int iommu_attach_domain(struct dmar_domain *domain,
 	return num;
 }
 
+static int iommu_attach_domain_with_id(struct dmar_domain *domain,
+			       struct intel_iommu *iommu,
+			       int domain_number)
+{
+	if (domain_number >= 0)
+		return domain_number;
+
+	return iommu_attach_domain(domain, iommu);
+}
+
 static int iommu_attach_vm_domain(struct dmar_domain *domain,
 				  struct intel_iommu *iommu)
 {
@@ -2224,6 +2234,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	u16 dma_alias;
 	unsigned long flags;
 	u8 bus, devfn;
+	int did = -1;   /* Default to "no domain_id supplied" */
 
 	domain = find_domain(dev);
 	if (domain)
@@ -2257,7 +2268,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	domain = alloc_domain(0);
 	if (!domain)
 		return NULL;
-	domain->id = iommu_attach_domain(domain, iommu);
+	domain->id = iommu_attach_domain_with_id(domain, iommu, did);
 	if (domain->id < 0) {
 		free_domain_mem(domain);
 		return NULL;
-- 
2.0.0-rc0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

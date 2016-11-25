Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cA8q0-0000d8-9T
 for kexec@lists.infradead.org; Fri, 25 Nov 2016 05:14:17 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v7 10/12] iommu/amd: Clear out the GV flag when handle
 deferred domain attach
Date: Fri, 25 Nov 2016 13:13:17 +0800
Message-Id: <1480050799-1237-11-git-send-email-bhe@redhat.com>
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

When handle deferred domain attach, we need check if the domain is
v2. If not, should try to clear out the GV flag which could be
copied from the old device table entry.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 22520f6..3a8e4ae 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1839,6 +1839,11 @@ static void clear_dte_entry(u16 devid)
 	amd_iommu_apply_erratum_63(devid);
 }
 
+static void clear_dte_flag_gv(u16 devid)
+{
+	amd_iommu_dev_table[devid].data[0] &= (~DTE_FLAG_GV);
+}
+
 static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
@@ -2299,6 +2304,7 @@ static void queue_add(struct dma_ops_domain *dma_dom,
  */
 static struct protection_domain *get_domain(struct device *dev)
 {
+	struct iommu_dev_data *dev_data = get_dev_data(dev);
 	struct protection_domain *domain;
 	struct iommu_domain *io_domain;
 
@@ -2306,11 +2312,21 @@ static struct protection_domain *get_domain(struct device *dev)
 		return ERR_PTR(-EINVAL);
 
 	domain = get_dev_data(dev)->domain;
-	if (domain == NULL && get_dev_data(dev)->defer_attach) {
+	if (domain == NULL && dev_data->defer_attach) {
+		u16 alias = amd_iommu_alias_table[dev_data->devid];
 		get_dev_data(dev)->defer_attach = false;
 		io_domain = iommu_get_domain_for_dev(dev);
 		domain = to_pdomain(io_domain);
 		attach_device(dev, domain);
+		/*
+		 * If the deferred attached domain is not v2, should clear out
+		 * the old GV flag.
+		 */
+		if (!(domain->flags & PD_IOMMUV2_MASK)) {
+			clear_dte_flag_gv(dev_data->devid);
+			if (alias != dev_data->devid)
+				clear_dte_flag_gv(dev_data->devid);
+		}
 	}
 	if (!dma_ops_domain(domain))
 		return ERR_PTR(-EBUSY);
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

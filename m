Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g2t2352.austin.hp.com ([15.217.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y0SMr-0006fW-L3
 for kexec@lists.infradead.org; Mon, 15 Dec 2014 09:55:06 +0000
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
Subject: [PATCH 08/10] iommu/vtd: assign new page table for dma_map
Date: Mon, 15 Dec 2014 17:53:04 +0800
Message-Id: <1418637186-9988-9-git-send-email-zhen-hual@hp.com>
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

When a device driver issues the first dma_map command for a
device, we assign a new and empty page-table, thus removing all
mappings from the old kernel for the device.

Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel-iommu.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4837ce5..f11a9b1 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3200,15 +3200,28 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 	}
 
 	/* make sure context mapping is ok */
-	if (unlikely(!domain_context_mapped(dev))) {
-		ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
-		if (ret) {
-			printk(KERN_ERR "Domain context map for %s failed",
-			       dev_name(dev));
-			return NULL;
-		}
+	if (likely(domain_context_mapped(dev))) {
+#ifdef CONFIG_CRASH_DUMP
+		if (is_kdump_kernel()) {
+			domain_exit(domain);
+			domain = get_domain_for_dev(dev,
+				DEFAULT_DOMAIN_ADDRESS_WIDTH);
+			if (!domain) {
+				pr_err("Allocating domain for %s failed",
+				       dev_name(dev));
+				return NULL;
+			}
+		} else
+#endif
+			return domain;
 	}
 
+	ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
+	if (ret) {
+		pr_err("Domain context map for %s failed",
+		       dev_name(dev));
+		return NULL;
+	}
 	return domain;
 }
 
-- 
2.0.0-rc0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

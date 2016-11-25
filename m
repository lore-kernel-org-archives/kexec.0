Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cA8q5-0000ed-92
 for kexec@lists.infradead.org; Fri, 25 Nov 2016 05:14:22 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v7 11/12] iommu: Assign the direct mapped domain to
 group->domain
Date: Fri, 25 Nov 2016 13:13:18 +0800
Message-Id: <1480050799-1237-12-git-send-email-bhe@redhat.com>
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

In iommu_request_dm_for_dev(), devices of group have all been attached
to newly created direct mapped domain. We should store the domain into
group->domain so that it works for iommu_get_domain_for_dev() and
get_domain().

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0262eee..a2d1a8f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1612,6 +1612,7 @@ int iommu_request_dm_for_dev(struct device *dev)
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
 	group->default_domain = dm_domain;
+	group->domain = dm_domain;
 
 	pr_info("Using direct mapping for device %s\n", dev_name(dev));
 
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

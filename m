Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zf0Ax-0001AR-7B
 for kexec@lists.infradead.org; Thu, 24 Sep 2015 06:38:39 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 09/10] iommu/amd: Clear the iommu pre enabled setting
Date: Thu, 24 Sep 2015 14:37:35 +0800
Message-Id: <1443076656-31776-10-git-send-email-bhe@redhat.com>
In-Reply-To: <1443076656-31776-1-git-send-email-bhe@redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
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
To: joro@8bytes.org, iommu@lists.linux-foundation.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>

In the first 
Now any change of domain can be updated to dev tables and io page table

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index aee1ae4..1e86f4c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2469,6 +2469,8 @@ static dma_addr_t __map_single(struct device *dev,
 	unsigned long align_mask = 0;
 	int i;
 
+	if (translation_pre_enabled())
+		clear_translation_pre_enabled();
 	pages = iommu_num_pages(paddr, size, PAGE_SIZE);
 	paddr &= PAGE_MASK;
 
-- 
2.4.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

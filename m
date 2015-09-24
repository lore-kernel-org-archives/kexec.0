Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zf0As-00016m-7Q
 for kexec@lists.infradead.org; Thu, 24 Sep 2015 06:38:34 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 08/10] iommu/amd: Do not update the information of domain to
 devtables before device driver init
Date: Thu, 24 Sep 2015 14:37:34 +0800
Message-Id: <1443076656-31776-9-git-send-email-bhe@redhat.com>
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

update_domain() is the only place where domain->pt_root will be got and
set into dev entry. So before the device driver initialization we do
nothing if it's in previously enabled translation status.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 0d59f79..aee1ae4 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2350,7 +2350,7 @@ static void update_device_table(struct protection_domain *domain)
 
 static void update_domain(struct protection_domain *domain)
 {
-	if (!domain->updated)
+	if (!domain->updated || translation_pre_enabled())
 		return;
 
 	update_device_table(domain);
-- 
2.4.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

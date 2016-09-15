Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bkYCl-0007KE-Vf
 for kexec@lists.infradead.org; Thu, 15 Sep 2016 15:04:00 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 2/8] iommu/amd: add early_enable_iommu() wrapper function
Date: Thu, 15 Sep 2016 23:03:20 +0800
Message-Id: <1473951806-25511-3-git-send-email-bhe@redhat.com>
In-Reply-To: <1473951806-25511-1-git-send-email-bhe@redhat.com>
References: <1473951806-25511-1-git-send-email-bhe@redhat.com>
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
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, Vincent.Wan@amd.com, iommu@lists.linux-foundation.org, dyoung@redhat.com

Move per iommu enabling code into a wrapper function early_enable_iommu().
This can make later kdump change easier.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu_init.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 9bf1a04..77c44c8 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1887,6 +1887,18 @@ static void iommu_apply_resume_quirks(struct amd_iommu *iommu)
 			       iommu->stored_addr_lo | 1);
 }
 
+static void early_enable_iommu(struct amd_iommu *iommu)
+{
+	iommu_disable(iommu);
+	iommu_init_flags(iommu);
+	iommu_set_device_table(iommu);
+	iommu_enable_command_buffer(iommu);
+	iommu_enable_event_buffer(iommu);
+	iommu_set_exclusion_range(iommu);
+	iommu_enable(iommu);
+	iommu_flush_all_caches(iommu);
+}
+
 /*
  * This function finally enables all IOMMUs found in the system after
  * they have been initialized
@@ -1895,16 +1907,8 @@ static void early_enable_iommus(void)
 {
 	struct amd_iommu *iommu;
 
-	for_each_iommu(iommu) {
-		iommu_disable(iommu);
-		iommu_init_flags(iommu);
-		iommu_set_device_table(iommu);
-		iommu_enable_command_buffer(iommu);
-		iommu_enable_event_buffer(iommu);
-		iommu_set_exclusion_range(iommu);
-		iommu_enable(iommu);
-		iommu_flush_all_caches(iommu);
-	}
+	for_each_iommu(iommu)
+		early_enable_iommu(iommu);
 }
 
 static void enable_iommus_v2(void)
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

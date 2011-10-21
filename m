Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RHEEV-0002ER-FU
	for kexec@lists.infradead.org; Fri, 21 Oct 2011 12:29:56 +0000
Date: Fri, 21 Oct 2011 20:31:54 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] intel-iommu:make identity_map default for crash dump
Message-ID: <20111021123154.GA5821@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, iommu@lists.linux-foundation.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org, luyu@redhat.com

kdump kernel sometimes will get DMAR faults which
is caused by random in-flight dma from 1st kernel

Here make the identity_mapping as default for this case

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 drivers/iommu/intel-iommu.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c621c98..8ac3895 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -40,6 +40,7 @@
 #include <linux/tboot.h>
 #include <linux/dmi.h>
 #include <linux/pci-ats.h>
+#include <linux/crash_dump.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
 
@@ -2481,7 +2482,7 @@ static int __init init_dmars(void)
 		}
 	}
 
-	if (iommu_pass_through)
+	if (iommu_pass_through || is_kdump_kernel())
 		iommu_identity_mapping |= IDENTMAP_ALL;
 
 #ifdef CONFIG_DMAR_BROKEN_GFX_WA
-- 
1.7.4.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

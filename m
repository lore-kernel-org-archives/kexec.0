Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jW2sL-000203-2V
 for kexec@lists.infradead.org; Tue, 05 May 2020 19:05:07 +0000
Received: by mail-pl1-f198.google.com with SMTP id j23so2671486pll.16
 for <kexec@lists.infradead.org>; Tue, 05 May 2020 12:05:01 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 2/2] net: qed: Disable SRIOV functionality inside kdump kernel
Date: Wed,  6 May 2020 00:34:41 +0530
Message-Id: <1588705481-18385-3-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1588705481-18385-1-git-send-email-bhsharma@redhat.com>
References: <1588705481-18385-1-git-send-email-bhsharma@redhat.com>
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
To: netdev@vger.kernel.org
Cc: aelior@marvell.com, manishc@marvell.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, GR-everest-linux-l2@marvell.com, bhupesh.linux@gmail.com, davem@davemloft.net

Since we have kdump kernel(s) running under severe memory constraint
it makes sense to disable the qed SRIOV functionality when running the
kdump kernel as kdump configurations on several distributions don't
support SRIOV targets for saving the vmcore (see [1] for example).

Currently the qed SRIOV functionality ends up consuming memory in
the kdump kernel, when we don't really use the same.

An example log seen in the kdump kernel with the SRIOV functionality
enabled can be seen below (obtained via memstrack tool, see [2]):
 dracut-pre-pivot[676]: ======== Report format module_summary: ========
 dracut-pre-pivot[676]: Module qed using 149.6MB (2394 pages), peak allocation 149.6MB (2394 pages)

This patch disables the SRIOV functionality inside kdump kernel and with
the same applied the memory consumption goes down:
 dracut-pre-pivot[671]: ======== Report format module_summary: ========
 dracut-pre-pivot[671]: Module qed using 124.6MB (1993 pages), peak allocation 124.7MB (1995 pages)

[1]. https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_monitoring_and_updating_the_kernel/installing-and-configuring-kdump_managing-monitoring-and-updating-the-kernel#supported-kdump-targets_supported-kdump-configurations-and-targets
[2]. Memstrack tool: https://github.com/ryncsn/memstrack

Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Ariel Elior <aelior@marvell.com>
Cc: GR-everest-linux-l2@marvell.com
Cc: Manish Chopra <manishc@marvell.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 drivers/net/ethernet/qlogic/qed/qed_sriov.h  | 10 +++++++---
 drivers/net/ethernet/qlogic/qede/qede_main.c |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.h b/drivers/net/ethernet/qlogic/qed/qed_sriov.h
index 368e88565783..f2ebd9a76e20 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.h
@@ -32,6 +32,7 @@
 
 #ifndef _QED_SRIOV_H
 #define _QED_SRIOV_H
+#include <linux/crash_dump.h>
 #include <linux/types.h>
 #include "qed_vf.h"
 
@@ -40,9 +41,12 @@
 #define QED_VF_ARRAY_LENGTH (3)
 
 #ifdef CONFIG_QED_SRIOV
-#define IS_VF(cdev)             ((cdev)->b_is_vf)
-#define IS_PF(cdev)             (!((cdev)->b_is_vf))
-#define IS_PF_SRIOV(p_hwfn)     (!!((p_hwfn)->cdev->p_iov_info))
+#define IS_VF(cdev)             ((is_kdump_kernel()) ? \
+				 (0) : ((cdev)->b_is_vf))
+#define IS_PF(cdev)             ((is_kdump_kernel()) ? \
+				 (1) : !((cdev)->b_is_vf))
+#define IS_PF_SRIOV(p_hwfn)     ((is_kdump_kernel()) ? \
+				 (0) : !!((p_hwfn)->cdev->p_iov_info))
 #else
 #define IS_VF(cdev)             (0)
 #define IS_PF(cdev)             (1)
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 34fa3917eb33..f557ae90ce7c 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -1187,7 +1187,7 @@ static int qede_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	case QEDE_PRIVATE_VF:
 		if (debug & QED_LOG_VERBOSE_MASK)
 			dev_err(&pdev->dev, "Probing a VF\n");
-		is_vf = true;
+		is_vf = is_kdump_kernel() ? false : true;
 		break;
 	default:
 		if (debug & QED_LOG_VERBOSE_MASK)
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

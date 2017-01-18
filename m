Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cTzS6-0002Np-I6
 for kexec@lists.infradead.org; Wed, 18 Jan 2017 23:15:39 +0000
From: Sameer Goel <sgoel@codeaurora.org>
Subject: [PATCH v3] kexec: Increase the upper limit for RAM segments
Date: Wed, 18 Jan 2017 16:15:12 -0700
Message-Id: <1484781312-22420-1-git-send-email-sgoel@codeaurora.org>
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
To: geoff@infradead.org, xlpang@redhat.com, bhe@redhat.com
Cc: Sameer Goel <sgoel@codeaurora.org>, kexec@lists.infradead.org

On a newer UEFI based Qualcomm target the number of system ram regions
retrieved from /proc/iomem are ~40. So increasing the current hardcoded
values to 64 from 16.

Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
---
 kexec/arch/arm64/kexec-arm64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index bac62f8..bd4c20e 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -11,7 +11,7 @@
 #include "image-header.h"
 #include "kexec.h"
 
-#define KEXEC_SEGMENT_MAX 16
+#define KEXEC_SEGMENT_MAX 64
 
 #define BOOT_BLOCK_VERSION 17
 #define BOOT_BLOCK_LAST_COMP_VERSION 16
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

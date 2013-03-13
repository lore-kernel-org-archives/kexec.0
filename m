Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-da0-x22f.google.com ([2607:f8b0:400e:c00::22f])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFpUl-0006HQ-Cz
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 17:29:43 +0000
Received: by mail-da0-f47.google.com with SMTP id s35so508415dak.6
 for <kexec@lists.infradead.org>; Wed, 13 Mar 2013 10:29:42 -0700 (PDT)
Message-ID: <5140B77E.7020800@gmail.com>
Date: Thu, 14 Mar 2013 01:29:34 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 06/13] kexec: arm: use _ALIGN* to make the logic clear
References: <5140B511.7020109@gmail.com>
In-Reply-To: <5140B511.7020109@gmail.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

By replacing all the explicit align opertion with marco _ALIGN*,
the code logic could be more clear.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/arm/kexec-zImage-arm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index db29a7b..dd2e06f 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -414,7 +414,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		 * align it.
 		 */
 		dtb_offset = initrd_base + initrd_size + getpagesize();
-		dtb_offset &= ~(getpagesize() - 1);
+		dtb_offset = _ALIGN_DOWN(dtb_offset, getpagesize());
 
 		add_segment(info, dtb_buf, dtb_length,
 		            dtb_offset, dtb_length);
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

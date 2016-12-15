Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cHMl1-0007P9-Vy
 for kexec@lists.infradead.org; Thu, 15 Dec 2016 03:31:01 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH] x86/crash: Update the stale comment in reserve_crashkernel()
Date: Thu, 15 Dec 2016 11:30:21 +0800
Message-Id: <1481772621-17923-1-git-send-email-xlpang@redhat.com>
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
To: kexec@lists.infradead.org
Cc: Robert LeBlanc <robert@leblancnet.us>, Xunlei Pang <xlpang@redhat.com>, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>

CRASH_KERNEL_ADDR_MAX was missing for a long time, update it
with more detailed explanation.

Cc: Robert LeBlanc <robert@leblancnet.us>
Cc: Baoquan He <bhe@redhat.com>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 arch/x86/kernel/setup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 9c337b0..79ee507 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -575,7 +575,10 @@ static void __init reserve_crashkernel(void)
 	/* 0 means: find the address automatically */
 	if (crash_base <= 0) {
 		/*
-		 *  kexec want bzImage is below CRASH_KERNEL_ADDR_MAX
+		 * Set CRASH_ADDR_LOW_MAX upper bound for crash range
+		 * as old kexec-tools loads bzImage below that, unless
+		 * "size,high" or "size@offset"(nonzero offset, see the
+		 * else leg below) is specified.
 		 */
 		crash_base = memblock_find_in_range(CRASH_ALIGN,
 						    high ? CRASH_ADDR_HIGH_MAX
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

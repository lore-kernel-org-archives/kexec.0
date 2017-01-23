Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cVYPW-0002B7-1X
 for kexec@lists.infradead.org; Mon, 23 Jan 2017 06:47:26 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH v2] x86/crash: Update the stale comment in
 reserve_crashkernel()
Date: Mon, 23 Jan 2017 14:48:23 +0800
Message-Id: <1485154103-18426-1-git-send-email-xlpang@redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, Xunlei Pang <xlpang@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Robert LeBlanc <robert@leblancnet.us>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

CRASH_KERNEL_ADDR_MAX has been missing for a long time,
update it with more detailed explanation.

Cc: Robert LeBlanc <robert@leblancnet.us>
Cc: Baoquan He <bhe@redhat.com>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 arch/x86/kernel/setup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 4cfba94..c32a167 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -575,7 +575,9 @@ static void __init reserve_crashkernel(void)
 	/* 0 means: find the address automatically */
 	if (crash_base <= 0) {
 		/*
-		 *  kexec want bzImage is below CRASH_KERNEL_ADDR_MAX
+		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory
+		 * as old kexec-tools loads bzImage below that, unless
+		 * "crashkernel=size[KMG],high" is specified.
 		 */
 		crash_base = memblock_find_in_range(CRASH_ALIGN,
 						    high ? CRASH_ADDR_HIGH_MAX
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWzkG-0003QY-0a
 for kexec@lists.infradead.org; Wed, 12 Dec 2018 08:19:54 +0000
Received: by mail-pl1-x644.google.com with SMTP id z23so8268166plo.0
 for <kexec@lists.infradead.org>; Wed, 12 Dec 2018 00:19:41 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCH] x86/kdump: directly find a candidate region when crashkernel=X
Date: Wed, 12 Dec 2018 16:19:16 +0800
Message-Id: <1544602756-17449-1-git-send-email-kernelfans@gmail.com>
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
To: linux-kernel@vger.kernel.org
Cc: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Pingfan Liu <kernelfans@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org, vgoyal@redhat.com

I encounter a case where crashkernel=384M, and kaslr is enabled. During the
test, sometimes, the system may fail to reserve region for crash kernel,
although there is much free space above 896MB. It is caused by the
truncation of the candidate region by kaslr kernel. It raises confusion to
the end user that sometimes crashkernel=X works while sometimes fails.
Since on x86, kaslr is a default option, and this corner case is
unavoidable.
This patch simplifies the method suggested in the mail [1]. It just goes
bottom-up to find a candidate region for crashkernel.
There is one trivial thing about the compatibility with old kexec-tools:
if the reserved region is above 896M, then old tool will fail to load
bzImage. But without this patch, the old tool also fail since there is no
memory below 896M can be reserved for crashkernel.

[1]: http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: yinghai@kernel.org,
Cc: vgoyal@redhat.com
Cc: kexec@lists.infradead.org

---
 arch/x86/kernel/setup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d494b9b..60f12c4 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -541,15 +541,18 @@ static void __init reserve_crashkernel(void)
 
 	/* 0 means: find the address automatically */
 	if (crash_base <= 0) {
+		if (!memblock_bottom_up())
+			memblock_set_bottom_up(true);
 		/*
 		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
 		 * as old kexec-tools loads bzImage below that, unless
 		 * "crashkernel=size[KMG],high" is specified.
 		 */
 		crash_base = memblock_find_in_range(CRASH_ALIGN,
-						    high ? CRASH_ADDR_HIGH_MAX
-							 : CRASH_ADDR_LOW_MAX,
-						    crash_size, CRASH_ALIGN);
+			(max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN);
+		if (!memblock_bottom_up())
+			memblock_set_bottom_up(false);
+
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

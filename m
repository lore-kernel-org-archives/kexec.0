Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1asdJt-0005uu-4e
 for kexec@lists.infradead.org; Tue, 19 Apr 2016 21:36:29 +0000
From: Sameer Goel <sgoel@codeaurora.org>
Subject: [PATCH] arm64: Memstart should not be before the kernel start address
Date: Tue, 19 Apr 2016 15:36:04 -0600
Message-Id: <1461101764-7941-1-git-send-email-sgoel@codeaurora.org>
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
To: geoff@infradead.org, kexec@lists.infradead.org
Cc: Sameer Goel <sgoel@codeaurora.org>, timur@codeaurora.org, rruigrok@codeaurora.org, shankerd@codeaurora.org

Starting 4.6-rc4 the kernel memblock start is rounded down to a desirable
alignment. So, the kernel can see reserved memory regions before the kernel
start address in the iomem query.
Need to make sure that the right kernel start address is picked from the iomem
query.
---
 kexec/arch/arm64/kexec-arm64.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 776596a..5e39f4f 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -30,6 +30,12 @@
 #include "kexec-syscall.h"
 #include "arch/options.h"
 
+#define SZ_2M 0x200000
+
+#define __round_mask(x, y) ((__typeof__(x))((y)-1))
+#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
+#define round_down(x, y) ((x) & ~__round_mask(x, y))
+
 /* Global varables the core kexec routines expect. */
 
 unsigned char reuse_initrd;
@@ -944,6 +950,10 @@ static int get_memory_ranges_iomem(struct memory_range *array,
 		str = line + consumed;
 		r.end++;
 
+		if (memcmp(str, "Kernel code\n", 12)==0) {
+			set_memstart(round_down(r.start,SZ_2M));
+		}
+
 		if (memcmp(str, "System RAM\n", 11)) {
 			dbgprintf("%s:%d: SKIP: %016Lx - %016Lx : %s", __func__,
 				__LINE__, r.start, r.end, str);
@@ -956,8 +966,6 @@ static int get_memory_ranges_iomem(struct memory_range *array,
 			__LINE__, r.start, r.end, str);
 
 		array[(*count)++] = r;
-
-		set_memstart(r.start);
 	}
 
 	fclose(fp);
-- 
Qualcomm Innovation Center, Inc. Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

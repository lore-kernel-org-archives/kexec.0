Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TtEQS-0008BA-Rz
 for kexec@lists.infradead.org; Thu, 10 Jan 2013 09:27:54 +0000
Message-ID: <50EE88F0.1010804@cn.fujitsu.com>
Date: Thu, 10 Jan 2013 17:25:04 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH] kexec,i386: Remove unnecessary if condition check
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

If we load the relocatable bzImage, the boot protocol must >= 2.05,
So the if condition check is unnecessary.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/i386/kexec-bzImage.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index fd214a3..0605909 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -245,10 +245,8 @@ int do_bzImage_load(struct kexec_info *info,
 		unsigned long kern_align = real_mode->kernel_alignment;
 		unsigned long kernel32_max_addr = DEFAULT_BZIMAGE_ADDR_MAX;
 
-		if (real_mode->protocol_version >= 0x0203) {
-			if (kernel32_max_addr > real_mode->initrd_addr_max)
-				kernel32_max_addr = real_mode->initrd_addr_max;
-		}
+		if (kernel32_max_addr > real_mode->initrd_addr_max)
+			kernel32_max_addr = real_mode->initrd_addr_max;
 
 		kernel32_load_addr = add_buffer(info, kernel + kern16_size,
 						size, size, kern_align,
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

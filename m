Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22e.google.com ([2607:f8b0:400e:c03::22e])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y48d3-0004W3-VL
 for kexec@lists.infradead.org; Thu, 25 Dec 2014 13:39:02 +0000
Received: by mail-pa0-f46.google.com with SMTP id lf10so11791397pab.19
 for <kexec@lists.infradead.org>; Thu, 25 Dec 2014 05:38:39 -0800 (PST)
From: Yuri Volchkov <wolchkov.yuri@gmail.com>
Subject: [PATCH] kexec/x86: fix crashkernel reserved mem detection
Date: Thu, 25 Dec 2014 22:38:21 +0900
Message-Id: <1419514701-9397-1-git-send-email-wolchkov.yuri@gmail.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org
Cc: wolchkov.yuri@gmail.com

Function crashkernel_mem_callback had wrong parameters type
So crash_reserved_mem got completely insane values
As a result kexec was unable to allocate segments for crashkernel
For instance, I got this message:
	"Could not find a free area of memory of 0x9f000 bytes..."

Signed-off-by: Yuri Volchkov <wolchkov.yuri@gmail.com>
---
 kexec/arch/i386/crashdump-x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 77bdad5..82bf239 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -1041,8 +1041,8 @@ int get_max_crash_kernel_limit(uint64_t *start, uint64_t *end)
 
 static int crashkernel_mem_callback(void *UNUSED(data), int nr,
                                           char *UNUSED(str),
-                                          unsigned long base,
-                                          unsigned long length)
+                                          unsigned long long base,
+                                          unsigned long long length)
 {
 	if (nr >= CRASH_RESERVED_MEM_NR)
 		return 1;
-- 
2.2.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

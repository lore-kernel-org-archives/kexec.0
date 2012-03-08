Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S5X1B-0001RU-7i
 for kexec@lists.infradead.org; Thu, 08 Mar 2012 06:40:05 +0000
Received: by mail-iy0-f177.google.com with SMTP id y10so310005iak.36
 for <kexec@lists.infradead.org>; Wed, 07 Mar 2012 22:40:05 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 3/5] arm: move DEBUG code to --debug
Date: Thu,  8 Mar 2012 14:39:40 +0800
Message-Id: <1331188782-10912-3-git-send-email-xiyou.wangcong@gmail.com>
In-Reply-To: <1331188782-10912-1-git-send-email-xiyou.wangcong@gmail.com>
References: <1331188782-10912-1-git-send-email-xiyou.wangcong@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Simon Horman <horms@verge.net.au>


Like patch 1/5, this one moves code under #if DEBUG to --debug
on arm arch.

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 kexec/arch/arm/crashdump-arm.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index e9b22bf..213dae2 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -219,7 +219,6 @@ static void cmdline_add_mem(char *cmdline, unsigned long size)
 	cmdline[COMMAND_LINE_SIZE - 1] = '\0';
 }
 
-#ifdef DEBUG
 static unsigned long long range_size(const struct memory_range *r)
 {
 	return r->end - r->start + 1;
@@ -229,6 +228,9 @@ static void dump_memory_ranges(void)
 {
 	int i;
 
+	if (!kexec_debug)
+		return;
+
 	dbgprintf("crashkernel: [%#llx - %#llx] (%ldM)\n",
 		  crash_reserved_mem.start, crash_reserved_mem.end,
 		  (unsigned long)range_size(&crash_reserved_mem) >> 20);
@@ -239,9 +241,6 @@ static void dump_memory_ranges(void)
 			  r->start, r->end, (unsigned long)range_size(r) >> 20);
 	}
 }
-#else
-static inline void dump_memory_ranges(void) {}
-#endif
 
 /**
  * load_crashdump_segments() - loads additional segments needed for kdump
-- 
1.7.7.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

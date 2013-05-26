Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgRqn-0000P4-8x
 for kexec@lists.infradead.org; Sun, 26 May 2013 03:42:29 +0000
Received: by mail-pd0-f181.google.com with SMTP id bv13so3609589pdb.40
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 20:42:07 -0700 (PDT)
Message-ID: <51A18486.10009@gmail.com>
Date: Sun, 26 May 2013 11:41:58 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 4/4] kexec-tools: sh: Remove saved_max_mem
References: <51A183B0.7000607@gmail.com>
In-Reply-To: <51A183B0.7000607@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

saved_max_mem is used to calculate the amount of memory that the previous
kernel used. It seems in sh, we just calculate this variable, but we
never use it. So remove it.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/sh/crashdump-sh.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/sh/crashdump-sh.c b/kexec/arch/sh/crashdump-sh.c
index 68ca756..fe11b17 100644
--- a/kexec/arch/sh/crashdump-sh.c
+++ b/kexec/arch/sh/crashdump-sh.c
@@ -31,8 +31,6 @@
 #define CRASH_MAX_MEMORY_RANGES 64
 static struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
 
-uint64_t saved_max_mem;
-
 static int crash_sh_range_nr;
 static int crash_sh_memory_range_callback(void *UNUSED(data), int UNUSED(nr),
 					  char *str,
@@ -54,9 +52,6 @@ static int crash_sh_memory_range_callback(void *UNUSED(data), int UNUSED(nr),
 		range->end = base + length - 1;
 		range->type = RANGE_RAM;
 		crash_sh_range_nr++;
-
-		if (saved_max_mem < range->end)
-			saved_max_mem = range->end;
 	}
 
 	if (strncmp(str, "Crash kernel\n", 13) == 0) {
@@ -80,7 +75,6 @@ static int crash_sh_memory_range_callback(void *UNUSED(data), int UNUSED(nr),
 static int crash_get_memory_ranges(struct memory_range **range, int *ranges)
 {
 	crash_sh_range_nr = 0;
-	saved_max_mem = 0;
 
 	kexec_iomem_for_each_line(NULL, crash_sh_memory_range_callback, NULL);
 	*range = crash_memory_range;
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

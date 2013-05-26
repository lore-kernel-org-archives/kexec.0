Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgRqG-0000OG-Hk
 for kexec@lists.infradead.org; Sun, 26 May 2013 03:41:57 +0000
Received: by mail-pd0-f178.google.com with SMTP id w11so2436583pde.9
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 20:41:35 -0700 (PDT)
Message-ID: <51A18465.9000709@gmail.com>
Date: Sun, 26 May 2013 11:41:25 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 3/4] kexec-tools: ppc64: Remove saved_max_mem
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
kernel used. And passed to the dump-capture kernel by kernel commandline
parameter "savemaxmem=". But in the dump-capture kernel, we never use
this parameter now, so remove saved_max_mem and don't add "savemaxmem="
to new kernel commandline.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/ppc64/crashdump-ppc64.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 49cab12..e31dd6d 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -69,17 +69,6 @@ static int crash_max_memory_ranges;
  */
 mem_rgns_t usablemem_rgns = {0, NULL};
 
-/*
- * To store the memory size of the first kernel and this value will be
- * passed to the second kernel as command line (savemaxmem=xM).
- * The second kernel will be calculated saved_max_pfn based on this
- * variable.
- * Since we are creating/using usable-memory property, there is no way
- * we can determine the RAM size unless parsing the device-tree/memoy@/reg
- * property in the kernel.
- */
-uint64_t saved_max_mem = 0;
-
 static unsigned long long cstart, cend;
 static int memory_ranges;
 
@@ -303,13 +292,6 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 		crash_memory_range[memory_ranges].start = cstart;
 		crash_memory_range[memory_ranges++].end = cend;
 	}
-	/*
-	 * Can not trust the memory regions order that we read from
-	 * device-tree. Hence, get the MAX end value.
-	 */
-	for (i = 0; i < memory_ranges; i++)
-		if (saved_max_mem < crash_memory_range[i].end)
-			saved_max_mem = crash_memory_range[i].end;
 
 	*range = crash_memory_range;
 	*ranges = memory_ranges;
@@ -446,7 +428,6 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	 * read by flatten_device_tree and modified if required
 	 */
 	add_cmdline_param(mod_cmdline, elfcorehdr, " elfcorehdr=", "K");
-	add_cmdline_param(mod_cmdline, saved_max_mem, " savemaxmem=", "M");
 	return 0;
 }
 
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pb0-x231.google.com ([2607:f8b0:400e:c01::231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgRpd-0000Nd-Qq
 for kexec@lists.infradead.org; Sun, 26 May 2013 03:41:18 +0000
Received: by mail-pb0-f49.google.com with SMTP id rp8so5645632pbb.36
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 20:40:55 -0700 (PDT)
Message-ID: <51A1843D.3060706@gmail.com>
Date: Sun, 26 May 2013 11:40:45 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 2/4] kexec-tools: ppc: Remove saved_max_mem
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
 kexec/arch/ppc/crashdump-powerpc.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index eee5b37..c06d310 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -51,17 +51,6 @@ static int crash_max_memory_ranges;
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
-unsigned long long saved_max_mem;
-
 /* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom to
  * create Elf headers. Keeping it separate from get_memory_ranges() as
  * requirements are different in the case of normal kexec and crashdumps.
@@ -224,13 +213,6 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
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
@@ -378,7 +360,6 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 	 * read by flatten_device_tree and modified if required
 	 */
 	add_cmdline_param(mod_cmdline, elfcorehdr, " elfcorehdr=", "K");
-	add_cmdline_param(mod_cmdline, saved_max_mem, " savemaxmem=", "M");
 	add_cmdline(mod_cmdline, " maxcpus=1");
 	return 0;
 }
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

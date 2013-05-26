Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgRoy-0000MX-LS
 for kexec@lists.infradead.org; Sun, 26 May 2013 03:40:37 +0000
Received: by mail-pa0-f50.google.com with SMTP id fb11so4329234pad.37
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 20:40:15 -0700 (PDT)
Message-ID: <51A18415.5070506@gmail.com>
Date: Sun, 26 May 2013 11:40:05 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 1/4] kexec-tools: mips: Remove saved_max_mem
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
 kexec/arch/mips/crashdump-mips.c |   34 ----------------------------------
 1 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index 8e7b1c3..e7840e0 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -41,14 +41,6 @@ static struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
 /* Memory region reserved for storing panic kernel and other data. */
 static struct memory_range crash_reserved_mem;
 
-/*
- * To store the memory size of the first kernel and this value will be
- * passed to the second kernel as command line (savemaxmem=xM).
- * The second kernel will be calculated saved_max_pfn based on this
- * variable.
- */
-unsigned long long saved_max_mem;
-
 /* Read kernel physical load addr from the file returned by proc_iomem()
  * (Kernel Code) and store in kexec_info */
 static int get_kernel_paddr(struct crash_elf_info *elf_info)
@@ -220,10 +212,6 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 	if (exclude_crash_reserve_region(&memory_ranges) < 0)
 		return -1;
 
-	for (i = 0; i < memory_ranges; i++)
-		if (saved_max_mem < crash_memory_range[i].end)
-			saved_max_mem = crash_memory_range[i].end + 1;
-
 	*range = crash_memory_range;
 	*ranges = memory_ranges;
 	return 0;
@@ -299,27 +287,6 @@ static int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr)
 	return 0;
 }
 
-/* Adds the savemaxmem= command line parameter to command line. */
-static int cmdline_add_savemaxmem(char *cmdline, unsigned long long addr)
-{
-	int cmdlen, len, align = 1024;
-	char str[30], *ptr;
-
-	/* Passing in savemaxmem=xxxM format. Saves space required in cmdline.*/
-	addr = addr/(align*align);
-	ptr = str;
-	strcpy(str, " savemaxmem=");
-	ptr += strlen(str);
-	ultoa(addr, ptr);
-	strcat(str, "M");
-	len = strlen(str);
-	cmdlen = strlen(cmdline) + len;
-	if (cmdlen > (COMMAND_LINE_SIZE - 1))
-		die("Command line overflow\n");
-	strcat(cmdline, str);
-	return 0;
-}
-
 #ifdef __mips64
 static struct crash_elf_info elf_info64 = {
 	class: ELFCLASS64,
@@ -394,7 +361,6 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	cmdline_add_mem(mod_cmdline, crash_reserved_mem.start,
 		elfcorehdr - crash_reserved_mem.start);
 	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
-	cmdline_add_savemaxmem(mod_cmdline, saved_max_mem);
 
 	dbgprintf("CRASH MEMORY RANGES:\n");
 	dbgprintf("%016Lx-%016Lx\n", crash_reserved_mem.start,
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

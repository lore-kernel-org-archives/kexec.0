Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UM8hd-0000Uh-Pd
 for kexec@lists.infradead.org; Sun, 31 Mar 2013 03:13:07 +0000
Received: by mail-pb0-f51.google.com with SMTP id rr4so721304pbb.10
 for <kexec@lists.infradead.org>; Sat, 30 Mar 2013 20:13:01 -0700 (PDT)
Message-ID: <5157A9B5.1040704@gmail.com>
Date: Sun, 31 Mar 2013 11:12:53 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] Revert "kexec: include reserved e820 sections in crash kernel"
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Cliff Wickman <cpw@sgi.com>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

This reverts commit e35aa29fb40b37bf86d980b2e19af5e01c2d2549.
This patch is based on the commit 49320340f705694e387d794f7f19d407ad9baefa
     "kexec: lengthen the kernel command line image"
Since the latter commit has been reverted due to its useless, this
patch should be reverted too.

Besides, This patch also changed a kernel restriction of max segments
from 16 to 70. Though kexec-tools could have more segments, more than 16,
the kexec_load syscall will still fail for the kernel side has a restriction
of 16.

Cc: Cliff Wickman <cpw@sgi.com>
Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/i386/crashdump-x86.c |   31 ++-----------------------------
 kexec/kexec-syscall.h           |    2 +-
 2 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 9ab648b..bbd0741 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -247,8 +247,6 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 			type = RANGE_ACPI;
 		} else if(memcmp(str,"ACPI Non-volatile Storage\n",26) == 0 ) {
 			type = RANGE_ACPI_NVS;
-		} else if(memcmp(str,"reserved\n", 9) == 0 ) {
-			type = RANGE_RESERVED;
 		} else if (memcmp(str, "GART\n", 5) == 0) {
 			gart_start = start;
 			gart_end = end;
@@ -907,27 +905,6 @@ static void get_backup_area(struct kexec_info *info,
 	info->backup_src_size = BACKUP_SRC_END - BACKUP_SRC_START + 1;
 }
 
-/* Appends memmap=X$Y commandline for reserved memory to command line*/
-static int cmdline_add_memmap_reserved(char *cmdline, unsigned long start,
-					unsigned long end)
-{
-	int align = 1024;
-	unsigned long startk, endk;
-
-	if (!(end - start))
-		return 0;
-
-	startk = start/1024;
-	endk = (end + align - 1)/1024;
-	cmdline_add_memmap_internal(cmdline, startk, endk, RANGE_RESERVED);
-
-#ifdef DEBUG
-		printf("Command line after adding reserved memmap\n");
-		printf("%s\n", cmdline);
-#endif
-	return 0;
-}
-
 /* Loads additional segments in case of a panic kernel is being loaded.
  * One segment for backup region, another segment for storing elf headers
  * for crash memory image.
@@ -1080,15 +1057,11 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	for (i = 0; i < CRASH_MAX_MEMORY_RANGES; i++) {
 		unsigned long start, end;
 		if ( !( mem_range[i].type == RANGE_ACPI
-			|| mem_range[i].type == RANGE_ACPI_NVS
-			|| mem_range[i].type == RANGE_RESERVED) )
+			|| mem_range[i].type == RANGE_ACPI_NVS) )
 			continue;
 		start = mem_range[i].start;
 		end = mem_range[i].end;
-		if (mem_range[i].type == RANGE_RESERVED)
-			cmdline_add_memmap_reserved(mod_cmdline, start, end);
-		else
-			cmdline_add_memmap_acpi(mod_cmdline, start, end);
+		cmdline_add_memmap_acpi(mod_cmdline, start, end);
 	}
 	return 0;
 }
diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index f5ee992..b56cb00 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -78,7 +78,7 @@ static inline long kexec_load(void *entry, unsigned long nr_segments,
 #define KEXEC_ARCH_MIPS    ( 8 << 16)
 #define KEXEC_ARCH_CRIS    (76 << 16)
 
-#define KEXEC_MAX_SEGMENTS 70
+#define KEXEC_MAX_SEGMENTS 16
 
 #ifdef __i386__
 #define KEXEC_ARCH_NATIVE	KEXEC_ARCH_386
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

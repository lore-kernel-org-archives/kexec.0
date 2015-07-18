Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0112.outbound.protection.outlook.com
 ([157.56.110.112] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZGYF7-0004CG-DO
 for kexec@lists.infradead.org; Sat, 18 Jul 2015 19:57:54 +0000
From: Scott Wood <scottwood@freescale.com>
Subject: [PATCH 1/2] ppc64: Fix warnings
Date: Sat, 18 Jul 2015 14:57:18 -0500
Message-ID: <1437249439-31496-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
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
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

Produce a warning-free build on ppc64 (at least, when built as 64-bit
userspace -- if a 64-bit binary for ppc64 is a requirement, why is -m64
set only on purgatory?).  Mostly unused (or write-only) variable
warnings, but also one nasty one where reserve() was used without a
prototype, causing long long arguments to be passed as int.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 kexec/arch/ppc64/crashdump-ppc64.c | 3 ++-
 kexec/arch/ppc64/kexec-elf-ppc64.c | 9 +--------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 6214b83..b3c8928 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -33,6 +33,7 @@
 #include "../../kexec-syscall.h"
 #include "../../crashdump.h"
 #include "kexec-ppc64.h"
+#include "../../fs2dt.h"
 #include "crashdump-ppc64.h"
 
 static struct crash_elf_info elf_info64 =
@@ -187,7 +188,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 	DIR *dir, *dmem;
 	FILE *file;
 	struct dirent *dentry, *mentry;
-	int i, n, crash_rng_len = 0;
+	int n, crash_rng_len = 0;
 	unsigned long long start, end;
 	int page_size;
 
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 4a1540e..adcee4c 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -97,7 +97,6 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	struct mem_ehdr ehdr;
 	char *cmdline, *modified_cmdline = NULL;
 	const char *devicetreeblob;
-	int cmdline_len, modified_cmdline_len;
 	uint64_t max_addr, hole_addr;
 	char *seg_buf = NULL;
 	off_t seg_size = 0;
@@ -107,7 +106,6 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	uint64_t *rsvmap_ptr;
 	struct bootblock *bb_ptr;
 #endif
-	int i;
 	int result, opt;
 	uint64_t my_kernel, my_dt_offset;
 	uint64_t my_opal_base = 0, my_opal_entry = 0;
@@ -162,10 +160,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 		}
 	}
 
-	cmdline_len = 0;
-	if (cmdline)
-		cmdline_len = strlen(cmdline) + 1;
-	else
+	if (!cmdline)
 		fprintf(stdout, "Warning: append= option is not passed. Using the first kernel root partition\n");
 
 	if (ramdisk && reuse_initrd)
@@ -181,7 +176,6 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 			strncpy(modified_cmdline, cmdline, COMMAND_LINE_SIZE);
 			modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
 		}
-		modified_cmdline_len = strlen(modified_cmdline);
 	}
 
 	/* Parse the Elf file */
@@ -219,7 +213,6 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 			return -1;
 		/* Use new command line. */
 		cmdline = modified_cmdline;
-		cmdline_len = strlen(modified_cmdline) + 1;
 	}
 
 	/* Add v2wrap to the current image */
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

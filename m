Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dfVZP-0007nW-Lg
 for kexec@lists.infradead.org; Wed, 09 Aug 2017 18:19:06 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v79IIbYf107999
 for <kexec@lists.infradead.org>; Wed, 9 Aug 2017 14:18:41 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c84gravs1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 09 Aug 2017 14:18:41 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 10 Aug 2017 04:18:35 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v79IIOlB26345634
 for <kexec@lists.infradead.org>; Thu, 10 Aug 2017 04:18:32 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v79II0aS021913
 for <kexec@lists.infradead.org>; Thu, 10 Aug 2017 04:18:00 +1000
Subject: [PATCH] kexec-tools: powerpc: fix command line overflow error
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 09 Aug 2017 23:47:42 +0530
MIME-Version: 1.0
Message-Id: <150230264648.32402.10255272562582526980.stgit@hbathini.in.ibm.com>
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
To: Simon Horman <horms@verge.net.au>, Kexec-ml <kexec@lists.infradead.org>

Since kernel commit a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE
to 2048"), powerpc bumped command line size to 2048 but the size
used here is still the default value of 512. Bump it to 2048 to
fix command line overflow errors observed when command line length
is above 512 bytes. Also, get rid of the multiple definitions of
COMMAND_LINE_SIZE macro in ppc architecture.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

Tested the patch successfully on ppc64 arch. Only compile-tested with
'make ARCH=ppc' on ppc32 arch. Would appreciate if someone with access
to any ppc32 system does some sanity testing of this patch.


 kexec/arch/ppc/crashdump-powerpc.c |    6 +++++-
 kexec/arch/ppc/crashdump-powerpc.h |    2 --
 kexec/arch/ppc/fs2dt.c             |    1 -
 kexec/arch/ppc/kexec-ppc.h         |    3 ++-
 kexec/arch/ppc/ops.h               |    1 -
 kexec/arch/ppc64/crashdump-ppc64.c |    6 ++++--
 kexec/arch/ppc64/crashdump-ppc64.h |    2 +-
 7 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index dde6de7..4ad026f 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -252,8 +252,12 @@ static void ulltoa(unsigned long long i, char *str)
 /* Append str to cmdline */
 static void add_cmdline(char *cmdline, char *str)
 {
+	int cmdline_size;
 	int cmdlen = strlen(cmdline) + strlen(str);
-	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+
+	cmdline_size = (kernel_version() < KERNEL_VERSION(3, 15, 0) ?
+			512 : COMMAND_LINE_SIZE);
+	if (cmdlen > (cmdline_size - 1))
 		die("Command line overflow\n");
 	strcat(cmdline, str);
 }
diff --git a/kexec/arch/ppc/crashdump-powerpc.h b/kexec/arch/ppc/crashdump-powerpc.h
index 9b9b01e..97b5095 100644
--- a/kexec/arch/ppc/crashdump-powerpc.h
+++ b/kexec/arch/ppc/crashdump-powerpc.h
@@ -20,8 +20,6 @@ extern struct arch_options_t arch_options;
 #define KERNELBASE	PAGE_OFFSET
 #define __pa(x)		((unsigned long)(x)-PAGE_OFFSET)
 
-#define COMMAND_LINE_SIZE	512 /* from kernel */
-
 #ifdef CONFIG_BOOKE
 /* We don't need backup region in Book E */
 #define BACKUP_SRC_START	0x0000
diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
index 6e77379..fed499b 100644
--- a/kexec/arch/ppc/fs2dt.c
+++ b/kexec/arch/ppc/fs2dt.c
@@ -37,7 +37,6 @@
 #define TREEWORDS		65536	/* max 32 bit words for properties */
 #define MEMRESERVE		256	/* max number of reserved memory blks */
 #define MAX_MEMORY_RANGES	1024
-#define COMMAND_LINE_SIZE	512	/* from kernel */
 
 static char pathname[MAXPATH];
 static char propnames[NAMESPACE] = { 0 };
diff --git a/kexec/arch/ppc/kexec-ppc.h b/kexec/arch/ppc/kexec-ppc.h
index f8fd678..04e728e 100644
--- a/kexec/arch/ppc/kexec-ppc.h
+++ b/kexec/arch/ppc/kexec-ppc.h
@@ -6,6 +6,8 @@
 #define CORE_TYPE_ELF32	1
 #define CORE_TYPE_ELF64	2
 
+#define COMMAND_LINE_SIZE	2048 /* from kernel */
+
 extern unsigned char setup_simple_start[];
 extern uint32_t setup_simple_size;
 
@@ -76,7 +78,6 @@ extern int init_memory_region_info(void);
 extern int read_memory_region_limits(int fd, unsigned long long *start,
 					unsigned long long *end);
 extern int get_devtree_value(const char *fname, unsigned long long *pvalue);
-#define COMMAND_LINE_SIZE	512 /* from kernel */
 /*fs2dt*/
 void reserve(unsigned long long where, unsigned long long length);
 
diff --git a/kexec/arch/ppc/ops.h b/kexec/arch/ppc/ops.h
index 7334a05..5e7a070 100644
--- a/kexec/arch/ppc/ops.h
+++ b/kexec/arch/ppc/ops.h
@@ -12,7 +12,6 @@
 #define _PPC_BOOT_OPS_H_
 #include "types.h"
 
-#define	COMMAND_LINE_SIZE	512
 #define	MAX_PATH_LEN		256
 #define	MAX_PROP_LEN		256 /* What should this be? */
 
diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 5a71d51..13995bf 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -381,7 +381,7 @@ static void ultoa(uint64_t i, char *str)
 static int add_cmdline_param(char *cmdline, uint64_t addr, char *cmdstr,
 				char *byte)
 {
-	int cmdlen, len, align = 1024;
+	int cmdline_size, cmdlen, len, align = 1024;
 	char str[COMMAND_LINE_SIZE], *ptr;
 
 	/* Passing in =xxxK / =xxxM format. Saves space required in cmdline.*/
@@ -402,7 +402,9 @@ static int add_cmdline_param(char *cmdline, uint64_t addr, char *cmdstr,
 	strcat(str, byte);
 	len = strlen(str);
 	cmdlen = strlen(cmdline) + len;
-	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+	cmdline_size = (kernel_version() < KERNEL_VERSION(3, 15, 0) ?
+			512 : COMMAND_LINE_SIZE);
+	if (cmdlen > (cmdline_size - 1))
 		die("Command line overflow\n");
 	strcat(cmdline, str);
 	dbgprintf("Command line after adding elfcorehdr: %s\n", cmdline);
diff --git a/kexec/arch/ppc64/crashdump-ppc64.h b/kexec/arch/ppc64/crashdump-ppc64.h
index d654c6b..42ccc31 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.h
+++ b/kexec/arch/ppc64/crashdump-ppc64.h
@@ -16,7 +16,7 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size);
 #define __pa(x)         ((unsigned long)(x)-PAGE_OFFSET)
 #define MAXMEM          (-KERNELBASE-VMALLOCBASE)
 
-#define COMMAND_LINE_SIZE       512 /* from kernel */
+#define COMMAND_LINE_SIZE       2048 /* from kernel */
 /* Backup Region, First 64K of System RAM. */
 #define BACKUP_SRC_START    0x0000
 #define BACKUP_SRC_END      0xffff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

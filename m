Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1STosC-00008X-SD
 for kexec@lists.infradead.org; Mon, 14 May 2012 06:35:14 +0000
From: Cong Wang <amwang@redhat.com>
Subject: [v2 PATCH] ppc: move DEBUG code to --debug
Date: Mon, 14 May 2012 14:34:56 +0800
Message-Id: <1336977296-30314-1-git-send-email-amwang@redhat.com>
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

From: Cong Wang <xiyou.wangcong@gmail.com>


From: Cong Wang <xiyou.wangcong@gmail.com>
V2: Fix a compile error

Like commit 28d4ab53280853d2aeefdfb7c369331e89ab9ac2
("Add generic debug option"), this one moves code
under #if DEBUG to --debug on ppc arch.

Sorry that I still can't find a ppc32 machine to test this.

Cc: Simon Horman <horms@verge.net.au>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 kexec/arch/ppc/crashdump-powerpc.c |   18 ++++++++----------
 kexec/arch/ppc/fixup_dtb.c         |   32 ++++++++++++++------------------
 kexec/arch/ppc/fs2dt.c             |    6 +++---
 kexec/arch/ppc/kexec-ppc.c         |   17 ++++++++---------
 kexec/arch/ppc/libfdt-wrapper.c    |    4 ++--
 kexec/arch/ppc64/crashdump-ppc64.c |   16 ++++++----------
 kexec/arch/ppc64/kexec-elf-ppc64.c |   23 +++++++++++------------
 kexec/arch/ppc64/kexec-ppc64.c     |    9 +++------
 8 files changed, 55 insertions(+), 70 deletions(-)

diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index 7c9dbff..1bef69b 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -226,15 +226,15 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 
 	*range = crash_memory_range;
 	*ranges = memory_ranges;
-#if DEBUG
+
 	int j;
-	printf("CRASH MEMORY RANGES\n");
+	dbgprintf("CRASH MEMORY RANGES\n");
 	for (j = 0; j < *ranges; j++) {
 		start = crash_memory_range[j].start;
 		end = crash_memory_range[j].end;
-		fprintf(stderr, "%016Lx-%016Lx\n", start, end);
+		dbgprintf("%016Lx-%016Lx\n", start, end);
 	}
-#endif
+
 	return 0;
 
 err:
@@ -289,9 +289,9 @@ static int add_cmdline_param(char *cmdline, unsigned long long addr,
 	if (cmdlen > (COMMAND_LINE_SIZE - 1))
 		die("Command line overflow\n");
 	strcat(cmdline, str);
-#if DEBUG
-	fprintf(stderr, "Command line after adding elfcorehdr: %s\n", cmdline);
-#endif
+
+	dbgprintf("Command line after adding elfcorehdr: %s\n", cmdline);
+
 	return 0;
 }
 
@@ -403,10 +403,8 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size)
 	usablemem_rgns.ranges[usablemem_rgns.size].start = base;
 	usablemem_rgns.ranges[usablemem_rgns.size++].end = end;
 
-#ifdef DEBUG
-	fprintf(stderr, "usable memory rgns size:%u base:%llx size:%llx\n",
+	dbgprintf("usable memory rgns size:%u base:%llx size:%llx\n",
 		usablemem_rgns.size, base, size);
-#endif
 }
 
 int is_crashkernel_mem_reserved(void)
diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
index 189e0c7..e9890a4 100644
--- a/kexec/arch/ppc/fixup_dtb.c
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -17,25 +17,26 @@
 
 const char proc_dts[] = "/proc/device-tree";
 
-#ifdef DEBUG
-static void print_fdt_reserve_regions(void)
+static void print_fdt_reserve_regions(char *blob_buf)
 {
 	int i, num;
 
+	if (!kexec_debug)
+		return;
 	/* Print out a summary of the final reserve regions */
 	num =  fdt_num_mem_rsv(blob_buf);
-	printf ("reserve regions: %d\n", num);
+	dbgprintf ("reserve regions: %d\n", num);
 	for (i = 0; i < num; i++) {
 		uint64_t offset, size;
 
 		if (fdt_get_mem_rsv(blob_buf, i, &offset, &size) == 0) {
-			printf("%d: offset: %llx, size: %llx\n", i, offset, size);
+			dbgprintf("%d: offset: %llx, size: %llx\n", i, offset, size);
 		} else {
-			printf("Error retreiving reserved region\n");
+			dbgprintf("Error retreiving reserved region\n");
 		}
 	}
 }
-#endif
+
 
 static void fixup_nodes(char *nodes[])
 {
@@ -201,11 +202,8 @@ static void fixup_reserve_regions(struct kexec_info *info, char *blob_buf)
 				"device_type", "cpu", 4);
 	}
 
-out:	;
-
-#ifdef DEBUG
-	print_fdt_reserve_regions();
-#endif
+out:
+	print_fdt_reserve_regions(blob_buf);
 }
 
 static void fixup_memory(struct kexec_info *info, char *blob_buf)
@@ -369,23 +367,23 @@ char *fixup_dtb_init(struct kexec_info *info, char *blob_buf, off_t *blob_size,
 	return blob_buf;
 }
 
-#ifdef DEBUG
 static void save_fixed_up_dtb(char *blob_buf, off_t blob_size)
 {
 	FILE *fp;
 
+	if (!kexec_debug)
+		return;
 	fp = fopen("debug.dtb", "w");
 	if (fp) {
 		if ( blob_size == fwrite(blob_buf, sizeof(char), blob_size, fp)) {
-			printf("debug.dtb written\n");
+			dbgprintf("debug.dtb written\n");
 		} else {
-			printf("Unable to write debug.dtb\n");
+			dbgprintf("Unable to write debug.dtb\n");
 		}
 	} else {
-		printf("Unable to dump flat device tree to debug.dtb\n");
+		dbgprintf("Unable to dump flat device tree to debug.dtb\n");
 	}
 }
-#endif
 
 char *fixup_dtb_finalize(struct kexec_info *info, char *blob_buf, off_t *blob_size,
 			char *nodes[], char *cmdline)
@@ -400,9 +398,7 @@ char *fixup_dtb_finalize(struct kexec_info *info, char *blob_buf, off_t *blob_si
 	blob_buf = (char *)dt_ops.finalize();
 	*blob_size = fdt_totalsize(blob_buf);
 
-#ifdef DEBUG
 	save_fixed_up_dtb(blob_buf, *blob_size);
-#endif
 
 	return blob_buf;
 }
diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
index 733515a..cdae69e 100644
--- a/kexec/arch/ppc/fs2dt.c
+++ b/kexec/arch/ppc/fs2dt.c
@@ -273,9 +273,9 @@ static void putprops(char *fn, struct dirent **nlist, int numlist)
 			memcpy(dt, local_cmdline, cmd_len);
 			len = cmd_len;
 			*dt_len = cmd_len;
-#if	DEBUG
-			fprintf(stderr, "Modified cmdline:%s\n", local_cmdline);
-#endif
+
+			dbgprintf("Modified cmdline:%s\n", local_cmdline);
+
 		}
 
 		dt += (len + 3)/4;
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index 57852dc..6075477 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -378,9 +378,9 @@ static int get_base_ranges(void)
 	nr_memory_ranges = local_memory_ranges;
 	sort_base_ranges();
 	memory_max = base_memory_range[nr_memory_ranges - 1].end;
-#ifdef DEBUG
-	fprintf(stderr, "get base memory ranges:%d\n", nr_memory_ranges);
-#endif
+
+	dbgprintf("get base memory ranges:%d\n", nr_memory_ranges);
+
 	return 0;
 }
 
@@ -716,13 +716,13 @@ static int get_devtree_details(unsigned long kexec_flags)
 
 	sort_ranges();
 
-#ifdef DEBUG
+
 	int k;
 	for (k = 0; k < i; k++)
-		fprintf(stderr, "exclude_range sorted exclude_range[%d] "
+		dbgprintf("exclude_range sorted exclude_range[%d] "
 			"start:%llx, end:%llx\n", k, exclude_range[k].start,
 			exclude_range[k].end);
-#endif
+
 	return 0;
 
 error_openfile:
@@ -812,13 +812,12 @@ static int setup_memory_ranges(unsigned long kexec_flags)
 	} else
 		nr_memory_ranges = j;
 
-#ifdef DEBUG
+
 	int k;
 	for (k = 0; k < j; k++)
-		fprintf(stderr, "setup_memory_ranges memory_range[%d] "
+		dbgprintf("setup_memory_ranges memory_range[%d] "
 				"start:%llx, end:%llx\n", k, memory_range[k].start,
 				memory_range[k].end);
-#endif
 	return 0;
 
 out:
diff --git a/kexec/arch/ppc/libfdt-wrapper.c b/kexec/arch/ppc/libfdt-wrapper.c
index f56ccc0..5fbd3a8 100644
--- a/kexec/arch/ppc/libfdt-wrapper.c
+++ b/kexec/arch/ppc/libfdt-wrapper.c
@@ -27,15 +27,15 @@
 #include <page.h>
 #include <libfdt.h>
 #include "ops.h"
+#include "../../kexec.h"
 
-#define DEBUG	0
 #define BAD_ERROR(err)	(((err) < 0) \
 			 && ((err) != -FDT_ERR_NOTFOUND) \
 			 && ((err) != -FDT_ERR_EXISTS))
 
 #define check_err(err) \
 	({ \
-		if (BAD_ERROR(err) || ((err < 0) && DEBUG)) \
+		if (BAD_ERROR(err) || ((err < 0) && kexec_debug)) \
 			printf("%s():%d  %s\n\r", __func__, __LINE__, \
 			       fdt_strerror(err)); \
 		if (BAD_ERROR(err)) \
diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index b5ec2c8..30ef443 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -304,15 +304,15 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 
 	*range = crash_memory_range;
 	*ranges = memory_ranges;
-#if DEBUG
+
 	int j;
-	printf("CRASH MEMORY RANGES\n");
+	dbgprintf("CRASH MEMORY RANGES\n");
 	for(j = 0; j < *ranges; j++) {
 		start = crash_memory_range[j].start;
 		end = crash_memory_range[j].end;
-		fprintf(stderr, "%016Lx-%016Lx\n", start, end);
+		dbgprintf("%016Lx-%016Lx\n", start, end);
 	}
-#endif
+
 	return 0;
 
 err:
@@ -367,9 +367,7 @@ static int add_cmdline_param(char *cmdline, uint64_t addr, char *cmdstr,
 	if (cmdlen > (COMMAND_LINE_SIZE - 1))
 		die("Command line overflow\n");
 	strcat(cmdline, str);
-#if DEBUG
-	fprintf(stderr, "Command line after adding elfcorehdr: %s\n", cmdline);
-#endif
+	dbgprintf("Command line after adding elfcorehdr: %s\n", cmdline);
 	return 0;
 }
 
@@ -490,10 +488,8 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size)
 	usablemem_rgns.ranges[usablemem_rgns.size].start = base;
 	usablemem_rgns.ranges[usablemem_rgns.size++].end = end;
 
-#ifdef DEBUG
-	fprintf(stderr, "usable memory rgns size:%u base:%llx size:%llx\n",
+	dbgprintf("usable memory rgns size:%u base:%llx size:%llx\n",
 		usablemem_rgns.size, base, size);
-#endif
 }
 
 int is_crashkernel_mem_reserved(void)
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index abd83dd..f68f2bc 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -294,7 +294,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 
 	/* Set debug */
 	elf_rel_set_symbol(&info->rhdr, "debug", &my_debug, sizeof(my_debug));
-#ifdef DEBUG
+
 	my_kernel = 0;
 	my_dt_offset = 0;
 	my_panic_kernel = 0;
@@ -318,19 +318,18 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 				sizeof(toc_addr));
 	elf_rel_get_symbol(&info->rhdr, "debug", &my_debug, sizeof(my_debug));
 
-	fprintf(stderr, "info->entry is %p\n", info->entry);
-	fprintf(stderr, "kernel is %llx\n", (unsigned long long)my_kernel);
-	fprintf(stderr, "dt_offset is %llx\n",
+	dbgprintf("info->entry is %p\n", info->entry);
+	dbgprintf("kernel is %llx\n", (unsigned long long)my_kernel);
+	dbgprintf("dt_offset is %llx\n",
 		(unsigned long long)my_dt_offset);
-	fprintf(stderr, "run_at_load flag is %x\n", my_run_at_load);
-	fprintf(stderr, "panic_kernel is %x\n", my_panic_kernel);
-	fprintf(stderr, "backup_start is %llx\n",
+	dbgprintf("run_at_load flag is %x\n", my_run_at_load);
+	dbgprintf("panic_kernel is %x\n", my_panic_kernel);
+	dbgprintf("backup_start is %llx\n",
 		(unsigned long long)my_backup_start);
-	fprintf(stderr, "stack is %llx\n", (unsigned long long)my_stack);
-	fprintf(stderr, "toc_addr is %llx\n", (unsigned long long)toc_addr);
-	fprintf(stderr, "purgatory size is %zu\n", purgatory_size);
-	fprintf(stderr, "debug is %d\n", my_debug);
-#endif
+	dbgprintf("stack is %llx\n", (unsigned long long)my_stack);
+	dbgprintf("toc_addr is %llx\n", (unsigned long long)toc_addr);
+	dbgprintf("purgatory size is %zu\n", purgatory_size);
+	dbgprintf("debug is %d\n", my_debug);
 
 	for (i = 0; i < info->nr_segments; i++)
 		fprintf(stderr, "segment[%d].mem:%p memsz:%zu\n", i,
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 48ea421..2f12907 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -594,13 +594,12 @@ static int get_devtree_details(unsigned long kexec_flags)
 
 	sort_ranges();
 
-#ifdef DEBUG
 	int k;
 	for (k = 0; k < i; k++)
-		fprintf(stderr, "exclude_range sorted exclude_range[%d] "
+		dbgprintf("exclude_range sorted exclude_range[%d] "
 			"start:%llx, end:%llx\n", k, exclude_range[k].start,
 			exclude_range[k].end);
-#endif
+
 	return 0;
 
 error_openfile:
@@ -687,13 +686,11 @@ int setup_memory_ranges(unsigned long kexec_flags)
 	}
 	nr_memory_ranges = j;
 
-#ifdef DEBUG
 	int k;
 	for (k = 0; k < j; k++)
-		fprintf(stderr, "setup_memory_ranges memory_range[%d] "
+		dbgprintf("setup_memory_ranges memory_range[%d] "
 			"start:%llx, end:%llx\n", k, memory_range[k].start,
 			memory_range[k].end);
-#endif
 	return 0;
 
 out:

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

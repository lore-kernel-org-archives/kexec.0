Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JUGBt-0003V8-MY
	for kexec@lists.infradead.org; Wed, 27 Feb 2008 06:54:58 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id 6DF4F341C9
	for <kexec@lists.infradead.org>; Wed, 27 Feb 2008 15:54:52 +0900 (JST)
Message-Id: <20080227065342.911455134@vergenet.net>
References: <20080227065154.518014550@vergenet.net>
Date: Wed, 27 Feb 2008 15:51:56 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 2/5] kexec-tools: no machine machine to proc_iomem()
Content-Disposition: inline; filename=proc_iomem-no-machine-flag.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
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

Removes the machine parameter to proc_iomem() which is no
longer of any use.

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/arch/i386/crashdump-x86.c      |    4 ++--
 kexec/arch/i386/kexec-x86.c          |    2 +-
 kexec/arch/ia64/crashdump-ia64.c     |    4 ++--
 kexec/arch/ia64/kexec-elf-ia64.c     |    2 +-
 kexec/arch/ia64/kexec-ia64.c         |    4 +++-
 kexec/arch/ia64/kexec-iomem.c        |    4 ++--
 kexec/arch/s390/kexec-s390.c         |    2 +-
 kexec/arch/x86_64/crashdump-x86_64.c |    6 +++---
 kexec/arch/x86_64/kexec-x86_64.c     |    2 +-
 kexec/crashdump-xen.c                |    4 ++--
 kexec/kexec-iomem.c                  |   10 +++++-----
 kexec/kexec.h                        |    6 +++---
 12 files changed, 26 insertions(+), 24 deletions(-)

Index: kexec-tools-testing-ia64-xen/kexec/arch/ia64/kexec-elf-ia64.c
===================================================================
--- kexec-tools-testing-ia64-xen.orig/kexec/arch/ia64/kexec-elf-ia64.c	2008-02-26 16:17:38.000000000 +0900
+++ kexec-tools-testing-ia64-xen/kexec/arch/ia64/kexec-elf-ia64.c	2008-02-26 16:18:47.000000000 +0900
@@ -195,7 +195,7 @@ int elf_ia64_load(int argc, char **argv,
 	if (info->kexec_flags & KEXEC_ON_CRASH ) {
 		if ((mem_min == 0x00) && (mem_max == ULONG_MAX)) {
 			fprintf(stderr, "Failed to find crash kernel region "
-				"in %s\n", proc_iomem(1));
+				"in %s\n", proc_iomem());
 			free_elf_info(&ehdr);
 			return -1;
 		}
Index: kexec-tools-testing-ia64-xen/kexec/arch/i386/crashdump-x86.c
===================================================================
--- kexec-tools-testing-ia64-xen.orig/kexec/arch/i386/crashdump-x86.c	2008-02-26 16:17:38.000000000 +0900
+++ kexec-tools-testing-ia64-xen/kexec/arch/i386/crashdump-x86.c	2008-02-26 16:18:47.000000000 +0900
@@ -59,7 +59,7 @@ static struct memory_range crash_reserve
  */
 static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 {
-	const char *iomem = proc_iomem(1);
+	const char *iomem = proc_iomem();
 	int memory_ranges = 0;
 	char line[MAX_LINE];
 	FILE *fp;
@@ -582,6 +582,6 @@ int is_crashkernel_mem_reserved(void)
 {
 	uint64_t start, end;
 
-	return parse_iomem_single("Crash kernel\n", 1, &start, &end) == 0 ?
+	return parse_iomem_single("Crash kernel\n", &start, &end) == 0 ?
 	  (start != end) : 0;
 }
Index: kexec-tools-testing-ia64-xen/kexec/arch/i386/kexec-x86.c
===================================================================
--- kexec-tools-testing-ia64-xen.orig/kexec/arch/i386/kexec-x86.c	2008-02-26 16:17:38.000000000 +0900
+++ kexec-tools-testing-ia64-xen/kexec/arch/i386/kexec-x86.c	2008-02-26 16:18:47.000000000 +0900
@@ -39,7 +39,7 @@ static struct memory_range memory_range[
 int get_memory_ranges(struct memory_range **range, int *ranges,
 				unsigned long kexec_flags)
 {
-	const char *iomem= proc_iomem(kexec_flags & KEXEC_ON_CRASH);
+	const char *iomem= proc_iomem();
 	int memory_ranges = 0;
 	char line[MAX_LINE];
 	FILE *fp;
Index: kexec-tools-testing-ia64-xen/kexec/arch/ia64/crashdump-ia64.c
===================================================================
--- kexec-tools-testing-ia64-xen.orig/kexec/arch/ia64/crashdump-ia64.c	2008-02-26 16:17:38.000000000 +0900
+++ kexec-tools-testing-ia64-xen/kexec/arch/ia64/crashdump-ia64.c	2008-02-26 16:18:47.000000000 +0900
@@ -143,7 +143,7 @@ static int exclude_crash_reserve_region(
 
 static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 {
-	const char *iomem = proc_iomem(1);
+	const char *iomem = proc_iomem();
         char line[MAX_LINE];
         FILE *fp;
         unsigned long start, end;
@@ -262,6 +262,6 @@ int is_crashkernel_mem_reserved(void)
 {
 	uint64_t start, end;
 
-	return parse_iomem_single("Crash kernel\n", 1, &start,
+	return parse_iomem_single("Crash kernel\n", &start,
 				  &end) == 0 ?  (start != end) : 0;
 }
Index: kexec-tools-testing-ia64-xen/kexec/arch/ia64/kexec-ia64.c
===================================================================
--- kexec-tools-testing-ia64-xen.orig/kexec/arch/ia64/kexec-ia64.c	2008-02-26 16:17:38.000000000 +0900
+++ kexec-tools-testing-ia64-xen/kexec/arch/ia64/kexec-ia64.c	2008-02-26 16:18:47.000000000 +0900
@@ -80,7 +80,7 @@ static int split_range(int range, unsign
 int get_memory_ranges(struct memory_range **range, int *ranges,
 				unsigned long kexec_flags)
 {
-	const char *iomem = proc_iomem(kexec_flags & KEXEC_ON_CRASH);
+	const char *iomem = proc_iomem();
 	char line[MAX_LINE];
 	FILE *fp;
 	fp = fopen(iomem, "r");
@@ -134,9 +134,11 @@ int get_memory_ranges(struct memory_rang
 			}
 			continue;
 		} else if (memcmp(str, "Boot parameter\n", 14) == 0) {
+			printf("Boot parameter\n");
 			memory_ranges = split_range(memory_ranges, start, end);
 			continue;
 		} else if (memcmp(str, "EFI Memory Map\n", 14) == 0) {
+			printf("EFI Memory Map\n");
 			memory_ranges = split_range(memory_ranges, start, end);
 			saved_efi_memmap_size = end - start;
 			continue;
Index: kexec-tools-testing-ia64-xen/kexec/arch/ia64/kexec-iomem.c
===================================================================
--- kexec-tools-testing-ia64-xen.orig/kexec/arch/ia64/kexec-iomem.c	2008-02-26 16:17:38.000000000 +0900
+++ kexec-tools-testing-ia64-xen/kexec/arch/ia64/kexec-iomem.c	2008-02-26 16:20:22.000000000 +0900
@@ -13,9 +13,9 @@ static const char proc_iomem_machine_str
  * If Xen is in use, then /proc/iomem is used for memory regions relating
  * to the currently running dom0 kernel, and /proc/iomem_machine is used
  * for regions relating to the machine itself or the hypervisor.
- * If Xen is not in used, then /proc/iomem is always used.
+ * If Xen is not in used, then /proc/iomem used.
  */
-const char *proc_iomem(int machine)
+const char *proc_iomem(void)
 {
 	if (xen_present())
 		return proc_iomem_machine_str;
Index: kexec-tools-testing-ia64-xen/kexec/arch/s390/kexec-s390.c
===================================================================
--- kexec-tools-testing-ia64-xen.orig/kexec/arch/s390/kexec-s390.c	2008-02-26 16:17:38.000000000 +0900
+++ kexec-tools-testing-ia64-xen/kexec/arch/s390/kexec-s390.c	2008-02-26 16:18:47.000000000 +0900
@@ -40,7 +40,7 @@ static struct memory_range memory_range[
 int get_memory_ranges(struct memory_range **range, int *ranges, unsigned long flags)
 {
 	char sys_ram[] = "System RAM\n";
-	char *iomem = proc_iomem(flags & KEXEC_ON_CRASH);
+	char *iomem = proc_iomem();
 	FILE *fp;
 	char line[80];
 	int current_range = 0;
Index: kexec-tools-testing-ia64-xen/kexec/arch/x86_64/crashdump-x86_64.c
===================================================================
--- kexec-tools-testing-ia64-xen.orig/kexec/arch/x86_64/crashdump-x86_64.c	2008-02-26 16:17:38.000000000 +0900
+++ kexec-tools-testing-ia64-xen/kexec/arch/x86_64/crashdump-x86_64.c	2008-02-26 16:18:47.000000000 +0900
@@ -61,7 +61,7 @@ static int get_kernel_paddr(struct kexec
 	if (xen_present()) /* Kernel not entity mapped under Xen */
 		return 0;
 
-	if (parse_iomem_single("Kernel code\n", 0, &start, NULL) == 0) {
+	if (parse_iomem_single("Kernel code\n", &start, NULL) == 0) {
 		info->kern_paddr_start = start;
 #ifdef DEBUG
 		printf("kernel load physical addr start = 0x%016Lx\n", start);
@@ -164,7 +164,7 @@ static struct memory_range crash_reserve
  */
 static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 {
-	const char *iomem= proc_iomem(1);
+	const char *iomem= proc_iomem();
 	int memory_ranges = 0;
 	char line[MAX_LINE];
 	FILE *fp;
@@ -642,6 +642,6 @@ int is_crashkernel_mem_reserved(void)
 {
 	uint64_t start, end;
 
-	return parse_iomem_single("Crash kernel\n", 1, &start, &end) == 0 ?
+	return parse_iomem_single("Crash kernel\n", &start, &end) == 0 ?
 	  (start != end) : 0;
 }
Index: kexec-tools-testing-ia64-xen/kexec/arch/x86_64/kexec-x86_64.c
===================================================================
--- kexec-tools-testing-ia64-xen.orig/kexec/arch/x86_64/kexec-x86_64.c	2008-02-26 16:17:38.000000000 +0900
+++ kexec-tools-testing-ia64-xen/kexec/arch/x86_64/kexec-x86_64.c	2008-02-26 16:18:47.000000000 +0900
@@ -40,7 +40,7 @@ static struct memory_range memory_range[
 int get_memory_ranges(struct memory_range **range, int *ranges,
 					unsigned long kexec_flags)
 {
-	const char *iomem= proc_iomem(kexec_flags & KEXEC_ON_CRASH);
+	const char *iomem= proc_iomem();
 	int memory_ranges = 0;
 	char line[MAX_LINE];
 	FILE *fp;
Index: kexec-tools-testing-ia64-xen/kexec/crashdump-xen.c
===================================================================
--- kexec-tools-testing-ia64-xen.orig/kexec/crashdump-xen.c	2008-02-26 16:17:38.000000000 +0900
+++ kexec-tools-testing-ia64-xen/kexec/crashdump-xen.c	2008-02-26 16:18:47.000000000 +0900
@@ -93,7 +93,7 @@ int xen_get_nr_phys_cpus(void)
 	if (xen_phys_cpus)
 		return xen_phys_cpus;
 
-	if ((cpus = kexec_iomem_for_each_line(match, 1, NULL, NULL))) {
+	if ((cpus = kexec_iomem_for_each_line(match, NULL, NULL))) {
 		n = sizeof(struct crash_note_info) * cpus;
 		xen_phys_notes = malloc(n);
 		if (!xen_phys_notes) {
@@ -101,7 +101,7 @@ int xen_get_nr_phys_cpus(void)
 			return -1;
 		}
 		memset(xen_phys_notes, 0, n);
-		kexec_iomem_for_each_line(match, 1,
+		kexec_iomem_for_each_line(match,
 					  xen_crash_note_callback, NULL);
 		xen_phys_cpus = cpus;
 	}
Index: kexec-tools-testing-ia64-xen/kexec/kexec-iomem.c
===================================================================
--- kexec-tools-testing-ia64-xen.orig/kexec/kexec-iomem.c	2008-02-26 16:17:38.000000000 +0900
+++ kexec-tools-testing-ia64-xen/kexec/kexec-iomem.c	2008-02-26 16:20:18.000000000 +0900
@@ -22,7 +22,7 @@
  * Return the number of lines matched.
  */
 
-int kexec_iomem_for_each_line(char *match, int machine,
+int kexec_iomem_for_each_line(char *match,
 			      int (*callback)(void *data,
 					      int nr,
 					      char *str,
@@ -30,7 +30,7 @@ int kexec_iomem_for_each_line(char *matc
 					      unsigned long length),
 			      void *data)
 {
-	const char *iomem = proc_iomem(machine);
+	const char *iomem = proc_iomem();
 	char line[MAX_LINE];
 	FILE *fp;
 	unsigned long long start, end, size;
@@ -78,14 +78,14 @@ static int kexec_iomem_single_callback(v
 	return 0;
 }
 
-int parse_iomem_single(char *str, int machine, uint64_t *start, uint64_t *end)
+int parse_iomem_single(char *str, uint64_t *start, uint64_t *end)
 {
 	struct memory_range range;
 	int ret;
 
 	memset(&range, 0, sizeof(range));
 
-	ret = kexec_iomem_for_each_line(str, machine,
+	ret = kexec_iomem_for_each_line(str,
 	                                kexec_iomem_single_callback, &range);
 
 	if (ret == 1) {
@@ -109,7 +109,7 @@ static const char proc_iomem_str[]= "/pr
  * function to override the location of a file looking a lot
  * like /proc/iomem
  */
-const char * __attribute__((weak)) proc_iomem(int machine)
+const char * __attribute__((weak)) proc_iomem(void)
 {
         return proc_iomem_str;
 }
Index: kexec-tools-testing-ia64-xen/kexec/kexec.h
===================================================================
--- kexec-tools-testing-ia64-xen.orig/kexec/kexec.h	2008-02-26 16:17:38.000000000 +0900
+++ kexec-tools-testing-ia64-xen/kexec/kexec.h	2008-02-26 16:18:47.000000000 +0900
@@ -207,15 +207,15 @@ int arch_compat_trampoline(struct kexec_
 void arch_update_purgatory(struct kexec_info *info);
 int is_crashkernel_mem_reserved(void);
 
-int kexec_iomem_for_each_line(char *match, int machine,
+int kexec_iomem_for_each_line(char *match,
 			      int (*callback)(void *data,
 					      int nr,
 					      char *str,
 					      unsigned long base,
 					      unsigned long length),
 			      void *data);
-int parse_iomem_single(char *str, int machine, uint64_t *start, uint64_t *end);
-const char * proc_iomem(int machine);
+int parse_iomem_single(char *str, uint64_t *start, uint64_t *end);
+const char * proc_iomem(void);
 
 #define MAX_LINE	160
 

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

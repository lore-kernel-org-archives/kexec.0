Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from lvk-gate.cs.msu.ru ([188.44.42.233] helo=mail.lvk.cs.msu.su)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WLpPA-0003ZQ-LS
 for kexec@lists.infradead.org; Fri, 07 Mar 2014 07:41:18 +0000
From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
Subject: [PATCH] kexec/ppc: cleanup crash regions creation
Date: Fri,  7 Mar 2014 11:40:33 +0400
Message-Id: <1394178033-501-1-git-send-email-nyushchenko@dev.rtsoft.ru>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: yadviga@dev.rtsoft.ru, nyushchenko@dev.rtsoft.ru, lugovskoy@dev.rtsoft.ru

Move filling crash_memory_range table entries into a separate routine,
which saves quite a few lines of code.

In this routine, if range spawns over lowmem-highmem border, split range
into two. This is needed to get proper virtual address for lowmem part.
Similar thing is already done for x86. Credits to Yadviga Grigorieva
<yadviga@dev.rtsoft.ru> for tracking down this issue for ppc.

Also this patch makes excluding crash kernel regoin a bit shorter, and
removes unused variable to get rid of compiler warning.

Signed-off-by: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
---
 kexec/arch/ppc/crashdump-powerpc.c |  108 +++++++++++++++++-------------------
 1 files changed, 51 insertions(+), 57 deletions(-)

diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index c06d310..3dc35eb 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -41,6 +41,7 @@ lowmem_limit: MAXMEM,
  * A separate program header is created for backup region
  */
 static struct memory_range *crash_memory_range;
+static int crash_nr_memory_ranges;
 
 /* Define a variable to replace the CRASH_MAX_MEMORY_RANGES macro */
 static int crash_max_memory_ranges;
@@ -51,6 +52,29 @@ static int crash_max_memory_ranges;
  */
 mem_rgns_t usablemem_rgns = {0, NULL};
 
+/* Append a segment to crash_memory_range, splitting it into two if
+ * it contains both lowmem and highmem */
+static void add_crash_memory_range(unsigned long long start,
+		unsigned long long end)
+{
+#ifndef CONFIG_PPC64
+	if (start < elf_info32.lowmem_limit && end > elf_info32.lowmem_limit) {
+		add_crash_memory_range(start, elf_info32.lowmem_limit);
+		add_crash_memory_range(elf_info32.lowmem_limit, end);
+		return;
+	}
+#endif
+
+	if (crash_nr_memory_ranges < crash_max_memory_ranges) {
+		crash_memory_range[crash_nr_memory_ranges].start = start;
+		crash_memory_range[crash_nr_memory_ranges].end = end;
+		crash_memory_range[crash_nr_memory_ranges].type = RANGE_RAM;
+	}
+
+	crash_nr_memory_ranges++;
+}
+
+
 /* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom to
  * create Elf headers. Keeping it separate from get_memory_ranges() as
  * requirements are different in the case of normal kexec and crashdumps.
@@ -65,13 +89,12 @@ mem_rgns_t usablemem_rgns = {0, NULL};
 static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 {
 
-	int memory_ranges = 0;
 	char device_tree[256] = "/proc/device-tree/";
 	char fname[256];
 	DIR *dir, *dmem;
 	int fd;
 	struct dirent *dentry, *mentry;
-	int i, n, crash_rng_len = 0;
+	int n, crash_rng_len = 0;
 	unsigned long long start, end, cstart, cend;
 
 	crash_max_memory_ranges = max_memory_ranges + 6;
@@ -83,13 +106,11 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 		return -1;
 	}
 	memset(crash_memory_range, 0, crash_rng_len);
+	crash_nr_memory_ranges = 0;
 
 #ifndef CONFIG_BOOKE
 	/* create a separate program header for the backup region */
-	crash_memory_range[0].start = BACKUP_SRC_START;
-	crash_memory_range[0].end = BACKUP_SRC_END + 1;
-	crash_memory_range[0].type = RANGE_RAM;
-	memory_ranges++;
+	add_crash_memory_range(BACKUP_SRC_START, BACKUP_SRC_END + 1);
 #endif
 
 	dir = opendir(device_tree);
@@ -128,70 +149,37 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 				closedir(dir);
 				goto err;
 			}
-			if (memory_ranges >= (max_memory_ranges + 1)) {
-				/* No space to insert another element. */
-				fprintf(stderr,
-					"Error: Number of crash memory ranges"
-					" excedeed the max limit\n");
-				goto err;
-			}
 #ifndef CONFIG_BOOKE
 			if (start == 0 && end >= (BACKUP_SRC_END + 1))
 				start = BACKUP_SRC_END + 1;
 #endif
 
-			cstart = crash_base;
-			cend = crash_base + crash_size;
 			/*
 			 * Exclude the region that lies within crashkernel.
 			 * If memory limit is set then exclude memory region
 			 * above it.
 			 */
+
 			if (memory_limit) {
 				if (start >= memory_limit)
 					continue;
 				if (end > memory_limit)
 					end = memory_limit;
 			}
-			if (cstart < end && cend > start) {
-				if (start < cstart && end > cend) {
-					crash_memory_range[memory_ranges].start
-						= start;
-					crash_memory_range[memory_ranges].end
-						= cstart;
-					crash_memory_range[memory_ranges].type
-						= RANGE_RAM;
-					memory_ranges++;
-					crash_memory_range[memory_ranges].start
-						= cend;
-					crash_memory_range[memory_ranges].end
-						= end;
-					crash_memory_range[memory_ranges].type
-						= RANGE_RAM;
-					memory_ranges++;
-				} else if (start < cstart) {
-					crash_memory_range[memory_ranges].start
-						= start;
-					crash_memory_range[memory_ranges].end
-						= cstart;
-					crash_memory_range[memory_ranges].type
-						= RANGE_RAM;
-					memory_ranges++;
-				} else if (end > cend) {
-					crash_memory_range[memory_ranges].start
-						= cend;
-					crash_memory_range[memory_ranges].end
-						= end;
-					crash_memory_range[memory_ranges].type
-						= RANGE_RAM;
-					memory_ranges++;
-				}
-			} else {
-				crash_memory_range[memory_ranges].start = start;
-				crash_memory_range[memory_ranges].end  = end;
-				crash_memory_range[memory_ranges].type
-					= RANGE_RAM;
-				memory_ranges++;
+
+			/*
+			 * Exclure region used by crash kernel
+			 */
+			cstart = crash_base;
+			cend = crash_base + crash_size;
+
+			if (cstart >= end || cend <= start)
+				add_crash_memory_range(start, end);
+			else {
+				if (start < cstart)
+					add_crash_memory_range(start, cstart);
+				if (cend < end)
+					add_crash_memory_range(cend, end);
 			}
 		}
 		closedir(dmem);
@@ -210,12 +198,18 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 			cstart = crash_base;
 		if (cend > crash_base + crash_size)
 			cend = crash_base + crash_size;
-		crash_memory_range[memory_ranges].start = cstart;
-		crash_memory_range[memory_ranges++].end = cend;
+		add_crash_memory_range(cstart, cend);
+	}
+
+	if (crash_nr_memory_ranges >= crash_max_memory_ranges) {
+		fprintf(stderr,
+			"Error: Number of crash memory ranges"
+			" excedeed the max limit\n");
+		goto err;
 	}
 
 	*range = crash_memory_range;
-	*ranges = memory_ranges;
+	*ranges = crash_nr_memory_ranges;
 
 	int j;
 	dbgprintf("CRASH MEMORY RANGES\n");
-- 
1.7.0.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TnQxm-0006eL-PO
 for kexec@lists.infradead.org; Tue, 25 Dec 2012 09:38:22 +0000
Message-ID: <50D97377.3010209@cn.fujitsu.com>
Date: Tue, 25 Dec 2012 17:35:51 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH] kexec: use dbgprintf instead of #if 0 for debug printing
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/i386/kexec-x86-common.c |   28 ++++++++++------------------
 kexec/kexec.c                      |   18 +++++++++---------
 2 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index 02471a8..234823c 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -88,10 +88,9 @@ static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges
 			continue;
 		str = line + consumed;
 		end = end + 1;
-#if 0
-		printf("%016Lx-%016Lx : %s",
-			start, end, str);
-#endif
+
+		dbgprintf("%016Lx-%016Lx : %s", start, end, str);
+
 		if (memcmp(str, "System RAM\n", 11) == 0) {
 			type = RANGE_RAM;
 		}
@@ -110,10 +109,9 @@ static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges
 		memory_range[memory_ranges].start = start;
 		memory_range[memory_ranges].end = end;
 		memory_range[memory_ranges].type = type;
-#if 0
-		printf("%016Lx-%016Lx : %x\n",
-			start, end, type);
-#endif
+
+		dbgprintf("%016Lx-%016Lx : %x\n", start, end, type);
+
 		memory_ranges++;
 	}
 	fclose(fp);
@@ -479,17 +477,11 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 			mem_max = end;
 	}
 
-	/* just set 0 to 1 to enable printing for debugging */
-#if 0
-	{
-		int i;
-		printf("MEMORY RANGES\n");
-		for (i = 0; i < *ranges; i++) {
-			printf("%016Lx-%016Lx (%d)\n", (*range)[i].start,
-				(*range)[i].end, (*range)[i].type);
-		}
+	dbgprintf("MEMORY RANGES\n");
+	for (i = 0; i < *ranges; i++) {
+		dbgprintf("%016Lx-%016Lx (%d)\n", (*range)[i].start,
+			  (*range)[i].end, (*range)[i].type);
 	}
-#endif
 
 	return ret;
 }
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 89ec182..60ea0a5 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -669,10 +669,9 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	kernel = argv[fileind];
 	/* slurp in the input kernel */
 	kernel_buf = slurp_decompress_file(kernel, &kernel_size);
-#if 0
-	fprintf(stderr, "kernel: %p kernel_size: %lx\n", 
-		kernel_buf, kernel_size);
-#endif
+
+	dbgprintf("kernel: %p kernel_size: %lx\n",
+		  kernel_buf, kernel_size);
 
 	if (get_memory_ranges(&info.memory_range, &info.memory_ranges,
 		info.kexec_flags) < 0) {
@@ -759,11 +758,12 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	update_purgatory(&info);
 	if (entry)
 		info.entry = entry;
-#if 0
-	fprintf(stderr, "kexec_load: entry = %p flags = %lx\n", 
-		info.entry, info.kexec_flags);
-	print_segments(stderr, &info);
-#endif
+
+	dbgprintf("kexec_load: entry = %p flags = %lx\n",
+		  info.entry, info.kexec_flags);
+	if (kexec_debug)
+		print_segments(stderr, &info);
+
 	result = kexec_load(
 		info.entry, info.nr_segments, info.segment, info.kexec_flags);
 	if (result != 0) {
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

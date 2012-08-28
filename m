Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T6H0a-00073c-DC
 for kexec@lists.infradead.org; Tue, 28 Aug 2012 08:18:50 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 6/7] arm: Make use of memory_ranges
Date: Tue, 28 Aug 2012 17:18:29 +0900
Message-Id: <1346141910-8214-7-git-send-email-horms@verge.net.au>
In-Reply-To: <1346141910-8214-1-git-send-email-horms@verge.net.au>
References: <1346141910-8214-1-git-send-email-horms@verge.net.au>
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
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>

Make use of struct memory_ranges and provide a global usablemem_rgns.
This is in preparation for adding device tree support.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/arm/crashdump-arm.c | 45 ++++++++++++++++++++++++++----------------
 kexec/arch/arm/crashdump-arm.h |  2 ++
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 213dae2..01973b1 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -31,8 +31,16 @@
 #include "../../crashdump.h"
 #include "crashdump-arm.h"
 
+
+/*
+ * Used to save various memory ranges/regions needed for the captured
+ * kernel to boot. (lime memmap= option in other archs)
+ */
 static struct memory_range crash_memory_ranges[CRASH_MAX_MEMORY_RANGES];
-static int crash_memory_nr_ranges;
+struct memory_ranges usablemem_rgns = {
+    .size = 0,
+    .ranges = crash_memory_ranges,
+};
 
 /* memory range reserved for crashkernel */
 static struct memory_range crash_reserved_mem;
@@ -65,16 +73,16 @@ static int crash_range_callback(void *UNUSED(data), int UNUSED(nr),
 {
 	struct memory_range *range;
 
-	if (crash_memory_nr_ranges >= CRASH_MAX_MEMORY_RANGES)
+	if (usablemem_rgns.size >= CRASH_MAX_MEMORY_RANGES)
 		return 1;
 
-	range = &crash_memory_ranges[crash_memory_nr_ranges];
+	range = usablemem_rgns.ranges + usablemem_rgns.size;
 
 	if (strncmp(str, "System RAM\n", 11) == 0) {
 		range->start = base;
 		range->end = base + length - 1;
 		range->type = RANGE_RAM;
-		crash_memory_nr_ranges++;
+		usablemem_rgns.size++;
 	} else if (strncmp(str, "Crash kernel\n", 13) == 0) {
 		crash_reserved_mem.start = base;
 		crash_reserved_mem.end = base + length - 1;
@@ -95,22 +103,24 @@ static void crash_exclude_range(void)
 	const struct memory_range *range = &crash_reserved_mem;
 	int i;
 
-	for (i = 0; i < crash_memory_nr_ranges; i++) {
-		struct memory_range *r = &crash_memory_ranges[i];
+	for (i = 0; i < usablemem_rgns.size; i++) {
+		struct memory_range *r = usablemem_rgns.ranges + i;
 
 		/*
 		 * We assume that crash area is fully contained in
 		 * some larger memory area.
 		 */
 		if (r->start <= range->start && r->end >= range->end) {
+			struct memory_range *new;
 			/*
 			 * Let's split this area into 2 smaller ones and
 			 * remove excluded range from between. First create
 			 * new entry for the remaining area.
 			 */
-			crash_memory_ranges[crash_memory_nr_ranges].start = range->end + 1;
-			crash_memory_ranges[crash_memory_nr_ranges].end = r->end;
-			crash_memory_nr_ranges++;
+			new = usablemem_rgns.ranges + usablemem_rgns.size;
+			new->start = range->end + 1;
+			new->end = r->end;
+			usablemem_rgns.size++;
 			/*
 			 * Next update this area to end before excluded range.
 			 */
@@ -150,7 +160,7 @@ static int crash_get_memory_ranges(void)
 	 */
 	kexec_iomem_for_each_line(NULL, crash_range_callback, NULL);
 
-	if (crash_memory_nr_ranges < 1) {
+	if (usablemem_rgns.size < 1) {
 		errno = EINVAL;
 		return -1;
 	}
@@ -164,8 +174,8 @@ static int crash_get_memory_ranges(void)
 	/*
 	 * Make sure that the memory regions are sorted.
 	 */
-	qsort(crash_memory_ranges, crash_memory_nr_ranges,
-	      sizeof(crash_memory_ranges[0]), range_cmp);
+	qsort(usablemem_rgns.ranges, usablemem_rgns.size,
+	      sizeof(*usablemem_rgns.ranges), range_cmp);
 
 	return 0;
 }
@@ -235,8 +245,8 @@ static void dump_memory_ranges(void)
 		  crash_reserved_mem.start, crash_reserved_mem.end,
 		  (unsigned long)range_size(&crash_reserved_mem) >> 20);
 
-	for (i = 0; i < crash_memory_nr_ranges; i++) {
-		struct memory_range *r = &crash_memory_ranges[i];
+	for (i = 0; i < usablemem_rgns.size; i++) {
+		struct memory_range *r = usablemem_rgns.ranges + i;
 		dbgprintf("memory range: [%#llx - %#llx] (%ldM)\n",
 			  r->start, r->end, (unsigned long)range_size(r) >> 20);
 	}
@@ -272,11 +282,12 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 	 * Now that we have memory regions sorted, we can use first memory
 	 * region as PHYS_OFFSET.
 	 */
-	phys_offset = crash_memory_ranges[0].start;
+	phys_offset = usablemem_rgns.ranges->start;
 	dbgprintf("phys_offset: %#lx\n", phys_offset);
 
-	err = crash_create_elf32_headers(info, &elf_info, crash_memory_ranges,
-					 crash_memory_nr_ranges, &buf, &bufsz,
+	err = crash_create_elf32_headers(info, &elf_info,
+					 usablemem_rgns.ranges,
+					 usablemem_rgns.size, &buf, &bufsz,
 					 ELF_CORE_HEADER_ALIGN);
 	if (err)
 		return err;
diff --git a/kexec/arch/arm/crashdump-arm.h b/kexec/arch/arm/crashdump-arm.h
index a2e7824..a342922 100644
--- a/kexec/arch/arm/crashdump-arm.h
+++ b/kexec/arch/arm/crashdump-arm.h
@@ -9,6 +9,8 @@ extern "C" {
 #define PAGE_OFFSET		0xc0000000
 #define CRASH_MAX_MEMORY_RANGES	32
 
+extern struct memory_ranges usablemem_rgns;
+
 struct kexec_info;
 
 extern unsigned long phys_offset;
-- 
1.7.10.2.484.gcd07cc5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

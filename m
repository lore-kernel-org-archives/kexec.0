Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtbj-0004DO-Lh
 for kexec@lists.infradead.org; Fri, 11 Jan 2019 10:00:14 +0000
Received: by mail-yw1-xc44.google.com with SMTP id d190so5576102ywb.5
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2019 02:00:07 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 3/3] arm64: kdump: deal with a lot of resource entries in
 /proc/iomem
Date: Fri, 11 Jan 2019 18:59:46 +0900
Message-Id: <20190111095946.28070-4-takahiro.akashi@linaro.org>
In-Reply-To: <20190111095946.28070-1-takahiro.akashi@linaro.org>
References: <20190111095946.28070-1-takahiro.akashi@linaro.org>
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
To: horms@verge.net.au, james.morse@arm.com, bhsharma@redhat.com
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org

As described in the commit ("arm64: kexec: allocate memory space avoiding
reserved regions"), /proc/iomem now has a lot of "reserved" entries, and
it's not just enough to have a fixed size of memory range array.

With this patch, kdump is allowed to handle arbitrary number of memory
ranges, using mem_regions_alloc_and_xxx() functions.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/crashdump-arm64.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 4fd7aa8fd43c..38d1a0f3000d 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -23,13 +23,8 @@
 #include "kexec-elf.h"
 #include "mem_regions.h"
 
-/* memory ranges on crashed kernel */
-static struct memory_range system_memory_ranges[CRASH_MAX_MEMORY_RANGES];
-static struct memory_ranges system_memory_rgns = {
-	.size = 0,
-	.max_size = CRASH_MAX_MEMORY_RANGES,
-	.ranges = system_memory_ranges,
-};
+/* memory ranges of crashed kernel */
+static struct memory_ranges system_memory_rgns;
 
 /* memory range reserved for crashkernel */
 struct memory_range crash_reserved_mem;
@@ -82,7 +77,7 @@ static uint64_t get_kernel_page_offset(void)
  *
  * This function is called once for each memory region found in /proc/iomem.
  * It locates system RAM and crashkernel reserved memory and places these to
- * variables, respectively, system_memory_ranges and crash_reserved_mem.
+ * variables, respectively, system_memory_rgns and usablemem_rgns.
  */
 
 static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
@@ -90,11 +85,11 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
 				unsigned long long length)
 {
 	if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0)
-		return mem_regions_add(&usablemem_rgns,
-				       base, length, RANGE_RAM);
+		return mem_regions_alloc_and_add(&usablemem_rgns,
+						base, length, RANGE_RAM);
 	else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0)
-		return mem_regions_add(&system_memory_rgns,
-				       base, length, RANGE_RAM);
+		return mem_regions_alloc_and_add(&system_memory_rgns,
+						base, length, RANGE_RAM);
 	else if (strncmp(str, KERNEL_CODE, strlen(KERNEL_CODE)) == 0)
 		elf_info.kern_paddr_start = base;
 	else if (strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)) == 0)
@@ -135,9 +130,9 @@ static int crash_get_memory_ranges(void)
 
 	dbgprint_mem_range("Reserved memory range", &crash_reserved_mem, 1);
 
-	if (mem_regions_exclude(&system_memory_rgns, &crash_reserved_mem)) {
-		fprintf(stderr,
-			"Error: Number of crash memory ranges excedeed the max limit\n");
+	if (mem_regions_alloc_and_exclude(&system_memory_rgns,
+						&crash_reserved_mem)) {
+		fprintf(stderr, "Cannot allocate memory for ranges\n");
 		return -ENOMEM;
 	}
 
-- 
2.19.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

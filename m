From: Zhen Lei <thunder.leizhen@huawei.com>
Date: Mon, 10 Jan 2022 18:20:08 +0800
Subject: [PATCH v5] arm64: support more than one crash kernel regions
Message-ID: <20220110102008.502-1-thunder.leizhen@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

From: Chen Zhou <chenzhou10@huawei.com>

When crashkernel is reserved above 4G in memory, kernel should
reserve some amount of low memory for swiotlb and some DMA buffers.
So there may be two crash kernel regions, one is below 4G, the other
is above 4G.

Currently, there is only one crash kernel region on arm64, and pass
"linux,usable-memory-range = <BASE SIZE>" property to crash dump
kernel.
Now, we pass "linux,usable-memory-range = <BASE1 SIZE1 BASE2 SIZE2>"
to crash dump kernel to support two crash kernel regions and load crash
kernel high. Make the low memory region as the second range "BASE2 SIZE2"
to keep compatibility with existing user-space and older kdump kernels.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kexec/arch/arm64/crashdump-arm64.c | 44 +++++++++-------
 kexec/arch/arm64/crashdump-arm64.h |  5 +-
 kexec/arch/arm64/kexec-arm64.c     | 84 ++++++++++++++++++++----------
 3 files changed, 86 insertions(+), 47 deletions(-)


Changes since [v4]:
1. Repalce "Crash kernel (low)" with "Crash kernel", consistent with the
   x86 implementation. See:
   e25e6e7593ca ("kdump, x86: Process multiple Crash kernel in /proc/iomem")
2. Expand fdt_setprop_range() to fdt_setprop_ranges() instead of adding the
   latter. Parameter 'reverse' is added to control whether to reversely
   output data to fdt.

Changes since [v3]:
- Reuse DT property "linux,usable-memory-range".
Reuse DT property "linux,usable-memory-range" to pass the low 
memory region.

Changes since [v2]:
- Rebase to latest kexec-tools code.

Changes since [v1]:
- Add another DT property "linux,low-memory-range" to crash dump kernel's
dtb to pass the low region instead of reusing "linux,usable-memory-range".

[1]: http://lists.infradead.org/pipermail/kexec/2019-April/022792.html
[2]: http://lists.infradead.org/pipermail/kexec/2019-August/023569.html
[3]: http://lists.infradead.org/pipermail/kexec/2020-May/025128.html
[4]: http://lists.infradead.org/pipermail/kexec/2020-June/020737.html

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 03d6204c9611dab..8558f260dc2b6b4 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -27,11 +27,11 @@
 static struct memory_ranges system_memory_rgns;
 
 /* memory range reserved for crashkernel */
-struct memory_range crash_reserved_mem;
+struct memory_range crash_reserved_mem[CRASH_MAX_RESERVED_RANGES];
 struct memory_ranges usablemem_rgns = {
 	.size = 0,
-	.max_size = 1,
-	.ranges = &crash_reserved_mem,
+	.max_size = CRASH_MAX_RESERVED_RANGES,
+	.ranges = crash_reserved_mem,
 };
 
 struct memory_range elfcorehdr_mem;
@@ -111,7 +111,7 @@ int is_crashkernel_mem_reserved(void)
 	if (!usablemem_rgns.size)
 		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
 
-	return crash_reserved_mem.start != crash_reserved_mem.end;
+	return usablemem_rgns.size;
 }
 
 /*
@@ -125,6 +125,8 @@ int is_crashkernel_mem_reserved(void)
  */
 static int crash_get_memory_ranges(void)
 {
+	int i;
+
 	/*
 	 * First read all memory regions that can be considered as
 	 * system memory including the crash area.
@@ -132,16 +134,19 @@ static int crash_get_memory_ranges(void)
 	if (!usablemem_rgns.size)
 		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
 
-	/* allow only a single region for crash dump kernel */
-	if (usablemem_rgns.size != 1)
+	/* allow one or two regions for crash dump kernel */
+	if (!usablemem_rgns.size)
 		return -EINVAL;
 
-	dbgprint_mem_range("Reserved memory range", &crash_reserved_mem, 1);
+	dbgprint_mem_range("Reserved memory range",
+			usablemem_rgns.ranges, usablemem_rgns.size);
 
-	if (mem_regions_alloc_and_exclude(&system_memory_rgns,
-						&crash_reserved_mem)) {
-		fprintf(stderr, "Cannot allocate memory for ranges\n");
-		return -ENOMEM;
+	for (i = 0; i < usablemem_rgns.size; i++) {
+		if (mem_regions_alloc_and_exclude(&system_memory_rgns,
+					&crash_reserved_mem[i])) {
+			fprintf(stderr, "Cannot allocate memory for ranges\n");
+			return -ENOMEM;
+		}
 	}
 
 	/*
@@ -202,7 +207,8 @@ int load_crashdump_segments(struct kexec_info *info)
 		return EFAILED;
 
 	elfcorehdr = add_buffer_phys_virt(info, buf, bufsz, bufsz, 0,
-		crash_reserved_mem.start, crash_reserved_mem.end,
+		crash_reserved_mem[usablemem_rgns.size - 1].start,
+		crash_reserved_mem[usablemem_rgns.size - 1].end,
 		-1, 0);
 
 	elfcorehdr_mem.start = elfcorehdr;
@@ -220,21 +226,23 @@ int load_crashdump_segments(struct kexec_info *info)
  * virt_to_phys() in add_segment().
  * So let's fix up those values for later use so the memory base
  * (arm64_mm.phys_offset) will be correctly replaced with
- * crash_reserved_mem.start.
+ * crash_reserved_mem[usablemem_rgns.size - 1].start.
  */
 void fixup_elf_addrs(struct mem_ehdr *ehdr)
 {
 	struct mem_phdr *phdr;
 	int i;
 
-	ehdr->e_entry += - arm64_mem.phys_offset + crash_reserved_mem.start;
+	ehdr->e_entry += -arm64_mem.phys_offset +
+		crash_reserved_mem[usablemem_rgns.size - 1].start;
 
 	for (i = 0; i < ehdr->e_phnum; i++) {
 		phdr = &ehdr->e_phdr[i];
 		if (phdr->p_type != PT_LOAD)
 			continue;
 		phdr->p_paddr +=
-			(-arm64_mem.phys_offset + crash_reserved_mem.start);
+			(-arm64_mem.phys_offset +
+			 crash_reserved_mem[usablemem_rgns.size - 1].start);
 	}
 }
 
@@ -243,11 +251,11 @@ int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
 	if (!usablemem_rgns.size)
 		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
 
-	if (!crash_reserved_mem.end)
+	if (!usablemem_rgns.size)
 		return -1;
 
-	*start = crash_reserved_mem.start;
-	*end = crash_reserved_mem.end;
+	*start = crash_reserved_mem[usablemem_rgns.size - 1].start;
+	*end = crash_reserved_mem[usablemem_rgns.size - 1].end;
 
 	return 0;
 }
diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
index 880b83aa3d0f80f..12f43087d8b32bf 100644
--- a/kexec/arch/arm64/crashdump-arm64.h
+++ b/kexec/arch/arm64/crashdump-arm64.h
@@ -16,8 +16,11 @@
 
 #define CRASH_MAX_MEMORY_RANGES	32
 
+/* crash dump kernel support at most two regions, low_region and high region. */
+#define CRASH_MAX_RESERVED_RANGES	2
+
 extern struct memory_ranges usablemem_rgns;
-extern struct memory_range crash_reserved_mem;
+extern struct memory_range crash_reserved_mem[];
 extern struct memory_range elfcorehdr_mem;
 
 extern int load_crashdump_segments(struct kexec_info *info);
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 6f572ed5f7daad8..44ca3dba10baf36 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -456,22 +456,32 @@ static void fill_property(void *buf, uint64_t val, uint32_t cells)
 	}
 }
 
-static int fdt_setprop_range(void *fdt, int nodeoffset,
-				const char *name, struct memory_range *range,
+static int fdt_setprop_ranges(void *fdt, int nodeoffset, const char *name,
+				struct memory_range *ranges, int nr_ranges, bool reverse,
 				uint32_t address_cells, uint32_t size_cells)
 {
 	void *buf, *prop;
 	size_t buf_size;
-	int result;
+	int i, result;
+	struct memory_range *range;
 
-	buf_size = (address_cells + size_cells) * sizeof(uint32_t);
+	buf_size = (address_cells + size_cells) * sizeof(uint32_t) * nr_ranges;
 	prop = buf = xmalloc(buf_size);
+	if (!buf)
+		return -ENOMEM;
 
-	fill_property(prop, range->start, address_cells);
-	prop += address_cells * sizeof(uint32_t);
+	for (i = 0; i < nr_ranges; i++) {
+		if (reverse)
+			range = ranges + (nr_ranges - 1 - i);
+		else
+			range = ranges + i;
 
-	fill_property(prop, range->end - range->start + 1, size_cells);
-	prop += size_cells * sizeof(uint32_t);
+		fill_property(prop, range->start, address_cells);
+		prop += address_cells * sizeof(uint32_t);
+
+		fill_property(prop, range->end - range->start + 1, size_cells);
+		prop += size_cells * sizeof(uint32_t);
+	}
 
 	result = fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
 
@@ -493,7 +503,7 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 	int len, range_len;
 	int nodeoffset;
 	int new_size;
-	int result, kaslr_seed;
+	int i, result, kaslr_seed;
 
 	result = fdt_check_header(dtb->buf);
 
@@ -524,18 +534,20 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 		goto on_error;
 	}
 
-	if (!cells_size_fitted(address_cells, size_cells,
-				&crash_reserved_mem)) {
-		fprintf(stderr, "kexec: usable memory range doesn't fit cells-size.\n");
-		result = -EINVAL;
-		goto on_error;
+	for (i = 0; i < usablemem_rgns.size; i++) {
+		if (!cells_size_fitted(address_cells, size_cells,
+					&crash_reserved_mem[i])) {
+			fprintf(stderr, "kexec: usable memory range doesn't fit cells-size.\n");
+			result = -EINVAL;
+			goto on_error;
+		}
 	}
 
 	/* duplicate dt blob */
 	range_len = sizeof(uint32_t) * (address_cells + size_cells);
 	new_size = fdt_totalsize(dtb->buf)
 		+ fdt_prop_len(PROP_ELFCOREHDR, range_len)
-		+ fdt_prop_len(PROP_USABLE_MEM_RANGE, range_len);
+		+ fdt_prop_len(PROP_USABLE_MEM_RANGE, range_len * usablemem_rgns.size);
 
 	new_buf = xmalloc(new_size);
 	result = fdt_open_into(dtb->buf, new_buf, new_size);
@@ -619,8 +631,8 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 	if (on_crash) {
 		/* add linux,elfcorehdr */
 		nodeoffset = fdt_path_offset(new_buf, "/chosen");
-		result = fdt_setprop_range(new_buf, nodeoffset,
-				PROP_ELFCOREHDR, &elfcorehdr_mem,
+		result = fdt_setprop_ranges(new_buf, nodeoffset,
+				PROP_ELFCOREHDR, &elfcorehdr_mem, 1, false,
 				address_cells, size_cells);
 		if (result) {
 			dbgprintf("%s: fdt_setprop failed: %s\n", __func__,
@@ -629,10 +641,17 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 			goto on_error;
 		}
 
-		/* add linux,usable-memory-range */
+		/*
+		 * add linux,usable-memory-range
+		 *
+		 * crash dump kernel support one or two regions, to make
+		 * compatibility with existing user-space and older kdump, the
+		 * low region is always the last one.
+		 */
 		nodeoffset = fdt_path_offset(new_buf, "/chosen");
-		result = fdt_setprop_range(new_buf, nodeoffset,
-				PROP_USABLE_MEM_RANGE, &crash_reserved_mem,
+		result = fdt_setprop_ranges(new_buf, nodeoffset,
+				PROP_USABLE_MEM_RANGE,
+				usablemem_rgns.ranges, usablemem_rgns.size, true,
 				address_cells, size_cells);
 		if (result) {
 			dbgprintf("%s: fdt_setprop failed: %s\n", __func__,
@@ -665,13 +684,13 @@ unsigned long arm64_locate_kernel_segment(struct kexec_info *info)
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		unsigned long hole_end;
 
-		hole = (crash_reserved_mem.start < mem_min ?
-				mem_min : crash_reserved_mem.start);
+		hole = (crash_reserved_mem[usablemem_rgns.size - 1].start < mem_min ?
+				mem_min : crash_reserved_mem[usablemem_rgns.size - 1].start);
 		hole = _ALIGN_UP(hole, MiB(2));
 		hole_end = hole + arm64_mem.text_offset + arm64_mem.image_size;
 
 		if ((hole_end > mem_max) ||
-		    (hole_end > crash_reserved_mem.end)) {
+		    (hole_end > crash_reserved_mem[usablemem_rgns.size - 1].end)) {
 			dbgprintf("%s: Crash kernel out of range\n", __func__);
 			hole = ULONG_MAX;
 		}
@@ -745,7 +764,7 @@ int arm64_load_other_segments(struct kexec_info *info,
 
 	hole_min = image_base + arm64_mem.image_size;
 	if (info->kexec_flags & KEXEC_ON_CRASH)
-		hole_max = crash_reserved_mem.end;
+		hole_max = crash_reserved_mem[usablemem_rgns.size - 1].end;
 	else
 		hole_max = ULONG_MAX;
 
@@ -979,12 +998,21 @@ int get_phys_base_from_pt_load(unsigned long *phys_offset)
 	return 0;
 }
 
-static bool to_be_excluded(char *str)
+static bool to_be_excluded(char *str, unsigned long long start, unsigned long long end)
 {
+	if (!strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL))) {
+		uint64_t load_start, load_end;
+
+		if (!get_crash_kernel_load_range(&load_start, &load_end) &&
+		    (load_start == start) && (load_end == end))
+			return false;
+
+		return true;
+	}
+
 	if (!strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) ||
 	    !strncmp(str, KERNEL_CODE, strlen(KERNEL_CODE)) ||
-	    !strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)) ||
-	    !strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)))
+	    !strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)))
 		return false;
 	else
 		return true;
@@ -1066,7 +1094,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 				memranges.size - 1,
 				memranges.ranges[memranges.size - 1].start,
 				memranges.ranges[memranges.size - 1].end);
-		} else if (to_be_excluded(str)) {
+		} else if (to_be_excluded(str, start, end)) {
 			if (!memranges.size)
 				continue;
 
-- 
2.26.0.106.g9fadedd



Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbgap-00032j-QI
 for kexec@lists.infradead.org; Thu, 21 May 2020 08:30:22 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 51C9F3B415EA5F6BA1A8
 for <kexec@lists.infradead.org>; Thu, 21 May 2020 16:30:01 +0800 (CST)
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v3] arm64: kdump: add another DT property to crash dump
 kernel's dtb
Date: Thu, 21 May 2020 16:32:57 +0800
Message-ID: <20200521083257.53415-1-chenzhou10@huawei.com>
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
To: horms@verge.net.au
Cc: chenzhou10@huawei.com, kexec@lists.infradead.org

Currently, there is only one crash kernel region on arm64, we add
another region "crash kernel low" used for crash dump kernel devices.

To do this, we add DT property "linux,low-memory-range" to crash
dump kernel's dtb to pass the low region.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
For "support reserving crashkernel above 4G on arm64 kdump", we need
to modify the kexec-tools.

Changes since [v2]:
- Rebase to latest kexec-tools code.

Changes since [v1]:
- Add another DT property "linux,low-memory-range" to crash dump kernel's
dtb to pass the low region instead of reusing "linux,usable-memory-range".

[1]: http://lists.infradead.org/pipermail/kexec/2019-April/022792.html
[2]: http://lists.infradead.org/pipermail/kexec/2019-August/023569.html
---
 kexec/arch/arm64/crashdump-arm64.c | 29 +++++++++++++++++++++++++++--
 kexec/arch/arm64/crashdump-arm64.h |  2 ++
 kexec/arch/arm64/iomem.h           |  1 +
 kexec/arch/arm64/kexec-arm64.c     | 27 +++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 38d1a0f..32b7e9f 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -34,6 +34,14 @@ struct memory_ranges usablemem_rgns = {
 	.ranges = &crash_reserved_mem,
 };
 
+/* memory range reserved for crashkernel low, optional */
+struct memory_range crash_reserved_low_mem;
+struct memory_ranges lowmem_rgns = {
+	.size = 0,
+	.max_size = 1,
+	.ranges = &crash_reserved_low_mem,
+};
+
 struct memory_range elfcorehdr_mem;
 
 static struct crash_elf_info elf_info = {
@@ -84,7 +92,10 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
 				char *str, unsigned long long base,
 				unsigned long long length)
 {
-	if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0)
+	if (strncmp(str, CRASH_KERNEL_LOW, strlen(CRASH_KERNEL_LOW)) == 0)
+		return mem_regions_alloc_and_add(&lowmem_rgns,
+				base, length, RANGE_RAM);
+	else if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0)
 		return mem_regions_alloc_and_add(&usablemem_rgns,
 						base, length, RANGE_RAM);
 	else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0)
@@ -124,7 +135,7 @@ static int crash_get_memory_ranges(void)
 	if (!usablemem_rgns.size)
 		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
 
-	/* allow only a single region for crash dump kernel */
+	/* allow only a single usablemem region for crash dump kernel */
 	if (usablemem_rgns.size != 1)
 		return -EINVAL;
 
@@ -136,6 +147,20 @@ static int crash_get_memory_ranges(void)
 		return -ENOMEM;
 	}
 
+	/* lowmem region for crash dump kernel is optional, at most one region */
+	if (lowmem_rgns.size > 1)
+		return -EINVAL;
+
+	if (lowmem_rgns.size) {
+		dbgprint_mem_range("Reserved low memory range", &crash_reserved_low_mem,
+				1);
+
+		if (mem_regions_exclude(&system_memory_rgns, &crash_reserved_low_mem)) {
+			fprintf(stderr,
+					"Error: Number of crash memory ranges excedeed the max limit\n");
+			return -ENOMEM;
+		}
+	}
 	/*
 	 * Make sure that the memory regions are sorted.
 	 */
diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
index 880b83a..f185534 100644
--- a/kexec/arch/arm64/crashdump-arm64.h
+++ b/kexec/arch/arm64/crashdump-arm64.h
@@ -18,6 +18,8 @@
 
 extern struct memory_ranges usablemem_rgns;
 extern struct memory_range crash_reserved_mem;
+extern struct memory_ranges lowmem_rgns;
+extern struct memory_range crash_reserved_low_mem;
 extern struct memory_range elfcorehdr_mem;
 
 extern int load_crashdump_segments(struct kexec_info *info);
diff --git a/kexec/arch/arm64/iomem.h b/kexec/arch/arm64/iomem.h
index d4864bb..45d7953 100644
--- a/kexec/arch/arm64/iomem.h
+++ b/kexec/arch/arm64/iomem.h
@@ -4,6 +4,7 @@
 #define SYSTEM_RAM		"System RAM\n"
 #define KERNEL_CODE		"Kernel code\n"
 #define KERNEL_DATA		"Kernel data\n"
+#define CRASH_KERNEL_LOW	"Crash kernel (low)\n"
 #define CRASH_KERNEL		"Crash kernel\n"
 #define IOMEM_RESERVED		"reserved\n"
 
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 45ebc54..afa4fda 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -41,6 +41,7 @@
 #define PROP_SIZE_CELLS "#size-cells"
 #define PROP_ELFCOREHDR "linux,elfcorehdr"
 #define PROP_USABLE_MEM_RANGE "linux,usable-memory-range"
+#define PROP_LOW_MEM_RANGE "linux,low-memory-range"
 
 #define PAGE_OFFSET_36 ((0xffffffffffffffffUL) << 36)
 #define PAGE_OFFSET_39 ((0xffffffffffffffffUL) << 39)
@@ -469,12 +470,24 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 		goto on_error;
 	}
 
+	if (lowmem_rgns.size) {
+		if (!cells_size_fitted(address_cells, size_cells,
+					&crash_reserved_low_mem)) {
+			fprintf(stderr, "kexec: low memory range doesn't fit cells-size.\n");
+			result = -EINVAL;
+			goto on_error;
+		}
+	}
+
 	/* duplicate dt blob */
 	range_len = sizeof(uint32_t) * (address_cells + size_cells);
 	new_size = fdt_totalsize(dtb->buf)
 		+ fdt_prop_len(PROP_ELFCOREHDR, range_len)
 		+ fdt_prop_len(PROP_USABLE_MEM_RANGE, range_len);
 
+	if (lowmem_rgns.size)
+		new_size += fdt_prop_len(PROP_LOW_MEM_RANGE, range_len);
+
 	new_buf = xmalloc(new_size);
 	result = fdt_open_into(dtb->buf, new_buf, new_size);
 	if (result) {
@@ -578,6 +591,20 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 			result = -EINVAL;
 			goto on_error;
 		}
+
+		/* add linux,low-memory-range */
+		if (lowmem_rgns.size) {
+			nodeoffset = fdt_path_offset(new_buf, "/chosen");
+			result = fdt_setprop_range(new_buf, nodeoffset,
+					PROP_LOW_MEM_RANGE, &crash_reserved_low_mem,
+					address_cells, size_cells);
+			if (result) {
+				dbgprintf("%s: fdt_setprop failed: %s\n", __func__,
+						fdt_strerror(result));
+				result = -EINVAL;
+				goto on_error;
+			}
+		}
 	}
 
 	fdt_pack(new_buf);
-- 
2.19.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

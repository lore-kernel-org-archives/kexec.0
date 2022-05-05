From: Zhen Lei <thunder.leizhen@huawei.com>
Date: Thu, 5 May 2022 17:18:42 +0800
Subject: [PATCH v23 3/6] arm64: kdump: Reimplement crashkernel=X
In-Reply-To: <20220505091845.167-1-thunder.leizhen@huawei.com>
References: <20220505091845.167-1-thunder.leizhen@huawei.com>
Message-ID: <20220505091845.167-4-thunder.leizhen@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

From: Chen Zhou <chenzhou10@huawei.com>

There are following issues in arm64 kdump:
1. We use crashkernel=X to reserve crashkernel in DMA zone, which
will fail when there is not enough low memory.
2. If reserving crashkernel above DMA zone, in this case, crash dump
kernel will fail to boot because there is no low memory available
for allocation.

To solve these issues, introduce crashkernel=X,[high,low].
The "crashkernel=X,high" is used to select a region above DMA zone, and
the "crashkernel=Y,low" is used to allocate specified size low memory.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/kernel/machine_kexec.c      |  9 +++-
 arch/arm64/kernel/machine_kexec_file.c | 12 ++++-
 arch/arm64/mm/init.c                   | 62 +++++++++++++++++++++++---
 3 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index e16b248699d5c3c..19c2d487cb08feb 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -329,8 +329,13 @@ bool crash_is_nosave(unsigned long pfn)
 
 	/* in reserved memory? */
 	addr = __pfn_to_phys(pfn);
-	if ((addr < crashk_res.start) || (crashk_res.end < addr))
-		return false;
+	if ((addr < crashk_res.start) || (crashk_res.end < addr)) {
+		if (!crashk_low_res.end)
+			return false;
+
+		if ((addr < crashk_low_res.start) || (crashk_low_res.end < addr))
+			return false;
+	}
 
 	if (!kexec_crash_image)
 		return true;
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 59c648d51848886..889951291cc0f9c 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -65,10 +65,18 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 
 	/* Exclude crashkernel region */
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	if (ret)
+		goto out;
+
+	if (crashk_low_res.end) {
+		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
+		if (ret)
+			goto out;
+	}
 
-	if (!ret)
-		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
+	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
+out:
 	kfree(cmem);
 	return ret;
 }
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 51863f1448c6989..11406f3e1443168 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -90,6 +90,32 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 #endif
 
+/* Current arm64 boot protocol requires 2MB alignment */
+#define CRASH_ALIGN			SZ_2M
+
+#define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
+#define CRASH_ADDR_HIGH_MAX		memblock.current_limit
+
+static int __init reserve_crashkernel_low(unsigned long long low_size)
+{
+	unsigned long long low_base;
+
+	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
+	if (!low_base) {
+		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
+		return -ENOMEM;
+	}
+
+	pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
+		low_base, low_base + low_size, low_size >> 20);
+
+	crashk_low_res.start = low_base;
+	crashk_low_res.end   = low_base + low_size - 1;
+	insert_resource(&iomem_resource, &crashk_low_res);
+
+	return 0;
+}
+
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -100,17 +126,32 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_base, crash_size;
-	unsigned long long crash_max = arm64_dma_phys_limit;
+	unsigned long long crash_low_size = 0;
+	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
+	char *cmdline = boot_command_line;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
-	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
+	/* crashkernel=X[@offset] */
+	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
-	/* no crashkernel= or invalid value specified */
-	if (ret || !crash_size)
-		return;
+	if (ret || !crash_size) {
+		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
+		if (ret || !crash_size)
+			return;
+
+		/*
+		 * crashkernel=Y,low can be specified or not, but invalid value
+		 * is not allowed.
+		 */
+		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
+		if (ret && (ret != -ENOENT))
+			return;
+
+		crash_max = CRASH_ADDR_HIGH_MAX;
+	}
 
 	crash_size = PAGE_ALIGN(crash_size);
 
@@ -118,8 +159,7 @@ static void __init reserve_crashkernel(void)
 	if (crash_base)
 		crash_max = crash_base + crash_size;
 
-	/* Current arm64 boot protocol requires 2MB alignment */
-	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
+	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
 					       crash_base, crash_max);
 	if (!crash_base) {
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
@@ -127,6 +167,11 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
+	if (crash_low_size && reserve_crashkernel_low(crash_low_size)) {
+		memblock_phys_free(crash_base, crash_size);
+		return;
+	}
+
 	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
 		crash_base, crash_base + crash_size, crash_size >> 20);
 
@@ -135,6 +180,9 @@ static void __init reserve_crashkernel(void)
 	 * map. Inform kmemleak so that it won't try to access it.
 	 */
 	kmemleak_ignore_phys(crash_base);
+	if (crashk_low_res.end)
+		kmemleak_ignore_phys(crashk_low_res.start);
+
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 	insert_resource(&iomem_resource, &crashk_res);
-- 
2.25.1



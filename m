Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v17 07/10] arm64: kdump: reimplement crashkernel=X
Date: Fri, 10 Dec 2021 14:55:30 +0800
Message-ID: <20211210065533.2023-8-thunder.leizhen@huawei.com>
In-Reply-To: <20211210065533.2023-1-thunder.leizhen@huawei.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
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
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>

From: Chen Zhou <chenzhou10@huawei.com>

There are following issues in arm64 kdump:
1. We use crashkernel=X to reserve crashkernel below 4G, which
will fail when there is no enough low memory.
2. If reserving crashkernel above 4G, in this case, crash dump
kernel will boot failure because there is no low memory available
for allocation.

To solve these issues, change the behavior of crashkernel=X and
introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
in DMA zone, and fall back to high allocation if it fails.
We can also use "crashkernel=X,high" to select a region above DMA zone,
which also tries to allocate at least 256M in DMA zone automatically.
"crashkernel=Y,low" can be used to allocate specified size low memory.

Another minor change, there may be two regions reserved for crash
dump kernel, in order to distinct from the high region and make no
effect to the use of existing kexec-tools, rename the low region as
"Crash kernel (low)".

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Tested-by: John Donnelly <John.p.donnelly@oracle.com>
Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 arch/arm64/Kconfig                     |  1 +
 arch/arm64/include/asm/kexec.h         |  4 ++
 arch/arm64/kernel/machine_kexec_file.c | 12 +++++-
 arch/arm64/kernel/setup.c              | 13 +++++-
 arch/arm64/mm/init.c                   | 59 +++++---------------------
 5 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17ffb..4b99efa36da3793 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -95,6 +95,7 @@ config ARM64
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 	select ARCH_WANT_LD_ORPHAN_WARN
+	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 1b9edc69f0244ca..3bde0079925d771 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -96,6 +96,10 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_CORE
+extern void __init reserve_crashkernel(void);
+#endif
+
 #if defined(CONFIG_KEXEC_CORE)
 void cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 		      unsigned long arg0, unsigned long arg1,
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 63634b4d72c158f..6f3fa059ca4e816 100644
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
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index be5f85b0a24de69..4bb2e55366be64d 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -248,7 +248,18 @@ static void __init request_standard_resources(void)
 		    kernel_data.end <= res->end)
 			request_resource(res, &kernel_data);
 #ifdef CONFIG_KEXEC_CORE
-		/* Userspace will find "Crash kernel" region in /proc/iomem. */
+		/*
+		 * Userspace will find "Crash kernel" or "Crash kernel (low)"
+		 * region in /proc/iomem.
+		 * In order to distinct from the high region and make no effect
+		 * to the use of existing kexec-tools, rename the low region as
+		 * "Crash kernel (low)".
+		 */
+		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
+				crashk_low_res.end <= res->end) {
+			crashk_low_res.name = "Crash kernel (low)";
+			request_resource(res, &crashk_low_res);
+		}
 		if (crashk_res.end && crashk_res.start >= res->start &&
 		    crashk_res.end <= res->end)
 			request_resource(res, &crashk_res);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index be4595dc7459115..85c83e4eff2b6c4 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -36,6 +36,7 @@
 #include <asm/fixmap.h>
 #include <asm/kasan.h>
 #include <asm/kernel-pgtable.h>
+#include <asm/kexec.h>
 #include <asm/kvm_host.h>
 #include <asm/memory.h>
 #include <asm/numa.h>
@@ -64,57 +65,11 @@ EXPORT_SYMBOL(memstart_addr);
  */
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
-#ifdef CONFIG_KEXEC_CORE
-/*
- * reserve_crashkernel() - reserves memory for crash kernel
- *
- * This function reserves memory area given in "crashkernel=" kernel command
- * line parameter. The memory reserved is used by dump capture kernel when
- * primary kernel is crashing.
- */
+#ifndef CONFIG_KEXEC_CORE
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_base, crash_size;
-	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
-	int ret;
-
-	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-				&crash_size, &crash_base);
-	/* no crashkernel= or invalid value specified */
-	if (ret || !crash_size)
-		return;
-
-	crash_size = PAGE_ALIGN(crash_size);
-
-	/* User specifies base address explicitly. */
-	if (crash_base)
-		crash_max = crash_base + crash_size;
-
-	/* Current arm64 boot protocol requires 2MB alignment */
-	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
-					       crash_base, crash_max);
-	if (!crash_base) {
-		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
-			crash_size);
-		return;
-	}
-
-	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
-		crash_base, crash_base + crash_size, crash_size >> 20);
-
-	/*
-	 * The crashkernel memory will be removed from the kernel linear
-	 * map. Inform kmemleak so that it won't try to access it.
-	 */
-	kmemleak_ignore_phys(crash_base);
-	crashk_res.start = crash_base;
-	crashk_res.end = crash_base + crash_size - 1;
 }
-#else
-static void __init reserve_crashkernel(void)
-{
-}
-#endif /* CONFIG_KEXEC_CORE */
+#endif
 
 /*
  * Return the maximum physical address for a zone accessible by the given bits
@@ -362,6 +317,14 @@ void __init bootmem_init(void)
 	 * reserved, so do it here.
 	 */
 	reserve_crashkernel();
+#ifdef CONFIG_KEXEC_CORE
+	/*
+	 * The low region is intended to be used for crash dump kernel devices,
+	 * just mark the low region as "nomap" simply.
+	 */
+	if (crashk_low_res.end)
+		memblock_mark_nomap(crashk_low_res.start, resource_size(&crashk_low_res));
+#endif
 
 	memblock_dump_all();
 }
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

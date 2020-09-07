Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v12 4/9] x86: kdump: move reserve_crashkernel[_low]() into
 crash_core.c
Date: Mon, 7 Sep 2020 21:47:40 +0800
Message-ID: <20200907134745.25732-5-chenzhou10@huawei.com>
In-Reply-To: <20200907134745.25732-1-chenzhou10@huawei.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
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
To: catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net, John.P.donnelly@oracle.com, prabhakar.pkin@gmail.com, bhsharma@redhat.com
Cc: wangkefeng.wang@huawei.com, arnd@arndb.de, linux-doc@vger.kernel.org, chenzhou10@huawei.com, xiexiuqi@huawei.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, horms@verge.net.au, nsaenzjulienne@suse.de, huawei.libin@huawei.com, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org

Make the functions reserve_crashkernel[_low]() as generic.
Arm64 will use these to reimplement crashkernel=X.

There is no functional change.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/x86/include/asm/kexec.h |  25 +++++
 arch/x86/kernel/setup.c      | 163 +------------------------------
 include/linux/crash_core.h   |   4 +
 include/linux/kexec.h        |   2 -
 kernel/crash_core.c          | 179 +++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c          |  17 ----
 6 files changed, 210 insertions(+), 180 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 83f200dd54a1..adf5e9a016bd 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -21,6 +21,27 @@
 /* 2M alignment for crash kernel regions */
 #define CRASH_ALIGN		SZ_2M
 
+/*
+ * Keep the crash kernel below this limit.
+ *
+ * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
+ * due to mapping restrictions.
+ *
+ * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
+ * the upper limit of system RAM in 4-level paging mode. Since the kdump
+ * jump could be from 5-level paging to 4-level paging, the jump will fail if
+ * the kernel is put above 64 TB, and during the 1st kernel bootup there's
+ * no good way to detect the paging mode of the target kernel which will be
+ * loaded for dumping.
+ */
+#ifdef CONFIG_X86_32
+# define CRASH_ADDR_LOW_MAX	SZ_512M
+# define CRASH_ADDR_HIGH_MAX	SZ_512M
+#else
+# define CRASH_ADDR_LOW_MAX	SZ_4G
+# define CRASH_ADDR_HIGH_MAX	SZ_64T
+#endif
+
 #ifndef __ASSEMBLY__
 
 #include <linux/string.h>
@@ -200,6 +221,10 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_KEXEC_CORE
+extern void __init reserve_crashkernel(void);
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 71a6a6e7ca5b..927ba83e8da4 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -22,8 +22,6 @@
 
 #include <uapi/linux/mount.h>
 
-#include <xen/xen.h>
-
 #include <asm/apic.h>
 #include <asm/numa.h>
 #include <asm/bios_ebda.h>
@@ -35,6 +33,7 @@
 #include <asm/io_apic.h>
 #include <asm/kasan.h>
 #include <asm/kaslr.h>
+#include <asm/kexec.h>
 #include <asm/mce.h>
 #include <asm/mtrr.h>
 #include <asm/realmode.h>
@@ -396,165 +395,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 	}
 }
 
-/*
- * --------- Crashkernel reservation ------------------------------
- */
-
-#ifdef CONFIG_KEXEC_CORE
-
-/*
- * Keep the crash kernel below this limit.
- *
- * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
- * due to mapping restrictions.
- *
- * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
- * the upper limit of system RAM in 4-level paging mode. Since the kdump
- * jump could be from 5-level paging to 4-level paging, the jump will fail if
- * the kernel is put above 64 TB, and during the 1st kernel bootup there's
- * no good way to detect the paging mode of the target kernel which will be
- * loaded for dumping.
- */
-#ifdef CONFIG_X86_32
-# define CRASH_ADDR_LOW_MAX	SZ_512M
-# define CRASH_ADDR_HIGH_MAX	SZ_512M
-#else
-# define CRASH_ADDR_LOW_MAX	SZ_4G
-# define CRASH_ADDR_HIGH_MAX	SZ_64T
-#endif
-
-static int __init reserve_crashkernel_low(void)
-{
-#ifdef CONFIG_X86_64
-	unsigned long long base, low_base = 0, low_size = 0;
-	unsigned long total_low_mem;
-	int ret;
-
-	total_low_mem = memblock_mem_size(CRASH_ADDR_LOW_MAX >> PAGE_SHIFT);
-
-	/* crashkernel=Y,low */
-	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);
-	if (ret) {
-		/*
-		 * two parts from kernel/dma/swiotlb.c:
-		 * -swiotlb size: user-specified with swiotlb= or default.
-		 *
-		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
-		 * to 8M for other buffers that may need to stay low too. Also
-		 * make sure we allocate enough extra low memory so that we
-		 * don't run out of DMA buffers for 32-bit devices.
-		 */
-		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
-	} else {
-		/* passed with crashkernel=0,low ? */
-		if (!low_size)
-			return 0;
-	}
-
-	low_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_LOW_MAX, low_size, CRASH_ALIGN);
-	if (!low_base) {
-		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
-		       (unsigned long)(low_size >> 20));
-		return -ENOMEM;
-	}
-
-	ret = memblock_reserve(low_base, low_size);
-	if (ret) {
-		pr_err("%s: Error reserving crashkernel low memblock.\n", __func__);
-		return ret;
-	}
-
-	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System low RAM: %ldMB)\n",
-		(unsigned long)(low_size >> 20),
-		(unsigned long)(low_base >> 20),
-		(unsigned long)(total_low_mem >> 20));
-
-	crashk_low_res.start = low_base;
-	crashk_low_res.end   = low_base + low_size - 1;
-	insert_resource(&iomem_resource, &crashk_low_res);
-#endif
-	return 0;
-}
-
-static void __init reserve_crashkernel(void)
-{
-	unsigned long long crash_size, crash_base, total_mem;
-	bool high = false;
-	int ret;
-
-	total_mem = memblock_phys_mem_size();
-
-	/* crashkernel=XM */
-	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
-	if (ret != 0 || crash_size <= 0) {
-		/* crashkernel=X,high */
-		ret = parse_crashkernel_high(boot_command_line, total_mem,
-					     &crash_size, &crash_base);
-		if (ret != 0 || crash_size <= 0)
-			return;
-		high = true;
-	}
-
-	if (xen_pv_domain()) {
-		pr_info("Ignoring crashkernel for a Xen PV domain\n");
-		return;
-	}
-
-	/* 0 means: find the address automatically */
-	if (!crash_base) {
-		/*
-		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
-		 * crashkernel=x,high reserves memory over CRASH_ADDR_LOW_MAX,
-		 * also allocates 256M extra low memory for DMA buffers
-		 * and swiotlb.
-		 * But the extra memory is not required for all machines.
-		 * So try low memory first and fall back to high memory
-		 * unless "crashkernel=size[KMG],high" is specified.
-		 */
-		if (!high)
-			crash_base = memblock_find_in_range(CRASH_ALIGN,
-						CRASH_ADDR_LOW_MAX,
-						crash_size, CRASH_ALIGN);
-		if (!crash_base)
-			crash_base = memblock_find_in_range(CRASH_ALIGN,
-						CRASH_ADDR_HIGH_MAX,
-						crash_size, CRASH_ALIGN);
-		if (!crash_base) {
-			pr_info("crashkernel reservation failed - No suitable area found.\n");
-			return;
-		}
-	} else {
-		unsigned long long start;
-
-		start = memblock_find_in_range(crash_base,
-					       crash_base + crash_size,
-					       crash_size, CRASH_ALIGN);
-		if (start != crash_base) {
-			pr_info("crashkernel reservation failed - memory is in use.\n");
-			return;
-		}
-	}
-	ret = memblock_reserve(crash_base, crash_size);
-	if (ret) {
-		pr_err("%s: Error reserving crashkernel memblock.\n", __func__);
-		return;
-	}
-
-	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
-		memblock_free(crash_base, crash_size);
-		return;
-	}
-
-	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
-		(unsigned long)(crash_size >> 20),
-		(unsigned long)(crash_base >> 20),
-		(unsigned long)(total_mem >> 20));
-
-	crashk_res.start = crash_base;
-	crashk_res.end   = crash_base + crash_size - 1;
-	insert_resource(&iomem_resource, &crashk_res);
-}
-#else
+#ifndef CONFIG_KEXEC_CORE
 static void __init reserve_crashkernel(void)
 {
 }
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 6594dbc34a37..eabbb703d2a3 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -66,6 +66,9 @@ extern unsigned char *vmcoreinfo_data;
 extern size_t vmcoreinfo_size;
 extern u32 *vmcoreinfo_note;
 
+extern struct resource crashk_res;
+extern struct resource crashk_low_res;
+
 /* raw contents of kernel .notes section */
 extern const void __start_notes __weak;
 extern const void __stop_notes __weak;
@@ -80,5 +83,6 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
+int __init reserve_crashkernel_low(void);
 
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e93bef52968..f301f2f5cfc4 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -337,8 +337,6 @@ extern int kexec_load_disabled;
 
 /* Location of a reserved region to hold the crash kernel.
  */
-extern struct resource crashk_res;
-extern struct resource crashk_low_res;
 extern note_buf_t __percpu *crash_notes;
 
 /* flag to track if kexec reboot is in progress */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 106e4500fd53..d968ef268fb4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -7,7 +7,12 @@
 #include <linux/crash_core.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/memblock.h>
+#include <linux/swiotlb.h>
 
+#include <xen/xen.h>
+
+#include <asm/kexec.h>
 #include <asm/page.h>
 #include <asm/sections.h>
 
@@ -21,6 +26,22 @@ u32 *vmcoreinfo_note;
 /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
 static unsigned char *vmcoreinfo_data_safecopy;
 
+/* Location of the reserved area for the crash kernel */
+struct resource crashk_res = {
+	.name  = "Crash kernel",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_CRASH_KERNEL
+};
+struct resource crashk_low_res = {
+	.name  = "Crash kernel",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_CRASH_KERNEL
+};
+
 /*
  * parsing the "crashkernel" commandline
  *
@@ -294,6 +315,164 @@ int __init parse_crashkernel_low(char *cmdline,
 				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
 }
 
+/*
+ * --------- Crashkernel reservation ------------------------------
+ */
+
+int __init reserve_crashkernel_low(void)
+{
+#if defined(CONFIG_X86_64)
+	unsigned long long base, low_base = 0, low_size = 0;
+	unsigned long total_low_mem;
+	int ret;
+
+	total_low_mem = memblock_mem_size(CRASH_ADDR_LOW_MAX >> PAGE_SHIFT);
+
+	/* crashkernel=Y,low */
+	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size,
+			&base);
+	if (ret) {
+		/*
+		 * two parts from lib/swiotlb.c:
+		 * -swiotlb size: user-specified with swiotlb= or default.
+		 *
+		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
+		 * to 8M for other buffers that may need to stay low too. Also
+		 * make sure we allocate enough extra low memory so that we
+		 * don't run out of DMA buffers for 32-bit devices.
+		 */
+		low_size = max(swiotlb_size_or_default() + (8UL << 20),
+				256UL << 20);
+	} else {
+		/* passed with crashkernel=0,low ? */
+		if (!low_size)
+			return 0;
+	}
+
+	low_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_LOW_MAX, low_size, CRASH_ALIGN);
+	if (!low_base) {
+		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
+		       (unsigned long)(low_size >> 20));
+		return -ENOMEM;
+	}
+
+	ret = memblock_reserve(low_base, low_size);
+	if (ret) {
+		pr_err("%s: Error reserving crashkernel low memblock.\n",
+				__func__);
+		return ret;
+	}
+
+	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System low RAM: %ldMB)\n",
+		(unsigned long)(low_size >> 20),
+		(unsigned long)(low_base >> 20),
+		(unsigned long)(total_low_mem >> 20));
+
+	crashk_low_res.start = low_base;
+	crashk_low_res.end   = low_base + low_size - 1;
+	insert_resource(&iomem_resource, &crashk_low_res);
+#endif
+	return 0;
+}
+
+#if defined(CONFIG_X86)
+#ifdef CONFIG_KEXEC_CORE
+/*
+ * reserve_crashkernel() - reserves memory for crash kernel
+ *
+ * This function reserves memory area given in "crashkernel=" kernel command
+ * line parameter. The memory reserved is used by dump capture kernel when
+ * primary kernel is crashing.
+ */
+void __init reserve_crashkernel(void)
+{
+	unsigned long long crash_size, crash_base, total_mem;
+	bool high = false;
+	int ret;
+
+	total_mem = memblock_phys_mem_size();
+
+	/* crashkernel=XM */
+	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
+	/* no crashkernel= or invalid value specified */
+	if (ret || !crash_size) {
+		/* crashkernel=X,high */
+		ret = parse_crashkernel_high(boot_command_line, total_mem,
+					     &crash_size, &crash_base);
+		if (ret || !crash_size)
+			return;
+		high = true;
+	}
+
+	if (xen_pv_domain()) {
+		pr_info("Ignoring crashkernel for a Xen PV domain\n");
+		return;
+	}
+
+	/* 0 means: find the address automatically */
+	if (!crash_base) {
+		/*
+		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
+		 * crashkernel=x,high reserves memory over CRASH_ADDR_LOW_MAX,
+		 * also allocates 256M extra low memory for DMA buffers
+		 * and swiotlb.
+		 * But the extra memory is not required for all machines.
+		 * So try low memory first and fall back to high memory
+		 * unless "crashkernel=size[KMG],high" is specified.
+		 */
+		if (!high)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						CRASH_ADDR_LOW_MAX,
+						crash_size, CRASH_ALIGN);
+		if (!crash_base)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						CRASH_ADDR_HIGH_MAX,
+						crash_size, CRASH_ALIGN);
+		if (!crash_base) {
+			pr_info("crashkernel reservation failed - No suitable area found.\n");
+			return;
+		}
+	} else {
+		/* User specifies base address explicitly. */
+		unsigned long long start;
+
+		if (!IS_ALIGNED(crash_base, CRASH_ALIGN)) {
+			pr_warn("cannot reserve crashkernel: base address is not %ldMB aligned\n",
+				(unsigned long)CRASH_ALIGN >> 20);
+			return;
+		}
+
+		start = memblock_find_in_range(crash_base,
+					       crash_base + crash_size,
+					       crash_size, CRASH_ALIGN);
+		if (start != crash_base) {
+			pr_info("crashkernel reservation failed - memory is in use.\n");
+			return;
+		}
+	}
+	ret = memblock_reserve(crash_base, crash_size);
+	if (ret) {
+		pr_err("%s: Error reserving crashkernel memblock.\n", __func__);
+		return;
+	}
+
+	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
+		memblock_free(crash_base, crash_size);
+		return;
+	}
+
+	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
+		(unsigned long)(crash_size >> 20),
+		(unsigned long)(crash_base >> 20),
+		(unsigned long)(total_mem >> 20));
+
+	crashk_res.start = crash_base;
+	crashk_res.end   = crash_base + crash_size - 1;
+	insert_resource(&iomem_resource, &crashk_res);
+}
+#endif /* CONFIG_KEXEC_CORE */
+#endif
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c19c0dad1ebe..db66bbabfff3 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -53,23 +53,6 @@ note_buf_t __percpu *crash_notes;
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
-
-/* Location of the reserved area for the crash kernel */
-struct resource crashk_res = {
-	.name  = "Crash kernel",
-	.start = 0,
-	.end   = 0,
-	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
-	.desc  = IORES_DESC_CRASH_KERNEL
-};
-struct resource crashk_low_res = {
-	.name  = "Crash kernel",
-	.start = 0,
-	.end   = 0,
-	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
-	.desc  = IORES_DESC_CRASH_KERNEL
-};
-
 int kexec_should_crash(struct task_struct *p)
 {
 	/*
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fhQ8s-0000tK-EX
 for kexec@lists.infradead.org; Mon, 23 Jul 2018 02:00:08 +0000
Received: by mail-pg1-x544.google.com with SMTP id e6-v6so11059114pgv.2
 for <kexec@lists.infradead.org>; Sun, 22 Jul 2018 18:59:55 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v4 5/5] arm64: acpi: fix alignment fault in accessing ACPI
Date: Mon, 23 Jul 2018 10:57:32 +0900
Message-Id: <20180723015732.24252-6-takahiro.akashi@linaro.org>
In-Reply-To: <20180723015732.24252-1-takahiro.akashi@linaro.org>
References: <20180723015732.24252-1-takahiro.akashi@linaro.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, ard.biesheuvel@linaro.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org, al.stone@linaro.org, bhsharma@redhat.com, tbaicar@codeaurora.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

This is a fix against the issue that crash dump kernel may hang up
during booting, which can happen on any ACPI-based system with "ACPI
Reclaim Memory."

(kernel messages after panic kicked off kdump)
	   (snip...)
	Bye!
	   (snip...)
	ACPI: Core revision 20170728
	pud=000000002e7d0003, *pmd=000000002e7c0003, *pte=00e8000039710707
	Internal error: Oops: 96000021 [#1] SMP
	Modules linked in:
	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-rc6 #1
	task: ffff000008d05180 task.stack: ffff000008cc0000
	PC is at acpi_ns_lookup+0x25c/0x3c0
	LR is at acpi_ds_load1_begin_op+0xa4/0x294
	   (snip...)
	Process swapper/0 (pid: 0, stack limit = 0xffff000008cc0000)
	Call trace:
	   (snip...)
	[<ffff0000084a6764>] acpi_ns_lookup+0x25c/0x3c0
	[<ffff00000849b4f8>] acpi_ds_load1_begin_op+0xa4/0x294
	[<ffff0000084ad4ac>] acpi_ps_build_named_op+0xc4/0x198
	[<ffff0000084ad6cc>] acpi_ps_create_op+0x14c/0x270
	[<ffff0000084acfa8>] acpi_ps_parse_loop+0x188/0x5c8
	[<ffff0000084ae048>] acpi_ps_parse_aml+0xb0/0x2b8
	[<ffff0000084a8e10>] acpi_ns_one_complete_parse+0x144/0x184
	[<ffff0000084a8e98>] acpi_ns_parse_table+0x48/0x68
	[<ffff0000084a82cc>] acpi_ns_load_table+0x4c/0xdc
	[<ffff0000084b32f8>] acpi_tb_load_namespace+0xe4/0x264
	[<ffff000008baf9b4>] acpi_load_tables+0x48/0xc0
	[<ffff000008badc20>] acpi_early_init+0x9c/0xd0
	[<ffff000008b70d50>] start_kernel+0x3b4/0x43c
	Code: b9008fb9 2a000318 36380054 32190318 (b94002c0)
	---[ end trace c46ed37f9651c58e ]---
	Kernel panic - not syncing: Fatal exception
	Rebooting in 10 seconds..

(diagnosis)
* This fault is a data abort, alignment fault (ESR=0x96000021)
  during reading out ACPI table.
* Initial ACPI tables are normally stored in system ram and marked as
  "ACPI Reclaim memory" by the firmware.
* After the commit f56ab9a5b73c ("efi/arm: Don't mark ACPI reclaim
  memory as MEMBLOCK_NOMAP"), those regions are differently handled
  as they are "memblock-reserved", without NOMAP bit.
* So they are now excluded from device tree's "usable-memory-range"
  which kexec-tools determines based on a current view of /proc/iomem.
* When crash dump kernel boots up, it tries to accesses ACPI tables by
  mapping them with ioremap(), not ioremap_cache(), in acpi_os_ioremap()
  since they are no longer part of mapped system ram.
* Given that ACPI accessor/helper functions are compiled in without
  unaligned access support (ACPI_MISALIGNMENT_NOT_SUPPORTED),
  any unaligned access to ACPI tables can cause a fatal panic.

With this patch, acpi_os_ioremap() always honors memory attribute
information provided by the firmware (EFI) and retaining cacheability
allows the kernel safe access to ACPI tables.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reported-by and Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/include/asm/acpi.h | 23 ++++++++++++++++-------
 arch/arm64/kernel/acpi.c      | 11 +++--------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 0db62a4cbce2..68bc18cb2b85 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -12,10 +12,12 @@
 #ifndef _ASM_ACPI_H
 #define _ASM_ACPI_H
 
+#include <linux/efi.h>
 #include <linux/memblock.h>
 #include <linux/psci.h>
 
 #include <asm/cputype.h>
+#include <asm/io.h>
 #include <asm/smp_plat.h>
 #include <asm/tlbflush.h>
 
@@ -29,18 +31,22 @@
 
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
+pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
+
 /* ACPI table mapping after acpi_permanent_mmap is set */
 static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 					    acpi_size size)
 {
+	/* For normal memory we already have a cacheable mapping. */
+	if (memblock_is_map_memory(phys))
+		return (void __iomem *)__phys_to_virt(phys);
+
 	/*
-	 * EFI's reserve_regions() call adds memory with the WB attribute
-	 * to memblock via early_init_dt_add_memory_arch().
+	 * We should still honor the memory's attribute here because
+	 * crash dump kernel possibly excludes some ACPI (reclaim)
+	 * regions from memblock list.
 	 */
-	if (!memblock_is_memory(phys))
-		return ioremap(phys, size);
-
-	return ioremap_cache(phys, size);
+	return __ioremap(phys, size, __acpi_get_mem_attribute(phys));
 }
 #define acpi_os_ioremap acpi_os_ioremap
 
@@ -129,7 +135,10 @@ static inline const char *acpi_get_enable_method(int cpu)
  * for compatibility.
  */
 #define acpi_disable_cmcff 1
-pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	return __acpi_get_mem_attribute(addr);
+}
 #endif /* CONFIG_ACPI_APEI */
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 7b09487ff8fb..ed46dc188b22 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -18,6 +18,7 @@
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <linux/cpumask.h>
+#include <linux/efi.h>
 #include <linux/efi-bgrt.h>
 #include <linux/init.h>
 #include <linux/irq.h>
@@ -29,13 +30,9 @@
 
 #include <asm/cputype.h>
 #include <asm/cpu_ops.h>
+#include <asm/pgtable.h>
 #include <asm/smp_plat.h>
 
-#ifdef CONFIG_ACPI_APEI
-# include <linux/efi.h>
-# include <asm/pgtable.h>
-#endif
-
 int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
 int acpi_disabled = 1;
 EXPORT_SYMBOL(acpi_disabled);
@@ -239,8 +236,7 @@ void __init acpi_boot_table_init(void)
 	}
 }
 
-#ifdef CONFIG_ACPI_APEI
-pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
 {
 	/*
 	 * According to "Table 8 Map: EFI memory types to AArch64 memory
@@ -261,4 +257,3 @@ pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 		return __pgprot(PROT_NORMAL_NC);
 	return __pgprot(PROT_DEVICE_nGnRnE);
 }
-#endif
-- 
2.18.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

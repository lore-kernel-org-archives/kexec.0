Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23B7ECAAD8
	for <kexec@archiver.kernel.org>; Fri, 23 Sep 2022 07:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jn7l37aEIMisle1tlp/wlZY4zJub9K5BF2CtHeRzqx4=; b=0XK/ZBrqRzVm5g
	UJ2Zkx8j+t+UfPgfqeqlpR1ry32Odpbwy280qEPe56kXKumm6NFmsq/FOehA1gapqhzKLGXOQTk9O
	eWNvax90QuPb/Vs7JM3cnysNj8BX2pX6fwA3OhUWrxS47TrFUvkNVY+oVhDqi0kP1gu6uVkqCk7t9
	G3fpxKnpz3ATP2kBedSLhDRWlBEu6qq5r7v2zoLIDKnLLbwRJXSSc0N/EKaaXDykOWBYJqhI/97rm
	rWgT6K/5v/Myh8fE4NrVOwml5rpArzTo6/CSVbcqtSdI9THPrfDj9XRzEmJlFjtsJY3e6tJJh7QeW
	kPQazh0W08JinQ7J1mOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obdMk-002l7T-Q0; Fri, 23 Sep 2022 07:44:54 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obdMd-002l4j-Lg
	for kexec@lists.infradead.org; Fri, 23 Sep 2022 07:44:51 +0000
Received: from bogon.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+DpYy1jsI4gAA--.57695S4;
	Fri, 23 Sep 2022 15:44:43 +0800 (CST)
From: Youling Tang <tangyouling@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] LoongArch: Add kdump support
Date: Fri, 23 Sep 2022 15:44:32 +0800
Message-Id: <1663919073-26849-3-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1663919073-26849-1-git-send-email-tangyouling@loongson.cn>
References: <1663919073-26849-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8CxT+DpYy1jsI4gAA--.57695S4
X-Coremail-Antispam: 1UD129KBjvAXoW3ur4kur15XF1UJr13XF1rtFb_yoW8XF45Go
	WxtF18tw1rKrW2yrs5CF1jyFW5Kr1qkrsxA39xZa13WF1Syw1UX348Kr9Iy347Jws5Ww4x
	G34ag3yjva97Xr95n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOn7k0a2IF6w4kM7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0
	x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87
	I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY
	1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20x
	vEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2
	xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U5LID3UUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_004448_151400_20154843 
X-CRM114-Status: GOOD (  40.34  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

This patch adds support for kdump. In kdump case the normal kernel will
reserve a region for the crash kernel and jump there on panic.

Arch-specific functions are added to allow for implementing a crash dump
file interface, /proc/vmcore, which can be viewed as a ELF file.

A user-space tool, such as kexec-tools, is responsible for allocating a
separate region for the core's ELF header within the crash kdump kernel
memory and filling it in when executing kexec_load().

Then, its location will be advertised to the crash dump kernel via a
command line argument "elfcorehdr=", and the crash dump kernel will
preserve this region for later use with loongarch_reserve_vmcore at
boot time.

At the same time, the crash kdump kernel is also limited within the
"crashkernel" area via a command line argument "mem=", so as not to
destroy the original kernel dump data.

In the crash dump kernel environment, /proc/vmcore is used to access the
primary kernel's memory with copy_oldmem_page().

I tested kdump on LoongArch machines (Loongson-3A5000) and it works as
expected (suggested crashkernel parameter is "crashkernel=512M@2560M"),
you may test it by triggering a crash through /proc/sysrq-trigger:

 $ sudo kexec -p /boot/vmlinux-kdump --reuse-cmdline --append="nr_cpus=1"
 # echo c > /proc/sysrq-trigger

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/Kconfig                  |  22 +++++
 arch/loongarch/Makefile                 |   4 +
 arch/loongarch/kernel/Makefile          |   1 +
 arch/loongarch/kernel/crash_dump.c      |  19 ++++
 arch/loongarch/kernel/machine_kexec.c   |  98 ++++++++++++++++++-
 arch/loongarch/kernel/mem.c             |   1 +
 arch/loongarch/kernel/relocate_kernel.S |   6 ++
 arch/loongarch/kernel/setup.c           | 123 ++++++++++++++++++++++--
 arch/loongarch/kernel/traps.c           |   4 +
 9 files changed, 263 insertions(+), 15 deletions(-)
 create mode 100644 arch/loongarch/kernel/crash_dump.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 4352e9b271aa..b2da0a6f844e 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -430,6 +430,28 @@ config KEXEC
 
 	  The name comes from the similarity to the exec system call.
 
+config CRASH_DUMP
+	bool "Build kdump crash kernel"
+	help
+	  Generate crash dump after being started by kexec. This should
+	  be normally only set in special crash dump kernels which are
+	  loaded in the main kernel with kexec-tools into a specially
+	  reserved region and then later executed after a crash by
+	  kdump/kexec.
+
+	  For more details see Documentation/admin-guide/kdump/kdump.rst
+
+config PHYSICAL_START
+	hex "Physical address where the kernel is loaded"
+	default "0x90000000a0000000"
+	depends on CRASH_DUMP
+	help
+	  This gives the XKPRANGE address where the kernel is loaded.
+	  If you plan to use kernel for capturing the crash dump change
+	  this value to start of the reserved region (the "X" value as
+	  specified in the "crashkernel=YM@XM" command line boot parameter
+	  passed to the panic-ed kernel).
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 42352f905858..ea17e692684e 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -69,7 +69,11 @@ endif
 cflags-y += -ffreestanding
 cflags-y += $(call cc-option, -mno-check-zero-division)
 
+ifndef CONFIG_PHYSICAL_START
 load-y		= 0x9000000000200000
+else
+load-y		= $(CONFIG_PHYSICAL_START)
+endif
 bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y)
 
 drivers-$(CONFIG_PCI)		+= arch/loongarch/pci/
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 17554244db54..53581442fa73 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_MODULES)		+= module.o module-sections.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
 obj-$(CONFIG_PROC_FS)		+= proc.o
 
diff --git a/arch/loongarch/kernel/crash_dump.c b/arch/loongarch/kernel/crash_dump.c
new file mode 100644
index 000000000000..3a3711e57f39
--- /dev/null
+++ b/arch/loongarch/kernel/crash_dump.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/highmem.h>
+#include <linux/crash_dump.h>
+#include <linux/io.h>
+
+ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
+			 size_t csize, unsigned long offset)
+{
+	void *vaddr;
+
+	if (!csize)
+		return 0;
+
+	vaddr = kmap_local_pfn(pfn);
+	csize = copy_to_iter(vaddr + offset, csize, iter);
+	kunmap_local(vaddr);
+
+	return csize;
+}
diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index 348d914d6d85..0ca9118c0a22 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -7,10 +7,15 @@
 #include <linux/compiler.h>
 #include <linux/cpu.h>
 #include <linux/kexec.h>
-#include <linux/mm.h>
+#include <linux/crash_dump.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
 #include <linux/libfdt.h>
+#include <linux/mm.h>
 #include <linux/of_fdt.h>
+#include <linux/reboot.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cacheflush.h>
@@ -22,6 +27,7 @@
 #define KEXEC_STBL_ADDR	TO_CACHE(0x110000UL)
 
 static unsigned long reboot_code_buffer;
+static cpumask_t cpus_in_crash = CPU_MASK_NONE;
 
 #ifdef CONFIG_SMP
 static void (*relocated_kexec_smp_wait)(void *);
@@ -83,7 +89,7 @@ int machine_kexec_prepare(struct kimage *kimage)
 		return -EINVAL;
 	}
 
-	/* kexec need a safe page to save reboot_code_buffer */
+	/* kexec/kdump need a safe page to save reboot_code_buffer */
 	kimage->control_code_page = virt_to_page((void *)KEXEC_CTRL_CODE);
 
 	reboot_code_buffer = (unsigned long)page_address(kimage->control_code_page);
@@ -107,7 +113,8 @@ void kexec_reboot(void)
 
 	/*
 	 * We know we were online, and there will be no incoming IPIs at
-	 * this point.
+	 * this point. Mark online again before rebooting so that the crash
+	 * analysis tool will see us correctly.
 	 */
 	set_cpu_online(smp_processor_id(), true);
 
@@ -152,7 +159,74 @@ static void kexec_shutdown_secondary(void *)
 
 	kexec_reboot();
 }
-#endif
+
+static void crash_shutdown_secondary(void *passed_regs)
+{
+	int cpu = smp_processor_id();
+	struct pt_regs *regs = passed_regs;
+
+	/*
+	 * If we are passed registers, use those. Otherwise get the
+	 * regs from the last interrupt, which should be correct, as
+	 * we are in an interrupt. But if the regs are not there,
+	 * pull them from the top of the stack. They are probably
+	 * wrong, but we need something to keep from crashing again.
+	 */
+	if (!regs)
+		regs = get_irq_regs();
+	if (!regs)
+		regs = task_pt_regs(current);
+
+	if (!cpu_online(cpu))
+		return;
+
+	/* We won't be sent IPIs any more. */
+	set_cpu_online(cpu, false);
+
+	local_irq_disable();
+	if (!cpumask_test_cpu(cpu, &cpus_in_crash))
+		crash_save_cpu(regs, cpu);
+	cpumask_set_cpu(cpu, &cpus_in_crash);
+
+	while (!atomic_read(&kexec_ready_to_reboot))
+		cpu_relax();
+
+	kexec_reboot();
+}
+
+void crash_smp_send_stop(void)
+{
+	unsigned int ncpus;
+	unsigned long timeout;
+	static int cpus_stopped;
+
+	/*
+	 * This function can be called twice in panic path, but obviously
+	 * we should execute this only once.
+	 */
+	if (cpus_stopped)
+		return;
+
+	cpus_stopped = 1;
+
+	 /* Excluding the panic cpu */
+	ncpus = num_online_cpus() - 1;
+
+	smp_call_function(crash_shutdown_secondary, NULL, 0);
+	smp_wmb();
+
+	/*
+	 * The crash CPU sends an IPI and wait for other CPUs to
+	 * respond. Delay of at least 10 seconds.
+	 */
+	timeout = MSEC_PER_SEC * 10;
+	pr_emerg("Sending IPI to other cpus...\n");
+	while ((cpumask_weight(&cpus_in_crash) < ncpus) && timeout--) {
+		mdelay(1);
+		cpu_relax();
+	}
+}
+#endif /* defined(CONFIG_SMP) */
 
 void machine_shutdown(void)
 {
@@ -170,6 +244,19 @@ void machine_shutdown(void)
 
 void machine_crash_shutdown(struct pt_regs *regs)
 {
+	int crashing_cpu;
+
+	local_irq_disable();
+
+	crashing_cpu = smp_processor_id();
+	crash_save_cpu(regs, crashing_cpu);
+
+#ifdef CONFIG_SMP
+	crash_smp_send_stop();
+#endif
+	cpumask_set_cpu(crashing_cpu, &cpus_in_crash);
+
+	pr_info("Starting crashdump kernel...\n");
 }
 
 void machine_kexec(struct kimage *image)
@@ -184,7 +271,8 @@ void machine_kexec(struct kimage *image)
 
 	jump_addr = (unsigned long)phys_to_virt(image->start);
 
-	first_ind_entry = (unsigned long)phys_to_virt(image->head & PAGE_MASK);
+	first_ind_entry = (image->type == KEXEC_TYPE_DEFAULT) ?
+		(unsigned long)phys_to_virt(image->head & PAGE_MASK) : 0;
 
 	/*
 	 * The generic kexec code builds a page list with physical
diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.c
index 7423361b0ebc..0f155e86e2dc 100644
--- a/arch/loongarch/kernel/mem.c
+++ b/arch/loongarch/kernel/mem.c
@@ -5,6 +5,7 @@
 #include <linux/efi.h>
 #include <linux/initrd.h>
 #include <linux/memblock.h>
+#include <linux/of_fdt.h>
 
 #include <asm/bootinfo.h>
 #include <asm/loongson.h>
diff --git a/arch/loongarch/kernel/relocate_kernel.S b/arch/loongarch/kernel/relocate_kernel.S
index 6eaa1eb05d8c..c7d663655246 100644
--- a/arch/loongarch/kernel/relocate_kernel.S
+++ b/arch/loongarch/kernel/relocate_kernel.S
@@ -24,6 +24,12 @@ SYM_CODE_START(relocate_new_kernel)
 	 */
 	move		s0, a4
 
+	/*
+	 * In case of a kdump/crash kernel, the indirection page is not
+	 * populated as the kernel is directly copied to a reserved location
+	 */
+	beqz		s0, done
+
 process_entry:
 	PTR_L		s1, s0, 0
 	PTR_ADDI	s0, s0, SZREG
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 05af1102fee7..cbb485e2477d 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -19,6 +19,8 @@
 #include <linux/memblock.h>
 #include <linux/initrd.h>
 #include <linux/ioport.h>
+#include <linux/kexec.h>
+#include <linux/crash_dump.h>
 #include <linux/root_dev.h>
 #include <linux/console.h>
 #include <linux/pfn.h>
@@ -60,6 +62,8 @@ EXPORT_SYMBOL(cpu_data);
 struct loongson_board_info b_info;
 static const char dmi_empty_string[] = "        ";
 
+static phys_addr_t crashmem_start, crashmem_size;
+
 /*
  * Setup information
  *
@@ -157,16 +161,6 @@ static int __init early_parse_mem(char *p)
 		return -EINVAL;
 	}
 
-	/*
-	 * If a user specifies memory size, we
-	 * blow away any automatically generated
-	 * size.
-	 */
-	if (usermem == 0) {
-		usermem = 1;
-		memblock_remove(memblock_start_of_DRAM(),
-			memblock_end_of_DRAM() - memblock_start_of_DRAM());
-	}
 	start = 0;
 	size = memparse(p, &p);
 	if (*p == '@')
@@ -176,6 +170,23 @@ static int __init early_parse_mem(char *p)
 		return -EINVAL;
 	}
 
+	/*
+	 * If a user specifies memory size, we
+	 * blow away any automatically generated
+	 * size.
+	 */
+	if (usermem == 0) {
+		usermem = 1;
+		if (!strstr(boot_command_line, "elfcorehdr")) {
+			memblock_remove(memblock_start_of_DRAM(),
+				memblock_end_of_DRAM() - memblock_start_of_DRAM());
+		} else {
+			crashmem_start = start;
+			crashmem_size = size;
+			return 0;
+		}
+	}
+
 	if (!IS_ENABLED(CONFIG_NUMA))
 		memblock_add(start, size);
 	else
@@ -185,6 +196,93 @@ static int __init early_parse_mem(char *p)
 }
 early_param("mem", early_parse_mem);
 
+void __init loongarch_reserve_vmcore(void)
+{
+	phys_addr_t start, end;
+	u64 i;
+
+	if (!is_kdump_kernel())
+		return;
+
+	if (!elfcorehdr_size) {
+		for_each_mem_range(i, &start, &end) {
+			if (elfcorehdr_addr >= start && elfcorehdr_addr < end) {
+				/*
+				 * Reserve from the elf core header to the end of
+				 * the memory segment, that should all be kdump
+				 * reserved memory.
+				 */
+				elfcorehdr_size = end - elfcorehdr_addr;
+				break;
+			}
+		}
+	}
+
+	if (memblock_is_region_reserved(elfcorehdr_addr, elfcorehdr_size)) {
+		pr_warn("elfcorehdr is overlapped\n");
+		return;
+	}
+
+	memblock_reserve(elfcorehdr_addr, elfcorehdr_size);
+
+	pr_info("Reserving %llu KiB of memory at 0x%llx for elfcorehdr\n",
+		elfcorehdr_size >> 10, elfcorehdr_addr);
+}
+
+/*
+ * After the kdump operation is performed to enter the capture kernel, the
+ * memory area used by the previous production kernel should be reserved to
+ * avoid destroy to the captured data.
+ */
+static void reserve_oldmem_region(void)
+{
+	if (!is_kdump_kernel())
+		return;
+
+	memblock_cap_memory_range(crashmem_start, crashmem_size);
+}
+
+static void __init loongarch_parse_crashkernel(void)
+{
+#ifdef CONFIG_KEXEC
+	int ret;
+	unsigned long long start;
+	unsigned long long total_mem;
+	unsigned long long crash_size, crash_base;
+
+	total_mem = memblock_phys_mem_size();
+	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
+	if (ret < 0 || crash_size <= 0)
+		return;
+
+
+	start = memblock_phys_alloc_range(crash_size, 1, crash_base, crash_base + crash_size);
+	if (start != crash_base) {
+		pr_warn("Invalid memory region reserved for crash kernel\n");
+		return;
+	}
+
+	crashk_res.start = crash_base;
+	crashk_res.end	 = crash_base + crash_size - 1;
+#endif
+}
+
+static void __init request_crashkernel(struct resource *res)
+{
+#ifdef CONFIG_KEXEC
+	int ret;
+
+	if (crashk_res.start == crashk_res.end)
+		return;
+
+	ret = request_resource(res, &crashk_res);
+	if (!ret)
+		pr_info("Reserving %ldMB of memory at %ldMB for crashkernel\n",
+			(unsigned long)((crashk_res.end - crashk_res.start + 1) >> 20),
+			(unsigned long)(crashk_res.start  >> 20));
+#endif
+}
+
 void __init platform_init(void)
 {
 #ifdef CONFIG_ACPI_TABLE_UPGRADE
@@ -227,6 +325,10 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	check_kernel_sections_mem();
 
+	loongarch_parse_crashkernel();
+	loongarch_reserve_vmcore();
+	reserve_oldmem_region();
+
 	/*
 	 * In order to reduce the possibility of kernel panic when failed to
 	 * get IO TLB memory under CONFIG_SWIOTLB, it is better to allocate
@@ -288,6 +390,7 @@ static void __init resource_init(void)
 		request_resource(res, &code_resource);
 		request_resource(res, &data_resource);
 		request_resource(res, &bss_resource);
+		request_crashkernel(res);
 	}
 }
 
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 950af620e7d0..a692009fee31 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -10,6 +10,7 @@
 #include <linux/entry-common.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kexec.h>
 #include <linux/module.h>
 #include <linux/extable.h>
 #include <linux/mm.h>
@@ -246,6 +247,9 @@ void __noreturn die(const char *str, struct pt_regs *regs)
 
 	oops_exit();
 
+	if (regs && kexec_should_crash(current))
+		crash_kexec(regs);
+
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 
-- 
2.36.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

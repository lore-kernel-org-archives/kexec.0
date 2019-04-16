Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH] RISC-V: Add kexec support
Date: Tue, 16 Apr 2019 16:01:09 +0300
Message-Id: <20190416130109.5314-1-mick@ics.forth.gr>
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
To: linux-riscv@lists.infradead.org
Cc: Nick Kossifidis <mick@ics.forth.gr>, Anup.Patel@wdc.com, palmer@sifive.com, kexec@lists.infradead.org, hch@lst.de

This patch adds support for kexec on RISC-V. For now it doesn't
include kexec_file or kdump / crashkernel support. I tested it
on riscv64 QEMU on both an smp and a non-smp system. On SMP
systems this disables all secondary harts through smp_send_stop(),
until we get support for hart suspend/resume through SBI. The
next kernel will start with "nosmp" appended to its cmdline
as a temporary workaround (this is done on kexec-tools). On
BBL this works fine, on OpenSBI there is an issue with trap
delegation / redirection of *_ACCESS traps, a patch is on the
way.

I submitted the patch for kexec-tools on the kexec list:
http://lists.infradead.org/pipermail/kexec/2019-April/022874.html

Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
---
 arch/riscv/Kconfig                 |  11 ++
 arch/riscv/include/asm/kexec.h     |  43 +++++++
 arch/riscv/kernel/Makefile         |   4 +-
 arch/riscv/kernel/kexec_relocate.S | 175 ++++++++++++++++++++++++++
 arch/riscv/kernel/machine_kexec.c  | 191 +++++++++++++++++++++++++++++
 include/uapi/linux/kexec.h         |   1 +
 6 files changed, 424 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/kexec.h
 create mode 100644 arch/riscv/kernel/kexec_relocate.S
 create mode 100644 arch/riscv/kernel/machine_kexec.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 515fc3cc9..0ed5f6d20 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -228,6 +228,17 @@ menu "Kernel features"
 
 source "kernel/Kconfig.hz"
 
+config KEXEC
+	bool "Kexec system call"
+	select KEXEC_CORE
+	help
+	  kexec is a system call that implements the ability to shutdown your
+	  current kernel, and to start another kernel. It is like a reboot
+	  but it is independent of the system firmware. And like a reboot
+	  you can start any kernel with it, not just Linux.
+
+	  The name comes from the similarity to the exec system call.
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
new file mode 100644
index 000000000..86d2f3c6c
--- /dev/null
+++ b/arch/riscv/include/asm/kexec.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 FORTH-ICS/CARV
+ *		       Nick Kossifidis <mick@ics.forth.gr>
+ */
+
+#ifndef _RISCV_KEXEC_H
+#define _RISCV_KEXEC_H
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
+
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+
+/* Maximum address we can use for the control code buffer */
+#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
+
+/* Reserve a page for the control code buffer */
+#define KEXEC_CONTROL_PAGE_SIZE 4096
+
+#define KEXEC_ARCH KEXEC_ARCH_RISCV
+
+static inline void
+crash_setup_regs(struct pt_regs *newregs,
+		 struct pt_regs *oldregs)
+{
+	/* Dummy implementation for now */
+}
+
+/*
+ * These are defined on kexec_relocate.S
+ * and modified on machine_kexec.c
+ */
+const extern unsigned char riscv_kexec_relocate[];
+const extern unsigned int riscv_kexec_relocate_size;
+
+extern unsigned long riscv_kexec_start_address;
+extern unsigned long riscv_kexec_indirection_page;
+extern unsigned long riscv_kexec_fdt_address;
+extern unsigned long riscv_kexec_hartid;
+
+#endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f13f7f276..de50d5f96 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -40,6 +40,8 @@ obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
-obj-$(CONFIG_PERF_EVENTS)      += perf_event.o
+obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
+
+obj-${CONFIG_KEXEC}		+= kexec_relocate.o machine_kexec.o
 
 clean:
diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
new file mode 100644
index 000000000..fae6b1360
--- /dev/null
+++ b/arch/riscv/kernel/kexec_relocate.S
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 FORTH-ICS/CARV
+ *		       Nick Kossifidis <mick@ics.forth.gr>
+ */
+
+#include <asm/asm.h>	/* For RISCV_* and REG_* macros */
+#include <asm/page.h>	/* For PAGE_SHIFT */
+
+	.globl riscv_kexec_relocate
+riscv_kexec_relocate:
+
+	/*
+	 * s0: Pointer to the current entry
+	 * s1: (const) Phys address to jump to after relocation
+	 * s2: (const) Phys address of the FDT image
+	 * s3: (const) The hartid of the current hart
+	 * s4: Pointer to the destination address for the relocation
+	 * s5: (const) Number of words per page
+	 * s6: (const) 1, used for subtraction
+	 * s7: (const) va_pa_offset, used when switching MMU off
+	 * s8: (const) Physical address of the main loop
+	 * s9: (debug) indirection page counter
+	 * s10: (debug) entry counter
+	 * s11: (debug) copied words counter
+	 */
+	REG_L	s0, riscv_kexec_indirection_page
+	REG_L	s1, riscv_kexec_start_address
+	REG_L	s2, riscv_kexec_fdt_address
+	REG_L	s3, riscv_kexec_hartid
+	mv	s4, zero
+	li	s5, ((1 << PAGE_SHIFT) / RISCV_SZPTR)
+	li	s6, 1
+	REG_L	s7, va_pa_offset
+	mv	s8, zero
+	mv	s9, zero
+	mv	s10, zero
+	mv	s11, zero
+
+	/* Disable / cleanup interrupts */
+	csrw	sie, zero
+	csrw	sip, zero
+
+	/*
+	 * When we switch SATP.MODE to "Bare" we'll only
+	 * play with physical addresses. However the first time
+	 * we try to jump somewhere, the offset on the jump
+	 * will be relative to pc which will still be on VA. To
+	 * deal with this we set stvec to the physical address at
+	 * the start of the loop below so that we jump there in
+	 * any case.
+	 */
+	la	s8, 1f
+	sub	s8, s8, s7
+	csrw	stvec, s8
+
+	/* Process entries in a loop */
+.align 2
+1:
+	addi	s10, s10, 1
+	REG_L	t0, 0(s0)		/* t0 = *image->entry */
+	addi	s0, s0, RISCV_SZPTR	/* image->entry++ */
+
+	/* IND_DESTINATION entry ? -> save destination address */
+	andi	t1, t0, 0x1
+	beqz	t1, 2f
+	andi	s4, t0, ~0x1
+	j	1b
+
+2:
+	/* IND_INDIRECTION entry ? -> update next entry ptr (PA) */
+	andi	t1, t0, 0x2
+	beqz	t1, 2f
+	andi	s0, t0, ~0x2
+	addi	s9, s9, 1
+	csrw	sptbr, zero
+	jalr	zero, s8, 0
+
+2:
+	/* IND_DONE entry ? -> jump to done label */
+	andi	t1, t0, 0x4
+	beqz	t1, 2f
+	j	4f
+
+2:
+	/*
+	 * IND_SOURCE entry ? -> copy page word by word to the
+	 * destination address we got from IND_DESTINATION
+	 */
+	andi	t1, t0, 0x8
+	beqz	t1, 1b		/* Unknown entry type, ignore it */
+	andi	t0, t0, ~0x8
+	mv	t3, s5		/* i = num words per page */
+3:	/* copy loop */
+	REG_L	t1, (t0)	/* t1 = *src_ptr */
+	REG_S	t1, (s4)	/* *dst_ptr = *src_ptr */
+	addi	t0, t0, RISCV_SZPTR /* stc_ptr++ */
+	addi	s4, s4, RISCV_SZPTR /* dst_ptr++ */
+	sub	t3, t3, s6	/* i-- */
+	addi	s11, s11, 1	/* c++ */
+	beqz	t3, 1b		/* copy done ? */
+	j	3b
+
+4:
+	/* Wait for the relocation to be visible by other harts */
+	fence	w,w
+
+	/* Pass the arguments to the next kernel  / Cleanup*/
+	mv	a0, s3
+	mv	a1, s2
+	mv	a2, s1
+
+	/* Cleanup */
+	mv	a3, zero
+	mv	a4, zero
+	mv	a5, zero
+	mv	a6, zero
+	mv	a7, zero
+
+	mv	s0, zero
+	mv	s1, zero
+	mv	s2, zero
+	mv	s3, zero
+	mv	s4, zero
+	mv	s5, zero
+	mv	s6, zero
+	mv	s7, zero
+	mv	s8, zero
+	mv	s9, zero
+	mv	s10, zero
+	mv	s11, zero
+
+	mv	t0, zero
+	mv	t1, zero
+	mv	t2, zero
+	mv	t3, zero
+	mv	t4, zero
+	mv	t5, zero
+	mv	t6, zero
+	csrw	sepc, zero
+	csrw	scause, zero
+	csrw	sscratch, zero
+
+	/*
+	 * Make sure the relocated code is visible
+	 * and jump to the new kernel
+	 */
+	fence.i
+
+	jalr	zero, a2, 0
+
+
+	/* Exported variables, set on machine_kexec.c */
+	.globl riscv_kexec_start_address
+riscv_kexec_start_address:
+	RISCV_PTR	0x0
+
+	.globl riscv_kexec_indirection_page
+riscv_kexec_indirection_page:
+	RISCV_PTR	0x0
+
+	.globl riscv_kexec_fdt_address
+riscv_kexec_fdt_address:
+	RISCV_PTR	0x0
+
+	.globl riscv_kexec_hartid
+riscv_kexec_hartid:
+	RISCV_PTR	0x0
+
+riscv_kexec_relocate_end:
+
+	.globl riscv_kexec_relocate_size
+riscv_kexec_relocate_size:
+	.long riscv_kexec_relocate_end - riscv_kexec_relocate
+
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
new file mode 100644
index 000000000..352bf8219
--- /dev/null
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 FORTH-ICS/CARV
+ *		       Nick Kossifidis <mick@ics.forth.gr>
+ */
+
+#include <linux/kexec.h>
+#include <asm/kexec.h>		/* For riscv_kexec_* symbol defines */
+#include <linux/smp.h>		/* For smp_send_stop () */
+#include <asm/cacheflush.h>	/* For local_flush_icache_all() */
+#include <asm/barrier.h>	/* For smp_wmb() */
+#include <asm/page.h>		/* For PAGE_MASK */
+#include <linux/libfdt.h>	/* For fdt_check_header() */
+
+
+/**
+ * kexec_image_info - Print received image details
+ */
+static void
+kexec_image_info(const struct kimage *image)
+{
+	unsigned long i;
+
+	pr_debug("Kexec image info:\n");
+	pr_debug("\ttype:        %d\n", image->type);
+	pr_debug("\tstart:       %lx\n", image->start);
+	pr_debug("\thead:        %lx\n", image->head);
+	pr_debug("\tnr_segments: %lu\n", image->nr_segments);
+
+	for (i = 0; i < image->nr_segments; i++) {
+		pr_debug("\t    segment[%lu]: %016lx - %016lx", i,
+			image->segment[i].mem,
+			image->segment[i].mem + image->segment[i].memsz);
+		pr_debug("\t\t0x%lx bytes, %lu pages\n",
+			(unsigned long) image->segment[i].memsz,
+			(unsigned long) image->segment[i].memsz /  PAGE_SIZE);
+	}
+}
+
+/**
+ * machine_kexec_prepare - Initialize kexec
+ *
+ * This function is called from do_kexec_load, when the user has
+ * provided us with an image to be loaded. Its goal is to validate
+ * the image and prepare the control code buffer as needed.
+ * Note that kimage_alloc_init has already been called and the
+ * control buffer has already been allocated.
+ */
+int
+machine_kexec_prepare(struct kimage *image)
+{
+	struct fdt_header fdt = {0};
+	void *control_code_buffer = NULL;
+	int i = 0;
+
+	riscv_kexec_start_address = 0;
+	riscv_kexec_indirection_page = 0;
+	riscv_kexec_fdt_address = 0;
+
+	kexec_image_info(image);
+
+	if (image->type == KEXEC_TYPE_CRASH) {
+		pr_warn("Loading a crash kernel is unsupported for now.\n");
+		return -EINVAL;
+	}
+
+	/* Find the Flattened Device Tree */
+	for (i = 0; i < image->nr_segments; i++) {
+		if (image->segment[i].memsz <= sizeof(fdt))
+			continue;
+
+		if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
+			continue;
+
+		if (fdt_check_header(&fdt))
+			continue;
+
+		riscv_kexec_fdt_address = (unsigned long) image->segment[i].mem;
+		break;
+	}
+
+	if (!riscv_kexec_fdt_address) {
+		pr_err("Device tree not included in the provided image\n");
+		return -EINVAL;
+	}
+
+	/* Initialize the rest of the arguments for the relocation code */
+	riscv_kexec_start_address = (unsigned long) image->start;
+	riscv_kexec_indirection_page = (unsigned long) &image->head;
+
+	/* Copy the assembler code for relocation to the control buffer */
+	control_code_buffer = page_address(image->control_code_page);
+	memcpy(control_code_buffer, riscv_kexec_relocate,
+		riscv_kexec_relocate_size);
+
+#ifdef CONFIG_SMP
+	/*
+	 * Make sure other harts see the copied data
+	 * if they try to read the buffer
+	 */
+	smp_wmb();
+#endif
+
+	return 0;
+}
+
+
+/**
+ * machine_kexec_cleanup - Cleanup any leftovers from
+ *			   machine_kexec_prepare
+ *
+ * This function is called by kimage_free to handle any arch-specific
+ * allocations done on machine_kexec_prepare. Since we didn't do any
+ * allocations there, this is just an empty function. Note that the
+ * control buffer is freed by kimage_free.
+ */
+void
+machine_kexec_cleanup(struct kimage *image)
+{
+}
+
+
+/*
+ * machine_shutdown - Prepare for a kexec reboot
+ *
+ * This function is called by kernel_kexec just before machine_kexec
+ * below. Its goal is to prepare the rest of the system (the other
+ * harts and possibly devices etc) for a kexec reboot. Since on kexec
+ * the current kernel will be lost, the other harts on the system won't
+ * know what to run and will hang in an unrecoverable way. Until we
+ * support CPU suspend through SBI we just stop all other harts by
+ * forcing them on an infinite wfi loop with interrupts disabled.
+ */
+void machine_shutdown(void)
+{
+#ifdef CONFIG_SMP
+	pr_notice("Stopping secondary harts\n");
+	smp_send_stop();
+#endif
+}
+
+/**
+ * machine_crash_shutdown - Prepare to kexec after a kernel crash
+ *
+ * This function is called by crash_kexec just before machine_kexec
+ * below and its goal is similar to machine_shutdown, but in case of
+ * a kernel crash. Since we don't handle such cases yet, this function
+ * is empty.
+ */
+void
+machine_crash_shutdown(struct pt_regs *regs)
+{
+}
+
+/**
+ * machine_kexec - Jump to the loaded kimage
+ *
+ * This function is called by kernel_kexec which is called by the
+ * reboot system call when the reboot cmd is LINUX_REBOOT_CMD_KEXEC,
+ * or by crash_kernel which is called by the kernel's arch-specific
+ * trap handler in case of a kernel panic. It's the final stage of
+ * the kexec process where the pre-loaded kimage is ready to be
+ * executed. We assume at this point that all other harts are
+ * suspended and this hart will be the new boot hart.
+ */
+void
+machine_kexec(struct kimage *image)
+{
+	void (*do_relocate)(void) __noreturn;
+	void *control_code_buffer = NULL;
+
+	control_code_buffer = page_address(image->control_code_page);
+	do_relocate = control_code_buffer;
+
+	/* Pass the current hart's id to the next kernel */
+	riscv_kexec_hartid = raw_smp_processor_id();
+
+	pr_notice("Will call new kernel at %08lx from hart id %lx\n",
+		  riscv_kexec_start_address, riscv_kexec_hartid);
+	pr_notice("FDT image at %08lx\n", riscv_kexec_fdt_address);
+
+	/* We can't be interrupted during reboot */
+	local_irq_disable();
+
+	/* Make sure the relocation code is visible to the hart */
+	local_flush_icache_all();
+
+	/* Jump to the relocation code */
+	pr_notice("Bye...\n");
+	do_relocate();
+}
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 6d1128682..87af2f17a 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -41,6 +41,7 @@
 #define KEXEC_ARCH_MIPS_LE (10 << 16)
 #define KEXEC_ARCH_MIPS    ( 8 << 16)
 #define KEXEC_ARCH_AARCH64 (183 << 16)
+#define KEXEC_ARCH_RISCV   (243 << 16)
 
 /* The artificial cap on the number of segments passed to kexec_load. */
 #define KEXEC_SEGMENT_MAX 16
-- 
2.21.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0936DC54EE9
	for <kexec@archiver.kernel.org>; Wed, 28 Sep 2022 02:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cqOvZyDkA7L9G1GhKt5jnRJn619xUYUY1MAe9myE6ww=; b=lumeMqcS01Ut09
	DM2R6XLc2udqyHh5nb8poq8ts7k8LI+f3fhGuPvwX54QLhAe71gmqnXjcW2gduspyNEnXFqu1kzQF
	55FY4ifIUqovtWaV3gPPQ1RaQUiWIduTy2PVGiaO3n8HirvWnU7hrTDCa1oWsQO7zp0DarRfuInjK
	hrhJgoHwz0xs94PV3UIbJk+lwts/49hSyj7OJ3ACUwxhzWOdtjsG8enld9XVCGQUv3oXldI34o6T0
	eMW/CptG8rScO1u3a6D5Ev+QVuS1c+XtZkN4TLL+s7avzPpphVOC4YoOAwsrKSqzdwgsugtfs2vCT
	3nOmV4qE4Cu4ssGu01/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odMoZ-00DaO8-2S; Wed, 28 Sep 2022 02:28:47 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odMoQ-00DaDC-3Z
	for kexec@lists.infradead.org; Wed, 28 Sep 2022 02:28:43 +0000
Received: from bogon.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOJKsTNjXAwjAA--.65269S4;
	Wed, 28 Sep 2022 10:28:29 +0800 (CST)
From: Youling Tang <tangyouling@loongson.cn>
To: horms@kernel.org
Cc: kexec@lists.infradead.org,
	Simon Horman <horms@verge.net.au>,
	Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 2/5] LoongArch: Add kexec/kdump support
Date: Wed, 28 Sep 2022 10:28:23 +0800
Message-Id: <1664332106-4845-3-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
References: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8DxBOJKsTNjXAwjAA--.65269S4
X-Coremail-Antispam: 1UD129KBjvAXoWfWFWrZrykGw1ftw17Ar1rXrb_yoW5AF1fto
	W7ZF45tr48Wr92yw1rGr1SqF90gryDCr4UA34fAF9IgF4IyryUJFyDGryayry7Jwn5W3y5
	u3yjqrnxJayxJr1kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYC7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
	x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87
	I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY
	1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20x
	vEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8JwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07brv3nUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_192838_609575_DBA76DB5 
X-CRM114-Status: GOOD (  30.32  )
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

Add the 64-bit processing support of the LoongArch architecture. For the time
being, the quick restart function(kexec) is supported. That is, the "kexec -l"
and "kexec -e" commands can be used normally.

At the same time, the crash dump function also supports, "kexec -p" operation
can be successfully performed, and the vmcore file can be generated.

I tested this on  LoongArch 3A5000 machine and works as expected,

kexec:
  $ sudo kexec -l /boot/vmlinux --reuse-cmdline
  $ sudo kexec -e

kdump:
  $ sudo kexec -p /boot/vmlinux-kdump --reuse-cmdline --append="nr_cpus=1"
  # echo c > /proc/sysrq_trigger

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 configure.ac                                  |   3 +
 include/elf.h                                 |   1 +
 include/image.h                               |   1 +
 kexec/Makefile                                |   1 +
 kexec/arch/loongarch/Makefile                 |  20 +
 kexec/arch/loongarch/crashdump-loongarch.c    | 198 ++++++++++
 kexec/arch/loongarch/crashdump-loongarch.h    |  25 ++
 kexec/arch/loongarch/include/arch/options.h   |  28 ++
 kexec/arch/loongarch/iomem.h                  |  10 +
 kexec/arch/loongarch/kexec-elf-loongarch.c    | 114 ++++++
 .../arch/loongarch/kexec-elf-rel-loongarch.c  |  42 +++
 kexec/arch/loongarch/kexec-loongarch.c        | 353 ++++++++++++++++++
 kexec/arch/loongarch/kexec-loongarch.h        |  51 +++
 kexec/kexec-syscall.h                         |   7 +
 14 files changed, 854 insertions(+)
 create mode 100644 kexec/arch/loongarch/Makefile
 create mode 100644 kexec/arch/loongarch/crashdump-loongarch.c
 create mode 100644 kexec/arch/loongarch/crashdump-loongarch.h
 create mode 100644 kexec/arch/loongarch/include/arch/options.h
 create mode 100644 kexec/arch/loongarch/iomem.h
 create mode 100644 kexec/arch/loongarch/kexec-elf-loongarch.c
 create mode 100644 kexec/arch/loongarch/kexec-elf-rel-loongarch.c
 create mode 100644 kexec/arch/loongarch/kexec-loongarch.c
 create mode 100644 kexec/arch/loongarch/kexec-loongarch.h

diff --git a/configure.ac b/configure.ac
index 0d825ef..819df6b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -58,6 +58,9 @@ case $target_cpu in
 	hppa*)
 		ARCH="hppa"
 		;;
+	loongarch*)
+		ARCH="loongarch"
+		;;
 	* )
 		AC_MSG_ERROR([unsupported architecture $target_cpu])
 		;;
diff --git a/include/elf.h b/include/elf.h
index b7677a2..1c8d2cc 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -259,6 +259,7 @@ typedef struct
 #define EM_ARC_A5	93		/* ARC Cores Tangent-A5 */
 #define EM_XTENSA	94		/* Tensilica Xtensa Architecture */
 #define EM_AARCH64	183		/* ARM AARCH64 */
+#define EM_LOONGARCH	258		/* Loongson Loongarch*/
 #define EM_NUM		184
 
 /* If it is necessary to assign new unofficial EM_* values, please
diff --git a/include/image.h b/include/image.h
index 8e9d81e..7a4bccf 100644
--- a/include/image.h
+++ b/include/image.h
@@ -86,6 +86,7 @@
 #define IH_ARCH_ARC		23	/* Synopsys DesignWare ARC */
 #define IH_ARCH_X86_64		24	/* AMD x86_64, Intel and Via */
 #define IH_ARCH_XTENSA		25	/* Xtensa       */
+#define IH_ARCH_LOONGARCH	26	/* LoongArch Loongson */
 
 /*
  * Image Types
diff --git a/kexec/Makefile b/kexec/Makefile
index e69e309..8a52e8d 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -92,6 +92,7 @@ include $(srcdir)/kexec/arch/s390/Makefile
 include $(srcdir)/kexec/arch/sh/Makefile
 include $(srcdir)/kexec/arch/x86_64/Makefile
 include $(srcdir)/kexec/arch/hppa/Makefile
+include $(srcdir)/kexec/arch/loongarch/Makefile
 
 KEXEC_SRCS += $($(ARCH)_KEXEC_SRCS)
 
diff --git a/kexec/arch/loongarch/Makefile b/kexec/arch/loongarch/Makefile
new file mode 100644
index 0000000..e5e190a
--- /dev/null
+++ b/kexec/arch/loongarch/Makefile
@@ -0,0 +1,20 @@
+#
+# kexec loongarch (linux booting linux)
+#
+loongarch_KEXEC_SRCS =  kexec/arch/loongarch/kexec-loongarch.c
+loongarch_KEXEC_SRCS += kexec/arch/loongarch/kexec-elf-loongarch.c
+loongarch_KEXEC_SRCS += kexec/arch/loongarch/kexec-elf-rel-loongarch.c
+loongarch_KEXEC_SRCS += kexec/arch/loongarch/crashdump-loongarch.c
+
+loongarch_MEM_REGIONS = kexec/mem_regions.c
+
+loongarch_CPPFLAGS += -I $(srcdir)/kexec/
+
+loongarch_ADD_BUFFER =
+loongarch_ADD_SEGMENT =
+loongarch_VIRT_TO_PHYS =
+
+dist += kexec/arch/loongarch/Makefile $(loongarch_KEXEC_SRCS)			\
+	kexec/arch/loongarch/kexec-loongarch.h					\
+	kexec/arch/loongarch/crashdump-loongarch.h				\
+	kexec/arch/loongarch/include/arch/options.h
diff --git a/kexec/arch/loongarch/crashdump-loongarch.c b/kexec/arch/loongarch/crashdump-loongarch.c
new file mode 100644
index 0000000..aaf6cf3
--- /dev/null
+++ b/kexec/arch/loongarch/crashdump-loongarch.c
@@ -0,0 +1,198 @@
+/*
+ * LoongArch crashdump.
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited.
+ *   Youling Tang <tangyouling@loongson.cn>
+ *
+ * derived from crashdump-arm64.c
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <linux/elf.h>
+
+#include "kexec.h"
+#include "crashdump.h"
+#include "crashdump-loongarch.h"
+#include "iomem.h"
+#include "kexec-loongarch.h"
+#include "kexec-elf.h"
+#include "mem_regions.h"
+
+/* memory ranges of crashed kernel */
+static struct memory_ranges system_memory_rgns;
+
+/* memory range reserved for crashkernel */
+struct memory_range crash_reserved_mem[CRASH_MAX_RESERVED_RANGES];
+struct memory_ranges usablemem_rgns = {
+	.size = 0,
+	.max_size = CRASH_MAX_RESERVED_RANGES,
+	.ranges = crash_reserved_mem,
+};
+
+struct memory_range elfcorehdr_mem;
+
+static struct crash_elf_info elf_info64 = {
+	.class		= ELFCLASS64,
+	.data		= ELFDATA2LSB,
+	.machine	= EM_LOONGARCH,
+	.page_offset	= PAGE_OFFSET,
+};
+
+/*
+ * iomem_range_callback() - callback called for each iomem region
+ * @data: not used
+ * @nr: not used
+ * @str: name of the memory region
+ * @base: start address of the memory region
+ * @length: size of the memory region
+ *
+ * This function is called once for each memory region found in /proc/iomem.
+ * It locates system RAM and crashkernel reserved memory and places these to
+ * variables, respectively, system_memory_rgns and usablemem_rgns.
+ */
+
+static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
+				char *str, unsigned long long base,
+				unsigned long long length)
+{
+	if (strncmp(str, CRASH_KERNEL, strlen(CRASH_KERNEL)) == 0)
+		return mem_regions_alloc_and_add(&usablemem_rgns,
+						base, length, RANGE_RAM);
+	else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0)
+		return mem_regions_alloc_and_add(&system_memory_rgns,
+						base, length, RANGE_RAM);
+	else if (strncmp(str, KERNEL_CODE, strlen(KERNEL_CODE)) == 0)
+		elf_info64.kern_paddr_start = base;
+	else if (strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)) == 0)
+		elf_info64.kern_size = base + length - elf_info64.kern_paddr_start;
+
+	return 0;
+}
+
+int is_crashkernel_mem_reserved(void)
+{
+	if (!usablemem_rgns.size)
+		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
+
+	return usablemem_rgns.size;
+}
+
+/*
+ * crash_get_memory_ranges() - read system physical memory
+ *
+ * Function reads through system physical memory and stores found memory
+ * regions in system_memory_ranges.
+ * Regions are sorted in ascending order.
+ *
+ * Returns 0 in case of success and a negative value otherwise.
+ */
+static int crash_get_memory_ranges(void)
+{
+	int i;
+
+	/*
+	 * First read all memory regions that can be considered as
+	 * system memory including the crash area.
+	 */
+	if (!usablemem_rgns.size)
+		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
+
+	/* allow one or two regions for crash dump kernel */
+	if (!usablemem_rgns.size)
+		return -EINVAL;
+
+	dbgprint_mem_range("Reserved memory range",
+			usablemem_rgns.ranges, usablemem_rgns.size);
+
+	for (i = 0; i < usablemem_rgns.size; i++) {
+		if (mem_regions_alloc_and_exclude(&system_memory_rgns,
+					&crash_reserved_mem[i])) {
+			fprintf(stderr, "Cannot allocate memory for ranges\n");
+			return -ENOMEM;
+		}
+	}
+
+	/*
+	 * Make sure that the memory regions are sorted.
+	 */
+	mem_regions_sort(&system_memory_rgns);
+
+	dbgprint_mem_range("Coredump memory ranges",
+			   system_memory_rgns.ranges, system_memory_rgns.size);
+
+	/*
+	 * For additional kernel code/data segment.
+	 * kern_paddr_start/kern_size are determined in iomem_range_callback
+	 */
+	elf_info64.kern_vaddr_start = get_kernel_sym("_text");
+	if (!elf_info64.kern_vaddr_start)
+		elf_info64.kern_vaddr_start = UINT64_MAX;
+
+	return 0;
+}
+
+/*
+ * load_crashdump_segments() - load the elf core header
+ * @info: kexec info structure
+ *
+ * This function creates and loads an additional segment of elf core header
+ : which is used to construct /proc/vmcore on crash dump kernel.
+ *
+ * Return 0 in case of success and -1 in case of error.
+ */
+
+int load_crashdump_segments(struct kexec_info *info)
+{
+	unsigned long elfcorehdr;
+	unsigned long bufsz;
+	void *buf;
+	int err;
+
+	/*
+	 * First fetch all the memory (RAM) ranges that we are going to
+	 * pass to the crash dump kernel during panic.
+	 */
+
+	err = crash_get_memory_ranges();
+
+	if (err)
+		return EFAILED;
+
+	err = crash_create_elf64_headers(info, &elf_info64,
+			system_memory_rgns.ranges, system_memory_rgns.size,
+			&buf, &bufsz, ELF_CORE_HEADER_ALIGN);
+
+	if (err)
+		return EFAILED;
+
+	elfcorehdr = add_buffer(info, buf, bufsz, bufsz, 1024,
+		crash_reserved_mem[usablemem_rgns.size - 1].start,
+		crash_reserved_mem[usablemem_rgns.size - 1].end, -1);
+
+	elfcorehdr_mem.start = elfcorehdr;
+	elfcorehdr_mem.end = elfcorehdr + bufsz - 1;
+
+	dbgprintf("%s: elfcorehdr 0x%llx-0x%llx\n", __func__,
+			elfcorehdr_mem.start, elfcorehdr_mem.end);
+
+	return 0;
+}
+
+int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
+{
+	if (!usablemem_rgns.size)
+		kexec_iomem_for_each_line(NULL, iomem_range_callback, NULL);
+
+	if (!usablemem_rgns.size)
+		return -1;
+
+	*start = crash_reserved_mem[usablemem_rgns.size - 1].start;
+	*end = crash_reserved_mem[usablemem_rgns.size - 1].end;
+
+	return 0;
+}
diff --git a/kexec/arch/loongarch/crashdump-loongarch.h b/kexec/arch/loongarch/crashdump-loongarch.h
new file mode 100644
index 0000000..3eb4e0a
--- /dev/null
+++ b/kexec/arch/loongarch/crashdump-loongarch.h
@@ -0,0 +1,25 @@
+#ifndef CRASHDUMP_LOONGARCH_H
+#define CRASHDUMP_LOONGARCH_H
+
+struct kexec_info;
+extern struct memory_ranges usablemem_rgns;
+extern struct memory_range crash_reserved_mem[];
+extern struct memory_range elfcorehdr_mem;
+
+int load_crashdump_segments(struct kexec_info *info);
+int is_crashkernel_mem_reserved(void);
+int get_crash_kernel_load_range(uint64_t *start, uint64_t *end);
+
+#define PAGE_OFFSET	0x9000000000000000ULL
+#define MAXMEM		0
+
+#define CRASH_MAX_MEMMAP_NR	(KEXEC_MAX_SEGMENTS + 1)
+#define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
+
+/* crash dump kernel support at most two regions, low_region and high region. */
+#define CRASH_MAX_RESERVED_RANGES      2
+
+#define COMMAND_LINE_SIZE	512
+
+extern struct arch_options_t arch_options;
+#endif /* CRASHDUMP_LOONGARCH_H */
diff --git a/kexec/arch/loongarch/include/arch/options.h b/kexec/arch/loongarch/include/arch/options.h
new file mode 100644
index 0000000..25a7dc1
--- /dev/null
+++ b/kexec/arch/loongarch/include/arch/options.h
@@ -0,0 +1,28 @@
+#ifndef KEXEC_ARCH_LOONGARCH_OPTIONS_H
+#define KEXEC_ARCH_LOONGARCH_OPTIONS_H
+
+#define OPT_APPEND		((OPT_MAX)+0)
+#define OPT_INITRD		((OPT_MAX)+1)
+#define OPT_REUSE_CMDLINE	((OPT_MAX)+2)
+#define OPT_ARCH_MAX		((OPT_MAX)+3)
+
+#define KEXEC_ARCH_OPTIONS \
+	KEXEC_OPTIONS \
+	{ "append",        1, NULL, OPT_APPEND }, \
+	{ "command-line",  1, NULL, OPT_APPEND }, \
+	{ "initrd",        1, NULL, OPT_INITRD }, \
+	{ "ramdisk",       1, NULL, OPT_INITRD }, \
+	{ "reuse-cmdline", 0, NULL, OPT_REUSE_CMDLINE }, \
+
+#define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR /* Only accept long arch options. */
+#define KEXEC_ALL_OPTIONS KEXEC_ARCH_OPTIONS
+#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR
+
+static const char loongarch_opts_usage[] __attribute__ ((unused)) =
+"     --append=STRING       Set the kernel command line to STRING.\n"
+"     --command-line=STRING Set the kernel command line to STRING.\n"
+"     --initrd=FILE         Use FILE as the kernel initial ramdisk.\n"
+"     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
+"     --reuse-cmdline       Use kernel command line from running system.\n";
+
+#endif /* KEXEC_ARCH_LOONGARCH_OPTIONS_H */
diff --git a/kexec/arch/loongarch/iomem.h b/kexec/arch/loongarch/iomem.h
new file mode 100644
index 0000000..7671e26
--- /dev/null
+++ b/kexec/arch/loongarch/iomem.h
@@ -0,0 +1,10 @@
+#ifndef IOMEM_H
+#define IOMEM_H
+
+#define SYSTEM_RAM		"System RAM\n"
+#define KERNEL_CODE		"Kernel code\n"
+#define KERNEL_DATA		"Kernel data\n"
+#define CRASH_KERNEL		"Crash kernel\n"
+#define IOMEM_RESERVED		"Reserved\n"
+
+#endif
diff --git a/kexec/arch/loongarch/kexec-elf-loongarch.c b/kexec/arch/loongarch/kexec-elf-loongarch.c
new file mode 100644
index 0000000..a5ec356
--- /dev/null
+++ b/kexec/arch/loongarch/kexec-elf-loongarch.c
@@ -0,0 +1,114 @@
+/*
+ * kexec-elf-loongarch.c - kexec Elf loader for loongarch
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited.
+ *   Youling Tang <tangyouling@loongson.cn>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+*/
+
+#define _GNU_SOURCE
+
+#include <limits.h>
+#include <errno.h>
+#include <elf.h>
+
+#include "kexec.h"
+#include "kexec-elf.h"
+#include "kexec-syscall.h"
+#include "crashdump-loongarch.h"
+#include "kexec-loongarch.h"
+#include "arch/options.h"
+
+off_t initrd_base, initrd_size;
+
+int elf_loongarch_probe(const char *kernel_buf, off_t kernel_size)
+{
+	struct mem_ehdr ehdr;
+	int result;
+
+	result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
+	if (result < 0) {
+		dbgprintf("%s: Not an ELF executable.\n", __func__);
+		goto out;
+	}
+
+	/* Verify the architecuture specific bits. */
+	if (ehdr.e_machine != EM_LOONGARCH) {
+		dbgprintf("%s: Not an LoongArch ELF executable.\n", __func__);
+		result = -1;
+		goto out;
+	}
+
+	result = 0;
+out:
+	free_elf_info(&ehdr);
+	return result;
+}
+
+int elf_loongarch_load(int argc, char **argv, const char *kernel_buf,
+	off_t kernel_size, struct kexec_info *info)
+{
+	unsigned long kernel_segment;
+	struct mem_ehdr ehdr;
+	int result;
+
+	result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
+
+	if (result < 0) {
+		dbgprintf("%s: build_elf_exec_info failed\n", __func__);
+		goto exit;
+	}
+
+	kernel_segment = loongarch_locate_kernel_segment(info);
+
+	if (kernel_segment == ULONG_MAX) {
+		dbgprintf("%s: Kernel segment is not allocated\n", __func__);
+		result = EFAILED;
+		goto exit;
+	}
+
+	dbgprintf("%s: kernel_segment: %016lx\n", __func__, kernel_segment);
+	dbgprintf("%s: image_size:     %016lx\n", __func__,
+		kernel_size);
+	dbgprintf("%s: text_offset:    %016lx\n", __func__,
+		loongarch_mem.text_offset);
+	dbgprintf("%s: phys_offset:    %016lx\n", __func__,
+		loongarch_mem.phys_offset);
+
+	/* create and initialize elf core header segment */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		result = load_crashdump_segments(info);
+		if (result) {
+			dbgprintf("%s: Creating eflcorehdr failed.\n",
+								__func__);
+			goto exit;
+		}
+	}
+
+	info->entry = (void *)virt_to_phys(ehdr.e_entry);
+
+	result = elf_exec_load(&ehdr, info);
+
+	if (result) {
+		dbgprintf("%s: elf_exec_load failed\n", __func__);
+		goto exit;
+	}
+
+	/* load additional data */
+	result = loongarch_load_other_segments(info, kernel_segment + kernel_size);
+
+exit:
+	free_elf_info(&ehdr);
+	if (result)
+		fprintf(stderr, "kexec: Bad elf image file, load failed.\n");
+	return result;
+}
+
+void elf_loongarch_usage(void)
+{
+	printf(
+"     An LoongArch ELF image, little endian.\n"
+"     Typically vmlinux or a stripped version of vmlinux.\n\n");
+}
diff --git a/kexec/arch/loongarch/kexec-elf-rel-loongarch.c b/kexec/arch/loongarch/kexec-elf-rel-loongarch.c
new file mode 100644
index 0000000..59f7f5d
--- /dev/null
+++ b/kexec/arch/loongarch/kexec-elf-rel-loongarch.c
@@ -0,0 +1,42 @@
+/*
+ * kexec-elf-rel-loongarch.c - kexec Elf relocation routines
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited.
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+*/
+
+#include <stdio.h>
+#include <elf.h>
+#include "../../kexec.h"
+#include "../../kexec-elf.h"
+
+int machine_verify_elf_rel(struct mem_ehdr *ehdr)
+{
+	if (ehdr->ei_data != ELFDATA2MSB)
+		return 0;
+
+	if (ehdr->ei_class != ELFCLASS32)
+		return 0;
+
+	if (ehdr->e_machine != EM_LOONGARCH)
+		return 0;
+
+	return 1;
+}
+
+void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
+			   struct mem_sym *UNUSED(sym),
+			   unsigned long r_type,
+			   void *UNUSED(location),
+			   unsigned long UNUSED(address),
+			   unsigned long UNUSED(value))
+{
+	switch (r_type) {
+
+	default:
+		die("Unknown rela relocation: %lu\n", r_type);
+		break;
+	}
+}
diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
new file mode 100644
index 0000000..ce7db2c
--- /dev/null
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -0,0 +1,353 @@
+/*
+ * kexec-loongarch.c - kexec for loongarch
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited.
+ *   Youling Tang <tangyouling@loongson.cn>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <assert.h>
+#include <errno.h>
+#include <getopt.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <linux/elf-em.h>
+#include <elf.h>
+#include <elf_info.h>
+
+#include "kexec.h"
+#include "kexec-loongarch.h"
+#include "crashdump-loongarch.h"
+#include "iomem.h"
+#include "kexec-syscall.h"
+#include "mem_regions.h"
+#include "arch/options.h"
+
+#define CMDLINE_PREFIX "kexec "
+static char cmdline[COMMAND_LINE_SIZE] = CMDLINE_PREFIX;
+
+/* Adds "initrd=start,size" parameters to command line. */
+static int cmdline_add_initrd(char *cmdline, unsigned long addr,
+		unsigned long size)
+{
+	int cmdlen, len;
+	char str[50], *ptr;
+
+	ptr = str;
+	strcpy(str, " initrd=");
+	ptr += strlen(str);
+	ultoa(addr, ptr);
+	strcat(str, ",");
+	ptr = str + strlen(str);
+	ultoa(size, ptr);
+	len = strlen(str);
+	cmdlen = strlen(cmdline) + len;
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str);
+
+	return 0;
+}
+
+/* Adds the appropriate "mem=size@start" options to command line, indicating the
+ * memory region the new kernel can use to boot into. */
+static int cmdline_add_mem(char *cmdline, unsigned long addr,
+		unsigned long size)
+{
+	int cmdlen, len;
+	char str[50], *ptr;
+
+	addr = addr/1024;
+	size = size/1024;
+	ptr = str;
+	strcpy(str, " mem=");
+	ptr += strlen(str);
+	ultoa(size, ptr);
+	strcat(str, "K@");
+	ptr = str + strlen(str);
+	ultoa(addr, ptr);
+	strcat(str, "K");
+	len = strlen(str);
+	cmdlen = strlen(cmdline) + len;
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str);
+
+	return 0;
+}
+
+/* Adds the "elfcorehdr=size@start" command line parameter to command line. */
+static int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr,
+			unsigned long size)
+{
+	int cmdlen, len;
+	char str[50], *ptr;
+
+	addr = addr/1024;
+	size = size/1024;
+	ptr = str;
+	strcpy(str, " elfcorehdr=");
+	ptr += strlen(str);
+	ultoa(size, ptr);
+	strcat(str, "K@");
+	ptr = str + strlen(str);
+	ultoa(addr, ptr);
+	strcat(str, "K");
+	len = strlen(str);
+	cmdlen = strlen(cmdline) + len;
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str);
+
+	return 0;
+}
+
+/* Return a sorted list of memory ranges. */
+static struct memory_range memory_range[MAX_MEMORY_RANGES];
+
+int get_memory_ranges(struct memory_range **range, int *ranges,
+		      unsigned long UNUSED(kexec_flags))
+{
+	int memory_ranges = 0;
+
+	const char *iomem = proc_iomem();
+	char line[MAX_LINE];
+	FILE *fp;
+	unsigned long long start, end;
+	char *str;
+	int type, consumed, count;
+
+	fp = fopen(iomem, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s: %s\n", iomem, strerror(errno));
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), fp) != 0) {
+		if (memory_ranges >= MAX_MEMORY_RANGES)
+			break;
+		count = sscanf(line, "%llx-%llx : %n", &start, &end, &consumed);
+		if (count != 2)
+			continue;
+		str = line + consumed;
+		end = end + 1;
+		if (!strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)))
+			type = RANGE_RAM;
+		else if (!strncmp(str, IOMEM_RESERVED, strlen(IOMEM_RESERVED)))
+			type = RANGE_RESERVED;
+		else
+			continue;
+
+		if (memory_ranges > 0 &&
+		    memory_range[memory_ranges - 1].end == start &&
+		    memory_range[memory_ranges - 1].type == type) {
+			memory_range[memory_ranges - 1].end = end;
+		} else {
+			memory_range[memory_ranges].start = start;
+			memory_range[memory_ranges].end = end;
+			memory_range[memory_ranges].type = type;
+			memory_ranges++;
+		}
+	}
+	fclose(fp);
+	*range = memory_range;
+	*ranges = memory_ranges;
+
+	dbgprint_mem_range("MEMORY RANGES:", *range, *ranges);
+	return 0;
+}
+
+struct file_type file_type[] = {
+	{"elf-loongarch", elf_loongarch_probe, elf_loongarch_load, elf_loongarch_usage},
+};
+int file_types = sizeof(file_type) / sizeof(file_type[0]);
+
+/* loongarch global varables. */
+
+struct loongarch_mem loongarch_mem;
+
+void arch_usage(void)
+{
+	printf(loongarch_opts_usage);
+}
+
+struct arch_options_t arch_options = {
+	.core_header_type = CORE_TYPE_ELF64,
+};
+
+int arch_process_options(int argc, char **argv)
+{
+	static const char short_options[] = KEXEC_ARCH_OPT_STR "";
+	static const struct option options[] = {
+		KEXEC_ARCH_OPTIONS
+		{ 0 },
+	};
+	int opt;
+	char *cmdline = NULL;
+	const char *append = NULL;
+
+	while ((opt = getopt_long(argc, argv, short_options,
+				  options, 0)) != -1) {
+		switch (opt) {
+		case OPT_APPEND:
+			append = optarg;
+			break;
+		case OPT_REUSE_CMDLINE:
+			cmdline = get_command_line();
+			break;
+		case OPT_INITRD:
+			arch_options.initrd_file = optarg;
+			break;
+		default:
+			break;
+		}
+	}
+
+	arch_options.command_line = concat_cmdline(cmdline, append);
+
+	dbgprintf("%s:%d: command_line: %s\n", __func__, __LINE__,
+		arch_options.command_line);
+	dbgprintf("%s:%d: initrd: %s\n", __func__, __LINE__,
+		arch_options.initrd_file);
+
+	return 0;
+}
+
+const struct arch_map_entry arches[] = {
+	{ "loongarch64", KEXEC_ARCH_LOONGARCH },
+	{ NULL, 0 },
+};
+
+unsigned long loongarch_locate_kernel_segment(struct kexec_info *info)
+{
+	unsigned long hole;
+
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		unsigned long hole_end;
+
+		hole = (crash_reserved_mem[usablemem_rgns.size - 1].start < mem_min ?
+				mem_min : crash_reserved_mem[usablemem_rgns.size - 1].start);
+		hole = _ALIGN_UP(hole, MiB(1));
+		hole_end = hole + loongarch_mem.text_offset + loongarch_mem.image_size;
+
+		if ((hole_end > mem_max) ||
+		    (hole_end > crash_reserved_mem[usablemem_rgns.size - 1].end)) {
+			dbgprintf("%s: Crash kernel out of range\n", __func__);
+			hole = ULONG_MAX;
+		}
+	} else {
+		hole = locate_hole(info,
+			loongarch_mem.text_offset + loongarch_mem.image_size,
+			MiB(1), 0, ULONG_MAX, 1);
+
+		if (hole == ULONG_MAX)
+			dbgprintf("%s: locate_hole failed\n", __func__);
+	}
+
+	return hole;
+}
+
+/*
+ * loongarch_load_other_segments - Prepare the initrd and cmdline segments.
+ */
+
+int loongarch_load_other_segments(struct kexec_info *info, unsigned long hole_min)
+{
+	unsigned long initrd_min, hole_max;
+	char *initrd_buf = NULL;
+	unsigned long pagesize = getpagesize();
+
+	if (arch_options.command_line) {
+		if (strlen(arch_options.command_line) >
+		    sizeof(cmdline) - 1) {
+			fprintf(stderr,
+				"Kernel command line too long for kernel!\n");
+			return EFAILED;
+		}
+
+		strncat(cmdline, arch_options.command_line, sizeof(cmdline) - 1);
+	}
+
+	/* Put the other segments after the image. */
+
+	initrd_min = hole_min;
+	if (info->kexec_flags & KEXEC_ON_CRASH)
+		hole_max = crash_reserved_mem[usablemem_rgns.size - 1].end;
+	else
+		hole_max = ULONG_MAX;
+
+	if (arch_options.initrd_file) {
+
+		initrd_buf = slurp_decompress_file(arch_options.initrd_file, &initrd_size);
+
+		initrd_base = add_buffer(info, initrd_buf, initrd_size,
+					initrd_size, sizeof(void *),
+					_ALIGN_UP(initrd_min,
+						pagesize), hole_max, 1);
+		dbgprintf("initrd_base: %lx, initrd_size: %lx\n", initrd_base, initrd_size);
+
+		cmdline_add_initrd(cmdline, initrd_base, initrd_size);
+	}
+
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		cmdline_add_elfcorehdr(cmdline, elfcorehdr_mem.start,
+				elfcorehdr_mem.end - elfcorehdr_mem.start + 1);
+
+		cmdline_add_mem(cmdline, crash_reserved_mem[usablemem_rgns.size - 1].start,
+			crash_reserved_mem[usablemem_rgns.size - 1].end -
+			crash_reserved_mem[usablemem_rgns.size - 1].start + 1);
+	}
+
+	cmdline[sizeof(cmdline) - 1] = 0;
+	add_buffer(info, cmdline, sizeof(cmdline), sizeof(cmdline),
+		sizeof(void *), _ALIGN_UP(hole_min, getpagesize()),
+		0xffffffff, 1);
+
+	dbgprintf("%s:%d: command_line: %s\n", __func__, __LINE__, cmdline);
+
+	return 0;
+
+}
+
+int arch_compat_trampoline(struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
+
+void arch_update_purgatory(struct kexec_info *UNUSED(info))
+{
+}
+
+unsigned long virt_to_phys(unsigned long addr)
+{
+	return addr & ((1ULL << 48) - 1);
+}
+
+/*
+ * add_segment() should convert base to a physical address on loongarch,
+ * while the default is just to work with base as is
+ */
+void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
+		 unsigned long base, size_t memsz)
+{
+	add_segment_phys_virt(info, buf, bufsz, virt_to_phys(base), memsz, 1);
+}
+
+/*
+ * add_buffer() should convert base to a physical address on loongarch,
+ * while the default is just to work with base as is
+ */
+unsigned long add_buffer(struct kexec_info *info, const void *buf,
+			 unsigned long bufsz, unsigned long memsz,
+			 unsigned long buf_align, unsigned long buf_min,
+			 unsigned long buf_max, int buf_end)
+{
+	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
+				    buf_min, buf_max, buf_end, 1);
+}
diff --git a/kexec/arch/loongarch/kexec-loongarch.h b/kexec/arch/loongarch/kexec-loongarch.h
new file mode 100644
index 0000000..cb9b79a
--- /dev/null
+++ b/kexec/arch/loongarch/kexec-loongarch.h
@@ -0,0 +1,51 @@
+#ifndef KEXEC_LOONGARCH_H
+#define KEXEC_LOONGARCH_H
+
+#include <sys/types.h>
+
+#define BOOT_BLOCK_VERSION 17
+#define BOOT_BLOCK_LAST_COMP_VERSION 16
+
+#define MAX_MEMORY_RANGES 64
+#define MAX_LINE 160
+
+#define CORE_TYPE_ELF64 1
+
+#define COMMAND_LINE_SIZE 512
+
+#define KiB(x) ((x) * 1024UL)
+#define MiB(x) (KiB(x) * 1024UL)
+
+int elf_loongarch_probe(const char *kernel_buf, off_t kernel_size);
+int elf_loongarch_load(int argc, char **argv, const char *buf, off_t len,
+	struct kexec_info *info);
+void elf_loongarch_usage(void);
+
+unsigned long loongarch_locate_kernel_segment(struct kexec_info *info);
+int loongarch_load_other_segments(struct kexec_info *info,
+	unsigned long hole_min);
+
+struct arch_options_t {
+	char *command_line;
+	char *initrd_file;
+	char *dtb;
+	int core_header_type;
+};
+
+/**
+ * struct loongarch_mem - Memory layout info.
+ */
+
+struct loongarch_mem {
+	uint64_t phys_offset;
+	uint64_t text_offset;
+	uint64_t image_size;
+};
+
+extern struct loongarch_mem loongarch_mem;
+
+extern struct memory_ranges usablemem_rgns;
+extern struct arch_options_t arch_options;
+extern off_t initrd_base, initrd_size;
+
+#endif /* KEXEC_LOONGARCH_H */
diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index bea29d4..be6ccd5 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -39,6 +39,9 @@
 #ifdef __s390__
 #define __NR_kexec_load		277
 #endif
+#ifdef __loongarch__
+#define __NR_kexec_load		104
+#endif
 #if defined(__arm__) || defined(__arm64__)
 #define __NR_kexec_load		__NR_SYSCALL_BASE + 347
 #endif
@@ -134,6 +137,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
 #define KEXEC_ARCH_MIPS_LE (10 << 16)
 #define KEXEC_ARCH_MIPS    ( 8 << 16)
 #define KEXEC_ARCH_CRIS    (76 << 16)
+#define KEXEC_ARCH_LOONGARCH	(258 << 16)
 
 #define KEXEC_MAX_SEGMENTS 16
 
@@ -177,5 +181,8 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
 #if defined(__arm64__)
 #define KEXEC_ARCH_NATIVE	KEXEC_ARCH_ARM64
 #endif
+#if defined(__loongarch__)
+#define KEXEC_ARCH_NATIVE	KEXEC_ARCH_LOONGARCH
+#endif
 
 #endif /* KEXEC_SYSCALL_H */
-- 
2.36.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dArpO-0000j2-Sm
 for kexec@lists.infradead.org; Wed, 17 May 2017 05:48:56 +0000
Received: by mail-pf0-x232.google.com with SMTP id n23so1808749pfb.2
 for <kexec@lists.infradead.org>; Tue, 16 May 2017 22:48:34 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v7 06/10] arm64: kdump: add elf core header segment
Date: Wed, 17 May 2017 14:51:46 +0900
Message-Id: <20170517055150.12601-7-takahiro.akashi@linaro.org>
In-Reply-To: <20170517055150.12601-1-takahiro.akashi@linaro.org>
References: <20170517055150.12601-1-takahiro.akashi@linaro.org>
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
To: horms@verge.net.au
Cc: geoff@infradead.org, panand@redhat.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

Elf core header contains the information necessary for the coredump of
the 1st kernel, including its physcal memory layout as well as cpu register
states at the panic.
The segment is allocated inside the reserved memory of crash dump kernel.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/crashdump-arm64.c | 98 ++++++++++++++++++++++++++++++++++++++
 kexec/arch/arm64/crashdump-arm64.h |  3 ++
 kexec/arch/arm64/iomem.h           |  2 +
 kexec/arch/arm64/kexec-elf-arm64.c | 11 +++++
 4 files changed, 114 insertions(+)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 9267c9a..d142435 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -39,6 +39,39 @@ struct memory_ranges usablemem_rgns = {
 	.ranges = &crash_reserved_mem,
 };
 
+struct memory_range elfcorehdr_mem;
+
+static struct crash_elf_info elf_info = {
+	.class		= ELFCLASS64,
+#if (__BYTE_ORDER == __LITTLE_ENDIAN)
+	.data		= ELFDATA2LSB,
+#else
+	.data		= ELFDATA2MSB,
+#endif
+	.machine	= EM_AARCH64,
+};
+
+/*
+ * Note: The returned value is correct only if !CONFIG_RANDOMIZE_BASE.
+ */
+static uint64_t get_kernel_page_offset(void)
+{
+	int i;
+
+	if (elf_info.kern_vaddr_start == UINT64_MAX)
+		return UINT64_MAX;
+
+	/* Current max virtual memory range is 48-bits. */
+	for (i = 48; i > 0; i--)
+		if (!(elf_info.kern_vaddr_start & (1UL << i)))
+			break;
+
+	if (i <= 0)
+		return UINT64_MAX;
+	else
+		return UINT64_MAX << i;
+}
+
 /*
  * iomem_range_callback() - callback called for each iomem region
  * @data: not used
@@ -62,6 +95,10 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
 	else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0)
 		return mem_regions_add(&system_memory_rgns,
 				       base, length, RANGE_RAM);
+	else if (strncmp(str, KERNEL_CODE, strlen(KERNEL_CODE)) == 0)
+		elf_info.kern_paddr_start = base;
+	else if (strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)) == 0)
+		elf_info.kern_size = base + length - elf_info.kern_paddr_start;
 
 	return 0;
 }
@@ -111,6 +148,67 @@ static int crash_get_memory_ranges(void)
 
 	dbgprint_mem_range("Coredump memory ranges",
 			   system_memory_rgns.ranges, system_memory_rgns.size);
+
+	/*
+	 * For additional kernel code/data segment.
+	 * kern_paddr_start/kern_size are determined in iomem_range_callback
+	 */
+	elf_info.kern_vaddr_start = get_kernel_sym("_text");
+	if (!elf_info.kern_vaddr_start)
+		elf_info.kern_vaddr_start = UINT64_MAX;
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
+	elf_info.page_offset = get_kernel_page_offset();
+	dbgprintf("%s: page_offset:   %016llx\n", __func__,
+			elf_info.page_offset);
+
+	err = crash_create_elf64_headers(info, &elf_info,
+			system_memory_rgns.ranges, system_memory_rgns.size,
+			&buf, &bufsz, ELF_CORE_HEADER_ALIGN);
+
+	if (err)
+		return EFAILED;
+
+	elfcorehdr = add_buffer_phys_virt(info, buf, bufsz, bufsz, 0,
+		crash_reserved_mem.start, crash_reserved_mem.end,
+		-1, 0);
+
+	elfcorehdr_mem.start = elfcorehdr;
+	elfcorehdr_mem.end = elfcorehdr + bufsz - 1;
+
+	dbgprintf("%s: elfcorehdr 0x%llx-0x%llx\n", __func__,
+			elfcorehdr_mem.start, elfcorehdr_mem.end);
+
+	return 0;
 }
 
 int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
index ce9881e..64c677d 100644
--- a/kexec/arch/arm64/crashdump-arm64.h
+++ b/kexec/arch/arm64/crashdump-arm64.h
@@ -18,5 +18,8 @@
 
 extern struct memory_ranges usablemem_rgns;
 extern struct memory_range crash_reserved_mem;
+extern struct memory_range elfcorehdr_mem;
+
+extern int load_crashdump_segments(struct kexec_info *info);
 
 #endif /* CRASHDUMP_ARM64_H */
diff --git a/kexec/arch/arm64/iomem.h b/kexec/arch/arm64/iomem.h
index 20cda87..d4864bb 100644
--- a/kexec/arch/arm64/iomem.h
+++ b/kexec/arch/arm64/iomem.h
@@ -2,6 +2,8 @@
 #define IOMEM_H
 
 #define SYSTEM_RAM		"System RAM\n"
+#define KERNEL_CODE		"Kernel code\n"
+#define KERNEL_DATA		"Kernel data\n"
 #define CRASH_KERNEL		"Crash kernel\n"
 #define IOMEM_RESERVED		"reserved\n"
 
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index 2b6c127..900c693 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -119,6 +119,16 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 	dbgprintf("%s: PE format:      %s\n", __func__,
 		(arm64_header_check_pe_sig(header) ? "yes" : "no"));
 
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
 	/* load the kernel */
 	result = elf_exec_load(&ehdr, info);
 
@@ -127,6 +137,7 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 		goto exit;
 	}
 
+	/* load additional data */
 	result = arm64_load_other_segments(info, kernel_segment
 		+ arm64_mem.text_offset);
 
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22c.google.com ([2607:f8b0:400e:c03::22c])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bRxIS-0008V9-QG
 for kexec@lists.infradead.org; Tue, 26 Jul 2016 08:01:12 +0000
Received: by mail-pa0-x22c.google.com with SMTP id ks6so69884881pab.0
 for <kexec@lists.infradead.org>; Tue, 26 Jul 2016 01:00:40 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 2/6] arm64: kdump: add elf core header segment
Date: Tue, 26 Jul 2016 17:05:21 +0900
Message-Id: <20160726080525.2539-3-takahiro.akashi@linaro.org>
In-Reply-To: <20160726080525.2539-1-takahiro.akashi@linaro.org>
References: <20160726080525.2539-1-takahiro.akashi@linaro.org>
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
 kexec/arch/arm64/crashdump-arm64.c | 61 ++++++++++++++++++++++++++++++++++++++
 kexec/arch/arm64/crashdump-arm64.h |  3 ++
 kexec/arch/arm64/kexec-arm64.c     |  1 -
 kexec/arch/arm64/kexec-elf-arm64.c | 11 +++++++
 4 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 5ab017c..3af01a3 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -41,6 +41,18 @@ struct memory_ranges usablemem_rgns = {
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
 /*
  * iomem_range_callback() - callback called for each iomem region
  * @data: not used
@@ -121,3 +133,52 @@ static int crash_get_memory_ranges(void)
 
 	return 0;
 }
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
+		return err;
+
+	elf_info.page_offset = arm64_mem.page_offset;
+
+	err = crash_create_elf64_headers(info, &elf_info,
+			crash_memory_rgns.ranges, crash_memory_rgns.size,
+			&buf, &bufsz, ELF_CORE_HEADER_ALIGN);
+
+	if (err)
+		return err;
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
+}
diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
index 07a0ed0..da75a2d 100644
--- a/kexec/arch/arm64/crashdump-arm64.h
+++ b/kexec/arch/arm64/crashdump-arm64.h
@@ -18,5 +18,8 @@
 
 extern struct memory_ranges usablemem_rgns;
 extern struct memory_range crash_reserved_mem;
+extern struct memory_range elfcorehdr_mem;
+
+extern int load_crashdump_segments(struct kexec_info *info);
 
 #endif /* CRASHDUMP_ARM64_H */
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 24031f6..a61f856 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -561,7 +561,6 @@ int arm64_load_other_segments(struct kexec_info *info,
 	}
 
 	purgatory_sink = read_sink(command_line);
-
 	dbgprintf("%s:%d: purgatory sink: 0x%" PRIx64 "\n", __func__, __LINE__,
 		purgatory_sink);
 
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index 27161e8..029d3e2 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -100,6 +100,17 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 		dbgprintf("%s: PE format:     %s\n", __func__,
 			(arm64_header_check_pe_sig(h) ? "yes" : "no"));
 
+		if (info->kexec_flags & KEXEC_ON_CRASH) {
+			/* create and initialize elf core header segment */
+			result = load_crashdump_segments(info);
+
+			if (result) {
+				fprintf(stderr,
+					"kexec: creating eflcorehdr failed.\n");
+				goto exit;
+			}
+		}
+
 		result = elf_exec_load(&ehdr, info);
 
 		if (result) {
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bWwGS-000776-Vz
 for kexec@lists.infradead.org; Tue, 09 Aug 2016 01:55:38 +0000
Received: by mail-pf0-x229.google.com with SMTP id x72so124623497pfd.2
 for <kexec@lists.infradead.org>; Mon, 08 Aug 2016 18:55:12 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 2/7] arm64: kdump: add elf core header segment
Date: Tue,  9 Aug 2016 11:00:27 +0900
Message-Id: <20160809020032.28654-3-takahiro.akashi@linaro.org>
In-Reply-To: <20160809020032.28654-1-takahiro.akashi@linaro.org>
References: <20160809020032.28654-1-takahiro.akashi@linaro.org>
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
 kexec/arch/arm64/kexec-elf-arm64.c | 11 +++++++
 3 files changed, 75 insertions(+)

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
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index fcac9bb..fdbf619 100644
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

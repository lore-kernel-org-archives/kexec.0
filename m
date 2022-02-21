From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Mon, 21 Feb 2022 14:16:23 +0530
Subject: [RFC PATCH 4/5] powerpc/kdump: enable kexec_file_load system call to
 use kexec crash FDT
In-Reply-To: <20220221084624.85792-1-sourabhjain@linux.ibm.com>
References: <20220221084624.85792-1-sourabhjain@linux.ibm.com>
Message-ID: <20220221084624.85792-5-sourabhjain@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

This patch enables the kexec_file_load system to utilize the pre-allocated
space for kexec crash FDT during the system boot.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kexec/elf_64.c       | 22 +++++++++++++++++++---
 arch/powerpc/kexec/file_load_64.c |  4 ++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index eeb258002d1e..3176dea0910d 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -116,13 +116,29 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 	if (ret)
 		goto out_free_fdt;
 
-	fdt_pack(fdt);
+#ifdef CONFIG_KEXEC_CRASH_FDT
+	if (kexec_crash_fdt && image->type == KEXEC_TYPE_CRASH) {
+		memcpy(kexec_crash_fdt, fdt, fdt_totalsize(fdt));
+		/* retain the original total size */
+		((struct fdt_header *)(kexec_crash_fdt))->totalsize = cpu_to_fdt32(kexec_crash_fdt_size);
+	} else
+#endif
+	{
+		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	}
 
 	kbuf.buffer = fdt;
-	kbuf.bufsz = kbuf.memsz = fdt_totalsize(fdt);
+
+#ifdef CONFIG_KEXEC_CRASH_FDT
+	if (kexec_crash_fdt && image->type == KEXEC_TYPE_CRASH) {
+		kbuf.bufsz = kbuf.memsz = fdt_totalsize(kexec_crash_fdt);
+	} else
+#endif
+	{
+		kbuf.bufsz = kbuf.memsz = fdt_totalsize(fdt);
+	}
 	kbuf.buf_align = PAGE_SIZE;
 	kbuf.top_down = true;
-	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret)
 		goto out_free_fdt;
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 02bb2adb1fe2..7a320d9e2098 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -906,6 +906,10 @@ int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 	u64 buf_min, buf_max;
 	int ret;
 
+	/* kbuf.mem is already pointing to validate memory hole */
+	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
+		return 0;
+
 	/* Look up the exclude ranges list while locating the memory hole */
 	emem = &(kbuf->image->arch.exclude_ranges);
 	if (!(*emem) || ((*emem)->nr_ranges == 0)) {
-- 
2.34.1



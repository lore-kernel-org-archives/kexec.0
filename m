From: Coiby Xu <coxu@redhat.com>
Date: Fri, 18 Mar 2022 18:34:21 +0800
Subject: [RFC 2/4] kdump,
 x86: pass the LUKS master key to kdump kernel using a kernel command
 line parameter luksmasterkey
In-Reply-To: <20220318103423.286410-1-coxu@redhat.com>
References: <20220318103423.286410-1-coxu@redhat.com>
Message-ID: <20220318103423.286410-3-coxu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

kdump will build up the kernel command parameter luksmasterkey as
similar to elfcorehdr to pass the memory address of the stored info of LUKS
master key to kdump kernel.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/include/asm/crash.h      |  1 +
 arch/x86/kernel/crash.c           | 42 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/kexec-bzimage64.c |  7 ++++++
 include/linux/kexec.h             |  4 +++
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index 8b6bd63530dc..757374389296 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -4,6 +4,7 @@
 
 struct kimage;
 
+int crash_load_luks_key(struct kimage *image);
 int crash_load_segments(struct kimage *image);
 int crash_setup_memmap_entries(struct kimage *image,
 		struct boot_params *params);
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e8326a8d1c5d..6d117da62da4 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -304,6 +304,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int r;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -312,7 +313,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 	/* Exclude elf header region */
 	start = image->elf_load_addr;
 	end = start + image->elf_headers_sz - 1;
-	return crash_exclude_mem_range(cmem, start, end);
+	r = crash_exclude_mem_range(cmem, start, end);
+
+	if (r)
+		return r;
+
+	/* Exclude LUKS master key region */
+	if (image->luks_master_key_addr) {
+		start = image->luks_master_key_addr;
+		end = start + image->luks_master_key_sz - 1;
+		return crash_exclude_mem_range(cmem, start, end);
+	}
+
+	return r;
 }
 
 /* Prepare memory map for crash dump kernel */
@@ -383,6 +396,33 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	return ret;
 }
 
+int crash_load_luks_key(struct kimage *image)
+{
+	int ret;
+	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
+				  .buf_max = ULONG_MAX, .top_down = false };
+
+	image->luks_master_key_addr = 0;
+	ret = kexec_pass_luks_master_key(&kbuf.buffer, &kbuf.bufsz);
+	if (ret)
+		return ret;
+
+	kbuf.memsz = kbuf.bufsz;
+	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	ret = kexec_add_buffer(&kbuf);
+	if (ret) {
+		vfree((void *)kbuf.buffer);
+		return ret;
+	}
+	image->luks_master_key_addr = kbuf.mem;
+	image->luks_master_key_sz = kbuf.bufsz;
+	pr_debug("Loaded LUKS master key at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		 image->luks_master_key_addr, kbuf.bufsz, kbuf.bufsz);
+
+	return ret;
+}
+
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..64ea3b6a5768 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		len = sprintf(cmdline_ptr,
 			"elfcorehdr=0x%lx ", image->elf_load_addr);
+
+		if (image->luks_master_key_addr != 0)
+			len += sprintf(cmdline_ptr + len,
+					"luksmasterkey=0x%lx ", image->luks_master_key_addr);
 	}
 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
 	cmdline_len += len;
@@ -372,6 +376,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
+		ret = crash_load_luks_key(image);
+		if (ret)
+			pr_debug("Either no LUKS master key or error to retrieve the LUKS master key\n");
 	}
 
 	/*
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 91507bc684e2..456a5bc28518 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -316,6 +316,10 @@ struct kimage {
 	void *elf_headers;
 	unsigned long elf_headers_sz;
 	unsigned long elf_load_addr;
+
+	/* LUKS master key buffer */
+	unsigned long luks_master_key_addr;
+	unsigned long luks_master_key_sz;
 };
 
 /* kexec interface functions */
-- 
2.34.1



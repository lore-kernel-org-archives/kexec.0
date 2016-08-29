Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1beHqJ-0006LK-Uj
 for kexec@lists.infradead.org; Mon, 29 Aug 2016 08:22:57 +0000
Received: by mail-pf0-x236.google.com with SMTP id h186so49671801pfg.3
 for <kexec@lists.infradead.org>; Mon, 29 Aug 2016 01:22:33 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 1/2] fixup! arm64: Add arm64 kexec support
Date: Mon, 29 Aug 2016 17:28:40 +0900
Message-Id: <20160829082841.3750-2-takahiro.akashi@linaro.org>
In-Reply-To: <20160829082841.3750-1-takahiro.akashi@linaro.org>
References: <20160829082841.3750-1-takahiro.akashi@linaro.org>
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
To: horms@verge.net.au, geoff@infradead.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/kexec-arm64.c     | 22 +++++++++--
 kexec/arch/arm64/kexec-arm64.h     |  1 +
 kexec/arch/arm64/kexec-elf-arm64.c | 79 ++++++++++++++++++++++----------------
 3 files changed, 64 insertions(+), 38 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index be3f964..253affa 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -300,16 +300,30 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line)
 	return result;
 }
 
+unsigned long arm64_locate_kernel_segment(struct kexec_info *info)
+{
+	unsigned long image_base;
+
+	image_base = locate_hole(info,
+		arm64_mem.text_offset + arm64_mem.image_size,
+		MiB(2), 0, ULONG_MAX, 1);
+	if (image_base == ULONG_MAX) {
+		dbgprintf("%s: locate_hole failed\n", __func__);
+	}
+
+	return image_base;
+}
+
 /**
  * arm64_load_other_segments - Prepare the dtb, initrd and purgatory segments.
  */
 
 int arm64_load_other_segments(struct kexec_info *info,
-	uint64_t kernel_entry)
+	unsigned long kernel_entry)
 {
 	int result;
-	uint64_t dtb_base;
-	uint64_t image_base;
+	unsigned long dtb_base;
+	unsigned long image_base;
 	unsigned long hole_min;
 	unsigned long hole_max;
 	char *initrd_buf = NULL;
@@ -343,7 +357,7 @@ int arm64_load_other_segments(struct kexec_info *info,
 
 	/* Put the other segments after the image. */
 
-	image_base = arm64_mem.phys_offset + arm64_mem.text_offset;
+	image_base = kernel_entry;
 	hole_min = image_base + arm64_mem.image_size;
 	hole_max = ULONG_MAX;
 
diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index c40e383..e4bc6d0 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -64,6 +64,7 @@ static inline void set_phys_offset(uint64_t v)
 }
 
 int arm64_process_image_header(const struct arm64_image_header *h);
+unsigned long arm64_locate_kernel_segment(struct kexec_info *info);
 int arm64_load_other_segments(struct kexec_info *info,
 	uint64_t kernel_entry);
 
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index 2635d29..18aca3c 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -5,6 +5,7 @@
 #define _GNU_SOURCE
 
 #include <errno.h>
+#include <limits.h>
 #include <stdlib.h>
 #include <linux/elf.h>
 
@@ -42,6 +43,8 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 	struct mem_ehdr ehdr;
 	int result;
 	int i;
+	const struct arm64_image_header *h = NULL;
+	unsigned long image_base;
 
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		fprintf(stderr, "kexec: kdump not yet supported on arm64\n");
@@ -59,7 +62,6 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 
 	for (i = 0; i < ehdr.e_phnum; i++) {
 		struct mem_phdr *phdr = &ehdr.e_phdr[i];
-		const struct arm64_image_header *h;
 		unsigned long header_offset;
 
 		if (phdr->p_type != PT_LOAD)
@@ -76,45 +78,54 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 		h = (const struct arm64_image_header *)(
 			kernel_buf + phdr->p_offset + header_offset);
 
-		if (arm64_process_image_header(h))
-			continue;
+		if (!arm64_process_image_header(h)) {
+			dbgprintf("%s: e_entry:       %016llx\n", __func__,
+				ehdr.e_entry);
+			dbgprintf("%s: p_vaddr:       %016llx\n", __func__,
+				phdr->p_vaddr);
+			dbgprintf("%s: header_offset: %016lx\n", __func__,
+				header_offset);
 
-		arm64_mem.vp_offset = ehdr.e_entry - arm64_mem.text_offset;
-
-		dbgprintf("%s: e_entry:       %016llx -> %016lx\n", __func__,
-			ehdr.e_entry,
-			virt_to_phys(ehdr.e_entry));
-		dbgprintf("%s: p_vaddr:       %016llx -> %016lx\n", __func__,
-			phdr->p_vaddr,
-			virt_to_phys(phdr->p_vaddr));
-		dbgprintf("%s: header_offset: %016lx\n", __func__,
-			header_offset);
-		dbgprintf("%s: text_offset:   %016lx\n", __func__,
-			arm64_mem.text_offset);
-		dbgprintf("%s: image_size:    %016lx\n", __func__,
-			arm64_mem.image_size);
-		dbgprintf("%s: phys_offset:   %016lx\n", __func__,
-			arm64_mem.phys_offset);
-		dbgprintf("%s: vp_offset:     %016lx\n", __func__,
-			arm64_mem.vp_offset);
-		dbgprintf("%s: PE format:     %s\n", __func__,
-			(arm64_header_check_pe_sig(h) ? "yes" : "no"));
-
-		result = elf_exec_load(&ehdr, info);
-
-		if (result) {
-			dbgprintf("%s: elf_exec_load failed\n", __func__);
-			goto exit;
+			break;
 		}
+	}
+	if (i == ehdr.e_phnum) {
+		dbgprintf("%s: Valid arm64 header not found\n", __func__);
+		result = -EFAILED;
+		goto exit;
+	}
+
+	image_base = arm64_locate_kernel_segment(info);
+	if (image_base == ULONG_MAX) {
+		dbgprintf("%s: Kernel segment is not allocated\n", __func__);
+		result = -EFAILED;
+		goto exit;
+	}
 
-		result = arm64_load_other_segments(info,
-			virt_to_phys(ehdr.e_entry));
+	arm64_mem.vp_offset = _ALIGN_DOWN(ehdr.e_entry, MiB(2));
+	arm64_mem.vp_offset -= image_base - get_phys_offset();
+
+	dbgprintf("%s: image_base:    %016lx\n", __func__, image_base);
+	dbgprintf("%s: text_offset:   %016lx\n", __func__,
+		arm64_mem.text_offset);
+	dbgprintf("%s: image_size:    %016lx\n", __func__,
+		arm64_mem.image_size);
+	dbgprintf("%s: phys_offset:   %016lx\n", __func__,
+		arm64_mem.phys_offset);
+	dbgprintf("%s: vp_offset:     %016lx\n", __func__,
+		arm64_mem.vp_offset);
+	dbgprintf("%s: PE format:     %s\n", __func__,
+		(arm64_header_check_pe_sig(h) ? "yes" : "no"));
+
+	/* load the kernel */
+	result = elf_exec_load(&ehdr, info);
+	if (result) {
+		dbgprintf("%s: elf_exec_load failed\n", __func__);
 		goto exit;
 	}
 
-	dbgprintf("%s: Bad arm64 image header\n", __func__);
-	result = -EFAILED;
-	goto exit;
+	result = arm64_load_other_segments(info,
+			image_base + arm64_mem.text_offset);
 
 exit:
 	reset_vp_offset();
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

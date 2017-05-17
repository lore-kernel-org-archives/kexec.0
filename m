Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dArpH-0000iM-Gc
 for kexec@lists.infradead.org; Wed, 17 May 2017 05:48:49 +0000
Received: by mail-pg0-x230.google.com with SMTP id u28so1754400pgn.1
 for <kexec@lists.infradead.org>; Tue, 16 May 2017 22:48:27 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v7 04/10] arm64: change return values on error to negative
Date: Wed, 17 May 2017 14:51:44 +0900
Message-Id: <20170517055150.12601-5-takahiro.akashi@linaro.org>
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

EFAILED is defined "-1" and so we don't need to negate it as a return value.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/kexec-arm64.c       | 24 ++++++++++++------------
 kexec/arch/arm64/kexec-elf-arm64.c   |  6 +++---
 kexec/arch/arm64/kexec-image-arm64.c |  4 ++--
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 7024f74..153c96f 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -79,7 +79,7 @@ int arm64_process_image_header(const struct arm64_image_header *h)
 #endif
 
 	if (!arm64_header_check_magic(h))
-		return -EFAILED;
+		return EFAILED;
 
 	if (h->image_size) {
 		arm64_mem.text_offset = arm64_header_text_offset(h);
@@ -202,7 +202,7 @@ static int set_bootargs(struct dtb *dtb, const char *command_line)
 	if (result) {
 		fprintf(stderr,
 			"kexec: Set device tree bootargs failed.\n");
-		return -EFAILED;
+		return EFAILED;
 	}
 
 	return 0;
@@ -222,7 +222,7 @@ static int read_proc_dtb(struct dtb *dtb)
 
 	if (result) {
 		dbgprintf("%s: %s\n", __func__, strerror(errno));
-		return -EFAILED;
+		return EFAILED;
 	}
 
 	dtb->path = path;
@@ -245,7 +245,7 @@ static int read_sys_dtb(struct dtb *dtb)
 
 	if (result) {
 		dbgprintf("%s: %s\n", __func__, strerror(errno));
-		return -EFAILED;
+		return EFAILED;
 	}
 
 	dtb->path = path;
@@ -275,7 +275,7 @@ static int read_1st_dtb(struct dtb *dtb)
 		goto on_success;
 
 	dbgprintf("%s: not found\n", __func__);
-	return -EFAILED;
+	return EFAILED;
 
 on_success:
 	dbgprintf("%s: found %s\n", __func__, dtb->path);
@@ -294,7 +294,7 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line)
 
 	if (result) {
 		fprintf(stderr, "kexec: Invalid 2nd device tree.\n");
-		return -EFAILED;
+		return EFAILED;
 	}
 
 	result = set_bootargs(dtb, command_line);
@@ -349,14 +349,14 @@ int arm64_load_other_segments(struct kexec_info *info,
 		if (result) {
 			fprintf(stderr,
 				"kexec: Error: No device tree available.\n");
-			return -EFAILED;
+			return EFAILED;
 		}
 	}
 
 	result = setup_2nd_dtb(&dtb, command_line);
 
 	if (result)
-		return -EFAILED;
+		return EFAILED;
 
 	/* Put the other segments after the image. */
 
@@ -384,7 +384,7 @@ int arm64_load_other_segments(struct kexec_info *info,
 
 			if (_ALIGN_UP(initrd_end, GiB(1)) - _ALIGN_DOWN(image_base, GiB(1)) > GiB(32)) {
 				fprintf(stderr, "kexec: Error: image + initrd too big.\n");
-				return -EFAILED;
+				return EFAILED;
 			}
 
 			dbgprintf("initrd: base %lx, size %lxh (%ld)\n",
@@ -395,7 +395,7 @@ int arm64_load_other_segments(struct kexec_info *info,
 				initrd_base + initrd_size);
 
 			if (result)
-				return -EFAILED;
+				return EFAILED;
 		}
 	}
 
@@ -403,7 +403,7 @@ int arm64_load_other_segments(struct kexec_info *info,
 
 	if (dtb.size > MiB(2)) {
 		fprintf(stderr, "kexec: Error: dtb too big.\n");
-		return -EFAILED;
+		return EFAILED;
 	}
 
 	dtb_base = add_buffer_phys_virt(info, dtb.buf, dtb.size, dtb.size,
@@ -509,7 +509,7 @@ static int get_memory_ranges_iomem(struct memory_range *array,
 
 	if (!*count) {
 		dbgprintf("%s: failed: No RAM found.\n", __func__);
-		return -EFAILED;
+		return EFAILED;
 	}
 
 	return 0;
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index daf8bf0..2b6c127 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -48,7 +48,7 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		fprintf(stderr, "kexec: kdump not yet supported on arm64\n");
-		return -EFAILED;
+		return EFAILED;
 	}
 
 	result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
@@ -92,7 +92,7 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 
 	if (i == ehdr.e_phnum) {
 		dbgprintf("%s: Valid arm64 header not found\n", __func__);
-		result = -EFAILED;
+		result = EFAILED;
 		goto exit;
 	}
 
@@ -100,7 +100,7 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 
 	if (kernel_segment == ULONG_MAX) {
 		dbgprintf("%s: Kernel segment is not allocated\n", __func__);
-		result = -EFAILED;
+		result = EFAILED;
 		goto exit;
 	}
 
diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index 960ed96..e5f2a9b 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -36,13 +36,13 @@ int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 	header = (const struct arm64_image_header *)(kernel_buf);
 
 	if (arm64_process_image_header(header))
-		return -1;
+		return EFAILED;
 
         kernel_segment = arm64_locate_kernel_segment(info);
 
         if (kernel_segment == ULONG_MAX) {
                 dbgprintf("%s: Kernel segment is not allocated\n", __func__);
-                result = -EFAILED;
+		result = EFAILED;
                 goto exit;
         }
 
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

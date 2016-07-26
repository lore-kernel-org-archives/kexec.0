Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x231.google.com ([2607:f8b0:400e:c03::231])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bRxIu-0000PZ-Ft
 for kexec@lists.infradead.org; Tue, 26 Jul 2016 08:01:35 +0000
Received: by mail-pa0-x231.google.com with SMTP id iw10so69643999pac.2
 for <kexec@lists.infradead.org>; Tue, 26 Jul 2016 01:01:08 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 5/6] arm64: kdump: add DT properties to crash dump kernel's dtb
Date: Tue, 26 Jul 2016 17:05:24 +0900
Message-Id: <20160726080525.2539-6-takahiro.akashi@linaro.org>
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

We pass the following properties to crash dump kernel:
linux,elfcorehdr: elf core header segment,
		  same as "elfcorehdr=" as on other archs
linxu,usable-memory-range: usable memory reserved for crash dump kernel

Then, we are ready to support kdump.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/kexec-arm64.c     | 72 ++++++++++++++++++++++++++++++++++++--
 kexec/arch/arm64/kexec-elf-arm64.c |  5 ---
 2 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 22ab098..3de0ead 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -482,8 +482,12 @@ on_success:
 	return 0;
 }
 
-static int setup_2nd_dtb(char *command_line, struct dtb *dtb_2)
+static int setup_2nd_dtb(char *command_line, struct dtb *dtb_2, int on_crash)
 {
+	char *new_buf;
+	int new_size;
+	int nodeoffset;
+	uint64_t range[2];
 	int result;
 
 	result = fdt_check_header(dtb_2->buf);
@@ -495,9 +499,72 @@ static int setup_2nd_dtb(char *command_line, struct dtb *dtb_2)
 
 	result = set_bootargs(dtb_2, command_line);
 
+	/* remove those anyway */
+	nodeoffset = fdt_path_offset(dtb_2->buf, "/chosen");
+	fdt_delprop(dtb_2->buf, nodeoffset, "linux,crashkernel-base");
+	fdt_delprop(dtb_2->buf, nodeoffset, "linux,crashkernel-size");
+
+	if (on_crash) {
+		nodeoffset = fdt_path_offset(dtb_2->buf, "/chosen");
+		fdt_delprop(dtb_2->buf, nodeoffset, "linux,elfcorehdr");
+		fdt_delprop(dtb_2->buf, nodeoffset, "linux,usable-memory-range");
+		new_size = fdt_totalsize(dtb_2->buf)
+			+ 2 * (sizeof(struct fdt_property)
+					+ FDT_TAGALIGN(sizeof(range)))
+			+ strlen("linux,elfcorehdr") + 1
+			+ strlen("linux,usable-memory-range") + 1;
+
+		new_buf = xmalloc(new_size);
+		result = fdt_open_into(dtb_2->buf, new_buf, new_size);
+		if (result) {
+			dbgprintf("%s: fdt_open_into failed: %s\n", __func__,
+				fdt_strerror(result));
+			result = -ENOSPC;
+			goto on_error;
+		}
+
+		range[0] = cpu_to_be64(elfcorehdr_mem.start);
+		range[1] = cpu_to_be64(elfcorehdr_mem.end
+				- elfcorehdr_mem.start + 1);
+		nodeoffset = fdt_path_offset(new_buf, "/chosen");
+		result = fdt_setprop(new_buf, nodeoffset, "linux,elfcorehdr",
+				(void *)range, sizeof(range));
+		if (result) {
+			dbgprintf("%s: fdt_setprop failed: %s\n", __func__,
+				fdt_strerror(result));
+			result = -EINVAL;
+			goto on_error;
+		}
+
+		range[0] = cpu_to_be64(crash_reserved_mem.start);
+		range[1] = cpu_to_be64(crash_reserved_mem.end
+				- crash_reserved_mem.start + 1);
+		nodeoffset = fdt_path_offset(new_buf, "/chosen");
+		result = fdt_setprop(new_buf, nodeoffset,
+				"linux,usable-memory-range",
+				(void *)range, sizeof(range));
+		if (result) {
+			dbgprintf("%s: fdt_setprop failed: %s\n", __func__,
+				fdt_strerror(result));
+			result = -EINVAL;
+			goto on_error;
+		}
+
+		/* don't free dtb_2->buf which might also be shared by dtb_1 */
+		dtb_2->buf = new_buf;
+		dtb_2->size = new_size;
+	}
+
 	dump_reservemap(dtb_2);
 
 	return result;
+
+on_error:
+	fprintf(stderr, "kexec: %s failed.\n", __func__);
+	if (new_buf)
+		free(new_buf);
+
+	return result;
 }
 
 static uint64_t read_sink(const char *command_line)
@@ -581,7 +648,8 @@ int arm64_load_other_segments(struct kexec_info *info,
 	else if (!result && !arm64_opts.dtb)
 		dtb_2 = dtb_1;
 
-	result = setup_2nd_dtb(command_line, &dtb_2);
+	result = setup_2nd_dtb(command_line, &dtb_2,
+			info->kexec_flags & KEXEC_ON_CRASH);
 
 	if (result)
 		return result;
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index 1e5deb4..57bf43b 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -44,11 +44,6 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 	int result;
 	int i;
 
-	if (info->kexec_flags & KEXEC_ON_CRASH) {
-		fprintf(stderr, "kexec: kdump not yet supported on arm64\n");
-		return -EINVAL;
-	}
-
 	result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
 
 	if (result < 0) {
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cVwa3-0001EY-Qc
 for kexec@lists.infradead.org; Tue, 24 Jan 2017 08:35:57 +0000
Received: by mail-pg0-f47.google.com with SMTP id t6so53220377pgt.3
 for <kexec@lists.infradead.org>; Tue, 24 Jan 2017 00:35:35 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v5 8/9] arm64: kdump: add DT properties to crash dump kernel's
 dtb
Date: Tue, 24 Jan 2017 17:33:30 +0900
Message-Id: <20170124083331.3468-9-takahiro.akashi@linaro.org>
In-Reply-To: <20170124083331.3468-1-takahiro.akashi@linaro.org>
References: <20170124083331.3468-1-takahiro.akashi@linaro.org>
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
		  same as "elfcorehdr=" kernel parameter on other archs
linux,usable-memory-range: usable memory reserved for crash dump kernel

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/kexec-arm64.c     | 71 +++++++++++++++++++++++++++++++++++---
 kexec/arch/arm64/kexec-elf-arm64.c |  5 ---
 2 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 5e30107..f62c4b3 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -128,9 +128,6 @@ int arch_process_options(int argc, char **argv)
 		case OPT_INITRD:
 			arm64_opts.initrd = optarg;
 			break;
-		case OPT_PANIC:
-			die("load-panic (-p) not supported");
-			break;
 		default:
 			break; /* Ignore core and unknown options. */
 		}
@@ -285,8 +282,12 @@ on_success:
  * setup_2nd_dtb - Setup the 2nd stage kernel's dtb.
  */
 
-static int setup_2nd_dtb(struct dtb *dtb, char *command_line)
+static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 {
+	char *new_buf;
+	int new_size;
+	int nodeoffset;
+	uint64_t range[2];
 	int result;
 
 	result = fdt_check_header(dtb->buf);
@@ -298,8 +299,67 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line)
 
 	result = set_bootargs(dtb, command_line);
 
+	if (on_crash) {
+		nodeoffset = fdt_path_offset(dtb->buf, "/chosen");
+		fdt_delprop(dtb->buf, nodeoffset, "linux,elfcorehdr");
+		fdt_delprop(dtb->buf, nodeoffset, "linux,usable-memory-range");
+		new_size = fdt_totalsize(dtb->buf)
+			+ 2 * (sizeof(struct fdt_property)
+					+ FDT_TAGALIGN(sizeof(range)))
+			+ strlen("linux,elfcorehdr") + 1
+			+ strlen("linux,usable-memory-range") + 1;
+
+		new_buf = xmalloc(new_size);
+		result = fdt_open_into(dtb->buf, new_buf, new_size);
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
+		fdt_pack(new_buf);
+		dtb->buf = new_buf;
+		dtb->size = fdt_totalsize(new_buf);
+	}
+
 	dump_reservemap(dtb);
 
+
+	return result;
+
+on_error:
+	fprintf(stderr, "kexec: %s failed.\n", __func__);
+	if (new_buf)
+		free(new_buf);
+
 	return result;
 }
 
@@ -367,7 +427,8 @@ int arm64_load_other_segments(struct kexec_info *info,
 		}
 	}
 
-	result = setup_2nd_dtb(&dtb, command_line);
+	result = setup_2nd_dtb(&dtb, command_line,
+			info->kexec_flags & KEXEC_ON_CRASH);
 
 	if (result)
 		return -EFAILED;
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index 842ce21..b17a31a 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -47,11 +47,6 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 	int result;
 	int i;
 
-	if (info->kexec_flags & KEXEC_ON_CRASH) {
-		fprintf(stderr, "kexec: kdump not yet supported on arm64\n");
-		return -EFAILED;
-	}
-
 	result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
 
 	if (result < 0) {
-- 
2.11.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

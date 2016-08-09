Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bWwGy-0008Rs-Nh
 for kexec@lists.infradead.org; Tue, 09 Aug 2016 01:56:17 +0000
Received: by mail-pf0-x22f.google.com with SMTP id y134so124579443pfg.0
 for <kexec@lists.infradead.org>; Mon, 08 Aug 2016 18:55:44 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 5/7] arm64: kdump: add DT properties to crash dump kernel's
 dtb
Date: Tue,  9 Aug 2016 11:00:30 +0900
Message-Id: <20160809020032.28654-6-takahiro.akashi@linaro.org>
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

We pass the following properties to crash dump kernel:
linux,elfcorehdr: elf core header segment,
		  same as "elfcorehdr=" as on other archs
linxu,usable-memory-range: usable memory reserved for crash dump kernel

Then, we are ready to support kdump.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/kexec-arm64.c     | 76 +++++++++++++++++++++++++++++++++++---
 kexec/arch/arm64/kexec-elf-arm64.c |  5 ---
 2 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index b9da85d..83ad966 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -126,9 +126,6 @@ int arch_process_options(int argc, char **argv)
 		case OPT_INITRD:
 			arm64_opts.initrd = optarg;
 			break;
-		case OPT_PANIC:
-			die("load-panic (-p) not supported");
-			break;
 		default:
 			break; /* Ignore core and unknown options. */
 		}
@@ -281,8 +278,12 @@ on_success:
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
@@ -294,8 +295,72 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line)
 
 	result = set_bootargs(dtb, command_line);
 
+	/* remove those anyway */
+	nodeoffset = fdt_path_offset(dtb->buf, "/chosen");
+	fdt_delprop(dtb->buf, nodeoffset, "linux,crashkernel-base");
+	fdt_delprop(dtb->buf, nodeoffset, "linux,crashkernel-size");
+
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
 
@@ -335,7 +400,8 @@ int arm64_load_other_segments(struct kexec_info *info,
 		}
 	}
 
-	result = setup_2nd_dtb(&dtb, command_line);
+	result = setup_2nd_dtb(&dtb, command_line,
+			info->kexec_flags & KEXEC_ON_CRASH);
 
 	if (result)
 		return -EFAILED;
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index 63209e8..e20ab3e 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -44,11 +44,6 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
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
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

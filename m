Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22c.google.com ([2607:f8b0:400e:c03::22c])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bhUTm-0005hY-Gw
 for kexec@lists.infradead.org; Wed, 07 Sep 2016 04:29:05 +0000
Received: by mail-pa0-x22c.google.com with SMTP id to9so2011358pac.1
 for <kexec@lists.infradead.org>; Tue, 06 Sep 2016 21:28:34 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 7/8] arm64: kdump: add DT properties to crash dump kernel's
 dtb
Date: Wed,  7 Sep 2016 13:34:00 +0900
Message-Id: <20160907043401.6403-8-takahiro.akashi@linaro.org>
In-Reply-To: <20160907043401.6403-1-takahiro.akashi@linaro.org>
References: <20160907043401.6403-1-takahiro.akashi@linaro.org>
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
/chosen/linux,elfcorehdr: elf core header segment,
				same as "elfcorehdr=" as on other archs
/reserved-memory/crash_dump@xx: any memory regions to be dumped
				into /proc/vmcore

Then, we are ready to support kdump.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/crashdump-arm64.c | 141 ++++++++++++++++++++++++++++++++++++-
 kexec/arch/arm64/crashdump-arm64.h |   2 +
 kexec/arch/arm64/kexec-arm64.c     |  34 +++++++--
 kexec/arch/arm64/kexec-elf-arm64.c |   5 --
 4 files changed, 171 insertions(+), 11 deletions(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 9517329..01b9716 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -13,6 +13,7 @@
 #define _GNU_SOURCE
 
 #include <errno.h>
+#include <stdlib.h>
 #include <linux/elf.h>
 
 #include "kexec.h"
@@ -21,11 +22,12 @@
 #include "iomem.h"
 #include "kexec-arm64.h"
 #include "kexec-elf.h"
+#include "libfdt.h"
 #include "mem_regions.h"
 
 /* memory ranges on crashed kernel */
 static struct memory_range crash_memory_ranges[CRASH_MAX_MEMORY_RANGES];
-static struct memory_ranges crash_memory_rgns = {
+struct memory_ranges crash_memory_rgns = {
 	.size = 0,
 	.max_size = CRASH_MAX_MEMORY_RANGES,
 	.ranges = crash_memory_ranges,
@@ -236,3 +238,140 @@ void modify_ehdr_for_crashdump(struct mem_ehdr *ehdr)
 			(-arm64_mem.phys_offset + crash_reserved_mem.start);
 	}
 }
+
+static int dtb_add_reserved_memory(void *dtb_buf)
+{
+	int nodeoffset, rsvmem_node;
+	uint32_t cell_size;
+	uint64_t range[2];
+	char name[30];
+	int i, result = 0;
+
+	rsvmem_node = fdt_path_offset(dtb_buf, "reserved-memory");
+	if (rsvmem_node < 0) {
+		nodeoffset = fdt_path_offset(dtb_buf, "/");
+		rsvmem_node = fdt_add_subnode(dtb_buf, nodeoffset,
+						"reserved-memory");
+		if (rsvmem_node < 0) {
+			result = rsvmem_node;
+			goto on_error;
+		}
+
+		cell_size = cpu_to_fdt32(2);
+		fdt_setprop(dtb_buf, rsvmem_node, "#address-cells",
+						&cell_size, sizeof(cell_size));
+		fdt_setprop(dtb_buf, rsvmem_node, "#size-cells",
+						&cell_size, sizeof(cell_size));
+		fdt_setprop(dtb_buf, rsvmem_node, "ranges", NULL, 0);
+	}
+
+	for (i = 0; i < crash_memory_rgns.size; i++) {
+		sprintf(name, "crash_dump@%llx",
+					crash_memory_rgns.ranges[i].start);
+		nodeoffset = fdt_add_subnode(dtb_buf, rsvmem_node, name);
+		if (nodeoffset < 0) {
+			result = nodeoffset;
+			goto on_error;
+		}
+
+		range[0] = cpu_to_fdt64(crash_memory_rgns.ranges[i].start);
+		range[1] = cpu_to_fdt64(crash_memory_rgns.ranges[i].end
+					- crash_memory_rgns.ranges[i].start + 1);
+		fdt_setprop(dtb_buf, nodeoffset, "reg", &range, sizeof(range));
+		fdt_setprop(dtb_buf, nodeoffset, "no-map", NULL, 0);
+	}
+
+on_error:
+	return result;
+}
+
+/*
+ * Increased size for extra properties:
+ * - linux,elfcorehdr
+ *      linux,elfcoredhr = <base, size>;
+ * - reserved-memory node
+ *      reserved-memory {
+ *         #address-cells = <2>;
+ *         #size-cells = <2>;
+ *         ranges;
+ *         crash_dump@xx {
+ *            reg = <base, size>;
+ *            no-map;
+ *         };
+ *         ...
+ *      }
+ */
+#define DTB_ELFCOREHDR_PROP_SIZE \
+		 (sizeof(struct fdt_property)		\
+		+ FDT_TAGALIGN(sizeof(uint64_t) * 2)	\
+		+ strlen("linux,elfcorehdr") + 1)
+#define DTB_RESVMEM_NODE_SIZE \
+		 (sizeof(struct fdt_node_header)	\
+		+ strlen("reserved-memory") + 1		\
+		+ sizeof(struct fdt_property)		\
+		+ FDT_TAGALIGN(sizeof(uint32_t))	\
+		+ strlen("#address-cells") + 1		\
+		+ sizeof(struct fdt_property)		\
+		+ FDT_TAGALIGN(sizeof(uint32_t))	\
+		+ strlen("#size-cells") + 1		\
+		+ sizeof(struct fdt_property)		\
+		+ strlen("ranges") + 1)
+#define DTB_RESVMEM_SUBNODE_SIZE \
+		 (sizeof(struct fdt_node_header)	\
+		+ strlen("crash_dump@xxxxxxxxxxxxxxxx") + 1	\
+		+ sizeof(struct fdt_property)		\
+		+ FDT_TAGALIGN(sizeof(uint64_t) * 2)	\
+		+ strlen("reg") + 1			\
+		+ sizeof(struct fdt_property)	\
+		+ strlen("no-map") + 1)
+
+void *fixup_memory_properties(void *dtb_buf)
+{
+	char *new_buf;
+	int new_size;
+	uint64_t range[2];
+	int nodeoffset;
+	int result;
+
+	new_size = fdt_totalsize(dtb_buf)
+		   + DTB_ELFCOREHDR_PROP_SIZE
+		   + DTB_RESVMEM_NODE_SIZE
+		   + DTB_RESVMEM_SUBNODE_SIZE * crash_memory_rgns.size;
+
+	new_buf = xmalloc(new_size);
+	result = fdt_open_into(dtb_buf, new_buf, new_size);
+	if (result) {
+		dbgprintf("%s: fdt_open_into failed: %s\n", __func__,
+						fdt_strerror(result));
+		result = -EFAILED;
+		goto on_error;
+	}
+
+	range[0] = cpu_to_fdt64(elfcorehdr_mem.start);
+	range[1] = cpu_to_fdt64(elfcorehdr_mem.end - elfcorehdr_mem.start + 1);
+	nodeoffset = fdt_path_offset(new_buf, "/chosen");
+	result = fdt_setprop(new_buf, nodeoffset, "linux,elfcorehdr",
+						(void *)range, sizeof(range));
+	if (result) {
+		dbgprintf("%s: fdt_setprop failed: %s\n", __func__,
+						fdt_strerror(result));
+		goto on_error;
+	}
+
+	result = dtb_add_reserved_memory(new_buf);
+	if (result) {
+		dbgprintf("%s: adding reserved-memory failed: %s\n", __func__,
+						fdt_strerror(result));
+		result = -EFAILED;
+		goto on_error;
+	}
+
+	fdt_pack(new_buf);
+
+	return new_buf;
+
+on_error:
+	if (new_buf)
+		free(new_buf);
+	return NULL;
+}
diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
index 382f571..25889bc 100644
--- a/kexec/arch/arm64/crashdump-arm64.h
+++ b/kexec/arch/arm64/crashdump-arm64.h
@@ -16,11 +16,13 @@
 
 #define CRASH_MAX_MEMORY_RANGES	32
 
+extern struct memory_ranges crash_memory_rgns;
 extern struct memory_ranges usablemem_rgns;
 extern struct memory_range crash_reserved_mem;
 extern struct memory_range elfcorehdr_mem;
 
 extern int load_crashdump_segments(struct kexec_info *info);
 extern void modify_ehdr_for_crashdump(struct mem_ehdr *ehdr);
+extern void *fixup_memory_properties(void *dtb_buf);
 
 #endif /* CRASHDUMP_ARM64_H */
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index bcb4e76..6f26f29 100644
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
@@ -283,8 +280,10 @@ on_success:
  * setup_2nd_dtb - Setup the 2nd stage kernel's dtb.
  */
 
-static int setup_2nd_dtb(struct dtb *dtb, char *command_line)
+static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 {
+	int nodeoffset;
+	void *new_buf;
 	int result;
 
 	result = fdt_check_header(dtb->buf);
@@ -296,8 +295,32 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line)
 
 	result = set_bootargs(dtb, command_line);
 
+	/*
+	 * Those properties are meaningful only for the current kernel.
+	 * So remove them anyway.
+	 */
+	nodeoffset = fdt_path_offset(dtb->buf, "/chosen");
+	fdt_delprop(dtb->buf, nodeoffset, "linux,crashkernel-base");
+	fdt_delprop(dtb->buf, nodeoffset, "linux,crashkernel-size");
+	fdt_delprop(dtb->buf, nodeoffset, "linux,elfcorehdr");
+
+	if (on_crash) {
+		new_buf = fixup_memory_properties(dtb->buf);
+		if (!new_buf)
+			goto on_error;
+
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
+
 	return result;
 }
 
@@ -365,7 +388,8 @@ int arm64_load_other_segments(struct kexec_info *info,
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
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

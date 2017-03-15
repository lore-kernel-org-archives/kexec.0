Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1co5Ml-00007W-GF
 for kexec@lists.infradead.org; Wed, 15 Mar 2017 09:37:13 +0000
Received: by mail-pg0-x22c.google.com with SMTP id b129so6751795pgc.2
 for <kexec@lists.infradead.org>; Wed, 15 Mar 2017 02:36:55 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v6 8/9] arm64: kdump: add DT properties to crash dump kernel's
 dtb
Date: Wed, 15 Mar 2017 18:38:23 +0900
Message-Id: <20170315093824.24566-9-takahiro.akashi@linaro.org>
In-Reply-To: <20170315093824.24566-1-takahiro.akashi@linaro.org>
References: <20170315093824.24566-1-takahiro.akashi@linaro.org>
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
 kexec/arch/arm64/kexec-arm64.c     | 197 ++++++++++++++++++++++++++++++++++++-
 kexec/arch/arm64/kexec-elf-arm64.c |   5 -
 2 files changed, 192 insertions(+), 10 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 5e30107..f3f101d 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -25,6 +25,14 @@
 #include "kexec-syscall.h"
 #include "arch/options.h"
 
+#define ROOT_NODE_ADDR_CELLS_DEFAULT 1
+#define ROOT_NODE_SIZE_CELLS_DEFAULT 1
+
+#define PROP_ADDR_CELLS "#address-cells"
+#define PROP_SIZE_CELLS "#size-cells"
+#define PROP_ELFCOREHDR "linux,elfcorehdr"
+#define PROP_USABLE_MEM_RANGE "linux,usable-memory-range"
+
 /* Global varables the core kexec routines expect. */
 
 unsigned char reuse_initrd;
@@ -128,9 +136,6 @@ int arch_process_options(int argc, char **argv)
 		case OPT_INITRD:
 			arm64_opts.initrd = optarg;
 			break;
-		case OPT_PANIC:
-			die("load-panic (-p) not supported");
-			break;
 		default:
 			break; /* Ignore core and unknown options. */
 		}
@@ -281,12 +286,115 @@ on_success:
 	return 0;
 }
 
+static int get_cells_size(void *fdt, uint32_t *address_cells,
+						uint32_t *size_cells)
+{
+	int nodeoffset;
+	const uint32_t *prop = NULL;
+	int prop_len;
+
+	/* default values */
+	*address_cells = ROOT_NODE_ADDR_CELLS_DEFAULT;
+	*size_cells = ROOT_NODE_SIZE_CELLS_DEFAULT;
+
+	/* under root node */
+	nodeoffset = fdt_path_offset(fdt, "/");
+	if (nodeoffset < 0)
+		goto on_error;
+
+	prop = fdt_getprop(fdt, nodeoffset, PROP_ADDR_CELLS, &prop_len);
+	if (prop) {
+		if (prop_len == sizeof(*prop))
+			*address_cells = fdt32_to_cpu(*prop);
+		else
+			goto on_error;
+	}
+
+	prop = fdt_getprop(fdt, nodeoffset, PROP_SIZE_CELLS, &prop_len);
+	if (prop) {
+		if (prop_len == sizeof(*prop))
+			*size_cells = fdt32_to_cpu(*prop);
+		else
+			goto on_error;
+	}
+
+	dbgprintf("%s: #address-cells:%d #size-cells:%d\n", __func__,
+			*address_cells, *size_cells);
+	return 0;
+
+on_error:
+	return -EFAILED;
+}
+
+bool cells_size_fitted(uint32_t address_cells, uint32_t size_cells,
+						struct memory_range *range)
+{
+	dbgprintf("%s: %llx-%llx\n", __func__, range->start, range->end);
+
+	/* if *_cells >= 2, cells can hold 64-bit values anyway */
+	if ((address_cells == 1) && (range->start >= (1ULL << 32)))
+		return false;
+
+	if ((size_cells == 1) &&
+			((range->end - range->start + 1) >= (1ULL << 32)))
+		return false;
+
+	return true;
+}
+
+static void fill_property(void *buf, uint64_t val, uint32_t cells)
+{
+	uint32_t val32;
+	int i;
+
+	if (cells == 1) {
+		val32 = cpu_to_fdt32((uint32_t)val);
+		memcpy(buf, &val32, sizeof(uint32_t));
+	} else {
+		for (i = 0;
+		     i < (cells * sizeof(uint32_t) - sizeof(uint64_t)); i++)
+			*(char *)buf++ = 0;
+
+		val = cpu_to_fdt64(val);
+		memcpy(buf, &val, sizeof(uint64_t));
+	}
+}
+
+static int setprop_range(void *fdt, int nodeoffset,
+				const char *name, struct memory_range *range,
+				uint32_t address_cells, uint32_t size_cells)
+{
+	void *buf, *prop;
+	size_t buf_size;
+	int result;
+
+	buf_size = (address_cells + size_cells) * sizeof(uint32_t);
+	prop = buf = xmalloc(buf_size);
+
+	fill_property(prop, range->start, address_cells);
+	prop += address_cells * sizeof(uint32_t);
+
+	fill_property(prop, range->end - range->start + 1, size_cells);
+	prop += size_cells * sizeof(uint32_t);
+
+	result = fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
+
+	free(buf);
+
+	return result;
+}
+
 /**
  * setup_2nd_dtb - Setup the 2nd stage kernel's dtb.
  */
 
-static int setup_2nd_dtb(struct dtb *dtb, char *command_line)
+static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 {
+	uint32_t address_cells, size_cells;
+	int range_len;
+	int nodeoffset;
+	char *new_buf = NULL;
+	int new_size;
 	int result;
 
 	result = fdt_check_header(dtb->buf);
@@ -298,8 +406,86 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line)
 
 	result = set_bootargs(dtb, command_line);
 
+	if (on_crash) {
+		/* determine #address-cells and #size-cells */
+		result = get_cells_size(dtb->buf, &address_cells, &size_cells);
+		if (result) {
+			fprintf(stderr,
+				"kexec: cannot determine cells-size.\n");
+			result = -EINVAL;
+			goto on_error;
+		}
+
+		if (!cells_size_fitted(address_cells, size_cells,
+					&elfcorehdr_mem)) {
+			fprintf(stderr,
+				"kexec: elfcorehdr doesn't fit cells-size.\n");
+			result = -EINVAL;
+			goto on_error;
+		}
+
+		if (!cells_size_fitted(address_cells, size_cells,
+					&crash_reserved_mem)) {
+			fprintf(stderr,
+				"kexec: usable memory range doesn't fit cells-size.\n");
+			result = -EINVAL;
+			goto on_error;
+		}
+
+		/* duplicate dt blob */
+		range_len = sizeof(uint32_t) * (address_cells + size_cells);
+		new_size = fdt_totalsize(dtb->buf)
+			+ fdt_prop_len(PROP_ELFCOREHDR, range_len)
+			+ fdt_prop_len(PROP_USABLE_MEM_RANGE, range_len);
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
+		/* add linux,elfcorehdr */
+		nodeoffset = fdt_path_offset(new_buf, "/chosen");
+		result = setprop_range(new_buf, nodeoffset,
+				PROP_ELFCOREHDR, &elfcorehdr_mem,
+				address_cells, size_cells);
+		if (result) {
+			dbgprintf("%s: fdt_setprop failed: %s\n", __func__,
+				fdt_strerror(result));
+			result = -EINVAL;
+			goto on_error;
+		}
+
+		/* add linux,usable-memory-range */
+		nodeoffset = fdt_path_offset(new_buf, "/chosen");
+		result = setprop_range(new_buf, nodeoffset,
+				PROP_USABLE_MEM_RANGE, &crash_reserved_mem,
+				address_cells, size_cells);
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
 
@@ -367,7 +553,8 @@ int arm64_load_other_segments(struct kexec_info *info,
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
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

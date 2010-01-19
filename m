Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NXN3O-0006sn-QX
	for kexec@lists.infradead.org; Tue, 19 Jan 2010 23:00:16 +0000
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 5/5] powerpc32: add support for uImage
Date: Tue, 19 Jan 2010 23:59:45 +0100
Message-Id: <1263941985-18856-6-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1263941985-18856-1-git-send-email-sebastian@breakpoint.cc>
References: <1263941985-18856-1-git-send-email-sebastian@breakpoint.cc>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kumar Gala <galak@kernel.crashing.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On PowerPC the uImage usually contains the compressed "final" kernel and
not a tiny wrapper which relocates itself und uncomprosses the final
kernel to its final position. Instead we uncompress the gzip image and
put it the its final position.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kexec/arch/ppc/Makefile           |    1 +
 kexec/arch/ppc/kexec-ppc.c        |    1 +
 kexec/arch/ppc/kexec-ppc.h        |    5 +
 kexec/arch/ppc/kexec-uImage-ppc.c |  336 +++++++++++++++++++++++++++++++++++++
 4 files changed, 343 insertions(+), 0 deletions(-)
 create mode 100644 kexec/arch/ppc/kexec-uImage-ppc.c

diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
index 90dfa5b..a6f9a04 100644
--- a/kexec/arch/ppc/Makefile
+++ b/kexec/arch/ppc/Makefile
@@ -7,6 +7,7 @@ ppc_KEXEC_SRCS =  kexec/arch/ppc/kexec-ppc.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/kexec-elf-ppc.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/kexec-elf-rel-ppc.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/kexec-dol-ppc.c
+ppc_KEXEC_SRCS += kexec/arch/ppc/kexec-uImage-ppc.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/ppc-setup-simple.S
 ppc_KEXEC_SRCS += kexec/arch/ppc/ppc-setup-dol.S
 
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index ef22c3d..9708b8c 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -485,6 +485,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 struct file_type file_type[] = {
 	{"elf-ppc", elf_ppc_probe, elf_ppc_load, elf_ppc_usage},
 	{"dol-ppc", dol_ppc_probe, dol_ppc_load, dol_ppc_usage},
+	{"uImage-ppc", uImage_ppc_probe, uImage_ppc_load, uImage_ppc_usage },
 };
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
 
diff --git a/kexec/arch/ppc/kexec-ppc.h b/kexec/arch/ppc/kexec-ppc.h
index 1b2b015..6cec467 100644
--- a/kexec/arch/ppc/kexec-ppc.h
+++ b/kexec/arch/ppc/kexec-ppc.h
@@ -21,6 +21,11 @@ int elf_ppc_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_ppc_usage(void);
 
+int uImage_ppc_probe(const char *buf, off_t len);
+int uImage_ppc_load(int argc, char **argv, const char *buf, off_t len,
+	struct kexec_info *info);
+void uImage_ppc_usage(void);
+
 int dol_ppc_probe(const char *buf, off_t len);
 int dol_ppc_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
new file mode 100644
index 0000000..8232d0e
--- /dev/null
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -0,0 +1,336 @@
+/*
+ * uImage support for PowerPC
+ */
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/types.h>
+#include <zlib.h>
+#include <image.h>
+#include <getopt.h>
+#include <arch/options.h>
+#include "../../kexec.h"
+#include "kexec-ppc.h"
+#include "fixup_dtb.h"
+
+#define OPT_APPEND      (OPT_ARCH_MAX+0)
+#define OPT_DTB         (OPT_ARCH_MAX+1)
+#define OPT_NODES       (OPT_ARCH_MAX+2)
+static const struct option options[] = {
+	KEXEC_ARCH_OPTIONS
+	{"command-line",	1, 0, OPT_APPEND},
+	{"append",	1, 0, OPT_APPEND},
+	{"dtb",		1, 0, OPT_DTB},
+	{"reuse-node",	1, 0, OPT_NODES},
+	{0, 0, 0, 0},
+};
+static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
+
+void uImage_ppc_usage(void)
+{
+	printf(
+			"    --command-line=STRING Set the kernel command line to STRING.\n"
+			"    --append=STRING       Set the kernel command line to STRING.\n"
+			"     --dtb=<filename>     Specify device tree blob file.\n"
+			"     --reuse-node=node    Specify nodes which should be taken from /proc/device-tree.\n"
+			"                          Can be set multiple times.\n"
+	);
+}
+
+int uImage_ppc_probe(const char *buf, off_t len)
+{
+	struct image_header header;
+	unsigned int crc;
+	unsigned int hcrc;
+
+	if (len < sizeof(header))
+		return -1;
+
+	memcpy(&header, buf, sizeof(header));
+
+	if (cpu_to_be32(header.ih_magic) != IH_MAGIC)
+		return -1;
+
+	hcrc = be32_to_cpu(header.ih_hcrc);
+	header.ih_hcrc = 0;
+	crc = crc32(0, (void *)&header, sizeof(header));
+	if (crc != hcrc) {
+		printf("Header checksum of the uImage does not match\n");
+		return -1;
+	}
+
+	if (header.ih_type != IH_TYPE_KERNEL) {
+		printf("uImage type %d unsupported\n", header.ih_type);
+		return -1;
+	}
+
+	if (header.ih_os != IH_OS_LINUX) {
+		printf("uImage os %d unsupported\n", header.ih_os);
+		return -1;
+	}
+
+	if (header.ih_arch != IH_ARCH_PPC) {
+		printf("uImage arch %d unsupported\n", header.ih_arch);
+		return -1;
+	}
+
+	switch (header.ih_comp) {
+	case IH_COMP_NONE:
+	case IH_COMP_GZIP:
+		break;
+
+	case IH_COMP_BZIP2:
+	case IH_COMP_LZMA:
+	case IH_COMP_LZO:
+	default:
+		printf("uImage uses unsupported compression method\n");
+		return -1;
+	}
+
+	crc = crc32(0, (void *)buf + sizeof(header), len - sizeof(header));
+	if (crc != be32_to_cpu(header.ih_dcrc)) {
+		printf("The data CRC does not match. Computed: %08x expected %08x\n",
+			crc, be32_to_cpu(header.ih_dcrc));
+		return -1;
+	}
+	return 0;
+}
+
+static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
+		off_t len, struct kexec_info *info, unsigned int load_addr,
+		unsigned int ep)
+{
+	char *command_line;
+	int command_line_len;
+	char *dtb;
+	unsigned int addr;
+	unsigned long dtb_addr;
+#define FIXUP_ENTRYS    (20)
+	char *fixup_nodes[FIXUP_ENTRYS + 1];
+	int cur_fixup = 0;
+	int opt;
+	int ret;
+
+	command_line = NULL;
+	dtb = NULL;
+
+	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
+		switch (opt) {
+		default:
+			/* Ignore core options */
+			if (opt < OPT_ARCH_MAX) {
+				break;
+			}
+		case '?':
+			usage();
+			return -1;
+		case OPT_APPEND:
+			command_line = optarg;
+			break;
+
+		case OPT_DTB:
+			dtb = optarg;
+			break;
+
+		case OPT_NODES:
+			if (cur_fixup >= FIXUP_ENTRYS) {
+				fprintf(stderr, "The number of entries for the fixup is too large\n");
+				exit(1);
+			}
+			fixup_nodes[cur_fixup] = optarg;
+			cur_fixup++;
+			break;
+		}
+	}
+
+	command_line_len = 0;
+	if (command_line)
+		command_line_len = strlen(command_line) + 1;
+
+	fixup_nodes[cur_fixup] = NULL;
+
+	/*
+	 * len contains the length of the whole kernel image except the bss
+	 * section. The 3 MiB should cover it. The purgatory and the dtb are
+	 * allocated from memtop down towards zero so we should never get too
+	 * close to the bss :)
+	 */
+	ret = valid_memory_range(info, load_addr, len + 3 * 1024 * 1024);
+	if (!ret) {
+		printf("Can't add kernel to addr 0x%08x len %ld\n",
+				load_addr, len + 3 * 1024 * 1024);
+		return -1;
+	}
+	add_segment(info, buf, len, load_addr, len + 3 * 1024 * 1024);
+	if (dtb) {
+		char *blob_buf;
+		off_t blob_size = 0;
+
+		/* Grab device tree from buffer */
+		blob_buf = slurp_file(dtb, &blob_size);
+		if (!blob_buf || !blob_size)
+			die("Device tree seems to be an empty file.\n");
+		blob_buf = fixup_dtb_nodes(blob_buf, &blob_size, fixup_nodes, command_line);
+
+		dtb_addr = add_buffer(info, blob_buf, blob_size, blob_size, 0, 0,
+				KERNEL_ACCESS_TOP, -1);
+	} else {
+		dtb_addr = 0;
+	}
+
+	elf_rel_build_load(info, &info->rhdr, (const char *)purgatory,
+			purgatory_size, 0, -1, -1, 0);
+
+	/* set various variables for the purgatory */
+	addr = ep;
+	elf_rel_set_symbol(&info->rhdr, "kernel", &addr, sizeof(addr));
+
+	addr = dtb_addr;
+	elf_rel_set_symbol(&info->rhdr, "dt_offset", &addr, sizeof(addr));
+
+	addr = rmo_top;
+	elf_rel_set_symbol(&info->rhdr, "mem_size", &addr, sizeof(addr));
+
+#define PUL_STACK_SIZE  (16 * 1024)
+	addr = locate_hole(info, PUL_STACK_SIZE, 0, 0, -1, 1);
+	addr += PUL_STACK_SIZE;
+	elf_rel_set_symbol(&info->rhdr, "pul_stack", &addr, sizeof(addr));
+	/* No allocation past here in order not to overwrite the stack */
+#undef PUL_STACK_SIZE
+
+	addr = elf_rel_get_addr(&info->rhdr, "purgatory_start");
+	info->entry = (void *)addr;
+	return 0;
+}
+
+/* gzip flag byte */
+#define ASCII_FLAG	0x01 /* bit 0 set: file probably ascii text */
+#define HEAD_CRC	0x02 /* bit 1 set: header CRC present */
+#define EXTRA_FIELD	0x04 /* bit 2 set: extra field present */
+#define ORIG_NAME	0x08 /* bit 3 set: original file name present */
+#define COMMENT		0x10 /* bit 4 set: file comment present */
+#define RESERVED	0xE0 /* bits 5..7: reserved */
+
+static int uImage_gz_load(int argc, char **argv, const char *buf, off_t len,
+		struct kexec_info *info, unsigned int load_addr,
+		unsigned int ep)
+{
+	int ret;
+	z_stream strm;
+	unsigned int skip;
+	unsigned int flags;
+	unsigned char *uncomp_buf;
+	unsigned int mem_alloc;
+
+	mem_alloc = 10 * 1024 * 1024;
+	uncomp_buf = malloc(mem_alloc);
+	if (!uncomp_buf)
+		return -1;
+
+	memset(&strm, 0, sizeof(strm));
+
+	/* Skip magic, method, time, flags, os code ... */
+	skip = 10;
+
+	/* check GZ magic */
+	if (buf[0] != 0x1f || buf[1] != 0x8b)
+		return -1;
+
+	flags = buf[3];
+	if (buf[2] != Z_DEFLATED || (flags & RESERVED) != 0) {
+		puts ("Error: Bad gzipped data\n");
+		return -1;
+	}
+
+	if (flags & EXTRA_FIELD) {
+		skip += 2;
+		skip += buf[10];
+		skip += buf[11] << 8;
+	}
+	if (flags & ORIG_NAME) {
+		while (buf[skip++])
+			;
+	}
+	if (flags & COMMENT) {
+		while (buf[skip++])
+			;
+	}
+	if (flags & HEAD_CRC)
+		skip += 2;
+
+	strm.avail_in = len - skip;
+	strm.next_in = (void *)buf + skip;
+
+	/* - activates parsing gz headers */
+	ret = inflateInit2(&strm, -MAX_WBITS);
+	if (ret != Z_OK)
+		return -1;
+
+	strm.next_out = uncomp_buf;
+	strm.avail_out = mem_alloc;
+
+	do {
+		ret = inflate(&strm, Z_FINISH);
+		if (ret == Z_STREAM_END)
+			break;
+
+		if (ret == Z_OK || ret == Z_BUF_ERROR) {
+			void *new_buf;
+			int inc_buf = 5 * 1024 * 1024;
+
+			mem_alloc += inc_buf;
+			new_buf = realloc(uncomp_buf, mem_alloc);
+			if (!new_buf) {
+				inflateEnd(&strm);
+				free(uncomp_buf);
+				return -1;
+			}
+
+			strm.next_out = uncomp_buf + mem_alloc - inc_buf;
+			strm.avail_out = inc_buf;
+			uncomp_buf = new_buf;
+		} else {
+			printf("Error during decompression %d\n", ret);
+			return -1;
+		}
+	} while (1);
+
+	inflateEnd(&strm);
+
+	ret = ppc_load_bare_bits(argc, argv, (char *)uncomp_buf,
+			mem_alloc - strm.avail_out, info,
+			load_addr, ep);
+
+	/* leak uncomp_buf since the buffer has to remain past this function */
+	return ret;
+}
+
+int uImage_ppc_load(int argc, char **argv, const char *buf, off_t len,
+		struct kexec_info *info)
+{
+	const struct image_header *header = (const struct image_header *)buf;
+	const char *img_buf = buf + sizeof(struct image_header);
+	off_t img_len = len - sizeof(struct image_header);
+	unsigned int img_base = cpu_to_be32(header->ih_load);
+	unsigned int img_entry = cpu_to_be32(header->ih_ep);
+
+	switch (header->ih_comp) {
+	case IH_COMP_NONE:
+		return ppc_load_bare_bits(argc, argv, img_buf, img_len, info,
+				img_base, img_entry);
+		break;
+
+	case IH_COMP_GZIP:
+		return uImage_gz_load(argc, argv, img_buf, img_len, info,
+				img_base, img_entry);
+		break;
+
+	case IH_COMP_BZIP2:
+	case IH_COMP_LZMA:
+	case IH_COMP_LZO:
+	default:
+	printf("%s(%d)\n", __func__, __LINE__);
+		return -1;
+	}
+}
-- 
1.6.5.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

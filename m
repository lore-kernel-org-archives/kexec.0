Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NwtDw-0002uO-ES
	for kexec@lists.infradead.org; Wed, 31 Mar 2010 08:24:31 +0000
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 6/7] Split Powerpc's uImage code
Date: Wed, 31 Mar 2010 10:24:17 +0200
Message-Id: <1270023858-26947-7-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1270023858-26947-1-git-send-email-sebastian@breakpoint.cc>
References: <1270023858-26947-1-git-send-email-sebastian@breakpoint.cc>
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
To: Simon Horman <horms@verge.net.au>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The check and uncompress code could be split and recycled by other arch.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/kexec-uImage.h            |   13 +++
 kexec/arch/ppc/Makefile           |    1 +
 kexec/arch/ppc/kexec-uImage-ppc.c |  201 ++---------------------------------
 kexec/kexec-uImage.c              |  213 +++++++++++++++++++++++++++++++++++++
 4 files changed, 236 insertions(+), 192 deletions(-)
 create mode 100644 include/kexec-uImage.h
 create mode 100644 kexec/kexec-uImage.c

diff --git a/include/kexec-uImage.h b/include/kexec-uImage.h
new file mode 100644
index 0000000..e8a4b69
--- /dev/null
+++ b/include/kexec-uImage.h
@@ -0,0 +1,13 @@
+#ifndef __KEXEC_UIMAGE_H__
+#define __KEXEC_UIMAGE_H__
+
+struct Image_info {
+	const char *buf;
+	off_t len;
+	unsigned int base;
+	unsigned int ep;
+};
+
+int uImage_probe(const char *buf, off_t len, unsigned int arch);
+int uImage_load(const char *buf, off_t len, struct Image_info *info);
+#endif
diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
index 698fd03..1c7441c 100644
--- a/kexec/arch/ppc/Makefile
+++ b/kexec/arch/ppc/Makefile
@@ -11,6 +11,7 @@ ppc_KEXEC_SRCS += kexec/arch/ppc/kexec-uImage-ppc.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/ppc-setup-simple.S
 ppc_KEXEC_SRCS += kexec/arch/ppc/ppc-setup-dol.S
 ppc_KEXEC_SRCS += kexec/arch/ppc/fixup_dtb.c
+ppc_KEXEC_SRCS += kexec/kexec-uImage.c
 
 libfdt_SRCS = kexec/arch/ppc/libfdt-wrapper.c
 libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/arch/ppc/libfdt/%)
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 47e6c10..0a655a3 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -6,15 +6,13 @@
 #include <stdint.h>
 #include <string.h>
 #include <sys/types.h>
-#ifdef HAVE_LIBZ
-#include <zlib.h>
-#endif
 #include <image.h>
 #include <getopt.h>
 #include <arch/options.h>
 #include "../../kexec.h"
 #include "kexec-ppc.h"
 #include "fixup_dtb.h"
+#include <kexec-uImage.h>
 
 #define OPT_APPEND      (OPT_ARCH_MAX+0)
 #define OPT_DTB         (OPT_ARCH_MAX+1)
@@ -42,64 +40,7 @@ void uImage_ppc_usage(void)
 
 int uImage_ppc_probe(const char *buf, off_t len)
 {
-	struct image_header header;
-#ifdef HAVE_LIBZ
-	unsigned int crc;
-	unsigned int hcrc;
-#endif
-
-	if (len < sizeof(header))
-		return -1;
-
-	memcpy(&header, buf, sizeof(header));
-
-	if (cpu_to_be32(header.ih_magic) != IH_MAGIC)
-		return -1;
-#ifdef HAVE_LIBZ
-	hcrc = be32_to_cpu(header.ih_hcrc);
-	header.ih_hcrc = 0;
-	crc = crc32(0, (void *)&header, sizeof(header));
-	if (crc != hcrc) {
-		printf("Header checksum of the uImage does not match\n");
-		return -1;
-	}
-#endif
-
-	if (header.ih_type != IH_TYPE_KERNEL) {
-		printf("uImage type %d unsupported\n", header.ih_type);
-		return -1;
-	}
-
-	if (header.ih_os != IH_OS_LINUX) {
-		printf("uImage os %d unsupported\n", header.ih_os);
-		return -1;
-	}
-
-	if (header.ih_arch != IH_ARCH_PPC) {
-		printf("uImage arch %d unsupported\n", header.ih_arch);
-		return -1;
-	}
-
-	switch (header.ih_comp) {
-	case IH_COMP_NONE:
-#ifdef HAVE_LIBZ
-	case IH_COMP_GZIP:
-#endif
-		break;
-
-	default:
-		printf("uImage uses unsupported compression method\n");
-		return -1;
-	}
-#ifdef HAVE_LIBZ
-	crc = crc32(0, (void *)buf + sizeof(header), len - sizeof(header));
-	if (crc != be32_to_cpu(header.ih_dcrc)) {
-		printf("The data CRC does not match. Computed: %08x expected %08x\n",
-			crc, be32_to_cpu(header.ih_dcrc));
-		return -1;
-	}
-#endif
-	return 0;
+	return uImage_probe(buf, len, IH_ARCH_PPC);
 }
 
 static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
@@ -209,140 +150,16 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 	return 0;
 }
 
-#ifdef HAVE_LIBZ
-/* gzip flag byte */
-#define ASCII_FLAG	0x01 /* bit 0 set: file probably ascii text */
-#define HEAD_CRC	0x02 /* bit 1 set: header CRC present */
-#define EXTRA_FIELD	0x04 /* bit 2 set: extra field present */
-#define ORIG_NAME	0x08 /* bit 3 set: original file name present */
-#define COMMENT		0x10 /* bit 4 set: file comment present */
-#define RESERVED	0xE0 /* bits 5..7: reserved */
-
-static int uImage_gz_load(int argc, char **argv, const char *buf, off_t len,
-		struct kexec_info *info, unsigned int load_addr,
-		unsigned int ep)
-{
-	int ret;
-	z_stream strm;
-	unsigned int skip;
-	unsigned int flags;
-	unsigned char *uncomp_buf;
-	unsigned int mem_alloc;
-
-	mem_alloc = 10 * 1024 * 1024;
-	uncomp_buf = malloc(mem_alloc);
-	if (!uncomp_buf)
-		return -1;
-
-	memset(&strm, 0, sizeof(strm));
-
-	/* Skip magic, method, time, flags, os code ... */
-	skip = 10;
-
-	/* check GZ magic */
-	if (buf[0] != 0x1f || buf[1] != 0x8b)
-		return -1;
-
-	flags = buf[3];
-	if (buf[2] != Z_DEFLATED || (flags & RESERVED) != 0) {
-		puts ("Error: Bad gzipped data\n");
-		return -1;
-	}
-
-	if (flags & EXTRA_FIELD) {
-		skip += 2;
-		skip += buf[10];
-		skip += buf[11] << 8;
-	}
-	if (flags & ORIG_NAME) {
-		while (buf[skip++])
-			;
-	}
-	if (flags & COMMENT) {
-		while (buf[skip++])
-			;
-	}
-	if (flags & HEAD_CRC)
-		skip += 2;
-
-	strm.avail_in = len - skip;
-	strm.next_in = (void *)buf + skip;
-
-	/* - activates parsing gz headers */
-	ret = inflateInit2(&strm, -MAX_WBITS);
-	if (ret != Z_OK)
-		return -1;
-
-	strm.next_out = uncomp_buf;
-	strm.avail_out = mem_alloc;
-
-	do {
-		ret = inflate(&strm, Z_FINISH);
-		if (ret == Z_STREAM_END)
-			break;
-
-		if (ret == Z_OK || ret == Z_BUF_ERROR) {
-			void *new_buf;
-			int inc_buf = 5 * 1024 * 1024;
-
-			mem_alloc += inc_buf;
-			new_buf = realloc(uncomp_buf, mem_alloc);
-			if (!new_buf) {
-				inflateEnd(&strm);
-				free(uncomp_buf);
-				return -1;
-			}
-
-			strm.next_out = uncomp_buf + mem_alloc - inc_buf;
-			strm.avail_out = inc_buf;
-			uncomp_buf = new_buf;
-		} else {
-			printf("Error during decompression %d\n", ret);
-			return -1;
-		}
-	} while (1);
-
-	inflateEnd(&strm);
-
-	ret = ppc_load_bare_bits(argc, argv, (char *)uncomp_buf,
-			mem_alloc - strm.avail_out, info,
-			load_addr, ep);
-
-	/* leak uncomp_buf since the buffer has to remain past this function */
-	return ret;
-}
-
-#else
-
-static int uImage_gz_load(int argc, char **argv, const char *buf, off_t len,
-		struct kexec_info *info, unsigned int load_addr,
-		unsigned int ep)
-{
-	return -1;
-}
-#endif
-
 int uImage_ppc_load(int argc, char **argv, const char *buf, off_t len,
 		struct kexec_info *info)
 {
-	const struct image_header *header = (const struct image_header *)buf;
-	const char *img_buf = buf + sizeof(struct image_header);
-	off_t img_len = len - sizeof(struct image_header);
-	unsigned int img_base = cpu_to_be32(header->ih_load);
-	unsigned int img_entry = cpu_to_be32(header->ih_ep);
-
-	switch (header->ih_comp) {
-	case IH_COMP_NONE:
-		return ppc_load_bare_bits(argc, argv, img_buf, img_len, info,
-				img_base, img_entry);
-		break;
+	struct Image_info img;
+	int ret;
 
-	case IH_COMP_GZIP:
-		return uImage_gz_load(argc, argv, img_buf, img_len, info,
-				img_base, img_entry);
-		break;
+	ret = uImage_load(buf, len, &img);
+	if (ret)
+		return ret;
 
-	default:
-		return -1;
-	}
+	return	ppc_load_bare_bits(argc, argv, img.buf, img.len, info,
+				img.base, img.ep);
 }
diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
new file mode 100644
index 0000000..4ce0f38
--- /dev/null
+++ b/kexec/kexec-uImage.c
@@ -0,0 +1,213 @@
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/types.h>
+#include <image.h>
+#include <getopt.h>
+#include <arch/options.h>
+#include "kexec.h"
+#include <kexec-uImage.h>
+
+#ifdef HAVE_LIBZ
+#include <zlib.h>
+#endif
+/*
+ * Basic uImage loader. Not rocket science.
+ */
+
+int uImage_probe(const char *buf, off_t len, unsigned int arch)
+{
+	struct image_header header;
+#ifdef HAVE_LIBZ
+	unsigned int crc;
+	unsigned int hcrc;
+#endif
+
+	if ((uintmax_t)len < (uintmax_t)sizeof(header))
+		return -1;
+
+	memcpy(&header, buf, sizeof(header));
+	if (be32_to_cpu(header.ih_magic) != IH_MAGIC)
+		return -1;
+#ifdef HAVE_LIBZ
+	hcrc = be32_to_cpu(header.ih_hcrc);
+	header.ih_hcrc = 0;
+	crc = crc32(0, (void *)&header, sizeof(header));
+	if (crc != hcrc) {
+		printf("Header checksum of the uImage does not match\n");
+		return -1;
+	}
+#endif
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
+	if (header.ih_arch != arch) {
+		printf("uImage arch %d unsupported\n", header.ih_arch);
+		return -1;
+	}
+
+	switch (header.ih_comp) {
+	case IH_COMP_NONE:
+#ifdef HAVE_LIBZ
+	case IH_COMP_GZIP:
+#endif
+		break;
+	default:
+		printf("uImage uses unsupported compression method\n");
+		return -1;
+	}
+
+	if (be32_to_cpu(header.ih_size) > len - sizeof(header)) {
+		printf("uImage header claims that image has %d bytes\n",
+				be32_to_cpu(header.ih_size));
+		printf("we read only %ld bytes.\n", len - sizeof(header));
+		return -1;
+	}
+#ifdef HAVE_LIBZ
+	crc = crc32(0, (void *)buf + sizeof(header), len - sizeof(header));
+	if (crc != be32_to_cpu(header.ih_dcrc)) {
+		printf("The data CRC does not match. Computed: %08x "
+				"expected %08x\n", crc,
+				be32_to_cpu(header.ih_dcrc));
+		return -1;
+	}
+#endif
+	return 0;
+}
+
+#ifdef HAVE_LIBZ
+/* gzip flag byte */
+#define ASCII_FLAG	0x01 /* bit 0 set: file probably ascii text */
+#define HEAD_CRC	0x02 /* bit 1 set: header CRC present */
+#define EXTRA_FIELD	0x04 /* bit 2 set: extra field present */
+#define ORIG_NAME	0x08 /* bit 3 set: original file name present */
+#define COMMENT		0x10 /* bit 4 set: file comment present */
+#define RESERVED	0xE0 /* bits 5..7: reserved */
+
+static int uImage_gz_load(const char *buf, off_t len,
+		struct Image_info *image)
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
+	image->buf = (char *)uncomp_buf;
+	image->len = mem_alloc - strm.avail_out;
+	return 0;
+}
+#else
+static int uImage_gz_load(const char *UNUSED(buf), off_t UNUSED(len),
+		struct Image_info *UNUSED(image))
+{
+	return -1;
+}
+#endif
+
+int uImage_load(const char *buf, off_t len, struct Image_info *image)
+{
+	const struct image_header *header = (const struct image_header *)buf;
+	const char *img_buf = buf + sizeof(struct image_header);
+	off_t img_len = len - sizeof(struct image_header);
+
+	image->base = cpu_to_be32(header->ih_load);
+	image->ep = cpu_to_be32(header->ih_ep);
+	switch (header->ih_comp) {
+	case IH_COMP_NONE:
+		image->buf = img_buf;
+		image->len = len;
+		return 0;
+		break;
+
+	case IH_COMP_GZIP:
+		return uImage_gz_load(img_buf, img_len, image);
+		break;
+
+	default:
+		return -1;
+	}
+}
-- 
1.6.5.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

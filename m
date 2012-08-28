Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T6H0a-00073e-C9
 for kexec@lists.infradead.org; Tue, 28 Aug 2012 08:18:53 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 7/7] arm: Add Device Tree support
Date: Tue, 28 Aug 2012 17:18:30 +0900
Message-Id: <1346141910-8214-8-git-send-email-horms@verge.net.au>
In-Reply-To: <1346141910-8214-1-git-send-email-horms@verge.net.au>
References: <1346141910-8214-1-git-send-email-horms@verge.net.au>
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
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>

This should mirror the functionality available in 32 and 64 bit powerpc.

1. A dtb may be provided on the command line using the --dtb command line option
2. Else, if /proc/device-tree is present a flattened devices tree will
   be synthesised from there
3. Otherwise kexec-tools will fall back to the existing atags behaviour,
   synthesising atags from /proc/atags

This patch has undergone light testing using an Armadillo 800 EVA board
in conjunction with a 3.6-rc3 kernel.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/arm/Makefile               |   8 +++
 kexec/arch/arm/include/arch/options.h |   4 +-
 kexec/arch/arm/kexec-arm.h            |   7 +++
 kexec/arch/arm/kexec-zImage-arm.c     | 100 +++++++++++++++++++++++++++++++---
 kexec/fs2dt.h                         |   1 -
 5 files changed, 109 insertions(+), 11 deletions(-)

diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 288ec33..00e6acd 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -1,6 +1,14 @@
 #
 # kexec arm (linux booting linux)
 #
+include $(srcdir)/kexec/libfdt/Makefile.libfdt
+
+arm_FS2DT		= kexec/fs2dt.c
+arm_FS2DT_INCLUDE	= -include kexec/arch/arm/crashdump-arm.h \
+			  -include kexec/arch/arm/kexec-arm.h
+
+arm_KEXEC_SRCS += kexec/fs2dt.c
+
 arm_KEXEC_SRCS=  kexec/arch/arm/kexec-elf-rel-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-zImage-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-uImage-arm.c
diff --git a/kexec/arch/arm/include/arch/options.h b/kexec/arch/arm/include/arch/options.h
index d89c91f..de08471 100644
--- a/kexec/arch/arm/include/arch/options.h
+++ b/kexec/arch/arm/include/arch/options.h
@@ -5,6 +5,7 @@
 
 #define OPT_APPEND	'a'
 #define OPT_RAMDISK	'r'
+#define OPT_DTB		(OPT_ARCH_MAX+0)
 
 /* Options relevant to the architecture (excluding loader-specific ones),
  * in this case none:
@@ -33,7 +34,8 @@
 	{ "command-line",	1, 0, OPT_APPEND },	\
 	{ "append",		1, 0, OPT_APPEND },	\
 	{ "initrd",		1, 0, OPT_RAMDISK },	\
-	{ "ramdisk",		1, 0, OPT_RAMDISK },
+	{ "ramdisk",		1, 0, OPT_RAMDISK },	\
+	{ "dtb",		1, 0, OPT_DTB },
 
 #define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR "a:r:"
 
diff --git a/kexec/arch/arm/kexec-arm.h b/kexec/arch/arm/kexec-arm.h
index 0d9a066..79663e3 100644
--- a/kexec/arch/arm/kexec-arm.h
+++ b/kexec/arch/arm/kexec-arm.h
@@ -1,6 +1,13 @@
 #ifndef KEXEC_ARM_H
 #define KEXEC_ARM_H
 
+#include <sys/types.h>
+
+#define BOOT_BLOCK_VERSION 17
+#define BOOT_BLOCK_LAST_COMP_VERSION 16
+
+extern off_t initrd_base, initrd_size;
+
 int zImage_arm_probe(const char *buf, off_t len);
 int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		        struct kexec_info *info);
diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 88a6c29..788b941 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -7,19 +7,25 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <errno.h>
 #include <limits.h>
 #include <stdint.h>
 #include <unistd.h>
 #include <getopt.h>
 #include <unistd.h>
+#include <ctype.h>
 #include <arch/options.h>
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
+#include "kexec-arm.h"
+#include "../../fs2dt.h"
 #include "crashdump-arm.h"
 
 #define BOOT_PARAMS_SIZE 1536
 
+off_t initrd_base = 0, initrd_size = 0;
+
 struct tag_header {
 	uint32_t size;
 	uint32_t tag;
@@ -208,20 +214,80 @@ int atag_arm_load(struct kexec_info *info, unsigned long base,
 	return 0;
 }
 
+static
+void dtb_arm_load(struct kexec_info *info, unsigned long base,
+		 const char *dtb, const char *command_line)
+{
+	char *blob_buf = NULL;
+	off_t blob_size = 0;
+
+	/* Here we need to initialize the device tree, and find out where
+	 * it is going to live so we can place it directly after the
+	 * kernel image */
+	if (dtb) {
+		/* Grab device tree from buffer */
+		blob_buf = slurp_file(dtb, &blob_size);
+	} else {
+		create_flatten_tree(&blob_buf, &blob_size, command_line);
+	}
+
+	if (!blob_buf || !blob_size)
+		die("Device tree seems to be an empty file.\n");
+
+	{
+		int i = 0, j = 0, k, alt = 0;
+		while (i < blob_size && j < blob_size) {
+			if (!(k % 16)) {
+				if (!alt)
+					fprintf(stderr, "%04x ", i);
+				else
+					fprintf(stderr, "     ");
+			}
+			if (!alt) {
+				if (isprint(blob_buf[i]))
+					fprintf(stderr, " %c", blob_buf[i]);
+				else
+					fprintf(stderr, "%02x", blob_buf[i]);
+				k = ++i;
+			} else {
+				fprintf(stderr, "%02x", blob_buf[j]);
+				k = ++j;
+			}
+			switch (k % 16) {
+			case 0:
+				fprintf(stderr, "\n");
+				if (alt)
+					fprintf(stderr, "\n");
+				alt = alt ? 0 : 1;
+				break;
+			case 8:
+				fprintf(stderr, "  ");
+				break;
+			default:
+				fprintf(stderr, " ");
+				break;
+			}
+		}
+		fprintf(stderr, "\n");
+	}
+
+	add_segment(info, blob_buf, blob_size, base, blob_size);
+}
+
 int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
 	unsigned long base;
-	unsigned int atag_offset = 0x1000; /* 4k offset from memory start */
+	unsigned int base_offset = 0x1000; /* 4k offset from memory start */
 	unsigned int offset = 0x8000;      /* 32k offset from memory start */
 	const char *command_line;
 	char *modified_cmdline = NULL;
 	off_t command_line_len;
 	const char *ramdisk;
 	char *ramdisk_buf;
-	off_t ramdisk_length;
-	off_t ramdisk_offset;
+	const char *dtb = NULL;
 	int opt;
+	bool have_proc_device_tree = false;
 	/* See options.h -- add any more there, too. */
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
@@ -229,6 +295,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		{ "append",		1, 0, OPT_APPEND },
 		{ "initrd",		1, 0, OPT_RAMDISK },
 		{ "ramdisk",		1, 0, OPT_RAMDISK },
+		{ "dtb",		1, 0, OPT_DTB },
 		{ 0, 			0, 0, 0 },
 	};
 	static const char short_options[] = KEXEC_ARCH_OPT_STR "a:r:";
@@ -240,7 +307,6 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	command_line_len = 0;
 	ramdisk = 0;
 	ramdisk_buf = 0;
-	ramdisk_length = 0;
 	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch(opt) {
 		default:
@@ -257,6 +323,9 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		case OPT_RAMDISK:
 			ramdisk = optarg;
 			break;
+		case OPT_DTB:
+			dtb = optarg;
+			break;
 		}
 	}
 	if (command_line) {
@@ -265,7 +334,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			command_line_len = COMMAND_LINE_SIZE;
 	}
 	if (ramdisk) {
-		ramdisk_buf = slurp_file(ramdisk, &ramdisk_length);
+		ramdisk_buf = slurp_file(ramdisk, &initrd_size);
 	}
 
 	/*
@@ -315,11 +384,24 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	/* assume the maximum kernel compression ratio is 4,
 	 * and just to be safe, place ramdisk after that
 	 */
-	ramdisk_offset = base + len * 4;
+	initrd_base = base + len * 4;
+
+	if (!dtb) {
+		const char *fn = "/proc/device-tree/";
+
+		if (!access(fn, F_OK))
+			have_proc_device_tree = true;
+		else if (errno == ENOENT)
+			have_proc_device_tree = false;
+		else
+			die("Failed to check for the presence of %s", fn);
+	}
 
-	if (atag_arm_load(info, base + atag_offset,
-			 command_line, command_line_len,
-			 ramdisk_buf, ramdisk_length, ramdisk_offset) == -1)
+	if (dtb || have_proc_device_tree)
+	    dtb_arm_load(info, base + base_offset, dtb, command_line);
+	else if (atag_arm_load(info, base + base_offset, command_line,
+			       command_line_len, ramdisk_buf,
+			       initrd_size, initrd_base) == -1)
 		return -1;
 
 	add_segment(info, buf, len, base + offset, len);
diff --git a/kexec/fs2dt.h b/kexec/fs2dt.h
index 6c5c3b2..99e616f 100644
--- a/kexec/fs2dt.h
+++ b/kexec/fs2dt.h
@@ -32,7 +32,6 @@ extern struct bootblock bb[1];
  * Only has implemented for PPC64 */
 int my_debug;
 
-void reserve(unsigned long long where, unsigned long long length);
 void create_flatten_tree(char **, off_t *, const char *);
 
 #endif /* KEXEC_H */
-- 
1.7.10.2.484.gcd07cc5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

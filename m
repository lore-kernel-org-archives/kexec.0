Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9ub5-0003wP-6E
 for kexec@lists.infradead.org; Fri, 07 Sep 2012 09:11:35 +0000
From: Matthew Leach <matthew.leach@arm.com>
Subject: [PATCH 7/7] ARM: Add device tree support to the ARM platform
Date: Fri,  7 Sep 2012 10:11:26 +0100
Message-Id: <1347009086-16506-8-git-send-email-matthew.leach@arm.com>
In-Reply-To: <1347009086-16506-1-git-send-email-matthew.leach@arm.com>
References: <1347009086-16506-1-git-send-email-matthew.leach@arm.com>
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
Cc: Matthew Leach <matthew.leach@arm.com>, horms@verge.net.au, will.deacon@arm.com

To allow newer ARM platforms to use kexec, pass device tree
information to the kernel during boot.

By default the dtb is found from /proc/device-tree. A user can specify
a dtb file or use legacy ATAGs

Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 kexec/arch/arm/Makefile               | 13 ++++++
 kexec/arch/arm/include/arch/options.h |  6 ++-
 kexec/arch/arm/kexec-arm.h            |  7 +++
 kexec/arch/arm/kexec-zImage-arm.c     | 87 +++++++++++++++++++++++++++++++----
 4 files changed, 103 insertions(+), 10 deletions(-)

diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 288ec33..192e6ec 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -1,11 +1,24 @@
 #
 # kexec arm (linux booting linux)
 #
+include $(srcdir)/kexec/libfdt/Makefile.libfdt
+
+arm_FS2DT              = kexec/fs2dt.c
+arm_FS2DT_INCLUDE      = -include kexec/arch/arm/crashdump-arm.h \
+                         -include kexec/arch/arm/kexec-arm.h
+
 arm_KEXEC_SRCS=  kexec/arch/arm/kexec-elf-rel-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-zImage-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-uImage-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/crashdump-arm.c
+arm_KEXEC_SRCS+= kexec/fs2dt.c
+
+libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/libfdt/%)
+
+CPPFLAGS+=-I$(srcdir)/kexec/libfdt
+
+arm_KEXEC_SRCS += $(libfdt_SRCS)
 
 arm_UIMAGE = kexec/kexec-uImage.c
 arm_PHYS_TO_VIRT = kexec/arch/arm/phys_to_virt.c
diff --git a/kexec/arch/arm/include/arch/options.h b/kexec/arch/arm/include/arch/options.h
index d89c91f..b355c26 100644
--- a/kexec/arch/arm/include/arch/options.h
+++ b/kexec/arch/arm/include/arch/options.h
@@ -5,6 +5,8 @@
 
 #define OPT_APPEND	'a'
 #define OPT_RAMDISK	'r'
+#define OPT_DTB     (OPT_ARCH_MAX+0)
+#define OPT_ATAGS   (OPT_ARCH_MAX+1)
 
 /* Options relevant to the architecture (excluding loader-specific ones),
  * in this case none:
@@ -33,7 +35,9 @@
 	{ "command-line",	1, 0, OPT_APPEND },	\
 	{ "append",		1, 0, OPT_APPEND },	\
 	{ "initrd",		1, 0, OPT_RAMDISK },	\
-	{ "ramdisk",		1, 0, OPT_RAMDISK },
+	{ "ramdisk",		1, 0, OPT_RAMDISK },	\
+	{ "dtb",		1, 0, OPT_DTB }, 	\
+	{ "atags",		0, 0, OPT_ATAGS },
 
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
index 88a6c29..46cedbf 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -13,13 +13,18 @@
 #include <unistd.h>
 #include <getopt.h>
 #include <unistd.h>
+#include <libfdt.h>
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
@@ -96,6 +101,8 @@ void zImage_arm_usage(void)
 		"     --append=STRING       Set the kernel command line to STRING.\n"
 		"     --initrd=FILE         Use FILE as the kernel's initial ramdisk.\n"
 		"     --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.\n"
+		"     --dtb=FILE            Use FILE as the fdt blob.\n"
+		"     --atags               Use ATAGs instead of device-tree.\n"
 		);
 }
 
@@ -219,9 +226,13 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	off_t command_line_len;
 	const char *ramdisk;
 	char *ramdisk_buf;
-	off_t ramdisk_length;
-	off_t ramdisk_offset;
 	int opt;
+	int use_atags;
+	char *dtb_buf;
+	off_t dtb_length;
+	char *dtb_file;
+	off_t dtb_offset;
+
 	/* See options.h -- add any more there, too. */
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
@@ -229,6 +240,8 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		{ "append",		1, 0, OPT_APPEND },
 		{ "initrd",		1, 0, OPT_RAMDISK },
 		{ "ramdisk",		1, 0, OPT_RAMDISK },
+		{ "dtb",		1, 0, OPT_DTB },
+		{ "atags",		0, 0, OPT_ATAGS },
 		{ 0, 			0, 0, 0 },
 	};
 	static const char short_options[] = KEXEC_ARCH_OPT_STR "a:r:";
@@ -240,7 +253,9 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	command_line_len = 0;
 	ramdisk = 0;
 	ramdisk_buf = 0;
-	ramdisk_length = 0;
+	initrd_size = 0;
+	use_atags = 0;
+	dtb_file = NULL;
 	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch(opt) {
 		default:
@@ -257,15 +272,28 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		case OPT_RAMDISK:
 			ramdisk = optarg;
 			break;
+		case OPT_DTB:
+			dtb_file = optarg;
+			break;
+		case OPT_ATAGS:
+			use_atags = 1;
+			break;
 		}
 	}
+
+	if (use_atags && dtb_file) {
+		fprintf(stderr, "You can only use ATAGs if you don't specify a "
+		        "dtb file.\n");
+		return -1;
+	}
+
 	if (command_line) {
 		command_line_len = strlen(command_line) + 1;
 		if (command_line_len > COMMAND_LINE_SIZE)
 			command_line_len = COMMAND_LINE_SIZE;
 	}
 	if (ramdisk) {
-		ramdisk_buf = slurp_file(ramdisk, &ramdisk_length);
+		ramdisk_buf = slurp_file(ramdisk, &initrd_size);
 	}
 
 	/*
@@ -315,12 +343,53 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	/* assume the maximum kernel compression ratio is 4,
 	 * and just to be safe, place ramdisk after that
 	 */
-	ramdisk_offset = base + len * 4;
+	initrd_base = base + len * 4;
 
-	if (atag_arm_load(info, base + atag_offset,
-			 command_line, command_line_len,
-			 ramdisk_buf, ramdisk_length, ramdisk_offset) == -1)
-		return -1;
+	if (use_atags) {
+		/*
+		 * use ATAGs from /proc/atags
+		 */
+		if (atag_arm_load(info, base + atag_offset,
+		                  command_line, command_line_len,
+		                  ramdisk_buf, initrd_size, initrd_base) == -1)
+			return -1;
+	} else {
+		/*
+		 * Read a user-specified DTB file.
+		 */
+		if (dtb_file) {
+			dtb_buf = slurp_file(dtb_file, &dtb_length);
+		} else {
+			/*
+			 * Extract the DTB from /proc/device-tree.
+			 */
+			create_flatten_tree(&dtb_buf, &dtb_length, command_line);
+		}
+
+		if (fdt_check_header(dtb_buf) != 0) {
+			fprintf(stderr, "Invalid FDT buffer.\n");
+			return -1;
+		}
+
+		if (base + atag_offset + dtb_length > base + offset) {
+			fprintf(stderr, "DTB too large!\n");
+			return -1;
+		}
+
+		if (ramdisk) {
+			add_segment(info, ramdisk_buf, initrd_size,
+			            initrd_base, initrd_size);
+		}
+
+		/* Stick the dtb at the end of the initrd and page
+		 * align it.
+		 */
+		dtb_offset = initrd_base + initrd_size + getpagesize();
+		dtb_offset &= ~(getpagesize() - 1);
+
+		add_segment(info, dtb_buf, dtb_length,
+		            dtb_offset, dtb_length);
+	}
 
 	add_segment(info, buf, len, base + offset, len);
 
-- 
1.7.12


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

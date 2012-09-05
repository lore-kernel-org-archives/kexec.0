Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9E1t-00022z-B3
 for kexec@lists.infradead.org; Wed, 05 Sep 2012 11:44:24 +0000
From: Matthew Leach <matthew.leach@arm.com>
Subject: [RFC PATCH 4/4] Add device tree support to the ARM platform
Date: Wed,  5 Sep 2012 12:44:03 +0100
Message-Id: <1346845443-32242-5-git-send-email-matthew.leach@arm.com>
In-Reply-To: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
References: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
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
Cc: Matthew Leach <matthew.leach@arm.com>, will.deacon@arm.com

To allow newer ARM platforms to use kexec, pass device tree
information to the kernel during boot.

By default the dtb is found from /proc/device-tree. A user can specify
a dtb file or use legacy ATAGs

Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 kexec/arch/arm/Makefile               |  10 +++
 kexec/arch/arm/include/arch/options.h |   6 +-
 kexec/arch/arm/kexec-zImage-arm.c     | 140 ++++++++++++++++++++++++++++++++--
 3 files changed, 150 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 288ec33..f25ce15 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -1,12 +1,22 @@
 #
 # kexec arm (linux booting linux)
 #
+include $(srcdir)/util_lib/dtc/Makefile.dtc
+
 arm_KEXEC_SRCS=  kexec/arch/arm/kexec-elf-rel-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-zImage-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-uImage-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/crashdump-arm.c
 
+libfdt_SRCS += $(LIBFDT_SRCS:%=util_lib/libfdt/%)
+dtc_SRCS += $(DTC_SRCS:%=util_lib/dtc/%)
+
+arm_KEXEC_SRCS+= $(libfdt_SRCS)
+arm_KEXEC_SRCS+= $(dtc_SRCS)
+
+CPPFLAGS+=-I$(srcdir)/util_lib/libfdt
+
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
 
diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 88a6c29..74028b8 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -13,6 +13,8 @@
 #include <unistd.h>
 #include <getopt.h>
 #include <unistd.h>
+#include <dtc.h>
+#include <libfdt.h>
 #include <arch/options.h>
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
@@ -96,6 +98,8 @@ void zImage_arm_usage(void)
 		"     --append=STRING       Set the kernel command line to STRING.\n"
 		"     --initrd=FILE         Use FILE as the kernel's initial ramdisk.\n"
 		"     --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.\n"
+		"     --dtb=FILE            Use FILE as the fdt blob.\n"
+		"     --atags               Use ATAGs instead of device-tree.\n"
 		);
 }
 
@@ -208,6 +212,63 @@ int atag_arm_load(struct kexec_info *info, unsigned long base,
 	return 0;
 }
 
+void dtb_fixup_chosen_node(char **dtb_buf, off_t *buf_sz, const char *command_line,
+                           unsigned long initrd_start, unsigned long initrd_end)
+{
+	if (command_line || initrd_start != initrd_end) {
+		int chosen_offset;
+		int root_offset;
+		int command_line_len = strlen(command_line);
+		off_t new_buf_sz = *buf_sz + command_line_len + 0x50; /* extra space for new node */
+		void *new_buf = malloc(new_buf_sz);
+
+		fdt_open_into(*dtb_buf, new_buf, new_buf_sz);
+
+		root_offset = fdt_path_offset(new_buf, "/");
+		chosen_offset = fdt_path_offset(new_buf, "/chosen");
+		if (chosen_offset == -FDT_ERR_NOTFOUND) {
+			chosen_offset = fdt_add_subnode(new_buf, root_offset, "chosen");
+		}
+		if (chosen_offset < 0) {
+			fprintf(stderr, "Warning: failed to find the chosen node, a specified command line and"
+			        " initrd will not be set.\n");
+			free(new_buf);
+			return;
+		}
+
+		/*
+		 * Add the 'bootargs' proerpty to the chosen node if the command
+		 * line is specified.
+		 */
+		if (command_line) {
+			if (fdt_setprop_string(new_buf, chosen_offset,
+			                       "bootargs", command_line) < 0) {
+				fprintf(stderr, "Warning: failed to set the command line.\n");
+				free(new_buf);
+				return;
+			}
+		}
+
+		/*
+		 * Add the 'initrd-start' and 'initrd-end' properties to the
+		 * chosen node if an initrd is specified.
+		 */
+		if (initrd_start != initrd_end) {
+			if ((fdt_setprop_cell(new_buf, chosen_offset,
+			                      "initrd-start", initrd_start) < 0) ||
+			    (fdt_setprop_cell(new_buf, chosen_offset,
+			                      "initrd-end", initrd_end) < 0)) {
+				fprintf(stderr, "Warning: failed to set the initrd addresses.\n");
+				return;
+			}	
+		}
+
+		free(*dtb_buf);
+		*dtb_buf = new_buf;
+		*buf_sz = new_buf_sz;
+	}
+}
+
 int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
@@ -222,6 +283,12 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	off_t ramdisk_length;
 	off_t ramdisk_offset;
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
@@ -229,6 +296,8 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		{ "append",		1, 0, OPT_APPEND },
 		{ "initrd",		1, 0, OPT_RAMDISK },
 		{ "ramdisk",		1, 0, OPT_RAMDISK },
+		{ "dtb",		1, 0, OPT_DTB },
+		{ "atags",		0, 0, OPT_ATAGS },
 		{ 0, 			0, 0, 0 },
 	};
 	static const char short_options[] = KEXEC_ARCH_OPT_STR "a:r:";
@@ -241,6 +310,8 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	ramdisk = 0;
 	ramdisk_buf = 0;
 	ramdisk_length = 0;
+	use_atags = 0;
+	dtb_file = NULL;
 	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch(opt) {
 		default:
@@ -257,8 +328,21 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
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
@@ -315,12 +399,58 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	/* assume the maximum kernel compression ratio is 4,
 	 * and just to be safe, place ramdisk after that
 	 */
-	ramdisk_offset = base + len * 4;
+		ramdisk_offset = base + len * 4;
 
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
+		                  ramdisk_buf, ramdisk_length, ramdisk_offset) == -1)
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
+			struct boot_info *bi;
+			bi = dt_from_fs("/proc/device-tree");
+			dtb_buf = dt_to_blob_buf(&dtb_length, bi, DEFAULT_FDT_VERSION);
+		}
+
+		dtb_fixup_chosen_node(&dtb_buf, &dtb_length, command_line,
+		                      ramdisk_offset, ramdisk_offset + ramdisk_length);
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
+			add_segment(info, ramdisk_buf, ramdisk_length,
+			            ramdisk_offset, ramdisk_length);
+		}
+
+		/* Stick the dtb at the end of the initrd and page
+		 * align it.
+		 */
+		dtb_offset = ramdisk_offset + ramdisk_length + getpagesize();
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

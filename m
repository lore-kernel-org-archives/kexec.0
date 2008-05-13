Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JvuMi-0002Ne-Ax
	for kexec@lists.infradead.org; Tue, 13 May 2008 13:16:25 +0000
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id ED70040908
	for <kexec@lists.infradead.org>; Tue, 13 May 2008 15:16:21 +0200 (CEST)
Date: Tue, 13 May 2008 15:17:03 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Implement EDD support for 32 bit boot
Message-ID: <20080513151703.07a31891@strauss.suse.de>
In-Reply-To: <20080509164904.GA18218@suse.de>
References: <20080509164904.GA18218@suse.de>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Update: Use the length field of the EDD header. Some BIOSe don't use
the full EDD_DEVICE_PARAM_SIZE bytes, depending on the EDD version.


From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Implement EDD support for 32 bit boot
To: kexec@lists.infradead.org

This patch implements EDD support. The information is read from
/sys/firmware/edd (the edd driver must be loaded for this) and is written into
the zero page of the 32 bit boot protocol.

I successfully tested the patch on a x86_64 machine with the x86_64 kernel.

This fixes a hardware detection problem, discovered in
https://bugzilla.novell.com/show_bug.cgi?id=383210.

The last patch that updates the E820MAX constant is required to use that patch.

Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 include/x86/x86-linux.h           |   39 +++++-
 kexec/arch/i386/x86-linux-setup.c |  244 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 277 insertions(+), 6 deletions(-)

--- a/include/x86/x86-linux.h
+++ b/include/x86/x86-linux.h
@@ -43,6 +43,29 @@ struct apm_bios_info {
 	uint8_t  reserved[44];	/* 0x54 */
 };
 
+/*
+ * EDD stuff
+ */
+
+#define EDD_MBR_SIG_MAX 16
+#define EDDMAXNR 	6	/* number of edd_info structs starting at EDDBUF  */
+
+#define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
+#define EDD_EXT_DEVICE_LOCKING_AND_EJECTING (1 << 1)
+#define EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT (1 << 2)
+#define EDD_EXT_64BIT_EXTENSIONS            (1 << 3)
+
+#define EDD_DEVICE_PARAM_SIZE 74
+
+struct edd_info {
+	uint8_t	 device;
+	uint8_t  version;
+	uint16_t interface_support;
+	uint16_t legacy_max_cylinder;
+	uint8_t  legacy_max_head;
+	uint8_t  legacy_sectors_per_track;
+	uint8_t  edd_device_params[EDD_DEVICE_PARAM_SIZE];
+} __attribute__ ((packed));
 
 struct x86_linux_param_header {
 	uint8_t  orig_x;			/* 0x00 */
@@ -87,7 +110,9 @@ struct x86_linux_param_header {
 	uint32_t alt_mem_k;			/* 0x1e0 */
 	uint8_t  reserved5[4];			/* 0x1e4 */
 	uint8_t  e820_map_nr;			/* 0x1e8 */
-	uint8_t  reserved6[8];			/* 0x1e9 */
+	uint8_t  eddbuf_entries;		/* 0x1e9 */
+	uint8_t  edd_mbr_sig_buf_entries;	/* 0x1ea */
+	uint8_t  reserved6[6];			/* 0x1eb */
 	uint8_t  setup_sects;			/* 0x1f1 */
 	uint16_t mount_root_rdonly;		/* 0x1f2 */
 	uint16_t syssize;			/* 0x1f4 */
@@ -148,18 +173,20 @@ struct x86_linux_param_header {
 	uint32_t cmdline_size;			/* 0x238 */
 	uint32_t hardware_subarch;		/* 0x23C */
 	uint64_t hardware_subarch_data;		/* 0x240 */
-	uint8_t  reserved16[0x2d0 - 0x248];	/* 0x248 */
+	uint8_t  reserved16[0x290 - 0x248];	/* 0x248 */
+	uint32_t edd_mbr_sig_buffer[EDD_MBR_SIG_MAX];	/* 0x290 */
 #endif
-	struct e820entry e820_map[E820MAX];	/* 0x2d0 */
-						/* 0x550 */
+	struct 	e820entry e820_map[E820MAX];	/* 0x2d0 */
+	uint8_t _pad8[48];			/* 0xcd0 */
+	struct 	edd_info eddbuf[EDDMAXNR];	/* 0xd00 */
+						/* 0xeec */
 #define COMMAND_LINE_SIZE 2048
 };
 
 struct x86_linux_faked_param_header {
 	struct x86_linux_param_header hdr;	/* 0x00 */
-	uint8_t reserved17[0xab0];		/* 0x550 */
 	uint8_t command_line[COMMAND_LINE_SIZE]; /* 0x1000 */
-	uint8_t reserved18[0x200];		/* 0x1800 - 0x2000 */
+	// uint8_t reserved18[0x200];		/* 0x1800 - 0x2000 */
 };
 
 struct x86_linux_header {
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -13,10 +13,12 @@
  * GNU General Public License for more details.
  *
  */
+/* #define DEBUG 1 */
 #define _GNU_SOURCE
 #include <stdint.h>
 #include <stdio.h>
 #include <string.h>
+#include <stdarg.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <limits.h>
@@ -26,6 +28,7 @@
 #include <sys/ioctl.h>
 #include <linux/fb.h>
 #include <unistd.h>
+#include <dirent.h>
 #include <x86/x86-linux.h>
 #include "../../kexec.h"
 #include "kexec-x86.h"
@@ -156,6 +159,244 @@ int setup_linux_vesafb(struct x86_linux_
 	return -1;
 }
 
+#define EDD_SYFS_DIR "/sys/firmware/edd"
+
+#define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
+#define EDD_EXT_DEVICE_LOCKING_AND_EJECTING (1 << 1)
+#define EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT (1 << 2)
+#define EDD_EXT_64BIT_EXTENSIONS            (1 << 3)
+
+/*
+ * Scans one line from a given filename. Returns on success the number of
+ * items written (same like scanf()).
+ */
+static int file_scanf(const char *dir, const char *file, const char *scanf_line, ...)
+{
+	va_list argptr;
+	FILE *fp;
+	int retno;
+	char filename[PATH_MAX];
+
+	snprintf(filename, PATH_MAX, "%s/%s", dir, file);
+	filename[PATH_MAX-1] = 0;
+
+	fp = fopen(filename, "r");
+	if (!fp) {
+		return -errno;
+	}
+
+	va_start(argptr, scanf_line);
+	retno = vfscanf(fp, scanf_line, argptr);
+	va_end(argptr);
+
+	fclose(fp);
+
+	return retno;
+}
+
+static int parse_edd_extensions(const char *dir, struct edd_info *edd_info)
+{
+	char filename[PATH_MAX];
+	char line[1024];
+	uint16_t flags = 0;
+	FILE *fp;
+
+	snprintf(filename, PATH_MAX, "%s/%s", dir, "extensions");
+	filename[PATH_MAX-1] = 0;
+
+	fp = fopen(filename, "r");
+	if (!fp) {
+		return -errno;
+	}
+
+	while (fgets(line, 1024, fp)) {
+		/*
+		 * strings are in kernel source, function edd_show_extensions()
+		 * drivers/firmware/edd.c
+		 */
+		if (strstr(line, "Fixed disk access") == line)
+			flags |= EDD_EXT_FIXED_DISK_ACCESS;
+		else if (strstr(line, "Device locking and ejecting") == line)
+			flags |= EDD_EXT_DEVICE_LOCKING_AND_EJECTING;
+		else if (strstr(line, "Enhanced Disk Drive support") == line)
+			flags |= EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT;
+		else if (strstr(line, "64-bit extensions") == line)
+			flags |= EDD_EXT_64BIT_EXTENSIONS;
+	}
+
+	fclose(fp);
+
+	edd_info->interface_support = flags;
+
+	return 0;
+}
+
+static int read_edd_raw_data(const char *dir, struct edd_info *edd_info)
+{
+	char filename[PATH_MAX];
+	FILE *fp;
+	size_t read_chars;
+	uint16_t len;
+
+	snprintf(filename, PATH_MAX, "%s/%s", dir, "raw_data");
+	filename[PATH_MAX-1] = 0;
+
+	fp = fopen(filename, "r");
+	if (!fp) {
+		return -errno;
+	}
+
+	memset(edd_info->edd_device_params, 0, EDD_DEVICE_PARAM_SIZE);
+	read_chars = fread(edd_info->edd_device_params, sizeof(uint8_t),
+				EDD_DEVICE_PARAM_SIZE, fp);
+	fclose(fp);
+
+	len = ((uint16_t *)edd_info->edd_device_params)[0];
+	dbgprintf("EDD raw data has length %d\n", len);
+
+	if (read_chars != len) {
+		fprintf(stderr, "BIOS reported EDD length of %hd but only "
+			"%d chars read.", len, (int)read_chars);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int add_edd_entry(struct x86_linux_param_header *real_mode,
+		const char *sysfs_name, int *current_edd, int *current_mbr)
+{
+	uint8_t devnum, version;
+	uint32_t mbr_sig;
+	struct edd_info *edd_info;
+
+	if (!current_mbr || !current_edd) {
+		fprintf(stderr, "%s: current_edd and current_edd "
+				"must not be NULL", __FUNCTION__);
+		return -1;
+	}
+
+	edd_info = &real_mode->eddbuf[*current_edd];
+	memset(edd_info, 0, sizeof(struct edd_info));
+
+	/* extract the device number */
+	if (sscanf(basename(sysfs_name), "int13_dev%hhx", &devnum) != 1) {
+		fprintf(stderr, "Invalid format of int13_dev dir "
+				"entry: %s\n", basename(sysfs_name));
+		return -1;
+	}
+
+	/* if there's a MBR signature, then add it */
+	if (file_scanf(sysfs_name, "mbr_signature", "0x%x", &mbr_sig) == 1) {
+		real_mode->edd_mbr_sig_buffer[*current_mbr] = mbr_sig;
+		(*current_mbr)++;
+		dbgprintf("EDD Device 0x%x: mbr_sig=0x%x\n", devnum, mbr_sig);
+	}
+
+	/* set the device number */
+	edd_info->device = devnum;
+
+	/* set the version */
+	if (file_scanf(sysfs_name, "version", "0x%hhx", &version) != 1)
+		return -1;
+
+	edd_info->version = version;
+
+	/* if version == 0, that's some kind of dummy entry */
+	if (version != 0) {
+		/* legacy_max_cylinder */
+		if (file_scanf(sysfs_name, "legacy_max_cylinder", "%hu",
+					&edd_info->legacy_max_cylinder) != 1) {
+			fprintf(stderr, "Reading legacy_max_cylinder failed.\n");
+			return -1;
+		}
+
+		/* legacy_max_head */
+		if (file_scanf(sysfs_name, "legacy_max_head", "%hhu",
+					&edd_info->legacy_max_head) != 1) {
+			fprintf(stderr, "Reading legacy_max_head failed.\n");
+			return -1;
+		}
+
+		/* legacy_sectors_per_track */
+		if (file_scanf(sysfs_name, "legacy_sectors_per_track", "%hhu",
+					&edd_info->legacy_sectors_per_track) != 1) {
+			fprintf(stderr, "Reading legacy_sectors_per_track failed.\n");
+			return -1;
+		}
+
+		/* Parse the EDD extensions */
+		if (parse_edd_extensions(sysfs_name, edd_info) != 0) {
+			fprintf(stderr, "Parsing EDD extensions failed.\n");
+			return -1;
+		}
+
+		/* Parse the raw info */
+		if (read_edd_raw_data(sysfs_name, edd_info) != 0) {
+			fprintf(stderr, "Reading EDD raw data failed.\n");
+			return -1;
+		}
+	}
+
+	(*current_edd)++;
+
+	return 0;
+}
+
+static void zero_edd(struct x86_linux_param_header *real_mode)
+{
+	real_mode->eddbuf_entries = 0;
+	real_mode->edd_mbr_sig_buf_entries = 0;
+	memset(real_mode->eddbuf, 0,
+		EDDMAXNR * sizeof(struct edd_info));
+	memset(real_mode->edd_mbr_sig_buffer, 0,
+		EDD_MBR_SIG_MAX * sizeof(uint32_t));
+}
+
+void setup_edd_info(struct x86_linux_param_header *real_mode,
+					unsigned long kexec_flags)
+{
+	DIR *edd_dir;
+	struct dirent *cursor;
+	int current_edd = 0;
+	int current_mbr = 0;
+
+	edd_dir = opendir(EDD_SYFS_DIR);
+	if (!edd_dir) {
+		dbgprintf(EDD_SYFS_DIR " does not exist.\n");
+		return;
+	}
+
+	zero_edd(real_mode);
+	while ((cursor = readdir(edd_dir))) {
+		char full_dir_name[PATH_MAX];
+
+		/* only read the entries that start with "int13_dev" */
+		if (strstr(cursor->d_name, "int13_dev") != cursor->d_name)
+			continue;
+
+		snprintf(full_dir_name, PATH_MAX, "%s/%s",
+				EDD_SYFS_DIR, cursor->d_name);
+		full_dir_name[PATH_MAX-1] = 0;
+
+		if (add_edd_entry(real_mode, full_dir_name, &current_edd,
+					&current_mbr) != 0) {
+			zero_edd(real_mode);
+			goto out;
+		}
+	}
+
+	real_mode->eddbuf_entries = current_edd;
+	real_mode->edd_mbr_sig_buf_entries = current_mbr;
+
+out:
+	closedir(edd_dir);
+
+	dbgprintf("Added %d EDD MBR entries and %d EDD entries.\n",
+		real_mode->edd_mbr_sig_buf_entries,
+		real_mode->eddbuf_entries);
+}
+
 void setup_linux_system_parameters(struct x86_linux_param_header *real_mode,
 					unsigned long kexec_flags)
 {
@@ -239,4 +480,7 @@ void setup_linux_system_parameters(struc
 			}
 		}
 	}
+
+	/* fill the EDD information */
+	setup_edd_info(real_mode, kexec_flags);
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

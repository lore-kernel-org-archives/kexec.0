Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxRN2-0009Zr-6w
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 10:18:51 +0000
From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2 1/5] s390: add variable command line size
Date: Wed, 15 Dec 2021 11:18:32 +0100
Message-Id: <20211215101836.1181165-2-svens@linux.ibm.com>
In-Reply-To: <20211215101836.1181165-1-svens@linux.ibm.com>
References: <20211215101836.1181165-1-svens@linux.ibm.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, prudo@redhat.com, Sven Schnelle <svens@linux.ibm.com>, Alexander Egorenkov <egorenar@linux.ibm.com>

Newer s390 kernels support a command line size longer than 896
bytes. Such kernels contain a new member in the parameter area,
which might be utilized by tools like kexec. Older kernels have
the location initialized to zero, so we check whether there's a
non-zero number present and use that. If there isn't, we fallback
to the legacy command line size of 896 bytes.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 kexec/arch/s390/crashdump-s390.c |  3 +-
 kexec/arch/s390/kexec-image.c    | 65 +++++++++++++++++++++-----------
 kexec/arch/s390/kexec-s390.h     | 21 ++++++-----
 3 files changed, 55 insertions(+), 34 deletions(-)

diff --git a/kexec/arch/s390/crashdump-s390.c b/kexec/arch/s390/crashdump-s390.c
index 10f4d607bbcc..3bd9efe6dafe 100644
--- a/kexec/arch/s390/crashdump-s390.c
+++ b/kexec/arch/s390/crashdump-s390.c
@@ -52,7 +52,8 @@ static int create_elf_header(struct kexec_info *info, unsigned long crash_base,
 	elfcorehdr_size = bufsz;
 	snprintf(str, sizeof(str), " elfcorehdr=%ld@%ldK\n",
 		 elfcorehdr_size, elfcorehdr / 1024);
-	command_line_add(str);
+	if (command_line_add(info, str))
+		return -1;
 #endif
 	return 0;
 }
diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
index 3c24fdfe3c7c..a52399eafd2a 100644
--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -25,7 +25,6 @@
 #include <fcntl.h>
 
 static uint64_t crash_base, crash_end;
-static char command_line[COMMAND_LINESIZE];
 
 static void add_segment_check(struct kexec_info *info, const void *buf,
 			      size_t bufsz, unsigned long base, size_t memsz)
@@ -36,13 +35,18 @@ static void add_segment_check(struct kexec_info *info, const void *buf,
 	add_segment(info, buf, bufsz, crash_base + base, memsz);
 }
 
-int command_line_add(const char *str)
+int command_line_add(struct kexec_info *info, const char *str)
 {
-	if (strlen(command_line) + strlen(str) + 1 > COMMAND_LINESIZE) {
-		fprintf(stderr, "Command line too long.\n");
+	char *tmp = NULL;
+
+	tmp = concat_cmdline(info->command_line, str);
+	if (!tmp) {
+		fprintf(stderr, "out of memory\n");
 		return -1;
 	}
-	strcat(command_line, str);
+
+	free(info->command_line);
+	info->command_line = tmp;
 	return 0;
 }
 
@@ -64,7 +68,7 @@ int image_s390_load_file(int argc, char **argv, struct kexec_info *info)
 	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch(opt) {
 		case OPT_APPEND:
-			if (command_line_add(optarg))
+			if (command_line_add(info, optarg))
 				return -1;
 			break;
 		case OPT_RAMDISK:
@@ -78,13 +82,16 @@ int image_s390_load_file(int argc, char **argv, struct kexec_info *info)
 		if (info->initrd_fd == -1) {
 			fprintf(stderr, "Could not open initrd file %s:%s\n",
 					ramdisk, strerror(errno));
+			free(info->command_line);
+			info->command_line = NULL;
 			return -1;
 		}
 	}
 
-	info->command_line = command_line;
-	info->command_line_len = strlen (command_line) + 1;
-
+	if (info->command_line)
+		info->command_line_len = strlen(info->command_line) + 1;
+	else
+		info->command_line_len = 0;
 	return 0;
 }
 
@@ -97,7 +104,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 	const char *ramdisk;
 	off_t ramdisk_len;
 	unsigned int ramdisk_origin;
-	int opt;
+	int opt, ret = -1;
 
 	if (info->file_mode)
 		return image_s390_load_file(argc, argv, info);
@@ -112,7 +119,6 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 		};
 	static const char short_options[] = KEXEC_OPT_STR "";
 
-	command_line[0] = 0;
 	ramdisk = NULL;
 	ramdisk_len = 0;
 	ramdisk_origin = 0;
@@ -120,7 +126,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 	while ((opt = getopt_long(argc,argv,short_options,options,0)) != -1) {
 		switch(opt) {
 		case OPT_APPEND:
-			if (command_line_add(optarg))
+			if (command_line_add(info, optarg))
 				return -1;
 			break;
 		case OPT_RAMDISK:
@@ -132,7 +138,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		if (parse_iomem_single("Crash kernel\n", &crash_base,
 				       &crash_end))
-			return -1;
+			goto out;
 	}
 
 	/* Add kernel segment */
@@ -151,7 +157,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 		rd_buffer = slurp_file_mmap(ramdisk, &ramdisk_len);
 		if (rd_buffer == NULL) {
 			fprintf(stderr, "Could not read ramdisk.\n");
-			return -1;
+			goto out;
 		}
 		ramdisk_origin = MAX(RAMDISK_ORIGIN_ADDR, kernel_size);
 		ramdisk_origin = _ALIGN_UP(ramdisk_origin, 0x100000);
@@ -160,7 +166,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 	}
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		if (load_crashdump_segments(info, crash_base, crash_end))
-			return -1;
+			goto out;
 	} else {
 		info->entry = (void *) IMAGE_READ_OFFSET;
 	}
@@ -183,15 +189,28 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 			*tmp = crash_end - crash_base + 1;
 		}
 	}
-	/*
-	 * We will write a probably given command line.
-	 * First, erase the old area, then setup the new parameters:
-	 */
-	if (strlen(command_line) != 0) {
-		memset(krnl_buffer + COMMAND_LINE_OFFS, 0, COMMAND_LINESIZE);
-		memcpy(krnl_buffer + COMMAND_LINE_OFFS, command_line, strlen(command_line));
+
+	if (info->command_line) {
+		unsigned long maxsize;
+		char *dest = krnl_buffer + COMMAND_LINE_OFFS;
+
+		maxsize = *(unsigned long *)(krnl_buffer + MAX_COMMAND_LINESIZE_OFFS);
+		if (!maxsize)
+			maxsize = LEGACY_COMMAND_LINESIZE;
+
+		if (strlen(info->command_line) > maxsize-1) {
+			fprintf(stderr, "command line too long, maximum allowed size %ld\n",
+				maxsize-1);
+			goto out;
+		}
+		strncpy(dest, info->command_line, maxsize-1);
+		dest[maxsize-1] = '\0';
 	}
-	return 0;
+	ret = 0;
+out:
+	free(info->command_line);
+	info->command_line = NULL;
+	return ret;
 }
 
 int 
diff --git a/kexec/arch/s390/kexec-s390.h b/kexec/arch/s390/kexec-s390.h
index ef53b111e167..6a99518c1c9e 100644
--- a/kexec/arch/s390/kexec-s390.h
+++ b/kexec/arch/s390/kexec-s390.h
@@ -10,16 +10,17 @@
 #ifndef KEXEC_S390_H
 #define KEXEC_S390_H
 
-#define IMAGE_READ_OFFSET     0x10000
+#define IMAGE_READ_OFFSET           0x10000
 
-#define RAMDISK_ORIGIN_ADDR   0x800000
-#define INITRD_START_OFFS     0x408
-#define INITRD_SIZE_OFFS      0x410
-#define OLDMEM_BASE_OFFS      0x418
-#define OLDMEM_SIZE_OFFS      0x420
-#define COMMAND_LINE_OFFS     0x480
-#define COMMAND_LINESIZE      896
-#define MAX_MEMORY_RANGES     1024
+#define RAMDISK_ORIGIN_ADDR         0x800000
+#define INITRD_START_OFFS           0x408
+#define INITRD_SIZE_OFFS            0x410
+#define OLDMEM_BASE_OFFS            0x418
+#define OLDMEM_SIZE_OFFS            0x420
+#define MAX_COMMAND_LINESIZE_OFFS   0x430
+#define COMMAND_LINE_OFFS           0x480
+#define LEGACY_COMMAND_LINESIZE     896
+#define MAX_MEMORY_RANGES           1024
 
 #define MAX(x, y) ((x) > (y) ? (x) : (y))
 #define MIN(x, y) ((x) < (y) ? (x) : (y))
@@ -32,6 +33,6 @@ extern int load_crashdump_segments(struct kexec_info *info,
 				   unsigned long crash_end);
 extern int get_memory_ranges_s390(struct memory_range range[], int *ranges,
 				  int with_crashk);
-extern int command_line_add(const char *str);
+extern int command_line_add(struct kexec_info *info, const char *str);
 
 #endif /* KEXEC_S390_H */
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

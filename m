Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HhISU-0003kQ-9n
	for kexec@lists.infradead.org; Fri, 27 Apr 2007 00:53:31 -0400
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 27 Apr 2007 14:53:19 +1000
Subject: [PATCH 2/2] kexec ppc64: Add arch specific --reuseinitrd hooks
In-Reply-To: <1177649598.976491.841801585564.qpush@coopers>
Message-Id: <20070427045319.1EF1070516@localhost.localdomain>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc: Milton Miller <miltonm@bga.com>

Adds ppc64 specific hooks for the --reuseinitrd option.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 kexec/arch/ppc64/fs2dt.c           |   30 +++++++++++-----
 kexec/arch/ppc64/kexec-elf-ppc64.c |   12 +++++-
 kexec/arch/ppc64/kexec-ppc64.c     |   69 +++++++++++++++++++++++++++++++++++++
 kexec/arch/ppc64/kexec-ppc64.h     |    1 
 4 files changed, 103 insertions(+), 9 deletions(-)

Index: kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/fs2dt.c
+++ kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
@@ -66,11 +66,11 @@ void reserve(unsigned long long where, u
 }
 
 /* look for properties we need to reserve memory space for */
-static void checkprop(char *name, unsigned *data)
+static void checkprop(char *name, unsigned *data, int len)
 {
-	static unsigned long long base, size;
+	static unsigned long long base, size, end;
 
-	if ((data == NULL) && (base || size))
+	if ((data == NULL) && (base || size || end))
 		die("unrecoverable error: no property data");
 	else if (!strcmp(name, "linux,rtas-base"))
 		base = *data;
@@ -79,11 +79,24 @@ static void checkprop(char *name, unsign
 	else if (!strcmp(name, "rtas-size") ||
 			!strcmp(name, "linux,tce-size"))
 		size = *data;
+	else if (reuse_initrd && !strcmp(name, "linux,initrd-start"))
+		if (len == 8)
+			base = *(unsigned long long *) data;
+		else
+			base = *data;
+	else if (reuse_initrd && !strcmp(name, "linux,initrd-end"))
+		end = *(unsigned long long *) data;
 
+	if (size && end)
+		die("unrecoverable error: size and end set at same time\n");
 	if (base && size) {
 		reserve(base, size);
 		base = size = 0;
 	}
+	if (base && end) {
+		reserve(base, end-base);
+		base = end = 0;
+	}
 }
 
 /*
@@ -213,10 +226,11 @@ static void putprops(char *fn, struct di
 				continue;
 
 		/* This property will be created/modified later in putnode()
-		 * So ignore it.
+		 * So ignore it, unless we are reusing the initrd.
 		 */
-		if (!strcmp(dp->d_name, "linux,initrd-start") ||
-			!strcmp(dp->d_name, "linux,initrd-end"))
+		if ((!strcmp(dp->d_name, "linux,initrd-start") ||
+		     !strcmp(dp->d_name, "linux,initrd-end")) &&
+		    !reuse_initrd)
 				continue;
 
 		if (! S_ISREG(statbuf.st_mode))
@@ -241,7 +255,7 @@ static void putprops(char *fn, struct di
 			die("unrecoverable error: could not read \"%s\": %s\n",
 			    pathname, strerror(errno));
 
-		checkprop(fn, dt);
+		checkprop(fn, dt, len);
 
 		/* Get the cmdline from the device-tree and modify it */
 		if (!strcmp(dp->d_name, "bootargs")) {
@@ -282,7 +296,7 @@ static void putprops(char *fn, struct di
 	}
 
 	fn[0] = '\0';
-	checkprop(pathname, NULL);
+	checkprop(pathname, NULL, 0);
 }
 
 /*
Index: kexec-tools-testing/kexec/arch/ppc64/kexec-elf-ppc64.c
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ kexec-tools-testing/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -43,6 +43,8 @@
 #define BOOTLOADER_VERSION VERSION
 
 unsigned long initrd_base, initrd_size;
+unsigned char reuse_initrd = 0;
+const char *ramdisk;
 
 int create_flatten_tree(struct kexec_info *, unsigned char **, unsigned long *,
 			char *);
@@ -69,12 +71,17 @@ int elf_ppc64_probe(const char *buf, off
 	return result;
 }
 
+void arch_reuse_initrd(void)
+{
+	reuse_initrd = 1;
+}
+
 int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 			struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
 	char *cmdline, *modified_cmdline;
-	const char *ramdisk, *devicetreeblob;
+	const char *devicetreeblob;
 	int cmdline_len, modified_cmdline_len;
 	unsigned long long max_addr, hole_addr;
 	unsigned char *seg_buf = NULL;
@@ -148,6 +155,9 @@ int elf_ppc64_load(int argc, char **argv
 	else
 		fprintf(stdout, "Warning: append= option is not passed. Using the first kernel root partition\n");
 
+	if (ramdisk && reuse_initrd)
+		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
+
 	setup_memory_ranges(info->kexec_flags);
 
 	/* Need to append some command line parameters internally in case of
Index: kexec-tools-testing/kexec/arch/ppc64/kexec-ppc64.c
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/kexec-ppc64.c
+++ kexec-tools-testing/kexec/arch/ppc64/kexec-ppc64.c
@@ -122,6 +122,11 @@ static int count_memory_ranges()
 			continue;
 		max_memory_ranges++;
 	}
+	/* need to add extra region for retained initrd */
+	if (reuse_initrd) {
+		max_memory_ranges++;
+	}
+
 	closedir(dir);
 
 	return 0;
@@ -253,12 +258,14 @@ static int get_devtree_details(unsigned 
 	unsigned int tce_size;
 	unsigned long long htab_base, htab_size;
 	unsigned long long kernel_end;
+	unsigned long long initrd_start, initrd_end;
 	char buf[MAXBYTES-1];
 	char device_tree[256] = "/proc/device-tree/";
 	char fname[256];
 	DIR *dir, *cdir;
 	FILE *file;
 	struct dirent *dentry;
+	struct stat *fstat = malloc(sizeof(struct stat));
 	int n, i = 0;
 
 	if ((dir = opendir(device_tree)) == NULL) {
@@ -394,6 +401,68 @@ static int get_devtree_details(unsigned 
 			exclude_range[i].start = htab_base;
 			exclude_range[i].end = htab_base + htab_size;
 			i++;
+
+			/* reserve the initrd_start and end locations. */
+			if (reuse_initrd) {
+				memset(fname, 0, sizeof(fname));
+				strcpy(fname, device_tree);
+				strcat(fname, dentry->d_name);
+				strcat(fname, "/linux,initrd-start");
+				if ((file = fopen(fname, "r")) == NULL) {
+					perror(fname);
+					closedir(cdir);
+					closedir(dir);
+					return -1;
+				}
+				/* check for 4 and 8 byte initrd offset sizes */
+				if (stat(fname, fstat) != 0) {
+					perror(fname);
+					fclose(file);
+					closedir(cdir);
+					closedir(dir);
+					return -1;
+				}
+ 				if (fread(&initrd_start, fstat->st_size, 1, file) != 1) {
+					perror(fname);
+					fclose(file);
+					closedir(cdir);
+					closedir(dir);
+					return -1;
+				}
+				fclose(file);
+
+				memset(fname, 0, sizeof(fname));
+				strcpy(fname, device_tree);
+				strcat(fname, dentry->d_name);
+				strcat(fname, "/linux,initrd-end");
+				if ((file = fopen(fname, "r")) == NULL) {
+					perror(fname);
+					closedir(cdir);
+					closedir(dir);
+					return -1;
+				}
+				/* check for 4 and 8 byte initrd offset sizes */
+				if (stat(fname, fstat) != 0) {
+					perror(fname);
+					fclose(file);
+					closedir(cdir);
+					closedir(dir);
+					return -1;
+				}
+ 				if (fread(&initrd_end, fstat->st_size, 1, file) != 1) {
+					perror(fname);
+					fclose(file);
+					closedir(cdir);
+					closedir(dir);
+					return -1;
+				}
+				fclose(file);
+
+				/* Add initrd address to exclude_range */
+				exclude_range[i].start = initrd_start;
+				exclude_range[i].end = initrd_end;
+				i++;
+			}
 		} /* chosen */
 
 		if (strncmp(dentry->d_name, "rtas", 4) == 0) {
Index: kexec-tools-testing/kexec/arch/ppc64/kexec-ppc64.h
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/kexec-ppc64.h
+++ kexec-tools-testing/kexec/arch/ppc64/kexec-ppc64.h
@@ -16,6 +16,7 @@ void reserve(unsigned long long where, u
 
 extern unsigned long initrd_base, initrd_size;
 extern int max_memory_ranges;
+extern unsigned char reuse_initrd;
 
 /* boot block version 2 as defined by the linux kernel */
 struct bootblock {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

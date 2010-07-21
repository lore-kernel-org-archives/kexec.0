Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]
	helo=TX2EHSOBE005.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1ObR9N-0003Hp-OX
	for kexec@lists.infradead.org; Wed, 21 Jul 2010 04:43:23 +0000
From: Matthew McClintock <msm@freescale.com>
Subject: [PATCH v3 2/7] Fix case where phys_addr_t != unsigned long when
	reading proc entries
Date: Tue, 20 Jul 2010 23:42:59 -0500
Message-ID: <1279687384-9770-3-git-send-email-msm@freescale.com>
In-Reply-To: <1279687384-9770-1-git-send-email-msm@freescale.com>
References: <1279687384-9770-1-git-send-email-msm@freescale.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: muvarov@gmail.com, Matthew McClintock <msm@freescale.com>, sebastian@breakpoint.cc

On some actitectures the physical memory can be 64 bits, therefore
the code that reads proc entries needs to take into account it could
read either a 32 bit or 64bit value for the physical addresses.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 kexec/arch/ppc/kexec-elf-ppc.c |    1 -
 kexec/arch/ppc/kexec-ppc.c     |  198 +++++++++++++++++++++++-----------------
 2 files changed, 114 insertions(+), 85 deletions(-)

diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index d155bde..ab2d343 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -32,7 +32,6 @@
 
 static const int probe_debug = 0;
 
-unsigned long long initrd_base, initrd_size;
 unsigned char reuse_initrd;
 const char *ramdisk;
 int create_flatten_tree(struct kexec_info *, unsigned char **, unsigned long *,
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index ca33303..e1547a8 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -28,6 +28,7 @@
 
 uint64_t rmo_top;
 unsigned long long crash_base, crash_size;
+unsigned long long initrd_base, initrd_size;
 unsigned int rtas_base, rtas_size;
 int max_memory_ranges;
 
@@ -262,14 +263,14 @@ static int get_base_ranges(void)
 				}
 			}
 
-			if (n == 8) {
+			if (n == sizeof(uint32_t) * 2) {
 				base_memory_range[local_memory_ranges].start =
 					((uint32_t *)buf)[0];
 				base_memory_range[local_memory_ranges].end  =
 					base_memory_range[local_memory_ranges].start +
 					((uint32_t *)buf)[1];
 			}
-			else if (n == 16) {
+			else if (n == sizeof(uint64_t) * 2) {
 				base_memory_range[local_memory_ranges].start =
                                         ((uint64_t *)buf)[0];
                                 base_memory_range[local_memory_ranges].end  =
@@ -317,9 +318,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 	DIR *dir, *cdir;
 	FILE *file;
 	struct dirent *dentry;
-	struct stat fstat;
 	int n, i = 0;
-	unsigned long tmp_long;
 
 	if ((dir = opendir(device_tree)) == NULL) {
 		perror(device_tree);
@@ -349,12 +348,18 @@ static int get_devtree_details(unsigned long kexec_flags)
 					perror(fname);
 					goto error_opencdir;
 				}
-				if (fread(&tmp_long, sizeof(unsigned long), 1, file)
-						!= 1) {
+				if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
 					perror(fname);
 					goto error_openfile;
 				}
-				kernel_end = tmp_long;
+				if (n == sizeof(uint32_t)) {
+					kernel_end = ((uint32_t *)buf)[0];
+				} else if (n == sizeof(uint64_t)) {
+					kernel_end = ((uint64_t *)buf)[0];
+				} else {
+					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					goto error_openfile;
+				}
 				fclose(file);
 
 				/* Add kernel memory to exclude_range */
@@ -364,37 +369,50 @@ static int get_devtree_details(unsigned long kexec_flags)
 				if (i >= max_memory_ranges)
 					realloc_memory_ranges();
 				memset(fname, 0, sizeof(fname));
-				strcpy(fname, device_tree);
-				strcat(fname, dentry->d_name);
-				strcat(fname, "/linux,crashkernel-base");
+				sprintf(fname, "%s%s%s",
+					device_tree, dentry->d_name,
+					"/linux,crashkernel-base");
 				file = fopen(fname, "r");
 				if (!file) {
 					perror(fname);
 					goto error_opencdir;
 				}
-				if (fread(&tmp_long, sizeof(unsigned long), 1,
-						file) != 1) {
+				if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
 					perror(fname);
 					goto error_openfile;
 				}
-				crash_base = tmp_long;
+				if (n == sizeof(uint32_t)) {
+					crash_base = ((uint32_t *)buf)[0];
+				} else if (n == sizeof(uint64_t)) {
+					crash_base = ((uint64_t *)buf)[0];
+				} else {
+					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					goto error_openfile;
+				}
 				fclose(file);
 
 				memset(fname, 0, sizeof(fname));
-				strcpy(fname, device_tree);
-				strcat(fname, dentry->d_name);
-				strcat(fname, "/linux,crashkernel-size");
+				sprintf(fname, "%s%s%s",
+					device_tree, dentry->d_name,
+					"/linux,crashkernel-size");
 				file = fopen(fname, "r");
 				if (!file) {
 					perror(fname);
 					goto error_opencdir;
 				}
-				if (fread(&tmp_long, sizeof(unsigned long), 1,
-						file) != 1) {
+				if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
 					perror(fname);
 					goto error_openfile;
 				}
-				crash_size = tmp_long;
+				if (n == sizeof(uint32_t)) {
+					crash_size = ((uint32_t *)buf)[0];
+				} else if (n == sizeof(uint64_t)) {
+					crash_size = ((uint64_t *)buf)[0];
+				} else {
+					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					goto error_openfile;
+				}
+				fclose(file);
 
 				if (crash_base > mem_min)
 					mem_min = crash_base;
@@ -405,10 +423,74 @@ static int get_devtree_details(unsigned long kexec_flags)
 				reserve(KDUMP_BACKUP_LIMIT,
 						crash_base-KDUMP_BACKUP_LIMIT);
 			}
+			/* reserve the initrd_start and end locations. */
 			memset(fname, 0, sizeof(fname));
-			strcpy(fname, device_tree);
-			strcat(fname, dentry->d_name);
-			strcat(fname, "/linux,htab-base");
+			sprintf(fname, "%s%s%s",
+				device_tree, dentry->d_name,
+				"/linux,initrd-start");
+			file = fopen(fname, "r");
+			if (!file) {
+				errno = 0;
+				initrd_start = 0;
+			} else {
+				if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
+					perror(fname);
+					goto error_openfile;
+				}
+				if (n == sizeof(uint32_t)) {
+					initrd_start = ((uint32_t *)buf)[0];
+				} else if (n == sizeof(uint64_t)) {
+					initrd_start = ((uint64_t *)buf)[0];
+				} else {
+					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					goto error_openfile;
+				}
+				fclose(file);
+			}
+
+			memset(fname, 0, sizeof(fname));
+			sprintf(fname, "%s%s%s",
+				device_tree, dentry->d_name,
+				"/linux,initrd-end");
+			file = fopen(fname, "r");
+			if (!file) {
+				errno = 0;
+				initrd_end = 0;
+			} else {
+				if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
+					perror(fname);
+					goto error_openfile;
+				}
+				if (n == sizeof(uint32_t)) {
+					initrd_end = ((uint32_t *)buf)[0];
+				} else if (n == sizeof(uint64_t)) {
+					initrd_end = ((uint64_t *)buf)[0];
+				} else {
+					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					goto error_openfile;
+				}
+				fclose(file);
+			}
+
+			if ((initrd_end - initrd_start) != 0 ) {
+				initrd_base = initrd_start;
+				initrd_size = initrd_end - initrd_start + 1;
+			}
+
+			if (reuse_initrd) {
+				/* Add initrd address to exclude_range */
+				exclude_range[i].start = initrd_start;
+				exclude_range[i].end = initrd_end;
+				i++;
+				if (i >= max_memory_ranges)
+					realloc_memory_ranges();
+			}
+
+			/* HTAB */
+			memset(fname, 0, sizeof(fname));
+			sprintf(fname, "%s%s%s",
+				device_tree, dentry->d_name,
+				"/linux,htab-base");
 			file = fopen(fname, "r");
 			if (!file) {
 				closedir(cdir);
@@ -426,9 +508,9 @@ static int get_devtree_details(unsigned long kexec_flags)
 				goto error_openfile;
 			}
 			memset(fname, 0, sizeof(fname));
-			strcpy(fname, device_tree);
-			strcat(fname, dentry->d_name);
-			strcat(fname, "/linux,htab-size");
+			sprintf(fname, "%s%s%s",
+				device_tree, dentry->d_name,
+				"/linux,htab-size");
 			file = fopen(fname, "r");
 			if (!file) {
 				perror(fname);
@@ -446,59 +528,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 			if (i >= max_memory_ranges)
 				realloc_memory_ranges();
 
-			/* reserve the initrd_start and end locations. */
-			if (reuse_initrd) {
-				memset(fname, 0, sizeof(fname));
-				strcpy(fname, device_tree);
-				strcat(fname, dentry->d_name);
-				strcat(fname, "/linux,initrd-start");
-				file = fopen(fname, "r");
-				if (!file) {
-					perror(fname);
-					goto error_opencdir;
-				}
-				/* check for 4 and 8 byte initrd offset sizes */
-				if (stat(fname, &fstat) != 0) {
-					perror(fname);
-					goto error_openfile;
-				}
-				if (fread(&initrd_start, fstat.st_size, 1, file)
-						!= 1) {
-					perror(fname);
-					goto error_openfile;
-				}
-				fclose(file);
-
-				memset(fname, 0, sizeof(fname));
-				strcpy(fname, device_tree);
-				strcat(fname, dentry->d_name);
-				strcat(fname, "/linux,initrd-end");
-				file = fopen(fname, "r");
-				if (!file) {
-					perror(fname);
-					goto error_opencdir;
-				}
-				/* check for 4 and 8 byte initrd offset sizes */
-				if (stat(fname, &fstat) != 0) {
-					perror(fname);
-					goto error_openfile;
-				}
-				if (fread(&initrd_end, fstat.st_size, 1, file)
-						!= 1) {
-					perror(fname);
-					goto error_openfile;
-				}
-				fclose(file);
-
-				/* Add initrd address to exclude_range */
-				exclude_range[i].start = initrd_start;
-				exclude_range[i].end = initrd_end;
-				i++;
-				if (i >= max_memory_ranges)
-					realloc_memory_ranges();
-			}
 		} /* chosen */
-
 		if (strncmp(dentry->d_name, "rtas", 4) == 0) {
 			strcat(fname, "/linux,rtas-base");
 			if ((file = fopen(fname, "r")) == NULL) {
@@ -511,9 +541,9 @@ static int get_devtree_details(unsigned long kexec_flags)
 				goto error_openfile;
 			}
 			memset(fname, 0, sizeof(fname));
-			strcpy(fname, device_tree);
-			strcat(fname, dentry->d_name);
-			strcat(fname, "/rtas-size");
+			sprintf(fname, "%s%s%s",
+				device_tree, dentry->d_name,
+				"/linux,rtas-size");
 			if ((file = fopen(fname, "r")) == NULL) {
 				perror(fname);
 				goto error_opencdir;
@@ -543,7 +573,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_openfile;
 			}
-			if (n == 8) {
+			if (n == sizeof(uint64_t)) {
 				rmo_base = ((uint32_t *)buf)[0];
 				rmo_top = rmo_base + ((uint32_t *)buf)[1];
 			} else if (n == 16) {
@@ -580,9 +610,9 @@ static int get_devtree_details(unsigned long kexec_flags)
 				return -1;
 			}
 			memset(fname, 0, sizeof(fname));
-			strcpy(fname, device_tree);
-			strcat(fname, dentry->d_name);
-			strcat(fname, "/linux,tce-size");
+			sprintf(fname, "%s%s%s",
+				device_tree, dentry->d_name,
+				"/linux,tce-size");
 			file = fopen(fname, "r");
 			if (!file) {
 				perror(fname);
-- 
1.6.0.6



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

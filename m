Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Za3lZ-0002Ue-CN
 for kexec@lists.infradead.org; Thu, 10 Sep 2015 15:28:02 +0000
Date: Thu, 10 Sep 2015 10:27:36 -0500
Subject: [PATCH V2] makedumpfile: make --work-dir easier to use
MIME-Version: 1.0
Message-Id: <20150910152736.325BEC41637@asylum.americas.sgi.com>
From: cpw@sgi.com (Cliff Wickman)
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
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp

From: Cliff Wickman <cpw@sgi.com>

This patch enhances the --work-dir feature to make it easier to use.

Currently the --work-dir=<PATH> must be specified in a form that is valid in the crashkernel's environment.
In other words, the boot kernel's /var, for example, must be specified as:
  RHEL6: /mnt/var/
  RHEL7: /sysroot/var/
  SLES11: /kdump/0/var/
  SLES12: (with root=kdump) /kdump/mnt0/var/
And the administrator must remember to create that directory.
If these conditions are not met makedumpfile fails, with little explanation as to why.

This patch:

- Allow the path to be one that is valid in the crashkernel's environment (as currently)
  or allow it to match the 'path' variable in /etc/kdump.conf or the 'KDUMP_SAVEDIR' variable
  in /etc/sysconfig/kdump. In this case it will be automatically adjusted to match how the root
  device is mounted in the crashkernel.
- Make the directory if it does not already exist.  All components of the path are
  made if necessary, similar to mkdir -p.
- Corrects some allocation (off-by-one) errors in the previous version of this patch.

---
 makedumpfile.c |  173 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |    3 
 print_info.c   |   16 +++--
 3 files changed, 187 insertions(+), 5 deletions(-)

Index: code/makedumpfile.c
===================================================================
--- code.orig/makedumpfile.c
+++ code/makedumpfile.c
@@ -25,6 +25,7 @@
 #include <sys/time.h>
 #include <limits.h>
 #include <assert.h>
+#include <sys/stat.h>
 
 struct symbol_table	symbol_table;
 struct size_table	size_table;
@@ -10364,6 +10365,175 @@ int show_mem_usage(void)
 	return TRUE;
 }
 
+/*
+ * return 1 if path is a directory
+ * else return 0
+ */
+int
+isdir(char *path)
+{
+	struct stat buf;
+
+	if (path) {
+		if (stat(path, &buf) || !S_ISDIR(buf.st_mode)) {
+			return 0;
+		}
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+/*
+ * Set info->root_dir to the crashkernel's path to the bootkernel's root
+ * or set it to null if that path cannot be determined.
+ * We need the --work-dir path to accurately extract the leading part of
+ * the dump file's path as the path to the root filesystem.
+ * Conventionally --work-dir will be the directory name to which dumps will
+ * be written.  But it could be the absolute, crashkernel-relative path
+ * to a working directory.  In the second case we do not need to set
+ * info-root_dir, and this function should not even be called.
+ */
+void
+set_rootdir()
+{
+	int len1, len2;
+	char *cp1, *cp2, *rootdir, *dumpdir;
+
+	/* allow this function to be called multiple times */
+	if (info->root_dir)
+		return;
+
+	/* without a dump file name we cannot determine the path to root */
+	if (!info->name_dumpfile) {
+		info->root_dir = NULL;
+		return;
+	}
+	if ((int)strlen(info->name_dumpfile) == 0) {
+		info->root_dir = NULL;
+		return;
+	}
+
+	/*
+	 * name_dumpfile might be /kdump/0/var/crash/xyz
+	 * working_dir   might be /var/crash
+	 * so the root path is /kdump/0
+	 */
+	len1 = strlen(info->name_dumpfile);
+	rootdir = malloc(len1 + 2);
+	strcpy(rootdir, info->name_dumpfile);
+	if (*(rootdir + len1 - 1) != '/' )
+		strcat(rootdir, "/");
+	len1 = strlen(rootdir);
+	info->root_dir = malloc(len1);
+
+	len2 = strlen(info->working_dir);
+	dumpdir = malloc(len2 + 2);
+	strcpy(dumpdir, info->working_dir);
+	if (*(dumpdir + len2 - 1) != '/' )
+		strcat(dumpdir, "/");
+	len2 = strlen(dumpdir);
+
+	/* find the dumpdir path within the rootdir path */
+	cp1 = rootdir;
+	cp2 = cp1;
+	while (*cp2 != '\0') {
+		if (!strncmp(cp2, dumpdir, len2)) {
+			len1 = cp2 - cp1;
+			strncpy(info->root_dir, cp1, len1);
+			/* name_dumpfile sometimes contains // */
+			if (*(info->root_dir + len1 - 1) == '/' )
+				*(info->root_dir + len1 - 1) = '\0';
+			if (!isdir(info->root_dir)) {
+				fprintf(stderr,
+				  "Error: root directory %s does not exist\n",
+					info->root_dir);
+				exit(1);
+			}
+			free(rootdir);
+			free(dumpdir);
+			return;
+		}
+		cp2++;
+	}
+	info->root_dir = NULL;
+	free(rootdir);
+	free(dumpdir);
+	return;
+}
+
+/*
+ * The --work-dir directory should be validated and created if necessary.
+ */
+void
+adjust_working_dir()
+{
+	int ret, finished=0;
+	char *hold, *inter_dir = NULL, *cp1, *cp2;
+
+	/* we cannot assume makedumpfile's current directory, so make the
+	   work-dir's path absolute */
+	if (strncmp(info->working_dir, "/", 1)) {
+		hold = malloc(strlen(info->working_dir) + 2);
+		strcpy(hold, "/");
+		strcat(hold, info->working_dir);
+		free(hold);
+	}
+
+	/* if a path that is valid in the crashkernel root environment
+	   was specified, no adjust is necessary */
+	if (isdir(info->working_dir))
+		return;
+
+	set_rootdir();
+
+	/* the path does not exist in the crashkernel's root, so it
+	   should be adjusted to be relative to that root path */
+	if (info->root_dir) {
+		hold = malloc(strlen(info->working_dir) + 1);
+		strcpy(hold, info->working_dir);
+		info->working_dir = malloc(strlen(info->root_dir) +
+			strlen(info->working_dir) + 1);
+		inter_dir = malloc(strlen(info->root_dir) +
+			strlen(info->working_dir) + 1);
+		strcpy(info->working_dir, info->root_dir);
+		strcat(info->working_dir, hold);
+		free (hold);
+		fprintf(stderr, "--workdir adjusted to %s\n",
+			info->working_dir);
+	} else {
+		inter_dir = malloc(strlen(info->working_dir) + 1);
+	}
+
+	/* path is complete, now make sure it exists */
+	if (!isdir(info->working_dir)) {
+		strcpy(inter_dir, info->working_dir);
+		if (info->root_dir)
+			cp1 = inter_dir + strlen(info->root_dir) + 1;
+		else
+			cp1 = inter_dir + 1;
+		while (finished == 0) {
+			strcpy(inter_dir, info->working_dir);
+			cp2 = strchr(cp1, '/');
+			if (cp2) {
+				*cp2 = '\0';
+				cp1 = cp2 + 1;
+			} else {
+				finished = 1;
+			}
+			if (!isdir(inter_dir)) {
+				ret = mkdir(inter_dir, 0755);
+				if (ret) {
+					fprintf(stderr,
+					 "Error: mkdir(%s, 0755) returned %d\n",
+						inter_dir, ret);
+					exit(1);
+				}
+			}
+		}
+	}
+	return;
+}
 
 static struct option longopts[] = {
 	{"split", no_argument, NULL, OPT_SPLIT},
@@ -10650,6 +10820,9 @@ main(int argc, char *argv[])
 				goto out;
 		}
 
+		if (info->working_dir)
+			adjust_working_dir();
+
 		if (!create_dumpfile())
 			goto out;
 
Index: code/print_info.c
===================================================================
--- code.orig/print_info.c
+++ code/print_info.c
@@ -221,11 +221,19 @@ print_usage(void)
 	MSG("      size is at most N kilo bytes.\n");
 	MSG("\n");
 	MSG("  [--work-dir]:\n");
-	MSG("      Specify the working directory for the temporary bitmap file.\n");
-	MSG("      If this option isn't specified, the bitmap will be saved on memory.\n");
-	MSG("      Filtering processing has to do 2 pass scanning to fix the memory consumption,\n");
-	MSG("      but it can be avoided by using working directory on file system.\n");
+	MSG("      Specify the working directory for temporary files such as the bitmap.\n");
+	MSG("      If this option isn't specified, the bitmap will be saved in memory.\n");
+	MSG("      Filtering processing has to do 2 pass scanning to fix the memory\n");
+	MSG("      consumption but it can be avoided by using this working directory on\n");
+	MSG("      the file system.\n");
 	MSG("      So if you specify this option, the filtering speed may be bit faster.\n");
+	MSG("      It may be an existing directory expressed with the path to the root\n");
+	MSG("      file system as it is mounted in the crashkernel.\n");
+	MSG("      Or, more conventionally, it should match the 'path' variable in\n");
+	MSG("      /etc/kdump.conf or the 'KDUMP_SAVEDIR' variable (directory portion) in\n");
+	MSG("      /etc/sysconfig/kdump. In this case it will be automatically adjusted\n");
+	MSG("      to be relative to the root of the crashkernel.\n");
+	MSG("      The root of the crashkernel is determined using the dump name, if present.\n");
 	MSG("\n");
 	MSG("  [--non-mmap]:\n");
 	MSG("      Never use mmap(2) to read VMCORE even if it supports mmap(2).\n");
Index: code/makedumpfile.h
===================================================================
--- code.orig/makedumpfile.h
+++ code/makedumpfile.h
@@ -1258,7 +1258,8 @@ struct DumpInfo {
 	/*
 	 * for cyclic processing
 	 */
-	char	           *working_dir;	     /* working directory for bitmap */
+	char	           *working_dir;	/* working directory for bitmap */
+	char		   *root_dir;		/* path to the root filesystem */
 	mdf_pfn_t          num_dumpable;
 	unsigned long      bufsize_cyclic;
 	unsigned long      pfn_cyclic;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

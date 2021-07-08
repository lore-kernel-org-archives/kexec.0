Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com
 ([40.107.243.68] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1O8M-00GAwp-Mx
 for kexec@lists.infradead.org; Thu, 08 Jul 2021 07:07:44 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
Subject: [PATCH v2 makedumpfile 3/3] Add -L option to limit output file size
Date: Thu, 8 Jul 2021 16:06:11 +0900
Message-ID: <20210708070611.291260-4-bpoirier@nvidia.com>
In-Reply-To: <20210708070611.291260-1-bpoirier@nvidia.com>
References: <20210708070611.291260-1-bpoirier@nvidia.com>
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
To: kexec@lists.infradead.org

This option can be used to ensure that a certain amount of free space is
preserved. It is useful when the output of makedumpfile is on the root
filesystem and some services fail to start at boot if there is no space
left.

Note that in some cases the limit can be triggered before the output file
reaches the specified size because makedumpfile seeks and tries to write
beyond the end of the file.

Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 makedumpfile.8 | 12 ++++++--
 makedumpfile.c | 79 ++++++++++++++++++++++++++++++++++++++++----------
 makedumpfile.h |  3 ++
 print_info.c   |  3 ++
 sadump_info.c  |  2 +-
 5 files changed, 79 insertions(+), 20 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 313a41c..9a90f0e 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -157,9 +157,10 @@ will be effective if you specify domain-0's \fIvmlinux\fR with \-x option.
 Then the pages are excluded only from domain-0.
 .br
 If specifying multiple dump_levels with the delimiter ',', makedumpfile retries
-to create a \fIDUMPFILE\fR by other dump_level when "No space on device" error
-happens. For example, if dump_level is "11,31" and makedumpfile fails
-by dump_level 11, makedumpfile retries it by dump_level 31.
+to create \fIDUMPFILE\fR using the next dump_level when the size of a dumpfile
+exceeds the limit specified with '-L' or when when a "No space on device" error
+happens. For example, if dump_level is "11,31" and makedumpfile fails with
+dump_level 11, makedumpfile retries with dump_level 31.
 .br
 .B Example:
 .br
@@ -221,6 +222,11 @@ Here is the all combinations of the bits.
     30 |      |   X   |   X   |  X   |  X
     31 |  X   |   X   |   X   |  X   |  X
 
+.TP
+\fB\-L\fR \fISIZE\fR
+Limit the size of the output file to \fISIZE\fR bytes. An incomplete
+\fIDUMPFILE\fR or \fILOGFILE\fR is written if the size would otherwise exceed
+\fISIZE\fR.
 
 .TP
 \fB\-E\fR
diff --git a/makedumpfile.c b/makedumpfile.c
index 9175a6a..4518ef4 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4716,27 +4716,62 @@ int
 write_and_check_space(int fd, void *buf, size_t buf_size, const char* desc,
 		      const char *file_name)
 {
-	int status, written_size = 0;
+	size_t limit, done = 0;
+	int retval = 0;
+	off_t pos;
 
-	write_bytes += buf_size;
+	if (fd == STDOUT_FILENO) {
+		pos = write_bytes;
+	} else {
+		pos = lseek(fd, 0, SEEK_CUR);
+		if (pos == -1) {
+			ERRMSG("Can't seek the dump file(%s). %s\n",
+			       file_name, strerror(errno));
+			return FALSE;
+		}
+	}
+
+	if (info->size_limit != -1 && pos + buf_size > info->size_limit) {
+		if (pos > info->size_limit)
+			limit = 0;
+		else
+			limit = info->size_limit - pos;
+		info->flag_nospace = TRUE;
+	} else {
+		limit = buf_size;
+	}
 
 	if (info->flag_dry_run)
-		return TRUE;
+		done = limit;
 
-	while (written_size < buf_size) {
-		status = write(fd, buf + written_size,
-				   buf_size - written_size);
-		if (0 < status) {
-			written_size += status;
-			continue;
+	while (done < limit) {
+		retval = write(fd, buf, limit - done);
+		if (retval > 0) {
+			done += retval;
+			buf += retval;
+		} else {
+			if (retval == -1) {
+				if (errno == EINTR)
+					continue;
+				if (errno == ENOSPC)
+					info->flag_nospace = TRUE;
+				else
+					info->flag_nospace = FALSE;
+				MSG("\nCan't write the %s file(%s). %s\n",
+				    desc, file_name, strerror(errno));
+			}
+			break;
 		}
-		if (errno == ENOSPC)
-			info->flag_nospace = TRUE;
-		MSG("\nCan't write the %s file(%s). %s\n", desc, file_name,
-		    strerror(errno));
-		return FALSE;
 	}
-	return TRUE;
+
+	write_bytes += done;
+
+	if (retval != -1 && done < buf_size) {
+		MSG("\nCan't write the %s file(%s). Size limit(%llu) reached.\n",
+		    desc, file_name, (unsigned long long) info->size_limit);
+	}
+
+	return done == buf_size;
 }
 
 int
@@ -11589,6 +11624,7 @@ main(int argc, char *argv[])
 	}
 	info->file_vmcoreinfo = NULL;
 	info->fd_vmlinux = -1;
+	info->size_limit = -1;
 	info->fd_xen_syms = -1;
 	info->fd_memory = -1;
 	info->fd_dumpfile = -1;
@@ -11609,9 +11645,12 @@ main(int argc, char *argv[])
 
 	info->block_order = DEFAULT_ORDER;
 	message_level = DEFAULT_MSG_LEVEL;
-	while ((opt = getopt_long(argc, argv, "b:cDd:eEFfg:hi:lpRvXx:", longopts,
+	while ((opt = getopt_long(argc, argv, "b:cDd:eEFfg:hi:lL:pRvXx:", longopts,
 	    NULL)) != -1) {
 		switch (opt) {
+			unsigned long long val;
+			char *endptr;
+
 		case OPT_BLOCK_ORDER:
 			info->block_order = atoi(optarg);
 			break;
@@ -11628,6 +11667,14 @@ main(int argc, char *argv[])
 			if (!parse_dump_level(optarg))
 				goto out;
 			break;
+		case OPT_SIZE_LIMIT:
+			val = memparse(optarg, &endptr);
+			if (*endptr || val == 0) {
+				MSG("Limit size(%s) is invalid.\n", optarg);
+				goto out;
+			}
+			info->size_limit = val;
+			break;
 		case OPT_ELF_DUMPFILE:
 			info->flag_elf_dumpfile = 1;
 			break;
diff --git a/makedumpfile.h b/makedumpfile.h
index fb23efd..ca50a89 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1344,6 +1344,7 @@ struct DumpInfo {
 	int		max_dump_level;      /* maximum dump level */
 	int		num_dump_level;      /* number of dump level */
 	int		array_dump_level[NUM_ARRAY_DUMP_LEVEL];
+	off_t		size_limit;          /* dump file size limit */
 	int		flag_compress;       /* flag of compression */
 	int		flag_lzo_support;    /* flag of LZO compression support */
 	int		flag_elf_dumpfile;   /* flag of creating ELF dumpfile */
@@ -2458,6 +2459,7 @@ struct elf_prstatus {
 #define OPT_HELP                'h'
 #define OPT_READ_VMCOREINFO     'i'
 #define OPT_COMPRESS_LZO        'l'
+#define OPT_SIZE_LIMIT          'L'
 #define OPT_COMPRESS_SNAPPY     'p'
 #define OPT_REARRANGE           'R'
 #define OPT_VERSION             'v'
@@ -2514,5 +2516,6 @@ int write_and_check_space(int fd, void *buf, size_t buf_size,
 			  const char* desc, const char *file_name);
 int open_dump_file(void);
 int dump_lockless_dmesg(void);
+unsigned long long memparse(char *ptr, char **retptr);
 
 #endif /* MAKEDUMPFILE_H */
diff --git a/print_info.c b/print_info.c
index ad4184e..8b28554 100644
--- a/print_info.c
+++ b/print_info.c
@@ -144,6 +144,9 @@ print_usage(void)
 	MSG("        16  |                                    X\n");
 	MSG("        31  |   X       X        X       X       X\n");
 	MSG("\n");
+	MSG("  [-L SIZE]:\n");
+	MSG("      Limit the size of the output file to SIZE bytes.\n");
+	MSG("\n");
 	MSG("  [-E]:\n");
 	MSG("      Create DUMPFILE in the ELF format.\n");
 	MSG("      This option cannot be specified with the -c, -l or -p options,\n");
diff --git a/sadump_info.c b/sadump_info.c
index 9f5f568..b91eae5 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -1062,7 +1062,7 @@ get_vec0_addr(ulong idtr)
  * Parse a string of [size[KMG]@]offset[KMG]
  * Import from Linux kernel(lib/cmdline.c)
  */
-static ulong memparse(char *ptr, char **retptr)
+unsigned long long memparse(char *ptr, char **retptr)
 {
 	char *endptr;
 
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

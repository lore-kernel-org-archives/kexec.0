Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khVpG-00034P-0O
 for kexec@lists.infradead.org; Tue, 24 Nov 2020 10:45:35 +0000
Received: by mail-wm1-f72.google.com with SMTP id j62so1029242wma.4
 for <kexec@lists.infradead.org>; Tue, 24 Nov 2020 02:45:31 -0800 (PST)
From: Julien Thierry <jthierry@redhat.com>
Subject: [MAKEDUMPFILE PATCH 1/2] Add option to prevent writing the dumpfile
Date: Tue, 24 Nov 2020 10:45:24 +0000
Message-Id: <20201124104525.1070885-2-jthierry@redhat.com>
In-Reply-To: <20201124104525.1070885-1-jthierry@redhat.com>
References: <20201124104525.1070885-1-jthierry@redhat.com>
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
Cc: bhsharma@redhat.com, Julien Thierry <jthierry@redhat.com>, k-hagio-ab@nec.com, lijiang@redhat.com

Add a --dry-run option to run all operations without writing the
dump to the output file.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 makedumpfile.8 |  5 +++++
 makedumpfile.c | 33 +++++++++++++++++++++++++++++++--
 makedumpfile.h |  2 ++
 print_info.c   |  3 +++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 2fe2cd0..39a63ba 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -637,6 +637,11 @@ Show the version of makedumpfile.
 Only check whether the command-line parameters are valid or not, and exit.
 Preferable to be given as the first parameter.
 
+.TP
+\fB\-\-dry-run\fR
+Do not write the output dump file while still performing operations specified
+by other options.
+
 .SH ENVIRONMENT VARIABLES
 
 .TP 8
diff --git a/makedumpfile.c b/makedumpfile.c
index cdde040..90258f3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1366,7 +1366,9 @@ open_dump_file(void)
 	if (!info->flag_force)
 		open_flags |= O_EXCL;
 
-	if (info->flag_flatten) {
+	if (info->flag_dry_run) {
+		fd = -1;
+	} else if (info->flag_flatten) {
 		fd = STDOUT_FILENO;
 		info->name_dumpfile = filename_stdout;
 	} else if ((fd = open(info->name_dumpfile, open_flags,
@@ -1384,6 +1386,9 @@ check_dump_file(const char *path)
 {
 	char *err_str;
 
+	if (info->flag_dry_run)
+		return TRUE;
+
 	if (access(path, F_OK) != 0)
 		return TRUE; /* File does not exist */
 	if (info->flag_force) {
@@ -4643,6 +4648,8 @@ write_buffer(int fd, off_t offset, void *buf, size_t buf_size, char *file_name)
 		}
 		if (!write_and_check_space(fd, &fdh, sizeof(fdh), file_name))
 			return FALSE;
+	} else if (info->flag_dry_run && fd == info->fd_dumpfile) {
+		return TRUE;
 	} else {
 		if (lseek(fd, offset, SEEK_SET) == failed) {
 			ERRMSG("Can't seek the dump file(%s). %s\n",
@@ -9007,6 +9014,9 @@ close_dump_file(void)
 	if (info->flag_flatten)
 		return;
 
+	if (info->flag_dry_run)
+		return;
+
 	if (close(info->fd_dumpfile) < 0)
 		ERRMSG("Can't close the dump file(%s). %s\n",
 		    info->name_dumpfile, strerror(errno));
@@ -11032,7 +11042,8 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
 		 */
 		info->name_memory   = argv[optind];
 
-	} else if ((argc == optind + 1) && info->flag_mem_usage) {
+	} else if ((argc == optind + 1) && (info->flag_mem_usage ||
+					    info->flag_dry_run)) {
 		/*
 		* Parameter for showing the page number of memory
 		* in different use from.
@@ -11412,6 +11423,7 @@ static struct option longopts[] = {
 	{"work-dir", required_argument, NULL, OPT_WORKING_DIR},
 	{"num-threads", required_argument, NULL, OPT_NUM_THREADS},
 	{"check-params", no_argument, NULL, OPT_CHECK_PARAMS},
+	{"dry-run", no_argument, NULL, OPT_DRY_RUN},
 	{0, 0, 0, 0}
 };
 
@@ -11578,6 +11590,9 @@ main(int argc, char *argv[])
 			info->flag_check_params = TRUE;
 			message_level = DEFAULT_MSG_LEVEL;
 			break;
+		case OPT_DRY_RUN:
+			info->flag_dry_run = TRUE;
+			break;
 		case '?':
 			MSG("Commandline parameter is invalid.\n");
 			MSG("Try `makedumpfile --help' for more information.\n");
@@ -11591,6 +11606,10 @@ main(int argc, char *argv[])
 		/* suppress debugging messages */
 		message_level = DEFAULT_MSG_LEVEL;
 
+	if (info->flag_dry_run)
+		/* Suppress progress indicator as dumpfile won't get written */
+		message_level &= ~ML_PRINT_PROGRESS;
+
 	if (info->flag_show_usage) {
 		print_usage();
 		return COMPLETED;
@@ -11661,6 +11680,9 @@ main(int argc, char *argv[])
 		if (!close_files_for_rearranging_dumpdata())
 			goto out;
 
+		if (info->flag_dry_run)
+			goto check_ok;
+
 		MSG("\n");
 		MSG("The dumpfile is saved to %s.\n", info->name_dumpfile);
 	} else if (info->flag_reassemble) {
@@ -11677,6 +11699,10 @@ main(int argc, char *argv[])
 
 		if (!reassemble_dumpfile())
 			goto out;
+
+		if (info->flag_dry_run)
+			goto check_ok;
+
 		MSG("\n");
 		MSG("The dumpfile is saved to %s.\n", info->name_dumpfile);
 	} else if (info->flag_dmesg) {
@@ -11739,6 +11765,9 @@ main(int argc, char *argv[])
 		if (!create_dumpfile())
 			goto out;
 
+		if (info->flag_dry_run)
+			goto check_ok;
+
 		MSG("\n");
 		if (info->flag_split) {
 			MSG("The dumpfiles are saved to ");
diff --git a/makedumpfile.h b/makedumpfile.h
index 698c054..58126cb 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1321,6 +1321,7 @@ struct DumpInfo {
 	int		flag_vmemmap;        /* kernel supports vmemmap address space */
 	int		flag_excludevm;      /* -e - excluding unused vmemmap pages */
 	int		flag_use_count;      /* _refcount is named _count in struct page */
+	int		flag_dry_run;        /* do not create a vmcore file */
 	unsigned long	vaddr_for_vtop;      /* virtual address for debugging */
 	long		page_size;           /* size of page */
 	long		page_shift;
@@ -2364,6 +2365,7 @@ struct elf_prstatus {
 #define OPT_NUM_THREADS         OPT_START+16
 #define OPT_PARTIAL_DMESG       OPT_START+17
 #define OPT_CHECK_PARAMS        OPT_START+18
+#define OPT_DRY_RUN             OPT_START+19
 
 /*
  * Function Prototype.
diff --git a/print_info.c b/print_info.c
index e0c38b4..d2b0cb7 100644
--- a/print_info.c
+++ b/print_info.c
@@ -308,6 +308,9 @@ print_usage(void)
 	MSG("      the crashkernel range, then calculates the page number of different kind per\n");
 	MSG("      vmcoreinfo. So currently /proc/kcore need be specified explicitly.\n");
 	MSG("\n");
+	MSG("  [--dry-run]:\n");
+	MSG("      This option runs makedumpfile without writting output dump file.\n");
+	MSG("\n");
 	MSG("  [-D]:\n");
 	MSG("      Print debugging message.\n");
 	MSG("\n");
-- 
2.25.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

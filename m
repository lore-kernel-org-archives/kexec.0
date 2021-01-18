Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410053.outbound.protection.outlook.com
 ([40.107.141.53] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1OGh-0008Ko-FN
 for kexec@lists.infradead.org; Mon, 18 Jan 2021 06:44:05 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [MAKEDUMPFILE PATCH 1/2] Add option to prevent writing the
 dumpfile
Date: Mon, 18 Jan 2021 06:43:55 +0000
Message-ID: <OSAPR01MB1986854BD0AEB2927A084DDCDDA40@OSAPR01MB1986.jpnprd01.prod.outlook.com>
References: <20201124104525.1070885-1-jthierry@redhat.com>
 <20201124104525.1070885-2-jthierry@redhat.com>
In-Reply-To: <20201124104525.1070885-2-jthierry@redhat.com>
Content-Language: ja-JP
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
To: Julien Thierry <jthierry@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "bhsharma@redhat.com" <bhsharma@redhat.com>, "lijiang@redhat.com" <lijiang@redhat.com>

Hi Julien,

Thanks for the patches, and sorry for the late reply..

-----Original Message-----
> Add a --dry-run option to run all operations without writing the
> dump to the output file.

First, I think makedumpfile should not change its behavior (path checks,
messages emitted, etc.) and exit code except for writing the dumpfile
with or without the --dry-run option.  For example with this patch:

  $ touch dumpfile
  $ makedumpfile -d 1 vmcore dumpfile --dry-run  --> ok, no problem
  $ makedumpfile -d 1 vmcore dumpfile            --> error

This change is a bit strange to me.  So with this premise, commented inline
and attached a modified patch at end of this email.  Could you check those?

> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  makedumpfile.8 |  5 +++++
>  makedumpfile.c | 33 +++++++++++++++++++++++++++++++--
>  makedumpfile.h |  2 ++
>  print_info.c   |  3 +++
>  4 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.8 b/makedumpfile.8
> index 2fe2cd0..39a63ba 100644
> --- a/makedumpfile.8
> +++ b/makedumpfile.8
> @@ -637,6 +637,11 @@ Show the version of makedumpfile.
>  Only check whether the command-line parameters are valid or not, and exit.
>  Preferable to be given as the first parameter.
> 
> +.TP
> +\fB\-\-dry-run\fR
> +Do not write the output dump file while still performing operations specified
> +by other options.
> +
>  .SH ENVIRONMENT VARIABLES
> 
>  .TP 8
> diff --git a/makedumpfile.c b/makedumpfile.c
> index cdde040..90258f3 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1366,7 +1366,9 @@ open_dump_file(void)
>  	if (!info->flag_force)
>  		open_flags |= O_EXCL;
> 
> -	if (info->flag_flatten) {
> +	if (info->flag_dry_run) {
> +		fd = -1;
> +	} else if (info->flag_flatten) {
>  		fd = STDOUT_FILENO;
>  		info->name_dumpfile = filename_stdout;

This does not support -F option.

# makedumpfile --dry-run -F -d 31 vmcore >/dev/null

Can't write the dump file((null)). Bad file descriptor

makedumpfile Failed.

I'll change the order here:

@@ -1372,6 +1372,8 @@ open_dump_file(void)
        if (info->flag_flatten) {
                fd = STDOUT_FILENO;
                info->name_dumpfile = filename_stdout;
+       } else if (info->flag_dry_run) {
+               fd = -1;
        } else if ((fd = open(info->name_dumpfile, open_flags,
            S_IRUSR|S_IWUSR)) < 0) {
                ERRMSG("Can't open the dump file(%s). %s\n",

>  	} else if ((fd = open(info->name_dumpfile, open_flags,
> @@ -1384,6 +1386,9 @@ check_dump_file(const char *path)
>  {
>  	char *err_str;
> 
> +	if (info->flag_dry_run)
> +		return TRUE;
> +

I would prefer to check the path rather than skip it because of the reason
I wrote above.

>  	if (access(path, F_OK) != 0)
>  		return TRUE; /* File does not exist */
>  	if (info->flag_force) {
> @@ -4643,6 +4648,8 @@ write_buffer(int fd, off_t offset, void *buf, size_t buf_size, char *file_name)
>  		}
>  		if (!write_and_check_space(fd, &fdh, sizeof(fdh), file_name))
>  			return FALSE;
> +	} else if (info->flag_dry_run && fd == info->fd_dumpfile) {
> +		return TRUE;

To support -F option and count bytes written later, I'll add this in
write_and_check_space().

@@ -4711,6 +4713,9 @@ write_and_check_space(int fd, void *buf, size_t buf_size, char *file_name)
 {
        int status, written_size = 0;
 
+       if (info->flag_dry_run)
+               return TRUE;
+
        while (written_size < buf_size) {
                status = write(fd, buf + written_size,
                                   buf_size - written_size);


>  	} else {
>  		if (lseek(fd, offset, SEEK_SET) == failed) {
>  			ERRMSG("Can't seek the dump file(%s). %s\n",
> @@ -9007,6 +9014,9 @@ close_dump_file(void)
>  	if (info->flag_flatten)
>  		return;
> 
> +	if (info->flag_dry_run)
> +		return;
> +
>  	if (close(info->fd_dumpfile) < 0)
>  		ERRMSG("Can't close the dump file(%s). %s\n",
>  		    info->name_dumpfile, strerror(errno));
> @@ -11032,7 +11042,8 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
>  		 */
>  		info->name_memory   = argv[optind];
> 
> -	} else if ((argc == optind + 1) && info->flag_mem_usage) {
> +	} else if ((argc == optind + 1) && (info->flag_mem_usage ||
> +					    info->flag_dry_run)) {

I would not like to change valid parameters with --dry-run, so will restore this.

>  		/*
>  		* Parameter for showing the page number of memory
>  		* in different use from.
> @@ -11412,6 +11423,7 @@ static struct option longopts[] = {
>  	{"work-dir", required_argument, NULL, OPT_WORKING_DIR},
>  	{"num-threads", required_argument, NULL, OPT_NUM_THREADS},
>  	{"check-params", no_argument, NULL, OPT_CHECK_PARAMS},
> +	{"dry-run", no_argument, NULL, OPT_DRY_RUN},
>  	{0, 0, 0, 0}
>  };
> 
> @@ -11578,6 +11590,9 @@ main(int argc, char *argv[])
>  			info->flag_check_params = TRUE;
>  			message_level = DEFAULT_MSG_LEVEL;
>  			break;
> +		case OPT_DRY_RUN:
> +			info->flag_dry_run = TRUE;
> +			break;
>  		case '?':
>  			MSG("Commandline parameter is invalid.\n");
>  			MSG("Try `makedumpfile --help' for more information.\n");
> @@ -11591,6 +11606,10 @@ main(int argc, char *argv[])
>  		/* suppress debugging messages */
>  		message_level = DEFAULT_MSG_LEVEL;
> 
> +	if (info->flag_dry_run)
> +		/* Suppress progress indicator as dumpfile won't get written */
> +		message_level &= ~ML_PRINT_PROGRESS;
> +

Will restore this as well.

>  	if (info->flag_show_usage) {
>  		print_usage();
>  		return COMPLETED;
> @@ -11661,6 +11680,9 @@ main(int argc, char *argv[])
>  		if (!close_files_for_rearranging_dumpdata())
>  			goto out;
> 
> +		if (info->flag_dry_run)
> +			goto check_ok;
> +
>  		MSG("\n");
>  		MSG("The dumpfile is saved to %s.\n", info->name_dumpfile);
>  	} else if (info->flag_reassemble) {
> @@ -11677,6 +11699,10 @@ main(int argc, char *argv[])
> 
>  		if (!reassemble_dumpfile())
>  			goto out;
> +
> +		if (info->flag_dry_run)
> +			goto check_ok;

To make --reassemble, --dump-dmesg, etc. support --dry-run looks a bit
troublesome and not so useful, I would like to not support it like:

@@ -11029,6 +11038,11 @@ check_param_for_reassembling_dumpfile(int argc, char *argv[])
            || info->flag_exclude_xen_dom || info->flag_split)
                return FALSE;
 
+       if (info->flag_dry_run) {
+               MSG("--dry-run cannot be used with --reassemble.\n");
+               return FALSE;
+       }
+
        if ((info->splitting_info
            = malloc(sizeof(struct splitting_info) * info->num_dumpfile))
            == NULL) {


> +
>  		MSG("\n");
>  		MSG("The dumpfile is saved to %s.\n", info->name_dumpfile);
>  	} else if (info->flag_dmesg) {
> @@ -11739,6 +11765,9 @@ main(int argc, char *argv[])
>  		if (!create_dumpfile())
>  			goto out;
> 
> +		if (info->flag_dry_run)
> +			goto check_ok;
> +
>  		MSG("\n");
>  		if (info->flag_split) {
>  			MSG("The dumpfiles are saved to ");
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 698c054..58126cb 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1321,6 +1321,7 @@ struct DumpInfo {
>  	int		flag_vmemmap;        /* kernel supports vmemmap address space */
>  	int		flag_excludevm;      /* -e - excluding unused vmemmap pages */
>  	int		flag_use_count;      /* _refcount is named _count in struct page */
> +	int		flag_dry_run;        /* do not create a vmcore file */
>  	unsigned long	vaddr_for_vtop;      /* virtual address for debugging */
>  	long		page_size;           /* size of page */
>  	long		page_shift;
> @@ -2364,6 +2365,7 @@ struct elf_prstatus {
>  #define OPT_NUM_THREADS         OPT_START+16
>  #define OPT_PARTIAL_DMESG       OPT_START+17
>  #define OPT_CHECK_PARAMS        OPT_START+18
> +#define OPT_DRY_RUN             OPT_START+19
> 
>  /*
>   * Function Prototype.
> diff --git a/print_info.c b/print_info.c
> index e0c38b4..d2b0cb7 100644
> --- a/print_info.c
> +++ b/print_info.c
> @@ -308,6 +308,9 @@ print_usage(void)
>  	MSG("      the crashkernel range, then calculates the page number of different kind per\n");
>  	MSG("      vmcoreinfo. So currently /proc/kcore need be specified explicitly.\n");
>  	MSG("\n");
> +	MSG("  [--dry-run]:\n");
> +	MSG("      This option runs makedumpfile without writting output dump file.\n");
> +	MSG("\n");
>  	MSG("  [-D]:\n");
>  	MSG("      Print debugging message.\n");
>  	MSG("\n");
> --
> 2.25.4


From e4600ef29a1bac00b93a03e9dd82dd86c719ce94 Mon Sep 17 00:00:00 2001
From: Julien Thierry <jthierry@redhat.com>
Date: Tue, 24 Nov 2020 10:45:24 +0000
Subject: [PATCH] Add --dry-run option to prevent writing the dumpfile

Add a --dry-run option to run all operations without writing the
dump to the output file.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Kazuhito Hagio <k-hagio-ab@nec.com>
---
 makedumpfile.8 |  5 +++++
 makedumpfile.c | 37 ++++++++++++++++++++++++++++++-------
 makedumpfile.h |  2 ++
 print_info.c   |  3 +++
 4 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index b68a7e3563a7..6dffc81ddc7b 100644
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
index ecd63fa1a90f..8c80c49b21cb 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1372,6 +1372,8 @@ open_dump_file(void)
 	if (info->flag_flatten) {
 		fd = STDOUT_FILENO;
 		info->name_dumpfile = filename_stdout;
+	} else if (info->flag_dry_run) {
+		fd = -1;
 	} else if ((fd = open(info->name_dumpfile, open_flags,
 	    S_IRUSR|S_IWUSR)) < 0) {
 		ERRMSG("Can't open the dump file(%s). %s\n",
@@ -4711,6 +4713,9 @@ write_and_check_space(int fd, void *buf, size_t buf_size, char *file_name)
 {
 	int status, written_size = 0;
 
+	if (info->flag_dry_run)
+		return TRUE;
+
 	while (written_size < buf_size) {
 		status = write(fd, buf + written_size,
 				   buf_size - written_size);
@@ -4748,13 +4753,12 @@ write_buffer(int fd, off_t offset, void *buf, size_t buf_size, char *file_name)
 		}
 		if (!write_and_check_space(fd, &fdh, sizeof(fdh), file_name))
 			return FALSE;
-	} else {
-		if (lseek(fd, offset, SEEK_SET) == failed) {
-			ERRMSG("Can't seek the dump file(%s). %s\n",
-			    file_name, strerror(errno));
-			return FALSE;
-		}
+	} else if (!info->flag_dry_run &&
+		    lseek(fd, offset, SEEK_SET) == failed) {
+		ERRMSG("Can't seek the dump file(%s). %s\n", file_name, strerror(errno));
+		return FALSE;
 	}
+
 	if (!write_and_check_space(fd, buf, buf_size, file_name))
 		return FALSE;
 
@@ -9112,7 +9116,7 @@ close_dump_memory(void)
 void
 close_dump_file(void)
 {
-	if (info->flag_flatten)
+	if (info->flag_flatten || info->flag_dry_run)
 		return;
 
 	if (close(info->fd_dumpfile) < 0)
@@ -10985,6 +10989,11 @@ check_param_for_generating_vmcoreinfo(int argc, char *argv[])
 
 		return FALSE;
 
+	if (info->flag_dry_run) {
+		MSG("--dry-run cannot be used with -g.\n");
+		return FALSE;
+	}
+
 	return TRUE;
 }
 
@@ -11029,6 +11038,11 @@ check_param_for_reassembling_dumpfile(int argc, char *argv[])
 	    || info->flag_exclude_xen_dom || info->flag_split)
 		return FALSE;
 
+	if (info->flag_dry_run) {
+		MSG("--dry-run cannot be used with --reassemble.\n");
+		return FALSE;
+	}
+
 	if ((info->splitting_info
 	    = malloc(sizeof(struct splitting_info) * info->num_dumpfile))
 	    == NULL) {
@@ -11057,6 +11071,11 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
 	    || (info->flag_read_vmcoreinfo && info->name_xen_syms))
 		return FALSE;
 
+	if (info->flag_dry_run && info->flag_dmesg) {
+		MSG("--dry-run cannot be used with --dump-dmesg.\n");
+		return FALSE;
+	}
+
 	if (info->flag_flatten && info->flag_split)
 		return FALSE;
 
@@ -11520,6 +11539,7 @@ static struct option longopts[] = {
 	{"work-dir", required_argument, NULL, OPT_WORKING_DIR},
 	{"num-threads", required_argument, NULL, OPT_NUM_THREADS},
 	{"check-params", no_argument, NULL, OPT_CHECK_PARAMS},
+	{"dry-run", no_argument, NULL, OPT_DRY_RUN},
 	{0, 0, 0, 0}
 };
 
@@ -11686,6 +11706,9 @@ main(int argc, char *argv[])
 			info->flag_check_params = TRUE;
 			message_level = DEFAULT_MSG_LEVEL;
 			break;
+		case OPT_DRY_RUN:
+			info->flag_dry_run = TRUE;
+			break;
 		case '?':
 			MSG("Commandline parameter is invalid.\n");
 			MSG("Try `makedumpfile --help' for more information.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index 5f50080f958d..4c4222cc2545 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1322,6 +1322,7 @@ struct DumpInfo {
 	int		flag_vmemmap;        /* kernel supports vmemmap address space */
 	int		flag_excludevm;      /* -e - excluding unused vmemmap pages */
 	int		flag_use_count;      /* _refcount is named _count in struct page */
+	int		flag_dry_run;        /* do not create a vmcore file */
 	unsigned long	vaddr_for_vtop;      /* virtual address for debugging */
 	long		page_size;           /* size of page */
 	long		page_shift;
@@ -2425,6 +2426,7 @@ struct elf_prstatus {
 #define OPT_NUM_THREADS         OPT_START+16
 #define OPT_PARTIAL_DMESG       OPT_START+17
 #define OPT_CHECK_PARAMS        OPT_START+18
+#define OPT_DRY_RUN             OPT_START+19
 
 /*
  * Function Prototype.
diff --git a/print_info.c b/print_info.c
index e0c38b4c2ba3..d2b0cb7aaef8 100644
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
1.8.3.1


Thanks,
Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

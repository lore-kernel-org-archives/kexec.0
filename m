Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IBPHR-0006vk-1m
	for kexec@lists.infradead.org; Thu, 19 Jul 2007 02:14:31 -0400
Subject: Re: [PATCH] [makedumpfile] Introduce -f (force) option
In-reply-to: <20070717135615.GA19864@suse.de>
Message-Id: <20070719151446oomichi@mail.jp.nec.com>
References: <20070717135615.GA19864@suse.de>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Thu, 19 Jul 2007 15:14:46 +0900
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org


Hi Bernhard,

2007/07/17 15:56:16 +0200, Bernhard Walle <bwalle@suse.de> wrote:
>As I always forget to delete the produced dump file when testing
>something, I'd like to see a `-f' option that forces makedumpfile to
>overwrite existing files.

Thank you for a good patch.
I will merge it into a new release.


Thanks
Ken'ichi Ohmichi

>Signed-off-by: Bernhard Walle <bwalle@suse.de>
>
>---
> makedumpfile.8 |   10 ++++++++++
> makedumpfile.c |   11 +++++++++--
> makedumpfile.h |    1 +
> 3 files changed, 20 insertions(+), 2 deletions(-)
>
>--- a/makedumpfile.8
>+++ b/makedumpfile.8
>@@ -144,6 +144,16 @@ support compressed data.
> # makedumpfile \-E \-d 31 \-x vmlinux /proc/vmcore dumpfile
> 
> .TP
>+\fB\-f\fR
>+Force existing files to be overwritten.
>+.br
>+.B Example:
>+.br
>+# makedumpfile \-f \-x vmlinux /proc/vmcore dumpfile
>+.br
>+This command overwrites \fIdumpfile\fR if it already exists.
>+
>+.TP
> \fB\-x\fR \fIVMLINUX\fR
> Specify the first kernel's \fIVMLINUX\fR with debug information to analyze the
> first kernel's memory usage.
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -409,6 +409,10 @@ int
> open_dump_file(struct DumpInfo *info)
> {
> 	int fd;
>+	int open_flags = O_RDWR|O_CREAT;
>+
>+	if (!info->flag_force)
>+		open_flags |= O_EXCL;
> 
> 	if (info->flag_flatten) {
> 		if ((info->name_dumpfile
>@@ -420,7 +424,7 @@ open_dump_file(struct DumpInfo *info)
> 		fd = STDOUT_FILENO;
> 		strcpy(info->name_dumpfile, FILENAME_STDOUT);
> 
>-	} else if ((fd = open(info->name_dumpfile, O_RDWR|O_CREAT|O_EXCL,
>+	} else if ((fd = open(info->name_dumpfile, open_flags,
> 	    S_IRUSR|S_IWUSR)) < 0) {
> 		ERRMSG("Can't open the dump file(%s). %s\n",
> 		    info->name_dumpfile, strerror(errno));
>@@ -4624,7 +4628,7 @@ main(int argc, char *argv[])
> 	vt = &info->vm_table;
> 
> 	info->block_order = DEFAULT_ORDER;
>-	while ((opt = getopt(argc, argv, "b:cDd:EFg:hi:Rvx:")) != -1) {
>+	while ((opt = getopt(argc, argv, "b:cDd:EFg:hi:Rvx:f")) != -1) {
> 		switch (opt) {
> 		case 'b':
> 			info->block_order = atoi(optarg);
>@@ -4646,6 +4650,9 @@ main(int argc, char *argv[])
> 		case 'F':
> 			info->flag_flatten = 1;
> 			break;
>+		case 'f':
>+			info->flag_force = 1;
>+			break;
> 		case 'g':
> 			info->flag_generate_config = 1;
> 			info->name_configfile = optarg;
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -552,6 +552,7 @@ struct DumpInfo {
> 						format to a standard out */
> 	int		flag_rearrange;      /* flag of creating dumpfile from
> 						flattened format */
>+	int		flag_force;	     /* overwrite existing stuff */
> 	long		page_size;           /* size of page */
> 	long		page_shift;
> 	unsigned long long	max_mapnr;   /* number of page descriptor */
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

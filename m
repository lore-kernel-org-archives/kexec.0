Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410073.outbound.protection.outlook.com
 ([40.107.141.73] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1Op5-0003Ti-9O
 for kexec@lists.infradead.org; Mon, 18 Jan 2021 07:19:36 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [MAKEDUMPFILE PATCH 2/2] Add shorthand option to show report stats
Date: Mon, 18 Jan 2021 07:19:30 +0000
Message-ID: <OSAPR01MB1986B32888EDA25C18366AFADDA40@OSAPR01MB1986.jpnprd01.prod.outlook.com>
References: <20201124104525.1070885-1-jthierry@redhat.com>
 <20201124104525.1070885-3-jthierry@redhat.com>
In-Reply-To: <20201124104525.1070885-3-jthierry@redhat.com>
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

-----Original Message-----
> Provide shorthand option to enable report messages without needing
> to set a particular value for message-level.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  makedumpfile.8 |  5 +++++
>  makedumpfile.c | 12 +++++++++++-
>  makedumpfile.h |  1 +
>  print_info.c   |  3 +++
>  4 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/makedumpfile.8 b/makedumpfile.8
> index 39a63ba..ec1e625 100644
> --- a/makedumpfile.8
> +++ b/makedumpfile.8
> @@ -642,6 +642,11 @@ Preferable to be given as the first parameter.
>  Do not write the output dump file while still performing operations specified
>  by other options.
> 
> +.TP
> +\fB\-\-show-stats\fR
> +Display report messages. This is an alternative to enabling bit 4 in the level
> +provided to --message-level.
> +
>  .SH ENVIRONMENT VARIABLES
> 
>  .TP 8
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 90258f3..db31a03 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -11424,13 +11424,14 @@ static struct option longopts[] = {
>  	{"num-threads", required_argument, NULL, OPT_NUM_THREADS},
>  	{"check-params", no_argument, NULL, OPT_CHECK_PARAMS},
>  	{"dry-run", no_argument, NULL, OPT_DRY_RUN},
> +	{"show-stats", no_argument, NULL, OPT_SHOW_STATS},
>  	{0, 0, 0, 0}
>  };
> 
>  int
>  main(int argc, char *argv[])
>  {
> -	int i, opt, flag_debug = FALSE;
> +	int i, opt, flag_debug = FALSE, flag_show_stats = FALSE;
> 
>  	if ((info = calloc(1, sizeof(struct DumpInfo))) == NULL) {
>  		ERRMSG("Can't allocate memory for the pagedesc cache. %s.\n",
> @@ -11593,6 +11594,9 @@ main(int argc, char *argv[])
>  		case OPT_DRY_RUN:
>  			info->flag_dry_run = TRUE;
>  			break;
> +		case OPT_SHOW_STATS:
> +			flag_show_stats = TRUE;
> +			break;
>  		case '?':
>  			MSG("Commandline parameter is invalid.\n");
>  			MSG("Try `makedumpfile --help' for more information.\n");
> @@ -11606,6 +11610,12 @@ main(int argc, char *argv[])
>  		/* suppress debugging messages */
>  		message_level = DEFAULT_MSG_LEVEL;
> 
> +	if (flag_show_stats) {
> +		message_level |= ML_PRINT_REPORT_MSG;
> +		/* Progress indicator interferes with report messages */
> +		message_level &= ~ML_PRINT_PROGRESS;

I personally don't think it's so interfering, should we drop the
ML_PRINT_PROGRESS?

Otherwise, looks good to me.

Thanks,
Kazu

> +	}
> +
>  	if (info->flag_dry_run)
>  		/* Suppress progress indicator as dumpfile won't get written */
>  		message_level &= ~ML_PRINT_PROGRESS;
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 58126cb..18c8b0b 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -2366,6 +2366,7 @@ struct elf_prstatus {
>  #define OPT_PARTIAL_DMESG       OPT_START+17
>  #define OPT_CHECK_PARAMS        OPT_START+18
>  #define OPT_DRY_RUN             OPT_START+19
> +#define OPT_SHOW_STATS          OPT_START+20
> 
>  /*
>   * Function Prototype.
> diff --git a/print_info.c b/print_info.c
> index d2b0cb7..6ebf611 100644
> --- a/print_info.c
> +++ b/print_info.c
> @@ -311,6 +311,9 @@ print_usage(void)
>  	MSG("  [--dry-run]:\n");
>  	MSG("      This option runs makedumpfile without writting output dump file.\n");
>  	MSG("\n");
> +	MSG("  [--show-stats]:\n");
> +	MSG("      This option sets message-level to print report messages\n");
> +	MSG("\n");
>  	MSG("  [-D]:\n");
>  	MSG("      Print debugging message.\n");
>  	MSG("\n");
> --
> 2.25.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

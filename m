Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YiBpb-0006nh-NQ
 for kexec@lists.infradead.org; Wed, 15 Apr 2015 01:09:33 +0000
Date: Wed, 15 Apr 2015 10:09:08 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH REPOST 1/2] kexec: implement -y (--no-sync) option
Message-ID: <20150415010908.GB28632@verge.net.au>
References: <20150326191608.GE1953@htj.duckdns.org>
 <20150326191644.GF1953@htj.duckdns.org>
 <20150413170156.GH2596@htj.duckdns.org>
 <20150414002944.GB10790@verge.net.au>
 <20150414121509.GJ2596@htj.duckdns.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150414121509.GJ2596@htj.duckdns.org>
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
To: Tejun Heo <tj@kernel.org>
Cc: Chris Mason <clm@fb.com>, kexec@lists.infradead.org

Hi Tejun,

On Tue, Apr 14, 2015 at 08:15:09AM -0400, Tejun Heo wrote:
> >From a32a35e46a950cd0e4b4e317a9062c41e79fbfeb Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Thu, 26 Mar 2015 14:56:26 -0400
> 
> During kernel develoment, kexec can be used to get out of sticky
> situations without going through possibly lenghty reboot; however,
> there are situations where the filesystem and/or storage stack are
> known to be misbehaving and performing sync before kexecing is
> dangerous or just never finishes.
> 
> This patch implement -y (--no-sync) option which makes kexec skip
> syncing in the similar way as -x (--no-ifdown).
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Chris Mason <clm@fb.com>
> ---
> Hello, Simon.
> 
> Heh, weird.  Let's see if it goes through this time.

Indeed. I have the patches this time.
They both look good and I have applied them.

> Thanks.
> 
>  kexec/kexec.8 | 8 ++++++--
>  kexec/kexec.c | 8 +++++++-
>  kexec/kexec.h | 4 +++-
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/kexec/kexec.8 b/kexec/kexec.8
> index 2575f9e..24d1969 100644
> --- a/kexec/kexec.8
> +++ b/kexec/kexec.8
> @@ -6,7 +6,7 @@
>  kexec \- directly boot into a new kernel
>  .SH SYNOPSIS
>  .B /sbin/kexec
> -.B [-v (\-\-version)] [-f (\-\-force)] [-x (\-\-no-ifdown)] [-l (\-\-load)] [-p (\-\-load-panic)] [-u (\-\-unload)] [-e (\-\-exec)] [-t (\-\-type)]
> +.B [-v (\-\-version)] [-f (\-\-force)] [-x (\-\-no-ifdown)] [-y (\-\-no-sync)] [-l (\-\-load)] [-p (\-\-load-panic)] [-u (\-\-unload)] [-e (\-\-exec)] [-t (\-\-type)]
>  .BI [\-\-mem\-min= addr ]
>  .BI [\-\-mem\-max= addr ]
>  
> @@ -148,7 +148,11 @@ Return the version number of the installed utility.
>  .TP
>  .B \-x\ (\-\-no\-ifdown)
>  Shut down the running kernel, but restore the interface on reload. (If
> -this option is used, it must be specified last.)
> +this option is used, it must be one of last options specified.)
> +.TP
> +.B \-y\ (\-\-no\-sync)
> +Shut down the running kernel, but skip syncing the filesystems. (If
> +this option is used, it must be one of last options specified.)
>  .TP
>  .BI \-\-mem\-min= addr
>  Specify the lowest memory address
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index b088916..7123460 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -913,7 +913,10 @@ void usage(void)
>  	       " -f, --force          Force an immediate kexec,\n"
>  	       "                      don't call shutdown.\n"
>  	       " -x, --no-ifdown      Don't bring down network interfaces.\n"
> -	       "                      (if used, must be last option\n"
> +	       "                      (if used, must be one of last options\n"
> +	       "                       specified)\n"
> +	       " -y, --no-sync        Don't sync filesystems before kexec.\n"
> +	       "                      (if used, must be one of last options\n"
>  	       "                       specified)\n"
>  	       " -l, --load           Load the new kernel into the\n"
>  	       "                      current kernel.\n"
> @@ -1218,6 +1221,9 @@ int main(int argc, char *argv[])
>  		case OPT_NOIFDOWN:
>  			do_ifdown = 0;
>  			break;
> +		case OPT_NOSYNC:
> +			do_sync = 0;
> +			break;
>  		case OPT_FORCE:
>  			do_load = 1;
>  			do_shutdown = 0;
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index 4be2b2f..b129c15 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -209,6 +209,7 @@ extern int file_types;
>  #define OPT_DEBUG		'd'
>  #define OPT_FORCE		'f'
>  #define OPT_NOIFDOWN		'x'
> +#define OPT_NOSYNC		'y'
>  #define OPT_EXEC		'e'
>  #define OPT_LOAD		'l'
>  #define OPT_UNLOAD		'u'
> @@ -227,6 +228,7 @@ extern int file_types;
>  	{ "version",		0, 0, OPT_VERSION }, \
>  	{ "force",		0, 0, OPT_FORCE }, \
>  	{ "no-ifdown",		0, 0, OPT_NOIFDOWN }, \
> +	{ "no-sync",		0, 0, OPT_NOSYNC }, \
>  	{ "load",		0, 0, OPT_LOAD }, \
>  	{ "unload",		0, 0, OPT_UNLOAD }, \
>  	{ "exec",		0, 0, OPT_EXEC }, \
> @@ -241,7 +243,7 @@ extern int file_types;
>  	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
>  	{ "debug",		0, 0, OPT_DEBUG }, \
>  
> -#define KEXEC_OPT_STR "h?vdfxluet:ps"
> +#define KEXEC_OPT_STR "h?vdfxyluet:ps"
>  
>  extern void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr);
>  extern void die(const char *fmt, ...)
> -- 
> 2.1.0
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

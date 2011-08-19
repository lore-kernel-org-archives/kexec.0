Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QuDTD-0003PR-UV
	for kexec@lists.infradead.org; Fri, 19 Aug 2011 01:02:01 +0000
Date: Fri, 19 Aug 2011 09:31:09 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: Support line mode terminals
Message-Id: <20110819093109.ed9252ed.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <1313414666.9445.3.camel@br98xy6r>
References: <1313414666.9445.3.camel@br98xy6r>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: kexec@lists.infradead.org


Hi Michael,

On Mon, 15 Aug 2011 15:24:26 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:
>
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> On S390 we have line mode terminals that do not have the ability to
> position the cursor. When using kdump the output of makedumpfile will be shown
> on such terminals. Currently the output looks very strange because the '\r'
> control character is ignored. It looks like the following:
> 
>  Checking for memory holes          : [  0 %]  Checking for memory holes        
>   : [100 %]  Copying data                       : [ 33 %]  Copying data         
>               : [ 65 %]  Copying data                       : [ 96 %]  Copying d
> ata                       : [100 %]   
> 
> For those line mode terminals the TERM environment variable is set to "dumb".
> With this patch makedumpfile checks the TERM variable and in case of "dumb"
> instead of using '\r' each progress message is printed into a separate line.
> The output will then look like the following:
> 
> Checking for memory holes          : [  0 %]
> Checking for memory holes          : [100 %]
> Copying data                       : [ 11 %]
> Copying data                       : [ 44 %]
> Copying data                       : [ 75 %]
> Copying data                       : [100 %]
> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Thank you for the patch, and it has been merged to devel tree.

http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=commit;h=4b4e1625a5ebe37cb0991fe1628f19bca2b1502f

Acked-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>


Thanks
Ken'ichi Ohmichi

> ---
>  makedumpfile.c |   22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -29,6 +29,7 @@ struct DumpInfo		*info = NULL;
>  
>  char filename_stdout[] = FILENAME_STDOUT;
>  int message_level;
> +static int dumb_term;
>  
>  /*
>   * Forward declarations
> @@ -5661,9 +5662,14 @@ print_progress(const char *msg, unsigned
>  		progress = current * 100 / end;
>  	} else
>  		progress = 100;
> -
> -	PROGRESS_MSG("\r");
> -	PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] ", msg, progress);
> +	if (dumb_term) {
> +		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%]\n",
> +			     msg, progress);
> +	} else {
> +		PROGRESS_MSG("\r");
> +		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] ",
> +			     msg, progress);
> +	}
>  }
>  
>  unsigned long long
> @@ -7825,11 +7831,21 @@ static struct option longopts[] = {
>  	{0, 0, 0, 0}
>  };
>  
> +static void setup_term(void)
> +{
> +	char *term_str = getenv("TERM");
> +
> +	if (term_str && strcmp(term_str, "dumb") == 0)
> +		dumb_term = 1;
> +}
> +
>  int
>  main(int argc, char *argv[])
>  {
>  	int i, opt, flag_debug = FALSE;
>  
> +	setup_term();
> +
>  	if ((info = calloc(1, sizeof(struct DumpInfo))) == NULL) {
>  		ERRMSG("Can't allocate memory for the pagedesc cache. %s.\n",
>  		    strerror(errno));
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

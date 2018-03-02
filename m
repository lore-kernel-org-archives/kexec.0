Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.89 #1 (Red Hat Linux))
 id 1erju6-00049g-RX
 for kexec@lists.infradead.org; Fri, 02 Mar 2018 12:35:19 +0000
Date: Fri, 2 Mar 2018 13:34:45 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/5] kexec: Return -ENOSYS when kexec does not know how
 to call KEXEC_FILE_LOAD
Message-ID: <20180302123445.3vemxrooug26ixdu@verge.net.au>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
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
To: Michal Suchanek <msuchanek@suse.de>
Cc: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, Tony Jones <tonyj@suse.com>

On Mon, Feb 26, 2018 at 01:00:34PM +0100, Michal Suchanek wrote:
> When the kernel does not know a syscall number it returns -ENOSYS but
> when kexec does not know a syscall number it returns -1. Return -ENOSYS
> from kexec as well.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  kexec/kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index cfd837c1b6bb..ab8cff7fe083 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1166,7 +1166,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
>  
>  	if (!is_kexec_file_load_implemented()) {
>  		fprintf(stderr, "syscall kexec_file_load not available.\n");
> -		return -1;
> +		return -ENOSYS;

It seems to me that the current with do_kexec_file_load() returning
0 for success and -1 for error. I think any change to that scheme would
need to be more comprehensive than this.

>  	}
>  
>  	if (argc - fileind <= 0) {
> -- 
> 2.13.6
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

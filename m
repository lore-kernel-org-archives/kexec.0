Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VRsrJ-0004sG-VX
 for kexec@lists.infradead.org; Fri, 04 Oct 2013 00:03:06 +0000
Date: Fri, 4 Oct 2013 09:02:44 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] kexec: Handle read errors in fs2dt setup
Message-ID: <20131004000244.GG29457@verge.net.au>
References: <cover.1380830946.git.geoff@infradead.org>
 <08231e47adbe1031fb2e919cce3c7f75b3edfa55.1380830946.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <08231e47adbe1031fb2e919cce3c7f75b3edfa55.1380830946.git.geoff@infradead.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org

On Thu, Oct 03, 2013 at 08:19:34PM +0000, Geoff Levand wrote:
> The putnode() routine in fs2dt.c was not checking for errors
> returned from calls to read().  Add checks for these errors
> and abort the setup of printing from purgatory if the checks
> fail.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  kexec/fs2dt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Thanks, applied.

> 
> diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
> index 98d6cb4..242a15e 100644
> --- a/kexec/fs2dt.c
> +++ b/kexec/fs2dt.c
> @@ -639,6 +639,11 @@ static void putnode(void)
>  		}
>  		result = read(fd, buff, statbuf.st_size);
>  		close(fd);
> +		if (result <= 0) {
> +			printf("Unable to read %s, printing from purgatory is diabled\n",
> +														filename);
> +			goto no_debug;
> +		}
>  		strncpy(filename, "/proc/device-tree/", MAXPATH);
>  		strncat(filename, buff, MAXPATH);
>  		strncat(filename, "/compatible", MAXPATH);
> @@ -661,7 +666,8 @@ static void putnode(void)
>  			goto no_debug;
>  		}
>  		result = read(fd, buff, statbuf.st_size);
> -		if (!strcmp(buff, "hvterm1") || !strcmp(buff, "hvterm-protocol"))
> +		if (result && (!strcmp(buff, "hvterm1")
> +			|| !strcmp(buff, "hvterm-protocol")))
>  			my_debug = 1;
>  		close(fd);
>  		free(buff);
> -- 
> 1.8.1.2
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

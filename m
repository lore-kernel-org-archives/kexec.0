Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UG3ex-0007IB-Sz
 for kexec@lists.infradead.org; Thu, 14 Mar 2013 08:37:12 +0000
Date: Thu, 14 Mar 2013 09:37:03 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: check size before trying the malloc
Message-ID: <20130314083702.GB11196@verge.net.au>
References: <5140B469.8080308@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5140B469.8080308@gmail.com>
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
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, Mar 14, 2013 at 01:16:25AM +0800, Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> If size is zero, it is unnecessary to do the malloc operation.
> So checking size first is better than doing malloc first.
> 
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Thanks, applied.

> ---
>  kexec/kexec.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 3ef6f0d..494c5b3 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -76,9 +76,9 @@ static char *xstrdup(const char *str)
>  void *xmalloc(size_t size)
>  {
>  	void *buf;
> -	buf = malloc(size);
>  	if (!size)
>  		return NULL;
> +	buf = malloc(size);
>  	if (!buf) {
>  		die("Cannot malloc %ld bytes: %s\n",
>  			size + 0UL, strerror(errno));
> -- 
> 1.7.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

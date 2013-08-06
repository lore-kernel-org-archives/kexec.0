Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V6cnq-00068R-FD
 for kexec@lists.infradead.org; Tue, 06 Aug 2013 08:39:39 +0000
Date: Tue, 6 Aug 2013 17:39:16 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH V2] kexec: remove unnecessary return
Message-ID: <20130806083915.GC28493@verge.net.au>
References: <5200B534.7000202@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5200B534.7000202@huawei.com>
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
To: Xishi Qiu <qiuxishi@huawei.com>
Cc: kexec@lists.infradead.org, zhangyanfei@cn.fujitsu.com, ebiederm@xmission.com, LKML <linux-kernel@vger.kernel.org>

On Tue, Aug 06, 2013 at 04:35:00PM +0800, Xishi Qiu wrote:
> Code can not run here forever, so remove the unnecessary return.
> 
> Signed-off-by: Xishi Qiu <qiuxishi@huawei.com>
> Suggested-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
>  kernel/kexec.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 59f7b55..2a74f30 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1474,11 +1474,8 @@ static int __init __parse_crashkernel(char *cmdline,
>  	if (first_colon && (!first_space || first_colon < first_space))
>  		return parse_crashkernel_mem(ck_cmdline, system_ram,
>  				crash_size, crash_base);
> -	else
> -		return parse_crashkernel_simple(ck_cmdline, crash_size,
> -				crash_base);
>  
> -	return 0;
> +	return parse_crashkernel_simple(ck_cmdline, crash_size, crash_base);
>  }
>  
>  /*
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

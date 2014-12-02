Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xvccd-0000EN-A4
 for kexec@lists.infradead.org; Tue, 02 Dec 2014 01:51:23 +0000
Date: Tue, 2 Dec 2014 10:50:57 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: remove some re zero-assignment
Message-ID: <20141202015057.GE20072@verge.net.au>
References: <1417221932-75098-1-git-send-email-hukeping@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1417221932-75098-1-git-send-email-hukeping@huawei.com>
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
To: HuKeping <hukeping@huawei.com>
Cc: kexec@lists.infradead.org, peifeiyue@huawei.com, sdu.liu@huawei.com

On Sat, Nov 29, 2014 at 08:45:32AM +0800, HuKeping wrote:
> since we have already cleared kexec_info with memset,
> there is no need to do that again to the struct members.
> 
> Signed-off-by: Hu Keping <hukeping@huawei.com>

Thanks, applied.

> ---
>  kexec/kexec.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index a5e78c6..b088916 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -662,10 +662,6 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
>  	int guess_only = 0;
>  
>  	memset(&info, 0, sizeof(info));
> -	info.segment = NULL;
> -	info.nr_segments = 0;
> -	info.entry = NULL;
> -	info.backup_start = 0;
>  	info.kexec_flags = kexec_flags;
>  
>  	result = 0;
> -- 
> 1.8.5.5
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

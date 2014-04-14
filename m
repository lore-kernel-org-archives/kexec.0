Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZWPW-0000Z1-SB
 for kexec@lists.infradead.org; Mon, 14 Apr 2014 02:14:15 +0000
Date: Mon, 14 Apr 2014 11:13:51 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH RESEND v5 04/10] x86, cleanup: add_memmap() only do
 alignment check on RANGE_RAM
Message-ID: <20140414021351.GK22411@verge.net.au>
References: <1397183011-1526-1-git-send-email-chaowang@redhat.com>
 <1397183011-1526-5-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397183011-1526-5-git-send-email-chaowang@redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, linn@hp.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

Could you please explain why this is necessary.

Also, it seems to me that it would make sense to move this
patch so that is is immediately after patch 2 in the series.

On Fri, Apr 11, 2014 at 10:23:25AM +0800, WANG Chao wrote:
> Signed-off-by: WANG Chao <chaowang@redhat.com>
> ---
>  kexec/arch/i386/crashdump-x86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 43eb8f7..4072c10 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -482,8 +482,8 @@ static int add_memmap(struct memory_range *memmap_p, int *nr_memmap_p,
>  	int i, j, nr_entries = 0, tidx = 0, align = 1024;
>  	unsigned long long mstart, mend;
>  
> -	/* Do alignment check. */
> -	if ((addr%align) || (size%align))
> +	/* Do alignment check if it's RANGE_RAM */
> +	if ((type == RANGE_RAM) && ((addr%align) || (size%align)))
>  		return -1;
>  
>  	/* Make sure at least one entry in list is free. */
> -- 
> 1.8.5.3
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

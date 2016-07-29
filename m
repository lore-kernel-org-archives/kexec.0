Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bT37L-0000Eg-7Y
 for kexec@lists.infradead.org; Fri, 29 Jul 2016 08:26:04 +0000
Received: by mail-pa0-f53.google.com with SMTP id ks6so29319363pab.0
 for <kexec@lists.infradead.org>; Fri, 29 Jul 2016 01:25:41 -0700 (PDT)
Date: Fri, 29 Jul 2016 13:55:37 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] kexec: (bugfix) mem_regions_sort()
Message-ID: <20160729082537.GA28046@localhost.localdomain>
References: <20160729082323.12253-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160729082323.12253-1-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: rmk@armlinux.org.uk, horms@verge.net.au, kexec@lists.infradead.org

On 29/07/2016:05:23:23 PM, AKASHI Takahiro wrote:
> The third argument of qsort() must be the size of each array element.

Yes, I had sent it day before yesterday which has been ACKed by Russell.

> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  kexec/mem_regions.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
> index e61c074..a8cb510 100644
> --- a/kexec/mem_regions.c
> +++ b/kexec/mem_regions.c
> @@ -24,7 +24,7 @@ static int mem_range_cmp(const void *a1, const void *a2)
>   */
>  void mem_regions_sort(struct memory_ranges *ranges)
>  {
> -	qsort(ranges->ranges, ranges->size, sizeof(ranges->ranges),
> +	qsort(ranges->ranges, ranges->size, sizeof(ranges->ranges[0]),
>  	      mem_range_cmp);
>  }
>  
> -- 
> 2.9.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

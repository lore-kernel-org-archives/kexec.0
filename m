Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bB3Pu-0001YU-ND
 for kexec@lists.infradead.org; Thu, 09 Jun 2016 17:06:51 +0000
Received: by mail-qg0-f49.google.com with SMTP id l44so22385839qgd.0
 for <kexec@lists.infradead.org>; Thu, 09 Jun 2016 10:06:30 -0700 (PDT)
Date: Thu, 9 Jun 2016 22:36:24 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] Remove "max" parameter comment
Message-ID: <20160609170624.GA28087@dhcppc6>
References: <20160608012257.GA28638@verge.net.au>
 <E1bB2em-0004ll-0u@e0050434b2927.dyn.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1bB2em-0004ll-0u@e0050434b2927.dyn.armlinux.org.uk>
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
To: Russell King <rmk@armlinux.org.uk>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>

On 09/06/2016:05:18:08 PM, Russell King wrote:
> Remove the "max" parameter in the documentation for mem_regions_add()
> 
> Signed-off-by: Russell King <rmk@armlinux.org.uk>
Reviewed-by: Pratyush Anand <panand@redhat.com> 
> ---
>  kexec/mem_regions.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
> index b01a5c89..e61c0747 100644
> --- a/kexec/mem_regions.c
> +++ b/kexec/mem_regions.c
> @@ -31,7 +31,6 @@ void mem_regions_sort(struct memory_ranges *ranges)
>  /**
>   * mem_regions_add() - add a memory region to a set of ranges
>   * @ranges: ranges to add the memory region to
> - * @max: maximum number of entries in memory region
>   * @base: base address of memory region
>   * @length: length of memory region in bytes
>   * @type: type of memory region
> -- 
> 1.9.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3xnu-0003PL-02
 for kexec@lists.infradead.org; Fri, 28 Apr 2017 04:46:52 +0000
Date: Fri, 28 Apr 2017 12:46:19 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec: allocate buffer in top-down, if specified,
 correctly
Message-ID: <20170428044619.GA3600@dhcp-128-65.nay.redhat.com>
References: <20170426082209.12127-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170426082209.12127-1-takahiro.akashi@linaro.org>
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
Cc: bauerman@linux.vnet.ibm.com, kexec@lists.infradead.org, vgoyal@redhat.com, bhe@redhat.com, linux-kernel@vger.kernel.org

Hi AKASHI
On 04/26/17 at 05:22pm, AKASHI Takahiro wrote:
> The current kexec_locate_mem_hole(kbuf.top_down == 1) stops searching at
> the first memory region that has enough space for requested size even if
> some of higher regions may also have.
> This behavior is not consistent with locate_hole(hole_end == -1) function
> of kexec-tools.

Have you seen actual bug happened or just observing this during code
review?

Till now seems we do not see any reports about this.

> 
> This patch fixes the bug, going though all the memory regions anyway.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  kernel/kexec_file.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index b118735fea9d..2f131c0d9017 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -373,8 +373,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  	/* If we are here, we found a suitable memory range */
>  	kbuf->mem = temp_start;
>  
> -	/* Success, stop navigating through remaining System RAM ranges */
> -	return 1;
> +	/* always return zero, going through all the System RAM ranges */
> +	return 0;
>  }
>  
>  static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
> @@ -439,18 +439,27 @@ static int locate_mem_hole_callback(u64 start, u64 end, void *arg)
>   *
>   * Return: The memory walk will stop when func returns a non-zero value
>   * and that value will be returned. If all free regions are visited without
> - * func returning non-zero, then zero will be returned.
> + * func returning non-zero, then kbuf->mem will be additionally checked
> + * for top-down search.
> + * After all, zero will be returned if none of regions fits.
>   */
>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
>  			       int (*func)(u64, u64, void *))
>  {
> +	int ret;
> +
> +	kbuf->mem = 0;
>  	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> -		return walk_iomem_res_desc(crashk_res.desc,
> +		ret = walk_iomem_res_desc(crashk_res.desc,
>  					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
>  					   crashk_res.start, crashk_res.end,
>  					   kbuf, func);
>  	else
> -		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
> +		ret = walk_system_ram_res(0, ULONG_MAX, kbuf, func);
> +
> +	if (!ret && kbuf->mem)
> +		ret = 1; /* found for top-down search */
> +	return ret;
>  }
>  
>  /**
> -- 
> 2.11.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

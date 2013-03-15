Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGNCK-0005AD-HD
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 05:28:57 +0000
Date: Fri, 15 Mar 2013 14:17:15 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: fix missing count of filtered free pages
Message-Id: <20130315141715.94cdf3da2079adfd44141367@mxc.nes.nec.co.jp>
In-Reply-To: <20130314.165415.412290566.d.hatayama@jp.fujitsu.com>
References: <20130314.165415.412290566.d.hatayama@jp.fujitsu.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

On Thu, 14 Mar 2013 16:54:15 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> On the current implementation, __exclude_unnecessary_pages() can refer
> to page frames not belonging to current cycle. Thus, pfn_free can be
> now counted up even if it doesn't belong to the current cycle.
> 
> This patch changes it so pfn_free is counted up only if the
> corresponding pfn really belongs to the cycle.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>

Thanks, applied.

Atsushi Kumagai

> ---
>  makedumpfile.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index acb1b21..817da34 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -4224,9 +4224,9 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  				 * See check_cyclic_buffer_overrun()
>  				 * for the detail.
>  				 */
> -				clear_bit_on_2nd_bitmap_for_kernel(pfn + i);
> +				if (clear_bit_on_2nd_bitmap_for_kernel(pfn + i))
> +					pfn_free++;
>  			}
> -			pfn_free += i;
>  		}
>  		/*
>  		 * Exclude the cache page without the private page.
> -- 
> 1.7.7.6
> 
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

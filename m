Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGNBZ-00057b-8U
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 05:28:09 +0000
Date: Fri, 15 Mar 2013 14:16:49 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: skip multiple pages filtered as free pages
Message-Id: <20130315141649.71df81b6eaa73f43041ddd31@mxc.nes.nec.co.jp>
In-Reply-To: <20130315.003635.427739264.d.hatayama@jp.fujitsu.com>
References: <20130315.003635.427739264.d.hatayama@jp.fujitsu.com>
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

On Fri, 15 Mar 2013 00:36:35 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> If buddy page has order n, (2^n) pages are filtered at the same
> time. Then, next (2^n) pages are already filterd, so we can skip the
> (2^n) pages for free.
> 
> By this, on 32GB memory system, there's the following improvement:
> 
> - with mmap() on /proc/vmcore from 0.594421 seconds to 0.496517
>   seconds, and
> - with normal read() from 1.533796 seconds to 0.750935 seconds.
> 
> Note that the two improvements are measured on the same /proc/vmcore.
> 
> Note also that amount of the improvement depends on amount of free
> pages, though it's obvious.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>

Good ! Applied.


Thanks
Atsushi Kumagai

> ---
>  makedumpfile.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 7acbf72..9075f38 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -4303,9 +4303,9 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  		    && info->flag_cyclic
>  		    && info->page_is_buddy
>  		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
> -			int i;
> +			int i, nr_pages = 1 << private;
>  
> -			for (i = 0; i < (1 << private); ++i) {
> +			for (i = 0; i < nr_pages; ++i) {
>  				/*
>  				 * According to combination of
>  				 * MAX_ORDER and size of cyclic
> @@ -4318,6 +4318,9 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  				clear_bit_on_2nd_bitmap_for_kernel(pfn + i);
>  			}
>  			pfn_free += i;
> +
> +			pfn += nr_pages - 1;
> +			mem_map += (nr_pages - 1) * SIZE(page);
>  		}
>  		/*
>  		 * Exclude the cache page without the private page.
> -- 
> 1.8.1.4
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

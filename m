Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYBN1-0000jA-W3
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 07:57:22 +0000
Date: Tue, 13 Nov 2012 16:56:00 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 10/10] Print warning about cyclic buffer overrun if it
 can happen
Message-Id: <20121113165600.09afdc35534c6fbf3905b289@mxc.nes.nec.co.jp>
In-Reply-To: <20121108094900.30421.54675.stgit@localhost6.localdomain6>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
 <20121108094900.30421.54675.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hello HATAYAMA-san,

On Thu, 08 Nov 2012 18:49:00 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> Clearling bits on cyclic buffer can overrun the cyclic buffer
> according to some combination of MAX_ORDER and cyclic buffer size.
> 
> This patch warns this possibility but continues processing.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---

Thank you for pointing it out.

v1.5.1-rc will calculate the cyclic buffer size automatically and this
issue can happen even if MAX_ORDER is 11, so this patch is useful.

I'll try to resolve this issue essentially in v1.5.2.


Thanks
Atsushi Kumagai

> 
>  makedumpfile.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 47 insertions(+), 1 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index d1efc09..98eb640 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -58,6 +58,7 @@ do { \
>  		*ptr_long_table = value; \
>  } while (0)
>  
> +static void check_cyclic_buffer_overrun(void);
>  static void setup_page_is_buddy(void);
>  
>  void
> @@ -2806,6 +2807,9 @@ out:
>  		    !sadump_generate_elf_note_from_dumpfile())
>  			return FALSE;
>  
> +		if (info->flag_cyclic && info->dump_level & DL_EXCLUDE_FREE)
> +			check_cyclic_buffer_overrun();
> +
>  	} else {
>  		if (!get_mem_map_without_mm())
>  			return FALSE;
> @@ -3642,6 +3646,38 @@ exclude_free_page(void)
>  	return TRUE;
>  }
>  
> +static void
> +check_cyclic_buffer_overrun(void)
> +{
> +	int max_order = ARRAY_LENGTH(zone.free_area);
> +	int max_order_nr_pages = 1 << (max_order - 1);
> +
> +	/*
> +	 * Let C be a cyclic buffer size and B a bitmap size used for
> +	 * representing maximum block size managed by buddy
> +	 * allocator. Then, if C mod B != 0, i.e., if there exists n >
> +	 * 0, B > b > 0 such that C = n x B + b, then clearing
> +	 * operation overruns cyclic buffer (B - b)-bytes.
> +	 *
> +	 * The bitmap size used for maximum block size B is calculated
> +	 * from MAX_ORDER as:
> +	 *
> +	 *   B := ROUND_UP((1 << (MAX_ORDER - 1)), / BITS_PER_BYTE)
> +	 *
> +	 * Normally, MAX_ORDER is 11 at default. This is configurable
> +	 * through CONFIG_FORCE_MAX_ZONEORDER.
> +	 *
> +	 * Note that If MAX_ORDER is default 11, this overrun issue
> +	 * never happens. First, if MAX_ORDER is 11, B is 128
> +	 * bytes. Cyclic buffer size is always specified in kilobytes,
> +	 * i.e. C = 1024 x c for some c > 0. Hence, C mod B = 0
> +	 * because 1024 mod 128 = 0.
> +	 */
> +	if (info->bufsize_cyclic %
> +	    roundup(max_order_nr_pages, BITPERBYTE))
> +		MSG("Some free pages are not filtered.\n");
> +}
> +
>  /*
>   * For the kernel versions from v2.6.15 to v2.6.17.
>   */
> @@ -3978,8 +4014,18 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
>  			int i;
>  
> -			for (i = 0; i < (1 << private); ++i)
> +			for (i = 0; i < (1 << private); ++i) {
> +				/*
> +				 * According to combination of
> +				 * MAX_ORDER and size of cyclic
> +				 * buffer, this clearing bit operation
> +				 * can overrun the cyclic buffer.
> +				 *
> +				 * See check_cyclic_buffer_overrun()
> +				 * for the detail.
> +				 */
>  				clear_bit_on_2nd_bitmap_for_kernel(pfn + i);
> +			}
>  			pfn_free += i;
>  		}
>  		/*
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

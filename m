Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by casper.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WXLAc-0002jA-6n
 for kexec@lists.infradead.org; Tue, 08 Apr 2014 01:49:52 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id DF2CB3EE0F1
 for <kexec@lists.infradead.org>; Tue,  8 Apr 2014 10:49:18 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 12D5045DEB4
 for <kexec@lists.infradead.org>; Tue,  8 Apr 2014 10:49:18 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id E7B2C45DEB9
 for <kexec@lists.infradead.org>; Tue,  8 Apr 2014 10:49:17 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id DB7361DB803B
 for <kexec@lists.infradead.org>; Tue,  8 Apr 2014 10:49:17 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7D0A81DB8037
 for <kexec@lists.infradead.org>; Tue,  8 Apr 2014 10:49:17 +0900 (JST)
Date: Tue, 08 Apr 2014 10:49:07 +0900 (JST)
Message-Id: <20140408.104907.132144009.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2 2/3] Generic handling of multi-page exclusions
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <25702884512808755449395c1622f2aed7b3be00.1396632131.git.ptesarik@suse.cz>
References: <cover.1396632131.git.ptesarik@suse.cz>
 <25702884512808755449395c1622f2aed7b3be00.1396632131.git.ptesarik@suse.cz>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: ptesarik@suse.cz
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH v2 2/3] Generic handling of multi-page exclusions
Date: Fri, 4 Apr 2014 19:25:08 +0200

> When multiple pages are excluded from the dump, store the extents in the
> mem_map_data structure, and check if anything is still pending on the
> next invocation of __exclude_unnecessary_pages for the same mem_map.
> 
> The start PFN of the excluded extent is set to the end of the current
> cycle (which is equal to the start of the next cycle, see update_cycle),
> so only the part of the excluded region which falls beyond current cycle
> buffer is valid. If the excluded region is completely processed in the
> current cycle, the start PFN is even bigger than the end PFN. That
> causes nothing to be done at the beginning of the next cycle.
> 
> There is no check whether the adjusted pfn_start is still within the
> current cycle. Nothing bad happens if it isn't, because exclude_range()
> is used again to exclude the remaining part, so even if the excluded
> region happens to span more than two cycles, the code will still work
> correctly.
> 
> Note that clear_bit_on_2nd_bitmap_for_kernel() accepts PFNs outside the
> current cyclic range. It willreturn FALSE, so such PFNs are not counted.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
> ---
>  makedumpfile.c | 47 +++++++++++++++++++++++++++++++++--------------
>  makedumpfile.h |  7 +++++++
>  2 files changed, 40 insertions(+), 14 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 81c687b..9ffb901 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -2385,6 +2385,9 @@ dump_mem_map(unsigned long long pfn_start,
>  	mmd->pfn_end   = pfn_end;
>  	mmd->mem_map   = mem_map;
>  
> +	mmd->exclude_pfn_start = 0ULL;
> +	mmd->exclude_pfn_end   = 0ULL;
> +
>  	DEBUG_MSG("mem_map (%d)\n", num_mm);
>  	DEBUG_MSG("  mem_map    : %lx\n", mem_map);
>  	DEBUG_MSG("  pfn_start  : %llx\n", pfn_start);
> @@ -4657,6 +4660,21 @@ initialize_2nd_bitmap_cyclic(struct cycle *cycle)
>  	return TRUE;
>  }
>  
> +static void
> +exclude_range(unsigned long long *counter, struct mem_map_data *mmd,
> +    unsigned long long pfn, unsigned long long endpfn, struct cycle *cycle)
> +{
> +	while (pfn < endpfn) {
> +		if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
> +			(*counter)++;
> +		++pfn;
> +	}

Here endpfn is pfn + nr_pages in __exclude_unnecessary_pages(), and
the pfn could be cycle->end_pfn <= pfn < endpfn.

while (pfn < MIN(endpfn, cycle->end_pfn) {
	if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
		(*counter)++;
	++pfn;
}

> +
> +	mmd->exclude_pfn_start = cycle ? cycle->end_pfn : ULONGLONG_MAX;

When does cycle become NULL?

Along with the above point,

mmd->exclude_pfn_start = MIN(endpfn, cycle->end_pfn);

and then we can continue the processing in the next cycle.

> +	mmd->exclude_pfn_end = endpfn;
> +	mmd->exclude_pfn_counter = counter;
> +}
> +
>  int
>  __exclude_unnecessary_pages(struct mem_map_data *mmd, struct cycle *cycle)
>  {
> @@ -4671,6 +4689,18 @@ __exclude_unnecessary_pages(struct mem_map_data *mmd, struct cycle *cycle)
>  	unsigned long flags, mapping, private = 0;
>  
>  	/*
> +	 * If a multi-page exclusion is pending, do it first
> +	 */
> +	if (mmd->exclude_pfn_start < mmd->exclude_pfn_end) {
> +		exclude_range(mmd->exclude_pfn_counter, mmd,
> +			mmd->exclude_pfn_start, mmd->exclude_pfn_end,
> +			cycle);
> +
> +		mem_map += (mmd->exclude_pfn_end - pfn_start) * SIZE(page);
> +		pfn_start = mmd->exclude_pfn_end;
> +	}
> +
> +	/*
>  	 * Refresh the buffer of struct page, when changing mem_map.
>  	 */
>  	pfn_read_start = ULONGLONG_MAX;
> @@ -4734,21 +4764,10 @@ __exclude_unnecessary_pages(struct mem_map_data *mmd, struct cycle *cycle)
>  		if ((info->dump_level & DL_EXCLUDE_FREE)
>  		    && info->page_is_buddy
>  		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
> -			int i, nr_pages = 1 << private;
> +			int nr_pages = 1 << private;
> +
> +			exclude_range(&pfn_free, mmd, pfn, pfn + nr_pages, cycle);
>  
> -			for (i = 0; i < nr_pages; ++i) {
> -				/*
> -				 * According to combination of
> -				 * MAX_ORDER and size of cyclic
> -				 * buffer, this clearing bit operation
> -				 * can overrun the cyclic buffer.
> -				 *
> -				 * See check_cyclic_buffer_overrun()
> -				 * for the detail.
> -				 */
> -				if (clear_bit_on_2nd_bitmap_for_kernel((pfn + i), cycle))
> -					pfn_free++;
> -			}
>  			pfn += nr_pages - 1;
>  			mem_map += (nr_pages - 1) * SIZE(page);
>  		}
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 951ed1b..dfad569 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -816,6 +816,13 @@ struct mem_map_data {
>  	unsigned long long	pfn_start;
>  	unsigned long long	pfn_end;
>  	unsigned long	mem_map;
> +
> +	/*
> +	 * for excluding multi-page regions
> +	 */
> +	unsigned long		exclude_pfn_start;
> +	unsigned long		exclude_pfn_end;

unsigned long long		exclude_pfn_start;
unsigned long long		exclude_pfn_end;

The integers representing page frame numbers need to be defined as
unsigned long long for architectures where physical address can have
64-bit length but unsigned long has 32-bit only, such as x86 PAE.

Kumagai-san, I saw this sometimes in the past. How about introducing
specific abstract type for page frame number like below?

typedef unsigned long long pfn_t;

maybe with some prefix. I think this also helps code readability
because unsigned long long is too long.

> +	unsigned long long	*exclude_pfn_counter;
>  };

Also, it seems to me better to introduce a new type for this
processing rather than extending existing code. struct mem_map_data is
not specific for the excluding processing.


Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

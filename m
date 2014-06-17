Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WwmzA-0004xK-1B
 for kexec@lists.infradead.org; Tue, 17 Jun 2014 06:35:13 +0000
Date: Tue, 17 Jun 2014 08:34:47 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v2] makedumpfile: Exclude unnecessary hugepages.
Message-ID: <20140617083447.166244e5@hananiah.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9722301C@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9722301C@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, 17 Jun 2014 02:32:51 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> Hello,
> 
> This is the v2 patch for hugepage filtering rebased on Petr's
> "Generic multi-page exclusion", thanks Petr.
> 
> The current kernel's VMCOREINFO doesn't include necessary values
> for this patch, so we need "-x vmlinux" to enable hugepage filtering.
> I tested this patch on kernel 3.13.
> 
> Regarding this, Petr made effort to add the values to VMCOREINFO,
> but it looks suspended:
> 
>   https://lkml.org/lkml/2014/4/11/349

Actually, I received an Acked-by from Vivek last Wednesday. Oh, wait a
moment, this email went to Andrew Morton, but not to any mailing
list. :-(

> So, we should resume this discussion for this patch. Then,
> I should modify this patch to use PG_head_mask if it's accepted.

I have already experimented with hugepage filtering, but haven't sent
my patches yet, precisely because they depend on a not-yet-confirmed
feature in the kernel.

Anyway, let's take your patch as base. I'll add my comments where I
believe my approach was better/cleaner.

> Thanks
> Atsushi Kumagai
> 
> 
> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Date: Tue, 17 Jun 2014 08:59:44 +0900
> Subject: [PATCH v2] Exclude unnecessary hugepages.
> 
> There are 2 types of hugepages in the kernel, the both should be
> excluded as user pages.
> 
> 1. Transparent huge pages (THP)
> All the pages are anonymous pages (at least for now), so we should
> just get how many pages are in the corresponding hugepage.
> It can be gotten from the page->lru.prev of the second page in the
> hugepage.
> 
> 2. Hugetlbfs pages
> The pages aren't anonymous pages but kind of user pages, we should
> exclude also these pages in any way.
> Luckily, it's possible to detect these pages by looking the
> page->lru.next of the second page in the hugepage. This idea came
> from the kernel's PageHuge().

Good point! My patch didn't take care of hugetlbfs pages.

> The number of pages can be gotten in the same way as THP.
> 
> Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> ---
>  makedumpfile.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  makedumpfile.h |   8 ++++
>  2 files changed, 120 insertions(+), 5 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 34db997..d170c54 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -92,6 +92,7 @@ do { \
>  } while (0)
>  
>  static void setup_page_is_buddy(void);
> +static void setup_page_is_hugepage(void);
>  
>  void
>  initialize_tables(void)
> @@ -328,6 +329,18 @@ update_mmap_range(off_t offset, int initial) {
>  }
>  
>  static int
> +page_is_hugepage(unsigned long flags) {
> +	if (NUMBER(PG_head) != NOT_FOUND_NUMBER) {
> +		return isHead(flags);
> +	} else if (NUMBER(PG_tail) != NOT_FOUND_NUMBER) {
> +		return isTail(flags);
> +	}if (NUMBER(PG_compound) != NOT_FOUND_NUMBER) {
> +		return isCompound(flags);
> +	}
> +	return 0;
> +}
> +
> +static int

Since it looks like we'll get the mask in VMCOREINFO, I'd rather use
the mask, and construct it from PG_* flags if there's no VMCOREINFO.
I add long PG_head_mask to struct number_table, define this macro:

#define isCompoundHead(flags)  (!!((flags) & NUMBER(PG_head_mask)))

Then I initialize it in get_structure_info like this:

	PG_head = get_enum_number("PG_head");
	if (PG_head == FAILED_DWARFINFO) {
		PG_head = get_enum_number("PG_compound");
		if (PG_head == FAILED_DWARFINFO)
			return FALSE;
	}
	NUMBER(PG_head_mask) = 1L << PG_head;

with a fallback in get_value_for_old_linux:

	if (NUMBER(PG_head_mask) == NOT_FOUND_NUMBER)
		NUMBER(PG_head_mask) = 1L << PG_compound_ORIGINAL;

Also, I prefer to write PG_head_mask to the makedumpfile-generated
VMCOREINFO, so it will have the same fields as the kernel-generated
VMCOREINFO.

>  is_mapped_with_mmap(off_t offset) {
>  
>  	if (info->flag_usemmap == MMAP_ENABLE
> @@ -1180,6 +1193,7 @@ get_symbol_info(void)
>  	SYMBOL_INIT(vmemmap_list, "vmemmap_list");
>  	SYMBOL_INIT(mmu_psize_defs, "mmu_psize_defs");
>  	SYMBOL_INIT(mmu_vmemmap_psize, "mmu_vmemmap_psize");
> +	SYMBOL_INIT(free_huge_page, "free_huge_page");
>  
>  	return TRUE;
>  }
> @@ -1288,11 +1302,19 @@ get_structure_info(void)
>  
>  	ENUM_NUMBER_INIT(PG_lru, "PG_lru");
>  	ENUM_NUMBER_INIT(PG_private, "PG_private");
> +	ENUM_NUMBER_INIT(PG_head, "PG_head");
> +	ENUM_NUMBER_INIT(PG_tail, "PG_tail");
> +	ENUM_NUMBER_INIT(PG_compound, "PG_compound");
>  	ENUM_NUMBER_INIT(PG_swapcache, "PG_swapcache");
>  	ENUM_NUMBER_INIT(PG_buddy, "PG_buddy");
>  	ENUM_NUMBER_INIT(PG_slab, "PG_slab");
>  	ENUM_NUMBER_INIT(PG_hwpoison, "PG_hwpoison");
>  
> +	if (NUMBER(PG_head) == NOT_FOUND_NUMBER &&
> +	    NUMBER(PG_compound) == NOT_FOUND_NUMBER)
> +		/* Pre-2.6.26 kernels did not have pageflags */
> +		NUMBER(PG_compound) = PG_compound_ORIGINAL;
> +
>  	ENUM_TYPE_SIZE_INIT(pageflags, "pageflags");
>  
>  	TYPEDEF_SIZE_INIT(nodemask_t, "nodemask_t");
> @@ -1694,6 +1716,7 @@ write_vmcoreinfo_data(void)
>  	WRITE_SYMBOL("vmemmap_list", vmemmap_list);
>  	WRITE_SYMBOL("mmu_psize_defs", mmu_psize_defs);
>  	WRITE_SYMBOL("mmu_vmemmap_psize", mmu_vmemmap_psize);
> +	WRITE_SYMBOL("free_huge_page", free_huge_page);
>  
>  	/*
>  	 * write the structure size of 1st kernel
> @@ -1783,6 +1806,9 @@ write_vmcoreinfo_data(void)
>  
>  	WRITE_NUMBER("PG_lru", PG_lru);
>  	WRITE_NUMBER("PG_private", PG_private);
> +	WRITE_NUMBER("PG_head", PG_head);
> +	WRITE_NUMBER("PG_tail", PG_tail);
> +	WRITE_NUMBER("PG_compound", PG_compound);
>  	WRITE_NUMBER("PG_swapcache", PG_swapcache);
>  	WRITE_NUMBER("PG_buddy", PG_buddy);
>  	WRITE_NUMBER("PG_slab", PG_slab);
> @@ -2033,6 +2059,7 @@ read_vmcoreinfo(void)
>  	READ_SYMBOL("vmemmap_list", vmemmap_list);
>  	READ_SYMBOL("mmu_psize_defs", mmu_psize_defs);
>  	READ_SYMBOL("mmu_vmemmap_psize", mmu_vmemmap_psize);
> +	READ_SYMBOL("free_huge_page", free_huge_page);
>  
>  	READ_STRUCTURE_SIZE("page", page);
>  	READ_STRUCTURE_SIZE("mem_section", mem_section);
> @@ -2109,6 +2136,9 @@ read_vmcoreinfo(void)
>  
>  	READ_NUMBER("PG_lru", PG_lru);
>  	READ_NUMBER("PG_private", PG_private);
> +	READ_NUMBER("PG_head", PG_head);
> +	READ_NUMBER("PG_tail", PG_tail);
> +	READ_NUMBER("PG_compound", PG_compound);
>  	READ_NUMBER("PG_swapcache", PG_swapcache);
>  	READ_NUMBER("PG_slab", PG_slab);
>  	READ_NUMBER("PG_buddy", PG_buddy);
> @@ -3283,6 +3313,9 @@ out:
>  	if (!get_value_for_old_linux())
>  		return FALSE;
>  
> +	/* Get page flags for compound pages */
> +	setup_page_is_hugepage();
> +
>  	/* use buddy identification of free pages whether cyclic or not */
>  	/* (this can reduce pages scan of 1TB memory from 60sec to 30sec) */
>  	if (info->dump_level & DL_EXCLUDE_FREE)
> @@ -4346,6 +4379,24 @@ out:
>  			  "follow free lists instead of mem_map array.\n");
>  }
>  
> +static void
> +setup_page_is_hugepage(void)
> +{
> +	if (NUMBER(PG_head) != NOT_FOUND_NUMBER) {
> +		if (NUMBER(PG_tail) == NOT_FOUND_NUMBER) {
> +			/*
> +			 * If PG_tail is not explicitly saved, then assume
> +			 * that it immediately follows PG_head.
> +			 */
> +			NUMBER(PG_tail) = NUMBER(PG_head) + 1;
> +		}
> +	} else if ((NUMBER(PG_compound) != NOT_FOUND_NUMBER)
> +		   && (info->dump_level & DL_EXCLUDE_USER_DATA)) {
> +		MSG("Compound page bit could not be determined: ");
> +		MSG("huge pages will NOT be filtered.\n");
> +	}
> +}
> +
>  /*
>   * If using a dumpfile in kdump-compressed format as a source file
>   * instead of /proc/vmcore, 1st-bitmap of a new dumpfile must be
> @@ -4660,8 +4711,9 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  	mdf_pfn_t pfn_read_start, pfn_read_end;
>  	unsigned char page_cache[SIZE(page) * PGMM_CACHED];
>  	unsigned char *pcache;
> -	unsigned int _count, _mapcount = 0;
> +	unsigned int _count, _mapcount = 0, compound_order = 0;
>  	unsigned long flags, mapping, private = 0;
> +	unsigned long hugetlb_dtor;
>  
>  	/*
>  	 * If a multi-page exclusion is pending, do it first
> @@ -4727,6 +4779,27 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  		flags   = ULONG(pcache + OFFSET(page.flags));
>  		_count  = UINT(pcache + OFFSET(page._count));
>  		mapping = ULONG(pcache + OFFSET(page.mapping));
> +
> +		if (index_pg < PGMM_CACHED - 1) {
> +			compound_order = ULONG(pcache + SIZE(page) + OFFSET(page.lru)
> +					       + OFFSET(list_head.prev));
> +			hugetlb_dtor = ULONG(pcache + SIZE(page) + OFFSET(page.lru)
> +					     + OFFSET(list_head.next));
> +		} else if (pfn + 1 < pfn_end) {

AFAICS this clause is not needed. All compound pages are aligned to its
page order, e.g. the head page of an order-2 compound page is aligned
to a multiple of 4. Since mem_map cache is aligned to PGMM_CACHED,
which is defined as 512 (that is power of 2), a compound page cannot
possibly start on the last PFN of the cache.

I even added a sanity check for the alignment:

			if (order && order < sizeof(unsigned long) * 8 &&
			    (pfn & ((1UL << order) - 1)) == 0)

Ok, the "order" above corresponds to your "compound_order"...

> +			unsigned char page_cache_next[SIZE(page)];
> +			if (!readmem(VADDR, mem_map, page_cache_next, SIZE(page))) {
> +				ERRMSG("Can't read the buffer of struct page.\n");
> +				return FALSE;
> +			}
> +			compound_order = ULONG(page_cache_next + OFFSET(page.lru)
> +					       + OFFSET(list_head.prev));
> +			hugetlb_dtor = ULONG(page_cache_next + OFFSET(page.lru)
> +					     + OFFSET(list_head.next));
> +		} else {
> +			compound_order = 0;
> +			hugetlb_dtor = 0;
> +		}
> +
>  		if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
>  			_mapcount = UINT(pcache + OFFSET(page._mapcount));
>  		if (OFFSET(page.private) != NOT_FOUND_STRUCTURE)
> @@ -4754,6 +4827,10 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  		    && !isPrivate(flags) && !isAnon(mapping)) {
>  			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
>  				pfn_cache++;
> +			/*
> +			 * NOTE: If THP for cache is introduced, the check for
> +			 *       compound pages is needed here.
> +			 */

I do this differently. I added:

		mdf_pfn_t *pfn_counter

Then I set pfn_counter to the appropriate counter, but do not call
clear_bit_on_2nd_bitmap_for_kernel(). At the end of the long
if-else-if-else-if statement I add a final else-clause:

		/*
		 * Page not excluded
		 */
		else
			continue;

If execution gets here, the page is excluded, so I can do:

		if (nr_pages == 1) {
			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
				(*pfn_counter)++;
		} else {
			exclude_range(pfn_counter, pfn, pfn + nr_pages, cycle);
		}

What do you think?

Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XS1Gc-0001ho-VS
 for kexec@lists.infradead.org; Thu, 11 Sep 2014 10:06:20 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v4] makedumpfile: Exclude unnecessary hugepages.
Date: Thu, 11 Sep 2014 10:04:11 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97254E06@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9724E000@BPXM01GP.gisp.nec.co.jp>
 <20140910073424.GD25867@dhcp-16-116.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97254CF9@BPXM01GP.gisp.nec.co.jp>
 <20140911092406.GB4411@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20140911092406.GB4411@dhcp-16-116.nay.redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On 09/11/14 at 08:52am, Atsushi Kumagai wrote:
>> >Hi Atsushi,
>> >
>> >Since huge pages are included in user pages, I can't think of a way to
>> >make test cases for huge page exclusion. Could you give some suggestions
>> >on this or how did you test it?
>>
>> Before I posted this patch, I tested as below.
>> This idea came from the fact that old makedumpfile can't exclude
>> huge pages except the first page(PG_head).
>>
>>    1. Get the number of hugepages from /proc/meminfo
>>    2. Calculate the number of PG_tail pages
>>    3. Capture the dumpfile without filtering
>>    4. Run makedumpfile and compare the report message between v1.5.6
>>       and v1.5.7(rc) to get how many user pages become excludable with
>>       this patch.
>>    5. The result of Step2's and Step4's must be same, confirm it.
>>
>> The way above is for THP but you can apply it also for hugetlbfs
>> if you take care of the things that old makedumpfile can't exclude
>> *any* hugetlbfs pages.
>
>But THP is also Anonymous pages, doesn't it do the same for THP between
>1.5.6 and 1.5.7?

Only a PG_head page is marked as an anonymous page, makedumpfile doesn't
distinguish PG_tail pages as anonymous pages. Please see below.

  do_huge_pmd_anonymous_page()
    + __do_huge_pmd_anonymous_page()
      + page_add_new_anon_rmap()
        + __page_set_anon_rmap()


Thanks
Atsushi Kumagai

>>
>> I recommend to separate the two cases completely by enabling either
>> THP or hugetlbfs explicitly since it's easier to confirm the results.
>
>For hugeTlbfs, this works, I will try this.
>
>>
>>
>> Thanks
>> Atsushi Kumagai
>>
>> >
>> >Thanks
>> >Baoquan
>> >
>> >
>> >On 08/20/14 at 07:27am, Atsushi Kumagai wrote:
>> >> There are 2 types of hugepages in the kernel, the both should be
>> >> excluded as user pages.
>> >>
>> >> 1. Transparent huge pages (THP)
>> >> All the pages are anonymous pages (at least for now), so we should
>> >> just get how many pages are in the corresponding hugepage.
>> >> It can be gotten from the page->lru.prev of the second page in the
>> >> hugepage.
>> >>
>> >> 2. Hugetlbfs pages
>> >> The pages aren't anonymous pages but kind of user pages, we should
>> >> exclude also these pages in any way.
>> >> Luckily, it's possible to detect these pages by looking the
>> >> page->lru.next of the second page in the hugepage. This idea came
>> >> from the kernel's PageHuge().
>> >> The number of pages can be gotten in the same way as THP.
>> >>
>> >> Changelog:
>> >> v4:
>> >>   - Cleaned up according to Petr's and Baoquan's comments.
>> >> v3:
>> >>   - Cleaned up according to Petr's comments.
>> >>   - Fix misdetection of hugetlb pages.
>> >> v2:
>> >>   - Rebased to "Generic multi-page exclusion".
>> >>
>> >> Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>> >> ---
>> >>  makedumpfile.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++----------
>> >>  makedumpfile.h |  7 +++++
>> >>  2 files changed, 78 insertions(+), 15 deletions(-)
>> >>
>> >> diff --git a/makedumpfile.c b/makedumpfile.c
>> >> index 11cd473..b4b6eca 100644
>> >> --- a/makedumpfile.c
>> >> +++ b/makedumpfile.c
>> >> @@ -1180,6 +1180,7 @@ get_symbol_info(void)
>> >>  	SYMBOL_INIT(vmemmap_list, "vmemmap_list");
>> >>  	SYMBOL_INIT(mmu_psize_defs, "mmu_psize_defs");
>> >>  	SYMBOL_INIT(mmu_vmemmap_psize, "mmu_vmemmap_psize");
>> >> +	SYMBOL_INIT(free_huge_page, "free_huge_page");
>> >>
>> >>  	SYMBOL_INIT(cpu_pgd, "cpu_pgd");
>> >>  	SYMBOL_INIT(demote_segment_4k, "demote_segment_4k");
>> >> @@ -1296,6 +1297,15 @@ get_structure_info(void)
>> >>  	ENUM_NUMBER_INIT(PG_slab, "PG_slab");
>> >>  	ENUM_NUMBER_INIT(PG_hwpoison, "PG_hwpoison");
>> >>
>> >> +	ENUM_NUMBER_INIT(PG_head_mask, "PG_head_mask");
>> >> +	if (NUMBER(PG_head_mask) == NOT_FOUND_NUMBER) {
>> >> +		ENUM_NUMBER_INIT(PG_head, "PG_head");
>> >> +		if (NUMBER(PG_head) == NOT_FOUND_NUMBER)
>> >> +			ENUM_NUMBER_INIT(PG_head, "PG_compound");
>> >> +		if (NUMBER(PG_head) != NOT_FOUND_NUMBER)
>> >> +			NUMBER(PG_head_mask) = 1UL << NUMBER(PG_head);
>> >> +	}
>> >> +
>> >>  	ENUM_TYPE_SIZE_INIT(pageflags, "pageflags");
>> >>
>> >>  	TYPEDEF_SIZE_INIT(nodemask_t, "nodemask_t");
>> >> @@ -1530,6 +1540,9 @@ get_value_for_old_linux(void)
>> >>  		NUMBER(PG_swapcache) = PG_swapcache_ORIGINAL;
>> >>  	if (NUMBER(PG_slab) == NOT_FOUND_NUMBER)
>> >>  		NUMBER(PG_slab) = PG_slab_ORIGINAL;
>> >> +	if (NUMBER(PG_head_mask) == NOT_FOUND_NUMBER)
>> >> +		NUMBER(PG_head_mask) = 1L << PG_compound_ORIGINAL;
>> >> +
>> >>  	/*
>> >>  	 * The values from here are for free page filtering based on
>> >>  	 * mem_map array. These are minimum effort to cover old
>> >> @@ -1699,6 +1712,7 @@ write_vmcoreinfo_data(void)
>> >>  	WRITE_SYMBOL("mmu_vmemmap_psize", mmu_vmemmap_psize);
>> >>  	WRITE_SYMBOL("cpu_pgd", cpu_pgd);
>> >>  	WRITE_SYMBOL("demote_segment_4k", demote_segment_4k);
>> >> +	WRITE_SYMBOL("free_huge_page", free_huge_page);
>> >>
>> >>  	/*
>> >>  	 * write the structure size of 1st kernel
>> >> @@ -1788,6 +1802,7 @@ write_vmcoreinfo_data(void)
>> >>
>> >>  	WRITE_NUMBER("PG_lru", PG_lru);
>> >>  	WRITE_NUMBER("PG_private", PG_private);
>> >> +	WRITE_NUMBER("PG_head_mask", PG_head_mask);
>> >>  	WRITE_NUMBER("PG_swapcache", PG_swapcache);
>> >>  	WRITE_NUMBER("PG_buddy", PG_buddy);
>> >>  	WRITE_NUMBER("PG_slab", PG_slab);
>> >> @@ -2040,6 +2055,7 @@ read_vmcoreinfo(void)
>> >>  	READ_SYMBOL("mmu_vmemmap_psize", mmu_vmemmap_psize);
>> >>  	READ_SYMBOL("cpu_pgd", cpu_pgd);
>> >>  	READ_SYMBOL("demote_segment_4k", demote_segment_4k);
>> >> +	READ_SYMBOL("free_huge_page", free_huge_page);
>> >>
>> >>  	READ_STRUCTURE_SIZE("page", page);
>> >>  	READ_STRUCTURE_SIZE("mem_section", mem_section);
>> >> @@ -2116,6 +2132,7 @@ read_vmcoreinfo(void)
>> >>
>> >>  	READ_NUMBER("PG_lru", PG_lru);
>> >>  	READ_NUMBER("PG_private", PG_private);
>> >> +	READ_NUMBER("PG_head_mask", PG_head_mask);
>> >>  	READ_NUMBER("PG_swapcache", PG_swapcache);
>> >>  	READ_NUMBER("PG_slab", PG_slab);
>> >>  	READ_NUMBER("PG_buddy", PG_buddy);
>> >> @@ -4643,13 +4660,16 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>> >>      mdf_pfn_t pfn_start, mdf_pfn_t pfn_end, struct cycle *cycle)
>> >>  {
>> >>  	mdf_pfn_t pfn;
>> >> +	mdf_pfn_t *pfn_counter;
>> >> +	mdf_pfn_t nr_pages;
>> >>  	unsigned long index_pg, pfn_mm;
>> >>  	unsigned long long maddr;
>> >>  	mdf_pfn_t pfn_read_start, pfn_read_end;
>> >>  	unsigned char page_cache[SIZE(page) * PGMM_CACHED];
>> >>  	unsigned char *pcache;
>> >> -	unsigned int _count, _mapcount = 0;
>> >> +	unsigned int _count, _mapcount = 0, compound_order = 0;
>> >>  	unsigned long flags, mapping, private = 0;
>> >> +	unsigned long compound_dtor;
>> >>
>> >>  	/*
>> >>  	 * If a multi-page exclusion is pending, do it first
>> >> @@ -4715,11 +4735,36 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>> >>  		flags   = ULONG(pcache + OFFSET(page.flags));
>> >>  		_count  = UINT(pcache + OFFSET(page._count));
>> >>  		mapping = ULONG(pcache + OFFSET(page.mapping));
>> >> +
>> >> +		if ((index_pg < PGMM_CACHED - 1) &&
>> >> +		    isCompoundHead(flags)) {
>> >> +			compound_order = ULONG(pcache + SIZE(page) + OFFSET(page.lru)
>> >> +					       + OFFSET(list_head.prev));
>> >> +			compound_dtor = ULONG(pcache + SIZE(page) + OFFSET(page.lru)
>> >> +					     + OFFSET(list_head.next));
>> >> +
>> >> +			if ((compound_order >= sizeof(unsigned long) * 8)
>> >> +			    || ((pfn & ((1UL << compound_order) - 1)) != 0)) {
>> >> +				/* Invalid order */
>> >> +				compound_order = 0;
>> >> +			}
>> >> +		} else {
>> >> +			/*
>> >> +			 * The last pfn of the mem_map cache must not be compound page
>> >> +			 * since all compound pages are aligned to its page order and
>> >> +			 * PGMM_CACHED is a power of 2.
>> >> +			 */
>> >> +			compound_order = 0;
>> >> +			compound_dtor = 0;
>> >> +		}
>> >> +
>> >>  		if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
>> >>  			_mapcount = UINT(pcache + OFFSET(page._mapcount));
>> >>  		if (OFFSET(page.private) != NOT_FOUND_STRUCTURE)
>> >>  			private = ULONG(pcache + OFFSET(page.private));
>> >>
>> >> +		nr_pages = 1 << compound_order;
>> >> +		pfn_counter = NULL;
>> >>  		/*
>> >>  		 * Exclude the free page managed by a buddy
>> >>  		 * Use buddy identification of free pages whether cyclic or not.
>> >> @@ -4727,12 +4772,8 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>> >>  		if ((info->dump_level & DL_EXCLUDE_FREE)
>> >>  		    && info->page_is_buddy
>> >>  		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
>> >> -			int nr_pages = 1 << private;
>> >> -
>> >> -			exclude_range(&pfn_free, pfn, pfn + nr_pages, cycle);
>> >> -
>> >> -			pfn += nr_pages - 1;
>> >> -			mem_map += (nr_pages - 1) * SIZE(page);
>> >> +			nr_pages = 1 << private;
>> >> +			pfn_counter = &pfn_free;
>> >>  		}
>> >>  		/*
>> >>  		 * Exclude the cache page without the private page.
>> >> @@ -4740,8 +4781,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>> >>  		else if ((info->dump_level & DL_EXCLUDE_CACHE)
>> >>  		    && (isLRU(flags) || isSwapCache(flags))
>> >>  		    && !isPrivate(flags) && !isAnon(mapping)) {
>> >> -			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
>> >> -				pfn_cache++;
>> >> +			pfn_counter = &pfn_cache;
>> >>  		}
>> >>  		/*
>> >>  		 * Exclude the cache page with the private page.
>> >> @@ -4749,23 +4789,39 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>> >>  		else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
>> >>  		    && (isLRU(flags) || isSwapCache(flags))
>> >>  		    && !isAnon(mapping)) {
>> >> -			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
>> >> -				pfn_cache_private++;
>> >> +			pfn_counter = &pfn_cache_private;
>> >>  		}
>> >>  		/*
>> >>  		 * Exclude the data page of the user process.
>> >> +		 *  - anonymous pages
>> >> +		 *  - hugetlbfs pages
>> >>  		 */
>> >>  		else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
>> >> -		    && isAnon(mapping)) {
>> >> -			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
>> >> -				pfn_user++;
>> >> +			 && (isAnon(mapping) || isHugetlb(compound_dtor))) {
>> >> +			pfn_counter = &pfn_user;
>> >>  		}
>> >>  		/*
>> >>  		 * Exclude the hwpoison page.
>> >>  		 */
>> >>  		else if (isHWPOISON(flags)) {
>> >> +			pfn_counter = &pfn_hwpoison;
>> >> +		}
>> >> +		/*
>> >> +		 * Unexcludable page
>> >> +		 */
>> >> +		else
>> >> +			continue;
>> >> +
>> >> +		/*
>> >> +		 * Execute exclusion
>> >> +		 */
>> >> +		if (nr_pages == 1) {
>> >>  			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
>> >> -				pfn_hwpoison++;
>> >> +				(*pfn_counter)++;
>> >> +		} else {
>> >> +			exclude_range(pfn_counter, pfn, pfn + nr_pages, cycle);
>> >> +			pfn += nr_pages - 1;
>> >> +			mem_map += (nr_pages - 1) * SIZE(page);
>> >>  		}
>> >>  	}
>> >>  	return TRUE;
>> >> diff --git a/makedumpfile.h b/makedumpfile.h
>> >> index eba9798..9f90b53 100644
>> >> --- a/makedumpfile.h
>> >> +++ b/makedumpfile.h
>> >> @@ -74,6 +74,7 @@ int get_mem_type(void);
>> >>  #define PG_lru_ORIGINAL	 	(5)
>> >>  #define PG_slab_ORIGINAL	(7)
>> >>  #define PG_private_ORIGINAL	(11)	/* Has something at ->private */
>> >> +#define PG_compound_ORIGINAL	(14)	/* Is part of a compound page */
>> >>  #define PG_swapcache_ORIGINAL	(15)	/* Swap page: swp_entry_t in private */
>> >>
>> >>  #define PAGE_BUDDY_MAPCOUNT_VALUE_v2_6_38	(-2)
>> >> @@ -148,6 +149,9 @@ test_bit(int nr, unsigned long addr)
>> >>
>> >>  #define isLRU(flags)		test_bit(NUMBER(PG_lru), flags)
>> >>  #define isPrivate(flags)	test_bit(NUMBER(PG_private), flags)
>> >> +#define isCompoundHead(flags)   (!!((flags) & NUMBER(PG_head_mask)))
>> >> +#define isHugetlb(dtor)         ((SYMBOL(free_huge_page) != NOT_FOUND_SYMBOL) \
>> >> +				 && (SYMBOL(free_huge_page) == dtor))
>> >>  #define isSwapCache(flags)	test_bit(NUMBER(PG_swapcache), flags)
>> >>  #define isHWPOISON(flags)	(test_bit(NUMBER(PG_hwpoison), flags) \
>> >>  				&& (NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER))
>> >> @@ -1218,6 +1222,7 @@ struct symbol_table {
>> >>  	unsigned long long	node_remap_start_vaddr;
>> >>  	unsigned long long	node_remap_end_vaddr;
>> >>  	unsigned long long	node_remap_start_pfn;
>> >> +	unsigned long long      free_huge_page;
>> >>
>> >>  	/*
>> >>  	 * for Xen extraction
>> >> @@ -1509,6 +1514,8 @@ struct number_table {
>> >>  	 */
>> >>  	long	PG_lru;
>> >>  	long	PG_private;
>> >> +	long	PG_head;
>> >> +	long	PG_head_mask;
>> >>  	long	PG_swapcache;
>> >>  	long	PG_buddy;
>> >>  	long	PG_slab;
>> >> --
>> >> 1.9.0
>> >>
>> >> _______________________________________________
>> >> kexec mailing list
>> >> kexec@lists.infradead.org
>> >> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

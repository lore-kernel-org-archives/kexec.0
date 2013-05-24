Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ufggd-0002fs-CO
 for kexec@lists.infradead.org; Fri, 24 May 2013 01:20:57 +0000
Date: Fri, 24 May 2013 10:11:21 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: Petr Tesarik's hugepage filtering
Message-Id: <20130524101121.58d765fdfd5800dee0f1b951@mxc.nes.nec.co.jp>
In-Reply-To: <E1UcggB-0005gy-4i@eag09.americas.sgi.com>
References: <E1UcggB-0005gy-4i@eag09.americas.sgi.com>
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
To: cpw@sgi.com
Cc: kexec@lists.infradead.org

On Wed, 15 May 2013 13:43:59 -0500
Cliff Wickman <cpw@sgi.com> wrote:

> From: Cliff Wickman <cpw@sgi.com>
> 
> This fix comes from Petr Tesarik <ptesarik@suse.cz>, and was applied
> to the SuSE version of makedumpfile.
> I don't see it in the mmap version.
> It is important to filtering out a great deal of user memory.
> 
> But this from Petr on 5/15:
> > This patch depends on exporting the relevant PG_* flags from the
> > kernel (in VMCOREINFO), and that's where I got stuck, because depending
> > on the number of available bits for the page flags, the kernel either
> > has PG_head and PG_tail, or only PG_compound, so I needed a #ifdef, and
> > the kernel maintainers didn't like the conditional.
> > I can restart the discussion with kernel maintainers and see what I can do
> So I'm not sending to the kexec list until he's ready.

I send this mail to kexec list to open the discussion below.

> His description:
> 
> > This filters out pages that have the compound page flag set.
> > The precise position of the flag(s) depends on the kernel version
> > and configuration, so an additional patch is needed for the kernel.
> > 
> > It is still possible to filter out huge pages on unpatched kernels
> > if the debuginfo is available. The page flag can also be saved
> > into a generated vmcoreinfo file.
> > 
> > To sum it up:
> > 
> > a. any kernel with the appropriate patch includes the PG_xxx values in
> >    VMCOERINFO, and these are automatically picked up by makedumpfile
> >    (planned for a regular SLES11 kernel maint update)
> > b. for unpatched 2.6.26+ kernels, the info can be pre-generated with
> >    "makedumpfile -g", or you can pass the "-x" option with the kernel
> >    debuginfo file when filtering
> >    NOTE: running "makedumpfile" without either "-g" or "-x" will NOT
> >    filter out huge pages; a warning message should be issued
> > c. for pre-2.6.26 kernels, makedumpfile will assume the legacy value of
> >    14 for PG_compound (this also covers SLES10 kernels)
> > d. ancient pre-2.6.13 kernels will not be supported; no change here
> > 
> > Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
> ---
>  makedumpfile.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
>  makedumpfile.h |    8 ++++++++
>  2 files changed, 50 insertions(+), 1 deletion(-)
> 
> Index: makedumpfile.mmap/makedumpfile.c
> ===================================================================
> --- makedumpfile.mmap.orig/makedumpfile.c
> +++ makedumpfile.mmap/makedumpfile.c
> @@ -173,6 +173,13 @@ is_in_same_page(unsigned long vaddr1, un
>  	return FALSE;
>  }
>  
> +/* Test whether flags belong to a huge page */
> +static inline int
> +isHugePage(unsigned long flags)
> +{
> +	return flags & info->hugepage_flags;
> +}
> +
>  #define BITMAP_SECT_LEN 4096
>  static inline int is_dumpable(struct dump_bitmap *, unsigned long long);
>  static inline int is_dumpable_cyclic(char *bitmap, unsigned long long);
> @@ -1092,11 +1099,19 @@ get_structure_info(void)
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
> @@ -1537,6 +1552,12 @@ write_vmcoreinfo_data(void)
>  
>  	WRITE_NUMBER("PG_lru", PG_lru);
>  	WRITE_NUMBER("PG_private", PG_private);
> +	if (NUMBER(PG_head) != NOT_FOUND_NUMBER)
> +		WRITE_NUMBER("PG_head", PG_head);
> +	if (NUMBER(PG_tail) != NOT_FOUND_NUMBER)
> +		WRITE_NUMBER("PG_tail", PG_tail);
> +	if (NUMBER(PG_compound) != NOT_FOUND_NUMBER)
> +		WRITE_NUMBER("PG_compound", PG_compound);
>  	WRITE_NUMBER("PG_swapcache", PG_swapcache);
>  	WRITE_NUMBER("PG_buddy", PG_buddy);
>  	WRITE_NUMBER("PG_slab", PG_slab);
> @@ -1839,6 +1860,9 @@ read_vmcoreinfo(void)
>  
>  	READ_NUMBER("PG_lru", PG_lru);
>  	READ_NUMBER("PG_private", PG_private);
> +	READ_NUMBER("PG_head", PG_head);
> +	READ_NUMBER("PG_tail", PG_tail);
> +	READ_NUMBER("PG_compound", PG_compound);
>  	READ_NUMBER("PG_swapcache", PG_swapcache);
>  	READ_NUMBER("PG_slab", PG_slab);
>  	READ_NUMBER("PG_buddy", PG_buddy);
> @@ -3079,6 +3103,23 @@ sync_bitmap(struct dump_bitmap *bitmap)
>  	off_t offset;
>  	offset = bitmap->offset + BUFSIZE_BITMAP * bitmap->no_block;
>  
> +	/* Get page flags for compound pages */
> +	if (NUMBER(PG_head) != NOT_FOUND_NUMBER) {
> +		info->hugepage_flags = 1UL << NUMBER(PG_head);
> +		if (NUMBER(PG_tail) != NOT_FOUND_NUMBER)
> +			info->hugepage_flags |= 1UL << NUMBER(PG_tail);
> +		else
> +			/* If PG_tail is not explicitly saved, then assume
> +			 * that it immediately follows PG_head.
> +			 */
> +			info->hugepage_flags |= info->hugepage_flags << 1;
> +	} else if (NUMBER(PG_compound) != NOT_FOUND_NUMBER) {
> +		info->hugepage_flags = 1UL << NUMBER(PG_compound);
> +	} else if (info->dump_level & DL_EXCLUDE_USER_DATA) {
> +		MSG("Compound page bit could not be determined: ");
> +		MSG("huge pages will NOT be filtered.\n");
> +	}
> +
>  	/*
>  	 * The bitmap buffer is not dirty, and it is not necessary
>  	 * to write out it.
> @@ -4345,7 +4386,7 @@ __exclude_unnecessary_pages(unsigned lon
>  		 * Exclude the data page of the user process.
>  		 */
>  		else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
> -		    && isAnon(mapping)) {
> +		    && (isAnon(mapping) || isHugePage(flags))) {
>  			if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
>  				pfn_user++;

This code will filter out both transparent huge pages and hugetlbfs pages.
But I think hugetlbfs pages shouldn't be filtered out as anonymous pages
because anonymous pages and hugetlbfs pages are certainly different kind
of pages.

Therefore, I plan to add a new dump level to filter out hugetlbfs pages.
My basic idea is like below:


 		 * Exclude the data page of the user process.
 		 */
                else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
                    && isAnon(mapping)) {
                        if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
                                pfn_user++;
+
+                       if (isPageHead(flags)) {
+                               int i, nr_pages = 1 << compound_order;
+
+                               for (i = 1; i < nr_pages; ++i) {
+                                       if (clear_bit_on_2nd_bitmap_for_kernel(pfn + i))
+                                               pfn_user++;
+                               }
+                               pfn += nr_pages - 2;
+                               mem_map += (nr_pages - 1) * SIZE(page);
+                       }
+               }
+               /*
+                * Exclude the hugetlbfs pages.
+                */
+               else if ((info->dump_level & DL_EXCLUDE_HUGETLBFS_DATA)
+                        && (!isAnon(mapping) && isPageHead(flags))) {
+                       int i, nr_pages = 1 << compound_order;
+
+                       for (i = 0; i < nr_pages; ++i) {
+                               if (clear_bit_on_2nd_bitmap_for_kernel(pfn + i))
+                                       pfn_hugetlb++;
+                       }
+                       pfn += nr_pages - 1;
+                       mem_map += (nr_pages - 1) * SIZE(page);
                }
                /*
                 * Exclude the hwpoison page.


But before that, I would like to hear the opinions about the new dump level
to make sure that the level is worthy or not.


Thanks
Atsushi Kumagai

>  		}
> Index: makedumpfile.mmap/makedumpfile.h
> ===================================================================
> --- makedumpfile.mmap.orig/makedumpfile.h
> +++ makedumpfile.mmap/makedumpfile.h
> @@ -74,6 +74,7 @@ int get_mem_type(void);
>  #define PG_lru_ORIGINAL	 	(5)
>  #define PG_slab_ORIGINAL	(7)
>  #define PG_private_ORIGINAL	(11)	/* Has something at ->private */
> +#define PG_compound_ORIGINAL	(14)	/* Is part of a compound page */
>  #define PG_swapcache_ORIGINAL	(15)	/* Swap page: swp_entry_t in private */
>  
>  #define PAGE_BUDDY_MAPCOUNT_VALUE_v2_6_38	(-2)
> @@ -140,6 +141,9 @@ test_bit(int nr, unsigned long addr)
>  
>  #define isLRU(flags)		test_bit(NUMBER(PG_lru), flags)
>  #define isPrivate(flags)	test_bit(NUMBER(PG_private), flags)
> +#define isHead(flags)		test_bit(NUMBER(PG_head), flags)
> +#define isTail(flags)		test_bit(NUMBER(PG_tail), flags)
> +#define isCompound(flags)	test_bit(NUMBER(PG_compound), flags)
>  #define isSwapCache(flags)	test_bit(NUMBER(PG_swapcache), flags)
>  #define isHWPOISON(flags)	(test_bit(NUMBER(PG_hwpoison), flags) \
>  				&& (NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER))
> @@ -908,6 +912,7 @@ struct DumpInfo {
>  	unsigned long   vmalloc_end;
>  	unsigned long	vmemmap_start;
>  	unsigned long	vmemmap_end;
> +	unsigned long	hugepage_flags;	     /* page flags for a compound page */
>  
>  	/*
>  	 * Filter config file containing filter commands to filter out kernel
> @@ -1377,6 +1382,9 @@ struct number_table {
>  	 */
>  	long	PG_lru;
>  	long	PG_private;
> +	long	PG_head;
> +	long	PG_tail;
> +	long	PG_compound;
>  	long	PG_swapcache;
>  	long	PG_buddy;
>  	long	PG_slab;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

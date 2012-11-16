Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZShX-0003wG-80
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 20:39:49 +0000
Date: Fri, 16 Nov 2012 15:39:44 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] makedumpfile: request the kernel do page scans
Message-ID: <20121116203944.GO4515@redhat.com>
References: <E1TZ8Ia-0000Gn-1v@eag09.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1TZ8Ia-0000Gn-1v@eag09.americas.sgi.com>
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
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org

On Thu, Nov 15, 2012 at 04:52:40PM -0600, Cliff Wickman wrote:
> 
> Gentlemen,
> 
> I know this is rather late to the game, given all the recent work to speed
> up makedumpfile and reduce the memory that it consumes.
> But I've been experimenting with asking the kernel to scan the page tables
> instead of reading all those page structures through /proc/vmcore.
> 
> The results are rather dramatic -- if they weren't I would not presume to
> suggest such a radical path.
> On a small, idle UV system: about 4 sec. versus about 40 sec.
> On a 8TB UV the unnecessary page scan alone takes 4 minutes, vs. about 200 min
> through /proc/vmcore.
> 
> I have not compared it to your version 1.5.1, so I don't know if your recent
> work provides similar speedups.

I guess try 1.5.1-rc. IIUC, we had the logic of going through page tables
but that required one single bitmap to be present and in constrained
memory environment we will not have that.

That's when this idea came up that scan portion of struct page range,
filter it, dump it and then move on to next range.

Even after 1.5.1-rc if difference is this dramatic, that means we are
not doing something right in makedumpfile and it needs to be
fixed/optimized.

But moving the logic to kernel does not make much sense to me at this
point of time untile and unless there is a good explanation that why
user space can't do a good job of what kernel is doing.

Thanks
Vivek

> 
> This patch:
>   - writes requests to new kernel file /proc/vmcore_pfn_lists
>   - makes request PL_REQUEST_MEMMAP to pass the crash kernel information about
>     the boot kernel
>   - makes requests PL_REQUEST_FREE and PL_REQUEST_EXCLUDE, asking the kernel
>     to return lists of PFNs
>   - adds page scan timing options -n -o and -t
> 
> It depends on a kernel patch of course, so I'm also sending one that applies
> to a linux-next kernel.   See [PATCH] scan page tables for makedumpfile
> 
> Diffed against makedumpfile-1.5.0
> 
> Signed-off-by: Cliff Wickman <cpw@sgi.com>
> ---
>  dwarf_info.c   |    2 
>  makedumpfile.c |  395 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  makedumpfile.h |   88 ++++++++++++
>  print_info.c   |    5 
>  print_info.h   |    3 
>  5 files changed, 478 insertions(+), 15 deletions(-)
> 
> 
> Index: makedumpfile-1.5.0/makedumpfile.h
> ===================================================================
> --- makedumpfile-1.5.0.orig/makedumpfile.h
> +++ makedumpfile-1.5.0/makedumpfile.h
> @@ -719,9 +719,20 @@ unsigned long long vaddr_to_paddr_ia64(u
>  	(((unsigned long long)(X) + ARCH_PFN_OFFSET) << PAGESHIFT())
>  
>  struct mem_map_data {
> +	/*
> +	 * pfn_start/pfn_end are the pfn's represented by this mem_map entry.
> +	 * mem_map is the virtual address of the array of page structures
> +	 * that represent this pages.
> +	 * paddr is the physical address of that array of structures.
> +	 * ending_paddr would be (pfn_end - pfn_start) * sizeof(struct page).
> +	 * section_vaddr is the address we get from ioremap_cache().
> +	 */
>  	unsigned long long	pfn_start;
>  	unsigned long long	pfn_end;
> -	unsigned long	mem_map;
> +	unsigned long		mem_map;
> +	unsigned long long	paddr;		/* filled in by makedumpfile */
> +	unsigned long long	ending_paddr;	/* filled in by kernel */
> +	void 			*section_vaddr;	/* filled in by kernel */
>  };
>  
>  struct dump_bitmap {
> @@ -800,6 +811,7 @@ struct DumpInfo {
>  	int		flag_rearrange;      /* flag of creating dumpfile from
>  						flattened format */
>  	int		flag_split;	     /* splitting vmcore */
> +	int		flag_use_kernel_lists;
>    	int		flag_cyclic;	     /* cyclic processing to keep memory consumption */
>  	int		flag_reassemble;     /* reassemble multiple dumpfiles into one */
>  	int		flag_refiltering;    /* refilter from kdump-compressed file */
> @@ -1282,6 +1294,80 @@ struct domain_list {
>  	unsigned int  pickled_id;
>  };
>  
> +#define PL_REQUEST_FREE		1	/* request for a list of free pages */
> +#define PL_REQUEST_EXCLUDE	2	/* request for a list of excludable
> +					   pages */
> +#define PL_REQUEST_MEMMAP	3	/* request to pass in the makedumpfile
> +					   mem_map_data table */
> +/*
> + * limit the size of the pfn list to this many pfn_element structures
> + */
> +#define MAX_PFN_LIST 10000
> +
> +/*
> + * one element in the pfn_list
> + */
> +struct pfn_element {
> +	unsigned long pfn;
> +	unsigned long order;
> +};
> +
> +/*
> + * a request for finding pfn's that can be excluded from the dump
> + * they may be pages of particular types or free pages
> + */
> +struct pfn_list_request {
> +	int request;		/* PL_REQUEST_FREE PL_REQUEST_EXCLUDE or */
> +				/* PL_REQUEST_MEMMAP */
> +	int debug;
> +	unsigned long paddr;	/* mem_map address for PL_REQUEST_EXCLUDE */
> +	unsigned long pfn_start;/* pfn represented by paddr */
> +	unsigned long pgdat_paddr; /* for PL_REQUEST_FREE */
> +	unsigned long pgdat_vaddr; /* for PL_REQUEST_FREE */
> +	int node;		/* for PL_REQUEST_FREE */
> +	int exclude_bits;	/* for PL_REQUEST_EXCLUDE */
> +	int count;		/* for PL_REQUEST_EXCLUDE */
> +	void *reply_ptr;	/* address of user's pfn_reply, for reply */
> +	void *pfn_list_ptr;	/* address of user's pfn array (*pfn_list) */
> +	int map_count;		/* for PL_REQUEST_MEMMAP; elements */
> +	int map_size;		/* for PL_REQUEST_MEMMAP; bytes in table */
> +	void *map_ptr;		/* for PL_REQUEST_MEMMAP; address of table */
> +	long list_size;		/* for PL_REQUEST_MEMMAP negotiation */
> +	/* resume info: */
> +	int more;		/* 0 for done, 1 for "there's more" */
> +				/* PL_REQUEST_EXCLUDE: */
> +	int map_index;		/* slot in the mem_map array of page structs */
> +				/* PL_REQUEST_FREE: */
> +	int zone_index;		/* zone within the node's pgdat_list */
> +	int freearea_index;	/* free_area within the zone */
> +	int type_index;		/* free_list within the free_area */
> +	int list_ct;		/* page within the list */
> +};
> +
> +/*
> + * the reply from a pfn_list_request
> + * the list of pfn's itself is pointed to by pfn_list
> + */
> +struct pfn_reply {
> +	long pfn_list_elements;	/* negoiated on PL_REQUEST_MEMMAP */
> +	long in_pfn_list;	/* returned by PL_REQUEST_EXCLUDE and
> +				   PL_REQUEST_FREE */
> +	/* resume info */
> +	int more;		/* 0 == done, 1 == there is more */
> +				/* PL_REQUEST_MEMMAP: */
> +	int map_index;		/* slot in the mem_map array of page structs */
> +				/* PL_REQUEST_FREE: */
> +	int zone_index;		/* zone within the node's pgdat_list */
> +	int freearea_index;	/* free_area within the zone */
> +	int type_index;		/* free_list within the free_area */
> +	int list_ct;		/* page within the list */
> +	/* statistic counters: */
> +	unsigned long long pfn_cache;		/* PL_REQUEST_EXCLUDE */
> +	unsigned long long pfn_cache_private;	/* PL_REQUEST_EXCLUDE */
> +	unsigned long long pfn_user;		/* PL_REQUEST_EXCLUDE */
> +	unsigned long long pfn_free;		/* PL_REQUEST_FREE */
> +};
> +
>  #define PAGES_PER_MAPWORD 	(sizeof(unsigned long) * 8)
>  #define MFNS_PER_FRAME		(info->page_size / sizeof(unsigned long))
>  
> Index: makedumpfile-1.5.0/dwarf_info.c
> ===================================================================
> --- makedumpfile-1.5.0.orig/dwarf_info.c
> +++ makedumpfile-1.5.0/dwarf_info.c
> @@ -324,6 +324,8 @@ get_data_member_location(Dwarf_Die *die,
>  	return TRUE;
>  }
>  
> +int dwarf_formref(Dwarf_Attribute *, Dwarf_Off *);
> +
>  static int
>  get_die_type(Dwarf_Die *die, Dwarf_Die *die_type)
>  {
> Index: makedumpfile-1.5.0/makedumpfile.c
> ===================================================================
> --- makedumpfile-1.5.0.orig/makedumpfile.c
> +++ makedumpfile-1.5.0/makedumpfile.c
> @@ -13,6 +13,8 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
>   */
> +#define _GNU_SOURCE
> +#include <stdio.h>
>  #include "makedumpfile.h"
>  #include "print_info.h"
>  #include "dwarf_info.h"
> @@ -31,6 +33,13 @@ struct srcfile_table	srcfile_table;
>  
>  struct vm_table		vt = { 0 };
>  struct DumpInfo		*info = NULL;
> +int pfn_list_fd;
> +struct pfn_element *pfn_list;
> +int nflag = 0;
> +int oflag = 0;
> +int tflag = 1;  // cpw: default for testing performance
> +struct timeval scan_start;
> +int max_pfn_list;
>  
>  char filename_stdout[] = FILENAME_STDOUT;
>  
> @@ -2351,6 +2360,9 @@ get_mm_sparsemem(void)
>  	unsigned long long pfn_start, pfn_end;
>  	unsigned long section, mem_map;
>  	unsigned long *mem_sec = NULL;
> +	int i;
> +	int num_mem_map;
> +	struct mem_map_data *mmd;
>  
>  	int ret = FALSE;
>  
> @@ -2395,6 +2407,21 @@ get_mm_sparsemem(void)
>  		dump_mem_map(pfn_start, pfn_end, mem_map, section_nr);
>  	}
>  	ret = TRUE;
> +
> +	/* add paddr to the table */
> +	mmd = &info->mem_map_data[0];
> +	num_mem_map = info->num_mem_map;
> +	for (i = 0; i < num_mem_map; i++) {
> +		if (mmd[i].mem_map == 0) {
> +			mmd[i].paddr = 0;
> +		} else {
> +			mmd[i].paddr = vaddr_to_paddr(mmd[i].mem_map);
> +			if (mmd[i].paddr == 0)
> +				printf("! can't translate %#lx to paddr\n",
> +					mmd[i].mem_map);
> +		}
> +	}
> +
>  out:
>  	if (mem_sec != NULL)
>  		free(mem_sec);
> @@ -3459,6 +3486,65 @@ out:
>  	return ret;
>  }
>  
> +/*
> + * let the kernel find excludable pages from one node
> + */
> +void
> +__exclude_free_pages_kernel(unsigned long pgdat, int node)
> +{
> +	int i, j, ret, pages;
> +	unsigned long pgdat_paddr;
> +	struct pfn_list_request request;
> +	struct pfn_reply reply;
> +	struct pfn_element *pe;
> +
> +	if ((pgdat_paddr = vaddr_to_paddr(pgdat)) == NOT_PADDR) {
> +		ERRMSG("Can't convert virtual address(%#lx) to physical.\n",
> +			pgdat);
> +		return;
> +	}
> +
> +	/*
> +	 * Get the list of free pages.
> +	 * This may be broken up into MAX_PFN_list arrays of PFNs.
> +	 */
> +	memset(&request, 0, sizeof(request));
> +	request.request = PL_REQUEST_FREE;
> +	request.node = node;
> +	request.pgdat_paddr = pgdat_paddr;
> +	request.pgdat_vaddr = pgdat;
> +	request.reply_ptr = (void *)&reply;
> +	request.pfn_list_ptr = (void *)pfn_list;
> +	memset(&reply, 0, sizeof(reply));
> +
> +	do {
> +		request.more = 0;
> +		if (reply.more) {
> +			/* this is to be a continuation of the last request */
> +			request.more = 1;
> +			request.zone_index = reply.zone_index;
> +			request.freearea_index = reply.freearea_index;
> +			request.type_index = reply.type_index;
> +			request.list_ct = reply.list_ct;
> +		}
> +		ret = write(pfn_list_fd, &request, sizeof(request));
> +		if (ret != sizeof(request)) {
> +			printf("PL_REQUEST_FREE failed\n");
> +			return;
> +		}
> +		pfn_free += reply.pfn_free;
> +
> +		for (i = 0; i < reply.in_pfn_list; i++) {
> +			pe = &pfn_list[i];
> +			pages = (1 << pe->order);
> +                        for (j = 0; j < pages; j++) {
> +				clear_bit_on_2nd_bitmap_for_kernel(pe->pfn + j);
> +			}
> +		}
> +	} while (reply.more);
> +
> +	return;
> +}
>  
>  int
>  _exclude_free_page(void)
> @@ -3478,7 +3564,24 @@ _exclude_free_page(void)
>  	gettimeofday(&tv_start, NULL);
>  
>  	for (num_nodes = 1; num_nodes <= vt.numnodes; num_nodes++) {
> -
> +		if (info->flag_use_kernel_lists) {
> +			node_zones = pgdat + OFFSET(pglist_data.node_zones);
> +			if (!readmem(VADDR,
> +				pgdat + OFFSET(pglist_data.nr_zones),
> +				&nr_zones, sizeof(nr_zones))) {
> +					ERRMSG("Can't get nr_zones.\n");
> +				return FALSE;
> +			}
> +			print_progress(PROGRESS_FREE_PAGES, num_nodes - 1,
> +								vt.numnodes);
> +			/* ask the kernel to do one node */
> +			__exclude_free_pages_kernel(pgdat, node);
> +			goto next_pgdat;
> +		}
> +		/*
> +		 * kernel does not have the pfn_list capability
> +		 * use the old way
> +		 */
>  		print_progress(PROGRESS_FREE_PAGES, num_nodes - 1, vt.numnodes);
>  
>  		node_zones = pgdat + OFFSET(pglist_data.node_zones);
> @@ -3505,6 +3608,7 @@ _exclude_free_page(void)
>  			if (!reset_bitmap_of_free_pages(zone))
>  				return FALSE;
>  		}
> +	next_pgdat:
>  		if (num_nodes < vt.numnodes) {
>  			if ((node = next_online_node(node + 1)) < 0) {
>  				ERRMSG("Can't get next online node.\n");
> @@ -3522,6 +3626,8 @@ _exclude_free_page(void)
>  	 */
>  	print_progress(PROGRESS_FREE_PAGES, vt.numnodes, vt.numnodes);
>  	print_execution_time(PROGRESS_FREE_PAGES, &tv_start);
> +	if (tflag)
> +		print_execution_time("Total time", &scan_start);
>  
>  	return TRUE;
>  }
> @@ -3766,10 +3872,77 @@ exclude_zero_pages(void)
>  	return TRUE;
>  }
>  
> +/*
> + * let the kernel find excludable pages from one mem_section
> + */
> +int
> +__exclude_unnecessary_pages_kernel(int mm, struct mem_map_data *mmd)
> +{
> +	unsigned long long pfn_start = mmd->pfn_start;
> +	unsigned long long pfn_end = mmd->pfn_end;
> +	int i, j, ret, pages;
> +	struct pfn_list_request request;
> +	struct pfn_reply reply;
> +	struct pfn_element *pe;
> +
> +	/*
> +	 * Get the list of to-be-excluded pages in this section.
> +	 * It may be broken up by groups of max_pfn_list size.
> +	 */
> +	memset(&request, 0, sizeof(request));
> +	request.request = PL_REQUEST_EXCLUDE;
> +	request.paddr = mmd->paddr; /* phys addr of mem_map */
> +	request.reply_ptr = (void *)&reply;
> +	request.pfn_list_ptr = (void *)pfn_list;
> +	request.exclude_bits = 0;
> +	request.pfn_start = pfn_start;
> +	request.count = pfn_end - pfn_start;
> +	if (info->dump_level & DL_EXCLUDE_CACHE)
> +	 	request.exclude_bits |= DL_EXCLUDE_CACHE;
> +	if (info->dump_level & DL_EXCLUDE_CACHE_PRI)
> +	 	request.exclude_bits |= DL_EXCLUDE_CACHE_PRI;
> +	if (info->dump_level & DL_EXCLUDE_USER_DATA)
> +	 	request.exclude_bits |= DL_EXCLUDE_USER_DATA;
> +	memset(&reply, 0, sizeof(reply));
> +
> +	do {
> +		/* pfn represented by paddr */
> +		request.more = 0;
> +		if (reply.more) {
> +			/* this is to be a continuation of the last request */
> +			request.more = 1;
> +			request.map_index = reply.map_index;
> +		}
> +
> +		ret = write(pfn_list_fd, &request, sizeof(request));
> +		if (ret != sizeof(request))
> +			return FALSE;
> +
> +		pfn_cache += reply.pfn_cache;
> +		pfn_cache_private += reply.pfn_cache_private;
> +		pfn_user += reply.pfn_user;
> +
> +		for (i = 0; i < reply.in_pfn_list; i++) {
> +			pe = &pfn_list[i];
> +			pages = (1 << pe->order);
> +                        for (j = 0; j < pages; j++) {
> +				clear_bit_on_2nd_bitmap_for_kernel(pe->pfn + j);
> +			}
> +		}
> +	} while (reply.more);
> +
> +	return TRUE;
> +}
> +
> +/*
> + * find excludable pages from one mem_section
> + */
>  int
> -__exclude_unnecessary_pages(unsigned long mem_map,
> -    unsigned long long pfn_start, unsigned long long pfn_end)
> +__exclude_unnecessary_pages(int mm, struct mem_map_data *mmd)
>  {
> +	unsigned long long pfn_start = mmd->pfn_start;
> +	unsigned long long pfn_end = mmd->pfn_end;
> +	unsigned long mem_map = mmd->mem_map;
>  	unsigned long long pfn, pfn_mm, maddr;
>  	unsigned long long pfn_read_start, pfn_read_end, index_pg;
>  	unsigned char page_cache[SIZE(page) * PGMM_CACHED];
> @@ -3777,6 +3950,12 @@ __exclude_unnecessary_pages(unsigned lon
>  	unsigned int _count;
>  	unsigned long flags, mapping;
>  
> +	if (info->flag_use_kernel_lists) {
> +		if (__exclude_unnecessary_pages_kernel(mm, mmd) == FALSE)
> +			return FALSE;
> +		return TRUE;
> +	}
> +
>  	/*
>  	 * Refresh the buffer of struct page, when changing mem_map.
>  	 */
> @@ -3860,13 +4039,164 @@ __exclude_unnecessary_pages(unsigned lon
>  	return TRUE;
>  }
>  
> +/*
> + * construct a version of the mem_map_data table to pass to the kernel
> + */
> +void *
> +make_kernel_mmap(int *kmap_elements, int *kmap_size)
> +{
> +	int i, j;
> +	int elements = 0;
> +	int page_structs;
> +	int elem;
> +	unsigned long base_end_pfn;
> +	unsigned long end_paddr;
> +	struct mem_map_data *mmdo, *mmdn;
> +	struct mem_map_data *mmdbase, *mmdnext, *mmdend, *mmdwork;
> +	struct mem_map_data temp_mmd;
> +	struct mem_map_data *mmap;
> +
> +	mmap = malloc(info->num_mem_map * sizeof(struct mem_map_data));
> +	if (mmap == NULL) {
> +		ERRMSG("Can't allocate memory kernel map\n");
> +		return NULL;
> +	}
> +	for (i = 0, mmdn = mmap, mmdo = &info->mem_map_data[0];
> +				i < info->num_mem_map; i++, mmdo++) {
> +		if (mmdo->mem_map && mmdo->paddr) {
> +			*mmdn = *mmdo;
> +			mmdn++;
> +			elements++;
> +		}
> +	}
> +
> +	/* make sure it is sorted by mem_map (it should be already) */
> +	mmdn = mmap;
> +	for (i = 0; i < elements - 1; i++) {
> +		for (j = i + 1; j < elements; j++) {
> +			if (mmdn[j].mem_map < mmdn[i].mem_map) {
> +				temp_mmd = mmdn[j];
> +				mmdn[j] = mmdn[i];
> +				mmdn[i] = temp_mmd;
> +			}
> +		}
> +	}
> +
> +	/*
> +	 * consolidate those mem_map's with occupying consecutive physical
> +	 * addresses
> +	 *  pages represented by these pages structs:       addr of page struct
> +	 * pfns 0x1000000-1008000 mem_map 0xffffea0038000000 paddr 0x11f7e00000
> +	 * pfns 0x1008000-1010000 mem_map 0xffffea00381c0000 paddr 0x11f7fc0000
> +	 * pfns 0x1010000-1018000 mem_map 0xffffea0038380000 paddr 0x11f8180000
> +	 *           8000 increments                             inc's:  1c0000
> +	 *        8000000 of memory (128M)                    8000 page structs
> +	 *
> +	 */
> +	mmdbase = mmap;
> +	mmdnext = mmap + 1;
> +	mmdend = mmap + elements;
> +	while (mmdnext < mmdend) {
> +		elem = mmdend - mmdnext;
> +		/*  test mmdbase vs. mmdwork and onward: */
> +		for (i = 0, mmdwork = mmdnext; i < elem; i++, mmdwork++) {
> +			base_end_pfn = mmdbase->pfn_end;
> +			if (base_end_pfn == mmdwork->pfn_start) {
> +				page_structs = (mmdbase->pfn_end -
> +							mmdbase->pfn_start);
> +				end_paddr = (page_structs * SIZE(page))
> +							+ mmdbase->paddr;
> +				if (mmdwork->paddr == end_paddr) {
> +					/* extend base by the work one */
> +					mmdbase->pfn_end = mmdwork->pfn_end;
> +					/* next is where to begin next time */
> +					mmdnext = mmdwork + 1;
> +				} else {
> +					/* gap in address of page
> +					   structs; end of section */
> +					mmdbase++;
> +					if (mmdwork - mmdbase > 0)
> +						*mmdbase = *mmdwork;
> +					mmdnext = mmdwork + 1;
> +					break;
> +				}
> +			} else {
> +				/* gap in pfns; end of section */
> +				mmdbase++;
> +				if (mmdwork - mmdbase > 0)
> +					*mmdbase = *mmdwork;
> +				mmdnext = mmdwork + 1;
> +				break;
> +			}
> +		}
> +	}
> +	elements = (mmdbase - mmap) + 1;
> +	*kmap_elements = elements;
> +	*kmap_size = elements * sizeof(struct mem_map_data);
> +	return mmap;
> +}
> +
>  int
>  exclude_unnecessary_pages(void)
>  {
> +	int ct=0;
> +	int ret;
> +	int kmap_elements, kmap_size;
> +	long malloc_size;
> +	void *kmap_addr;
>  	unsigned int mm;
>  	struct mem_map_data *mmd;
> +	struct pfn_list_request request;
> +	struct pfn_reply reply;
>  	struct timeval tv_start;
>  
> +	gettimeofday(&scan_start, NULL);
> +	if (info->flag_use_kernel_lists) {
> +		/*
> +		 * Pass in the mem_map_data table.
> +		 * Must do this once, and before doing PL_REQUEST_FREE or
> +		 * PL_REQUEST_EXCLUDE.
> +		 */
> +		kmap_addr = make_kernel_mmap(&kmap_elements, &kmap_size);
> +		if (kmap_addr == NULL)
> +			return FALSE;
> +		memset(&request, 0, sizeof(request));
> +		request.request = PL_REQUEST_MEMMAP;
> +		request.map_ptr = kmap_addr;
> +		request.reply_ptr = (void *)&reply;
> +		request.map_count = kmap_elements;
> +		request.map_size = kmap_size;
> +		request.list_size = MAX_PFN_LIST;
> +
> +		ret = write(pfn_list_fd, &request, sizeof(request));
> +		if (ret < 0) {
> +			fprintf(stderr, "PL_REQUEST_MEMMAP returned %d\n", ret);
> +			return FALSE;
> +		}
> +		/* the reply tells us how long the kernel's list actually is */
> +		max_pfn_list = reply.pfn_list_elements;
> +		if (max_pfn_list <= 0) {
> +			fprintf(stderr,
> +				"PL_REQUEST_MEMMAP returned max_pfn_list %d\n",
> +				max_pfn_list);
> +			return FALSE;
> +		}
> +		if (max_pfn_list < MAX_PFN_LIST) {
> +			printf("length of pfn list dropped from %d to %d\n",
> +				MAX_PFN_LIST, max_pfn_list);
> +		}
> +		free(kmap_addr);
> +		/*
> +		 * Allocate the buffer for the PFN list (just once).
> +		 */
> +		malloc_size = max_pfn_list * sizeof(struct pfn_element);
> +		if ((pfn_list = (struct pfn_element *)malloc(malloc_size)) ==
> +									NULL) {
> +			ERRMSG("Can't allocate pfn_list of %ld\n", malloc_size);
> +			return FALSE;
> +		}
> +	}
> +
>  	gettimeofday(&tv_start, NULL);
>  
>  	for (mm = 0; mm < info->num_mem_map; mm++) {
> @@ -3876,9 +4206,10 @@ exclude_unnecessary_pages(void)
>  
>  		if (mmd->mem_map == NOT_MEMMAP_ADDR)
>  			continue;
> -
> -		if (!__exclude_unnecessary_pages(mmd->mem_map,
> -						 mmd->pfn_start, mmd->pfn_end))
> +		if (mmd->paddr == 0)
> +			continue;
> +		ct++;
> +		if (!__exclude_unnecessary_pages(mm, mmd))
>  			return FALSE;
>  	}
>  
> @@ -3932,8 +4263,8 @@ exclude_unnecessary_pages_cyclic(void)
>  				continue;
>  
>  			if (mmd->pfn_end >= info->cyclic_start_pfn || mmd->pfn_start <= info->cyclic_end_pfn) {
> -				if (!__exclude_unnecessary_pages(mmd->mem_map,
> -								 mmd->pfn_start, mmd->pfn_end))
> +				if (__exclude_unnecessary_pages(mm, mmd)
> +								== FALSE)
>  					return FALSE;
>  			}
>  		}
> @@ -3963,7 +4294,7 @@ update_cyclic_region(unsigned long long 
>  	if (!create_1st_bitmap_cyclic())
>  		return FALSE;
>  
> -	if (!exclude_unnecessary_pages_cyclic())
> +	if (exclude_unnecessary_pages_cyclic() == FALSE)
>  		return FALSE;
>  
>  	return TRUE;
> @@ -4023,7 +4354,7 @@ create_2nd_bitmap(void)
>  	if (info->dump_level & DL_EXCLUDE_CACHE ||
>  	    info->dump_level & DL_EXCLUDE_CACHE_PRI ||
>  	    info->dump_level & DL_EXCLUDE_USER_DATA) {
> -		if (!exclude_unnecessary_pages()) {
> +		if (exclude_unnecessary_pages() == FALSE) {
>  			ERRMSG("Can't exclude unnecessary pages.\n");
>  			return FALSE;
>  		}
> @@ -4969,7 +5300,7 @@ get_loads_dumpfile_cyclic(void)
>  	info->cyclic_end_pfn = info->pfn_cyclic;
>  	if (!create_1st_bitmap_cyclic())
>  		return FALSE;
> -	if (!exclude_unnecessary_pages_cyclic())
> +	if (exclude_unnecessary_pages_cyclic() == FALSE)
>  		return FALSE;
>  
>  	if (!(phnum = get_phnum_memory()))
> @@ -6953,6 +7284,11 @@ retry:
>  		if ((status = writeout_multiple_dumpfiles()) == FALSE)
>  			return FALSE;
>  	} else {
> +		if (nflag) {
> +			printf("\n");
> +			print_report();
> +			return TRUE;
> +		}
>  		if ((status = writeout_dumpfile()) == FALSE)
>  			return FALSE;
>  	}
> @@ -7782,6 +8118,22 @@ static struct option longopts[] = {
>  	{0, 0, 0, 0}
>  };
>  
> +/*
> + * test for the presence of capability in the kernel to provide lists
> + * of pfn's:
> + *   /proc/vmcore_pfn_lists
> + * return 1 for present
> + * return 0 for not present
> + */
> +int
> +test_kernel_pfn_lists(void)
> +{
> +	if ((pfn_list_fd = open("/proc/vmcore_pfn_lists", O_WRONLY)) < 0) {
> +		return 0;
> +	}
> +	return 1;
> +}
> +
>  int
>  main(int argc, char *argv[])
>  {
> @@ -7803,11 +8155,12 @@ main(int argc, char *argv[])
>  	/*
>  	 * By default, makedumpfile works in constant memory space.
>  	 */
> -	info->flag_cyclic = TRUE;
> +	// cpw: turn off cyclic as the default, for testing
> +	info->flag_cyclic = FALSE;
>  	
>  	info->block_order = DEFAULT_ORDER;
>  	message_level = DEFAULT_MSG_LEVEL;
> -	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMRrsvXx:", longopts,
> +	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:MnoRrstVvXx:Y", longopts,
>  	    NULL)) != -1) {
>  		switch (opt) {
>  		case 'b':
> @@ -7865,6 +8218,13 @@ main(int argc, char *argv[])
>  		case 'M':
>  			info->flag_dmesg = 1;
>  			break;
> +		case 'n':
> +			/* -n undocumented, for testing page scanning time */
> +			nflag = 1;
> +			break;
> +		case 'o':
> +			oflag = 1;
> +			break;
>  		case 'P':
>  			info->xen_phys_start = strtoul(optarg, NULL, 0);
>  			break;
> @@ -7877,6 +8237,9 @@ main(int argc, char *argv[])
>  		case 'r':
>  			info->flag_reassemble = 1;
>  			break;
> +		case 't':
> +			tflag = 1;
> +			break;
>  		case 'V':
>  			info->vaddr_for_vtop = strtoul(optarg, NULL, 0);
>  			break;
> @@ -7908,6 +8271,12 @@ main(int argc, char *argv[])
>  			goto out;
>  		}
>  	}
> +
> +	if (oflag)
> +		info->flag_use_kernel_lists = 0;
> +	else
> +		info->flag_use_kernel_lists = test_kernel_pfn_lists();
> +
>  	if (flag_debug)
>  		message_level |= ML_PRINT_DEBUG_MSG;
>  
> Index: makedumpfile-1.5.0/print_info.c
> ===================================================================
> --- makedumpfile-1.5.0.orig/print_info.c
> +++ makedumpfile-1.5.0/print_info.c
> @@ -237,6 +237,11 @@ print_usage(void)
>  	MSG("  [-f]:\n");
>  	MSG("      Overwrite DUMPFILE even if it already exists.\n");
>  	MSG("\n");
> +	MSG("  [-o]:\n");
> +	MSG("      Read page structures from /proc/vmcore in the scan for\n");
> +	MSG("      free and excluded pages regardless of whether\n");
> +	MSG("      /proc/vmcore_pfn_lists is present.\n");
> +	MSG("\n");
>  	MSG("  [-h]:\n");
>  	MSG("      Show help message and LZO support status (enabled/disabled).\n");
>  	MSG("\n");
> Index: makedumpfile-1.5.0/print_info.h
> ===================================================================
> --- makedumpfile-1.5.0.orig/print_info.h
> +++ makedumpfile-1.5.0/print_info.h
> @@ -43,7 +43,8 @@ void print_execution_time(char *step_nam
>   */
>  #define MIN_MSG_LEVEL		(0)
>  #define MAX_MSG_LEVEL		(31)
> -#define DEFAULT_MSG_LEVEL	(7)	/* Print the progress indicator, the
> +// cpw: was 7  but add x10 for testing
> +#define DEFAULT_MSG_LEVEL	(23)	/* Print the progress indicator, the
>  					   common message, the error message */
>  #define ML_PRINT_PROGRESS	(0x001) /* Print the progress indicator */
>  #define ML_PRINT_COMMON_MSG	(0x002)	/* Print the common message */
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

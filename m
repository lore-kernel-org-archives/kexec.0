Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KiA23-0006Ow-FF
	for kexec@lists.infradead.org; Tue, 23 Sep 2008 15:42:32 +0000
Message-ID: <48D90E13.3040202@redhat.com>
Date: Tue, 23 Sep 2008 11:41:07 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: the exiting makedumpfile is almost there... :)
References: <48C85836.8080606@sgi.com> <20080911143226.GT29908@sgi.com>
	<48C9D22A.5010404@mxs.nes.nec.co.jp> <48CA70CD.2090500@sgi.com>
	<48CAC7DB.4090904@sgi.com> <48CAD340.7000701@redhat.com>
	<48CAEB6A.8080405@sgi.com> <48D77E05.30504@mxs.nes.nec.co.jp>
In-Reply-To: <48D77E05.30504@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0335220788=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Jay Lan <jlan@sgi.com>, kexec@lists.infradead.org, Hedi Berriche <hedi@sgi.com>

--===============0335220788==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Ken'ichi,

We just ran into a similar problem using an older version of makedumpfile,
but looking at the latest makedumpfile code, it's seems that you could
run into the same problem.

In exclude_unnecessary_pages(), if a physical page is in a memory
hole, then it skips the page and continues.  In our case, that happened,
but when it started up again, the next legitimate pfn was well beyond
the previously-read cache of 512 pages.  But since the new legit page
wasn't modulo-512, it didn't refresh the page cache, and it ended up
using stale page data (page->flags) and ended up excluding legitimate
pages:

                for (; pfn < mmd->pfn_end;
                    pfn++, mem_map += SIZE(page),
                    paddr += info->page_size) {

                        /*
                         * Exclude the memory hole.
                         */
                        if (!is_in_segs(paddr))
                                continue;

                        if ((pfn % PGMM_CACHED) == 0) {
                                if (pfn + PGMM_CACHED < mmd->pfn_end)
                                        pfn_mm = PGMM_CACHED;
                                else
                                        pfn_mm = mmd->pfn_end - pfn;
                                if (!readmem(VADDR, mem_map, page_cache,
                                    SIZE(page) * pfn_mm))
                                        goto out;
                        }

We fixed it by doing something like this:

         if (!is_in_segs(paddr)) {
                 reset_cache = 1;
                 continue;
         }

         if (((pfn % PGMM_CACHED) == 0) || reset_cache) {
                 reset_cache = 0;
                 ...

Dave



Ken'ichi Ohmichi wrote:
> Hi Jay,
> 
> My IA64 linux-2.6.27-rc7 kernel could boot by your patches and its kdump
> succeeded, thanks. But I cannot reproduce this problem unfortunately.
> Could you send me your kernel .config file to reproduce it ?
> 
> And could you please research the reason why the page of virtual address
> 0xe0000060031417a8 is excluded ?  This patch is for researching it.
> Please apply it against makedumpfile-1.2.9, and create a dump file
> by makedumpfile with "-e 0xe0000060031417a8" option. The reason why
> excluding the page is printed like the following:
> 
>   # makedumpfile -cd31 -e 0xe000000062744000 -x vmlinux /proc/vmcore dump.cd31
>   The kernel version is not supported.
>   The created dumpfile may be incomplete.
>   Excluding unnecessary pages        : [100 %]
>   PAGE(vaddr:e000000062744000, pfn:189d1) is excluded as FREE PAGE.
> 
>   Copying data                       : [100 %]
> 
>   The dumpfile is saved to dump.cd31.
> 
>   makedumpfile Completed.
>   # 
> 
> 
> Thanks
> Ken'ichi Ohmichi
> 
> ---
> diff -puN backup/makedumpfile-1.2.9/makedumpfile.c makedumpfile/makedumpfile.c
> --- backup/makedumpfile-1.2.9/makedumpfile.c	2008-09-04 16:31:58.000000000 +0900
> +++ makedumpfile/makedumpfile.c	2008-09-22 20:15:37.000000000 +0900
> @@ -3360,6 +3360,9 @@ out:
>  	if (!get_mem_map())
>  		return FALSE;
>  
> +	if (info->vaddr_why_excluded)
> +		info->pfn_why_excluded = (vaddr_to_paddr(info->vaddr_why_excluded) / info->page_size);
> +
>  	return TRUE;
>  }
>  
> @@ -3470,8 +3473,14 @@ clear_bit_on_1st_bitmap(unsigned long lo
>  }
>  
>  int
> -clear_bit_on_2nd_bitmap(unsigned long long pfn)
> +clear_bit_on_2nd_bitmap(unsigned long long pfn, char *page_type)
>  {
> +	if (info->pfn_why_excluded == pfn) {
> +		MSG("\n");
> +		MSG("PAGE(vaddr:%lx, pfn:%llx) is excluded as %s.\n",
> +		    info->vaddr_why_excluded, info->pfn_why_excluded, page_type);
> +		MSG("\n");
> +	}
>  	return set_bitmap(info->bitmap2, pfn, 0);
>  }
>  
> @@ -3872,7 +3881,7 @@ reset_bitmap_of_free_pages(unsigned long
>  				}
>  				for (i = 0; i < (1<<order); i++) {
>  					pfn = start_pfn + i;
> -					clear_bit_on_2nd_bitmap(pfn);
> +					clear_bit_on_2nd_bitmap(pfn, "FREE PAGE");
>  				}
>  				found_free_pages += i;
>  
> @@ -4114,7 +4123,7 @@ exclude_zero_pages(void)
>  			return FALSE;
>  
>  		if (is_zero_page(buf, info->page_size)) {
> -			clear_bit_on_2nd_bitmap(pfn);
> +			clear_bit_on_2nd_bitmap(pfn, "ZERO PAGE");
>  			pfn_zero++;
>  		}
>  	}
> @@ -4186,7 +4195,7 @@ exclude_unnecessary_pages(void)
>  			if ((info->dump_level & DL_EXCLUDE_CACHE)
>  			    && (isLRU(flags) || isSwapCache(flags))
>  			    && !isPrivate(flags) && !isAnon(mapping)) {
> -				clear_bit_on_2nd_bitmap(pfn);
> +				clear_bit_on_2nd_bitmap(pfn, "CACHE PAGE");
>  				pfn_cache++;
>  			}
>  			/*
> @@ -4195,7 +4204,7 @@ exclude_unnecessary_pages(void)
>  			else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
>  			    && (isLRU(flags) || isSwapCache(flags))
>  			    && !isAnon(mapping)) {
> -				clear_bit_on_2nd_bitmap(pfn);
> +				clear_bit_on_2nd_bitmap(pfn, "CACHE PRIVATE PAGE");
>  				pfn_cache_private++;
>  			}
>  			/*
> @@ -4203,7 +4212,7 @@ exclude_unnecessary_pages(void)
>  			 */
>  			else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
>  			    && isAnon(mapping)) {
> -				clear_bit_on_2nd_bitmap(pfn);
> +				clear_bit_on_2nd_bitmap(pfn, "USER DATA PAGE");
>  				pfn_user++;
>  			}
>  		}
> @@ -5794,7 +5803,7 @@ exclude_xen_user_domain(void)
>  					size * info->num_load_memory);
>  
>  			if (!allocated_in_map(pfn)) {
> -				clear_bit_on_2nd_bitmap(pfn);
> +				clear_bit_on_2nd_bitmap(pfn, "USER DOMAIN PAGE");
>  				continue;
>  			}
>  
> @@ -5802,7 +5811,7 @@ exclude_xen_user_domain(void)
>  			if (!readmem(VADDR_XEN,
>  			      page_info_addr + OFFSET(page_info.count_info),
>  		 	      &count_info, sizeof(count_info))) {
> -				clear_bit_on_2nd_bitmap(pfn);
> +				clear_bit_on_2nd_bitmap(pfn, "USER DOMAIN PAGE");
>  				continue;	/* page_info may not exist */
>  			}
>  			if (!readmem(VADDR_XEN,
> @@ -5823,7 +5832,7 @@ exclude_xen_user_domain(void)
>  				continue;
>  			if ((count_info & 0xffff) && is_select_domain(_domain))
>  				continue;
> -			clear_bit_on_2nd_bitmap(pfn);
> +			clear_bit_on_2nd_bitmap(pfn, "USER DOMAIN PAGE");
>  		}
>  	}
>  
> @@ -6162,7 +6171,7 @@ main(int argc, char *argv[])
>  
>  	info->block_order = DEFAULT_ORDER;
>  	message_level = DEFAULT_MSG_LEVEL;
> -	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:RVvXx:", longopts,
> +	while ((opt = getopt_long(argc, argv, "b:cDd:Ee:Ffg:hi:RVvXx:", longopts,
>  	    NULL)) != -1) {
>  		switch (opt) {
>  		case 'b':
> @@ -6180,6 +6189,9 @@ main(int argc, char *argv[])
>  		case 'E':
>  			info->flag_elf_dumpfile = 1;
>  			break;
> +		case 'e':
> +			info->vaddr_why_excluded = strtoul(optarg, NULL, 0);
> +			break;
>  		case 'F':
>  			info->flag_flatten = 1;
>  			break;
> diff -puN backup/makedumpfile-1.2.9/makedumpfile.h makedumpfile/makedumpfile.h
> --- backup/makedumpfile-1.2.9/makedumpfile.h	2008-09-04 16:31:58.000000000 +0900
> +++ makedumpfile/makedumpfile.h	2008-09-22 18:41:16.000000000 +0900
> @@ -725,6 +725,8 @@ struct DumpInfo {
>  	int		flag_force;	     /* overwrite existing stuff */
>  	int		flag_exclude_xen_dom;/* exclude Domain-U from xen-kdump */
>  	unsigned long	vaddr_for_vtop;      /* virtual address for debugging */
> +	unsigned long	vaddr_why_excluded;
> +	unsigned long long	pfn_why_excluded;
>  	long		page_size;           /* size of page */
>  	long		page_shift;
>  	unsigned long long	max_mapnr;   /* number of page descriptor */
> 



--===============0335220788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0335220788==--

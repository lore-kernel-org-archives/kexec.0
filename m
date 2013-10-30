Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VbTRO-0007U7-Op
 for kexec@lists.infradead.org; Wed, 30 Oct 2013 10:56:01 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 2/2] Write out a whole part of the 1st bitmap before
 entering cyclic process
Date: Wed, 30 Oct 2013 10:52:58 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971BA5FD@BPXM01GP.gisp.nec.co.jp>
References: <20131024065015.5291.51864.stgit@localhost6.localdomain6>
 <20131024065205.5291.37035.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

(2013/10/24 15:52), HATAYAMA Daisuke wrote:
> Currently, 1st bitmap is created during cyclic process, but the
> information represented by the 1st bitmap, originally present memory,
> is still available from ELF program header table, so we don't need to
> keep the 1st bitmap even in cyclic process.
>
> Supported is a conversion from ELF to kdump-compressed format only,
> not from ELF to ELF.
>
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>   makedumpfile.c |  224 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 202 insertions(+), 22 deletions(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 4b6c0ed..7440c97 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3055,7 +3055,8 @@ out:
>   				 * bufsize_cyclic is used to allocate 1st and 2nd bitmap,
>   				 * so it should be truncated to the half of free_memory.
>   				 */
> -				info->bufsize_cyclic = free_memory / 2;
> +				if (info->flag_elf_dumpfile)
> +					info->bufsize_cyclic = free_memory / 2;
>   			}
>   		}

I think here should be changed like below:

		if (info->flag_elf_dumpfile)
			info->bufsize_cyclic = free_memory / 2;
		else
			info->bufsize_cyclic = free_memory;


Thanks
Atsushi Kumagai

>
> @@ -3328,6 +3329,33 @@ clear_bit_on_2nd_bitmap_for_kernel(unsigned long long pfn)
>   	return clear_bit_on_2nd_bitmap(pfn);
>   }
>
> +int
> +set_bit_on_2nd_bitmap(unsigned long long pfn)
> +{
> +	if (info->flag_cyclic) {
> +		return set_bitmap_cyclic(info->partial_bitmap2, pfn, 1);
> +	} else {
> +		return set_bitmap(info->bitmap2, pfn, 1);
> +	}
> +}
> +
> +int
> +set_bit_on_2nd_bitmap_for_kernel(unsigned long long pfn)
> +{
> +	unsigned long long maddr;
> +
> +	if (is_xen_memory()) {
> +		maddr = ptom_xen(pfn_to_paddr(pfn));
> +		if (maddr == NOT_PADDR) {
> +			ERRMSG("Can't convert a physical address(%llx) to machine address.\n",
> +			    pfn_to_paddr(pfn));
> +			return FALSE;
> +		}
> +		pfn = paddr_to_pfn(maddr);
> +	}
> +	return set_bit_on_2nd_bitmap(pfn);
> +}
> +
>   static inline int
>   is_in_segs(unsigned long long paddr)
>   {
> @@ -4418,6 +4446,53 @@ exclude_zero_pages(void)
>   	return TRUE;
>   }
>
> +static int
> +initialize_2nd_bitmap_cyclic(void)
> +{
> +	int i;
> +	unsigned long long pfn;
> +	unsigned long long phys_start, phys_end;
> +	unsigned long long pfn_start, pfn_end;
> +	unsigned long long pfn_start_roundup, pfn_end_round;
> +	unsigned long pfn_start_byte, pfn_end_byte;
> +
> +	/*
> +	 * At first, clear all the bits on the 2nd-bitmap.
> +	 */
> +	initialize_bitmap_cyclic(info->partial_bitmap2);
> +
> +	/*
> +	 * If page is on memory hole, set bit on the 2nd-bitmap.
> +	 */
> +	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
> +		pfn_start = MAX(paddr_to_pfn(phys_start), info->cyclic_start_pfn);
> +		pfn_end = MIN(paddr_to_pfn(phys_end), info->cyclic_end_pfn);
> +
> +		if (pfn_start >= pfn_end)
> +			continue;
> +
> +		pfn_start_roundup = roundup(pfn_start, BITPERBYTE);
> +		pfn_end_round = round(pfn_end, BITPERBYTE);
> +
> +		for (pfn = pfn_start; pfn < pfn_start_roundup; ++pfn)
> +			if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
> +				return FALSE;
> +
> +		pfn_start_byte = (pfn_start_roundup - info->cyclic_start_pfn) >> 3;
> +		pfn_end_byte = (pfn_end_round - info->cyclic_start_pfn) >> 3;
> +
> +		memset(info->partial_bitmap2 + pfn_start_byte,
> +		       0xff,
> +		       pfn_end_byte - pfn_start_byte);
> +
> +		for (pfn = pfn_end_round; pfn < pfn_end; ++pfn)
> +			if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
> +				return FALSE;
> +	}
> +
> +	return TRUE;
> +}
> +
>   int
>   __exclude_unnecessary_pages(unsigned long mem_map,
>       unsigned long long pfn_start, unsigned long long pfn_end)
> @@ -4584,12 +4659,6 @@ exclude_unnecessary_pages(void)
>   	return TRUE;
>   }
>
> -void
> -copy_bitmap_cyclic(void)
> -{
> -	memcpy(info->partial_bitmap2, info->partial_bitmap1, info->bufsize_cyclic);
> -}
> -
>   int
>   exclude_unnecessary_pages_cyclic(void)
>   {
> @@ -4597,10 +4666,8 @@ exclude_unnecessary_pages_cyclic(void)
>   	struct mem_map_data *mmd;
>   	struct timeval tv_start;
>
> -	/*
> -	 * Copy 1st-bitmap to 2nd-bitmap.
> -	 */
> -	copy_bitmap_cyclic();
> +	if (!initialize_2nd_bitmap_cyclic())
> +		return FALSE;
>
>   	if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
>   		if (!exclude_free_page())
> @@ -4657,7 +4724,7 @@ update_cyclic_region(unsigned long long pfn)
>   	if (info->cyclic_end_pfn > info->max_mapnr)
>   		info->cyclic_end_pfn = info->max_mapnr;
>
> -	if (!create_1st_bitmap_cyclic())
> +	if (info->flag_elf_dumpfile && !create_1st_bitmap_cyclic())
>   		return FALSE;
>
>   	if (!exclude_unnecessary_pages_cyclic())
> @@ -4841,19 +4908,71 @@ prepare_bitmap_buffer_cyclic(void)
>   	return TRUE;
>   }
>
> +int
> +prepare_bitmap1_buffer_cyclic(void)
> +{
> +	/*
> +	 * Prepare partial bitmap buffers for cyclic processing.
> +	 */
> +	if ((info->partial_bitmap1 = (char *)malloc(info->bufsize_cyclic)) == NULL) {
> +		ERRMSG("Can't allocate memory for the 1st bitmaps. %s\n",
> +		       strerror(errno));
> +		return FALSE;
> +	}
> +	initialize_bitmap_cyclic(info->partial_bitmap1);
> +
> +	return TRUE;
> +}
> +
> +int
> +prepare_bitmap2_buffer_cyclic(void)
> +{
> +	unsigned long tmp;
> +
> +	/*
> +	 * Create 2 bitmaps (1st-bitmap & 2nd-bitmap) on block_size
> +	 * boundary. The crash utility requires both of them to be
> +	 * aligned to block_size boundary.
> +	 */
> +	tmp = divideup(divideup(info->max_mapnr, BITPERBYTE), info->page_size);
> +	info->len_bitmap = tmp * info->page_size * 2;
> +
> +	/*
> +	 * Prepare partial bitmap buffers for cyclic processing.
> +	 */
> +	if ((info->partial_bitmap2 = (char *)malloc(info->bufsize_cyclic)) == NULL) {
> +		ERRMSG("Can't allocate memory for the 2nd bitmaps. %s\n",
> +		       strerror(errno));
> +		return FALSE;
> +	}
> +	initialize_bitmap_cyclic(info->partial_bitmap2);
> +
> +	return TRUE;
> +}
> +
>   void
> -free_bitmap_buffer(void)
> +free_bitmap1_buffer(void)
>   {
>   	if (info->bitmap1) {
>   		free(info->bitmap1);
>   		info->bitmap1 = NULL;
>   	}
> +}
> +
> +void
> +free_bitmap2_buffer(void)
> +{
>   	if (info->bitmap2) {
>   		free(info->bitmap2);
>   		info->bitmap2 = NULL;
>   	}
> +}
>
> -	return;
> +void
> +free_bitmap_buffer(void)
> +{
> +	free_bitmap1_buffer();
> +	free_bitmap2_buffer();
>   }
>
>   int
> @@ -4862,10 +4981,21 @@ create_dump_bitmap(void)
>   	int ret = FALSE;
>
>   	if (info->flag_cyclic) {
> -		if (!prepare_bitmap_buffer_cyclic())
> -			goto out;
>
> -		info->num_dumpable = get_num_dumpable_cyclic();
> +		if (info->flag_elf_dumpfile) {
> +			if (!prepare_bitmap_buffer_cyclic())
> +				goto out;
> +
> +			info->num_dumpable = get_num_dumpable_cyclic();
> +		} else {
> +			if (!prepare_bitmap2_buffer_cyclic())
> +				goto out;
> +
> +			info->num_dumpable = get_num_dumpable_cyclic();
> +
> +			free_bitmap2_buffer();
> +		}
> +
>   	} else {
>   		if (!prepare_bitmap_buffer())
>   			goto out;
> @@ -6564,7 +6694,7 @@ out:
>   }
>
>   int
> -write_kdump_bitmap_cyclic(void)
> +write_kdump_bitmap1_cyclic(void)
>   {
>   	off_t offset;
>           int increment;
> @@ -6576,10 +6706,30 @@ write_kdump_bitmap_cyclic(void)
>   		return FALSE;
>
>   	offset = info->offset_bitmap1;
> -	if (!write_buffer(info->fd_dumpfile, offset,
> +	if (!write_buffer(info->fd_dumpfile, offset + info->bufsize_cyclic *
> +			  (info->cyclic_start_pfn / info->pfn_cyclic),
>   			  info->partial_bitmap1, increment, info->name_dumpfile))
>   		goto out;
>
> +	ret = TRUE;
> +out:
> +	return ret;
> +}
> +
> +int
> +write_kdump_bitmap2_cyclic(void)
> +{
> +	off_t offset;
> +	int increment;
> +	int ret = FALSE;
> +
> +	increment = divideup(info->cyclic_end_pfn - info->cyclic_start_pfn,
> +			     BITPERBYTE);
> +
> +	if (info->flag_elf_dumpfile)
> +		return FALSE;
> +
> +	offset = info->offset_bitmap1;
>   	offset += info->len_bitmap / 2;
>   	if (!write_buffer(info->fd_dumpfile, offset,
>   			  info->partial_bitmap2, increment, info->name_dumpfile))
> @@ -6633,6 +6783,30 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
>   	}
>
>   	/*
> +	 * Write the 1st bitmap
> +	 */
> +	if (!prepare_bitmap1_buffer_cyclic())
> +		return FALSE;
> +
> +	info->cyclic_start_pfn = 0;
> +	info->cyclic_end_pfn = 0;
> +	for (pfn = 0; pfn < info->max_mapnr; pfn++) {
> +		if (is_cyclic_region(pfn))
> +			continue;
> +		if (!update_cyclic_region(pfn))
> +			return FALSE;
> +		if (!create_1st_bitmap_cyclic())
> +			return FALSE;
> +		if (!write_kdump_bitmap1_cyclic())
> +			return FALSE;
> +	}
> +
> +	free_bitmap1_buffer();
> +
> +	if (!prepare_bitmap2_buffer_cyclic())
> +		return FALSE;
> +
> +	/*
>   	 * Write pages and bitmap cyclically.
>   	 */
>   	info->cyclic_start_pfn = 0;
> @@ -6647,7 +6821,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
>   		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero, &offset_data))
>   			return FALSE;
>
> -		if (!write_kdump_bitmap_cyclic())
> +		if (!write_kdump_bitmap2_cyclic())
>   			return FALSE;
>           }
>
> @@ -8681,8 +8855,14 @@ calculate_cyclic_buffer_size(void) {
>   	 * should be 40% of free memory to keep the size of cyclic buffer
>   	 * within 80% of free memory.
>   	 */
> -	free_size = get_free_memory_size() * 0.4;
> -	needed_size = (info->max_mapnr * 2) / BITPERBYTE;
> +	if (info->flag_elf_dumpfile) {
> +		free_size = get_free_memory_size() * 0.4;
> +		needed_size = (info->max_mapnr * 2) / BITPERBYTE;
> +	} else {
> +		free_size = get_free_memory_size() * 0.8;
> +		needed_size = info->max_mapnr / BITPERBYTE;
> +	}
> +
>   	/* if --split was specified cyclic buffer allocated per dump file */
>   	if (info->num_dumpfile > 1)
>   		needed_size /= info->num_dumpfile;
>
>
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W68SD-00025o-Av
 for kexec@lists.infradead.org; Thu, 23 Jan 2014 00:47:33 +0000
Date: Thu, 23 Jan 2014 08:47:05 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 2/3] makedumpfile: use struct cycle to update cyclic
 region and clean up
Message-ID: <20140123004705.GB1517@dhcp-17-102.nay.redhat.com>
References: <1390399051-8732-1-git-send-email-bhe@redhat.com>
 <1390399051-8732-2-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1390399051-8732-2-git-send-email-bhe@redhat.com>
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
To: kexec@lists.infradead.org
Cc: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp


> @@ -5929,6 +5897,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>  	off_t off_seg_load, off_memory;
>  	Elf64_Phdr load;
>  	struct timeval tv_start;
> +	struct cycle cycle = {0};
>  
>  	if (!info->flag_elf_dumpfile)
>  		return FALSE;
> @@ -5946,11 +5915,6 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>  	pfn_user = pfn_free = pfn_hwpoison = 0;
>  	pfn_memhole = info->max_mapnr;
>  
> -	info->cyclic_start_pfn = 0;
> -	info->cyclic_end_pfn = 0;
> -	if (!update_cyclic_region(0))
> -		return FALSE;
> -
>  	if (!(phnum = get_phnum_memory()))
>  		return FALSE;
>  
> @@ -5982,30 +5946,17 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>  		if (frac_tail)
>  			pfn_end++;
>  
> -		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
> +		for_each_cycle(pfn_start, pfn_end, &cycle) {
>  			/*
>  			 * Update target region and partial bitmap if necessary.
>  			 */
> -			if (!update_cyclic_region(pfn))
> +			if (!create_1st_bitmap_cyclic(&cycle))
> +				return FALSE;
> +			if (!exclude_unnecessary_pages_cyclic(&cycle))
>  				return FALSE;

If in first_cycle(), the cycle->start_pfn is changed to 
		cycle->start_pfn = round(start, info->pfn_cyclic);

Here the cycle.start_pfn need be reassigned, otherwise some paddr may be
out of load segment.

		cycle.start_pfn = MAX(pfn_start, cycle.start_pfn);


>  
> -			if (!is_dumpable_cyclic(info->partial_bitmap2, pfn)) {
> -				num_excluded++;
> -				if ((pfn == pfn_end - 1) && frac_tail)
> -					memsz += frac_tail;
> -				else
> -					memsz += page_size;
> -				continue;
> -			}
> -
> -			/*
> -			 * Exclude zero pages.
> -			 */
> -			if (info->dump_level & DL_EXCLUDE_ZERO) {
> -				if (!read_pfn(pfn, buf))
> -					return FALSE;
> -				if (is_zero_page(buf, page_size)) {
> -					pfn_zero++;
> +			for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
> +				if (!is_dumpable_cyclic(info->partial_bitmap2, pfn, &cycle)) {
>  					num_excluded++;
>  					if ((pfn == pfn_end - 1) && frac_tail)
>  						memsz += frac_tail;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

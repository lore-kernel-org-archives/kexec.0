Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vklei-00031M-Km
 for kexec@lists.infradead.org; Mon, 25 Nov 2013 02:12:10 +0000
Date: Mon, 25 Nov 2013 10:11:17 +0800
From: Baoquan He <bhe@redhat.com>
Message-ID: <20131125021117.GA13197@dhcp-16-252.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: d.hatayama@jp.fujitsu.com, chaowang@redhat.com

kumagai-atsushi@mxc.nes.nec.co.jp
Bcc: bhe@redhat.com
Subject: Re: [PATCH v2] makedumpfile: add parameters to update_cyclic_region
Reply-To: 
In-Reply-To: <20131123092914.GA31384@dhcp-16-105.nay.redhat.com>

I think v2 is better than v1, since update_cyclic_region can be used
with a more flexible calling.

Hi HATAYAMA and Atsushi,

What's your opinion about this?

Baoquan
Thanks a lot

On 11/23/13 at 05:29pm, Baoquan He wrote:
> Function update_cyclic_region has a name which doesn't match its
> functionality. it does 3 tings: update the cyclic region; if elf
> dump, call create_1st_bitmap_cyclic in this region; call
> exclude_unnecessary_pages_cyclic to exclude pages in this region.
> 
> However not all 3 things are needed to be done everywhere. Somewhere
> unnecessary thing is done with much efforts, e.g when get dumpable
> page numbers for elf cyclic dump 1st bigmap creating is not needed.
> Somewhere thing is done, but it also cause errors, e.g when write
> 1st bitmap cyclic for compressed kdump it will add free page numbers
> twice, namely pfn_free is doubled. Then dump information will be wrong
> like below:
> 
> Original pages  : 0x000000000007539c
>   Excluded pages   : 0x00000000000d986a
>     Pages filled with zero  : 0x0000000000001196
>     Cache pages             : 0x0000000000025008
>     Cache pages + private   : 0x0000000000004baa
>     User process data pages : 0x00000000000127d0
>     Free pages              : 0x000000000009c352
>     Hwpoison pages          : 0x0000000000000000
>   Remaining pages  : 0xfffffffffff9bb32
>   (The number of pages is reduced to 38418230895101%.)
> Memory Hole     : 0x000000000000ac62
> --------------------------------------------------
> Total pages     : 0x000000000007fffe
> 
> So add 2 more parameters for update_cyclic_region. By these adding
> update_cyclic_region can be called in a refined grain. Then effort
> can be saved and above error can be fixed.
> 
> And in kdump compressed dump case, prepare_bitmap2_buffer_cyclic is
> called, that means partial_bitmap2 is malloced twice. Here remove
> the 2nd call.
> ---
>  makedumpfile.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 3746cf6..8cfc2a5 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -4725,7 +4725,7 @@ exclude_unnecessary_pages_cyclic(void)
>  }
>  
>  int
> -update_cyclic_region(unsigned long long pfn)
> +update_cyclic_region(unsigned long long pfn, int bmp1_set, int exclude)
>  {
>  	if (is_cyclic_region(pfn))
>  		return TRUE;
> @@ -4736,10 +4736,10 @@ update_cyclic_region(unsigned long long pfn)
>  	if (info->cyclic_end_pfn > info->max_mapnr)
>  		info->cyclic_end_pfn = info->max_mapnr;
>  
> -	if (info->flag_elf_dumpfile && !create_1st_bitmap_cyclic())
> +	if (bmp1_set && info->flag_elf_dumpfile && !create_1st_bitmap_cyclic())
>  		return FALSE;
>  
> -	if (!exclude_unnecessary_pages_cyclic())
> +	if (exclude && !exclude_unnecessary_pages_cyclic())
>  		return FALSE;
>  
>  	return TRUE;
> @@ -5502,7 +5502,7 @@ get_num_dumpable_cyclic(void)
>  	unsigned long long pfn, num_dumpable=0;
>  
>  	for (pfn = 0; pfn < info->max_mapnr; pfn++) {
> -		if (!update_cyclic_region(pfn))
> +		if (!update_cyclic_region(pfn, 0, 1))
>  			return FALSE;
>  
>  		if (is_dumpable_cyclic(info->partial_bitmap2, pfn))
> @@ -5803,7 +5803,7 @@ get_loads_dumpfile_cyclic(void)
>  			 * Update target region and bitmap
>  			 */
>  			if (!is_cyclic_region(pfn)) {
> -				if (!update_cyclic_region(pfn))
> +				if (!update_cyclic_region(pfn, 0, 1))
>  					return FALSE;
>  			}
>  
> @@ -5872,7 +5872,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>  
>  	info->cyclic_start_pfn = 0;
>  	info->cyclic_end_pfn = 0;
> -	if (!update_cyclic_region(0))
> +	if (!update_cyclic_region(0, 1, 1))
>  		return FALSE;
>  
>  	if (!(phnum = get_phnum_memory()))
> @@ -5910,7 +5910,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>  			/*
>  			 * Update target region and partial bitmap if necessary.
>  			 */
> -			if (!update_cyclic_region(pfn))
> +			if (!update_cyclic_region(pfn, 1, 1))
>  				return FALSE;
>  
>  			if (!is_dumpable_cyclic(info->partial_bitmap2, pfn)) {
> @@ -6805,7 +6805,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
>  	for (pfn = 0; pfn < info->max_mapnr; pfn++) {
>  		if (is_cyclic_region(pfn))
>  			continue;
> -		if (!update_cyclic_region(pfn))
> +		if (!update_cyclic_region(pfn, 0, 0))
>  			return FALSE;
>  		if (!create_1st_bitmap_cyclic())
>  			return FALSE;
> @@ -6815,9 +6815,6 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
>  
>  	free_bitmap1_buffer();
>  
> -	if (!prepare_bitmap2_buffer_cyclic())
> -		return FALSE;
> -
>  	/*
>  	 * Write pages and bitmap cyclically.
>  	 */
> @@ -6827,7 +6824,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
>  		if (is_cyclic_region(pfn))
>  			continue;
>  
> -		if (!update_cyclic_region(pfn))
> +		if (!update_cyclic_region(pfn, 0, 1))
>                          return FALSE;
>  
>  		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero, &offset_data))
> -- 
> 1.8.3.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

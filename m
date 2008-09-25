Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]
	helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KiwPi-0007iv-U8
	for kexec@lists.infradead.org; Thu, 25 Sep 2008 19:22:11 +0000
Message-ID: <48DBE4DF.30801@sgi.com>
Date: Thu, 25 Sep 2008 12:22:07 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: the exiting makedumpfile is almost there... :)
References: <48C85836.8080606@sgi.com>	<20080911143226.GT29908@sgi.com>	<48C9D22A.5010404@mxs.nes.nec.co.jp>	<48CA70CD.2090500@sgi.com>	<48CAC7DB.4090904@sgi.com>	<48CAD340.7000701@redhat.com>	<48CAEB6A.8080405@sgi.com>	<48D77E05.30504@mxs.nes.nec.co.jp>	<48D90E13.3040202@redhat.com>	<48D99351.7090804@mxs.nes.nec.co.jp>	<48DA8738.2090207@sgi.com>
	<48DAB79C.9050601@sgi.com> <48DB31D5.9040200@mxs.nes.nec.co.jp>
	<48DB7692.1020002@mxs.nes.nec.co.jp>
In-Reply-To: <48DB7692.1020002@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1341826688=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Hedi Berriche <hedi@sgi.com>

--===============1341826688==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Ken'ichi Ohmichi wrote:
> Hi Jay,

Hi Ken'ichi San,

The latest patch worked on my 2p A350 IA64 as well as on my 128p 256G
memory A4700 machines! And it still took less than 2 minutes to
complete makedumpfile on the freshly booted A4700 (compared to >6
minutes doing 'cp --sparse=always' :) It would be fun to see how much
time to run makedumpfile on a 1TB system ;)

Congradulation, Ken'ichi! And, thanks a lot!

Now, only if i can cut out huge memory required for kdump kernel
due to cpus we do not need (hey, maxcpus=1!) and due to disk arrays
we do not use! ;)

Cheers,
 - jay

> 
> The last patch contained a bug yet, so please use this patch.
> Sorry for my mistake.
> 
> Ken'ichi Ohmichi wrote:
>> Yes, your test data helps me.
>> Your test informed me that there was the buffer-handling problem
>> referring different page yet, so the last patch is not enough.
>> I created the attached patch for fixing it. Could you test the
>> attached patch again ?  Sorry for many tests.
>>
>> This patch is for makedumpfile-1.2.9.
>>
>>
>> Thanks
>> Ken'ichi Ohmichi
>>
>> diff -puN a/makedumpfile.c b/makedumpfile.c
>> --- a/makedumpfile.c	2008-09-25 15:39:00.000000000 +0900
>> +++ b/makedumpfile.c	2008-09-25 15:39:17.000000000 +0900
>> @@ -4133,6 +4133,7 @@ exclude_unnecessary_pages(void)
>>  	unsigned int mm;
>>  	unsigned long mem_map;
>>  	unsigned long long pfn, paddr, pfn_mm;
>> +	unsigned long long pfn_read_start, pfn_read_end, index_pg;
>>  	unsigned char *page_cache = NULL, *pcache;
>>  	unsigned int _count;
>>  	unsigned long flags, mapping;
>> @@ -4156,6 +4157,12 @@ exclude_unnecessary_pages(void)
>>  		if (mem_map == NOT_MEMMAP_ADDR)
>>  			continue;
>>  
>> +		/*
>> +		 * Refresh the buffer of struct page, when changing mem_map.
>> +		 */
>> +		pfn_read_start = ULONGLONG_MAX;
>> +		pfn_read_end   = 0;
>> +
>>  		for (; pfn < mmd->pfn_end;
>>  		    pfn++, mem_map += SIZE(page),
>>  		    paddr += info->page_size) {
>> @@ -4166,16 +4173,23 @@ exclude_unnecessary_pages(void)
>>  			if (!is_in_segs(paddr))
>>  				continue;
>>  
>> -			if ((pfn % PGMM_CACHED) == 0) {
>> -				if (pfn + PGMM_CACHED < mmd->pfn_end)
>> -					pfn_mm = PGMM_CACHED;
>> +			index_pg = pfn % PGMM_CACHED;
>> +			if (pfn < pfn_read_start || pfn_read_end < pfn) {
>> +				if (roundup(pfn, PGMM_CACHED) < mmd->pfn_end)
>                                     ~~~~~~~~~~~~~~~~~~~~~~~~~ This is a bug.
> The above should be roundup(pfn + 1, PGMM_CACHED).
> 
> 
> Thanks
> Ken'ichi Ohmichi
> 
> ---
> diff -puN a/makedumpfile.c b/makedumpfile.c
> --- a/makedumpfile.c	2008-09-04 16:31:58.000000000 +0900
> +++ b/makedumpfile.c	2008-09-25 20:27:48.000000000 +0900
> @@ -4133,6 +4133,7 @@ exclude_unnecessary_pages(void)
>  	unsigned int mm;
>  	unsigned long mem_map;
>  	unsigned long long pfn, paddr, pfn_mm;
> +	unsigned long long pfn_read_start, pfn_read_end, index_pg;
>  	unsigned char *page_cache = NULL, *pcache;
>  	unsigned int _count;
>  	unsigned long flags, mapping;
> @@ -4156,6 +4157,12 @@ exclude_unnecessary_pages(void)
>  		if (mem_map == NOT_MEMMAP_ADDR)
>  			continue;
>  
> +		/*
> +		 * Refresh the buffer of struct page, when changing mem_map.
> +		 */
> +		pfn_read_start = ULONGLONG_MAX;
> +		pfn_read_end   = 0;
> +
>  		for (; pfn < mmd->pfn_end;
>  		    pfn++, mem_map += SIZE(page),
>  		    paddr += info->page_size) {
> @@ -4166,16 +4173,24 @@ exclude_unnecessary_pages(void)
>  			if (!is_in_segs(paddr))
>  				continue;
>  
> -			if ((pfn % PGMM_CACHED) == 0) {
> -				if (pfn + PGMM_CACHED < mmd->pfn_end)
> -					pfn_mm = PGMM_CACHED;
> +			index_pg = pfn % PGMM_CACHED;
> +			if (pfn < pfn_read_start || pfn_read_end < pfn) {
> +				if (roundup(pfn + 1, PGMM_CACHED) < mmd->pfn_end)
> +					pfn_mm = PGMM_CACHED - index_pg;
>  				else
>  					pfn_mm = mmd->pfn_end - pfn;
> -				if (!readmem(VADDR, mem_map, page_cache,
> -				    SIZE(page) * pfn_mm))
> +
> +				if (!readmem(VADDR, mem_map,
> +				    page_cache + (index_pg * SIZE(page)),
> +				    SIZE(page) * pfn_mm)) {
> +					ERRMSG("Can't read the buffer of struct page.\n");
>  					goto out;
> +				}
> +				pfn_read_start = pfn;
> +				pfn_read_end   = pfn + pfn_mm - 1;
>  			}
> -			pcache  = page_cache + ((pfn%PGMM_CACHED) * SIZE(page));
> +			pcache  = page_cache + (index_pg * SIZE(page));
> +
>  			flags   = ULONG(pcache + OFFSET(page.flags));
>  			_count  = UINT(pcache + OFFSET(page._count));
>  			mapping = ULONG(pcache + OFFSET(page.mapping));
> 



--===============1341826688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1341826688==--

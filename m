Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fmw8M-0006zR-MJ
 for kexec@lists.infradead.org; Tue, 07 Aug 2018 07:10:24 +0000
Subject: Re: [PATCHv2] makedumpfile: when using refiltering, initialize
 refiltered bitmap2 from the kdump file's bitmap2
References: <1533266198-14693-1-git-send-email-piliu@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03559E66@BPXM09GP.gisp.nec.co.jp>
From: piliu <piliu@redhat.com>
Message-ID: <f79acf25-07d4-695e-9d43-0bad160df00c@redhat.com>
Date: Tue, 7 Aug 2018 15:09:51 +0800
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03559E66@BPXM09GP.gisp.nec.co.jp>
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>



On 08/07/2018 03:56 AM, Kazuhito Hagio wrote:
> Hello Pingfan,
> 
> Thank you for the v2 update.
> 
> On 8/2/2018 11:16 PM, Pingfan Liu wrote:
>> When refiltering on kdump format file, there is no info about pt_load[] for
>> exclude_nodata_pages(), and also we can not expect more data than the kdump
>> file can provide, hence this patch suggests to initialize the refiltered
>> bitmap2 from the kdump file's bitmap2. As for the statics original_pfn, it
>> should also be calculated based on kdump file's bitmap2.
> 
> As for statistics, since we now count up "Excluded pages" even if
> the page is already excluded (the bit is already off in bitmap2), so
> "Remaining pages" (= pfn_original - pfn_excluded) becomes incorrect
> with the patch.
> 
> [first filtering]
> # makedumpfile --message-level 22 -l -d 31 /proc/vmcore dump.ld31
> ...
> Original pages  : 0x000000000007311b
>   Excluded pages   : 0x00000000000694ed
>     Pages filled with zero  : 0x0000000000001442
>     Non-private cache pages : 0x00000000000058ea
>     Private cache pages     : 0x0000000000000000
>     User process data pages : 0x000000000000031f
>     Free pages              : 0x00000000000624a2
>     Hwpoison pages          : 0x0000000000000000
>   Remaining pages  : 0x0000000000009c2e
>   (The number of pages is reduced to 8%.)
> Memory Hole     : 0x000000000000cee5
> --------------------------------------------------
> Total pages     : 0x0000000000080000
> 
> [re-filtering]
> # makedumpfile --message-level 22 -l -d 31 dump.ld31 dump.ld31.ld31
> ...
> Original pages  : 0x000000000000f9e3
>   Excluded pages   : 0x00000000000694ed      <<-- same with the above
>     Pages filled with zero  : 0x0000000000001442
>     Non-private cache pages : 0x00000000000058ea
>     Private cache pages     : 0x0000000000000000
>     User process data pages : 0x000000000000031f
>     Free pages              : 0x00000000000624a2
>     Hwpoison pages          : 0x0000000000000000
>   Remaining pages  : 0xfffffffffffa64f6                 <<-- incorrect
>   (The number of pages is reduced to 288361039747273%.) <<--
> Memory Hole     : 0x0000000000080000
> --------------------------------------------------
> Total pages     : 0x0000000000080000
> 
> 
> So how about counting memory hole with the kdump file's bitmap1
> instead of the bitmap2? i.e. the report shows statistics between
> the original vmcore and the re-filtered kdump file.
> 

Sounds reasonable.
> My comments on this suggestion:
>>
>> Note about the bug reported by the following ops:
>>   makedumpfile -l --message-level 1 -d 31 /proc/vmcore /path/to/vmcore
>>   makedumpfile  --split  -d 31 ./vmcore dumpfile_{1,2,3} 2>&1
>> And get the following error:
>>   Excluding unnecessary pages                       : [100.0 %] \
>>   readpage_kdump_compressed: pfn(9b) is excluded from /var/crash/127.0.0.1-2018-07-02-22:10:38/vmcore.
>>   readmem: type_addr: 1, addr:9b000, size:4096
>>   read_pfn: Can't get the page data.
>>   writeout_multiple_dumpfiles: Child process(2277) finished incompletely.(256)
>>   Copying data                                      : [ 24.6 %] -           eta: 2s
>>   makedumpfile Failed.
>>
>> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
>> Signed-off-by: Pingfan Liu <piliu@redhat.com>
>> ---
>> v1 -> v2
>>  initialized refiltered bitmap2 from file's bitmap2
>>  improve statics of original_pfn
>>
>>  makedumpfile.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 45 insertions(+), 9 deletions(-)
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index 915cbf4..bf2f806 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -6090,26 +6090,59 @@ copy_bitmap_buffer(void)
>>  	return TRUE;
>>  }
>>  
>> +static mdf_pfn_t count_bits(unsigned char *buf, int sz)
>> +{
>> +	unsigned char *p = buf;
>> +	int i, j;
>> +	mdf_pfn_t cnt = 0;
>> +	for (i = 0; i < sz; i++, p++) {
>> +		if (*p == 0)
>> +			continue;
>> +		else if (*p == 0xff)
>> +			cnt += 8;
> 
> should have a continue?
> 
Yes.
>> +		for (j = 0; j < 8; j++) {
>> +			if (*p & 1<<j)
>> +				cnt++;
>> +		}
>> +	}
>> +	return cnt;
>> +}
>> +
>> +static mdf_pfn_t orig_pfn = 0;
> 
> If counting memory hole with bitmap1, orig_pfn is not needed.
> 
>> +
>>  int
>>  copy_bitmap_file(void)
>>  {
>> -	off_t offset;
>> +	off_t base, offset = 0;
>>  	unsigned char buf[info->page_size];
>>   	const off_t failed = (off_t)-1;
>> +	int fd;
>> +	struct disk_dump_header *dh = info->dh_memory;
>>  
>> -	offset = 0;
>> +	if (info->flag_refiltering) {
>> +		fd = info->fd_memory;
>> +		base = info->len_bitmap / 2;
>> +		base +=  (DISKDUMP_HEADER_BLOCKS + dh->sub_hdr_size) * dh->block_size;
>> +		orig_pfn = 0;
>> +	} else {
>> +		fd = info->bitmap1->fd;
>> +		base = info->bitmap1->offset;
>> +	}
>>  	while (offset < (info->len_bitmap / 2)) {
>> -		if (lseek(info->bitmap1->fd, info->bitmap1->offset + offset,
>> -		    SEEK_SET) == failed) {
>> +		if (lseek(fd,  base + offset, SEEK_SET) == failed) {
>>  			ERRMSG("Can't seek the bitmap(%s). %s\n",
>>  			    info->name_bitmap, strerror(errno));
>>  			return FALSE;
>>  		}
>> -		if (read(info->bitmap1->fd, buf, sizeof(buf)) != sizeof(buf)) {
>> +		if (read(fd, buf, sizeof(buf)) != sizeof(buf)) {
>>  			ERRMSG("Can't read the dump memory(%s). %s\n",
>>  			    info->name_memory, strerror(errno));
>>  			return FALSE;
>>  		}
>> +		/* counting the original pfn */
>> +		if (info->flag_refiltering) {
>> +			orig_pfn += count_bits(buf,  sizeof(buf));
>> +		}
> 
> Shall we move this to copy_1st_bitmap_from_memory() and
> do the following?
> 
>     pfn_memhole -= count_bits(buf, sizeof(buf));
> 
OK

Thanks for your kindly review. I will send out v3 soon

Regards,
Pingfan
>>  		if (lseek(info->bitmap2->fd, info->bitmap2->offset + offset,
>>  		    SEEK_SET) == failed) {
>>  			ERRMSG("Can't seek the bitmap(%s). %s\n",
>> @@ -9713,10 +9746,13 @@ print_report(void)
>>  {
>>  	mdf_pfn_t pfn_original, pfn_excluded, shrinking;
>>  
>> -	/*
>> -	 * /proc/vmcore doesn't contain the memory hole area.
>> -	 */
>> -	pfn_original = info->max_mapnr - pfn_memhole;
>> +	if (info->flag_refiltering)
>> +		pfn_original = orig_pfn;
>> +	else
>> +		/*
>> +		 * /proc/vmcore doesn't contain the memory hole area.
>> +		 */
>> +		pfn_original = info->max_mapnr - pfn_memhole;
>>  
>>  	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
>>  	    + pfn_user + pfn_free + pfn_hwpoison;
>>
> 
> Thanks,
> Kazu
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

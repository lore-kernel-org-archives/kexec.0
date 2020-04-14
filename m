Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jOBpb-0004BS-Gr
 for kexec@lists.infradead.org; Tue, 14 Apr 2020 03:01:49 +0000
Subject: Re: [PATCH] makedumpfile: clear mem_map if not in pt_loads
References: <1586749598-1671-1-git-send-email-piliu@redhat.com>
 <OSBPR01MB1991F32564DE2C60C233EC76DDDD0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
From: piliu <piliu@redhat.com>
Message-ID: <8a43526d-aea8-d4de-743e-703e01609396@redhat.com>
Date: Tue, 14 Apr 2020 11:01:30 +0800
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB1991F32564DE2C60C233EC76DDDD0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>



On 04/14/2020 03:09 AM, HAGIO KAZUHITO(萩尾　一仁) wrote:
> Hi Pingfan,
> 
>> -----Original Message-----
>> The crashed kernel passes usable RAM info through pt_loads[], but the
>> current code ignore this, and parse all sections below info->max_mapnr.
>> Refer to code in get_mm_sparsemem()
>>   num_section = divideup(info->max_mapnr, PAGES_PER_SECTION());
>>
>> These ranges can include unwanted memory e.g. reserved-memory for crash
>> kernel, PMEM for fs-dax. Excluding them by setting mem_maps[section_nr]=NULL.
> 
> hmm, I think that bitmap1 corresponds to pt_loads ranges, so even without
> the patch, only the ranges in pt_loads can be included in a dumpfile.
> Am I missing anything?
> 
Check the code, and I think you are right.

Thanks,
Pingfan
> Thanks,
> Kazu
> 
>>
>> Signed-off-by: Pingfan Liu <piliu@redhat.com>
>> ---
>>  elf_info.c     | 12 ++++++++++++
>>  elf_info.h     |  1 +
>>  makedumpfile.c |  5 +++++
>>  3 files changed, 18 insertions(+)
>>
>> diff --git a/elf_info.c b/elf_info.c
>> index 7d72742..297c3e4 100644
>> --- a/elf_info.c
>> +++ b/elf_info.c
>> @@ -1302,3 +1302,15 @@ get_max_file_offset(void)
>>  {
>>  	return max_file_offset;
>>  }
>> +
>> +int phyaddr_in_pt_loads(unsigned long long phys_start)
>> +{
>> +	 struct pt_load_segment *pls;
>> +
>> +	for (int i = 0; i < num_pt_loads; i++) {
>> +		pls = &pt_loads[i];
>> +		if (phys_start >= pls->phys_start && phys_start < pls->phys_end)
>> +			return TRUE;
>> +	}
>> +	return FALSE;
>> +}
>> diff --git a/elf_info.h b/elf_info.h
>> index 934b608..f5bb07c 100644
>> --- a/elf_info.h
>> +++ b/elf_info.h
>> @@ -90,6 +90,7 @@ void get_eraseinfo(off_t *offset, unsigned long *size);
>>  void set_eraseinfo(off_t offset, unsigned long size);
>>
>>  off_t get_max_file_offset(void);
>> +int phyaddr_in_pt_loads(unsigned long long phys_start);
>>
>>  #endif  /* ELF_INFO_H */
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index f5860a1..c0fa075 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -3556,8 +3556,13 @@ get_mm_sparsemem(void)
>>  		goto out;
>>  	}
>>  	for (section_nr = 0; section_nr < num_section; section_nr++) {
>> +		unsigned long phys_start;
>> +
>>  		pfn_start = section_nr * PAGES_PER_SECTION();
>>  		pfn_end   = pfn_start + PAGES_PER_SECTION();
>> +		phys_start = pfn_start << PAGESHIFT();
>> +		if (!phyaddr_in_pt_loads(phys_start))
>> +			mem_maps[section_nr] = (unsigned long)NULL;
>>  		if (info->max_mapnr < pfn_end)
>>  			pfn_end = info->max_mapnr;
>>  		dump_mem_map(pfn_start, pfn_end, mem_maps[section_nr], section_nr);
>> --
>> 2.7.5
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

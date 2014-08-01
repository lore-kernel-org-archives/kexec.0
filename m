Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XD7Cf-00063X-NX
 for kexec@lists.infradead.org; Fri, 01 Aug 2014 07:24:38 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v3] makedumpfile: Exclude unnecessary hugepages.
Date: Fri, 1 Aug 2014 07:12:42 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97246628@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE972430B1@BPXM01GP.gisp.nec.co.jp>
 <20140725060045.GN11399@dhcp-16-105.nay.redhat.com>
In-Reply-To: <20140725060045.GN11399@dhcp-16-105.nay.redhat.com>
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

>Hi Atsushi,
>
>Patch looks good. Only a small concern.
>
>
> +	mdf_pfn_t nr_pages;
>>  	unsigned long index_pg, pfn_mm;
>>  	unsigned long long maddr;
>>  	mdf_pfn_t pfn_read_start, pfn_read_end;
>>  	unsigned char page_cache[SIZE(page) * PGMM_CACHED];
>>  	unsigned char *pcache;
>> -	unsigned int _count, _mapcount = 0;
>> +	unsigned int _count, _mapcount = 0, compound_order = 0;
>>  	unsigned long flags, mapping, private = 0;
>> +	unsigned long hugetlb_dtor;
>                      ~~~~~~~~~~~~~
>>
>>  	/*
>>  	 * If a multi-page exclusion is pending, do it first
>> @@ -4708,11 +4728,36 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>>  		flags   = ULONG(pcache + OFFSET(page.flags));
>>  		_count  = UINT(pcache + OFFSET(page._count));
>>  		mapping = ULONG(pcache + OFFSET(page.mapping));
>> +
>> +		if (index_pg < PGMM_CACHED - 1) {
>> +			compound_order = ULONG(pcache + SIZE(page) + OFFSET(page.lru)
>> +					       + OFFSET(list_head.prev));
>> +			hugetlb_dtor = ULONG(pcache + SIZE(page) + OFFSET(page.lru)
>> +					     + OFFSET(list_head.next));
>
>Here I think the variable should be compound_page_dtor because it could
>be free_compound_page if it's thp or normal huge page. Only if it's a
>hugetlb huge page, it will be free_huge_page. So for removing confusion
>and future extention, it could be named as compound_page_dtor or
>compound_dtor, a more generic name.

Sounds good to me, I'll fix it in the next version.


Thanks
Atsushi Kumagai.

>Thanks
>Baoquan
>
>
>> +
>> +			if (compound_order &&
>> +			    ((compound_order >= sizeof(unsigned long) * 8)
>> +			     || (pfn & ((1UL << compound_order) - 1)) != 0)) {
>> +				/* Invalid order */
>> +				compound_order = 0;
>> +			}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

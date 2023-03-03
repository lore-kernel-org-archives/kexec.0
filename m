Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE55C7EE36
	for <kexec@archiver.kernel.org>; Fri,  3 Mar 2023 11:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=26C8vh45pewTIEItBx3DKL+vpqJRAKB8t/uS1Jr4ZvQ=; b=dcOZui+wioytYpL+RilFVff5hX
	2I11vpxbrGrrjJAPRfntx8wNt/byBrhxIWhbBJ2J7nQwR5y8Lid41d+ZbmRm5CS12FWB7xOh36LvI
	h5yScvknR1rbjDnPz6/+V2qTFPQzCJ7X5UFbW5j7ogyB76R0D7CiGeXYAVs4nB3NSx4v8iu5i9Vji
	rJIF32zp910jiEJOO1xf12v5yPBvKs3hx68v9yAFIRqTflf5YfXQm5vAriPLDQ6sE0xGZdYWMwdGv
	/NN5EUazh3+ZtE89mFPRXK7eLMU14nw+qwKmIJpQdPMlWB2WukreBi+xjVDyrxzeEtHntMeiWkfVu
	jtg86cqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY3bQ-0069E6-NG; Fri, 03 Mar 2023 11:29:32 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY3bM-006977-Rc; Fri, 03 Mar 2023 11:29:31 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PSm2j1cP8znVcr;
	Fri,  3 Mar 2023 19:29:17 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 19:29:18 +0800
Subject: Re: [PATCH v3] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
To: Baoquan He <bhe@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
	<horms@kernel.org>, <John.p.donnelly@oracle.com>, <will@kernel.org>,
	<kexec@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>
References: <20230223124532.128744-1-bhe@redhat.com>
 <7971ddbe-aefb-271e-647c-59d81c5840a7@huawei.com>
 <ZAFi/+J7WITdcUWb@MiWiFi-R3L-srv>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b26641a4-1df4-19bf-50c7-6411da7cdb97@huawei.com>
Date: Fri, 3 Mar 2023 19:29:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZAFi/+J7WITdcUWb@MiWiFi-R3L-srv>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_032929_269272_7C7E78B2 
X-CRM114-Status: GOOD (  16.01  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 2023/3/3 11:01, Baoquan He wrote:
> On 03/02/23 at 11:32am, Leizhen (ThunderTown) wrote:
> ......
>>> @@ -166,31 +169,51 @@ static void __init reserve_crashkernel(void)
>>>  	/* User specifies base address explicitly. */
>>>  	if (crash_base) {
>>>  		fixed_base = true;
>>> +		search_base = crash_base;
>>>  		crash_max = crash_base + crash_size;
>>>  	}
>>>  
>>>  retry:
>>>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>> -					       crash_base, crash_max);
>>> +					       search_base, crash_max);
>>>  	if (!crash_base) {
>>>  		/*
>>> -		 * If the first attempt was for low memory, fall back to
>>> -		 * high memory, the minimum required low memory will be
>>> -		 * reserved later.
>>> +		 * For crashkernel=size[KMG]@offset[KMG], print out failure
>>> +		 * message if can't reserve the specified region.
>>>  		 */
>>> -		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
>>> +		if (fixed_base) {
>>> +			pr_info("crashkernel reservation failed - memory is in use.\n");
>>
>> How about changing pr_info to pr_warn?
>>
>>> +			return;
>>> +		}
>>> +
>>> +		/*
>>> +		 * For crashkernel=size[KMG], if the first attempt was for
>>> +		 * low memory, fall back to high memory, the minimum required
>>> +		 * low memory will be reserved later.
>>> +		 */
>>> +		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
>>>  			crash_max = CRASH_ADDR_HIGH_MAX;
>>> +			search_base = CRASH_ADDR_LOW_MAX;
>>>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>>  			goto retry;
>>>  		}
>>>  
>>> +		/*
>>> +		 * For crashkernel=size[KMG],high, if the first attempt was
>>> +		 * for high memory, fall back to low memory.
>>> +		 */
>>> +		if (high && crash_max == CRASH_ADDR_HIGH_MAX) {
>>
>> Adding unlikely to indicate that it is rare would be better.
>>
>> if (unlikely(high && crash_max == CRASH_ADDR_HIGH_MAX))
> 
> Rethink about this and checked code in kernel, seems likely|unlikely are
> mostly used in highly frequent execution branch optimize code path, while 
> crashkernel resevatoin is one time execution during boot, we may not
> need to bother to add unlikely. What do you think?

OK.

> 
> 
>>
>>> +			crash_max = CRASH_ADDR_LOW_MAX;
>>> +			search_base = 0;
>>> +			goto retry;
>>> +		}
>>>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>>>  			crash_size);
>>>  		return;
>>>  	}
>>>  
>>> -	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
>>> -	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>>> +	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
>>> +	     reserve_crashkernel_low(crash_low_size)) {
>>>  		memblock_phys_free(crash_base, crash_size);
>>>  		return;
>>>  	}
>>>
>>
>> -- 
>> Regards,
>>   Zhen Lei
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

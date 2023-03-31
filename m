Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3251FC6FD18
	for <kexec@archiver.kernel.org>; Fri, 31 Mar 2023 11:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f9HmfSUNDT8KC2tYiNJFdqT36QHqmfVff3+zhx6bAX0=; b=JZ0KYgEldXaoLv
	jw+aIjpSlsWMQIWcCevaUtDdtH+xkpj7bhQM5bQ/NpkgsNW1/tKc58xBeVgZcUD+4hZ8Kz9PVDgd7
	B9haPfeSxJSlKrp6e1hMVUJZxgt8cUV0v5kDT4vdseshluJ5NgbqhxLENJuCIFMKshJDhOpH7eOxk
	5LYona7lmOQI0lie72jCeUyTeV/F1B4A3STyW6pUwBDcArcA7ELfEkwitXHDbYt3BWzbCgjDGKqF/
	s3wAWjUHA9CNYm3OJggmDiAGxtGtQ7TBb/ialpnPoTjcMjJezxCtLfyCfvDxV+oJpjg4zAY5pShX1
	IsPvYsmdkf7wABbl8D9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1piD3y-0079Nl-0K;
	Fri, 31 Mar 2023 11:36:58 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1piD3r-0079LN-00;
	Fri, 31 Mar 2023 11:36:57 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PnypX3DWVz17RGV;
	Fri, 31 Mar 2023 19:33:24 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 31 Mar
 2023 19:36:42 +0800
Message-ID: <f1fcf149-4d40-f10e-39d4-6580f025629c@huawei.com>
Date: Fri, 31 Mar 2023 19:36:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v2 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <thunder.leizhen@huawei.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <20230328115150.2700016-1-chenjiahao16@huawei.com>
 <20230328115150.2700016-2-chenjiahao16@huawei.com>
 <ZCQewkvSpaI52DSM@MiWiFi-R3L-srv>
 <b8a32e3c-c083-20de-16d1-f628b02b739b@huawei.com>
 <ZCYcJos4MLBvpP9/@MiWiFi-R3L-srv>
From: "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <ZCYcJos4MLBvpP9/@MiWiFi-R3L-srv>
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230331_043655_040738_F02D3898 
X-CRM114-Status: GOOD (  13.01  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


On 2023/3/31 7:32, Baoquan He wrote:
> On 03/30/23 at 09:40pm, chenjiahao (C) wrote:
> ......
>> Agreed, I will clean this up later in next version.
>>>> +		if (ret || !crash_size)
>>>> +			return;
>>>> +
>>>> +		/*
>>>> +		 * crashkernel=Y,low is valid only when crashkernel=X,high
>>>> +		 * is passed and high memory is reserved successful.
>>>> +		 */
>>>> +		ret = parse_crashkernel_low(boot_command_line, 0, &crash_low_size, &crash_base);
>>>> +		if (ret == -ENOENT)
>>>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>>> +		else if (ret)
>>>> +			return;
>>>> +
>>>> +		search_start = dma32_phys_limit;
>>>> +	} else if (ret || !crash_size) {
>>>> +		/* Invalid argument value specified */
>>>>    		return;
>>>> +	}
>>>>    	crash_size = PAGE_ALIGN(crash_size);
>>>> @@ -1201,16 +1246,26 @@ static void __init reserve_crashkernel(void)
>>>>    	 */
>>>>    	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>>>>    					       search_start,
>>>> -					       min(search_end, (unsigned long) SZ_4G));
>>>> +					       min(search_end, (unsigned long)dma32_phys_limit));
>>>>    	if (crash_base == 0) {
>>> The above conditional check isn't right. If crashkernel=size@offset
>>> specified, the reservation failure won't trigger retry. This seems to be
>>> originally introduced by old commit, while this need be fixed firstly.
>> Just a little curious about the rule to cope with this specific case. If
>> "crashkernel=size@offset" was passed
>>
>> but reserve failed, should try again to allocate in high memory, regardless
>> the specified size@offset,
>>
>> or just throw a warning and return? Since I noticed the current logic here
>> on Arm64 is to check if !fixed_base first
> Yeah, we need mark the "crashkernel=size@offset" case and avoid to
> retry. Because you won't succeed if  memblock has already failed to
> reserve an unavailable memory region, retry is meaningless. This has
> been done in x86, arm64.

Make sense, thanks.

Actually, in my previous tests, the result in this case is the same
as expectation, i.e. when allocating "crashkernel=size@offset" failed
on low memory, it would retry but return on failure. Since the
search_end is assigned with offset + size, which is lower than DMA32
limit, the second allocation is definitely invalid.

But for sure, to make the code easy to read and eradicate other
possible corner cases, I will check if !fixed_base first on retry.

>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

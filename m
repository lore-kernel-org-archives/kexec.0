Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57BFC77B61
	for <kexec@archiver.kernel.org>; Mon, 10 Apr 2023 09:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r91JprT7xerIPSLDaDrWtPBoRP6174P53zgJ2G+nWf4=; b=ZmLnnHDmEuKjby
	mGHOIkAk8RQGQl7d9EgQJI8dcND6+NpcYNEPEs5wsXBzNMarMqnhF5fF2i9IiVGR3+w7gwhJv91x/
	30xQzRgce00IMrKWhehqBd1kIeI0MFV+Avz3smBHAUduN540qBTndE0VqSSXJTX/sPQxO7fEbtSWM
	GhMKlOrCjLwzFdvlcQ1usVWdtyTTBuS+WARIyjJJ0UwX7qVBImsGehSuIhArLYmvBLejjDVktbBaJ
	QYsebnLNVXCOecYc+3goKrYXJgFbvwgWYnnkTLDlAO17Op8CYynxzVwd8ypriQsvzD5Z2UMPGobcV
	HKhOECkGvUp9JPt0ZmyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1plnhk-00ErzH-2h;
	Mon, 10 Apr 2023 09:20:52 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1plnhe-00Ery0-1X;
	Mon, 10 Apr 2023 09:20:48 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pw3J43tTdzSqbK;
	Mon, 10 Apr 2023 17:16:36 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Apr
 2023 17:20:29 +0800
Message-ID: <826e8733-2f02-e0db-ee34-a6ae0cadb040@huawei.com>
Date: Mon, 10 Apr 2023 17:20:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v3 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
To: Simon Horman <horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <bhe@redhat.com>, <thunder.leizhen@huawei.com>
References: <20230406220206.3067006-1-chenjiahao16@huawei.com>
 <20230406220206.3067006-2-chenjiahao16@huawei.com>
 <ZDAGi2/+1q0oEUZ5@kernel.org>
Content-Language: en-US
From: "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <ZDAGi2/+1q0oEUZ5@kernel.org>
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_022046_699156_ACB32A76 
X-CRM114-Status: GOOD (  15.10  )
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


On 2023/4/7 20:03, Simon Horman wrote:
> On Fri, Apr 07, 2023 at 06:02:05AM +0800, Chen Jiahao wrote:
>> On riscv, the current crash kernel allocation logic is trying to
>> allocate within 32bit addressible memory region by default, if
>> failed, try to allocate without 4G restriction.
>>
>> In need of saving DMA zone memory while allocating a relatively large
>> crash kernel region, allocating the reserved memory top down in
>> high memory, without overlapping the DMA zone, is a mature solution.
>> Here introduce the parameter option crashkernel=X,[high,low].
>>
>> One can reserve the crash kernel from high memory above DMA zone range
>> by explicitly passing "crashkernel=X,high"; or reserve a memory range
>> below 4G with "crashkernel=X,low".
>>
>> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> ...
>
>> @@ -1180,14 +1206,37 @@ static void __init reserve_crashkernel(void)
>>   		return;
>>   	}
>>   
>> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>>   				&crash_size, &crash_base);
>> -	if (ret || !crash_size)
>> +	if (ret == -ENOENT) {
>> +		/*
>> +		 * crashkernel=X,[high,low] can be specified or not, but
>> +		 * invalid value is not allowed.
> nit: Perhaps something like this would be easier to correlate with the
>       code that follows:
>
> 		/* Fallback to crashkernel=X,[high,low] */
>
Agreed, this would be more concise and accurate.
>> +		 */
>> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
>> +		if (ret || !crash_size)
>> +			return;
>> +
>> +		/*
>> +		 * crashkernel=Y,low is valid only when crashkernel=X,high
>> +		 * is passed and high memory is reserved successful.
> nit: s/successful/successfully/

I will fix above nits and resend another version later, thanks.


>> +		 */
>> +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
>> +		if (ret == -ENOENT)
>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> +		else if (ret)
>> +			return;
>> +
>> +		search_start = search_low_max;
>> +	} else if (ret || !crash_size) {
>> +		/* Invalid argument value specified */
>>   		return;
>> +	}
> ...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

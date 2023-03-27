Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1DCC7619A
	for <kexec@archiver.kernel.org>; Mon, 27 Mar 2023 12:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4CBXM2WClLylfqGHpp3TKIewSj6KONGiI1qgNETNqV4=; b=3YFHeszLA49ppQ
	oQhSbVJRg5TlmSOlgmnKddGSKoqaOno2eqrui1aRUqYqo7vYJtu8sqWPVUkKlskAvFoYi+jebGm96
	JeNWjXl6BWkMNPNycOzeAVoF0/GR6PBWGFcKp5B4/3zn4h75Iu0Z5E9trCYG4/NH+p0NjEe1UEu/k
	/tmXL1cn8tGCLjyW3oaEoKs26+or72tEn1SSttmUGgNf4VQHh1qwrq7s5D/1eurmAKXlTMzNGYiXh
	MW79GwyhzfWTOgw/JZp+9fOngYC9OhZKncM1PHgFEvMQF1VHUDcBS+Ji6ZTgLhQ8TTHL3DYvZ+DS0
	TqaI1dyCexYB7EPHg7qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgmJQ-00B0HT-0C;
	Mon, 27 Mar 2023 12:51:00 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgmJL-00B0F3-22;
	Mon, 27 Mar 2023 12:50:57 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PlXdt52LRznZ50;
	Mon, 27 Mar 2023 20:47:30 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 27 Mar
 2023 20:50:44 +0800
Message-ID: <8bf91bee-e51c-90f6-b522-1db4094966f4@huawei.com>
Date: Mon, 27 Mar 2023 20:50:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <bhe@redhat.com>, <thunder.leizhen@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <20230320204244.1637821-1-chenjiahao16@huawei.com>
 <20230320204244.1637821-2-chenjiahao16@huawei.com>
 <ZBhvhBTQhAnN5qdm@kernel.org>
From: "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <ZBhvhBTQhAnN5qdm@kernel.org>
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_055056_016428_8138D80C 
X-CRM114-Status: GOOD (  16.60  )
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


On 2023/3/20 22:36, Simon Horman wrote:
> On Tue, Mar 21, 2023 at 04:42:43AM +0800, Chen Jiahao wrote:
>> On riscv, the current crash kernel allocation logic is trying to
>> allocate within 32bit addressible memory region by default, if
>> failed, try to allocate without 4G restriction.
>>
>> In need of saving DMA zone memory while allocating a relatively large
>> crash kernel region, allocating the reserved memory top down in
>> high memory, without overlapping the DMA zone, is a mature solution.
>> Here introduce the parameter option crashkernel=X,[high,low].
>>
>> We can reserve the crash kernel from high memory above DMA zone range
>> by explicitly passing "crashkernel=X,high"; or reserve a memory range
>> below 4G with "crashkernel=X,low".
>>
>> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> Some minor nits, but I don't think there is any need to respin for them.
>
> Reviewed-by: Simon Horman <horms@kernel.org>

I will send another version and clean up these by the way, thanks.

Chen, Jiahao


>
> ...
>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 478d6763a01a..5def2174b243 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
> ...
>
>> @@ -1201,16 +1242,25 @@ static void __init reserve_crashkernel(void)
>>   	 */
>>   	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>>   					       search_start,
>> -					       min(search_end, (unsigned long) SZ_4G));
>> +					       min(search_end, (unsigned long) dma32_phys_limit));
> nit: While here, you could drop the space before 'ma32_phys_limit'.
>       Or perhaps use min_t, which seems appropriate here.
>
>>   	if (crash_base == 0) {
>>   		/* Try again without restricting region to 32bit addressible memory */
>>   		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>> -						search_start, search_end);
>> +						       search_start, search_end);
>>   		if (crash_base == 0) {
>>   			pr_warn("crashkernel: couldn't allocate %lldKB\n",
>>   				crash_size >> 10);
>>   			return;
>>   		}
>> +
>> +		if (!crash_low_size)
>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> +	}
>> +
>> +	if ((crash_base > dma32_phys_limit - crash_low_size) &&
>> +	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> nit: The line above should be aligned one character to the left
>       (remove one space in the indent).
>
>> +		memblock_phys_free(crash_base, crash_size);
>> +		return;
>>   	}
>>   
>>   	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
> ...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

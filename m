Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A5AC43334
	for <kexec@archiver.kernel.org>; Fri, 17 Jun 2022 07:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ivCUneOBR6h+2p37VSdsggkToXh7DePKFYDCkPwpl6Y=; b=fkd3IPPKzPgJgwEnm5Xh3yMW43
	gKKO25LKh/PcQNiEj9ZHyGxXuJWMaSIZdoSvGhrFTOxqmIb3OKaAMcCeJRk6WrzzBwuuVofFMQwx+
	kMKzMiuVQrbButnk5+hty8HYtVaf0YPPjqELwp7Qn4pvPONbb00e24Ny+dzkBH3u2vV/PlCUcCxRR
	Qu3OXRYPpRX2/F24Q0BysFSeBwjLbeKtjwJ8D508SU4XTiI0HmOJ6ngcLK7L8rpUlEHVx6IDVhALI
	n8EecYkSTQjs3Qym33S4Qlhvyb0oGaqO7LyVyz3nE7RaZ6OXtO/+EHYMCJS738rSNlE/OjY4URNuJ
	nOY3xBzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o26k2-0066lG-Ki; Fri, 17 Jun 2022 07:50:06 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o26Zf-0061V5-2P; Fri, 17 Jun 2022 07:39:25 +0000
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LPW8Q0yF8zhXb1;
	Fri, 17 Jun 2022 15:37:10 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 15:39:08 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 15:39:07 +0800
Subject: Re: [PATCH 1/5] arm64: kdump: Provide default size when
 crashkernel=Y,low is not specified
To: Baoquan He <bhe@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, Rob Herring
	<robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	<devicetree@vger.kernel.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal
	<vgoyal@redhat.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>, "John
 Donnelly" <John.p.donnelly@oracle.com>, Dave Kleikamp
	<dave.kleikamp@oracle.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-2-thunder.leizhen@huawei.com>
 <20220617024042.GC234358@MiWiFi-R3L-srv>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <26bb3d13-fb8b-3e1d-2529-31d34d3c1c1d@huawei.com>
Date: Fri, 17 Jun 2022 15:39:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220617024042.GC234358@MiWiFi-R3L-srv>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_003923_494172_19D21D0D 
X-CRM114-Status: GOOD (  25.16  )
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



On 2022/6/17 10:40, Baoquan He wrote:
> On 06/13/22 at 04:09pm, Zhen Lei wrote:
>> To be consistent with the implementation of x86 and improve cross-platform
>> user experience. Try to allocate at least 256 MiB low memory automatically
>> when crashkernel=Y,low is not specified.
> 
> This should correspond to the case that crashkernel=,high is explicitly
> specified, while crashkenrel=,low is omitted. It could be better to
> mention these.

Okay, I'll update the description in the next version.

> 
> Otherwise, this looks good to me.
> 
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  8 +-------
>>  arch/arm64/mm/init.c                            | 12 +++++++++++-
>>  2 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 8090130b544b070..61b179232b68001 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -843,7 +843,7 @@
>>  			available.
>>  			It will be ignored if crashkernel=X is specified.
>>  	crashkernel=size[KMG],low
>> -			[KNL, X86-64] range under 4G. When crashkernel=X,high
>> +			[KNL, X86-64, ARM64] range under 4G. When crashkernel=X,high
>                         ~~~~ exceeds 80 characters, it should be OK.
> 
>>  			is passed, kernel could allocate physical memory region
>>  			above 4G, that cause second kernel crash on system
>>  			that require some amount of low memory, e.g. swiotlb
>> @@ -857,12 +857,6 @@
>>  			It will be ignored when crashkernel=X,high is not used
>>  			or memory reserved is below 4G.
>>  
>> -			[KNL, ARM64] range in low memory.
>> -			This one lets the user specify a low range in the
>> -			DMA zone for the crash dump kernel.
>> -			It will be ignored when crashkernel=X,high is not used
>> -			or memory reserved is located in the DMA zones.
>> -
>>  	cryptomgr.notests
>>  			[KNL] Disable crypto self-tests
>>  
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 339ee84e5a61a0b..5390f361208ccf7 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -96,6 +96,14 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
>>  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
>>  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
>>  
>> +/*
>> + * This is an empirical value in x86_64 and taken here directly. Please
>> + * refer to the code comment in reserve_crashkernel_low() of x86_64 for more
>> + * details.
>> + */
>> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	\
>> +	max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)
>> +
>>  static int __init reserve_crashkernel_low(unsigned long long low_size)
>>  {
>>  	unsigned long long low_base;
>> @@ -147,7 +155,9 @@ static void __init reserve_crashkernel(void)
>>  		 * is not allowed.
>>  		 */
>>  		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
>> -		if (ret && (ret != -ENOENT))
>> +		if (ret == -ENOENT)
>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> +		else if (ret)
>>  			return;
>>  
>>  		crash_max = CRASH_ADDR_HIGH_MAX;
>> -- 
>> 2.25.1
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

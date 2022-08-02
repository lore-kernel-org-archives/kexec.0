Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7049EC00140
	for <kexec@archiver.kernel.org>; Tue,  2 Aug 2022 10:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=B8i/9RwgcuTvisQsi+m/cRhjLs7PD0DLFfIVgScIOMg=; b=Jy/9EBrugL7/nrr1gs3eShnPXO
	svXR0BfgAdxCXdnVL/mKKoxYB051vkChJE1c+h+Zv1pvelbAvOxXjpz9cH4d9uxELq/9MDfs1o6go
	Re3ClgtKkl+nVB3uxKlOWfbhtNvs49ZGdSIaN7+k6ebzbYFHaNSoOUohL75Px2lgWNTi9v/3ei4P2
	qQUpArv74dVgh30ktK9PABwfN1Hfu85YdjZi9FQryxGbGXmRtFaLPtEg127kAWFuQczzFfpo/rbIP
	cZpuDqXYD7ZgnL3ff3TJ20rpBJQNzO1PB2uTnIjRsuO/2SizwVqK27kAHaY5dX2qGWLT4hK1XepCJ
	ioTfVqFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIotb-00Cn4k-Vn; Tue, 02 Aug 2022 10:13:04 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIotW-00Cmxe-Ll; Tue, 02 Aug 2022 10:13:02 +0000
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LxrMK1cbwz1M8Kp;
	Tue,  2 Aug 2022 18:09:49 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 18:12:50 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 18:12:49 +0800
Subject: Re: [PATCH v3 1/2] arm64: kdump: Provide default size when
 crashkernel=Y,low is not specified
To: Will Deacon <will@kernel.org>
CC: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal
	<vgoyal@redhat.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou
	<dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>, "Dave
 Kleikamp" <dave.kleikamp@oracle.com>, <ardb@kernel.org>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <20220711090319.1604-2-thunder.leizhen@huawei.com>
 <20220802083703.GA26962@willie-the-truck>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <bc2830f7-7c3c-30ea-0178-ad86922f8f5c@huawei.com>
Date: Tue, 2 Aug 2022 18:12:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220802083703.GA26962@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220802_031259_303387_15A61DBC 
X-CRM114-Status: GOOD (  28.02  )
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



On 2022/8/2 16:37, Will Deacon wrote:
> On Mon, Jul 11, 2022 at 05:03:18PM +0800, Zhen Lei wrote:
>> To be consistent with the implementation of x86 and improve cross-platform
>> user experience. Try to allocate at least 256 MiB low memory automatically
>> for the case that crashkernel=,high is explicitly specified, while
>> crashkenrel=,low is omitted.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  8 +-------
>>  arch/arm64/mm/init.c                            | 12 +++++++++++-
>>  2 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 2522b11e593f239..65a2c3a22a4b57d 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -843,7 +843,7 @@
>>  			available.
>>  			It will be ignored if crashkernel=X is specified.
>>  	crashkernel=size[KMG],low
>> -			[KNL, X86-64] range under 4G. When crashkernel=X,high
>> +			[KNL, X86-64, ARM64] range under 4G. When crashkernel=X,high
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
> 
> Honestly, I read that comment and I'm none the wiser. What does "due to
> mapping restrictions" mean? The remainder of the comment appears to be

Because the comments you read is addressed to CRASH_ADDR_LOW_MAX, not
for DEFAULT_CRASH_KERNEL_LOW_SIZE. Please see the following patch:

94fb9334182284 x86/crash: Allocate enough low memory when crashkernel=high

> specific to x86 and refers to jump ranges with 5-level page-tables.
> 
>> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	\
>> +	max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)
> 
> So why does this value make sense for arm64? We have considerable platform
> fragmentation^Wdiversity compared to x86 and picking a one-size-fits-all
> default is more likely to cause weird problems when it doesn't work imo. I'd
> actually prefer that the default is something that fails obviously (e.g. 0)
> and we force an appropriate size to be specified.
> 
> On the other hand, if you can convince me that having a global constant is
> the right way forward, then please move this out of the arch code.

Yes, the default value may not be the same as that of x86. For example,
128 MB may be sufficient.

So we need to discuss first, do we need a default value? Personally, I
don't think it hurts.

> 
> Will
> .
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

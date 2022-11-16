Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B942C4332F
	for <kexec@archiver.kernel.org>; Wed, 16 Nov 2022 11:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QrEIorFHbh04WfJHoDS8LgOn5HgxcTl0hlXZecbURuU=; b=4AWOBMHNXlu2rUzsrTipRx60m/
	osXgV8jLnOqbzBQobnH098Dk9Ulh0IQVKOknopxsB9WMPN6gl8bdzktBvbzIsAbFRbaSqoP2eistG
	HVbhxhIwjuWoObmVqfYK/f4fapWLJRgoI9O7lbSncgPeJWyMDkP58jn7kOnh9iZ5TvjaBFZMyw4zp
	ST3b1zI9R+RR5dXHA0CnKvdKYbgZX1CFJQEoNgfNe/RiqYFflph1okBGNt8iFem8tJC8zIjHvGiMH
	eXDy8v+SDIjPq4JMwB1VQXqzsEulUYJBvghEThniS0YnWiLxfHrbzHZdNViQTzdmweSZl31kD6QUZ
	Jf/PEKfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovGvr-0038KM-3y; Wed, 16 Nov 2022 11:50:19 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovGvk-00383y-Jd; Wed, 16 Nov 2022 11:50:15 +0000
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NC1Tk0vqbzqSTl;
	Wed, 16 Nov 2022 19:46:18 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 19:50:06 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 19:50:05 +0800
Subject: Re: [PATCH v3 1/2] arm64: kdump: Provide default size when
 crashkernel=Y,low is not specified
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal
	<vgoyal@redhat.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou
	<dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>, "Dave
 Kleikamp" <dave.kleikamp@oracle.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <20220711090319.1604-2-thunder.leizhen@huawei.com> <Y2kRC7JALMQQRsxE@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <7c474745-1bec-93d6-0b82-9171e8149c0d@huawei.com>
Date: Wed, 16 Nov 2022 19:50:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y2kRC7JALMQQRsxE@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_035012_860664_32E8F61A 
X-CRM114-Status: GOOD (  20.56  )
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



On 2022/11/7 22:07, Catalin Marinas wrote:
> On Mon, Jul 11, 2022 at 05:03:18PM +0800, Zhen Lei wrote:
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
> 
> I agree with Will here, we need a better comment and we might as well
> change the default value to something else until someone tells us that
> the default is not large enough. The default swiotlb size is 64M, so we
> need to cover that. The extra 8MB for any additional low allocations are
> ok as well but the 256MB doesn't make much sense to me, or at least not
> together with the rest.
> 
> If the main kernel got a command line option for a larger swiotlb, does
> the crash kernel boot with the same command line? If not, we can just go

Sometimes the image is shared, but the command line is often different.
The command line of the crash kernel is specified by kexec --append=.

> for a fixed 128M value here, which is double the default swiotlb buffer.

Sorry, I missed this e-mail. Yes, fixed 128M would be better. I haven't
seen anyone adding "swiotlb=" to the crash kernel. And, if the default size
isn't enough, he can use crashkernel=Y,low.

> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

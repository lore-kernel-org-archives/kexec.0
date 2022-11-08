Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4D9C4332F
	for <kexec@archiver.kernel.org>; Tue,  8 Nov 2022 02:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=B831p0WXRApj+EYGhYxVGMW252SpWUePkKUPTlZTxLE=; b=fA+mGzWzgVz5SdprSFLLT2ChG+
	bByZ/8cinKxdma0JJN8knV4Zjv5MYDAKbws96YydT531uXxUyrRqpmUGWXsJgrZ9itRIh9Sn4HGQL
	BnJE0IP5rM96AyRzcWeNbaDO1b2ks/uK8t79lSLrhPoo1ih8OPtuGIrck1zJWUPPBM3o0dSTHlcmQ
	ouQuz4ed10wvl3Ku3RDKpi73rBfx9NRZSmZzHnvyAvG8IthIiVMH4jcAhIiCQGUCI/O4EqHVGPiW1
	dJsAYp2yPOnEgabPaJCWxahGr5Lp/6YKVJNAOKPp4+ISdJO0OkZop+7fwg1h2uLE6dPH8D/2mCNs5
	H3hDHsjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osE0y-001wNe-QD; Tue, 08 Nov 2022 02:07:00 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osE0t-001wLk-LR; Tue, 08 Nov 2022 02:06:57 +0000
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N5rx81X4gzJnYV;
	Tue,  8 Nov 2022 10:03:40 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 10:06:40 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 10:06:39 +0800
Subject: Re: [PATCH v3 2/2] arm64: kdump: Support crashkernel=X fall back to
 reserve region above DMA zones
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
 <20220711090319.1604-3-thunder.leizhen@huawei.com> <Y2k8yuUghrbQE6da@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6b20a203-6aab-2b87-9b95-814aeb79b5bd@huawei.com>
Date: Tue, 8 Nov 2022 10:06:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y2k8yuUghrbQE6da@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_180656_086683_A2F4A5C9 
X-CRM114-Status: GOOD (  19.65  )
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



On 2022/11/8 1:13, Catalin Marinas wrote:
> On Mon, Jul 11, 2022 at 05:03:19PM +0800, Zhen Lei wrote:
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 5390f361208ccf7..8539598f9e58b4d 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -138,6 +138,7 @@ static void __init reserve_crashkernel(void)
>>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>>  	char *cmdline = boot_command_line;
>>  	int ret;
>> +	bool fixed_base;
>>  
>>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>>  		return;
>> @@ -166,15 +167,28 @@ static void __init reserve_crashkernel(void)
>>  		return;
>>  	}
>>  
>> +	fixed_base = !!crash_base;
>>  	crash_size = PAGE_ALIGN(crash_size);
>>  
>>  	/* User specifies base address explicitly. */
>> -	if (crash_base)
>> +	if (fixed_base)
>>  		crash_max = crash_base + crash_size;
> 
> Not a fan of '!!', it is converted automatically. If you don't like the
> conversion, just initialise fixed_base to false and here:
> 
> 	if (crash_base) {
> 		fixed_base = true;

OK, This way would be better.

> 		crash_max = crash_base + crash_size;
> 	}
> 
>> +retry:
>>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>  					       crash_base, crash_max);
>>  	if (!crash_base) {
>> +		/*
>> +		 * Attempt to fully allocate low memory failed, fall back
>> +		 * to high memory, the minimum required low memory will be
>> +		 * reserved later.
>> +		 */
> 
> I'm not sure this comment makes sense. If !crash_base, it doesn't mean
> the kernel failed to fully allocate low memory. crash_max here could be
> CRASH_ADDR_HIGH_MAX if crashkerne=X,high was specified. Maybe says
> something like "If the first attempt was for low memory, fall back to
> high ..."

This description is accurate. I'll update. Thanks.

> 
>> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
>> +			crash_max = CRASH_ADDR_HIGH_MAX;
>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> +			goto retry;
>> +		}
> 
> The retry logic looks fine, it only happens once as crash_max is
> updated.
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

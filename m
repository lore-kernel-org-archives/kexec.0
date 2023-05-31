Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36689C77B73
	for <kexec@archiver.kernel.org>; Wed, 31 May 2023 02:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VKRK/kC0fPNryGpabm/8sp+bEOru3JNEXU4/mvRci3c=; b=huOsx3gYS3JuwVOuwyGDME/Lsc
	3tNRM9VgPAMUgc3wEdH67NIFTjXd9iOvFcVO9a935IEkphLWxYtGbQL2J8Ml5esl826Uby6eMvy0E
	9l6kAJa/UCjoVLKGd6eDW33soV1UToag1w6lS20yq7TfU1cfAMw+2iW03YUg9GFJU4q49HEg31liM
	MRd0VwQsuWWVb9chw2HCvRBvUno71zhQ/NI3s+76xjaICawhweLsYSRebb6JnI+uBPD2sqnjuUNZS
	8Y67UqMEY91RfD/rJlutYrlfOCwiznO0K4RhpP4ZsGFBeG3imRD2kZJwnPT8pjFta+nC29CVutdp5
	aoBfuANg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4BRS-00Fmba-2z;
	Wed, 31 May 2023 02:20:02 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4BRP-00FmZT-1d
	for kexec@lists.infradead.org;
	Wed, 31 May 2023 02:20:01 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QWCdV68m0zTkwp;
	Wed, 31 May 2023 10:19:42 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 10:19:52 +0800
Subject: Re: [PATCH 2/6] kexec: delete a useless check in
 crash_shrink_memory()
To: Baoquan He <bhe@redhat.com>
CC: Eric Biederman <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Michael Holzheu <holzheu@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-3-thunder.leizhen@huawei.com>
 <ZHaSF4EGNwSGhGAL@MiWiFi-R3L-srv>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5beb1883-5391-1b75-d8cd-2152478b9e72@huawei.com>
Date: Wed, 31 May 2023 10:19:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZHaSF4EGNwSGhGAL@MiWiFi-R3L-srv>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_191959_714611_6CCF63BA 
X-CRM114-Status: GOOD (  18.24  )
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



On 2023/5/31 8:17, Baoquan He wrote:
> On 05/27/23 at 08:34pm, Zhen Lei wrote:
>> The check '(crashk_res.parent != NULL)' is added by
>> commit e05bd3367bd3 ("kexec: fix Oops in crash_shrink_memory()"), but it's
>> stale now. Because if 'crashk_res' is not reserved, it will be zero in
>> size and will be intercepted by the above 'if (new_size >= old_size)'.
>>
>> Ago:
>> 	if (new_size >= end - start + 1)
>>
>> Now:
>> 	old_size = (end == 0) ? 0 : end - start + 1;
>> 	if (new_size >= old_size)
> 
> Hmm, I would strongly suggest we keep that check. Even though the
> current code like above can do the acutal checking, but its actual usage
> is not obvious for checking of crashk_res existence. In the future,
> someone may change above calculation and don't notice the hidden
> functionality at all behind the calculation. The cost of the check is
> almost zero, right?

The cost of the check is negligible. The only downside is that it's hard to
understand why it's added, and I only found out why by looking at the history
log. In my opinion, the above 'Now:' is the right fix.

> 
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  kernel/kexec_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index 22acee18195a591..d1ab139dd49035e 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -1137,7 +1137,7 @@ int crash_shrink_memory(unsigned long new_size)
>>  	end = start + new_size;
>>  	crash_free_reserved_phys_range(end, crashk_res.end);
>>  
>> -	if ((start == end) && (crashk_res.parent != NULL))
>> +	if (start == end)
>>  		release_resource(&crashk_res);
>>  
>>  	ram_res->start = end;
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

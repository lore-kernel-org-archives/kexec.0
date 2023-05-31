Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6589BC7EE2C
	for <kexec@archiver.kernel.org>; Wed, 31 May 2023 01:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tQbIZysiVFGw6QzEs5fR9jZS7qxG47WrejuoMzN8apk=; b=o7BeyAVAUKY7Ag5+jt86B4elq/
	OmHbVKjHgYdQ9s/eyBvfGqmK3VM9W2EO+4qkSboIwmaHviaqVyUFmdxZAgllNqg2WAb7sls6VOBTs
	7XRQ7aZs47zFs4QUgfm+igKW/K7UANkN+Y9TBCN+8BTp6MKQjKE6q47AU1AyU2c5uZ2WIiD92zx9Y
	3LZHFo5kgPq61MFzBnr0KNuoBIXj8PLFx6OCiVUZSYv46WYgNn50cQtuFzik324gDtJYFRcDHGuPX
	9rQkSL1tcFh320ejvWZ4VHBGM0gG296ukRiyafAO41FEw1yk1CAKVjlnqse+oDk/dCqZhc5HKglSA
	ImPUHg7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4AS3-00Fh0x-2U;
	Wed, 31 May 2023 01:16:35 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4ARz-00FgxG-2p
	for kexec@lists.infradead.org;
	Wed, 31 May 2023 01:16:34 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QWB746xqwzqTYs;
	Wed, 31 May 2023 09:11:44 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 09:16:23 +0800
Subject: Re: [PATCH 1/6] kexec: fix a memory leak in crash_shrink_memory()
To: Baoquan He <bhe@redhat.com>
CC: Eric Biederman <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Michael Holzheu <holzheu@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-2-thunder.leizhen@huawei.com>
 <ZHaQ7qRYWX9FETu6@MiWiFi-R3L-srv>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5232350c-7529-eece-c9cb-8a8bbc83a81a@huawei.com>
Date: Wed, 31 May 2023 09:16:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZHaQ7qRYWX9FETu6@MiWiFi-R3L-srv>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_181632_250518_3005D5BB 
X-CRM114-Status: GOOD (  20.84  )
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



On 2023/5/31 8:13, Baoquan He wrote:
> On 05/27/23 at 08:34pm, Zhen Lei wrote:
>> If the value of parameter 'new_size' is in the semi-open and semi-closed
>> interval (crashk_res.end - KEXEC_CRASH_MEM_ALIGN + 1, crashk_res.end], the
>> calculation result of ram_res is:
>> 	ram_res->start = crashk_res.end + 1
>> 	ram_res->end   = crashk_res.end
> 
> If the new_size is smaller than KEXEC_CRASH_MEM_ALIGN, does it make
> any sense except of testing purpose? Do we need to fail this kind of
> shrinking, or just shrink all the left crash memory?

We can't give a fixed value, that is, how much crash memory is reserved to
ensure that the capture kernel runs. The size of KEXEC_CRASH_MEM_ALIGN is
only one page on non-s390 platforms. So, it's better to keep the code simple,
and let the user(administrator) shrink the crash memory reasonably.

include/linux/kexec.h
#define KEXEC_CRASH_MEM_ALIGN	PAGE_SIZE

> 
>> The operation of function insert_resource() fails, and ram_res is not
>> added to iomem_resource. As a result, the memory of the control block
>> ram_res is leaked.
>>
>> In fact, on all architectures, the start address and size of crashk_res
>> are already aligned by KEXEC_CRASH_MEM_ALIGN. Therefore, we do not need to
>> round up crashk_res.start again. Instead, we should round up 'new_size'
>> in advance.
>>
>> Fixes: 6480e5a09237 ("kdump: add missing RAM resource in crash_shrink_memory()")
>> Fixes: 06a7f711246b ("kexec: premit reduction of the reserved memory size")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  kernel/kexec_core.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index 3d578c6fefee385..22acee18195a591 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -1122,6 +1122,7 @@ int crash_shrink_memory(unsigned long new_size)
>>  	start = crashk_res.start;
>>  	end = crashk_res.end;
>>  	old_size = (end == 0) ? 0 : end - start + 1;
>> +	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
>>  	if (new_size >= old_size) {
>>  		ret = (new_size == old_size) ? 0 : -EINVAL;
>>  		goto unlock;
>> @@ -1133,9 +1134,7 @@ int crash_shrink_memory(unsigned long new_size)
>>  		goto unlock;
>>  	}
>>  
>> -	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
>> -	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
>> -
>> +	end = start + new_size;
>>  	crash_free_reserved_phys_range(end, crashk_res.end);
>>  
>>  	if ((start == end) && (crashk_res.parent != NULL))
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

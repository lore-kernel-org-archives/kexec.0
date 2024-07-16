Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04787C3DA49
	for <kexec@archiver.kernel.org>; Tue, 16 Jul 2024 12:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sx1DcDtxyx2oNnvcev3ikhNFDMNz8ZtZPvh5e/wet4I=; b=HLzI86V9532OPH
	s2oh4HtmG7AyWJHoOZljqHMJd5qHdLorHnvwV/uk7w3v84LmDSuSu7aKH4rNU8qtS/znp/gE99rvf
	w4iEFp4LxSXUuw8BZP0FhpDsdyGakyXjYfBYMWViKU2Kkj6UfJ0IHijHozObFrQ9YExV3rlzSeQkI
	idFcTG6fD60U3L/sMmoJspmWoyQgKO1pDxPxu5DQVsRXi3dRZv+D3yfxc9h7V77iQZnOG/fUwdHH9
	CosAY8Arn3Otid3A02PoGoCKk7BBlwQLws+94fnSMuoYlHTbgqt+8oo9s0e9CNWetLSLwaD+O5PL9
	Dsl7oxUxUmSKlmVEMAhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sThZk-0000000AS1t-2Skc;
	Tue, 16 Jul 2024 12:46:36 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sThZg-0000000AS0I-2V75
	for kexec@lists.infradead.org;
	Tue, 16 Jul 2024 12:46:34 +0000
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WNf1k6JbTznbJ0;
	Tue, 16 Jul 2024 20:45:46 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F62B1400C9;
	Tue, 16 Jul 2024 20:46:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 20:46:23 +0800
Message-ID: <5dba2994-5f38-1410-0f3f-ef04993cc169@huawei.com>
Date: Tue, 16 Jul 2024 20:46:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] crash: Fix x86_32 and arm32 memory reserve bug
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <akpm@linux-foundation.org>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<austindh.kim@gmail.com>, <rmk+kernel@armlinux.org.uk>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240713014808.1689915-1-ruanjinjie@huawei.com>
 <ZpU2rJ1aKyqlu8IN@MiWiFi-R3L-srv>
 <ff8d5b8c-088c-9e05-53b2-f86335a18b8f@huawei.com>
 <ZpYRrsSLd2ZpUyff@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZpYRrsSLd2ZpUyff@MiWiFi-R3L-srv>
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_054633_027673_FACC8FC7 
X-CRM114-Status: GOOD (  27.06  )
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



On 2024/7/16 14:22, Baoquan He wrote:
> On 07/16/24 at 11:44am, Jinjie Ruan wrote:
>>
>>
>> On 2024/7/15 22:48, Baoquan He wrote:
>>> On 07/13/24 at 09:48am, Jinjie Ruan wrote:
>>>> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
>>>> as below:
>>>> 	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)
>>>>
>>>> And on Qemu vexpress-a9 with 1GB memory, the crash kernel "crashkernel=4G"
>>>> is also ok as below:
>>>> 	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)
>>>>
>>>> The cause is that the crash_size is parsed and printed with "unsigned long
>>>> long" data type which is 8 bytes but allocated used with "phys_addr_t"
>>>> which is 4 bytes in memblock_phys_alloc_range().
>>>>
>>>> Fix it by limiting the "crash_size" to phys_addr_t and bypass the invalid
>>>> input size.
>>>
>>> I am not sure if this is a good idea. Shouldn't we handle this in
>>> arch_reserve_crashkernel() to check the system RAM size?
>>>
>>> With this patch, if you specify crashkernel=4352M (namely 4G+256M) in
>>> kernel cmdline, then you will reserve 256M crashkernel in system, don't
>>> you think that is confusing?
>>
>> You are right!
>>
>> In the case you mentioned, it can still allocate 256M successfully, but
>> the log shows 4352M successfully allocated, which is not taken into
>> account by this patch.
>>
>> And handle this in arch_reserve_crashkernel() is a good idea, which will
>>  bypass all these corner case, I'll do it next version.
>>
>>>
>>> By the way, I am considering changing code to apply generic crashkernel
>>> reservation to 32bit system. Maybe below draft code can prevent
>>> crashkernel=,high from being parsed successfully on 32bit system.
>>>
>>> What do you think?
>>
>> I agree with you, I've thought about passing in a parameter in the
>> generic interface whether high is supported or not to implement it,
>> which is so incompatible. An architecture-defined macro to filter out
>> parsing of "high" fundamentally avoid using the generic interface to
>> allocate memory in "high" for the architecture that does not support
>> "high". The below code do prevent "crashkernel=,high" from being parsed
>> successfully on 32bit system.
>>
>> But if it is to support 32 bit system to use generic crash memory
>> reserve interface, reserve_crashkernel_generic() needs more modification
>> , as it may try to allocate memory at high.
> 
> You are right. Below change may be able to fix that. 
> 
> And I have been thinking if one case need be taken off in which the
> first attempt was for high memory, then fall back to low memory. Surely,
> this is not related to the 32bit crashkernel reservation.

It seems that ARM64 has the possibility before the refactoring. However,
x86 supports only the "low" -> "high" retry but not the "high" -> "low"
retry before the refactoring. In my opinion, "low" -> "high" retry is
more usefull, but I'm not sure if we should get rid of the other way.

> 
> By the way, do you figure out these issues from code reading and qemu
> testing, or there's need for deploying kdump on 32bit system, e.g i386
> or arm32? Just curious.

I found these problems during testing on QEMU when trying to support
this generic crash memory retention on ARM32, and I further found that
x86_32 also has the same problem by code reading and uncommon
configuration test.

> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 5b2722a93a48..ac087ba442cd 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -414,7 +414,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  			search_end = CRASH_ADDR_HIGH_MAX;
>  			search_base = CRASH_ADDR_LOW_MAX;
>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> -			goto retry;
> +			if (search_base != search_end)
> +				goto retry;
>  		}
>  
>  		/*
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

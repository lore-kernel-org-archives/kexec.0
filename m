Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DD1C76195
	for <kexec@archiver.kernel.org>; Sat, 25 Mar 2023 01:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VG9wjnZqjgSOqvQq/fEt6ZL1K9tADeAb79c7mKJCAjY=; b=07SYT91O0QaT1Xbxrv35gwi31K
	a9XHKDeY6P0oTCL5AxM6JbQMGiEQmnTr+TYL3N5TaAG/K+P0QYo5I/PdSvMB4q0HN+UFi7j6MjUIM
	N3ujrrP/uNyGSlHlmkQAEMK2sYpOYZLLlpssaF6k2Pbv1mORAbuM7+PxUK+Rc58CIh0X/uCO8wnJY
	t+od0q1fVoJ1lknUnGzCg9Bxx5m9t2Z90NEQs4z0P977eU8MJle4sLmR5UZeJ32146j6iTJLtNRCF
	ALuWTM9pIWe0RSM2vjKsofoLsmYpOz0yQC0Ni3j2lRwkZyfSmmVZRU+RB1j+o47Y7iPUilXvMqW5d
	pHoPkZyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pft6G-005wop-1z;
	Sat, 25 Mar 2023 01:53:44 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pft6D-005woO-2Y;
	Sat, 25 Mar 2023 01:53:44 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pk2C52DV1zrWWm;
	Sat, 25 Mar 2023 09:52:33 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 09:53:36 +0800
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
To: Baoquan He <bhe@redhat.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, <linux-kernel@vger.kernel.org>,
	<horms@kernel.org>, <John.p.donnelly@oracle.com>, <will@kernel.org>,
	<kexec@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>
References: <20230306084124.300584-1-bhe@redhat.com>
 <ZBHbw3Vp4dxukGOD@arm.com> <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
 <ZBNTRBqqb74T3RMx@arm.com> <ZBSCeWtHvqc/iJZg@MiWiFi-R3L-srv>
 <ZBSr/kIIuxmC/INY@arm.com> <ZBhbqAOsHFj5cheI@MiWiFi-R3L-srv>
 <ZByLga6FS5o8Syug@arm.com> <4d4ecdd6-9716-570d-5595-e47bfbb58cdf@huawei.com>
 <ZB25WN02AHOS8RTT@MiWiFi-R3L-srv>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <cac9bb78-18b3-6f7d-8f35-db15de7c9b80@huawei.com>
Date: Sat, 25 Mar 2023 09:53:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZB25WN02AHOS8RTT@MiWiFi-R3L-srv>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_185342_167270_A174B823 
X-CRM114-Status: GOOD (  21.64  )
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



On 2023/3/24 22:53, Baoquan He wrote:
> Hi Leizhen,
> 
> On 03/24/23 at 10:47am, Leizhen (ThunderTown) wrote:
> ...... 
>>>>>> 2) with the fixed CRASH_ADDR_LOW_MAX as 4G, we can easily fix the
>>>>>> problem of base page mapping for the whole linear mapping if crsahkernel=
>>>>>> is set in kernel parameter shown in [1] at bottom. 
>>>>>
>>>>> That's a different problem ;). I should re-read that thread, forgot most
>>>>> of the details but I recall one of the counter arguments was that there
>>>>> isn't a strong case to unmap the crashkernel reservation. Now, if we
>>>>> place crashdump kernel image goes in the 'high' reservation, can we not
>>>>> leave the 'low' reservation mapped? We don't really care about it as it
>>>>> wouldn't have any meaningful code/data to be preserved. If the 'high'
>>>>> one goes above 4G always, we don't depend on the arm64_dma_phys_limit.
>>>>
>>>> Yes, this looks ideal. While it only works when crashkernel=,high case and
>>>> it succeeds to reserve a memory region for the specified size of crashkernel
>>>> high memory. At below, we have 4 cases of crashkernel= syntax:
>>>>
>>>> crashkernel=size
>>>> 1)first attempt:  low memory under arm64_dma_phys_limit
>>>> 2)fallback:       finding memory above 4G
>>>
>>> (2) should be 'finding memory above arm64_dma_phys_limit' to keep the
>>> current behaviour for RPi4.
>>>
>>>> crashkernel=size,high
>>>> 3)first attempt:  finding memory above 4G
>>>> 4)fallback:       low memory under arm64_dma_phys_limit
>>>
>>> Yes.
>>>
>>>> case 3) works with your suggestion. However, 1), 2), 4) all need to
>>>> defer to bootmem_init(). With these cases and different handling,
>>>> reserve_crashkernel() could be too complicated.
>>>
>>> Ah, because of the fallback below arm64_dma_phys_limit as in (4), we
>>> still can't move the full crashkernel reservation early. Well, we could
>>> do it in two steps: (a) early attempt at crashkernel reservation above
>>> 4G if 'high' was specified and we avoid mapping it if successful and (b)
>>> do the late crashkernel reservation below arm64_dma_phys_limit and skip
>>> unmapping as being too late. This way most server-like platforms would
>>> get a reservation above 4G, unmapped.
>>>
>>>> I am wondering if we can cancel the protection of crashkernel memory
>>>> region on arm64 for now. In earlier discussion, people questioned if the
>>>> protection is necessary on arm64. After comparison, I would rather take
>>>> away the protection method of crashkernel region since they try to
>>>> protect in a chance in one million , while the base page mapping for the
>>>> whole linear mapping is mitigating arm64 high end server always.
>>>
>>> This works for me. We can add the protection later for addresses above
>>> 4GB only as mentioned above.
>>
>> Recently, I've also been rethinking the performance issues when kdump is
>> enabled. I have a new idea. For crashkernel=X, we can temporarily search
>> for free memory from the low address to the high address. As below:
>>
>> save_bottom_up = memblock_bottom_up();
>> if (!high)
>> 	memblock_set_bottom_up(true);
>> crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base, crash_max);
>> memblock_set_bottom_up(save_bottom_up);
>>
>> The final code change should be small, and I'll try it today.
> 
> I have sent a patchset to remove the crashkernel region protection code
> as per Catalin's confirmation. I personally like the code conciseness w/o
> protection because kinds of crahskernel reservation has been complex,
> the situation on arm64 will makes it worse if we try to keep the
> protection and fix the performance issue. While I am glad to see any
> attempt to achieve the two goals if it's satisfactory.

I saw the patchset. No protection is also a good idea, the code is
simplified a lot.

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

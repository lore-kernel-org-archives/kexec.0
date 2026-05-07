Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D10CD3442
	for <kexec@archiver.kernel.org>; Thu,  7 May 2026 09:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JUkIjpcmnqAY6snj5K4KsoGXaSrVhFlzy2v4P9fV3pM=; b=aM8Fmoiit0DWtiQZR9YFA1JX1x
	s1UzYrKX6oUegoZfm+BasyPAs7nQdXaFMWwzVIqtF7URi9F+gO8A/SVIqkKNzAugPk2hooVjIn088
	O+4o5OPEsw/3QC6Fi30f3jMAIlthG2KZcx61QKHwVXb9qy/k0nXOGZ8/kVTKk0hAONQQ3lYE3Kwvb
	KwyzSNXcT5VOsy17PjnB3yNQhJujPNzPDslnD26SdZHcld2+23CpXNzIjeqkh32XByDH9kJ3QTmZd
	8kzYxt1GnztCsedi9zBZWDnlO56dzQsdZu2pWkKAOxnM88AqBiRmQQzDD32pzdEYpEudHfr+lTZv0
	Exz1beJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKv95-00000003Mi9-1ge0;
	Thu, 07 May 2026 09:35:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKv93-00000003MhG-42UP
	for kexec@bombadil.infradead.org;
	Thu, 07 May 2026 09:35:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=JUkIjpcmnqAY6snj5K4KsoGXaSrVhFlzy2v4P9fV3pM=; b=aoMzfzsl1SEK7/lxA8CXn6wRqk
	dd+UnpKN0Ams0ugMTkgzEWT4O3MIHaZ/2+TvG493YVXLREx3mMcvPdZGFRnVtlt9E5vLvHTdM+CKO
	+GrYERHYdkq/5j3SDKOIQS6eWlupIkyVfz9QHB70KAL0GT7nE2M0w93MzOsCthpIgozehnU9W/d8A
	iSlIdptXu9gWc9u/nGP1mABxBvy949O4ej1DZLdBjDT7W0/uOmMiE59S9g4a3Y8neh2Mb6GrkylZL
	4grQDfsuH4mvGFUrrKusaLt74qBGzszpIEkvKsr1Zyn4bLPeqrQoElEZMDi/iG6mNB08BZ88NNozA
	s3tarLlA==;
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKv8z-0000000363Z-35ls
	for kexec@lists.infradead.org;
	Thu, 07 May 2026 09:35:48 +0000
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-364f7c42c62so468553a91.0
        for <kexec@lists.infradead.org>; Thu, 07 May 2026 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778146544; x=1778751344; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JUkIjpcmnqAY6snj5K4KsoGXaSrVhFlzy2v4P9fV3pM=;
        b=bpfq/2HDfg72vYjM32RZpg212fRKAE7SXeISg9P2vkDCFcQarQfSNhArrkBJk2BHXx
         598jq5mXU5j8q2uN7P+IityOW/KrlTmKVyl8VgADcHQC7iHT5QOzV6Ayrv88EunJP5J4
         1Vj7gxHSFC0NFv2A5TM2l9yKpPnQ3c/yPLkqMSdlqlbO49puGqVmmgTrqVNGzQMZ51Yg
         Rhl7JrTy3PGqhf/COS4EbcApdQswJEiDyYxr6C89wtz2sWFGeSqjYOoJYtNp4v17kaAQ
         oHlULYdOfu5EEoSgCODJ07TqHqGXjUJQfq96JY4UDCgCWa6cQp/8ycewocLYlrN1gCwV
         z4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778146544; x=1778751344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUkIjpcmnqAY6snj5K4KsoGXaSrVhFlzy2v4P9fV3pM=;
        b=AC7/Ze2qxNpbp0VGkNApbj7Vfk7Zm0R1OLS5X0TanoGr1Fy6H/DvMzt9FiyBDnuFFD
         TiCEJNOoNvrP0vgrlFtg6HGsqdcsLf0JC8qatQKGsMXi9+u//W3pH++qEMZIhvFGw0ud
         1lN2ixEi+J+V1jOVLO3fgnUm0o6v2ZH7YBbHBtHXq22swIV91RKoMS09KUhFcV8IAKY6
         rJEn2mwfxeovihrJa0A8GMl83+wfFJbZQPFTh3dBGqWlxbRb3xB8TI248Hh5yq/wdxOi
         lW//+JkfdgMtmTOEzoOWTQKIbkAtuOXUfAwaJGJdXejd9ZYPim5A+QL669w/sWB5DLAS
         BetA==
X-Gm-Message-State: AOJu0YyfH4MQTsqpPJZ/bGYo+/lKLYbXjyCSRGaMan0jv/RQrivUV8zy
	Rm8BYxZL+W0qd6xnQFv5eDGT5jJg1zQYtLogxeIW2ltucJqd/7U24fWP
X-Gm-Gg: AeBDieuY/GX9IMucNfifuwBBhpPpxZNFNkHVs7TsApn/Rup2JArc82th8f+SuOB3ygv
	wuYkW52bWvIfD352CFGFctaDHUs30YVtFCvdUmzyHvSeaSVSyX5jvCBaY7ZRlwO2mvvnD9wg0r3
	HDGRBCHUwL2xLta+V2QiBKKgiP9uRZp7lrcpLCVhm+kQh3/1VuL/bnBetePL+yH7EL+J0dcJVmz
	pTzulRi4DzLGuFOk8qpQ4xwG7mwXozvEBp47X0fj7cA5h5awdtgLb/yG4HX5UsjFNDnCdXfyMUv
	T0kkorFibrMKRJasWkwwdkzmRAkJrIkDrGL+wplAExYoteEfBHJHUFkWQFfjR2xJgaBLBPY7jFX
	6YEQK5foJtzO6XEewDNg/sQhx+ClmZFDa5W8d5otbXxjIOw8lp9I3T9c/wGv3qXmBa5OACOqnlf
	ekfT7zxav+u/MwJkiFLt/L/AY8nsiH2qIO6HqvWg/KnQ==
X-Received: by 2002:a17:90b:1c8b:b0:356:35a5:4a64 with SMTP id 98e67ed59e1d1-365ab9b8e5dmr6393838a91.4.1778146543874;
        Thu, 07 May 2026 02:35:43 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4c19387sm6651310a91.7.2026.05.07.02.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 02:35:43 -0700 (PDT)
Message-ID: <1a8af3cf-5edc-4ca4-b340-12ebeb2ed982@gmail.com>
Date: Thu, 7 May 2026 17:35:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] of: reserved_mem: reject reserved memory outside
 physical address range
To: Rob Herring <robh@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
 rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 ruirui.yang@linux.dev, corbet@lwn.net, skhan@linuxfoundation.org,
 catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, saravanak@kernel.org, chenwandun@lixiang.com,
 zhaomeijing@lixiang.com, everyzhao@126.com
References: <20260429065831.1510858-1-chenwandun@lixiang.com>
 <20260429065831.1510858-3-chenwandun@lixiang.com>
 <20260506015112.GA286568-robh@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20260506015112.GA286568-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260507_103546_224225_33796528 
X-CRM114-Status: GOOD (  21.78  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 5/6/26 09:51, Rob Herring wrote:
> On Wed, Apr 29, 2026 at 02:58:22PM +0800, Chen Wandun wrote:
>> early_init_dt_reserve_memory() does not validate whether the region
>> falls within physical memory. If a device tree incorrectly specifies a
>> reserved memory region outside the physical address range:
>>
>>   - For the non-nomap path, memblock_reserve() blindly adds the region
>>     to memblock.reserved, creating a stale entry that refers to
>>     non-existent memory.
>>
>>   - For the nomap path, memblock_mark_nomap() silently fails to match
>>     any region in memblock.memory, but still returns success.
>>
>> Add a memblock_overlaps_region() check at the entry of
>> early_init_dt_reserve_memory() to reject such regions before any
>> memblock operation takes place. This also simplifies the existing nomap
>> guard: the original "overlaps && is_reserved" condition reduces to just
>> "is_reserved", since the overlap with physical memory is already
>> guaranteed by the new check.
> While I agree, I suspect we already have cases abusing reserved-memory
> like this.
Sashiko reviewed this patch and told me:
"Historically, the reserved-memory binding is often used to describe 
hardware
SRAM, DSP memory, or IOMEM carveouts that reside outside of system RAM."
IIUC, nowdays using mmio-sram DT binding is more appropriate for SRAM or 
IOMEM carveouts.
Should I drop this patch or keep it ?
Thanks.
>
>> Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
>> Tested-by: Zhao Meijing <zhaomeijing@lixiang.com>
>> ---
>>   drivers/of/of_reserved_mem.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>> index 9d1b0193864c..03c676052dab 100644
>> --- a/drivers/of/of_reserved_mem.c
>> +++ b/drivers/of/of_reserved_mem.c
>> @@ -112,14 +112,21 @@ static int fdt_fixup_reserved_mem_node(unsigned long node,
>>   static int __init early_init_dt_reserve_memory(phys_addr_t base,
>>   					       phys_addr_t size, bool nomap)
>>   {
>> +	if (!memblock_overlaps_region(&memblock.memory, base, size)) {
>> +		phys_addr_t end = base + size - 1;
>> +
>> +		pr_warn("Reserved memory region %pa..%pa is outside of physical memory\n",
>> +			&base, &end);
>> +		return -EINVAL;
>> +	}
>> +
>>   	if (nomap) {
>>   		/*
>>   		 * If the memory is already reserved (by another region), we
>> -		 * should not allow it to be marked nomap, but don't worry
>> -		 * if the region isn't memory as it won't be mapped.
>> +		 * should not allow it to be marked nomap. The region being
>> +		 * physical memory is guaranteed by the overlap check above.
>>   		 */
>> -		if (memblock_overlaps_region(&memblock.memory, base, size) &&
>> -		    memblock_is_region_reserved(base, size))
>> +		if (memblock_is_region_reserved(base, size))
>>   			return -EBUSY;
>>   
>>   		return memblock_mark_nomap(base, size);
>> -- 
>> 2.43.0
>>



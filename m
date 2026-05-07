Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9334FCD3442
	for <kexec@archiver.kernel.org>; Thu,  7 May 2026 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JUrNwnrnHXKNK1Z+tsaGPk05Wyp59KKsZWMiHJkBCuY=; b=Y/u3CFCIqQBywD62MhV/jL+1w8
	lEhL5T3Zv75xCN02LGkBkOwtehMbYNkCseZagLXbUNkTDpqT7h7CtI53p4m4La3FbPQ0npunQWLV3
	MOxiBSazjeY2hXwlLbElH9Dcm7ZgbqzoqKeatW16+bN4D8OuaQIHmyIb+bBbgzoYiIsSXdWdyLRry
	uKRfrdwBoEwODjcccx6ww+SLYYmdTkAkMvcBDuVzo5/wRKq7upbUl8+9cSQbLn+4iBW3SN8p9CezI
	5d7Zk04dI9lPlyNzuYGaneGj3ZiiTIuk/f22Bz8UvwZx7tsn9zM5hOCM2uhnK5FM3YAuW4mTZFo8E
	nmCyht7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKvF9-00000003Nn0-2Dp9;
	Thu, 07 May 2026 09:42:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKvF7-00000003Nlr-3VjO
	for kexec@bombadil.infradead.org;
	Thu, 07 May 2026 09:42:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=JUrNwnrnHXKNK1Z+tsaGPk05Wyp59KKsZWMiHJkBCuY=; b=p8HoeoOerompljGWVWnn/tw9+4
	O3e76Dkvfq7vDnNPrCoGdHnV++UtSJOdYyc5LGyT5xVHBytECtZrROBpP9PGuTM7G4XYbTJM6AWla
	VBY4YtFTQOagFQkGVjwf7yD+2ViG3MUuU0bL2Ew0N6zl8C2J2GP3ixBF80LZsf2YrZreWxYJpZYx0
	OljufQyErYmcQOecsap0Ga+ZijmnVWI7TqTbtXZkwPtonA4DCIvwDiadu94hcREci0XW1oU2TO2AY
	A6fuAvEJmcZYVwIlsbug4i2mpg3dWtc5rxB0f7HRmOr7QAFMRhXOnVgNzTZIYkzeJclCqjcD/0Fe1
	dxT5ylYw==;
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKvF4-0000000376G-29ML
	for kexec@lists.infradead.org;
	Thu, 07 May 2026 09:42:04 +0000
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-82748257f5fso1103142b3a.1
        for <kexec@lists.infradead.org>; Thu, 07 May 2026 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778146921; x=1778751721; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JUrNwnrnHXKNK1Z+tsaGPk05Wyp59KKsZWMiHJkBCuY=;
        b=ITBpeySW6a6eibrRTB32ZR65rtLEkeVANQMTTdWQJPbt/1kMTVPveWzWNfPnC2cBMU
         WYFKebZw8YSOhHQH79tt6o9e3LI0DziiE9kjmMQSSa582fpRFUfKRZqzPYlIgagkvwVs
         ZAvgr6hUyWVDtyL9lGxRWs08DYrHB12h7tUewr1hZLFn5nISFAwyHzLz4fHb/HE4q7Uh
         s4a3CdvqRoFPDNsjMEqoo3KwtSZC3bVistUGZgbwHphEb03dF13LZVkPhFWzhF9XERfo
         M7kjknavjxi3X52Y1SzTiGVtyvewEPAbII2I4ygTJsi0csKBf5lfQJJDIrPUbNkbD9J/
         bh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778146921; x=1778751721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUrNwnrnHXKNK1Z+tsaGPk05Wyp59KKsZWMiHJkBCuY=;
        b=plPDGfCIIOYpFenGjCI1l80phDSLUBm1mBwNPpaqyAIj95qieMFQ+CdI4NUv9MeiRD
         uZhIIiYQ5V+5fDM6J/63hBOZx1jp6bmO0cseievT0h57IpkjBSfENOcU3k78eJgQT39y
         HnfSrFVam/XG+i1+ArBU/QhIvsMbwkRSB7d2C6ina+3lWh+M/dTP6MX3FYECuw8bP/UL
         2LUd29o7lWZiZ5d7l1jrdOvZiMvMEX58kGzoQaKInw8BP2EX1L+Oglw2nbwCiw8PZlWW
         qFDxOKmuo5fcQRepWDIhS2oAQzCOuSyNSIcZRGOxpuZ1bEnQwdnB9+lG99FZccAG9xhf
         mWQw==
X-Gm-Message-State: AOJu0YwLpzzJVT8dbq2MwaOm3bOLYY6UGdirSPHWLFc4l7L7EsMB32sb
	X4k3dreIXA6IMVvf7o3qGNI9XHpgkZdKDwIrFUetgO3Rq79lqffwqkZr
X-Gm-Gg: AeBDiesAeSOAAcPVoXz5rtp/aoejxg68FdZyc8Sp+JHwacvsISo04uI5IBj2L/voRMW
	WCEAzYh4vzGpqF9J7WBbKTeL5BRM9pB/cvylZTSQtwGS0B8DoP/QRZ8Of9JrGzfEXwlDW++sNTD
	/vb80z494na4QJY+3YFDEPhKap7NgIydCouyNvV6u2QC55uRbbJMNXhXd3fpN6p1pMbYyyknzK2
	fIHtegv+hr0LNxKHpWqNVE/7v4DygCqdU+elyZWO9NX0KNPQdpLezUIAHaxSQsapJNx5iWQjVIf
	ap8PfaOdbl2N7ywmVcAJhsLAmsQTAy0IH3rIHmsxvOSLjZGi38C4ZJZPO8mghUHj0pG8ImgY85r
	dH8MSbYYBgDmoK3nWsqW8+IA7nWD1wqIo4axudZx+FwJh2L2J6sujBmH/dO0cFAGbPRT1xNOaAD
	6a3gVleBBwg9lJCNqT8X+F7uPEvvIMBjN2rUMK+rp5Fp1l7Cw+JQdL
X-Received: by 2002:a05:6a00:4093:b0:82f:3e9:7bec with SMTP id d2e1a72fcca58-83bb7abceeemr1949432b3a.12.1778146920796;
        Thu, 07 May 2026 02:42:00 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965c30ddasm10264549b3a.21.2026.05.07.02.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 02:42:00 -0700 (PDT)
Message-ID: <eece7690-634a-43c5-9b20-0afc174a89a0@gmail.com>
Date: Thu, 7 May 2026 17:41:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] of: reserved_mem: add linux,no-dump property
 support for reserved memory regions
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
 <20260429065831.1510858-6-chenwandun@lixiang.com>
 <20260506144542.GA2072596-robh@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20260506144542.GA2072596-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260507_104203_041496_43AA81A6 
X-CRM114-Status: GOOD (  18.35  )
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



On 5/6/26 22:45, Rob Herring wrote:
> On Wed, Apr 29, 2026 at 02:58:25PM +0800, Chen Wandun wrote:
>> Add a 'no_dump' field to struct reserved_mem and parse the
>> 'linux,no-dump' device tree property during reserved memory node
>> initialization. This property allows device tree authors to mark
>> specific reserved memory regions that should be excluded from kdump
>> vmcore dumps.
>>
>> Reserved memory regions used by device firmware (e.g., GPU, DSP, modem)
>> typically contain data that is not useful for kernel crash analysis and
>> can significantly increase vmcore size. The 'linux,no-dump' property
>> provides a declarative way to indicate these regions should be filtered
>> out when constructing the elfcorehdr for kdump.
>>
>> The property is named with a 'linux,' prefix because kdump/vmcore is
>> Linux-specific and the property is an OS hint rather than a hardware
>> description, matching existing properties such as 'linux,cma-default'
>> and 'linux,usable-memory-range'.
>>
>> The 'linux,no-dump' property is only effective when the region:
>>   - Does not have 'no-map': these regions are already excluded from
>>     vmcore since they are removed from the linear mapping (MEMBLOCK_NOMAP).
>>   - Does not have 'reusable': CMA reusable regions are actively used by
>>     the kernel for movable page allocations, and their contents are
>>     valuable for crash analysis.
>>
>> The no-dump status is also printed in the boot log alongside the
>> existing nomap and reusable flags for diagnostic purposes.
> I think this property is the wrong way around and probably not needed.
> The default should be exclude the regions, but if Linux is using the
> regions (like CMA) then it can decide on its own to include them.
>
> With the restructuring that went into 7.1, it should be possible for the
> CMA code (and code for any other regions) to set some flag for the
> region.
Agree that the property direction is wrong. Rework in v2:
   - Default: exclude reserved regions from vmcore
   - CMA (reusable) setup path marks regions as kernel-managed general 
memory → include
   - No DT binding needed; linux,no-dump proposal withdrawn

Thanks.
>
> Rob



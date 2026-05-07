Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6312BCD3427
	for <kexec@archiver.kernel.org>; Thu,  7 May 2026 08:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tYLd8a4rOgJ0HgA5aFHjScXvqopFgzBf/Pbs3wYF8a8=; b=CyonNR19/nhMu+Il+ophsjiESK
	nvSlMqxZdSdqcHmZh7Kbj9LgRalPha7+tmGSdE+kRLckvbWz42OctPMSqAjqdfiBGl9ZylyEsw3ve
	63eeugkhCrbAkoOJVa2ou+qhbY1PH+kU1FHv8aFrQQQEwzIwdc7J034qPuFdJzz80FTSd7jcSHEtz
	u/XG8zQnWjDQjkvcS3qWcB/5lGbMtwippbtdK+WA9e13/f+VJ5SH4ipKXLfjRIpUOALobDKzJNjTO
	2y2r3feAUtUpw4Tw4vfDu9KZvBa5kliEyu0cT+rdA9J9Gwwg2BvrVprMOYUTK0Y2AFFwfRLJ+qLGq
	98InkbhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKuIW-00000003Cx0-2XrD;
	Thu, 07 May 2026 08:41:32 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKuIT-00000003Cuv-1tFT
	for kexec@lists.infradead.org;
	Thu, 07 May 2026 08:41:31 +0000
Received: by mail-pg1-x542.google.com with SMTP id 41be03b00d2f7-c8173b2af32so382512a12.0
        for <kexec@lists.infradead.org>; Thu, 07 May 2026 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778143287; x=1778748087; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tYLd8a4rOgJ0HgA5aFHjScXvqopFgzBf/Pbs3wYF8a8=;
        b=ej2U1T871X7xAnfuXp3jCB/0CtLmoAPt0yLVPD98LEq+DyvGiml1Vr9qEMyBEWghsf
         CgbFbdL35C7Dachi4grlvMV3zBKQBfJgjZyO1cKag5QSdh94sY+x5dXDCyKRnXW7b1ze
         BtLcHc6Wy3KrB33IEesAiLOPtbQHS2kZnyrj4FfNmVtx55pxV2Q6xpCcz5kERDShuG1H
         PifSX6mfC9vH4q/MKMngJYt6DxQRahAqOy8euFbhzyFWHbAZYmbzFNXeVCV1zmmNPadN
         m7EJfiWjf2oAd9CysBVr+g67HEhwv8J+6Z/xf07zsTOllNS86IutCXc4sw5otl9Sr957
         rkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778143287; x=1778748087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYLd8a4rOgJ0HgA5aFHjScXvqopFgzBf/Pbs3wYF8a8=;
        b=BaJYFJwMfDEiUOzKo80xUVe7KC2W1CaXbrWRTIZgAUNIVs+4L6HBxmLqDKAbp9kmC+
         U9ECvMwFKx1dAfprgplJCss2ApDdGJo7iVpkuT+FrJIx0JgGLYKU+ZocaKFb3pRiAL+B
         7t1KK0uu+9DDBN/U7gpDkYu8TtusgD+j6O/ebHqAn/tkLvhyxRo1tBqvs/nht3Ke15R9
         xNLipYu/qZWCH5RD4++aVNWqslJBUf7SZUfzoSM8qHM0s6cfoVd/w+NRQfF7cpF+T4q/
         ewmtlG+E4DA4FcKRvDGkMNkYVADorFCkst6gt1WWeYDA/Pb17xoTX2uvBzMGVLdKI/y8
         sIKA==
X-Gm-Message-State: AOJu0YwvwXWY3uaBfDE8loMbblI4VChszyvhgqQ9bDJEMWhFpk8Skk6C
	1ykTlXYsalGzzcAg/L4TZIudjluov/B/hizgifLJhL0dIyXDdCtZIceA
X-Gm-Gg: AeBDietgbW8FVZ9MFAeNx4ZG7r75oC5eIUc+Sn8W2k6/+FW3mw/FpeBP5Hwz0XY4aWI
	bvAMHnyiv16Q4dsgdD80I92AKx147hBKSKD35aW5zQbZkV7EkQaI8TByD8Z+KjJkrnIUTIbTswN
	t+TOUwFOw1Lq9CjBslFoWL+tRX4H5mJLzmseQFaIm6dUIh/jycqQz3+0IFK+K+cOpqLWJ1b4LJ1
	BuoNEpd/lwgivMqYpsC55YSkMAxspeb01x2bpf54A4tfXJxYNatVSqrRaP4nsg9iY9sAhRI5FYK
	MbypvU9Sn7xlescN0XXQgTkJSx1iReZsZjQN4+IwA4nlO75oui/K2U7u8C5ZNnczXXS+OIJAC2Y
	aSn7Nu+yuRhf5O3CY4cHXng4iYRZql/dNQjlVcqzs4bclqtkwy/BjLwLqJeYPusESsGmfDeWHbE
	5YbVjFzikQ4zSjLGiedd/+O1hqLLeabndoKN+QQo84Yw==
X-Received: by 2002:a05:6a20:a106:b0:3a2:dc51:445 with SMTP id adf61e73a8af0-3aa5ab6853cmr7732684637.36.1778143287552;
        Thu, 07 May 2026 01:41:27 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8253586c6asm1305583a12.4.2026.05.07.01.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 01:41:26 -0700 (PDT)
Message-ID: <126f4fd0-0a1c-41e0-8746-fa7ab85d6773@gmail.com>
Date: Thu, 7 May 2026 16:41:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] of: reserved_mem: fix region count for nodes with
 multiple reg entries
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
 <20260429065831.1510858-2-chenwandun@lixiang.com>
 <20260506014752.GA280279-robh@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20260506014752.GA280279-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260507_014129_493865_4F454CC0 
X-CRM114-Status: GOOD (  14.46  )
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


在 2026/5/6 09:47, Rob Herring 写道:
> On Wed, Apr 29, 2026 at 02:58:21PM +0800, Chen Wandun wrote:
>> When a reserved-memory node contains multiple reg entries (e.g.,
>> reg = <base1 size1>, <base2 size2>), the count used for
>> total_reserved_mem_cnt is wrong in two places:
>>
>> 1) __reserved_mem_reserve_reg() returns 0 on success regardless of how
>>     many regions it reserved in memblock. The caller in
>>     fdt_scan_reserved_mem() then increments count by just 1.
> Just to make sure, more than 1 worked before the referenced commits? It
> would be easier to just define we only expect/support 1 entry.
Looking at the pre-8a6e02d0c00e code, __reserved_mem_reserve_reg()
reserved memblock memory for all reg entries, but only called
fdt_reserved_mem_save_node() for the first one (guarded by an 'if 
(first)' flag).

So multiple reg entries were never fully supported: subsequent entries
got their memory reserved in memblock, but their metadata was lost
and driver-specific init callbacks were never invoked for them.

The referenced commits made this worse by also breaking the count
tracking, but the root limitation predates them.

I support documenting "only 1 entry supported" based on the
following reasons:

   - of_reserved_mem_lookup() does a name-based linear scan and returns
     the *first* matching entry. A node with N reg entries would create
     N entries with identical names; entries [1..N-1] are permanently
     unreachable via lookup.

   - Drivers like CMA and DMA coherent are designed to initialize a
     single contiguous pool per node_init call. Calling node_init
     multiple times with the same FDT node is not a supported usage.


>
>> 2) fdt_scan_reserved_mem_late() uses of_flat_dt_get_addr_size() which
>>     only reads the first reg entry. Subsequent entries are never
>>     initialized via fdt_init_reserved_mem_node(), so their metadata is
>>     lost.
>>
>> Fix both issues:
>>   - Make __reserved_mem_reserve_reg() return the actual number of
>>     regions successfully reserved. Update the caller to accumulate
>>     the returned count.
>>   - Rewrite fdt_scan_reserved_mem_late() to use
>>     of_flat_dt_get_addr_size_prop() and iterate all reg entries,
>>     initializing each one via fdt_init_reserved_mem_node().
>>
>> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
>> Fixes: 00c9a452a235 ("of: reserved_mem: Add code to dynamically allocate reserved_mem array")


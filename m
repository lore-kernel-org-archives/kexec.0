Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C28C44536
	for <kexec@archiver.kernel.org>; Wed, 22 Jul 2026 12:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y9Z7oDiKdtFczxQKch+yVvuNvhzSOS2efy5d+XjmEE4=; b=WZuIyTjlDZDXRtJJmS9+7f+t5M
	gmvyNQMvdzR82btW96Nhid1riqyyDDExi4M3dmlosBs8c/4a7BqTDhXvnNjOx/ZNezKn8ltm98rQH
	lH/Y9H0khZo+Vz/Pc1oIiVJL8uX63VG9q3pJFHrL+PEbw8j1ZpYmEHVeblfGTHlMb3KYj7kMQD5iy
	pVwVqytqn7g0ASf2fhUS6kct2RpaJlXL9XRQ/VPOZD3vcJLqg/EeX4Z6qJ41VmezgczrUyOTrQVus
	Dh0Gh3iu6yrYbFfI1VtX0Vqz/J0wXH4tPJCUUiS2VI7+k0kdGS9HdsorJXxdLdxi2RpjkokGYn/BJ
	yHnOddiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmVjz-0000000Bi1d-3lo3;
	Wed, 22 Jul 2026 12:07:59 +0000
Received: from mail-pj2-x02.google.com ([2607:f8b0:4864:39::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmVjw-0000000Bhzk-0JR8
	for kexec@lists.infradead.org;
	Wed, 22 Jul 2026 12:07:59 +0000
Received: by mail-pj2-x02.google.com with SMTP id 98e67ed59e1d1-3896ccc93b5so3678475a91.1
        for <kexec@lists.infradead.org>; Wed, 22 Jul 2026 05:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784722075; x=1785326875; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y9Z7oDiKdtFczxQKch+yVvuNvhzSOS2efy5d+XjmEE4=;
        b=NzsTBVclC/VLVbD8OYfdQQll1aIpQIm1h7lVsOkNuN2ZusTF4VT1ZdrZr9IuiIq7ca
         FqOanYD7nVWkVPyGEpekuM21VnAWD8FsQKwG6hWxtiNLDSTm2xspwduoqKFvXK2luHvj
         /TpOmsrp3jUeBdzbiLJ/BlZbhkAWrzgmxies125ubSZHabIUb+EBgPdAhqYwuHwdIo+E
         r706H1iRbLbuKmslN3zrMv71CCcar5CJcHtVr5kItYlao1CX5wDq6ZEyYIdlW9rWo88P
         oP2VXWJz0JtGr8prK33m4WTR7X04gKrP4feyaj9cNJdyldjzFaxtRVeKib3OKaRQrYuo
         JfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784722075; x=1785326875;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y9Z7oDiKdtFczxQKch+yVvuNvhzSOS2efy5d+XjmEE4=;
        b=h2Gg3vuMq/1fgF2FWt6awZ7UaJ5h7xow3qjEeRoifqOqPKUH78RG1xEuMPxXLg8l7v
         wTkUQN8rI1VvO9KsVJ7kHZn0V7dKF8HYCcreZqw7DLS1K4ipu3L5zteiWL4a2Szchc4P
         ucxF1HbVsuqysL8GSq2J8vwV2SWWIi02c+AUeZkajvDjj4tx3Z7iPPnWDNemxQkDKVf1
         MB/8MwDMEDVtP9g3xc5q2NMcy9OcVcnvHVEdZwCx9WyPfAFhZ4SSQnx6n750FmKQ233s
         3W91Ab2RQO5WaemMziG4wSx4/G1QJniMjh4a9gT1efrKUGYCgbUSsIhzKxvV1mdZNlxT
         gcpg==
X-Forwarded-Encrypted: i=1; AHgh+RpRVZmwdl6wtc331KpsQycTccFFG7wnyH+xfyVqwP/NVEU0jimHQ6cIGDN4wgLNJAjnhttAuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyDQuj85/+ZN/hnZ1ZmdU6+MefBQdz2OQoYLAUnYlaeJRJIteEv
	EQiPz2G6hn20nMFfnf5fi/WwPRM0eFchYv7sJFHL8Qu54x+hUogsccfc
X-Gm-Gg: AR+sD12dGBAik0ljjHmg/NH91pZKoxMGlJ2VDmSB4FwyV6BJxHmH7oY0GBh2AEx9pXh
	+BnlzNt890s0K6CdFboTuLr0Qy8EfVFrLKQdCm+M3Z0Jb//yCpFsm2MG/Ppzxok5JK/Wv98bLF1
	E/ChbbrL9zQtsgJNAjLWAIJMvEOasG5P9SndIjLgqAtgeqiw9YtVo1A4u/yP9uu3FgOWmAB3R77
	GLUGY8g2CjP1jEK+f9+kGhaWkwIUzlOjrXypNlE3XisXekWkx4imjA4R19Lx94/LtZsihhCjWZa
	8jEm972mGv6+vWbxgjyiTURpUt4CURT4oLYgymWuBg5gQr0l0vc7BLJiShhjbcKpWm1J28XXMR/
	ckl40eRPQiY22Bsr9B7qki7OQ9dChCfG69YH7+VaHt5d1Gu1AvTuqJni2v8loZx4gh7rhvH/Re5
	QdWitxfLvmng==
X-Received: by 2002:a17:90b:1b42:b0:387:e0db:bc28 with SMTP id 98e67ed59e1d1-38e4b57ee22mr21351484a91.40.1784722074599;
        Wed, 22 Jul 2026 05:07:54 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9218a343sm3215461a91.16.2026.07.22.05.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 05:07:54 -0700 (PDT)
Message-ID: <e3dd16fb-3795-4028-a2f9-00f54882183f@gmail.com>
Date: Wed, 22 Jul 2026 20:07:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] kdump: reduce vmcore size and capture time
From: Wandun <chenwandun1@gmail.com>
To: chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, robh@kernel.org,
 saravanak@kernel.org, bhe@redhat.com, rppt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org,
 iommu@lists.linux.dev, zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com, will@kernel.org, alex@ghiti.fr,
 akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 ruirui.yang@linux.dev, m.szyprowski@samsung.com, robin.murphy@arm.com
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
Content-Language: en-US
In-Reply-To: <20260630074715.4126796-1-chenwandun1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_050756_112866_B94F538D 
X-CRM114-Status: GOOD (  21.54  )
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



On 6/30/26 15:47, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> On SoCs that carve out large firmware-owned reserved memory (GPU
> firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
> those carveouts as part of system RAM even though their contents are
> firmware state that is not useful for kernel crash analysis.
> 
> This series introduces an opt-in 'dumpable' flag [1] on struct
> reserved_mem and uses it to filter the elfcorehdr PT_LOAD ranges on
> DT-based architectures (arm64, riscv, loongarch). By default reserved
> regions are treated as non-dumpable; CMA regions are explicitly opted
> in because their pages are returned to the buddy allocator and may
> carry key crash-analysis data.
> 
> Since the reserved memory regions are filtered out, the vmcore is
> smaller in size and faster to produce. The reserved memory
> has already been filtered out in x86; the optimizations in this series
> apply to systems that use DTS such as arm64/riscv/loongarch.
> 
> The series is organized as follows:
> Patches 1-4: Small prepare changes and cleanups.
> Patches 5: Add dumpable flag to opt-in vmcore.
> Patches 6: Append /memreserve/ entries into reserved_mem[].
> Patch 7: Add generic kdump helpers.
> Patches 8-10: Wire the helpers into arm64, riscv and loongarch kdump
>               elfcorehdr preparation.

Hi Rob,

Gentle ping on this series. Patches 01, 05 and 07-10 have been
acked (thanks Pratyush, Will and Marek), and the comments there
have been addressed in my local tree.

Patch 02/03/04/06 are the core of: reserved_mem changes, they are still
pending review on the devicetree side.

Could you take a look when you have a chance? Happy to respin and
address any feedback.

Best regards,
Wandun


> 
> v3 --> v4:
> 1. Rebase this series on v7.2-rc1.
> 2. Add two cleanup patches (patch 02/03).
> 3. Simplify patch 03 to avoid checking whether initial_boot_params is
>    NULL multiple times, suggested by Rob.
> 
> v2 --> v3:
> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.[2]
> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
> 3. Add some prepare patches.
> 
> v1 --> v2:
> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
>    feedback [1], v2 drop that property and exclude reserve memory
>    by default.
> 2. Split some prepared patches from the original patches.
> 3. Address coding-style comments on patch 5 from Rob.
> 
> [1] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
> [2] https://sashiko.dev/#/patchset/20260520091844.592753-1-chenwandun%40lixiang.com?part=4
> 
> 
> Wandun Chen (10):
>   kexec/crash: provide crash_exclude_mem_range() stub when
>     CONFIG_CRASH_DUMP=n
>   of: reserved_mem: dedup and relocate reserved-memory messages
>   of: reserved_mem: skip late scan when no regions are reserved
>   of: reserved_mem: split alloc_reserved_mem_array() from
>     fdt_scan_reserved_mem_late()
>   of: reserved_mem: add dumpable flag to opt-in vmcore
>   of: reserved_mem: save /memreserve/ entries into the reserved_mem
>     array
>   of: reserved_mem: add kdump helpers to exclude non-dumpable regions
>   arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
>   riscv: kdump: exclude non-dumpable reserved memory regions from vmcore
>   loongarch: kdump: exclude non-dumpable reserved memory regions from
>     vmcore
> 
>  arch/arm64/kernel/machine_kexec_file.c     |   6 ++
>  arch/loongarch/kernel/machine_kexec_file.c |   6 ++
>  arch/riscv/kernel/machine_kexec_file.c     |   4 +
>  drivers/of/fdt.c                           |  11 ++-
>  drivers/of/of_private.h                    |   3 +
>  drivers/of/of_reserved_mem.c               | 108 ++++++++++++++++++---
>  include/linux/crash_core.h                 |   6 ++
>  include/linux/of_reserved_mem.h            |  15 +++
>  kernel/dma/contiguous.c                    |   1 +
>  9 files changed, 142 insertions(+), 18 deletions(-)
> 



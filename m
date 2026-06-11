Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F023CD98C6
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 02:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rrKKxjQkCCq7BO+0b9GvAXj1oVgaGXMfePrho45byEA=; b=PDe4jiupAxmzBcWXWDiePi+G0F
	OxxCcnYHATaGHIlInbR57L91Vo82BwCMds1Yy2y2XTxs4NbSyGwJ139yzumPM4QWIktzLZok6segh
	g4pnIQT97jS68UaAYjX5Kd1Q0YCjC4teFKOryJGbYZsWWdkJVHhgcYPnvzUcKJXjQbhdAUirR5lMx
	ABEKAt/oCKwPFxvRV/0HC2yVo08ao6gh+3emIG+nB994ifak7zl2xCNHpS/5DXq40sFlYp/QY+3Ks
	OFZVHHSmU/SFREXbGnllqck2ER7QbUiuOPTWF5Qq3f9+xp/7bb3FDNJFx1CHIymgSa83UvRS9nx7I
	MHEwYLWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXUrh-00000008YAC-1jYl;
	Thu, 11 Jun 2026 02:09:53 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXUre-00000008Y94-2E54
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 02:09:52 +0000
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-2c0c3546924so49663045ad.3
        for <kexec@lists.infradead.org>; Wed, 10 Jun 2026 19:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781143789; x=1781748589; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rrKKxjQkCCq7BO+0b9GvAXj1oVgaGXMfePrho45byEA=;
        b=CVgEsQyn8p3i+wQXvcwzqsMJCig1u3MK4JEwYNHK7OSqGpG276McCNVZN1osSUpNPD
         k2EniKOnF4c/JT5zYQKI4oIuu2Cclz78zxLo/qLwj49Hodq3KoThsgGrhGXdD9qQBHRa
         nYtUulLPid3jsO37bnArjwXtKuY/my9KiKQbboHXxXCFySr5O2iaV8rjxeXq7gY4bfgc
         SFfLhZdJUxMra/fkIJRPDK/KaQ3tIUsMWjvjfFRpStu7VQPr/hBp0vxVcykpKg5OeEiP
         L/QgXZBeYdWYYfA9+OLL/7WUcTlY2onPJeisrXQVEHBcoov2vZoWIp5iddq2fsAlKwx1
         xbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781143789; x=1781748589;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrKKxjQkCCq7BO+0b9GvAXj1oVgaGXMfePrho45byEA=;
        b=qtISIWMkq5SDUlDFVhUvs3Q3WtCHR/qpco7eVshmIU5Issb5Ng81djp81oIaA9wexW
         Tk4+l8f8FtHIM+ZuUpygRX8mB1wi0so36kbgp20txo0rQzIeJTz8gHdy9ZGJXQkIOPpo
         mQZRBUIACtODQyUEKGhAaffthBOEs+AMmi4kG1T9/FALYuoE138/obruX9Wm4II4M0+q
         tptGna6vpvIb//VEyKZe92oH33vxVMrYRdVDxeqzS0z2EIJbqVqXLBcDy0UzIS7DNd5M
         tEqMIdf4yRK5Q6olamczgpQVz+LjwqwNntphOBH/ZtZoNqxVNLbTU50HlefPcHZ+4ySS
         EK+g==
X-Forwarded-Encrypted: i=1; AFNElJ/FW/0Pc0wIeURNw3LXTkF+oW5kO6eghYuWu+tpBoMHIXCn8MN0xicVAJEA7cR9UCF/zcOJmw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwYng82BEzNUARhVcKZrQ39kAbwsRSPnUJysvthcW/jlUcfLKJW
	65WF5MgLpb+Ero58Y6CqkMLbCvGNK42mhbyZwVi3uXEKyuPhZmvzDI1z
X-Gm-Gg: Acq92OHWO9XbeCxHPgaunYMV2AmNhKf3zN1mTXO5Oa6hJze/93AsVnn6XmCO+qhE0xF
	8r648d6R6WhBjL1x7vxCBSLjtaZnQcIwuuR38nDgG6oQOrdh7tBkBa9SHM8XeJFP0Dd0sSyA3Ab
	D9V7jVC1vG93e01/3bsSeVETaHsHZAAAx8RlBnHhF5ptWBS92OtUeBOgxEOvpBmoqaxt3l8OiWl
	1l40s9Suy/L1AolBoKYTA4dypztahYTSXaBv0nRZCciYRN4acF0fwwRzkfAEIQWBoQAgl08F2D/
	+ILhnDdMMQ0HhPOPf95jNkX7e3fNK7W6giNeK1JGtMQBe4WROjAxz3X1JLODFFysYvBApCkxrY7
	7z+/rBVhmeOaNz5S4TdCOs/GW3ldOZvMOffoVpyArvj7O+dBgOl2UD+qqsfUGrqmi5rb5YjPt9N
	juP3bdtDHQ5I/5KKtzy2o60uY9DX4cO9IaXLbypB6sog==
X-Received: by 2002:a17:903:acd:b0:2c1:f29a:b554 with SMTP id d9443c01a7336-2c2f21a11f5mr7037195ad.21.1781143789049;
        Wed, 10 Jun 2026 19:09:49 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa404fsm256644005ad.37.2026.06.10.19.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 19:09:48 -0700 (PDT)
Message-ID: <7ed207fa-4c86-426a-8570-495902ce04c3@gmail.com>
Date: Thu, 11 Jun 2026 10:09:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] kdump: reduce vmcore size and capture time
From: Wandun <chenwandun1@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org,
 iommu@lists.linux.dev, zhaomeijing@lixiang.com, Rob Herring
 <robh@kernel.org>, saravanak@kernel.org, bhe@redhat.com, rppt@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 chenhuacai@kernel.org, kernel@xen0n.name
Cc: catalin.marinas@arm.com, will@kernel.org, alex@ghiti.fr,
 akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 ruirui.yang@linux.dev, m.szyprowski@samsung.com, robin.murphy@arm.com
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
Content-Language: en-US
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_190950_578102_E6038B39 
X-CRM114-Status: GOOD (  18.73  )
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



On 5/27/26 11:29, Wandun Chen wrote:
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
> The series is organized as follows:
> Patches 1-3: Pre-existing fixes and a small prep change.
> Patches 4-5: Restructure to allow appending /memreserve/ entries.
> Patches 6-7: Add a dumpable flag and append /memreserve/ entries.
> Patch 8: Add generic kdump helpers.
> Patches 9-11: Wire the helpers into arm64, riscv and loongarch kdump
>                elfcorehdr preparation.
Hi,

Gentle ping on this series.

Status summary:
-patch 03: respun separately per Rob's suggestion, picked up for 7.2
-patch 06: Acked-by: Marek Szyprowski -patch 09: Acked-by: Will Deacon 
The remaining patches (01, 02, 04, 05, 07, 08, 10, 11) are still 
awaiting review. your feedback would be greately appreciated. I know we 
are at the end of 7.1 -rc cycle, I don't want to rush this series, just 
collecting more feedback, and will send next version based on 7.2-rc1. 
If spliting the series into smaller logical group would make review 
easier, please let me know. Best regards, Wandun
>
> v2 --> v3:
> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.[2]
> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
> 3. Add some prepare patches.
>
> v1 --> v2:
> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
>     feedback [1], v2 drop that property and exclude reserve memory
>     by default.
> 2. Split some prepared patches from the original patches.
> 3. Address coding-style comments on patch 5 from Rob.
>
> [1] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
> [2] https://sashiko.dev/#/patchset/20260520091844.592753-1-chenwandun%40lixiang.com?part=4
>
> Wandun Chen (11):
>    of: reserved_mem: handle NULL name in of_reserved_mem_lookup()
>    kexec/crash: provide crash_exclude_mem_range() stub when
>      CONFIG_CRASH_DUMP=n
>    of: reserved_mem: avoid post-init UAF when alloc_reserved_mem_array()
>      fails
>    of: reserved_mem: zero total_reserved_mem_cnt if no valid
>      /reserved-memory entry
>    of: reserved_mem: split alloc_reserved_mem_array() from
>      fdt_scan_reserved_mem_late()
>    of: reserved_mem: add dumpable flag to opt-in vmcore
>    of: reserved_mem: save /memreserve/ entries into the reserved_mem
>      array
>    of: reserved_mem: add kdump helpers to exclude non-dumpable regions
>    arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
>    riscv: kdump: exclude non-dumpable reserved memory regions from vmcore
>    loongarch: kdump: exclude non-dumpable reserved memory regions from
>      vmcore
>
>   arch/arm64/kernel/machine_kexec_file.c     |   6 ++
>   arch/loongarch/kernel/machine_kexec_file.c |   6 ++
>   arch/riscv/kernel/machine_kexec_file.c     |   4 +
>   drivers/of/fdt.c                           |  11 +-
>   drivers/of/of_private.h                    |   3 +
>   drivers/of/of_reserved_mem.c               | 117 +++++++++++++++++++--
>   include/linux/crash_core.h                 |   6 ++
>   include/linux/of_reserved_mem.h            |  15 +++
>   kernel/dma/contiguous.c                    |   1 +
>   9 files changed, 157 insertions(+), 12 deletions(-)
>



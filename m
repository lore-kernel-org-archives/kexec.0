Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041A2CCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 03:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BLv1jdYPShZUl6WRXA2OAAq/MQ9I53lb2Im743pbZNE=; b=NY418vuOc3gPZ3A+vSZZPkTRc3
	4Oe/fC1zJEYMZDleVWtggjPM8POtMrIvTBk9602aqhOCxRT4zWpZbz6xkOZhg3TbLaaPQaPN+GUZS
	DCvYYc85oDnYWeYfKTw7d/4nKDGW2n5htzV1c3uPx6PJ8WDO7Z1W8PVwLh4sXERpOsEoqD40Bat8N
	0ghuPzvfzWreABgaZO5DmTsYk0bulgv7X204JTjEqcfLpDoDUlPtsO4nAgkW9DJT6w4H4GPgIMq60
	AH4wXRpPL0viy4w6Xqd/zvKzC9sSSjt7QFahYqXoY+kmnlzztUtGg63IvoXIvaKHm4cgMp1U3GDEd
	Ro9kdrUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHYVJ-00000001p6r-0h5j;
	Fri, 16 Oct 2026 03:21:09 +0000
Received: from mail-pj2-x00.google.com ([2607:f8b0:4864:39::])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHYVG-00000001p5y-0Vm3
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 03:21:07 +0000
Received: by mail-pj2-x00.google.com with SMTP id 98e67ed59e1d1-3abe4fb64d2so2660313a91.1
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 20:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792120865; x=1792725665; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BLv1jdYPShZUl6WRXA2OAAq/MQ9I53lb2Im743pbZNE=;
        b=LMTEU41ljokEc6OQeW06co9vHiMFHRDuaXzJIbtj0+ZFf1NxJ9kLGnDuY+APeooy8Z
         7Arw8Sl1mwaXnSP3SLf/GOarGRPBqQY3qtQvBrwlBEVewG6z7xmPWisfklBi31vbzOsW
         7YUtz/GG2+TBsC7YSP4qx7DV3kzqKaRvpYaBlUYvLMyi4zQdDK0hhDbHaXR3a9t+ge0A
         JI7NNE9EQ2OYCKRj81+CjOPp658mPa54rNMN/YFcylzvDtnrwYrlIO39A4x8zUBlJQ/g
         sJlGeojrNy+4VMkJnGKWveIK3GVtgS3yx8NMPgqWb8r8CWiRVBVd3xtKdX9CII/ts1jR
         2DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792120865; x=1792725665;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BLv1jdYPShZUl6WRXA2OAAq/MQ9I53lb2Im743pbZNE=;
        b=AGy0QCJanc/dK7AZsNMxSi7Ep40ZZqx7vdlDnviJRgG//Ar4Ok54LWUrTBrFw8FCAz
         RbK5qhUXfBS8VJVszM7VSK+Y/yVlSI1Tig1t7z0AxZKue7Ix2LDgH+UOC8tlzH0FH73f
         nILEOAUcLkL9KfrqHki9QROiYwHyRbYDBwEUlVU4zQOsZZBgPS86IJS8cXDsRdsdaTEZ
         d3+YpnwL5XjXddHscMeQp669sOkrLv2IMNBG9GyDNG6mlo98+qy4C9rJo4HnpsrYqtlP
         BnPIVc+tHkOjqspMU9tLZwOcV4mddJfYlbm6r+OanDb0r4wKxNt3QmBvV3T6ZLkJQgRX
         NiSw==
X-Forwarded-Encrypted: i=1; AKwUvBxt6KTBhbSxxyO1CDFJeiBCBS7oa6WLPMcCL2J1fewz0KCddRqHbJQAqsv03mt/LVUv1HSZ7w==@lists.infradead.org
X-Gm-Message-State: AFq9FYJDyHeAYB6dANAkcEdbcQPR0C+oPmLUNCFW+Mrp4CqTFu+SzLlI
	4vEo8W/wO3njokt7+h1xVv6uR4XMFJZPHCFQccVZuJt3VOXPqs4BacLJ
X-Gm-Gg: AYBFou2oEytejxJDdGWMElb5ifsLd9dWeTAs2/3chH86AUJMC9Xof6kE4EEOw0sEz9o
	PPSuyTrbh4jHFuNx7kJNy2VlamVYZU519LXolGR0L8PatAEAQemzZKq8KsYsCn8zpKunEBH5E2/
	ru4Zo7kggzu+g8zdsw/shurazzELJfGdnkvOsNPwD2fvT8XfpfLSntw+RkeyLx0AfOPbAaYCH1z
	bz4Pb4+7ODPQNBhjXDKXEF0NPMHYy839ZYw3xh2g9FGxx+mp8Rlsc2s8x24dCc3qGaICgZTkbVs
	rAzns1lbbIMi563SFoZ/JFhJdUpfp8pWBRFsLwWpttNMrFnqimujJosgW03B1Z3xc5fMUNkiOfK
	sgrSZ7r0WfH9NEWyRyoxv2vK6gFwcK2/ybKzjf9DFhgWkqgQdGor5TQfFsU/aAh2O8QGg+dG0iS
	EUQgzqXIeczjempsFu9tA3NbN5K+w7mnYg3BeGHzyqIC3nlByYJJmvkdIge9gwvWjPXQ/E43Rvl
	OlYRA==
X-Received: by 2002:a17:90b:1801:b0:3ac:a11a:7c79 with SMTP id 98e67ed59e1d1-3aca11a7d89mr3638559a91.16.1792120865028;
        Thu, 15 Oct 2026 20:21:05 -0700 (PDT)
Received: from [10.125.112.22] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9474b52fsm7959974a91.9.2026.10.15.20.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 20:21:03 -0700 (PDT)
Message-ID: <643bbd4c-1041-43b9-9362-17c5330fc06a@gmail.com>
Date: Fri, 16 Oct 2026 11:20:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] kdump: reduce vmcore size and capture time
From: Wandun <chenwandun1@gmail.com>
To: robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org,
 m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev
References: <20261016030855.4062882-1-chenwandun1@gmail.com>
Content-Language: en-US
In-Reply-To: <20261016030855.4062882-1-chenwandun1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_202106_183154_46D57A73 
X-CRM114-Status: GOOD (  31.75  )
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


Hi all,

My SMTP server hit a temporary error (4.3.0) partway through sending
this series, so some patches did not make it to the list. I will resend
the whole series later. Please ignore the current incomplete set.

Sorry for the noise.


Best regards,
Wandun



On 10/16/26 11:08, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> On SoCs that carve out large firmware-owned reserved memory (GPU,
> camera ISP, ...), kdump currently dumps those carveouts as part of
> system RAM even though their contents are firmware state that is not
> useful for kernel crash analysis.
> 
> ACPI systems already filter reserved memory out of the vmcore through
> their existing path: firmware reports those carveouts as unusable in
> the EFI memory map, they get MEMBLOCK_NOMAP set in memblock.memory
> (is_usable_memory(), efi-init.c), and the ELF header builder has
> always skipped nomap regions; only DT-based systems currently fail
> to filter these regions, which is what this series addresses.
> 
> This series introduces a MEMBLOCK_NODUMP flag (suggested by Rob) in
> memblock to filter reserved memory on DT-based architectures. A new
> flag is needed because MEMBLOCK_NOMAP can only express regions without
> a linear mapping, while MEMBLOCK_NODUMP can filter regions that are
> linearly mapped. Reserved regions are marked MEMBLOCK_NODUMP by default
> so kdump omits them; reusable CMA regions are different because their
> pages are handed back to the buddy allocator and may carry crash-relevant
> data.
> 
> Since the reserved memory regions are filtered out, the vmcore is
> smaller in size and faster to produce.
> 
> The series is based on linux-next and is organized as follows:
> 
> Patches 1-3: Preparation and bugfixes: switch riscv crash_mem to
>              memblock, fold the duplicated per-arch memblock walks
>              into the weak defaults, and serialize crash header
>              preparation against memory hotplug.
> Patches 4-7: NODUMP infrastructure: switch crash_core to
>              for_each_mem_region(), introduce the MEMBLOCK_NODUMP
>              flag, add a dumpable flag to struct reserved_mem, and
>              mark /reserved-memory entries with MEMBLOCK_NODUMP.
> Patch 8:     Skip MEMBLOCK_NODUMP regions when building the vmcore
>              ELF header.
> 
> v6 --> v8 (v7 mainly tried to fix the initrd issue on release in v6,
> that approach is superseded here):
> 
> 1. Stop marking /memreserve/ regions with NODUMP. v6 marked
>    /memreserve/ regions with NODUMP. But a bootloader may specify
>    a /memreserve/ entry for memory that the kernel later frees
>    (e.g. the initrd), and those pages would then be wrongly
>    filtered out of the vmcore after being reused as normal memory.
>    The v7 fix (clearing the flag in free_reserved_area()) caused
>    a lockless runtime mutation of memblock.memory [1]. Better solutions
>    exist but need extra preparation, so they are left out to keep
>    this series simple in v8.
> 
> 2. Fix a build failure in patch 2 with both ARCH_KEEP_MEMBLOCK and
>    MEMORY_HOTPLUG are unset. There the memblock arrays live in
>    .init.data, and the weak defaults referencing them create section
>    mismatches, which turn into build errors when SECTION_MISMATCH_WARN_ONLY
>    is also unset.
> 
> 3. RISCV recently gained crash hotplug support, so adapt its handler
>    like x86 in patch 3: use __crash_prepare_headers() instead of
>    crash_prepare_headers() to avoid self-deadlock.
> 
> 4. Update the cover letter per review feedback: describe how ACPI
>    systems filter reserved memory and why a new flag is needed
>    instead of reusing NOMAP.
> 
> Every patch in this series now carries an Acked-by or Reviewed-by tag.
> Patches 2 and 3 have changed since v6, but the changes (a build fix and
> a riscv hotplug adaptation) do not alter the logic the tags were given
> for, so their tags are kept. If any tag should not be carried, please
> let me know and I will drop it.
> 
> 
> v6 --> v7:
> 1. Fix a stale MEMBLOCK_NODUMP flag issue [2]. Memory reserved and
>    marked as NODUMP may later be freed (the initrd, for example),
>    so the NODUMP flag must be cleared accordingly. Since the fix is
>    part of the NODUMP infrastructure introduced by patch 5, it has
>    been folded into that patch.
> 2. Drop the "generic" related description in the cover letter.
> 3. Collect the Acked-by and Reviewed-by tags received during the v6
>    review (thanks to Baoquan, Mike, Rob and Marek). Patch 5 is the
>    only one without a tag, as its Reviewed-by was dropped when the
>    fix was folded in.
> 4. Drop patch 1 of v6, which has been merged separately.
> 
> 
> v5 --> v6:
> 1. Serialize crash header preparation against memory hotplug to avoid
>    out-of-bounds or use-after-free issues.
> 2. MEMBLOCK_NODUMP marking is now done after memblock allows resizing,
>    avoiding a panic from too few regions before resize is permitted.
> 3. Reordered the patches, put pre-existing bugfixes earlier in the series.
> 
> [1] https://lore.kernel.org/lkml/20260922090252.B01541F000FF@smtp.kernel.org/
> [2] https://sashiko.dev/#/message/20260917220750.GA4013814-robh%40kernel.org
> 
> v5: https://lore.kernel.org/lkml/20260806093519.2907771-1-chenwandun1@gmail.com/
> v4: https://lore.kernel.org/lkml/20260630074715.4126796-1-chenwandun1@gmail.com/
> 
> 
> Wandun Chen (8):
>   riscv: build crash_mem ranges from memblock instead of resource tree
>   crash_core: fold duplicated memblock arch hooks into the weak default
>   crash_core: serialize crash header preparation against hotplug
>   crash_core: replace for_each_mem_range() with for_each_mem_region()
>   memblock: introduce MEMBLOCK_NODUMP flag
>   of: reserved_mem: add dumpable flag to opt-in vmcore
>   of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
>   crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
>     header
> 
>  arch/arm64/kernel/machine_kexec_file.c     | 29 ------------
>  arch/loongarch/kernel/machine_kexec_file.c | 27 -----------
>  arch/riscv/Kconfig                         |  2 +-
>  arch/riscv/kernel/crash.c                  |  2 +-
>  arch/riscv/kernel/machine_kexec_file.c     | 33 --------------
>  arch/x86/kernel/crash.c                    |  2 +-
>  drivers/of/fdt.c                           |  1 +
>  drivers/of/of_private.h                    |  1 +
>  drivers/of/of_reserved_mem.c               | 15 ++++++
>  include/linux/crash_core.h                 |  2 +
>  include/linux/memblock.h                   |  9 ++++
>  include/linux/of_reserved_mem.h            |  1 +
>  kernel/crash_core.c                        | 53 +++++++++++++++++++++-
>  kernel/dma/contiguous.c                    |  1 +
>  mm/memblock.c                              | 16 +++++++
>  15 files changed, 100 insertions(+), 94 deletions(-)
> 



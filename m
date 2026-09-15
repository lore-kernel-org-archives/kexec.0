Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C683AC88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+F7E7Bq/M1FITHwdNffpUS733lAk0A+k2uxZSk0JCQc=; b=L9DGrduJVY6eL3nTS/xvmPn0zF
	GdFOyn9YLoMKxYQlh5Q+o6GTXwoNPUV/CkYXB5H/FdfkNhQBMLMaudZp0L4hXJNSQfLKQNTUXEmIy
	x7bySB1in6DymlX32nRCVIR3Dv3C7om5Gx+BxwTB0ZetJpkfqBtzumzdIuYZ2vA7xYHKcA9hiasJy
	lmyFQm5KoysTvv+ruzjdcJIz55QosTneLMo+OIzx7FERXBbtFLki0s0NTP3acbnO5FvKRUA/oG6pG
	X3fabMxv+G0Bsn+yVp0ssxDmAblkpqvL3Zk2j3G92pCScdk1XtkHJvlYSRyyfKBTIdBD0XFPTBWhB
	eYqVXblw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Smz-00000006dqk-19GJ;
	Tue, 15 Sep 2026 13:01:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Smu-00000006dpZ-3qR8
	for kexec@bombadil.infradead.org;
	Tue, 15 Sep 2026 13:01:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+F7E7Bq/M1FITHwdNffpUS733lAk0A+k2uxZSk0JCQc=; b=ZXSqqHNqmtWQE/xk4q1A4odoZQ
	WEJULYEp6G+lNQg3c6lCD3OIens65iWvdv6aejTGhCaozmiw3+85yH745okXvAsbeNJmU36aFFP/G
	AjWFuBlMS2ILkpSU7QX46CGKoXXGgJqH2UhPepokKbQjQDC0zHkdbHgIuNj50FNZqKaL+mBtGU9aJ
	51huGZOfbzvucog2nK8Qcmnj2+nhaFOSCkgXFxyVMY1SPklnpmnBkPbFUzWtBRQ1+9yXdf/Tn0LNf
	vBnGk1Ao5Jb9CI3pMslbEGPSAb7Ht20Pt6i8o1UMrHUTk2hTtMfYJIxBFh2eZQeUsnh8khzvnVnX2
	RM2nAW6Q==;
Received: from mail-pj2-x08.google.com ([2607:f8b0:4864:39::8])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6Smq-00000006mhl-0fKy
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 13:01:26 +0000
Received: by mail-pj2-x08.google.com with SMTP id d9443c01a7336-2d8fcda61c8so20306175ad.1
        for <kexec@lists.infradead.org>; Tue, 15 Sep 2026 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789477282; x=1790082082; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+F7E7Bq/M1FITHwdNffpUS733lAk0A+k2uxZSk0JCQc=;
        b=jdeSD89VEXR070frLIn9irnMXcM27YASPEuA4Q6s/buqyKSd874gt0traPN23xJfMl
         jbfPipvOWxjOr1i1rnC8SB7BKRSTNEubbndxuhtpqcgNraX4sKxozcCaj+1hcb8NzIqJ
         zk+v69LAI0jsokxage7siy6d7N9SEC7HRjXQmGFWsGmgDy0K2qFbG1JfwAvaKEqDN282
         AHgGPBjQas7At5k5l4UZ3AyK3tM0kQdJ7LfMKoC3xTaaOpGBNgVj7BYr571VjM2IMQ5f
         wwm003iXQdY/54pE/p2Sr6ynexF4ztAUyBqrzynqBFK6InbqLccnjUXmr6mamz0xiocC
         ggtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789477282; x=1790082082;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+F7E7Bq/M1FITHwdNffpUS733lAk0A+k2uxZSk0JCQc=;
        b=ItpggOob45B0kScJSNwg5e2F2OMj/5zQTDY9zDilkq39Jf1RnzAh2bggWNE2PsYZxb
         1Bm27QyiVZPn7ek0rO6eiqKQkhhOSEYRAoqmMjsB+p4BbzrEg3bxAgFjt7eGfOGlEBAn
         UTcoZtCunHq+HZWUMQP4J6mPH1CyDdXDKxjBYqLv6VxcoSGDEAhGo2I2mkt/1deTuC5y
         W0AWSf66a5IBDMVvsrgvgsQv/qx9kh9mIH6QL4CXlcFPkFwK9lfGuGDx9JVK0uR60lkl
         S4Qoq1ZLhOI5jU36hzz3/OBP1HH8cgJmfAvipBE4wB92285kiuQjB0ccj6H6/cRZtrhD
         Y74w==
X-Forwarded-Encrypted: i=1; AKwUvBzjbFypWt2Qf4Wn9I5rmCDEgaKY+vQyoUoJH7/hINeD/xbDDm4PJtdA+Y2Plt3ucfsxLip4Ag==@lists.infradead.org
X-Gm-Message-State: AFuF++nXLindeQpJP/k9LgaujBy/l/2gx/UXc90+Sl+GHLlUsJWDsduR
	ugrUpLmO+608dAvgmAsfbYxFncXRqwYde/UxyeRXyKrYjT3S/60l96Tx
X-Gm-Gg: AYBFou1t3GkBrGpiPZS3w0vJl4CFWHX4lf9pGXcUza/eA5yc2eES+hsYwZcO3TiEWBB
	BsvIcIwnZl6rnqsaZht+4tMKEFTsajVgX3DjbCKyOReKGy/h/L9rakkXuJvlkMClLilr8sS+rFX
	QU0/K273bX0RDOdC0awicNWusI6INyM7ro6EteX2nF74WnxXsbR4isiFFuRPUhQhap/uHAxACld
	BDUt/ambA+hOMQ/oMkLSQv1lP1751h9Ebn4e9YcUkuPmCYO6+WYdwakRLFqw/CuVAUDJdKyBkmb
	aie3XljG81ENKxjKE63AyHYs+ntX0r8DViI/8knezgk+9EALDKt6Qo9VEF5UmSXFCAoxV2m6ANC
	8m9l1wLt/Tj6qU3i0i7Vb5LXFyt0t28Kek4Lu6yQy6EvAxiGvNfjg95Lv5vthm7yPHmD8qKzAn7
	junZ8IItTmjzuKjfiEuB9nmS4aCL9MqI+WlaH7E+2iyXi9jOyBlVj0lgXMzYz0a7R2z8n4iWX03
	u5VZw==
X-Received: by 2002:a17:903:3d0d:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2dd6c6eb7a4mr138425825ad.13.1789477281468;
        Tue, 15 Sep 2026 06:01:21 -0700 (PDT)
Received: from [10.125.112.20] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd87e5sm67187695ad.58.2026.09.15.06.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 06:01:20 -0700 (PDT)
Message-ID: <13cfcd99-e420-478b-8ce8-06674727977d@gmail.com>
Date: Tue, 15 Sep 2026 21:01:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] kdump: reduce vmcore size and capture time
From: Wandun <chenwandun1@gmail.com>
To: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
 baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
 pratyush@kernel.org, m.szyprowski@samsung.com
Cc: mark.rutland@arm.com, kernel@xen0n.name, alex@ghiti.fr, hpa@zytor.com,
 ruirui.yang@linux.dev, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 iommu@lists.linux.dev
References: <20260902073116.802752-1-chenwandun1@gmail.com>
Content-Language: en-US
In-Reply-To: <20260902073116.802752-1-chenwandun1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_140124_356885_D24239DE 
X-CRM114-Status: GOOD (  27.11  )
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



On 9/2/26 15:31, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> On SoCs that carve out large firmware-owned reserved memory (GPU,
> camera ISP, ...), kdump currently dumps those carveouts as part of
> system RAM even though their contents are firmware state that is not
> useful for kernel crash analysis.
> 
> This series introduces a MEMBLOCK_NODUMP flag in memblock to filter
> reserved memory on DT-based architectures (arm64, riscv, loongarch).
> Reserved regions default are marked MEMBLOCK_NODUMP so kdump omits them;
> reusable CMA regions are different because their pages are handed back
> to the buddy allocator and may carry crash-relevant data.
> 
> ACPI systems already filter reserved memory out of the vmcore through
> their existing path; only DT-based systems currently fail to filter these
> regions, which is what this series addresses. The flag lives in memblock
> itself rather than in a DT-only structure, so the mechanism is generic and
> both ACPI and DT systems can benefit from it (suggested by Rob, thanks) [1].
> 
> Since the reserved memory regions are filtered out, the vmcore is
> smaller in size and faster to produce. 
> 
> The series is based on linux-next and is organized as follows:
> 
> Patches 1-4: Preparation and bugfixes: fix the missing HugeTLB
>              flagname, switch riscv crash_mem to memblock, fold the
>              duplicated per-arch memblock walks into the weak
>              defaults, and serialize crash header preparation against
>              memory hotplug.
> Patches 5-9: NODUMP infrastructure: switch crash_core to
>              for_each_mem_region(), introduce the MEMBLOCK_NODUMP
>              flag, add a dumpable flag to struct reserved_mem, and
>              mark /reserved-memory and /memreserve/ entries with
> 	     MEMBLOCK_NODUMP flag.
> Patch 10:    Exclude MEMBLOCK_NODUMP regions from the vmcore ELF
>              header.

Hi,

Gentle ping on the remaining patches of this series.
Patches 1, 7, 8 and 9 have been reviewed (thanks Mike and Marek);
Still looking for review on patches 2-6 and 10.

Would appreciate a look when you have a moment, happy to rework
anything based on feedback.

Best regards,
Wanun

> 
> In v5, Sashiko found some pre-existing issues related to reserved-memory,
> and has no dependency on this series, so these issues have been addressed
> in a separate series [2].
> 
> v5 --> v6:
> 1. Serialize crash header preparation against memory hotplug to avoid
>    out-of-bounds or use-after-free issues.
> 
> 2. MEMBLOCK_NODUMP marking is now done after memblock allows resizing,
>    avoiding a panic from too few regions before resize is permitted.
> 
> 3. Reordered the patches, put pre-existing bugfixes earlier in the series.
> 
> 
> v4 --> v5:
> 1. Rework the mechanism around a memblock-level MEMBLOCK_NODUMP flag
>    (suggested by Rob) instead of the v4 opt-in 'dumpable' flag on
>    DT-only struct reserved_mem.
> 2. Switch the riscv vmcore elf header preparation to use memblock
>    instead of the resource tree, aligning it with arm64 and loongarch,
>    so riscv also can exclude reserved memory from vmcore.
> 3. Deduplicate the vmcore elf header preparation: arm64, riscv and
>    loongarch open-coded the same logic, so fold it into shared
>     __weak defaults in crash_core.
> 4.  Drop the v4 patch that saved /memreserve/ entries into the
>     reserved_mem array; /memreserve/ is now marked MEMBLOCK_NODUMP
>     directly.
> 
> v3 --> v4:
> 1. Rebase this series on v7.2-rc1.
> 2. Add two cleanup patches (patch 02/03).
> 3. Simplify patch 03 to avoid checking whether initial_boot_params is
>    NULL multiple times, suggested by Rob.
> 
> v2 --> v3:
> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.
> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
> 3. Add some prepare patches.
> 
> v1 --> v2:
> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
>    feedback [3], v2 drop that property and exclude reserve memory
>    by default.
> 2. Split some prepared patches from the original patches.
> 3. Address coding-style comments on patch 5 from Rob.
> 
> [1] https://lore.kernel.org/lkml/20260723234126.GA3253409-robh@kernel.org/
> [2] https://lore.kernel.org/lkml/20260818092420.2859026-1-chenwandun1@gmail.com/
> [3] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
> 
> Meijing Zhao (1):
>   mm: memblock: add missing HugeTLB flag name
> 
> Wandun Chen (9):
>   riscv: build crash_mem ranges from memblock instead of resource tree
>   crash_core: fold duplicated memblock arch hooks into the weak default
>   crash_core: serialize crash header preparation against hotplug
>   crash_core: replace for_each_mem_range() with for_each_mem_region()
>   memblock: introduce MEMBLOCK_NODUMP flag
>   of: reserved_mem: add dumpable flag to opt-in vmcore
>   of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
>   of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
>   crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
>     header
> 
>  arch/arm64/kernel/machine_kexec_file.c     | 29 ------------
>  arch/loongarch/kernel/machine_kexec_file.c | 27 ------------
>  arch/riscv/Kconfig                         |  2 +-
>  arch/riscv/kernel/machine_kexec_file.c     | 33 --------------
>  arch/x86/kernel/crash.c                    |  2 +-
>  drivers/of/fdt.c                           |  2 +
>  drivers/of/of_private.h                    |  2 +
>  drivers/of/of_reserved_mem.c               | 48 ++++++++++++++++++++
>  include/linux/crash_core.h                 |  2 +
>  include/linux/memblock.h                   |  9 ++++
>  include/linux/of_reserved_mem.h            |  1 +
>  kernel/crash_core.c                        | 51 ++++++++++++++++++++--
>  kernel/dma/contiguous.c                    |  1 +
>  mm/memblock.c                              | 17 ++++++++
>  14 files changed, 131 insertions(+), 95 deletions(-)
> 



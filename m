Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD27C61DD3
	for <kexec@archiver.kernel.org>; Thu,  3 Sep 2026 09:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1MZQdmy+aD6EzeJNs6e/eUAQKmqctsgijH/5ayyWVio=; b=T/ccyycqhTh+1cA6QiwELTBSZd
	42VBUhq2riTk0P4DaBaNZRV5U9PR3e6SWCYiMy5zlXAJSGd/yUzczRs6Vg8JkBSfsBLjxQPVz5HXx
	9cdWW+gZtLF0f115eYQvG35tWD7XqL615xWEnKHHWyNm5B4SlNIu9en+2RxKmofzSkZdZnHW5tv0k
	FKephaIS06g6vtUEXu66J+sgvDvmvZFXIkUOMqlBrTN13XVDN1thrpIgYgXsywKj1JOPRcL3zU+TA
	tF3v3EAAgJueXXHpZqoe9PmcYhK3L9xxQwvMMrFVcrIvKk8cstS/bAhC4qJUbDiD3jJdI6nPH1yKz
	PKzL0ing==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x23tl-0000000GySt-3xUb;
	Thu, 03 Sep 2026 09:38:21 +0000
Received: from out-37.mta1.migadu.com ([95.215.58.37] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x23ti-0000000GyRb-0ucc
	for kexec@lists.infradead.org;
	Thu, 03 Sep 2026 09:38:19 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=xkq56dwf8DBNdrzi3qeWturDMdOajTLtoV/DhFx+x38=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788428296; v=1; x=1789033096;
 b=dJKMYrpSu9hn6T+tGDlWJlDQ8ca+hlEszTRs1d1hxr5tWLbMftClkEyJ+BrqB5HWh5zDTwEj
 +M1lOPYdCmPeU1VkaX/CkgZxJpZiXRV30o9RlQMJnKHfHhc3BBU2gUfa7h6YXs/1FpWFbE4Xd9X
 IVSYZ1HJ3fRjiN7HazC+Ob3Y=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 4c96c0b4fdde9bc3;
	Thu, 03 Sep 2026 09:38:16 +0000
X-Mizu-Trace-ID: 4c96c0b4fdde9bc3
X-Migadu-Flow: FLOW_OUT
Date: Thu, 3 Sep 2026 17:38:11 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Wandun <chenwandun1@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, robh@kernel.org,
	saravanak@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	m.szyprowski@samsung.com, mark.rutland@arm.com, kernel@xen0n.name,
	alex@ghiti.fr, hpa@zytor.com, ruirui.yang@linux.dev,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v6 00/10] kdump: reduce vmcore size and capture time
Message-ID: <aplAA9-NX3pw9Wmb@fedora>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <apfkDlcMYrgiuGYA@fedora>
 <6aef2f48-1cc5-408d-a5a2-2b4b4d45ad7b@gmail.com>
 <apkiW8gn9Z5XaVQh@fedora>
 <edd83cd6-663f-43f5-8058-99e59d941d5b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edd83cd6-663f-43f5-8058-99e59d941d5b@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_023818_405168_12F044DE 
X-CRM114-Status: GOOD (  38.47  )
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

On 09/03/26 at 03:43pm, Wandun wrote:
> 
> 
> On 9/3/26 15:31, Baoquan He wrote:
> > On 09/03/26 at 03:05pm, Wandun wrote:
> >>
> >>
> >> On 9/2/26 16:53, Baoquan He wrote:
> >>> Hi Wandun,
> >>>
> >>> On 09/02/26 at 03:31pm, Wandun Chen wrote:
> >>>> From: Wandun Chen <chenwandun@lixiang.com>
> >>>>
> >>>> On SoCs that carve out large firmware-owned reserved memory (GPU,
> >>>> camera ISP, ...), kdump currently dumps those carveouts as part of
> >>>> system RAM even though their contents are firmware state that is not
> >>>> useful for kernel crash analysis.
> >>>>
> >>>> This series introduces a MEMBLOCK_NODUMP flag in memblock to filter
> >>>> reserved memory on DT-based architectures (arm64, riscv, loongarch).
> >>>> Reserved regions default are marked MEMBLOCK_NODUMP so kdump omits them;
> >>>> reusable CMA regions are different because their pages are handed back
> >>>> to the buddy allocator and may carry crash-relevant data.
> >>>>
> >>>> ACPI systems already filter reserved memory out of the vmcore through
> >>>> their existing path; only DT-based systems currently fail to filter these
> >>>> regions, which is what this series addresses. The flag lives in memblock
> >>>> itself rather than in a DT-only structure, so the mechanism is generic and
> >>>> both ACPI and DT systems can benefit from it (suggested by Rob, thanks) [1].
> >>>
> >>> Thanks for the effort. I am not against this patchset, and I haven't
> >>> went through it carefully. Just from the cover letter, you mentioned
> >>> generic, I am wondering if this can be generic for excluding other
> >>> memory regions. Asking this because I try to find a way to exclude
> >>> unwanted memory regions too, please check below link where there's
> >>> the relevant discussion. We definitely don't like inventing wheels
> >>> time after time. Do you think this memblock region excluding can
> >>> be used in other places of kernel?
> >>>
> >>> https://lore.kernel.org/all/aoLFai0gzzH2bGgy@MiWiFi-R3L-srv/T/#u
> >>
> >>
> >> Thanks for taking a look, and for the pointer to the crash-wipe thread.
> >>
> >> To answer your question directly: the exclusion mechanism in this series
> >> is already generic, memblock_mark_nodump() is the entry point. Any code
> >> that wants a region out of the vmcore just marks it MEMBLOCK_NODUMP, when
> >> preparing vmcore elf header by walking memblock, these regionss are skipped;
> >> This series is simply one caller, marking the DTS /reserved-memory and
> >> /memreserve/ regions with MEMBLOCK_NODUMP.
> > 
> > Thanks, for memory not allocated from memblock, e.g buddy, is it still
> > good?
> 
> Yes, still good, only need to pass the physical range to memblock_mark_nodump().

That's interesting. If drivers or any component allocate memory from
buddy, then you will call memblock_mark_nodump() to mark the region
specifically (memblock_setclr_flag will split regions if it's a sub
region of existing memblock region), it won't impact anything?

> 
> > 
> >>
> >> x86 currently builds the vmcore elf header from iomem_resource, not
> >> memblock; it could be switched to memblock, but that would bring no
> >> benefit for the problem this series solves, so this series makes no
> >> x86 change. I'd personally be in favor of switching to memblock for
> >> a unified implementation across architectures.
> >>
> >> Best regards
> >> Wandun
> >>
> >>
> >>>
> >>>>
> >>>> Since the reserved memory regions are filtered out, the vmcore is
> >>>> smaller in size and faster to produce. 
> >>>>
> >>>> The series is based on linux-next and is organized as follows:
> >>>>
> >>>> Patches 1-4: Preparation and bugfixes: fix the missing HugeTLB
> >>>>              flagname, switch riscv crash_mem to memblock, fold the
> >>>>              duplicated per-arch memblock walks into the weak
> >>>>              defaults, and serialize crash header preparation against
> >>>>              memory hotplug.
> >>>> Patches 5-9: NODUMP infrastructure: switch crash_core to
> >>>>              for_each_mem_region(), introduce the MEMBLOCK_NODUMP
> >>>>              flag, add a dumpable flag to struct reserved_mem, and
> >>>>              mark /reserved-memory and /memreserve/ entries with
> >>>> 	     MEMBLOCK_NODUMP flag.
> >>>> Patch 10:    Exclude MEMBLOCK_NODUMP regions from the vmcore ELF
> >>>>              header.
> >>>>
> >>>> In v5, Sashiko found some pre-existing issues related to reserved-memory,
> >>>> and has no dependency on this series, so these issues have been addressed
> >>>> in a separate series [2].
> >>>>
> >>>> v5 --> v6:
> >>>> 1. Serialize crash header preparation against memory hotplug to avoid
> >>>>    out-of-bounds or use-after-free issues.
> >>>>
> >>>> 2. MEMBLOCK_NODUMP marking is now done after memblock allows resizing,
> >>>>    avoiding a panic from too few regions before resize is permitted.
> >>>>
> >>>> 3. Reordered the patches, put pre-existing bugfixes earlier in the series.
> >>>>
> >>>>
> >>>> v4 --> v5:
> >>>> 1. Rework the mechanism around a memblock-level MEMBLOCK_NODUMP flag
> >>>>    (suggested by Rob) instead of the v4 opt-in 'dumpable' flag on
> >>>>    DT-only struct reserved_mem.
> >>>> 2. Switch the riscv vmcore elf header preparation to use memblock
> >>>>    instead of the resource tree, aligning it with arm64 and loongarch,
> >>>>    so riscv also can exclude reserved memory from vmcore.
> >>>> 3. Deduplicate the vmcore elf header preparation: arm64, riscv and
> >>>>    loongarch open-coded the same logic, so fold it into shared
> >>>>     __weak defaults in crash_core.
> >>>> 4.  Drop the v4 patch that saved /memreserve/ entries into the
> >>>>     reserved_mem array; /memreserve/ is now marked MEMBLOCK_NODUMP
> >>>>     directly.
> >>>>
> >>>> v3 --> v4:
> >>>> 1. Rebase this series on v7.2-rc1.
> >>>> 2. Add two cleanup patches (patch 02/03).
> >>>> 3. Simplify patch 03 to avoid checking whether initial_boot_params is
> >>>>    NULL multiple times, suggested by Rob.
> >>>>
> >>>> v2 --> v3:
> >>>> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.
> >>>> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
> >>>> 3. Add some prepare patches.
> >>>>
> >>>> v1 --> v2:
> >>>> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
> >>>>    feedback [3], v2 drop that property and exclude reserve memory
> >>>>    by default.
> >>>> 2. Split some prepared patches from the original patches.
> >>>> 3. Address coding-style comments on patch 5 from Rob.
> >>>>
> >>>> [1] https://lore.kernel.org/lkml/20260723234126.GA3253409-robh@kernel.org/
> >>>> [2] https://lore.kernel.org/lkml/20260818092420.2859026-1-chenwandun1@gmail.com/
> >>>> [3] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
> >>>>
> >>>> Meijing Zhao (1):
> >>>>   mm: memblock: add missing HugeTLB flag name
> >>>>
> >>>> Wandun Chen (9):
> >>>>   riscv: build crash_mem ranges from memblock instead of resource tree
> >>>>   crash_core: fold duplicated memblock arch hooks into the weak default
> >>>>   crash_core: serialize crash header preparation against hotplug
> >>>>   crash_core: replace for_each_mem_range() with for_each_mem_region()
> >>>>   memblock: introduce MEMBLOCK_NODUMP flag
> >>>>   of: reserved_mem: add dumpable flag to opt-in vmcore
> >>>>   of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
> >>>>   of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
> >>>>   crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
> >>>>     header
> >>>>
> >>>>  arch/arm64/kernel/machine_kexec_file.c     | 29 ------------
> >>>>  arch/loongarch/kernel/machine_kexec_file.c | 27 ------------
> >>>>  arch/riscv/Kconfig                         |  2 +-
> >>>>  arch/riscv/kernel/machine_kexec_file.c     | 33 --------------
> >>>>  arch/x86/kernel/crash.c                    |  2 +-
> >>>>  drivers/of/fdt.c                           |  2 +
> >>>>  drivers/of/of_private.h                    |  2 +
> >>>>  drivers/of/of_reserved_mem.c               | 48 ++++++++++++++++++++
> >>>>  include/linux/crash_core.h                 |  2 +
> >>>>  include/linux/memblock.h                   |  9 ++++
> >>>>  include/linux/of_reserved_mem.h            |  1 +
> >>>>  kernel/crash_core.c                        | 51 ++++++++++++++++++++--
> >>>>  kernel/dma/contiguous.c                    |  1 +
> >>>>  mm/memblock.c                              | 17 ++++++++
> >>>>  14 files changed, 131 insertions(+), 95 deletions(-)
> >>>>
> >>>> -- 
> >>>> 2.43.0
> >>>>
> >>
> 


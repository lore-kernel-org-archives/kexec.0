Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2794C982D2
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 07:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iG9TE3i2ben8shGNkspUy6ctghynma/j8xkooo4i6XY=; b=16dev+cDP5OieyuahgJpmpW8eC
	/R9xqU043EClUimkOWIBRQSizzohqeOTLHMfofs68J2uEP2A1S9n66Df2uqe/v1AnXvNs/9tLKoNN
	05R0stdL2o22dstWrHDEN+Ht0Wf+gIxM+mjQKqO35XXnbLhowEIVnLKZcCPSJmxbZx1bFzFCwhLcj
	9z2YHeFK+xL6xy6aA/dKYVUpwSQewvtvQ25XyaO+LPVSOO2ziVDa8k3mN6OvYZ6d1SE+MJ9Zik5RA
	cDYO0l5Tms3/d42c+Tas7Us0Syl0dCgYokfdONtwW085OE3HRlAHJ4p8fZk5Bz+Yv0vZASO0GGRuL
	DfonhdWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7T3x-0000000DhuG-1mbz;
	Fri, 18 Sep 2026 07:31:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7T3v-0000000DhtI-3W50
	for kexec@bombadil.infradead.org;
	Fri, 18 Sep 2026 07:31:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iG9TE3i2ben8shGNkspUy6ctghynma/j8xkooo4i6XY=; b=b6ZFQR1hvgeEs5ymEkrl5l4IqM
	U9ZpCFGQT3uPmL1Tn4Kk+1H1HrDVBPHsDr/NCSwNZGFj0ja0D6O6452mh6pDo9TdPAL4DkeI/SjcK
	0sFYUK1CZkzE3fzuDB1UeHZUTzFKPb5XrboEfjsFrwi2eON2y16K3YlY88uvyFoOzg+6cK81GOS+8
	1J0LZYZKXwPWHKvi9OMe7oFwFCNyrO071xz/IYr7wjMw7icdF1fNieDPpW1Z9+btu5TW2pBMqS8Hk
	5zhtZFFpwYmZfKNmfiv2YB/iTk2P69vSs7+Jcq8WZOKbfEneBkmtqeLWM/AfV1wptU5lbZ3JoXOIh
	zTCLuz+Q==;
Received: from out-205.mta0.migadu.com ([2001:41d0:1004:224b::cd] helo=mta0.migadu.com)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7T3r-00000009iIh-37aC
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 07:31:10 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=A0ZxUuBFvNPTWV1BVZ21PLOvGnhXlq1pS65I/1JMwuc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789716665; v=1; x=1790321465;
 b=OddnrBSp5q03B7tRuHJLM3xcGpfDmIYvNDZbBElvCVQ5B6GjNA2XANEUoWnkmzSpEsPIAf1i
 EBKDFtsPo6yG84TuyO+z/4ncYu+iZ2bo1iANUF2aERqxsUnYWPX6Q5qLab4glXOcQfHsUQ6Ab5p
 0LOFxLyNzVnNweqt9X1HlbEQ=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id 33707ef04d706312;
	Fri, 18 Sep 2026 07:31:05 +0000
X-Mizu-Trace-ID: 33707ef04d706312
X-Migadu-Flow: FLOW_OUT
Date: Fri, 18 Sep 2026 15:31:00 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wandun <chenwandun1@gmail.com>, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, pasha.tatashin@soleen.com,
	pratyush@kernel.org, m.szyprowski@samsung.com, mark.rutland@arm.com,
	kernel@xen0n.name, alex@ghiti.fr, hpa@zytor.com,
	ruirui.yang@linux.dev, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH v6 00/10] kdump: reduce vmcore size and capture time
Message-ID: <aqzotDs4yDRxgcWS@fedora>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <13cfcd99-e420-478b-8ce8-06674727977d@gmail.com>
 <aqziOmx1yhy0ozkX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqziOmx1yhy0ozkX@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_083107_948265_4183E6C0 
X-CRM114-Status: GOOD (  32.15  )
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

On 09/18/26 at 10:03am, Mike Rapoport wrote:
> Hi,
> 
> On Tue, Sep 15, 2026 at 09:01:07PM +0800, Wandun wrote:
> > On 9/2/26 15:31, Wandun Chen wrote:
> > > From: Wandun Chen <chenwandun@lixiang.com>
...snip... 
> > > ACPI systems already filter reserved memory out of the vmcore through
> > > their existing path; only DT-based systems currently fail to filter these
> > > regions, which is what this series addresses. The flag lives in memblock
> > > itself rather than in a DT-only structure, so the mechanism is generic and
                                                                     ~~~~~~~
> > > both ACPI and DT systems can benefit from it (suggested by Rob, thanks) [1].
> > > 
> > > Since the reserved memory regions are filtered out, the vmcore is
> > > smaller in size and faster to produce. 
> > > 
> > > The series is based on linux-next and is organized as follows:
> > > 
> > > Patches 1-4: Preparation and bugfixes: fix the missing HugeTLB
> > >              flagname, switch riscv crash_mem to memblock, fold the
> > >              duplicated per-arch memblock walks into the weak
> > >              defaults, and serialize crash header preparation against
> > >              memory hotplug.
> > > Patches 5-9: NODUMP infrastructure: switch crash_core to
> > >              for_each_mem_region(), introduce the MEMBLOCK_NODUMP
> > >              flag, add a dumpable flag to struct reserved_mem, and
> > >              mark /reserved-memory and /memreserve/ entries with
> > > 	     MEMBLOCK_NODUMP flag.
> > > Patch 10:    Exclude MEMBLOCK_NODUMP regions from the vmcore ELF
> > >              header.
> > 
> > Hi,
> > 
> > Gentle ping on the remaining patches of this series.
> > Patches 1, 7, 8 and 9 have been reviewed (thanks Mike and Marek);
> > Still looking for review on patches 2-6 and 10.
> 
> I'm waiting for reviews from Baoquan and Dave for crash core patches before
> applying this series.

I will go through the crash core patches, thanks for reminding.

>  
> > Would appreciate a look when you have a moment, happy to rework
> > anything based on feedback.
> > 
> > Best regards,
> > Wanun
> > 
> > > 
> > > In v5, Sashiko found some pre-existing issues related to reserved-memory,
> > > and has no dependency on this series, so these issues have been addressed
> > > in a separate series [2].
> > > 
> > > v5 --> v6:
> > > 1. Serialize crash header preparation against memory hotplug to avoid
> > >    out-of-bounds or use-after-free issues.
> > > 
> > > 2. MEMBLOCK_NODUMP marking is now done after memblock allows resizing,
> > >    avoiding a panic from too few regions before resize is permitted.
> > > 
> > > 3. Reordered the patches, put pre-existing bugfixes earlier in the series.
> > > 
> > > 
> > > v4 --> v5:
> > > 1. Rework the mechanism around a memblock-level MEMBLOCK_NODUMP flag
> > >    (suggested by Rob) instead of the v4 opt-in 'dumpable' flag on
> > >    DT-only struct reserved_mem.
> > > 2. Switch the riscv vmcore elf header preparation to use memblock
> > >    instead of the resource tree, aligning it with arm64 and loongarch,
> > >    so riscv also can exclude reserved memory from vmcore.
> > > 3. Deduplicate the vmcore elf header preparation: arm64, riscv and
> > >    loongarch open-coded the same logic, so fold it into shared
> > >     __weak defaults in crash_core.
> > > 4.  Drop the v4 patch that saved /memreserve/ entries into the
> > >     reserved_mem array; /memreserve/ is now marked MEMBLOCK_NODUMP
> > >     directly.
> > > 
> > > v3 --> v4:
> > > 1. Rebase this series on v7.2-rc1.
> > > 2. Add two cleanup patches (patch 02/03).
> > > 3. Simplify patch 03 to avoid checking whether initial_boot_params is
> > >    NULL multiple times, suggested by Rob.
> > > 
> > > v2 --> v3:
> > > 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.
> > > 2. Fix UAF issue when alloc_reserved_mem_array() fails.
> > > 3. Add some prepare patches.
> > > 
> > > v1 --> v2:
> > > 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
> > >    feedback [3], v2 drop that property and exclude reserve memory
> > >    by default.
> > > 2. Split some prepared patches from the original patches.
> > > 3. Address coding-style comments on patch 5 from Rob.
> > > 
> > > [1] https://lore.kernel.org/lkml/20260723234126.GA3253409-robh@kernel.org/
> > > [2] https://lore.kernel.org/lkml/20260818092420.2859026-1-chenwandun1@gmail.com/
> > > [3] https://lore.kernel.org/lkml/20260506144542.GA2072596-robh@kernel.org/
> > > 
> > > Meijing Zhao (1):
> > >   mm: memblock: add missing HugeTLB flag name
> > > 
> > > Wandun Chen (9):
> > >   riscv: build crash_mem ranges from memblock instead of resource tree
> > >   crash_core: fold duplicated memblock arch hooks into the weak default
> > >   crash_core: serialize crash header preparation against hotplug
> > >   crash_core: replace for_each_mem_range() with for_each_mem_region()
> > >   memblock: introduce MEMBLOCK_NODUMP flag
> > >   of: reserved_mem: add dumpable flag to opt-in vmcore
> > >   of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
> > >   of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP
> > >   crash_core: skip MEMBLOCK_NODUMP regions when building vmcore ELF
> > >     header
> > > 
> > >  arch/arm64/kernel/machine_kexec_file.c     | 29 ------------
> > >  arch/loongarch/kernel/machine_kexec_file.c | 27 ------------
> > >  arch/riscv/Kconfig                         |  2 +-
> > >  arch/riscv/kernel/machine_kexec_file.c     | 33 --------------
> > >  arch/x86/kernel/crash.c                    |  2 +-
> > >  drivers/of/fdt.c                           |  2 +
> > >  drivers/of/of_private.h                    |  2 +
> > >  drivers/of/of_reserved_mem.c               | 48 ++++++++++++++++++++
> > >  include/linux/crash_core.h                 |  2 +
> > >  include/linux/memblock.h                   |  9 ++++
> > >  include/linux/of_reserved_mem.h            |  1 +
> > >  kernel/crash_core.c                        | 51 ++++++++++++++++++++--
> > >  kernel/dma/contiguous.c                    |  1 +
> > >  mm/memblock.c                              | 17 ++++++++
> > >  14 files changed, 131 insertions(+), 95 deletions(-)
> > > 
> > 
> > 
> 
> -- 
> Sincerely yours,
> Mike.


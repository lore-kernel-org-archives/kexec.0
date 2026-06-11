Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D65FCD98D7
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 12:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f/j69pXYfj34ZmqA6bJCKc0nePFg+h49mJ8/N7zh1iA=; b=qmOGaleROMENHP+85/TpLRrQqz
	zgJ7lxWlh7BpAdliCOUYV9i3mK49uSeIXdod3gnfWPaL2syVNtw4vfMZG+EmDidkgPY3cuULTrngS
	rkTkEenXaRxlJ4VbhtzNVnYvhfem/NiBvCOuzAr2ms0TuBbyGQbILiz5xzsECrNEggI+ZXnoXdTAR
	L0EUOmXGFDBGNU6xk8mglI7DNMhZlMPTXL0KC+CMM4lVQi9g/op0slKcMeX3eQlxJUBBtVgXjwm4z
	Eu6ORcH/foRwf77rnDN3ClU8lWtcAsH4Lj+iNQ6DW76HoOYOEQB6VJ3+8spiWIBwAp58Wv+TI4Qn+
	/vocB6gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXe97-00000009Md9-0gXy;
	Thu, 11 Jun 2026 12:04:29 +0000
Received: from out-173.mta0.migadu.com ([2001:41d0:1004:224b::ad])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXe93-00000009MbO-2rSI
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 12:04:27 +0000
Date: Thu, 11 Jun 2026 20:03:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781179452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/j69pXYfj34ZmqA6bJCKc0nePFg+h49mJ8/N7zh1iA=;
	b=C7VD/ntPHBl4YIG9Watr5T2GZLCvEmAzup5tfdjNbozip65PyigVCCrPseQbQKMgC2+M7G
	fYJkNSWFsX/dRktAsP7CNtY62sQ3fk1oEHQwJa+H4KpymFRmYbGmZ4jTCJo6jBN0nw2upe
	Z54mPkCYOx99N+izHFLdL+L2Fx6cijE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Wandun <chenwandun1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com,
	Rob Herring <robh@kernel.org>, saravanak@kernel.org, bhe@redhat.com,
	rppt@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, chenhuacai@kernel.org, kernel@xen0n.name,
	catalin.marinas@arm.com, will@kernel.org, alex@ghiti.fr,
	akpm@linux-foundation.org, pasha.tatashin@soleen.com,
	pratyush@kernel.org, ruirui.yang@linux.dev,
	m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: Re: [PATCH v3 00/11] kdump: reduce vmcore size and capture time
Message-ID: <aiqkKe1gXPZ5LZ7t@MiWiFi-R3L-srv>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <7ed207fa-4c86-426a-8570-495902ce04c3@gmail.com>
 <a3993db0-6975-455d-9674-4fd7cfcf80fc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3993db0-6975-455d-9674-4fd7cfcf80fc@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260611_050425_859574_A23B96A2 
X-CRM114-Status: GOOD (  31.93  )
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

On 06/11/26 at 11:09am, Wandun wrote:
> 
> 
> On 6/11/26 10:09, Wandun wrote:
> > 
> > 
> > On 5/27/26 11:29, Wandun Chen wrote:
> >> From: Wandun Chen <chenwandun@lixiang.com>
> >>
> >> On SoCs that carve out large firmware-owned reserved memory (GPU
> >> firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
> >> those carveouts as part of system RAM even though their contents are
> >> firmware state that is not useful for kernel crash analysis.
> >>
> >> This series introduces an opt-in 'dumpable' flag [1] on struct
> >> reserved_mem and uses it to filter the elfcorehdr PT_LOAD ranges on
> >> DT-based architectures (arm64, riscv, loongarch). By default reserved
> >> regions are treated as non-dumpable; CMA regions are explicitly opted
> >> in because their pages are returned to the buddy allocator and may
> >> carry key crash-analysis data.
> >>
> >> The series is organized as follows:
> >> Patches 1-3: Pre-existing fixes and a small prep change.
> >> Patches 4-5: Restructure to allow appending /memreserve/ entries.
> >> Patches 6-7: Add a dumpable flag and append /memreserve/ entries.
> >> Patch 8: Add generic kdump helpers.
> >> Patches 9-11: Wire the helpers into arm64, riscv and loongarch kdump
> >>                elfcorehdr preparation.
> > Hi,
> > 
> > Gentle ping on this series.
> > 
> > Status summary:
> > -patch 03: respun separately per Rob's suggestion, picked up for 7.2
> > -patch 06: Acked-by: Marek Szyprowski -patch 09: Acked-by: Will Deacon
> > The remaining patches (01, 02, 04, 05, 07, 08, 10, 11) are still
> > awaiting review. your feedback would be greately appreciated. I know we
> > are at the end of 7.1 -rc cycle, I don't want to rush this series, just
> > collecting more feedback, and will send next version based on 7.2-rc1.
> > If spliting the series into smaller logical group would make review
> > easier, please let me know. Best regards, Wandun
> 
> Apologies for the formatting issue in my previous email.
> Here is the properly formatted version.
> 
> Gentle ping on this series.

Thanks for the effort, the overral looks good to me at 1st glance. I will
check if there's concern on generic part. And meanwhile, I am wondering
if there's any chance x86 or other ARCH-es w/o OF/FDT can also choose to
not dump some areas, e.g GPU stolen memory. Surely, that's another story.

> 
> Status summary:
> - patch 03: respun separately per Rob's suggestion, picked up for 7.2
> - patch 06: Acked-by: Marek Szyprowski
> - patch 09: Acked-by: Will Deacon
> 
> The remaining patches (01, 02, 04, 05, 07, 08, 10, 11) are still
> awaiting review. Your feedback would be greatly appreciated.
> 
> I know we are at the end of 7.1-rc cycle, I don't want to rush this
> series, just collecting more feedback, and will send next version based
> on 7.2-rc1.
> 
> If splitting the series into smaller logical groups would make review
> easier, please let me know.
> 
> Best regards,
> Wandun
> 
> 
> >>
> >> v2 --> v3:
> >> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.[2]
> >> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
> >> 3. Add some prepare patches.
> >>
> >> v1 --> v2:
> >> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
> >>     feedback [1], v2 drop that property and exclude reserve memory
> >>     by default.
> >> 2. Split some prepared patches from the original patches.
> >> 3. Address coding-style comments on patch 5 from Rob.
> >>
> >> [1] https://lore.kernel.org/lkml/20260506144542.GA2072596-
> >> robh@kernel.org/
> >> [2] https://sashiko.dev/#/patchset/20260520091844.592753-1-
> >> chenwandun%40lixiang.com?part=4
> >>
> >> Wandun Chen (11):
> >>    of: reserved_mem: handle NULL name in of_reserved_mem_lookup()
> >>    kexec/crash: provide crash_exclude_mem_range() stub when
> >>      CONFIG_CRASH_DUMP=n
> >>    of: reserved_mem: avoid post-init UAF when alloc_reserved_mem_array()
> >>      fails
> >>    of: reserved_mem: zero total_reserved_mem_cnt if no valid
> >>      /reserved-memory entry
> >>    of: reserved_mem: split alloc_reserved_mem_array() from
> >>      fdt_scan_reserved_mem_late()
> >>    of: reserved_mem: add dumpable flag to opt-in vmcore
> >>    of: reserved_mem: save /memreserve/ entries into the reserved_mem
> >>      array
> >>    of: reserved_mem: add kdump helpers to exclude non-dumpable regions
> >>    arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
> >>    riscv: kdump: exclude non-dumpable reserved memory regions from vmcore
> >>    loongarch: kdump: exclude non-dumpable reserved memory regions from
> >>      vmcore
> >>
> >>   arch/arm64/kernel/machine_kexec_file.c     |   6 ++
> >>   arch/loongarch/kernel/machine_kexec_file.c |   6 ++
> >>   arch/riscv/kernel/machine_kexec_file.c     |   4 +
> >>   drivers/of/fdt.c                           |  11 +-
> >>   drivers/of/of_private.h                    |   3 +
> >>   drivers/of/of_reserved_mem.c               | 117 +++++++++++++++++++--
> >>   include/linux/crash_core.h                 |   6 ++
> >>   include/linux/of_reserved_mem.h            |  15 +++
> >>   kernel/dma/contiguous.c                    |   1 +
> >>   9 files changed, 157 insertions(+), 12 deletions(-)
> >>
> > 
> 


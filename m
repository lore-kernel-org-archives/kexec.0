Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E42C0502A
	for <kexec@archiver.kernel.org>; Sun, 28 Aug 2022 01:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A3W3rdTAwWPNyUkxzNKXixqeZ4FkdiK7/ga7q0PiRd8=; b=IOsXnor91tVoRi
	Y2fuxbgE5uh4E3aGHk4Q7J3prilSWQ/RUkOXVK15hWjqh0AKZ+kFU1xnnPO+jApgAAfBWVD2SCno2
	zxLJVqTA4RL0qzg2ovc1m+OgNB/WzCDlxqsvQA3ThzRZVbqZJFg2wdupecAIIAueyL+L1maWvBulp
	nrRaxvxoqoQHmDHdebDE/fkM0us+O8yu26Ong6pOVkijwYve3IYDzJ8h3+UEcULNGCllPNFhCSzDY
	QgNwX57pmRvhfZ/Euy+v6eoB650QJ0EuE0wpXt2pXBB1ISYoLpp8TJ1G9x2GsukmKkHFqZWjaVrX+
	YDkaTj44cb0UuADdCOow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oS7Yk-008YxM-68; Sun, 28 Aug 2022 01:57:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oS7YR-008YMa-CQ
	for kexec@lists.infradead.org; Sun, 28 Aug 2022 01:57:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661651858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3fZFEPgbjjmu6J/LmASfOOq+L6kipv2vP4maHTFsNbM=;
	b=C8+LlEUUoIxvtDDdJHH4WhQb1U+nQYDMU6uM0wsMDahMKYY2NORSuUd8jVBcqR8ptdWE1p
	+9RdBxlsTUcTbF69Feha6Q41+y3fT53rgNdaRqBg5jpKGLptXj8CLDxxkgI3vZmifeVU6N
	71NaFV6TaRHXfJtU3wp677jzpYEaOpw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-z8xHsvapMrav6hnIavubbQ-1; Sat, 27 Aug 2022 21:57:33 -0400
X-MC-Unique: z8xHsvapMrav6hnIavubbQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C727811E76;
	Sun, 28 Aug 2022 01:57:32 +0000 (UTC)
Received: from localhost (ovpn-12-25.pek2.redhat.com [10.72.12.25])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 71506492C3B;
	Sun, 28 Aug 2022 01:57:31 +0000 (UTC)
Date: Sun, 28 Aug 2022 09:57:28 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	ardb@kernel.org, rppt@kernel.org, guanghuifeng@linux.alibaba.com,
	mark.rutland@arm.com, will@kernel.org, linux-mm@kvack.org,
	thunder.leizhen@huawei.com, wangkefeng.wang@huawei.com,
	kexec@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
Message-ID: <YwrLiNXtNq/JFsYG@MiWiFi-R3L-srv>
References: <20220828005545.94389-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220828005545.94389-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220827_185739_607031_DB03F65F 
X-CRM114-Status: GOOD (  33.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Forgot adding Nicolas when sending patch, add now.

On 08/28/22 at 08:55am, Baoquan He wrote:
> Problem:
> =======
> On arm64, block and section mapping is supported to build page tables.
> However, currently it enforces to take base page mapping for the whole
> linear mapping if CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled and
> crashkernel kernel parameter is set. This will cause longer time of the
> linear mapping process during bootup and severe performance degradation
> during running time.
> 
> Root cause:
> ==========
> On arm64, crashkernel reservation relies on knowing the upper limit of
> low memory zone because it needs to reserve memory in the zone so that
> devices' DMA addressing in kdump kernel can be satisfied. However, the
> limit on arm64 is variant. And the upper limit can only be decided late
> till bootmem_init() is called.
> 
> And we need to map the crashkernel region with base page granularity when
> doing linear mapping, because kdump needs to protect the crashkernel region
> via set_memory_valid(,0) after kdump kernel loading. However, arm64 doesn't
> support well on splitting the built block or section mapping due to some
> cpu reststriction [1]. And unfortunately, the linear mapping is done before
> bootmem_init().
> 
> To resolve the above conflict on arm64, the compromise is enforcing to
> take base page mapping for the entire linear mapping if crashkernel is
> set, and CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabed. Hence
> performance is sacrificed.
> 
> Solution:
> =========
> To fix the problem, we should always take 4G as the crashkernel low
> memory end in case CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled.
> With this, we don't need to defer the crashkernel reservation till
> bootmem_init() is called to set the arm64_dma_phys_limit. As long as
> memblock init is done, we can conclude what is the upper limit of low
> memory zone.
> 
> 1) both CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are disabled or memblock_start_of_DRAM() > 4G
>   limit = PHYS_ADDR_MAX+1  (Corner cases)
> 2) CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are enabled:
>    limit = 4G  (generic case)
> 
> Justification:
> ==============
> In fact, kdump kernel doesn't need to cover all peripherals'
> addressing bits. Only device taken as dump target need be taken care of
> and its addressing bits need be satified. Currently, there are two kinds
> of dumping, dumped to local storage disk or dumped through network card to
> remove storage server. It means only storage disk or netowrk card taken
> as dump target need be consider if their addressing bits are satisfied.
> For saving memory, we usually generate kdump specific initramfs including
> necessary kernel modules for dump target devices. All other unnecessary
> kernel modules are excluded and their correspondent devices won't be
> initialized during kdump kernel bootup.
> 
> So far, only Raspberry Pi 4 has some peripherals whcih can only address
> 30 bits memory range as reported in [2]. Devices on all other arm64 systems
> can address 32bits memory range.
> 
> So by enforcing to take 4G as the crashkernel low memory end, the only
> risk is if RPi4 owns storage disk or network card which can't address
> 32bits memory range because they could be set as dump target. Even if
> RPi4 truly has storage devices or network card which can only address 30
> bits memory range, it should be a corner case. We can document it since
> crashkernel is more taken as a feature on server. Besides, RPi4 still can
> use crashkernel=xM@yM to sepcify a location for 32bits addressing if it
> really has that kind of storage device or network card and kdump is expected.
> 
> [1]
> https://lore.kernel.org/all/YrIIJkhKWSuAqkCx@arm.com/T/#u
> 
> [2]
> [PATCH v6 0/4] Raspberry Pi 4 DMA addressing support
> https://lore.kernel.org/linux-arm-kernel/20190911182546.17094-1-nsaenzjulienne@suse.de/T/
> 
> 
> ======
> Question to Nicolas:
> 
> Hi Nicolas,
> 
> In cover letter of [2] patchset, you told RPi4 has peripherals which
> can only address 30bits range. In below sentence, do you mean "the PCIe,
> V3D, GENET" can't address 32bit range, or they have wider view of
> address space the same as 40-bit DMA channels? I am confused about that.
> 
> And the storage device or network card on RPi4 can address 32bit range
> or 32bit range, do we have document or do you happen to know that?
> 
> """
> The new Raspberry Pi 4 has up to 4GB of memory but most peripherals can
> only address the first GB: their DMA address range is
> 0xc0000000-0xfc000000 which is aliased to the first GB of physical
> memory 0x00000000-0x3c000000. Note that only some peripherals have these
> limitations: the PCIe, V3D, GENET, and 40-bit DMA channels have a wider
> view of the address space by virtue of being hooked up trough a second
> interconnect.
> """
> 
> 
> Baoquan He (2):
>   arm64, kdump: enforce to take 4G as the crashkernel low memory end
>   arm64: remove unneed defer_reserve_crashkernel() and crash_mem_map
> 
>  arch/arm64/include/asm/memory.h |  5 ----
>  arch/arm64/mm/init.c            | 24 ++++++++-------
>  arch/arm64/mm/mmu.c             | 53 ++++++++++++++-------------------
>  3 files changed, 36 insertions(+), 46 deletions(-)
> 
> 
> base-commit: 10d4879f9ef01cc6190fafe4257d06f375bab92c
> -- 
> 2.34.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

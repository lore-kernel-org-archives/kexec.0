Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A59EC6FD1C
	for <kexec@archiver.kernel.org>; Sat, 25 Mar 2023 06:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=USVEYV2B9VMUHxJeUBnEfMmXx6bC4EIa2a8ERMGsCCQ=; b=xmdJEA+cbcHY0F
	3oQpOLGz+j43cThrxAFV2s9TJ8IGt+Z87KWsJyv2Exi1Ion6Wb86qsRz3Cs+Cc4vpI1+yqgBgu72b
	m2Zznz0y5GbT+PhY1r1rHt+bJV/oKjrR3V+uKWXZLltV2zTZtMWSZa+QWu0nd4GhsdYIXuKv9VOmx
	gna7o6NJV2EwX2FQXX/thp2tjDw8moGmkOiNFBY0SqACat5iPKqFjXCBcltGhTEUxv5fAldTZnDNY
	OT17uzqMusvQKntCNNmJzFR43i4fUjt/wDgDPjtVZCiRKL5jqgC7bLKqs8ZLgxGAULicrEiuFUYN+
	7Li0c+uc+1wkH+oZuoeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfwz3-006Aw6-31;
	Sat, 25 Mar 2023 06:02:33 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfwz0-006AvA-0y;
	Sat, 25 Mar 2023 06:02:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 74598B826D7;
	Sat, 25 Mar 2023 06:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC746C433D2;
	Sat, 25 Mar 2023 06:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679724145;
	bh=Rm5cs/yD0VtyU6KhTA35Om5SsVQpAHv9hH3/NHRCp/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4GsbOChMjBs+cc6q/siXf+TIpqHSXAP4PhF5b3RctdQLqfhSBXZIjGjaYbR1gqIO
	 Fvoyeu28I30ITId8AlXRmsDo+Yad3QrVVGWACLTYYL7Q3Sy5U8IjAhh4vwxhmx3RFz
	 DwBqZF/R62NeydzttDCSvUAzM6VZV+gjEKljw5jcBCZR8mhj2ydWSCeiEGCC3AhpOi
	 Y9YlMuH528884ZqUlXHk5f9ovfP95Xue443SNJ3dyjubxNOleI/X3tjTjOI3Ef2Gh3
	 couRbkuD5vnFweX+PBAl3tLptvNVJDrih9blzTaTOSyKJ9RUDrZgkb9kGKxniAwvsa
	 Fvxq+xyPz5mXQ==
Date: Sat, 25 Mar 2023 09:02:10 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	will@kernel.org, kexec@lists.infradead.org, ardb@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64: kdump : take off the protection on
 crashkernel memory region
Message-ID: <ZB6OYjP5ODkSwaUx@kernel.org>
References: <20230324131838.409996-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230324131838.409996-1-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_230230_668887_BC85581D 
X-CRM114-Status: GOOD (  25.65  )
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

On Fri, Mar 24, 2023 at 09:18:35PM +0800, Baoquan He wrote:
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
> upper limit of low memory on arm64 is variant. And the upper limit can
> only be decided late till bootmem_init() is called [1].
> 
> And we need to map the crashkernel region with base page granularity when
> doing linear mapping, because kdump needs to protect the crashkernel region
> via set_memory_valid(,0) after kdump kernel loading. However, arm64 doesn't
> support well on splitting the built block or section mapping due to some
> cpu reststriction [2]. And unfortunately, the linear mapping is done before
> bootmem_init().
> 
> To resolve the above conflict on arm64, the compromise is enforcing to
> take base page mapping for the entire linear mapping if crashkernel is
> set, and CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabed. Hence
> performance is sacrificed.
> 
> Solution:
> =========
> Comparing with the always encountered base page mapping for the whole
> linear region, it's better to take off the protection on crashkernel memory
> region for now because the protection can only happen in a chance in one
> million, while the base page mapping for the whole linear mapping is
> always mitigating arm64 systems with crashkernel set.
> 
> This can let distros have chance to back port this patchset to fix the
> performance issue caused by the base page mapping in the whole linear
> region.
> 
> Extra words
> ===========
> I personally expect that  we can add these back in the near future
> when arm64_dma_phys_limit is fixed, e.g Raspberry Pi enlarges the device
> addressing limit to 32bit; or Arm64 can support splitting built block or
> section mapping. Like this, the code is the simplest and clearest.
> 
> Or as Catalin suggested, for below 4 cases we currently defer to handle
> in bootme_init(), we can try to handle case 3) in advance so that memory
> above 4G can avoid base page mapping wholly. This will complicate the
> already complex code, let's see how it looks if people interested post patch.
> 
> crashkernel=size
> 1)first attempt:  low memory under arm64_dma_phys_limit
> 2)fallback:       finding memory above 4G
> 
> crashkernel=size,high
> 3)first attempt:  finding memory above 4G
> 4)fallback:       low memory under arm64_dma_phys_limit
> 
> 
> [1]
> https://lore.kernel.org/all/YrIIJkhKWSuAqkCx@arm.com/T/#u
> 
> [2]
> https://lore.kernel.org/linux-arm-kernel/20190911182546.17094-1-nsaenzjulienne@suse.de/T/
> 
> Baoquan He (3):
>   arm64: kdump : take off the protection on crashkernel memory region
>   arm64: kdump: do not map crashkernel region specifically
>   arm64: kdump: defer the crashkernel reservation for platforms with no
>     DMA memory zones
> 
>  arch/arm64/include/asm/kexec.h    |  6 -----
>  arch/arm64/include/asm/memory.h   |  5 ----
>  arch/arm64/kernel/machine_kexec.c | 20 --------------
>  arch/arm64/mm/init.c              |  6 +----
>  arch/arm64/mm/mmu.c               | 43 -------------------------------
>  5 files changed, 1 insertion(+), 79 deletions(-)

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

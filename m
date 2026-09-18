Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE706C982D2
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 08:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cm05iWolKHjPlNQoY8Tj98EKh/QANqizkq4K8fj4bGw=; b=thLeyLSVNNhjWuRyMFDtiq7sPx
	Vg/xuKX9YrALca1KDpUsH3yR0GNlkvKnUuat/AD/4wGpw52NEZ1as0BW8rEU7J+/FPSMFWvGsCFrU
	AsgtZhj/ARkMZUf1hhzvDho826uGBRZ0g3syg/j32KOpko4ZEgRVJiEGo+xsxYnaGkgbVA3D0B4o/
	UYfz4OMVEEdZ57vGiL5zJo0KJj0qo0txv+g4PU1jedTd9XuOsiw/Ny/h9bSbOQRwyvdlc2MqNo97B
	xLFyN/nwpUJxG5kEnHvTDSabVl0UDRfWNwTDC1ypThg3r4RnmjIQ3iZd7bperqNJuqVIb2IU9S4Om
	GFCeIukg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Tds-0000000DlLk-1SPl;
	Fri, 18 Sep 2026 08:08:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Tdr-0000000DlL8-0RTt
	for kexec@bombadil.infradead.org;
	Fri, 18 Sep 2026 08:08:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Cm05iWolKHjPlNQoY8Tj98EKh/QANqizkq4K8fj4bGw=; b=DmMHdyKSzJYs64+8LEB4bo62ae
	vuUtbLzAWQpuCZO2GLCveE6fepRLBZMYLtAOvH4pwZHoKZakfZJxwhrc2XFjY7f8ia3RSqotKjIf2
	3XbToTkesL2U84J2pljk3iJsFepj7FbMDIbduu+QvWKAAyMCjtPah3ElrSlPH40Ij/yezMsJtncqK
	Xa1nBxKmMtBAiB0ART2/uvUTwFkcHB1jB1V0yc3yW9iLQ+1fJlZ6qOS0WJ6KDH0t3ufY0e1e1LO0h
	uEIkC3JU2+RetpQ3bT7QTHN6GQzpINeHkSlq3RTvNDxt0pXZpQyTq4vFj0Soym3H8+Kdgtqo6wrRm
	pEIOUGvw==;
Received: from out-253.mta0.migadu.com ([2001:41d0:1004:224b::fd] helo=mta0.migadu.com)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7Tdo-00000009lQa-1OP3
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 08:08:18 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=xyISkBw574ZsXxKvu3xwdAxcFPyzjbZIs1ckRKr/QYs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789718893; v=1; x=1790323693;
 b=GYOIjE9TCS52kB3fasEHvocV/8o9kyickSQMkR89NrjEqDrcRo7nQvB/cqQnO+0Tj5dPpoTG
 nBygKi9DiR9Q8JDpWZYaeMzZhRwyJr700RwTNBDgmq+K6LMw5VsDWStD4oF15tqYBf9N6CpOzZE
 iQwloIBn/uTyOTtX1ltiWxJE=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id e05f79cdbbeb581e;
	Fri, 18 Sep 2026 08:08:13 +0000
X-Mizu-Trace-ID: e05f79cdbbeb581e
X-Migadu-Flow: FLOW_OUT
Date: Fri, 18 Sep 2026 16:08:10 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Wandun Chen <chenwandun1@gmail.com>
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
Subject: Re: [PATCH v6 06/10] memblock: introduce MEMBLOCK_NODUMP flag
Message-ID: <aqzxavL91icLw-Xv@fedora>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-7-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902073116.802752-7-chenwandun1@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_090816_512455_42F74B33 
X-CRM114-Status: GOOD (  22.45  )
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

On 09/02/26 at 03:31pm, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> Add MEMBLOCK_NODUMP to mark regions that should be excluded from
> kdump vmcores.
> 
> The flag is meant for reserved memory that carries no data useful for
> crash analysis. Reusable reserved regions such as CMA may hold useful
> data, so these regions must not be marked MEMBLOCK_NODUMP. Subsequent
> patches wire this up for /reserved-memory and /memreserve/ entries.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> ---
>  include/linux/memblock.h |  9 +++++++++
>  mm/memblock.c            | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index d62db9e776cf..b2fcf11fba2b 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -52,6 +52,8 @@ extern unsigned long long max_possible_pfn;
>   * kernel that we know is good to use. It is the only memory that
>   * allocations may happen from in this phase.
>   * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
> + * @MEMBLOCK_NODUMP: exclude from kdump vmcore. It carries no data useful
> + * for crash analysis (e.g. firmware carveouts).
>   */
>  enum memblock_flags {
>  	MEMBLOCK_NONE		= 0x0,	/* No special request */
> @@ -63,6 +65,7 @@ enum memblock_flags {
>  	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>  	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
>  	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
> +	MEMBLOCK_NODUMP		= 0x100,/* exclude from kdump vmcore */
>  };
>  
>  /**
> @@ -160,6 +163,7 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
>  int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
>  int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
> +int memblock_mark_nodump(phys_addr_t base, phys_addr_t size);
>  
>  void memblock_free(void *ptr, size_t size);
>  void reset_all_zones_managed_pages(void);
> @@ -306,6 +310,11 @@ static inline bool memblock_is_kho_scratch(struct memblock_region *m)
>  	return m->flags & MEMBLOCK_KHO_SCRATCH;
>  }
>  
> +static inline bool memblock_is_nodump(struct memblock_region *m)
> +{
> +	return m->flags & MEMBLOCK_NODUMP;
> +}
> +
>  int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
>  			    unsigned long  *end_pfn);
>  void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
> diff --git a/mm/memblock.c b/mm/memblock.c
> index f2952d725c10..2e87f39826dd 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1204,6 +1204,21 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
>  				    MEMBLOCK_KHO_SCRATCH);
>  }
>  
> +/**
> + * memblock_mark_nodump - Mark a memory region with flag MEMBLOCK_NODUMP.
> + * @base: the base phys addr of the region
> + * @size: the size of the region
> + *
> + * Mark the region as not to be included in crash dumps.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int __init_memblock memblock_mark_nodump(phys_addr_t base, phys_addr_t size)
      ~~~~~~~~~~~~~~^
Is it impossible to use at runtime even thought it claims to be generic?


> +{
> +	return memblock_setclr_flag(&memblock.memory, base, size, 1,
> +				    MEMBLOCK_NODUMP);
> +}
> +
>  static bool should_skip_region(struct memblock_type *type,
>  			       struct memblock_region *m,
>  			       int nid, int flags)
> @@ -2887,6 +2902,7 @@ static const char * const flagname[] = {
>  	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
>  	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
>  	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
> +	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
>  };
>  
>  static int memblock_debug_show(struct seq_file *m, void *private)
> -- 
> 2.43.0
> 


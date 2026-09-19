Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6050C982CC
	for <kexec@archiver.kernel.org>; Sat, 19 Sep 2026 07:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bEP94n9v3wLAo85N51UgdrheAoXFz2CprleV4BZJMM8=; b=I7oDS/+O27M18xtBBLXFGCLWi3
	IL1AyBG0pEhLHME0Tyh+eXSJEC8YXXl4zK87tgeROpZ++Tecd1SviHhVjcCFWeKd0LumwGPlYYTBw
	qOQDpLt+U7QTyUL0vKNTLco5btmtyRTBpVza9FuNnNAL8nTKqONzqAt5TzTV9KYfL9boAIb5mDlOo
	tVdQct7L+1xOH/QWvKOhRCoZ8KRrNxv4gAYWKsw/GcyyyXwAoiOOMiQs+5oAFlxSHW+DoJ6QukCot
	hVEjQpbUVfxceaX9nFaekAYe0HtHQjDr9MgaLQxgx3wOh138t1VNWeUbny8wuNVn5CX54YKuEqj8M
	hwwqE/1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7pEX-0000000G2W7-1MBO;
	Sat, 19 Sep 2026 07:11:37 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7pEW-0000000G2VA-03jm;
	Sat, 19 Sep 2026 07:11:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BD9CD402DD;
	Sat, 19 Sep 2026 07:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3261F000FF;
	Sat, 19 Sep 2026 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789801895;
	bh=bEP94n9v3wLAo85N51UgdrheAoXFz2CprleV4BZJMM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F4W1bQei0WbJqW4r8EVplbGGhiwx7NXzD9fjTAJz1nnroqL5YVOgqQUiArkdtmHyr
	 W9CUxLppulp2QWgWTUWbd/dAehRrSW/lkzZ8oqUe3f2GoaBZ9mxErL6fLMqXM7hUoW
	 pflbnHmqkcZuRmlsQGGEHcLyopvAXc13ZfvUKI6JKD4iUk+a26j861qNbyRs7NwWAe
	 5rxSiPFeIPanXD5TpncL4/J1QB4XlrZSZXGeFurkupyx3dvKksXmU0uWgTWfiWByEt
	 kIY5KOkGCC+OaHU6gMgpAmJdMdOpQb8sI62v9yK0E5VZLKYJBnSZK7nFcRXx41rwCe
	 CYxurd2l460hw==
Date: Sat, 19 Sep 2026 10:11:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <baoquan.he@linux.dev>
Cc: Wandun Chen <chenwandun1@gmail.com>, catalin.marinas@arm.com,
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
Subject: Re: [PATCH v6 06/10] memblock: introduce MEMBLOCK_NODUMP flag
Message-ID: <aq41nFRPtRWTQ7cK@kernel.org>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-7-chenwandun1@gmail.com>
 <aqzxavL91icLw-Xv@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqzxavL91icLw-Xv@fedora>
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

On Fri, Sep 18, 2026 at 04:08:10PM +0800, Baoquan He wrote:
> On 09/02/26 at 03:31pm, Wandun Chen wrote:
> > From: Wandun Chen <chenwandun@lixiang.com>
> > 
> > Add MEMBLOCK_NODUMP to mark regions that should be excluded from
> > kdump vmcores.
> > 
> > The flag is meant for reserved memory that carries no data useful for
> > crash analysis. Reusable reserved regions such as CMA may hold useful
> > data, so these regions must not be marked MEMBLOCK_NODUMP. Subsequent
> > patches wire this up for /reserved-memory and /memreserve/ entries.
> > 
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> > Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> > ---
> >  include/linux/memblock.h |  9 +++++++++
> >  mm/memblock.c            | 16 ++++++++++++++++
> >  2 files changed, 25 insertions(+)
> > 
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index d62db9e776cf..b2fcf11fba2b 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -52,6 +52,8 @@ extern unsigned long long max_possible_pfn;
> >   * kernel that we know is good to use. It is the only memory that
> >   * allocations may happen from in this phase.
> >   * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
> > + * @MEMBLOCK_NODUMP: exclude from kdump vmcore. It carries no data useful
> > + * for crash analysis (e.g. firmware carveouts).
> >   */
> >  enum memblock_flags {
> >  	MEMBLOCK_NONE		= 0x0,	/* No special request */
> > @@ -63,6 +65,7 @@ enum memblock_flags {
> >  	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
> >  	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
> >  	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
> > +	MEMBLOCK_NODUMP		= 0x100,/* exclude from kdump vmcore */
> >  };
> >  
> >  /**
> > @@ -160,6 +163,7 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
> >  int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
> >  int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
> >  int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
> > +int memblock_mark_nodump(phys_addr_t base, phys_addr_t size);
> >  
> >  void memblock_free(void *ptr, size_t size);
> >  void reset_all_zones_managed_pages(void);
> > @@ -306,6 +310,11 @@ static inline bool memblock_is_kho_scratch(struct memblock_region *m)
> >  	return m->flags & MEMBLOCK_KHO_SCRATCH;
> >  }
> >  
> > +static inline bool memblock_is_nodump(struct memblock_region *m)
> > +{
> > +	return m->flags & MEMBLOCK_NODUMP;
> > +}
> > +
> >  int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
> >  			    unsigned long  *end_pfn);
> >  void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index f2952d725c10..2e87f39826dd 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1204,6 +1204,21 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
> >  				    MEMBLOCK_KHO_SCRATCH);
> >  }
> >  
> > +/**
> > + * memblock_mark_nodump - Mark a memory region with flag MEMBLOCK_NODUMP.
> > + * @base: the base phys addr of the region
> > + * @size: the size of the region
> > + *
> > + * Mark the region as not to be included in crash dumps.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +int __init_memblock memblock_mark_nodump(phys_addr_t base, phys_addr_t size)
>       ~~~~~~~~~~~~~~^
> Is it impossible to use at runtime even thought it claims to be generic?

This should only happen at boot.

Allowing modifications of memblock properties in runtime is a can of worms
I don't want to open.
 
> > +{
> > +	return memblock_setclr_flag(&memblock.memory, base, size, 1,
> > +				    MEMBLOCK_NODUMP);
> > +}
> > +
> >  static bool should_skip_region(struct memblock_type *type,
> >  			       struct memblock_region *m,
> >  			       int nid, int flags)
> > @@ -2887,6 +2902,7 @@ static const char * const flagname[] = {
> >  	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
> >  	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
> >  	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
> > +	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
> >  };
> >  
> >  static int memblock_debug_show(struct seq_file *m, void *private)
> > -- 
> > 2.43.0
> > 

-- 
Sincerely yours,
Mike.


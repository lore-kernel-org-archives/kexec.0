Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886E3C982D0
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 03:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A7ZVtpRa4xG9tmEOcZ/WJOmfdObDCumvMarROr2J/Xo=; b=fcajvXKRsh0Dorubza0kGOso52
	ow9fD3qE1MlOCR/KUiq44ew0H8UPfbw5vgKK2bVmsHzeBsKo+NpSYzz3LWfq5xD5EwTbIE3ktL0yv
	1hJd142dzMEzWnYwP2qjcF17fQW8zr/9jxPNmgHqpfZgAu/V62B5oqJYi8mHavZ9hUTkqlP0IqMM0
	aRlrrku/PvLtIf+vVvUrzNdY+UdmlPmdAhEo1HTw7/He59TvIlRNGEAZgkG9nyPERjDgephgWBUMY
	wVZAsP12cGe4jj8skST2B/AdScj3SkVNbxAVBRwY9bQ5CmSky4Ql5UvVinLwRAdoxz2k7wVjM4O9+
	RII7QmIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x88JT-0000000GoCt-13no;
	Sun, 20 Sep 2026 03:33:59 +0000
Received: from out-192.mta0.migadu.com ([2001:41d0:1004:224b::c0] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x88JQ-0000000GoBE-1Bqx
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 03:33:58 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=hXLqE47HqcLGyqOng+gJY4MA1aiOWDH2fotgfictL0g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789875232; v=1; x=1790480032;
 b=MjFuIBdxri6mnPIUOZ/bHRkOn9QfFFAQ/Q0tabD86fdfsLaHgHc5pFS1MJG6bPQIFl3Gca6t
 kDUwPfcgXw4TbXfFtT1ksq+r5VLNgYmTTo+y/m6Qe1Fm5WLBb1VtWBJjhIKxd4GXgMgK888pnSb
 W4ddmcOquFJ+NHn4dj3C3t4o=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 15499ad898b25d57;
	Sun, 20 Sep 2026 03:33:52 +0000
X-Mizu-Trace-ID: 15499ad898b25d57
X-Migadu-Flow: FLOW_OUT
Date: Sun, 20 Sep 2026 11:33:45 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
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
Message-ID: <aq9UGXeqmCfuPHdD@fedora>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-7-chenwandun1@gmail.com>
 <aqzxavL91icLw-Xv@fedora>
 <aq41nFRPtRWTQ7cK@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq41nFRPtRWTQ7cK@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260919_203356_461186_F4EA297C 
X-CRM114-Status: GOOD (  17.58  )
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

On 09/19/26 at 10:11am, Mike Rapoport wrote:
> On Fri, Sep 18, 2026 at 04:08:10PM +0800, Baoquan He wrote:
> > On 09/02/26 at 03:31pm, Wandun Chen wrote:
...snip... 
> > > +/**
> > > + * memblock_mark_nodump - Mark a memory region with flag MEMBLOCK_NODUMP.
> > > + * @base: the base phys addr of the region
> > > + * @size: the size of the region
> > > + *
> > > + * Mark the region as not to be included in crash dumps.
> > > + *
> > > + * Return: 0 on success, -errno on failure.
> > > + */
> > > +int __init_memblock memblock_mark_nodump(phys_addr_t base, phys_addr_t size)
> >       ~~~~~~~~~~~~~~^
> > Is it impossible to use at runtime even thought it claims to be generic?
> 
> This should only happen at boot.
> 
> Allowing modifications of memblock properties in runtime is a can of worms
> I don't want to open.

Thank you. This is why I said this can't be claimed as a generic way to
mark memory region as no dump. The generic way I'd like to see is
at any time of system we can mark any unwanted memory region as no dump.
And it won't impact the behaviour of the current system.

>  
> > > +{
> > > +	return memblock_setclr_flag(&memblock.memory, base, size, 1,
> > > +				    MEMBLOCK_NODUMP);
> > > +}
> > > +
> > >  static bool should_skip_region(struct memblock_type *type,
> > >  			       struct memblock_region *m,
> > >  			       int nid, int flags)
> > > @@ -2887,6 +2902,7 @@ static const char * const flagname[] = {
> > >  	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
> > >  	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
> > >  	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
> > > +	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
> > >  };
> > >  
> > >  static int memblock_debug_show(struct seq_file *m, void *private)
> > > -- 
> > > 2.43.0
> > > 
> 
> -- 
> Sincerely yours,
> Mike.


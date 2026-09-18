Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04F8C982D8
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 16:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RUrki9PiihwqQhD1He2HPnPY/iXNXQ626jiFsHj9jNE=; b=pS0ta3XbBfqw3tK3MgpEZbJqJQ
	ZXVcmjI/V36WJqQUaVXQeFaXB+UIw8DdU2gG+MEwW/X/I5tiwM0HA+fCTlNhn8iPjTT2Ab3rJgq05
	hmhy8aoYMbjpMn94zZoUI4GH3IBgxAD8ElZMgjoF469UoOC0U04Vwm25pnsN1qEABB1qND8evdl/B
	RL2O6vYHngb+5MvGf1YCaHmCC2yhpQ+MtkG45jpAVOSECi0ThjtZXplweDQdKCNJl2zmWRKSgX6xQ
	8ct4a8pHmuITy47cuPuLedHlxS63eFVoK5YAtAl1SCEfE8n+kuon26e09fEP1YfOYow1RZ67UOu9/
	JdwOo2RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7bRH-0000000F1RO-3nej;
	Fri, 18 Sep 2026 16:27:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7bRG-0000000F1R7-41v9
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 16:27:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3DF0E41A79;
	Fri, 18 Sep 2026 16:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067F71F000FF;
	Fri, 18 Sep 2026 16:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789748870;
	bh=RUrki9PiihwqQhD1He2HPnPY/iXNXQ626jiFsHj9jNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oz5E76IC1AW958/OUCiLVFPK5O7IA+IxOlkLIFaPL/lstGjxdAu9qkLwneHvOXAm8
	 /xsMM1GKPycYfyUcVsfLeJ+zz/LmAi+r4ijC6UisTu8rfZKebDQTq3ndKWvKZRW6/L
	 tvVmTbPn/42oV4pvF3FAVzMs1Fl2HNBs91bqs2Pi5Ni7+OPTKLwyaUz4vgyRcODGLM
	 aa0zQzqttJ9ShuLZM7S32GyDsYhEUnp8A2mfzjxWzWxZ/QPHswu8KO9/EvikoSGcRI
	 rMVHRJFoIEsgkxWwKuM3ET9catgXFbWZ2t17QkcjeUfJHfJkB3pmrB7GA56iZdyad7
	 rSr3njC0LIivw==
Date: Fri, 18 Sep 2026 17:27:43 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH v2 00/10] dma-mapping: Add preservation of direct
 allocations
Message-ID: <aq1mf_EXzn2hUwy4@willie-the-truck>
References: <20260708234854.4044652-1-skhawaja@google.com>
 <20260826183112.GA3703145@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826183112.GA3703145@nvidia.com>
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

On Wed, Aug 26, 2026 at 03:31:12PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 08, 2026 at 11:48:44PM +0000, Samiullah Khawaja wrote:
> > This is an RFC v2 to discuss the preservation of DMA allocations for
> > devices that are using direct allocation mode. Note preservation here
> > means preservation of physical memory using KHO only. IOVAs and IOMMU
> > mappings are out of scope.
> > 
> > The complexity and need of this was discussed in the thread mentioned
> > below. It was proposed to allow preservation of only a subset of
> > allocations with minimum support. Offline discussion with Will Deacon
> > concluded that this series is still needed, because we still want to use
> > coherent allocations for Arm sMMUv3 ste/cds, so sending this v2.
> 
> Was this before or after concluding that ARM was OK with using
> cachable memory?

That discussion was primarily about the page-tables iirc.

I still think drivers should be able to use the coherent DMA API and not
have to use an entirely different interface depending on whether or not
they need to support KHO.

> >  include/linux/dma-direct.h        |  29 +++++
> >  include/linux/dma-map-ops.h       |  10 ++
> >  include/linux/dma-mapping.h       | 100 ++++++++++++++
> >  include/linux/kho/abi/dma_alloc.h |  32 +++++
> >  kernel/dma/Kconfig                |  12 ++
> >  kernel/dma/Makefile               |   1 +
> >  kernel/dma/coherent.c             |  11 ++
> >  kernel/dma/contiguous.c           |  27 ++++
> >  kernel/dma/direct.c               | 189 +++++++++++++++++++++++++++
> >  kernel/dma/direct_test.c          | 208 ++++++++++++++++++++++++++++++
> >  kernel/dma/mapping.c              | 132 +++++++++++++++++++
> >  kernel/dma/pool.c                 |  17 +++
> >  12 files changed, 768 insertions(+)
> 
> Because this seems like quite a big change to swallow compared to just
> using iommu pages.h

Maybe, but I think it's in the right place rather than scattered across
a bunch of drivers. A good chunk of it is also test code and empty
static inline functions.

Will


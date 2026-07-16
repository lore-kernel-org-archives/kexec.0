Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98E9C44514
	for <kexec@archiver.kernel.org>; Thu, 16 Jul 2026 21:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oucStQnRyawORtPI7Wj+qEZX9FA99Twpl/PrB1SpiMs=; b=3LG2wQ7LsQtbgf64RlnXFbTKCr
	2IFgsr6S48n0OQbdJyqwb0+DS5fzF52OdvveIXatZmW+UnmX/GslXb87krue8efDe2IAB6MbmDE01
	Ti/YbkLuHJvXpr2wUs0kKTNJXGvIGMikkG4qMAPxWbKlZwRKHPGh4atiPQPRFsYayG4ZNnK+aa1lb
	gcp+DTAqPSKyf27e+ks4Cl01ES2HqEH2rQf7sCefpvLvYT2w9sqtzVXCRSR5jXJk5L2b8F1vzA7oQ
	tsnm7Px6fY3LNKnca0TIApndYbXVnhXqr1L/3px9Jbgvg8kpIjo9+ybHW7TfM4tKd7qoeANp3iEtD
	GnQSbLmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkTHr-00000000ZtK-0xD2;
	Thu, 16 Jul 2026 21:06:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkTHp-00000000Zsx-3SOa
	for kexec@lists.infradead.org;
	Thu, 16 Jul 2026 21:06:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6C40A411FD;
	Thu, 16 Jul 2026 21:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859721F000E9;
	Thu, 16 Jul 2026 21:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784235989;
	bh=oucStQnRyawORtPI7Wj+qEZX9FA99Twpl/PrB1SpiMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mOC8CeGi42U+SdUKidcJPeWP6ZY4+ga7NyPiOUDh79HKDJUjX0/fAvYuU4zHGvfR5
	 HQCjCcs8mYgluWNtJzcWXoGF996LfTAFtzmJ5jFHo63T7NRCIw9CxmGePcNdTPdEMR
	 OMaak/ENhnvrB1SlY/b+v/QVqL3/mxpe0HG+pb2j17Y+j198b2SRNxecu3PWemJuXe
	 yWYrK66ibJzgTJdjdJq+7dUWCs57xiGlurrXoJkgWIJQA6/J1Jfh20qQs+81U22lEe
	 29I0zLtHNmMyabxgk6lApS7oubGAZvAiAn9D3VXdFj705DLbr+H4zKIbd5oibckO5A
	 hlYWVxCVcMH4A==
Date: Fri, 17 Jul 2026 00:06:22 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Michal Clapinski <mclapinski@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
Message-ID: <allHznJ3EyI-dytV@kernel.org>
References: <20260714205111.2497151-1-mclapinski@google.com>
 <178409777790.255896.16691338963510282908.b4-review@b4>
 <aljy_-Y7OT6s0kj0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aljy_-Y7OT6s0kj0@google.com>
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

On Thu, Jul 16, 2026 at 11:04:31AM -0400, Pasha Tatashin wrote:
> On 07-15 09:42, Mike Rapoport wrote:
> > Hi Michal,
> > 
> > > I caught this crash:
> > > BUG: unable to handle page fault for address: ff19164fffff8328
> > > RIP: 0010:__free_one_page+0x1a1/0x6b0
> > > Call Trace:
> > >  <TASK>
> > >  [<ffffffff913208bf>] free_one_page+0xaf/0x240
> > >  [<ffffffff93973288>] deferred_free_pages+0xa8/0xd0
> > >  [<ffffffff93971b4f>] deferred_init_memmap_chunk+0x10f/0x1b0
> > >  [<ffffffff9396e265>] padata_mt_helper+0x65/0xa0
> > >  [<ffffffff90fac402>] process_scheduled_works+0x202/0x410
> > >  [<ffffffff90fae739>] worker_thread+0x1f9/0x2d0
> > >  [<ffffffff90fb62fd>] kthread+0x27d/0x2f0
> > >  [<ffffffff90fae540>] ? __pfx_worker_thread+0x10/0x10
> > >  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
> > >  [<ffffffff90efdc55>] ret_from_fork+0x145/0x280
> > >  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
> > >  [<ffffffff90e2e46a>] ret_from_fork_asm+0x1a/0x30
> > >  </TASK>
> > > 
> > > deferred_init_memmap_chunk() works fine without KHO because free
> > > regions will never be neighbors. However, with KHO, free memory
> > > will be split into (free && scratch) and (free && !scratch).
> > > KHO scratch is aligned to CMA_MIN_ALIGNMENT_BYTES (which on my setup
> > > is equal to 1 << 9 pages) but buddy can look at the neighborhood of
> > > MAX_ORDER_NR_PAGES pages (which is equal to 1 << 10 pages).
> > > This sometimes crashes when one half of the neighborhood is being
> > > initialized but the other part is yet to be initialized.
> > > 
> > > To fix this, let's just align KHO scratch to MAX_ORDER_NR_PAGES pages.
> > > 
> > > Fixes: c6073743d0c7 ("kho: make preserved pages compatible with deferred struct page init")
> > > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > >
> > > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > > index 4834a809985ab..50928aaa33710 100644
> > > --- a/kernel/liveupdate/kexec_handover.c
> > > +++ b/kernel/liveupdate/kexec_handover.c
> > > @@ -38,6 +38,16 @@
> > >  #include "../kexec_internal.h"
> > >  #include "kexec_handover_internal.h"
> > >  
> > > +/*
> > > + * This is the minimal alignment required by deferred struct page init.
> > > + * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
> > > + * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> > > + * If KHO scratch is not aligned to that value, buddy can access uninitialized
> > > + * struct pages, which can cause a crash.
> > > + */
> > > +#define SCRATCH_ALIGNMENT_BYTES (1 << (PAGE_SHIFT + MAX_PAGE_ORDER))
> > > +static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
> > 
> > Maybe make it a variable and set it at runtime?
> > We won't need to worry about different confugurations that override
> > MAX_ORDER and potentail divergence of pageblock size from MAX_ORDER in
> 
> Do those architectures reduce MAX_ORDER when they override it? I would 
> hope we could set the alignment once and make it large enough to work 
> everywhere, rather than depending on dynamic changes even during boot...

They could, e.g. arm64 has this:

config ARCH_FORCE_MAX_ORDER
	int
	default "13" if ARM64_64K_PAGES
	default "11" if ARM64_16K_PAGES
	default "10"
 
> > the future.
> > 
> > -- 
> > Sincerely yours,
> > Mike.
> > 

-- 
Sincerely yours,
Mike.


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935B2F327A8
	for <kexec@archiver.kernel.org>; Tue, 21 Apr 2026 06:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1aRMmUIunY2D6/F9pOtV5sNBSuLNQ6TBWuB1f9eyf3A=; b=NelHlGB6+g0MnDaKv3xKrypR5Y
	Ecezkd4W8U8SHWskpc8qnxZ1ow3S1LdXhuaTzlNPJKVCVCjSp5T5gbemEv1gnGGxJcgXPaTKU4pR3
	DvnOmTdJc/jZ8m4sW+T4wdo4ocDCe9+KPKSAaJq1I7+vogOsMCHfM6ToZTWusdY7xxKGbKZDAGNJe
	YOsLpZ6kAnROKj+lWLrnWFY+i6AO0ZEOsrqjPyz+UY7vZkdVUDI4v5zGxJoifuD9s/ryswKahQS4G
	K9FeBKAc/7JVU7/3+D1cGxw4IPYt8hZpZ9gUyhtVXqBTQpXtHB+DT89IYJfaMx3TwWHRVhZGIMsDv
	6Y3ptDXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF4Ho-000000084sb-2H2p;
	Tue, 21 Apr 2026 06:08:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF4Hl-000000084s4-2v49
	for kexec@lists.infradead.org;
	Tue, 21 Apr 2026 06:08:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8CC9D41B09;
	Tue, 21 Apr 2026 06:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402A3C2BCB0;
	Tue, 21 Apr 2026 06:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776751716;
	bh=W/hzbip07LNU/tDJ2aO3ZCidj5JMSONEyovcM7R7tZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxpOYq0qMk/X+UYLwyY+5jPb27dG3yNzGaRGqgOSBB6EGi0gmlrWIwn7HZ/lBe3lu
	 2sehwQcnzYl2XIlQQqfBpoirREgd4El6lkSxTo4Rt3YDaeRdze7PVcExaIUVo+FuJD
	 hPQg2l62q4NOQ8v6SlErDOF1hWWn1jfhQVuHqn77E21IsRN+yfx8/HViLmi2yIyU+D
	 Osqj/aZeE32cgTH9AkM1ZRYuhvwJb1+sA+kfNSYEJ2+eAH7VelseY7ukM6u/ZZyJXZ
	 aKJl3xSyRlc67o/CeFYGxzS8PV01KjlFDcv41EJyCMu5+d5IILkH9aKyRtxw5SvxTc
	 W/oC5ziCgPafg==
Date: Tue, 21 Apr 2026 09:08:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v8 1/2] kho: fix deferred initialization of scratch areas
Message-ID: <aecUW-Xgm5MPMyVr@kernel.org>
References: <20260416110654.247398-1-mclapinski@google.com>
 <20260416110654.247398-2-mclapinski@google.com>
 <aeD2Fzr6yr4pu9-X@kernel.org>
 <CAAi7L5d-ujEa7R21Lmd37X9451KBmK8ZhagSKbJde15aQLi2MQ@mail.gmail.com>
 <aeEKksfLxQ0A7Jun@kernel.org>
 <CAAi7L5cp3B0DFEQex5EqFdLDkqVWwRw228-pgp0PnhfgLP=e6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAi7L5cp3B0DFEQex5EqFdLDkqVWwRw228-pgp0PnhfgLP=e6Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_230837_794551_75E18CB3 
X-CRM114-Status: GOOD (  19.00  )
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

On Mon, Apr 20, 2026 at 03:11:03PM +0200, Michał Cłapiński wrote:
> On Thu, Apr 16, 2026 at 6:13 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Thu, Apr 16, 2026 at 05:06:10PM +0200, Michał Cłapiński wrote:
> > > On Thu, Apr 16, 2026 at 4:45 PM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > Hi Michal,
> > > >
> > > > On Thu, Apr 16, 2026 at 01:06:53PM +0200, Michal Clapinski wrote:
> > > > > @@ -2262,6 +2253,12 @@ static void __init memmap_init_reserved_range(phys_addr_t start,
> > > > >                * access it yet.
> > > > >                */
> > > > >               __SetPageReserved(page);
> > > > > +
> > > > > +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
> > > >
> > > > No need for #ifdef here, there's a stub returning false for
> > > > CONFIG_MEMBLOCK_KHO_SCRATCH=n case.
> > >
> > > In all 3 places the #ifdef is there because MIGRATE_CMA might be
> > > undefined. I already broke mm-new branch in the past because of that.
> >
> > Hmm, that hurts :/
> >
> > The best I can think of is to add a static inline in memblock.h and ifdefs
> > around it.
> 
> Sorry, I don't understand what you mean. What would that static inline contain?

Something like this:

#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
						       enum migratetype mt)
{
	if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)))
		return MIGRATE_CMA
	return mt;
}
#else
static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
						       enum migratetype mt)
{
	return mt;
}
#endif

Can't say I'm happy about the name, but could not think of something
better.

> > > > > +             if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)) &&
> > > > > +                 pageblock_aligned(pfn))
> > > > > +                     init_pageblock_migratetype(page, MIGRATE_CMA, false);
> > > > > +#endif
> > > > >       }
> > > > >  }
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.


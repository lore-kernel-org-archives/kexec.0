Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CCDF94CDE
	for <kexec@archiver.kernel.org>; Wed, 22 Apr 2026 08:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sYLiGcnW+OQmYUURhujiHWOSX8EBFzucg+U6o17BlWI=; b=J79cVe9Oup0t1bb3tf/hEGhUx+
	Xk0E4e3esOXemm6B4o7E8THfR/7+RbVbcB7HmMO2SfXa0K7PFcftlJ73/eaivgJfeRkJ6HPJNeF9l
	MNKBHn3k90IruwgiHhroIIuQQQtMGWTw0SA0gIIezitfnGsYN7N7wit+c2+KeOS35/YPyhdfpNOCa
	gId/3JK+VxWVOu20Ln8qQIABMzWKMUFGXXP4ZGsnoq0RuwPfgZJrGHCzAfgX3xsy4jcns4f8JtgQ8
	Xijy4XxOfAEW8ZK5h05iECaUa20/nd96VdYH79sCBWn6/e+QyIgDRobqrL3/Jss2leR7eFsBF3HM6
	90OoNTlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFSt8-00000009m3o-3jJF;
	Wed, 22 Apr 2026 08:24:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFSt6-00000009m3R-3n3h
	for kexec@lists.infradead.org;
	Wed, 22 Apr 2026 08:24:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 059BE4069B;
	Wed, 22 Apr 2026 08:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1779C19425;
	Wed, 22 Apr 2026 08:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776846287;
	bh=O4CGkWR3yo72+GsjHY8NtS8RkGbc3ZGUxRZULeofgFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cv0wwWgrynQ5CA3sXK6hAWgNSFWM9M0Zf2+AiJn8U6B9PhZ8P+C4ZcFM2PTWH3/gS
	 xunfJhdsw6QoZtFJ7iQZ1jD/zF3jHLpWq1U0LzJ1UqK6dYj9WCy5q36v2PwNmOUy92
	 +ddok9+Sq2osrJYGf7HRLV38oc6lizDVYyDKEbkCaWLBoeXywA/hrW+EJmemlReyHx
	 A4tFlE44uBAEjEHQbhIY2BImZLll0veiNGSOAJpViaay+cnCilRb/Lf1uj4stLtM/3
	 yk99yteLjLs3RCIdvQqb8sXfx3R6zXyYAEYIw67qBRxVeD29gSj3H9EYJqOxWNRAEw
	 bTUUsOhSinHig==
Date: Wed, 22 Apr 2026 11:24:39 +0300
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
Message-ID: <aeiFx8tilasoGzwa@kernel.org>
References: <20260416110654.247398-1-mclapinski@google.com>
 <20260416110654.247398-2-mclapinski@google.com>
 <aeD2Fzr6yr4pu9-X@kernel.org>
 <CAAi7L5d-ujEa7R21Lmd37X9451KBmK8ZhagSKbJde15aQLi2MQ@mail.gmail.com>
 <aeEKksfLxQ0A7Jun@kernel.org>
 <CAAi7L5cp3B0DFEQex5EqFdLDkqVWwRw228-pgp0PnhfgLP=e6Q@mail.gmail.com>
 <aecUW-Xgm5MPMyVr@kernel.org>
 <CAAi7L5d8x1MB1f6A_h2acj1CYU1wf7DijS1TENC+Lurx5wLhKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAi7L5d8x1MB1f6A_h2acj1CYU1wf7DijS1TENC+Lurx5wLhKw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_012448_986230_8DAE5EAB 
X-CRM114-Status: GOOD (  25.48  )
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

On Tue, Apr 21, 2026 at 12:20:27PM +0200, Michał Cłapiński wrote:
> On Tue, Apr 21, 2026 at 8:08 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Mon, Apr 20, 2026 at 03:11:03PM +0200, Michał Cłapiński wrote:
> > > On Thu, Apr 16, 2026 at 6:13 PM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > On Thu, Apr 16, 2026 at 05:06:10PM +0200, Michał Cłapiński wrote:
> > > > > On Thu, Apr 16, 2026 at 4:45 PM Mike Rapoport <rppt@kernel.org> wrote:
> > > > > >
> > > > > > Hi Michal,
> > > > > >
> > > > > > On Thu, Apr 16, 2026 at 01:06:53PM +0200, Michal Clapinski wrote:
> > > > > > > @@ -2262,6 +2253,12 @@ static void __init memmap_init_reserved_range(phys_addr_t start,
> > > > > > >                * access it yet.
> > > > > > >                */
> > > > > > >               __SetPageReserved(page);
> > > > > > > +
> > > > > > > +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
> > > > > >
> > > > > > No need for #ifdef here, there's a stub returning false for
> > > > > > CONFIG_MEMBLOCK_KHO_SCRATCH=n case.
> > > > >
> > > > > In all 3 places the #ifdef is there because MIGRATE_CMA might be
> > > > > undefined. I already broke mm-new branch in the past because of that.
> > > >
> > > > Hmm, that hurts :/
> > > >
> > > > The best I can think of is to add a static inline in memblock.h and ifdefs
> > > > around it.
> > >
> > > Sorry, I don't understand what you mean. What would that static inline contain?
> >
> > Something like this:
> >
> > #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
> > static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
> >                                                        enum migratetype mt)
> > {
> >         if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)))
> >                 return MIGRATE_CMA
> >         return mt;
> > }
> > #else
> > static inline enum migratetype kho_scratch_migratetype(unsigned long pfn,
> >                                                        enum migratetype mt)
> > {
> >         return mt;
> > }
> > #endif
> 
> How would I use it for this code?
> 
> +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
> +             if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)) &&
> +                 pageblock_aligned(pfn))
> +                     init_pageblock_migratetype(page, MIGRATE_CMA, false);
> +#endif

Something like this

		enum migratetype mt = kho_scratch_migratetype(pfn, MIGRATE_MOVABLE);

	        ...

		if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)) &&
		    pageblock_aligned(pfn)) 
			init_pageblock_migratetype(page, mt, false);

seems better to me than ifdef, even though MIGRATE_MOVABLE is bogus here.

And since we anyway changing init_pageblock_migratetype() callers in
mm_init.c the entire block in memmap_init_reserved_range() can be dropped
and the change can be done in __init_page_from_nid().

> 
> It doesn't invoke init_pageblock_migratetype unless pfn is kho scratch.
> 
> > Can't say I'm happy about the name, but could not think of something
> > better.
> >
> > > > > > > +             if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)) &&
> > > > > > > +                 pageblock_aligned(pfn))
> > > > > > > +                     init_pageblock_migratetype(page, MIGRATE_CMA, false);
> > > > > > > +#endif
> > > > > > >       }
> > > > > > >  }
> > > >
> > > > --
> > > > Sincerely yours,
> > > > Mike.
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.


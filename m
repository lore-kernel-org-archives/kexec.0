Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9051CF8D753
	for <kexec@archiver.kernel.org>; Thu, 16 Apr 2026 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zd3e2VDKFmhHyj8dlw1B5vVyPvKeqv4J9fz3f7RtiCM=; b=g74oWPW4zJF7L6AvI7PWA0tyuG
	o3n2jrSghJWPQc5clhqR6zFWf4zYEzAFklDyTnqk4PHmuU7XJmGCKK4Y/GFU4AFA1Q2MVwU+p8Lp+
	cJ29Gn8kiNXazYtoZIYMoUb0jt1uc7FK2prDLoUU7v7FNcqY/fZgrqQE2aKqucQGLDXh2O8bM3ylK
	UDTDdvi5AFRReD8ZnPYZzBDYIRsCyIsIVQ6vygZlQ8jH22X1RwExxSe0J0ysHuMLJ/CqkgvTGzaMw
	dr1GMtb04/olYXVuRkfq6zYf4OGy1CuzfjHFP/dpi/y3cCnFaU9qIZzhA9Q6lyWj3LD35Vni37rrh
	XLHGPR+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDOsK-00000002dMn-0akM;
	Thu, 16 Apr 2026 15:43:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDOsJ-00000002dMh-2SiU
	for kexec@lists.infradead.org;
	Thu, 16 Apr 2026 15:43:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5914C60127;
	Thu, 16 Apr 2026 15:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91706C2BCAF;
	Thu, 16 Apr 2026 15:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776354205;
	bh=aCG8gGEPXzuo1QRGojUmghGuuLoszJoxEs8ppN1nF9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UnQoNmDqmM4OQ9xZI2iIfRMM2LZ+f8ZvP6JyKMv2rzL4SRId993hJU4/RZb9HMW8K
	 KLdoOhFv/hOkgKx0VIX5Z+hxsV0R9pzX5xT+epyBp5ar0AMl8GjKGiOQeE4oHZH5TQ
	 unnuTtu9QTpoIyd6fNAt4/rdStMlWIz2+Liv8RNO/mWqCIL3YqdFhkBaWoZdMoDCmS
	 fIKoMAcdpF5Yzdqf3syStgdqw8ze+El9pQEj0qrsg9FwZhVg1mOdtiPhdrC1V6///W
	 js28o+vPMnyIm2T1xIMsYIxgUdcHLXJebfj8DatOwmqTpSLp5ojbr6zaLIRMHieRac
	 Lx9TSKJTSSHqg==
Date: Thu, 16 Apr 2026 18:43:17 +0300
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
Subject: Re: [PATCH v8 0/2] kho: add support for deferred struct page init
Message-ID: <aeEDlY6ZpzeqmAtJ@kernel.org>
References: <20260416110654.247398-1-mclapinski@google.com>
 <aeD5kboEdzwuR4P_@kernel.org>
 <CAAi7L5dFaxwoU5dho8sJJ41+SSwgrmXW_NjQZnn7UPzj0zoowg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAi7L5dFaxwoU5dho8sJJ41+SSwgrmXW_NjQZnn7UPzj0zoowg@mail.gmail.com>
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

On Thu, Apr 16, 2026 at 05:23:32PM +0200, Michał Cłapiński wrote:
> On Thu, Apr 16, 2026 at 5:00 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Thu, Apr 16, 2026 at 01:06:52PM +0200, Michal Clapinski wrote:
> > > When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, struct page
> > > initialization is deferred to parallel kthreads that run later in
> > > the boot process.
> > >
> > > Currently, KHO is incompatible with DEFERRED.
> > > This series fixes that incompatibility.
> > > ---
> > > v8:
> > > - moved overriding the migratetype from init_pageblock_migratetype
> > >   to callsites
> > > v7:
> > > - reimplemented the initialization of kho scratch again
> > > v6:
> > > - reimplemented the initialization of kho scratch
> > > v5:
> > > - rebased
> > > v4:
> > > - added a new commit to fix deferred init of kho scratch
> > > - switched to ulong when refering to pfn
> > > v3:
> > > - changed commit msg
> > > - don't invoke early_pfn_to_nid if CONFIG_DEFERRED_STRUCT_PAGE_INIT=n
> > > v2:
> > > - updated a comment
> > >
> > > I took Evangelos's test code:
> > > https://git.infradead.org/?p=users/vpetrog/linux.git;a=shortlog;h=refs/heads/kho-deferred-struct-page-init
> > > and then modified it to this monster test that does 2 allocations:
> > > at core_initcall (early) and at module_init (late). Then kexec, then
> > > 2 more allocations at these points, then restore the original 2, then
> > > kexec, then restore the other 2. Basically I test preservation of early
> > > and late allocation both on cold and on warm boot.
> > > Tested it both with and without DEFERRED.
> >
> > Any chance you can clean that monster and send it as patch 3?
> 
> I fear that would delay this series somewhere into v15, which I would
> like to avoid. Can I clean it up and send it separately?

I don't mind. For this series can we add a build with deferred pages to
selftests/kho/vmtest.sh? Shouldn't be as controversial :)
 
> > There's no real difference between core_initcall() and module_init() with
> > respect to that deferred page initialization, they both run after the
> > memory map is fully initialized.
> 
> One of them runs before kho_init() and the other after. So it allowed
> me to expose the bug that I introduced in v4.
 
Ah, nice.

> > > This patch probably doesn't apply onto anything currently.
> > > It's based on mm-new with
> > > "memblock: move reserve_bootmem_range() to memblock.c and make it static"
> > > cherrypicked from rppt/memblock.
> >
> > You can base on for-next in the memblock tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
> 
> I tried that but that branch is missing other commits from mm-new. So
> I would have to modify my code, which would then conflict with mm-new.

Let's continue with mm-new and a cherrypicked memblock patch, it all should
be sorted out after -rc1 I hope.
 
> > > Evangelos Petrongonas (1):
> > >   kho: make preserved pages compatible with deferred struct page init
> > >
> > > Michal Clapinski (1):
> > >   kho: fix deferred initialization of scratch areas
> > >
> > >  include/linux/memblock.h           |  7 ++--
> > >  kernel/liveupdate/Kconfig          |  2 --
> > >  kernel/liveupdate/kexec_handover.c | 52 +++++++++++++++---------------
> > >  mm/memblock.c                      | 41 +++++++++++------------
> > >  mm/mm_init.c                       | 27 +++++++++++-----
> > >  5 files changed, 69 insertions(+), 60 deletions(-)
> > >
> > > --
> > > 2.54.0.rc1.555.g9c883467ad-goog
> > >
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.


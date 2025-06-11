Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D84C71141
	for <kexec@archiver.kernel.org>; Wed, 11 Jun 2025 18:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tQ/UxDHgzeuATrOg3yhOk1IwDk2MPYkl06v/k4Sv0iQ=; b=NpQtAUG9Y7utVVT3LorNoDwqdV
	Zi3hidPRjCaeHCN9ltdOCqbKubbhA4UuVg8wE0i+zR8HPWBUvJr9lnEvJuCRhEDIMEGABKrMhnPTE
	Pd9RaW5IlnKsVYxnHgvQN9p9IZF8a2L1o0h0+YGl3PChbJWly1OKk5Kl4p+mlPbhIhtes+lg+M3B3
	xVVtVHhlyEcFC1DvT4OMMIcVExK5qXA+7fafOzzbOk/gsYZegDQks2dsbjdP240zQw6cZ8zUxnEQ/
	bWlHWoafCWT8nA6oli2EDhRh1wAiPYw/SFle6gmtsTKpm//4sRnD6JmQfJW8HXDaGvG5FY1LEn3LQ
	pahN63/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPPl3-0000000AoDd-2DRM;
	Wed, 11 Jun 2025 18:01:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPMYk-0000000A7Ju-1NGI
	for kexec@lists.infradead.org;
	Wed, 11 Jun 2025 14:36:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AA68243C3B;
	Wed, 11 Jun 2025 14:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F58C4CEEA;
	Wed, 11 Jun 2025 14:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749652569;
	bh=BwQApHN0G3pfvpqONIQ8shCNdyfSmev1VZcGPQpRZ34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOa0tr0MZr22xzfLw6yG03FCfm3DAvZ66DbbNiM8el3S8oQYbxQMYfhtzZHQlNR2q
	 lmSmDbHnHG1gXQRmpiLx5b1HR5ak/nq/HDoCttAfN+n0fwDTeMft5gl3tlWMaHBS3o
	 +XXauGzxsJSluj/syCEdaiCaJ4DUgGPb6o0pXnh5I/PTD97ri5WGCgweRrfIkOWf8D
	 Dyo4R3Yxr83cHU5IcXNBPZl7ASvgPrxLf2bthoyS/TYX6/Ws93Pj5HkrcBqLx6VXVm
	 Bm9hEdL7KtEFqVaOjsQ8BVEb5nGEle3P7KlcPR4/QmlkZjAT5eS0jdDHIgQP0iudoZ
	 qvWkLp1EUfR/g==
Date: Wed, 11 Jun 2025 17:36:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Michal Clapinski <mclapinski@google.com>
Subject: Re: [PATCH] kho: initialize tail pages for higher order folios
 properly
Message-ID: <aEmUU4L3eStEsYQM@kernel.org>
References: <aEc30BoLE9HRxiZm@kernel.org>
 <CA+CK2bAAbZjS2Og79xxLcDtNf-eM0up-8fwhd4fg_dp0j_TahA@mail.gmail.com>
 <aEfGTXrsEL5-DuF1@kernel.org>
 <CA+CK2bDXOWzrTsNtbCCK2rabNysf0JFQT5VfAjYrX5oSoiLmSQ@mail.gmail.com>
 <aEhgNU80Dr9iRwoD@kernel.org>
 <CA+CK2bD3n=JDuSsMGvsyMnVbPhGdhdf6zWFDa3KpzRGEXygdgQ@mail.gmail.com>
 <mafs0qzzqo2bg.fsf@kernel.org>
 <CA+CK2bBoMfJuUCV6sL80kwzYPnENnt7fDk2jRMPV0iPn1jCJdw@mail.gmail.com>
 <aEmGMNL9v9djgrGz@kernel.org>
 <mafs0ikl2nzqn.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mafs0ikl2nzqn.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_073610_406903_534FD512 
X-CRM114-Status: GOOD (  45.76  )
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

On Wed, Jun 11, 2025 at 04:01:52PM +0200, Pratyush Yadav wrote:
> On Wed, Jun 11 2025, Mike Rapoport wrote:
> 
> > On Wed, Jun 11, 2025 at 09:14:55AM -0400, Pasha Tatashin wrote:
> >> On Wed, Jun 11, 2025 at 9:06 AM Pratyush Yadav <pratyush@kernel.org> wrote:
> >> >
> >> > On Tue, Jun 10 2025, Pasha Tatashin wrote:
> >> >
> >> > >> > > I think it should be the other way around, KHO should depend on
> >> > >> > > !DEFERRED_STRUCT_PAGE_INIT.
> >> > >> >
> >> > >> > Agreed, and this is what I first tried, but that does not work, there
> >> > >> > is some circular dependency breaking the build. If you feel
> >> > >> > adventurous you can try that :-)
> >> > >>
> >> > >> Hmm, weird, worked for me :/
> >> >
> >> > Worked for me as well.
> >> >
> >> > >
> >> > > I am super confused, it did not work for me over weekend, and now it
> >> > > is working. Even `make menuconfig` would not work. Anyways, I will put
> >> > > it in the appropriate place.
> >> > >
> >> > >>
> >> > >> > > > We will need to teah KHO to work with deferred struct page init. I
> >> > >> > > > suspect, we could init preserved struct pages and then skip over them
> >> > >> > > > during deferred init.
> >> > >> > >
> >> > >> > > We could, but with that would mean we'll run this before SMP and it's not
> >> > >> > > desirable. Also, init_deferred_page() for a random page requires
> >> > >> >
> >> > >> > We already run KHO init before smp_init:
> >> > >> > start_kernel() -> mm_core_init() -> kho_memory_init() ->
> >> > >> > kho_restore_folio() -> struct pages must be already initialized here!
> >> > >> >
> >> > >> > While deferred struct pages are initialized:
> >> > >> > start_kernel() -> rest_init() -> kernel_init() ->
> >> > >> > kernel_init_freeable() -> page_alloc_init_late() ->
> >> > >> > deferred_init_memmap()
> >> > >> >
> >> > >> > If the number of preserved pages that is needed during early boot is
> >> > >> > relatively small, that it should not be an issue to pre-initialize
> >> > >> > struct pages for them before deferred struct pages are initialized. We
> >> > >> > already pre-initialize some  "struct pages" that are needed during
> >> > >> > early boot before the reset are initialized, see deferred_grow_zone()
> >> > >>
> >> > >> deferred_grow_zone() takes a chunk in the beginning of uninitialized range,
> >> > >> with kho we are talking about some random pages. If we preinit them early,
> >> > >> deferred_init_memmap() will overwrite them.
> >> > >
> >> > > Yes, this is why I am saying that we would need to skip the KHO
> >> > > initialized "struct pages" somehow during deferred initialization. If
> >> > > we create an ordered by PFN list of early-initialized KHO struct
> >> > > pages, skipping during deferred initialization could be done
> >> > > efficiently.
> >> >
> >> > Or keep things simple and don't use any KHO struct pages during early
> >> > init. You can access the page itself, just don't use its struct page.
> >> >
> >> > Currently the only user of kho_restore_folio() during init is
> >> > kho_memory_init(). The FDT is accessed by doing
> >> > phys_to_virt(kho_in.fdt_phys) anyway, so there is really no need for
> >> > restoring the folio so early. It can be done later, for example when LUO
> >> > does the finish event, to clean up and free the folio.
> >> 
> >> Good suggestion, however, KHO does not have any sophisticated users
> >> that we are going to be adding as part of the live update work in the
> >> future: IR, KVM, early VCPU threads, and so on. So, while today, this
> >> might work, in the future, I am not sure if we should expect struct
> >> pages are not accessed until after deferred initialization or simply
> >> fix it once and for all.
> >
> > KHO already accesses stuct page early and uses page->private for order.
> > Since preserved memory is reserved in memblock, deferred init of struct
> > pages won't touch those pages, we just need to make sure they are properly 
> 
> Not strictly true. Some of them might have been initialized from
> free_area_init() -> memmap_init() (the ones not eligible for deferred
> init), which happens before KHO makes its memblock reservations.
> 
> > initialized at some point. If we don't expect many kho_restore_folio()
> > before page_alloc_init_late() we can use init_deferred_page() for early
> > accesses.
> 
> I tried doing this when looking into this initially, but it doesn't work
> for some reason.
> 
>     static void kho_restore_page(struct page *page, unsigned int order)
>     {
>     	unsigned int i, nr_pages = (1 << order);
>     
>     	/* Head page gets refcount of 1. */
>     	init_deferred_page(page_to_pfn(page), NUMA_NO_NODE);


This would do

	if (early_page_initialised(pfn, nid))
		return;

	__init_page_from_nid(pfn, nid);

and I'm really surprised it didn't crash in early_page_initialised()
because of NUMA_NO_NODE :)

What might work here is 

	pfn = page_to_pfn(page);
	__init_page_from_nid(pfn, early_pfn_to_nid(pfn));

>     	set_page_count(page, 1);
>     
>     	/* For higher order folios, tail pages get a page count of zero. */
>     	for (i = 1; i < nr_pages; i++) {
>     		init_deferred_page(page_to_pfn(page + i), NUMA_NO_NODE);
>     		set_page_count(page + i, 0);
>     	}
>     
>     [...]
> 
> results in:
> 
>     [    0.644032] page:(____ptrval____) is uninitialized and poisoned
>     [    0.644679] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(page))
>     [    0.645376] ------------[ cut here ]------------
>     [    0.645883] kernel BUG at ./include/linux/mm.h:1512!
>     [...]
>     [    0.647924] RIP: 0010:__pageblock_pfn_to_page+0x166/0x180
>     [...]
>     [    0.647924]  <TASK>
>     [    0.647924]  set_zone_contiguous+0x6b/0x90
>     [    0.647924]  page_alloc_init_late+0x356/0x370
>     [    0.647924]  kernel_init_freeable+0x12d/0x190
>     [    0.647924]  ? __pfx_kernel_init+0x10/0x10
>     [    0.647924]  kernel_init+0x1a/0x130
> 
> didn't dig any deeper on why it happens...
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.


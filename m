Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06D5C61DB2
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 20:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l1i8H/gKC/oQ3qAYchklHr1EYmsfN/BYNqkPNHyoIWY=; b=FhZ55VFrO0QVe09Szyw2BBII1N
	IiDarjdIZ9HkpTjAstJuiTKGCZDMNJ8OI+LZFAE+Jl9U/NV6pw7G8TAh68hdqSoxRTOuBahnMIekE
	3KuKTJ8asArtQ2rcUuLX8pbfK66PrEsh6ZHnqCx5Yi+GuFPf4LExfmiCdibFv+fQdU9pCgIhe8IyY
	y20QYY+/fGJNPzK2aNPrYwnKEmJiMIsYAK8JFku8W0ryzHYofpJZ/GWMMa3JOWXCfSIK7iNw21eYq
	X8AKkhC8cNTr3BwjncngEh2uYFe32IPiT74Ot9rqTmWr0YJHhC+QlWGuTqSGP2DjdmJiuIaTqjeMP
	df1opofA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP5Hm-000000080RN-3f0T;
	Tue, 10 Jun 2025 20:09:30 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP22W-00000007VSv-3umw
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 16:41:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 54A40439AA;
	Tue, 10 Jun 2025 16:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145CAC4CEED;
	Tue, 10 Jun 2025 16:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749573692;
	bh=08Tu33HS43YPREV9dKmb5e6r7DxszomFLxukqEtLKf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IdDVu89IR3IdEcEWe6/IvKaF7o5LSpl246RsGJ6PnsyEtdcTN4MRqXzKvbf2pAC+L
	 Js7czcTLYihX65/4n5DfhNZ/7Av+Gw2+l4m3hyp26Zz8q5jGJ4q41LY2MAhMS44SVy
	 s4iMDv2EA30q4UgZ3myzo6Oj+Hci3/58dDeLcukivysCI/HavQ0nEmltshuJHfaYe7
	 lIMdHLaOMY5OXv+iyUzYa4c7fyfqsiZjp9yyAVQjCLVrDMlqMeBk1av8mKfq8MQ1UR
	 HESTnkU13SHTt0TNkiHP2iUyPTTKSwiN6gUHzw9JNr4T1Fzk016KxwKva0tLRM/b7c
	 3jt+dIAuHtVdA==
Date: Tue, 10 Jun 2025 19:41:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: initialize tail pages for higher order folios
 properly
Message-ID: <aEhgNU80Dr9iRwoD@kernel.org>
References: <20250605171143.76963-1-pratyush@kernel.org>
 <aEKhF3HcrvG77Ogb@kernel.org>
 <mafs0jz5osutx.fsf@kernel.org>
 <aEc30BoLE9HRxiZm@kernel.org>
 <CA+CK2bAAbZjS2Og79xxLcDtNf-eM0up-8fwhd4fg_dp0j_TahA@mail.gmail.com>
 <aEfGTXrsEL5-DuF1@kernel.org>
 <CA+CK2bDXOWzrTsNtbCCK2rabNysf0JFQT5VfAjYrX5oSoiLmSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDXOWzrTsNtbCCK2rabNysf0JFQT5VfAjYrX5oSoiLmSQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_094133_019772_176C61B6 
X-CRM114-Status: GOOD (  47.41  )
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

On Tue, Jun 10, 2025 at 07:20:23AM -0400, Pasha Tatashin wrote:
> On Tue, Jun 10, 2025 at 1:44 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Mon, Jun 09, 2025 at 04:07:50PM -0400, Pasha Tatashin wrote:
> > > On Mon, Jun 9, 2025 at 3:36 PM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > Hi Pratyush,
> > > >
> > > > On Fri, Jun 06, 2025 at 06:23:06PM +0200, Pratyush Yadav wrote:
> > > > > Hi Mike,
> > > > >
> > > > > On Fri, Jun 06 2025, Mike Rapoport wrote:
> > > > >
> > > > > > On Thu, Jun 05, 2025 at 07:11:41PM +0200, Pratyush Yadav wrote:
> > > > > >> From: Pratyush Yadav <ptyadav@amazon.de>
> > > > > >>
> > > > > >> --- a/kernel/kexec_handover.c
> > > > > >> +++ b/kernel/kexec_handover.c
> > > > > >> @@ -157,11 +157,21 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
> > > > > >>  }
> > > > > >>
> > > > > >>  /* almost as free_reserved_page(), just don't free the page */
> > > > > >> -static void kho_restore_page(struct page *page)
> > > > > >> +static void kho_restore_page(struct page *page, unsigned int order)
> > > > > >>  {
> > > > > >> -  ClearPageReserved(page);
> > > > > >
> > > > > > So now we don't clear PG_Reserved even on order-0 pages? ;-)
> > > > >
> > > > > We don't need to. As I mentioned in the commit message as well,
> > > > > PG_Reserved is never set for KHO pages since they are reserved with
> > > > > MEMBLOCK_RSRV_NOINIT, so memmap_init_reserved_pages() skips over them.
> > > >
> > > > You are right, I missed it.
> > > >
> > > > > That said, while reading through some of the code, I noticed another
> > > > > bug: because KHO reserves the preserved pages as NOINIT, with
> > > > > CONFIG_DEFERRED_STRUCT_PAGE_INIT == n, all the pages get initialized
> > > > > when memmap_init_range() is called from setup_arch (paging_init() on
> > > > > x86). This happens before kho_memory_init(), so the KHO-preserved pages
> > > > > are not marked as reserved to memblock yet.
> > > > >
> > > > > With deferred page init, some pages might not get initialized early, and
> > > > > get initialized after kho_memory_init(), by which time the KHO-preserved
> > > > > pages are marked as reserved. So, deferred_init_maxorder() will skip
> > > > > over those pages and leave them uninitialized.
> > > > >
> > > > > So we need to either also call init_deferred_page(), or remove the
> > > > > memblock_reserved_mark_noinit() call in deserialize_bitmap(). And TBH, I
> > > > > am not sure why KHO pages even need to be marked noinit in the first
> > > > > place. Probably the only benefit would be if a large chunk of memory is
> > > > > KHO-preserved, the pages can be initialized later on-demand, reducing
> > > > > bootup time a bit.
> > > >
> > > > One benefit is performance indeed, because in not deferred case the
> > > > initialization of reserved pages in memmap_init_reserved_pages() is really
> > > > excessive.
> > > >
> > > > But more importantly, if we remove memblock_reserved_mark_noinit(), with
> > > > CONFIG_DEFERRED_STRUCT_PAGE_INIT we'd loose page->private because the
> > > > struct page will be cleared after kho_mem_deserialize().
> > > >
> > > > > What do you think? Should we drop noinit or call init_deferred_page()?
> > > > > FWIW, my preference is to drop noinit, since init_deferred_page() is
> > > > > __meminit and we would have to make sure it doesn't go away after boot.
> > > >
> > > > We can't drop noinit and calling init_deferred_page() after boot just won't
> > > > work because it uses memblock to find the page's node and memblock is gone
> > > > after init.
> > > >
> > > > The simplest short-term solution is to disable KHO when
> > > > CONFIG_DEFERRED_STRUCT_PAGE_INIT is set and then find an efficient way to
> > > > make it all work together.
> > >
> > > This is what I've done in LUOv3 WIP:
> > > https://github.com/soleen/linux/commit/3059f38ac0a39a397873759fb429bd5d1f8ea681
> >
> > I think it should be the other way around, KHO should depend on
> > !DEFERRED_STRUCT_PAGE_INIT.
> 
> Agreed, and this is what I first tried, but that does not work, there
> is some circular dependency breaking the build. If you feel
> adventurous you can try that :-)

Hmm, weird, worked for me :/
 
> > > We will need to teah KHO to work with deferred struct page init. I
> > > suspect, we could init preserved struct pages and then skip over them
> > > during deferred init.
> >
> > We could, but with that would mean we'll run this before SMP and it's not
> > desirable. Also, init_deferred_page() for a random page requires
> 
> We already run KHO init before smp_init:
> start_kernel() -> mm_core_init() -> kho_memory_init() ->
> kho_restore_folio() -> struct pages must be already initialized here!
> 
> While deferred struct pages are initialized:
> start_kernel() -> rest_init() -> kernel_init() ->
> kernel_init_freeable() -> page_alloc_init_late() ->
> deferred_init_memmap()
> 
> If the number of preserved pages that is needed during early boot is
> relatively small, that it should not be an issue to pre-initialize
> struct pages for them before deferred struct pages are initialized. We
> already pre-initialize some  "struct pages" that are needed during
> early boot before the reset are initialized, see deferred_grow_zone()

deferred_grow_zone() takes a chunk in the beginning of uninitialized range,
with kho we are talking about some random pages. If we preinit them early,
deferred_init_memmap() will overwrite them.

Anyway, I'm going to look into it, hopefully I'll have something Really
Soon (tm).
 
> Pasha

-- 
Sincerely yours,
Mike.


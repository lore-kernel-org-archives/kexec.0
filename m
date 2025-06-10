Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3323C61DB2
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 05:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YuKLGx6o286cAEpkNpnYdZ8aIdxAVC37hih+/xzulMg=; b=RG+VMLhv6ZHiOK80WG05mWBlOr
	IOx+fZFtFcKLi9D4i36SBjbD3aId+htfuQTBicUXUbHsf4SHGXz3bEv03xWXeopy2wA6regHNl3pu
	CNtG07Pv3QksUWo+YRvmYgnWEBlIwZi9/wCdhNaFyBok2fQj7oq0lDlKBb0mnnsv75TrmrJO9+IHm
	h/qncfvBrP+HLSS00kOg/hgPpsPnuFI2pYFumFdJGRoaMoL7j3BFCOCobFO9i5IR6rrhdYsmkClHY
	pIX60SjMpVNX/is3xwnAorJ2D9zYD4wfWWYrOSvA6E/kyfyHHBTpVFSUuGvrZwEb+wEE93QkdDOx3
	/ywb54nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrn8-00000005rZD-1zpz;
	Tue, 10 Jun 2025 05:44:58 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrn3-00000005rXy-1suq
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 05:44:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9471EA50C11;
	Tue, 10 Jun 2025 05:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528DEC4CEEF;
	Tue, 10 Jun 2025 05:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749534292;
	bh=W+Gg4WOhK9awSlR/caQgQ38dLinN024eBtGS/ksxClw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxupDTQ06zfuopf4OU2zbSpo9JenUV3xucU30QvDP3xxaPrjvCDxrwJACEPiTBqtu
	 je6iLXmTkqxL0PPqW/aPIJeGMzq1pdHN15ydbQsMxFvyIghPwMjbK9yy6ONVJK68ju
	 blTglhxSnHf106jy9zd85Ffu+pkKFbLe35sO/zJDrVA3Kn6PH0i9LMhAGid9BIQzbp
	 NNN5MUja6ouaXVXwQsA8bUVd8iAGM2m90R3VxBWXpx2hpqLZ7F3uugzjvJ+EIO6aH/
	 xrkkT9fqv+6ka/RsRcFUZ20yOpd82LoHW+0ShrA2xtbwobV+9Ahc74WlnmyNsg7YXh
	 uvufsTllM9Y6w==
Date: Tue, 10 Jun 2025 08:44:45 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: initialize tail pages for higher order folios
 properly
Message-ID: <aEfGTXrsEL5-DuF1@kernel.org>
References: <20250605171143.76963-1-pratyush@kernel.org>
 <aEKhF3HcrvG77Ogb@kernel.org>
 <mafs0jz5osutx.fsf@kernel.org>
 <aEc30BoLE9HRxiZm@kernel.org>
 <CA+CK2bAAbZjS2Og79xxLcDtNf-eM0up-8fwhd4fg_dp0j_TahA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bAAbZjS2Og79xxLcDtNf-eM0up-8fwhd4fg_dp0j_TahA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_224453_623256_1EA49988 
X-CRM114-Status: GOOD (  39.03  )
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

On Mon, Jun 09, 2025 at 04:07:50PM -0400, Pasha Tatashin wrote:
> On Mon, Jun 9, 2025 at 3:36 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Hi Pratyush,
> >
> > On Fri, Jun 06, 2025 at 06:23:06PM +0200, Pratyush Yadav wrote:
> > > Hi Mike,
> > >
> > > On Fri, Jun 06 2025, Mike Rapoport wrote:
> > >
> > > > On Thu, Jun 05, 2025 at 07:11:41PM +0200, Pratyush Yadav wrote:
> > > >> From: Pratyush Yadav <ptyadav@amazon.de>
> > > >>
> > > >> --- a/kernel/kexec_handover.c
> > > >> +++ b/kernel/kexec_handover.c
> > > >> @@ -157,11 +157,21 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
> > > >>  }
> > > >>
> > > >>  /* almost as free_reserved_page(), just don't free the page */
> > > >> -static void kho_restore_page(struct page *page)
> > > >> +static void kho_restore_page(struct page *page, unsigned int order)
> > > >>  {
> > > >> -  ClearPageReserved(page);
> > > >
> > > > So now we don't clear PG_Reserved even on order-0 pages? ;-)
> > >
> > > We don't need to. As I mentioned in the commit message as well,
> > > PG_Reserved is never set for KHO pages since they are reserved with
> > > MEMBLOCK_RSRV_NOINIT, so memmap_init_reserved_pages() skips over them.
> >
> > You are right, I missed it.
> >
> > > That said, while reading through some of the code, I noticed another
> > > bug: because KHO reserves the preserved pages as NOINIT, with
> > > CONFIG_DEFERRED_STRUCT_PAGE_INIT == n, all the pages get initialized
> > > when memmap_init_range() is called from setup_arch (paging_init() on
> > > x86). This happens before kho_memory_init(), so the KHO-preserved pages
> > > are not marked as reserved to memblock yet.
> > >
> > > With deferred page init, some pages might not get initialized early, and
> > > get initialized after kho_memory_init(), by which time the KHO-preserved
> > > pages are marked as reserved. So, deferred_init_maxorder() will skip
> > > over those pages and leave them uninitialized.
> > >
> > > So we need to either also call init_deferred_page(), or remove the
> > > memblock_reserved_mark_noinit() call in deserialize_bitmap(). And TBH, I
> > > am not sure why KHO pages even need to be marked noinit in the first
> > > place. Probably the only benefit would be if a large chunk of memory is
> > > KHO-preserved, the pages can be initialized later on-demand, reducing
> > > bootup time a bit.
> >
> > One benefit is performance indeed, because in not deferred case the
> > initialization of reserved pages in memmap_init_reserved_pages() is really
> > excessive.
> >
> > But more importantly, if we remove memblock_reserved_mark_noinit(), with
> > CONFIG_DEFERRED_STRUCT_PAGE_INIT we'd loose page->private because the
> > struct page will be cleared after kho_mem_deserialize().
> >
> > > What do you think? Should we drop noinit or call init_deferred_page()?
> > > FWIW, my preference is to drop noinit, since init_deferred_page() is
> > > __meminit and we would have to make sure it doesn't go away after boot.
> >
> > We can't drop noinit and calling init_deferred_page() after boot just won't
> > work because it uses memblock to find the page's node and memblock is gone
> > after init.
> >
> > The simplest short-term solution is to disable KHO when
> > CONFIG_DEFERRED_STRUCT_PAGE_INIT is set and then find an efficient way to
> > make it all work together.
> 
> This is what I've done in LUOv3 WIP:
> https://github.com/soleen/linux/commit/3059f38ac0a39a397873759fb429bd5d1f8ea681

I think it should be the other way around, KHO should depend on
!DEFERRED_STRUCT_PAGE_INIT.
 
> We will need to teah KHO to work with deferred struct page init. I
> suspect, we could init preserved struct pages and then skip over them
> during deferred init.

We could, but with that would mean we'll run this before SMP and it's not
desirable. Also, init_deferred_page() for a random page requires
finding its node with early_pfn_to_nid() that's also suboptimal. 
 
> Pasha
> 
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.


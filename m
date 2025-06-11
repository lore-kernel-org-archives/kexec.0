Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C55CC7114A
	for <kexec@archiver.kernel.org>; Wed, 11 Jun 2025 17:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/DVFZslNMDQCpFsrI22FsAPDdmwlVhjdsES7f27EQQ4=; b=Rn8OEda0pZ92RlEm8Ers9GeiIZ
	L5H/e2pCOM5XziAQgTn5xGQJZj1u1Mzin9LpbcFgHU2k0RGdV3niZUWiY62hAI5UamV3xLmH7+KvQ
	NP1Zlos7LORofP7qyD2yRuZ8PcGixGvYGps029XJFAUD8bOkxiitjoPF1ZpkfVgRrzC1M627a+aTi
	JEfi6f8C7lx+6XFt/6l3NBPvpMXPuIGEgsnBWcfTPgJ8gD7/0m242ocXF5HLdHy98pOU2byoeScJu
	tW4gBHeaAPFx7J96akv1VV3jYUBYc7Xfv1kG87CkoLwqPt8KaY3fiJ+w8walhJBiv6Sy1NS5irP1g
	1AQjkoUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPPjp-0000000Am2w-0uK3;
	Wed, 11 Jun 2025 17:59:49 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPLcO-00000009ygp-31pu
	for kexec@lists.infradead.org;
	Wed, 11 Jun 2025 13:35:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8EA11A51805;
	Wed, 11 Jun 2025 13:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C02C4CEEE;
	Wed, 11 Jun 2025 13:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749648951;
	bh=8X+6Dpb2majUF6w6aZsaAegNKHMP2ANt2g25xsiSY54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2b7VoG4KVqWAF+icCE2Z4hRUFIlu5OHHqYJ3oHZFr4R7WyyXukCtW9n+ox3tMs5a
	 fBKESZmb07rlHHttjx1F4xhBLi+GI/wjGbkMeDrKI9rhP6MkomwzA7VRwrN/QQAcTB
	 18NWQhj68drd91qGaVTUU24Kd4QLQ0SSQPFgT1cJ6yKyOWVUVLiCOwjzZHfDwrTaDu
	 GGefcMkhiQ048C3/8M4NKoKylVohrYJ0mtxNcWkUhJ18XM6qc+9JDpkMF3+lcZz1Wx
	 rGza2+RMTw7fo4GZRCPMqNE5CyCp3I5GFLIh/OIOpSRTDapMEIYZYTexFKBFUE205v
	 1d6RTTMYa8e0A==
Date: Wed, 11 Jun 2025 16:35:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Michal Clapinski <mclapinski@google.com>
Subject: Re: [PATCH] kho: initialize tail pages for higher order folios
 properly
Message-ID: <aEmGMNL9v9djgrGz@kernel.org>
References: <aEKhF3HcrvG77Ogb@kernel.org>
 <mafs0jz5osutx.fsf@kernel.org>
 <aEc30BoLE9HRxiZm@kernel.org>
 <CA+CK2bAAbZjS2Og79xxLcDtNf-eM0up-8fwhd4fg_dp0j_TahA@mail.gmail.com>
 <aEfGTXrsEL5-DuF1@kernel.org>
 <CA+CK2bDXOWzrTsNtbCCK2rabNysf0JFQT5VfAjYrX5oSoiLmSQ@mail.gmail.com>
 <aEhgNU80Dr9iRwoD@kernel.org>
 <CA+CK2bD3n=JDuSsMGvsyMnVbPhGdhdf6zWFDa3KpzRGEXygdgQ@mail.gmail.com>
 <mafs0qzzqo2bg.fsf@kernel.org>
 <CA+CK2bBoMfJuUCV6sL80kwzYPnENnt7fDk2jRMPV0iPn1jCJdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBoMfJuUCV6sL80kwzYPnENnt7fDk2jRMPV0iPn1jCJdw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_063552_885738_17A7CB40 
X-CRM114-Status: GOOD (  37.71  )
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

On Wed, Jun 11, 2025 at 09:14:55AM -0400, Pasha Tatashin wrote:
> On Wed, Jun 11, 2025 at 9:06 AM Pratyush Yadav <pratyush@kernel.org> wrote:
> >
> > On Tue, Jun 10 2025, Pasha Tatashin wrote:
> >
> > >> > > I think it should be the other way around, KHO should depend on
> > >> > > !DEFERRED_STRUCT_PAGE_INIT.
> > >> >
> > >> > Agreed, and this is what I first tried, but that does not work, there
> > >> > is some circular dependency breaking the build. If you feel
> > >> > adventurous you can try that :-)
> > >>
> > >> Hmm, weird, worked for me :/
> >
> > Worked for me as well.
> >
> > >
> > > I am super confused, it did not work for me over weekend, and now it
> > > is working. Even `make menuconfig` would not work. Anyways, I will put
> > > it in the appropriate place.
> > >
> > >>
> > >> > > > We will need to teah KHO to work with deferred struct page init. I
> > >> > > > suspect, we could init preserved struct pages and then skip over them
> > >> > > > during deferred init.
> > >> > >
> > >> > > We could, but with that would mean we'll run this before SMP and it's not
> > >> > > desirable. Also, init_deferred_page() for a random page requires
> > >> >
> > >> > We already run KHO init before smp_init:
> > >> > start_kernel() -> mm_core_init() -> kho_memory_init() ->
> > >> > kho_restore_folio() -> struct pages must be already initialized here!
> > >> >
> > >> > While deferred struct pages are initialized:
> > >> > start_kernel() -> rest_init() -> kernel_init() ->
> > >> > kernel_init_freeable() -> page_alloc_init_late() ->
> > >> > deferred_init_memmap()
> > >> >
> > >> > If the number of preserved pages that is needed during early boot is
> > >> > relatively small, that it should not be an issue to pre-initialize
> > >> > struct pages for them before deferred struct pages are initialized. We
> > >> > already pre-initialize some  "struct pages" that are needed during
> > >> > early boot before the reset are initialized, see deferred_grow_zone()
> > >>
> > >> deferred_grow_zone() takes a chunk in the beginning of uninitialized range,
> > >> with kho we are talking about some random pages. If we preinit them early,
> > >> deferred_init_memmap() will overwrite them.
> > >
> > > Yes, this is why I am saying that we would need to skip the KHO
> > > initialized "struct pages" somehow during deferred initialization. If
> > > we create an ordered by PFN list of early-initialized KHO struct
> > > pages, skipping during deferred initialization could be done
> > > efficiently.
> >
> > Or keep things simple and don't use any KHO struct pages during early
> > init. You can access the page itself, just don't use its struct page.
> >
> > Currently the only user of kho_restore_folio() during init is
> > kho_memory_init(). The FDT is accessed by doing
> > phys_to_virt(kho_in.fdt_phys) anyway, so there is really no need for
> > restoring the folio so early. It can be done later, for example when LUO
> > does the finish event, to clean up and free the folio.
> 
> Good suggestion, however, KHO does not have any sophisticated users
> that we are going to be adding as part of the live update work in the
> future: IR, KVM, early VCPU threads, and so on. So, while today, this
> might work, in the future, I am not sure if we should expect struct
> pages are not accessed until after deferred initialization or simply
> fix it once and for all.

KHO already accesses stuct page early and uses page->private for order.
Since preserved memory is reserved in memblock, deferred init of struct
pages won't touch those pages, we just need to make sure they are properly 
initialized at some point. If we don't expect many kho_restore_folio()
before page_alloc_init_late() we can use init_deferred_page() for early
accesses.
 
> Pasha
> 
> >
> > --
> > Regards,
> > Pratyush Yadav

-- 
Sincerely yours,
Mike.


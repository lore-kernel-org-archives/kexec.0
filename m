Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7790C71137
	for <kexec@archiver.kernel.org>; Wed, 11 Jun 2025 16:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bx+QJSwdqHmxmjJfWKsN6eCcQk7vmKe/DJTvo5pGcrg=; b=y2kLLW1S07YrGKu9jQoBKcNG2f
	D+MOJ6+ha+RjVCipHIfTJ7P6r/RRJELjvoj8T6OmCh1kqGKVTn17huDg/mWZpa0E5gx4kbi2q26mB
	CbQpmJizzwhmVTA7umHPboQnC7+Z8COyYkRigy+m/VxAmG7U+z33LhQ/oJvccKL+8f6Y9CVA6fiy3
	aA9B90djp5ybxMbknebRBE6LVo7ors3z/RPsxl4kbQjPGeJ1KCWKfEhl9/73dgmOL9pWKwMpeOZtI
	gx1ouC3k9BMZj1cNZ0Re7GKYSmin1kP+Q5BUDdy+4au0pvp1e2Z85dufe8cmlWmTdN/R2iXUX/BCS
	eHI9na/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPON5-0000000AcPi-3EA2;
	Wed, 11 Jun 2025 16:32:15 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPLIl-00000009vrg-0Bl8
	for kexec@lists.infradead.org;
	Wed, 11 Jun 2025 13:15:36 +0000
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4a6f0bcdf45so50369441cf.0
        for <kexec@lists.infradead.org>; Wed, 11 Jun 2025 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1749647733; x=1750252533; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx+QJSwdqHmxmjJfWKsN6eCcQk7vmKe/DJTvo5pGcrg=;
        b=pHQum4lfza4F4zGMV4tng0PMLPaKknigv4f0akD0lp0Pqx0Mvj/jrLpDq8Kpgqq4Cx
         8HUpiKb/bf4HTMJFzRf7HPK5vIey7UyfneUNqHmInRAfgUJh0d5MKBceO9cVN3HuP+sK
         A1El2YtC/WvL2vKWZ7ZXcxm+2/dErcTKL6ggfeoWtdi4eCdWHXRSyZjAcMaLCTbD5X0B
         UK3YoyPnSm6fGo5H6X5gk4NxoD5yLph5TCM2pb0alOGyeVMeCksXTJysb5A7NkPes5qQ
         4CALva+xo1kw8C2qAVsG61h34iO0G60jH/E38+A4TbSjcsNX4gaj6RzspprQfudEnMor
         hFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749647733; x=1750252533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx+QJSwdqHmxmjJfWKsN6eCcQk7vmKe/DJTvo5pGcrg=;
        b=dIkdq6F2ZKyEsLjgb24bq+XaMHi1nYhizeve1nDgDm9XIoXjHjiWgtjSLQtmJFYpx+
         eyMi7TJrQHDVA+4H9dP4KGWUCR8a/EM+5ZRlgYjpazJbTtZdMUplBOuR3BZaR6CfZIcX
         7WXDFH2QG8bD3lxoiFfrRGKNNTAK7O6M50THuITX/rmpmzDd4og29Bx3tRCyOTuwXF2o
         ZCYJ59fIjfJ1a/PU6oK1WqzjAVIMBNkm+gmJeLTPvCYOG3zs4Fc/n2pLcYvo5cTbxZOS
         gNJNJbuwHvDvVlWw4UgfJe6GJVhNZ7k3ZOE+U6GmuI0t5yCIBBO0m194OudZdIFAfccJ
         dudw==
X-Forwarded-Encrypted: i=1; AJvYcCVycOJb06lWHLpOjQ7h20LNl0GW8JplyeXZV9pMFVkBdivDApGg+/giQZmlLQabke80tBSGpg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyWsz3H25XeXygmaPyymrFmaVsi00asEIh7t63PdBTo+2FTnhKY
	ugRHToQfEAFGqXr1/AQO96+dp1911rQuVAKuVlRyRwAZ9c56yMfM/rZDUbE2To9JKRfGuLdnDRv
	fZY8yDBZfXJMENVdoR4wN8gPe5pihh6KhvukYAPzoBg==
X-Gm-Gg: ASbGncsNCIzSfKk9CdA5ynpw76HWHl3e6JO9vS8kKA5QCcmO0PQqWGWyugiq95QWSI2
	aRQz5JtF1LhOftEhHjP5QLw2hqAGn7XX21SUgKzXLdnAipd967B9lIS8lUda3UUuDWDiZ41NRMJ
	xjJ2kX17bK22Is9DV5MFJl+0kDq+Yf166cCNnQAwPb
X-Google-Smtp-Source: AGHT+IHkj+/aNhbEvJ86/UIGCIx4gF59E2n+BXlPkeJ7OIUIHWfiwDNSQWWRAB99p0osoYKzpjGZCD42Uxr3WOr2ynM=
X-Received: by 2002:ac8:6904:0:b0:4a3:d015:38ae with SMTP id
 d75a77b69052e-4a714bc0ca3mr46790171cf.23.1749647733254; Wed, 11 Jun 2025
 06:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250605171143.76963-1-pratyush@kernel.org> <aEKhF3HcrvG77Ogb@kernel.org>
 <mafs0jz5osutx.fsf@kernel.org> <aEc30BoLE9HRxiZm@kernel.org>
 <CA+CK2bAAbZjS2Og79xxLcDtNf-eM0up-8fwhd4fg_dp0j_TahA@mail.gmail.com>
 <aEfGTXrsEL5-DuF1@kernel.org> <CA+CK2bDXOWzrTsNtbCCK2rabNysf0JFQT5VfAjYrX5oSoiLmSQ@mail.gmail.com>
 <aEhgNU80Dr9iRwoD@kernel.org> <CA+CK2bD3n=JDuSsMGvsyMnVbPhGdhdf6zWFDa3KpzRGEXygdgQ@mail.gmail.com>
 <mafs0qzzqo2bg.fsf@kernel.org>
In-Reply-To: <mafs0qzzqo2bg.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 11 Jun 2025 09:14:55 -0400
X-Gm-Features: AX0GCFvQtpuz31GBIWBQSIsnOG-xC0O1tIo1gpevWjl4XB1iep4R0wvTpWnG7zw
Message-ID: <CA+CK2bBoMfJuUCV6sL80kwzYPnENnt7fDk2jRMPV0iPn1jCJdw@mail.gmail.com>
Subject: Re: [PATCH] kho: initialize tail pages for higher order folios properly
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Changyuan Lyu <changyuanl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_061535_170576_59D21680 
X-CRM114-Status: GOOD (  32.11  )
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

On Wed, Jun 11, 2025 at 9:06=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Tue, Jun 10 2025, Pasha Tatashin wrote:
>
> >> > > I think it should be the other way around, KHO should depend on
> >> > > !DEFERRED_STRUCT_PAGE_INIT.
> >> >
> >> > Agreed, and this is what I first tried, but that does not work, ther=
e
> >> > is some circular dependency breaking the build. If you feel
> >> > adventurous you can try that :-)
> >>
> >> Hmm, weird, worked for me :/
>
> Worked for me as well.
>
> >
> > I am super confused, it did not work for me over weekend, and now it
> > is working. Even `make menuconfig` would not work. Anyways, I will put
> > it in the appropriate place.
> >
> >>
> >> > > > We will need to teah KHO to work with deferred struct page init.=
 I
> >> > > > suspect, we could init preserved struct pages and then skip over=
 them
> >> > > > during deferred init.
> >> > >
> >> > > We could, but with that would mean we'll run this before SMP and i=
t's not
> >> > > desirable. Also, init_deferred_page() for a random page requires
> >> >
> >> > We already run KHO init before smp_init:
> >> > start_kernel() -> mm_core_init() -> kho_memory_init() ->
> >> > kho_restore_folio() -> struct pages must be already initialized here=
!
> >> >
> >> > While deferred struct pages are initialized:
> >> > start_kernel() -> rest_init() -> kernel_init() ->
> >> > kernel_init_freeable() -> page_alloc_init_late() ->
> >> > deferred_init_memmap()
> >> >
> >> > If the number of preserved pages that is needed during early boot is
> >> > relatively small, that it should not be an issue to pre-initialize
> >> > struct pages for them before deferred struct pages are initialized. =
We
> >> > already pre-initialize some  "struct pages" that are needed during
> >> > early boot before the reset are initialized, see deferred_grow_zone(=
)
> >>
> >> deferred_grow_zone() takes a chunk in the beginning of uninitialized r=
ange,
> >> with kho we are talking about some random pages. If we preinit them ea=
rly,
> >> deferred_init_memmap() will overwrite them.
> >
> > Yes, this is why I am saying that we would need to skip the KHO
> > initialized "struct pages" somehow during deferred initialization. If
> > we create an ordered by PFN list of early-initialized KHO struct
> > pages, skipping during deferred initialization could be done
> > efficiently.
>
> Or keep things simple and don't use any KHO struct pages during early
> init. You can access the page itself, just don't use its struct page.
>
> Currently the only user of kho_restore_folio() during init is
> kho_memory_init(). The FDT is accessed by doing
> phys_to_virt(kho_in.fdt_phys) anyway, so there is really no need for
> restoring the folio so early. It can be done later, for example when LUO
> does the finish event, to clean up and free the folio.

Good suggestion, however, KHO does not have any sophisticated users
that we are going to be adding as part of the live update work in the
future: IR, KVM, early VCPU threads, and so on. So, while today, this
might work, in the future, I am not sure if we should expect struct
pages are not accessed until after deferred initialization or simply
fix it once and for all.

Pasha

>
> --
> Regards,
> Pratyush Yadav


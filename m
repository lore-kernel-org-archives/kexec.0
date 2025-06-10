Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01B0C5B552
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 15:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hr6vkvNJmo2xkK9euicJYSo2Erx9EUnaEaDLPPm5ZFw=; b=uh69zfEM5/eljodsuRDcQupBYW
	jTaqPK81XfVyUcLGyVc4diYuWvldvttQ0E64VF9jwMJDk7L28v8m4+8oUXmbGXPAlF3DCW7kQ6ZGE
	7OY1lUvfZ2FpGRUv2IUfS0ETgC/l8x2unf0bbqcuZ97w9CtSetskc5fCoNDe/YMv40Wjo3k4+n07D
	fivSlYYVpx5MWAIzY+PsPCiSZDhf923pyNnwKDppNWAELt9NegAjbGhdGtZ6YRcxrPnxFJUYNvBSk
	oOwFhvhanbBvSWIZNXYtAQp2AcsAZEUU/N/htdrgz/kiu2K/fVPf2ZtnxGN5Qju3e9dCOLnDM/L/b
	QaQJrQRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP0pS-00000007II2-3ZNC;
	Tue, 10 Jun 2025 15:23:58 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOx2M-00000006dfm-2qLq
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 11:21:04 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4a5903bceffso68531761cf.3
        for <kexec@lists.infradead.org>; Tue, 10 Jun 2025 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1749554461; x=1750159261; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hr6vkvNJmo2xkK9euicJYSo2Erx9EUnaEaDLPPm5ZFw=;
        b=z3BsbFl3O/qUUINL4ks80lH9Nk/wLgH3O0fcSG3mhpA3hN2uj/0bLXGKZSkszJutXn
         TnYNIIIwxegyJteBtIJRlBUPGN/UMhWXj3W8hmIR/kEaKS+zQqHuXGqJV4ryjA7cjsv3
         w/tmu6cfj3jCD2DMIz0DlV7xhT4ipY0s7q6rUsCd/mSE6uKIcJuzOlM52vUExtc1VvMG
         zzvtJuJqQ76dD40y5QWH3oxNh+iziSJeiRKNK+55KsznR6pys8YnzSKaUjSpjgpkbcF1
         iNDslJQO0kpPyELQ5P/DeAYeReAhwqbo53rja51yxT+9uUzHzA2xjAtwYAPU0KyYl2sE
         sHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749554461; x=1750159261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hr6vkvNJmo2xkK9euicJYSo2Erx9EUnaEaDLPPm5ZFw=;
        b=WbNN1lDusuErACAo6ZcTQCrRNKkhuKBuPwgSzspi6EW2MY2pm3U+l/oTiBPpIzdCFI
         K6Bm1OvbIRAI7aJFQ/10S2X4V7cym69VNGs9yXbI8ghYTbVSrWIp4odHNmy5+ys94nsR
         cPZ8gRbVjy20A6WFd96Hm/khHcbNX/ox+gr/UsPhmTzTVY0wg6D2eAQ3zMkrUkk2Vi9f
         oLYkinir9tqQ0TUTsGYL2pnvrkzjxU7aLm46y0oqOvtOVgAs46PK8KXFL5KJ4TlPgJYc
         h8+y47DqiOm6ie6ipaI1Rh3F5jJyVIDVuX+9qety/Tnm0zCylz7BaFD/FZvjey5bu0U/
         k8tA==
X-Forwarded-Encrypted: i=1; AJvYcCXnpOZv2AuK32AOxIfr+QB9pIwRR8p/cPjaBEnqOAJExuCwwAva7o4d5wZ1Y7DWERhW6m3c9Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YzeSYFOhre2aBnsbdU7IUvSYO51JYaSUcQUa7X53WPEpmF5f4EB
	IFHfLVUA0ATe8rdaS6twIGI1fpgSJ/lRH96wm18KYZfW5Fp5zjgZHMg33z2jV96EAHc0rDPE+ZH
	U6w/QBOWft6bY5LVZ60BPPlhLvcikFRLae9AJ3YK0tQ==
X-Gm-Gg: ASbGncseoPdijj9gYyDKTLtMTgwOBkinKu0trwKPwIcrr1OQ6RRMFj3pmJ/hu097xfF
	mIZvoBu1khW8jGrbPPwZwNIA/i6WURmqqf7NWzdQKxTAIC/gotKwYaj8PceoOLuRbeayHH6iV6g
	gOjaeHZC/5QF4G5w5lwbFDia/BEfTz/OhXq1bt12w/
X-Google-Smtp-Source: AGHT+IEYByUVl/yepIaYoB2uxlybeMfdVCnOM2tCCnTwmK/gNk4T3vDFpOGjgIevx5sWAC+4GR5rpfJ+v3CSPkSnqY4=
X-Received: by 2002:a05:622a:4d87:b0:4a4:39a6:93d6 with SMTP id
 d75a77b69052e-4a5b9dec472mr350827001cf.52.1749554461120; Tue, 10 Jun 2025
 04:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250605171143.76963-1-pratyush@kernel.org> <aEKhF3HcrvG77Ogb@kernel.org>
 <mafs0jz5osutx.fsf@kernel.org> <aEc30BoLE9HRxiZm@kernel.org>
 <CA+CK2bAAbZjS2Og79xxLcDtNf-eM0up-8fwhd4fg_dp0j_TahA@mail.gmail.com> <aEfGTXrsEL5-DuF1@kernel.org>
In-Reply-To: <aEfGTXrsEL5-DuF1@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 10 Jun 2025 07:20:23 -0400
X-Gm-Features: AX0GCFuL7c_RAoZ4ZCdyX1YlCD0SjPG2cCCnRF6R-Ws5F5HXOirJt-HVRYtvgUQ
Message-ID: <CA+CK2bDXOWzrTsNtbCCK2rabNysf0JFQT5VfAjYrX5oSoiLmSQ@mail.gmail.com>
Subject: Re: [PATCH] kho: initialize tail pages for higher order folios properly
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Changyuan Lyu <changyuanl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_042102_802919_B2202501 
X-CRM114-Status: GOOD (  43.12  )
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

On Tue, Jun 10, 2025 at 1:44=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Mon, Jun 09, 2025 at 04:07:50PM -0400, Pasha Tatashin wrote:
> > On Mon, Jun 9, 2025 at 3:36=E2=80=AFPM Mike Rapoport <rppt@kernel.org> =
wrote:
> > >
> > > Hi Pratyush,
> > >
> > > On Fri, Jun 06, 2025 at 06:23:06PM +0200, Pratyush Yadav wrote:
> > > > Hi Mike,
> > > >
> > > > On Fri, Jun 06 2025, Mike Rapoport wrote:
> > > >
> > > > > On Thu, Jun 05, 2025 at 07:11:41PM +0200, Pratyush Yadav wrote:
> > > > >> From: Pratyush Yadav <ptyadav@amazon.de>
> > > > >>
> > > > >> --- a/kernel/kexec_handover.c
> > > > >> +++ b/kernel/kexec_handover.c
> > > > >> @@ -157,11 +157,21 @@ static int __kho_preserve_order(struct kho=
_mem_track *track, unsigned long pfn,
> > > > >>  }
> > > > >>
> > > > >>  /* almost as free_reserved_page(), just don't free the page */
> > > > >> -static void kho_restore_page(struct page *page)
> > > > >> +static void kho_restore_page(struct page *page, unsigned int or=
der)
> > > > >>  {
> > > > >> -  ClearPageReserved(page);
> > > > >
> > > > > So now we don't clear PG_Reserved even on order-0 pages? ;-)
> > > >
> > > > We don't need to. As I mentioned in the commit message as well,
> > > > PG_Reserved is never set for KHO pages since they are reserved with
> > > > MEMBLOCK_RSRV_NOINIT, so memmap_init_reserved_pages() skips over th=
em.
> > >
> > > You are right, I missed it.
> > >
> > > > That said, while reading through some of the code, I noticed anothe=
r
> > > > bug: because KHO reserves the preserved pages as NOINIT, with
> > > > CONFIG_DEFERRED_STRUCT_PAGE_INIT =3D=3D n, all the pages get initia=
lized
> > > > when memmap_init_range() is called from setup_arch (paging_init() o=
n
> > > > x86). This happens before kho_memory_init(), so the KHO-preserved p=
ages
> > > > are not marked as reserved to memblock yet.
> > > >
> > > > With deferred page init, some pages might not get initialized early=
, and
> > > > get initialized after kho_memory_init(), by which time the KHO-pres=
erved
> > > > pages are marked as reserved. So, deferred_init_maxorder() will ski=
p
> > > > over those pages and leave them uninitialized.
> > > >
> > > > So we need to either also call init_deferred_page(), or remove the
> > > > memblock_reserved_mark_noinit() call in deserialize_bitmap(). And T=
BH, I
> > > > am not sure why KHO pages even need to be marked noinit in the firs=
t
> > > > place. Probably the only benefit would be if a large chunk of memor=
y is
> > > > KHO-preserved, the pages can be initialized later on-demand, reduci=
ng
> > > > bootup time a bit.
> > >
> > > One benefit is performance indeed, because in not deferred case the
> > > initialization of reserved pages in memmap_init_reserved_pages() is r=
eally
> > > excessive.
> > >
> > > But more importantly, if we remove memblock_reserved_mark_noinit(), w=
ith
> > > CONFIG_DEFERRED_STRUCT_PAGE_INIT we'd loose page->private because the
> > > struct page will be cleared after kho_mem_deserialize().
> > >
> > > > What do you think? Should we drop noinit or call init_deferred_page=
()?
> > > > FWIW, my preference is to drop noinit, since init_deferred_page() i=
s
> > > > __meminit and we would have to make sure it doesn't go away after b=
oot.
> > >
> > > We can't drop noinit and calling init_deferred_page() after boot just=
 won't
> > > work because it uses memblock to find the page's node and memblock is=
 gone
> > > after init.
> > >
> > > The simplest short-term solution is to disable KHO when
> > > CONFIG_DEFERRED_STRUCT_PAGE_INIT is set and then find an efficient wa=
y to
> > > make it all work together.
> >
> > This is what I've done in LUOv3 WIP:
> > https://github.com/soleen/linux/commit/3059f38ac0a39a397873759fb429bd5d=
1f8ea681
>
> I think it should be the other way around, KHO should depend on
> !DEFERRED_STRUCT_PAGE_INIT.

Agreed, and this is what I first tried, but that does not work, there
is some circular dependency breaking the build. If you feel
adventurous you can try that :-)

> > We will need to teah KHO to work with deferred struct page init. I
> > suspect, we could init preserved struct pages and then skip over them
> > during deferred init.
>
> We could, but with that would mean we'll run this before SMP and it's not
> desirable. Also, init_deferred_page() for a random page requires

We already run KHO init before smp_init:
start_kernel() -> mm_core_init() -> kho_memory_init() ->
kho_restore_folio() -> struct pages must be already initialized here!

While deferred struct pages are initialized:
start_kernel() -> rest_init() -> kernel_init() ->
kernel_init_freeable() -> page_alloc_init_late() ->
deferred_init_memmap()

If the number of preserved pages that is needed during early boot is
relatively small, that it should not be an issue to pre-initialize
struct pages for them before deferred struct pages are initialized. We
already pre-initialize some  "struct pages" that are needed during
early boot before the reset are initialized, see deferred_grow_zone()

Pasha


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8086BF99351
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 08:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AnqwNiNmBE870TAbn0m3IWi2wJAeU1ScdF9aKm0HDwQ=; b=RyNDmo0dA9R7fuqrW1852NgpKL
	/iTm3MmH5p0bA+Xsqv4e4ZDC7IgE5XFi+a95YLnOXLXhD/FerYJpaF2PquKFklJRlpoXflzqrogAl
	9qq9lCIcuCgIvTrbZ31pV5+j6/1yAcur2PPRV0Hlt0iCnrkSyWQgIpw/QuVawduHJYY1z2t+zRs+a
	oIpVNae9y7VfKvNznNefpj9saKgVKxgLrGk8LlHJwjFSTMhZbJEgFODFBf0EF9zHGT6Juzz8HH56O
	sIUNbGGuleiG6Vkaj+3aK/0wkcA4HGOzPRAmCjqoyqdod5r53ThqJHBGg5Q+qUaCsnCooqQcIUnnk
	hyqE52Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFpci-0000000BGPR-2eRd;
	Thu, 23 Apr 2026 08:41:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFpcb-0000000BGPK-2BcY
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 08:41:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 40BA56001A;
	Thu, 23 Apr 2026 08:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E55C2BCAF;
	Thu, 23 Apr 2026 08:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776933676;
	bh=/o3cyhlI3NGUpyx7vDlXkXGS/7l1clLahFR6qWl4Ock=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FLcJUqE+7zBvDxLageLu5YyUTMj8lC6wE1/M26SxjfptjMSqgpGlxLccHjh9YvSfp
	 xROm9gPXfErHIJqvFx7WN5jD0HzoO6HV2MAvppfFxyImKdMvwg7pD53cfEeVFMfCOQ
	 KoUcxtirs9rs8z16YYzzGjoGKHUieLX/lYMD9d/bC02bXJvc3rPvuuQPMLeBMYyMxS
	 ggdyxIp2HIOkR5Sp4Z07wdEHzERvLKpLEi4hkeBxkD5as4nDON3vElkI5QmDQBDtaQ
	 wzooCPgouNEtEDgXKs0uKi7/QxUY7Dnq4PdufvO9fyPjDRIeXY/LBxiDJblPV+xob5
	 MJLJICKdkYybw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
  Evangelos Petrongonas
 <epetron@amazon.de>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Samiullah Khawaja <skhawaja@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Vlastimil Babka <vbabka@kernel.org>,  Suren
 Baghdasaryan <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,
  Brendan Jackman <jackmanb@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v8 1/2] kho: fix deferred initialization of scratch areas
In-Reply-To: <aeiFx8tilasoGzwa@kernel.org> (Mike Rapoport's message of "Wed,
	22 Apr 2026 11:24:39 +0300")
References: <20260416110654.247398-1-mclapinski@google.com>
	<20260416110654.247398-2-mclapinski@google.com>
	<aeD2Fzr6yr4pu9-X@kernel.org>
	<CAAi7L5d-ujEa7R21Lmd37X9451KBmK8ZhagSKbJde15aQLi2MQ@mail.gmail.com>
	<aeEKksfLxQ0A7Jun@kernel.org>
	<CAAi7L5cp3B0DFEQex5EqFdLDkqVWwRw228-pgp0PnhfgLP=e6Q@mail.gmail.com>
	<aecUW-Xgm5MPMyVr@kernel.org>
	<CAAi7L5d8x1MB1f6A_h2acj1CYU1wf7DijS1TENC+Lurx5wLhKw@mail.gmail.com>
	<aeiFx8tilasoGzwa@kernel.org>
Date: Thu, 23 Apr 2026 10:41:11 +0200
Message-ID: <2vxzqzo65as8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 22 2026, Mike Rapoport wrote:

> On Tue, Apr 21, 2026 at 12:20:27PM +0200, Micha=C5=82 C=C5=82api=C5=84ski=
 wrote:
>> On Tue, Apr 21, 2026 at 8:08=E2=80=AFAM Mike Rapoport <rppt@kernel.org> =
wrote:
>> >
>> > On Mon, Apr 20, 2026 at 03:11:03PM +0200, Micha=C5=82 C=C5=82api=C5=84=
ski wrote:
>> > > On Thu, Apr 16, 2026 at 6:13=E2=80=AFPM Mike Rapoport <rppt@kernel.o=
rg> wrote:
>> > > >
>> > > > On Thu, Apr 16, 2026 at 05:06:10PM +0200, Micha=C5=82 C=C5=82api=
=C5=84ski wrote:
>> > > > > On Thu, Apr 16, 2026 at 4:45=E2=80=AFPM Mike Rapoport <rppt@kern=
el.org> wrote:
>> > > > > >
>> > > > > > Hi Michal,
>> > > > > >
>> > > > > > On Thu, Apr 16, 2026 at 01:06:53PM +0200, Michal Clapinski wro=
te:
>> > > > > > > @@ -2262,6 +2253,12 @@ static void __init memmap_init_reserv=
ed_range(phys_addr_t start,
>> > > > > > >                * access it yet.
>> > > > > > >                */
>> > > > > > >               __SetPageReserved(page);
>> > > > > > > +
>> > > > > > > +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
>> > > > > >
>> > > > > > No need for #ifdef here, there's a stub returning false for
>> > > > > > CONFIG_MEMBLOCK_KHO_SCRATCH=3Dn case.
>> > > > >
>> > > > > In all 3 places the #ifdef is there because MIGRATE_CMA might be
>> > > > > undefined. I already broke mm-new branch in the past because of =
that.
>> > > >
>> > > > Hmm, that hurts :/
>> > > >
>> > > > The best I can think of is to add a static inline in memblock.h an=
d ifdefs
>> > > > around it.
>> > >
>> > > Sorry, I don't understand what you mean. What would that static inli=
ne contain?
>> >
>> > Something like this:
>> >
>> > #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
>> > static inline enum migratetype kho_scratch_migratetype(unsigned long p=
fn,
>> >                                                        enum migratetyp=
e mt)
>> > {
>> >         if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)))
>> >                 return MIGRATE_CMA
>> >         return mt;
>> > }
>> > #else
>> > static inline enum migratetype kho_scratch_migratetype(unsigned long p=
fn,
>> >                                                        enum migratetyp=
e mt)
>> > {
>> >         return mt;
>> > }
>> > #endif
>>=20
>> How would I use it for this code?
>>=20
>> +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
>> +             if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)) &&
>> +                 pageblock_aligned(pfn))
>> +                     init_pageblock_migratetype(page, MIGRATE_CMA, fals=
e);
>> +#endif
>
> Something like this
>
> 		enum migratetype mt =3D kho_scratch_migratetype(pfn, MIGRATE_MOVABLE);
>
> 	        ...
>
> 		if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)) &&
> 		    pageblock_aligned(pfn))=20
> 			init_pageblock_migratetype(page, mt, false);

You can optimize this a tiny bit by doing something like this:

	if (pageblock_aligned(pfn)) {
		enum migratetype mt =3D kho_scratch_migratetype(pfn, MIGRATE_MOVABLE);

		init_pageblock_migratetype(page, mt, false);
	}

The kho_scratch_migratetype() you suggested already calls
memblock_is_kho_scratch_memory() so no need to duplicate the search.
Plus, this way this only executes for each pageblock instead for each
page.

>
> seems better to me than ifdef, even though MIGRATE_MOVABLE is bogus here.
>
> And since we anyway changing init_pageblock_migratetype() callers in
> mm_init.c the entire block in memmap_init_reserved_range() can be dropped
> and the change can be done in __init_page_from_nid().
>
>>=20
>> It doesn't invoke init_pageblock_migratetype unless pfn is kho scratch.
>>=20
>> > Can't say I'm happy about the name, but could not think of something
>> > better.
>> >
>> > > > > > > +             if (memblock_is_kho_scratch_memory(PFN_PHYS(pf=
n)) &&
>> > > > > > > +                 pageblock_aligned(pfn))
>> > > > > > > +                     init_pageblock_migratetype(page, MIGRA=
TE_CMA, false);
>> > > > > > > +#endif
>> > > > > > >       }
>> > > > > > >  }
>> > > >
>> > > > --
>> > > > Sincerely yours,
>> > > > Mike.
>> >
>> > --
>> > Sincerely yours,
>> > Mike.

--=20
Regards,
Pratyush Yadav


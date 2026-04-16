Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F29F8D759
	for <kexec@archiver.kernel.org>; Thu, 16 Apr 2026 15:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=45BgfgnYSvNFM3E5UxQrEO2kHNtJ//4sETpS6wYzv3E=; b=TV0pLs2MQA9aldjusOBSdMcgn0
	N4IS21mwHz4fXI77iKozY+MgEkaOgMKbr6m8JsgKL6rpDkaO5Sc1Mrt0HaCFEQwmgAG6iQ6J/oyLN
	09aZ128Bb8lr83M7fkNcNsmHZgRN3k8A7/8kwNjTheGy78SDAcrrVfZYf5ADPHEPQWkfG7JY0ESi6
	cA8c3V3KkXzkhIC+YzHsaJMVufh++Z7Jq49tdaKwhtGQY5yUI+w9N+I8Nnv8Qx10Xc/bx3sHovJuo
	EFXjNJ6xBMgmc8PqaSpY4PwRsv7IPp+siePOx/sWWPzBMdE+sEw6BAMEVeXx+ZnWZLQpGgXg16QpM
	eUd/pKZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDOIW-00000002b7u-1Q88;
	Thu, 16 Apr 2026 15:06:28 +0000
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDOIT-00000002b6y-2xSx
	for kexec@lists.infradead.org;
	Thu, 16 Apr 2026 15:06:27 +0000
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-1270fc2bdf2so7788c88.0
        for <kexec@lists.infradead.org>; Thu, 16 Apr 2026 08:06:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776351984; cv=none;
        d=google.com; s=arc-20240605;
        b=LtAF8H8/ce1J/bmrydN9Ohh3uYBdkIJjbiBY6OQfIKbLvvF665Kia3Zmv+Xki1nWeJ
         Cgp5DnaS+UxCJ2/U6h8Nxymp+dj/QkMPdU/HPc3p2Y4uQ4RwuQB2rxlN+JgFoustIKPm
         11/vJ/19yqy9881NWQKtZQx5sErnJfW51yaTyyqALw26E6esPAfixfX94STX5z9UN1hc
         Vq3100vRwUn4ZRgQZ96f9Zv2tKwZ7P3He9MBaMYpnjqW5ojsNrDn2jj3rpOd3RqUR3hd
         hKoAlVa46OkONf6aCYgW2FrlIOmou8q8dqRSWCEoTHEAtDfNbB9GW2xjLGfg/x0YIkeu
         tXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=45BgfgnYSvNFM3E5UxQrEO2kHNtJ//4sETpS6wYzv3E=;
        fh=ICt7x/e2HcupwQz9sg4U5RRc1KNwuzvEDTpFvQYT1Xc=;
        b=b/Adu6EzetMSrmt5rbEqSFck31/9gzEuU24tBoQF1OfvLFPx/1C3cKH8hkdR6hRumY
         16jEIwJYEeqoUkad1dNEq9mwUR73JyXDIofSaIuFqxW9wSNoBZPfzL6d1PysaKd0clbw
         1LWAMe8HMWo7Q5y5ILkmEgGq82b+CHvlBdzDkqTxFEcYEmmgtIH43KJcsb47t+1W55CC
         13urd8EHUcRwSMExY7n5FVMov+PDd79ZzkgRSZ1/zDgP3IjtOrSP6UkbLpGfJ4hOQ13K
         Jx9NXR7AiEeauYGy0B9pLziphKU9JKLL/5NK8/8yxTeVpF7GiyaNuB0PYoTRsD/oh0eh
         HPZg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776351984; x=1776956784; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45BgfgnYSvNFM3E5UxQrEO2kHNtJ//4sETpS6wYzv3E=;
        b=EXFxtZrC5MGbP6u4o2OYZuo/FkArRP9Nzve+Com0rRNQz+hzX/BYiIs9LqOEzX9KNs
         MioAedlyCvjui+DFwSnnjmZ0mT4AsMCOOBXwe8eQjBmk9qsfpnBT3Tkuhq1CeXG35rUJ
         HkSlcqtyguGt8UuinSMBJXy/DED0K10wxy1LXwJRtP7V6fdmCPbVRHQNPNcJ1gmCfd2V
         EgYgX8wCHEiF5c0cWk5FHX3WEJeRim+gp9kSNEw7KRWt7ZgchMmiD6A0D15lC1SltaqG
         kXqRWMo58GYh3tigReFQrWemKAESxtg5+/EUecqtNV1aZZMc6MvlOYRpqcCMfQ60sv0N
         onYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776351984; x=1776956784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=45BgfgnYSvNFM3E5UxQrEO2kHNtJ//4sETpS6wYzv3E=;
        b=UZ20+gbbf2xEsGDmlgyVzJQ9SjnPf87T1HVIb9vIL1it1KbgZTuQmq8XpxMS0jwB9Y
         veskHikBMzr7Ys0psk/fF0c923B4RtN2R/IOH5mw24h1Y4pRis65wW7sOWNb//rqNAjU
         3gOSvE4gnphVxI9GijfyzxfnGDx7Ex5U5D4o5czC/j5Jz4fjIfCBNz7f5mFrs64iN74u
         4d/6060hIJ+kq1R6hME34jojloaaHd5VzwVQs7Ncw2D6FIEH3509RbFKPxfOBfIME9Kw
         yfzFxUwdPFn6xkNDq2Tnlbzfj5OlAMabGNWPUsrcte2XZn60wuxpUDDZhg95eRC1iusT
         9epw==
X-Forwarded-Encrypted: i=1; AFNElJ9BeGO9zwWt4ODmq3ew3KhOMPeZtEFif+5BHo01NHI1v6JGPIWp2wGKGTy5YOmfW87c9Jhyxg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6xatVMjZgMle841PrANx6rxuRQQ+V+9ge8JReB0rm9TmyBQJf
	eTQaGFF6vtsQ+UcmjlYCmKoD/flY+JNoVFJYWRE3IBuq/UHfpxmNrWFM0AMrtgGaTbRGI1PqSYc
	Ndz3O4xhuUUDVHEGO1KM0KtC/4r2ByF9IRRf902Z0
X-Gm-Gg: AeBDiesXrgYSZ3JX/9bOrMHLqz4htpU8kyBBJDdYrI9pNDZyGZsuVl6G0xbC+xov9e1
	eLjOkaiIJ22bmJFf9VjZsl4zfCC8n4NOQYn7G1s8XYMs19SBAEbcP4iLgC/j+F2oh17VGmp2u4i
	lwXfXe2xKm7tjrtRzbwFC3SXc3ecWZdOejpFH3y+wse3NfGBRivTthigE9heEWjnLn6V9jucLVv
	hmLSkajjoCUzvpOq1BmtaB7OoK9QRqsRv2jbSaYIP5GnJt3r9TVZsXhUVl50TkArHEGg6/8kDF+
	Mv7h5bsfR2PQatP/kmNGD4jiJ77L06undRTsxFRMAL5yeePZIxeQFI5N+8A=
X-Received: by 2002:a05:7022:6081:b0:12a:77e6:68d9 with SMTP id
 a92af1059eb24-12c6376e195mr157713c88.16.1776351982854; Thu, 16 Apr 2026
 08:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260416110654.247398-1-mclapinski@google.com>
 <20260416110654.247398-2-mclapinski@google.com> <aeD2Fzr6yr4pu9-X@kernel.org>
In-Reply-To: <aeD2Fzr6yr4pu9-X@kernel.org>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Thu, 16 Apr 2026 17:06:10 +0200
X-Gm-Features: AQROBzARF615Kab2e80dancapvA5l6qTAyjo5RjoXtClPQ7kr5-X60F2Yw6i9FE
Message-ID: <CAAi7L5d-ujEa7R21Lmd37X9451KBmK8ZhagSKbJde15aQLi2MQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] kho: fix deferred initialization of scratch areas
To: Mike Rapoport <rppt@kernel.org>
Cc: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_080625_752975_65F1BBD0 
X-CRM114-Status: GOOD (  34.32  )
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

On Thu, Apr 16, 2026 at 4:45=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Hi Michal,
>
> On Thu, Apr 16, 2026 at 01:06:53PM +0200, Michal Clapinski wrote:
> > Currently, if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled,
> > kho_release_scratch() will initialize the struct pages and set migratet=
ype
> > of KHO scratch. Unless the whole scratch fits below first_deferred_pfn,
> > some of that will be overwritten either by deferred_init_pages() or
> > memmap_init_reserved_range().
> >
> > To fix it, make memmap_init_range(), deferred_init_memmap_chunk() and
> > memmap_init_reserved_range() recognize KHO scratch regions and set
> > migratetype of pageblocks in those regions to MIGRATE_CMA.
> >
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>
> Your signed-off should be last here :)
> https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked=
-by-cc-and-co-developed-by
>
> > ---
> >  include/linux/memblock.h           |  7 +++--
> >  kernel/liveupdate/kexec_handover.c | 25 ------------------
> >  mm/memblock.c                      | 41 ++++++++++++++----------------
> >  mm/mm_init.c                       | 27 ++++++++++++++------
> >  4 files changed, 43 insertions(+), 57 deletions(-)
> >
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index 6ec5e9ac0699..410f2a399691 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -614,11 +614,14 @@ static inline void memtest_report_meminfo(struct =
seq_file *m) { }
> >  #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
> >  void memblock_set_kho_scratch_only(void);
> >  void memblock_clear_kho_scratch_only(void);
> > -void memmap_init_kho_scratch_pages(void);
> > +bool memblock_is_kho_scratch_memory(phys_addr_t addr);
> >  #else
> >  static inline void memblock_set_kho_scratch_only(void) { }
> >  static inline void memblock_clear_kho_scratch_only(void) { }
> > -static inline void memmap_init_kho_scratch_pages(void) {}
> > +static inline bool memblock_is_kho_scratch_memory(phys_addr_t addr)
> > +{
> > +     return false;
> > +}
> >  #endif
> >
> >  #endif /* _LINUX_MEMBLOCK_H */
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index 18509d8082ea..a507366a2cf9 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -1576,35 +1576,10 @@ static __init int kho_init(void)
> >  }
> >  fs_initcall(kho_init);
> >
> > -static void __init kho_release_scratch(void)
> > -{
> > -     phys_addr_t start, end;
> > -     u64 i;
> > -
> > -     memmap_init_kho_scratch_pages();
> > -
> > -     /*
> > -      * Mark scratch mem as CMA before we return it. That way we
> > -      * ensure that no kernel allocations happen on it. That means
> > -      * we can reuse it as scratch memory again later.
> > -      */
> > -     __for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> > -                          MEMBLOCK_KHO_SCRATCH, &start, &end, NULL) {
> > -             ulong start_pfn =3D pageblock_start_pfn(PFN_DOWN(start));
> > -             ulong end_pfn =3D pageblock_align(PFN_UP(end));
> > -             ulong pfn;
> > -
> > -             for (pfn =3D start_pfn; pfn < end_pfn; pfn +=3D pageblock=
_nr_pages)
> > -                     init_pageblock_migratetype(pfn_to_page(pfn),
> > -                                                MIGRATE_CMA, false);
> > -     }
> > -}
> > -
> >  void __init kho_memory_init(void)
> >  {
> >       if (kho_in.scratch_phys) {
> >               kho_scratch =3D phys_to_virt(kho_in.scratch_phys);
> > -             kho_release_scratch();
> >
> >               if (kho_mem_retrieve(kho_get_fdt()))
> >                       kho_in.fdt_phys =3D 0;
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 4224fdaa8918..fab234f732c3 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/memblock.h>
> >  #include <linux/mutex.h>
> > +#include <linux/page-isolation.h>
> >
> >  #ifdef CONFIG_KEXEC_HANDOVER
> >  #include <linux/libfdt.h>
> > @@ -959,28 +960,6 @@ __init void memblock_clear_kho_scratch_only(void)
> >  {
> >       kho_scratch_only =3D false;
> >  }
> > -
> > -__init void memmap_init_kho_scratch_pages(void)
> > -{
> > -     phys_addr_t start, end;
> > -     unsigned long pfn;
> > -     int nid;
> > -     u64 i;
> > -
> > -     if (!IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
> > -             return;
> > -
> > -     /*
> > -      * Initialize struct pages for free scratch memory.
> > -      * The struct pages for reserved scratch memory will be set up in
> > -      * memmap_init_reserved_pages()
> > -      */
> > -     __for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> > -                          MEMBLOCK_KHO_SCRATCH, &start, &end, &nid) {
> > -             for (pfn =3D PFN_UP(start); pfn < PFN_DOWN(end); pfn++)
> > -                     init_deferred_page(pfn, nid);
> > -     }
> > -}
> >  #endif
> >
> >  /**
> > @@ -1971,6 +1950,18 @@ bool __init_memblock memblock_is_map_memory(phys=
_addr_t addr)
> >       return !memblock_is_nomap(&memblock.memory.regions[i]);
> >  }
> >
> > +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
> > +bool __init_memblock memblock_is_kho_scratch_memory(phys_addr_t addr)
>
> We already have a block under #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH, please
> add this function to that block.
>
> > +{
> > +     int i =3D memblock_search(&memblock.memory, addr);
> > +
> > +     if (i =3D=3D -1)
> > +             return false;
> > +
> > +     return memblock_is_kho_scratch(&memblock.memory.regions[i]);
> > +}
> > +#endif
> > +
> >  int __init_memblock memblock_search_pfn_nid(unsigned long pfn,
> >                        unsigned long *start_pfn, unsigned long *end_pfn=
)
> >  {
> > @@ -2262,6 +2253,12 @@ static void __init memmap_init_reserved_range(ph=
ys_addr_t start,
> >                * access it yet.
> >                */
> >               __SetPageReserved(page);
> > +
> > +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
>
> No need for #ifdef here, there's a stub returning false for
> CONFIG_MEMBLOCK_KHO_SCRATCH=3Dn case.

In all 3 places the #ifdef is there because MIGRATE_CMA might be
undefined. I already broke mm-new branch in the past because of that.

> > +             if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)) &&
> > +                 pageblock_aligned(pfn))
> > +                     init_pageblock_migratetype(page, MIGRATE_CMA, fal=
se);
> > +#endif
> >       }
> >  }
> >
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index f9f8e1af921c..890c3ae21ba0 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -916,8 +916,15 @@ void __meminit memmap_init_range(unsigned long siz=
e, int nid, unsigned long zone
> >                * over the place during system boot.
> >                */
> >               if (pageblock_aligned(pfn)) {
> > -                     init_pageblock_migratetype(page, migratetype,
> > -                                     isolate_pageblock);
> > +                     int mt =3D migratetype;
> > +
> > +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
>
> Ditto.
>
> > +                     if (memblock_is_kho_scratch_memory(page_to_phys(p=
age)))
> > +                             mt =3D MIGRATE_CMA;
> > +#endif
>
> memmap_init_zone_range() is called each time for a region in
> memblock.memory. This means either entire range will be KHO_SCRATHC or no=
t
> and we can check for memblock_is_kho_scratch_memory() once for every regi=
on
> in memmap_init_zone_range().

Thanks, I didn't notice for_each_mem_pfn_range iterates over regions. Will =
do.

> > +
> > +                     init_pageblock_migratetype(page, mt,
> > +                                                isolate_pageblock);
> >                       cond_resched();
> >               }
> >               pfn++;
> > @@ -1970,7 +1977,7 @@ unsigned long __init node_map_pfn_alignment(void)
> >
> >  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> >  static void __init deferred_free_pages(unsigned long pfn,
> > -             unsigned long nr_pages)
> > +             unsigned long nr_pages, enum migratetype mt)
> >  {
> >       struct page *page;
> >       unsigned long i;
> > @@ -1983,8 +1990,7 @@ static void __init deferred_free_pages(unsigned l=
ong pfn,
> >       /* Free a large naturally-aligned chunk if possible */
> >       if (nr_pages =3D=3D MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pf=
n)) {
> >               for (i =3D 0; i < nr_pages; i +=3D pageblock_nr_pages)
> > -                     init_pageblock_migratetype(page + i, MIGRATE_MOVA=
BLE,
> > -                                     false);
> > +                     init_pageblock_migratetype(page + i, mt, false);
> >               __free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
> >               return;
> >       }
> > @@ -1994,8 +2000,7 @@ static void __init deferred_free_pages(unsigned l=
ong pfn,
> >
> >       for (i =3D 0; i < nr_pages; i++, page++, pfn++) {
> >               if (pageblock_aligned(pfn))
> > -                     init_pageblock_migratetype(page, MIGRATE_MOVABLE,
> > -                                     false);
> > +                     init_pageblock_migratetype(page, mt, false);
> >               __free_pages_core(page, 0, MEMINIT_EARLY);
> >       }
> >  }
> > @@ -2051,6 +2056,7 @@ deferred_init_memmap_chunk(unsigned long start_pf=
n, unsigned long end_pfn,
> >       u64 i =3D 0;
> >
> >       for_each_free_mem_range(i, nid, 0, &start, &end, NULL) {
> > +             enum migratetype mt =3D MIGRATE_MOVABLE;
> >               unsigned long spfn =3D PFN_UP(start);
> >               unsigned long epfn =3D PFN_DOWN(end);
> >
> > @@ -2060,12 +2066,17 @@ deferred_init_memmap_chunk(unsigned long start_=
pfn, unsigned long end_pfn,
> >               spfn =3D max(spfn, start_pfn);
> >               epfn =3D min(epfn, end_pfn);
> >
> > +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
>
> No need for #ifdef here as well.
>
> > +             if (memblock_is_kho_scratch_memory(PFN_PHYS(spfn)))
> > +                     mt =3D MIGRATE_CMA;
> > +#endif
> > +
> >               while (spfn < epfn) {
> >                       unsigned long mo_pfn =3D ALIGN(spfn + 1, MAX_ORDE=
R_NR_PAGES);
> >                       unsigned long chunk_end =3D min(mo_pfn, epfn);
> >
> >                       nr_pages +=3D deferred_init_pages(zone, spfn, chu=
nk_end);
> > -                     deferred_free_pages(spfn, chunk_end - spfn);
> > +                     deferred_free_pages(spfn, chunk_end - spfn, mt);
> >
> >                       spfn =3D chunk_end;
> >
> > --
> > 2.54.0.rc1.555.g9c883467ad-goog
> >
>
> --
> Sincerely yours,
> Mike.


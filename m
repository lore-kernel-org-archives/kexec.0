Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A838C10775EA
	for <kexec@archiver.kernel.org>; Wed, 18 Mar 2026 17:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NLRA5wLn5WuPBfC09ox3pNnNkgYTeioPhs9JJbhrjUM=; b=b1LCNZ+rAdb6I+ORsD/4KbIhfx
	w0n1/ECjkeQUHUquBZTkaSDtH5QlInxzZ/EiluM/Pouap8sDU9qnIXNyM1WnK/m2llPUsIZxpUmHa
	26yDw4wnhtBcyJndh4kdFUYIbvogSAJ6glOeLwyg2dVBAQyE3IkEs6Fr4gLvy7xwikQUS/qy7XBXo
	hFw0+FoPTZVRTtnT/2ac9QPRF+pO/xMijRJE1+sR7drU/0S59zf8f6NxVKg+g2JPpSEpkLUoCYpE7
	on3x816DeK3ZDPRP5TRVfoiq+B69HoLTRgzc1wR5Jwtx3x9M/upTWSVtNC6Deql/0qSBBgfPQK5p8
	U63q4OFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2uYh-000000093G1-1Jfm;
	Wed, 18 Mar 2026 17:19:51 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2uYf-000000093Fc-0c4n
	for kexec@lists.infradead.org;
	Wed, 18 Mar 2026 17:19:50 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-1270f10a774so323c88.1
        for <kexec@lists.infradead.org>; Wed, 18 Mar 2026 10:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773854388; cv=none;
        d=google.com; s=arc-20240605;
        b=M0SUhht8tfHrGNYSLJPatOGOxB2GfzY2NF3nxJC1BLRhoR4hRWKWX4H27xYGXqNCXl
         NpddAV0kS/bvL39grz3fCaZAvx4Zi0jWhFi+yGTYbUaA33NFMOSSlHOayBerl6zxqp51
         U8M8grdWKHFbsGDO2RY3wcePzjrpA6RNyH7n+jf77Sx/g7t3FHInRQ0Lp0c5UZ4p4ryh
         DZZ3JAqM+UayUf+RBKbtiFumZBdQRQCKj5TqL++8+kP5vaIPekABkbJgIpoh7egV/zwk
         xgqDnEucR9ioXrZchCaJQzdUQif1ySNviRwnP1K8XxFXf4UGW9IZIQXuWfcd71d78XD0
         jYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NLRA5wLn5WuPBfC09ox3pNnNkgYTeioPhs9JJbhrjUM=;
        fh=0tNVjwZGQXhK5/ul3y8yTLKa8e467Eeo0CNihGsXaxc=;
        b=axOlbS+11JNAlzZ0flj49TLWbGoiufLvep78VjBG7GYlgT5c8CpboY5UhZMpYK3Lus
         sowWXQGwbtfllnoLVtnF4lHQm3GxbJXDD6BZKzHB6PgUnSaoQB3Uq4ef3lyAs4A5ONlm
         KRvsWB3LkmFe6u7SUoeCyN4wpBKhXeLn+FwgdM8JqqbVAtvrJ9U/Lit9Zineh75RXg6f
         6fhkiXH+fEIWpJGTWhD/eglJ0LLdA6jUSPfLqeoRoVE8ZNMYyM1eZkvvlL7lVJ10ZM7a
         m6irdlVUhyPUfXrOXUXYBYKQujGSXXR9IrM8c2/QpPIyTkt8DBwx3BhOawLgJsIPkVS2
         JpMA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773854388; x=1774459188; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLRA5wLn5WuPBfC09ox3pNnNkgYTeioPhs9JJbhrjUM=;
        b=wBex9FjVT6Vw1qr6sRapSZC0TN19xZIkRTzEMl0pFQWY43k7mJgeOw9szoOZZUza/x
         qydW5wQeMtp1H/TArHcoAY9Qts+AOa124mmMNJJ984QiLOyqOvaaAVPOPpYRObn05gzK
         764CO/AQa1FlBh12y5kt5+B9nsV5MpBu5/zaNHiAsXC3YK+JwOiAqD+y7RPnRBb+fQyL
         CNaLlfIgpVC9YbI3RwV1vKknF+2blaZ1/81N/fJt13ppHxnJ34u48bbcujZ3hZaja0gc
         O/t+IleAzCA20e1I2X7JwRoMspSZmllk5RFTwLgM90o5WSNbcGxbwEpBuzsA7fVTHMBn
         mavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773854388; x=1774459188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NLRA5wLn5WuPBfC09ox3pNnNkgYTeioPhs9JJbhrjUM=;
        b=dEOULZy5D9bTdrl/ymmw0G8JRtf76MFjWiQACgP25yTS+FeHu/XGS2dX79ggv+bDcb
         NmCoaW0E0YkHakyaccgpZhWZ1KnO4piEVrPRvtMjyW1K0aqBQoy57Bpburg2tLW0FWli
         vqkKHzGqoaykbxpoDbIWkNy4GFOuaZUFvInWLTnCYBn5FBVO+zM1zgjI1MZzWF+oc/kO
         Z3Q73MoLgN+EnQ7r5mJmj8yScn4zekphrGWET7IqlhUBsxqsHvYdxKWqNOG3pnBhA2uU
         HpUu5G9j5Y7kzQy8UcFNYC+SGrMYsp0aNR8dTpi5AOiiQjYqMVJf+vwpANmfujDlTzsy
         TJxw==
X-Forwarded-Encrypted: i=1; AJvYcCWWJuKdzsXzD7Gcp4xNSyfKROMpVJNfbCUb2pBFPPkwK9p21YVieaGCbviCWASlBQZMoaTyYg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyBAqlgsAteldgKvVTl2AlF7kUsvodprEUQCYT3Mn23q8j1dJ3J
	+7Rrp68RtVEuAUZqW8izSvux5R1VYJXZ8zjbLAi/NV133u/KXflw2kWlB/J7yiFekKY7WW+juUG
	1ukn4R71GcMkCZEODB65BObgZvDDUb3sCxstMSkW1
X-Gm-Gg: ATEYQzzLJLBC++GqN5JGx/5YGWIG0tuh4aUixeF9Imo0aoSCW/DnKKq3PFIOYLx4tqj
	rgmtNVq2Tdw+9gRB3FRh3m5xTp/lQLHGx5Qaudl4n2H+4+2BWLH3mnccDc1zRs1v9MnEyhUsXKo
	1ahUDcMPnKHFdK1jjqXjbRQWXs3kn+/sRj97nP8BezfZsvEc3r0Sn5SNYT/3saqqrTvMWcpMRVS
	s3YD/ncB6NpAyNPFtRm5dkHr9cLP0pXbpRJXPrjJAVYgVT6cbQD251Vz5m5Qa5x4bSNAMVS+Cz5
	E07b4Q==
X-Received: by 2002:a05:7022:124:b0:119:e56b:c1e3 with SMTP id
 a92af1059eb24-12a68d26a20mr10433c88.14.1773854387389; Wed, 18 Mar 2026
 10:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260317141534.815634-1-mclapinski@google.com>
 <20260317141534.815634-3-mclapinski@google.com> <AD9E1B18-C813-480E-894C-FEEB51EE8A93@nvidia.com>
 <CAAi7L5dSOxXETv-bYs4hJ1SfixMBQXS4fmfKs3SzVvQ=yY7oSg@mail.gmail.com>
 <76559EF5-8740-4691-8776-0ADD1CCBF2A4@nvidia.com> <CAAi7L5ex+66qgFzRkLDbuOmC=cVrMyBctPZv6wd15n1rc2U9KQ@mail.gmail.com>
 <0D1F59C7-CA35-49C8-B341-32D8C7F4A345@nvidia.com>
In-Reply-To: <0D1F59C7-CA35-49C8-B341-32D8C7F4A345@nvidia.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Wed, 18 Mar 2026 18:19:35 +0100
X-Gm-Features: AaiRm52CPFaymzRa8X5AjTmLN3_97Lik6HaBOVaHylO9YyWT8r-Y2mIkOIgQpF8
Message-ID: <CAAi7L5fvUPUqd3A4m6wubeYh90NH+S2KBRE1R8WKerBYhkU8kg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
To: Zi Yan <ziy@nvidia.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_101949_199325_8D675CDE 
X-CRM114-Status: GOOD (  49.26  )
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

On Wed, Mar 18, 2026 at 6:08=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 18 Mar 2026, at 11:45, Micha=C5=82 C=C5=82api=C5=84ski wrote:
>
> > On Wed, Mar 18, 2026 at 4:26=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 18 Mar 2026, at 11:18, Micha=C5=82 C=C5=82api=C5=84ski wrote:
> >>
> >>> On Wed, Mar 18, 2026 at 4:10=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote=
:
> >>>>
> >>>> On 17 Mar 2026, at 10:15, Michal Clapinski wrote:
> >>>>
> >>>>> Currently, if DEFERRED is enabled, kho_release_scratch will initial=
ize
> >>>>> the struct pages and set migratetype of kho scratch. Unless the who=
le
> >>>>> scratch fit below first_deferred_pfn, some of that will be overwrit=
ten
> >>>>> either by deferred_init_pages or memmap_init_reserved_pages.
> >>>>>
> >>>>> To fix it, I modified kho_release_scratch to only set the migratety=
pe
> >>>>> on already initialized pages. Then, modified init_pageblock_migrate=
type
> >>>>> to set the migratetype to CMA if the page is located inside scratch=
.
> >>>>>
> >>>>> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> >>>>> ---
> >>>>>  include/linux/memblock.h           |  2 --
> >>>>>  kernel/liveupdate/kexec_handover.c | 10 ++++++----
> >>>>>  mm/memblock.c                      | 22 ----------------------
> >>>>>  mm/page_alloc.c                    |  7 +++++++
> >>>>>  4 files changed, 13 insertions(+), 28 deletions(-)
> >>>>>
> >>>>
> >>>> <snip>
> >>>>
> >>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>>>> index ee81f5c67c18..5ca078dde61d 100644
> >>>>> --- a/mm/page_alloc.c
> >>>>> +++ b/mm/page_alloc.c
> >>>>> @@ -55,6 +55,7 @@
> >>>>>  #include <linux/cacheinfo.h>
> >>>>>  #include <linux/pgalloc_tag.h>
> >>>>>  #include <linux/mmzone_lock.h>
> >>>>> +#include <linux/kexec_handover.h>
> >>>>>  #include <asm/div64.h>
> >>>>>  #include "internal.h"
> >>>>>  #include "shuffle.h"
> >>>>> @@ -549,6 +550,12 @@ void __meminit init_pageblock_migratetype(stru=
ct page *page,
> >>>>>                    migratetype < MIGRATE_PCPTYPES))
> >>>>>               migratetype =3D MIGRATE_UNMOVABLE;
> >>>>>
> >>>>> +     /*
> >>>>> +      * Mark KHO scratch as CMA so no unmovable allocations are ma=
de there.
> >>>>> +      */
> >>>>> +     if (unlikely(kho_scratch_overlap(page_to_phys(page), PAGE_SIZ=
E)))
> >>>>> +             migratetype =3D MIGRATE_CMA;
> >>>>> +
> >>>>
> >>>> If this is only for deferred init code, why not put it in deferred_f=
ree_pages()?
> >>>> Otherwise, all init_pageblock_migratetype() callers need to pay the =
penalty
> >>>> of traversing kho_scratch array.
> >>>
> >>> Because reserve_bootmem_region() doesn't call deferred_free_pages().
> >>> So I would also have to modify it.
> >>>
> >>> And the early initialization won't pay the penalty of traversing the
> >>> kho_scratch array, since then kho_scratch is NULL.
> >>
> >> How about hugetlb_bootmem_init_migratetype(), init_cma_pageblock(),
> >> init_cma_reserved_pageblock(), __init_page_from_nid(), memmap_init_ran=
ge(),
> >> __init_zone_device_page()?
> >>
> >> 1. are they having any PFN range overlapping with kho?
> >> 2. is kho_scratch NULL for them?
> >>
> >> 1 tells us whether putting code in init_pageblock_migratetype() could =
save
> >> the hassle of changing all above locations.
> >> 2 tells us how many callers are affected by traversing kho_scratch.
> >
> > I could try answering those questions but
> >
> > 1. I'm new to this and I'm not sure how correct the answers will be.
> >
> > 2. If you're not using CONFIG_KEXEC_HANDOVER, the performance penalty
> > will be zero.
> > If you are using it, currently you have to disable
> > CONFIG_DEFERRED_STRUCT_PAGE_INIT and the performance hit from this is
> > far, far greater. This solution saves 0.5s on my setup (100GB of
> > memory). We can always improve the performance further in the future.
> >
>
> OK, I asked Claude for help and the answer is that not all callers of
> init_pageblock_migratetype() touch kho scratch memory regions. Basically,
> you only need to perform the kho_scratch_overlap() check in
> __init_page_from_nid() to achieve the same end result.
>
>
> The below is the analysis from Claude.
> Based on my understanding,
> 1. memmap_init_range() is done before kho_memory_init(), so it does not n=
eed
> the check.
>
> 2. __init_zone_device_page() is not relevant.
>
> 3. init_cma_reserved_pageblock() / init_cma_pageblock() are already set
> to MIGRATE_CMA.
>
> 4. hugetlb is not used by kho scratch, so also does not need the check.
>
> 5. kho_release_scratch() already takes care of it.
>
> The remaining memblock_free_pages() needs a check, but I am not 100%.
>
>
> # kho_scratch_overlap() in init_pageblock_migratetype() =E2=80=94 scope a=
nalysis
>
> ## Context
>
> Commit a7700b3c6779 ("kho: fix deferred init of kho scratch") added a
> kho_scratch_overlap() call inside init_pageblock_migratetype() in
> mm/page_alloc.c:
>
> ```c
> if (unlikely(kho_scratch_overlap(page_to_phys(page), PAGE_SIZE)))
>     migratetype =3D MIGRATE_CMA;
> ```
>
> kho_scratch_overlap() does a NULL check followed by a loop over the
> kho_scratch array. For non-KHO boots (kho_scratch =3D=3D NULL) the cost i=
s
> a single NULL load and branch. For KHO boots the loop runs on every call
> to init_pageblock_migratetype().
>
> ## Question
>
> Does this add overhead for callers whose memory range cannot overlap
> with scratch? Can the check be moved to the caller side?
>
> ## Call site analysis
>
> init_pageblock_migratetype() has nine call sites. The init call ordering
> relevant to scratch is:
>
> ```
> setup_arch()
>   zone_sizes_init() -> free_area_init() -> memmap_init_range()   [1]
>
> mm_init_free_all() / start_kernel():
>   kho_memory_init() -> kho_release_scratch()                     [2]
>   memblock_free_all()
>     free_low_memory_core_early()
>       memmap_init_reserved_pages()
>         reserve_bootmem_region() -> __init_deferred_page()
>           -> __init_page_from_nid()                              [3]
>   deferred init kthreads -> __init_page_from_nid()               [4]
> ```

I don't understand this. deferred_free_pages() doesn't call
__init_page_from_nid(). So I would clearly need to modify both
deferred_free_pages and __init_page_from_nid.

>
> ### Per call site
>
> **mm/mm_init.c =E2=80=94 __init_page_from_nid() (deferred init)**
>
> Called for every deferred pfn (>=3D first_deferred_pfn). Scratch pages
> in the deferred range are not touched by kho_release_scratch() (new
> code clips end_pfn to first_deferred_pfn) and not touched by
> memmap_init_range() (stops at first_deferred_pfn). This path sets
> MIGRATE_MOVABLE on deferred scratch pageblocks after
> kho_release_scratch() has already run.
>
> **Needs the fix: yes.**
>
> Both sub-paths that reach this function for deferred scratch pages:
> - deferred init kthreads [4]
> - reserve_bootmem_region() -> __init_deferred_page() [3]
>   (early_page_initialised() returns early for non-deferred pfns, so
>   __init_page_from_nid() is only reached for deferred pfns here too)
>
> **mm/mm_init.c =E2=80=94 memmap_init_range()**
>
> Runs during setup_arch() [1], before kho_memory_init() [2]. Sets
> MIGRATE_MOVABLE on scratch pageblocks, but kho_release_scratch() runs
> afterward and correctly overrides to MIGRATE_CMA for non-deferred
> scratch. For deferred scratch, memmap_init_range() stops at
> first_deferred_pfn and never processes them.
>
> **Needs the fix: no.**
>
> **mm/mm_init.c =E2=80=94 __init_zone_device_page()**
>
> ZONE_DEVICE path only. Scratch is normal RAM, not ZONE_DEVICE.
>
> **Needs the fix: no.**
>
> **mm/mm_init.c =E2=80=94 memblock_free_pages() (lines ~2012 and ~2023)**
>
> Called by memblock_free_all() for free (non-reserved) memblock regions.
> Scratch is memblock-reserved and released through the CMA path, not
> through memblock_free_all().
>
> **Needs the fix: no.**
>
> **mm/mm_init.c =E2=80=94 init_cma_reserved_pageblock() / init_cma_pageblo=
ck()**
>
> Both already pass MIGRATE_CMA. The kho_scratch_overlap() check would
> be redundant even if scratch reaches these paths.
>
> **Needs the fix: no (redundant).**
>
> **mm/hugetlb.c =E2=80=94 __prep_compound_gigantic_folio()**
>
> Gigantic hugepage setup. Scratch regions are not used for gigantic
> hugepages.
>
> **Needs the fix: no.**
>
> **kernel/liveupdate/kexec_handover.c =E2=80=94 kho_release_scratch()**
>
> Already passes MIGRATE_CMA. Additionally, kho_scratch is NULL at the
> point kho_release_scratch() runs (kho_memory_init() sets kho_scratch
> only after kho_release_scratch() returns), so kho_scratch_overlap()
> would return false regardless.
>
> **Needs the fix: no.**
>
> ## Conclusion
>
> The only path that actually requires the MIGRATE_CMA override is
> __init_page_from_nid(). All problematic sub-paths (deferred init
> kthreads and reserve_bootmem_region()) converge there.
>
> The check could be moved to __init_page_from_nid() to keep the
> KHO-specific concern out of the generic init_pageblock_migratetype():
>
> ```c
> /* mm/mm_init.c: __init_page_from_nid() */
> if (pageblock_aligned(pfn)) {
>     enum migratetype mt =3D MIGRATE_MOVABLE;
>     if (kho_scratch_overlap(PFN_PHYS(pfn), PAGE_SIZE))
>         mt =3D MIGRATE_CMA;
>     init_pageblock_migratetype(pfn_to_page(pfn), mt, false);
> }
> ```
>
> __init_page_from_nid() is only compiled under CONFIG_DEFERRED_STRUCT_PAGE=
_INIT,
> which is the only configuration where the bug can occur, so the
> kho_scratch_overlap() call would be naturally gated by that config.
>
>
>
> Best Regards,
> Yan, Zi


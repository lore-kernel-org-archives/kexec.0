Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435B71091909
	for <kexec@archiver.kernel.org>; Thu, 19 Mar 2026 18:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YQeSlb7OEZ3xloMA9xhKbLU6mKFG3hm3XyxfgVq5ezM=; b=Ik4ZrwrtlfntVrM3RsimzV/1zR
	u8/CeNq1txhg3lCRdx/gYf4hJ83N+22CmdqmC8nzLqxeTcVu6TMDNZtC2IaZs+fPusmIQylaj06bi
	B2pLKgsPhKE9ELDJQbVqf0XCrCtWeAzuQ+jo73WAr+FkLck2OE9wrhWyMjYbQDW6ST+CBW4WWxmb9
	n/zLNn4ZVXvYG6cWghSsjKE7gPfv5p2xjLLWNahKZ5AWHHD48pi5blMZ4wLrZ+6lxYLxAxT7nBCDI
	tTMAFHI4bpaVscU4OKA4nGYZsvFBUHUIIY9b+Y4i+vApALLt01QdGRs3DW1wW2n2qUfUehnb1T+L2
	FIrKFkog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Hwf-0000000BIAX-1fZC;
	Thu, 19 Mar 2026 18:18:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Hwd-0000000BIAN-2mOb
	for kexec@bombadil.infradead.org;
	Thu, 19 Mar 2026 18:18:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YQeSlb7OEZ3xloMA9xhKbLU6mKFG3hm3XyxfgVq5ezM=; b=FJUo9GoQ9F88TckiU/2rRMCUBM
	JV2HvgxybPdXcUkeXUjoOVSsXHz4xPIlmqTtKD6au05i2+onV7W5EdUTLSn5uBAvRBSVmKp9SkUS3
	/RamV/hcTHKvmXdDD0FLbIwhyf7XKMo2SpTEEfrkGHHPjYZE5qUOhxrniLr4WIP8J4Z8ESZJqdnkr
	c9tNULjqux6e3YXLW1Ocd1aQ+gIkfY2YvzDg0Lbfwy1mxAR6EHlb7/5Njg9LLlibd3q6iquLO+N4Q
	9eCSKzYo6mtZqpmKQ0EZF/h9hG10RprsyZQHQ84e8DFpN8TrcF8l7YJS+MLnGjLdzI1qHo8yMBfn0
	jSNZGPJQ==;
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Hwa-0000000EDH5-1m0a
	for kexec@lists.infradead.org;
	Thu, 19 Mar 2026 18:18:06 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-1270fc2bdf2so1330c88.0
        for <kexec@lists.infradead.org>; Thu, 19 Mar 2026 11:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773944281; cv=none;
        d=google.com; s=arc-20240605;
        b=jPvCv/K3DXY557Fnfc4v414Q8ipOiVAoXEuAd1/CuFwpsda9vAme5yUhI+XzGmbfZ+
         MfiQvPJ9pHm3zTmMD/Uy47wS9Hea9GvRm8KvfYX2vF1JV3mND58sUaZQ9Nivjv3Bw+1b
         04SHp5025UgvSsQUQWEzo0zxFwdcSONxiQ5ripq7Mhpks48kLuyS6henk28ijp8ejlXN
         bLA+2OvBICJoqX4EfgWP6z914zSFdQm95qZHibuUW/BqnPwBgUDCLRsiLPSaYByD/qJp
         Jz9lBTyE0RZBOQdr5Y95md4nG9fuG9FEmZ+qBO6CXBw5Hhq4CG0BFAeDkAXvJhfU8TY4
         psdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YQeSlb7OEZ3xloMA9xhKbLU6mKFG3hm3XyxfgVq5ezM=;
        fh=4s/yN3P3UhqYAUfaPtspyJdn7R4aAgAqzqYug8o5Pdc=;
        b=aSB3rIbJSX60hTKgHXP5gxJLWR6svHNRWwZQNLLRyZdkQ842q0XjCj68quCAd5F2xC
         iuBv43AeyCruKU7ckUvb+VPH/vW449e1PaOLZEwnkQfQeImeaoFaH2wn3Usjtwzo5XmL
         II1jrIG/YZXzHTM2Y9BQbJW9EC5/DAgrrtvsGPVfR8+v5RQIkPBh/88N1m3Nj4pwhs9T
         SMRiJHUFuEvGKlRrduHEVD0VUZrlUOG3yUpA7SpHKtb0hM1nsmz665YHWJOe+zGBd0Kv
         SHyaIVdEsjoF01NFJEhmYTQBGO4V969oe8/v90LhcN68/cNbIskATTGNUMS34IgVWiuT
         +GEg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773944281; x=1774549081; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQeSlb7OEZ3xloMA9xhKbLU6mKFG3hm3XyxfgVq5ezM=;
        b=YEOtg8JM2bDRrfqqzN2adZzbUcukS3r27FCX4F+MNgOb1ybh3YOUjccqch5oUAI0PM
         FFXyOt2i/tBAPrlNGuxki528cyd36Add33H+gM/r8n6eUMDzBWF/oGaevd0wmx3GNW/5
         iKibHCYLoISdHVI8w4PspkXPSIU/dj3o1OxlwH3IFu9EgVViPuZ19YzxxsqfyrxQSwl9
         fhk1mqh0d2wArHNneMMVQVthdRIZ0UQTSFystU0TUlS9k/aGQ2eEsgNeUAxgO35KZdN0
         1YxAerj+0pnAKqiSZAXArWQyvuX4syopaMOMP9GiIh8PeHV2J1kYcCQkLAKpT5tBJRkC
         n3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773944281; x=1774549081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YQeSlb7OEZ3xloMA9xhKbLU6mKFG3hm3XyxfgVq5ezM=;
        b=miZc05Nku4a0O5Wjgca4+0Zkqsik62gv5wUc9huLVHzZgCEUyXJuxqQGfcJqUxiA9B
         WwLPxlRagOcfwZbt7WNBskukmxIkF8PKvlwS087P+lpzb5j3Xm0znhwluTjXVJ0cp1Dt
         lleqchb5+QM1fyk7gNXGfoCzoOLUprGygPIqacMKoR+bbzYSmCuRRWUpZ6ZC/JfR5di3
         FDYLbFPAUPiJUnuFy3zNhEqa4p6TgV9JaLSMiGkpQiihMvYJgniHhrkEXj4rjJrYrbRT
         ImJNpeEy6QXP2FWdVlwZ2qdwkY1NM+E6wYVmj4ACwsUzYbyfMp/G61+o371FcoauE/g9
         k/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi6u0O22Awto708McdsbFB0IWWkdPTLScaORe3WWrLB4CfJstfN5LUi8bXtm/ij2O87FiDew==@lists.infradead.org
X-Gm-Message-State: AOJu0YyN5CYpZntODD/NysKGJJIlRBPF9x8GiC3d5vAihXBCFVdZv6qs
	bkdNu7D+qRgpEqAt/znES92jbB04lHbV4aEAiWSBBDqQMkxhfUupOZHR7B5NwTQy0NeEK4Scaa8
	r3ILfAmwbgUODpjITYYpGEb7196mLSxqgnYsvO6cbRHG3WJ6o+XGZHPw1kI8bpA==
X-Gm-Gg: ATEYQzxcQGDt8oQb6d2sLx76KxJn2WqUu3FskH29zC5T+qBk7EW4ru7zHyihBOBwaoQ
	6WKiOJDvyWLDB7fAmT8KKkeg2g73jk2HKJ6RQLJ7JqIl5CAUu10VSQZ/ncNfSG8kJObUS/ii0B4
	uItmTrVcSDrEhrqq5Y4XkqbtLmcgFV+RpvXyBP2ZWF2L6ixTg12Lofx06yHU70aQRfDX21TAcg3
	dujXGcuIg0yJkw9RlhTZp7bxzbS5AfljIULx+dXEAick5exojAneg9ZnyNSk5miCHTboCQahcm+
	8DcqM1XtmQo6T7iS
X-Received: by 2002:a05:7022:699d:b0:128:ec96:67 with SMTP id
 a92af1059eb24-12a724be71fmr6228c88.9.1773944280502; Thu, 19 Mar 2026 11:18:00
 -0700 (PDT)
MIME-Version: 1.0
References: <20260317141534.815634-1-mclapinski@google.com>
 <20260317141534.815634-3-mclapinski@google.com> <AD9E1B18-C813-480E-894C-FEEB51EE8A93@nvidia.com>
 <CAAi7L5dSOxXETv-bYs4hJ1SfixMBQXS4fmfKs3SzVvQ=yY7oSg@mail.gmail.com>
 <76559EF5-8740-4691-8776-0ADD1CCBF2A4@nvidia.com> <CAAi7L5ex+66qgFzRkLDbuOmC=cVrMyBctPZv6wd15n1rc2U9KQ@mail.gmail.com>
 <0D1F59C7-CA35-49C8-B341-32D8C7F4A345@nvidia.com> <CAAi7L5fvUPUqd3A4m6wubeYh90NH+S2KBRE1R8WKerBYhkU8kg@mail.gmail.com>
 <58A8B1B4-A73B-48D2-8492-A58A03634644@nvidia.com> <aburnbP64n9axmu_@kernel.org>
In-Reply-To: <aburnbP64n9axmu_@kernel.org>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Thu, 19 Mar 2026 19:17:48 +0100
X-Gm-Features: AaiRm505tq6vM1X9ULuY3A25VFS9p9k0Q14LqvIkt_uaKuJpyK0GLpRABpnGwjA
Message-ID: <CAAi7L5evx8ta8BifNiGNfUoTiaBUsv4cgQRbm_15RoAfdKPcMw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
To: Mike Rapoport <rppt@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Evangelos Petrongonas <epetron@amazon.de>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_181804_556013_67B49D99 
X-CRM114-Status: GOOD (  36.12  )
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

On Thu, Mar 19, 2026 at 8:54=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Hi,
>
> On Wed, Mar 18, 2026 at 01:36:07PM -0400, Zi Yan wrote:
> > On 18 Mar 2026, at 13:19, Micha=C5=82 C=C5=82api=C5=84ski wrote:
> > > On Wed, Mar 18, 2026 at 6:08=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote=
:
> > >>
> > >> ## Call site analysis
> > >>
> > >> init_pageblock_migratetype() has nine call sites. The init call orde=
ring
> > >> relevant to scratch is:
> > >>
> > >> ```
> > >> setup_arch()
> > >>   zone_sizes_init() -> free_area_init() -> memmap_init_range()   [1]
>
> Hmm, this is slightly outdated, but largely correct :)
>
> > >>
> > >> mm_init_free_all() / start_kernel():
> > >>   kho_memory_init() -> kho_release_scratch()                     [2]
> > >>   memblock_free_all()
> > >>     free_low_memory_core_early()
> > >>       memmap_init_reserved_pages()
> > >>         reserve_bootmem_region() -> __init_deferred_page()
> > >>           -> __init_page_from_nid()                              [3]
> > >>   deferred init kthreads -> __init_page_from_nid()               [4]
>
> And this is wrong, deferred init does not call __init_page_from_nid, only
> reserve_bootmem_region() does.
>
> And there's a case claude missed:
>
> hugetlb_bootmem_free_invalid_page() -> __init_page_from_nid() that
> shouldn't check for KHO. Well, at least until we have support for hugetlb
> persistence and most probably even afterwards.
>
> I don't think we should modify reserve_bootmem_region(). If there are
> reserved pages in a pageblock, it does not matter if it's initialized to
> MIGRATE_CMA. It only becomes important if the reserved pages freed, so we
> can update pageblock migrate type in free_reserved_area().
> When we boot with KHO, all memblock allocations come from scratch, so
> anything freed in free_reserved_area() should become CMA again.

What happens if the reserved area covers one page and that page is
pageblock aligned? Then it won't be marked as CMA until it is freed
and unmovable allocation might appear in that pageblock, right?

>
> > >> ```
> > >
> > > I don't understand this. deferred_free_pages() doesn't call
> > > __init_page_from_nid(). So I would clearly need to modify both
> > > deferred_free_pages and __init_page_from_nid.
>
> For deferred_free_pages() we don't need kho_scratch_overlap(), we already
> have memblock_region (almost) at hand and it's enough to check if it's
> MEMBLOCK_KHO_SCRATCH.
>
> Something along these lines (compile tested only) should do the trick:
>
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 3e217414e12d..b9b1e0991ec8 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -275,6 +275,8 @@ static inline void __next_physmem_range(u64 *idx, str=
uct memblock_type *type,
>         __for_each_mem_range(i, &memblock.reserved, NULL, NUMA_NO_NODE, \
>                              MEMBLOCK_NONE, p_start, p_end, NULL)
>
> +struct memblock_region *memblock_region_from_iter(u64 iterator);
> +
>  static inline bool memblock_is_hotpluggable(struct memblock_region *m)
>  {
>         return m->flags & MEMBLOCK_HOTPLUG;
> diff --git a/mm/memblock.c b/mm/memblock.c
> index ae6a5af46bd7..9cf99f32279f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1359,6 +1359,16 @@ void __init_memblock __next_mem_range_rev(u64 *idx=
, int nid,
>         *idx =3D ULLONG_MAX;
>  }
>
> +__init_memblock struct memblock_region *memblock_region_from_iter(u64 it=
erator)
> +{
> +       int index =3D iterator & 0xffffffff;

I'm not sure about this. __next_mem_range() has this code:
/*
* The region which ends first is
* advanced for the next iteration.
*/
if (m_end <=3D r_end)
        idx_a++;
else
        idx_b++;

Therefore, the index you get from this might be correct or it might
already be incremented.

> +
> +       if (index < 0 || index >=3D memblock.memory.cnt)
> +               return NULL;
> +
> +       return &memblock.memory.regions[index];
> +}
> +
>  /*
>   * Common iterator interface used to define for_each_mem_pfn_range().
>   */
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index cec7bb758bdd..96b25895ffbe 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1996,7 +1996,7 @@ unsigned long __init node_map_pfn_alignment(void)
>
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  static void __init deferred_free_pages(unsigned long pfn,
> -               unsigned long nr_pages)
> +               unsigned long nr_pages, enum migratetype mt)
>  {
>         struct page *page;
>         unsigned long i;
> @@ -2009,8 +2009,7 @@ static void __init deferred_free_pages(unsigned lon=
g pfn,
>         /* Free a large naturally-aligned chunk if possible */
>         if (nr_pages =3D=3D MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pf=
n)) {
>                 for (i =3D 0; i < nr_pages; i +=3D pageblock_nr_pages)
> -                       init_pageblock_migratetype(page + i, MIGRATE_MOVA=
BLE,
> -                                       false);
> +                       init_pageblock_migratetype(page + i, mt, false);
>                 __free_pages_core(page, MAX_PAGE_ORDER, MEMINIT_EARLY);
>                 return;
>         }
> @@ -2020,8 +2019,7 @@ static void __init deferred_free_pages(unsigned lon=
g pfn,
>
>         for (i =3D 0; i < nr_pages; i++, page++, pfn++) {
>                 if (pageblock_aligned(pfn))
> -                       init_pageblock_migratetype(page, MIGRATE_MOVABLE,
> -                                       false);
> +                       init_pageblock_migratetype(page, mt, false);
>                 __free_pages_core(page, 0, MEMINIT_EARLY);
>         }
>  }
> @@ -2077,6 +2075,8 @@ deferred_init_memmap_chunk(unsigned long start_pfn,=
 unsigned long end_pfn,
>         u64 i =3D 0;
>
>         for_each_free_mem_range(i, nid, 0, &start, &end, NULL) {
> +               struct memblock_region *region =3D memblock_region_from_i=
ter(i);
> +               enum migratetype mt =3D MIGRATE_MOVABLE;
>                 unsigned long spfn =3D PFN_UP(start);
>                 unsigned long epfn =3D PFN_DOWN(end);
>
> @@ -2086,12 +2086,15 @@ deferred_init_memmap_chunk(unsigned long start_pf=
n, unsigned long end_pfn,
>                 spfn =3D max(spfn, start_pfn);
>                 epfn =3D min(epfn, end_pfn);
>
> +               if (memblock_is_kho_scratch(region))
> +                       mt =3D MIGRATE_CMA;
> +
>                 while (spfn < epfn) {
>                         unsigned long mo_pfn =3D ALIGN(spfn + 1, MAX_ORDE=
R_NR_PAGES);
>                         unsigned long chunk_end =3D min(mo_pfn, epfn);
>
>                         nr_pages +=3D deferred_init_pages(zone, spfn, chu=
nk_end);
> -                       deferred_free_pages(spfn, chunk_end - spfn);
> +                       deferred_free_pages(spfn, chunk_end - spfn, mt);
>
>                         spfn =3D chunk_end;
>
> --
> Sincerely yours,
> Mike.


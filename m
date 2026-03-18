Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C6D10706E8
	for <kexec@archiver.kernel.org>; Wed, 18 Mar 2026 10:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h1YwBcD7XlNYfw4PFQzrHzcpcYPaaxw4aJMR4YVcRA4=; b=wDM1YOyBdYyeqQDhnJA2MjYxtI
	ckKTHejr/JTBr0oSiyFP02Yz3tatW3TmAqPWpraQBGJJLQ4GKCMLbdgbAQ5Ye6iS0X7s2je/wtR/H
	Ngf1KLQ00226Vzs4K0YM6sPA/Vy+XTywaYsXGMnTzmwlIss556CF9F1fbJHtFBVy8co3SRHUjLZP6
	o4jvBJ0z3KSq6ITHgiaacamhjYAgnbFvbaTiL2hqh05MZyVPQRjY3aXhVXSPqCqIrXVBwTOAtysHV
	DDNOXiQ4RbzwXcejXMrGDsfUiDxo08ds0w21TPmmlIwuw10TXyTZ8/KqUwswih39BELSWXhqaShsG
	wiwknMRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2oDN-00000008DQD-3AqS;
	Wed, 18 Mar 2026 10:33:25 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2oDL-00000008DPi-0lM4
	for kexec@lists.infradead.org;
	Wed, 18 Mar 2026 10:33:24 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-1270f10a774so6980c88.1
        for <kexec@lists.infradead.org>; Wed, 18 Mar 2026 03:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773830002; cv=none;
        d=google.com; s=arc-20240605;
        b=MYySxwZ/wwn8RwT0BAy1D9Mt6EoiswmBNq/waNFQoLEwpqjDddgUxTNzI1r85eCJcm
         K6OLubHm03qr9x+WAhGRATxaJ0z/eZowE7G4rTqp9KPQN1Q27mL2QHK56nY6W/h1LOgq
         nX/DtwJ//ujvinUfbV+j4Tce9nllTLsmI3M6uk86fVExTct2Z+IOwexS9w/xrRAYgV9Z
         36Cmf3A+toExEE/RQkGTL2hU+gT8JhDEQCiocPLarSoORUkZkTQR1d9c2Xbh+J7ibiH8
         hfabGG9xmNoSshNOKcP34rscfS5JPID7EQhDB+ZTrWZfiluq4E6zEB/T/0mFG1Z/oHIt
         hLuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h1YwBcD7XlNYfw4PFQzrHzcpcYPaaxw4aJMR4YVcRA4=;
        fh=WaTOF5Q03uVlsvSaL/1CgI0B27PTJug3wqcA8WSeagQ=;
        b=Pf4WFRwXQwr7BqtIYWXWQ33xqPXeNLvYrYw0GcnJKWASw6aYmzikRKgMtEFLv37+s1
         7YQ1GVNz+CY+TSglhT2g39d/d72jGTRt9QPbTJ1pRbgX3wOrXDPSolM9eebA5tmSf7cz
         PmUD99piGLwYxrfnKt07eobvq/hfEzo3LgIzENlj5ECt/8OGt0A+XUtOOr/IbiLiyHuI
         Sx2FLu1mClLa4xunOW8O7JgOGVwN1MruPRQXr6I12WGcQibseIJdlZYYghXptltm88II
         U7KYmFKeUjdeRiJ/NTDZs6Q4GSCIV9/5z1f6nQYX+Rn3Ky3TDH7OM2nbFUd9VO/zAzQD
         gRAA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773830002; x=1774434802; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1YwBcD7XlNYfw4PFQzrHzcpcYPaaxw4aJMR4YVcRA4=;
        b=TSZPA9fpC+jP6yorhuRvmdww+5Q15lpl2JKu6hXizwLObi3+izK8rnezMHspxN6uRg
         5mC/QPUlYJTZL1zBN+gXePeAywomUEzWLGl+UV5b6kry6aq6cj4SH53VEGg34qPdz9nI
         25rI7Hl8hVVu9Gk1cdjfGh7s1CtowuDfXjfPiyC7DOOtwVy2cb2/8LJW57SDD0raBhow
         2JnAxVqUBfCYbFjNp/+UHERYdHaOtcAWy1XZTALXe6y7GhlzzKcRL5THRyey/uLEUT1l
         Q4DYy9Aw0OFTKPXjyDZ+WuiPUEPvABLmXdaRhwoF8AfxqbekuRbsqRQERZpS4HrbyNy1
         2ZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773830002; x=1774434802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h1YwBcD7XlNYfw4PFQzrHzcpcYPaaxw4aJMR4YVcRA4=;
        b=Hi9pzR/J4rfPwPtR0OiX7FYNs7ux5bsNQ5EUzFckLR4KmUEsnvSx8AuDGvRqL8mJQA
         FwxG3p+O9LxMQZ6sVUB1LEWz/yq0aiDH78LexlbE+2yW7B6jxVJWcPTSG3Ks92aSp3G9
         TT87Emk9K+tuHyW3Ot9CkvOT2PrRM1z2W8xMde1RtQk9bI5LlbzdIowIYyFtVwO6eb1r
         U4Z+Je4eBQRKweDJTD5qiiN+uCamFDiODP3SHDMQyuwkfG21uOBikP2JiMHqfvwsrFvM
         NN3yhW5TCV9w0E6ESJfgo54fO7T/UNWyZXWr5iIOS5VkwqeAEUQWEY8mN7HauAz9Mwd7
         vSng==
X-Forwarded-Encrypted: i=1; AJvYcCUkpNLG6pCAvtekYELJcVNY8edXuVMqrtoyquWxWtfYqk8kpxzUMwgcwilFspSVUG/7ZEfhmQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyhRyxCTdUvOZ67Q1Me8Rwfcd98iWEoQI4u0nszX3py7eXZG2bb
	N0TmkiRIPKK4cx0FYWkfR0GcN5NSydxKp4w34MRUhzo81Iaf+MV1QByW6ufdiHglNoj6yKLBSXS
	OdZhIpFr0WICblccucDpyVjCdBwzjjEDdo9QnBj/p
X-Gm-Gg: ATEYQzwDOtVswSQy6/9SJIUl3JCEUgINgBtJb4+hp+gN+nwMNVAP6pNplyMEUqfcswU
	3+IWmEjSK7qok5ex2eJV5XAVTLBDtedVL2a65PuIIKpK4hH5AcUyrKi+DWbk0TtQZ3QQKbMkMzw
	hA29qSka3lCsB6VDtvsuY3BNNSfB4eJ9keouEz1aS+7lvRB0jgm/EOma4bgS1RWuTSDeowOp9XF
	xVIkkA1x7D/StJLV7ubLNskGn/CQFI0y6nlQoSfLKIFZAy5TjvO8LesP8I9wfjaG8c4mzUutkOq
	vYeGjQ==
X-Received: by 2002:a05:7022:3a83:b0:128:def1:f77f with SMTP id
 a92af1059eb24-129c5927900mr173162c88.20.1773830001815; Wed, 18 Mar 2026
 03:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260317141534.815634-1-mclapinski@google.com>
 <20260317141534.815634-3-mclapinski@google.com> <abpxUEijdHJzziEV@kernel.org>
In-Reply-To: <abpxUEijdHJzziEV@kernel.org>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Wed, 18 Mar 2026 11:33:09 +0100
X-Gm-Features: AaiRm51MWIfBPmVPLB2qYcQk0b3M6X8XFd5NBfBzpi7jH-NiRIi6OxA361n9fs0
Message-ID: <CAAi7L5e9GxgvGTFvPfcn81Ve59N-K-o7FOh+Y8qKHwpuCYycCw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
To: Mike Rapoport <rppt@kernel.org>
Cc: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_033323_230057_98717608 
X-CRM114-Status: GOOD (  31.70  )
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

On Wed, Mar 18, 2026 at 10:33=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> Hi Michal,
>
> On Tue, Mar 17, 2026 at 03:15:33PM +0100, Michal Clapinski wrote:
> > Currently, if DEFERRED is enabled, kho_release_scratch will initialize
>
> Please spell out CONFIG_DEFERRED_STRUCT_PAGE_INIT
>
> > the struct pages and set migratetype of kho scratch. Unless the whole
> > scratch fit below first_deferred_pfn, some of that will be overwritten
> > either by deferred_init_pages or memmap_init_reserved_pages.
>
> Usually we put brackets after function names to make them more visible.
>
> > To fix it, I modified kho_release_scratch to only set the migratetype
>
> Prefer an imperative mood please, e.g. "To fix it, modify
> kho_release_scratch() ..."
>
> > on already initialized pages. Then, modified init_pageblock_migratetype
> > to set the migratetype to CMA if the page is located inside scratch.
> >
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > ---
> >  include/linux/memblock.h           |  2 --
> >  kernel/liveupdate/kexec_handover.c | 10 ++++++----
> >  mm/memblock.c                      | 22 ----------------------
> >  mm/page_alloc.c                    |  7 +++++++
> >  4 files changed, 13 insertions(+), 28 deletions(-)
> >
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index 6ec5e9ac0699..3e217414e12d 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -614,11 +614,9 @@ static inline void memtest_report_meminfo(struct s=
eq_file *m) { }
> >  #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
> >  void memblock_set_kho_scratch_only(void);
> >  void memblock_clear_kho_scratch_only(void);
> > -void memmap_init_kho_scratch_pages(void);
> >  #else
> >  static inline void memblock_set_kho_scratch_only(void) { }
> >  static inline void memblock_clear_kho_scratch_only(void) { }
> > -static inline void memmap_init_kho_scratch_pages(void) {}
> >  #endif
> >
> >  #endif /* _LINUX_MEMBLOCK_H */
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index c9b982372d6e..e511a50fab9c 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -1477,8 +1477,7 @@ static void __init kho_release_scratch(void)
> >  {
> >       phys_addr_t start, end;
> >       u64 i;
> > -
> > -     memmap_init_kho_scratch_pages();
> > +     int nid;
> >
> >       /*
> >        * Mark scratch mem as CMA before we return it. That way we
> > @@ -1486,10 +1485,13 @@ static void __init kho_release_scratch(void)
> >        * we can reuse it as scratch memory again later.
> >        */
> >       __for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> > -                          MEMBLOCK_KHO_SCRATCH, &start, &end, NULL) {
> > +                          MEMBLOCK_KHO_SCRATCH, &start, &end, &nid) {
> >               ulong start_pfn =3D pageblock_start_pfn(PFN_DOWN(start));
> >               ulong end_pfn =3D pageblock_align(PFN_UP(end));
> >               ulong pfn;
> > +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> > +             end_pfn =3D min(end_pfn, NODE_DATA(nid)->first_deferred_p=
fn);
> > +#endif
>
> A helper that returns first_deferred_pfn or ULONG_MAX might be beeter
> looking.
>
> >
> >               for (pfn =3D start_pfn; pfn < end_pfn; pfn +=3D pageblock=
_nr_pages)
> >                       init_pageblock_migratetype(pfn_to_page(pfn),
> > @@ -1500,8 +1502,8 @@ static void __init kho_release_scratch(void)
> >  void __init kho_memory_init(void)
> >  {
> >       if (kho_in.scratch_phys) {
> > -             kho_scratch =3D phys_to_virt(kho_in.scratch_phys);
> >               kho_release_scratch();
> > +             kho_scratch =3D phys_to_virt(kho_in.scratch_phys);
>
> Why this change is needed?

It's not necessary but kho_release_scratch() will call
kho_scratch_overlap(). If kho_scratch is NULL, kho_scratch_overlap()
will return early, making it slightly faster. Alternatively, I skip
invoking kho_scratch_overlap() if migratetype is already MIGRATE_CMA.
(resending this since the last email was html)

> >
> >               if (kho_mem_retrieve(kho_get_fdt()))
> >                       kho_in.fdt_phys =3D 0;
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index b3ddfdec7a80..ae6a5af46bd7 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -959,28 +959,6 @@ __init void memblock_clear_kho_scratch_only(void)
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
> > -      * reserve_bootmem_region()
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
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index ee81f5c67c18..5ca078dde61d 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -55,6 +55,7 @@
> >  #include <linux/cacheinfo.h>
> >  #include <linux/pgalloc_tag.h>
> >  #include <linux/mmzone_lock.h>
> > +#include <linux/kexec_handover.h>
> >  #include <asm/div64.h>
> >  #include "internal.h"
> >  #include "shuffle.h"
> > @@ -549,6 +550,12 @@ void __meminit init_pageblock_migratetype(struct p=
age *page,
> >                    migratetype < MIGRATE_PCPTYPES))
> >               migratetype =3D MIGRATE_UNMOVABLE;
> >
> > +     /*
> > +      * Mark KHO scratch as CMA so no unmovable allocations are made t=
here.
> > +      */
> > +     if (unlikely(kho_scratch_overlap(page_to_phys(page), PAGE_SIZE)))
> > +             migratetype =3D MIGRATE_CMA;
> > +
>
> Please pick SJ's fixup for the next respin :)
>
> >       flags =3D migratetype;
> >
> >  #ifdef CONFIG_MEMORY_ISOLATION
> > --
> > 2.53.0.851.ga537e3e6e9-goog
> >
>
> --
> Sincerely yours,
> Mike.


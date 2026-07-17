Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDDFC44515
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vn+vPcBR7yKw800EHGrmkJfxwiILybxPqqHpaIR8qUU=; b=IONCkO3Qi/kjy3bX8jJSiNCDkr
	uMSV+7x3n+MQsuKoA5HDmExcQlsIr73x4j1ynLJaOCXkCj+koIA4kTG/y9z8T+6XOSqtyrafgaMqU
	mQbTbicgycDO3aguyRx0qTSka+j9SliHxzTqCRnkrukA4nqiBQqf3uvfqiimwd8o8Fe9pGrJxQJqx
	c2OLhLk1uHRpnT3MdlJ9h6csz98qx984GN6PuDzs+is658mharOJuVfYl5qiLYVRwGy1bZf3YVHjz
	3syIZsMwd0SFE/LarOMCtTAdf4tYUqbbVog05FBrq9y7qpgHY1lceZo2H+3poplbUfY0l+cKRKKxU
	o/axtrog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkmJv-00000002rud-35vi;
	Fri, 17 Jul 2026 17:25:55 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkmJt-00000002rtt-30yj
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 17:25:54 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso16750a12.1
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 10:25:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784309150; cv=none;
        d=google.com; s=arc-20260327;
        b=jtw1oy1KVbpAKv7AX/7fj+/MT41ifsi0BW7A1QN1Mnr5OPmYEqkxFMOJA+ZnMAegT9
         4ztx2iKpWLPzjUyTHATi82tM/zha3m6N6izUVvPodG60CG2N86k13KBfsK/P0JR0/a9V
         BJ9hLI2G9kAsieK6fvBguCcEr+0nUjG2f9ODh4k24UBlpceBXuWYiYVlNdpkoAaKaFXo
         1KJeWtIJYZ2uaUpnb7PSdrt3EeO3ww7dRU1LEVhc1wLag/4BpgsUW8yKfd4y6q6x5Ahp
         2g8T+0/ihEryrwpxanknatGCMvR4nxrl149wv0xXAMj6VOsBKkozTRlbJadXpuwDKlcM
         +4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vn+vPcBR7yKw800EHGrmkJfxwiILybxPqqHpaIR8qUU=;
        fh=SSWrCLGQ/8hUlnAi3tlPe3VdwCG2KebIap8ep0nXRZg=;
        b=DuXx5p60o9CViooWpqLORfhoDe4T3GQwHxiWGBxMU9lttfKDNoGaKxdqQfW+zo+Ech
         T0aAaHo0nft/fig31RN0rL3ecB1498/2xHrMGcCCvRu0+ShqatgxmPKQUPF2sDtjluPo
         9dCgCXlm/y43WXscIlv91bPPV36KLIgViFB8JztNPYXQPbXJHxdT2J2TitFM6Zk+kYsG
         R50jHkB58X0Cg19sNFDE148ojCYkN8LGiDmUeT0LmnM1NlRG9kYkuNilznCf5Bufzz3k
         YfN7qPGifrrDGTN39sPEAlZmz8EHhDCha2egNVKlLvqLQs7YXI3YTDL5hPkqZ32NJf/u
         hGDw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784309150; x=1784913950; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vn+vPcBR7yKw800EHGrmkJfxwiILybxPqqHpaIR8qUU=;
        b=ku3OI7tvaRODdqbL0fDRRmjjnLT0L0adBIylz/cJkGA/6GkX2MoL0ScCE7qpoC3fX+
         Cl8LAqM3NFINVBv5TuR4IEfxsevw+eF4ciU4Y5CINfb1CncckkMuJ1t3ZtEbQOzuaSjP
         p5JGeqDaBHzofHFil9YSJYJYWPsr0TCcol5/ZAlPpL2yAGWfqRvrHXmeV244daqxeNLk
         CDY6TxHfaQNQ2hU3vjT1j1drxLGQCIyYf2cnNw1biHY0mtU6dRdx2eCpCcJHdS03x2xi
         iMvHEMzVn0fJuDtUS+7ZogktUR4HgDh74zQETxXZXzOpCsVFe4uaBaL9Uq5cVirfY85B
         Ii1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784309150; x=1784913950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vn+vPcBR7yKw800EHGrmkJfxwiILybxPqqHpaIR8qUU=;
        b=a9Nq34f2YySesCaKlhdP0yGdxQAnLjSvBbB5rZKOGAVSMuxKC8aegcpJioVG83+jyc
         S+j6x8qJyZNdWzyFoihdimgYhy+LTHgPGUqST4A1ExsM3lu2XCiaLrBUneDRKgSYkJow
         beqClhNwVr0O0JIszHLQa+Nb8u9LqoQ+YBBcux6cACuG3RW1x4jfoeBO03w0UOYCn6yy
         PG85sQvIZ+4HH2RZzyYvaN5X/UehCeLlKtenMvja8/wM1chfvZ+IsxJOt39AOG2e1yC4
         HBRacmxCv43rfsMMrqvoJvNBVBqF7lq4vlyfLr3mmHm82WUl2WMa0lehA/hFpvQpbnIm
         mFnw==
X-Forwarded-Encrypted: i=1; AHgh+RpFBCJOHe3RExFPHDUapXIN6yMhu7yo6eBPiR5bHyGY/nVeO0GOSKKRi3O+ZuchpHkwpn04cw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxCl9VFBIzGDdzL3vMx4M/OYx58CgAIR+n4Nge5AbRZ6PLPFgvG
	wvem2Mur36uBp/m2b2gpS9ZFkrSyYoasUJuSocR4JwpwcwtfUV6ySjdaSc6fJR5p59YFbJUiB1X
	keHm4luGJtHm5K8iBL07LCLUs5pl9NL9YaHzocint
X-Gm-Gg: AfdE7cnKc2M5+JSwkMYhxSjywAVrWnHtxGcSm10xoEcUqMaRvrcTCRNq1fqOWlYYfk6
	e+g0H8GMOdskhJrywBGlS0NieenVXRKtks/UClkxMZ5rGLqMwtIIUNLvFYKQUeKOlpW4abcKK4h
	sDVx3rdYROoJqpfDUJLcJuxz7TM6crt+KYddYBE5PTuhnvyb1LHQcXTsmaUhavt4hFz2f7sMco8
	o1dXSSC94ojaEXnIgAHnRT/9Y3GJBVXcKn9W8TZxjprTiAf92NCGU860UJa
X-Received: by 2002:a05:6402:1244:b0:68a:e1ba:9cc0 with SMTP id
 4fb4d7f45d1cf-69e89ac9e37mr2887a12.8.1784309149795; Fri, 17 Jul 2026 10:25:49
 -0700 (PDT)
MIME-Version: 1.0
References: <20260717134028.2880508-1-mclapinski@google.com> <alpWWFo1gnxVnP7T@google.com>
In-Reply-To: <alpWWFo1gnxVnP7T@google.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Fri, 17 Jul 2026 19:25:38 +0200
X-Gm-Features: AUfX_mwtqaEj54b9UO72Tsip-eG3KMthhMEZ491YyqaB1ESSnxwLuQFSVqeb19A
Message-ID: <CAAi7L5f0huF0Gyo_uw-UM2zZdgeQtee1dNHW0pGMCW01HdsVZA@mail.gmail.com>
Subject: Re: [PATCH v2] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Evangelos Petrongonas <epetron@amazon.de>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_102553_829185_DFF68AEB 
X-CRM114-Status: GOOD (  34.14  )
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

On Fri, Jul 17, 2026 at 6:21=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 07-17 15:40, Michal Clapinski wrote:
> > While booting with KHO, the following crash was observed:
> >
> > BUG: unable to handle page fault for address: ff19164fffff8328
> > RIP: 0010:__free_one_page+0x1a1/0x6b0
> > Call Trace:
> >  <TASK>
> >  [<ffffffff913208bf>] free_one_page+0xaf/0x240
> >  [<ffffffff93973288>] deferred_free_pages+0xa8/0xd0
> >  [<ffffffff93971b4f>] deferred_init_memmap_chunk+0x10f/0x1b0
> >  [<ffffffff9396e265>] padata_mt_helper+0x65/0xa0
> >  [<ffffffff90fac402>] process_scheduled_works+0x202/0x410
> >  [<ffffffff90fae739>] worker_thread+0x1f9/0x2d0
> >  [<ffffffff90fb62fd>] kthread+0x27d/0x2f0
> >  [<ffffffff90fae540>] ? __pfx_worker_thread+0x10/0x10
> >  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
> >  [<ffffffff90efdc55>] ret_from_fork+0x145/0x280
> >  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
> >  [<ffffffff90e2e46a>] ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> >
> > deferred_init_memmap_chunk() interleaves initialization of struct pages
> > with freeing them. This works fine without KHO because free regions
> > will never be neighbors. However, with KHO, free memory will be split
> > into (free && scratch) and (free && !scratch), which can be neighbors.
> >
> > KHO scratch is aligned to CMA_MIN_ALIGNMENT_PAGES pages but buddy looks
> > at the neighborhood of MAX_ORDER_NR_PAGES pages. These values are
> > configurable but CMA_MIN_ALIGNMENT_PAGES is always less or equal to
> > MAX_ORDER_NR_PAGES. In the crashing configuration they were set as
> > follows:
> > CMA_MIN_ALIGNMENT_PAGES =3D 1 << 9
> > MAX_ORDER_NR_PAGES =3D 1 << 10
> >
> > So while freeing one chunk, buddy accessed uninitialized struct pages
> > from another chunk, tried to merge the blocks and crashed.
> >
> > To fix this, let's just align KHO scratch to MAX_ORDER_NR_PAGES pages.
> >
> > Fixes: c6073743d0c7 ("kho: make preserved pages compatible with deferre=
d struct page init")
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > ---
> > Unfortunately, this is very hard to catch, so I don't have a good
> > reproducer. But I run the code with the fix through extensive testing
> > and it seems fine.
> > I think I've never caught it before because enabling HUGETLB is what
> > causes CMA_MIN_ALIGNMENT_PAGES to be 1 << 9, instead of 1 << 10.
> >
> > If this passes review, please cherry-pick it to 7.2 so we don't release
> > a broken kernel.
>
> A changelog would be super helful here.

Sorry, forgot.

Changelog:
- functionally it's exactly the same
- changed SCRATCH_ALIGNMENT_BYTES to be calculated using
multiplication instead of binary shift
- updated the commit msg as Mike asked
- rebased on top of liveupdate/next

> Pasha
>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index 4834a809985a..175c08a6e41e 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -38,6 +38,16 @@
> >  #include "../kexec_internal.h"
> >  #include "kexec_handover_internal.h"
> >
> > +/*
> > + * This is the minimal alignment required by deferred struct page init=
.
> > + * deferred_init_memmap_chunk frees memory to the buddy allocator, whi=
ch looks
> > + * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> > + * If KHO scratch is not aligned to that value, buddy can access unini=
tialized
> > + * struct pages, which can cause a crash.
> > + */
> > +#define SCRATCH_ALIGNMENT_BYTES (PAGE_SIZE * MAX_ORDER_NR_PAGES)
> > +static_assert(SCRATCH_ALIGNMENT_BYTES >=3D CMA_MIN_ALIGNMENT_BYTES);
> > +
> >  /* The magic token for preserved pages */
> >  #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
> >
> > @@ -640,8 +650,8 @@ static void __init scratch_size_update(void)
> >        * Scratch areas are released as MIGRATE_CMA. Round them up to th=
e right
> >        * size.
> >        */
> > -     scratch_size_lowmem =3D round_up(scratch_size_lowmem, CMA_MIN_ALI=
GNMENT_BYTES);
> > -     scratch_size_global =3D round_up(scratch_size_global, CMA_MIN_ALI=
GNMENT_BYTES);
> > +     scratch_size_lowmem =3D round_up(scratch_size_lowmem, SCRATCH_ALI=
GNMENT_BYTES);
> > +     scratch_size_global =3D round_up(scratch_size_global, SCRATCH_ALI=
GNMENT_BYTES);
> >  }
> >
> >  static phys_addr_t __init scratch_size_node(int nid)
> > @@ -656,7 +666,7 @@ static phys_addr_t __init scratch_size_node(int nid=
)
> >               size =3D scratch_size_pernode;
> >       }
> >
> > -     return round_up(size, CMA_MIN_ALIGNMENT_BYTES);
> > +     return round_up(size, SCRATCH_ALIGNMENT_BYTES);
> >  }
> >
> >  /**
> > @@ -692,7 +702,7 @@ static void __init kho_reserve_scratch(void)
> >        * next kernel
> >        */
> >       size =3D scratch_size_lowmem;
> > -     addr =3D memblock_phys_alloc_range(size, CMA_MIN_ALIGNMENT_BYTES,=
 0,
> > +     addr =3D memblock_phys_alloc_range(size, SCRATCH_ALIGNMENT_BYTES,=
 0,
> >                                        ARCH_LOW_ADDRESS_LIMIT);
> >       if (!addr) {
> >               pr_err("Failed to reserve lowmem scratch buffer\n");
> > @@ -705,7 +715,7 @@ static void __init kho_reserve_scratch(void)
> >
> >       /* reserve large contiguous area for allocations without nid */
> >       size =3D scratch_size_global;
> > -     addr =3D memblock_phys_alloc(size, CMA_MIN_ALIGNMENT_BYTES);
> > +     addr =3D memblock_phys_alloc(size, SCRATCH_ALIGNMENT_BYTES);
> >       if (!addr) {
> >               pr_err("Failed to reserve global scratch buffer\n");
> >               goto err_free_scratch_areas;
> > @@ -721,7 +731,7 @@ static void __init kho_reserve_scratch(void)
> >        */
> >       for_each_node_state(nid, N_MEMORY) {
> >               size =3D scratch_size_node(nid);
> > -             addr =3D memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT=
_BYTES,
> > +             addr =3D memblock_alloc_range_nid(size, SCRATCH_ALIGNMENT=
_BYTES,
> >                                               0, MEMBLOCK_ALLOC_ACCESSI=
BLE,
> >                                               nid, true);
> >               if (!addr) {
> > --
> > 2.55.0.229.g6434b31f56-goog
> >


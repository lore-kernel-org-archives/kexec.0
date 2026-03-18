Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD613103E198
	for <kexec@archiver.kernel.org>; Wed, 18 Mar 2026 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O6gmeMVPdTQy9BEMRG9Pt8pp3Mke6GzH6nH2NXf+FRA=; b=0dGLko3ln16ndUGrw3TPVCOQZb
	cykc0NO3evXO2q3at6CiN2DNccYtO79GwVrAqpn2Sev1H3LURQrEa6I22GQIQpADVLAqNf8Ha+84h
	lZzAvHs1cEw0iWKSLti1VfS0d+u9OEnqgM94VNTQMlCVy7cOKtdsjs6ZS7gzN7TtMEpyrfzGSND3v
	lkO71KIuI22S8JNrPxQrP+VocVFv2lXB79pbftMr5ShY2FdmYB7rFTXGRyRbKhlz3KH0ogcT/7kor
	KaGbos5zW4jcM65en/pujQhjd0ccCbaHWW70rD+CyxNyE0LVA0PIU2Lk5mOfJHTTYrVon+YhqanOk
	xpTptwtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2t5Y-00000008knL-3A1U;
	Wed, 18 Mar 2026 15:45:40 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2t5W-00000008kmc-3YHa
	for kexec@lists.infradead.org;
	Wed, 18 Mar 2026 15:45:39 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-1270f10a774so10229c88.1
        for <kexec@lists.infradead.org>; Wed, 18 Mar 2026 08:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773848738; cv=none;
        d=google.com; s=arc-20240605;
        b=MCPl7oXEQIxmGm1YP14xu08Bpgg9fZh4fbWwr6O8swQKAHy2W7T751UdVVcjobV6bL
         N8/Oup4NNV1AazPdrQjrKEgmE/wXTI2c+vf2rKLHxR8FlxKTCqv/ZPpYiU+tcJl22+dB
         sKt+WZm+ZDUJokK8TzGlrg3zpaxonmI87/2EXI3AMxxikQfDOC//sLq5mMMymVYzUjNl
         bj3/LXsq0Ux4FdIqGkBUWtTagleeq02LBvzbKMOBSqixk59mSe0Dvl+peorOhX2WY3+B
         cmr5g/XOm52C3kr84PXtRr4euTzclDJQuhlP+OchA88qYEEnTZU5+RVj0ZyxoHLh5ej/
         Y+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O6gmeMVPdTQy9BEMRG9Pt8pp3Mke6GzH6nH2NXf+FRA=;
        fh=KBk9PCTNLWiOfJmyrRYtvJFMldKzeYWY0gWtSocyz60=;
        b=Zn/ARWg4ZiC4x15B6zsz7kc0OrhI+m4Nwo8+ffw/56RzNj4IkSX3aW3QY7ePMQF9Wj
         ELqAFm4jgkwlyJ0hGcepbJVc9ZY5RVCBfrGnkNfqvTzzpseYqILekNk8RgrlqpJEF9P3
         jsKPv3ft2j3f4Hfs67ZrLhUgbsleG1tSy+wJ6oSd9UGSmbePvWBQvZAevGUmzR+6hamR
         N8l1u8vC0t5ZdUT/6iifpOaT/8qya6SONibhfqO/vVEWBoo2dCHHKSTihp2jwwHJQPhK
         TqhkBwRrsX+YomuDD28OMTCMPOvUKnsHoycIUMkCMpUHzqH9YnYg67LkI4IGue4UsEZo
         BE0g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773848738; x=1774453538; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6gmeMVPdTQy9BEMRG9Pt8pp3Mke6GzH6nH2NXf+FRA=;
        b=bnzksLUGNuC0H3H/a40vk+QpJpQpzDU0bUB1kjVzQP9vPa164B+sVI22UhQ/jK7T8M
         uzjxSieQKW6vtGQXSedAd2xAPo8+nGliTMrgXv0Ba6TTQns35S8vdKSRztEAbe4MbQzA
         M7CGKzdC9dZQu7JNAOHHRwebOnlWah73aOqGXJfcIve0EZt/0+KRuRhFZax7f/IZc8EM
         EGh5vCi0c1fxXC5MKo/fPckioN5ROGkqKKJR/asxIi5x+Evz1yu5UBnJeUIn18UkGL5R
         pCuwDbbKss8qD8tLzCnONAPS+xtPidU3nh0whglzH2J+0FCgrYBoFiqIYmuRXcu5lQqa
         RKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773848738; x=1774453538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O6gmeMVPdTQy9BEMRG9Pt8pp3Mke6GzH6nH2NXf+FRA=;
        b=qRqnuXXaqX2sm/jAz7XSkh50XrWydTq8h/VbqgLyhVC0okAZgdfQiFUPbZduUvu6Ra
         C16TcAOgYNtzPItMgNAUGIuNqrtA57p7fNGt/Wyez1Elk0lkE8dT9t7WyLqlilDu4kZY
         Fk14oEqNOr8IyP6xlJWN4rRIPp/yOACHJaVSwBPjSF4Op8BEkwr3TfmN2ycB2izMOJX3
         E5ZeakFWprPOHWJo4DuhTWlWylqY/JjUOVsvwTWOs46nzH/25IrQHm1wdKjqIJF/Dgu1
         BoMvhiOTJOmXSxUgQpfC4JLbMEzDq1/5vhr7rjYpK1ydhkHoHG/DZHYF961XjcJhfOd5
         AxGg==
X-Forwarded-Encrypted: i=1; AJvYcCVhS/sGOU/49uV6uXRO94bQSMwRZY+Sx3dTM/SzDgNbWnAdrfINjOQERzgghLqmoovWsUMtQQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzUAj/9LOh20mQTaqvZ8FHLz1nsCkMn9f75B4rFDgazRl5Wgt2j
	ro+ziYXuk/YnnTXQYiXOZXkE1iuuqM4KRkAeU1WRUcZ4w1jX1dl3SHdnvKd6YN34hXxqnrJ0gQL
	oD2RWTxghnlrhBZOZAZMhtdMzWV02gTBs49971PNn
X-Gm-Gg: ATEYQzxmhR7NkVnxGswHoSAlRHDVGgHJOLWoDDsoH44+MlTOxMyQWTvgFa4YQUa/wdX
	G6HKAGs/xWVTkvZ0EhCmH9Y1JF5Qg1ss5NOP6Jtn1M7BYbFsuB8pq2goRXAjIJyZLK8IGjW0LO3
	UzHdq+ntj1YTj2FcSWpUQsYZ1XL4aXsD1u0uST/QGXcNBOFovBB0ZAarjrSICpvI2yqbuyLmnJF
	pXJx7+HWKeE2Q91antnnSJN+0z9TbCAw8QFIoGPcaoYLQ1oIB/EmM1+fHyHJ0Uzj7gGi85CHSwu
	GrwQ/Q==
X-Received: by 2002:a05:7022:158d:b0:120:5719:624e with SMTP id
 a92af1059eb24-12a11f010acmr183038c88.21.1773848737286; Wed, 18 Mar 2026
 08:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260317141534.815634-1-mclapinski@google.com>
 <20260317141534.815634-3-mclapinski@google.com> <AD9E1B18-C813-480E-894C-FEEB51EE8A93@nvidia.com>
 <CAAi7L5dSOxXETv-bYs4hJ1SfixMBQXS4fmfKs3SzVvQ=yY7oSg@mail.gmail.com> <76559EF5-8740-4691-8776-0ADD1CCBF2A4@nvidia.com>
In-Reply-To: <76559EF5-8740-4691-8776-0ADD1CCBF2A4@nvidia.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Wed, 18 Mar 2026 16:45:25 +0100
X-Gm-Features: AaiRm51mIhUJpu9fr7jrOrLMxLU9hXk7UnvNj60zpy5QVyfWqaaH2yeHe6cwuAQ
Message-ID: <CAAi7L5ex+66qgFzRkLDbuOmC=cVrMyBctPZv6wd15n1rc2U9KQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
To: Zi Yan <ziy@nvidia.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_084538_895011_4F7B8F31 
X-CRM114-Status: GOOD (  29.28  )
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

On Wed, Mar 18, 2026 at 4:26=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 18 Mar 2026, at 11:18, Micha=C5=82 C=C5=82api=C5=84ski wrote:
>
> > On Wed, Mar 18, 2026 at 4:10=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 17 Mar 2026, at 10:15, Michal Clapinski wrote:
> >>
> >>> Currently, if DEFERRED is enabled, kho_release_scratch will initializ=
e
> >>> the struct pages and set migratetype of kho scratch. Unless the whole
> >>> scratch fit below first_deferred_pfn, some of that will be overwritte=
n
> >>> either by deferred_init_pages or memmap_init_reserved_pages.
> >>>
> >>> To fix it, I modified kho_release_scratch to only set the migratetype
> >>> on already initialized pages. Then, modified init_pageblock_migratety=
pe
> >>> to set the migratetype to CMA if the page is located inside scratch.
> >>>
> >>> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> >>> ---
> >>>  include/linux/memblock.h           |  2 --
> >>>  kernel/liveupdate/kexec_handover.c | 10 ++++++----
> >>>  mm/memblock.c                      | 22 ----------------------
> >>>  mm/page_alloc.c                    |  7 +++++++
> >>>  4 files changed, 13 insertions(+), 28 deletions(-)
> >>>
> >>
> >> <snip>
> >>
> >>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>> index ee81f5c67c18..5ca078dde61d 100644
> >>> --- a/mm/page_alloc.c
> >>> +++ b/mm/page_alloc.c
> >>> @@ -55,6 +55,7 @@
> >>>  #include <linux/cacheinfo.h>
> >>>  #include <linux/pgalloc_tag.h>
> >>>  #include <linux/mmzone_lock.h>
> >>> +#include <linux/kexec_handover.h>
> >>>  #include <asm/div64.h>
> >>>  #include "internal.h"
> >>>  #include "shuffle.h"
> >>> @@ -549,6 +550,12 @@ void __meminit init_pageblock_migratetype(struct=
 page *page,
> >>>                    migratetype < MIGRATE_PCPTYPES))
> >>>               migratetype =3D MIGRATE_UNMOVABLE;
> >>>
> >>> +     /*
> >>> +      * Mark KHO scratch as CMA so no unmovable allocations are made=
 there.
> >>> +      */
> >>> +     if (unlikely(kho_scratch_overlap(page_to_phys(page), PAGE_SIZE)=
))
> >>> +             migratetype =3D MIGRATE_CMA;
> >>> +
> >>
> >> If this is only for deferred init code, why not put it in deferred_fre=
e_pages()?
> >> Otherwise, all init_pageblock_migratetype() callers need to pay the pe=
nalty
> >> of traversing kho_scratch array.
> >
> > Because reserve_bootmem_region() doesn't call deferred_free_pages().
> > So I would also have to modify it.
> >
> > And the early initialization won't pay the penalty of traversing the
> > kho_scratch array, since then kho_scratch is NULL.
>
> How about hugetlb_bootmem_init_migratetype(), init_cma_pageblock(),
> init_cma_reserved_pageblock(), __init_page_from_nid(), memmap_init_range(=
),
> __init_zone_device_page()?
>
> 1. are they having any PFN range overlapping with kho?
> 2. is kho_scratch NULL for them?
>
> 1 tells us whether putting code in init_pageblock_migratetype() could sav=
e
> the hassle of changing all above locations.
> 2 tells us how many callers are affected by traversing kho_scratch.

I could try answering those questions but

1. I'm new to this and I'm not sure how correct the answers will be.

2. If you're not using CONFIG_KEXEC_HANDOVER, the performance penalty
will be zero.
If you are using it, currently you have to disable
CONFIG_DEFERRED_STRUCT_PAGE_INIT and the performance hit from this is
far, far greater. This solution saves 0.5s on my setup (100GB of
memory). We can always improve the performance further in the future.

> Thanks.
>
> Best Regards,
> Yan, Zi


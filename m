Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC56103E195
	for <kexec@archiver.kernel.org>; Wed, 18 Mar 2026 15:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zJSXdmrQV+K79VmgmeCa/oY/xkKliZyOXrkXdpiFNNY=; b=P3ybfWCz8PvmN2MYJm5v6/x/Vb
	BxuEZQ86f8TFoJJ3NbLCgoaVBRjDyTjvba6ACgnVAcbbqFeCEWSm1Wrcu9OILfII5S7KofkS5Q1p0
	oliuVOO9cwAb6/7jvhTSCwmpy5/LRYCd6jdy/o+8F/e5dhp60hXDvYoGH16yVgh7ZM2aFUtmvibj9
	q0rdEJe9DdiLvKEKfMtNqsI1/WRVAfbA+2oSe6ZRUl0X/xE5V9rWImh7GpdmaTlgVF14AuPBnl7On
	db5JrB4ctwfXczYjUez+07t/j0UZD7mYWQrEz5BZHGVa+buU3DBR6vQZOT1IFVXGpf0tBb1dx6Efo
	w52vSL+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2sfc-00000008gf4-0UH6;
	Wed, 18 Mar 2026 15:18:52 +0000
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2sfZ-00000008geS-3Fea
	for kexec@lists.infradead.org;
	Wed, 18 Mar 2026 15:18:50 +0000
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-128ce536fe0so12235c88.0
        for <kexec@lists.infradead.org>; Wed, 18 Mar 2026 08:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773847129; cv=none;
        d=google.com; s=arc-20240605;
        b=HPNA+cB+EkjxV7A4PqqSYTj301lAK/5/HITPmtAPCd1+Ecnh4uY9Dav8cwF4TjNElB
         9mQe8M0SMYrjvfyeId+VlTs6VQX7dbsyb2P0BWfXNIxvRhYceGLazZYpjtEL8JRXAnMe
         QkvnaiMQKJ5qDB+tMo4fk5nzYSgjKxCil7ny14h3QFOJQ3Sk+CHdC6mGW4cFMtJc596G
         2zL4fx31dV7hZdr1yCg604SQsIqk2424sIeKZh2xun/OwsE7DYJOUojffxjp25nD0KSz
         qixtzQ3zg6CDR+2H+64nS2QsigwhGq+OYR+L/ap5WUtKbFal39vfaFYVC1OPWyot94kz
         M2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJSXdmrQV+K79VmgmeCa/oY/xkKliZyOXrkXdpiFNNY=;
        fh=Grrr0Kocl3kIY8nO18/lBM52sBKYWe9O0JbHQ2k8dXQ=;
        b=POrb1I7kfKwjOq0wYp5laL53x19IVKVglCK7TX6sWP8xYCnSiB37iohzWddZjOsmUK
         1gAkCLtTohPuFqJ1syKqlFDuJnlt2YjIGinDzzEd+Wy1VkH47tnffQokS9jvhqXpo1im
         ruQthskVDpEWLEYoMJexUX6O2yd5QOtZOS9FBMCpbRndlmcOxaHHCK8b8nOInhw3qSbT
         5F89c9dBWAv2/XM3BSPIgJ712CvWeeryhM3pyb/Os0CP6X25dDxcJWsXDJWhRn0YzpxU
         sddr7pTQ/c6BkhPRvphPlzw6lD1AKLAvvDalXU5nhcojlZwHeHKQpX0RYgaNPEfniz7g
         XN9Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773847129; x=1774451929; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJSXdmrQV+K79VmgmeCa/oY/xkKliZyOXrkXdpiFNNY=;
        b=Lx3mivpXXpV6KewQaSjfUowrKEUbiOKqrLqs3aW7y5h429o/ZF3NV/MJCNVJkwUOpi
         QJ+Y5LdF9nj6YU5pd2dhAWZirBMub78PBUSrVR2oHVjEFXs9VP1Wwh/xQ6WvZb17ecwm
         ZoqbPPZ+O2Tp1kjRTkSXhxo1y2qGZewyP3H+P8gjJ41qpHWMMN8DD/QL4HyUMevPsY/U
         Z8ZEq14qiVdJv3TUSXe4phUlcAnracRrGVaBCJVbmsunHD/4YctVVd2fAT/oXIR0op8T
         LgScPTlzsKWk5hJ/z5uLBXcCAICz9/e2PX/QK9cRJLD0V7Xi4FHRjM2jRBZmgx0m23V4
         eO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773847129; x=1774451929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJSXdmrQV+K79VmgmeCa/oY/xkKliZyOXrkXdpiFNNY=;
        b=eNFqhl4A1s6l3klH6oLQoSkz05PgBHWqDzTb9FP8oieKCpQtUKepq3jlm0esK+EZnJ
         5TpAY4jUATHpQ91AJ9L3xs0K74sLV+d7nsfQJ+0eUh45B4ytwewufuYKuBoBNJGaQzXE
         nt/xAJWBMsMETDq0hVxXlY+6pfq+mpohI9q37M4E7E2OapkvejPcxNjK3u+eXWMCeoVl
         3p1UZh5YEf4GPGTvrWx1pRDK+2ARlETnaVa4TEt5KY7vgPQZ5ANL3h0zOyLAF8D56Zsi
         AbZkNvvlL8bwzPpMCe5meJ7+oXKoA6cp5AC7rSz+dKlhQ0si4y8mQT1qwVs9VrihzlNl
         WVww==
X-Forwarded-Encrypted: i=1; AJvYcCXN2HpH7Z96ku2pFUFwThuXQaEe59yFu8CsvgLmoE5lgmFjk8rlrn67CMP9xdUtgD6Oi/YQpQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5XTqm/qO0+HV+zSBIfW3Ls/wxudVnwFcTDYhUCC42PZIek3ZY
	md1aV+6KwQ+ecQ5JALZTw3rQWBljd6c7TxPsvLW4zTAZ2kYk/oESq59vvHmIdQ6QVXWvpkyIXEe
	Js/LosX7vudleF7Eag4QMoXasDsneAF3Zww98fIfO
X-Gm-Gg: ATEYQzymBXWqFqWJLPUsE/ckniIX7j73A0tgUGf5F+UndlbjcfZKLRrBYMufMZfe0N9
	eFOUQf5ZksUvVD2UE4mpuTFjLUlptj9IKfmtD/T1zgDE1mK3L7gm9WhqQf9NMHedL3GrCLdqXF5
	vBVA2Zs2StaXExXkVNoukml1Z/Rfhp52ZJ7J4mkVlXXOyywM9aRF/Z/+CzFQnuC3CuUfvmW5BQj
	Dx0EdGgFH37THbKM0vXpAuxy/Fhh+1tjLyEd8OK104rjvseOj656FQDCZoo5xtLeuUGINZeDi47
	ZZ1nRg==
X-Received: by 2002:a05:7022:e1d:b0:129:e9f:4c09 with SMTP id
 a92af1059eb24-129c58964b6mr256844c88.6.1773847128064; Wed, 18 Mar 2026
 08:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260317141534.815634-1-mclapinski@google.com>
 <20260317141534.815634-3-mclapinski@google.com> <AD9E1B18-C813-480E-894C-FEEB51EE8A93@nvidia.com>
In-Reply-To: <AD9E1B18-C813-480E-894C-FEEB51EE8A93@nvidia.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Wed, 18 Mar 2026 16:18:36 +0100
X-Gm-Features: AaiRm531JN35mo1Mbe2KYhEsq0xf4gyOI0iQIVc6Zhg91-Z5R0b7EOHbR97JHD8
Message-ID: <CAAi7L5dSOxXETv-bYs4hJ1SfixMBQXS4fmfKs3SzVvQ=yY7oSg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
To: Zi Yan <ziy@nvidia.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_081849_814373_DDA7CF83 
X-CRM114-Status: GOOD (  22.65  )
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

On Wed, Mar 18, 2026 at 4:10=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 17 Mar 2026, at 10:15, Michal Clapinski wrote:
>
> > Currently, if DEFERRED is enabled, kho_release_scratch will initialize
> > the struct pages and set migratetype of kho scratch. Unless the whole
> > scratch fit below first_deferred_pfn, some of that will be overwritten
> > either by deferred_init_pages or memmap_init_reserved_pages.
> >
> > To fix it, I modified kho_release_scratch to only set the migratetype
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
>
> <snip>
>
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
> If this is only for deferred init code, why not put it in deferred_free_p=
ages()?
> Otherwise, all init_pageblock_migratetype() callers need to pay the penal=
ty
> of traversing kho_scratch array.

Because reserve_bootmem_region() doesn't call deferred_free_pages().
So I would also have to modify it.

And the early initialization won't pay the penalty of traversing the
kho_scratch array, since then kho_scratch is NULL.

> >       flags =3D migratetype;
> >
> >  #ifdef CONFIG_MEMORY_ISOLATION
>
>
>
> Best Regards,
> Yan, Zi


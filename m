Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F14AD609AA
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kyhO0Vu8BVEr0KLG4JdHSpLvhjfSxro5PtVmRdfvFt0=; b=tbQUTxHfedhPvt4uxDN5lJ+fkh
	wioRQTYTUEulk0NntM/GtUAVLf8ep6h/GvTG19tCHsEBpFpGyfB6EBsP/IFRmLZFcl0OZEHbjVRQF
	aPCqT/yRRSWikslGgoe1VqmweHAcr5m9iYBVxeQdrOu82OzhV32Sg+vNI2nerVcQ5F6P0qVVtD2K+
	veYV9yeaBiBkAd0lpztRrhHRe/MozN3daLJdOoewQdIrdKvoJwqhhIW44kdAirjl6VW80SWcG3b3e
	ACfKUs2zlzqi6rYrIR1XHLijgdJss6ScWErFxx+QOG53A1rH2OFO9Z4ewAeWvWc6e0uaGFotJvFbX
	skbGj5pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVX6Q-00000005SZt-1y72;
	Tue, 16 Dec 2025 15:36:42 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVX6O-00000005SZN-1fo8
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 15:36:41 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so8957553a12.0
        for <kexec@lists.infradead.org>; Tue, 16 Dec 2025 07:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1765899398; x=1766504198; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyhO0Vu8BVEr0KLG4JdHSpLvhjfSxro5PtVmRdfvFt0=;
        b=D7wrajoGMSnpE4UbFbGTFxNhS8OkiwRbN8j9kzc3zVGC9MIvkY7ihjfpqj92Hy4VEL
         s+hYLD5PNLkjSiZYtHoNTu/4EdFzAhAPwe03v14DAYOUkgt0+wxRAvGMsDulFsfzhrm9
         I9Czn979yeRoPDqTvfYwL/EyNgWXFzUInbY42yZ82BJWAeK8ZiHKdBv/r5dYsq3eX3br
         MliJQOba8yy4HM9DcUWJ9Dvq2/VT/lXICNKzdxT25KtQtM9aYOeD6LSOlCm5JL/LXv/R
         DiLn/wmS3yqb4mPefazv0fu3i0PJsnfonJdJ4GnEKHVXnHELx9+FnvglE5Wad+xo6RwY
         Qb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765899398; x=1766504198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kyhO0Vu8BVEr0KLG4JdHSpLvhjfSxro5PtVmRdfvFt0=;
        b=dfdMVFvMTbwVBhmMSxZ/fsB2f+creFw6jnHN4j+BSNdzbLEAWNSQ/OyspWiOW5OvWA
         942nZCKnqGtnwkcFq3xlNVMhH9bRJ6QGgT1BsoqnfU0ggb3VFeOpxcew3SiT9+TIsHqR
         GbehcJnqStNO78VUyY+2FP5JndcqSDgTD6oTKYWW2BMsa90CN/xzbN+fyjSVDBXaqe88
         U2fAALK81o+eCEM+Le3BJscVvDcNozbzR7Hjaa6CDYzfc/RbgkizG/C4Wbi6/B9H1mEj
         YmBDiVUPaYxZIwwWM1ULEDmq3LU5+Nou/nmEYzjiaZR1WcU08YdcJ/TSTAV/CKizLDL3
         W1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVct7olgLzJ5pHpICENFby5zODk/yItC/tlhG4bf4jpNFTc5X6dgxUE5j+Evmy9wYGmwyawGQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywc+duriWkHEw4wbBnQSnEXY1sz/i5RFfNYDC7nwjQloWoiNh+x
	/CraBTY8usTXPHfxcWps5230sZAzDxw0qEYvmZKEiHkQy4oJN7moJyP3or/gljh7gsNrtqZCoVI
	rPn7gyDPwo1DUvYa0Grfow6oYncOStDqcoh+7Ytv5Bw==
X-Gm-Gg: AY/fxX6L9AXiP05/I+H5vcHlOn4UV4bC5CHVU+u0QSgaK/w3hCDUOyo8f0AMkOPFYHp
	W5Qg1ALU43BOCiS/Hrd/X7ODvku8x7UkUzCglRo5DFHzemOC9Nv2Fb1xVjZlHC4nzhA54THfgVX
	2+L6vV8MF5scZLCZxHZBd9xgzMsSXqWswzXrGAYvH/AWiRvHjV0Q/+9lfKg+ppcn9DRKAoTop1e
	qh+U7tcQ4wfX/GDtVTWyI7zkTqJechaPJnj2EaqFhsIldwCydgOEZ9Bn+X6KFgRpiwDhyfjQI3/
	P0yAFdQS08Gbee+QzJGBsmCq
X-Google-Smtp-Source: AGHT+IF1mzYKz9Pi/RdrX2W8Uy/2n5vpRPoElJEou5SB9bjQFnA433sUpyNaSnQczRJ6sW3Cz+taBB6TZqfVtRlhV4E=
X-Received: by 2002:a05:6402:2114:b0:640:947e:70ce with SMTP id
 4fb4d7f45d1cf-6499b12ff90mr15987210a12.5.1765899398395; Tue, 16 Dec 2025
 07:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20251216084913.86342-1-epetron@amazon.de> <aUFJH9xzJXYOt_X8@kernel.org>
 <CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com> <aUF4fsWwD9BswkFh@kernel.org>
In-Reply-To: <aUF4fsWwD9BswkFh@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 16 Dec 2025 10:36:01 -0500
X-Gm-Features: AQt7F2oykeBYe_aO9TrNeO_QmB0iVwu16-Lrz5T79UiOUKv88gfkA_WI_X2fFTw
Message-ID: <CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
To: Mike Rapoport <rppt@kernel.org>
Cc: Evangelos Petrongonas <epetron@amazon.de>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_073640_462023_5EB04DCC 
X-CRM114-Status: GOOD (  21.49  )
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

On Tue, Dec 16, 2025 at 10:19=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Tue, Dec 16, 2025 at 10:05:27AM -0500, Pasha Tatashin wrote:
> > > > +static struct page *__init kho_get_preserved_page(phys_addr_t phys=
,
> > > > +                                               unsigned int order)
> > > > +{
> > > > +     unsigned long pfn =3D PHYS_PFN(phys);
> > > > +     int nid =3D early_pfn_to_nid(pfn);
> > > > +
> > > > +     for (int i =3D 0; i < (1 << order); i++)
> > > > +             init_deferred_page(pfn + i, nid);
> > >
> > > This will skip pages below node->first_deferred_pfn, we need to use
> > > __init_page_from_nid() here.
> >
> > Mike, but those struct pages should be initialized early anyway. If
> > they are not yet initialized we have a problem, as they are going to
> > be re-initialized later.
>
> Can say I understand your point. Which pages should be initialized earlt?

All pages below node->first_deferred_pfn.

> And which pages will be reinitialized?

kho_memory_init() is called after free_area_init() (which calls
memmap_init_range to initialize low memory struct pages). So, if we
use __init_page_from_nid() as suggested, we would be blindly running
__init_single_page() again on those low-memory pages that
memmap_init_range() already set up. This would cause double
initialization and corruptions due to losing the order information.

> > > > +
> > > > +     return pfn_to_page(pfn);
> > > > +}
> > > > +
> > > >  static void __init deserialize_bitmap(unsigned int order,
> > > >                                     struct khoser_mem_bitmap_ptr *e=
lm)
> > > >  {
> > > > @@ -449,7 +466,7 @@ static void __init deserialize_bitmap(unsigned =
int order,
> > > >               int sz =3D 1 << (order + PAGE_SHIFT);
> > > >               phys_addr_t phys =3D
> > > >                       elm->phys_start + (bit << (order + PAGE_SHIFT=
));
> > > > -             struct page *page =3D phys_to_page(phys);
> > > > +             struct page *page =3D kho_get_preserved_page(phys, or=
der);
> > >
> > > I think it's better to initialize deferred struct pages later in
> > > kho_restore_page. deserialize_bitmap() runs before SMP and it already=
 does
> >
> > The KHO memory should still be accessible early in boot, right?
>
> The memory is accessible. And we anyway should not use struct page for
> preserved memory before kho_restore_{folio,pages}.

This makes sense, what happens if someone calls kho_restore_folio()
before deferred pages are initialized?


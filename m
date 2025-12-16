Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729C2D609B0
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 15:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QXxGblJuerDWpBcIOypq80sXY6o3+TxONi+Sc9tFnGs=; b=nfb+TUdJKFj+O6x5RJd/f1xwr1
	9+v+YMIs+Crs68ND4ZmiB6crNELI2LO3Q2edQOZL+qktt//3hdN2FvColeopBB4hVGghmjiHnRQ3m
	/yr8Znwd18tIsYo99H4JCh9ujXb037EgCb5wMVTIC7Kr2td6FlfVEIOvm/IQO2hmFVRoplVe03dJt
	8eGFQ3i93+Z9dc6UiEWC0s62s43sCHva4lk68u749UpKpobzuKW2iMsZUSBib+sGH5I2mJPmXP/Nz
	xFOiZBq+6IM5FnAeAO71T4Dd7HkKfT4bkMvSUKiZw1les4fB1R1k96S19g6O8Qhftqha9wPpRke6X
	S1rVdsiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVXLs-00000005U22-1zeN;
	Tue, 16 Dec 2025 15:52:40 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVXLo-00000005U0o-2Xlj
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 15:52:38 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-b7eff205947so393792266b.1
        for <kexec@lists.infradead.org>; Tue, 16 Dec 2025 07:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1765900355; x=1766505155; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXxGblJuerDWpBcIOypq80sXY6o3+TxONi+Sc9tFnGs=;
        b=OysqBbYJrQtSnSEFFoaNd9XHdL38j1POrhLIKytePdSXDpKkNwofFVFCbZBnQWaYks
         uZVn/aOZe2j5fDnOk97tVHGt2RbcMW+Hdwlnr4tHEWAZ/35SUg3QQxrlyVODj0TevU3p
         bDgZmr6dnLalsws+8rtFukx25i3XCM8Vd4Hz9t4TuNg/PPop/fvCOWyKJK0dcybrq8he
         tZuMW7pu4RKF/VNQu89E2UBTXowCZG0fi6idMEkGMRFm9ihQ1JRCaAtA1TV2g8ixBSPA
         /VbonQsTqNJ4rcGQScu1JBy5CQaZYdnR+dvYU+5WzCywKMcRQoaMOKaxKDC8tFmb5k5/
         7nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765900355; x=1766505155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXxGblJuerDWpBcIOypq80sXY6o3+TxONi+Sc9tFnGs=;
        b=VH9AKaFQahos3mEIdmANUxk+zD8pQRjI08VVgaqD782eYRAk2TVGhMKfK0lZY/wvUO
         +og4fFR93dERobIFUMgwlYaB+8FF8x9xyLWVflGG/XA2+++OHqUVgZogdHonQQXe/Tx3
         jNY7DIhMNnR6pCdpRy3PCP+TSnUbSUySjmEoW/2dZbMMZYmhWw8IjnvEKy6zRCDHLpCs
         Momk15NytKdWJXt68zQj+UOp4gX4G1HI5hYSiyBWXHUzE4K06C2Sz/2PuyedQnsKJGzX
         UfIZa2AlSXIsY8YBEUlhY28YQNNfpwpEXaNb/PG5N5lN6SPmhBENWTGwqUwUMRcuLxNJ
         N3PA==
X-Forwarded-Encrypted: i=1; AJvYcCVHYte2uGHwh4aMkxA6UGE0PVVbAvFHedbEjVG3SaTVFmL/OwjYo1xYs3jhaF8euyGNfFMg9Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwmP0IpJW4X7aff1F6ncRuoRfJM1vkMhKJDJqnr8V00FoNHbq/P
	sgNRqcaxp3nGahgvqmLgIspehiKbMGk20vYGce0Rw6HuX7RdnruQB7s1iihFV/F9fZFnOjoUyhK
	miVa1xYhFOMkaS1bcyuopudCXKepvn/fLUoixDkSzQg==
X-Gm-Gg: AY/fxX4d1NocIhPSvkGvh1BzaGlDxjCbDSDjxheg/fXNBkNOP0b7AWaOQNzU6P7l6OS
	SYMeQlTodL8l9fkvoD5t4dmohCqTe+o8OwN7OLXGZiDwR6Q4q83cGRT3FfCuBST/oOFT23eDPgT
	IPBrmHJRYM2lFgslzEkhoqklmaEuAsMnME7IZ1Wpg0Cz4ln6LYSBmMt+Yy/nLzv93cHZXQAMYZw
	ibz4oGno/lYSgwpWtglVOEl4Kf4VQ+HleaYMayjLzs7jyboH4cZ/XF7PZ0HuV2NnzwJBfaSo0Gw
	+NMt2cw/CPD67Q+qOXbQYXua
X-Google-Smtp-Source: AGHT+IF8hUf/njs47ssOWxWrTAtN9SW44kkMcdwp9wLrZso0GjDwC7fAR8uTmXjFxwWpMLXPrdui4riC4+4Ir5L8T5c=
X-Received: by 2002:a17:907:3f21:b0:b76:f57a:b0a7 with SMTP id
 a640c23a62f3a-b7d238caf7dmr1725050066b.31.1765900354456; Tue, 16 Dec 2025
 07:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20251216084913.86342-1-epetron@amazon.de> <aUFJH9xzJXYOt_X8@kernel.org>
 <CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
 <aUF4fsWwD9BswkFh@kernel.org> <CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
In-Reply-To: <CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 16 Dec 2025 10:51:57 -0500
X-Gm-Features: AQt7F2oVU79Y7RmiV1TRfmRsHfWXG1IqX56Yslo2Aowm0vb9rvseAzO_YZsWkZw
Message-ID: <CA+CK2bDLkf=5Mk0XH2XvUFS1px4cROBRjO+eKd4zvgzrS=Z-xA@mail.gmail.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
To: Mike Rapoport <rppt@kernel.org>
Cc: Evangelos Petrongonas <epetron@amazon.de>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_075236_662768_BF8B9B75 
X-CRM114-Status: GOOD (  25.94  )
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

On Tue, Dec 16, 2025 at 10:36=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Tue, Dec 16, 2025 at 10:19=E2=80=AFAM Mike Rapoport <rppt@kernel.org> =
wrote:
> >
> > On Tue, Dec 16, 2025 at 10:05:27AM -0500, Pasha Tatashin wrote:
> > > > > +static struct page *__init kho_get_preserved_page(phys_addr_t ph=
ys,
> > > > > +                                               unsigned int orde=
r)
> > > > > +{
> > > > > +     unsigned long pfn =3D PHYS_PFN(phys);
> > > > > +     int nid =3D early_pfn_to_nid(pfn);
> > > > > +
> > > > > +     for (int i =3D 0; i < (1 << order); i++)
> > > > > +             init_deferred_page(pfn + i, nid);
> > > >
> > > > This will skip pages below node->first_deferred_pfn, we need to use
> > > > __init_page_from_nid() here.
> > >
> > > Mike, but those struct pages should be initialized early anyway. If
> > > they are not yet initialized we have a problem, as they are going to
> > > be re-initialized later.
> >
> > Can say I understand your point. Which pages should be initialized earl=
t?
>
> All pages below node->first_deferred_pfn.
>
> > And which pages will be reinitialized?
>
> kho_memory_init() is called after free_area_init() (which calls
> memmap_init_range to initialize low memory struct pages). So, if we
> use __init_page_from_nid() as suggested, we would be blindly running
> __init_single_page() again on those low-memory pages that
> memmap_init_range() already set up. This would cause double
> initialization and corruptions due to losing the order information.
>
> > > > > +
> > > > > +     return pfn_to_page(pfn);
> > > > > +}
> > > > > +
> > > > >  static void __init deserialize_bitmap(unsigned int order,
> > > > >                                     struct khoser_mem_bitmap_ptr =
*elm)
> > > > >  {
> > > > > @@ -449,7 +466,7 @@ static void __init deserialize_bitmap(unsigne=
d int order,
> > > > >               int sz =3D 1 << (order + PAGE_SHIFT);
> > > > >               phys_addr_t phys =3D
> > > > >                       elm->phys_start + (bit << (order + PAGE_SHI=
FT));
> > > > > -             struct page *page =3D phys_to_page(phys);
> > > > > +             struct page *page =3D kho_get_preserved_page(phys, =
order);
> > > >
> > > > I think it's better to initialize deferred struct pages later in
> > > > kho_restore_page. deserialize_bitmap() runs before SMP and it alrea=
dy does
> > >
> > > The KHO memory should still be accessible early in boot, right?
> >
> > The memory is accessible. And we anyway should not use struct page for
> > preserved memory before kho_restore_{folio,pages}.
>
> This makes sense, what happens if someone calls kho_restore_folio()
> before deferred pages are initialized?

I looked at your repo. I think what you're proposing makes sense, and
indeed it will provide a performance boost if some of the folios are
restored in parallel. Just kho_init_deferred_pages() should be using
init_deferred_page() to avoid re-initializing the lower memory pages.
Also, I am still wondering how it will work with HVO, but I need to
take a look at Pratyuh's series for that.

Thanks,
Pasha


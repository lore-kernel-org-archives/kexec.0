Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E978D7879C
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HTr2kO3AH5aV44rgROvP5AMfNOh764zNrIB60vgO1zc=; b=oW6s+TG6E8q1SnI4+wGeVpnxyP
	qM63ZEXkhxg8o/Z9/qkYC3w6cKr6DZim3TVnVuXljK+tDE48HbOqZHOnTBzzZNnOaPYhV7MevF2S5
	PCui7gysTdYzAXn69eZqQm0AXRK4iJFk7RyzC1G04C2bQN1B7ONaz/L4c8lQ8dBUmgrLo1QbQUbwj
	gKzq+JpgTHBZ6sb3w/wqA2SsMHSjoM5yl2T+heuG7mBZkQ4Q1p9k9cO/TCFgr89xeyZfcEOIMOrds
	GRgVsUxMSbPxvm+zpJOBcLSqyrwxz3yA7tFJFr34UL9QacjV4Qg0ivjJ/U2pLo/uFmV7t75EHkPFj
	TzwsXVSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWdMA-0000000AeHJ-2TYt;
	Fri, 19 Dec 2025 16:29:30 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWdM7-0000000AeGs-38ZD
	for kexec@lists.infradead.org;
	Fri, 19 Dec 2025 16:29:29 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-b7633027cb2so342155266b.1
        for <kexec@lists.infradead.org>; Fri, 19 Dec 2025 08:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766161766; x=1766766566; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTr2kO3AH5aV44rgROvP5AMfNOh764zNrIB60vgO1zc=;
        b=XkjB/NsjBeHPCZHYam9nFi6C5V59asVnkopmhRWN5phvQ0RrQEu4vZtb1WYgXdDefH
         kfKaeHGAcWbxvnmSggp/OMirPAALwQjBc6rfsqIkgt32fw2CNusnS9+VEnwCT9GMirij
         ntn11r9CPepMYgy5viAWckGidedpUx90q4malIvEVIUMmQRuVWz2CCuwatBgBubYiOHl
         toicvSd8PrZAwJ8fO3rkj1JP3C8ISLSb08za6mfp0NY7+YqNJ/Hlwby05vYkk6rRKHiX
         DZpA0+rPMnwmYQmgHj/1M5n/Fi8CHSDOWa+6+2L0BQLuzFQ12+B7MNbw1YAsWB9ajEbw
         Qyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766161766; x=1766766566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HTr2kO3AH5aV44rgROvP5AMfNOh764zNrIB60vgO1zc=;
        b=henleO73QOUqKB+CR3zZg1xlbD5dYUhuFyvAeBFgCYyyLaV4Zd4OvNFuHTP4FVOG7z
         RP7uWos4a97alP2o5TUfkF51DPz3Vr+n2XTn0jVnGzQwnqS+kU9XcI2gTqD+6teoq6Bk
         QsC3BrJ+Woll92ZfJGLXtGTQr2kHoG2Jm9RgTNLA+zKqzrJTon3ZIc/2H7xPqKXgX0LV
         7SwWdy0ixsALj8O36oBjdlb7GqKE662i92fqjd8tBHMYS5gY5fGkXV75ICM8nng8T+dN
         p03I2wPl3vMGKPUovaA5NBCneozMD0Mjv7sCnJS0xFOk14emttwVFegGr6XpnYLM+2tL
         fKXw==
X-Forwarded-Encrypted: i=1; AJvYcCWZDXQv8zRQ6U4s4xX7DxAhezuUGGszTUeTIaajQJ1GaySNkda4/rL2qspUqcoBfRAyUDTxYA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZ4WqJpEnLp+/9VS1IcEMrXlgVzVj1RnrbNw0Xsjn/baCkPYRp
	UEz/OI2/Nh9lbc1fqZBpHwAAibrBXCO2fhdgo3R0mw+pj8CODdQMgJwk9E9vEjixWOcMmoz+T04
	g1mPekAzfbn806WmngYR5DeHyxIXSgEjRnTwwjfTO1A==
X-Gm-Gg: AY/fxX5gTc1n0CoBxy7A5DO/pBlJn+3VSgcqz+8IAMhAp8d5+stzm+NJBV6z3aLM9zg
	7Gpsr0J/sn9EYeVCIMwIjdF3HILijJZD7jNZSIsJc6SH8DP6ERClCxLWFH/6jlVgbiPeya4Q3le
	LCEs46MIgeEE6AJIoEIciMwq/oJfsadbpQT6RW4vXsR924IM2qTxpMt139z/L1Rv+zopd2K0YhD
	xNmPiaiDWViChO+r7QNCJOenK7ZGD7Ahj0BbK/IzyUKpELtyw1m6vn9ZT+33FN6R7lrhZuGRI0o
	Jgwh03k24N69rZSgEd9pVCfp
X-Google-Smtp-Source: AGHT+IGofUtuvCgN109UZF/PypAnhjEWl72HM9EdTQ1Wf1lQtHMZjSd97H5VK6s4AyDQ+AGPgIsUiET6kxIVyVyiVZo=
X-Received: by 2002:a17:907:1b15:b0:b76:2517:6927 with SMTP id
 a640c23a62f3a-b80371d46bbmr380301766b.43.1766161765744; Fri, 19 Dec 2025
 08:29:25 -0800 (PST)
MIME-Version: 1.0
References: <20251216084913.86342-1-epetron@amazon.de> <aUFJH9xzJXYOt_X8@kernel.org>
 <CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
 <aUF4fsWwD9BswkFh@kernel.org> <CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
 <aUUYprAotKYMiEs0@kernel.org>
In-Reply-To: <aUUYprAotKYMiEs0@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 19 Dec 2025 11:28:50 -0500
X-Gm-Features: AQt7F2pTd4wK3RRR8DuXPyTXo-EBR6g4IBaYL5wdaMP_cdEs620s97K7y3D5Xr0
Message-ID: <CA+CK2bD101cSC_7+OWkMei2QvUVjSaRLy+LboLe8Sz7KS3by4g@mail.gmail.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
To: Mike Rapoport <rppt@kernel.org>
Cc: Evangelos Petrongonas <epetron@amazon.de>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_082927_824222_C3CBEF50 
X-CRM114-Status: GOOD (  31.13  )
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

On Fri, Dec 19, 2025 at 4:19=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Dec 16, 2025 at 10:36:01AM -0500, Pasha Tatashin wrote:
> > On Tue, Dec 16, 2025 at 10:19=E2=80=AFAM Mike Rapoport <rppt@kernel.org=
> wrote:
> > >
> > > On Tue, Dec 16, 2025 at 10:05:27AM -0500, Pasha Tatashin wrote:
> > > > > > +static struct page *__init kho_get_preserved_page(phys_addr_t =
phys,
> > > > > > +                                               unsigned int or=
der)
> > > > > > +{
> > > > > > +     unsigned long pfn =3D PHYS_PFN(phys);
> > > > > > +     int nid =3D early_pfn_to_nid(pfn);
> > > > > > +
> > > > > > +     for (int i =3D 0; i < (1 << order); i++)
> > > > > > +             init_deferred_page(pfn + i, nid);
> > > > >
> > > > > This will skip pages below node->first_deferred_pfn, we need to u=
se
> > > > > __init_page_from_nid() here.
> > > >
> > > > Mike, but those struct pages should be initialized early anyway. If
> > > > they are not yet initialized we have a problem, as they are going t=
o
> > > > be re-initialized later.
> > >
> > > Can say I understand your point. Which pages should be initialized ea=
rlt?
> >
> > All pages below node->first_deferred_pfn.
> >
> > > And which pages will be reinitialized?
> >
> > kho_memory_init() is called after free_area_init() (which calls
> > memmap_init_range to initialize low memory struct pages). So, if we
> > use __init_page_from_nid() as suggested, we would be blindly running
> > __init_single_page() again on those low-memory pages that
> > memmap_init_range() already set up. This would cause double
> > initialization and corruptions due to losing the order information.
> >
> > > > > > +
> > > > > > +     return pfn_to_page(pfn);
> > > > > > +}
> > > > > > +
> > > > > >  static void __init deserialize_bitmap(unsigned int order,
> > > > > >                                     struct khoser_mem_bitmap_pt=
r *elm)
> > > > > >  {
> > > > > > @@ -449,7 +466,7 @@ static void __init deserialize_bitmap(unsig=
ned int order,
> > > > > >               int sz =3D 1 << (order + PAGE_SHIFT);
> > > > > >               phys_addr_t phys =3D
> > > > > >                       elm->phys_start + (bit << (order + PAGE_S=
HIFT));
> > > > > > -             struct page *page =3D phys_to_page(phys);
> > > > > > +             struct page *page =3D kho_get_preserved_page(phys=
, order);
> > > > >
> > > > > I think it's better to initialize deferred struct pages later in
> > > > > kho_restore_page. deserialize_bitmap() runs before SMP and it alr=
eady does
> > > >
> > > > The KHO memory should still be accessible early in boot, right?
> > >
> > > The memory is accessible. And we anyway should not use struct page fo=
r
> > > preserved memory before kho_restore_{folio,pages}.
> >
> > This makes sense, what happens if someone calls kho_restore_folio()
> > before deferred pages are initialized?
>
> That's fine, because this memory is still memblock_reserve()ed and deferr=
ed
> init skips reserved ranges.
> There is a problem however with the calls to kho_restore_{pages,folio}()
> after memblock is gone because we can't use early_pfn_to_nid() then.

I agree with the regarding memblock and early_pfn_to_nid(), but I
don't think we need to rely on early_pfn_to_nid() during the restore
phase.

> I think we can start with Evangelos' approach that initializes struct pag=
es
> at deserialize time and then we'll see how to optimize it.

Let's do the lazy tail initialization that I proposed to you in a
chat: we initialize only the head struct page during
deserialize_bitmap(). Since this happens while memblock is still
active, we can safely use early_pfn_to_nid() to set the nid in the
head page's flags, and also preserve order as we do today.

Then, we can defer the initialization of all tail pages to
kho_restore_folio(). At that stage, we no longer need memblock or
early_pfn_to_nid(); we can simply inherit the nid from the head page
using page_to_nid(head).

This approach seems to give us the best of both worlds: It avoids the
memblock dependency during restoration. It keeps the serial work in
deserialize_bitmap() to a minimum (O(1)O(1) per region). It allows the
heavy lifting of tail page initialization to be done later in the boot
process, potentially in parallel, as you suggested.

Thanks,
Pasha


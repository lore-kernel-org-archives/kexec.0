Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF965F588C3
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 13:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5FVwLkQx8K1po5pri2al0PpGhu0V85k3MLpduafsc+s=; b=jrTRPmQl5iPiatvKKCaRjRULo1
	IF0zlhP6zW/ctXuiqN7MK4tHwjQPP6AzUo08OykoXFi8u1UoVCRz6v1fCoILhti6KFDxgwUTK2FS6
	NyXpdOUOIbelLRYT+2+VH9ivMIvVamlVCm/Jw7H2lWtNR4xCBT35x2C8wEqvEy5EGkdM+W4ZlCGbg
	KzS6gvXfAhHHe6LyqP1BSRjS7WynEyAKOlOesGN2fl3bzSGLoLZExblfkomzsK1qHz89NvHg5QqME
	/u57hJcRoMzzv39fkPBKmA4B3o0ZSdnfBg1W6V5iKCbw/Tbq7RyUlprGNhLqAIsDHw71o5bnoN7Qd
	fVdI1riQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEoPH-00000006xXn-2l9g;
	Mon, 20 Apr 2026 13:11:19 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEoPF-00000006xXS-2RNa
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 13:11:18 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-12c8d0945b3so6280c88.0
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 06:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776690676; cv=none;
        d=google.com; s=arc-20240605;
        b=J4SAJjDCL9KYFKFQdwgHBUM6iP9F67Z3f7G/kibPvudoyLbvVGDBpi9vtZQpXRR2An
         nicjjYF9v2rbQd2OZRxeigxzyKJRj+hAHer21H1zxGqTqQ9eBHogDz9ljwvaA843xOVm
         +h7yw0xfWxrTEZunohKDm2IbGsl6oOQV10joZq7fClbJgy/z1iE4dJO3Y3gt9dVgWkls
         6wSQjbnPMVIj2k1+xVjuRDeBvM2HfR12OSFIbM1+yqzNX6Gcs//V+n4Q2bea2GrZKVFa
         YZBTANiO9TT7vAOVkvoWtsv0KP+1uR5JFeoRmCoh1/TlL1S5Z5r7ufL+0VUcfZHyIgxy
         1LeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5FVwLkQx8K1po5pri2al0PpGhu0V85k3MLpduafsc+s=;
        fh=0RWNyG2KHeJZU2XakF6ryNMh4miUvNs92NlddUInPHw=;
        b=R5yOGLAHi2V0AL80pvprWXXKEcz6ZTFSLiJb6s99iLJW9Dl4tAToocbYdx0i5LKlA1
         8Mg4kYXyNfltkpjuId/oNs5fJTDf7ZTrLirHPnlTtw+P3/l3cVXsczrlbRJL09Xe7w26
         6Hci2pvBZ4OQufm7baw+hPoeBlnNeiw4uci9eqbLFN8NcZmmgivcISJz877KsQBBxfRd
         Uma/vdYWcWKnpMiPUh9Jrdog8zmdX380o22UZE6rFgbovqtQPVyqFkd3Hpk9LInK0Dbe
         WyP4H3minaTYzNPmIqWU/rNE84r8ya7tR3vzdHLuZiOUV0XiGkAgVAaZj+dXv7L6mr1n
         sFPw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776690676; x=1777295476; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FVwLkQx8K1po5pri2al0PpGhu0V85k3MLpduafsc+s=;
        b=bSNK48ZdZez1SOQEEThBGsTAVIS7MZdE8LXiLYieCTgLCJ5r3IV7LufPi1POJOqJj3
         c88DM0IzFciLCZ97ardtUg/IwEcwm2kPhl+E+EFzSuZtGCqH0hA0lZCY1t+FCeFbYz8I
         TWqxhGPOLlyRnCQJww/OGeXgtzaNePq2OjkRVLbczlZ7fTA6lxqflFatr7iKk+Gqk208
         zU/SZFldnqLQso7OFMuHxKOiZ4Xw4vwfr6I8f5xXdwUOnqjSUCGKGmqP44njNfNZ/7QC
         OEzlIEFBtYLtyqRPri1f8+yP6BoHtVIbrLyfxuknHzer76zFjGxkPxdecPVpkxmkjBP9
         Nclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776690676; x=1777295476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5FVwLkQx8K1po5pri2al0PpGhu0V85k3MLpduafsc+s=;
        b=BOf7iTCe1W/s/Atd1kZddJY17TLBpO8x2I9mGRCBznxCEbfqlOwU5iRQzV1hznDuIz
         4ZdBNz/mZMicVCciBI8qaWmbpciSkRfygKbAWyGHzAISPhTlCoMo+IpptCh8nh6iLIax
         exgum8X6KakOBxfPZsnZpQNeL8OTfBIQ+o76JoawPja8UvK7dM2gExE+Fv0ocyrVYPZQ
         Ap4ZT685EWIIrkcj+Ln5tlShRuGLbkM24pVukD3gVBlUjf9kX5ZENDQIc+aIG7RThhzP
         l4CPWNYuLMM47iM3Fg6yYjFHlaobv3j1etSV7PDjv+lF45jGD4P3RHCVm0X9MOPk0PYr
         /Ctw==
X-Forwarded-Encrypted: i=1; AFNElJ9M/PBznVPTbPofHyrg76XdnjP2dHbL63eKrCfYy+OLKIp3kEr7ybjjvoirdCxde5Hu7eIljw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxcy9ndkH1SW43yhkPVJOMnHhwemNgJu9n/cLgeU9LMsmbWUURq
	aWcct+nl491xFCKb8V7pwV+bRX8KsvcMobuUA0ZYjwkiJgr6aYH0vQcCsQWYA4V1/mOCxwuBE8f
	2aeXyFWuXAVPiVxc1w/xy3VZFLBuk/MFL8+x70Bm+
X-Gm-Gg: AeBDiesexvbk5D/O3j4q1+v3QGKEQd1VLj9XQygNnhuB9SMD3aEYcUkpc69QXez9VGo
	KFUU3rWANpCpzDFr68ZR3y2mJtsyY8AGjDMneiVwuszH7Q7DS8v9YMhZkGIse94Dh74rWF9nkOO
	AneeSdyOkgvnqJvzzBS2vvW+3QZLnu71Sf/mm4O0YvhNYk3R5/iqwxsXfuUl/qBgC2RitrEu0qY
	Z2WF80GRiCb4jrEhfzCyKPP5Ko7JXkthG9RdGPSX+JHnPruwv9gVwiQGjJ3PjkQdrnPg5Qbh3Su
	Rrmzgq39xtSc9B03iAWKuH/idqlSB+eEo9aEUEGBz8wTFVDt2PmvH+9HaOY=
X-Received: by 2002:a05:7022:7f19:b0:12c:8c69:8f57 with SMTP id
 a92af1059eb24-12c8c69912amr48697c88.21.1776690675122; Mon, 20 Apr 2026
 06:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260416110654.247398-1-mclapinski@google.com>
 <20260416110654.247398-2-mclapinski@google.com> <aeD2Fzr6yr4pu9-X@kernel.org>
 <CAAi7L5d-ujEa7R21Lmd37X9451KBmK8ZhagSKbJde15aQLi2MQ@mail.gmail.com> <aeEKksfLxQ0A7Jun@kernel.org>
In-Reply-To: <aeEKksfLxQ0A7Jun@kernel.org>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Mon, 20 Apr 2026 15:11:03 +0200
X-Gm-Features: AQROBzB3QuDSyAD1D1K_U7KpKhvC1Hwu7IFcApx7uCWmoXxgKHNIl6UKX4G9oas
Message-ID: <CAAi7L5cp3B0DFEQex5EqFdLDkqVWwRw228-pgp0PnhfgLP=e6Q@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260420_061117_651989_DCAD1A0E 
X-CRM114-Status: GOOD (  16.89  )
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

On Thu, Apr 16, 2026 at 6:13=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Thu, Apr 16, 2026 at 05:06:10PM +0200, Micha=C5=82 C=C5=82api=C5=84ski=
 wrote:
> > On Thu, Apr 16, 2026 at 4:45=E2=80=AFPM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > Hi Michal,
> > >
> > > On Thu, Apr 16, 2026 at 01:06:53PM +0200, Michal Clapinski wrote:
> > > > @@ -2262,6 +2253,12 @@ static void __init memmap_init_reserved_rang=
e(phys_addr_t start,
> > > >                * access it yet.
> > > >                */
> > > >               __SetPageReserved(page);
> > > > +
> > > > +#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
> > >
> > > No need for #ifdef here, there's a stub returning false for
> > > CONFIG_MEMBLOCK_KHO_SCRATCH=3Dn case.
> >
> > In all 3 places the #ifdef is there because MIGRATE_CMA might be
> > undefined. I already broke mm-new branch in the past because of that.
>
> Hmm, that hurts :/
>
> The best I can think of is to add a static inline in memblock.h and ifdef=
s
> around it.

Sorry, I don't understand what you mean. What would that static inline cont=
ain?

> > > > +             if (memblock_is_kho_scratch_memory(PFN_PHYS(pfn)) &&
> > > > +                 pageblock_aligned(pfn))
> > > > +                     init_pageblock_migratetype(page, MIGRATE_CMA,=
 false);
> > > > +#endif
> > > >       }
> > > >  }
>
> --
> Sincerely yours,
> Mike.


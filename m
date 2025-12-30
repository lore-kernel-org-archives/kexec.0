Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC83EEE4997
	for <kexec@archiver.kernel.org>; Tue, 30 Dec 2025 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SbX4+3prQedbYohaWCzcG8i2LaKGHYsnZgkzeM93RSw=; b=PzmmcGSM9GWOXV7kFQzofq/KlG
	7QgjFQqU9Bxx1naycwLKJheW4MpPBhK5tedsFtaRZRZdvASgk1ggjkihBVznD28LvOTd8brmTNaJP
	pSRwmyy6hXlc50gLgVe5kVoqYHQT0X4MPVk/oMDcdLDpjfBAdE4RCALwaJIx2zHtYXgVvhpqpJhIN
	FUW7EA+gDI4LWyYVMyUMjw8I0sCgonprZScgB4pXDZFh03clhmrtvbkEcBFXVe3UtcI/EjLRTfMWJ
	b5LdfDfjcoNFAngGh8by1/TxGqgtT1h5c3V5gu5mmuA49K7V2F9Y/zMl4ANxS1FuTZgHucIAeTS+L
	TG6gpLSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaeMH-00000005AyH-2axY;
	Tue, 30 Dec 2025 18:22:13 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaeME-00000005Axp-0Y8B
	for kexec@lists.infradead.org;
	Tue, 30 Dec 2025 18:22:12 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so2235846766b.2
        for <kexec@lists.infradead.org>; Tue, 30 Dec 2025 10:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1767118928; x=1767723728; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbX4+3prQedbYohaWCzcG8i2LaKGHYsnZgkzeM93RSw=;
        b=XzK5fdMgKNcn12X/QvfU14l5ztmTqzhdsU8wwPT3ZctRyhzifqZtBbjRDfjOflqKUN
         HljZuzFkf/7m3KVqoxYpKRz0d73iBxAum5XUwBuSXxKywoGCG/3QTCnsXm37K6Pl1Dgh
         DKK/gaVCcqH5s+oZ9RUiaK1y8Vse74i/8EYFYnZllJrMDAQWSdY8VWSJcxMeRRUYNu7N
         FpOwZ1nSXa6GyB5IrwOcVUn3pinHF/ebJ7vcHWqKMVIAbm5Lx1ILBMY96IhZpXSuwCB4
         F+pn8K5dFWlq+zPojoTSi2tvHNryQVWBVpnVAZoJFqPuBuwXF8e7a0Swf8ZcSkhTTowi
         /sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767118928; x=1767723728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SbX4+3prQedbYohaWCzcG8i2LaKGHYsnZgkzeM93RSw=;
        b=jATSWb3I/Y1PQdk8PkRVaGi5L6J3vHYPJ7kXVXar11/VJDDPGyCAFfjWdiPsWlXZCi
         Mr089sfMn8Q3s15AcYrouEhVLMP6UIM6JDPHXulSGYCHtNf1SJuur/k4fvfT3r+Z4es9
         8sKpCj6/wG9VuJM56sSyCyzdIaRTqEYidaOoKq4AkS0MFCG14LHCxQOLu2xsdchPKMZX
         0dtXM0iOb0+9VoRvKc01yU8bfKDdonqiBqUO/Kt2Cb2cdYfMCq3yAXwRaEQ+FTIfSeL5
         DP3m/mEhpWJhF1VEOquingrUL+dhw/lklm+l+YD8hZtaVo7I1v3mszlZ/UCk1S8c47CS
         se4w==
X-Forwarded-Encrypted: i=1; AJvYcCW6nhsYTJ+wckx1G11jSuMEzLl6p+0+wggtTyuNLTcNW1aTQOyHPW1TQ6deciGKYdMK7flIvw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx82z2rTkryQEmbwdT3A4ZGSKudEiuZgF/jTwCiGqpuR9bxWx5q
	USozPkQuT90ou7X1NVl/KiIxemTAkXSdMPr3ygl8N9omwG+DJwkGI3CpHKfGWJhSURnmnVz8OnH
	ET7JTe8SmS/obtXN7OtNfDpKWTSJP5rrhaBXikbMDzg==
X-Gm-Gg: AY/fxX6/p1ZDzL+bnTHvrtmFAFHOH2sb5WEs1QAf1Lt1P5pwAWXMTVOlnLrLqQnY7yh
	ZacxinKg9FbkjAYCMGsbBZSiuK4G+wUoPQG19Bls0d5UO7yV7Fqg/8X+vhEN11ppz/h596C23I9
	5NpPZehkI0Rbns2yU0/LN1XWRAPiDduSKqyGGh52pzjgx4f7iV18lPlMg77MACZLh3YkYYtl06i
	nGYbyZVu1FuQ2Id1nz1BjJFurpHxFuR/InlsJ7jANXKOMRcPFYXbDhJWFrvAZDlwAxEfVznFayc
	E/dWQyDzf8jQQCDFO591BVB56ATBys8wpKCC
X-Google-Smtp-Source: AGHT+IE+NvY3nTwJty4csE57PDC23CsYYgYnBf8uXu6yTmkVwhlkaOlD6ryEaJ7e/qlHwQjSX1HDyhcouW9OYEj26Qo=
X-Received: by 2002:a17:907:28d6:b0:b83:1344:4872 with SMTP id
 a640c23a62f3a-b8313444da9mr1518310166b.32.1767118927990; Tue, 30 Dec 2025
 10:22:07 -0800 (PST)
MIME-Version: 1.0
References: <861pkpkffh.fsf@kernel.org> <CA+CK2bA1kYCf0BwhX3Sg9Ur82nK-7HPzs0sg6xbVWFAJaZLhpw@mail.gmail.com>
 <86jyyecyzh.fsf@kernel.org> <CA+CK2bDxnTEe9Ohq5zLuyF-jqgD0DPhfdq6z=yztUsXU5p5fSQ@mail.gmail.com>
 <863452cwns.fsf@kernel.org> <CA+CK2bCjJWZG_rPoPsHWSxirmUCTOuFQzTCss2AKf9UqpThrdw@mail.gmail.com>
 <864ip99f1a.fsf@kernel.org> <CA+CK2bDDEZ5a+LJNDVMtKFtQ1D9rP6rJqU064eoru=a9eHpaAQ@mail.gmail.com>
 <aVP6wBYoHJQsplIl@kernel.org> <CA+CK2bDZPwYpUhksDLSbfVdVm5TYbh0XrOKRV=q4YjGpqH+Fwg@mail.gmail.com>
 <aVQJUPOn85WlJaM9@kernel.org>
In-Reply-To: <aVQJUPOn85WlJaM9@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Dec 2025 13:21:31 -0500
X-Gm-Features: AQt7F2qfaFW5jYlhg6zDjPkXHhj6hFsRttMeIx54YfGgD6WpInICzEQbwDgmzGw
Message-ID: <CA+CK2bCm=AGDSLTbs6etbqveFUHU80okE-bCT2zg20nrHXgHRQ@mail.gmail.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Evangelos Petrongonas <epetron@amazon.de>, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_102211_069553_621F5BF3 
X-CRM114-Status: GOOD (  24.24  )
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

On Tue, Dec 30, 2025 at 12:18=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Tue, Dec 30, 2025 at 11:18:12AM -0500, Pasha Tatashin wrote:
> > On Tue, Dec 30, 2025 at 11:16=E2=80=AFAM Mike Rapoport <rppt@kernel.org=
> wrote:
> > >
> > > On Tue, Dec 30, 2025 at 11:05:05AM -0500, Pasha Tatashin wrote:
> > > > On Mon, Dec 29, 2025 at 4:03=E2=80=AFPM Pratyush Yadav <pratyush@ke=
rnel.org> wrote:
> > > > >
> > > > > The magic is purely sanity checking. It is not used to decide any=
thing
> > > > > other than to make sure this is actually a KHO page. I don't inte=
nd to
> > > > > change that. My point is, if we make sure the KHO pages are prope=
rly
> > > > > initialized during MM init, then restoring can actually be a very=
 cheap
> > > > > operation, where you only do the sanity checking. You can even pu=
t the
> > > > > magic check behind CONFIG_KEXEC_HANDOVER_DEBUG if you want, but I=
 think
> > > > > it is useful enough to keep in production systems too.
> > > >
> > > > It is part of a critical hotpath during blackout, should really be
> > > > behind CONFIG_KEXEC_HANDOVER_DEBUG
> > >
> > > Do you have the numbers? ;-)
> >
> > The fastest reboot we can achieve is ~0.4s on ARM
>
> I meant the difference between assigning info.magic and skipping it.

It is proportional to the amount of preserved memory. Extra assignment
for each page. In our fleet we have observed IOMMU page tables to be
20G in size. So, let's just assume it is 20G. That is: 20 * 1024^3 /
4096 =3D 5.24 million pages. If we access "struct page" only for the
magic purpose, we fetch full 64-byte cacheline, which is 5.24 million
* 64 bytes =3D 335 M, that is ~13ms with ~25G/s DRAM; and also each TLB
miss will add some latency, 5.2M * 10ns =3D ~50ms. In total we can get
15ms ~ 50ms regression compared to 400ms, that is 4-12%. It will be
less if we also access "struct page" for another reason at the same
time, but still it adds up.

>
> > (shutdown+purgatory+boot), let's not add anything to regress, as every
> > microsecond counts during blackout.
>
> Any added functionality adds cycles, this is inevitable. And neither KHO
> nor LUO are near the completion, so we'll have to add functionality to bo=
th
> of them. And the added functionality should be correct first and foremost=
.
> And magic sanity check seems pretty useful and presumably cheap enough to
> always keep it unless you see a real slowdown because of it.

Magic check is proportional to the amount of preserved memory. It is
not a required functionality, only a sanity checking. I really do not
see a reason to enable it in production. All other sanity struct page,
and pg_flags related sanity checking are usually enabled with
CONFIG_DEBUG_VM, so enabling it only with CONFIG_KEXEC_HANDOVER_DEBUG
is better.

Pasha

>
> > Pasha
>
> --
> Sincerely yours,
> Mike.


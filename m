Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E224B6070339
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xmVcah+I;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=RkW/UHo/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AOYXXvAeGQUSKg94QWzYjLTLmtv76jOGX9YU9MzItx4=; b=xmVcah+ISgx8t3
	Cca1IN+oZW1BSt1S3h3eQbjJWNziIcDRePZIZocMhM3CBul9UaByw3eloA14GhXSZ6F/BtqaQg9oN
	gdczGf50xiW4cTmhtyfB2k/G1lWHtnQXdIGuWierjixKHz6Wj9TYxzS409OZbZq6jNYh775l8AuaF
	WvpInvhaxbuWLFrw5mzcDtY9d/I7D1GA32tuR6HR55EyPAktcpCvvwRedUpL6SNt0AttvG8uKrW4J
	4zXrAv1+lfrevJ/mWj4XyAzEZJRc0UOSXHvGKRkgPhEw569B3qN1FqQn9tEZmHJLeWNuQ+3C6YmtG
	xm+JnB7MvRRMQrQ7VoZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOiv9-000000075zr-2hQd;
	Wed, 04 Nov 2026 21:53:27 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOiv5-000000075yj-2f5C
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 21:53:26 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso1812909a12.2
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 13:53:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793829202; cv=none;
        d=google.com; s=arc-20260327;
        b=Ju4+8IXrTR1agtexw+1wL6iumH+WaprjKZ3AJZd3/BnPC+d5vFYV9bZHH9L6TdKWk+
         2xUUUOJw1G9TSwSJCOQ3z1NEqieNkEQZGpdbv5yUN3wl6nOStSCXf24hBVuXgZeeAlpp
         kRK8e1Qw8q2Ir/sOi0ceaTGCc0Qy6PWQKkfymG/BGuoVS2MbQ7Mg8egTtO8M8EFLgdMv
         qIAB4FW4sAhvfElL1/ClvgbAvrmG0/EQi9tJRhJHsnPfxvfVcMbQ3ASeSXdoAgE6GZp+
         /RhW0LG+5EnmAGqLcVLW5YpOKD9vFozQmhLB100r8SAmmOMERSuPPGnjkw++rAXi2imo
         cHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AOYXXvAeGQUSKg94QWzYjLTLmtv76jOGX9YU9MzItx4=;
        fh=huPVsmlM3+H0hppJX4srSw7O7jXmQGAGbyfRBZeUEqU=;
        b=VVjxva4nmZ6NIfpkA4zpCQPIKIddGuzDqOaOsqCKB0NvJ/jKIARP9rSiiKYZ6fircs
         5Wr8nAriPllYhYCoe4ghJhDZbGBjwMv0rBFNp3Do/6Om9O+bxND0e1/2hgzt9jzkIo1t
         T+XBiehgswKCn9orMIs64ESVqJ+c3Su5aPpLX+fW1nmYCaTAS2LHFVZzbzpH5gMCxJbV
         ez9JS85UmwiINWdRBPqTvD7UPa0n3WoiGcdBMDoXWFotX5u9rezEN5KmaODeR490o9WH
         gPVbqW7fyHrhrUkFUjkrtUj/g4yKDkkO9JzlH57Maj1L01WMQoFetWBjC3YBSVLLRySG
         mZew==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793829202; x=1794434002; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AOYXXvAeGQUSKg94QWzYjLTLmtv76jOGX9YU9MzItx4=;
        b=RkW/UHo/88UMm+4MAVj4lWmRnAhOVoUwCUM5MbaYcacQs+LgK8cZO+mwMVacyt57dR
         ZB37NMfaE6xXcAKdSAw9WMbmFM5fYQJp6jvFlJClgAd8eJ6uXD/pow5H+Cc80aifjGIH
         MRuPy6plmudczP8B6GgiV/jrDa2BjLnDFaRHh8yzSojGq3nNvSD8i+t5MCdsGKAkTvEj
         ASjKP5e/YAbxW+ccOlxkEwrpYBZP24u28PpxSYXkQ+bU9lChqcaMcgsLoGsQOC0ElYkw
         rxkfC9/+qWYAdhHNlTwL4V1/2yV4xKheOZQ+ubsjyzxVE96AC0h9u8/6KhBN0GeOuwfz
         ASzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829202; x=1794434002;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AOYXXvAeGQUSKg94QWzYjLTLmtv76jOGX9YU9MzItx4=;
        b=r6+C5STHc8X5kwFaeWLx9FMiIejrvY+ZWv5Wz5C8XfzgBgqjKQt2U2ew+D2iSRaEmU
         E6j3jdG8JvusRGmgFGwGU2Fva+nObBak6VYCTz6xY1dLFYTgFK/W71pZowe74OOuy4eb
         NZASpvjfkVPWQ8lpqogwJCe9jdYtXJ5xaU8hLdmYC8nyKeGLfHuicNPXWr0nfDdc/hnU
         mIQTfgbMqh2LcUINU8egh9QQHBOpQKCbIfS4ANyn6IWCitZl4TO50e/arZ4tiXLvkk05
         VdVLl8xTI5ESEV09H7SV+ZVfl8TQPZCIVDG+K9rLpxoo+QRABouXnFhSRcsLzD1KwWHt
         20AQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8bHPyLVfqVaGFnkmrtS6zaPcianXTsTnTPqVOQqJSpxNx0nW5Xyo8ylelSSLGKMrW4qsBYQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z806JwEZ8LgW1MMylSWB6J2P8KSkpPnrYp79RSOBxpWSRWzKJ4R
	aH8cLL/enrnsbrjHerWHe5S2bhcbnFdAGMDjjQhlPOhHZoU/O8nEmdYHBRC2OJjiEI7cs1toPDV
	EhodwDFhjhGdW4mGzNgT8wSua6p0dK3XqWLNunGyZNw==
X-Gm-Gg: AYBFou2WFIOE+Jz7OosJGFkWBMC49xJlYMseKayLzImZmom8LONX4oMwfoY4zaaxddr
	1Ks/gsCMkzzDJoW3bvaebKfR4e04kNDP4p30XLt3PYZacBMeFc+999FwXeppxrgRfj5uLwAjBGw
	wbH+35KlA0M9xDnlSfuZ3t1uAQmFz+ArYkEkxbtF/ETJwHR6SzYgwpC+/H87aqUgtcuArSt7qbT
	UPgVJTRUv9KQM7uqPAI/10FWvA3vmkt3EtBLfC4iCzEeKKM3tJX+Y5prnvY2A66gY4+Hu6IZndp
	XnZOlqdect68x5x5SFI9ktFJ4e+36uZVbfVcr7nqwzV6cyrhzdGkYlpL6tk4apFuFQu4iQO2ic9
	cyur3EDum7UbbSA1S11N75YxBvKMFx/tonBBu6Te6LtrS7qZD1GhdZe2mBHctxs5VRz5Z
X-Received: by 2002:a05:6402:324c:b0:6b1:c7d9:b631 with SMTP id
 4fb4d7f45d1cf-6b4d4877be2mr10211433a12.23.1793829201753; Wed, 04 Nov 2026
 13:53:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104162352.140836-3-blum@kernel.org> <179382570401.2089669.6201187990672133004.b4-review@b4>
 <34a03ed8-5b75-49b5-bfd5-e5cdf48dbfd4@app.fastmail.com>
In-Reply-To: <34a03ed8-5b75-49b5-bfd5-e5cdf48dbfd4@app.fastmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 4 Nov 2026 16:52:44 -0500
X-Gm-Features: AclHuK-s-sl_kRxXOrDtbT9-CufQHmeS1snyHVWmWxn4YyNWTQWbPewzEi16i1s
Message-ID: <CA+CK2bD4s_qn7Scat_B9vya+BoqkJdNTy=iYY4JoHNAzY9YaoA@mail.gmail.com>
Subject: Re: [PATCH v2] kho: Remove redundant 0x prefixes
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thorsten Blum <blum@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Changyuan Lyu <changyuanl@google.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_135323_692988_5D5A705A 
X-CRM114-Status: GOOD (  20.24  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 4:00=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Nov 4, 2026, at 21:55, Pasha Tatashin wrote:
> >> The %pa format specifier already includes the 0x prefix. Remove the
> >> redundant prefixes to avoid printing 0x0x.
> >>
> >> Use phys_addr_t for size to match the expected type.
> >>
> >> Fixes: c609c144b0e8 ("kexec: add KHO parsing support")
> >> Signed-off-by: Thorsten Blum <blum@kernel.org>
> >>
> >> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/ke=
xec_handover.c
> >> index 6f1f55fe3181..6a7600a0a7d5 100644
> >> --- a/kernel/liveupdate/kexec_handover.c
> >> +++ b/kernel/liveupdate/kexec_handover.c
> >> @@ -2010,16 +2010,16 @@ void __init kho_populate(phys_addr_t fdt_phys,=
 u64 fdt_len,
> >>       */
> >>      for (int i =3D 0; i < bootmem_cnt; i++) {
> >>              struct kho_bootmem *area =3D &bootmem[i];
> >> -            u64 size =3D area->size;
> >> +            phys_addr_t size =3D area->size;
> >
> > I am not sure; having a variable size of type phys_addr_t looks strange
> > to me. Furthermore, KHO only works on 64-bit platforms because of how
> > our radix tree is designed, and we do not plan to add support for 32-bi=
t
> > systems.
> >
> > I would keep u64, or if using %pa for u64 is still an eyesore, use
> > 0x%llx for the size field.
>
> area->size is also a phys_addr_t, so using a local variable of the
> same type makes sense for consistency.

True, that makes sense.

Thanks,
Pasha

>
>       Arnd


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A5BCA1012
	for <kexec@archiver.kernel.org>; Thu,  4 Sep 2025 19:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jjoOxNGipBZMZSrHgnJO7zIqbW8l/mlQVhOAOi/XHNk=; b=YGS5JF+1pwAZAiRnLAqlCiqbmC
	i09DcllsrMsSPLlSzabUNDVz18GvWMUU0Zq33zgJoq3n5+s4vEi6gVf0Oa4Yvo+aIlEqTX2uOWsyg
	2FoRg9J1UJ/9l7KUBRSGH/nVrD8ZCy1yG5wnLx00YFGyLFkETASmlQykZ3d6dBEi6j3btxcAm8gG0
	PzXJouBgkzSQeW568BWP5zsaPgKRjMxkPgovX7+PSNTS8KvlD7Ma7iaTFvgkszNAhSGxYqpERC5pq
	qRZo/KUfF4zuDWeNIqz75yDlOX9bm44LQQUBPIjBNTnkciXp77gzcQAhah/Q4O9UOCKqUI7q+HoZ2
	YaRjQbWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuG0s-0000000E3CA-0hgC;
	Thu, 04 Sep 2025 19:52:54 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuBQJ-0000000CNtw-2QGU
	for kexec@lists.infradead.org;
	Thu, 04 Sep 2025 14:58:52 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3dce6eed889so841552f8f.0
        for <kexec@lists.infradead.org>; Thu, 04 Sep 2025 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756997930; x=1757602730; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjoOxNGipBZMZSrHgnJO7zIqbW8l/mlQVhOAOi/XHNk=;
        b=dYiA93QTOZl9hNAmIRyoLfHLxQ80s+L6GmNmTr7LwzsDUo5r+TWzHGy3coa9Ni8Fte
         1GEgLMt8OAdH2SwwiKo3ue+SyCo5iQerqfzX1CuUufcK6QHEKhqjhFi6Z27nwCnB874l
         MZYMOsGaKD7rk5wtpykCwrRWB7vTeoQ5C1cauG0BwoxpYv0KxpucTW61VCic3x6Kw+Yv
         vaWzwqca/DtdTjx+5OCBZl9zANWhIqN0nYWG1fujlZzN8r08qRGumIX4k7SGALhGNVQW
         yVmcKxNGB+crqnZoRKS8v3BN91WMw4aRSPrLlIzAHGxL1zzFEEwVmndvqAwyM7Tt6iQq
         Y/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756997930; x=1757602730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjoOxNGipBZMZSrHgnJO7zIqbW8l/mlQVhOAOi/XHNk=;
        b=R7GR0fK6cpzoUuFh3ZB3+2UaoK4D27qnXU+kpUVjWjBJK+CE8uS/bWDs4zelJGoaMv
         LOTXltr0LKYf0YC+ZzkFPHLJwVFGb0GS2Ol06/Qzq6ql/nx62PxXKwW4BqXIGpfxqAz5
         zIS+39vgUkmS5oHYO18aYsXzi50qhgC0B1mKoZNaNFWG+8EyWX59peYQr0eejbkPNuEO
         89tKqKizoBeGkfIAl55Nd+RK0Bu/64gZJ06NIhsB247cqXeoI2rEs1VqOdBtLVIiTHoV
         /5MN2Km/X4etwC97liIGW5V0tPbgmOcf91ezS5/JVjJ6j9kcmd7PvAzPMJtZ4joSRlea
         OQfA==
X-Forwarded-Encrypted: i=1; AJvYcCVPUC5WPJZmTmI0FaX62C/5nMSI3mBAQVZboYdvwxm4Hu8Gojo/MBpmjcMYF9iRl/9zLOE4ZQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxdVDVAKRj8/BbAFZZRA7r4VWAg2rBc2dQ2yAr9ULhqtyOFF7Us
	iFlTOaXImIVnw1/OKkvW3H8CEJjjpleIb52eQR+Cie/zm/wKoD/J6u5/8mMDNMo9fwigm3d66f9
	P69FryfxWi6Ls/ifJ/G9HKWrEDDpIMDI=
X-Gm-Gg: ASbGncv2DeApGlOABW5y/Z3ECgXFlmA4VTRSnn+R4V5jUjcdt3H32fKvnXAhPhBJDRX
	xTl2mdeyAVZx8TFFOFI+2VF/QwFJPQeHywpbYVi9bSn2Djxm5tWSRUd2JCHInPYIOEVRMVL4rqa
	AeVmx3NJis6O8prCh/BHSdxSPImyIQOZwJeoaiXZOZLsWLPJ/l6URRuRZpn93Ah9TYZAGzNfkXv
	sZEFFQ=
X-Google-Smtp-Source: AGHT+IEOLYmXnNodyTdeKUcsNwKRu/qrjmwe1/I99spM8q/MVj2nsHb/yfnDKG0O9PUqtUVGjpAX+llHDS6iNPSghBc=
X-Received: by 2002:a05:6000:430c:b0:3e0:4d29:80be with SMTP id
 ffacd0b85a97d-3e04d29815cmr2637642f8f.49.1756997929274; Thu, 04 Sep 2025
 07:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
In-Reply-To: <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 4 Sep 2025 16:58:38 +0200
X-Gm-Features: Ac12FXyGDcz59ifSydw05MuQg_P1V6YF0m9gsQ5VWAu0_B8ZIjHvT6en0L_OHZQ
Message-ID: <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>, snovitoll@gmail.com
Cc: glider@google.com, dvyukov@google.com, elver@google.com, 
	linux-mm@kvack.org, ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com, 
	akpm@linux-foundation.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, sj@kernel.org, 
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_075851_615661_60BA8EA6 
X-CRM114-Status: GOOD (  37.22  )
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

On Thu, Sep 4, 2025 at 10:11=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> > If so, would it help if we make the kasan.vmalloc command-line
> > parameter work with the non-HW_TAGS modes (and make it do the same
> > thing as disabling CONFIG_KASAN_VMALLOC)?
> >
> > What I don't like about introducing kasan=3Doff for non-HW_TAGS modes i=
s
> > that this parameter does not actually disable KASAN. It just
> > suppresses KASAN code for mapping proper shadow memory. But the
> > compiler-added instrumentation is still executing (and I suspect this
> > might break the inline instrumentation mode).
>
> I may not follow your saying it doesn't disable KASAN. In this patchset,
> not only do I disable the code for mapping shadow memory, but also I
> skip any KASAN checking. Please see change of check_region_inline() in
> mm/kasan/generic.c and kasan_check_range() in mm/kasan/sw_tags.c. It
> will skip any KASAN checking when accessing memory.
>
> Yeah, the compiler added instrumentation will be called, but the if
> (!kasan_enabled()) checking will decide if going further into KASAN code
> or just return directly.

This all is true for the outline instrumentation mode.

However, with the inline instrumentation, check_region_inline() is not
called (in many cases, at least) and instead the compiler embeds the
instructions to calculate the shadow memory address and check its
value directly (this is why we have CONFIG_KASAN_SHADOW_OFFSET, whose
value has to be known at compile time).

> I tried inline mode on x86_64 and arm64, it
> works well when one reviewer said inline mode could cost much more
> memory, I don't see any breakage w or w/o kasan=3Doff when this patchset
> applied..

This is interesting. I guess what happens is that we still have the
early shadow memory mapped so the shadow memory accesses inserted by
the inline instrumentation do not crash.

But have you tried running kasan=3Doff + CONFIG_KASAN_STACK=3Dy +
CONFIG_VMAP_STACK=3Dy (+ CONFIG_KASAN_VMALLOC=3Dy)? I would expect this
should causes crashes, as the early shadow is mapped as read-only and
the inline stack instrumentation will try writing into it (or do the
writes into the early shadow somehow get ignored?..).

> > Perhaps, we could instead add a new kasan.shadow=3Don/off parameter to
> > make it more explicit that KASAN is not off, it's just that it stops
> > mapping shadow memory.
>
> Hmm, as I explained at above, kasan=3Doff will stop mapping shadow memory=
,
> and also stop executing KASAN code to poison/unpoison memory and check th=
e
> shadow. It may be inappropriate to say it only stops mapping shadow.

That's true, but we can only achieve this for the outline instrumentation m=
ode.

With the inline instrumentation mode, the (early) shadow memory would
still get accessed all the time even with kasan=3Doff. Which can be
considered inappropriate, as you pointed out (though this is what
happens for vmalloc allocations when CONFIG_KASAN_VMALLOC is disabled
and it does seem to work; but the inline stack instrumentation might
be a problem).

We could limit kasan=3Doff to only the outline instrumentation mode, but
I guess that defeats the purpose.

I'm not completely opposed to making kasan=3Doff work with all KASAN
modes (assuming it works with the inline instrumentation), but then we
will need to thoroughly document the behavior it creates.

And let's also wait for an opinion from the other KASAN maintainers on this=
.

> > Dmitry, Alexander, Marco, do you have any opinion on kasan=3Doff for
> > non-HW_TAGS modes?
> >
> > On a side note, this series will need to be rebased onto Sabyrzhan's
> > patches [1] - those are close to being ready. But perhaps let's wait
> > for v7 first.
>
> I replied to Sabyrzhan's patchset, on top of this patchset, it's much
> easier and cleaner to remove kasan_arch_is_ready(). We don't need
> introduce CONFIG_ARCH_DEFER_KASAN. Please see below patchset which is
> based on this patchset introducing 'kasan=3Doff|on' to genric|sw_tags
> mode.

Based on a brief look, both patch series seem to be doing similar
things (except yours also allows using kasan=3Doff for all modes).

But I like the Sabyrzhan's approach of hiding the explicit
static_branch_enable() calls under CONFIG_ARCH_DEFER_KASAN for the
architectures where they are actually required.

So I propose we moved forward with the Sabyrzhan's series and then
apply additional patches for supporting kasan=3Doff on top (but again,
assuming they work with the inline instrumentation).

Thank you!


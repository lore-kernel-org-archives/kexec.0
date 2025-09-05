Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DCBCA0FED
	for <kexec@archiver.kernel.org>; Sat,  6 Sep 2025 00:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BfAilJ2gxaTlTEXjw4cUYBqev2DLfb4NtdyYplV2cLk=; b=fn7hUwnIuvUslWvzszZvzpOAop
	s53mH6OSmD4Z3uz1zBubcTtos7q4ZTRiSochM7n2As/7kWXKzh04cn+HkqpskLHGYlUpUdYirzlo/
	kfxvRUhqYcbnYcsnPek0//uyPimjuJcfQ4ZSUQNgIJeKQvdRCrq0WWBdlQLcqsY2KNJZRCkVaX/e0
	xFCsLWHHCK/IU/lL11DF2U4joloxzA2L4I9QuFRSaBhMNunRWhaXWoabiZcMCPvo/jDR5OnzasvqM
	xe1nsF14l3UtZ/HIT8WG0DrxZx3aqkb0qXolCXXRG9qSY+HQhT67sft/f3BJ3B5+my5Zx+5PTs60o
	YYgYs8vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uugYK-00000005WoO-0Dog;
	Sat, 06 Sep 2025 00:13:12 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uud8o-00000004TsI-43lc
	for kexec@lists.infradead.org;
	Fri, 05 Sep 2025 20:34:40 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso22483625e9.2
        for <kexec@lists.infradead.org>; Fri, 05 Sep 2025 13:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757104477; x=1757709277; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfAilJ2gxaTlTEXjw4cUYBqev2DLfb4NtdyYplV2cLk=;
        b=eojvjIf4pYuCih+MfVbPLUh2/xBu79S7Eafl4wICF3R9tGpqiKl8YZ+mZEVUrKWbN6
         VZC0tt7Q3XuJQX6AF5EkllwaMbtpPNglzQ8SF0+7VYrvNoNPFDG9cArzgfC5E+tdlMDz
         Dz1XgEG4qvqZKcTE4L5jjBAyoLpnkiBx5MJWRahOQWZl2/v1XhkEpD9liREfAB9Z9/Pt
         xnLkC3YR2jZdfYCTmUZPN5nwO+Cq01JgAKR1VgsDptGn8pwl9xKpFXp9XpLtngCv7b7s
         IFZFxtNzXbXlM1arxdWKP57vH4rZz/NnSLTN9zOlDuHB2vxlZYxolUN3w3vNjS4O4RJ+
         OyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757104477; x=1757709277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfAilJ2gxaTlTEXjw4cUYBqev2DLfb4NtdyYplV2cLk=;
        b=JfoerVC09VxX9MpAhzsokAclBxnaoQhWXjP0oxS2JWfVeZhT/IrxQqbI2j16G6FhL+
         aHweeDOAN5W6vm6lh4S5FGCIbFl1L+TZw8jfn6GurnvaJjIXxddwt9DxiftZVhfFoTUa
         67mJldLSHE+0daFLgSGChg9gfgV9OE4Ql6MjGW/yVo4uMwB03Z+jVYjSXhlwzu1Q97FC
         M2pCdWAS0kUqHMRvXrOS5dmt+47uku1hGn8FQYqBjyNmneyH3gvbFHzr6eXC8OLoM3dr
         hT28UjrU9nCJuzXHKmrIID9DX/4Tnaqn5eL+ZjFKMnw218KzDEHqKGsRSd55UTOaLJSs
         gfFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRsoPZvCZBZ1/J5Q5e5PMF27H6TLfaiPVxHWuMGuUDhIjdTwQY2qoJGx7p2CONvRSK/M4RTA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzcD4LUACui/OmB1QCc9yBEr1YsVsfi816x78Toga0s0kTer67L
	29MP57mKcW3nOR0567/8TNfUA2G4HZ7xdiDmjGYmiNrRvoiPgWhAmeszmY/s2rg/vqvqgaNupWu
	FpRji9ymC5ReXPy2YuZ2YYkUCOFSM+xs=
X-Gm-Gg: ASbGnctqQKGjKXKfQPSbWdzU+WNXXEjoaUkEEpRc0TaHgtfKTH2wLcSolRWNBnehosT
	/vFmErFlFUF2aTn+PAyIoVdazG0syGQ6e3Tbist4fNPh3cgZw8KnsUsplnYYvV4oool3XMueE0m
	tZWYYZQirbexpf5U93CeNsaGGu8c5PCiZiOaF0O8GkDTg+7HTbHReFZy303zm9RMz/RaEfpUQrI
	zkQBIY=
X-Google-Smtp-Source: AGHT+IHAHVwclBpybbHsJm/2lJguUcGowceRU+Er1bB8qLNDR1sjTRVlcevgD13lm8TELeXUorSoWEH8Q8YTbd86dPY=
X-Received: by 2002:a05:600c:1991:b0:45d:d6fc:24ec with SMTP id
 5b1f17b1804b1-45ddde8a579mr1347145e9.1.1757104477218; Fri, 05 Sep 2025
 13:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv> <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
In-Reply-To: <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 5 Sep 2025 22:34:26 +0200
X-Gm-Features: Ac12FXx365TCqrnAMDPozsjaxIlbZS7cS1EckX64FuOxYCiii9Ap4uOCa5qcCQw
Message-ID: <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Baoquan He <bhe@redhat.com>, snovitoll@gmail.com
Cc: glider@google.com, dvyukov@google.com, elver@google.com, 
	linux-mm@kvack.org, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_133439_012614_2AE9D0E3 
X-CRM114-Status: GOOD (  20.14  )
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

On Fri, Sep 5, 2025 at 7:12=E2=80=AFPM Andrey Ryabinin <ryabinin.a.a@gmail.=
com> wrote:
>
> > But have you tried running kasan=3Doff + CONFIG_KASAN_STACK=3Dy +
> > CONFIG_VMAP_STACK=3Dy (+ CONFIG_KASAN_VMALLOC=3Dy)? I would expect this
> > should causes crashes, as the early shadow is mapped as read-only and
> > the inline stack instrumentation will try writing into it (or do the
> > writes into the early shadow somehow get ignored?..).
>
> It's not read-only, otherwise we would crash very early before full shado=
w
> setup and won't be able to boot at all. So writes still happen, and shado=
w
> checked, but reports are disabled.
>
> So the patchset should work, but it's a little bit odd feature. With kasa=
n=3Doff we still
> pay x2-x3 performance penalty of compiler instrumentation and get nothing=
 in return.
> So the usecase for this is if you don't want to compile and manage additi=
onal kernel binary
> (with CONFIG_KASAN=3Dn) and don't care about performance at all.

Ack. So kasan=3Doff would work but it's only benefit would be to avoid
the RAM overhead.

Baoquan, I'd be in favor of implementing kasan.vmalloc=3Doff instead of
kasan=3Doff. This seems to both (almost) solve the RAM overhead problem
you're having (AFAIU) and also seems like a useful feature on its own
(similar to CONFIG_KASAN_VMALLOC=3Dn but via command-line). The patches
to support kasan.vmalloc=3Doff should also be orthogonal to the
Sabyrzhan's series.

If you feel strongly that the ~1/8th RAM overhead (coming from the
physmap shadow and the slab redzones) is still unacceptable for your
use case (noting that the performance overhead (and the constant
silent detection of false-positive bugs) would still be there), I
think you can proceed with your series (unless someone else is
against).

I also now get what you meant that with your patches for the kasan=3Doff
support, Sabyrzhan's CONFIG_ARCH_DEFER_KASAN would not be required
anymore: as every architecture would need a kasan_enabled() check,
every architecture would effectively need the CONFIG_ARCH_DEFER_KASAN
functionality (i.e. the static key to switch off KASAN).

Nevertheless, I still like the unification of the static keys usage
and the KASAN initialization calls that the Sabyrzhan's series
introduces, so I would propose to rebase your patches on top of his
(even though you would remove CONFIG_ARCH_DEFER_KASAN, but that seems
like a simple change) or pick out the related parts from his patches
(but this might not be the best approach in case someone discovers a
reason why kasan=3Doff is a bad idea and we need to abandon the
kasan=3Doff series).


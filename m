Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E42C87FCA
	for <kexec@archiver.kernel.org>; Thu,  7 Aug 2025 21:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UNwxnWYdOCD69TW4rPS535ZBaNxlQLgyIPCf+8x+3Q4=; b=1+uOfeUcUSOyYjsyhTADovKM5x
	LaHYftRGQfWUzoXU/puxhW+P74YQD56mxQnerkOeZKJbziNJD7fNyxwhk9b4kpjfxYgT/p5sqmKGy
	hbj54H4O+F94m4HMHynAaXQdhR5TOhPkQImY+xMzBfe+QympBFtuK2PknqeEDUqSEssBYAtsrF1al
	tsIgf/EmEzz8PuQdwW5hSULZgRZIZy1Lay6C4I2HDVU7Kp1gi8x9ejxmatugfoyEN1nlxfz/YGPgC
	CitRXrv+5+dy/WDTcfri/ETs7EQjnxh2GJT+2Lv7jqjBMLCuTNmRFjBzwY2aKq2u6+LU8H2W62HR0
	C6txDODw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk8Io-00000001Zf7-1XVT;
	Thu, 07 Aug 2025 21:37:34 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk8Il-00000001Zej-3O9V
	for kexec@lists.infradead.org;
	Thu, 07 Aug 2025 21:37:33 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-617c40825c9so2117897a12.2
        for <kexec@lists.infradead.org>; Thu, 07 Aug 2025 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754602650; x=1755207450; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNwxnWYdOCD69TW4rPS535ZBaNxlQLgyIPCf+8x+3Q4=;
        b=F1K7LusfB2KQ/FVFDyyhlkicrmf9G8664FgdXjmOsFFDHyttiGSTJWKV1AITkRI/wt
         gb1wDBgc+Fjwmf+WYlVTchft/DIfjx+j3r+TThbwXj24rgyAE+KgA8OW1LBpwZrfJPDJ
         scpV9L6i4jjoj++e9LPP+i3ZmT5SFQXl4f8lIuc/Ml+Y2v75nDsK4dpJG3V6wq11Lhp2
         hITdGkyrcJFfwOV3w/PWcmAi11+euP9t3+loywuCo0dTw3oXJBjc9rM/gO3XIAqZIyUK
         0YteZafOBMKDT05ri0reEOuIL3yGoOIylQqqvLRHYrbyCxfU0FSOkJZQdiGimz2oZ8fC
         6Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754602650; x=1755207450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNwxnWYdOCD69TW4rPS535ZBaNxlQLgyIPCf+8x+3Q4=;
        b=bh87Q8tHMv1jr183W7T6f+TDSWu+Xjb3sYewtWTjYgtC1UjPpDupUK+ZgTNnicdW9I
         Uu6S6aadFcywLPylczqiiPO3XwzIOmfk+Rk6PLzqZvJmBnfF1WiRZaIrs2aV6TK/vuD2
         2/U2YP94i38JkqEgmxhX25ed6NW28O2A79yvkepCScZ4b788f2Rnev2AJfWl4RCgGEdJ
         ceLIRTFDpx9Mb5ic11wY8QXWhtOfFxrBokUlEesH245G7RhQDGG8UG77lz4Yg+kV2ztk
         h0BdPkVcJeDJj1a66bH/wScoRfe7+LVt1HLw2okGZUjof39xGSi0LYZvooCuYydLszkc
         bIUA==
X-Forwarded-Encrypted: i=1; AJvYcCX++1VZnF5wJbS3H4CIFXb336seBSEoFav2TAOspNx0f/oui0eNAiH5s4Aurk36K7TstDb9FA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yznyy3L3pYxBnaIksQggB9WlRLHgbdTDVawej2Ur8npeuwvrTr0
	O6IdbTmWFuDRKQIRTBlpHqzg57N6IX7kAmAtV3QxTu7kWU6kDfrETCz70nQd8zztM/DPaghPNrX
	OFrYjimMimzmOXAdrO7mBBzxQrCL5zgQ=
X-Gm-Gg: ASbGncsPTFezOkkTYjT9jdBP/tUMi5McZmYYOTCJbpkXfm6YdevRvqEsIyo41fieg1c
	9LJsecPEPdPPviY3115ykTgCzwqxmi/wdI/bST+15z2Pv/nBP+SI4JJUkXwXE4IAwTJF+iec4Ff
	T0GE0gXP4DiCqb6lYHIGj9kxvjKs15rb3qRM0xkaTNQ57WBuSK7kvV7+iuggg1qA0iBDRTWIjGG
	QA5FcbgZA==
X-Google-Smtp-Source: AGHT+IG1YuD/kbToN/CHBMfxrZ7a3ankfilrT5tRw1gMtrrN+k52FuuyWDkp56qsIxRjYRKFY9LpQ3TaM8fEZOyeul0=
X-Received: by 2002:a17:906:f5aa:b0:af9:7f4f:775e with SMTP id
 a640c23a62f3a-af9c655d730mr40700766b.51.1754602650087; Thu, 07 Aug 2025
 14:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250807032510.4211-1-safinaskar@zohomail.com> <c8b1a8db-ab84-417f-8815-5ebc9dde46c6@arm.com>
In-Reply-To: <c8b1a8db-ab84-417f-8815-5ebc9dde46c6@arm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 23:36:53 +0200
X-Gm-Features: Ac12FXz7Gl3PGpEHsAk2lkwOTecJIb5JSGGcTJDahFMxGb-AsIzXP4zJX1nVNfs
Message-ID: <CAHp75VcsMYnSp8UqjPL7b=D=sFS-JMe+q=KLScRWzM5S7yYmwA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Fix printf string specifiers, otherwise kexec
 doesn't work on my laptop
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Askar Safin <safinaskar@zohomail.com>, Simon Horman <horms@kernel.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_143731_847931_FAC65D8D 
X-CRM114-Status: GOOD (  30.74  )
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

On Thu, Aug 7, 2025 at 10:35=E2=80=AFPM Jeremy Linton <jeremy.linton@arm.co=
m> wrote:
> On 8/6/25 10:25 PM, Askar Safin wrote:
> > TL;DR: this patchset fixes regression, introduced in aecc554e7b.
> > This patchset should be backported to all distributions, which packaged=
 v2.0.31, otherwise
> > kexec doesn't work at all at my laptop with pretty common setup with v2=
.0.31.
> > v2.0.31 is broken without this patchset.
> >
> > See details of this bug on my laptop in first commit message.
> >
> > Okay, why the bug happens? I suspect this is because of "%lux"
> > string specifiers, which are totally wrong. The author meant "print (an=
d scan) in hexademical"
> > here, but this specifier prints (and scans) number in decimal, followed=
 by literal "x". Oops.
> > And this seems to break kexec.
> >
> > The bug reproduces on kexec-tools aecc554e7ba8bd449dceaf3eeecacc09b9b77=
fc4 , but
> > doesn't reproduce on kexec-tools 6aecc32c6db895b1c0b1f522d82c8810ece655=
42 .
> >
> > (This is cover letter, so I think using scary SHA1 sums is okay here.)
> >
> > I. e. it is regression, introduced by aecc554e7ba8bd449dceaf3eeecacc09b=
9b77fc4 .
> >
> > Okay, how to fix this? Well, this is not easy. In 07821da7cf and d2f429=
7166 Andy Shevchenko
> > observed compilation warnings, when %lx is used with uint64_t, so he re=
placed %lx with %llx.
> >
> > Then in aecc554e7b Jeremy Linton observed warnings with %llx and replac=
ed it with %lux.
> > (Yes, C is nightmare.)
> >
> > So, uint64_t is sometimes defined as long unsigned, and thus needs %lx,=
 and sometimes as
> > long long unsigned and thus needs %llx.
> >
> > How to fix this once and for all?
> >
> > I see three ways.
> >
> > 1. uint64_t a; printf ("%llx", (unsigned long long)a);
> > 2. uint64_t a; printf ("%" PRIx64, a);
> > 3. uint64_t a; printf ("%w64x", a);
> >
> > I think that %w64x is beautiful, but it causes compilation warnings on =
clang. (Facepalm.)
> > Also it was introduced in C23, which is too young.
> >
> > "(unsigned long long)a" is the best in my opinion. This is what I used =
in v1.
> > But Andy said to me that POD conversions are evil.
> >
> > PRIx64 is ugly, but this is the only option left. So this is what I use=
d in this (v2) version.
> >
> > Also this patchset fixes other misc things. See commit messages for det=
ails.
> >
> > I tested on my laptop that this patchset actually fixes the bug.
> >
> > v1: https://lore.kernel.org/kexec/20250805124722.11193-1-safinaskar@zoh=
omail.com/
>
> Thanks for fixing this, that patch was a last minute addition and I
> guess it shows.
>
> The patch content looks fine to me, but I would suggest that the commit
> messages are added/cleaned up a bit. Also you need the fixes tags for
> all the cases I broke since they are now in separate files. It might be
> easier to keep some of the related ones together and the additional
> fixes you made which aren't corrections together.
>
> Thanks again,

As Jeremy said, I have nothing to add.
Codewise and split looks good otherwise.

--=20
With Best Regards,
Andy Shevchenko


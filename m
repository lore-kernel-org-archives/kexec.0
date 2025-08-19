Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F775CA0EFE
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 20:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B6TzjFTlH1JLT31fuDBg1E8dnevEFul98PYwdJPZ/QA=; b=yr4eO2jEF1QRzKWSnItnV4d5YG
	eDRyYisdUzXJidvBroN2trgovdPot+7bAvN+uaL389x+U7abTUSJH0327WEe+xL9RrrSLp3otq7np
	CaLzzFBGxtnAYkDj8rZIYynYIRnzOsnrQAaWhzqLcZFcP58yGwO8n+a0q0TxgC1dzsxhbbpBjBiP0
	AeXP7GskCfdhp6qoTO9MkkKXD6CEfzdYpLMCSBrh6Gwrx7or+CX5LDBpPxsqmCfmxyB5cT8cdKrmn
	pFA7HLJI2U1VYTDEPZZgk5/juS9vHrY0er8VSL7GtngPPCqT5tba981eBMfU4qP1g8Diu9DDoOP6l
	A5bW7N1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoTAV-0000000BYyX-1cqS;
	Tue, 19 Aug 2025 20:42:55 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoRPn-0000000BLEK-12ln
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 18:50:36 +0000
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-333e7517adcso1850201fa.1
        for <kexec@lists.infradead.org>; Tue, 19 Aug 2025 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755629433; x=1756234233; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6TzjFTlH1JLT31fuDBg1E8dnevEFul98PYwdJPZ/QA=;
        b=nk1JGJzjwEOhwLYX+RrLTki7+6I0v2VrRrmwOZBw2kyDMHlP12VQd8LZUHPTRR7sDi
         7htRciE99/JrQP4IcYpJZwQiUTbWuzJgXtZl48j4dDQg80/4FSEgrqRpL8TVSn5m9N2F
         Mtcji/M0WRtOFV0soXzrxxZlpZraXrbXX8epwf5f+1U9Z3Pk58+M/KlbdEO0ToZsQkkM
         2bHucwMmZvMa4dfEVX3cxsUOnun69aVNOfqyL3zRBu3ctplTvhlJhPYwstLaBQ7LaePQ
         ThRq0psKtPJWv9HMy3SVoY4m9ttJw+Vd9PM/oPxZPZp6J4OceI4SjMvNtDEt6/gfQx2f
         f5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629433; x=1756234233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6TzjFTlH1JLT31fuDBg1E8dnevEFul98PYwdJPZ/QA=;
        b=fuL5dXO/wBJnDC720ie/MAA6YJDjK/1KDJh2oi33SEh2DAjrvj0LTLgyz4PsBgTTE0
         giPJzLpWf5kg0mugHqwQoA30FuHBx0AOpZZgb99mvd8AZxshJ7rpRu/3+bKWPwxgxb99
         LQZlNLKMyCsR4yXkp8f37+1Gp1OznQmEVWoDNhQz/fI5Qk/wkGUF3lR8Szgus+qgBqo+
         Xh0dTW1xusflHL8vtGD7KJQXbAvIEEEIAS2X6HcMj0GQY3a2es4sExQIyJKPXRTBaoBO
         UiZBVoVd01zioFoxmFbREyIjWSAqf7A++5z1LBB5G/lZ3bAPccxBprcShXzuszTRc7OD
         Domw==
X-Forwarded-Encrypted: i=1; AJvYcCWINuDrq8MKKrvL9OrmdbRlsm9DlO75+c4C0YsFhFXq91JIKMQTIRUL3wpLo6+UrOOy8Tw2pQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxz9ume2ufj5lHVH/3XweyC1pfAxAPJIxWeLrLjhPfwr7f0zfT+
	UUFYxlV7TEp0sCfZ3bUDRG0fypMUbskVAsUX3CZ0U4sO98dcBGSG2CUz5xE0yggKEQHCh893wZJ
	TPnbmclxxE6xcYD7Z6LXUAL6QWftYsHy6zMQW
X-Gm-Gg: ASbGncuI4jooD3KXpQkB1b6pPND4Yxuip3mQxWonVRIjy4yxEjP6MqBMABq+XMAN5LS
	9RXiCXTsR8Z5yx21+jT5yCFzlsCAKYwpACySsDgSiDH1EZuqCcv8/SniH7g41qhmmuL/yUF7uKz
	BTZriNXpFznDj1vvx4ViPWpd2x9ooI/Kz2p8gJhcKLnA2NVTS/wLQw48t7HsQ6U5wOhTUGDlVOo
	WkFA/+0Q9uW9S3niQ==
X-Google-Smtp-Source: AGHT+IGda0IIizbxCPJJm9t4/aSQ9T0Nii5wU9pqzECwR57ozSmbHWWPTvWOwOw4EmXjG9keWBdKHU2NOh9o2YBJxWY=
X-Received: by 2002:a2e:bc05:0:b0:333:b9db:f994 with SMTP id
 38308e7fff4ca-3353b411229mr1229601fa.6.1755629433258; Tue, 19 Aug 2025
 11:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250819090505.647690-1-safinaskar@zohomail.com>
In-Reply-To: <20250819090505.647690-1-safinaskar@zohomail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Aug 2025 21:49:56 +0300
X-Gm-Features: Ac12FXyd-2NK-WVdtMHQncLQl_D8Qy8lKaeQ5yRqYJIW50Ut9cx9W3FMFSLdIsk
Message-ID: <CAHp75VdY6YtaVER6QZ9K=iJfMEYvQ4=63KfEWEnthA1QQVFQ2Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Fix printf string specifiers, otherwise kexec
 doesn't work on my laptop
To: Askar Safin <safinaskar@zohomail.com>
Cc: Simon Horman <horms@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_115035_287664_FA356FB2 
X-CRM114-Status: GOOD (  22.56  )
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

On Tue, Aug 19, 2025 at 12:05=E2=80=AFPM Askar Safin <safinaskar@zohomail.c=
om> wrote:
>
> TL;DR: this patchset fixes regression, introduced in aecc554e7b.
> This patchset should be backported to all distributions, which packaged v=
2.0.31, otherwise
> kexec doesn't work at all at my laptop with pretty common setup with v2.0=
.31.
> v2.0.31 is broken without this patchset.
>
> See details of this bug on my laptop in first commit message.
>
> Okay, why the bug happens? I suspect this is because of "%lux"
> string specifiers, which are totally wrong. The author meant "print (and =
scan) in hexademical"
> here, but this specifier prints (and scans) number in decimal, followed b=
y literal "x". Oops.
> And this seems to break kexec.
>
> The bug reproduces on kexec-tools aecc554e7ba , but
> doesn't reproduce on kexec-tools 6aecc32c6db .
>
> I. e. it is regression, introduced by aecc554e7ba .
>
> Okay, how to fix this? Well, this is not easy. In 07821da7cf and d2f42971=
66 Andy Shevchenko
> observed compilation warnings, when %lx is used with uint64_t, so he repl=
aced %lx with %llx.
>
> Then in aecc554e7b Jeremy Linton observed warnings with %llx and replaced=
 it with %lux.
> (Yes, C is nightmare.)
>
> So, uint64_t is sometimes defined as long unsigned, and thus needs %lx, a=
nd sometimes as
> long long unsigned and thus needs %llx.
>
> How to fix this once and for all?
>
> I see three ways.
>
> 1. uint64_t a; printf ("%llx", (unsigned long long)a);
> 2. uint64_t a; printf ("%" PRIx64, a);
> 3. uint64_t a; printf ("%w64x", a);
>
> I think that %w64x is beautiful, but it causes compilation warnings on cl=
ang. (Facepalm.)
> Also it was introduced in C23, which is too young.
>
> "(unsigned long long)a" is the best in my opinion. This is what I used in=
 v1.
> But Andy said to me that POD conversions are evil.
>
> PRIx64 is ugly, but this is the only option left. So this is what I used =
in this version.
>
> Also this patchset fixes other misc things. See commit messages for detai=
ls.
>
> I tested on my laptop that this patchset actually fixes the bug.

There are still some small issues with the commit messages, otherwise LGTM.
After addressing them, feel free to add
Reviewed-by: Andy Shevchenko <andy@kernel.org>
to the entire series.

--=20
With Best Regards,
Andy Shevchenko


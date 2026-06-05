Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1032DCD6E6E
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 22:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ASI/Ub/JEtT4EKfj0fwBEiEH80u/0dqFtTJS0kVCOY8=; b=UIgOcxvMlnhdc1jm7Z2SQLArDV
	VXymViEO89RydywXY4wywuFXjkNyxxeUfYYE7JNOwVVc0b0iQO4V8eFqLWT5xfpeqtsMhiO6AZJWw
	eCjtZRqYQCYa7X0aWo0P/BFtDnnlOFH93XXi0qvN2EFuiq9V+P3yc9I9z3A2v/SJf6Xe7KDKBA7Rw
	xQL0ptP/Q4tX1X21pa8sFvtQesBiKZJVil45QHsrRMs90ZldkiZALOaETjronWCedzNFoMFdw0ash
	jfT4gglPNCcAWfD2PeNwwNiKViaQ4gm4VfLtMA1BBInDsx0yW9FZJ0Cs54hFQR497lPd2Gb8fcoOX
	KHo5ZWsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVciT-00000001Egz-2D1w;
	Fri, 05 Jun 2026 22:08:37 +0000
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVciP-00000001EW9-2tvW
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 22:08:35 +0000
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-963a7e48493so1701490241.1
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 15:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780697312; x=1781302112; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASI/Ub/JEtT4EKfj0fwBEiEH80u/0dqFtTJS0kVCOY8=;
        b=BjaO7pXKE1LBGSr6d8n9MJ5qUo6ix8gANEnFqBglmLGH9IV/xkf+4303I4JpTZesEO
         jmzs4QNQhgDtthfz9YPTZ2FTdLLK801k4RAkVdmLa/UJ3bcEcWlwblOwu0W55v45LlkX
         czEfY4Btg4a2FhdTeR3yYQ1vRBDJ/L+CSaT1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780697312; x=1781302112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ASI/Ub/JEtT4EKfj0fwBEiEH80u/0dqFtTJS0kVCOY8=;
        b=qyrAlxfAFRS5WWv8BXwbRajChlhesGy8EI7YuMznxKc9UH1piERnSIRDD/Q9KK1QO3
         WTi8LCHSphl+dzodWBz/zLHuOsET+zeX4eCJC1IGz11navJkykCCUrrc7MG5D8SeUzqa
         8qpYLBQRbF0mc3NbWNPRINUoKQUa6xgBDsibOcX7cM2PLpyWKsA4KXo5hw2UcMYQY3TH
         0KV4ORopqoaRYGn7Wo3bp/1mI+gqQDSpp9bAxnYsIwhS3/zyvwH+dDXA/9ma5bjwKeNq
         LLz8VSLSTjn3UnrflOBYU4FT9RC4cS7uBf3P2e+Ki11T9JASuz+TaIo3mWJslue7cwJP
         0pfA==
X-Forwarded-Encrypted: i=1; AFNElJ/8+qrzq4JiOj8MuV4zkgp8l2u8S2OLL1ihgVjvnlp6CcWQ9HpFiC8URgYhlSTTFDWH6uw9Tg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0DuerX5k21tg5OJJZGOTlEdxMF/tO+0+zX3+WBHIXJ/jvV9Pj
	MjZZSceFx9dmTwLPcadJ2P1EFSoz64CttJAlrxa2uoB4KgYAf+Po7PpIS0ntKDtA1QcKU8C4nhI
	N/hQ=
X-Gm-Gg: Acq92OHzr/nhbR09pKe2TIsBj0s6399+9wgTOx5xhSf3YbKI5JL1T7+Zw01Q0z94ASn
	QG7qjSadX/BAEay5tvVQ9HO127N1HUKz1P+tMCaSZ5gJ9Fqqj9nVnZDVJyzmqlq48njAkCZJnal
	jbO/iQHJqdTuoWC3cqC7wHaf7PC30ZyXW4rXYWyq/jfSXXq5JDA5Ut+eddOxemXIFFV4UP2JP4s
	AGnos6DTCXSLVXnR6Q2HNFYSX0GOa8WkcZLN1UPV1t0FXTqWFwmJiWhVnleYeYejo1TALM7Yl+f
	WoxmnRRgveKPBuwaRGqXcHSsZEhUutnFRf5Ixgdzob7SfQYXso0+bGLiVZARIw13laGNpNtkS3Z
	re0wmyKj+/tZUlwAr/TT2p9NiLQy+8Flt8hMBV9xkvA5LzsKGRlq7b1lwRsRdU6JCQwpmjRF00U
	PinAbHKV1pDaM3wNFYJDuhJUtBh9nBgQrMnOYV8/AsHg+EfEkRkcPPwjWID4BVa/+0qt7Ui1D9
X-Received: by 2002:a05:6122:8282:b0:5ab:26f:49f5 with SMTP id 71dfb90a1353d-5ac50312b75mr3536840e0c.6.1780697312066;
        Fri, 05 Jun 2026 15:08:32 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dc44da2fsm9003435e0c.9.2026.06.05.15.08.30
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 15:08:30 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-6ca94e539f9so1438266137.2
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 15:08:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+CLdnjpb2ntnc6nmTw1MSY7UXc8a1gGei+TauFDG4lqJWWqw7tUZmKQHgf6ES5AJGB4gcu1A==@lists.infradead.org
X-Received: by 2002:a05:6102:548c:b0:639:1e8b:ecd9 with SMTP id
 ada2fe7eead31-6fefa23308cmr3363451137.20.1780697309372; Fri, 05 Jun 2026
 15:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1780496779.git.kas@kernel.org> <6172eafcb9de6e626c0f1c36426d67e1e562ed32.1780496779.git.kas@kernel.org>
 <CAD=FV=U4eJ__dQc1e8CGgj5sMDNrD1MgEEy9Cgj9M5n-WmYAXA@mail.gmail.com> <aiM69AZXtGduS4VY@thinkstation>
In-Reply-To: <aiM69AZXtGduS4VY@thinkstation>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 5 Jun 2026 15:08:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VLs6+PjaoobSaNV9ZZ0v+aNceP8OwQuwCDsUr7uhakVQ@mail.gmail.com>
X-Gm-Features: AVVi8CeXTZbZ_bCiZKWuqK0BkpwxT8zq1PPYmubKztyrw4PW0_2EbW1xDkadtwM
Message-ID: <CAD=FV=VLs6+PjaoobSaNV9ZZ0v+aNceP8OwQuwCDsUr7uhakVQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: wire SDEI NMI into the hardlockup watchdog
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Breno Leitao <leitao@debian.org>, Julien Thierry <julien.thierry.kdev@gmail.com>, 
	Lecopzer Chen <lecopzer.chen@mediatek.com>, Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_150833_789007_02B8F4AD 
X-CRM114-Status: GOOD (  28.88  )
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

Hi,

On Fri, Jun 5, 2026 at 2:12=E2=80=AFPM Kiryl Shutsemau <kirill@shutemov.nam=
e> wrote:
>
> On Fri, Jun 05, 2026 at 01:03:05PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Jun 3, 2026 at 7:36=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov=
.name> wrote:
> > >
> > > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > >
> > > Select HAVE_HARDLOCKUP_DETECTOR_ARCH so the framework takes its backe=
nd
> > > from this driver. A per-CPU hrtimer checks its buddy's heartbeat and
> > > signals event 0 at a stalled CPU, which runs watchdog_hardlockup_chec=
k()
> > > NMI-like.
> > >
> > > The source is chosen at boot: SDEI if firmware provides it, otherwise=
 a
> > > perf-NMI counter (pseudo-NMI) fallback -- one image covers both.
> > >
> > > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > > ---
> > >  arch/arm64/Kconfig          |   1 +
> > >  drivers/firmware/Kconfig    |   3 +
> > >  drivers/firmware/sdei_nmi.c | 247 ++++++++++++++++++++++++++++++++++=
+-
> > >  3 files changed, 248 insertions(+), 3 deletions(-)
> >
> > I'm a little confused about this patch. We already have a buddy
> > hardlockup detector using the hrtimer, and it's even been improved
> > recently to trigger in a smaller time bound. It looks as if you're
> > duplicating bits of the perf and buddy detector here?
> >
> > I don't think you need this patch at all. The existing buddy detector
> > + patches #1 and #2 in your series should be sufficient.
>
> You're mostly right.
>
> Buddy + #2 covers the console case (the remote branch triggers the
> culprit's backtrace, which #2 makes deliverable), and #4 gets the wedged
> CPU's registers into the vmcore.
>
> The one thing this patch adds that a config can't is boot-time source
> selection: PERF-compiled kernels have no detector on a pseudo_nmi=3D0
> boot, and PREFER_BUDDY costs the pseudo-NMI machines perf
> self-detection. But that's arguably out of scope for the patchset.
>
> I'll drop this patch in v2 and run PREFER_BUDDY here. If a runtime
> perf->buddy fallback ever materializes, the gap closes entirely.

Sure. If you're interested in trying to make pref vs. buddy coexist,
that should be done in a platform-agnostic way. Feel free to post
patches for that. I know we discussed this previously. Ah, here they
are:

https://lore.kernel.org/r/20250916145122.416128-1-wangjinchao600@gmail.com

I think those got bikeshedded to death and nobody cared enough to keep push=
ing.

FWIW, my belief is that the buddy detector is superior in every way
except that it can't detect when all CPUs lock up simultaneously.
...though I wonder if a nicer way to solve the "all CPUs locked up" is
to just NMI-enable the "bark" interrupt of a hardware watchdog timer.
That ought to be quite easy...

-Doug


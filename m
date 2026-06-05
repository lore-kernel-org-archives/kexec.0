Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB130CD6E7B
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 20:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ISDeP/qyYAEltSrqbCKLAdEkNOxIUqnGYCtw5a23CLI=; b=KrgOJO0VngnpHv6EEJj5Y7NOKo
	70OKLgzFRaQ4SpdgoUWn91tQIrrLPprIwxr7DZ6cxvvpe4LJsRsCJGOfiK2SbfjqU1MaCSPQ7akew
	XfzkLJaE0GXNa92wKcaqeXStiAdVLrPQ8ICGOwl1k4TbZxhV2ZPdVLGMLSeUoWEzTborqSajKimH6
	LSwLV9RhH9ey36zoGHXsVn1GfLNTN2y2c3QWWlw88YLsWf6+CV5FSp7T406avxTx89XgRM/o/OtkJ
	yBenCulRwRXWMpERO2vEvtvrxGn4HEyW+/d9xIU3MGN57BYN8BKHCPGnYV7SJ5CZopw8+aWCowgta
	qU/Ix+JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wValH-000000018wf-3e2U;
	Fri, 05 Jun 2026 20:03:23 +0000
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wValF-000000018vt-2gq0
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 20:03:22 +0000
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-59cd803792aso1657587e0c.3
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 13:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780689800; x=1781294600; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISDeP/qyYAEltSrqbCKLAdEkNOxIUqnGYCtw5a23CLI=;
        b=UIzUZraSKTHVSgCJFs8c35EkElFq0+9LpW0EKu9glNy1AtApFUVKOLn/iUNd0wu0Tt
         BxVBWIRLLQcNfRZK3kyw5iEYOy2o3uQjyKNn53QuGulkPI+xs65YmmQg6CzqBfBYAs3f
         jjcmZ93pa4gOGurgadykOPmeVs6mWIFLUMyyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780689800; x=1781294600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ISDeP/qyYAEltSrqbCKLAdEkNOxIUqnGYCtw5a23CLI=;
        b=MqHrfydfoO0uBAq0/+t/4RZG/ImUiJUQAV8mKkhE8Ah4+JBsJfC6I180F61+uLUBS7
         rgDwIZSDOjYf+/ZAeDb9ZTVBX1s9OvITmZI7KD4rJY+pKjKam2Jf0K/wgfXU97p2wzd2
         13cp4cY5v5sKc6tFk4vF/MXvLN+1GQm/RtX/7Ajitmo7FLqbrIqjqTw/eiIUY3XYbN2J
         4ynhSCu5r4iSiLTJscj4O90yFy9ND+zw82MmWDWs+k8fkFJxcKrc74WUIDsat+pfr3wu
         P0pDdZt9EmJy6bKtv35MiCmkck7R8IA7dzQ/A0Z5yoUc9y0LWTH4yKijBIYhsakHPMQb
         8nHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qg9a8qEQ0qCUcAk2xft3bQF1utWgbGnIWEVgz4+7y3rp+JFeUll2tNG+z1JzsyxFEapBs3g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxoaDc9C0fh56rFJhsPEavIbc4jsbdzFmEUnfsyXpJEKDoGBugh
	CgiPEEMMel3OJtxL97K8TiVT/u3MHNa+eYvnDkD1XafQUv2ccl7VSZzbh1iOMPIJbbg/scRt155
	sMeo=
X-Gm-Gg: Acq92OGOuKi6naEzQyumgNoXwBrpAKVUYtKdN+Lg3dNxS1cbWJXIvQEgx+PByIA35xf
	BE0AxBEN26++EzAZTz0dbOUx8WfcfKB5/SnqYdd2viIM6x0e6XAi58rdb9U7DN8yD2cFQwVsiQC
	wQyaB2qloxPz/WuW3X4CJevQHGG2UxT7g5aqoJbieZ9IvxyjQg/HNZ3kMX/XfhPVL8kF4CQIA9J
	LCQiH8NmxlxwYkCDAfif3FoIhyGFnjF9czaJs+mn4gg/D+nemkMIZFm83u8TXVh50kftijUDTAH
	ED4XLiKxRfT9QDTrxFSkto6AnNCqfJEcC9hN/qpmTRscEtPTOKyGyavQ7DRQtwxOMgMlg0APU3u
	JRHoKy69z+SAGfbVyrqldz/1SRJU9w0xbA9w9Lvn96YH6IEX0gaPvFbfQcmii7ZTnlZxO3Y86c9
	vSLAtawnRb/8r0AKuVMuB5CcWFqRH7tfJtc1zjWv2+pAq/8upiS7knbQQHZkv19UWszfo1LP3OI
	U3551B3Mda+Ko0=
X-Received: by 2002:a05:6122:6e0f:b0:5ab:26f:4a42 with SMTP id 71dfb90a1353d-5ac4d5208c3mr3417243e0c.0.1780689800280;
        Fri, 05 Jun 2026 13:03:20 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dd501a90sm8856081e0c.17.2026.06.05.13.03.17
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 13:03:18 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-59cd803792aso1657553e0c.3
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 13:03:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Bk09uO9BKdu5riv+OqvlSbzz/ydxCZ4YlEQZk+jhfSa4lR3hIfH1p+p0MFDGnp1iWFipIyA==@lists.infradead.org
X-Received: by 2002:a05:6122:906:b0:56d:451b:e4dd with SMTP id
 71dfb90a1353d-5ac5792009bmr2730729e0c.12.1780689796811; Fri, 05 Jun 2026
 13:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1780496779.git.kas@kernel.org> <6172eafcb9de6e626c0f1c36426d67e1e562ed32.1780496779.git.kas@kernel.org>
In-Reply-To: <6172eafcb9de6e626c0f1c36426d67e1e562ed32.1780496779.git.kas@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 5 Jun 2026 13:03:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U4eJ__dQc1e8CGgj5sMDNrD1MgEEy9Cgj9M5n-WmYAXA@mail.gmail.com>
X-Gm-Features: AVVi8Cemd2ZnzLkxdzHldi4k5VmRnmgjGuGWN3228_wubZLNmG-MW1yRJDWJrzg
Message-ID: <CAD=FV=U4eJ__dQc1e8CGgj5sMDNrD1MgEEy9Cgj9M5n-WmYAXA@mail.gmail.com>
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
	linux-kernel@vger.kernel.org, "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_130321_682907_BCE47E15 
X-CRM114-Status: GOOD (  14.74  )
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

On Wed, Jun 3, 2026 at 7:36=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov.nam=
e> wrote:
>
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>
> Select HAVE_HARDLOCKUP_DETECTOR_ARCH so the framework takes its backend
> from this driver. A per-CPU hrtimer checks its buddy's heartbeat and
> signals event 0 at a stalled CPU, which runs watchdog_hardlockup_check()
> NMI-like.
>
> The source is chosen at boot: SDEI if firmware provides it, otherwise a
> perf-NMI counter (pseudo-NMI) fallback -- one image covers both.
>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>  arch/arm64/Kconfig          |   1 +
>  drivers/firmware/Kconfig    |   3 +
>  drivers/firmware/sdei_nmi.c | 247 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 248 insertions(+), 3 deletions(-)

I'm a little confused about this patch. We already have a buddy
hardlockup detector using the hrtimer, and it's even been improved
recently to trigger in a smaller time bound. It looks as if you're
duplicating bits of the perf and buddy detector here?

I don't think you need this patch at all. The existing buddy detector
+ patches #1 and #2 in your series should be sufficient.

Did I misunderstand?

-Doug


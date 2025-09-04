Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBCCCA1015
	for <kexec@archiver.kernel.org>; Thu,  4 Sep 2025 07:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tb40G1BP2UOmzBv4K9eP2Zzmqp+7E3i2B0tVuKcnrc0=; b=VSkdPLS/CDfxx1lKpFJMHDfqYZ
	dnkdtiDDtcAmMeN8osG3mfHEABd9q3XWDc4opnGf26dS9h+hm6hScu8yVB8fFECNaMa38Riw///fv
	ROESDjv+g+o4eFpbPUSmafJgWJZ/HjNavqFGohv3tF0g/NzwDk36/3BNrw808oT3ZWNqTliHPbmMg
	jKIMh6bHafj0HGn/FVn2ZB1uvIu27AxUc+X9n+BRC/BJNSpT9e2MwwsfA1r7wbd/wTxo6JoVxpfdN
	dp9rek5ozt0GpeX1ZF5jBod13kjf2sX5jaT81kdvXd0LIa3qv6assbXXTrxEfHEa4Tz9TahZQO5N7
	Ac5mPAdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu4PQ-00000009rtu-3bUl;
	Thu, 04 Sep 2025 07:29:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu4Fs-00000009oRl-1Sl4
	for kexec@lists.infradead.org;
	Thu, 04 Sep 2025 07:19:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ABC7B601A4
	for <kexec@lists.infradead.org>; Thu,  4 Sep 2025 07:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BD7C4CEF4
	for <kexec@lists.infradead.org>; Thu,  4 Sep 2025 07:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756970375;
	bh=72oYlNKXXmAjA5Q5e13+DWrwi/CpM80zljJXvzw63aw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RkpRQhtW+a9Y5lrqRKRhT35FXEw1JPCeIWAQrYQnCH0PzIhHfBAOhG2Y5tMpknarz
	 Pl6vzMh5wTJkjfijbtkfNLawzbNfsDaIq0XFhQ03u1qXSHpsWOyAsewXLQkmGGDpF4
	 g5AZtKvc/NMoBuOSrEYboremIyftnqUZnccdN63+lyYaqC2zXAg1ev7wfVJH2lBPPs
	 JVWLymM+QXBvbXwT51vLAHuB98LJ3hPXoXOI0XidDfDFuhAkXtfKW2uJbzeDUKLK45
	 gu3YhlMYSQbv5cDMx39swAF/M58+EsE1FTxDMYZouqSbCtxD0PLFI34ZU+9r65T2RB
	 b7Av9NcRTOQvQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f69cf4b77so787855e87.2
        for <kexec@lists.infradead.org>; Thu, 04 Sep 2025 00:19:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRu83sFHJk9kqqAGZIniEO3XN7+vsrmki9zic65cPn4thzSHRTYMxQrsPs7yTRSpZK5OonOw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwIlebOUppxxltOaY7F81kDzF8s5CGyGDLkzMFnIoVVNI5trfD2
	4FF414hDCy1H4goXlVaM0didKDsysgJLZ5hD9ypUiXZPDodxuD3jPL/nnffcoCgceoFKI1zMtED
	u19tO3aqoECvWe/GYtDfuMV9Gkt6VTC8=
X-Google-Smtp-Source: AGHT+IEFvmAnCvfgO7PlnrG1BYUxZTjjsz6BPZ180OOcQw+OkZ+byNbMMbmHC7LJX6qhewccjpN/hH5j8/8g6mEFmZQ=
X-Received: by 2002:a05:6512:239a:b0:560:8d97:8bb8 with SMTP id
 2adb3069b0e04-5608d978cd1mr1413481e87.32.1756970373660; Thu, 04 Sep 2025
 00:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1755721529.git.epetron@amazon.de> <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
 <CAMj1kXFQwOHyQg2LtabMA3qxiBn_AVV_JNfki2WPSg8u_XbBcg@mail.gmail.com>
In-Reply-To: <CAMj1kXFQwOHyQg2LtabMA3qxiBn_AVV_JNfki2WPSg8u_XbBcg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Sep 2025 09:19:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFzKzpoqczq7Rk-u+kKLFO057XEXMD+KM=iRMMsoUZbJA@mail.gmail.com>
X-Gm-Features: Ac12FXzg-Gwf5w9Dkz74akKGMbsagt1QMuLWSxeot3bSIi-D7R24FEVq60rM11k
Message-ID: <CAMj1kXFzKzpoqczq7Rk-u+kKLFO057XEXMD+KM=iRMMsoUZbJA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] efi: Support booting with kexec handover (KHO)
To: Evangelos Petrongonas <epetron@amazon.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Changyuan Lyu <changyuanl@google.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 23 Aug 2025 at 23:47, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (cc Ilias)
>
> Note to akpm: please drop this series for now.
>
> On Fri, 22 Aug 2025 at 04:00, Evangelos Petrongonas <epetron@amazon.de> wrote:
> >
> > When KHO (Kexec HandOver) is enabled, it sets up scratch memory regions
> > early during device tree scanning. After kexec, the new kernel
> > exclusively uses this region for memory allocations during boot up to
> > the initialization of the page allocator
> >
> > However, when booting with EFI, EFI's reserve_regions() uses
> > memblock_remove(0, PHYS_ADDR_MAX) to clear all memory regions before
> > rebuilding them from EFI data. This destroys KHO scratch regions and
> > their flags, thus causing a kernel panic, as there are no scratch
> > memory regions.
> >
> > Instead of wholesale removal, iterate through memory regions and only
> > remove non-KHO ones. This preserves KHO scratch regions, which are
> > good known memory, while still allowing EFI to rebuild its memory map.
> >
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> > ---
> > Changes in v3:
> >         - Improve the code comments, by stating that the scratch regions are
> >         good known memory
> >
> > Changes in v2:
> >         - Replace the for loop with for_each_mem_region
> >         - Fix comment indentation
> >         - Amend commit message to specify that scratch regions
> >         are known good regions
> >
> >  drivers/firmware/efi/efi-init.c | 29 +++++++++++++++++++++++++----
> >  1 file changed, 25 insertions(+), 4 deletions(-)
> >
>
> I'd rather drop the memblock_remove() entirely if possible. Could we
> get some insight into whether memblocks are generally already
> populated at this point during the boot?
>
>

Ping?


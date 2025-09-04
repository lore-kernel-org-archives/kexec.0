Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9854BCA1016
	for <kexec@archiver.kernel.org>; Thu,  4 Sep 2025 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wqwtBP0K+7f0j3IdSu9ZNLeR1MixCwE8h3oP16EJpvM=; b=0OuvVuqAZECajg5qA3ia4aFkup
	A781poh0/iFAXCdJEu3njcZZWAVUBLEWAvOvgDQ50K7MO8cSR31CXqA/t1zYACuc9EuXP7VRCnjym
	oMfDkkRSD4DkCunwBjQZ2hYxRr4c5ucDS/upUzmM2dk7XZkLr+9j/YEHW0bk4Kjk59n2eQrFbQBs4
	l0vMsmZWN8Fjn1Yq+2vIpC1H2fzlZgyqqHrd8owsvEOFa6hey+OFVBVhlIvI74kJuvV4D++FkvvIt
	NzVsUHYImxpfC0y8FxTrVRPSB8MboKEWr7/aA4AXu4RhpaNoeJWpV05Wo1YHw2dtg6iOmumZOj+Y+
	+xeKEj1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu7Vr-0000000B09n-0i3A;
	Thu, 04 Sep 2025 10:48:19 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu6R2-0000000Ac6H-3SnZ
	for kexec@lists.infradead.org;
	Thu, 04 Sep 2025 09:39:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4615F60285
	for <kexec@lists.infradead.org>; Thu,  4 Sep 2025 09:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11E5C4CEFB
	for <kexec@lists.infradead.org>; Thu,  4 Sep 2025 09:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756978756;
	bh=b7BACgAwQUb+uyXmCf5NXBvllTt2WyPGKAHbjgfVB+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hq8dWolf0lAYzF8jShP680EJaAzvGQim5Lr2AfrQ+ynHO4bA1yUoLufGdEjFWxoDt
	 WueJWqG1gjLENcYyHwFD5cR5wiD1q96ufPzHkiUEZgiq/iJ+N/Fh/WFzgbupuusSXV
	 J+Uxdr6+jY/CQ13BmQhYpvw7+3tqOG7fHtUC03nC5V5Wtrs1mvWDn1HVoFdWQSxg4W
	 /GEItyCPqtMKGEHnHChwaXCQdULZQDHHXAsgppVPbyaYGyRqpYzHK9MRXPU2FRZvvx
	 MNrqF5Tep+j54821ldD8OUoF8un94CzR2u0VZbVY7vhVxzWpxthQhZVLZWSHgJbiP1
	 0q7SVgtv4I0Bw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f720ffe34so997036e87.1
        for <kexec@lists.infradead.org>; Thu, 04 Sep 2025 02:39:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWp8yOp1ARsCnmnrI0LZbqrQGDeHCf+tHgr6W5zqAHZXQ+tVyanoWBmV8DNiozJAa6xNOPO8Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw2ajQdEzZAyiBrW9LP+NCGJ7NlBR6mmZ8JwjEvV4fSz4iWKjqo
	5DrzT2RgY0u+QQVmElBVFGrC4LyyMnHnry6OVIi56sf1CG4bCIIsA1CmOlmfEVqyW1Qtr53HhpL
	Y8zRcYEIDr31RJctWdT3F3O/v5ODyfN0=
X-Google-Smtp-Source: AGHT+IE+sZix8HxDMFoQ4qCVA3ERgwP0vsD+zEJb2XElfW+EN65uuxN8+XQS8HhSU1B4zUIkMiL6fynWNcS2PalYMqE=
X-Received: by 2002:a05:6512:63d9:b0:560:83e2:1db7 with SMTP id
 2adb3069b0e04-56083e220c3mr2265147e87.6.1756978754251; Thu, 04 Sep 2025
 02:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1755721529.git.epetron@amazon.de> <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
 <CAMj1kXFQwOHyQg2LtabMA3qxiBn_AVV_JNfki2WPSg8u_XbBcg@mail.gmail.com>
 <CAMj1kXFzKzpoqczq7Rk-u+kKLFO057XEXMD+KM=iRMMsoUZbJA@mail.gmail.com> <20250904093455.73184-1-epetron@amazon.de>
In-Reply-To: <20250904093455.73184-1-epetron@amazon.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Sep 2025 11:39:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHTJxBMFX6J-QwcPRojLGMQsTNOH5Bz9kHk7CFdt1JApw@mail.gmail.com>
X-Gm-Features: Ac12FXwC151u6vsYrsntF6Gl_qF6tE-aW0TPl91D1Up2Kpmz5zWqn28--0rAVOE
Message-ID: <CAMj1kXHTJxBMFX6J-QwcPRojLGMQsTNOH5Bz9kHk7CFdt1JApw@mail.gmail.com>
Subject: Re: Re: [PATCH v3 2/2] efi: Support booting with kexec handover (KHO)
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, 
	bhe@redhat.com, changyuanl@google.com, graf@amazon.com, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nh-open-source@amazon.com, 
	rppt@kernel.org
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

On Thu, 4 Sept 2025 at 11:36, Evangelos Petrongonas <epetron@amazon.de> wrote:
>
> On Thu, 4 Sep 2025 09:19:21 +0200, Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Sat, 23 Aug 2025 at 23:47, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > (cc Ilias)
> > >
> > > Note to akpm: please drop this series for now.
> > >
> > > On Fri, 22 Aug 2025 at 04:00, Evangelos Petrongonas <epetron@amazon.de> wrote:
> > > >
> > > > When KHO (Kexec HandOver) is enabled, it sets up scratch memory regions
> > > > early during device tree scanning. After kexec, the new kernel
> > > > exclusively uses this region for memory allocations during boot up to
> > > > the initialization of the page allocator
> > > >
> > > > However, when booting with EFI, EFI's reserve_regions() uses
> > > > memblock_remove(0, PHYS_ADDR_MAX) to clear all memory regions before
> > > > rebuilding them from EFI data. This destroys KHO scratch regions and
> > > > their flags, thus causing a kernel panic, as there are no scratch
> > > > memory regions.
> > > >
> > > > Instead of wholesale removal, iterate through memory regions and only
> > > > remove non-KHO ones. This preserves KHO scratch regions, which are
> > > > good known memory, while still allowing EFI to rebuild its memory map.
> > > >
> > > > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > > Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> > > > ---
> > > > Changes in v3:
> > > >         - Improve the code comments, by stating that the scratch regions are
> > > >         good known memory
> > > >
> > > > Changes in v2:
> > > >         - Replace the for loop with for_each_mem_region
> > > >         - Fix comment indentation
> > > >         - Amend commit message to specify that scratch regions
> > > >         are known good regions
> > > >
> > > >  drivers/firmware/efi/efi-init.c | 29 +++++++++++++++++++++++++----
> > > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > > >
> > >
> > > I'd rather drop the memblock_remove() entirely if possible. Could we
> > > get some insight into whether memblocks are generally already
> > > populated at this point during the boot?
> > >
> > >
> >
> > Ping?
>
> Hey Ard I was AFK travelling. I am back now and will get to it.
> PS: Keen to meet you later today in the KVM Forum.
>

Yes, let's catch up!


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F066CC61CE8
	for <kexec@archiver.kernel.org>; Mon,  9 Jun 2025 20:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q1DFQw67oYiMjYNfjgsljBrJ/qGcx57WY9wqDizp8tM=; b=2UfOF5pdEuKdLPkXbmnEPzdTJF
	zrBHHLjXqTTFwocSHl7fKWSlsCtUebnHWzuO0CiWHI/doZYgcc+JFqGnPQeC7jMMS6Etw1SkmbEA1
	FypQA7qWl4PGjbeOujFiU1vXuOoxL5ZOmdEFN9GggflyKYKPw9BGKTRNJdklUutYF0YcWxC6/muxP
	WevbBYN1DpVp0yk3uFN+N3i5BXirhTEdRJnGhQIpQmGW8UrCHC2knqd44RimZpnF7xPlG0oLzjNVS
	jzC/GZwvvUnqh2aWEghrLt+PF2S14Nhvk/asLsKbYuKXlegp8A3c8f/jaB9XypBKCmI9XVdxygRS3
	2a5/+BaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOipM-000000058CG-2XaM;
	Mon, 09 Jun 2025 20:10:40 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOinD-000000057sK-49OW
	for kexec@lists.infradead.org;
	Mon, 09 Jun 2025 20:08:29 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4a42cb03673so60519951cf.3
        for <kexec@lists.infradead.org>; Mon, 09 Jun 2025 13:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1749499707; x=1750104507; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1DFQw67oYiMjYNfjgsljBrJ/qGcx57WY9wqDizp8tM=;
        b=cxj1e6/bFD8id4pjhapynjfwl+pKrUInTVlHbXTwggoTW0aCkQNGrKEBXzP3yooQc/
         xla20M0Ab+dGJP3uRnRY4NPLCzfQQ0RxO5CvkS793plOOChLXRfOCGDRXeevhRe0QuqQ
         VWxaBWnA4k4uXTHg8oVLN5HXkEugb5qnNgO2Su3SJqGmNzZYm9QPAQnImL2eRsckWOnO
         2THKQbyhU9YCdeQelDjSIWrPfJ2hWux7x3Zqb75EkIYPPirJ/pkO+GeVpFWJpFGraTa8
         d7nY29VmqmeeuG00A4yyULcbR1w3pZ4nGhEEargSlP4QnoMBC/cUZx/0rLTCvBoSTzrq
         WbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749499707; x=1750104507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1DFQw67oYiMjYNfjgsljBrJ/qGcx57WY9wqDizp8tM=;
        b=SfPI4S/IyPrCnqM0LS373MW394QpC6DS/nTCozlq6XwwNj/Mx8CO+qPc4DJ1fyO6Td
         jEdSf5pd0ugilZqFr2C0YflVZ3j7dHoSoN/DX2tdXmArrqtPMWf/2VYsZdugneinlmUp
         aGP9xynNw+OTX6Y2BToaoNaeuT3cnr+/PKFbUNwHSxmKspW/cssriOpdzzXmlVJFW647
         dWewbs7jstHSjBuVl676IDWYg+MyLqkbspEtvnhFHAkDeWmX38XIBAEx8UckXIpFlpcR
         B4qLuyFPRMuZMnBUdvcfofSwax3/KBrILR0XxCNadaBbAPUOEYhEkTsGbvGShEGltdf/
         UkBg==
X-Forwarded-Encrypted: i=1; AJvYcCXrVQy3w4zlrCYi2qASFbV+gQSfGPxzkdyp6k29dCeCLLlcXcxaIlbooMrp78uK+nx603pFAQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxSRcfTga/Ztt+o8wMLIkD2/AG4cAiVxpNoNnquNscorfjPOvW7
	9UbQNFK5nBjngWUzRs8aiDazjOi3ZL585nvjsBeFpNvk+jeAU2qY5QIsQvsGQwWvbdIrkakfe40
	HaFxxH2UspinmR8wR/i9l6AU/37MciB1z63QfzZQVPQ==
X-Gm-Gg: ASbGncvrPfjBmjKTlKM0FzTq2tkwp5ny6K/GvvtVAHgBs/J1kJhTfQTTWpPQXDHQtg5
	pP85Au0IIj1KvpC935hupajU4Z18ghKDM2mR7O6kwBf/hpdSgkLEVt/qPK1y+TFIoIRh/57N6uA
	O4G5oMBoSVYoJqB9SItDdSpZbrojWR8MyOOj2OcHz+
X-Google-Smtp-Source: AGHT+IHwZ8xxwy1rbJ2XYzDgbb0cvWkJy5FW984f0Zrhq4kdp7mC5bx3gPRzk5/yaIfN5T8ydPXCdjKttoq3lg7ewfM=
X-Received: by 2002:a05:622a:4d94:b0:48c:54ad:c409 with SMTP id
 d75a77b69052e-4a5b9e00aacmr196256071cf.10.1749499706847; Mon, 09 Jun 2025
 13:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250605171143.76963-1-pratyush@kernel.org> <aEKhF3HcrvG77Ogb@kernel.org>
 <mafs0jz5osutx.fsf@kernel.org> <aEc30BoLE9HRxiZm@kernel.org>
In-Reply-To: <aEc30BoLE9HRxiZm@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 9 Jun 2025 16:07:50 -0400
X-Gm-Features: AX0GCFtEuDZaSUxyvgIQvzavhtS0Upun00DQmQthsZKvdGuGbBntdnwQlmoxuqE
Message-ID: <CA+CK2bAAbZjS2Og79xxLcDtNf-eM0up-8fwhd4fg_dp0j_TahA@mail.gmail.com>
Subject: Re: [PATCH] kho: initialize tail pages for higher order folios properly
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Changyuan Lyu <changyuanl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_130828_118516_520A3768 
X-CRM114-Status: GOOD (  33.28  )
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

On Mon, Jun 9, 2025 at 3:36=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> Hi Pratyush,
>
> On Fri, Jun 06, 2025 at 06:23:06PM +0200, Pratyush Yadav wrote:
> > Hi Mike,
> >
> > On Fri, Jun 06 2025, Mike Rapoport wrote:
> >
> > > On Thu, Jun 05, 2025 at 07:11:41PM +0200, Pratyush Yadav wrote:
> > >> From: Pratyush Yadav <ptyadav@amazon.de>
> > >>
> > >> --- a/kernel/kexec_handover.c
> > >> +++ b/kernel/kexec_handover.c
> > >> @@ -157,11 +157,21 @@ static int __kho_preserve_order(struct kho_mem=
_track *track, unsigned long pfn,
> > >>  }
> > >>
> > >>  /* almost as free_reserved_page(), just don't free the page */
> > >> -static void kho_restore_page(struct page *page)
> > >> +static void kho_restore_page(struct page *page, unsigned int order)
> > >>  {
> > >> -  ClearPageReserved(page);
> > >
> > > So now we don't clear PG_Reserved even on order-0 pages? ;-)
> >
> > We don't need to. As I mentioned in the commit message as well,
> > PG_Reserved is never set for KHO pages since they are reserved with
> > MEMBLOCK_RSRV_NOINIT, so memmap_init_reserved_pages() skips over them.
>
> You are right, I missed it.
>
> > That said, while reading through some of the code, I noticed another
> > bug: because KHO reserves the preserved pages as NOINIT, with
> > CONFIG_DEFERRED_STRUCT_PAGE_INIT =3D=3D n, all the pages get initialize=
d
> > when memmap_init_range() is called from setup_arch (paging_init() on
> > x86). This happens before kho_memory_init(), so the KHO-preserved pages
> > are not marked as reserved to memblock yet.
> >
> > With deferred page init, some pages might not get initialized early, an=
d
> > get initialized after kho_memory_init(), by which time the KHO-preserve=
d
> > pages are marked as reserved. So, deferred_init_maxorder() will skip
> > over those pages and leave them uninitialized.
> >
> > So we need to either also call init_deferred_page(), or remove the
> > memblock_reserved_mark_noinit() call in deserialize_bitmap(). And TBH, =
I
> > am not sure why KHO pages even need to be marked noinit in the first
> > place. Probably the only benefit would be if a large chunk of memory is
> > KHO-preserved, the pages can be initialized later on-demand, reducing
> > bootup time a bit.
>
> One benefit is performance indeed, because in not deferred case the
> initialization of reserved pages in memmap_init_reserved_pages() is reall=
y
> excessive.
>
> But more importantly, if we remove memblock_reserved_mark_noinit(), with
> CONFIG_DEFERRED_STRUCT_PAGE_INIT we'd loose page->private because the
> struct page will be cleared after kho_mem_deserialize().
>
> > What do you think? Should we drop noinit or call init_deferred_page()?
> > FWIW, my preference is to drop noinit, since init_deferred_page() is
> > __meminit and we would have to make sure it doesn't go away after boot.
>
> We can't drop noinit and calling init_deferred_page() after boot just won=
't
> work because it uses memblock to find the page's node and memblock is gon=
e
> after init.
>
> The simplest short-term solution is to disable KHO when
> CONFIG_DEFERRED_STRUCT_PAGE_INIT is set and then find an efficient way to
> make it all work together.

This is what I've done in LUOv3 WIP:
https://github.com/soleen/linux/commit/3059f38ac0a39a397873759fb429bd5d1f8e=
a681

We will need to teah KHO to work with deferred struct page init. I
suspect, we could init preserved struct pages and then skip over them
during deferred init.

Pasha

>
> --
> Sincerely yours,
> Mike.


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC87C677C4
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 23:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g8Bytf44g5ahAkLfve403jgiYb+uxN9HvR9Tj8YMufg=; b=hQVlDWHyC3i5gtCRKnrh9SJ/S8
	Jb7QOcYt5++0DTuBWynYB6KNsd+38pwbWWM6CZ1V5ALycoi/dtZ5SpjNx18uRiszUNmVkH6IqUZ2w
	gmuD0KKtvldMsi5g4O0eboy0AfS6LehBVo68472dbjgK54sS0eoZo5EIhoeypFIfqh75ozdbhP3x3
	+7FnaQsHxPbDdSVNEfj+GN223JA5to7E4vdtdiySPMSYVzE2JMhbsqetum23cpiimL9dmvkblNrWe
	iAETWgRRD08hw0Sj2lN53OX7hs4bajuUmxEN2FiPNRmd0JmByaj8jdGovUkw7Gi7gL1f633eSPa/H
	PJqz3Vqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP8n4-00000008QYV-2o2L;
	Tue, 10 Jun 2025 23:54:02 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP7Xs-00000008DTN-1Va5
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 22:34:17 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4a58e0b26c4so97532161cf.3
        for <kexec@lists.infradead.org>; Tue, 10 Jun 2025 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1749594855; x=1750199655; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g8Bytf44g5ahAkLfve403jgiYb+uxN9HvR9Tj8YMufg=;
        b=W60S24UkwDuMvLRZRzWLxavUUuaWDlrftY8BTlUzAiBCVf5ODAb9M/o7XQSTfwfZn6
         TvKOGmubY4qEPtmn0gZi9qkJCRNuS8MX2TG3UgPqp9Fp2F+yEOAvDhE7GIMLzwRN4Y8q
         cpxCTjg2pGyPhRuPSeINpwaunr8iGbXSxRsjrpt5i7hzWRDwoMXnnDjm5g+gByHpF48g
         NfkNoCxDQzImigXjHLgdbAAe+aqNMIPtL+pRU4Owcu6fE8w225T8hSE79u6+RPACQzzr
         PvjqwUXffTj4Ay7gK1VpCY2P3hAu2j8790D6lhFxkEFBinZfZ5G/hA8db6DgF/TaDv6x
         GwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749594855; x=1750199655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8Bytf44g5ahAkLfve403jgiYb+uxN9HvR9Tj8YMufg=;
        b=WdKXIy6gvNJYCVpxHXyAR5EoBeEiiw35T49FmhJYHsYEwX9nKeXfnP5q/o0PPHZHFB
         VbWYnGP3QJvvvyJmN819B9eP6Qy0zd4lh2Ccza+Knx8BwzQtsCcqan1URY+Omyka13a1
         Tr6yOTv3558Ruof5i1GcZ+chE0tREyB6Ysb4pQhDeUdqSSs9FRzznoTt7KUhk8No8pzy
         BuEBM0LlnxMBfPaEUvLUTnvLXI2NB61vnOdzivHVV7B3VP5mCcIYxEw9lhX6J9LM2qRX
         FSgPAsMAu+aRaa//xHxKPbw2FK5kHkRwfYRp7zt46W+5tyB2aETBrkVTwzPeKdx2sp9D
         bZWw==
X-Forwarded-Encrypted: i=1; AJvYcCURyqhlEipK13UCQ+II3xZy88JsaGf2MmsL94mmpwpyha5hdw87igyuJ87hHYjHNmaLYfrO1Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwXaOFaneAEh7ONKyZ8swqm1eab5oeKcxHrAlAr1DAhFrcZDme5
	dwRKiw+LQPAg0xjeenS699ts4t0OFyrEHYULA0PfOnDUSPGttmvfsmrUg08NzV/r7mTvvcgB3M7
	gOemfYWte0bi4TeJ1ekCb2ZweDEYyOE6MS6MHdmyHgg==
X-Gm-Gg: ASbGnctOupMbYIP9wXU5UuE86shZGYRKHRhKOT6m/UkqGjf4RzrDvETgwtJPf7K8yNn
	dJeW627VKIHCyT8QSTegPO156jyu1jBV1RPvFN4iUXdpFmFUseyOTBD4+0WUuoOT8cuHi9fntUB
	YnPoOy9dRZKBp0NFiNcM81zXKHN67YNRyCzsbMAC1YppFDVc2tomU=
X-Google-Smtp-Source: AGHT+IHSkj9Ox3qM4oxVyr5va+0+HoSbN/LLwfuLeFvYTxchuXt69sOnDinqF5sKYnwKgdPq/ii5HJ6fe9Jm7X41Znc=
X-Received: by 2002:a05:622a:579a:b0:4a4:3be3:6d69 with SMTP id
 d75a77b69052e-4a714c8d948mr10914881cf.41.1749594855242; Tue, 10 Jun 2025
 15:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250605171143.76963-1-pratyush@kernel.org> <aEKhF3HcrvG77Ogb@kernel.org>
 <mafs0jz5osutx.fsf@kernel.org> <aEc30BoLE9HRxiZm@kernel.org>
 <CA+CK2bAAbZjS2Og79xxLcDtNf-eM0up-8fwhd4fg_dp0j_TahA@mail.gmail.com>
 <aEfGTXrsEL5-DuF1@kernel.org> <CA+CK2bDXOWzrTsNtbCCK2rabNysf0JFQT5VfAjYrX5oSoiLmSQ@mail.gmail.com>
 <aEhgNU80Dr9iRwoD@kernel.org>
In-Reply-To: <aEhgNU80Dr9iRwoD@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 10 Jun 2025 18:33:38 -0400
X-Gm-Features: AX0GCFtJcS6mAcxYKHzkPfp4Zf1aggcovv204XYP6gR6eeACW9WTRiEaZ4dYXr8
Message-ID: <CA+CK2bD3n=JDuSsMGvsyMnVbPhGdhdf6zWFDa3KpzRGEXygdgQ@mail.gmail.com>
Subject: Re: [PATCH] kho: initialize tail pages for higher order folios properly
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Changyuan Lyu <changyuanl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_153416_510391_C94731CB 
X-CRM114-Status: GOOD (  22.94  )
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

> > > I think it should be the other way around, KHO should depend on
> > > !DEFERRED_STRUCT_PAGE_INIT.
> >
> > Agreed, and this is what I first tried, but that does not work, there
> > is some circular dependency breaking the build. If you feel
> > adventurous you can try that :-)
>
> Hmm, weird, worked for me :/

I am super confused, it did not work for me over weekend, and now it
is working. Even `make menuconfig` would not work. Anyways, I will put
it in the appropriate place.

>
> > > > We will need to teah KHO to work with deferred struct page init. I
> > > > suspect, we could init preserved struct pages and then skip over them
> > > > during deferred init.
> > >
> > > We could, but with that would mean we'll run this before SMP and it's not
> > > desirable. Also, init_deferred_page() for a random page requires
> >
> > We already run KHO init before smp_init:
> > start_kernel() -> mm_core_init() -> kho_memory_init() ->
> > kho_restore_folio() -> struct pages must be already initialized here!
> >
> > While deferred struct pages are initialized:
> > start_kernel() -> rest_init() -> kernel_init() ->
> > kernel_init_freeable() -> page_alloc_init_late() ->
> > deferred_init_memmap()
> >
> > If the number of preserved pages that is needed during early boot is
> > relatively small, that it should not be an issue to pre-initialize
> > struct pages for them before deferred struct pages are initialized. We
> > already pre-initialize some  "struct pages" that are needed during
> > early boot before the reset are initialized, see deferred_grow_zone()
>
> deferred_grow_zone() takes a chunk in the beginning of uninitialized range,
> with kho we are talking about some random pages. If we preinit them early,
> deferred_init_memmap() will overwrite them.

Yes, this is why I am saying that we would need to skip the KHO
initialized "struct pages" somehow during deferred initialization. If
we create an ordered by PFN list of early-initialized KHO struct
pages, skipping during deferred initialization could be done
efficiently.

> Anyway, I'm going to look into it, hopefully I'll have something Really
> Soon (tm).

CC:  Michal Clapinski, who was also planning to look into this problem.

Pasha


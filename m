Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2461C44512
	for <kexec@archiver.kernel.org>; Thu, 16 Jul 2026 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iqBuWxa0vx7vE0co4ZY41gbuMB1fSwmGyg1K2AK2XRU=; b=BO0CMXSBYdONEXp0BKuhjD2bPu
	IKMgJt4hk/hwWqFI0nDnP2xmLhfaXKIHsZj+VxDOfyhngmxKvjJPL/zrcAjpmy1qjqhCPAl8TcfsE
	o4wzXlgfT/h0TpriNB18alHBZPuiCEhGg6HwYgC3s4U0+5TcFwBU3Rdncvj9icxcZE2ydcBemDO1a
	GbdEFQGdK78w4Sn2QTnW7A8Je05W565RVcJNTwfMLvnZFfD51kmdnxiJ88wuZdgg7VsQ5e36ubXfn
	I0xsFJGZ4XkaohfqUtDefKhJxDJ2yDCs7Cpa2MK2qN1HzxOsgrRAR5E6r0lhFyIVAE1rkJ+LXwRoe
	NcIqhgQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNpT-000000001az-3JWO;
	Thu, 16 Jul 2026 15:16:51 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNpR-000000001aF-3NQl
	for kexec@lists.infradead.org;
	Thu, 16 Jul 2026 15:16:51 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso1004a12.1
        for <kexec@lists.infradead.org>; Thu, 16 Jul 2026 08:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784215008; cv=none;
        d=google.com; s=arc-20260327;
        b=kNUmMp7F9S6AiLGcCTnIX/xYGfK5GNgX3DIjHXacWHPJgoV7PQo1kD59rblpIJaYFF
         CnqshkyfxKOdE+gwrhbids1E3mHKipwjQU/4VE1UtXMRFYPedL7WZ4zHJcqetz1ErH9n
         ZXHi2NS9rhFyIIC6V0gG8pFcK3NaQMpRBhSY9bB/1PzWzvXMuYmHiT+LaBBQKwsfDAZ9
         blD1NSje4g9yk1Dvn06pLUNQbTeUZSHm+Tx/tjnrghBx53JUqMRDwJxROWhD3cQuu4f3
         mgt9Zx8qRlxcJ6hUNH7bjrHcMJf1QxlC0Sf2IhhvA+0karfHhmLyJvZurc7qvsp36gIy
         p0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iqBuWxa0vx7vE0co4ZY41gbuMB1fSwmGyg1K2AK2XRU=;
        fh=9CwBZ8iO0o2JSW/vqTpgVq7QhNX0qQK4yvRY+xW+8NY=;
        b=grDQeCllo0bTkRUOkguPBVgtjZoQvXaIzFY0I+aBskoLT8jmz9nleXsTV55i1iHLn/
         RAqrMmucOveBmIPi9IG+D8NP97jJlZbyuZ5pRp4vBUUVSD9h9AAzQIA0B49LfJOmlh5n
         tEJ3geSdNOq4LHAozrRZye6xiZWDoLOOi3QV+Uniz+2R6VmRMbJoPfYg8L+pVNlEib/G
         jOBRTXBh0rV521X8gv3xVe03OaT854oNQ1nj/59AF2SqrAb5Nx4kNSNV1GgQB3aUeDoX
         XezJERzqYBNzPf9rx+He9cV/iEmznLq7XtIY5+3390UoO1eCJwYDmU8AZZcD3ZMOQ9I4
         bvqg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784215008; x=1784819808; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iqBuWxa0vx7vE0co4ZY41gbuMB1fSwmGyg1K2AK2XRU=;
        b=v1EuwyXanwjP8KGdjuT1RlGXReyOV7VwBR4wmPwX4RShx0iqpgiORGP/QrFYAVF+dx
         qgltT5lJQwc3JVrPDhCJrGd52rEknLY+oFDOQnS43AbYWlwig89+D1VR9duI0UHO/+wY
         C9g2MQ15Vqp5xPLqEFX5G3vB6KvfT7t6VI8CsuRUT/pWq33fIWNha6QWHcM2loSbSNyb
         WzBUbAfOj7MR063hl2xQAFyjQmorbwY8Ya3PcjOB+hhFoqr6hOsotWUoCrD+TJwM/bRp
         xaR5eO105IeNQoEHGWi039lgYhpvlkH4yg2H0D1aXP1JMG+3TUZhq8+Vi6lFcMbKYe8u
         X+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784215008; x=1784819808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqBuWxa0vx7vE0co4ZY41gbuMB1fSwmGyg1K2AK2XRU=;
        b=SGvoymVfJaMZTBFAWH/gZwF4J92Sv14lRxMXspOEA9P5EjIAuOHRd1z4RcWE+afauY
         g0mzFpauB4GNF7ELyj/srx/0pvPolr8UESSav8PBmo4R/ChfHWXP3QZfoTfK62UB8pKf
         Jt4LQQlO8eyPsDaa5PQRzvnCsfVrkeqY6RuvsAr7tWLvZMGUxPFF5f5IB7hfcuKamDjN
         N+JKC3Eiv3aAGjhYIzi+hQckbM2ENJ1WLRQTJvQ/tmZOfiyOeEDdDBZnCa/GVVaUv+9l
         jyCU/tl5pwt0G7F47WPON9ARfOXBbWbIoJenSb9YDW73IxX1rH3sZKVT4XEOIxP49673
         ztLQ==
X-Forwarded-Encrypted: i=1; AHgh+RpE7FOlhtntyWNCQkLU04BFicmq7obiE0bFEwICHjBh8ba//OxQaA0wTxJOL+Mnqc7spvR3Vw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw2M+jPwDcX8GiICk6tA79KKc/WFRvVsW0nBsWMGdqtXhXUR3Ps
	LhtgKYM21iyJfKUGHam/cKRFaD4nGLcOQrHgum6Q9NKrSch3AeM2eWftJFxtypjJG9anI1DkEKg
	EVVqYj+LodAI7Kkth2xUWn5IvLkQ4+QicFC0D9yPH
X-Gm-Gg: AfdE7clSnTRpdmTtfiK3CNkyyu6HFPD0oxjBchU7mSpyndUSH09O4wB2rS/wI7IwYtD
	L+k4+T0hrb6ojH5ID1Cv+qzGjfCFOlvNB4RVKU688L5DcYRtmQYK2qqxqcPXheY06vybXnfEtBL
	Dz/23QUoISjpJdPBH1GGC0+gGRpKtLnUOsB4mk1LcMMt1SP+H2wdekRbmVIdE5JSHt1/NsPLfe3
	HQVzds6fADSDZAiZNjmrkOebiE9t1B5RuelbryRzOvpgTwoh+VQLSD4j13DRXc39uyxs6fm8AYm
	7hZL3dhYT7zscVmn
X-Received: by 2002:a05:6402:3d5:b0:69c:3005:12aa with SMTP id
 4fb4d7f45d1cf-69e2e3c01ebmr77184a12.6.1784215007276; Thu, 16 Jul 2026
 08:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260714205111.2497151-1-mclapinski@google.com>
 <178409777790.255896.16691338963510282908.b4-review@b4> <aljy_-Y7OT6s0kj0@google.com>
In-Reply-To: <aljy_-Y7OT6s0kj0@google.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Thu, 16 Jul 2026 17:16:36 +0200
X-Gm-Features: AUfX_mwHtEQCDzSKOWpRsxhX676TcVn98jGTGGvIkOzpKfZmwE7X4hoJWY_RhEU
Message-ID: <CAAi7L5c3fX9cN_s3fDB1x27SSWE=Mut8B2gkXNJ9nuHsuWTNZA@mail.gmail.com>
Subject: Re: [PATCH] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Evangelos Petrongonas <epetron@amazon.de>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_081649_877515_17721437 
X-CRM114-Status: GOOD (  25.39  )
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

On Thu, Jul 16, 2026 at 5:04=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 07-15 09:42, Mike Rapoport wrote:
> > Hi Michal,
> >
> > > I caught this crash:
> > > BUG: unable to handle page fault for address: ff19164fffff8328
> > > RIP: 0010:__free_one_page+0x1a1/0x6b0
> > > Call Trace:
> > >  <TASK>
> > >  [<ffffffff913208bf>] free_one_page+0xaf/0x240
> > >  [<ffffffff93973288>] deferred_free_pages+0xa8/0xd0
> > >  [<ffffffff93971b4f>] deferred_init_memmap_chunk+0x10f/0x1b0
> > >  [<ffffffff9396e265>] padata_mt_helper+0x65/0xa0
> > >  [<ffffffff90fac402>] process_scheduled_works+0x202/0x410
> > >  [<ffffffff90fae739>] worker_thread+0x1f9/0x2d0
> > >  [<ffffffff90fb62fd>] kthread+0x27d/0x2f0
> > >  [<ffffffff90fae540>] ? __pfx_worker_thread+0x10/0x10
> > >  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
> > >  [<ffffffff90efdc55>] ret_from_fork+0x145/0x280
> > >  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
> > >  [<ffffffff90e2e46a>] ret_from_fork_asm+0x1a/0x30
> > >  </TASK>
> > >
> > > deferred_init_memmap_chunk() works fine without KHO because free
> > > regions will never be neighbors. However, with KHO, free memory
> > > will be split into (free && scratch) and (free && !scratch).
> > > KHO scratch is aligned to CMA_MIN_ALIGNMENT_BYTES (which on my setup
> > > is equal to 1 << 9 pages) but buddy can look at the neighborhood of
> > > MAX_ORDER_NR_PAGES pages (which is equal to 1 << 10 pages).
> > > This sometimes crashes when one half of the neighborhood is being
> > > initialized but the other part is yet to be initialized.
> > >
> > > To fix this, let's just align KHO scratch to MAX_ORDER_NR_PAGES pages=
.
> > >
> > > Fixes: c6073743d0c7 ("kho: make preserved pages compatible with defer=
red struct page init")
> > > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > >
> > > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/k=
exec_handover.c
> > > index 4834a809985ab..50928aaa33710 100644
> > > --- a/kernel/liveupdate/kexec_handover.c
> > > +++ b/kernel/liveupdate/kexec_handover.c
> > > @@ -38,6 +38,16 @@
> > >  #include "../kexec_internal.h"
> > >  #include "kexec_handover_internal.h"
> > >
> > > +/*
> > > + * This is the minimal alignment required by deferred struct page in=
it.
> > > + * deferred_init_memmap_chunk frees memory to the buddy allocator, w=
hich looks
> > > + * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> > > + * If KHO scratch is not aligned to that value, buddy can access uni=
nitialized
> > > + * struct pages, which can cause a crash.
> > > + */
> > > +#define SCRATCH_ALIGNMENT_BYTES (1 << (PAGE_SHIFT + MAX_PAGE_ORDER))
> > > +static_assert(SCRATCH_ALIGNMENT_BYTES >=3D CMA_MIN_ALIGNMENT_BYTES);
> >
> > Maybe make it a variable and set it at runtime?
> > We won't need to worry about different confugurations that override
> > MAX_ORDER and potentail divergence of pageblock size from MAX_ORDER in
>
> Do those architectures reduce MAX_ORDER when they override it? I would
> hope we could set the alignment once and make it large enough to work
> everywhere, rather than depending on dynamic changes even during boot...

MAX_PAGE_ORDER can't be modified at runtime. It's either 10 or it's
CONFIG_ARCH_FORCE_MAX_ORDER.


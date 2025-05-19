Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566EFC3ABDD
	for <kexec@archiver.kernel.org>; Mon, 19 May 2025 12:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sxj5tV4ZjtLTjypVmyMI86S9Wm14CRi4YEthyQjDYJE=; b=QX1NtYVr1TGwOCVkz4NfYvBZes
	KPBSs9kaAEltJ6L1ojqG/0NUl1vdaqZF21+e51rbzxWhfy5Yqkc1T9JATB0nEKr4BmpT+ONCNEXQA
	dCmMWgOsvpEQih03tp6+xJSpHlkVo63qxFieJynBjk3V1DFJm/qaMAUGHNNRPK+tG+pHzSSA3bG8H
	QtWV6fKlgA8WuBe7hPyH5M8kauAPxtgKfY+1VlF62tq5Z5zLZtkLg20PJ1LlFiqsK2DNdBNMJCoA7
	NeCgQ53IlRBOrMwAD3lqJH1A3yAfc0F6wya1CZwZhuoKfuE0gVkMVC6vU3R9wYwmo31D4EyKfSHVJ
	XBdlHNHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGzOM-000000096ox-1OtO;
	Mon, 19 May 2025 12:14:50 +0000
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGzKQ-000000096PZ-0GjY
	for kexec@lists.infradead.org;
	Mon, 19 May 2025 12:10:47 +0000
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-47662449055so22746561cf.1
        for <kexec@lists.infradead.org>; Mon, 19 May 2025 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1747656644; x=1748261444; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxj5tV4ZjtLTjypVmyMI86S9Wm14CRi4YEthyQjDYJE=;
        b=q2TbtKXlNo1z7l1RTW4wHvBwBImUYVjB46o/2Yno/X0RJFgiQXCbAKSKDAfjFTmvxA
         ej2LQAeB8gebRa+aJeAsWZSI+9jcb3Xq6uvGT26RI+uJh0+BFy4G0vs1rKbq5PuMHHEb
         QLeKxtO12FLEoEqsaYKDjblnbn2Q5mgmW0fGWF5EmgrrB50BTtapxeQ7JdAqMUI43Ckq
         jrHUYJENZuXh380nEdDM708NC6uSvMgdTY/RLR3SuLrXhP1SMTX4iXE+ucN3sjwp0TPs
         oOduzfi1agy/jPcX/83KqiA0zNtJOneiG/erZaPXdH+SU7V2hXLeVv3twKjWTFGYLPas
         5QcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747656644; x=1748261444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxj5tV4ZjtLTjypVmyMI86S9Wm14CRi4YEthyQjDYJE=;
        b=tmGFdNCF2+fohA5AttyxFGVhufC7vzzI5DIUEhQinoB9iLjCn22rAbcUtF1MW4BnTA
         MseiZ9en9gu9exY6DUeil5PnezJiec00rjFHlgsph/yOXDmIH3jPCdMfvfN46nKRs0Fn
         qHKV1IHrVu50L+fE/Aggo1l3TnrP7Nr/yJLgQR4Y37KPmgwLUAjI7GSqC6okYFbLgs9I
         cU5xufpBXRx9lQTARBlszwinNYfSZMku4EYB2xvOuCjp526Vr7FoDflq5mG/WTZVqJqn
         L/YVfRTM3H+oyqwEmioJPrw5mM7AAT0S0PzHWTx47DUXmHcj1DEhxkN7RgdYQZtWdrrb
         gUfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB2wHD/8Is19j4d5N5ADg2UFMy4C7nCqI0GubSnP5hWpnUvfeYSUrG4F8zccmR1Eb5kmmwUA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzPNnstqO68U3l/RTyfwras8dP622++OkWWl7JkS1QX44Pw0pp6
	sBjbELvxIblQGdNMnoCIH2knfAO3iqBNO2bZUw1htKZ7WuFmotCRZu66w9vAapkqpqcgvsKK0Sb
	PLWip4Mjrg3vn1YRFxTlkintfW1Ae/nm8R3eVdZoUPw==
X-Gm-Gg: ASbGncv822IBeqM/ByM88QjLQeSqrwU9LgpeilZsZFfrN53ULH3xhZWDl6B07jQu1HQ
	IB2qWDsBLZYCXwmYwpvpERuYy6cudPRU2vMQkll2iRgFyqE72t9X+X4C8STdjJFS9u6noep2s9q
	yRsGI7Era1Z9CzwRDD0TApjPs+DtAU9A==
X-Google-Smtp-Source: AGHT+IHFVZaN/KoXQKmix7VBW6TAlcDBvQWjHHP9O9i0WPdPw4x+eCBlpXYOmcHm5M0gwFeXPJdS+ox//5pK2zRXTgs=
X-Received: by 2002:a05:622a:1b10:b0:48a:d21f:4ea with SMTP id
 d75a77b69052e-494ae377aadmr250581171cf.13.1747656644392; Mon, 19 May 2025
 05:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250518142315.241670-1-changyuanl@google.com>
 <20250518142315.241670-3-changyuanl@google.com> <aCoB6KkQr4xFBlEu@kernel.org>
In-Reply-To: <aCoB6KkQr4xFBlEu@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 19 May 2025 08:10:07 -0400
X-Gm-Features: AX0GCFvC73OzkVuPTBSZiZm6D6fkjt14tbJiCBHbeRPZlSwcNy9mM8PHVLc8h78
Message-ID: <CA+CK2bD7Zf_zvzi6zvQamUTJR19vKkWB8eux5vcwn-8ns=ZRKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] KHO: init new_physxa->phys_bits to fix lockdep
To: Mike Rapoport <rppt@kernel.org>
Cc: Changyuan Lyu <changyuanl@google.com>, akpm@linux-foundation.org, graf@amazon.com, 
	bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, chrisl@kernel.org, jasonmiu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_051046_366323_8224712A 
X-CRM114-Status: GOOD (  25.88  )
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

On Sun, May 18, 2025 at 11:51=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Sun, May 18, 2025 at 07:23:15AM -0700, Changyuan Lyu wrote:
> > From: Pasha Tatashin <pasha.tatashin@soleen.com>
> >
> > Lockdep shows the following warning:
> >
> > INFO: trying to register non-static key.
> > The code is fine but needs lockdep annotation, or maybe
> > you didn't initialize this object before use?
> > turning off the locking correctness validator.
> >
> > [<ffffffff810133a6>] dump_stack_lvl+0x66/0xa0
> > [<ffffffff8136012c>] assign_lock_key+0x10c/0x120
> > [<ffffffff81358bb4>] register_lock_class+0xf4/0x2f0
> > [<ffffffff813597ff>] __lock_acquire+0x7f/0x2c40
> > [<ffffffff81360cb0>] ? __pfx_hlock_conflict+0x10/0x10
> > [<ffffffff811707be>] ? native_flush_tlb_global+0x8e/0xa0
> > [<ffffffff8117096e>] ? __flush_tlb_all+0x4e/0xa0
> > [<ffffffff81172fc2>] ? __kernel_map_pages+0x112/0x140
> > [<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
> > [<ffffffff81359556>] lock_acquire+0xe6/0x280
> > [<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
> > [<ffffffff8100b9e0>] _raw_spin_lock+0x30/0x40
> > [<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
> > [<ffffffff813ec327>] xa_load_or_alloc+0x67/0xe0
> > [<ffffffff813eb4c0>] kho_preserve_folio+0x90/0x100
> > [<ffffffff813ebb7f>] __kho_finalize+0xcf/0x400
> > [<ffffffff813ebef4>] kho_finalize+0x34/0x70
> >
> > This is becase xa has its own lock, that is not initialized in
> > xa_load_or_alloc.
> >
> > Modifiy __kho_preserve_order(), to properly call
> > xa_init(&new_physxa->phys_bits);
> >
> > Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation=
")
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > ---
> >  kernel/kexec_handover.c | 29 +++++++++++++++++++++++++----
> >  1 file changed, 25 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> > index 69b953551677..f0ac6a9170f8 100644
> > --- a/kernel/kexec_handover.c
> > +++ b/kernel/kexec_handover.c
> > @@ -144,14 +144,35 @@ static int __kho_preserve_order(struct kho_mem_tr=
ack *track, unsigned long pfn,
> >                               unsigned int order)
> >  {
> >       struct kho_mem_phys_bits *bits;
> > -     struct kho_mem_phys *physxa;
> > +     struct kho_mem_phys *physxa, *new_physxa;
> >       const unsigned long pfn_high =3D pfn >> order;
> >
> >       might_sleep();
> >
> > -     physxa =3D xa_load_or_alloc(&track->orders, order, sizeof(*physxa=
));
> > -     if (IS_ERR(physxa))
> > -             return PTR_ERR(physxa);
> > +     physxa =3D xa_load(&track->orders, order);
> > +     if (!physxa) {
> > +             new_physxa =3D kzalloc(sizeof(*physxa), GFP_KERNEL);
> > +             if (!new_physxa)
> > +                     return -ENOMEM;
> > +
> > +             xa_init(&new_physxa->phys_bits);
> > +             physxa =3D xa_cmpxchg(&track->orders, order, NULL, new_ph=
ysxa,
> > +                                 GFP_KERNEL);
> > +             if (xa_is_err(physxa)) {
> > +                     int err_ret =3D xa_err(physxa);
> > +
> > +                     xa_destroy(&new_physxa->phys_bits);
> > +                     kfree(new_physxa);
> > +
> > +                     return err_ret;
> > +             }
> > +             if (physxa) {
> > +                     xa_destroy(&new_physxa->phys_bits);
> > +                     kfree(new_physxa);
> > +             } else {
> > +                     physxa =3D new_physxa;
> > +             }
> > +     }
>
> You are nearly duplicating xa_load_or_alloc() here.
> Is xa_destroy() is really needed here? In the end we destroying an empty
> xarray.
>
> Unless xa_destroy() is a must something like this would be simpler IMHO:

I wanted to do proper xa_destroy(), as the whole point of this patch
is to satisfy lockdep, and do a proper xa_init(). The patch fixes a
warning in linux-next, and I think should be taken as is. We can do a
separate clean-up once the series lands, where xa_load_or_alloc()
could either take another argument, or split into two functions.

Pasha


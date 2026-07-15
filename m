Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E008C4450E
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pERiy6dVlA901+DL6zvyyrnjEz4Li9eRjQ4QFKdKZJQ=; b=wbOOgXFTHONadvbDLDONgujNwM
	S9e/awBwg8QR//EXIm00XeMnc5p1vTI9NNG7vofKhaSPtttuVKkf4f17ywJyd9mW6Rou7bajksFKy
	TaWQIjT3pdAq+R094p3wTQLwfwRKWM303Wkt8w8WLuGvGsjJIFe0MkYb0bPN6y7vbo4nVDWtzhIm+
	WtvvVotFXD8kIlhMTOpou+En9x9s644w7+KDIHzzlXpyqbgEgZUuFtZQQ04gXx20pW4gmktlNWc/B
	BgcI48zRf1rpiFoO5scJhsnRZLP8F0d8ZUaC31Sz5ORKT6aduZuxmjzL4tdt1mXxeTWX5/4gdgphT
	V5JodmAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk2Zh-0000000FTfA-0hUz;
	Wed, 15 Jul 2026 16:35:09 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk2Zf-0000000FTeA-0AAn
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 16:35:08 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so12530a12.1
        for <kexec@lists.infradead.org>; Wed, 15 Jul 2026 09:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784133303; cv=none;
        d=google.com; s=arc-20260327;
        b=IEHB37QtHwFVYEaTTvRMPCPQTiLMVmJTTGQo/mZq/8VdAZeOVhi4kQJyw/P7F34oa5
         1R1xMM94IxHxVEQk6vIuTLvHs464VYnjwoRxUbTv1qvzXzM3fWFdjFHclEuxS6/Fhb0D
         GsfRfq+0eo7320wt7TnVjNjdZ6ZDAZjR3i8ZFB/SdhOEDUNDv8uC3UJ5AOvSsqMh12kr
         YkEadFJAo6UnCscW02e7uMXFU1NjzSmM7SwED7h81P4d821bKogOGqQNWeU/ZPftkCoA
         HKozHXtphsbP37eQu0XnzoOfm4k5vEpyYJM7IBKRHEjtyKtjiqCiaIXuApjR96T9UzDh
         CNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pERiy6dVlA901+DL6zvyyrnjEz4Li9eRjQ4QFKdKZJQ=;
        fh=NGhkHEnLL5jjPTg8o8RiPOtvICFf0zucuFi/nLUv6JI=;
        b=P0y6HCRkLQljjc6VjUokXEpw9vzry1he8eHvDTHZU29ICi+B4i7sHFVihEcRRiC9r8
         sy7+/ofJt8SdVFooEz+lqSHFbTrFj3qlxpSH/qy19T0oQ21ZOOrFbl2Pd5Ggr67sSpos
         utEd1MYmOtbBuxN61irBUX3XdoQRV3NA3nL9kNsdVgC9QpeBBic28VqtQu7+dmnMVH/M
         dNSeeGbPOTNI8UwKc4lgpeHikxJOm/oG0yj5wlI0SkuQSHXDtWM1dthZXHotXUvDk1zV
         3mokx04imFmkAp4nF8oW9JqyaF2orrFEkoGWDAM61bO1NlQytz7j3Acz7laKqp0vqmm0
         XsSg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784133303; x=1784738103; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pERiy6dVlA901+DL6zvyyrnjEz4Li9eRjQ4QFKdKZJQ=;
        b=EhNsQfFytcs+l/gGpskJPsDSKcaNgNq0dTANvTlzqeea4WvKFzMqP6XKb2d6f8zJBz
         L7TrDOQW0NLim9nHzOHYs9yR12OgOf/NJU7ZHD7HnqoU4dXee3t0DnxkDeXM924aRt7Y
         4nvGnIuLqHP9CVBzSlEOQz9KCivEddgQxzFjbV0p8ZcmH9sPRook/CXnQHO84j0MaIVY
         +CgTuI90jnklhl0JYjYemX0uvb6Z+loQx/sVZsVu+GchDL1johd69NblLUIHYp7Bqbd7
         jv+nol494p8huPzh6VdiXNpMdD9ggVmZcaq3YPAC542y6da+URwTqwZrdhJmbhvM6wpB
         +GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784133303; x=1784738103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pERiy6dVlA901+DL6zvyyrnjEz4Li9eRjQ4QFKdKZJQ=;
        b=eCn31/CM5pR6K5fzE39WaMV5l4BqCcuel3wODDtUhGhGLh76gyrQv8tfNEdJnnSAuk
         Vh9J+Et315TMIqMoXgcZLRoTEF5ZlcVchpIkFLN3CJNuoABbvATikIc79XiR76sOWCNl
         aaQrJLcvONEOC6zVWkRd9dA8dyXymPezz1vKpXKytWYzqqM25X8FNqDxWVQnGE20RJZ9
         ekOqkl8xnQPAOQCTCdafUWC7PvOuNMzGO789X+FUSVBDNP385gZuT25MRgs+uLgPtVVS
         StGusGHyNvDodivzDGHQMzjHUC/7kQiiqT2cgjdwSknDBSZb18hNUb/f8Nx6KNDbzlcW
         X90g==
X-Forwarded-Encrypted: i=1; AHgh+RroKP3euT2hSxUBmqD9ANabPnWxTzXF/GhmRfNjMw8YGrT463upULXio7dbpq/KYO5YLTYAPw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxljnXc6FvWYwKuhx7cN8129ooAJrarl9gxCa15ASPfPliUDS9L
	cicJCx+n3XSMQHffvRLIK1r2L+h6qU/XD+AKGbOQkFpaCwdOh3hdu/KUe7JtbAFH3OJFIjdFaN+
	UEZFcX5Y+l5EwVH0TbMsUjQcK4YsO+cAyTTYhccCM
X-Gm-Gg: AfdE7clLx26h+aBKPHfefu0MDQnUD+ngcaVsR0bKHXgibMeigHO5LJTJLyg7k/p62Nk
	Lz1l5tLyBhf+1ctnqMfOXxIBrU4TIiS2zi73FTVvrH7LlhN0sW7cSdnQ0OTXQx1Y6bempb9b2Ow
	yEZpJqJzkqLrSX/ys304lss/ujNNodYbqNbszew2ptjIe3d/tVMPWCOhX6HUpazSsR/UexKi6+B
	SZjpj8mQ8SRwYKzgmiOke3bsUBGtXOK1Wr5Pmz4ydEXUSBUrhYh8HxOj1GD+AiIVHinyhQ=
X-Received: by 2002:a05:6402:3255:20b0:697:9254:a66b with SMTP id
 4fb4d7f45d1cf-69ccf0a4e15mr209288a12.6.1784133302824; Wed, 15 Jul 2026
 09:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260714205111.2497151-1-mclapinski@google.com> <178409777790.255896.16691338963510282908.b4-review@b4>
In-Reply-To: <178409777790.255896.16691338963510282908.b4-review@b4>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Wed, 15 Jul 2026 18:34:51 +0200
X-Gm-Features: AUfX_mw4j5Tg0PUVoucFNnFxJRaEYRBEsBUaUuaX3fJCgHNZLpJrrA8egZ5It8g
Message-ID: <CAAi7L5e13dwTOJYhYu2q0XNxRHjaZz=EatOpK9_8+jacyBzNzQ@mail.gmail.com>
Subject: Re: [PATCH] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Evangelos Petrongonas <epetron@amazon.de>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_093507_114576_21DF06CE 
X-CRM114-Status: GOOD (  25.54  )
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

On Wed, Jul 15, 2026 at 8:43=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Hi Michal,
>
> > I caught this crash:
> > BUG: unable to handle page fault for address: ff19164fffff8328
> > RIP: 0010:__free_one_page+0x1a1/0x6b0
> > Call Trace:
> >  <TASK>
> >  [<ffffffff913208bf>] free_one_page+0xaf/0x240
> >  [<ffffffff93973288>] deferred_free_pages+0xa8/0xd0
> >  [<ffffffff93971b4f>] deferred_init_memmap_chunk+0x10f/0x1b0
> >  [<ffffffff9396e265>] padata_mt_helper+0x65/0xa0
> >  [<ffffffff90fac402>] process_scheduled_works+0x202/0x410
> >  [<ffffffff90fae739>] worker_thread+0x1f9/0x2d0
> >  [<ffffffff90fb62fd>] kthread+0x27d/0x2f0
> >  [<ffffffff90fae540>] ? __pfx_worker_thread+0x10/0x10
> >  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
> >  [<ffffffff90efdc55>] ret_from_fork+0x145/0x280
> >  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
> >  [<ffffffff90e2e46a>] ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> >
> > deferred_init_memmap_chunk() works fine without KHO because free
> > regions will never be neighbors. However, with KHO, free memory
> > will be split into (free && scratch) and (free && !scratch).
> > KHO scratch is aligned to CMA_MIN_ALIGNMENT_BYTES (which on my setup
> > is equal to 1 << 9 pages) but buddy can look at the neighborhood of
> > MAX_ORDER_NR_PAGES pages (which is equal to 1 << 10 pages).
> > This sometimes crashes when one half of the neighborhood is being
> > initialized but the other part is yet to be initialized.
> >
> > To fix this, let's just align KHO scratch to MAX_ORDER_NR_PAGES pages.
> >
> > Fixes: c6073743d0c7 ("kho: make preserved pages compatible with deferre=
d struct page init")
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index 4834a809985ab..50928aaa33710 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -38,6 +38,16 @@
> >  #include "../kexec_internal.h"
> >  #include "kexec_handover_internal.h"
> >
> > +/*
> > + * This is the minimal alignment required by deferred struct page init=
.
> > + * deferred_init_memmap_chunk frees memory to the buddy allocator, whi=
ch looks
> > + * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> > + * If KHO scratch is not aligned to that value, buddy can access unini=
tialized
> > + * struct pages, which can cause a crash.
> > + */
> > +#define SCRATCH_ALIGNMENT_BYTES (1 << (PAGE_SHIFT + MAX_PAGE_ORDER))
> > +static_assert(SCRATCH_ALIGNMENT_BYTES >=3D CMA_MIN_ALIGNMENT_BYTES);
>
> Maybe make it a variable and set it at runtime?
> We won't need to worry about different confugurations that override
> MAX_ORDER and potentail divergence of pageblock size from MAX_ORDER in
> the future.

Sorry, I don't track. What would I set it to at runtime?
MAX_PAGE_ORDER must be >=3D PAGE_BLOCK_MAX_ORDER and I don't understand
what's the problem if some configurations override MAX_PAGE_ORDER.
They can't override it to be smaller than PAGE_BLOCK_MAX_ORDER.

Are you saying that in the future PAGE_BLOCK_MAX_ORDER could be bigger
than MAX_PAGE_ORDER?


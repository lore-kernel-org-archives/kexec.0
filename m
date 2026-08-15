Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6583C5AD5A
	for <kexec@archiver.kernel.org>; Sat, 15 Aug 2026 03:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=luVYJYWQOB0XY/tTpneISfB+TB1fZM2KMGuLqcIZEDI=; b=ee7on9YV6Et6shOth7QBg9f8eu
	OJ4QX/f0MzC6C+DH0ISPSYZos7J+aD120V/5kiozVKDPKJmF86cyrWlVLdE+H71iciB+weFocJbpF
	QLbjel7Di5izVeEO20BjJ1Mkyw2cu4UEHPPW9Sl+BKzoLilgDeFofbWyhyBhmUWHm0Al2c/WXrpgh
	nFyVa+F4OD1TaviBI5KNrTHtbkH+1j4bwo9NW/zlYWDufI5awxaIifwHMlcsPzL1cRcOWm1OsE6ht
	FU+BPs26iWodVCJHjmKHPaTrdYhtP9ZImX4/RhXUn2smsz5WuY66aFnS3fpDP+M4T26sXTMRQj62K
	ZnwAATqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv5Dw-00000003SJY-0n4k;
	Sat, 15 Aug 2026 03:38:20 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv5Dt-00000003SJA-4BIz
	for kexec@lists.infradead.org;
	Sat, 15 Aug 2026 03:38:19 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-51c15a5b265so408671cf.0
        for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 20:38:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786765095; cv=none;
        d=google.com; s=arc-20260327;
        b=ltJ0CxmLDNBmSuIop0GtSZU8AFi79EWogeEXSAUFSYKzNEFH9qpbjltMVg28mBqmFn
         GXYTG1hcIpUQhnBgyQgSmymO9fvOgfWRAdwXcbfobD8THQaK90Fh6YD3dbgEGWM+NAYJ
         yaoiBY5hvh7NpMsF0OuXvMToUubFsvgs4CzRI8JUjFNDH0UVqz50cE8OQZ/ZM7fXC+lI
         lfKiTUeCRWEe6PcddrXer/Xrg2vzbe9v/sA1Oplkb81kbm2KxJmHb6EkjPFnw7mxP/Kc
         4lWJPUWq4enOJm8YpK1Wx7eibZq3qpWDcNRYSE018DQcJTcOX6auM5zWAkQRagZy8IXX
         trkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=luVYJYWQOB0XY/tTpneISfB+TB1fZM2KMGuLqcIZEDI=;
        fh=NSpVdpWZ8W53TMZxGAwql6/tF7XUUNmH5ZU8vxp5syQ=;
        b=E0PHfEN4SZOz0Dei1PlOq3+3Ac1au9k0wpxN8S5CXEx52/j6Qd4NDapmzE0oeITXi/
         TfftCd+Ox8bzqtGdZEOaCYc5G6HMU0GsK0jAMiu5/rxE2Hb2lz55B3AxKkUK/2DWyRSU
         DBT4ApuMii/GdeYWCMmXs/vdKWsedQMqP2BFo9WmlDdMvMFgKlI2qtnmx6BL/DQWtFJR
         wsKLhWJX4gs5NoJGv0mi4k4ws6yRlDQMBI8eRFq9Phc+0nG9gmarG4oAeFQ1ZFqfQOGp
         ga2g8h5LBaOWXpw3/gCJYpsfgJ6lB8ByiFZm62Yzx8B1Or/l5lrBCQ5yWraEqiX0kha4
         UJwQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786765095; x=1787369895; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=luVYJYWQOB0XY/tTpneISfB+TB1fZM2KMGuLqcIZEDI=;
        b=lBK1PRQtB2ly1EpQgtVyCbD/ogZrgkDAcMnH/SHLsmVVtdAczTOoiOQ56mch2ro8k2
         xRQ4HZH3eebYCMnmfBvkSHpcUAARZkHxkJF/BNWsjaqcaXYHAp75M7HwRe97pt3wMtw7
         ILncc2MredWgH4x4D5Ex1x3l6+cgQLA9qX1W4jlrjmFfht7gMWBRVs1tEUo9et5LcXzP
         LEQ58Q02K+u9Id22ehM0NqQa1v6G8d/+rw6tFKhkUHrIhBPrPGAZQXRPAxvWdDkRiBWe
         eBo0UcD/0xW4SuWeHqtMEKWYKXRHiabqWOrAGUQKu88mCpE9RKVqOdOMqkAHoA0G/ev+
         dyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786765095; x=1787369895;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=luVYJYWQOB0XY/tTpneISfB+TB1fZM2KMGuLqcIZEDI=;
        b=bqUCGH4JW38JInglgDDxQSIHAFsRZ08x0Qe8RYaQJ4Q6kfRG52lj7ZfkRe7wof9fiv
         4+d0lxdtlyatok4doApTF4YDeKoOBa4i32pdG387/xTnQX2TGPVDRzRJA32jqeJBNHjp
         qNxgNnYZOguq3+AiuMvLsNsEc7kq5usT+035VkFJVHeblz82j71ztgfgheUVjABBKpjC
         FPhZiM50ZLTqd3CjHi6wcZzCEfcztKj6HUauB3PwD92RApNTL2MVzfLTkJhxtJm8GZeG
         xnGxmpY9E6ec1IB+ehTlFRuxU2Og7OeeiFMYYp63YgBAVcfC1gVcan5+u0c4e/N2S+E9
         onkQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAVwZ3ljJrd3OqnefM0N4NtZUl43FRuPU5Lq5zyiFVJf184dQIQfCG3W4Vn8xQp+BfSI2ZRg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3fuWdG8FDnRN1BOy8J9N7C++Hf8nkupAta+aYk5vQ0knSEP9z
	buJYXkHykLY03a/Opez2wfu/R5E4C0NeybcdmoPMqG+CyhdtXSCeTnCMO93kFoCQPZ75hHm38Gw
	r/q5RVCrdvhbkI28EMPck3kJtNi7feUqSrXLksuEI
X-Gm-Gg: AR+sD13TzfINUscBf8M0F96gCjlOSLwRsR+yONskOwyuzM8DiFynbiElxHhI6NuOb/i
	/SngwKGEHtgjEm/sVMubnvvjyRIAuDPdkASfnqPmGFuN4IySkApAefZX2renlWMDJ0PlbEHgj6l
	Dl/Qv2ZijK+KZ7dGJX5EE0PXgVdytqBX/xyhyLTswKLqS+iieTvjljje29pNRO5kMZsaaZPcZP6
	Q/3f8wOZEsc1OxBjY34Dpse4fFhmY0qtr05moENQbMCgx0oCgKDXwqawfE7PiG01UTV/oPK7tfR
	a0WCaTat1XEaUWsDgly6rw1J+lD2vhNRm9GzEBUij7Q=
X-Received: by 2002:a05:622a:578e:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-52d86192a1emr30633361cf.1.1786765094873; Fri, 14 Aug 2026
 20:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260803113944.3694290-1-praan@google.com> <20260803113944.3694290-2-praan@google.com>
 <2vxzqzk338y2.fsf@kernel.org> <an2skkjrNXBTFagK@kernel.org>
In-Reply-To: <an2skkjrNXBTFagK@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 14 Aug 2026 20:38:03 -0700
X-Gm-Features: AcwNN1XrGQyskIqu-lIjMZBTlBvDbp-7AMsoC0-TI6TqDyvNpYGgAf_q-RSalo8
Message-ID: <CAJuCfpF-A1DeRmg1i7rNyTaFT3_0H+Rqsy6yQRUct4Z79xGtHw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kho: Introduce a helper to init high order pages
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_203818_082601_66FECEEE 
X-CRM114-Status: GOOD (  29.34  )
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

On Thu, Aug 13, 2026 at 4:38=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> (added Suren)

Thanks!

>
> On Wed, Aug 12, 2026 at 12:54:45PM +0200, Pratyush Yadav wrote:
> > On Mon, Aug 03 2026, Pranjal Shrivastava wrote:
> >
> > > The current KHO restoration logic assumes all multi-page blocks are
> > > split into independent 4KB pages. Break out a helper to prepare for
> > > supporting high-order non-compound pages.
> > >
> > > Extract kho_init_high_order_page() to handle the refcount pattern
> > > where only the head page is refcounted. Use the helper for folio
> > > restoration that requires a similar refcount logic.
> > >
> > > Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > ---
> > >  kernel/liveupdate/kexec_handover.c | 29 +++++++++++++++++++---------=
-
> > >  1 file changed, 19 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/k=
exec_handover.c
> > > index 4834a809985a..e836efd98795 100644
> > > --- a/kernel/liveupdate/kexec_handover.c
> > > +++ b/kernel/liveupdate/kexec_handover.c
> > > @@ -357,6 +357,24 @@ int kho_radix_walk_tree(struct kho_radix_tree *t=
ree,
> > >  }
> > >  EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
> > >
> > > +/* For physically contiguous pages. */
> > > +static void kho_init_high_order_page(struct page *page, unsigned int=
 order)
> > > +{
> > > +   unsigned long nr_pages =3D (1UL << order);
> > > +
> > > +   /* Head page gets refcount of 1. */
> > > +   set_page_count(page, 1);
> > > +   /* Clear head page's codetag to avoid accounting mismatch. */
> > > +   clear_page_tag_ref(page);
> > > +
> > > +   /* For high-order blocks, tail pages get a page count of zero. */
> > > +   for (unsigned long i =3D 1; i < nr_pages; i++) {
> > > +           set_page_count(page + i, 0);
> > > +           /* Clear each page's codetag to avoid accounting mismatch=
. */
> > > +           clear_page_tag_ref(page + i);
> > > +   }
> >
> > That's sneaky...
> >
> > The patch _almost_ looks like pure code movement, but then adds this
> > little change. I'm not saying this is intentionally sneaky or anything
> > of the sort, but these kind of things are easy to miss during code
> > movement and should get a patch of their own or at least be called out
> > in the commit message.
> >
> > I don't know how page tags work, but IIRC when the change was originall=
y
> > added by Ran, he said that we don't need to clear the tag for tail
> > pages. That held true for folios, does it not hold true for non-compoun=
d
> > high-order pages?

Yeah, only the head page is tagged with number of pages of (1 <<
order), so the rest of the pages don't have tags to be cleared.

> >
> > > +}
> > > +
> > >  /* For physically contiguous 0-order pages. */
> > >  static void kho_init_pages(struct page *page, unsigned long nr_pages=
)
> > >  {
> > > @@ -369,16 +387,7 @@ static void kho_init_pages(struct page *page, un=
signed long nr_pages)
> > >
> > >  static void kho_init_folio(struct page *page, unsigned int order)
> > >  {
> > > -   unsigned long nr_pages =3D (1 << order);
> > > -
> > > -   /* Head page gets refcount of 1. */
> > > -   set_page_count(page, 1);
> > > -   /* Clear head page's codetag to avoid accounting mismatch. */
> > > -   clear_page_tag_ref(page);
> > > -
> > > -   /* For higher order folios, tail pages get a page count of zero. =
*/
> > > -   for (unsigned long i =3D 1; i < nr_pages; i++)
> > > -           set_page_count(page + i, 0);
> > > +   kho_init_high_order_page(page, order);
> > >
> > >     if (order > 0)
> > >             prep_compound_page(page, order);
> >
> > --
> > Regards,
> > Pratyush Yadav
>
> --
> Sincerely yours,
> Mike.


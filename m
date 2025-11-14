Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F8CCE8D66
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+zbn9p1VuyYMk2i0qgvr7OVfrXyGoZz9FTwk/+35lXQ=; b=CMMJWngzt+aCNcpjqwvwFAf2Iq
	Gyq2WMaDg5iOqjXZds1yprwu8MakhccLg8qzP+s2s7YIE8+WacgUWWTqBYTskfvtSwfIrhpMmjKaF
	Qatf+LCHAMakr9LO8fqbSx2IbAs6A2itNE3HTQzD6F/BDtHRbqx5z/QR3+4cjLYRF2YI68ugwGbQo
	4OaWQxoKDwNBIvJPjPNzdmpB3R/KS7WrJJpcC6hJwcwaPdwXUtYj7AsA0WqRUJjMDP4m1WX+GJ4sy
	DXx/dSqzyhl5YhRPe5XCraH2f1UUkUQcHHFqpzldsM3JHUwqv9M2lY6O+UCiu3f7Ay7vi+BKJehzw
	wFb0QJrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxu2-0000000CsOP-1EWD;
	Fri, 14 Nov 2025 17:48:06 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxtx-0000000CsLg-3qov
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 17:48:04 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so3147875a12.3
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 09:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763142480; x=1763747280; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zbn9p1VuyYMk2i0qgvr7OVfrXyGoZz9FTwk/+35lXQ=;
        b=CxpFwnl9Vg+viEYnquHo1XHnK94L5oYSJ75a3gSXgkkBTMxMEAiqYsmfVPLh/EKSP1
         78ZI5iDi2DrxM+i8gICwsuVX+DpNenO3Sh9fxs9eJf8B2RWMCeRMpZXQjib95WlzbH8+
         7RuL1nuDTJFC8rXbbM2RJRkVC8gksOg23avKOGwRzfjXcnon1jGtyEuW9k2sczVSVbmv
         4D978wRVPObLmKEdq/cQZRhVIjkuQtZREACpW17dL0/s5gnx/aWq7oYTmHOiCYsavPme
         11MKFez4rj+s42FzUTydLWKTMPMxi+IOaWZ9J83CcMzNNKepQW1Iy01IUPQ01gKJPUl2
         IWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142480; x=1763747280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zbn9p1VuyYMk2i0qgvr7OVfrXyGoZz9FTwk/+35lXQ=;
        b=mmqextWC4v3KKDqmDHqtwtLEYjGkqUbmae4G7BrbtaQhW8nF44rszxmioi8SigSn6o
         ePbFcAywaI5+sGehy4UtEyDvuhU4MosseAD+YcZS9W0cjV+VK+InPZEYPjqZL63ll1CN
         nIIV2tN/L7wyWMhY8tDaEhB5X/W15gT7WGk3RXAobC62u742GT/ZQopvFJySf0NUM1c9
         qTOEHcc1j2SHhZdFMRqqDYQIjH53WlF3SmZx2hKkzoyGERZ+w8+cm1AjN0EWOKjX+Wp4
         tHMDVCUgoPKxjcBz8Tcp6KP/s6mTn/2L8BsUh/N69afBFoeZaU296DHw4q2djVsAuOzs
         hqUA==
X-Forwarded-Encrypted: i=1; AJvYcCUjle3FzdblJ1FSS+CTvF/fhIYzZ3Dvs5CmOWi1SYOJs9lrzssel//EoksSCr+2YT3Wl54org==@lists.infradead.org
X-Gm-Message-State: AOJu0YwjwbPj8oL+4xVMP9TnylbgOIXs/ic6xMJjJFGwaj+0QffPNPDK
	qqFUSlZ7vkoM2gLzTZ0k8FTVV/AAr40rFXIxiYCBEaFX7Ob8czI8j22V5+MwBVEErEmvcwBo/2j
	LZluqjpuxkACbZvBxk0iwBOUf3KFwxcb4vXIQasMcUA==
X-Gm-Gg: ASbGncsLX1CofMQpfT6lji0piN7v+ILlPdbo/Q1bH4UweFF8Obg0HXDr8o4Jeg7YL53
	e9FOKK93tfBGYo0J+raAFyiXthpwQcYRGr4xFLNw1zyHKlRe3qCnrE9BnB5DE7v0iVO18S+nWfr
	QkiY9eWHBYWfb9ob+KwRkGz2V5YDyipxbmQT5Gd+uUFtY+9iRO45EReDCa4GP3Zx2i7JCr8HnWB
	rf1JRsSY9URpQzJqbMLVfBx2sorzDaFIo+b6oM91QsmsUjtJRNe8HhGHfWzpkZQB0FJhfRM5j27
	hPI=
X-Google-Smtp-Source: AGHT+IFQhVRqfKMxnTXFqt53dbh9lEJU1FDUr5KWPHxGUp6CjT22Lq5xHtZYP0OnXMk43mo1GItUtGSGw951XYijv2o=
X-Received: by 2002:a05:6402:2813:b0:640:9eb3:3686 with SMTP id
 4fb4d7f45d1cf-64350e8e398mr3485744a12.19.1763142480101; Fri, 14 Nov 2025
 09:48:00 -0800 (PST)
MIME-Version: 1.0
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
 <20251114155358.2884014-12-pasha.tatashin@soleen.com> <mafs0zf8o5xjk.fsf@kernel.org>
In-Reply-To: <mafs0zf8o5xjk.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 12:47:24 -0500
X-Gm-Features: AWmQ_bmCljt8tZlfSqASZeT1KUJ_yGPGwIPhaLXLETZu6fzjOFak8efk0-r0QcU
Message-ID: <CA+CK2bC99-VwzuyB-0D=z9H_zF6gnH-EX1USf-Ox-fwGd1s5dg@mail.gmail.com>
Subject: Re: [PATCH v1 11/13] kho: Allow memory preservation state updates
 after finalization
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org, 
	jasonmiu@google.com, arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca, 
	ebiggers@google.com, graf@amazon.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_094801_977763_BACFBCF3 
X-CRM114-Status: GOOD (  20.31  )
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

On Fri, Nov 14, 2025 at 12:33=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Fri, Nov 14 2025, Pasha Tatashin wrote:
>
> > Currently, kho_preserve_* and kho_unpreserve_* return -EBUSY if
> > KHO is finalized. This enforces a rigid "freeze" on the KHO memory
> > state.
> >
> > With the introduction of re-entrant finalization, this restriction is
> > no longer necessary. Users should be allowed to modify the preservation
> > set (e.g., adding new pages or freeing old ones) even after an initial
> > finalization.
> >
> > The intended workflow for updates is now:
> > 1. Modify state (preserve/unpreserve).
> > 2. Call kho_finalize() again to refresh the serialized metadata.
> >
> > Remove the kho_out.finalized checks to enable this dynamic behavior.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 13 -------------
> >  1 file changed, 13 deletions(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index 27ef20565a5f..87e9b488237d 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -183,10 +183,6 @@ static int __kho_preserve_order(struct kho_mem_tra=
ck *track, unsigned long pfn,
> >       const unsigned long pfn_high =3D pfn >> order;
> >
> >       might_sleep();
> > -
> > -     if (kho_out.finalized)
> > -             return -EBUSY;
> > -
> >       physxa =3D xa_load(&track->orders, order);
> >       if (!physxa) {
> >               int err;
> > @@ -815,9 +811,6 @@ int kho_unpreserve_folio(struct folio *folio)
>
> This can be void now. This would make consumers a bit simpler, since
> right now, the memfd preservation logic does a WARN_ON() if this
> function fails. That can be dropped now that the function can never
> fail.
>
> Same for kho_unpreserve_pages() and kho_unpreserve_vmalloc().

Oh, this is a very good suggestion, really disliked those
kho_unpreserve_* errors.

>
> >       const unsigned int order =3D folio_order(folio);
> >       struct kho_mem_track *track =3D &kho_out.track;
> >
> > -     if (kho_out.finalized)
> > -             return -EBUSY;
> > -
> >       __kho_unpreserve_order(track, pfn, order);
> >       return 0;
> >  }
> > @@ -885,9 +878,6 @@ int kho_unpreserve_pages(struct page *page, unsigne=
d int nr_pages)
> >       const unsigned long start_pfn =3D page_to_pfn(page);
> >       const unsigned long end_pfn =3D start_pfn + nr_pages;
> >
> > -     if (kho_out.finalized)
> > -             return -EBUSY;
> > -
> >       __kho_unpreserve(track, start_pfn, end_pfn);
> >
> >       return 0;
> > @@ -1066,9 +1056,6 @@ EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
> >   */
> >  int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
> >  {
> > -     if (kho_out.finalized)
> > -             return -EBUSY;
> > -
> >       kho_vmalloc_free_chunks(preservation);
> >
> >       return 0;
>
> --
> Regards,
> Pratyush Yadav


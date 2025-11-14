Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EBCCE8D69
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 17:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5gEcuTmU00mCZqfk4m/VlByDhVR9d3CRF5yUAWb2ups=; b=D9gEBmubPa46m5f7Ny1f3Cq+0f
	srL4m1aZOmwR4sV5otI9V74SpfFqO8NQ9fOJIfKyHU5xur9/txFIk5PuFyzG77ATQAFIQN5Lk2AVG
	rvwWW9q9VcX2JeHC02CSB6LgpKW0Jj94lZ9tGDE0fVWYqaUMF9pq/3h3wcspg9c9nvKjiIkQQy4IW
	8hU5npCLNrgp9mDlHcxV6R1mkmYVM8hyu55t1OOvxZYfrGZ6Wyo+0UXdfGWQCmXMVAyekE8O8lvwK
	jF8cJWP+IhvwPmsPwYXtYUfNk4xWZzSllatDBbyJyU8YrZOfeeUw/Sk8OtSGEuQj8XpWMl3ua5IlN
	4EwvVtCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJy1L-0000000CuZd-3hTR;
	Fri, 14 Nov 2025 17:55:39 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJy1J-0000000CuYp-2nMo
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 17:55:38 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so4084077a12.3
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 09:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763142936; x=1763747736; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gEcuTmU00mCZqfk4m/VlByDhVR9d3CRF5yUAWb2ups=;
        b=R9aNKpx0PUftWfG9h4S3tlJP8zkj44jlniR5a0XHa0NuOE8KiUtFMO10YS4+pJ2MCv
         EHwbmDJ9xNyX06ZSwvtRTfZL6w2I5RdpMYgBJ5UKuDpFkHI3/Kw6N2NJS6FP/+Y88wQo
         8xpvw6Xk7oAjEcUq0QEKSTjezOZ4jBKCzbXmyMTM4I4St3rQ7QfW2t+O0/tk/Xn1dG0w
         M+R/VhEcXJIUD0C//VTJC6c145KF27LNG/kLB6cIn4B8kyUAe3N9FUjXlygkYYpf8aJX
         nmH/bfORn7I7WEE0knzhAx0cPloz7sdBfRNn1CD0K3BRwdwY7CL696NYEmo+/Coe7OH+
         W7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142936; x=1763747736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5gEcuTmU00mCZqfk4m/VlByDhVR9d3CRF5yUAWb2ups=;
        b=RJDClqe1aRFJBm6zZXwcozZM5o3NW/k0TfUgvewY8JWyBuTggTMdDpsdx90FkZtUMR
         4KAiHC3QbnEbOCyxwGl6Km6Z6Te4/zUFQdiZeBv2dyhqVxIBP7BFWWms6+/W9V0HDmKa
         MDH5r1WqvQQb6cqD2kqvZHfh+BaUDhlivGXyR4Brnd/8tDiZVsshIAoOOiIueMcH3G+S
         zGdElYRWceyEKAmJ3yl17wnF8kW1Xj7ufVXEisKTji7STeWGSJPADdqRRO/IabxuQhvS
         uzQiTUZbX7HjmNHqOrntUHh/TQX25RHoRQJLF3kIrhGEjoP0duF3UM6nmr13t5XGy1Ro
         1trw==
X-Forwarded-Encrypted: i=1; AJvYcCUXQN2+eGD9B7XC0EX4slJCKp1lfxqhx4CqJz1cGUHudNO7C4hnLr0MwmPoPjaiA0QaSpIIBQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+/B5XMvTIeop2XGXzwNGank8G94T7YmHSHmzbrgvv7z1PAEvi
	0gfx9YG7EuENramTS0SUxsDAvNFg9b6ujT+DpO8oQWb4As/qBeeAFeQFYCcol/FPamO0iT1h6CL
	KRiLHKqvDD/QozRPdocpsM47jNJHIAwL3Ot7T11oP1A==
X-Gm-Gg: ASbGnctevfQThOhYJzkitaUgcDMItgYD3uJYAT7vh8ngtnJH7woktjWwbJbtf9NXFsz
	xKSxHhqMsoNPvAQES7K6jmbpjFxhlmE68S7PwNVTNQMR8X9e71ZJXlpGOTz+m4sZt2e0Hu8abCS
	JRsZmhBtBptU8SzkdK5q2lb2FFHTCPfN1fka8vLp9EESOd31NmLDBJn0om8Bc3uB5/69DXJvf6y
	UptvKspabbgbHrNchni5zYA2VtxIozGz6A85UT7sxF6ut3FPFRbAJsWDyRJVJxdamsE
X-Google-Smtp-Source: AGHT+IE/pUAFReDEhKsxRDV2cL6tpIxJ1mhw5f1DZB2MJBkBG0VZktDDpA84kaoQHR8TX4r0XzDH9lhrcuh4WEcb+1k=
X-Received: by 2002:a05:6402:2710:b0:640:6653:65c1 with SMTP id
 4fb4d7f45d1cf-64350e03876mr3623108a12.5.1763142935814; Fri, 14 Nov 2025
 09:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
 <20251114155358.2884014-14-pasha.tatashin@soleen.com> <mafs0qzu05wz1.fsf@kernel.org>
In-Reply-To: <mafs0qzu05wz1.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 12:54:59 -0500
X-Gm-Features: AWmQ_bnFnEkRgJfJSBtZx9VdxbTw3Y6MhHBaDkb1rPplthz1zT5z-mlity4cV_U
Message-ID: <CA+CK2bA9OKvJH+kwd8nWaOUayAzPOO1U74jW8x22t3GmA-wH7g@mail.gmail.com>
Subject: Re: [PATCH v1 13/13] kho: Introduce high-level memory allocation API
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org, 
	jasonmiu@google.com, arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca, 
	ebiggers@google.com, graf@amazon.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_095537_758228_8AE279D5 
X-CRM114-Status: GOOD (  40.22  )
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

On Fri, Nov 14, 2025 at 12:45=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Fri, Nov 14 2025, Pasha Tatashin wrote:
>
> > Currently, clients of KHO must manually allocate memory (e.g., via
> > alloc_pages), calculate the page order, and explicitly call
> > kho_preserve_folio(). Similarly, cleanup requires separate calls to
> > unpreserve and free the memory.
> >
> > Introduce a high-level API to streamline this common pattern:
> >
> > - kho_alloc_preserve(size): Allocates physically contiguous, zeroed
> >   memory and immediately marks it for preservation.
> > - kho_free_unpreserve(ptr, size): Unpreserves and frees the memory
> >   in the current kernel.
> > - kho_free_restore(ptr, size): Restores the struct page state of
> >   preserved memory in the new kernel and immediately frees it to the
> >   page allocator.
>
> Nit: kho_unpreserve_free() and kho_restore_free() make more sense to me
> since that is the order of operations. Having them the other way round
> is kind of confusing.

Sure will rename.

>
> Also, why do the free functions need size? They can get the order from
> folio_order(). This would save users of the API from having to store the
> size somewhere and make things simpler.

Yes, size is not needed, I will remove it.

Thanks,
Pasha

>
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/kexec_handover.h     |  22 +++++--
> >  kernel/liveupdate/kexec_handover.c | 101 +++++++++++++++++++++++++++++
> >  2 files changed, 116 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_hando=
ver.h
> > index 80ece4232617..76c496e01877 100644
> > --- a/include/linux/kexec_handover.h
> > +++ b/include/linux/kexec_handover.h
> > @@ -2,8 +2,9 @@
> >  #ifndef LINUX_KEXEC_HANDOVER_H
> >  #define LINUX_KEXEC_HANDOVER_H
> >
> > -#include <linux/types.h>
> > +#include <linux/err.h>
> >  #include <linux/errno.h>
> > +#include <linux/types.h>
> >
> >  struct kho_scratch {
> >       phys_addr_t addr;
> > @@ -48,6 +49,9 @@ int kho_preserve_pages(struct page *page, unsigned in=
t nr_pages);
> >  int kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
> >  int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
> >  int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
> > +void *kho_alloc_preserve(size_t size);
> > +void kho_free_unpreserve(void *mem, size_t size);
> > +void kho_free_restore(void *mem, size_t size);
> >  struct folio *kho_restore_folio(phys_addr_t phys);
> >  struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages=
);
> >  void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
> > @@ -101,6 +105,14 @@ static inline int kho_unpreserve_vmalloc(struct kh=
o_vmalloc *preservation)
> >       return -EOPNOTSUPP;
> >  }
> >
> > +void *kho_alloc_preserve(size_t size)
> > +{
> > +     return ERR_PTR(-EOPNOTSUPP);
> > +}
> > +
> > +void kho_free_unpreserve(void *mem, size_t size) { }
> > +void kho_free_restore(void *mem, size_t size) { }
> > +
> >  static inline struct folio *kho_restore_folio(phys_addr_t phys)
> >  {
> >       return NULL;
> > @@ -122,18 +134,14 @@ static inline int kho_add_subtree(const char *nam=
e, void *fdt)
> >       return -EOPNOTSUPP;
> >  }
> >
> > -static inline void kho_remove_subtree(void *fdt)
> > -{
> > -}
> > +static inline void kho_remove_subtree(void *fdt) { }
> >
> >  static inline int kho_retrieve_subtree(const char *name, phys_addr_t *=
phys)
> >  {
> >       return -EOPNOTSUPP;
> >  }
> >
> > -static inline void kho_memory_init(void)
> > -{
> > -}
> > +static inline void kho_memory_init(void) { }
> >
> >  static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
> >                               phys_addr_t scratch_phys, u64 scratch_len=
)
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index a905bccf5f65..9f05849fd68e 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
> >   * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kerne=
l.org>
> >   * Copyright (C) 2025 Google LLC, Changyuan Lyu <changyuanl@google.com=
>
> > + * Copyright (C) 2025 Pasha Tatashin <pasha.tatashin@soleen.com>
> >   */
> >
> >  #define pr_fmt(fmt) "KHO: " fmt
> > @@ -1151,6 +1152,106 @@ void *kho_restore_vmalloc(const struct kho_vmal=
loc *preservation)
> >  }
> >  EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
> >
> > +/**
> > + * kho_alloc_preserve - Allocate, zero, and preserve memory.
> > + * @size: The number of bytes to allocate.
> > + *
> > + * Allocates a physically contiguous block of zeroed pages that is lar=
ge
> > + * enough to hold @size bytes. The allocated memory is then registered=
 with
> > + * KHO for preservation across a kexec.
> > + *
> > + * Note: The actual allocated size will be rounded up to the nearest
> > + * power-of-two page boundary.
> > + *
> > + * @return A virtual pointer to the allocated and preserved memory on =
success,
> > + * or an ERR_PTR() encoded error on failure.
> > + */
> > +void *kho_alloc_preserve(size_t size)
> > +{
> > +     struct folio *folio;
> > +     int order, ret;
> > +
> > +     if (!size)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     order =3D get_order(size);
> > +     if (order > MAX_PAGE_ORDER)
> > +             return ERR_PTR(-E2BIG);
> > +
> > +     folio =3D folio_alloc(GFP_KERNEL | __GFP_ZERO, order);
> > +     if (!folio)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     ret =3D kho_preserve_folio(folio);
> > +     if (ret) {
> > +             folio_put(folio);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> > +     return folio_address(folio);
> > +}
> > +EXPORT_SYMBOL_GPL(kho_alloc_preserve);
> > +
> > +/**
> > + * kho_free_unpreserve - Unpreserve and free memory.
> > + * @mem:  Pointer to the memory allocated by kho_alloc_preserve().
> > + * @size: The original size requested during allocation. This is used =
to
> > + *        recalculate the correct order for freeing the pages.
> > + *
> > + * Unregisters the memory from KHO preservation and frees the underlyi=
ng
> > + * pages back to the system. This function should be called to clean u=
p
> > + * memory allocated with kho_alloc_preserve().
> > + */
> > +void kho_free_unpreserve(void *mem, size_t size)
> > +{
> > +     struct folio *folio;
> > +     unsigned int order;
> > +
> > +     if (!mem || !size)
> > +             return;
> > +
> > +     order =3D get_order(size);
> > +     if (WARN_ON_ONCE(order > MAX_PAGE_ORDER))
> > +             return;
> > +
> > +     folio =3D virt_to_folio(mem);
> > +     WARN_ON_ONCE(kho_unpreserve_folio(folio));
>
> This is what I meant in my reply to the previous patch.
> kho_unpreserve_folio() can be void now, so the WARN_ON_ONCE() is not
> needed.
>
> > +     folio_put(folio);
> > +}
> > +EXPORT_SYMBOL_GPL(kho_free_unpreserve);
> > +
> > +/**
> > + * kho_free_restore - Restore and free memory after kexec.
> > + * @mem:  Pointer to the memory (in the new kernel's address space)
> > + * that was allocated by the old kernel.
> > + * @size: The original size requested during allocation. This is used =
to
> > + * recalculate the correct order for freeing the pages.
> > + *
> > + * This function is intended to be called in the new kernel (post-kexe=
c)
> > + * to take ownership of and free a memory region that was preserved by=
 the
> > + * old kernel using kho_alloc_preserve().
> > + *
> > + * It first restores the pages from KHO (using their physical address)
> > + * and then frees the pages back to the new kernel's page allocator.
> > + */
> > +void kho_free_restore(void *mem, size_t size)
>
> On restore side, callers are already using the phys addr directly. So do
> kho_restore_folio() and kho_restore_pages() for example. This should
> follow suit for uniformity. Would also save the callers a __va() call
> and this function the __pa() call.
>
> > +{
> > +     struct folio *folio;
> > +     unsigned int order;
> > +
> > +     if (!mem || !size)
> > +             return;
> > +
> > +     order =3D get_order(size);
> > +     if (WARN_ON_ONCE(order > MAX_PAGE_ORDER))
> > +             return;
> > +
> > +     folio =3D kho_restore_folio(__pa(mem));
> > +     if (!WARN_ON(!folio))
>
> kho_restore_folio() already WARNs on failure. So the WARN_ON() here can
> be skipped I think.
>
> > +             free_pages((unsigned long)mem, order);
>
> folio_put() here makes more sense since we just restored a folio.
>
> > +}
> > +EXPORT_SYMBOL_GPL(kho_free_restore);
> > +
> >  int kho_finalize(void)
> >  {
> >       int ret;
>
> --
> Regards,
> Pratyush Yadav


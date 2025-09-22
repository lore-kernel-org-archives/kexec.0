Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAFACAC5AA
	for <kexec@archiver.kernel.org>; Mon, 22 Sep 2025 14:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3SOuRg8CAw4qdC6TljMIQSoNCuXerOjdSHs4nx/il8o=; b=GMuHt1mZutWJYaMCkEYe/DIPVi
	IjrO/JiM6qwsR/Uy3VivWR/UL4muBLGvhJo6tDOlJteTH4d4fLQc0KlMUZdKd4ULC327o1zCUMKrC
	Vi3P+2a0/HK2VBS8PHnTj5MJhStL72vzw+cIBJvAih9DfOE/V49Eqjpys1KnJsx1NQ7KK+vaJsWTc
	ejgBaJOU/OV7ncrMq0vAyAxQxsNdt0LKJr+nzsno9LXwtSpZwaXkBq34H0rnVVOVhjbdjtYTBuWHO
	nhq3xVkIulv3xZGxrCktc+k1senwnu3fjVjE73etTAakqLnXymlHU7q5xxedIE8m7w1rF3pyRTsqP
	qPh3cndA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0hNF-0000000Adk7-1q8U;
	Mon, 22 Sep 2025 14:18:37 +0000
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0hND-0000000Adjc-05d4
	for kexec@lists.infradead.org;
	Mon, 22 Sep 2025 14:18:36 +0000
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4ca049e90b8so9018311cf.0
        for <kexec@lists.infradead.org>; Mon, 22 Sep 2025 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758550714; x=1759155514; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SOuRg8CAw4qdC6TljMIQSoNCuXerOjdSHs4nx/il8o=;
        b=D+/a8uO0XJthJaGmTIZxoMi7L8erKlHubqTdFmSxQw1psvjSIbZgHXF7jM7xuxbt0H
         YRAiqkMVIvPRLnP1OcEz40GBWF+m5CFrnoozux7XtzQ9hHYqH5zoshiURz6W4OI7OkY+
         ZSl5jiHHIXhXYlrJp4gekPHzKooOTZN2iPe4VrpQLMUIdPwujCn55TohWnSsuJ3F8Ecx
         R8u+olssHC3YGznrF4tVGYx9iw0C/udNXtpoGtjFeN/69ihEEeg783V5J/xeTMwr9Nul
         Zagyrbk42U5hBTDcANFVTQEcWLb5yBLaSsXfE+2a9ztjCiGSefBDO7LGWz1i9D9YJDOQ
         JjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550714; x=1759155514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SOuRg8CAw4qdC6TljMIQSoNCuXerOjdSHs4nx/il8o=;
        b=QEncIXpLawvJ9OljqGi8jJ/NofeJzZcwVDDDoIeswM8CoXiCUbXV+iGXg3oEhtLkfl
         Ic9nMYt6hueRYbue5qZHdd2JXdIVZtk5yCkhORAy7Vu7+mRh2mf3ArXzDzedCz9DEDHn
         Kd+U4jfXpVMHfFCE6ggqffzwKawa1PIMqR8AXf+IGIHyKxGkwaFwPsEWflhLMMfvfoea
         2caaebCRHgnnZvRpcI4oqL/QAcltaJREe6hDRb6um8SscH7939kixYZvhc5ghE8X/5z+
         JUtH73/mlL9UaRWGkBraGzUHLBbN0G0JmsmNdtW5hMhoi+NpQM8IluClUnFYk0vk/qHJ
         n6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXLPbM9exh8JvsHHXl0zTFDLnybKc7wtYoE8oc5QpXyuDmgAGtmqkWOSFEk+KnszMoa1RXxgg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzzW4Lp+Vp6jajUQsCmgMEQt7df2QoaRt7yVt1qDH4guAImOaw4
	GI0NVmw0IdFDbvI/QVSWHadyBpQpum6XhekEeZnXmuLCOXv2cwA1qEFqfuFHZCMWtqDdjTTgPth
	8dqj+WZQVDOhOGL7MKo9wGFsnJG3VboD+igqvptU7DgsvI/2jZWxidH/jFA==
X-Gm-Gg: ASbGnctKO3vNKKNCRqG3Dl1MStnSyQ1boTrfSD++wqVb1mMh6cgJwY6TIAuGii0tgZI
	h542YzyfvzJlf/TFR0L9KfF99qC7ZDDp8a0ZygegviGO0B0YgOe5nn1+KnIu7KYZO4Gh7wYRA5z
	UXG15KsshGcQYmATFI2vj7se4ARfkRkGC2QcMT+6ZSv8GGBCVJdE5sNRB8UYs/e5XWyJ2elom8M
	JD5
X-Google-Smtp-Source: AGHT+IFhqTMUJ5QI5mJ54JxXg7+gUal2FzXiUL3S25XlFP+lq4CAYaIEkRLtdSJ+1NpX7UxhDL1AdOxDY9fOvqLaP/U=
X-Received: by 2002:a05:622a:989:b0:4b3:4e8e:9e32 with SMTP id
 d75a77b69052e-4c03c195262mr170546171cf.3.1758550713588; Mon, 22 Sep 2025
 07:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250921054458.4043761-1-rppt@kernel.org> <20250921054458.4043761-4-rppt@kernel.org>
In-Reply-To: <20250921054458.4043761-4-rppt@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 22 Sep 2025 10:17:56 -0400
X-Gm-Features: AS18NWAGcHoTlig1ssHPBFP_C5vSdMZBQ76Hlsz-uZcoUPzzkP0cpDwB-jS3KKo
Message-ID: <CA+CK2bDFScwAwyKA2NNkQhvhrj5OsmHm4eTshw2B9e2muqBcvg@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc allocations
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_071835_099050_C215050C 
X-CRM114-Status: GOOD (  32.85  )
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

On Sun, Sep 21, 2025 at 1:45=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> A vmalloc allocation is preserved using binary structure similar to
> global KHO memory tracker. It's a linked list of pages where each page
> is an array of physical address of pages in vmalloc area.
>
> kho_preserve_vmalloc() hands out the physical address of the head page
> to the caller. This address is used as the argument to
> kho_vmalloc_restore() to restore the mapping in the vmalloc address
> space and populate it with the preserved pages.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>  include/linux/kexec_handover.h |  28 ++++
>  kernel/kexec_handover.c        | 281 +++++++++++++++++++++++++++++++++
>  2 files changed, 309 insertions(+)
>
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handove=
r.h
> index cc5c49b0612b..49e36d4ae5dc 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -39,12 +39,23 @@ struct page;
>
>  struct kho_serialization;
>
> +struct kho_vmalloc_chunk;
> +struct kho_vmalloc {
> +        DECLARE_KHOSER_PTR(first, struct kho_vmalloc_chunk *);
> +        unsigned int total_pages;
> +        unsigned short flags;
> +        unsigned short order;
> +};
> +
>  #ifdef CONFIG_KEXEC_HANDOVER
>  bool kho_is_enabled(void);
>
>  int kho_preserve_folio(struct folio *folio);
>  int kho_preserve_pages(struct page *page, unsigned int nr_pages);
> +int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
>  struct folio *kho_restore_folio(phys_addr_t phys);
> +struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
> +void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
>  int kho_add_subtree(struct kho_serialization *ser, const char *name, voi=
d *fdt);
>  int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
>
> @@ -71,11 +82,28 @@ static inline int kho_preserve_pages(struct page *pag=
e, unsigned int nr_pages)
>         return -EOPNOTSUPP;
>  }
>
> +static inline int kho_preserve_vmalloc(void *ptr,
> +                                      struct kho_vmalloc *preservation)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  static inline struct folio *kho_restore_folio(phys_addr_t phys)
>  {
>         return NULL;
>  }
>
> +static inline struct page *kho_restore_pages(phys_addr_t phys,
> +                                            unsigned int nr_pages)
> +{
> +       return NULL;
> +}
> +
> +static inline void *kho_restore_vmalloc(const struct kho_vmalloc *preser=
vation)
> +{
> +       return NULL;
> +}
> +
>  static inline int kho_add_subtree(struct kho_serialization *ser,
>                                   const char *name, void *fdt)
>  {
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index fd80be3b12fd..e6380d8dce57 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -18,6 +18,7 @@
>  #include <linux/memblock.h>
>  #include <linux/notifier.h>
>  #include <linux/page-isolation.h>
> +#include <linux/vmalloc.h>
>
>  #include <asm/early_ioremap.h>
>
> @@ -274,6 +275,37 @@ struct folio *kho_restore_folio(phys_addr_t phys)
>  }
>  EXPORT_SYMBOL_GPL(kho_restore_folio);
>
> +/**
> + * kho_restore_pages - restore list of contiguous order 0 pages.
> + * @phys: physical address of the first page.
> + * @nr_pages: number of pages.
> + *
> + * Restore a contiguous list of order 0 pages that was preserved with
> + * kho_preserve_pages().
> + *
> + * Return: 0 on success, error code on failure
> + */
> +struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages)
> +{
> +       const unsigned long start_pfn =3D PHYS_PFN(phys);
> +       const unsigned long end_pfn =3D start_pfn + nr_pages;
> +       unsigned long pfn =3D start_pfn;
> +
> +       while (pfn < end_pfn) {
> +               const unsigned int order =3D
> +                       min(count_trailing_zeros(pfn), ilog2(end_pfn - pf=
n));
> +               struct page *page =3D kho_restore_page(PFN_PHYS(pfn));

This line breaks linux-next build because, kho_restore_page has a prototype=
:
void kho_restore_page(struct page *page, unsigned int order).

> +
> +               if (!page)
> +                       return NULL;
> +               split_page(page, order);
> +               pfn +=3D 1 << order;
> +       }
> +
> +       return pfn_to_page(start_pfn);
> +}
> +EXPORT_SYMBOL_GPL(kho_restore_pages);
> +
>  /* Serialize and deserialize struct kho_mem_phys across kexec
>   *
>   * Record all the bitmaps in a linked list of pages for the next kernel =
to
> @@ -763,6 +795,255 @@ int kho_preserve_pages(struct page *page, unsigned =
int nr_pages)
>  }
>  EXPORT_SYMBOL_GPL(kho_preserve_pages);
>
> +struct kho_vmalloc_hdr {
> +       DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
> +};
> +
> +#define KHO_VMALLOC_SIZE                               \
> +       ((PAGE_SIZE - sizeof(struct kho_vmalloc_hdr)) / \
> +        sizeof(phys_addr_t))
> +
> +struct kho_vmalloc_chunk {
> +       struct kho_vmalloc_hdr hdr;
> +       phys_addr_t phys[KHO_VMALLOC_SIZE];
> +};
> +
> +static_assert(sizeof(struct kho_vmalloc_chunk) =3D=3D PAGE_SIZE);
> +
> +/* vmalloc flags KHO supports */
> +#define KHO_VMALLOC_SUPPORTED_FLAGS    (VM_ALLOC | VM_ALLOW_HUGE_VMAP)
> +
> +/* KHO internal flags for vmalloc preservations */
> +#define KHO_VMALLOC_ALLOC      0x0001
> +#define KHO_VMALLOC_HUGE_VMAP  0x0002
> +
> +static unsigned short vmalloc_flags_to_kho(unsigned int vm_flags)
> +{
> +       unsigned short kho_flags =3D 0;
> +
> +       if (vm_flags & VM_ALLOC)
> +               kho_flags |=3D KHO_VMALLOC_ALLOC;
> +       if (vm_flags & VM_ALLOW_HUGE_VMAP)
> +               kho_flags |=3D KHO_VMALLOC_HUGE_VMAP;
> +
> +       return kho_flags;
> +}
> +
> +static unsigned int kho_flags_to_vmalloc(unsigned short kho_flags)
> +{
> +       unsigned int vm_flags =3D 0;
> +
> +       if (kho_flags & KHO_VMALLOC_ALLOC)
> +               vm_flags |=3D VM_ALLOC;
> +       if (kho_flags & KHO_VMALLOC_HUGE_VMAP)
> +               vm_flags |=3D VM_ALLOW_HUGE_VMAP;
> +
> +       return vm_flags;
> +}
> +
> +static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_ch=
unk *cur)
> +{
> +       struct kho_vmalloc_chunk *chunk;
> +       int err;
> +
> +       chunk =3D (struct kho_vmalloc_chunk *)get_zeroed_page(GFP_KERNEL)=
;
> +       if (!chunk)
> +               return NULL;
> +
> +       err =3D kho_preserve_pages(virt_to_page(chunk), 1);
> +       if (err)
> +               goto err_free;
> +       if (cur)
> +               KHOSER_STORE_PTR(cur->hdr.next, chunk);
> +       return chunk;
> +
> +err_free:
> +       free_page((unsigned long)chunk);
> +       return NULL;
> +}
> +
> +static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk=
)
> +{
> +       struct kho_mem_track *track =3D &kho_out.ser.track;
> +       unsigned long pfn =3D PHYS_PFN(virt_to_phys(chunk));
> +
> +       __kho_unpreserve(track, pfn, pfn + 1);
> +
> +       for (int i =3D 0; chunk->phys[i]; i++) {
> +               pfn =3D PHYS_PFN(chunk->phys[i]);
> +               __kho_unpreserve(track, pfn, pfn + 1);
> +       }
> +}
> +
> +static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
> +{
> +       struct kho_vmalloc_chunk *chunk =3D KHOSER_LOAD_PTR(kho_vmalloc->=
first);
> +
> +       while (chunk) {
> +               struct kho_vmalloc_chunk *tmp =3D chunk;
> +
> +               kho_vmalloc_unpreserve_chunk(chunk);
> +
> +               chunk =3D KHOSER_LOAD_PTR(chunk->hdr.next);
> +               kfree(tmp);
> +       }
> +}
> +
> +/**
> + * kho_preserve_vmalloc - preserve memory allocated with vmalloc() acros=
s kexec
> + * @ptr: pointer to the area in vmalloc address space
> + * @preservation: placeholder for preservation metadata
> + *
> + * Instructs KHO to preserve the area in vmalloc address space at @ptr. =
The
> + * physical pages mapped at @ptr will be preserved and on successful ret=
urn
> + * @preservation will hold the physical address of a structure that desc=
ribes
> + * the preservation.
> + *
> + * NOTE: The memory allocated with vmalloc_node() variants cannot be rel=
iably
> + * restored on the same node
> + *
> + * Return: 0 on success, error code on failure
> + */
> +int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
> +{
> +       struct kho_vmalloc_chunk *chunk;
> +       struct vm_struct *vm =3D find_vm_area(ptr);
> +       unsigned int order, flags, nr_contig_pages;
> +       unsigned int idx =3D 0;
> +       int err;
> +
> +       if (!vm)
> +               return -EINVAL;
> +
> +       if (vm->flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
> +               return -EOPNOTSUPP;
> +
> +       flags =3D vmalloc_flags_to_kho(vm->flags);
> +       order =3D get_vm_area_page_order(vm);
> +
> +       chunk =3D new_vmalloc_chunk(NULL);
> +       if (!chunk)
> +               return -ENOMEM;
> +       KHOSER_STORE_PTR(preservation->first, chunk);
> +
> +       nr_contig_pages =3D (1 << order);
> +       for (int i =3D 0; i < vm->nr_pages; i +=3D nr_contig_pages) {
> +               phys_addr_t phys =3D page_to_phys(vm->pages[i]);
> +
> +               err =3D kho_preserve_pages(vm->pages[i], nr_contig_pages)=
;
> +               if (err)
> +                       goto err_free;
> +
> +               chunk->phys[idx++] =3D phys;
> +               if (idx =3D=3D ARRAY_SIZE(chunk->phys)) {
> +                       chunk =3D new_vmalloc_chunk(chunk);
> +                       if (!chunk)
> +                               goto err_free;
> +                       idx =3D 0;
> +               }
> +       }
> +
> +       preservation->total_pages =3D vm->nr_pages;
> +       preservation->flags =3D flags;
> +       preservation->order =3D order;
> +
> +       return 0;
> +
> +err_free:
> +       kho_vmalloc_free_chunks(preservation);
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
> +
> +/**
> + * kho_restore_vmalloc - recreates and populates an area in vmalloc addr=
ess
> + * space from the preserved memory.
> + * @preservation: preservation metadata.
> + *
> + * Recreates an area in vmalloc address space and populates it with memo=
ry that
> + * was preserved using kho_preserve_vmalloc().
> + *
> + * Return: pointer to the area in the vmalloc address space, NULL on fai=
lure.
> + */
> +void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
> +{
> +       struct kho_vmalloc_chunk *chunk =3D KHOSER_LOAD_PTR(preservation-=
>first);
> +       unsigned int align, order, shift, vm_flags;
> +       unsigned long total_pages, contig_pages;
> +       unsigned long addr, size;
> +       struct vm_struct *area;
> +       struct page **pages;
> +       unsigned int idx =3D 0;
> +       int err;
> +
> +       vm_flags =3D kho_flags_to_vmalloc(preservation->flags);
> +       if (vm_flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
> +               return NULL;
> +
> +       total_pages =3D preservation->total_pages;
> +       pages =3D kvmalloc_array(total_pages, sizeof(*pages), GFP_KERNEL)=
;
> +       if (!pages)
> +               return NULL;
> +       order =3D preservation->order;
> +       contig_pages =3D (1 << order);
> +       shift =3D PAGE_SHIFT + order;
> +       align =3D 1 << shift;
> +
> +       while (chunk) {
> +               struct page *page;
> +
> +               for (int i =3D 0; chunk->phys[i]; i++) {
> +                       phys_addr_t phys =3D chunk->phys[i];
> +
> +                       if (idx + contig_pages > total_pages)
> +                               goto err_free_pages_array;
> +
> +                       page =3D kho_restore_pages(phys, contig_pages);
> +                       if (!page)
> +                               goto err_free_pages_array;
> +
> +                       for (int j =3D 0; j < contig_pages; j++)
> +                               pages[idx++] =3D page;
> +
> +                       phys +=3D contig_pages * PAGE_SIZE;
> +               }
> +
> +               page =3D kho_restore_pages(virt_to_phys(chunk), 1);
> +               if (!page)
> +                       goto err_free_pages_array;
> +               chunk =3D KHOSER_LOAD_PTR(chunk->hdr.next);
> +               __free_page(page);
> +       }
> +
> +       if (idx !=3D total_pages)
> +               goto err_free_pages_array;
> +
> +       area =3D __get_vm_area_node(total_pages * PAGE_SIZE, align, shift=
,
> +                                 vm_flags, VMALLOC_START, VMALLOC_END,
> +                                 NUMA_NO_NODE, GFP_KERNEL,
> +                                 __builtin_return_address(0));
> +       if (!area)
> +               goto err_free_pages_array;
> +
> +       addr =3D (unsigned long)area->addr;
> +       size =3D get_vm_area_size(area);
> +       err =3D vmap_pages_range(addr, addr + size, PAGE_KERNEL, pages, s=
hift);
> +       if (err)
> +               goto err_free_vm_area;
> +
> +       area->nr_pages =3D total_pages;
> +       area->pages =3D pages;
> +
> +       return area->addr;
> +
> +err_free_vm_area:
> +       free_vm_area(area);
> +err_free_pages_array:
> +       kvfree(pages);
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
> +
>  /* Handling for debug/kho/out */
>
>  static struct dentry *debugfs_root;
> --
> 2.50.1
>


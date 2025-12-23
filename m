Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B84E6FE24
	for <kexec@archiver.kernel.org>; Tue, 23 Dec 2025 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ok3Aj/qyWRE1hCf9QqFvj0/4fcSMjg0OoyQuUL19KWU=; b=gXuKyut7zS6fI1bFnqpuxR3blb
	ECYQMHLWDVDu6z3VTDloBYeki5fsdGUw6PCaENmQX5fd01bak+AfkGq+YOS4SiBzXhAm97/OcCl6q
	8FtT1tB/iah9VDmPMfcQjYLmpVkNhEpr+tc62uf2Vk03nGRGOeShZnFel0aIAJDw+ZhJrfU64wJUW
	S+YdqNLX9Dm+q0LfcQ5xGLA+SV4haDJ1h7/T/yuxHSqBsafI7nfxzzjRL+tJcY4hxO/CfOCQy1+/B
	FWNXk7bRCW3QByh7AvkEtmdF+bbqWG4PNTyWfqXT2nwmfWW0HxlU80ky46bcxubJtiVzCJHbFQYMc
	4qwcugBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY6Wb-0000000FrtC-0al0;
	Tue, 23 Dec 2025 17:50:21 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY6WY-0000000Frsn-0MIi
	for kexec@lists.infradead.org;
	Tue, 23 Dec 2025 17:50:19 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-b7cee045187so935427966b.0
        for <kexec@lists.infradead.org>; Tue, 23 Dec 2025 09:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766512216; x=1767117016; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ok3Aj/qyWRE1hCf9QqFvj0/4fcSMjg0OoyQuUL19KWU=;
        b=HwCUdoSEJCVH91Nplcyqb8Q2CrSxESMw2qnEfnYYuooE9lygW49nV3vsojeJfhx5Ls
         lVIv1z19V5wIa1nRnedU4DO18vSVYjtahob5HxOFdVSJstTsaaFWz05eSlsUr2cKN1V9
         I71zXqKiViGC3o4vuVha2c6Ry2D/TjuyroXYan9jJL2aFzwwY3soewL5Cx46XzqcTBHV
         cAinGnTATKJ9Nfd15ApcqVPYSS3f4GeepAulouZwPhWM3uA4tsojGkV9xtmNy9IZXDrW
         3mYgcNAldd6eVxN68OBWO4j47jlc8RsX3B2EmaENoeZCqSQWV1mWzCsWJTp3Frciofsl
         2Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766512216; x=1767117016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ok3Aj/qyWRE1hCf9QqFvj0/4fcSMjg0OoyQuUL19KWU=;
        b=J52t5uwTp43jR9OpsoFpCKgU9DS6tZawesZ8g+mLCJH05BWG3ZaDtKUoxSY1ZkMvlu
         /7uXwhUwFr3VqH7mV7AuT5yzXwHoO4f3DvV6bQdyhpXLJj6IjxJrOxo4grirWRsd/4TS
         rioqN4uVmALWrvcv7CNrrtdZSOORyD0XKifwp0XgsfbZsY152sZluhsOUajgMemjzybG
         ZbFkD2UsaJF5N3NHre9/IqqrSufY027gA4xac9Z/lAVG/YfUt5Babq1myC9HGUas7v8O
         qjzfx8uE0gZ7ODKbo6urdCsAqNGNj3qrfBXLmJdWxzVoZjQOHokOivmnbGUQZEJrq+aH
         QVKg==
X-Forwarded-Encrypted: i=1; AJvYcCVPBrnBF4ZD4TW6gfGa9exekKUm+Bd1h2faPwr3dNBKvab2t/UBk87sdHGX2drHRwjDxxClig==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7+SeX9hyCJV/TQdG1VBTyVd9UAz59aaFbvCGjuS/yL3kxHdEQ
	o53w1xwJ7uoQ9p5tBYYiYuoXqSPu/n47I4dFnrSdkKTlxX/8N1W8RfrcZLY0vLbPc2lt7Ik/5+e
	PX5JvinMwoFMNxffQpe/4R33UL+MdQ7buLdRnZ/topA==
X-Gm-Gg: AY/fxX62UU+S0dvmHekupkdwsFCAYPMSM45HoiZWGngBlCx1qF2oi/I1Tz0cg9E0ZWP
	vGBIrRRr7DbjzmizzFrCZ4Fh/J7ZNkOwGFxTWwSnqjZIaH1Mn4G/vcO4Dof54bZxE6scGIKmsL0
	OttabRs1R/jHrwlJG4u8qIwo9GRJirGZdlo+0y11blJ8rdZgISOl/C/mob365R1p+gzi7k4dp3l
	NgOXWb+YQdJvy4m+dM8QfM28Jjz61MNOfa1tbfHv3o18mNuO+gxchxYNS/wHXxVf8toIYROmZJI
	d0c7vNTKrnvn6fCK7KL3d/5PmQ==
X-Google-Smtp-Source: AGHT+IHpM1t2D8hom0JAjvCmVAh1r2zpdM9beyI1kYn99D4aa5g9AkslkSjbRb3fRBVIViB0dpMOcMDXtwKoyXUcSf0=
X-Received: by 2002:a17:907:61a2:b0:b80:3fb7:8e68 with SMTP id
 a640c23a62f3a-b803fb78ef2mr933875966b.21.1766512215920; Tue, 23 Dec 2025
 09:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20251223104448.195589-1-pratyush@kernel.org>
In-Reply-To: <20251223104448.195589-1-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 23 Dec 2025 12:49:39 -0500
X-Gm-Features: AQt7F2pf8XmLmwqluLaF5vHB_10yuSQHlsbc1JXgZTMDrcOQxJTZMuXQmSFqybE
Message-ID: <CA+CK2bBv2wpduYQF_fwzciH4HxZ6eFjwZMSpZwW0AC6KXL4msg@mail.gmail.com>
Subject: Re: [PATCH] kho: simplify page initialization in kho_restore_page()
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_095018_153140_4ED4846A 
X-CRM114-Status: GOOD (  27.56  )
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

On Tue, Dec 23, 2025 at 5:45=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> When restoring a page (from kho_restore_pages()) or folio (from
> kho_restore_folio()), KHO must initialize the struct page. The
> initialization differs slightly depending on if a folio is requested or
> a set of 0-order pages is requested.
>
> Conceptually, it is quite simple to understand. When restoring 0-order
> pages, each page gets a refcount of 1 and that's it. When restoring a
> folio, head page gets a refcount of 1 and tail pages get 0.
>
> kho_restore_page() tries to combine the two separate initialization flow
> into one piece of code. While it works fine, it is more complicated to
> read than it needs to be. Make the code simpler by splitting the two
> initalization paths into two separate functions. This improves
> readability by clearly showing how each type must be initialized.
>
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>
> Notes:
>     This patch is a follow up from
>     https://lore.kernel.org/linux-mm/86ms42mj44.fsf@kernel.org/
>
>  kernel/liveupdate/kexec_handover.c | 41 ++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 2d9ce33c63dc..304c26fd5ee6 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -219,11 +219,33 @@ static int __kho_preserve_order(struct kho_mem_trac=
k *track, unsigned long pfn,
>         return 0;
>  }
>
> +/* For physically contiguous 0-order pages. */
> +static void kho_init_pages(struct page *page, unsigned int nr_pages)

Here and in other places below, it is better for nr_pages to be
unsigned long. This is consistent with other places in mm, where we
have gradually moved on from int/unsigned int to unsigned long for
npages (see gup.c for example). Otherwise, LGTM.

> +{
> +       for (unsigned int i =3D 0; i < nr_pages; i++)
> +               set_page_count(page + i, 1);
> +}
> +
> +static void kho_init_folio(struct page *page, unsigned int order)
> +{
> +       unsigned int nr_pages =3D (1 << order);
> +
> +       /* Head page gets refcount of 1. */
> +       set_page_count(page, 1);
> +
> +       /* For higher order folios, tail pages get a page count of zero. =
*/
> +       for (unsigned int i =3D 1; i < nr_pages; i++)
> +               set_page_count(page + i, 0);
> +
> +       if (order > 0)
> +               prep_compound_page(page, order);
> +}
> +
>  static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>  {
>         struct page *page =3D pfn_to_online_page(PHYS_PFN(phys));
> -       unsigned int nr_pages, ref_cnt;
>         union kho_page_info info;
> +       unsigned int nr_pages;
>
>         if (!page)
>                 return NULL;
> @@ -240,20 +262,11 @@ static struct page *kho_restore_page(phys_addr_t ph=
ys, bool is_folio)
>
>         /* Clear private to make sure later restores on this page error o=
ut. */
>         page->private =3D 0;
> -       /* Head page gets refcount of 1. */
> -       set_page_count(page, 1);
>
> -       /*
> -        * For higher order folios, tail pages get a page count of zero.
> -        * For physically contiguous order-0 pages every pages gets a pag=
e
> -        * count of 1
> -        */
> -       ref_cnt =3D is_folio ? 0 : 1;
> -       for (unsigned int i =3D 1; i < nr_pages; i++)
> -               set_page_count(page + i, ref_cnt);
> -
> -       if (is_folio && info.order)
> -               prep_compound_page(page, info.order);
> +       if (is_folio)
> +               kho_init_folio(page, info.order);
> +       else
> +               kho_init_pages(page, nr_pages);

Thanks,
Pasha


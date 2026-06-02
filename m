Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BAACD6E60
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PUr3bsMoRkbQDw1QaKEWk5VDOxAnIFkuTAcpZsbKpvU=; b=UE/ZkGzQdDE7JEBOzpz4kpCSwa
	xXxzI89BIzErLJO6g2EXIv6aEB9chuqPVcGukam02ObFlnDzEPAf4/9BMhMr+E4fEw75TRR7+SZ+k
	Qkl+FkDEyPKEbvCyXdXX4sRPjFZnIiUqseHvzXjE5gSEGHNu3q33JmgB7KxB7gifeLIRib1F7/mge
	mq6zezSQcRC+Btg6wyv1ItvuDyPYiqDcqJTrHZ950Gpb9T0VBdD3cm+Rnu+9j5BsMuM9zl4k6+l0S
	OaJ3e+g/K/xYfzjZ9SI/KGcoDM/DD99KM4TX5/1sCQqrpzJ+Pqbka2vQpc3XW8IuEhRWu9+9LowhB
	VfhTZK4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wURHm-0000000DMCJ-1iq7;
	Tue, 02 Jun 2026 15:44:10 +0000
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wURHj-0000000DMBp-42MN
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 15:44:09 +0000
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-13618bda934so71c88.0
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 08:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780415047; cv=none;
        d=google.com; s=arc-20240605;
        b=hS6S6VTDag5HrviJ2Bcse7lwhO9L4fwKexnbUeEvyHl6AOuCT1xz6J64I58uCS4UcD
         JMfV1I+19k6MzaeN4NmnQUL6FDSu4OJVjLxwegizfQtGxCLjVX1rDRY5KIhhkKuH3DnH
         pYa0BodaEqbdlDzRnrNnbFzT38PSltdYP8AE06boNyINkGZoJYapDfwZjR00U++oswEr
         3EBIMu9Mte84JliVYI0Xf+wobh7otu0axkU5kw1Km5i9g2Ecs60detb/6MqJqid5JmJW
         82beDlLXxxnPJ2ulr9bp1ZtpoEdKxiDecwAUe/Es4TMhntd9pDXG1DL6vKb2i09WyVgh
         rULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PUr3bsMoRkbQDw1QaKEWk5VDOxAnIFkuTAcpZsbKpvU=;
        fh=4tYgjt9SGb4N/YOCkeoGBaDVMCcimAvzi5/3pfjk/2Q=;
        b=OGR547qB5Jit8wjoau3oM+Xd5oqsOSzqugqISGFKwnmANb1onihgczfbWU3/KqQYpw
         2RHltc9GNOuLs0bETFepf3UTT0odo6Z6/0t0tr13q/+/BeVWvD/s5s1azal2iykv56G9
         AJ0y4sIVx0bESnu3tBZH0LdEwamBpTwT8WsgYZ2aJwduzd90nZ8eozEmiEHCnmvspN7a
         Tpz6WDKbecWPfuebhFiL/g/r/FoJokoNW0WxiIO3xX46nEGdaJFm9qWN+yAPlrHrjZXx
         0E8Gb/Ed+EAoOw1eA5iCbi9tImJeyKt4wmttFyycKyNG7opd82+BcQWsrHkBsuPzKvcS
         7LQA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780415047; x=1781019847; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUr3bsMoRkbQDw1QaKEWk5VDOxAnIFkuTAcpZsbKpvU=;
        b=QCJwll6cTvCTVlG7wCz7Kc6T1n7UuKTo1+1yO4RhY6jnyMwSzxxw/7Cbr6s96O/PM6
         bUBtgti/n/1cwkiBh2084wQhVCmVPwGSMPgNYUftF/KiruZWOqQKKttybxPe6qMr8TS/
         5XEfZCmja6XcVbzVI+BOxyxzcGA1TY+/4vPczReNPMoCtQPSxmdk2WPHiTdDvi8i9hAb
         ZlWlUrwDNdcRqEVnja1A/Ja+WrcHzen1id2dhMop/1TOvLv8Ezkrtwn0P1kahHJ4zk2U
         oX77rRH3NaWOW/8VZZooq6B7gTI9NTj1iMzYBJ2LQp5e/aL+JpYdGTpV9YH7kJi0bakq
         wm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780415047; x=1781019847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PUr3bsMoRkbQDw1QaKEWk5VDOxAnIFkuTAcpZsbKpvU=;
        b=CDHMsXlXSBlYM9i6tabgH7lsFZZrDrFgm5YYSbWWcSWfxWhMgaEtOGzoCUu4bTC3k9
         awECzXoER0/sjeV61HrqFQ/WlK+HBwLBbAFgN821lN72Gw8FV2SN9d/srwBgZpJO6EUD
         OfdA4jl7QChta8raRHC1KyiOgxpSB6C2eIm2eOtKw1lMtmkaz0AVz1DtE3jSQVr/P57a
         T0ZvnOy1e2u9L66ZkTFJn7xNSmYdMxB7fE+tWbihHloVWMP2VW1Y15iIEsG8t4KtxLcD
         0C2oLV/W1Twpzb89KKNIDefktw72VEV10i42exxQoC4Oy/SfAPhBjhzVPTrIZeOi29Ny
         H1Hg==
X-Forwarded-Encrypted: i=1; AFNElJ8zRKxkzRQ7vfVP+gWW7HYlvs+JJ16BdId0fz9F/7MKN6dxcT2JW7Y0dgfS/9Fo34Jb1Sb7/Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YzKKWfNvFgiwXfTC4nPk4cD83eE1IHpnyMl2740fG35Po4rTC8t
	w+EXwuh5Fm8GLTnJ2tR3EGVSgu60hlWBx4FYWCFAd0alKrhNj+PDJu1EjyjTU9NKbcrSojgUpKZ
	O67AcEo7mzRXwporW0P+LcSS+xy/I63Nv/jC7c6VpJp/kzbbkEGxwjYsyeNQ=
X-Gm-Gg: Acq92OH5cibm79jtHpI2h/8tvoFm7TY7kvON98Sbdv0PLoRsT7nN+uZo+gsaSpItolH
	9cr5ypIRUmfrGX3Kqf3zBfpI5AxstYKgJZC3WzUkHg4t45t5+YayYZXAaVfWZs0eoavLdph8MXB
	UN6i3O0eEWjBj7OjqGLRFYxKdI0VhwI0v0pkYhg8hf968OdrCEQ7CXNX9DTLnC5xvj/Cv7DiDFl
	b5QafDS/q2NZOVN2tsHhDCbz40U2hBpjkscYXrRDDRLjpbU/NzZRhe/4l1dyTk+tT8NhRzQ3Ufq
	n9zm9+pQVgp6/MHx
X-Received: by 2002:a05:7022:3d89:b0:12c:912f:7cf1 with SMTP id
 a92af1059eb24-137ef2cfa23mr156195c88.17.1780415046249; Tue, 02 Jun 2026
 08:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260602123311.1841746-1-mclapinski@google.com> <2vxzik81dlbu.fsf@kernel.org>
In-Reply-To: <2vxzik81dlbu.fsf@kernel.org>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Tue, 2 Jun 2026 17:43:54 +0200
X-Gm-Features: AVHnY4JzlSNTCvrh69-19UrZ8cMETgvrUgVqoPX3sgOo-O_Dp7lT-BvERyowspA
Message-ID: <CAAi7L5chTDdmGfdZGU+KONgYRi7JE-2R53-zhFi-L-17rg2G2A@mail.gmail.com>
Subject: Re: [PATCH v2] kexec_file: skip checksum verification when safe
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_084408_011895_F561AB54 
X-CRM114-Status: GOOD (  56.58  )
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

On Tue, Jun 2, 2026 at 5:16=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Tue, Jun 02 2026, Michal Clapinski wrote:
>
> > Checksum verification is needed
> > 1. for crash kernels. In a crash, we can't be sure the kernel is
> >    intact.
> > 2. if we're worried about relocating the kernel into a region used by
> >    some DMA that wasn't properly cancelled.
> >
> > If KHO is enabled then relocations will happen to KHO scratch, which
> > is free from DMA regions.
> > If we used CMA to allocate segments then relocations are not going to
> > happen at all.
> > Therefore, we can safely disable checksum verification in both of those
> > cases.
> >
> > Instead of adding a new variable to purgatory, just skip adding regions
> > and save the default value of SHA256 hash.
> >
> > Saves ~250ms on my 4.0 GHz CPU. This is an important saving for the
> > live-update project.
> >
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > ---
> > v2:
> > - also skip checksum verification if KHO is enabled
> > - small fixes from reviews
> >
> > My original idea was to do 2 changes:
> > 1. Skip checksum if all segments are CMA.
> > 2. If KHO is enabled, allocate the kernel inside kho_scratch using CMA.
> >
> > This way we could skip both relocations and checksum verification when
> > KHO is enabled.
> > But I realized that step 2 might not be possible on warm boots.
>
> AFAIU we only relocate into scratch since relocating anywhere else might
> over-write preserved memory. If there is no relocation, there is no need
> for the kernel image to be in scratch, since the image won't be
> preserved memory anyway.
>
> So perhaps we can just use CMA directly, and only fall back to
> kho_locate_mem_hole() if that fails? This should be a simple enough
> change.

I agree that it will work. However, the user would need to have CMA
memory and it would need to have enough contiguous memory available.
Do you think running out of CMA memory is a real problem?

> Do you know how much time we can save by skipping relocations? I would
> guess it is in the hundreds of milliseconds.

It's smaller than the variance between runs. Maybe 10ms. Everything
between exiting the old kernel and TSC initialization in the new
kernel takes ~70ms.

Theoretically if we didn't have to do relocations, we could try
unpacking the kernel before kexec, which would save a little bit more
time. But again, definitely less than 0.1s.

> Can you try this (COMPLETELY UNTESTED) patch out and see if it works and
> if it further improves kexec time?
>
> --- 8< ---
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 2bfbb2d144e6..0ccc7b6d67c1 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -720,14 +720,6 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>         if (kbuf->mem !=3D KEXEC_BUF_MEM_UNKNOWN)
>                 return 0;
>
> -       /*
> -        * If KHO is active, only use KHO scratch memory. All other memor=
y
> -        * could potentially be handed over.
> -        */
> -       ret =3D kho_locate_mem_hole(kbuf, locate_mem_hole_callback);
> -       if (ret <=3D 0)
> -               return ret;
> -
>         /*
>          * Try to find a free physically contiguous block of memory first=
. With that, we
>          * can avoid any copying at kexec time.
> @@ -735,6 +727,14 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>         if (!kexec_alloc_contig(kbuf))
>                 return 0;
>
> +       /*
> +        * If KHO is active and relocations are to be done,, only use KHO
> +        * scratch memory. All other memory could potentially be handed o=
ver.
> +        */
> +       ret =3D kho_locate_mem_hole(kbuf, locate_mem_hole_callback);
> +       if (ret <=3D 0)
> +               return ret;
> +
>         if (!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
>                 ret =3D kexec_walk_resources(kbuf, locate_mem_hole_callba=
ck);
>         else
> --- >8 ---
>
> Of course this is not directly related to this patch so it shouldn't
> block it, but I reckon we might be able to squeeze a bit more
> performance out this way as a follow up.
>
> > I have no idea how to fix that (except weird ideas like 2 kho_scratches
> > that we swap on every warm boot), so I decided to just skip checksum
> > verification when KHO is enabled. This unfortunately means relocations
> > will still happen.
> > ---
> >  kernel/kexec_file.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 2bfbb2d144e6..db25a14692ab 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/dma-map-ops.h>
> > +#include <linux/kexec_handover.h>
> >  #include "kexec_internal.h"
> >
> >  #ifdef CONFIG_KEXEC_SIG
> > @@ -798,6 +799,16 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
> >       return 0;
> >  }
> >
> > +static bool kexec_only_cma_segments(struct kimage *image)
> > +{
> > +     for (int i =3D 0; i < image->nr_segments; i++) {
> > +             if (!image->segment_cma[i])
> > +                     return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> >  /* Calculate and store the digest of segments */
> >  static int kexec_calculate_store_digests(struct kimage *image)
> >  {
> > @@ -822,6 +833,21 @@ static int kexec_calculate_store_digests(struct ki=
mage *image)
> >
> >       sha256_init(&sctx);
> >
> > +     /*
> > +      * If KHO is enabled, the destinations are located in KHO scratch=
.
> > +      * KHO scratch can only contain early boot allocations and movabl=
e
> > +      * allocations. That means there is no risk of memory corruption =
by
> > +      * uncancelled DMA.
> > +      *
> > +      * If all segments were loaded into contiguous memory, there will=
 be no
> > +      * relocations at all, so also no risk no corruption.
>
> Typo: "so also no risk *of* corruption".
>
> We can fix that up when applying I think, so no need for a v3 just for
> this.
>
> Other than this,
>
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>
> > +      */
> > +     if (image->type !=3D KEXEC_TYPE_CRASH &&
> > +         (kho_is_enabled() || kexec_only_cma_segments(image))) {
> > +             pr_debug("disabling checksum verification in purgatory\n"=
);
> > +             goto skip_checksum;
> > +     }
> > +
> >       for (j =3D i =3D 0; i < image->nr_segments; i++) {
> >               struct kexec_segment *ksegment;
> >
> > @@ -867,6 +893,7 @@ static int kexec_calculate_store_digests(struct kim=
age *image)
> >               j++;
> >       }
> >
> > +skip_checksum:
> >       sha256_final(&sctx, digest);
> >
> >       ret =3D kexec_purgatory_get_set_symbol(image, "purgatory_sha_regi=
ons",
>
> --
> Regards,
> Pratyush Yadav


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1009EC88E72
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 16:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qWVBYiAiVaUTItPwh8DxKhgx0WfrEial88iAt+y43m4=; b=VSaIciiGs8cuaPbl3mByS5riOH
	SZDqx6mbe8jz9NrQ9oq5gBh1HdawvBOwe2g+fJOFO2lk0uJDz5tmPQiqkWIqjQQd2YuoafosqjMQ2
	FFXg8VkOkD8+mVy6P2sdFuQE733sKfT681+HwL9paiw/iJZCfZAiHSN65J/EQaqslH1Y9xCFL5rdg
	lZozNJEoHRHGiG5eFxkCvg3yQaacylJ19/ixEzrbVz6dG5B6TxAu5WOrE+eOFH4+JqBKDGdJo9BB0
	C8VXlCXWBWaM/AiQshV/ULNu+n5G7o6VoqmEv50YPZ88VCj7T8VepnRDkpAni2KI6NvPh7j/PK9B1
	2FCCqeKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Eym-0000000Btsr-41VN;
	Thu, 17 Sep 2026 16:28:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Eyl-0000000BtsE-3PYd
	for kexec@bombadil.infradead.org;
	Thu, 17 Sep 2026 16:28:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qWVBYiAiVaUTItPwh8DxKhgx0WfrEial88iAt+y43m4=; b=ONnyixZwu6SbhnrnDsmOHLFBTF
	LoN1DymhjZyKWQoENREjV1xMzGTFusIq77RVfDLo8qeKQ4fhO2vy52vRzsSz5zEzSZELNC4fkGZvT
	kqLQEJkgP0g6ezgNh2Vlg7g5F+7PU/1/TCLgvf2aApBfHe6Bkl3ez3wCozoxbdEXG2yBAojMz8E16
	FwINJE69aTWWXLRY5XN0lLH9owaFX9vD85g9qW9MgWOKKSX9O63usBEjkHTPPWHd+cVmcAmZ1rATn
	UcfNcWstiEjRR5frDYnIcLMzzw7wfILLM9vF+vzxlU81QTAfam0FcHLwQQOSvaeH8Fey4J72eW0jg
	TmHpFVDw==;
Received: from mail-lf2-x10.google.com ([2a00:1450:4864:36::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7Eyi-000000092Zu-2bI6
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 16:28:54 +0000
Received: by mail-lf2-x10.google.com with SMTP id 2adb3069b0e04-5b7be8dbabfso930448e87.2
        for <kexec@lists.infradead.org>; Thu, 17 Sep 2026 09:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789662530; cv=none;
        d=google.com; s=arc-20260327;
        b=pdzTYYoEQ7TJ9e3OG5hyf1RoCCCIIHLYb0TekWkGSnIpl6NLMQzlTDwBs9relYRdRG
         BrKj2/eCu3YuAF7NC9ddkzpuIQRE1XK/H3itSvn8N4gaECsW6DxU2qvq1FrFzx9Aqcyp
         Dpy9wMQBaVa1dKalufBZxrGJnD5V3fP3/ofFzLLATK+2F7Ja8FAVJU0Kcg05uAV67WAs
         vxKt+KeH3IstdKdiHuBJu8qrIV3Vhi3+7k3+FoCNnFpR8ygHZm6+vPzKOV3jV59yewIc
         ne6chVasUvrng6sOAIkeAr/MUxQEFD7inMzzHPODBk3eM/QMcUTvQt4Qfro+AyEp++rZ
         ISMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qWVBYiAiVaUTItPwh8DxKhgx0WfrEial88iAt+y43m4=;
        fh=sjEGxJrpK2xBMA0syWHEJ8c0bnS/GjKwJV+8S7ldWyg=;
        b=oBJrk9ocLPKaUT+UZWJS9t/x1liXXNdGWDFEG48B3fIQudOfHGMaKB/qi0+qxGPwtT
         fF9YMkCwpD74QY1zgcvH/CZVMvSiZS6XmjdSYf+QXHYug0tlpvg1Kx6TmXT5IvBfGJ+6
         +m8CDAyS1BmbHvGt63jprFEuZ4BELxFdx05+fO7DqjU9qjbPQtrHDf8ygmLQ93vHVqSm
         8e1Ci+ob2grO0pOswfRkm9P0uJcQnTTOw52KFC5ZVle4fP1Ne7rEvvAksupcGBmWwkT5
         EqFaNVmCcIR+eKZ3wMR9+x3PxcDsYuL7FSwGF/Vm5DxHOHMW475utNbVwDCkuilUwm91
         x2MA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1789662530; x=1790267330; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qWVBYiAiVaUTItPwh8DxKhgx0WfrEial88iAt+y43m4=;
        b=Z5z8U6Ha+1tskuhhDL/zk42w7wMDMlHZe6tz4v1WUF0Llz91JBfAmJZwBbeiNQi9Cx
         7jLVOXrz2tGb2qoNJqPjdWWbIFRQwJ8Vzyegf5M5mpW6nzF5uXXx4kwQY58QzJqSJ1z9
         +RvwTdbJRYJ6vlh+uifk96j6PczOror5R1MVktDMb/0N2698cK0vrz+PwkIGGJw+uKM8
         chMJXfOo/no5vGd5Xn7pMaOuiIcGOhkvM9QEESgKC87CyOFo3gqLpz10F8N3xGJlQzQ9
         i3lQvG38oyZXB3aqdYIk5Ur5L56A3vsvw7cJPJc75vzaZu98jLme9xgrt4bMnA+hxMor
         xnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789662530; x=1790267330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWVBYiAiVaUTItPwh8DxKhgx0WfrEial88iAt+y43m4=;
        b=ajrsZCPBt5HeO4aIWMqzEF/W8L33QYzy0rk24JuzoGjIkqEAFE2j6w21GxWcS1krKH
         zVQ41Ta+Pb7CRT8JXLxOp9WJ/34CckUGN4DNsdwZ4hZ+Tf+oJB90TLnelX8/quG8ePEk
         RZtvN0556zHE4DojDqcq/VhEwOXDIJFDsZcP0iJ5sxErpzQPc4rlO7LTpbRYPx2mOsxC
         yk2F1aLJLST1MPojyCsSiVBlVrrloNcc/GyfILyPFb+sAB80QhCROQDpeJ6jOXS7piUD
         CNyxh4hib+D/KgAAd00GlJiMzoov6F0iqhLeTZ6la9hCWb28p5KnyKXsfGqxtxzrvLWT
         rVOw==
X-Gm-Message-State: AFuF++lmpOB8JltPzGxOqNC+yv1I9gekx+YpdOXkzkRei2kJgiI34f4P
	TPPiI8J6lyZLifsUX4Hu8A8LMNd9+FTn6J8wp4fgBcP4njefzX9IaztQtjKOvQjdQieH2w5wEGJ
	gzUzA9G/7MI5+bA2CkZyk4UekidAfn+vPxk9KQhexCw==
X-Gm-Gg: AYBFou0amST0oc9qBpqbsWBRi2BivhJej6+Zazlqo6eYO8q6F29/R56i9UL/J2rv5eQ
	a3GXM4nJhaeH3HKlAWf+byFuytEr+XiTknRKoM1Wx1/Qxwc1TTCo4Ro2GuZApJdlyvkaKjOUg51
	tjrgmPxoOeENwEzLq/J9hxpLugcmkxRRM+WqK4dakjs7GFaHiIHJ8apxUOwGURRbkOSqjXxZr0r
	dWvUFSXTqN9EFKvnqvl+GwQbRXnjunpLEFaQOFXj2lONDYor5mW+xb+3u3J2gqW7NgRDzHPS2jS
	mbRUm6PYLDGoqy36++JgxWkK/vovsnZL2GVq0Anj73SDG/njGdmisuLucQ==
X-Received: by 2002:a05:6512:10d2:b0:5b6:184c:7da8 with SMTP id
 2adb3069b0e04-5b8b665c220mr1995428e87.49.1789662529845; Thu, 17 Sep 2026
 09:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260904190825.79964-1-nkela@crusoe.ai> <TY1PR01MB10753FE96BBA5EEBCAF6F13DD84B82@TY1PR01MB10753.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB10753FE96BBA5EEBCAF6F13DD84B82@TY1PR01MB10753.jpnprd01.prod.outlook.com>
From: Nikunj Kela <nkela@crusoe.ai>
Date: Thu, 17 Sep 2026 09:28:38 -0700
X-Gm-Features: AcwNN1W1LtJT4bDJZuEbewUttGMAgd6gzSS9PzdmIUbczqPzqVltWZd4Yh4e51A
Message-ID: <CAP328seLmGJpSkecRK+U2n7pdSqp=QdwDr4RuX9XfT13-pZaRg@mail.gmail.com>
Subject: Re: [PATCH] Derive the mem_section mem_map mask from SIZE(page)
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <kazuhito.hagio@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	=?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>, 
	"bhe@redhat.com" <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_172852_800319_2132BD1E 
X-CRM114-Status: GOOD (  43.68  )
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

Hi Kazu,

Yes, that's fine. Please remove the "(see the BUG_ON ...)" when
merging. The point I wanted to capture was just that masking with
SECTION_MAP_MASK losslessly recovers the encoded mem_map (which that
check enforces), but the reference is more confusing than helpful,
especially now that it's a VM_WARN_ON_ONCE in
sparse_init_one_section(). Thanks for testing and picking this up.

Regards,
-Nikunj


On Thu, Sep 17, 2026 at 1:10=E2=80=AFAM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
<kazuhito.hagio@nec.com> wrote:
>
> Hi Nikunj,
>
> thank you for the patch.  sorry for my delay.
>
> (My email will be changed to this From address soon.)
>
> > -----Original Message-----
> > Linux 6.15 added a new mem_section flag bit, SECTION_IS_VMEMMAP_PREINIT
> > (commit "mm/sparse: allow for alternate vmemmap section init at boot",
> > Frank van der Linden), used on x86-64 to mark sections whose vmemmap
> > was pre-initialized at boot for HugeTLB Vmemmap Optimization (HVO).
> > With CONFIG_ZONE_DEVICE=3Dy this is bit 5, and SECTION_MAP_LAST_BIT in
> > the kernel moved to bit 6:
> >
> >     SECTION_MARKED_PRESENT_BIT,      /* 0 */
> >     SECTION_HAS_MEM_MAP_BIT,         /* 1 */
> >     SECTION_IS_ONLINE_BIT,           /* 2 */
> >     SECTION_IS_EARLY_BIT,            /* 3 */
> >     SECTION_TAINT_ZONE_DEVICE_BIT,   /* 4 */
> >     SECTION_IS_VMEMMAP_PREINIT_BIT,  /* 5 */
> >     SECTION_MAP_LAST_BIT,            /* 6 */
> >
> > makedumpfile still defines SECTION_MAP_LAST_BIT as 1UL<<5, so
> > SECTION_MAP_MASK is ~0x1f and bit 5 survives when section_mem_map is
> > decoded in section_mem_map_addr().  For every section that has
> > SECTION_IS_VMEMMAP_PREINIT set, the resulting mem_map address is off
> > by 0x20 -- half a struct page on 64-bit.  All struct page fields read
> > from those sections are misaligned (page.flags reads page.index,
> > page._mapcount reads the next page's lru.prev, ...), no exclusion
> > filter matches, and the pages are kept as "dumpable kernel data".
> > Nothing is reported, because the bogus address still passes
> > is_kvaddr().
> >
> > The kernel sets this flag on every section backing a boot-time
> > gigantic hugetlb page when HVO is enabled (hugetlb_vmemmap_init_early()=
).
> > On the hosts with lot of hugepages reserved at boot-time, the core size
> > grows significantly. It increase the time taken to generate the core as
> > as the disk space needed to store it.
> >
> > Signed-off-by: Nikunj Kela <nkela@crusoe.ai>
> > ---
> > Tested:
> >   - x86-64, Linux 6.17.13 (SPARSEMEM_VMEMMAP_PREINIT=3Dy, ZONE_DEVICE=
=3Dy),
> >     1470 x 1 GiB hugepages, HVO enabled
> >   - arm64, Linux 6.11, 512 MiB hugepages, HVO not enabled
> >   - No 32-bit target available; the 32-bit case is a provable no-op
> >     since mask is unchanged
> >
> >  makedumpfile.c | 16 +++++++++++++++-
> >  makedumpfile.h |  5 +++++
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index ba01137..be885f3 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -3705,7 +3705,21 @@ section_mem_map_addr(unsigned long addr, unsigne=
d long *map_mask)
> >               return NOT_KV_ADDR;
> >       }
> >       map =3D ULONG(mem_section + OFFSET(mem_section.section_mem_map));
> > -     mask =3D SECTION_MAP_MASK;
> > +     /*
> > +      * The encoded mem_map is struct page pointer arithmetic, so it i=
s
> > +      * always SIZE(page)-aligned, and the kernel guarantees that all
> > +      * section flag bits fit below that alignment (see the BUG_ON in
> > +      * sparse_encode_mem_map()).  Derive the mask from SIZE(page) ins=
tead
>
> The whole patch looks good to me and tested ok, but does the BUG_ON says
> about the relation to that alignment?
>
>   BUG_ON(coded_mem_map & ~SECTION_MAP_MASK);
>
> (currently this is in sparse_init_one_section() as VM_WARN_ON_ONCE though=
.)
>
> This seems that all section flag bits fit below SECTION_MAP_LAST_BIT, not=
 the
> alignment.  Is it ok to remove the "(see the BUG_ON ...)" to avoid confus=
ion?
> If it's ok, I'll remove it when merging.
>
> Thanks,
> Kazu
>
> > +      * of hardcoding the number of flag bits, which changed in Linux =
4.13,
> > +      * 5.x and again in 6.15 (SECTION_IS_VMEMMAP_PREINIT, bit 5 with
> > +      * CONFIG_ZONE_DEVICE), and fall back to SECTION_MAP_MASK if SIZE=
(page)
> > +      * is unknown or not a power of two.
> > +      */
> > +     if (SIZE(page) !=3D NOT_FOUND_STRUCTURE && SIZE(page) > 0
> > +         && !(SIZE(page) & (SIZE(page) - 1)))
> > +             mask =3D ~((unsigned long)SIZE(page) - 1);
> > +     else
> > +             mask =3D SECTION_MAP_MASK;
> >       *map_mask =3D map & ~mask;
> >       map &=3D mask;
> >       free(mem_section);
> > diff --git a/makedumpfile.h b/makedumpfile.h
> > index c4f3614..e2ab034 100644
> > --- a/makedumpfile.h
> > +++ b/makedumpfile.h
> > @@ -195,6 +195,11 @@ test_bit(int nr, unsigned long addr)
> >   *     version 4.12,
> >   *  2. it has been verified that (1UL<<2) was never set, so it is
> >   *     safe to mask that bit off even in old kernels.
> > + *  3. since Linux 6.15 (SECTION_IS_VMEMMAP_PREINIT, bit 5 with
> > + *     CONFIG_ZONE_DEVICE) there are six flag bits, so this value is
> > + *     stale; section_mem_map_addr() derives the real mask from
> > + *     SIZE(page) and only falls back to SECTION_MAP_MASK when that
> > + *     is not possible.
> >   */
> >  #define SECTION_MAP_LAST_BIT (1UL<<5)
> >  #define SECTION_MAP_MASK     (~(SECTION_MAP_LAST_BIT-1))
> > --
> > 2.54.0


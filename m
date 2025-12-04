Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E4FD216B6
	for <kexec@archiver.kernel.org>; Thu,  4 Dec 2025 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=neM2aFFGXkdhFk1Bgngnbt+CCpd3u3ncCxbfP639ydc=; b=u3HgPhdV3qFeh/jpSslZwwUH7K
	IbL738nIcX/PJyYPU3EQUG32S45WV++QBEcP3OFX7SCJh4xwIvd1LaJpf2UQUXK/zZ54rHyhvKRBe
	ug0DDdn/3DUFrvCGkVIfl13AcFNVPgxMZ3t6lGuX3vLSgOGFN5uF4FcvqntUTyXJMb86ZhQe5t4u5
	4lQSOn28RBzEyfWGpfeQSuDAUNSxZXpeUdodIv8B/chMfF3DK6QhD0dyTe7xasm7wXEN2030WflqS
	HeG0KZ7127mCkbMabwg0yGxoOZL2F52QMc9XepQjKW+3z3c/lDCKObAjaOue7BzVNbKDm2or1Lmw/
	7T5JtULg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRCMH-00000008IcH-101f;
	Thu, 04 Dec 2025 16:39:09 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRCME-00000008IbR-3qK2
	for kexec@lists.infradead.org;
	Thu, 04 Dec 2025 16:39:08 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-42e2e40582eso709101f8f.1
        for <kexec@lists.infradead.org>; Thu, 04 Dec 2025 08:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764866345; x=1765471145; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neM2aFFGXkdhFk1Bgngnbt+CCpd3u3ncCxbfP639ydc=;
        b=iS7DwQTcFtxtw6ToUNxcZm7KO/y1V9OYyQbffKz4xRZ7xQ0VcgPBuvyY+Rh6OkW4of
         Gr8lNPiPp0MynMsdFRLcgiIBJG1rDe18i/W9jXEG18FLXO2zXEP4jwLnrkoyz8uqo8sn
         PQFKiv2/uy7j9wqfBTfhEcmUVPXWYhFiOaH6yNACwF3reFQugHyYykyABOhZrSagG/oF
         V8DBIJ1D+j76HYzSJjETX8Es2NIsdJd4MeNYECWksfHEvnH+mlOhTcCAY1VdfoGVmez5
         ZkWkAE7VPUHPgA5/mYjmporRdew7lNtaQhPN/WN0bb2W43rjCpmAJI2LojPZwbflPuzr
         rZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764866345; x=1765471145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=neM2aFFGXkdhFk1Bgngnbt+CCpd3u3ncCxbfP639ydc=;
        b=LC6HYXccQpoaCPl8QGu43hUe1UeSTAUbcbsCFE1lWG2Z0q/LarFMyuSmJAr6Yo85ji
         t/8rnr1TyupAMeN/pmu2uq4YyBXC3caEGXvdQol2WzzWeKyKbmGiVeiL9iHmFmPaP/K9
         V3IoO7XOdZf7EQbLoxb/vRtH8WqUhSGgUisCveN2D+tywDJ4pGo8hd+UPeLxKrPHqofj
         s9lpEPV4EX2B0aApYjKx0jn/531OQzp7cFBS5xUV/+RKnnarfJQ0xLQsPwkrNfi1Y4nN
         kmfCjyS9w9M/WdpRbAcLa4A55DW+avVqiK9+GsSRfw13RgBcwX2AFa5rhCtmeda9SCed
         KvFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+STDUGc7QWrJgIYT20vUzEVvS5KBu6hEY3k2E5p3x2169f9XFMbdc6hTAIFfxuHwSM2A5mw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1Cl1hgP/1k5zIr19B8WTaWf3pO+6psoU+w2cHpzEXTIh735qD
	TwzGcdfhxl+roVAjEtA39DpOqiCl7XG/eJWkrZXBS7XPKAy1zQsQEWoWMfjjuZw8XnBTVtfVAeh
	fFs6GKmA4iXo2dKtRfykWKyWkalPK50E=
X-Gm-Gg: ASbGncspw+W0MpFD4jkZILhMR6Ae7Qgz3YYyf8HeCJzN0rXtjB09dACS8oXHefw2pSm
	1V0LIhCaaYwewE6CAd/ELsqYza6qgYnzZrrBKeQY/1YTvngNXJ8ZUhvOxhQ0GS0JMrzWHVojOkE
	7XMFYhbBIjOAOQr7qWlaeuCOBrs4Ww7AFTVmAJzUpCZiwZjmyYUZUYCbQILcYS88//oR4tcPT/v
	7vcXWEaRCPNdMp1ruZOgwqa0bcj/Dicpjk2vwAOEygkBDSX6vABkJprc8E8zE4aMuGgUMYZXdrF
	clRcja3xMJbCQtNu8mRuIf93CFxhnuPavvruXFs=
X-Google-Smtp-Source: AGHT+IHoodyyNldCFLAHSL99GtNDC0mgxYwiy2LhCAjNxaLnR0UmBgujNCAg0JZR/0N90Dq070py5kyBptf8+EpoBYw=
X-Received: by 2002:a5d:5f84:0:b0:42c:a449:d6ab with SMTP id
 ffacd0b85a97d-42f7984151bmr3587206f8f.30.1764866344934; Thu, 04 Dec 2025
 08:39:04 -0800 (PST)
MIME-Version: 1.0
References: <20251128033320.1349620-1-bhe@redhat.com> <20251128033320.1349620-2-bhe@redhat.com>
In-Reply-To: <20251128033320.1349620-2-bhe@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 4 Dec 2025 17:38:54 +0100
X-Gm-Features: AWmQ_bkK3QIZDgXBUmjiM3wqIjjTq9eL1_nc5mEHts5eDeieA_K5fYtO6D27Mp0
Message-ID: <CA+fCnZfDYHUVKX-hdX3SgmuvJEU-U+MuUJGjs-wJJnfRDHz2sw@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] mm/kasan: add conditional checks in functions to
 return directly if kasan is disabled
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, elver@google.com, sj@kernel.org, 
	lorenzo.stoakes@oracle.com, snovitoll@gmail.com, christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_083906_995084_D9DECBDF 
X-CRM114-Status: GOOD (  24.94  )
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

On Fri, Nov 28, 2025 at 4:33=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> The current codes only check if kasan is disabled for hw_tags
> mode. Here add the conditional checks for functional functions of
> generic mode and sw_tags mode.
>
> This is prepared for later adding kernel parameter kasan=3Don|off for
> all three kasan modes.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/kasan/generic.c    | 17 +++++++++++++++--
>  mm/kasan/init.c       |  6 ++++++
>  mm/kasan/quarantine.c |  3 +++
>  mm/kasan/report.c     |  4 +++-
>  mm/kasan/shadow.c     | 11 ++++++++++-
>  mm/kasan/sw_tags.c    |  3 +++
>  6 files changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 2b8e73f5f6a7..aff822aa2bd6 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -214,12 +214,13 @@ bool kasan_byte_accessible(const void *addr)
>
>  void kasan_cache_shrink(struct kmem_cache *cache)
>  {
> -       kasan_quarantine_remove_cache(cache);
> +       if (kasan_enabled())

Please move these checks to include/linux/kasan.h and add __helpers to
consistent with how it's done for other KASAN annotation calls.
Otherwise eventually these checks start creeping into lower level
functions and the logic of checking when and whether KASAN is enabled
becomes a mess.



> +               kasan_quarantine_remove_cache(cache);
>  }
>
>  void kasan_cache_shutdown(struct kmem_cache *cache)
>  {
> -       if (!__kmem_cache_empty(cache))
> +       if (kasan_enabled() && !__kmem_cache_empty(cache))
>                 kasan_quarantine_remove_cache(cache);
>  }
>
> @@ -239,6 +240,9 @@ void __asan_register_globals(void *ptr, ssize_t size)
>         int i;
>         struct kasan_global *globals =3D ptr;
>
> +       if (!kasan_enabled())
> +               return;
> +
>         for (i =3D 0; i < size; i++)
>                 register_global(&globals[i]);
>  }
> @@ -369,6 +373,9 @@ void kasan_cache_create(struct kmem_cache *cache, uns=
igned int *size,
>         unsigned int rem_free_meta_size;
>         unsigned int orig_alloc_meta_offset;
>
> +       if (!kasan_enabled())
> +               return;
> +
>         if (!kasan_requires_meta())
>                 return;
>
> @@ -518,6 +525,9 @@ size_t kasan_metadata_size(struct kmem_cache *cache, =
bool in_object)
>  {
>         struct kasan_cache *info =3D &cache->kasan_info;
>
> +       if (!kasan_enabled())
> +               return 0;
> +
>         if (!kasan_requires_meta())
>                 return 0;
>
> @@ -543,6 +553,9 @@ void kasan_record_aux_stack(void *addr)
>         struct kasan_alloc_meta *alloc_meta;
>         void *object;
>
> +       if (!kasan_enabled())
> +               return;
> +
>         if (is_kfence_address(addr) || !slab)
>                 return;
>
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index f084e7a5df1e..c78d77ed47bc 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -447,6 +447,9 @@ void kasan_remove_zero_shadow(void *start, unsigned l=
ong size)
>         unsigned long addr, end, next;
>         pgd_t *pgd;
>
> +       if (!kasan_enabled())
> +               return;
> +
>         addr =3D (unsigned long)kasan_mem_to_shadow(start);
>         end =3D addr + (size >> KASAN_SHADOW_SCALE_SHIFT);
>
> @@ -482,6 +485,9 @@ int kasan_add_zero_shadow(void *start, unsigned long =
size)
>         int ret;
>         void *shadow_start, *shadow_end;
>
> +       if (!kasan_enabled())
> +               return 0;
> +
>         shadow_start =3D kasan_mem_to_shadow(start);
>         shadow_end =3D shadow_start + (size >> KASAN_SHADOW_SCALE_SHIFT);
>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 6958aa713c67..a6dc2c3d8a15 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -405,6 +405,9 @@ static int __init kasan_cpu_quarantine_init(void)
>  {
>         int ret =3D 0;
>
> +       if (!kasan_enabled())
> +               return 0;
> +
>         ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mm/kasan:online",
>                                 kasan_cpu_online, kasan_cpu_offline);
>         if (ret < 0)
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 62c01b4527eb..884357fa74ed 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -576,7 +576,9 @@ bool kasan_report(const void *addr, size_t size, bool=
 is_write,
>         unsigned long irq_flags;
>         struct kasan_report_info info;
>
> -       if (unlikely(report_suppressed_sw()) || unlikely(!report_enabled(=
))) {
> +       if (unlikely(report_suppressed_sw()) ||
> +           unlikely(!report_enabled()) ||
> +           !kasan_enabled()) {
>                 ret =3D false;
>                 goto out;
>         }
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 29a751a8a08d..f73a691421de 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -164,6 +164,8 @@ void kasan_unpoison(const void *addr, size_t size, bo=
ol init)
>  {
>         u8 tag =3D get_tag(addr);
>
> +       if (!kasan_enabled())
> +               return;
>         /*
>          * Perform shadow offset calculation based on untagged address, a=
s
>          * some of the callers (e.g. kasan_unpoison_new_object) pass tagg=
ed
> @@ -277,7 +279,8 @@ static int __meminit kasan_mem_notifier(struct notifi=
er_block *nb,
>
>  static int __init kasan_memhotplug_init(void)
>  {
> -       hotplug_memory_notifier(kasan_mem_notifier, DEFAULT_CALLBACK_PRI)=
;
> +       if (kasan_enabled())
> +               hotplug_memory_notifier(kasan_mem_notifier, DEFAULT_CALLB=
ACK_PRI);
>
>         return 0;
>  }
> @@ -658,6 +661,9 @@ int kasan_alloc_module_shadow(void *addr, size_t size=
, gfp_t gfp_mask)
>         size_t shadow_size;
>         unsigned long shadow_start;
>
> +       if (!kasan_enabled())
> +               return 0;
> +
>         shadow_start =3D (unsigned long)kasan_mem_to_shadow(addr);
>         scaled_size =3D (size + KASAN_GRANULE_SIZE - 1) >>
>                                 KASAN_SHADOW_SCALE_SHIFT;
> @@ -694,6 +700,9 @@ int kasan_alloc_module_shadow(void *addr, size_t size=
, gfp_t gfp_mask)
>
>  void kasan_free_module_shadow(const struct vm_struct *vm)
>  {
> +       if (!kasan_enabled())
> +               return;
> +
>         if (IS_ENABLED(CONFIG_UML))
>                 return;
>
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index c75741a74602..6c1caec4261a 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -79,6 +79,9 @@ bool kasan_check_range(const void *addr, size_t size, b=
ool write,
>         u8 *shadow_first, *shadow_last, *shadow;
>         void *untagged_addr;
>
> +       if (!kasan_enabled())
> +               return true;
> +
>         if (unlikely(size =3D=3D 0))
>                 return true;
>
> --
> 2.41.0
>


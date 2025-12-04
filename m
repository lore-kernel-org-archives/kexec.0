Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D56D216B2
	for <kexec@archiver.kernel.org>; Thu,  4 Dec 2025 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hCk7JgdAPLLkYhpcS4mPpcBCsA+/FaiQTCAUq224jgk=; b=n/nCwEmIMFuINFjUNBXTtAr4Kj
	pk8wzqH1e0n/UMs0/1odaCK5nVzXAOjK2eWpif/ZRMfXsYMhg/ZsF50j6ZSukA/RFlQP9VeqigE0O
	/azQQCngV0IMpJWd5eYWSl3dOemSWVlAAaa3d/Hb3dwePydIlp2oLAVTdEX/kFfCFBgr33O4Y/Onf
	kkexepk96jumpd4T9s8DK62Ml9tW5v3izJCNmT1N5clR5d9FHD8ksGBfOv0xiJwmCbUYO90COomYt
	5DL70ulWt5phl/OkEixn61mFTDL8kyy6BJmXfr/qD1HtLwj4GXHLBOSiKyyuQDoEWSftV2vYFiYhW
	c14QOOJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRCMX-00000008IiB-3Bya;
	Thu, 04 Dec 2025 16:39:25 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRCMU-00000008Ih2-30eX
	for kexec@lists.infradead.org;
	Thu, 04 Dec 2025 16:39:23 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso755158f8f.2
        for <kexec@lists.infradead.org>; Thu, 04 Dec 2025 08:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764866361; x=1765471161; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCk7JgdAPLLkYhpcS4mPpcBCsA+/FaiQTCAUq224jgk=;
        b=b83QztQSpr2uppWVRtfdIzbQQ1EYOKkw3YL0HTS9jph87Wkge9UBrLfOdEATL/lKII
         /E4KtupFtyEICAdqOl/Nr/McGD0Co+f5QAR34Q3UNGbAjcja0Lm3UCK/uv7/ciQR4AjO
         o/o3I1K5FBWNJevu1FZqoFZGLrN/Xzn3pAMjPdNAdJuQMB/8zKHAqR0Ma78MPGGe0bZr
         ci+TEFqUTFBqNxe2wpLrszxs1/UkRsfa4pGTNGYnNBE2l83P8oMlxXHLZj268E1DaC+A
         sZ18boedBzz+4+Ve0MvqojxYPODQi0ymla1xVCbhAGqmmWEnR91mYqKt7HpY3siORS3n
         Unig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764866361; x=1765471161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hCk7JgdAPLLkYhpcS4mPpcBCsA+/FaiQTCAUq224jgk=;
        b=gVePPC6o6eaH8KSKxEpFSG4U+11N8sHoAy2uZVsnE66Y00WbKGV9TSZAK09vftoBr+
         gFIrpBXbfSjJYBa5mAB/hyYwgQJD2RENhmvzAIuRqQv9/KAH7YJcz0GNkIO32g6slW1F
         ZTDNT50tAxYTHxaP0C1Q1Lo4adtHDR/VW3yntfWf8hcU9Zg1/AYTqH2ULuorUuG99g2Q
         7Sc419VbmRIfvWvvgzsOUv7/uaZcl9JvQ5qQWukPTw80t3hyWr7CpD/uvRVgU/AJ45uH
         klSSSHR52MfHDN29jylquAbc5OpNR22wjyEQdkqoHSXGw+uv7c4k159QEw+PoymytVEm
         oqpw==
X-Forwarded-Encrypted: i=1; AJvYcCUNGOyf+/ufIHn8zpIsrggsfVVS4n/4NLCG6R/iq0+I3BXqnWPMzsUCyoankoEib15X3aPgVw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwYSwDV3uDGBW23SsJQofo9O5vKEsgk8G5rO1A33wwDF5gGWz5N
	Ug64lb0YbBmIUTc600RwTpCibNwodltphYHGxGZMtEtYEC6iYGRFZus2SLhxj1wqx0OK83YqKye
	AdA4v752AtcHU7MXN/XVpvJPHxwRMlBY=
X-Gm-Gg: ASbGncstgETa+2pWSR7/hZlrYM3szkCDK92GnjLx8EPVNv7/yHpNYR44a4Z8cUhlT9d
	qePEjri7pHXbt78lUMqfxLd1MKlfBFzdixRMtGztuEGQdsQkkYotfvtPCveGLDx9kD2lUcE6HX+
	2FtryOeR6cowwmZa5W5iELQy1QTB7MGUghnnCWioLwZQS7AFTRQ7ynrcUITeJeDFs6n+uN1b6Y5
	4AoRsiYO9wpGyRSIWfomXax5B+AMKh00f+f/0ARLaZq3gzfFX6fgnT84Rx4V9xRLkygUqEMpKfH
	0Meb2ImUy9lW6vTFwTHqj4uMcglGyyhOEqCVKCI=
X-Google-Smtp-Source: AGHT+IH6eC+G7DJcYKZysz/wZNnhwLWNXumkT56cpPFdLUowfZ815U1Yxtr7meerF2BouQRmu9P8dfyDE5ZnzXmcl3E=
X-Received: by 2002:a05:6000:2c0c:b0:429:d186:8c49 with SMTP id
 ffacd0b85a97d-42f731bcd25mr6805868f8f.56.1764866360830; Thu, 04 Dec 2025
 08:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20251128033320.1349620-1-bhe@redhat.com> <20251128033320.1349620-3-bhe@redhat.com>
In-Reply-To: <20251128033320.1349620-3-bhe@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 4 Dec 2025 17:39:10 +0100
X-Gm-Features: AWmQ_blUh_06nghjvNtkMSFLLH4KmVbjTWIqXM8ANs1LK16keDIndnTKt6SV0Qo
Message-ID: <CA+fCnZeHZ4+8GOn0untumM0TE9TeSHqja9kAsbEb-+jbEFNQQQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] mm/kasan: move kasan= code to common place
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, elver@google.com, sj@kernel.org, 
	lorenzo.stoakes@oracle.com, snovitoll@gmail.com, christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_083922_782057_349D235F 
X-CRM114-Status: GOOD (  25.56  )
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
> This allows generic and sw_tags to be set in kernel cmdline too.
>
> When at it, rename 'kasan_arg' to 'kasan_arg_disabled' as a bool
> variable. And expose 'kasan_flag_enabled' to kasan common place
> too.

This asks to be two separate patches.

>
> This is prepared for later adding kernel parameter kasan=3Don|off for
> all three kasan modes.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/kasan-enabled.h |  4 +++-
>  mm/kasan/common.c             | 20 ++++++++++++++++++--
>  mm/kasan/hw_tags.c            | 28 ++--------------------------
>  3 files changed, 23 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.=
h
> index 9eca967d8526..b05ec6329fbe 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -4,13 +4,15 @@
>
>  #include <linux/static_key.h>
>
> -#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)

These changes of moving/removing CONFIG_ARCH_DEFER_KASAN also seem to
belong to a separate patch (or should be combined with patch 12?); the
commit message does not even mention them.

> +extern bool kasan_arg_disabled;
> +
>  /*
>   * Global runtime flag for KASAN modes that need runtime control.
>   * Used by ARCH_DEFER_KASAN architectures and HW_TAGS mode.
>   */
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);

So kasan_flag_enabled is now always exposed here...

>
> +#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)

but the functions that use it are not. Why?


>  /*
>   * Runtime control for shadow memory initialization or HW_TAGS mode.
>   * Uses static key for architectures that need deferred KASAN or HW_TAGS=
.
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 1d27f1bd260b..ac14956986ee 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -32,14 +32,30 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> -#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
>  /*
>   * Definition of the unified static key declared in kasan-enabled.h.
>   * This provides consistent runtime enable/disable across KASAN modes.
>   */
>  DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
>  EXPORT_SYMBOL_GPL(kasan_flag_enabled);
> -#endif
> +
> +bool kasan_arg_disabled __ro_after_init;
> +/* kasan=3Doff/on */
> +static int __init early_kasan_flag(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       if (!strcmp(arg, "off"))
> +               kasan_arg_disabled =3D true;
> +       else if (!strcmp(arg, "on"))
> +               kasan_arg_disabled =3D false;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +early_param("kasan", early_kasan_flag);
>
>  struct slab *kasan_addr_to_slab(const void *addr)
>  {
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 1c373cc4b3fa..709c91abc1b1 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -22,12 +22,6 @@
>
>  #include "kasan.h"
>
> -enum kasan_arg {
> -       KASAN_ARG_DEFAULT,
> -       KASAN_ARG_OFF,
> -       KASAN_ARG_ON,
> -};
> -
>  enum kasan_arg_mode {
>         KASAN_ARG_MODE_DEFAULT,
>         KASAN_ARG_MODE_SYNC,
> @@ -41,7 +35,6 @@ enum kasan_arg_vmalloc {
>         KASAN_ARG_VMALLOC_ON,
>  };
>
> -static enum kasan_arg kasan_arg __ro_after_init;
>  static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
>  static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
>
> @@ -81,23 +74,6 @@ unsigned int kasan_page_alloc_sample_order =3D PAGE_AL=
LOC_SAMPLE_ORDER_DEFAULT;
>
>  DEFINE_PER_CPU(long, kasan_page_alloc_skip);
>
> -/* kasan=3Doff/on */
> -static int __init early_kasan_flag(char *arg)
> -{
> -       if (!arg)
> -               return -EINVAL;
> -
> -       if (!strcmp(arg, "off"))
> -               kasan_arg =3D KASAN_ARG_OFF;
> -       else if (!strcmp(arg, "on"))
> -               kasan_arg =3D KASAN_ARG_ON;
> -       else
> -               return -EINVAL;
> -
> -       return 0;
> -}
> -early_param("kasan", early_kasan_flag);
> -
>  /* kasan.mode=3Dsync/async/asymm */
>  static int __init early_kasan_mode(char *arg)
>  {
> @@ -222,7 +198,7 @@ void kasan_init_hw_tags_cpu(void)
>          * When this function is called, kasan_flag_enabled is not yet
>          * set by kasan_init_hw_tags(). Thus, check kasan_arg instead.
>          */
> -       if (kasan_arg =3D=3D KASAN_ARG_OFF)
> +       if (kasan_arg_disabled)
>                 return;
>
>         /*
> @@ -240,7 +216,7 @@ void __init kasan_init_hw_tags(void)
>                 return;
>
>         /* If KASAN is disabled via command line, don't initialize it. */
> -       if (kasan_arg =3D=3D KASAN_ARG_OFF)
> +       if (kasan_arg_disabled)
>                 return;
>
>         switch (kasan_arg_mode) {
> --
> 2.41.0
>


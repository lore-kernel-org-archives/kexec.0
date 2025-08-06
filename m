Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71056C87FD1
	for <kexec@archiver.kernel.org>; Wed,  6 Aug 2025 07:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CIQROcvGNDvP322fenFV06FYLfCBAUlOFBfGGGTH+sk=; b=VgJyHud4xwh6zp1RDb9vI/t/+N
	Jz6C3kSNQhhC56FYN5+GiK8OhmhcghYszvO7Am3Kpb69tZW5XJWlALf/frURIvaHCCkocbhJ9Q0ZY
	HNKrqmQLCYQoq0jIW5jdU6i/LJ+izp5i1zYcQiVz+ZqRwXTYuZm24sZLPrXKZOGgQ5V4sWwPn6ZRX
	mNUFyQD4Ojq8nRWlxJ0ywKh1SYlVwg2jlySLczDR7UMUPY49dT5apf1mORa9nNg/AiQO2UGVZlFcB
	d8V5DkIzWl1dbnQGoew3YvvuqEPOUV3CL+V0HJedRbhaXKBeyVAbchmn04PywuXedAhPUmJCoBLet
	FBuCALCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujYSS-0000000EV2U-49PR;
	Wed, 06 Aug 2025 07:21:08 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujYJL-0000000EU4L-1nsp
	for kexec@lists.infradead.org;
	Wed, 06 Aug 2025 07:11:44 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-b3220c39cffso5074608a12.0
        for <kexec@lists.infradead.org>; Wed, 06 Aug 2025 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754464302; x=1755069102; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CIQROcvGNDvP322fenFV06FYLfCBAUlOFBfGGGTH+sk=;
        b=iDXEgGVGuoD04mG5sjYpgHRaHFy/RwE6FinDZT5d5djCTAxWOeIWe6uFeN6xclKyer
         ugNJ86CvGTpTOKDQbFhIHy7uYMQ0DfiW5qOEV+rUORGY4DLJyDlC2QmY/o638Ux0oK28
         m13QlpSOWqhsUvGjL4rvtKcHsUN4vNz3L+H47wzzW/8B6T+MDp68FsuH3cWeEQ9cnNWF
         nabyNw9vC2slEPPWzuN1kH5f9Jl+lqyRGMwEpx7Xt20C2mf1447M4iPCyT/Kyh2ysoHg
         AjGTGv19f6d79I17OSk0ZRVfkwQXsbFnnzWxvoRaxa5NB+8+GfhXoCBEO8RXoEw9j6ZM
         DB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754464302; x=1755069102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIQROcvGNDvP322fenFV06FYLfCBAUlOFBfGGGTH+sk=;
        b=rq/YJ0G1YaDyfkQCTv/V8zrLyFny0wmmWrKZk8VDZhXvpSXoUWU4YFWFZIFcGyBc0r
         hNW/SUCnwAW6c646g9VJHVi62jEoHeTgwxPDzRxPYrmTOExa+2eumifso8WJzM7OSvRB
         GOUB67TLHH46RJ0KRL8glZK3zny1UEdXF2eyo7DOJh6ddLzt2hmtXw3a+wZqdrtNmJ4/
         zBVmFJnXzQqlXFpYW1+zD6ISv4ZlyUfprr/O9Ac/h4p4KQOgPtGtm5glVyAFgLfCsVgR
         Xx7/H4mMl51dl8l62N9PniktlrMZOXjDhhFpDRXSFfNCmEgeM9rx+dr8GFaacYMJh6sM
         d6EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYvZB2c4PsYN9luKjdUZaP+F3U7sbFclJSILr17kiPSsDUH21j2sDgOINcy00A+issNJYCJw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwF+JU49IdmqlhRplZbInT6BgrlwU+SYSH1vjxm3liJxPl6VAM7
	nzA8XzTTlFgILwQwoOe5rWCW/rtpzNLTMz4ylbbvJawLHIiTR320392HoQ3UzQPrCKbPyVLbob8
	mae1qh6WnJX6Ko20OAteABVK725lIyCb7t0hh9m6c
X-Gm-Gg: ASbGncskGnmn3+tc7A0RdqW1pK86DmM2F7XlSgWqiMtW9swSVBAYdv7q+fSpY1u8tR0
	N464Hfnr8FkZF0gst3QYIqqK06dlXTDKKasa51Ptk1uHYgepJCSm/VxV5tB92i8faKSTXtDmffO
	aeNyj8icv3A2cgH8ClCIiUGiKdIIbBq6VxMD/o+Fuip6z4xfsmFkDp5Ima5ksbW/PUWHxZf+0OL
	utItJ/kRKP10j39eY/7kry2Ts5LHe8MBEGNEiY=
X-Google-Smtp-Source: AGHT+IH4eNRLMKya/4o32tlSQWOb3//29rbV7XojFN8jVRMxJhB+5q+ILE/Mwm5nN4R+52ElrJ7C6Z2zf+YQwxTewsE=
X-Received: by 2002:a17:903:3c6b:b0:240:3bb7:fdc3 with SMTP id
 d9443c01a7336-242a0b6eac4mr17702345ad.28.1754464301762; Wed, 06 Aug 2025
 00:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250805062333.121553-1-bhe@redhat.com> <20250805062333.121553-3-bhe@redhat.com>
In-Reply-To: <20250805062333.121553-3-bhe@redhat.com>
From: Marco Elver <elver@google.com>
Date: Wed, 6 Aug 2025 09:11:05 +0200
X-Gm-Features: Ac12FXwvxDclvgbX00BaC4VbF0Z298SA2kuazPxeIBtYynYYBydJBukUdCOs9jk
Message-ID: <CANpmjNNr7e6DXQrZva8k46jELr1JSkjExWvQOyrkY5VD8mOadw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/kasan: move kasan= code to common place
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	akpm@linux-foundation.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_001143_483513_4C81D8E8 
X-CRM114-Status: GOOD (  18.91  )
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

On Tue, 5 Aug 2025 at 08:24, 'Baoquan He' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> This allows generic and sw_tags to be set in kernel cmdline too.
>
> When at it, rename 'kasan_arg' to 'kasan_arg_disabled' as a bool
> variable. And expose 'kasan_flag_enabled' to kasan common place
> too.
>
> This is prepared for later adding kernel parameter kasan=on|off for
> all kasan modes.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/kasan-enabled.h |  4 +++-
>  mm/kasan/common.c             | 27 +++++++++++++++++++++++++++
>  mm/kasan/hw_tags.c            | 35 ++---------------------------------
>  3 files changed, 32 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> index 6f612d69ea0c..32f2d19f599f 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -4,10 +4,12 @@
>
>  #include <linux/static_key.h>
>
> -#ifdef CONFIG_KASAN_HW_TAGS
> +extern bool kasan_arg_disabled;
>
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>
> +#ifdef CONFIG_KASAN_HW_TAGS
> +
>  static __always_inline bool kasan_enabled(void)
>  {
>         return static_branch_likely(&kasan_flag_enabled);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index ed4873e18c75..fe6937654203 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -32,6 +32,33 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> +/*
> + * Whether KASAN is enabled at all.
> + * The value remains false until KASAN is initialized.
> + */
> +DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> +EXPORT_SYMBOL(kasan_flag_enabled);
> +
> +bool kasan_arg_disabled;

You lost __ro_after_init

> +/* kasan=off/on */
> +static int __init early_kasan_flag(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       if (!strcmp(arg, "off"))
> +               kasan_arg_disabled = true;
> +       else if (!strcmp(arg, "on"))
> +               kasan_arg_disabled = false;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +early_param("kasan", early_kasan_flag);
> +
> +
> +

Why extra blank lines?


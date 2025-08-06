Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CA5C87FD3
	for <kexec@archiver.kernel.org>; Wed,  6 Aug 2025 18:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jzfnt4fl4r2JAvr3EQAhX7jF93WfuTFzsNkMkN0wipE=; b=FPMdl/OT/myLV4GeVREL85S7Wa
	HKvWa2nK2DId6CP8eygpLBG1I49KJbLWtHlyWDIJxIvHCpwg52I19jkgbqZR5xf2XbOKKWitxR8I1
	zXLmgQ65uvlGrE9o+H+iGzH4CT+mT9e7QeKb37DHD90JgPG4lLU2XV375ocLk2uTbWqs2lVBA4nUC
	B9lRST1PZzuyqLIoUQZ2WCOHrtu0pNMqtGfDqKXK2Uq4Pnpz+6LIVzggkHJtnmShvMmDamC0L/oVt
	ta/8iZJtluQ4jZ5lWg4XFMXGPda5CeAQs59sbYuenBV7De4YGQfOQlcLpUJUdtFof5i9PodVK1fYt
	sWdDbEAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujj0o-0000000G5eP-1mFK;
	Wed, 06 Aug 2025 18:37:18 +0000
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujioi-0000000G3o7-1H4S
	for kexec@lists.infradead.org;
	Wed, 06 Aug 2025 18:24:49 +0000
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-55b93104888so208302e87.1
        for <kexec@lists.infradead.org>; Wed, 06 Aug 2025 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754504686; x=1755109486; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jzfnt4fl4r2JAvr3EQAhX7jF93WfuTFzsNkMkN0wipE=;
        b=JyPw0rT5P5wEaEZrYdIJE+5BJnv3VxQFLRNIOdsI+eScdDXi2v8bado42v4O5dlAFe
         fNyiQTmsGj0uqOE4PEYdx5uiliL9aN9a49NAJKd7GVcdaVPM8msnszzWQ2v5mwZrRgdX
         wEIC97jgjNiVx2fw7Z1yZlLDGGBSeFx57wW28vnqTIwy7nQz6KTbNu7actiYvLAC/bUy
         aKsQdZKZcCVMV5tUoBCWFdT1yScGCbJTz5RNJpEm4aFVZVIiSBS1K3eAJN3KSqldk7Ne
         jaut81tIteMgN/BmNbEIyn6G5nhMlzcv5YIAzFYIRfNWudQR4m4LO7Z5R12Fb7D5GyTp
         a9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754504686; x=1755109486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jzfnt4fl4r2JAvr3EQAhX7jF93WfuTFzsNkMkN0wipE=;
        b=iJCx6gq8sZaLXcKQDL4V+rDL54x9tVLhXkE09ZDYm4guejGhAyEBANE18enDbkvACL
         oyn+abyZOWsJM01eLKCsahfeuA7ALkQ775uwygYP2cVmNfo/a3z847hPdd/psMXRy0oB
         oSXQuZYnzEa0eUJH3TY1rvYLScThBuxydRh/CvLep1Jqkkk0grtdxF3ARdgHvU5jjHoW
         NU9sxsSK5QJMOc/VeEzr98qbdxD5AKe1NKslZyIULKZ3LTu5jkgDFF137sJaCbIuBzrT
         l6FmZcsVQT+ScTfbUkCyHb4xqP9wOPd8c0dRgj4/d/Njrv4z1Qz8ZtCJXme+fxkO3r7q
         5yXA==
X-Forwarded-Encrypted: i=1; AJvYcCVI0fEfdBOZWMCKTwkZJKkXuIzRMp3EXTJnAOlVF2M59LDiXCgIlcKPi/zrfHdKnqf9AiXrow==@lists.infradead.org
X-Gm-Message-State: AOJu0YwKcmoUjCFgkNAm+a9g1UCQPawS9/MHfkK93m58aumtPf2S1jol
	DDRoRPeVUhUoXNbF3Xnl972L4i44/hnfm1VX3wn3feI9ds1Yl3AC2roM+fk6IUExmTgKEsjly0R
	Zez5UpdkQ1kqEUIV7ODafLBqwXuCq0cA=
X-Gm-Gg: ASbGncvj5SdtuochhWrw+50p2bmKdehktfRTUzqsKq0aY2w7UHtATDjYdgKyOlSTl3m
	hHvi+8UaNI3x3hAWkjOBCYi8Tqz9DnY5JSRrqZxlY6pEg5r114iYT2B43WC+g44C7YX0G9DxVJI
	R33ZjOxAVZjz2+/yO7bW+toJqTlYmRZE3vRIJI6pQ9AOi2vrV7VjrhbwdB2VmPy8wWj8P/2DtTk
	+Achs0=
X-Google-Smtp-Source: AGHT+IF0PXQZi9vqVnGtQAW+0IZx7w81vI5Y5ZNTHdf+iKVApDbJ4sFRSLR1PHAs1LlJtYMmoHssgB5z97iQcbR/02I=
X-Received: by 2002:a05:6512:224d:b0:55b:7cb7:f57c with SMTP id
 2adb3069b0e04-55cb69c0452mr37793e87.57.1754504685766; Wed, 06 Aug 2025
 11:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250805062333.121553-1-bhe@redhat.com> <20250805062333.121553-5-bhe@redhat.com>
In-Reply-To: <20250805062333.121553-5-bhe@redhat.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 6 Aug 2025 23:24:28 +0500
X-Gm-Features: Ac12FXwvECclFxV4j0m2efvjg_nqG0wG27nQYV0fVI0B5ZHzOZg6GczwOHM9vRs
Message-ID: <CACzwLxivXFYXuF1OkqcP9THar7UGQ3VVAQgQm=PU9Tohb8hnRQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/kasan: make kasan=on|off take effect for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	akpm@linux-foundation.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_112448_345975_46436B33 
X-CRM114-Status: GOOD (  16.50  )
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

On Tue, Aug 5, 2025 at 11:34=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> Now everything is ready, set kasan=3Doff can disable kasan for all
> three modes.
>

Hello,

I've been working on this already and a different approach
with the Kconfig ARCH_DEFER_KASAN has been proposed.

Please see v4 thread.
https://lore.kernel.org/all/20250805142622.560992-1-snovitoll@gmail.com/

It also covers the printing in a single KASAN codebase, instead of
printing "KASAN intiilaized" in arch/* code.
Also covers the enabling KASAN via kasan_enable() for all 3 modes.

It's up to KASAN maintainers to choose either version.
I just need the confirmation now if I should proceed with v5,
or your version if it covers all arch and cases should be picked up.

Thanks

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/kasan-enabled.h | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.=
h
> index 32f2d19f599f..b5857e15ef14 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -8,30 +8,21 @@ extern bool kasan_arg_disabled;
>
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>
> -#ifdef CONFIG_KASAN_HW_TAGS
> -
>  static __always_inline bool kasan_enabled(void)
>  {
>         return static_branch_likely(&kasan_flag_enabled);
>  }
>
> +#ifdef CONFIG_KASAN_HW_TAGS
>  static inline bool kasan_hw_tags_enabled(void)
>  {
>         return kasan_enabled();
>  }
> -
>  #else /* CONFIG_KASAN_HW_TAGS */
> -
> -static inline bool kasan_enabled(void)
> -{
> -       return IS_ENABLED(CONFIG_KASAN);
> -}
> -
>  static inline bool kasan_hw_tags_enabled(void)
>  {
>         return false;
>  }
> -
>  #endif /* CONFIG_KASAN_HW_TAGS */
>
>  #endif /* LINUX_KASAN_ENABLED_H */
> --
> 2.41.0
>
>


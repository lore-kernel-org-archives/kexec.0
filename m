Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBB9CE7B12
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V1GWVk4qjCFFs45/WyYJujSVk3cU8UHP9J9lavaWKGo=; b=EubNel6acsN3ZvRsZoRwmeCkBW
	y+uPgY536A6lStUwFKRgxXgxJFWZQ+CqQRmsMlaz7YSjDma//1DRbyQRsHLse49lLFIPUoK983Ts+
	HYurJNTbGD/EolyuM5X6dYtetj+Q+BaNyiePxAPyaZDJic4Iu7Kvya9pOeUM04pubbtATkogEpUed
	2R77ORkVyW7VahGraoBTp9JU3N2+GAIRPaj0epjGbOmxbFuGyJ5ltqJCHo0O2d4HNkdJMvwx9qZtX
	ZWMWiJ7YCHjL6tVpFIbCs5hsGC727Tc33sNwQpllHnwkGTcC3tIX8JIaRPdD1EtZVv7h7wvxgAs9Q
	5MdgcQVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJuYa-0000000CKVZ-0rcA;
	Fri, 14 Nov 2025 14:13:44 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJuYX-0000000CKUC-46Wn
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 14:13:43 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so2946481a12.2
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 06:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763129618; x=1763734418; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1GWVk4qjCFFs45/WyYJujSVk3cU8UHP9J9lavaWKGo=;
        b=eY768dGAjbPyYNbOxZU3DLtgR6Ut9PLpxxyuyqNIMIgtZg7nNKOgkqxoUl2NbjQkEX
         O+1zhvy+6Nm3BsEB6p1kfL6un795jjDesIh/CxryTIGdsPZkYuY8StxSnJEOC5V7dGjs
         ZhzHlwF245YOjKPazYs7ihjGfg7SarKbLTgDmocLzwSN290PoNF2sUJFvFPpHwPzvJyw
         +qHlbhHmG7mIEsP24vtHW85Ffs2WxVWEqlAILdOEe2m7QpKkNZbtwsOsn5LlejYpQe9i
         bY6JbkIhayqA2cRdL06xeNtTzzJJu0nEq76tCb0l1nzS3zBLqVe9eRCQNX3VTP0cssR6
         UEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763129618; x=1763734418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V1GWVk4qjCFFs45/WyYJujSVk3cU8UHP9J9lavaWKGo=;
        b=Jyv/SuENDjvSxfNt67MkN8LWwb72kza6rgcvAmcC1awDc26g5lTsYEMi+f+XYca1aV
         LAsznigf48pu6vzRn4pbjS5JStr7EZQg+RjOMeVSX0M9BGIoeLLY0us7+IFykHEKRu5R
         +hvRLurmS4/xNAnRQQeBjwH7K42rjYXCCGP38iDcR/BAaYMvjaqArGh488FUceDJwHtJ
         +ZM0cfTmWypOZQy70QbpTNSmdFVLo6ZYoC2eQPvUzJrLbvLFE5ZgI9Mxe4zbVshDd9ys
         S1Io/9rypAPJNKDPOEXQtRoDhpXAmAIFcbsuY8ZZMXYWKO1+LbY1l2vDHub4Zi0dVwum
         zUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxt0szj5Of9nj3SzzmI+KSTMCEpHcTeJGosJl7W7dRc1SFx6iIrSvhr9u9jYSvuATCEMi+tg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwuRZVbpDiZO6Bi8noWPrK5nu7FWvN9vocCpIZvGUKCm+akdVTW
	+iW29jtAPEK6MRnGNOfKxU0X7yRJwKMgE0Nzfv9x8CEAsqwkBw2hDyVgj1VcuKQqWwja1EWTDqs
	ZdTswlxrDnAUjozGZWju4zvlz0BLzZHnaK4voUkSlmQ==
X-Gm-Gg: ASbGncues2bZ2I3jUXXhKG2iU9M+Cm30zkWnU/SxTLMIHudwydFbfkKzBPlU/MTWK03
	P5TrINwEE9tKWENaT6YhuaGjFd3N9Jo9noHuuoh7O8Q934yhPxiTa0ynk9oB40B5i9VSnnhGXA/
	7y8CDu2xVD3gEOOnb8BDJ00AiQ67w/3YMQllv7Q+mJXXntISSKrJ9HIZmMwNetlN69R5wsgHJuY
	+PQqwjuOuDVx+r2ero8dZfFwBW6JN7Yw92C1hfqc19FumLCmp5cJnAmWw==
X-Google-Smtp-Source: AGHT+IE6NyLe9C9FZki5iqhbn7SPAhloGhmZAVL7TcGQzvAGxu+qhhe6/PYG3PIh8YJQedsoxrgsfW8jKdq98CqxiHg=
X-Received: by 2002:a05:6402:21d2:b0:641:7a6b:c84b with SMTP id
 4fb4d7f45d1cf-64350eaa120mr2487306a12.27.1763129617993; Fri, 14 Nov 2025
 06:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20251110180715.602807-1-pasha.tatashin@soleen.com> <aRbag7qR9OVNAQXN@kernel.org>
In-Reply-To: <aRbag7qR9OVNAQXN@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 09:13:01 -0500
X-Gm-Features: AWmQ_bn2JTVcrMalLvDrtUy-789mrdL8UQfu0H53fSt1tKQevbBhJ-8H6gadkbQ
Message-ID: <CA+CK2bD+ZseJ_6GUMV7d=8xpUcWW6jzJBdJRy7kQmez_2sMYUQ@mail.gmail.com>
Subject: Re: [PATCH] liveupdate: kho: Enable KHO by default
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, graf@amazon.com, pratyush@kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_061342_029296_0FA1B305 
X-CRM114-Status: GOOD (  20.51  )
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

On Fri, Nov 14, 2025 at 2:30=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Mon, Nov 10, 2025 at 01:07:15PM -0500, Pasha Tatashin wrote:
> > Upcoming LUO requires KHO for its operations, the requirement to place
> > both KHO=3Don and liveupdate=3Don becomes redundant. Set KHO to be enab=
led
> > by default.
>
> I though more about this and it seems too much of a change. kho=3D1 enabl=
es
> scratch areas and that significantly changes how free pages are distribut=
ed
> in the free lists.
>
> Let's go with a Kconfig option we discussed of-list:
> (this is on top of the current mmotm/mm-nonmm-unstable)

I will include this into the KHO simplification series

>
> From 823299d80aa4f7c16ef6cfd798a19e1dfe1a91ab Mon Sep 17 00:00:00 2001
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> Date: Fri, 14 Nov 2025 09:27:47 +0200
> Subject: [PATCH] kho: Allow KHO to be enabled by default
>
> Upcoming LUO requires KHO for its operations, the requirement to place
> both KHO=3Don and liveupdate=3Don becomes reduntant. Let's allow KHO to b=
e
> enabled by default, and CONFIG_LIVEUPDATE can select this CONFIG.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  kernel/liveupdate/Kconfig          | 8 ++++++++
>  kernel/liveupdate/kexec_handover.c | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> index d7344d347f69..25c9a4d7781f 100644
> --- a/kernel/liveupdate/Kconfig
> +++ b/kernel/liveupdate/Kconfig
> @@ -63,4 +63,12 @@ config KEXEC_HANDOVER_DEBUGFS
>           Also, enables inspecting the KHO fdt trees with the debugfs bin=
ary
>           blobs.
>
> +config KEXEC_HANDOVER_ENABLE_DEFAULT
> +       bool "Enable kexec handover by default"
> +       depends on KEXEC_HANDOVER
> +       help
> +         Enable the kexec handover by default. It is equivalent of passi=
ng
> +         kho=3Don via kernel parameter, and can be overwritten to off vi=
a
> +         kho=3Doff.
> +
>  endmenu
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 568cd9fe9aca..23a3df297bb3 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -51,7 +51,7 @@ union kho_page_info {
>
>  static_assert(sizeof(union kho_page_info) =3D=3D sizeof(((struct page *)=
0)->private));
>
> -static bool kho_enable __ro_after_init =3D true;
> +static bool kho_enable __ro_after_init =3D IS_ENABLED(CONFIG_KEXEC_HANDO=
VER_ENABLE_DEFAULT);
>
>  bool kho_is_enabled(void)
>  {
> --
> 2.50.1
>
>
>
> --
> Sincerely yours,
> Mike.


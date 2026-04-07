Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CA8FEEF44
	for <kexec@archiver.kernel.org>; Tue,  7 Apr 2026 14:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PH7dFq7f1INYm9K7IYaHG84sZj/ZwJzM9/9IHu+cmAg=; b=CftinuTzwv+i6rSvNMkBQBafh9
	37uL9pDEQYkZo5HqbQribpDRJC5BZJE7EHHVXj2gUKYN/FxTFNOQix8tgRmQns19vJklq+rIPsDg3
	zXH4T9HBk5bBt+L5GxNMTEYB90+DtuQ7NHZf8IvNFSaHVewd8kg16Jjzws+EjrHW89WhVxwDgwW+G
	sxjraQ1BveEW1LQMO4PdIUhuZG9uhCiT27HRE+syeSFgZyMfHI93zBDiAAsNkRo7NHPVnqzKPaIH2
	jytyi0i5ZQnv1RCeBrlZnsriiPaM71/8rpwPNXQcAlbFxff3s2YCp2ByjP0YibO6ETNnGxQ6t+NIZ
	a5lmpC4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA7Gm-00000006ag7-40Me;
	Tue, 07 Apr 2026 14:19:08 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA7Gj-00000006afj-3xvM
	for kexec@lists.infradead.org;
	Tue, 07 Apr 2026 14:19:07 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso534040166b.1
        for <kexec@lists.infradead.org>; Tue, 07 Apr 2026 07:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775571543; cv=none;
        d=google.com; s=arc-20240605;
        b=WTVGNJVSGxEbCE7p1RGtuXa6epHMpkH6n5zQaIqIdTeACW5lDcCd/xfQgq1iuFfYFg
         aMNrYBtQzOTfB+HUchg/zn9pJWl+irk0zHvKsGaXOfWYJy5wzuKEJkB3WhDZQquQPQsC
         +kZETvzPtrCJwqFcr09w/IMXFcGXq3Zwxcp6ESlSF3IYFZ769En6sDgU3OvHlDuVD8tA
         n0EmCgkUeQKP1oXeHXj7qDmDa1l1or3zIDVQPhIMQDC9UIZ0Erx1m26K4JrS6z60T/Ef
         O2pB4ePdyWGpl3Sor+x/gRWsSP0Fjo8kjUctE+AkxUDPo35fj3qpEUdCtmnPTgdhUNY9
         ipjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PH7dFq7f1INYm9K7IYaHG84sZj/ZwJzM9/9IHu+cmAg=;
        fh=AGLSkFPpX8pguion7pnCqQlkMkCdUn13X3unb8feXus=;
        b=fOrDfmf36roihFb0b7l3qJjPluoXTkLA3/4OLqhFVc2YNGrC1nZKPo/9iaxDs4qPeL
         cXEoW3aoIkcz2EfGz9Qep9xFAcMYNczNjX3ez/e7KKqDXW+cSN5xnGS9XPMXFTtiW8wO
         VC9y2aZ7CN0xYONn/bfQcX1kw85qr2uFTAPbIbBEj2sPDDAS4V5hX9zZtr9vBwVJhGyE
         Z0rjqxn0U2qG0LW1VjnwX0L/Sg2uMM34B/DKMRbfI8aZgqOaiQEePZ2zdvF6W3wklQzk
         WgaXlioGThQ3y8d/wYuKwOPGQQtjQQfzkgNFy3PZ7CHRK8LY7Me51tD5mAf/LnSYo0qF
         tAmA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1775571543; x=1776176343; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PH7dFq7f1INYm9K7IYaHG84sZj/ZwJzM9/9IHu+cmAg=;
        b=YJ/5Zp3as+yR35mPftTbxKe/WsLyJZH5oZwunGiwPDS3j2bhISLHTUc7ZAQ8z63Y/3
         riB5s4Imlyr6AKZxJMeIemSkisDqdR68dq4uRpSqu6ZeF9vAwjPiIo99L2/Zc/Rzf3s7
         1V+XFP0FfPkxb5DSj98BNI4/9BkecQ48POJ9lZOF8b9VrQhGIARVfDhZnEJ85DRTo1yR
         4qWj96zrTYWNKT/DE1OT7aqwtKOY6FtErV50hr+p3vcgaGrxkD1XRCySBW05lauZ0VJN
         OZqtmf9OJ+FXXmoNg25WdEdgZmvKClwgYXcLYpCmMLtENiaAQMv/vm96v7dPNrdZBsC3
         J2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775571543; x=1776176343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PH7dFq7f1INYm9K7IYaHG84sZj/ZwJzM9/9IHu+cmAg=;
        b=i9zfVfUe1YVgOLpDV9likWTn52OvZFaJO/8viMUvVFyvx7+wjlman8z8uA1DT+hijI
         AM72D6rCjtyTDtA0OpMxXiM66uVhn2j7r5TN+7ba/ZPIglrvcS/5eRxljQKMsyhmWXH9
         Pj3KiKx9zFp53vZ71kURfqo3euaOqKdPxYIr5bPOt3ZMOv6FyNwlPl5XZPu3391G59X6
         Tw1VhPu0AnK1TsbC+5aC8KRYXoG5IciZu8/Hrpz3f+7EKuzhjAcIKWbA/ooWKYay7TZP
         hck6F6KjIVZ2QXfnOjif002AhFjrh8Uf3E5yBCYkWY3yRpFnBMkczQTsNOYiVmAxXEfk
         ci9A==
X-Forwarded-Encrypted: i=1; AJvYcCX6KXXXmV1G+q+WGCHKsVpfBpSWtyS5U0WDefQyRFBXgweg+Eka83Syg+ez6327RsGbXl7H/Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxvsTrVZvgea7v5ly6mAVt6TzEX1XdQrzIzwBAg3cj6q8y3HBgP
	dHFTB0nuyBKhWVwUhXxu1iyHJQrti6In85Ug7G0x3pyq4EZMbhcSl4T6y6UvR07aN0x62zmGya9
	6eL4bgWWq3p+79VxDZU97dgoJcN/AvEzv2YGjAickYQ==
X-Gm-Gg: AeBDiesqIEg3PsbK5OXZV2IaQF1hBxim5F6hTPkC1xf9nGy+AO5TTAkpA9+YcB5tlt0
	upG7LI+09OArC3MRjfHfFEMAvPm7D7BazkS+KthosKdnicnAqi9/oH3uabWC6FF7Dlp28xW42+L
	XWkux8Ut6dinEWLV3kVy9X3H4hTZVlfs2o0OgsXJH0UdzMGkiy2rNwy0acJD1oJZ/UNdW/qbGkG
	374Pi6eMWZBXKRSApdVEkwLzZUFe3qyi2CO6xcAo19bSekkJ0VJvD7MZKJT6PBvkbVNURyyOhW5
	2qmdQ+GjhmXrwOl2UyaQiTH/BJKCzFbUpLRinU2k3AspSMaO
X-Received: by 2002:a17:907:e113:b0:b9c:1a5:acb7 with SMTP id
 a640c23a62f3a-b9c67b4d13bmr511967866b.29.1775571543087; Tue, 07 Apr 2026
 07:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260317141534.815634-1-mclapinski@google.com>
 <20260317141534.815634-2-mclapinski@google.com> <abptg2AObfxkkxKf@kernel.org> <2vxz1pgravke.fsf@kernel.org>
In-Reply-To: <2vxz1pgravke.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 7 Apr 2026 10:18:24 -0400
X-Gm-Features: AQROBzDxG3uqA6xycK2LUwqsWH3qLlD9BRFGhHVc5AlW0BiYM_p2w8BL8PV1yAE
Message-ID: <CA+CK2bCSoKGxfV+0QL46p_GqC=rj0YhcvP__bLrM2rVTgTNr=A@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] kho: make kho_scratch_overlap usable outside debugging
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Michal Clapinski <mclapinski@google.com>, 
	Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_071906_014578_AC1F3086 
X-CRM114-Status: GOOD (  20.66  )
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

On Tue, Apr 7, 2026 at 6:55=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Wed, Mar 18 2026, Mike Rapoport wrote:
>
> > Hi Michal,
> >
> > On Tue, Mar 17, 2026 at 03:15:32PM +0100, Michal Clapinski wrote:
> >> Also return false if kho_scratch is NULL.
> >>
> [...]
> >> diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
> >> index d2f779cbe279..dc352839ccf0 100644
> >> --- a/kernel/liveupdate/Makefile
> >> +++ b/kernel/liveupdate/Makefile
> >> @@ -7,7 +7,6 @@ luo-y :=3D                                            =
                 \
> >>              luo_session.o
> >>
> >>  obj-$(CONFIG_KEXEC_HANDOVER)                +=3D kexec_handover.o
> >> -obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)  +=3D kexec_handover_debug.o
> >>  obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)        +=3D kexec_handover_debug=
fs.o
> >>
> >>  obj-$(CONFIG_LIVEUPDATE)            +=3D luo.o
> >> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/ke=
xec_handover.c
> >> index 532f455c5d4f..c9b982372d6e 100644
> >> --- a/kernel/liveupdate/kexec_handover.c
> >> +++ b/kernel/liveupdate/kexec_handover.c
> >> @@ -820,7 +820,8 @@ int kho_preserve_folio(struct folio *folio)
> >>      const unsigned long pfn =3D folio_pfn(folio);
> >>      const unsigned int order =3D folio_order(folio);
> >>
> >> -    if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << o=
rder)))
> >> +    if (WARN_ON(kho_scratch_overlap_debug(pfn << PAGE_SHIFT,
> >> +                                          PAGE_SIZE << order)))
> >
> > Can't say I'm fond of kho_scratch_overlap_debug(). How about we make it
> >
> >       if (IS_ENABLED(CONFIG_KEXEC_HANDOVER_DEBUG) &&
> >           WARN_ON(kho_scratch_overlap(...))
>
> +1. And we can get rid of kexec_handover_debug.c, for now at least. We
> can add it back when we have something else to put in there.

Are you proposing moving kho_scratch_overlap() into kexec_handover.c?
That would make it uglier to have #ifdefs in the C file. If you mean
removing this function entirely, I think that is too dangerous because
we have already had a memory corruption issue [1] that was challenging
to root cause, and having this simple check prevents this from
occurring going forward. The problem is that changes to defences such
as kfence, kasan, and asi are happening outside of the core KHO code,
and it is very easy to miss when something unexpectedly causes a
preservation from the scratch area, as we have seen this with kfence.
Worst of all, some of those mitigations use randomized or sampling
approaches and might not be reproducible on every try, so having a
CONFIG that tests it every time in a debug build is the only solid
defense against that.

Pasha

[1] https://lore.kernel.org/all/20251021000852.2924827-1-pasha.tatashin@sol=
een.com

>
> >
> >>              return -EINVAL;
> >>
> >>      return kho_radix_add_page(tree, pfn, order);
> [...]
>
> --
> Regards,
> Pratyush Yadav


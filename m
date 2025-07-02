Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93565C83F03
	for <kexec@archiver.kernel.org>; Wed,  2 Jul 2025 17:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+3iu10ARXrli6aYGeWMSd0G/SI4ynrsF78F10CwdKD8=; b=SoMSPKt+0Flhf3a018EBZK3epV
	AoapIvmEy55Q3WqQKDAes9oRarQf4KfLtw2m+pH+1bsTf4GXNsSRfX8H2HHkay1GoaUI8C7I9V6PM
	dHQ5iTU5KwsTSE7teJzUJudSnLSEjouw5ECPjYj2gCrQLayh7uSrMaIXCQAyCPjiGRsPKkg2mNmaY
	WLhCXLuWL2TxhkDNMmEQMS748z3iIU3+PBfbRz6mwXrRWnegueOxFOjh1UyJaeTf2hPbnL1pIRv0G
	fqN0/btN3YiNbuaM3p8cp5MAsscIUrnztvwVslDJBSnWU7c7d2oM1R1xKhet8tlPgQzjqY0Ou1+K/
	0i52X3/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX1ZV-00000009AjL-08qc;
	Wed, 02 Jul 2025 17:48:37 +0000
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX1OV-000000098qv-3vKm
	for kexec@lists.infradead.org;
	Wed, 02 Jul 2025 17:37:17 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-70e5d953c0bso80427427b3.1
        for <kexec@lists.infradead.org>; Wed, 02 Jul 2025 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751477835; x=1752082635; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3iu10ARXrli6aYGeWMSd0G/SI4ynrsF78F10CwdKD8=;
        b=KRBGKln9032tpMzxijCNKaFwkUEOaBBTkgYrP5BnmJYlznjXqixfK+5KZnfhiRAGL3
         t1WrUIAMaalcrSSP6Le2ktGkYhjVecAPHBdXm5f40VXrNN6Y9eY38x9oRw0BuahX7wrR
         Gg0f9J4KTY6rkIfQXNJUGd8QDmeS3fL+YvM0kbPUIsxONXVaUZYF+/ZF5Qh2byN/E6nl
         VnbdxjB3RH5XwTR767mMqmJvD4kW5rV0fmeYW1T6NMYQeqCuGEvmxlVKLezpjoUo4j7N
         NZx1l0Qp1r4mGghVQRDfzQvdknVqTubTputWJ4KbsB8L/3zO2U8Aof1vBL/oggrlXOJ6
         wJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751477835; x=1752082635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3iu10ARXrli6aYGeWMSd0G/SI4ynrsF78F10CwdKD8=;
        b=ppBZ7lwKD1k3AkCHo7V9W+UhKr/pRCEjtU6xNHemJR2P9P2Q1wGrviuYI6LCo+R0Cf
         oiCrpnn5nQ5ggHHjaNpno2wlVFM8mASxJOqszCiCiUHRuDjRffjTbC0Y6RWlNzUc/kZx
         rMGhRiukKFtaXuwJgPWsCuxefxA4wT04qUJaEvYe2ru+0fusB0Zui3/3J6wElxh9p9X9
         z0RVo1/o4bCz4zVCBUY2TavH5yy2uzTbMq/NexJIw0MVw4F5wnVver8oy4gvqj+GLVp3
         vAjJ9qSnj7kY96ukHf3ICToL/1/y+DkGFUA1FrR/ASISmYTnBmhh+j9shYo82ylVE9Bb
         fUUg==
X-Gm-Message-State: AOJu0YwdzkuLa5meMv93F8lyWxjByJaLqoHzprOKTWkPSLEV9St+kl4d
	WZEumCEit7LXZEKZ2on/QboyHHrV7kPKMrEzGNndNvshZcsZhmSngVGykasCFNi5AgK6DpYNuLW
	laaB6+7XMnsB/r1F5qHBhL6ebeQsqpOU=
X-Gm-Gg: ASbGncu9eBtZ+9ZgIfkosWYEQrjDdFNCxVLUD42VJvFAhqUJaulPx/yCw7f9J6kcmos
	DZZtwaLwuYzgynRhMWFZQ3lKblq561zbU5Y6VmBl+H3TiWhMSpSDJ8Nm65iq5BrkmBVSolWBy52
	MSz3vwRjNgcH8UdnVDzZiTObXf69O5+JsQlQ/vcR1fbyGEHgWWeExtbVwNxQtZnfma8jVXTWvFl
	P99
X-Google-Smtp-Source: AGHT+IG65yWaIH+GMe5uFx9j4slTz+xcfrbtnzt86UHGCPNc2S++CK6rMAk8qWiyENa3BvDVqurWq+l2oPlvEZC1Mro=
X-Received: by 2002:a05:690c:6886:b0:714:3e9:dd3 with SMTP id
 00721157ae682-71658fbcc71mr7959357b3.6.1751477834545; Wed, 02 Jul 2025
 10:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250702171704.22559-2-moonhee.lee.ca@gmail.com>
In-Reply-To: <20250702171704.22559-2-moonhee.lee.ca@gmail.com>
From: Moonhee Lee <moonhee.lee.ca@gmail.com>
Date: Wed, 2 Jul 2025 10:37:03 -0700
X-Gm-Features: Ac12FXxSvmf-vd0t6RoDD8VwiJfrWPOWXyAk3_FBBMmpe3i4cdXWTYiNc4YjfZE
Message-ID: <CAF3JpA7q6WRMNar-EqOd6afTogyiUoRq+GnWp0sdv5rakLpsYw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/kexec: fix test_kexec_jump build
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: kexec@lists.infradead.org, dwmw@amazon.co.uk, mingo@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_103715_971426_14AEA7D3 
X-CRM114-Status: UNSURE (   9.45  )
X-CRM114-Notice: Please train this message.
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

On Wed, Jul 2, 2025 at 10:17=E2=80=AFAM Moon Hee Lee <moonhee.lee.ca@gmail.=
com> wrote:
> ---
> Changes in v2:
> - Dropped the .gitignore addition, as it is already handled in [1]
>
> [1] https://lore.kernel.org/r/20250623232549.3263273-1-dyudaken@gmail.com

Just noticed I had the wrong address in the To field =E2=80=94 the correct =
one
(skhan@linuxfoundation.org) was already in Cc, but sending this to fix it
properly.

No changes to the patch.

Thanks,
Moonhee


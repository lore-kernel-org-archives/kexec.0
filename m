Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD9FCCFA0D
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 20:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ST1oNBMS4hRThDaChGSDv3RZNfWOxmzM7Tq7eDcBdgs=; b=CHf/WUIYp9RCqqCaAtXNZj/w4M
	P81no0Q+Fh4LTY9fYLgU9a4VhDWg1OhL9LsxonJyZvXhEtVrCnDL2hrKNKLDqg1gY7J8q2L8UObh6
	w01zstKnu4GW3s778o5AtcDDPZThwENXfCzQYoBd2I5CxQlBU1Nnq2Oe8pWxqQaM2QfrCglkZ+4zW
	kflapP1YWpSjvtqE742QCC7ldFvn9waodsuoyNYn4sPW4tmZw1Y+rt14fSHyJZgRDz3v0e+vCRRWg
	c8xfdr5MZB34oLExib/iI+W0Ygi8CMAWj9IqN5E5EarBkQTjXmJlA9OOfq03w37XPY3oIuzEA3mMS
	onjvm/Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGjnb-0000000EM7v-3guA;
	Wed, 05 Nov 2025 20:08:07 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGjnZ-0000000EM7Z-0pVO
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 20:08:06 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so261340a12.3
        for <kexec@lists.infradead.org>; Wed, 05 Nov 2025 12:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762373283; x=1762978083; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST1oNBMS4hRThDaChGSDv3RZNfWOxmzM7Tq7eDcBdgs=;
        b=DoDOM7xt4cq/P3LPtB6rU2vCek14MAKkAYgM7myUNj8VeQsrBI9eeINpMSRgnj3CgZ
         5hm0ELNVSzr6w7wbTt0b2fauizbVqMOytb0C1UGTMNiSFJw84dIASO86nv+lM+vlhDvo
         WiILybZiR/M10wPNw1SK71JnwFxZaky5ZAp2AQR3uBI4F4CXtfO9PkXqJ/7D0kYOtm+4
         figdNCiV0b7AxaoAmx3jbtpYPuO3p+K6mix6PRIC9InoVZh2N5dTdq3Vbf2IEjP1SJwF
         JCZkQjH59D2/VKJ1onHWfTvg7UcQpRBmxggVSAEq6MVC7xo3ZZ4A7ehF6pCWbIwNkBqH
         xEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373283; x=1762978083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST1oNBMS4hRThDaChGSDv3RZNfWOxmzM7Tq7eDcBdgs=;
        b=NowdWwHHYjkEMUwEqUsmno39ma76R3q2MXAKqM0l46c1ouxpQiQAbWqDwvyUolNDZU
         YSu0ImBmxd7L72mH/d/ovWYzePINGrNSHe1qtQahJikgeUFIOoYVlScS4NIdSX1Iq/a4
         dQYM+hLLmKxwTjmG5P2sCyQFAyQrOCFGzKzJT6Tw4ap8cPdCj2WnaHl14m1kd1hjxyNP
         apUTgDTMf3qqwqd5CVty9XfZ5lk4gr47x+XwlcNjZCnEXQp0g3ZzPJylJ1WSPoW+1P58
         hjldvClOFO29IAwwV1v3Bmu5Y/fz5I1R49vWzr+rDeHItRXeOeGxxjxY3aG4kI8ipZmN
         zVBg==
X-Forwarded-Encrypted: i=1; AJvYcCVmHoJDsjPCMrHD7nsUaeBKnJnolOrB/Qh9r856INkJvvcEiPBu9WchD/fMYq/U0yBj5lc4Eg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwN75/TA78kbCMCLAkJ7aeTijxVvOAGT6/adi1BeTNfyeSvmmcC
	3fdS9B/yLnnQSGSuMprBosCi9e+7ii/bHUDdBEVW+O1abc/dgaH2lGKaa69W3AVLidmoxBz2+Zd
	gTP285M81BQ3q5POvnUEwS23Lte/qscJY2MDeJ39d0Q==
X-Gm-Gg: ASbGnctl3PAyrze5wzsA5fBA7aV3d96gM9gKRzdVSKb/z7jwcTi12cnvr4eLTpF9zLW
	1bgeUgAUQyEa0WQD9rj/huvjdEXyafN5AAdAMxUrwR+10QzYTdMf08GOD0AlTm9/iJewucD5+ag
	5jwBkY4MrvRrHd5CZUPPQFXiEZ+N4GRsHT4kcaIBtZgonoFgfnZfNWA8pBD0ZflsTDh8DmVc9aS
	bMvjn+g8DDh1CZfn/fJV3skbUL+It4Doi3QpvSUoljXASUK3PEvDSNelg==
X-Google-Smtp-Source: AGHT+IFO1PbWILyZhkmdzoG1Cq20TQMLfVmCXio+kB7daV6YdfwSyF0hqOCX+kysiN5VcXgBtF/rgyt0JUY9JXLmzhE=
X-Received: by 2002:a05:6402:234f:b0:639:d9f4:165e with SMTP id
 4fb4d7f45d1cf-64105b7064dmr3535609a12.29.1762373282826; Wed, 05 Nov 2025
 12:08:02 -0800 (PST)
MIME-Version: 1.0
References: <20251105102022.18798-1-pratyush@kernel.org>
In-Reply-To: <20251105102022.18798-1-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 5 Nov 2025 15:07:25 -0500
X-Gm-Features: AWmQ_bn21g6lzNnlKmCfnUIMRgz-n6pxjgW9XHZT8JIFo9Q6t3fWBtoZk10pspU
Message-ID: <CA+CK2bBGvaZ4-mjL2MeCP9650z7XOoB3dWr+1BMKfoMbAUK02Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as a reviewer for KHO
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_120805_264532_6C7F8B73 
X-CRM114-Status: GOOD (  13.82  )
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

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

On Wed, Nov 5, 2025 at 5:20=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> I have been reviewing most patches for KHO already, and it is easier to
> spot them if I am directly in Cc.
>
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8ee7cb5fe838f..3c85bb0e381fc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13789,6 +13789,7 @@ KEXEC HANDOVER (KHO)
>  M:     Alexander Graf <graf@amazon.com>
>  M:     Mike Rapoport <rppt@kernel.org>
>  M:     Pasha Tatashin <pasha.tatashin@soleen.com>
> +R:     Pratyush Yadav <pratyush@kernel.org>
>  L:     kexec@lists.infradead.org
>  L:     linux-mm@kvack.org
>  S:     Maintained
>
> base-commit: d25eefc46daf21bd1ebbc699f0ffd7fe11d92296
> --
> 2.47.3
>


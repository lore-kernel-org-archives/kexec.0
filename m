Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14B7D6CFA3
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 18:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w9r8EjZfu+6WBBNKHZIudTdElM7NIcXhyZ7Jt0sf0KQ=; b=ekurKy5YfX7cdX7b8JiusSZTUB
	Fh/W0UFhUyR8aAH2aVG9/lCF4iImHKqt0W9JR8Y1ahn2pS+TVK2rvbBA/ecRaVSs3oX/RthxDfBXM
	9ZH8VlTaAAkpkQ62cLKIJrgkVD5kH6o5Y9ENAmSIin229CHwIGa7zPTqCyh/g6pZ9FqQp0ByL0H73
	bWK6jYL81vkiYs38MrBfbEJIoMmv6lTP1aLzmS2CcUnjrwuNucrGgq+H5RZNaiiXh7HKV+q/1epet
	jo/OhuhHSh7yaoWPfspDrnINHECWNHVS7XojsfH1RWMEerT1YLPcaUoCDPafCPfqHiKIXFXDT6DwV
	GU9rzyZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizNj-00000007dFR-4AUA;
	Thu, 22 Jan 2026 18:26:11 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizNi-00000007dF8-2WvI
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 18:26:11 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-65807298140so2064208a12.2
        for <kexec@lists.infradead.org>; Thu, 22 Jan 2026 10:26:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769106369; cv=none;
        d=google.com; s=arc-20240605;
        b=QVhw9YKXEFIB8bfNkEAiGkfZOcU+vUmrR4hcbtmjKtIfviMF8OW6NNonbvVhgNwIFM
         CqQBW0Djxwe3WEzGITnjXwWf+j+fCee0WoQ4PkQ8L+N1Vq/oYMLM1EJTo2lt1iGTfT4s
         uyK2o21weprYa4HmZ3Fm/wDNmfyuJAutZMdrzaYuGyaZc89R+vKsJdTuuKFrfyZoZjzm
         XIujyC4grwIVb01HoyJXoUqSHX9rpTPkqeGQx0cXw+QO08WTrN98JLy8gMm39dNJ3IYr
         87JWQvzJ3sttE+FQ0QrN7XEzDGSAmJW+E3XM+dmIkM6cZy9Jelv5lYomEZ8UfMRo7wL+
         c21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w9r8EjZfu+6WBBNKHZIudTdElM7NIcXhyZ7Jt0sf0KQ=;
        fh=V4AL418M95ndZGZK07ykTE1EtBiSelLpUV0G9EVgIXg=;
        b=UiOO8+60Ib7KQDTUynGU97rHEQMeJUFwtmVeGgGAdHnx8dFANr1WPd5wJYvi2TuImk
         wYPRr/ssHd/bKTZcOvmRCWa8ZdrE/OqYu0eJ8pgzNsiBFM6DhFvdMfptWZ9GR2jXt3a0
         V3HAde1BmncwauwGN+8mkIVW7BGt3zjesBpgpEsZxRIGKdopc6MlolOyhO2UEPp0LDib
         8MHvRgbgSSB6nyDgDRJl/RQ3ur+IglzuFOQG8JwbiQamVT+YyxoVfzul/CK7kkfS2CQP
         dRV1tlUaeOvzZ2LcD5zMF9//KMUWKgIehbizTpp+MlE4LYw/ubII4s4OWQ/9YEQGabSG
         uBgg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1769106369; x=1769711169; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9r8EjZfu+6WBBNKHZIudTdElM7NIcXhyZ7Jt0sf0KQ=;
        b=kgI0OjrHd2A27fMurWvF9LqsBLAgVfv7Tch7uSzVLlGNKqmOTtrqi8P8o5+iOXvSV2
         15r0lhNZX7sorut3Vg4JzGMmXGdoS1/82U2veVzHegaAKD+/UpAPgtnNEXMaqSbQ2iG2
         XNDFb6qZqeS4bWSyIBTtln/X1T++PtC2uRmn86vlv3rlNVNfOy1uNYz8XMC4JzloIjSI
         ffhcpQygPnK6JEvkq0xs+7gnGNu6SrdgiD9R/XMtL8ZhaQmWvjwLTte4y9Ywt1RP/7TL
         YIGgR3LPRZ4BWjog3GC0LAx4TJKUDH8JN4owT0o+yNhStdAPeJTvUVXSYPh+g5cBoaiP
         cZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769106369; x=1769711169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w9r8EjZfu+6WBBNKHZIudTdElM7NIcXhyZ7Jt0sf0KQ=;
        b=c02bOOLbi54uGS0rWtn0hk+2Kne21qKZ8xdZQluYtTRQyiJTOXpYm4QzwlmjdLI324
         MAroGWM6+XHbBJsaIqZUe9zilpvS2/IbucaXjhobmZyEu+Fd43mIxc9AOytQFnT2rFOJ
         fSTqYNxf5Z/6eeGCbCLcM7hAl8F+F6UUlNvh+xv+NedYdJw4nj+7LJxqUoPwhONzcucM
         GBNnhGWEbs/b0zJdFXfSJGeJKK47zUoyCocqmjB2YdGGXATxA0ik71jixs52UxSFx/VU
         0WsjLDZII+O3FNe1WhkJN4n2BbuFo7JZ9HElX7u/z+IXr0NIoUBZXShatotgJP2FI4mp
         qd5A==
X-Forwarded-Encrypted: i=1; AJvYcCXtVpHueMtGzdZM9t3c5UN85ZIAz2f2/M0RkGvkMdyB55+3erre0h/J2smFsyBxgi3Q91qLEA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZK/HOLQMWOI+XdxwIoeXaT0qNPT9EV3cPshq0QzZlUE4XUSIV
	h2VbozLjiwDXEK8N035LTgaXHbEoSOBTC9Q2Xrf4Pmyy+md0C67KetBxY7NHLUtgu6qpiFqq94d
	MAgeAo4F1+rAjmBCzSrxDKbh0zs8ThvEIkORfFZIVEevv5egdyHEH
X-Gm-Gg: AZuq6aL3vdoSy5HZsa4jPBGby5m5F0WJXh2SFy8nglWEbFjJbAIY+Pm2HWlEylwHUfI
	4OtGxUtFPiRzR8XrcfPlgEi8YMzY7LhQHPnTiT75YTFMVBphSwDGF3F94Q1c9cj3pckOd/13StH
	/P+/ZQu4XSN7Mx/yWshI8Y4veRHML2sUdf3GxSLRDvXnqPzFP3l2mGbdNQsFvQcwcOCyFzc8rvM
	jQdNRmOtYSFq6z4bp1F9mf9yYfvV6t2xfktKLyFhZIAyVaU8Z6F+njBGMPFmwXNGidwTC8EC84c
	DndXMeMkIBmcQ9xGx4lEOweiDg==
X-Received: by 2002:a05:6402:2745:b0:658:3c7b:5c3f with SMTP id
 4fb4d7f45d1cf-6584876232bmr343669a12.11.1769106368921; Thu, 22 Jan 2026
 10:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20260105165839.285270-1-rppt@kernel.org> <20260105165839.285270-7-rppt@kernel.org>
In-Reply-To: <20260105165839.285270-7-rppt@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Jan 2026 13:25:32 -0500
X-Gm-Features: AZwV_QiXDdGmSgod4IzeC1v1Mi9Wmeos0iKetVDkwL8LXL1nrc7MhMPUl8727d0
Message-ID: <CA+CK2bBu=ThSf1nsrMWO6ij1cLB_TNrEK0dCCc8+kC-MtAXstQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] kho/abi: add memblock ABI header
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Jason Miu <jasonmiu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_102610_676178_B6CB17BA 
X-CRM114-Status: UNSURE (   6.74  )
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

On Mon, Jan 5, 2026 at 11:59=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Introduce KHO ABI header describing preservation ABI for memblock's
> reserve_mem regions and link the relevant documentation to KHO docs.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBC9FF8867
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 14:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=urfi6N/NcYnik0gp5xxDi2Nhfk8E7h+SxSQ7FJ8O9t4=; b=Zk37TCrVpnPwLkiRLe0jhGRXEn
	4ikUJ2WNTdUtg3Bbiw60PSPAOq7lABprn236vuXWDGlsVcgAfkA2afVonJ4iqLd1xCVG87Re+0YBz
	OjqzKSx/t/NecR55WT96tG8d94x0hqL1nAMqUraf/ppmrpQrG7s3J1+zErIX3l+Bd1fqr/AClslcB
	6IUNczARQzZNtSKo/+WtmbwJBpuA6GmIo3H1LEmx6M/Am1kWs3rMM1BVw4rU04VAGzOcx5cS8eeNJ
	hNeO/JMYsmfoB+SMXL6aQDYusDc8FKnRkiEvnWxXWhuML7lH9/fpn9wwHg9IMl2/8+ewZ+Sv54oG5
	PsmdJMNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI5tB-00000003lFM-1VVw;
	Wed, 29 Apr 2026 14:27:45 +0000
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI5t8-00000003lF3-25qX
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 14:27:43 +0000
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-651c7ddf514so11807615d50.1
        for <kexec@lists.infradead.org>; Wed, 29 Apr 2026 07:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472861; cv=none;
        d=google.com; s=arc-20240605;
        b=B+7QGDTpq8rALIwi3iyLmmZIRN1UsrHTv7+mCNAmJYJkMuY2OpImIdKOOJEOGVAuqh
         rrMDD9wnMw4CFfrkJfBldzjNl6nbAT009AKFIw03yUOqJ5j2PQTjXGqjXzbDep7eKlcF
         uigSrmOj1LdALraUxujbisubqN3C2L01kOPRXN2E+9brb2K3lSAcrFN4sUxO+fhSvXzu
         2eAoc7LUO97PnA1e8+tgXi6MBe/FuzlK04P9MYVTVr+gTbFLun/eYw7/KAbYgCwCkl4l
         Vh/N+vuDrAZnup9ZTsbHhF/F1x5WJsVmZTpqm0q/SN8uEYct+0O0y1PR0B4tCDoff5UL
         ejCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=urfi6N/NcYnik0gp5xxDi2Nhfk8E7h+SxSQ7FJ8O9t4=;
        fh=LY4yzD4hTHKbPiBUqpWX+5Mwu4/djjfrqkBvM1hEdRc=;
        b=Gv5dFC1KdyUjvhb6UNUXc6XL7C1CeqgNeX8ggdRCfYYUIpXj2t/RgxpYoMnHsg6h4N
         DpgDPT/CoqtCA3NAqrzzOjYchT4Wqjd81WwttrG7qU8fI7KtKFGARGFbP4jT/gF9S44s
         w4qMdxwLSeddCohn/VtZ2XBzacjT2UL/H4A3BEmGvwUE+JZrZoFIGA3aU5vwL1zPhTCb
         /oDXkr26LcJszRi+l8bfs6sWuNeRPo6OX71re0WJhAQ2Wvocq29oI8vegH85m7kC1Unx
         JML9Ge7FQyWGU5I7fc039Vol885PIXIadylAhCNdMjBuSIL0u38rs+Zmemh/q/skeGlu
         FokA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777472861; x=1778077661; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urfi6N/NcYnik0gp5xxDi2Nhfk8E7h+SxSQ7FJ8O9t4=;
        b=iV4BNdGXIwwYTQ6MEmZpuOZ+GoJBax9HWUVJmGmPCZT0kZthPnnHzeExQdpU7BT2Mm
         jGIrV6U7YMOJQ2FJPT+GdyaR1yNqcxf1HBFQFQLKveypJfhdLncQx5c1js7MVhlIi4cQ
         q3Wx9SCHQAuO+lIrdlJA8yE3MM5odahcp8C4nVcK3n2UTsKIXdgjVUA6XBFy6r6iUZN2
         XjkEV9kjgJYvVXmVB/w0Onc8fU880yWaXwTEOw0rp9/0yvj+SJboN82S3n1iKhWwBrOY
         YWH5p6cBHXWU1D7j2ZmIuY/2mnfwn329Kqqp2IUOh/hgnohRNaWWjuv4ARy/nlGLeD2K
         nOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777472861; x=1778077661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urfi6N/NcYnik0gp5xxDi2Nhfk8E7h+SxSQ7FJ8O9t4=;
        b=DFaD8aEWEokGiafm1oWb2/wKdAL0oTU6YsNXGIOEMX1I6G2AzvInYRqakcqkr37Lrx
         AR7Kscdy/TozxDUnVXizWc/0uSP5tTXc4AlCWAVlhQc4aQZHVVsULgnJ1poAnCUQ1NEv
         bHd2CZVj3Dtwv8M1OO2mfW5YldODAmHoG0ySYRy5IOkD8SVeFS8ZC9kkttCB9py5WzkW
         RXRAThBhnbVobPUf1XbTt4LoS1d2UikUA3jlgfgRRXwBm6LG7DZboTC80RGFyiQbiJCk
         JC1ulVJzNGC48Wt7gRQ+2cCF1+TO6wfFt0hw96CfN1o7U4BUt2lkkSWVpO3CgxLTfOLX
         yiBQ==
X-Gm-Message-State: AOJu0Yz88wc0ZOy0CpSbGBAUxzlu+NCl2PMl7Sgx6gaaRcciqqkTL+bG
	CdxM/6bkpiZglOjv0mcZTCOZ6LMggsATfFei0s6UHcHUEjrW4g8rwaHniE1TSuM1hZXNDD0CYeU
	8xhvl2kwJmewY2FTEGCJxOYS0R+kvC4jw3w==
X-Gm-Gg: AeBDieve5953sbDe3J5N0BGX/ma+BFXglLE9Vem5qZ5D0tYjyjWp7eJyREyV6VtFJkw
	Doojkiz6kOLe0VOB3SWJiEGpFzc4Zz2Hl/Bgxz0v8mAoxbEKrMY+2WKTkWjJ+ON7lmlUg+Gg7pg
	81Z6qAidULV3N2EpenkTYMoKwg/o3vglBSJb4/rAA7geIJNaglh9eQIBbjBtZ8WQ0S5GhKeEPue
	T9k/KsWhIiPa79bC+f59XslVhkpMuWrb+71XWHqq2/kEiQGBx68ap3tWv1dycKc34lEjkzPgfhz
	CsIPcR+z0slEUXGi/3p77guXwcZ/HleZ2Ss30zvVawhHeAweZ0Yt
X-Received: by 2002:a05:690e:d58:b0:657:4633:b67e with SMTP id
 956f58d0204a3-65bfb71052bmr3498954d50.46.1777472860977; Wed, 29 Apr 2026
 07:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260423234753.3873095-1-luca.boccassi@gmail.com>
 <20260423234753.3873095-2-luca.boccassi@gmail.com> <2vxza4ul4zez.fsf@kernel.org>
In-Reply-To: <2vxza4ul4zez.fsf@kernel.org>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Wed, 29 Apr 2026 15:27:27 +0100
X-Gm-Features: AVHnY4KDQcGvvdIXjoWZ1u9FJ9qEcoYuCaptNj3DGjOjhzukA6OesM9rXYf4ACw
Message-ID: <CAMw=ZnRY=XyQjvTeFwQ6JaVz-f-YVVvcyix4-tCEVjx0whMsPw@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] liveupdate: reject LIVEUPDATE_IOCTL_CREATE_SESSION
 with invalid name length
To: Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, rppt@kernel.org, 
	pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_072742_566542_CABE7057 
X-CRM114-Status: UNSURE (   9.70  )
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

On Wed, 29 Apr 2026 at 15:24, Pratyush Yadav <pratyush@kernel.org> wrote:
>
> On Fri, Apr 24 2026, luca.boccassi@gmail.com wrote:
>
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> >
> > A session name must not be an empty string, and must not exceed the
> > maximum size define in the uapi header, including null termination.
> >
> > Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
> >
> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>
> Cc: stable?

Yeah that would be good, can it be added when merging please?


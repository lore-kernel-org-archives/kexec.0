Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF2BCD5BAC
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 18:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fpbk6DPvyYML+NSWi9mMU4VfHIZbK/PcW4cHuFgQyhg=; b=2yXwktzN6bmH3HfLGXaaICG0xV
	oLNur/UcdY7K1LNQEQZMfvIwuhpbPmPBrzxNt43ZYXZjPMzEXqtQQrTYZubPbDujyGEJYxDZSeqeF
	bn/8CsRZQDHAQ1u5CMjP9kw/1B8ixpKiQzthTirVZj2XpleYEgkJ4BH7lcQu2rcsHWent6YSgMAUf
	OxuxyegC8waKKQn450hrcSOvslkKDupJf21Nvyu40K+1Uzb+4ePP7mapB36xyfJtFt7KTZ8juY6ZV
	RnhL5DeuF1GZyXINGPGdMeBqTSnWRooChffvLg7JkkNYZR7igZYi8BhC4djQ4eW/nhzOxgl55wWdB
	cJwvmljQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ7hD-00000008iRr-10fu;
	Thu, 21 May 2026 18:00:35 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ7hB-00000008iQE-0EO9
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 18:00:34 +0000
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-8b5232009a6so89743946d6.1
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779386432; x=1779991232; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpbk6DPvyYML+NSWi9mMU4VfHIZbK/PcW4cHuFgQyhg=;
        b=CY+19skePBHlGhzixBCuVIBhIH4dX9oM+WKTyASAgX1rB4ouD6mgAjdQlxZeAlhO+K
         /5ZzI8nSJ2iRhNngB2cIZAzfv0od2OXHtvgPVvsAFwOI275ppeKUqlQ5XjN+6AgnZO/a
         sf13RZS+7sS172AnTc8HQFMuv34VzpvVV4q+D0O15ABIAlI/ek0/mNeYa9+QWkDWAX7i
         L8vWZJMehYlFxznxg3cgVH/O7GrX1+Jc3Iu7+uXloNFvxGjSoPqn7+Koco4vUJHUALH1
         SwSY9QwQqsz8KPKVXJmq91aeHixlg11gORcqyJ8pEYnU5WDnCvhf2CgfE/r1V4fu6Rvk
         vDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779386432; x=1779991232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fpbk6DPvyYML+NSWi9mMU4VfHIZbK/PcW4cHuFgQyhg=;
        b=lt8Re/S/CTZUoGzB6YGvmc/0dUGJ2hgRy+Ngz5D/3oGLIMlMFNwe8zVRewAN/Df+pm
         pmfE90qCVqen8TYW0nzTW0ve0Ye6917VLUmhQ9c/vYiUxdvjYduk63GWd1zJ3SNbkGFq
         L8x0FCRLkQFSU5UfDAQtyvBzNEaPDC3B9kYLqkA/mGhnkS/jyUQGzD0Lz+8ijNsoDXJN
         tm62SD8KvOTxKsN4aF/XI5xr6pc5D2Kh7fpnp/VUOSuLvlvqhRxUJX3bc38bEsb7U6mv
         wbYTQXqf4caKdUNrTBevMMV0Hv7VVK9/EuhLpqQqRJVZOYzW5xxt6L3Iy8E283kPzXyP
         TMQA==
X-Forwarded-Encrypted: i=1; AFNElJ97KmgBLmlxK+8B/hRbQWpkO++N5x+xeAB/p2IY1pQBqYXpLwI4Ms+KovfI1X++eRhLN92Fcw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwPOkEufUQnKTN5c735+uF+D9FgORYm2pC7W5WhdE+58pZAYHXZ
	zwfeQNqbFKzY9zJDceKcEFT5hob8Xyw/RTNVTP9/JwnLnP1+1vONXYdtpVSwnjzsE4o=
X-Gm-Gg: Acq92OGttmlgyi49EJ/QUoEseK903aXOmtBOAZ1rw2DS1SHsdZGoqLfMFw0SRxQELxn
	K6w+KfZ758YspGjvx2VjHsgcSdIyfCDEePKFZU9PkwRnfKhmDeLGTrR3t1es2BI77fEm/v1knxt
	mclFbYHNaPsRHJ6xw+iMjXrFuHQgDoM4hFbeTBmvfQ0+JxPSX4/OpKgKg4NV+EDVjJPoiAjqMIy
	3X3py6W7DptAIqZNTm44JS40R/dRYkH1rAcJhnYk6l1KGuwDTy6L8MpZV0tnKK6c3qWlVICjDef
	pOukkVZQGZvXLk4takueSHG8Pf7eW3wiUJtWkugwdwrkeoXqAkh080Pb9RIUu/UFrB4X9o3px0S
	hqN+yGTFrWX2t3IKa9Oe7lk+oCgSXFozn3w0O2RltzTdNyVkedX7o9lgfe/DgiukZt7aSUZsu6M
	g50Qhz8UjiddeZYOydaiz8nwbFcd4Uv2Q/D2twQWWVeLXiBEgUm+u27G1fnlyuwA==
X-Received: by 2002:a05:6214:5c43:b0:8ac:9fc3:b9fb with SMTP id 6a1803df08f44-8cc7b5d5584mr6556796d6.45.1779386431403;
        Thu, 21 May 2026 11:00:31 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc781f7a88sm12544246d6.43.2026.05.21.11.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 11:00:31 -0700 (PDT)
Date: Thu, 21 May 2026 18:00:30 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: luca.boccassi@gmail.com, kexec@lists.infradead.org, linux-mm@kvack.org, 
	pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] liveupdate: document systemd support
Message-ID: <ag9HpKdDuu7LvL3N@plex>
References: <20260519152957.548119-1-luca.boccassi@gmail.com>
 <2vxzbje8944z.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzbje8944z.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_110033_096208_4F8C42D0 
X-CRM114-Status: GOOD (  13.13  )
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

On 05-21 17:25, Pratyush Yadav wrote:
> On Tue, May 19 2026, luca.boccassi@gmail.com wrote:
> 
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> >
> > systemd v261 will add native support for LUO via the file descriptor
> > store mechanism. Add a brief paragraph in the LUO userspace documentation
> > page to inform users.
> >
> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> 
> Acked-by: Pratyush Yadav <pratyush@kernel.org>
> 
> But of course, we should only apply this once systemd v261 is released.

I think, time wise it is fair just to add it to liveupdate/next branch 
instead of micro-mange the exact time when this lands.

Pasha

> 
> > ---
> > NOTE: the external links will mention LUO after the next release is
> >       published, which should happen within ~4 weeks
> >
> 
> -- 
> Regards,
> Pratyush Yadav


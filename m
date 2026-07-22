Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18450C44536
	for <kexec@archiver.kernel.org>; Wed, 22 Jul 2026 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lqCXIznA1pzGDyUhZSlfjDm381k0hmycs7JYcnqQ7Fo=; b=vpY4pzyqcbbuK47QHN6A1LQX3i
	SM2LnR81uZKr9fMivOwNqnsaN6rFjaXhflv91K+IGAu11XW+2jk4OalvJgsIoK3KgwGLMrnjce8lb
	XW6Cd+bGyw7iT2y4jtaJHI8WftD63GbXXnbupXOYqnmBGcFQBBXCFP1bqXOsKrmlaFsHHJ0+H/OcK
	QYRVa8aegXHOAKOs6wUFVj+WLsLClQE8orNNFPnfOVoWW7c5MTZTQ18a5Q/kfiEnsqZxuPtjR44gp
	8KEXxyoAEZziHlvjJe+RvGa5IBc+Btu8STLc9wvs9Tr1IfhO1y631CsDymG8I83gK8xHLkkga7mkz
	/BG3jBww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeL0-0000000Cnem-2npX;
	Wed, 22 Jul 2026 21:18:46 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeKy-0000000CneJ-3lOe
	for kexec@lists.infradead.org;
	Wed, 22 Jul 2026 21:18:45 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2cacef7d299so1145ad.1
        for <kexec@lists.infradead.org>; Wed, 22 Jul 2026 14:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784755123; x=1785359923; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lqCXIznA1pzGDyUhZSlfjDm381k0hmycs7JYcnqQ7Fo=;
        b=uDWYVIDuP3hCngUbIevHPs1cqtiKEMVcYyxr/R7O+9B7vQkSLitkM27qcYuW8H16nc
         7mH1cP0wjmTxLXtasGgPViPsWKkzCs/QnXLiZ0ifxCmIkkrkHVWtogydT9YGuFb4Hd/t
         PGRto6bzJM0ctN8gkzei8AesK/BYO1JQf13cgYcUwwswoARlKStvLuQek+MKtaq/DNPL
         8Ou1PFGL1I/1KxOr+G/MI5aomhP2Rv/24Ka3qNV/cZiklDPr5yElssdeK91ho9OAvpGX
         LxPSav3KJNZOn46Kbvh3oyxN1CvG845nxbPudphTp4vffbsK/EURvmr00ZmUMkxqjD1n
         JB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784755123; x=1785359923;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lqCXIznA1pzGDyUhZSlfjDm381k0hmycs7JYcnqQ7Fo=;
        b=LkQc8TVXZLm1yk+Y3Bo2TozUcgOR47YtYnEOsNJcAM52ESlFKa4nBHhD3zgTrxdgYq
         lHCcSnOrHoh9XM/maWYo0YR62ECUhvnXC4g6Heib91OTatbmDeUz5/4XRTKwa2sHMC3T
         cuA7buDLcn90XR8O1eaEcUpZhWKrx/N+y2XFX+v80DutUnTGiGHAL/wml51toTiLBfAe
         yx9mwR7lbQgTvWCEpruPvBtMglcxCMHiNHrnR/b56nT7epyAQkoxXserEObe9l1ize2P
         y7dMrMBdPk13Oabgr470u3hoxstwySkJMfiF/Wea5KB5zqWetmC4YrBYqOgX8S/KrbJg
         g1OQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8UR8YwGXC8+2vOMYrKEwwH9328g38ObJewkabGfA79upOPUcvPzTujLI311MU0PVhNf5YaA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxR1WYhD30mj50zasodDHbEmDeKVMfmRpf7+A94kXR1EfVmsNPw
	WtmYw7e/YugRidQbGZlb8CItCHiKNOj+Rzx6rsfJTy0GFP9bTNCCFj+h5tI/MAARCQ==
X-Gm-Gg: AR+sD11aggh99hfH2qvRIP9uWPBT7ewbmNGIkcH0tJmAwq77YoOILtBwHVsgQTIMDSO
	QIwGfYPF01LK/OEjlR2MUK2tEB9du0s6dDWO0Sj5IYPyJ3cFrErw1Boj7PNe94dd1VLkL3fYU3x
	hXG2YFOPLrapQPuTotmpz+pMZ7mPblbKOQ058xxMavjicA4UtL9TWN+sxycT6KBOEh/T8T1M5vH
	6u3UKRi5K9oOC+XZPQFumyiaL3Zs5wIbvbg/esbcSmY6LrqYsigVAkzXCHm66mwhTBJWVtcNt4K
	2KFt611wddvoinVQXFJDq6LeHqGLmT2277Os32IPU6FCHfKzt6AfWwUb7byTu3vyHDW5Z6TrDu9
	JoLH5z8iy3Nvdjnc4OQz8+3rQ3V556Bc3QpuJch4fnYeqcqniHfz7QO7XoYwpxT2Xr34xCFxBR3
	Zmwa7S9/hruNqchztFkOd414sCL61s2fZs60Yd
X-Received: by 2002:a17:903:198c:b0:2ca:be81:b469 with SMTP id d9443c01a7336-2cfa422522fmr1806795ad.0.1784755122326;
        Wed, 22 Jul 2026 14:18:42 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc9f2f0sm13076614eec.13.2026.07.22.14.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:18:41 -0700 (PDT)
Date: Wed, 22 Jul 2026 21:18:35 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] kho: Introduce a helper to init unsplit pages
Message-ID: <amEzq5aXBtT4nLfd@google.com>
References: <20260713204935.3069000-1-praan@google.com>
 <20260713204935.3069000-2-praan@google.com>
 <178456663513.143128.13731300065093148388.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178456663513.143128.13731300065093148388.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_141844_936874_C5561373 
X-CRM114-Status: GOOD (  15.74  )
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

On Mon, Jul 20, 2026 at 07:57:15PM +0300, Mike Rapoport wrote:
> > The current KHO restoration logic assumes all multi-page blocks are
> > split into independent 4KB pages. Break out a helper to prepare for
> > supporting high-order non-compound pages.
> > 
> > Extract kho_init_unsplit_pages() to handle the refcount pattern
> > where only the head page is refcounted. Use the helper for folio
> > restoration that requires a similar refcount logic.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index 4834a809985ab..07f6f453cd69d 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -357,6 +357,24 @@ int kho_radix_walk_tree(struct kho_radix_tree *tree,
> >  }
> >  EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
> >  
> > +/* For physically contiguous pages. */
> > +static void kho_init_unsplit_pages(struct page *page, unsigned int order)
> > +{
> 
> Can't say I like "unsplit". How about kho_init_high_order_page?
> 
> And whatever name we pick here, it's surely must end with "page" rather
> than "pages".
> 

Ack. I'll rename this to kho_init_high_order_page().

Thanks,
Praan


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB24EC5B56A
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 12:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S8keOZILRO+hA/w6RNVNhXJ75VzJNzahD3Vhsnf0uDM=; b=TEy/a6xFmfQDXt65ilxlZChDtT
	sNrZ2T8QziFDVx6xo7HuoIKHScAZcG6jJi3XeLv07dvFtawOPK//9jrl+IticGBJF+wH85qvthvC4
	PlP6u1hbzEIKw4EXE6tH/KjCCavFF5VOQddXxo4zrVyOLfzPWhEOMb/NoLbshhqe4Y/u6E5OVQMws
	7vahBPN2uQq4lfUzFCX9GZNN72+aPbj8+vArrNTMqzFI6H7SUpS1XS9CLTTuuDrAuuipNrPHKqaiX
	tP+WLr9Ejeh1b56pux24quC6p6k6axjXmeyLva0PcfqpfWJ4VrlfCQ3YdQfYpsdscR9t3vI0kIkJS
	QqFwFMZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu89D-0000000GCIW-3sKD;
	Wed, 12 Aug 2026 12:33:31 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu89B-0000000GCI9-2YR4
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 12:33:30 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2cab97c86bdso92345ad.1
        for <kexec@lists.infradead.org>; Wed, 12 Aug 2026 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786538007; x=1787142807; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S8keOZILRO+hA/w6RNVNhXJ75VzJNzahD3Vhsnf0uDM=;
        b=ZZSPYLTY0zmG4N7woYO99UzXidKKc73Z+hH4vHCHWAvgKen6cWO1LJNqKwR/hN4rsT
         wBDBGzgam8UqthwupMz37pG9imnQAqwBpyj49GQ780VkW0HFoqBjG8vY6HiTYBDDHlWP
         1miWYo+LaSEwGLxcxtLhvJsN6lA6kTgsVXhdQ+7M4B54PqcuxSjcI9hLDRdV4S1hBYIF
         /z0ovAzCn9a3A1bzYSB7vGv1UzJP2zqHrlgPSsI//PfYyQw2eaT5wgEUgb9mLcq6ztJ6
         kvk/liH4tomMPj9TBEWsrwa/FYBR1SBYCBDbJmUj+hvbfqm+CoRPNtXCVUpQMebOpr81
         6t/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786538007; x=1787142807;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S8keOZILRO+hA/w6RNVNhXJ75VzJNzahD3Vhsnf0uDM=;
        b=XoKc6zbIYG4GgBb4EYdz3cKpWVFaJorCvTap7ycetcn9wscv/Mhe2QQikhYS32Krea
         ZgiTp0rKLGLSkUcCesqGLGA2lWAZrVGNCNKdKqFUUENkBohTePAEhjlE16gE0e0U+QAw
         DcQKFIY0qAl6DYE9e/1o7KPMkVuFz+tjsbaXI/pabtJsv53RYzDuV+oFKkQp5YZZMUKR
         +D1zbnIRV/bi2le7pbNgNBqbsvHPeEzsOtCzh+md5fdkja6ejCb3QZUuUpr5wWE4pt1S
         y30AhlCqAmHzUWyV3+RKXrZgQAbi4pVUTf2mFLSxcmeUnP1kTbqqBAaP93ZGcwbPb7BO
         qd6w==
X-Forwarded-Encrypted: i=1; AHgh+RrlXY+Ts6etVo4OPYTyW2TIs992wkArT1SJhgKxKbFIlpjyu8ju84h+Q2MT16TfoQbcP3aUmg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwqxiO31LApeXeIEDAKIYHUz+WsqKZdnvD1ILIo5deZeF2Ag9IE
	+2YGFXIpufrUXACR7uRilwBoKRofzZAPRb7sW8qbPe5Jgb7+AOwIi2KNpkGr2PQ827ZWDpR+ZzP
	EIpnYOA==
X-Gm-Gg: AR+sD12FuaOZ9maNTEnc4CCbPS2JuiQgS8gmNjYT+trd8XRjtBNHHqxTdK3G9oKmmuT
	NPr7dD+wpw97EVEBcngDeGFiJO8OOVNScK5/rSudTEWtyiIN/Qcic8ySdPUwi6XB7wqEuAPBQVk
	k1C0nfQafPDIc69ItUPAfR2vHwrlNhwYPI1JuHnXk5t0FEHFXF2djcJ7Gsjh0oRgNO79KhzSAsS
	yWHo4aN+hR+55rVDDv5IxblFsnj8g4S+fA2hAFLX67IlRBS8UbQiP67YoL/AmgitsoxkHvEFHH2
	Zrv3jFfvWhz6baFQ8OUEoz5I5qrMvixTnegzBYp2nuaPXPOaJv/ZRuRQJLVlJd76hHWs4jm/C2M
	TJwQi7JTl2Kojo4qPd1mI84B4InfqTGDsFqh7PKzjufQtAdJMEXT1GqZfSpdia5deJZ+lKuV7x3
	x+7XxFdTwKZCw3hWvISCprszB7ng8HnZMFbtHkTrujvXRLp3XTPM8/nLBXgq6ZFX7VOGspOVIyu
	QvJaLceJSEzHt+WlG9UJPg=
X-Received: by 2002:a17:903:2acc:b0:2ce:b436:272a with SMTP id d9443c01a7336-2d34aa4449dmr5490875ad.3.1786538006669;
        Wed, 12 Aug 2026 05:33:26 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d352218b5bsm5554125ad.70.2026.08.12.05.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:33:25 -0700 (PDT)
Date: Wed, 12 Aug 2026 12:33:19 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] kho: Introduce a helper to init high order pages
Message-ID: <anxoD5OGtBkiDLMo@google.com>
References: <20260803113944.3694290-1-praan@google.com>
 <20260803113944.3694290-2-praan@google.com>
 <2vxzqzk338y2.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzqzk338y2.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_053329_655167_65F461F2 
X-CRM114-Status: GOOD (  27.22  )
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

On Wed, Aug 12, 2026 at 12:54:45PM +0200, Pratyush Yadav wrote:
> On Mon, Aug 03 2026, Pranjal Shrivastava wrote:
> 
> > The current KHO restoration logic assumes all multi-page blocks are
> > split into independent 4KB pages. Break out a helper to prepare for
> > supporting high-order non-compound pages.
> >
> > Extract kho_init_high_order_page() to handle the refcount pattern
> > where only the head page is refcounted. Use the helper for folio
> > restoration that requires a similar refcount logic.
> >
> > Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index 4834a809985a..e836efd98795 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -357,6 +357,24 @@ int kho_radix_walk_tree(struct kho_radix_tree *tree,
> >  }
> >  EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
> >  
> > +/* For physically contiguous pages. */
> > +static void kho_init_high_order_page(struct page *page, unsigned int order)
> > +{
> > +	unsigned long nr_pages = (1UL << order);
> > +
> > +	/* Head page gets refcount of 1. */
> > +	set_page_count(page, 1);
> > +	/* Clear head page's codetag to avoid accounting mismatch. */
> > +	clear_page_tag_ref(page);
> > +
> > +	/* For high-order blocks, tail pages get a page count of zero. */
> > +	for (unsigned long i = 1; i < nr_pages; i++) {
> > +		set_page_count(page + i, 0);
> > +		/* Clear each page's codetag to avoid accounting mismatch. */
> > +		clear_page_tag_ref(page + i);
> > +	}
> 
> That's sneaky...
> 
> The patch _almost_ looks like pure code movement, but then adds this
> little change. I'm not saying this is intentionally sneaky or anything
> of the sort, but these kind of things are easy to miss during code
> movement and should get a patch of their own or at least be called out
> in the commit message.
> 
> I don't know how page tags work, but IIRC when the change was originally
> added by Ran, he said that we don't need to clear the tag for tail
> pages. That held true for folios, does it not hold true for non-compound
> high-order pages?
> 

Hmm.. I added it here because I saw pgalloc_tag_add(..., 1 << order, ..);
being called in the post_alloc_hook [1] but digging deeper I see it
doesn't set a tag_ref on the tail pages for non-compound high-order
pages (i.e. it doesn't loop over 1 << order pages) [2]

We seem to clear tag refs which shouldn't be set in the first place,
I'll remove the clear_page_tag_ref(page + i); in the tail loop.

Thanks,
Praan 

[1] https://elixir.bootlin.com/linux/v7.2-rc3/source/mm/page_alloc.c#L1861
[2] https://elixir.bootlin.com/linux/v7.2-rc3/source/mm/page_alloc.c#L1255


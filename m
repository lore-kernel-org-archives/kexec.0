Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BDAC43458
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T72id7RPi86+PG3iZJFHATNYzmFCFJW00jDywLiIkEk=; b=Cr+6+twkRqfm9eWPdAP2lL2usO
	2sgXfLLbiM8dQCiB7yjuVXqxp7JRHp/2jl5PFKGZMV2dT2K8wB9SgNFG6lMLNztIswedG/YnIdWdy
	K4Fx7weQPVOql6fMTca4AfxVXAbng2Z7GArM8WkIBdBBescsP7ttpxdKODVoB41Ne+XzxpXOHflTG
	SuWVv68m8zXmOpQzGdWgYoUOblahAll1apgg7WE8sM+x8CuDxxDiR4gEpqTAaAhJ1+cbYa+j45Uwx
	lZA4Ldcp2h00pgE8m9PCzfVvx6s/yCQmsDP1t67hKLGSVsyn2jq2wZj2F6fSx1zWQp17OHseYnsJA
	kkTnMyfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whWMH-000000008II-1U0K;
	Wed, 08 Jul 2026 17:46:53 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whWME-000000008Hp-3SIH
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 17:46:51 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2cacef7d299so7895ad.1
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 10:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783532810; x=1784137610; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T72id7RPi86+PG3iZJFHATNYzmFCFJW00jDywLiIkEk=;
        b=YLwlbY2PNj2Of0tMcqEpBOrfacNE192gn2wUpiZkpnIIeEOsnxVIratyft/lEXLpBG
         05q/Tfr+xR9Y5i51Y1mHWIKJy1bnGComF7t2HVpob/rzCzm8hBNeI5TPNA/vUiIEZdK4
         aa4dD/U5T7RLqlP0y5s+K9jVpVrQ+dNjuqhMP64C6hJhYvHHm8D+gghJKiarvUjEcD+4
         z/omKRyaxewsvQxwop2sxKesFE/C4vcH+f8zXiNCxZSMVy5Mwq0ut00D2AuHrAWvzs3M
         71bXNY/oRtn8D/Qa70mo5gweC0dgSOiiwKWfZtv16dIhJZSyUvxM0X0r1FVGAokn7X/n
         VkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783532810; x=1784137610;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T72id7RPi86+PG3iZJFHATNYzmFCFJW00jDywLiIkEk=;
        b=FzRFD1zgdm2tGlLqt0ly6/XExInHqhEgJ4VvSKXk6BzqWe1niWv1FufhfvVen90ozp
         myf56sIntqhg+/xX2DqFmu02e8kz3LAnM3CoC/ioKimyZPH9CqilsmAzz4JxWIR96au6
         pSi51J68yj+sNCwLNJFOGMCq3I3W36zHaya/5ewbx7fhjBiy5kmEB59xSBxIUAVhB7pk
         3qmUgGg75kw3IvmpWUW8oQjZZJqtPUGBlEKEvSTcP9OeZTW3/n7gBKSXEZNi5IZSifJk
         /rmjWaHSPirQ/P8gOqzE8xEfHGHh4SNZKb9Kk8CPv7i+U6KzEgejnIryA0kyJUUMCOM3
         AOVQ==
X-Forwarded-Encrypted: i=1; AHgh+RruPw9d1wGFVmKC9KzGjjcW5bSt5AWik1LZeKXN/36LkhUjxvBvKXRvhL28KniLjSe7D2GPmQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwRH+EvSLQ/RbRFHwWHPM7mN4GHzlxb8V0zNi9ctsOat8MaAI17
	Ew+TybQWKB0oKGruuuI/lgt2eiGpwS1JvMIM6GGXUMCR6KjVQZrU1VzvcTGgxnhxAQ==
X-Gm-Gg: AfdE7cmavpEhJg9ZlyhFxzsTpfC04hFSUgl5Rjg8SKnFhRD6zaxW1LUFT5MQ5Jm76Qr
	3N3WfMFDtIVo/W9oX8dQM005rfja/hA8UXgYdp+gCJgKU/8+5eq6CSfWduOA8ccGodKaF4sWJdV
	D+lzyW7e46RYvJC0sPsYb/J+CcVy7GfcZGmo5Xm2AHcG/pCF1vyvGgJW0OWhhEntWMMV97tMl1Y
	nQz4YxdfHC1aW+vXi3D63PdchEay+zQLpBV5tykj7V7pNaziBnqQMre3wzP8YLfDwls67UeGUmQ
	F3oJyR+TbQvf7/gIeNj5vpbrZ3JnNSm6auqvAz4Qhky6Awb9rAh1ieLdfhZIDa0igav6uAqwEsV
	2PuLHHX7Y3Yq7VsNcGZYFLZZcdNtzCyWgeuIiccjtJ/x1+mK0SjaTQZxx1oLqc0pjY4+qoD7f7e
	K3bHZUtprE0th4Xxgt3lEzTI7Fm/TZtSZVRGsY0YXyx7Ymw+0=
X-Received: by 2002:a17:903:32c7:b0:2c9:a222:47e0 with SMTP id d9443c01a7336-2ccff85d2fcmr469435ad.20.1783532809401;
        Wed, 08 Jul 2026 10:46:49 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1eea1sm31610665ad.46.2026.07.08.10.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:46:48 -0700 (PDT)
Date: Wed, 8 Jul 2026 17:46:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Pratyush Yadav <pratyush@kernel.org>, h@google.com
Cc: Samiullah Khawaja <skhawaja@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] kho: Support preserving unsplit high-order pages
Message-ID: <ak6NA9-sQIel1W15@google.com>
References: <20260703020832.1731864-1-praan@google.com>
 <2vxz7bn5mv0n.fsf@kernel.org>
 <ak57VeunO8qd4wEh@google.com>
 <ak6DUC7NsIZ20RZD@google.com>
 <2vxzy0fll71f.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzy0fll71f.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_104650_896452_4D2BCBDE 
X-CRM114-Status: GOOD (  35.44  )
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

On Wed, Jul 08, 2026 at 07:34:20PM +0200, Pratyush Yadav wrote:
> On Wed, Jul 08 2026, Pranjal Shrivastava wrote:
> 
> > On Wed, Jul 08, 2026 at 04:36:46PM +0000, Samiullah Khawaja wrote:
> >> On Wed, Jul 08, 2026 at 04:11:04PM +0200, Pratyush Yadav wrote:
> >> > On Fri, Jul 03 2026, Pranjal Shrivastava wrote:
> >> > 
> >> 
> >> [snip]
> >> > > 
> >> > > 3. kho_restore_page() applies the correct refcount pattern based on the
> >> > >    preserved metadata.
> >> > 
> >> > Why do you need to save the type of pages in KHO metadata? For example,
> >> > for pages or folios, we don't store any type information and leave it to
> >> > the caller choose the right API. So reserve-mem and kho vmalloc need
> >> > pages, they can call kho_{preserve,restore}_pages(), and memfd needs
> >> > folios so it can call kho_{preserve,restore}_folio(). The radix tree
> >> > itself does not hold the information. The caller knows what its memory
> >> > is supposed to be so it calls the right restore API.
> >> > 
> >> > So why can't we add a kho_{preserve,restore}_page_multi() (pick a better
> >> > name; we can argue about the naming later)? Then your driver knows it is
> >> > restoring DMA buffers so it can call kho_restore_page_multi(), and KHO
> >> > takes care of initializing the pages with the right refcounts.
> >> > 
> >> > You won't have to muck about with the ABI in that case.
> >> 
> >> +1
> >> 
> >> I think this makes sense. The mm already relies on the allocator to
> >> track the type of pages it has and expectes it to use free_pages or
> >> put_page() or free_page(), so it is natural for KHO to rely on the
> >> caller to call the right restore API.
> >> 
> >> Lets add kho_preserve/restore_page_contig|_order|_nonsplit and the dma
> >> preservation can use the appropriate one during restore.
> >
> > Ack. I like kho_restore_contig, I don't think we'll need a preserve for
> 
> Dunno, everything is contiguous, folio, 0-order pages, higher order
> pages. So not exactly the best name.
> 
> Since you'd get these pages via alloc_pages, perhaps
> kho_preserve_pages() works better for this kind of allocation, and for
> the _current_ kho_preserve_pages(), we can rename it to
> kho_preserve_split_pages()? It is a bit too wordy though, so that's a
> downside.
> 

I suppose this is to preserve unsplit higher order non-compound pages.
kho_preserve_unsplit_pages() ? 

> Mike, you are better than me at naming things, so do you perhaps have
> any better ideas? :-)
> 

+1 would love everyone's help here :)

> > this though? Preserve doesn't seem to be preserving refcounts, I guess
> > we could rely on kho_preserve_pages and the caller can use
> > kho_restore_pages_contig() to set refcount correctly for unsplit pages?
> 
> No, kho_preserve_pages() can split the preservations in unexpected ways.
> While for a high order pages the current algorithm _shouldn't_ do it, it
> is simpler to just add a new preservation function.
> 
> Move things out into helpers if you want to avoid duplication, though at
> first glance I don't think there should be much.

Ack, I'll add another preserve helper.

> 
> -- 
> Regards,
> Pratyush Yadav

Thanks,
Praan


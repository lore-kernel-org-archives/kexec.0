Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360D7C43458
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 17:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NY8WDLERqRUUyPPjKLcGWnXs7jTmISXhATSCwU5JbWU=; b=ZsQcCgT0yJP6b2iId+vf8E57Ed
	6ZN5B9X/4s+mIemQ2yM6AUwevUWWuH3WlqLV5tSLXzGONIE3Fh2JMmo5kl/hBcCkot1373fqDSUZ5
	fwHIUPttppyCTi5aA1z5d6CNNHXxbiTWrCVuhcy9W7wgwGyz5vOt3YvmSN/0FWYt+DtGIuSoHgJp6
	Hun/LzgTvMitKwJHg6WyFFywNfz1JJLI0BQWpfiUCR7gL8bTjFGqVJO1ZJaqfkp6kGZok35ahImic
	gLeeMANmpVKiMgJE+DdvqJ9yNb1pMoBvUXm9ESnGq/+/+Ge9e+CHiXh+YWw17fM2RtWlLNyoXJOzA
	YKIJJ3ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whWHt-000000007ym-3cxO;
	Wed, 08 Jul 2026 17:42:21 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whWHs-000000007yL-1QCd
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 17:42:21 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2cb59f6ba26so9255ad.0
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783532539; x=1784137339; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NY8WDLERqRUUyPPjKLcGWnXs7jTmISXhATSCwU5JbWU=;
        b=p53rKvaRNC44Ha2satTl3wr4jN5j6cTmhsJA/r3nXUUT+8IH5MEzvswz27Tjq9toIH
         J14qKBsZ5jvyIXoF7p/h3bZSwcWMDmfVCT5VvLeTCKFhOPPKvzKc658/Lr29Xy7wsTza
         cJV817PvrfkDYGpABmrbyRpzlUAbNI04u0sLDgUeOcEjNlptQjFD7bC7mMUvWVVQRQPT
         2kBLo4t7X2DLYKj0IBU5vr514HfODALvmDfj3ijp6/dq3fnd5GuwaDBYhn7bG6UXpZvN
         ilauNNmOXxRZIaiDhcuOeEr5Kg8eXg4MpGErai7PKAd5BSNtMYpH4bYvl+SdCgBVVfx0
         eT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783532539; x=1784137339;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NY8WDLERqRUUyPPjKLcGWnXs7jTmISXhATSCwU5JbWU=;
        b=NS9IOPnusa1dZS6LJhhL46Fud5PdQKf3lylP9hj2kdqXZYvyqvaU6XbMMheIEeOHu2
         ldYXeJ0MYrPwDMcR+rbeft7eKHxRf9CwmXocb2SZJ3MBHGifef1UBxExokhuFiPay5j0
         Xp//J0VSdxVbBEbuptZVLtzrtDChhTaPGL61sE05Jdh3NwTmCzzQnDUscF+33980x0tS
         jkZeswWJxZpX7PqsoVLA0tQLeWoJy1kK+N89v3yQwBFih0FI2ojHg9MU31rFQO8yA5oi
         jHDqWx7oMy1FQFUnvjEBcmJ02/K7OH62feVpXc/q8BwarPDkltFAths74MEHVZcpknE2
         eInw==
X-Forwarded-Encrypted: i=1; AHgh+Rqo8+W/ozJus2AgSZg651ZOw9hMoyHSSM/omJgNebMf4+ZNTwi7aiOaHiNC+kCjUSkSwSxcOg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwNWOtGoP6Xju9/6gpS8b0CNnvKA3odltDsGQOL5UcAhRGkaZmM
	2syXtNrJwnRos54klT1VSV+fhxDcqZag8Hzgk60VV5BvHm+3PO4fBOhzac38vKsopg==
X-Gm-Gg: AfdE7cl26bOSfy75Lw4GFhywGxeDwSMFGp3WuCy4GBgAWINLOyS3tXgKsgjQba5VzqP
	Z/+6wc6/U03havW5jptQGxE2VC8cWq63GEuskdqbzS8PbOw9wlFZmns/Yznwg4tRD7GZYfW6PH+
	9JDg1oFqqL2fRAAtJ0IBMliWTBEC/E1LAmpO0p8CReg1tDHSnS4y0CbsQGtn5K7NKrEwnIdbt3R
	iw3kQ+O5HRfCx1ckRNhk8m8SuV59UmNS9RBIOUPTljVYNeT4cC+ZsTm+orBSXDWRTlfOOFlTz9N
	0J+MIsaON2rY4WCu9QlpsDZahNgwg4IDo77Ks6gQboWj/p/lWRsq8gd6lZ7kzdy+DXVnHtS1Los
	g/sy312Mudtci+GV2ctr3+HoQF4pZpCGRek4AojQUAChv3XavVcb8VcQkXzdtJ/Bu16xfvbyXUo
	wcpwEUYijqfro4/AsJjdZStkpofuyjVAxKit5BCuUbPUAN5BY=
X-Received: by 2002:a17:902:e806:b0:2c6:a078:bfb7 with SMTP id d9443c01a7336-2ccff8dc9a5mr327665ad.7.1783532538783;
        Wed, 08 Jul 2026 10:42:18 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b609acsm7268238b3a.1.2026.07.08.10.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:42:18 -0700 (PDT)
Date: Wed, 8 Jul 2026 17:42:12 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] kho: Support preserving unsplit high-order pages
Message-ID: <ak6L9G-x72n2kY7B@google.com>
References: <20260703020832.1731864-1-praan@google.com>
 <178341290876.3292146.16538284698967245356.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178341290876.3292146.16538284698967245356.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_104220_386378_6268FC14 
X-CRM114-Status: GOOD (  32.00  )
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

On Tue, Jul 07, 2026 at 11:28:28AM +0300, Mike Rapoport wrote:
> > This series is required for the ongoing effort to preserve DMA allocations
> > across KHO [1]. It addresses a fundamental mismatch between the current KHO
> > restoration logic and adds support for high-order buddy allocations.
> > 
> > The Problem
> > ===========
> > The current KHO restore implementation treats all multi-page blocks as
> > split pages during restoration, i.e. kho_restore_pages() initializes
> > every 4KB page with a refcount of 1.
> > 
> > However, many kernel subsystems, most notably the DMA allocator (via
> > dma_alloc_coherent), frequently return high-order non-compound pages.
> > In this unsplit state, only the head page carries a refcount of 1,
> > while all tail pages have a reference count of 0.
> > 
> > Consequently, when these contiguous but unsplit blocks are restored by
> > KHO in the new kernel, the forced refcount of 1 on tail pages causes some
> > trouble with the buddy allocator. Downstream of the eventual free path
> > the __free_pages_prepare() [2] ends up calling page_expected_state() [3]
> > when is_check_pages_enabled() returns true (only when CONFIG_DEBUG_VM or
> > debug_pagealloc=on).
> > 
> > This detects the non-zero refcounts on tail pages [4] and incorrectly
> > taints the kernel while leaking the pages in question.
> > 
> > Proposed Solution
> > =================
> > This series introduces a "Page Type" field to the KHO ABI to track the
> > refcount pattern of the preserved pages.
> > 
> > 1. KHO detects the physical state (CONTIG vs SPLIT) during preservation
> >    by peeking at the refcount of the second page in each buddy block.
> > 
> > 2. The type bit is preserved in the high bits of the KHO radix tree key
> >    (Bit 63) and stashed in page->private metadata during boot.
> 
> This brings a broader question - what is the best way to deal with page
> metadata. This particular case requires only a single bit and luckily we
> have a few spare high bits in the radix tree key. But what if going
> forward we'll need more than a few bits? Do we need a parallel data
> structure for the page metadata? Or something in kho_radix_leaf in
> addition to the bitmap?
> 
> I'm not saying that a generic solution for page metadata must be a part
> of this series, but we definitely need to consider and better sooner
> than later.

Ack. I agree that regarding page metadata, we are limited by the 
available bits in the Radix key (and as discussed with Pratysh on the 
other thread it increases the memory usage too). I guess we need more
complex metadata in the future, a parallel data structure or expanding
struct kho_radix_leaf to include a metadata array alongside the bitmap
should be better in the long-ter I guess?

> 
> > 3. kho_restore_page() applies the correct refcount pattern based on the
> >    preserved metadata.
> > 
> > 4. A new helper, kho_split_preserved_pages(), is provided for subsystems
> >    that may need to split memory after it has already been preserved.
> > 
> > Considerations
> > ==============
> > 
> > 1. A primary goal of this approach is to prevent driver/subsystem code
> >    from peeking into MM internals. Drivers should not need to understand
> >    the distinction between head/tail pages or compound metadata. The KHO
> >    core handles this internally.
> > 
> > 2. To handle rare cases where a caller might wish to split a high-order
> >    block after preservation, we provide kho_split_preserved_pages().
> 
> Do you have anything particular in mind?

Not really, I guess I was thinking of an edge case and attempted to
handle it this way. We could very well write this in the kdoc that the
caller who wants to do this must unpreserve first.

> 
> -- 
> Sincerely yours,
> Mike.
> 

Thanks,
Praan


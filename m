Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24228C43458
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 17:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xmyFw2R0UQPIDfzvj9wMwsWmgYLjmqNhoTqDamPgvg8=; b=jWJ41LRAdhpmaI0MELr4MkusUU
	Kg8qbYLYWpsXl2Sxno/sVSrot4eBNer5BpDJf+t8Z7RjDaiE9WvXmPr9kJvHNgIKTD3bxgXA4aRJA
	RmJlK+C9tcZ6n2wKR+i1ihvtt61m6Tdh4FfzgIxk5CBAKFoDRYVSeN+hwVShC2WsoFy/9IIYm+7Qd
	/2pkxwFhNmGHHJZGzoo2TOLmI8rHcO3Xaa35d1YJde1GaRc7pr5pnS+P918sZhHQMq0CQw6VhNL/v
	aeUUt4V8MZXfQiGm7LbDHFZ3z/7DSAPVRS3rGvykZeaZWXMPfk7SihGhwyXnMR/GMX7Me/zcGfR22
	EnzyiBDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whWJz-0000000083s-0FO8;
	Wed, 08 Jul 2026 17:44:31 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whWJx-0000000083M-1coh
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 17:44:30 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2cb59f6ba26so9585ad.0
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783532669; x=1784137469; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xmyFw2R0UQPIDfzvj9wMwsWmgYLjmqNhoTqDamPgvg8=;
        b=QwG+l6XzfoyJT/V9oKxzrl4998y8xPvyFrnJbweRUFfUeXBUKsQGB1iLLMeFwWdo9Z
         tZFSAOOkqgUXkrBhwQ1VjAHKFLbYJQen0yYfOhwC+i034Vgb/IEC9ixPtQDwgqJfVAbs
         BMqCrdiRzXBuk9KewK8kWswmjYB0z7N3YaqITBdPjRGY4HujC0rDtGNm6FxGH/7AwIIR
         fjn+ikKeiC7hWA09eSVjhCm9M9La0H7kZBIHEMC0Xg5/qiXBAFy/ICKU/BcizzSK7kHm
         5UC/uoxSdjblsT41LhO1ae9v81IVFmAIjBU5Ep9ygoNs+1w8gnjVqLd1qlLi0oOWWugr
         oaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783532669; x=1784137469;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xmyFw2R0UQPIDfzvj9wMwsWmgYLjmqNhoTqDamPgvg8=;
        b=dzOSmlnlRCkx8SNaZoc0KhPiGtGcEsGVPSttTEQTYLu4uuTOT0KO4MXwNTfRkQP8f+
         ST568peEVxpHTbFDO22mXyrdyFpYtGIuvMMb5BBNOcqTL/BVTiMQFYWVUpwJ7Aauyp5g
         G7Qx4iExWTBjrY4RX9oaL4YIGDVA1Yd5J+fwTp2sL15Fd9VpijP3M2tKwfCBUAvR18Pt
         ZWdfH6hFQfqhKPY9Jl7aULf0E61Kca8EyOUz9xOREXm+ONHeejzV+OaChCD/EKWO5H7B
         3BSKGbYzcPIn99CKt71TC9YvwJUxg7qsdB9P6DFsupGed9KMjBCUQLmTm4Tv92w6LgQL
         0q2g==
X-Forwarded-Encrypted: i=1; AHgh+RqN2tfsSPDja17maenNWUHzYMsjPosubHFwNetEJ/4ndRTb6w4XPY9J5BdpyKfilfD7RkBIgg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwbfDDlyGFXNAoni9wOl4m8f7EPoE+SVD5NCrECEDb1Jog/DgNb
	aDQnm5uvnWM3Yh2602y4V4LNZvN029gOYmAJUoru8H1QD7coVDG41gumX5P5Tvsp1A==
X-Gm-Gg: AfdE7cmtg9JKmWSFHbg/ul5BBCCnKI4GHG7WthectzgFkdPoMpG10bIZA9X+wOVgvWc
	6ZgbYJYnj91gPatRNbhixAU4HUGikbFSxfg6TKCJVLglEM/M4ROKadjUwm5sVS621KARpvuAcF+
	48asqjyWOvPzkJPmSvcxXoejU/DratmNqszWUIW0qEjaS3EWVYiVkVnHdiazgWvEGVLQlmW+NHD
	22XYwVQXrgzd10qQuhND9n1dyKe+PgYxES1ZNDSFJpLZSwog+DuFjxRddvCU/FnDZctJ+psdjet
	/Qau+JNbMtclDcPweOO3Bw37N6g/QJIVMMXrBmIiyPB4dMl5QeSaib/nrgNtpC0yH/yCDxQynT9
	hkEPHeRg/lTCiZC4l9d9IfqucC7ufDYY4/y0eInzyoRZbadCcy2ZfXeBe0ZyLwiihhERhoUWy1w
	dxOmwha4gx/H4OgRAaWH9CDcvFJ/Mx+L6xvT5hX2ealXu7jts=
X-Received: by 2002:a17:903:38d0:b0:2cc:7759:ffcf with SMTP id d9443c01a7336-2ccff916ae6mr403275ad.17.1783532668070;
        Wed, 08 Jul 2026 10:44:28 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb746sm30815595ad.7.2026.07.08.10.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:44:27 -0700 (PDT)
Date: Wed, 8 Jul 2026 17:44:22 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] kho: Support preserving unsplit high-order pages
Message-ID: <ak6Mdp45x8TGNOPP@google.com>
References: <20260703020832.1731864-1-praan@google.com>
 <2vxz7bn5mv0n.fsf@kernel.org>
 <ak57VeunO8qd4wEh@google.com>
 <ak6DUC7NsIZ20RZD@google.com>
 <ak6FJf8jUGudEw0c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak6FJf8jUGudEw0c@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_104429_435555_A701A3EB 
X-CRM114-Status: GOOD (  30.98  )
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

On Wed, Jul 08, 2026 at 05:14:40PM +0000, Samiullah Khawaja wrote:
> On Wed, Jul 08, 2026 at 05:05:20PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jul 08, 2026 at 04:36:46PM +0000, Samiullah Khawaja wrote:
> > > On Wed, Jul 08, 2026 at 04:11:04PM +0200, Pratyush Yadav wrote:
> > > > On Fri, Jul 03 2026, Pranjal Shrivastava wrote:
> > > >
> > > 
> > > [snip]
> > > > >
> > > > > 3. kho_restore_page() applies the correct refcount pattern based on the
> > > > >    preserved metadata.
> > > >
> > > > Why do you need to save the type of pages in KHO metadata? For example,
> > > > for pages or folios, we don't store any type information and leave it to
> > > > the caller choose the right API. So reserve-mem and kho vmalloc need
> > > > pages, they can call kho_{preserve,restore}_pages(), and memfd needs
> > > > folios so it can call kho_{preserve,restore}_folio(). The radix tree
> > > > itself does not hold the information. The caller knows what its memory
> > > > is supposed to be so it calls the right restore API.
> > > >
> > > > So why can't we add a kho_{preserve,restore}_page_multi() (pick a better
> > > > name; we can argue about the naming later)? Then your driver knows it is
> > > > restoring DMA buffers so it can call kho_restore_page_multi(), and KHO
> > > > takes care of initializing the pages with the right refcounts.
> > > >
> > > > You won't have to muck about with the ABI in that case.
> > > 
> > > +1
> > > 
> > > I think this makes sense. The mm already relies on the allocator to
> > > track the type of pages it has and expectes it to use free_pages or
> > > put_page() or free_page(), so it is natural for KHO to rely on the
> > > caller to call the right restore API.
> > > 
> > > Lets add kho_preserve/restore_page_contig|_order|_nonsplit and the dma
> > > preservation can use the appropriate one during restore.
> > 
> > Ack. I like kho_restore_contig, I don't think we'll need a preserve for
> > this though? Preserve doesn't seem to be preserving refcounts, I guess
> > we could rely on kho_preserve_pages and the caller can use
> > kho_restore_pages_contig() to set refcount correctly for unsplit pages?
> 
> I think for consistency we can add both, even if preserve doesn't do
> anything special internally.

Ack, alright.

> > 
> > Thanks
> > Praan
> 
> Sami

Praan


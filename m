Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C9606A33A
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sOS8Rrzz;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QW7MK1KM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/GSWuUudINQ5InmDwWsy8zWhwr+7Kpnc2mR1mJL4+KA=; b=sOS8Rrzzu62VbvExXHJh4D4Qpj
	bGKX0DA4S1a8f9PgEleykOKvbHWXmcVwWo66ZP01he/FMKjP12trAyi+Q2QS5In4TJdD27igQYPoK
	p2uESBe4yNZbuQwj6bmkNJFF+L2Q8BZiLOKgp3bMtCPEZ2x0JwZq6fJF4l4mIHwN5iiX5pxyB7jL3
	04Tv2u0rhSTHntLm6IM2fHUIaJ7LNpr4nYC71d9pW8LVW9LW9WpzTC3kizWwSzGXlTDp6pLJu15x/
	rd3QzsmfajD6YLZqqIsCHHumo2/0IKjzTYkegBU21qy5MQ1IsGVydw6VrkPHpig/KLWylVw1d+jcN
	7WLzFZqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR3Kn-00000005z5D-1a3M;
	Wed, 11 Nov 2026 08:05:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR3Kl-00000005z57-3gof
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 08:05:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9F6C644D84;
	Wed, 11 Nov 2026 08:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E491F00A06;
	Wed, 11 Nov 2026 08:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384331;
	bh=/GSWuUudINQ5InmDwWsy8zWhwr+7Kpnc2mR1mJL4+KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QW7MK1KMPShmXAzj2tGBuE1vD3/CnUjJJ6qz1x6814x0dF88RS2ylZ3oJGCJXWldl
	 oCmk98Qi2QHSbNYVhnD9ZYNfgT3mhaWRKSEXXHWtCRQHb81g1edSgty+bDEAXPjMXb
	 f2/15FBZNATOuZsxuXJtN7a24+G3vHnH9k0HGG7q62QmKPCjV0zRedYRvAKLUvt1dZ
	 t1UfZbr1OFwF+Fm7gcNyaT99SpdKSLOcF0K4IOG6BELRlA4/pZWDxY+2G264tU/YWG
	 UulKdXOxLH0wx8yH08+Ct/GNXMTPS3DgKrcax3Zgz0oChXeTaigr28d1hsFazZJzf2
	 OT9H6SrQywRUw==
Date: Wed, 11 Nov 2026 10:05:26 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/memfd_luo: don't use memfd_pin_folios()
Message-ID: <avQhxo-dVGdvcHK6@kernel.org>
References: <20261103172251.2348370-1-pratyush@kernel.org>
 <179381215936.28814.9050829645096838793.b4-review@b4>
 <2vxzse18h9j5.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzse18h9j5.fsf@kernel.org>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 06:38:06PM +0100, Pratyush Yadav wrote:
> On Wed, Nov 04 2026, Mike Rapoport wrote:
> 
> >> +/*
> >> + * Move a folio out of ZONE_MOVABLE or CMA, so it can be held until the next
> >
> > "held until next kernel" - here and below - I feel that something is off
> > here, but can't pinpoint what exactly.
> 
> Hmm, perhaps this:
> 
>     Preservation holds a longterm reference on the folio. This would
>     block migration in ZONE_MOVABLE or CMA. Move it out.
>
> ?
> 
> >
> >> + * kernel. Called with a reference on the unlocked folio, which is always
> >> + * dropped. The caller must look up the folio again afterwards.
> >
> > I'm having hard time parsing "called with a reference" sentence :)
> 
> What about this:
> 
>      Must be called with folio unlocked. Drops the reference to folio.
>      The caller must look it up again.

Ack for both :)
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.


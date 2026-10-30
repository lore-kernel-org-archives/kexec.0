Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597F606A325
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hVcI8JsB;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKBGo9SZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=v82mzkt/jt6jPtl1ei1Iq8wfRsMZYKIpIpg9HbC5F18=; b=hVcI8JsBxRVJZSvL1dPr60VoOH
	z/ZZFW/Id4PsCTlwYFe559j6OA9Kc4nvf6L/ilauYlFOnjpjYQ3NS5I/cSWW60zyZkp61DxUoLv6y
	z8rg85I/+sK/DaGWBInsSPqNxhuIyyOFwDkVN0PpfRB031AIV9ywz1FDJO1Px2su8EiD5ktKWxHSh
	gkRFB2mYeEUrGW7qpgTShZbXLXsMKq3i9etuJYgcoiFcneBxSq7ROMD/MGXWLgc+2I5uez12AXMIP
	eeEODGxB1N1HB0+2jdr75+s+K/0ElQ12eTErbyOZ66aVIp2AhNeZ9T1qEv9HmYTLX2TUIAM/d+x1H
	JUrjSYRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMlL6-0000000Bcz9-3zUf;
	Fri, 30 Oct 2026 12:04:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMlL5-0000000BcyZ-1N6u
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 12:04:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7015543602;
	Fri, 30 Oct 2026 12:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CDA1F000C1;
	Fri, 30 Oct 2026 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793361846;
	bh=v82mzkt/jt6jPtl1ei1Iq8wfRsMZYKIpIpg9HbC5F18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bKBGo9SZfxwjC/Xfqsy4J8CcQ7x1O4QhOR3H1pnysW62FBdsJRwtCvOy28QHYKcR3
	 VrjQ0tY9EXaol2fM77uzLHD7pYPlEk1J4x6OdzYA1y0Ma0UuT1ivg5wMECjifl0Utv
	 rUnI08CGpjcSJYa7vDOHCTTh8HAsV/KOVk2/4x8DzYVbujacQUZBbpImkrVWvouKx0
	 QcRuEbgagwyuFa0f3k/RGb/l7/6udXYs+QS3xtQ430YisTQ2zEg/YjK8JAM/8p3iYH
	 Da5Q8yZeBa+apnfcjjbIDPFYbLXav/zsReh2gHHinKOyVPyxzeM59lHemtrjCLDefk
	 jVON88cHrKDnw==
Date: Fri, 30 Oct 2026 14:03:57 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Pandey, Radhey Shyam" <radheys@amd.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, baoquan.he@linux.dev, pasha.tatashin@soleen.com,
	graf@amazon.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [RFC PATCH 1/2] kexec: do not place the next kernel in a
 fixed-address CMA area
Message-ID: <auSHrdDdFrWRsuzM@kernel.org>
References: <20261014145731.3431527-1-radhey.shyam.pandey@amd.com>
 <20261014145731.3431527-2-radhey.shyam.pandey@amd.com>
 <2vxzh5i5orbv.fsf@kernel.org>
 <auL3UW2InVqYU6Fs@kernel.org>
 <2vxzzevwmz2v.fsf@kernel.org>
 <7625fa23-5f4b-4658-b17a-fe4e58103e7c@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7625fa23-5f4b-4658-b17a-fe4e58103e7c@amd.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 01:22:50PM +0530, Pandey, Radhey Shyam wrote:
> On 10/29/2026 6:41 PM, Pratyush Yadav wrote:
> > On Thu, Oct 29 2026, Mike Rapoport wrote:
> > > On Wed, Oct 28, 2026 at 03:03:16PM +0100, Pratyush Yadav wrote:
> > > > On Wed, Oct 14 2026, Radhey Shyam Pandey wrote:
> > > > > @@ -304,6 +317,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
> > > > >   	cma->ranges[0].count = cma->count;
> > > > >   	cma->nranges = 1;
> > > > >   	cma->nid = NUMA_NO_NODE;
> > > > > +	set_bit(CMA_FIXED_BASE, &cma->flags);
> > > > >   	*res_cma = cma;
> > > > > @@ -517,6 +531,8 @@ static int __init __cma_declare_contiguous_nid(phys_addr_t *basep,
> > > > >   	}
> > > > >   	(*res_cma)->nid = nid;
> > > > > +	if (!fixed)
> > > > > +		clear_bit(CMA_FIXED_BASE, &(*res_cma)->flags);
> > > > 
> > > > Nit: This reads a bit odd. cma_init_reserved_mem() sets the fixed base
> > > > and then you clear it later. Wouldn't it be better to just pass the
> > > > fixed boolean to cma_init_reserved_mem()?
> > > 
> > > Actually, we shouldn't expose cma_init_reserved_mem() at all.
> > > 
> > > The current callers of cma_init_reserved_mem() should be switched to
> > > cma_declare_contiguous_nid() that does sanity checks before calling
> > > cma_init_reserved_mem().
> 
> Thanks Pratyush and Mike for the review.
> 
> The switch from cma_init_reserved_mem() to cma_declare_contiguous_nid()
> looks like a broader CMA refactoring and requires additional changes to work
> correctly.

Hmm, you are right.

How about we invert the flag meaning?
Than cma_declare_contiguous_* will set it where appropriate and we won't
have the weirdness Pratyush pointed out.

And Radhey, please, make your LLM to spill more concise and to the point
text and teach it to trim emails ;-)

> Thanks,
> Radhey
> 

-- 
Sincerely yours,
Mike.


Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC21606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YeDeO33V;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=AtDCD1kv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RsAyHrXNfqX02yWykA3lATIbdnc5zjm5tP62HlWexE4=; b=YeDeO33V5WBSpKRrJcO48Jgtzl
	S1N7Kvymmpdz9L9nTYKORhuxL3v6hmBa6925gPeSxcnBbioOKg3VI8VW7O3BWvvXgMhhtTvwOLhUv
	GzMlrfM5uxkE9HAnbTLHrWSqARXxrrWHVaNFKBKMpFFtg8HA2tClfXNBfF07SuPQ0TRblhrxy4pls
	TFlOSj6kVVStG+h7v9uSghPJXEG7XOAY56CHBJTkhrSMWqo56SwUi9DUovd8R9XbzLCLMCdq8qsXI
	i3k955A9giHa3mo7uFF3J0231llASJkMzbL74rNepZJObdvJ4S/4g+WefcDE+3w9ePb0rPVzW7NCN
	tmX7cYsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcyK-00000005neq-2Npx;
	Wed, 04 Nov 2026 15:32:20 +0000
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcyI-00000005ndx-0xim
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 15:32:19 +0000
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-7cc91ddf447so256205137.2
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 07:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793806337; x=1794411137; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RsAyHrXNfqX02yWykA3lATIbdnc5zjm5tP62HlWexE4=;
        b=AtDCD1kvdMOIydaAf2ZU5VmuRZayk3QkpOo9BA6dpUCgnwTgdfRoGmLxHPa242I4B1
         DQXkaDF4RBti0XCDKxLvkKXy1FZ8GDTPf+5JARUgRynOas4WPmskRJT9g2qYisSYwvb0
         K/DR1E0CqHUqGcNW36g1s5/9CDifdUIUlLkVVUNsFkz3j1WTj6hj0GOW/FivhLDTfWvJ
         UVAjc6B+7oZxKqklWyNd5L6RZoiAgBIIlE0JgdF2iknbNHsFoMf4v2hTt93GekZX7pn9
         FqsuIm54EbfpJO8fw8raphMR+33hjBtvMjzF/BskuGeVyl7SbWsMl1FGIviwAaQklxZC
         zOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806337; x=1794411137;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RsAyHrXNfqX02yWykA3lATIbdnc5zjm5tP62HlWexE4=;
        b=mZ88H+kstJdkymxVh5M5Qy1LAR7IcKr7Ev76+WcIy6MOV0Ygq1PZfFLAmlgxPOQ0vX
         FA8Un+USMIyUbKRvDizJe517aX/yR3ZBwd2WqD87qMfOJWuNyHVG+vw4oZHZdfEil+Mu
         tLIQ2cM2CTiNwuGXcaMU84l3ohkCRh05kSuMunZC17QrvkFOWM9U9tlNaGmed4MriSKy
         8ECqPqePi7nSBCpehfYV+8rabw9mt1aSyELddyUxJtrW+mucS4g+T6N0KCaSFj4qHwIT
         m3yQvWKQV83o9oTFOHLhgvYe6AWP3Q1bSFPo+yAEgsJbscrVeqYdQAPCLWiLOXwLKjR+
         3JYg==
X-Forwarded-Encrypted: i=1; AKwUvBwiSsbQ1ZMpbvQwMKWFCS3NUdWws/XuGQCh6Z8uwzn6ujw7chOnmAW9BAT/cdcgISDPLaLtlQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z87bIEUCIr4jQXFtl5Uar9NBqvdd17wjM+N6XsES79SWfNOKrQo
	1PpcqYEbQG67/TbgFtxVwJan6e54/nIaprUq5ym+bQsYLOIIMBvatSScfXe3QhxPfjU=
X-Gm-Gg: AYBFou1Wvb7hRMrY+S6GAw0cQITWyPzuzIshVVKZedZDXkSrok+BQPBE4/xRvFo/nOv
	CKThuzVMqAhDyQcrLdIgemjgn30E11LYBz3jcguUnPF5yQzxjTldo8NqzlFVryZzg5jbuGaLK/6
	fjjQLs/e6F2kt+bF5J4f7iQ574kOblO8dgCJ2ok1/nnQngRNGVg8gJwuGh/UBUL8vSz2EPN2K/1
	t3TFz0EMWlD85sYf6ypUBbwLWrPalXecix4PbtNxcWIs702d8qPAF3Q5pdMVJowCGmShMT1k9zW
	bKNp+MS0lxmxG/viHYQTEm9lCmWn5MDbXBOIKFc/qZu3aIDMGPoBZMx7SD5wOCcsSsyjNpSIVYB
	Ap2CvP/eEKnbWljSI+ALhB5Ig5jnM8pa5mKAYrDBuYY6wGGJKdRod/acIq4spiGP0rvR2Za7vwM
	n4ex0ba762ERJBrWZ66fYtWyi2k/ivfxdZm84ih8J4pAqusXm4282zxcn8W7SFJXEfenkUJCPTg
	F9ECHqfr1T/5d/RknonR9kE3JR3XBe+2VD5SVSVAqWUBfIOv6orVPLoqSyHV626NPuUnGC3bTZb
	QakEe+Xa9kW9hUeLMYE/cOo/nc79mpLmfeFHnrDFJvI2uANKcJG3A+G4i5B33d7ZMSsndmH85Mp
	2BOKrh+yMotA1bl7s8Rsz+2//NmrgJng=
X-Received: by 2002:a05:6102:e0d:b0:7bd:b263:14c8 with SMTP id ada2fe7eead31-7d072784174mr5342781137.30.1793806336602;
        Wed, 04 Nov 2026 07:32:16 -0800 (PST)
Received: from google.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2770ffbb4sm1208724137.0.2026.11.04.07.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:32:15 -0800 (PST)
Date: Wed, 4 Nov 2026 10:32:14 -0500
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Pei <cp0613@linux.alibaba.com>, 
	George Guo <guodongtai@kylinos.cn>, Kexin Liu <liukexin@kylinos.cn>, 
	Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] kho: skip zero-sized lowmem and global bootmem areas
Message-ID: <autM3_pSLuOGZQCh@google.com>
References: <20261103-kho-bootmem-sizing-v1-0-45aa74098f34@kernel.org>
 <20261103-kho-bootmem-sizing-v1-1-45aa74098f34@kernel.org>
 <auo3PzmisfK3br1l@google.com>
 <ausVbqZd9qgZf4zc@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ausVbqZd9qgZf4zc@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_073218_287902_90C6BC1F 
X-CRM114-Status: GOOD (  38.97  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11-04 13:22, Mike Rapoport wrote:
> On Tue, Nov 03, 2026 at 02:48:36PM -0500, Pasha Tatashin wrote:
> > On 11-03 13:49, Mike Rapoport (Microsoft) wrote:
> > > The lowmem and the global bootmem areas can have zero size, for example
> > > when none or all of the memory is below ARCH_LOW_ADDRESS_LIMIT, or when
> > > either of those areas is explicitly set to zero with kho_bootmem=.
> > > 
> > > For a zero-sized allocation memblock returns an address without reserving
> > > anything, and that empty area is recorded in kho_bootmem. If there is no
> > > memory below ARCH_LOW_ADDRESS_LIMIT, allocation of the empty lowmem area
> > > fails and KHO gets disabled.
> > > 
> > > Extract a helper that checks for zero size and allocates memory from
> > > memblock, and use it to skip empty areas the same way as empty per-node
> > > areas are skipped.
> > > 
> > > Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> > > Reported-by: Chen Pei <cp0613@linux.alibaba.com>
> > > Closes: https://lore.kernel.org/all/20261026131851.9942-1-cp0613@linux.alibaba.com
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > ---
> > >  kernel/liveupdate/kexec_handover.c | 61 ++++++++++++++++++--------------------
> > >  1 file changed, 29 insertions(+), 32 deletions(-)
> > > 
> > > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > > index 6f1f55fe31819..f268c57413a7e 100644
> > > --- a/kernel/liveupdate/kexec_handover.c
> > > +++ b/kernel/liveupdate/kexec_handover.c
> > > @@ -820,6 +820,27 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
> > >  	return false;
> > >  }
> > >  
> > > +static int __init kho_reserve_bootmem_area(int *idx, phys_addr_t size,
> > > +					   phys_addr_t end, int nid)
> > > +{
> > > +	phys_addr_t addr;
> > > +	int i = *idx;
> > > +
> > > +	if (!size)
> > > +		return 0;
> > > +
> > > +	addr = memblock_alloc_range_nid(size, BOOTMEM_ALIGNMENT_BYTES, 0, end,
> > > +					nid, true);
> > > +	if (!addr)
> > > +		return -ENOMEM;
> > > +
> > > +	kho_bootmem[i].addr = addr;
> > > +	kho_bootmem[i].size = size;
> > > +	*idx = i + 1;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /**
> > >   * kho_reserve_bootmem - Reserve a contiguous chunk of memory for kexec
> > >   *
> > > @@ -832,7 +853,7 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
> > >  static void __init kho_reserve_bootmem(void)
> > >  {
> > >  	int nid, i = 0, max_nr_bootmem;
> > > -	phys_addr_t addr, size;
> > > +	phys_addr_t size;
> > >  
> > >  	if (!kho_enable)
> > >  		return;
> > > @@ -852,56 +873,32 @@ static void __init kho_reserve_bootmem(void)
> > >  	 * reserve bootmem area in low memory for lowmem allocations in the
> > >  	 * next kernel
> > >  	 */
> > > -	size = bootmem_size_lowmem;
> > > -	addr = memblock_phys_alloc_range(size, BOOTMEM_ALIGNMENT_BYTES, 0,
> > > -					 ARCH_LOW_ADDRESS_LIMIT);
> > > -	if (!addr) {
> > > +	if (kho_reserve_bootmem_area(&i, bootmem_size_lowmem,
> > > +				     ARCH_LOW_ADDRESS_LIMIT, NUMA_NO_NODE)) {
> > >  		pr_err("Failed to reserve lowmem bootmem\n");
> > 
> > You are adding a helper that returns an error code and then ignoring it 
> > at all call sites. Even though it can only return -ENOMEM right now, 
> > dropping the return value is not good practice.
> 
> I don't think error code is important here.

Perhaps, but it is just not elegant to add a function that returns an 
error, call that function from three places, and ignore that error every 
time.

What is wrong with:

err = kho_reserve_bootmem_area(...);
if (err) {
        pr_err("Failed to reserve lowmem bootmem: %pe\n", ERR_PTR(err));
        ...
}

> Even if some theoretical future update will change
> kho_reserve_bootmem_area() to return anything but -ENOMEM I don't see why
> the error code should be printed at all.
> 
> And anyway, that would be the part of that change.

I just don't see why not do it right away? If the function is only used 
as a boolean check, then just make it return a bool, and move prints 
inside.

In any case, this is not critical and I am not insisting on the change, 
but I think it would look better.

> 
> -- 
> Sincerely yours,
> Mike.

-- 
Pasha


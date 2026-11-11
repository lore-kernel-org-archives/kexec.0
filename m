Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83C2606A33B
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lZyEBF7A;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPQ/W3tB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QWs1gzgqO1A59hoKs3tuMBi4edD/w8k5cYwrGVQ+cB0=; b=lZyEBF7AE2arBggj9d7B+ow1hY
	0HWqE1mitGL4LrfpjbAoHc/ru6zhQ3gW62cKLMcDkxJVNSctpmThhIkOqYrEhgg+7UWRXiuEhUYtm
	JF6hwQoY4X72aKX39IZ+q450q7MwoyJvL6nf3FeCusWZDgOWSI1V5s8Kzs0tKdXjZL6POlIUhHy3W
	/h2KzKauPaVF8qhJjvsv1QMmEJXxw2oNMBHZuzqXtXwq2rG7AOgoB+i06rgth4fwidzWtyAkLYMX3
	ReMBdxQ+T1LK7OKU3viTWBL4XVQEIk/QRQ1oOiNaKhtIkQYba5/bURuamhWZRWJ5e35nW5zQ84INH
	XearWuWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR4TA-000000069ER-44AJ;
	Wed, 11 Nov 2026 09:18:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR4T9-000000069Dp-2HVZ
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 09:18:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9CB9F63BB0;
	Wed, 11 Nov 2026 09:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CCA1F00A05;
	Wed, 11 Nov 2026 09:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794388694;
	bh=QWs1gzgqO1A59hoKs3tuMBi4edD/w8k5cYwrGVQ+cB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nPQ/W3tBH7IXMyeKIqwMvWCKjOnatvPKh87fP3UWoe4psnTdQu3w//a4sVvyE5zyz
	 WF6vpLmRhLQ185mGVjNFBZhQ7xCxtNeg3hFPeJzQXaTIUVMFg/S3s9Qe1Cxt8RCkJF
	 HhDBZ6WdHgptQZ2NRfBJiRcBr5kB7SouvZozxUO2+UN1neTwxcLQmC61yWu1KPQ6by
	 gwpvXemy6XTmp/oBzm6UWZvKSQ0ZwHAhr3GU5rLIhfedrpY5pUWiqZLQpnLKj4hkNR
	 5zs8NjAKyNYimLPdfruEqZ6OUkajo6zoVMkPD0cWEzSrrHnr+VdqzG9d/rcN2NXPxd
	 95DJQsE3IFJIA==
Date: Wed, 11 Nov 2026 11:18:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] kho: Prevent reuse of preserved pages after a
 reservation failure
Message-ID: <avQy0MUl6eOplwhh@kernel.org>
References: <avQUquBK6cO6tUUI@chrisdown.name>
 <avQg0_jFY3get3wG@kernel.org>
 <avQka0wY-EdLkspv@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avQka0wY-EdLkspv@chrisdown.name>
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

On Wed, Nov 11, 2026 at 12:16:43AM -0800, Chris Down wrote:
> Hi Mike,
> 
> Mike Rapoport writes:
> > On Tue, Nov 10, 2026 at 11:09:30PM -0800, Chris Down wrote:
> > > kho_preserved_memory_reserve() reserves each range of preserved memory
> > > in memblock and marks it noinit, but ignores both return values. Either
> > > can fail when memblock has to grow its reserved array and can't find
> > > room, which at this point in boot it may only take from KHO bootmem.
> > 
> > Is it an LLM analysis or you seen this happen?
> 
> Are those the only two options nowadays! :-) In this case it's just eyeballs.

Didn't think anybody still uses those :)
Kudos!
 
> I happened to notice this while preparing my KHO/LUO observability patchset
> and thought it made sense to send as a separate patch, since it doesn't
> depend on anything there.
> 
> It's probably realistically quite unlikely, I would think it would require a
> lot of fragmentation or a very small kho_bootmem=.

It's unlikely indeed and if that happens we'll panic on memory map
allocation anyway :)
 
> > > Dropping the handover at this point isn't safe either. reserve_mem=
> > > revives its regions from the handover before mm_core_init(), and
> > > relies on this walk to reserve them.
> > 
> > reserve_mem_kho_revive() can memblock_reserve() its memory itself and we
> > can carry on, can't we?
> 
> Thanks, that's better. I had thought carryong on wasn't possible because
> reserve_mem has already reserved its regions by the time we get to the walk,
> but actually you're right that there's no reason reserve_mem_kho_revive()
> can't just do it itself...
> 
> Looking at the code one thing we would likely trip over then is that
> kho_mem_retrieve()'s error path only clears fdt_phys, but not bootmem_phys.
> kho_init() then thinks that it's a cold boot and runs
> init_cma_reserved_pageblock() over the inherited bootmem which has already
> been handed to the buddy allocator, so this would need adjustment first.
> 
> So then, let me send v2 with reserve_mem_kho_revive() sorting out its own
> range, and making kho_init() skip the bootmem setup when the bootmem was
> inherited, if that sounds good?

Yeah, just keep them as two patches please :)
 
> Thanks!
> 
> Chris

-- 
Sincerely yours,
Mike.


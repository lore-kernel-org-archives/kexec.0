Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475E9606A33A
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2LAKgpVt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzQFw0Fc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PhlIWW6g3N+AFu1LsfAztQ3Wt3gvl8nW98AXZASgM/A=; b=2LAKgpVtq36lsSR3oXP1CUbD/D
	gamshzk7+Z36qNPbOHiejZyufq8tyd58lk6PpUPhA+9DHiodoj2KqFsJJVhkam9C15GL2ubMC0sGp
	Wm/vOYvuw65LO64hITSM2kNH+xQyumP1Ye0aa4N91L8boQVSN8DUZR7GY509PNgRuMeneeVXeTuiO
	tICpCDZU6eNiA5AQ7O5BM8j46FL3TPwyy0MnN98FiyIghiTNLZcdLXejO+832v2PxhOF+F2ULrUWh
	B1xz8bWfJ/MRi5CMBKQJxGoefzKnz5axUzYYZiZHNiP6jtEHURaKxjuy2qKtPso9O7ELZ8lgm9aGm
	F4sJHHOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOZ4a-000000058V5-38h9;
	Wed, 04 Nov 2026 11:22:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOZ4Z-000000058Um-1Tdm
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 11:22:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AF6FB43558;
	Wed,  4 Nov 2026 11:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC30B1F00A16;
	Wed,  4 Nov 2026 11:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793791350;
	bh=PhlIWW6g3N+AFu1LsfAztQ3Wt3gvl8nW98AXZASgM/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PzQFw0FctCGUG1qHhQ27pa7aqyd7BxJUFvbnrW/uv19RT1NEp+QBsPx9tWUT0MRKZ
	 EP/IgnjNU2qQXaN6ydBSAjnVmbibh1JigkN4pF0k4b4TVFlN6vXgsHaMIv4OLWjbtW
	 9JZAxCVdX8vntYR8F2GsWdf0v+5nIZntQeHoeycoXS6Lh2ud8VSmqn3XOp3F5vl6Gk
	 1UEiBKOXa+yKIeI0dmRVCCjCuoSXB1eQLxtei9hnz4GTO95SjGcSospGRBVSQlJ3qW
	 ekL/wjVM9kPF4GBBy0057j6cy9SYv1Kl52peqE0i5VtsYdAP5nRfejwHQD75bTPkD2
	 5zQx0FPWv/hpg==
Date: Wed, 4 Nov 2026 13:22:22 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Pei <cp0613@linux.alibaba.com>,
	George Guo <guodongtai@kylinos.cn>, Kexin Liu <liukexin@kylinos.cn>,
	Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] kho: skip zero-sized lowmem and global bootmem areas
Message-ID: <ausVbqZd9qgZf4zc@kernel.org>
References: <20261103-kho-bootmem-sizing-v1-0-45aa74098f34@kernel.org>
 <20261103-kho-bootmem-sizing-v1-1-45aa74098f34@kernel.org>
 <auo3PzmisfK3br1l@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auo3PzmisfK3br1l@google.com>
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

On Tue, Nov 03, 2026 at 02:48:36PM -0500, Pasha Tatashin wrote:
> On 11-03 13:49, Mike Rapoport (Microsoft) wrote:
> > The lowmem and the global bootmem areas can have zero size, for example
> > when none or all of the memory is below ARCH_LOW_ADDRESS_LIMIT, or when
> > either of those areas is explicitly set to zero with kho_bootmem=.
> > 
> > For a zero-sized allocation memblock returns an address without reserving
> > anything, and that empty area is recorded in kho_bootmem. If there is no
> > memory below ARCH_LOW_ADDRESS_LIMIT, allocation of the empty lowmem area
> > fails and KHO gets disabled.
> > 
> > Extract a helper that checks for zero size and allocates memory from
> > memblock, and use it to skip empty areas the same way as empty per-node
> > areas are skipped.
> > 
> > Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> > Reported-by: Chen Pei <cp0613@linux.alibaba.com>
> > Closes: https://lore.kernel.org/all/20261026131851.9942-1-cp0613@linux.alibaba.com
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 61 ++++++++++++++++++--------------------
> >  1 file changed, 29 insertions(+), 32 deletions(-)
> > 
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index 6f1f55fe31819..f268c57413a7e 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -820,6 +820,27 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
> >  	return false;
> >  }
> >  
> > +static int __init kho_reserve_bootmem_area(int *idx, phys_addr_t size,
> > +					   phys_addr_t end, int nid)
> > +{
> > +	phys_addr_t addr;
> > +	int i = *idx;
> > +
> > +	if (!size)
> > +		return 0;
> > +
> > +	addr = memblock_alloc_range_nid(size, BOOTMEM_ALIGNMENT_BYTES, 0, end,
> > +					nid, true);
> > +	if (!addr)
> > +		return -ENOMEM;
> > +
> > +	kho_bootmem[i].addr = addr;
> > +	kho_bootmem[i].size = size;
> > +	*idx = i + 1;
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * kho_reserve_bootmem - Reserve a contiguous chunk of memory for kexec
> >   *
> > @@ -832,7 +853,7 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
> >  static void __init kho_reserve_bootmem(void)
> >  {
> >  	int nid, i = 0, max_nr_bootmem;
> > -	phys_addr_t addr, size;
> > +	phys_addr_t size;
> >  
> >  	if (!kho_enable)
> >  		return;
> > @@ -852,56 +873,32 @@ static void __init kho_reserve_bootmem(void)
> >  	 * reserve bootmem area in low memory for lowmem allocations in the
> >  	 * next kernel
> >  	 */
> > -	size = bootmem_size_lowmem;
> > -	addr = memblock_phys_alloc_range(size, BOOTMEM_ALIGNMENT_BYTES, 0,
> > -					 ARCH_LOW_ADDRESS_LIMIT);
> > -	if (!addr) {
> > +	if (kho_reserve_bootmem_area(&i, bootmem_size_lowmem,
> > +				     ARCH_LOW_ADDRESS_LIMIT, NUMA_NO_NODE)) {
> >  		pr_err("Failed to reserve lowmem bootmem\n");
> 
> You are adding a helper that returns an error code and then ignoring it 
> at all call sites. Even though it can only return -ENOMEM right now, 
> dropping the return value is not good practice.

I don't think error code is important here.
Even if some theoretical future update will change
kho_reserve_bootmem_area() to return anything but -ENOMEM I don't see why
the error code should be printed at all.

And anyway, that would be the part of that change.

-- 
Sincerely yours,
Mike.


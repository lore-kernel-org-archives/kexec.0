Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F740606A331
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mirPqtt0;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UH8BzPZP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BXtqewBsP373CPIOAi6YTJNiMe9FVQMK+bBEbUQClZU=; b=mirPqtt0iXHYi41vvWJDtae6sh
	HCMJcpJoNSsmdVQYBp6EZRojiBrHeu/JxD5ir88edBgPkmDHIgj2IK25kssdN+x4oqYIwql+aED+C
	HaoRJ+BouxFAcU+A8Gnv1bnOUVmUul7sqKz59LQ/+gMGfeuy7Ie4S7EBRDGzSaLgnNXrQ9Xv4rn7b
	DqmMbtQRRHpJ4rhTaN6T34B3p8RNU8RD7nwF1pEdJpKWPmkfhxtqn90KTxrtzDeBrBzFgxtRDl0tC
	nRuJE8ufuyK9jTpCmeUytzE0UFYy0FYlxmKhTxbz4ib7a+gysyU6HfeIno3epXZwl6P64gfsYE7Di
	RAqcx7UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJMg-00000003Rud-04Ni;
	Tue, 03 Nov 2026 18:36:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJMe-00000003RuU-2Bjn
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 18:36:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 43A8A43DAB;
	Tue,  3 Nov 2026 18:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16B61F00A15;
	Tue,  3 Nov 2026 18:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793730968;
	bh=BXtqewBsP373CPIOAi6YTJNiMe9FVQMK+bBEbUQClZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UH8BzPZP8cqAcgbW0cJ2L2+EeGFa8v1ugJxgyujaVpJRuRY+sSCplVUE39iUvpYeu
	 D6ecFGlEC6/3TCkletVwNohOQv2BJNrNjwk7jIgifq72h/eagD0XCTcNzHg9FYs0Wj
	 HlsU+MQghxeeGnDEUZNxmhKoSDPp8ER3jnt71KYlUs8BJsH3yp3I56jFVTzAPJDi3T
	 cI/VO1uVPhFX8+5NWFOi4/0yk7U/i8sJgZkThrJDsHx98cnlkrRyhWZk+pz6MJC5lV
	 ovSEHcqvAE49zuIHSkwCpalvys7U15hZlL6DBvwTR10SnI2vHvMkF3Nfb27NjxX9ow
	 DLArzvkvQGnTg==
Date: Tue, 3 Nov 2026 20:36:00 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Pei <cp0613@linux.alibaba.com>,
	George Guo <guodongtai@kylinos.cn>, Kexin Liu <liukexin@kylinos.cn>,
	Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] kho: fix bootmem sizing
Message-ID: <auopkIsiqxzg4anJ@kernel.org>
References: <20261103-kho-bootmem-sizing-v1-0-45aa74098f34@kernel.org>
 <20261103-kho-bootmem-sizing-v1-2-45aa74098f34@kernel.org>
 <2vxz5wydnbuj.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz5wydnbuj.fsf@kernel.org>
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

On Tue, Nov 03, 2026 at 05:01:08PM +0100, Pratyush Yadav wrote:
> Hi Mike,
> 
> On Tue, Nov 03 2026, Mike Rapoport (Microsoft) wrote:
> 
> > Bootmem areas are sized from overlapping views of the memory reserved in
> > memblock:
> >
> > * the global area is sized from all reserved memory, including memory
> >   allocated on specific nodes, so on NUMA systems everything allocated
> >   on a node is accounted in both the global area and the area of that
> >   node.
> > * per-node sizes are calculated after the lowmem and the global areas
> >   are reserved. With CONFIG_NUMA=n all memblock regions belong to node 0,
> >   so the lowmem and the global areas are accounted in the size of node 0
> >   area and scaled once again.
> >
> > As a result, bootmem is about twice bigger than it should be on NUMA
> > systems and about four times bigger with CONFIG_NUMA=n. On small systems
> > reservation of the bootmem may fail and then KHO gets disabled.
> >
> > Make the areas cover separate parts of the reserved memory: the lowmem
> > area covers allocations below ARCH_LOW_ADDRESS_LIMIT, per-node areas
> > cover allocations above it on each node and the global area covers
> > allocations that are not bound to any node. Calculate all sizes before
> > reserving any of the areas.
> >
> > With CONFIG_NUMA=n the global area becomes empty and it is not reserved.
> >
> > Bootmem sizes in MiB in x86 QEMU VMs, before -> after:
> >
> >                      CONFIG_NUMA=y     CONFIG_NUMA=n
> >   1G,  1 node         176 ->   92       320 ->   80
> >   4G,  1 node         508 ->  332      1264 ->  316
> >   16G, 2 nodes       1268 ->  704      2944 ->  736
> >   32G, 4 nodes       2296 -> 1224      5196 -> 1300
> >   64G, 4 nodes       4344 -> 2248      9664 -> 2420
> >
> > Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> > Reported-by: Kexin Liu <liukexin@kylinos.cn>
> > Reported-by: George Guo <guodongtai@kylinos.cn>
> > Closes: https://lore.kernel.org/all/20260904025101.9959-1-dongtai.guo@linux.dev
> > Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> > Closes: https://lore.kernel.org/all/20260922131217.698809-1-sourabhjain@linux.ibm.com
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Thanks for the patch! My LLM caught an interesting problems that is
> worth considering.
> 
> On arm64, ARCH_LOW_ADDRESS_LIMIT is arm64_dma_phys_limit - 1, and
> dma_limits_init() sets the default value to PHYS_MASK + 1, and it can
> also be memblock_end_of_dram() in some cases. So on arm64, it is
> possible for lowmem to span the entire RAM.
> 
> Currently, that results in over-allocation of bootmem, and it ends up
> being 4x what it should be. While obviously problematic, it should still
> work. With this patch, all memory is in lowmem, and nothing ever goes to
> per-node bootmem (except for the node that hosts the lowmem area).
> 
> All this is from reading the code, I haven't tried anything out yet.
> 
> Not sure how to fix this though. Should we perhaps use
> min(ARCH_LOW_ADDRESS_LIMIT, U32_MAX) for the lowmem limit?

Argh :)

Maybe we reset lowmem to zero if memblock_end_of_DRAM() <
ARCH_LOW_ADDRESS_LIMIT?
 
> Also, a couple nitpicks below.
> 
> > ---
> >  kernel/liveupdate/kexec_handover.c | 83 ++++++++++++++++++++------------------
> >  1 file changed, 44 insertions(+), 39 deletions(-)
> >
> > +
> > +		lowmem = reserved_mem_size(ARCH_LOW_ADDRESS_LIMIT, NUMA_NO_NODE);
> > +		global = reserved_mem_size(MEMBLOCK_ALLOC_ANYWHERE, NUMA_NO_NODE);
> > +		global -= lowmem;
> 
> Nit: Please add a short comment above this to explain why you remove
> lowmem from global.

I prefer to extend the comment above the function to say that calculations
for global and node that includes lowmem remove that.
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.


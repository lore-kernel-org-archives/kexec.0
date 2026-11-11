Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5D560A2615
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=13dcI3uR;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5sS8+8u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gFD8GxCW8TaX600NUsdqPsT5QbgfQppQ+86XjlXuBB8=; b=13dcI3uRbF92oOXyXcefpMDAQE
	KmrINQLt1iVrzKwehlIMyePEWW1bMUrycUgXeWUCxMFE4L0RcA8bf/7zYp5dSzob4gLv+a9c/WLtN
	ulDG5+LIKUY00/WI8mI74f3YeojHY4YFOgWCIk90sel6pbel+9UpzRTqg/MoV+yOH4AJ7UsiFwQvY
	OM7JSwy6KxE/S2kdpYWjQM1pxecYV+4+pJ8Ny8J3lYvtkxkcEswd9FkmBGkMUMW0w306m3BtWu8e7
	z8UwD30KH5vR4THLFapYgakg4Kou72oswwMA36Ny4/xr2ea7AApNgKeYLB5yPCe+/HdVZVkgoHd5u
	MKLH2OnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR3Gt-00000005yi8-2hxl;
	Wed, 11 Nov 2026 08:01:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR3Gs-00000005yhz-0emE
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 08:01:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F2716112A;
	Wed, 11 Nov 2026 08:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A022C1F00A08;
	Wed, 11 Nov 2026 08:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384089;
	bh=gFD8GxCW8TaX600NUsdqPsT5QbgfQppQ+86XjlXuBB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A5sS8+8uY+DdCHXQg9bRdOYPz96TIc0INTUnO+kkKrJHaM26c1xrNB1zhn38ZR5XQ
	 a7PPfIg8HknZg+PMAMVRgWVp6MK3YnB4FQW+7eT4e61afhSVfAcWXe0Jj+tperG+J6
	 Dba1+3LJCt6ArpYAnkXiJLliqL/5LdetKFFAbKNh32rFyso25fblbBhUjhL8FDI1li
	 EZAo5C/9n0lU3+Vx9r00gWq5QjPkLLy6n+P9F8Oda8sotn3CotI3ynZdBEcdwNAIS0
	 L0UuXPmy9Yt9YTLvvnkx9jHVGoKUDxjn9siexv4zzcPe9rKUdzNcSyzFT1PdQDeB9J
	 k5fMTXuIOAW1Q==
Date: Wed, 11 Nov 2026 10:01:23 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] kho: Prevent reuse of preserved pages after a
 reservation failure
Message-ID: <avQg0_jFY3get3wG@kernel.org>
References: <avQUquBK6cO6tUUI@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avQUquBK6cO6tUUI@chrisdown.name>
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

Hi,

On Tue, Nov 10, 2026 at 11:09:30PM -0800, Chris Down wrote:
> kho_preserved_memory_reserve() reserves each range of preserved memory
> in memblock and marks it noinit, but ignores both return values. Either
> can fail when memblock has to grow its reserved array and can't find
> room, which at this point in boot it may only take from KHO bootmem.

Is it an LLM analysis or you seen this happen?

> The boot then goes on as if the range were reserved, and two things
> can follow:
 
> - If the reservation failed, memblock_free_all() hands the range to the
>   page allocator with the previous kernel's data still in it, while its
>   KHO user still expects to restore it. A memfd preserved through LUO
>   can then get back pages that belong to someone else. Oh dear!
> - If only the noinit marking failed, the struct pages can be
>   initialised later, wiping the KHO magic, so restoring the range fails.
> 
> Dropping the handover at this point isn't safe either. reserve_mem=
> revives its regions from the handover before mm_core_init(), and
> relies on this walk to reserve them.

reserve_mem_kho_revive() can memblock_reserve() its memory itself and we
can carry on, can't we?
 
> Carrying on could hand out private data, so let's panic if either call
> fails.
> 
> Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  kernel/liveupdate/kexec_handover.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index eeec298aa9d6..0faa21ebb0cf 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -629,9 +629,14 @@ static int __init kho_preserved_memory_reserve(unsigned long key, void *data)
>  	sz = 1UL << (order + PAGE_SHIFT);
>  	page = kho_get_preserved_page(phys, order);
>  
> -	/* Reserve the memory preserved in KHO in memblock */
> -	memblock_reserve(phys, sz);
> -	memblock_reserved_mark_noinit(phys, sz);
> +	/*
> +	 * Reserve the memory preserved in KHO in memblock. It's too late to
> +	 * drop the handover if that fails: reserve_mem may already have revived
> +	 * regions from it.
> +	 */
> +	if (memblock_reserve(phys, sz) || memblock_reserved_mark_noinit(phys, sz))
> +		panic("KHO: failed to reserve preserved memory %pa+%#llx\n",
> +		      &phys, sz);
>  	info.magic = KHO_PAGE_MAGIC;
>  	info.order = order;
>  	page->private = info.page_private;
> 
> base-commit: a0dc8eddbfdb6dd9c5c2b70eb66ab49cb1978425
> -- 
> 2.54.0
> 

-- 
Sincerely yours,
Mike.


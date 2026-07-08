Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87BBC43602
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 14:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ts8+PPYmxoOpLLgVeTglSWE1PasRF+dUNUmJflgeGZM=; b=2zZGa6tougU3v8/EvK/tBs8SVW
	aIaG34QAL4EIlgdf+CmrfBwGknA0SAEOHwxD7ZoSYY8EuvWd1IOTHcY7klsvJzBp44hXjclx6YGIy
	n80lpwsTXDAMhYAW4NqrWFfFUf2KeWaOF4WJApkbKd0rf2M6IimjC9D9JtLyVar+E7q9oc5gmxwGx
	tv1JFePv1/fM2JUJMRVavNStuceEIA05ieiu3m77hDwN5NZojz9hYRGhuVktryDxT4wtCmt/yxfm/
	X2DjKdeW7ieDvBNGBe2DQE2usiujOqqfRcjq7vUElNosj5rqcGjYRqKyZMzyg4BTb/mB26xf78XeL
	0WNI3NQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whSzV-0000000HFGO-3sSn;
	Wed, 08 Jul 2026 14:11:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whSzU-0000000HFFq-3Mep
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 14:11:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D3E00600AF;
	Wed,  8 Jul 2026 14:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8FD1F00A3A;
	Wed,  8 Jul 2026 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519867;
	bh=ts8+PPYmxoOpLLgVeTglSWE1PasRF+dUNUmJflgeGZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CUQcU9G1jJ4xeYZiG3BZOH2n9CAq095h2H4KghWvlIVWxEl4bDX2Cs/id1+GyN5aq
	 Q3Lkbj9ZFwkXKeIeQcwj7JqJQ2Nu3dDoPr91m0JOYW0zR5GgMpOiakj1U+3JrF8n5a
	 0bVwOrQhgjabZlvTy5q50RVhtvLcsIFaFor4qaz9ij1QPS3Vrk6jP7MBS7/zYlOjcn
	 NmpRaiDVSZJvPXrciJ5a75LjjZPYpYsgPjFNy/VQoCFt9JAchFioDo/5OdPV7uODKY
	 24xjzqmhJCl1Mj7NTqHihjOMO3TAFSkAvUQtHFdhGi5uz+Aj0Mb9BZLNz6CgrkC9zh
	 5RmrRS35OcTsQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  David Matlack <dmatlack@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] kho: Support preserving unsplit high-order pages
In-Reply-To: <20260703020832.1731864-1-praan@google.com> (Pranjal
	Shrivastava's message of "Fri, 3 Jul 2026 02:08:28 +0000")
References: <20260703020832.1731864-1-praan@google.com>
Date: Wed, 08 Jul 2026 16:11:04 +0200
Message-ID: <2vxz7bn5mv0n.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Jul 03 2026, Pranjal Shrivastava wrote:

> This series is required for the ongoing effort to preserve DMA allocations
> across KHO [1]. It addresses a fundamental mismatch between the current KHO
> restoration logic and adds support for high-order buddy allocations.
>
> The Problem
> ===========
> The current KHO restore implementation treats all multi-page blocks as 
> split pages during restoration, i.e. kho_restore_pages() initializes 
> every 4KB page with a refcount of 1.
>
> However, many kernel subsystems, most notably the DMA allocator (via
> dma_alloc_coherent), frequently return high-order non-compound pages. 
> In this unsplit state, only the head page carries a refcount of 1, 
> while all tail pages have a reference count of 0.
>
> Consequently, when these contiguous but unsplit blocks are restored by 
> KHO in the new kernel, the forced refcount of 1 on tail pages causes some 
> trouble with the buddy allocator. Downstream of the eventual free path
> the __free_pages_prepare() [2] ends up calling page_expected_state() [3] 
> when is_check_pages_enabled() returns true (only when CONFIG_DEBUG_VM or
> debug_pagealloc=on).
>
> This detects the non-zero refcounts on tail pages [4] and incorrectly
> taints the kernel while leaking the pages in question.
>
> Proposed Solution
> =================
> This series introduces a "Page Type" field to the KHO ABI to track the
> refcount pattern of the preserved pages.
>
> 1. KHO detects the physical state (CONTIG vs SPLIT) during preservation
>    by peeking at the refcount of the second page in each buddy block.
>
> 2. The type bit is preserved in the high bits of the KHO radix tree key
>    (Bit 63) and stashed in page->private metadata during boot.

The KHO radix tree today only guarantees support for 53 bit wide keys.
Although in practice, on 4k pages the math works out to support 60 bit
wide keys in practice because we have 6 table levels.

Still, you can't preserve a key with the 63rd bit set. So how does your
code even work?

Also, if you do this, it comes with a side effect. It will increase the
memory usage of the radix tree, since now you have two branches of the
tree, one with the high bit set, and one without it. So that is more
intermediate table pages allocated.

>
> 3. kho_restore_page() applies the correct refcount pattern based on the
>    preserved metadata.

Why do you need to save the type of pages in KHO metadata? For example,
for pages or folios, we don't store any type information and leave it to
the caller choose the right API. So reserve-mem and kho vmalloc need
pages, they can call kho_{preserve,restore}_pages(), and memfd needs
folios so it can call kho_{preserve,restore}_folio(). The radix tree
itself does not hold the information. The caller knows what its memory
is supposed to be so it calls the right restore API.

So why can't we add a kho_{preserve,restore}_page_multi() (pick a better
name; we can argue about the naming later)? Then your driver knows it is
restoring DMA buffers so it can call kho_restore_page_multi(), and KHO
takes care of initializing the pages with the right refcounts.

You won't have to muck about with the ABI in that case.

>
> 4. A new helper, kho_split_preserved_pages(), is provided for subsystems
>    that may need to split memory after it has already been preserved.

Umm, that sounds scary... Why do you need to do that? What's the use
case? Why is the driver reconfiguring its memory after preservation? I
assume these are DMA buffers, so why do they suddenly look different?

And in either case, why does KHO need to do the split? Why can't the
driver unpreserve old preservation, then split the pages, and then
preserve the new ones?

>
> Considerations
> ==============
>
> 1. A primary goal of this approach is to prevent driver/subsystem code
>    from peeking into MM internals. Drivers should not need to understand
>    the distinction between head/tail pages or compound metadata. The KHO
>    core handles this internally.
>
> 2. To handle rare cases where a caller might wish to split a high-order 
>    block after preservation, we provide kho_split_preserved_pages().
>  
> 3. The callers must ensure that the split_page() doesn't race with
>    kho_preserve_pages for consistency.
>
> 4. Folios are always implicitly considered of the CONTIG type
>
> Thanks,
> Praan
>
> [1] https://lore.kernel.org/all/20260505002737.2213734-1-skhawaja@google.com/
> [2] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1370
> [3] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1027
> [4] https://elixir.bootlin.com/linux/v7.1.1/source/mm/page_alloc.c#L1034
>
> Pranjal Shrivastava (4):
>   kho: Introduce infrastructure to track preserved page types
>   kho: Detect preserved page types
>   kho: Implement page-aware refcount restoration
>   kho: Introduce kho_split_preserved_pages() helper
>
>  include/linux/kexec_handover.h     |   7 ++
>  include/linux/kho_radix_tree.h     |  17 +++-
>  kernel/liveupdate/kexec_handover.c | 144 +++++++++++++++++++++--------
>  3 files changed, 124 insertions(+), 44 deletions(-)
>
>
> base-commit: 87320be9f0d24fce67631b7eef919f0b79c3e45c

-- 
Regards,
Pratyush Yadav


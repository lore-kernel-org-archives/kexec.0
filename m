Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEDEC43458
	for <kexec@archiver.kernel.org>; Tue,  7 Jul 2026 08:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5pdPtIHiIQoepiex1h1rTZsPNlcpN7aFZWNjXMcloL4=; b=YCI8FNyx9S06247XhF3Cq7+RN9
	DRt6uCGeYGVNrXqw2cEWjcbeU3vN5lBqobNDJa//TbXWdAlnYgkguAfesFjX0E8qtrv+CrEwT/OVj
	PYGEedJIo4uNXWv4Xk8GAgaiIB0O3yBLL/svH+2GPRXvUBE3JpVB3QDe4Vgh2ct1bM6iaAZvT/xBw
	JwdattO8n16JzN1uQj/3VbryDczom/waVb3ZECbKGwCzodNGZoeadkLAZqXfbiXeTAFuvPRXwFTlB
	mpBJMpAFXU3/BDOULYUi273ECuijpXci4NGtlGu3UCFa97D+It4mi3rKeB0WGZnmgXa6Au0aoUTnz
	DNGW7uww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh1AT-0000000ETft-3VzX;
	Tue, 07 Jul 2026 08:28:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh1AS-0000000ETfB-0XGV
	for kexec@lists.infradead.org;
	Tue, 07 Jul 2026 08:28:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 536EE618A8;
	Tue,  7 Jul 2026 08:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7681F000E9;
	Tue,  7 Jul 2026 08:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783412915;
	bh=5pdPtIHiIQoepiex1h1rTZsPNlcpN7aFZWNjXMcloL4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=dwkWD4ywktM5Qi5tFg4O57t+Dqxw4Qv2nnHqcL/Cawk9UEuLb01dx0UgluOGAuLt/
	 FHpw74frxj+GAztg/Ag+SEVil5vy3oHjeHOZwU2EdE6+CsBYPTOUGfQYQq+lCHZH0D
	 NhASQTAx1yM0g9VFNCtwKNh8y4ZSGew5+5x9w12k2sduLQSOLVL1OsQoj9KDiqYu+c
	 AAK/T8ov/hvuJqjzgCJF4cAWoPF4GZwiPVBCPkCwzp5B0u5CvbX+gOZaaaI0LewPpX
	 e4ub4YpTE4g2aohbVzbCi9/Jfo/ZVHyz91kvaLlLttdJeJLdVJFbF3HMj1TAC0hLVU
	 8mI5GPU4FYnKg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 0/4] kho: Support preserving unsplit high-order
 pages
From: Mike Rapoport <rppt@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260703020832.1731864-1-praan@google.com>
References: <20260703020832.1731864-1-praan@google.com>
Date: Tue, 07 Jul 2026 11:28:28 +0300
Message-Id: <178341290876.3292146.16538284698967245356.b4-review@b4>
X-Mailer: b4 0.16-dev
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

This brings a broader question - what is the best way to deal with page
metadata. This particular case requires only a single bit and luckily we
have a few spare high bits in the radix tree key. But what if going
forward we'll need more than a few bits? Do we need a parallel data
structure for the page metadata? Or something in kho_radix_leaf in
addition to the bitmap?

I'm not saying that a generic solution for page metadata must be a part
of this series, but we definitely need to consider and better sooner
than later.

> 3. kho_restore_page() applies the correct refcount pattern based on the
>    preserved metadata.
> 
> 4. A new helper, kho_split_preserved_pages(), is provided for subsystems
>    that may need to split memory after it has already been preserved.
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

Do you have anything particular in mind?

-- 
Sincerely yours,
Mike.



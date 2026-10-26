Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E66606A327
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NP9dRj5y;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JhmotoTd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aKt6+bsKfLK53L2GaRA3WWqLfNzUo0lW3V0HdvcPXJI=; b=NP9dRj5yevh6phokY6RtsSIsJm
	FbTdflt9d77MUIjEg5BP7wXinsa0gOUOxN2JKKNpkCRUpiRsMV2+Y7maKvxehByBZNdw94+oeXdH8
	CiMkVuyqiZI4jxWlMREe6roJewGMs/H+qFeNpJpAUYPgWSk4Jixlmf2g6UvE/8zTi7svwzCnt+jJA
	ZMKIOjV/FlP4QizOTv88mi5reYFcdzqVbzuGrUhXTqZdq/OKRvbCYmw0wsLxT7bSndXCd8aadrDBq
	y2/hrDwZiI2GSZaVblQVnr1gwrk2+uxT2P7/EVBnd+8i9L4rxYSdvMiQTr0MZjHtudf8jNavJiElA
	BTveZsJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLLb7-00000002flj-3Gy5;
	Mon, 26 Oct 2026 14:22:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLLb6-00000002flR-3Agq
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 14:22:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2FCEB43DD2;
	Mon, 26 Oct 2026 14:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9813F1F01825;
	Mon, 26 Oct 2026 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793024568;
	bh=aKt6+bsKfLK53L2GaRA3WWqLfNzUo0lW3V0HdvcPXJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=JhmotoTdkwlq5uP+ikQwsrku1uYQ8w4CrgqDBBQGrnSQ8fncJUV6Sg905Qdo1IWoS
	 5RyHMQ7joXXGnvEG/1EEYSGiS+fLiKMyOC8UeUvJQZDWmT+oo0byF9GStp/mEVtj5E
	 ChnLqvVcXxkRNtJxnlqXq4hdQhEBH/HXm1MRVUSwBiRAhXMf5D/fnqlFHX2ADL6hI/
	 +qHBoI+zrEtXkaf6vly/J70BbMg6yeiklwe2d7rqLCbTkhql199+pp796ACDzhd/9v
	 B5ceaRbvY0LkNByK5/2141SWcFvqID77OmSGU2mRIkLCzh3iZzeWxIqW8xyeft5E08
	 jl44bha+xgC6g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: rppt@kernel.org,  pasha.tatashin@soleen.com,  pratyush@kernel.org,
  graf@amazon.com,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: Skip zero-sized bootmem areas
In-Reply-To: <20261026131851.9942-1-cp0613@linux.alibaba.com> (Chen Pei's
	message of "Mon, 26 Oct 2026 21:18:51 +0800")
References: <20261026131851.9942-1-cp0613@linux.alibaba.com>
Date: Mon, 26 Oct 2026 15:22:45 +0100
Message-ID: <2vxzld7kpmmi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26 2026, Chen Pei wrote:

> The lowmem and the global bootmem area are reserved unconditionally,
> while the per-node loop below already skips nodes whose size works out
> to 0. Either can legitimately be 0: the global size is the scaled total
> minus the lowmem one, so it is 0 whenever all measured reservations fit
> below ARCH_LOW_ADDRESS_LIMIT.
>
> Reserving 0 bytes still succeeds, so an area covering nothing gets
> recorded with a valid address. That is not neutral:
> kho_bootmem_overlap() reports an overlap for any request straddling
> that address, and memblock_alloc_hugetlb() aligns a request to its page
> size, so a 1G hugetlb allocation retries a free candidate on account of
> an area that holds nothing.
>
> A machine whose memory all starts at or above ARCH_LOW_ADDRESS_LIMIT
> hits the other side of the same code: the lowmem size is 0, the range
> below the limit is empty, the allocation fails and KHO is disabled
> although no lowmem area was needed.
>
> Skip a zero-sized area instead, as the per-node loop does. The
> descriptor count stays consistent, as kho_populate() derives it from
> the segment length that kho_fill_kimage() serialises.
>
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Do you see zero sized lowmem or global scratch in practice? If yes, how?
What's your setup?

Note that I already fixed this for per-node areas since those do end up
with no allocations with movable_node set [0].

[0] https://lore.kernel.org/kexec/20261014131547.259138-1-pratyush@kernel.org/

[...]

-- 
Regards,
Pratyush Yadav


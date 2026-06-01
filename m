Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502B8CD6E56
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 12:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4D8mKmK+s+4sL4bhA99fPLjzqV9Yidvpyfe324Qy2BE=; b=jEQVkfcu43DWW/rYKdyp+09EwD
	5BfTJzE/5kTSvz719KhfZI+d/guQnntxxBjFmTiAGkr0A5ic2WFqAjST+dOKkCFC15r2gpUd3whlo
	BnkqKVlrOdDFCWc2TsShfsXjio8wkKP7a5DddY0SvD7jSYJCk/WNob8ObxGwxvCJijUxwUu1vhPkO
	gON1bjsenySVZyhlO1gQzN7x3m7mHDWP8Pf74cJjkwrCqzk1nTJiE/hJH+mFBJE0CUozELkF9nsrJ
	NC0qCPggUJ8/G5foupuFSpruiWAy3rXNPW0f8eILHfEA4MnRhAqJQrrL/ZfxBesRY0+O1q3GUmmOP
	YBQ4G/9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU1ra-0000000B8zP-0FTg;
	Mon, 01 Jun 2026 12:35:26 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU1rX-0000000B8yy-2Gmq
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 12:35:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D308840E2F;
	Mon,  1 Jun 2026 12:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B771F00898;
	Mon,  1 Jun 2026 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780317322;
	bh=4D8mKmK+s+4sL4bhA99fPLjzqV9Yidvpyfe324Qy2BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LeJxeT58apk3aiYwTcDP8ZuwOqZlxtg6xsRxAvAegwmbFCDWBr1iXRhj/SzfUMjtg
	 ctd1IuB9RXeyJf73H5q5jKeChTLAWYcR+1nbgKUR4qKmsdz81nh3zUoFDzYbS2ERXF
	 Y3hdyA82gVLA+0qtbBuD6/x2Rds6PCzBM4hgiJpPdmalG12vhHakoRTCQDN2nAjOW0
	 0NhnDNlQdED8swk7O1onCeGs2OQ1ePSxqpK8cEUmqZ96lA55xvPKzhRTt83806PL5b
	 Y3RTz2PHWzhSlpIYI8NjtPR4c1MnsuNAg64LpWlb/TYnFk8mhgdoa1+lY6ZFc8dT/H
	 d8hAdyuD2phxQ==
Date: Mon, 1 Jun 2026 13:35:16 +0100
From: Will Deacon <will@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 3/4] dma-direct: Add API to preserve/restore
 allocations
Message-ID: <ah18hDhjSLxIvb-Y@willie-the-truck>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-4-skhawaja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505002737.2213734-4-skhawaja@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_053523_600733_BAEE0604 
X-CRM114-Status: GOOD (  13.66  )
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

On Tue, May 05, 2026 at 12:27:36AM +0000, Samiullah Khawaja wrote:
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index ec887f443741..c2b98f91900a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -6,6 +6,8 @@
>   */
>  #include <linux/memblock.h> /* for max_pfn */
>  #include <linux/export.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/kho/abi/dma_alloc.h>
>  #include <linux/mm.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/scatterlist.h>
> @@ -307,6 +309,167 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_DMA_LIVEUPDATE
> +int dma_direct_preserve_allocation(struct device *dev, void *cpu_addr,
> +				   size_t size, dma_addr_t dma_handle,
> +				   unsigned long attrs, u64 *state)
> +{
> +	struct dma_alloc_ser *ser;
> +	int ret;
> +
> +	if (!kho_is_enabled())
> +		return -EOPNOTSUPP;
> +
> +	if (IS_ENABLED(CONFIG_DMA_CMA))
> +		return -EOPNOTSUPP;

Hmm, it seems a bit overkill to do this just because CMA is compiled
in, especially as it's user-selectable in kconfig.

Maybe you need to iterate over the CMA areas using cma_for_each_area(),
similarly to how you do with the pools?

Will


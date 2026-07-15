Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1054C4450A
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 06:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n8HXYrZJxWHjjmj3qEyT+Zg6Jj3eLpVK+NKrXWZfxeg=; b=eFgpC73TjGRvTrxq7fIRUrdF3L
	T8c6tlHRXMUmhs+FiatFhFTgnPogWwDx4WnzXFAW8mawA/4smSK4+ZxJhsvse7iFpVbEHudGbMUkL
	1BAatTkgsikS7LrXnkRJQGsdPjCB3hbGOmQnC2qFeMsacJ/8JrNFxPs57Xs28BShRIChLT6Ih9wRe
	4cQ/T58DwiCf1FtiKGou5cIm8BpaKjURFSxd5GYT9+gVx0CRB10ua9bzu104U+UNhf6mhS1VSpoFy
	D2mfvmCu+RX4nxh6WzaceWJ1Hjt3Fw60YHGntNIvnXSVX2253hJOR1cooiwQOAAee9JDXQEEhhMHZ
	5PWS7AIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjszp-0000000Ds84-3Ex3;
	Wed, 15 Jul 2026 06:21:29 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjszo-0000000Ds7g-1Plt
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 06:21:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E4F9F40649;
	Wed, 15 Jul 2026 06:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80851F00A3A;
	Wed, 15 Jul 2026 06:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784096487;
	bh=n8HXYrZJxWHjjmj3qEyT+Zg6Jj3eLpVK+NKrXWZfxeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jcDlTBB6w3jar+gMo8sJ2wnylExEoKYg3oqsAi971GZqI/U5UXD/5lAnFaH0pAed1
	 AgW/W4DBhcbIZSVQO1w7/O6GIhLPZkRgUKNG5lXcSs69L7cmDqaFKN4uLYUz5lba8/
	 3oLl/xVLZbpOQ/EhSuTqMd4+ZpWd5sisGGPaFa1fzB45txm2Ae2o9Pj9BC8XZeXWDQ
	 D7Lmr3vKi4DsIMc6PCJQNgOueHApMAzsUTdS+WE2H/lMGuWQ6CmWaUnQSns++2Ikey
	 lDTk5Hp4JbOnzMM7XNMnsvv86oXz4yllbfATJJiBH/9qxx4TlncWAGZxBEvdKKcC7K
	 up+1DErnDWHjA==
Date: Wed, 15 Jul 2026 09:21:16 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Subject: Re: [RFC PATCH v2 03/10] dma: contiguous: Add API to check if an
 allocation is from CMA
Message-ID: <20260715062116.GA21348@unreal>
References: <20260708234854.4044652-1-skhawaja@google.com>
 <20260708234854.4044652-4-skhawaja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708234854.4044652-4-skhawaja@google.com>
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

On Wed, Jul 08, 2026 at 11:48:47PM +0000, Samiullah Khawaja wrote:
> Add an API that uses cma_for_each() to check whether a DMA allocation is
> from a CMA region.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  include/linux/dma-map-ops.h |  6 ++++++
>  kernel/dma/contiguous.c     | 24 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)

<...>

>  #ifdef CONFIG_DMA_DECLARE_COHERENT
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 03f52bd17120..0b1702bf39ca 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -130,6 +130,30 @@ struct cma *dev_get_cma_area(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_get_cma_area);
>  
> +struct dma_cma_check_data {
> +	phys_addr_t start;
> +	phys_addr_t end;
> +};

If this series is retried, use "struct phys_vec" here instead of
declaring a new structure:
https://elixir.bootlin.com/linux/v7.1.3/source/include/linux/types.h#L173

Thanks.


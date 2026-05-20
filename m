Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFB2CD4F3C
	for <kexec@archiver.kernel.org>; Wed, 20 May 2026 09:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ROuDJc1ckmzsUK3GQqF5RpUdIt3rHpwnZ651Dx4KTEU=; b=OJ1MPIv/6YEa9r9iyOtnCjsF0h
	ahI2kbWtd0F+1Rqxt4dbVRyMK5exW5+kBsQdGK44RZJs+sijc07P0gTv2DDaD9FUoEqRCQptWRawQ
	vpG9WQjN3hyHBmjHHuMBknBInaJ4ku+oWg9qTRUJVkNe6GOUjVYW3oncl9QwLOEo9L81yabTOGNCJ
	+oRRGFuJ63RNZPO3EPC3QIB10muqDj1/LpNC0f+MC8WfqTX7UeuT8AGnm/GV0pmWu50T7oQjgc2Pi
	H4CFl+wrfKU8LWdnuAf8SdPjW1OaQ2S4u2HYrgXDXdWgMzVLn9z6vowfu5gAvuMBITsgH374BS4oe
	70gcYKCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPdd1-00000004Epy-25wR;
	Wed, 20 May 2026 09:54:15 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPdct-00000004Ep0-1ZWt;
	Wed, 20 May 2026 09:54:11 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260520095359euoutp0198bcd0d30eb407a19ba86b2e2a0aa636~xPWbGPRHZ2283822838euoutp01G;
	Wed, 20 May 2026 09:53:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260520095359euoutp0198bcd0d30eb407a19ba86b2e2a0aa636~xPWbGPRHZ2283822838euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779270839;
	bh=ROuDJc1ckmzsUK3GQqF5RpUdIt3rHpwnZ651Dx4KTEU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=XF5eoO6iIyP+yCtpP3A8TGvh7GdDuyqBUt33HERHmy0S7JjHZU25lGEQBRo1uI7yM
	 xKjGjzOAnuX9sNbzBHZjYTMarbQoPJA/rfU7eI7SVQCO27LQ49kvWSeFQnoBkjwSrS
	 lCkUYQMv8ZgGaOQMZ5JVsI8vM6NOOrcWXVPUsv64=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260520095358eucas1p1d5ec8fc83da4c9969214d9dbd4e59061~xPWajlDwS0908909089eucas1p1b;
	Wed, 20 May 2026 09:53:58 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260520095357eusmtip1a47766f5000651b2ff2398051841ce3f~xPWZFRiKV1382913829eusmtip1U;
	Wed, 20 May 2026 09:53:57 +0000 (GMT)
Message-ID: <e5dbe092-1c28-4799-b7c6-a78f84065dd2@samsung.com>
Date: Wed, 20 May 2026 11:53:56 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 3/8] of: reserved_mem: add dumpable flag to opt-in
 vmcore
To: Wandun Chen <chenwandun1@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
	robin.murphy@arm.com, leitao@debian.org, kees@kernel.org, coxu@redhat.com,
	tangyouling@kylinos.cn, songshuaishuai@tinylab.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260520091844.592753-4-chenwandun@lixiang.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260520095358eucas1p1d5ec8fc83da4c9969214d9dbd4e59061
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260520091935eucas1p1e3bd0cd7a5d2229acf937de3439571c7
X-EPHeader: CA
X-CMS-RootMailID: 20260520091935eucas1p1e3bd0cd7a5d2229acf937de3439571c7
References: <20260520091844.592753-1-chenwandun@lixiang.com>
	<CGME20260520091935eucas1p1e3bd0cd7a5d2229acf937de3439571c7@eucas1p1.samsung.com>
	<20260520091844.592753-4-chenwandun@lixiang.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_025407_688653_A9F2D674 
X-CRM114-Status: GOOD (  17.09  )
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

On 20.05.2026 11:18, Wandun Chen wrote:
> From: Wandun Chen <chenwandun1@gmail.com>
>
> From: Wandun Chen <chenwandun@lixiang.com>
>
> Add a 'dumpable' flag to struct reserved_mem so the kernel can decide
> whether a reserved area should be included in the kdump vmcore. Most
> reserved regions are owned by devices and do not contain data useful
> for kernel crash analysis, so excluding them by default is the right
> behaviour.
>
> Reusable CMA regions are different: pages in a CMA region are handed
> back to the buddy allocator and may contain key data for crash
> analysis, so set dumpable to true in rmem_cma_setup().
>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> Link: https://lore.kernel.org/all/20260506144542.GA2072596-robh@kernel.org/
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  include/linux/of_reserved_mem.h | 1 +
>  kernel/dma/contiguous.c         | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
> index e8b20b29fa68..55a67cee41ea 100644
> --- a/include/linux/of_reserved_mem.h
> +++ b/include/linux/of_reserved_mem.h
> @@ -15,6 +15,7 @@ struct reserved_mem {
>  	phys_addr_t			base;
>  	phys_addr_t			size;
>  	void				*priv;
> +	bool				dumpable;
>  };
>  
>  struct reserved_mem_ops {
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 03f52bd17120..eddec89eb414 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -579,6 +579,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
>  		dma_contiguous_default_area = cma;
>  
>  	rmem->priv = cma;
> +	rmem->dumpable = true;
>  
>  	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
>  		&rmem->base, (unsigned long)rmem->size / SZ_1M);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



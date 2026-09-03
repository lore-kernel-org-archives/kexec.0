Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C298C624D4
	for <kexec@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Rh82UpIZQ7NIonfNGs8YTQqWSqGT+MHCSLTl6BXJFs=; b=mBnvmacDzUFRyZqQY8RpQYlLAn
	VTL8/u2Gwu4C5jmkD5piIyAR7SMkletrEDukCE9pjyQgIcwJUZ0QZGRyXwuWrZl323zQTP7hSuu+A
	o7XxjwHju0DKKiB8msxH5IGBxeM5t54pd/U2lOwNKUauB1ZGBFxd+/0crxiS1bTxfGA7nxie9a5vk
	2gM+N34He6ncjSAntZdro1Jh3TVYffLqY4M5mm8uJIQJAZW7v8+AAcKTVLoaou5P5+zJwuLCPnWE3
	MnoVJSK31B7qaAFglfB8MOnTUmEOwWyyeDWq1khzfFmLMi7wyvgXxx74pEyQrqMucNuY+R3QqtI81
	sc9DxZBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x21wZ-0000000Gabv-2Atn;
	Thu, 03 Sep 2026 07:33:07 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x21wV-0000000GaXv-1GKT;
	Thu, 03 Sep 2026 07:33:05 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260903073300euoutp01f932cc3b5b8312ed22b276d0d0ac5943~RvzldRbJd3111131111euoutp01L;
	Thu,  3 Sep 2026 07:33:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260903073300euoutp01f932cc3b5b8312ed22b276d0d0ac5943~RvzldRbJd3111131111euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788420780;
	bh=4Rh82UpIZQ7NIonfNGs8YTQqWSqGT+MHCSLTl6BXJFs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bQV1zXZ4+kSUiD1UtpA8m7+DEFdp3b+UJT/x0X50HERkYva4J2b8M/D3zL6qOxYy5
	 6lfDF3e+/r2d8teE3hZUKOHqLhKuqFmsKNY1MOeHj8gIqcQh65i9ERtw7Ct1LVadGN
	 is0YSAfIOwuPbjiTdffjbCDzJGY3smVOZSHQSVyY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260903073259eucas1p1129fec57788d227a159662ed4bbd4068~Rvzk9e9k82315423154eucas1p1i;
	Thu,  3 Sep 2026 07:32:59 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260903073256eusmtip1b94b6b13230ed6f62847ad6ac2a1cf65~RvzhrjUza3241332413eusmtip1J;
	Thu,  3 Sep 2026 07:32:56 +0000 (GMT)
Message-ID: <859ff0c6-6c3f-47c1-95f5-0428d06f0b87@samsung.com>
Date: Thu, 3 Sep 2026 09:32:55 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v6 09/10] of: reserved_mem: mark /memreserve/ entries as
 MEMBLOCK_NODUMP
To: Wandun Chen <chenwandun1@gmail.com>, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, robh@kernel.org,
	saravanak@kernel.org, akpm@linux-foundation.org, baoquan.he@linux.dev,
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org
Cc: mark.rutland@arm.com, kernel@xen0n.name, alex@ghiti.fr, hpa@zytor.com,
	ruirui.yang@linux.dev, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
	iommu@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260902073116.802752-10-chenwandun1@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260903073259eucas1p1129fec57788d227a159662ed4bbd4068
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260902073334eucas1p1b0e997e1f1c9752bc9f48229d7922443
X-EPHeader: CA
X-CMS-RootMailID: 20260902073334eucas1p1b0e997e1f1c9752bc9f48229d7922443
References: <20260902073116.802752-1-chenwandun1@gmail.com>
	<CGME20260902073334eucas1p1b0e997e1f1c9752bc9f48229d7922443@eucas1p1.samsung.com>
	<20260902073116.802752-10-chenwandun1@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_003303_607810_1E94DCB8 
X-CRM114-Status: GOOD (  22.88  )
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

On 02.09.2026 09:31, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
>
> The /memreserve/ entries are memory reservations made by the bootloader
> or firmware, their contents are not needed for kernel crash analysis,
> so mark them MEMBLOCK_NODUMP to have kdump omit them from the vmcore.
>
> Entries that overlap a dumpable region (such as CMA) are left unmarked,
> because the pages of a dumpable region may carry crash-relevant data.
>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>  drivers/of/fdt.c             |  1 +
>  drivers/of/of_private.h      |  1 +
>  drivers/of/of_reserved_mem.c | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 286fd4db6312..9a727941b5af 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1286,6 +1286,7 @@ void __init unflatten_device_tree(void)
>  	/* Save the statically-placed regions in the reserved_mem array */
>  	fdt_scan_reserved_mem_late();
>  	fdt_mark_reserve_mem_nodump();
> +	fdt_mark_memreserve_nodump();
>  
>  	/* Populate an empty root node when bootloader doesn't provide one */
>  	if (!fdt) {
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 505735732c13..6497404ec751 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -188,6 +188,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
>  int fdt_scan_reserved_mem(void);
>  void __init fdt_scan_reserved_mem_late(void);
>  void __init fdt_mark_reserve_mem_nodump(void);
> +void __init fdt_mark_memreserve_nodump(void);
>  
>  bool of_fdt_device_is_available(const void *blob, unsigned long node);
>  
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index f29a07e8fb23..a42cf6eac55b 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -251,6 +251,39 @@ static void __init __rmem_check_for_overlap(void)
>  	}
>  }
>  
> +void __init fdt_mark_memreserve_nodump(void)
> +{
> +	u64 base, size;
> +	int n;
> +	const void *fdt = initial_boot_params;
> +
> +	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
> +		return;
> +
> +	if (!fdt)
> +		return;
> +
> +	for (n = 0; ; n++) {
> +		int i;
> +
> +		if (fdt_get_mem_rsv(fdt, n, &base, &size))
> +			break;
> +		if (!size)
> +			break;
> +
> +		for (i = 0; i < reserved_mem_count; i++) {
> +			struct reserved_mem *rmem = &reserved_mem[i];
> +
> +			if (rmem->dumpable &&
> +			    base < (u64)rmem->base + (u64)rmem->size &&
> +			    (u64)rmem->base < base + size)
> +				break;
> +		}
> +		if (i == reserved_mem_count)
> +			memblock_mark_nodump(base, size);
> +	}
> +}
> +
>  /**
>   * fdt_scan_reserved_mem_late() - Scan FDT and initialize remaining reserved
>   * memory regions.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



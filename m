Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E48C624D4
	for <kexec@archiver.kernel.org>; Thu,  3 Sep 2026 07:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+wHQNtUzqWMJSc1lx6xZnDlVX8u6lqdGivmRj3Xx4g8=; b=Iocm34GI8Mn+BA7ZOJpERYobl7
	QfEpDowqwKw9X9CQaU8HJjL8827Ajpax2Lt1iTd1zz4roJscD2IVJtiJKwas+RmzGsgNzVuUpQVwc
	J+KOGjVp4x/KKwJ5m/Xcmps3oo2c84MRTR4OJPaMlOhl1I038J5wmJzO0jjGV/Y5+xVUQeWd1Vwnz
	itPBNpVJ3kLxxUZTZc78pL6+FKf4u8gnpN0TB0wU4KgYCCblphd2hnFQwj1Lirn3YR1UOIlpREgOe
	tSDqZ8dhFKygc2J6FSxp+cZtVkXxpcZkAPOqfe+MJDrX0B/hjtXvkCBgnqu4SiBEbBx7ebu1ZfPAj
	PTLh6EPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x21wL-0000000GaRY-3i13;
	Thu, 03 Sep 2026 07:32:53 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x21wI-0000000GaNa-29Oy;
	Thu, 03 Sep 2026 07:32:52 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260903073242euoutp028273f8b6ecd56cd872bd07708e437933~RvzVL078Z1675416754euoutp02g;
	Thu,  3 Sep 2026 07:32:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260903073242euoutp028273f8b6ecd56cd872bd07708e437933~RvzVL078Z1675416754euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788420762;
	bh=+wHQNtUzqWMJSc1lx6xZnDlVX8u6lqdGivmRj3Xx4g8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Be3mug4nDx3cwq9l0zEJz6bxShgUmWFhNerr8aSB3+JpOhp9ELT8C2JQyOj6fiw4U
	 63hQQKr92t6934Lz4jr0aWYWf9gs/krroQ4w+aFShXYrTDqv0AAefQ0qxhBjgLrOnp
	 2H+8ACOP+2hdFtmyQM7P43B6v62oHP8TSEfYlJfI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260903073242eucas1p1bf766543283c23d9923ef581b9056525~RvzU88Ke02312023120eucas1p1b;
	Thu,  3 Sep 2026 07:32:42 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260903073239eusmtip2a4493b60653a6ab9ea0e63ade61f9b93~RvzSMWeKp1596215962eusmtip2K;
	Thu,  3 Sep 2026 07:32:39 +0000 (GMT)
Message-ID: <2d0d36ba-db8f-454b-a90b-8eea69e97452@samsung.com>
Date: Thu, 3 Sep 2026 09:32:38 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v6 08/10] of: reserved_mem: mark /reserved-memory
 entries with MEMBLOCK_NODUMP
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
In-Reply-To: <20260902073116.802752-9-chenwandun1@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260903073242eucas1p1bf766543283c23d9923ef581b9056525
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260902073459eucas1p282f20730a9f6dce75cf5a406714b8ed0
X-EPHeader: CA
X-CMS-RootMailID: 20260902073459eucas1p282f20730a9f6dce75cf5a406714b8ed0
References: <20260902073116.802752-1-chenwandun1@gmail.com>
	<CGME20260902073459eucas1p282f20730a9f6dce75cf5a406714b8ed0@eucas1p2.samsung.com>
	<20260902073116.802752-9-chenwandun1@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_003251_146101_6F9F69FD 
X-CRM114-Status: GOOD (  21.16  )
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
> Mark non-dumpable reserved-memory regions with MEMBLOCK_NODUMP so
> kdump can omit them from the vmcore.
>
> The marking is guarded by CONFIG_CRASH_DUMP so non-kdump kernels do not
> pay the cost of splitting memblock.memory entries at NODUMP boundaries.
>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>  drivers/of/fdt.c             |  1 +
>  drivers/of/of_private.h      |  1 +
>  drivers/of/of_reserved_mem.c | 15 +++++++++++++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index a64afc3ded3d..286fd4db6312 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1285,6 +1285,7 @@ void __init unflatten_device_tree(void)
>  
>  	/* Save the statically-placed regions in the reserved_mem array */
>  	fdt_scan_reserved_mem_late();
> +	fdt_mark_reserve_mem_nodump();
>  
>  	/* Populate an empty root node when bootloader doesn't provide one */
>  	if (!fdt) {
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 0ae16da066e2..505735732c13 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -187,6 +187,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
>  
>  int fdt_scan_reserved_mem(void);
>  void __init fdt_scan_reserved_mem_late(void);
> +void __init fdt_mark_reserve_mem_nodump(void);
>  
>  bool of_fdt_device_is_available(const void *blob, unsigned long node);
>  
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 8c9d6395d6a3..f29a07e8fb23 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -677,6 +677,21 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
>  	reserved_mem_count++;
>  }
>  
> +void __init fdt_mark_reserve_mem_nodump(void)
> +{
> +	struct reserved_mem *rmem;
> +	int i;
> +
> +	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
> +		return;
> +
> +	for (i = 0; i < reserved_mem_count; i++) {
> +		rmem = &reserved_mem[i];
> +		if (rmem->size && !rmem->dumpable)
> +			memblock_mark_nodump(rmem->base, rmem->size);
> +	}
> +}
> +
>  struct rmem_assigned_device {
>  	struct device *dev;
>  	struct reserved_mem *rmem;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



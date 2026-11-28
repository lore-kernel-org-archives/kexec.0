Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A2606A31C
	for <kexec@archiver.kernel.org>; Sat, 28 Nov 2026 02:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YlzglRKg;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SfKvHHDA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=iXm9bjNklHkCJkXC6cXS/6l9msjPSXzfutfiuU6LTJE=; b=YlzglRKgyuVryV
	JWU1GcvXnvhsi9VH83VW0+rSMmaYPawDyVuxx2bBMKT8sjTmdYze2e/LZocIlo9ZGV5+R37ejJUir
	M2hrxKSOnIFrqNlrxltZUJk7/gKFB6b6twrlgDeUPsekok7KzCTejf6TTldj3jKGb7Y3Ep2gnVu+L
	MDg4AA0Mu5KXJnZh5CIaTDJxbvIrsJPhJa5oJZmriybVkRCelsn/hhrcxy+Qd0yTBnd7LRSGfRFoe
	CAnwYCFUX1ckGElx90Ud7MrwPv1oSqVXvM46S/jJIB8thJcmGBzbfOx9e/sNMxkIdyRXnD+raTvmC
	AhzKTqZ/hZNolgaKjGog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xX8eA-00000000KL1-3QUv;
	Sat, 28 Nov 2026 02:58:42 +0000
Received: from canpmsgout03.his.huawei.com ([113.46.200.218])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xX8e5-00000000KK6-1GVV;
	Sat, 28 Nov 2026 02:58:41 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iXm9bjNklHkCJkXC6cXS/6l9msjPSXzfutfiuU6LTJE=;
	b=SfKvHHDA5DZy5PHVuUfUp7ZJIYPFO/O1wYHgqxN6U4/eJpLR+3Ela1UpPw9XS8p/TtJJrEZrr
	gDPn1UZB2A8lTM0A3I9jkCqzQxTZVWI0Nmo8f3SKrZ6KPSFo+ihxjnn+PVobzzgk/65BELmIsiR
	LEeIYm+6onwT1S/RxJyVyGY=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jbw1Y64lPzpStH;
	Sat, 28 Nov 2026 10:57:21 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 102B5202E6;
	Sat, 28 Nov 2026 10:58:29 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 28 Nov
 2026 10:58:28 +0800
Message-ID: <ad0126a1-0d5d-47eb-87fd-1df6ccfece02@huawei.com>
Date: Sat, 28 Nov 2026 10:58:27 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/8] crash_core: replace for_each_mem_range() with
 for_each_mem_region()
To: Wandun Chen <chenwandun1@gmail.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<robh@kernel.org>, <baoquan.he@linux.dev>, <rppt@kernel.org>,
	<m.szyprowski@samsung.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-mm@kvack.org>, <iommu@lists.linux.dev>
References: <20261127090723.741253-1-chenwandun1@gmail.com>
 <20261127090723.741253-5-chenwandun1@gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261127090723.741253-5-chenwandun1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_185839_205697_3381E040 
X-CRM114-Status: GOOD (  13.02  )
X-Spam-Score: -2.8 (--)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/27 17:07, Wandun Chen 写道:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> for_each_mem_range() skips MEMBLOCK_NOMAP regions implicitly. Switch the
> weak defaults to for_each_mem_region(), which exposes struct
> memblock_region and per-region flags, and filter NOMAP regions explicitly
> via the new crash_should_skip_region() helper. This prepares for a
> subsequent patch to extend the skip filter.
> 
> No functional change.
> 
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> ---
>  kernel/crash_core.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 8a861a946e26..e161c8b65e00 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -283,25 +283,34 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
>  }
>  
>  #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
> +/* Exclude NOMAP regions from the vmcore. */
> +static bool crash_should_skip_region(struct memblock_region *reg)
> +{
> +	return memblock_is_nomap(reg);


LGTM
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

> +}
> +
>  unsigned int __weak arch_get_system_nr_ranges(void)
>  {
>  	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* crashk_res + crashk_low_res, +CMA splits */
> -	phys_addr_t start, end;
> -	u64 i;
> +	struct memblock_region *reg;
>  
> -	for_each_mem_range(i, &start, &end)
> +	for_each_mem_region(reg) {
> +		if (crash_should_skip_region(reg))
> +			continue;
>  		nr_ranges++;
> +	}
>  	return nr_ranges;
>  }
>  
>  int __weak arch_crash_populate_cmem(struct crash_mem *cmem)
>  {
> -	phys_addr_t start, end;
> -	u64 i;
> +	struct memblock_region *reg;
>  
> -	for_each_mem_range(i, &start, &end) {
> -		cmem->ranges[cmem->nr_ranges].start = start;
> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
> +	for_each_mem_region(reg) {
> +		if (crash_should_skip_region(reg))
> +			continue;
> +		cmem->ranges[cmem->nr_ranges].start = reg->base;
> +		cmem->ranges[cmem->nr_ranges].end = reg->base + reg->size - 1;
>  		cmem->nr_ranges++;
>  	}
>  	return 0;



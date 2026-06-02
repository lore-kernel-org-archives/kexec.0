Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B503CD6E60
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 16:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ARchzyUNZAbw3oM5o7JzGNUTWxidv0kmAjA3GG9Rj+I=; b=Z9116DEb68Nqk5os9YCHZ59dqh
	Ss7bkPoYydW6Yp1AV6+WMJbXOgw33SEoZiwbE2u34x6Kx3xymiwe3VCCGPuopM0K5d2sgCKAOD47r
	tWaaPP4EV9sBg3susIGJwTtc0JW8Qei2aQQ8OkkU24t51fP2mBhbsqOIA2yQdeV7OXDJKy4N86CH/
	TiR6FjVkJrvBl+Igy1+08h/lTfU8w28EkMbk4EVdiPc/Skrlk48mZyzrQqfM1UkvaZCQn/pJWfAQM
	SBkr/lOveP+iEapyd3UtOE9fQfA8B6Tg5IMt3HN92R4bZBEKWNnr4wRSAgJwzhCQ3wFAfn6ZSeNdB
	QuhEQoug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wURvB-0000000DQvs-33uR;
	Tue, 02 Jun 2026 16:24:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wURvA-0000000DQvQ-0poq;
	Tue, 02 Jun 2026 16:24:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 808B96001A;
	Tue,  2 Jun 2026 16:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112731F00893;
	Tue,  2 Jun 2026 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417491;
	bh=ARchzyUNZAbw3oM5o7JzGNUTWxidv0kmAjA3GG9Rj+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hWgXm3gqMKY1cga0sOGDmfX5tuur2FyZ2+UBKReLheii8J6pYT4NdM8Jm0IdJQTQn
	 YWb5GtNBHGO5azMu8v0S2CijL/q9nO0etmifndyKMg/5hUFS6st/r1flJP8/8tttch
	 THCbDFAXfUiokcjRZ8qLXphB/uxFsMKIq/qqcvhpFYvqfilke+/F4bnb9zSexfdfMJ
	 PBW5qll4e5sf/7LoTMSvRxiI3pFmz3IHO5uXBSfN1L/ZrofDyZuS5elvTeSfdzxzJ/
	 QHyYqEaWl9xKmA0OOuDM8nLNcMlZp52JjLzyOmS/xiU9ZsWzbevIAWWlCjMz0sBFvA
	 xnlna8VtJdPPA==
Date: Tue, 2 Jun 2026 11:24:50 -0500
From: Rob Herring <robh@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com,
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, m.szyprowski@samsung.com,
	robin.murphy@arm.com, quic_obabatun@quicinc.com
Subject: Re: [PATCH v3 03/11] of: reserved_mem: avoid post-init UAF when
 alloc_reserved_mem_array() fails
Message-ID: <20260602162450.GA442759-robh@kernel.org>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <20260527032917.3385849-4-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527032917.3385849-4-chenwandun1@gmail.com>
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

On Wed, May 27, 2026 at 11:29:09AM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> The global pointer 'reserved_mem' continues to reference the
> reserved_mem_array which lives in __initdata if
> alloc_reserved_mem_array() fails. of_reserved_mem_lookup() is
> exported for post-init use, that would dereference freed memory
> and trigger a use-after-free.
> 
> So reset reserved_mem_count to 0 when alloc_reserved_mem_array()
> fails.
> 
> Fixes: 00c9a452a235 ("of: reserved_mem: Add code to dynamically allocate reserved_mem array")

Fixes should come first in a series.

> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> ---
>  drivers/of/of_reserved_mem.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 313cbc57aa45..6d479381ff1f 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -69,29 +69,31 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>   * the initial static array is copied over to this new array and
>   * the new array is used from this point on.
>   */
> -static void __init alloc_reserved_mem_array(void)
> +static bool __init alloc_reserved_mem_array(void)
>  {
>  	struct reserved_mem *new_array;
>  	size_t alloc_size, copy_size, memset_size;
>  
> +	if (!total_reserved_mem_cnt)
> +		return true;
> +
>  	alloc_size = array_size(total_reserved_mem_cnt, sizeof(*new_array));
>  	if (alloc_size == SIZE_MAX) {
>  		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);
> -		return;
> +		goto fail;
>  	}
>  
>  	new_array = memblock_alloc(alloc_size, SMP_CACHE_BYTES);
>  	if (!new_array) {
>  		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -ENOMEM);
> -		return;
> +		goto fail;
>  	}
>  
>  	copy_size = array_size(reserved_mem_count, sizeof(*new_array));
>  	if (copy_size == SIZE_MAX) {
>  		memblock_free(new_array, alloc_size);
> -		total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
>  		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);

These prints could be moved to 'fail'. Perhaps instead of just printing 
an error value, you can return the error value instead of boolean.

If you respin just this patch, I can pick it up for 7.2.

Rob


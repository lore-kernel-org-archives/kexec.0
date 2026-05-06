Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCF3CD3427
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 01:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5QkCCPmEUet18iwVTOXpl2KN3gCpaXWtyiZR527oaXs=; b=fkJAhyxUgJEYBkUmRWWrPZQVtz
	rWK40gZMvFiV2lWaYZwxOQK7EdFyS0xZsh5u3phL3hASHTQAp/JqzU9ZuH+y0rdsAuggyieWQTP8t
	djdLPzRZyK6Jiq/LJyVU6yH63gPf/VaRCAFlDOZD72eHYBsCQOUdAU93o7vifOVazDo12IIkapX+G
	aYK+qIPaATHxFfZXpho3gP00SOcVOj6wIvI6N5cACli5yF6Rnu4U7PT0CMHYWKUA3Hok1q2ID4rpR
	FmzM8E8DY/kBWN0UUwouzpp49nEVMx8bgxBOOQXHqrc0xWpljrOA9RtTBnFtK098JmayD69uvB4+L
	Y9Oma8BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKRPy-00000000SS3-3sWg;
	Wed, 06 May 2026 01:51:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKRPx-00000000SRn-0WRy;
	Wed, 06 May 2026 01:51:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0F6E760123;
	Wed,  6 May 2026 01:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E996C2BCB4;
	Wed,  6 May 2026 01:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032274;
	bh=rZGbP7UVSJQLbomugjy0SBe34Yd1bEsmhshX1oItOXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKnMC9Af9zyMVkAZ3683otI/LgubBaZvrCRPg4y2mubUZ8JHFwvPcQC4rztW27bOm
	 kOm7cwUT07yU8UYQz4zLdvuVbzLSWaprXSNOZzVhfuTni8P0PxH6BM681/2D3j+/ob
	 CjALN1Mhcgdob4ftf2pzjZp9Nh3j3IM3tQcpEi8mRqDKrm54QcW1LESyIla3EGmwip
	 H29FY6TLiKOswKlzYRB6BS9cvZJm/2U96hMnZzDeAv/wkdgs+f2Shuf6VeUsJOdB2X
	 0hAMQ1Je+3KqqL6lZe4Hn8OJ8OSJJzIz8HlF9vIFq8Ywqbs/TkTcDj9dNhN/KGiB90
	 +HV47N+hmO7/Q==
Date: Tue, 5 May 2026 20:51:12 -0500
From: Rob Herring <robh@kernel.org>
To: Chen Wandun <chenwandun1@gmail.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, akpm@linux-foundation.org,
	bhe@redhat.com, rppt@kernel.org, pasha.tatashin@soleen.com,
	pratyush@kernel.org, ruirui.yang@linux.dev, corbet@lwn.net,
	skhan@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org,
	chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, saravanak@kernel.org,
	chenwandun@lixiang.com, zhaomeijing@lixiang.com, everyzhao@126.com
Subject: Re: [PATCH 02/11] of: reserved_mem: reject reserved memory outside
 physical address range
Message-ID: <20260506015112.GA286568-robh@kernel.org>
References: <20260429065831.1510858-1-chenwandun@lixiang.com>
 <20260429065831.1510858-3-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429065831.1510858-3-chenwandun@lixiang.com>
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

On Wed, Apr 29, 2026 at 02:58:22PM +0800, Chen Wandun wrote:
> early_init_dt_reserve_memory() does not validate whether the region
> falls within physical memory. If a device tree incorrectly specifies a
> reserved memory region outside the physical address range:
> 
>  - For the non-nomap path, memblock_reserve() blindly adds the region
>    to memblock.reserved, creating a stale entry that refers to
>    non-existent memory.
> 
>  - For the nomap path, memblock_mark_nomap() silently fails to match
>    any region in memblock.memory, but still returns success.
> 
> Add a memblock_overlaps_region() check at the entry of
> early_init_dt_reserve_memory() to reject such regions before any
> memblock operation takes place. This also simplifies the existing nomap
> guard: the original "overlaps && is_reserved" condition reduces to just
> "is_reserved", since the overlap with physical memory is already
> guaranteed by the new check.

While I agree, I suspect we already have cases abusing reserved-memory 
like this.

> 
> Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
> Tested-by: Zhao Meijing <zhaomeijing@lixiang.com>
> ---
>  drivers/of/of_reserved_mem.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 9d1b0193864c..03c676052dab 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -112,14 +112,21 @@ static int fdt_fixup_reserved_mem_node(unsigned long node,
>  static int __init early_init_dt_reserve_memory(phys_addr_t base,
>  					       phys_addr_t size, bool nomap)
>  {
> +	if (!memblock_overlaps_region(&memblock.memory, base, size)) {
> +		phys_addr_t end = base + size - 1;
> +
> +		pr_warn("Reserved memory region %pa..%pa is outside of physical memory\n",
> +			&base, &end);
> +		return -EINVAL;
> +	}
> +
>  	if (nomap) {
>  		/*
>  		 * If the memory is already reserved (by another region), we
> -		 * should not allow it to be marked nomap, but don't worry
> -		 * if the region isn't memory as it won't be mapped.
> +		 * should not allow it to be marked nomap. The region being
> +		 * physical memory is guaranteed by the overlap check above.
>  		 */
> -		if (memblock_overlaps_region(&memblock.memory, base, size) &&
> -		    memblock_is_region_reserved(base, size))
> +		if (memblock_is_region_reserved(base, size))
>  			return -EBUSY;
>  
>  		return memblock_mark_nomap(base, size);
> -- 
> 2.43.0
> 


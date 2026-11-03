Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB62606A326
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TH3DFZ55;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaxGzOap
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2V/ndYvkVxA79d43Mf+7vdJDqWuLHWGgjyn9NcOP058=; b=TH3DFZ55bnJf+ioC8aSUzeZ0+0
	9f5LGuJDRH2d2NWcr5dezYUcHp6rcUHiJkzYG/F7MTrz1lImSKsssQ1jBrPNKQ/gdS63rmCPIai0p
	Kbaq56Cnp1GtIu/Z1SWD168v++Nb8VbIm0GBIQunMzwwdvhgp2yVPJdTGvAyqYF5LYcPswUigQU9u
	AQ7Jlti3gXwFBrnBLqFJSWlk2jfo8D+yN7trwm3gPH/ykC6SukKgqBZNSFNEKixWM7y0HKYZbon8a
	iFQlvgEbCLiW2/6aK5XTRazWL56J0MHCdFOMJg1gvwIIrEue+K5VmPKCGc3a5x+GIf0Yn2wLmHLTL
	BCrDiAaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFHe-00000002gpU-2Z1S;
	Tue, 03 Nov 2026 14:14:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFHd-00000002gpE-1gBr
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:14:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 39E136020A;
	Tue,  3 Nov 2026 14:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AE71F000C1;
	Tue,  3 Nov 2026 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793715279;
	bh=2V/ndYvkVxA79d43Mf+7vdJDqWuLHWGgjyn9NcOP058=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=aaxGzOapyHfFlHAjXCCWCjylt3vC/AQ1UNK9BFKFXitIBtPZrbR/XMTiI3H58/9B3
	 rm4qwhVZkPr9afPfqC+SFSfDnkPN/4pEHVC1sK4quxxp1Rc5hVPXwC3DOw6tsidh9H
	 MFXS5kQySyEbKY0PlI8frUlR0NraysItCxrW/vRVEkyB7L9oRSQz4l6B9ikb/ZLeqH
	 e9UYc9Xglp9TUTDi2YQU+w++JAwJxwGWJQF6La9NcirxdMEI7eyWYBWmUXQ376ZAlr
	 nkMeyLqyu6kO0wR8Sh0e85LlWSp4vP1DPz82PnnY3yl2gSyJfBzbsZEp02Z5x51mnz
	 3UduQA6+/qHHw==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chen Pei <cp0613@linux.alibaba.com>,  George
 Guo <guodongtai@kylinos.cn>,  Kexin Liu <liukexin@kylinos.cn>,  Sourabh
 Jain <sourabhjain@linux.ibm.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH 1/2] kho: skip zero-sized lowmem and global bootmem areas
In-Reply-To: <20261103-kho-bootmem-sizing-v1-1-45aa74098f34@kernel.org> (Mike
	Rapoport's message of "Tue, 03 Nov 2026 13:49:49 +0200")
References: <20261103-kho-bootmem-sizing-v1-0-45aa74098f34@kernel.org>
	<20261103-kho-bootmem-sizing-v1-1-45aa74098f34@kernel.org>
Date: Tue, 03 Nov 2026 15:14:36 +0100
Message-ID: <2vxza4nqm27n.fsf@kernel.org>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mike,

On Tue, Nov 03 2026, Mike Rapoport (Microsoft) wrote:

> The lowmem and the global bootmem areas can have zero size, for example
> when none or all of the memory is below ARCH_LOW_ADDRESS_LIMIT, or when
> either of those areas is explicitly set to zero with kho_bootmem=.
>
> For a zero-sized allocation memblock returns an address without reserving
> anything, and that empty area is recorded in kho_bootmem. If there is no
> memory below ARCH_LOW_ADDRESS_LIMIT, allocation of the empty lowmem area
> fails and KHO gets disabled.
>
> Extract a helper that checks for zero size and allocates memory from
> memblock, and use it to skip empty areas the same way as empty per-node
> areas are skipped.
>
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Reported-by: Chen Pei <cp0613@linux.alibaba.com>
> Closes: https://lore.kernel.org/all/20261026131851.9942-1-cp0613@linux.alibaba.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks for the patch! LGTM for the most part, one minor nitpick below.

> ---
>  kernel/liveupdate/kexec_handover.c | 61 ++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 32 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 6f1f55fe31819..f268c57413a7e 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -820,6 +820,27 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
>  	return false;
>  }
>  
> +static int __init kho_reserve_bootmem_area(int *idx, phys_addr_t size,
> +					   phys_addr_t end, int nid)
> +{
> +	phys_addr_t addr;
> +	int i = *idx;
> +
> +	if (!size)
> +		return 0;
> +
> +	addr = memblock_alloc_range_nid(size, BOOTMEM_ALIGNMENT_BYTES, 0, end,
> +					nid, true);
> +	if (!addr)
> +		return -ENOMEM;
> +
> +	kho_bootmem[i].addr = addr;
> +	kho_bootmem[i].size = size;
> +	*idx = i + 1;
> +
> +	return 0;

I reckon it will be cleaner if you update kho_bootmem_cnt here directly.
So you directly do:

	kho_bootmem[kho_bootmem_cnt].addr = addr;
	kho_bootmem[kho_bootmem_cnt].size = size;
	kho_bootmem_cnt++;

You won't have to pass around *idx and you won't need the final
kho_bootmem_cnt assignment.

You might also want to have a kho_bootmem_max_cnt and do some bounds
checking here.

What do you think?

> +}
> +
>  /**
>   * kho_reserve_bootmem - Reserve a contiguous chunk of memory for kexec
>   *
> @@ -832,7 +853,7 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
>  static void __init kho_reserve_bootmem(void)
>  {
>  	int nid, i = 0, max_nr_bootmem;
> -	phys_addr_t addr, size;
> +	phys_addr_t size;
>  
>  	if (!kho_enable)
>  		return;
> @@ -852,56 +873,32 @@ static void __init kho_reserve_bootmem(void)
>  	 * reserve bootmem area in low memory for lowmem allocations in the
>  	 * next kernel
>  	 */
> -	size = bootmem_size_lowmem;
> -	addr = memblock_phys_alloc_range(size, BOOTMEM_ALIGNMENT_BYTES, 0,
> -					 ARCH_LOW_ADDRESS_LIMIT);
> -	if (!addr) {
> +	if (kho_reserve_bootmem_area(&i, bootmem_size_lowmem,
> +				     ARCH_LOW_ADDRESS_LIMIT, NUMA_NO_NODE)) {
>  		pr_err("Failed to reserve lowmem bootmem\n");
>  		goto err_free_bootmem_desc;
>  	}
>  
> -	kho_bootmem[i].addr = addr;
> -	kho_bootmem[i].size = size;
> -	i++;
> -
>  	/* reserve large contiguous area for allocations without nid */
> -	size = bootmem_size_global;
> -	addr = memblock_phys_alloc(size, BOOTMEM_ALIGNMENT_BYTES);
> -	if (!addr) {
> +	if (kho_reserve_bootmem_area(&i, bootmem_size_global,
> +				     MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE)) {
>  		pr_err("Failed to reserve global bootmem\n");
>  		goto err_free_bootmem_areas;
>  	}
>  
> -	kho_bootmem[i].addr = addr;
> -	kho_bootmem[i].size = size;
> -	i++;
> -
>  	/*
>  	 * Loop over nodes that have both memory and are online. Skip
>  	 * memoryless nodes, as we can not allocate bootmem areas there.
>  	 */
>  	for_each_node_state(nid, N_MEMORY) {
> -		size = bootmem_size_node(nid);
> -		if (!size)
> -			continue;
> -
> -		addr = memblock_alloc_range_nid(size, BOOTMEM_ALIGNMENT_BYTES,
> -						0, MEMBLOCK_ALLOC_ACCESSIBLE,
> -						nid, true);
> -		if (!addr) {
> +		if (kho_reserve_bootmem_area(&i, bootmem_size_node(nid),
> +					     MEMBLOCK_ALLOC_ACCESSIBLE, nid)) {
>  			pr_err("Failed to reserve nid %d bootmem\n", nid);
>  			goto err_free_bootmem_areas;
>  		}
> -
> -		kho_bootmem[i].addr = addr;
> -		kho_bootmem[i].size = size;
> -		i++;
>  	}
>  
> -	/*
> -	 * Nodes that needed no bootmem were skipped, so fewer areas than
> -	 * initially estimated may have been reserved.
> -	 */
> +	/* Areas with zero size were skipped */
>  	kho_bootmem_cnt = i;
>  
>  	return;

-- 
Regards,
Pratyush Yadav


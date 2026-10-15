Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDDFCC6B2F
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 08:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NLcSuJO4U8vjtpBw9Dd1guU9F3I58AzL7EvX+dUZ0Qo=; b=u3V2tekyy/1cHEBs7GeDAyN/gW
	exMbKuQVyFwwRIIzHVTsr8+X6FJl37WsWMQcwRea3ZTkgHxPPD6X5cqahzvuzgA1cQNM2LRKCfAXZ
	0AxhZb+CLMUh1u6Vrf4O3gfdPbKSuWLDz4FJsO7UDBvphGrEG+//Y0538QGg/VOGO3z27n2CjixwF
	SjkJMScq+fYyTiTiOxWSuMilSDMMdapR8VqeYExWLG8stpfteh73G20ZVDPxcLnxKOCnAFscw7UEq
	Veo0XLvb1J14oYju4Z4JI9s34tJxl+MOWniUcWeKfi4bdmC1Y8KJutN60WQ266WdCx1K0HmYZjh8T
	vPG4+pqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHGxV-0000000HAP1-3ucT;
	Thu, 15 Oct 2026 08:37:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHGxV-0000000HAOb-10sd
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 08:37:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B4A1B43C14;
	Thu, 15 Oct 2026 08:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1BB1F000C4;
	Thu, 15 Oct 2026 08:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792053424;
	bh=NLcSuJO4U8vjtpBw9Dd1guU9F3I58AzL7EvX+dUZ0Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ceFJqAFLM7g4NE9wZsEJoybbeHVCVxchnM7ejTiim3IUlIFyU3ctm4G9tESzMQMla
	 DtM5RNVSK1/JVG2PJqbDaMrJtDeUiCNnpI7BbLZkgoooSQUevs8vV++LK021vfv2cV
	 2pdkgAjUJy8kcL1c/QXjLltJq619Z1+4uE0gOSXKSgBn9+sAjWca4ng0iBZb/Wj+HF
	 DoQgKlj4SpKEMEYFJaqRJssFTt18waBVfOXf1eOWjRYA2znJ1KOFyqgCAu6Qk1i1kL
	 LzSTCa3+D34hc8AKJVAg7VQxtm+MGSw+6K9TtN/GxtwaY4A1HRstooBKVORn402cMK
	 YJKOUb/qL/qqg==
Date: Thu, 15 Oct 2026 11:36:58 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Bing Jiao <bingjiao@google.com>
Subject: Re: [PATCH] kho: do not reserve empty per-node bootmem areas
Message-ID: <atCQqghin0KOyx63@kernel.org>
References: <20261014131547.259138-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014131547.259138-1-pratyush@kernel.org>
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

On Wed, Oct 14, 2026 at 03:15:44PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Some nodes do not allocate any early boot memory. An example is
> hotpluggable nodes with movable_node enabled. So the scratch size for

                          Let's use the new naming please ^ ;-)

I'll fix it up when applying.

> them ends up being zero. Zero size allocations normally don't play well
> with memblock. Memblock returns an address, but then doesn't actually
> reserve anything. This address ends up being recorded in kho_bootmem
> with a size of 0. In case of hotpluggable nodes with movable_nodes, the
> allocation on the node actually fails because memblock refuses to
> allocate there, and so KHO fails to initialize.
> 
> Skip bootmem reservation for such nodes entirely.
> 
> To keep the code more robust, avoid overloading kho_bootmem_cnt. use
> max_nr_bootmem to store the size of kho_bootmem array. This ensures that
> the location of kho_bootmem_cnt assignment does not affect the cleanup
> paths.
> 
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Reported-by: Bing Jiao <bingjiao@google.com>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 7018e25e4eda..6f1f55fe3181 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -831,8 +831,8 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
>   */
>  static void __init kho_reserve_bootmem(void)
>  {
> +	int nid, i = 0, max_nr_bootmem;
>  	phys_addr_t addr, size;
> -	int nid, i = 0;
>  
>  	if (!kho_enable)
>  		return;
> @@ -840,8 +840,8 @@ static void __init kho_reserve_bootmem(void)
>  	bootmem_size_update();
>  
>  	/* FIXME: deal with node hot-plug/remove */
> -	kho_bootmem_cnt = nodes_weight(node_states[N_MEMORY]) + 2;
> -	size = kho_bootmem_cnt * sizeof(*kho_bootmem);
> +	max_nr_bootmem = nodes_weight(node_states[N_MEMORY]) + 2;
> +	size = max_nr_bootmem * sizeof(*kho_bootmem);
>  	kho_bootmem = memblock_alloc(size, PAGE_SIZE);
>  	if (!kho_bootmem) {
>  		pr_err("Failed to reserve bootmem array\n");
> @@ -882,6 +882,9 @@ static void __init kho_reserve_bootmem(void)
>  	 */
>  	for_each_node_state(nid, N_MEMORY) {
>  		size = bootmem_size_node(nid);
> +		if (!size)
> +			continue;
> +
>  		addr = memblock_alloc_range_nid(size, BOOTMEM_ALIGNMENT_BYTES,
>  						0, MEMBLOCK_ALLOC_ACCESSIBLE,
>  						nid, true);
> @@ -895,13 +898,19 @@ static void __init kho_reserve_bootmem(void)
>  		i++;
>  	}
>  
> +	/*
> +	 * Nodes that needed no bootmem were skipped, so fewer areas than
> +	 * initially estimated may have been reserved.
> +	 */
> +	kho_bootmem_cnt = i;
> +
>  	return;
>  
>  err_free_bootmem_areas:
>  	for (i--; i >= 0; i--)
>  		memblock_phys_free(kho_bootmem[i].addr, kho_bootmem[i].size);
>  err_free_bootmem_desc:
> -	memblock_free(kho_bootmem, kho_bootmem_cnt * sizeof(*kho_bootmem));
> +	memblock_free(kho_bootmem, max_nr_bootmem * sizeof(*kho_bootmem));
>  err_disable_kho:
>  	pr_warn("Failed to reserve bootmem, disabling kexec handover\n");
>  	kho_enable = false;
> 
> base-commit: e1fe7daedae7a4a23aca6dbd58e1746750b632dc
> -- 
> 2.56.0.385.gd3acb90ef8-goog
> 

-- 
Sincerely yours,
Mike.


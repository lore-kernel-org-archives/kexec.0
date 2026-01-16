Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6CFD48990
	for <kexec@archiver.kernel.org>; Fri, 16 Jan 2026 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZlOIbNUCEgilbaY1KGaFBHB7qA7SGL79lCxCJaeM+TE=; b=IdK9xi/mFMHHhKjEAq5c5QpcAD
	cArTzN6sDduCJPvf0/aC38yCfrgXmXZjUtp4WFOOp7fy8KL3WD47CPI8I8fknrU5Up7acOk2V5o36
	3fWh4TvtzDBYlUHeYmNZumQximo86BmSHoKNOuKFCmJ0eytzMVD9ge5gMj0roHfduOeOZvg0KouFk
	j6fa315okSirBcwvWF33Ol6yXIlJW/GbZjdQtM0lVNyV14S1jIFEhtLaA+8my5soBLVFFoKL0y/MM
	xPA87eMLlggS/Hp61q8ANg4O4qiZBSg9w3ivCPy7ZFZbBMlDagejOrAY8KbUJKXtDM9zyQTZqJDoV
	zj0M1DgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgiS8-0000000E4q4-1XHE;
	Fri, 16 Jan 2026 11:57:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgiS6-0000000E4pu-3up7
	for kexec@lists.infradead.org;
	Fri, 16 Jan 2026 11:57:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0F32D601B2;
	Fri, 16 Jan 2026 11:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1146CC19423;
	Fri, 16 Jan 2026 11:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768564637;
	bh=6SDIwhdUvWr8ewpLO9jVWgrS1866uQekJSM327jVKA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hOcOOVnbFJZHY+6yr3s6ggGs2USLu/6pg8AM9s1qhAq8dxpyxu2RQCfeWUItuRHIs
	 jt7/yWca2D2fWNieB8Kz8ZrRGE81TvhXbv/ebxDCRHIg373WcldjDR0aRTFwWdWNlq
	 m25R3zKYRoJ0peAIUvrkdciinHFKOZZpNMTlZEX7wqoZ5/pvj6WJmzYZ4sfi6OqWDQ
	 qLbm64nXLy2tfNhp0vIsCU/8ohNsEQyRdoTySUPjkHTSjyqZOSQYfpacLSWzSwNuC6
	 UsyefUb9VlmycNTcU1Wp3Sg5JOw+Yijv7QuVGPmlu010D5zSy/SaA/Z2M0duqyAzBv
	 PBdlJSELC0Frw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  "Alexander Graf" <graf@amazon.com>,  Jason Miu <jasonmiu@google.com>,
  <linux-kernel@vger.kernel.org>,  <kexec@lists.infradead.org>,
  <linux-mm@kvack.org>,  <nh-open-source@amazon.com>
Subject: Re: [PATCH] kho: skip memoryless NUMA nodes when reserving scratch
 areas
In-Reply-To: <20260116112640.64900-1-epetron@amazon.de> (Evangelos
	Petrongonas's message of "Fri, 16 Jan 2026 11:26:35 +0000")
References: <20260116112640.64900-1-epetron@amazon.de>
Date: Fri, 16 Jan 2026 11:57:14 +0000
Message-ID: <2vxzsec57oth.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Evangelos,

On Fri, Jan 16 2026, Evangelos Petrongonas wrote:

> kho_reserve_scratch() iterates over all online NUMA nodes to allocate
> per-node scratch memory. On systems with memoryless NUMA nodes (nodes
> that have CPUs but no memory), memblock_alloc_range_nid() fails because
> there is no memory available on that node. This causes KHO initialization
> to fail and kho_enable to be set to false.
>
> Some ARM64 systems have NUMA topologies where certain nodes contain only
> CPUs without any associated memory. These configurations are valid and
> should not prevent KHO from functioning.
>
> Fix this by introducing kho_mem_nodes_count() which counts only nodes
> that have memory (N_MEMORY state), and skip memoryless nodes in the
> per-node scratch allocation loop.
>
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
>  kernel/liveupdate/kexec_handover.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 9dc51fab604f..c970ed08b477 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -623,6 +623,23 @@ static phys_addr_t __init scratch_size_node(int nid)
>  	return round_up(size, CMA_MIN_ALIGNMENT_BYTES);
>  }
>  
> +/*
> + * Count online NUMA nodes that have memory. Memoryless nodes cannot have
> + * scratch memory and should be excluded.
> + */
> +static unsigned int __init kho_mem_nodes_count(void)
> +{
> +	unsigned int cnt = 0;
> +	int nid;
> +
> +	for_each_online_node(nid) {
> +		if (node_state(nid, N_MEMORY))
> +			cnt++;
> +	}
> +
> +	return cnt;
> +}
> +

You don't need this. You can use nodes_weight(nodes_state[N_MEMORY])
directly. Other than this, LGTM.

>  /**
>   * kho_reserve_scratch - Reserve a contiguous chunk of memory for kexec
>   *
> @@ -643,7 +660,7 @@ static void __init kho_reserve_scratch(void)
>  	scratch_size_update();
>  
>  	/* FIXME: deal with node hot-plug/remove */
> -	kho_scratch_cnt = num_online_nodes() + 2;
> +	kho_scratch_cnt = kho_mem_nodes_count() + 2;
>  	size = kho_scratch_cnt * sizeof(*kho_scratch);
>  	kho_scratch = memblock_alloc(size, PAGE_SIZE);
>  	if (!kho_scratch)
> @@ -674,6 +691,10 @@ static void __init kho_reserve_scratch(void)
>  	i++;
>  
>  	for_each_online_node(nid) {
> +		/* Skip memoryless nodes - we cannot allocate scratch memory there */
> +		if (!node_state(nid, N_MEMORY))
> +			continue;
> +
>  		size = scratch_size_node(nid);
>  		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
>  						0, MEMBLOCK_ALLOC_ACCESSIBLE,

-- 
Regards,
Pratyush Yadav


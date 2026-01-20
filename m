Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7867D2628A
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 19:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lq3aLbEqRyA37VDbVG+GjNtcxF/ESTkZeYhJniRXhow=; b=N+Rmc4t1okdBr1wcAoRyCEbM7S
	qXzOKwvV9YGyu0rsYgxj/WjilF2VS6673F8Ex09SuSLIGGFe3eGbdWo5f9ZuTJwxLMio/Dc47at/6
	zHHn5n1io2UX0Hjpb2LLO3CTizuUF+3ZQzc7DV3SBkX0rRDTLjDKSLW55wo1xk42Qx/sRkzaRf5id
	EZskaduxBIQxErb+ypp11SLJgcLHKiaKfg5PaZJOyyL8bDZZqauOch1iBQPmINrx4ut/Pa/bqr2hA
	UHp/h5NfC0TrtqioRObRdws7ayQAB08xghZiPlmwIiLP5vOxYcmVW7LRcAoLE5IWazjGQAuVRzpml
	r/MYqI0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGxc-00000004Kfw-3RFW;
	Tue, 20 Jan 2026 19:00:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGxb-00000004KfZ-088S
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 19:00:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 78868600BB;
	Tue, 20 Jan 2026 19:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A071C16AAE;
	Tue, 20 Jan 2026 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768935614;
	bh=yvQMSUis/1NCpptkFQ9k3gZYHiivZOEOD7LfuZ7H1ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bxw8pyjHejSup2eL6mvA96uU19t1osAViIerhPz9jEnZivgiUot4+fBfGEx0iha+T
	 tXrlbmjA2vd6EeDIeLRb2kKyZz70+J3Lr77AfxsAALlJdTn0+9HmXJY2vVEfquWKl+
	 /kUgz8xUTkbXsDISlW7QbcnuTK+LqCWkiBo4cft+B3f0bWY8VaUZvdrh5qXW97zWu+
	 Xwojtdzz62UqOT6v+AEq2StJ47k/j+r5XCK4QMrieSUO8Dxi0VYsRqff8ZaCPywzDC
	 kk+ZxOYZl+u0wBH1Yd6NDCEzY7/NzyT+lk7J1sMjayMtIa2SKc2vNKYRBOWT+MAnMQ
	 3/uXHubLDOvIA==
Date: Tue, 20 Jan 2026 21:00:07 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>, Jason Miu <jasonmiu@google.com>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, nh-open-source@amazon.com
Subject: Re: [PATCH v2] kho: skip memoryless NUMA nodes when reserving
 scratch areas
Message-ID: <aW_Qtz6X-XErS74D@kernel.org>
References: <20260120175913.34368-1-epetron@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120175913.34368-1-epetron@amazon.de>
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

On Tue, Jan 20, 2026 at 05:59:11PM +0000, Evangelos Petrongonas wrote:
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
> Fix this by only counting nodes that have memory (N_MEMORY state) and
> skip memoryless nodes in the per-node scratch allocation loop.
> 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> v2:
> - Removed kho_mem_nodes_count in favour of nodes_weight(nodes_state[N_MEMORY])
> - Use for_each_node_state(nid, N_MEMORY) to loop over nodes that are both
> online and have memory.
> TIL: Nodes in N_MEMORY are a subset of those that are online. Thanks Mike :)
> 
>  kernel/liveupdate/kexec_handover.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 9dc51fab604f..979ebaf015bf 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -643,7 +643,7 @@ static void __init kho_reserve_scratch(void)
>  	scratch_size_update();
>  
>  	/* FIXME: deal with node hot-plug/remove */
> -	kho_scratch_cnt = num_online_nodes() + 2;
> +	kho_scratch_cnt = nodes_weight(node_states[N_MEMORY]) + 2;
>  	size = kho_scratch_cnt * sizeof(*kho_scratch);
>  	kho_scratch = memblock_alloc(size, PAGE_SIZE);
>  	if (!kho_scratch)
> @@ -673,7 +673,11 @@ static void __init kho_reserve_scratch(void)
>  	kho_scratch[i].size = size;
>  	i++;
>  
> -	for_each_online_node(nid) {
> +	/*
> +	 * Loop over nodes that have both memory and are online. Skip
> +	 * memoryless nodes, as we can not allocate scratch areas there.
> +	 */
> +	for_each_node_state(nid, N_MEMORY) {
>  		size = scratch_size_node(nid);
>  		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
>  						0, MEMBLOCK_ALLOC_ACCESSIBLE,
> -- 
> 2.43.0
> 
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
> 

-- 
Sincerely yours,
Mike.


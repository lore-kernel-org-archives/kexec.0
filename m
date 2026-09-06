Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55F1C79F99
	for <kexec@archiver.kernel.org>; Sun,  6 Sep 2026 20:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6dLtZ4diiABDwf70eKATggUD/DCfK2UIavuZ29uFn94=; b=OwPmTi+Ez8YKPeQ4UTfHT5zeU0
	dKq93Aa6QWXEdH4t7gLGPO0ASqZrgh27xVeZ9Sklcr8fMXJ07IF2MJe1dUQWXkaOvPGgLd4TlC9Ae
	WGpk0c8aky3CK/HsaU3UqCcYJTDVCMbt4cL1zJ5rTwh1VPnrT4Tst3a4pJfjwX3qAvJfXbBanfaDj
	LpoX2ct5gm4ufnkCBXpcrS+k7QyrDsSDY6xu57pmR8nYc1paYHRjTRDe5cZWj0UtAIV+sm7CGAiJN
	7s6W6MGXoaErLBkt0026PDwjryrDshU3gFZJp/HzERsXcedFVtD7/lcq5gtZ8TbtBimP53KYlwVhd
	L6CsD31w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3J9j-00000005XQ0-2RBa;
	Sun, 06 Sep 2026 20:07:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3J9j-00000005XPu-0SVL
	for kexec@lists.infradead.org;
	Sun, 06 Sep 2026 20:07:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2325B601F9;
	Sun,  6 Sep 2026 20:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AFA1F00A3A;
	Sun,  6 Sep 2026 20:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788725277;
	bh=6dLtZ4diiABDwf70eKATggUD/DCfK2UIavuZ29uFn94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RqoOuRgRG1enfRI1D9SjcgS9tKVhnFREjkX+IlSFfMW3MsqNns+AWPlyPdeEKBY7e
	 uG2BwFv3LXCAunkIOcVcViIXknbGSpB/bAjMbYO+mF2ZGpYOTTsSbcswzh6Fk7Bspk
	 xoRdD8yV3EJZtO7zX2zPJxTGqrjmO5vXSbfXu6LB+CQU0sfi3Y3uUHxZppAMqYvAoR
	 5eXN/m+EszZdq0meyMub1OCprX5zkG3e4PePLPkwZ7ydRDpkCPRWlF/F33DUyD2oX9
	 OdIfAzYrAWfx2F44BxBIa/LZtftjfA4FnjPC4YITR6DlSoZQynoO34dyoQrkzp6mLU
	 e9LTmn9kZa7gA==
Date: Sun, 6 Sep 2026 23:07:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com,
	changyuanl@google.com, akpm@linux-foundation.org,
	chenhuacai@kernel.org, liukexin@kylinos.cn, guodongtai@kylinos.cn,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] liveupdate: kho: calculate per-node scratch sizes
 before allocation
Message-ID: <ap3IFd2FVvfKkHkV@kernel.org>
References: <20260904025101.9959-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904025101.9959-1-dongtai.guo@linux.dev>
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

Hi George,

On Fri, Sep 04, 2026 at 10:51:01AM +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> The default percentage-based policy sizes scratch areas from the current
> kernel's MEMBLOCK_RSRV_KERN footprint. This is a reasonable heuristic for
> predicting the early memory demand of the next kernel.
> 
> scratch_size_update() calculates the lowmem and global sizes before either
> area is allocated. However, kho_reserve_scratch() calculates each per-node
> size only after allocating the lowmem and global areas. Since memblock
> allocations are marked MEMBLOCK_RSRV_KERN, the per-node calculation
> includes those newly allocated scratch areas and scales them again.
> 
> This feedback substantially inflates the per-node request. On a 1 GiB
> LoongArch QEMU guest, the relevant reservation baseline is about
> 98.45 MiB. With the default 200% scale and 32 MiB alignment, the old
> ordering allocates 224 MiB of lowmem scratch, then requests 672 MiB for
> node 0, for a total of 896 MiB. The node allocation fails and KHO is
> disabled. The same incorrect calculation is hidden on the tested 1 GiB
> x86 guest because its baseline is smaller and its memory map can satisfy
> the inflated request.
> 
> Calculate and save all per-node sizes in the scratch descriptors before
> reserving any scratch areas, then use the saved sizes during allocation.
> This keeps the percentage heuristic while preventing scratch memory from
> becoming input to the sizing of more scratch memory. On the LoongArch
> guest, the aligned total is reduced from 896 MiB to 448 MiB.
> 
> The KHO vmtest passes on 1 GiB LoongArch and x86 QEMU guests with this
> change.

This reads as LLM-generated text. Please add LLM attribution as per 

https://docs.kernel.org/process/coding-assistants.html#attribution
 
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Reported-by: Kexin Liu <liukexin@kylinos.cn>
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  kernel/liveupdate/kexec_handover.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 7c4d86daf86d..39f489a258d9 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -847,6 +847,17 @@ static void __init kho_reserve_scratch(void)
>  		goto err_disable_kho;
>  	}
>  
> +	/*
> +	 * Calculate the per-node sizes before reserving any scratch areas.
> +	 * memblock allocations are marked MEMBLOCK_RSRV_KERN, so calculating
> +	 * them later would count the lowmem and global scratch areas as kernel
> +	 * allocations and scale them again.
> +	 */
> +	i = 2;
> +	for_each_node_state(nid, N_MEMORY)
> +		kho_scratch[i++].size = scratch_size_node(nid);
> +	i = 0;

Ugh, this really does not look nice.
Can't we just calculated all the sizes first and than do the allocations?

> +
>  	/*
>  	 * reserve scratch area in low memory for lowmem allocations in the
>  	 * next kernel
> @@ -880,7 +891,7 @@ static void __init kho_reserve_scratch(void)
>  	 * memoryless nodes, as we can not allocate scratch areas there.
>  	 */
>  	for_each_node_state(nid, N_MEMORY) {
> -		size = scratch_size_node(nid);
> +		size = kho_scratch[i].size;
>  		addr = memblock_alloc_range_nid(size, SCRATCH_ALIGNMENT_BYTES,
>  						0, MEMBLOCK_ALLOC_ACCESSIBLE,
>  						nid, true);
> -- 
> 2.53.0
> 

-- 
Sincerely yours,
Mike.


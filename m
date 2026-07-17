Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C79EC4451B
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MEBrAHUFnk2FiioO0VpLsJTiSrnUVA33Eunb1QkbnAs=; b=r1sbJFVqBF4qrkFiHeFrmsQzFg
	tNO4FW3JjdyaCdt3NZusIi1lbBpYiBgZKCShlSlNBzdywQcYUDMWdIQ1UPJpKKuulkyn68TzosPF0
	d+jDys7IVY1xnxjco+dhyzcpqetaMrD20vyGv2IrL8lmV1hHE1sqGFgK2i1Lb0Xshha+bm+2FJKQs
	kA+RiZBSUvDsHZv40jYahbUkvekqnfWIzp0Lnv0RwsW36RdkLc75B8K9jiX02XjNupHXzqr3+Th1Y
	MUqCD69qjFiW0YD7N4huLRw+5y6CgWnteNaQdZierZivl0Jzl+UtlN0fUsECq7fI/8x36jkEN9npQ
	HiUTihwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wklJJ-00000002jBY-1t40;
	Fri, 17 Jul 2026 16:21:13 +0000
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wklJB-00000002jAl-1SN6
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 16:21:11 +0000
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-81e83f1f15aso22164307b3.1
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784305264; x=1784910064; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MEBrAHUFnk2FiioO0VpLsJTiSrnUVA33Eunb1QkbnAs=;
        b=bYesgQ4CrwyzNwFGjmEEXOG3zFTA+0I+PcT/3Osrdz+375Yyqy6zzBeCu23dkCNK6V
         qVv/H48R8h1owmvjdRwKae0DxmnWgCwfP1Wr4fF1N+cxcY/g1x04whHkU0WiqGp6iFtF
         FKp3GoRXK4JWTSpfwO8gzSvxs8o3asv5uy8JAnm83iHdiy24gKEiUuBqLRS92+iXafqR
         /0orCFZsz96Bz142Bv2gG13/625kLbd0KzVFBb6mx9rxj2QYxaQM8Q3k7yz3akIC2At5
         SSuG6wyazpMkH+B8uHwH2wO8GuG3V3+VcN1UJn4ZygiVs1+QS14zyCBl2Cx/bPH9Zt4c
         M20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784305264; x=1784910064;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MEBrAHUFnk2FiioO0VpLsJTiSrnUVA33Eunb1QkbnAs=;
        b=WEtZSQPa0OfP8gwYtMahC3TpbpqEpr6Ruch+U1SF26Ua2hW00ew2nqj0zWXXoqDfOV
         6ue3ERSq+ApFTHhTJobOMxcVvd4rpgQRC5RjXrFNhWMPiKCHpXRyHgf8webEuXH5FWwR
         aZvLUYag3vgFy1fJrN5ZeQ/IKD+MPx6C8Vw4Mjs1EGlqzkP8y3Cxh25N500RzFopPzXh
         1dBdi2xAWYW38o+YO8KNGfvr7BNqlmN8TbAkdCmwkf5jy/82sMknbxYpcrGuggE34T6M
         v03YtqVzekZvnqFJ4N/bjgclF7ZQJe19+PQvhCTCTcmCLT2ExitsPuarkPfryBf6WdG1
         Tp8A==
X-Forwarded-Encrypted: i=1; AHgh+RoHgteOhRCeiXldseHCzSZsFGCMA34quxTPDT3aNxYtNvH45VyFlCVT/ch2r1DgKg4i0GEL2g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxnF9OW4HY25e2yPG4okAE2S3VSkQ+BKOkwRnJwrJt5FAfC5ZZa
	9xKdJUwJeGvquTFdJ7fSBTQRg0ee73aTsEPuH8MDGT0MIUq14SY44IY/mQhQaX++Ky2M9QuMzW0
	CQmDh
X-Gm-Gg: AfdE7ckCFwmi9n+gUbcxqK8c8sM7rK3+a8z62+tM/38C7Pb5dUXg7Pf93NhyZclCHcW
	k1g4++Y6wcTK0kDxjshIYuZb5JuAIHAv3qcZcJID9ZgrXHwoyOlcQ4BHC8VF94Pl/40Hl+foGSM
	dFtnjtVv1aLK85M5ssisNXwK5VVmWexpRIacO0dtNKIm+CjMCvu5m6u29GBTSbFJX8goAoIkIYM
	6VqSUfa/GB4yXsKmE7w0lbhDFF8LqLYEuTq0V1s5Yhi7p6+cIkDWqkbqs+dk+JaeYlMBpG4RDM/
	XxcK08Z/8RCe7DXUIBROtLZLN/5ovtaDFxVVWxEW5kQ3kknlTfKTpadrmLq4qMigg0+LikxAnCt
	O2E5JDp9iQeXmRDK5eBBZ6OtuL9fQw4/VCSWDeRuC6mo8znM3Nh17lgzCqyJJHARjsrkvIwti3R
	GoRNMzEiYg5Sx/Fna8M5MtZ4tfsueMVlDoCO2064kXowzwPUWrC+Y+GodcDi17PVx1vRR8whNe5
	vnTsSj/kNR0
X-Received: by 2002:a05:690c:c4e7:b0:80c:88b8:2dd9 with SMTP id 00721157ae682-81ef15ea910mr12966957b3.35.1784305264127;
        Fri, 17 Jul 2026 09:21:04 -0700 (PDT)
Received: from google.com (138.200.150.34.bc.googleusercontent.com. [34.150.200.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42e89e8sm13834677b3.44.2026.07.17.09.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:21:03 -0700 (PDT)
Date: Fri, 17 Jul 2026 12:21:03 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Michal Clapinski <mclapinski@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Evangelos Petrongonas <epetron@amazon.de>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
Message-ID: <alpWWFo1gnxVnP7T@google.com>
References: <20260717134028.2880508-1-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717134028.2880508-1-mclapinski@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_092105_401595_3896F6D8 
X-CRM114-Status: GOOD (  29.98  )
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

On 07-17 15:40, Michal Clapinski wrote:
> While booting with KHO, the following crash was observed:
> 
> BUG: unable to handle page fault for address: ff19164fffff8328
> RIP: 0010:__free_one_page+0x1a1/0x6b0
> Call Trace:
>  <TASK>
>  [<ffffffff913208bf>] free_one_page+0xaf/0x240
>  [<ffffffff93973288>] deferred_free_pages+0xa8/0xd0
>  [<ffffffff93971b4f>] deferred_init_memmap_chunk+0x10f/0x1b0
>  [<ffffffff9396e265>] padata_mt_helper+0x65/0xa0
>  [<ffffffff90fac402>] process_scheduled_works+0x202/0x410
>  [<ffffffff90fae739>] worker_thread+0x1f9/0x2d0
>  [<ffffffff90fb62fd>] kthread+0x27d/0x2f0
>  [<ffffffff90fae540>] ? __pfx_worker_thread+0x10/0x10
>  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
>  [<ffffffff90efdc55>] ret_from_fork+0x145/0x280
>  [<ffffffff90fb6080>] ? __pfx_kthread+0x10/0x10
>  [<ffffffff90e2e46a>] ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> deferred_init_memmap_chunk() interleaves initialization of struct pages
> with freeing them. This works fine without KHO because free regions
> will never be neighbors. However, with KHO, free memory will be split
> into (free && scratch) and (free && !scratch), which can be neighbors.
> 
> KHO scratch is aligned to CMA_MIN_ALIGNMENT_PAGES pages but buddy looks
> at the neighborhood of MAX_ORDER_NR_PAGES pages. These values are
> configurable but CMA_MIN_ALIGNMENT_PAGES is always less or equal to
> MAX_ORDER_NR_PAGES. In the crashing configuration they were set as
> follows:
> CMA_MIN_ALIGNMENT_PAGES = 1 << 9
> MAX_ORDER_NR_PAGES = 1 << 10
> 
> So while freeing one chunk, buddy accessed uninitialized struct pages
> from another chunk, tried to merge the blocks and crashed.
> 
> To fix this, let's just align KHO scratch to MAX_ORDER_NR_PAGES pages.
> 
> Fixes: c6073743d0c7 ("kho: make preserved pages compatible with deferred struct page init")
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
> Unfortunately, this is very hard to catch, so I don't have a good
> reproducer. But I run the code with the fix through extensive testing
> and it seems fine.
> I think I've never caught it before because enabling HUGETLB is what
> causes CMA_MIN_ALIGNMENT_PAGES to be 1 << 9, instead of 1 << 10.
> 
> If this passes review, please cherry-pick it to 7.2 so we don't release
> a broken kernel.

A changelog would be super helful here.

Pasha

> ---
>  kernel/liveupdate/kexec_handover.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 4834a809985a..175c08a6e41e 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -38,6 +38,16 @@
>  #include "../kexec_internal.h"
>  #include "kexec_handover_internal.h"
>  
> +/*
> + * This is the minimal alignment required by deferred struct page init.
> + * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
> + * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> + * If KHO scratch is not aligned to that value, buddy can access uninitialized
> + * struct pages, which can cause a crash.
> + */
> +#define SCRATCH_ALIGNMENT_BYTES (PAGE_SIZE * MAX_ORDER_NR_PAGES)
> +static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
> +
>  /* The magic token for preserved pages */
>  #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
>  
> @@ -640,8 +650,8 @@ static void __init scratch_size_update(void)
>  	 * Scratch areas are released as MIGRATE_CMA. Round them up to the right
>  	 * size.
>  	 */
> -	scratch_size_lowmem = round_up(scratch_size_lowmem, CMA_MIN_ALIGNMENT_BYTES);
> -	scratch_size_global = round_up(scratch_size_global, CMA_MIN_ALIGNMENT_BYTES);
> +	scratch_size_lowmem = round_up(scratch_size_lowmem, SCRATCH_ALIGNMENT_BYTES);
> +	scratch_size_global = round_up(scratch_size_global, SCRATCH_ALIGNMENT_BYTES);
>  }
>  
>  static phys_addr_t __init scratch_size_node(int nid)
> @@ -656,7 +666,7 @@ static phys_addr_t __init scratch_size_node(int nid)
>  		size = scratch_size_pernode;
>  	}
>  
> -	return round_up(size, CMA_MIN_ALIGNMENT_BYTES);
> +	return round_up(size, SCRATCH_ALIGNMENT_BYTES);
>  }
>  
>  /**
> @@ -692,7 +702,7 @@ static void __init kho_reserve_scratch(void)
>  	 * next kernel
>  	 */
>  	size = scratch_size_lowmem;
> -	addr = memblock_phys_alloc_range(size, CMA_MIN_ALIGNMENT_BYTES, 0,
> +	addr = memblock_phys_alloc_range(size, SCRATCH_ALIGNMENT_BYTES, 0,
>  					 ARCH_LOW_ADDRESS_LIMIT);
>  	if (!addr) {
>  		pr_err("Failed to reserve lowmem scratch buffer\n");
> @@ -705,7 +715,7 @@ static void __init kho_reserve_scratch(void)
>  
>  	/* reserve large contiguous area for allocations without nid */
>  	size = scratch_size_global;
> -	addr = memblock_phys_alloc(size, CMA_MIN_ALIGNMENT_BYTES);
> +	addr = memblock_phys_alloc(size, SCRATCH_ALIGNMENT_BYTES);
>  	if (!addr) {
>  		pr_err("Failed to reserve global scratch buffer\n");
>  		goto err_free_scratch_areas;
> @@ -721,7 +731,7 @@ static void __init kho_reserve_scratch(void)
>  	 */
>  	for_each_node_state(nid, N_MEMORY) {
>  		size = scratch_size_node(nid);
> -		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
> +		addr = memblock_alloc_range_nid(size, SCRATCH_ALIGNMENT_BYTES,
>  						0, MEMBLOCK_ALLOC_ACCESSIBLE,
>  						nid, true);
>  		if (!addr) {
> -- 
> 2.55.0.229.g6434b31f56-goog
> 


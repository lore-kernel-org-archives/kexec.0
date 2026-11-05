Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194DF606A334
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rBz6MU/y;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=guQbtF2j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=b3t/AZZXgpUUBPoN/8EcWLM6aSitZao8sMvkUu7sQcw=; b=rBz6MU/y//gyWMsXF5/5pBTsGs
	tgNPMpT/Lm/B0b1IxXaWAI0p/ZajH/eIj46X7ETr0re2gIiVVgvkL3IXYQJAYomuTLhBt78oLdZtb
	R9MDOBtWrG5gPKjauGei5vFz3AmuKFw7FYaYAlvoMHlUsxZ9mupDkamWFdjBJDPr5wxwBVHS/eLOT
	DsehCXrj3Q8LXAM7Bb2l/aCsOEmcV2N8aQPxX34EhHXLXss56lVyjmzSLoI31h1k33ShVeVtdbBC2
	DZyhJ+ThEucvsMTxMLrg04eAPNG49SqQ0W9jm9cGlmWFQH8KKgayN6giVIqqcchjwpfz8uRsvwEaf
	sRIIay+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOsO9-000000085Kk-2dFS;
	Thu, 05 Nov 2026 08:00:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOsO6-000000085Jl-37PP
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 07:59:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6BB6C43B86;
	Thu,  5 Nov 2026 07:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425191F0093A;
	Thu,  5 Nov 2026 07:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793865598;
	bh=b3t/AZZXgpUUBPoN/8EcWLM6aSitZao8sMvkUu7sQcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=guQbtF2jldVKgx4ac787ghXRGdDM4Ye6jRjYUwcllIkG+O5epTzarqTG/si+Dq7cd
	 8SAQXX3JwughkvqUx9Ef6WOTuPu9qLF3Qyqyf+MPL0zMS+bKGmlqJ8zmyzBmZqD3vF
	 dEt4/oPS7+PqkIpO9cQ2jJSEsfB3Kp4ifdiqTxmcNuNuT1pIexCUI/Ft441pXEgt4s
	 ltwwL3cFcpsnoAa45emlUhoxiDyKEHWddO+SR1XkpvsE8z9U9ysIjcLz9ege4L4IUV
	 ZGHcgwYNvLUFYWrREJXvQ3Ph63X2uBayjKz3okeaKiP2/QLBfaDLvop+6MMV6CpbQr
	 hdR+Mx+Mq+T3w==
Date: Thu, 5 Nov 2026 09:59:50 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2] memblock: don't allocate new reserve_mem regions on a
 KHO boot
Message-ID: <auw3dtAMp4CjNwY2@kernel.org>
References: <20261104204235.9066-1-azpijr@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104204235.9066-1-azpijr@gmail.com>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, Kees Cook <kees@kernel.org>, Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 09:42:17PM +0100, Jose A. Perez de Azpillaga wrote:
> On a KHO boot, a reserve_mem region that can't be revived is allocated
> from KHO_NOPRSRV memory, which includes the bootmem the next kernel
> boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG, preserving the region
> then fails:
> 
>   WARNING: kernel/liveupdate/kexec_handover.c:1245 at kho_preserve_pages+0x168/0x180
>   failed to prepare memblock FDT for KHO: -22
> 
> Without it, the next kernel puts its memmap on top of the region and
> the ramoops records in it are lost.
> 
> There is no use case for adding regions across a live update, so fail
> instead of allocating, and drop the TODO.
> 
> Fixes: f99230780211 ("memblock: add KHO support for reserve_mem")
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> ---
> Changes in v2:
> - fail on a KHO boot instead of allocating outside bootmem, as agreed
>   with Pratyush [1]. this drops v1's patch 1.
> - not an RFC anymore.
> - based on v7.4-rc1.
> 
> v1: https://lore.kernel.org/all/20261021211058.83483-3-azpijr@gmail.com/
> 
> [1] https://lore.kernel.org/all/2vxzfqxglrg6.fsf@kernel.org/
> 
>  mm/memblock.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index a450092a80fb..e325e0542c9a 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2827,7 +2827,16 @@ static int __init reserve_mem(char *p)
>  	if (reserve_mem_kho_revive(name, size, align))
>  		return 1;
>  
> -	/* TODO: Allocation must be outside of KHO_NOPRSRV region */
> +	/*
> +	 * On a KHO boot memblock only allocates from KHO_NOPRSRV memory here,
> +	 * which includes the bootmem the next kernel boots out of. Only regions
> +	 * handed over by the previous kernel are supported.
> +	 */
> +	if (is_kho_boot()) {

This breaks memblock tests, please add a stub there.

> +		pr_err("reserve_mem: can't allocate \"%s\" on a KHO boot\n", name);
> +		return -EOPNOTSUPP;
> +	}
> +
>  	start = memblock_phys_alloc(size, align);
>  	if (!start) {
>  		pr_err("reserve_mem: memblock allocation failed\n");
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.56.0
> 

-- 
Sincerely yours,
Mike.


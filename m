Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FAA606A339
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UDIohkZf;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RkD0ZTkK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cVDZpxqqtGXanXSa85zXaSGNSgk4+pujulEU5rVUYrI=; b=UDIohkZfhRXfxWNEO8jh3OswFJ
	xPKQkZCQWZdBixGKPjw+bTtbt8xAr2FCrZl9vVs4dG1oOR7P0n+aSvoGf1vAmjIAcU+9IGigqs+P4
	JtuZSlPuIiYYDIQ3yV/O/ln7utmZs9TWMdhIvJpeuym4s8P169ARn3ziW2nsX2j8LY55R9Y+FgtQf
	o0GWzqYfDgRuVggk3YN9vLCzjTceaYEtE6hmby7biKGbASdb9+FexpmB7PL9SzTcziNh0fw7F92Uu
	bMICafasRlUeU2YVcolBaNiqeAR5ShFbxwEjmO0vNIkSFnIdG/8MmFRUofiFigT7RiRBW0QwdKFcT
	493bq2Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQMJl-00000000N6l-2fow;
	Mon, 09 Nov 2026 10:09:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQMJl-00000000N6c-13jB
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 10:09:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 898836306D;
	Mon,  9 Nov 2026 10:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AA01F0089F;
	Mon,  9 Nov 2026 10:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794218976;
	bh=cVDZpxqqtGXanXSa85zXaSGNSgk4+pujulEU5rVUYrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RkD0ZTkK4UPON4c35h81yShsugX7KG37JtcxD2aUF6JUC30zWJqFhbDGyKqUah9ae
	 fP2maAVrCgbTCNnhOWJVTJhjX79zLJ/0RE7a7icltlw54oqi2yDeZ2WhBVR4ulKCT2
	 swE1tBlCR8QmzwQs3Tm3msHIU6pou/hNuz26EdKD3d+L0lrIbcRdJcLxUFT0dGV7A2
	 T4+0CI8h+D2boYeyH/j/gl6VVoSMgqf/fas9k5ObVWEF/08LvOecImOd6GEnB+Vvv9
	 TKnxk59d9A/Keuth0/lDlaE1ixFwS/OTMmkPcerP53RJx8DGnJL0EkgK2mC53fElRk
	 2xZZqsrVZFqkw==
Date: Mon, 9 Nov 2026 12:09:29 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] kho: Don't release incoming bootmem areas when
 kho_init() fails
Message-ID: <avGb2Trm-C3_YC-7@kernel.org>
References: <au_vQhHAcJbkryXN@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au_vQhHAcJbkryXN@chrisdown.name>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Sat, Nov 07, 2026 at 07:40:50PM -0800, Chris Down wrote:
> kho_populate() adds the incoming bootmem areas without reserving
> them. memblock_free_all() then hands the remainder to the buddy
> allocator.

This paragraph is confusing.
It reads like kho_populate() should have reserved bootmem areas, but it
didn't.
 
> Unfortunately however, if kho_init() fails, err_free_bootmem
> currently frees every area with free_reserved_area(). This can free
> pages still backing early allocations or free buddy pages a second
> time.

Is this an issue you hit in practice or it was reported by a code analysis?

> To fix this, let's only free the areas on a cold boot when
> kho_reserve_bootmem() reserved them.
> 
> Fixes: c609c144b0e8 ("kexec: add KHO parsing support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  kernel/liveupdate/kexec_handover.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 6f1f55fe3181..a566ad6634d8 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1899,11 +1899,13 @@ static __init int kho_init(void)
>  	kho_radix_destroy_tree(tree);
>  err_free_bootmem:
>  	kho_out.fdt = NULL;
> -	for (int i = 0; i < kho_bootmem_cnt; i++) {
> -		void *start = __va(kho_bootmem[i].addr);
> -		void *end = start + kho_bootmem[i].size;
> +	if (!fdt) {

I think using !is_kho_boot() makes this clearer.

> +		for (int i = 0; i < kho_bootmem_cnt; i++) {
> +			void *start = __va(kho_bootmem[i].addr);
> +			void *end = start + kho_bootmem[i].size;
>  
> -		free_reserved_area(start, end, -1, "");
> +			free_reserved_area(start, end, -1, "");
> +		}
>  	}
>  	kho_enable = false;
>  	return err;
> 
> base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
> -- 
> 2.54.0
> 

-- 
Sincerely yours,
Mike.


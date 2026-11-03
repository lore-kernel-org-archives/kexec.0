Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B7606A32F
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DQJMUKxW;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=J3qSNzf+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mmIYdzsXtSLJ4H9TN4ODtrKjdEj6BTA0VO5FF1tJVsk=; b=DQJMUKxW9/JT+JN73tO2fkjBFM
	cA+KgW9ZYQVUzQw6oyqnzm3Z1rzntV069++dIe/G5G+4LIENB4cUhhyCXqbpe2DM7UzO1UN5g3AcY
	3ztr+tBNrz29IJwfIX4TTyWfct+Lf4d03C6yXFh9BJ9aKeAXIzfSUS665tRrQK9NTQuQItE+s5ElQ
	GIH47w07oRoYKxbn48jlc6W6wZr8a1Aq9UJ+LLI5DFhlMijOQqHgX/wMF4zXWlYDi8HPL2vCmleLH
	drkqC4qO7HQsOEQCuQi4+oE7yT0wXA4orlSQGYIjwIcPuQeMYZb3P1CIiZYhZm0yEknbbdniu0Uic
	habMgs3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKUs-00000003Z2S-1nkW;
	Tue, 03 Nov 2026 19:48:42 +0000
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKUo-00000003Z0y-39AJ
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 19:48:41 +0000
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso3122364137.2
        for <kexec@lists.infradead.org>; Tue, 03 Nov 2026 11:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793735317; x=1794340117; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mmIYdzsXtSLJ4H9TN4ODtrKjdEj6BTA0VO5FF1tJVsk=;
        b=J3qSNzf+yp1A/V+6UrA1l/MtOWSzhhhU/UvRke7o7e23h918gQ8JE+eeP+ngP6PnFU
         9SQ5cTfvHwoc2/3Uo+6JCL/6nXizq4yrMaChiDnEnmv8PQMnmpHJ9ZJaT8zQ0A/VQPDS
         LNeKsUgUgSguTLE4AdFVI7XLtYI/oqVjgpXKE7lGhGqGEksP9fubNJzUAnMGjc4YUCq3
         aGDI5xvgTaT39x6yg9XdATuRUyxJxjf0LrxMOO1so4qojnCSlgfEguPcn2ST4GLRHAT8
         Q63yfcev/VPIckWl5aBOiRcKIXFB7mYxcPHHcTRu3D0A9qnR2g6eHAm2hRlDZLofegiC
         AlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735317; x=1794340117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mmIYdzsXtSLJ4H9TN4ODtrKjdEj6BTA0VO5FF1tJVsk=;
        b=LNst46BoheRVwMx/x6iSpkQZ2ycL5iL+wA8yFcILErIzb73o7sCmpX6jsaLVOhBqLh
         YDECU3wPNgM2BmfCh5iBiP4UDZweQ31k36cXmBtrl++dyQrBPs9+U210nM2rZL3mEVq4
         D9djwMqssJx1Us9lvcS426boOn+882RWz1Nvc7DEbNzvHppCaTaeKfxTu0AgqLWJifDN
         aTP0zjz2LSeK4apvHytrEe+Ve2kH0MaOtyVVYHjRtpKqRMUswsh3bFsQ0CBRXRW2GspP
         vBjmYkilwnwv2VmuA8mpxUL2+TIrbEY/TX/IqCHoQbw3DuhDnL8ajraKOH9Tz+HruE/I
         XW8g==
X-Forwarded-Encrypted: i=1; AKwUvBwujza/+OVfMHvKjxkRFY2vaNklVxpCvcUcBuFnNfykUTy6OlwuolWIY9ULVFud6ydQa39O6g==@lists.infradead.org
X-Gm-Message-State: APuU4Z/KoZs7zSbhlz2rSpD5LvGv1c7bn2FcjotRcQBML40paB+sMaB6
	uYklO9xMlUa2ta+aqvFLbx5ja+9CqARSDIGWeejoIYRcG/3cUc8ghUkXtGcd1JsI0hs=
X-Gm-Gg: AYBFou0TWzVO1YaIhscnx8XuL75PQ+LhJ63lwU3ozUnMp6G3HX2HwQXzmV5N0wfJPI+
	i9y50uUiBjMjyR1ViykvAjcFtmBhWWiCwfoePChxEXQ5fZIDfzGbt/nQEjN4P5AOhzjWdg+Ruus
	QW6LBLhLVOR/zY2StuitDROF9GHWVZatF76WcSW25XqSmmhmtND0M0Hf8X8cSjAYE4JBkz3Bwbf
	FwkxcSba9C54Ad99gfsL17noyhCLqp+ukFjoegDaptLyYxwcntP/y3BcKhkuUNKZr/9T6nGGhPJ
	XGfMRYlKNInsa3S58tJ03KVKqJwwfb4NBvJXv1zw+HI6ckWlCiX0WCuspyoiQ/lysa/HVQXhqTo
	Rh+0wzaoCoF6pKAX1XsuysX8cYZmSYSb5F+MPVj82FXQWFEuu13EgHM036TXONGCi8+/Z2zgUS/
	4tkeQ7wOmcsvSu9eWKRNPqusn9a+lupfcx0S+YSj9tlIEs2J7j40eLyfiu/gksSUs5rYalXC7mb
	w3V9MOCqanwEEDHCjbGQI/40jVGYJRdkWcg0elZdZCbz5ucZRHJNGP7jtX/wAsJOiL/YXpz0Nno
	FDLddSoIfnJtWcwT8sRB0nEQmjRp/XwU5dtHsiljcODsI3t4VHUKIji01rSOgw349MCvGnTMaet
	Fhen3EQtz/r8kVOcfBn6NPIDDt1uCeVc=
X-Received: by 2002:a05:6102:549f:b0:7c3:ac79:9b09 with SMTP id ada2fe7eead31-7d072735c70mr6239243137.30.1793735317321;
        Tue, 03 Nov 2026 11:48:37 -0800 (PST)
Received: from google.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d9c906fcsm51783241.11.2026.11.03.11.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:48:36 -0800 (PST)
Date: Tue, 3 Nov 2026 14:48:36 -0500
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Pei <cp0613@linux.alibaba.com>, 
	George Guo <guodongtai@kylinos.cn>, Kexin Liu <liukexin@kylinos.cn>, 
	Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] kho: skip zero-sized lowmem and global bootmem areas
Message-ID: <auo3PzmisfK3br1l@google.com>
References: <20261103-kho-bootmem-sizing-v1-0-45aa74098f34@kernel.org>
 <20261103-kho-bootmem-sizing-v1-1-45aa74098f34@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-kho-bootmem-sizing-v1-1-45aa74098f34@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_114838_796266_090A2D30 
X-CRM114-Status: GOOD (  24.16  )
X-Spam-Score: -2.1 (--)
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11-03 13:49, Mike Rapoport (Microsoft) wrote:
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

You are adding a helper that returns an error code and then ignoring it 
at all call sites. Even though it can only return -ENOMEM right now, 
dropping the return value is not good practice.

Either capture and print the error in pr_err(), or even better have 
kho_reserve_bootmem_area() return bool and move the pr_err() 
inside it, using nid != NUMA_NO_NODE for per-node areas and a name 
argument for "lowmem"/"global".


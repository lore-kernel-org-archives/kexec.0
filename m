Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F624C87FD2
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 06:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tae7EzQepmnEcvutuU/I6yJ760KCBMyvekUMC5MLrBA=; b=hChCPQ2MO+NBKh3vJ2M5zwycyD
	Gf5sVjvNJoGcsb3eGrytKDmNFNeMcVbq8rmvWTQZJlB63eH28654EI+KidcEgsWDkx/jIzfH+ySrc
	kfDS6mG1W1S9jeq6DcyFVaXYXks89U2xWw8alJjUY1jre9SNAFweDnT1VBImhwlKNTki3SvPlOG9t
	t3RRAf38DlQ7bz9k4M2Xf7NJqJdeBnTV0wivEybaGSCp09AZLd01QB1kxPkvJI6+xJ6fhP/ojhEgx
	xlOSnztJeApbU9cJaZEG+EY80RrSWU091539weznMt5FPJmC8EsRQ6IUf5Ry8i4F6hDpyV/1mM0ly
	CWRHlnLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulMFx-00000006chU-47sM;
	Mon, 11 Aug 2025 06:43:41 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulMCM-00000006cOY-1iWS
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 06:39:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 70CE15C3798;
	Mon, 11 Aug 2025 06:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B643C4CEED;
	Mon, 11 Aug 2025 06:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754894397;
	bh=TuyYgNyOFUQ5s68HmKErQ2s++npfUFsEhM9wvY0n9Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cyf4/hMmSdOnLKJigF5NZtnZSF/Fw0RAsAGtpjWE72dB6BfPMTv+ywv4DDXv0mqpS
	 cKtUcoDboJ3Nh+c2ZobIJP56Aq2+YjuFmmUPHYzKkNBVu/S3EbdyJImdW3H4i3sFrB
	 jWI+FVy+YGxg+tKO4BZJlw6Otuw36YqvtHBkcjxOl2ZlzSWOtJD90/jPGrrFuGvXCm
	 pQyUJP/50lT3ci5oo6alyUDquv/GOGb5t3MY8lmXAejInj5nvcz/eqhZu+tLXtuQcN
	 qGuBusXcNp+7egjj9lWZoO7zGSwI4d0gbU/LTjc73kaRighiXpTlGvF0SeIZZtYDbN
	 G2cFf/pt/pURA==
Date: Mon, 11 Aug 2025 09:39:50 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: ardb@kernel.org, Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	nh-open-source@amazon.com, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: Support booting with kexec handover (KHO)
Message-ID: <aJmQNuQxLLtXjq2r@kernel.org>
References: <20250808163651.25279-1-epetron@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808163651.25279-1-epetron@amazon.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_233958_534270_EE92E7FF 
X-CRM114-Status: GOOD (  27.03  )
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

On Fri, Aug 08, 2025 at 04:36:51PM +0000, Evangelos Petrongonas wrote:
> When KHO (Kexec HandOver) is enabled, it sets up scratch memory regions
> early during device tree scanning. After kexec, the new kernel
> exclusively uses this region for memory allocations during boot up to
> the initialization of the page allocator
> 
> However, when booting with EFI, EFI's reserve_regions() uses
> memblock_remove(0, PHYS_ADDR_MAX) to clear all memory regions before
> rebuilding them from EFI data. This destroys KHO scratch regions and
> their flags, thus causing a kernel panic, as there are no scratch
> memory regions.
> 
> Instead of wholesale removal, iterate through memory regions and only
> remove non-KHO ones. This preserves KHO scratch regions while still
> allowing EFI to rebuild its memory map.

It's worth mentioning that scratch areas are "good known memory" :)
 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
> 
> Reproduction/Verification Steps
> The issue and the fix can be reproduced/verified by booting a VM with
> EFI and attempting to perform a KHO enabled kexec. The fix
> was developed/tested on arm64.
> 
>  drivers/firmware/efi/efi-init.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index a00e07b853f22..2f08b1ab764f6 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -164,12 +164,35 @@ static __init void reserve_regions(void)
>  		pr_info("Processing EFI memory map:\n");
>  
>  	/*
> -	 * Discard memblocks discovered so far: if there are any at this
> -	 * point, they originate from memory nodes in the DT, and UEFI
> -	 * uses its own memory map instead.
> +	 * Discard memblocks discovered so far except for KHO scratch regions.
> +	 * Most memblocks at this point originate from memory nodes in the DT,
> +	 * and UEFI uses its own memory map instead. However, if KHO is enabled,
> +	 * scratch regions must be preserved.
>  	 */
>  	memblock_dump_all();
> -	memblock_remove(0, PHYS_ADDR_MAX);
> +
> +	if (IS_ENABLED(CONFIG_MEMBLOCK_KHO_SCRATCH)) {

It's better to condition this on kho_get_fdt() that means that we are
actually doing a handover.

> +		struct memblock_region *reg;
> +		phys_addr_t start, size;
> +		int i;
> +
> +		/* Remove all non-KHO regions */
> +		for (i = memblock.memory.cnt - 1; i >= 0; i--) {

Please use for_each_mem_region() 

> +			reg = &memblock.memory.regions[i];
> +			if (!memblock_is_kho_scratch(reg)) {
> +				start = reg->base;
> +				size = reg->size;
> +				memblock_remove(start, size);
> +			}
> +		}
> +	} else {
> +	/*
> +	 * KHO is disabled. Discard memblocks discovered so far: if there
> +	 * are any at this point, they originate from memory nodes in the
> +	 * DT, and UEFI uses its own memory map instead.
> +	 */
> +		memblock_remove(0, PHYS_ADDR_MAX);
> +	}
>  
>  	for_each_efi_memory_desc(md) {
>  		paddr = md->phys_addr;
> -- 
> 2.43.0

-- 
Sincerely yours,
Mike.


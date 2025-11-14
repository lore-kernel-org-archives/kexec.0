Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCF2CE8D57
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MarKiFtWWXiCJfop2Mp04w6dux4RRrqD8MZucum8wGM=; b=kEFPeVLTNEUSCdb3MPl/fw/rEV
	5xpud62tqABxhDL+zXhrXMWFxAdmOBt1kfvjwpvdd+rjM8Vc4qE/yFIDrsUSDaZ54P1ivCWqgfVGm
	SWY/7Ou1xhneHgRDjomSaZYSdj3xSYHhoiC1KOVGLeLFmYfjMyyfsOiXu32HFAv0BrYnrVhGm6uRp
	Jhhuv288N6y37+S4lE/Uq8zdyJp2pwReX+VbGXxvkHfL3JWicFtjDXElN/Hd2x8ipk2f6tI72dllv
	Fuf10C/oH4NgbuQ3lxaSNEam8iAh3vhDnFNWwOQCBC5h9zhkkIbnizRMuiXtDGQ+HDDqW/gYkCOBP
	ppCbdl5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJx2R-0000000Cljc-2mE3;
	Fri, 14 Nov 2025 16:52:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJx2P-0000000CljJ-3VpA
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 16:52:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D5A1360198;
	Fri, 14 Nov 2025 16:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32DBC116B1;
	Fri, 14 Nov 2025 16:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763139160;
	bh=ukDtEMQ3h+HhdTJApwHm9gtvXizGx7c4PKt+RTNGPfM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dYUKLJgJtebr3v2RLEJLGjWo41D48EJ74YaRNQVVcm9EIEADqqQMMJSdMPnkQyRAY
	 XkyMOmFO3ICqJO7e5Nva3u3qleGxnEKKidN2/N8S3rc1/Nh30kccNHXjEAVPZsadOg
	 dOiaDloor0qs0YW7KtSIGIMWfqCor3kC3qbk4otQ0YiPgFGwSZCynzXIoJUG4QHN/E
	 IH4UrA/zU3x42MbWyJqcj2PmtkLUek9tZM/TDt1nf1GFO6ZuOKoUV7X2U3r7+ihKBA
	 rPf51GRurGrGeTA6XskxG28Z/YZzJAQOnxxY5Dqu65vEFiDcfcKcHdWBmZsUeVhRK3
	 GxVPiDNBhTPRg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 04/13] kho: Verify deserialization status and fix FDT
 alignment access
In-Reply-To: <20251114155358.2884014-5-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 10:53:49 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-5-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 17:52:37 +0100
Message-ID: <mafs0tsyw7e0a.fsf@kernel.org>
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

On Fri, Nov 14 2025, Pasha Tatashin wrote:

> During boot, kho_restore_folio() relies on the memory map having been
> successfully deserialized. If deserialization fails or no map is present,
> attempting to restore the FDT folio is unsafe.
>
> Update kho_mem_deserialize() to return a boolean indicating success. Use
> this return value in kho_memory_init() to disable KHO if deserialization
> fails. Also, the incoming FDT folio is never used, there is no reason to
> restore it.
>
> Additionally, use memcpy() to retrieve the memory map pointer from the FDT.
> FDT properties are not guaranteed to be naturally aligned, and accessing
> a 64-bit value via a pointer that is only 32-bit aligned can cause faults.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 32 ++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index a4b33ca79246..83aca3b4af15 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -450,20 +450,28 @@ static void __init deserialize_bitmap(unsigned int order,
>  	}
>  }
>  
> -static void __init kho_mem_deserialize(const void *fdt)
> +/* Return true if memory was deserizlied */
> +static bool __init kho_mem_deserialize(const void *fdt)
>  {
>  	struct khoser_mem_chunk *chunk;
> -	const phys_addr_t *mem;
> +	const void *mem_ptr;
> +	u64 mem;
>  	int len;
>  
> -	mem = fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
> -
> -	if (!mem || len != sizeof(*mem)) {
> +	mem_ptr = fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
> +	if (!mem_ptr || len != sizeof(u64)) {
>  		pr_err("failed to get preserved memory bitmaps\n");
> -		return;
> +		return false;
>  	}
> +	/* FDT guarantees 32-bit alignment, have to use memcpy */
> +	memcpy(&mem, mem_ptr, len);

Perhaps get_unaligned(mem) would have been simpler?

> +
> +	chunk = mem ? phys_to_virt(mem) : NULL;
> +
> +	/* No preserved physical pages were passed, no deserialization */
> +	if (!chunk)
> +		return false;

Should we disallow all kho_restore_{folio,pages}() calls too if this
fails? Ideally those should never happen since kho_retrieve_subtree()
will fail, so maybe as a debug aid?

>  
> -	chunk = *mem ? phys_to_virt(*mem) : NULL;
>  	while (chunk) {
>  		unsigned int i;
>  
> @@ -472,6 +480,8 @@ static void __init kho_mem_deserialize(const void *fdt)
>  					   &chunk->bitmaps[i]);
>  		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
>  	}
> +
> +	return true;
>  }
>  
>  /*
> @@ -1377,16 +1387,12 @@ static void __init kho_release_scratch(void)
>  
>  void __init kho_memory_init(void)
>  {
> -	struct folio *folio;
> -
>  	if (kho_in.scratch_phys) {
>  		kho_scratch = phys_to_virt(kho_in.scratch_phys);
>  		kho_release_scratch();
>  
> -		kho_mem_deserialize(kho_get_fdt());
> -		folio = kho_restore_folio(kho_in.fdt_phys);
> -		if (!folio)
> -			pr_warn("failed to restore folio for KHO fdt\n");
> +		if (!kho_mem_deserialize(kho_get_fdt()))
> +			kho_in.fdt_phys = 0;

The folio restore does serve a purpose: it accounts for that folio in
the system's total memory. See the call to adjust_managed_page_count()
in kho_restore_page(). In practice, I don't think it makes much of a
difference, but I don't see why not.

>  	} else {
>  		kho_reserve_scratch();
>  	}

-- 
Regards,
Pratyush Yadav


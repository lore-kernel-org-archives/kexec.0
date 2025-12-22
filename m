Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7032E677EA
	for <kexec@archiver.kernel.org>; Mon, 22 Dec 2025 16:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XBrGNJbf+1/790dJpv4JTnMT0Es8hx4Z71VPlAy9J1E=; b=dbP+R/Ux8yZtc0zNb4CaZFbJpm
	BbLuoQGfsbk0KY6Tp4MkiGdZ3Z7gkbz58lzijMZZRIOxAieV+FLd+hHPoHAN+3kRBKxp4XDNH8bNq
	nmBGHv40vTC5NkYx02K7bPO9QnlKTXeOMVKfrt8RBqqMHS1w2/6uK5BlobgCCMOvQSVftNwUnuuGA
	86dxrsc3vK3aTzI76jkf1EGu40Stfaw5/G424jtKQVH7tbI4eZDhP8TjqJ75UPEZ9ZCMOi5gvycLA
	g/E0daXci4gZvKL89YsFjvcUM0H1xA6o7pqYvLaktoZYpLWmbik4Bfv4ZIkgw4cuuCp495UGnvuJR
	weQ/kMSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXiO9-0000000Dx0u-0rZp;
	Mon, 22 Dec 2025 16:04:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXiO7-0000000Dx0Z-1X8w
	for kexec@lists.infradead.org;
	Mon, 22 Dec 2025 16:03:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C2EDF60151;
	Mon, 22 Dec 2025 16:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7493C116C6;
	Mon, 22 Dec 2025 16:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766419436;
	bh=9E0AkRoTHDM9XLALHPyae80PIArrlbd3vLJQBT5gFuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y3C8rcsNp2jiaxiFMf+tsdv9F57FjwOITbbmK158PhvN1oXkQ4SPKTEsGB5oeEQaq
	 O83uSR2R0gCP4h/fJB6q8c5ALwTYDTkg7lVxm42oPObUzWBFHgI64BtIiCyz2+TTaN
	 zzZhrorTQ5r6hD4BHAibtHbxWizGut2JaQ7D5XRrBu7hksIZVR4q/K5gctDRTVhZ+Y
	 g8wszBRB+rpCvLqhOwtbWELsfW+mD7xp1UZ6Fra3y6UgKQLP6KZuhRNGSX02Yc1RTm
	 r7KTKcxWr+qVVt16yBQwLKoKPbS/ngA7k+VxiMwJJl8Rd/YLpIqC07USONMFm/Lccl
	 LsAFXc76bMdLA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  rppt@kernel.org,  graf@amazon.com,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  pratyush@kernel.org,
  ricardo.neri-calderon@linux.intel.com
Subject: Re: [PATCH v3] kho: validate preserved memory map during population
In-Reply-To: <20251219071209.3696755-1-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 19 Dec 2025 02:12:09 -0500")
References: <20251219071209.3696755-1-pasha.tatashin@soleen.com>
Date: Mon, 22 Dec 2025 17:03:50 +0100
Message-ID: <867buecxll.fsf@kernel.org>
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

On Fri, Dec 19 2025, Pasha Tatashin wrote:

> If the previous kernel enabled KHO but did not call kho_finalize()
> (e.g., CONFIG_LIVEUPDATE=n or userspace skipped the finalization step),
> the 'preserved-memory-map' property in the FDT remains empty/zero.
>
> Previously, kho_populate() would succeed regardless of the memory map's
> state, reserving the incoming scratch regions in memblock. However,
> kho_memory_init() would later fail to deserialize the empty map. By that
> time, the scratch regions were already registered, leading to partial
> initialization and subsequent list corruption (double-free) during
> kho_init().

Nit: I am guessing the double-free is the scratch regions being freed
twice? Can you please write that out explicitly?

>
> Move the validation of the preserved memory map earlier into
> kho_populate(). If the memory map is empty/NULL:
> 1. Abort kho_populate() immediately with -ENOENT.
> 2. Do not register or reserve the incoming scratch memory, allowing the new
>    kernel to reclaim those pages as standard free memory.
> 3. Leave the global 'kho_in' state uninitialized.
>
> Consequently, kho_memory_init() sees no active KHO context
> (kho_in.mem_chunks_phys is 0) and falls back to kho_reserve_scratch(),
> allocating fresh scratch memory as if it were a standard cold boot.
>
> Fixes: de51999e687c ("kho: allow memory preservation state updates after finalization")
> Reported-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Closes: https://lore.kernel.org/all/20251218215613.GA17304@ranerica-svr.sc.intel.com
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> Changes v3:
> - Addressed review comments, and added review-by from Mike
>
>  kernel/liveupdate/kexec_handover.c | 39 ++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 9dc51fab604f..2d9ce33c63dc 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -460,27 +460,23 @@ static void __init deserialize_bitmap(unsigned int order,
>  	}
>  }
>  
> -/* Return true if memory was deserizlied */
> -static bool __init kho_mem_deserialize(const void *fdt)
> +/* Returns physical address of the preserved memory map from FDT */
> +static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
>  {
> -	struct khoser_mem_chunk *chunk;
>  	const void *mem_ptr;
> -	u64 mem;
>  	int len;
>  
>  	mem_ptr = fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
>  	if (!mem_ptr || len != sizeof(u64)) {
>  		pr_err("failed to get preserved memory bitmaps\n");
> -		return false;
> +		return 0;
>  	}
>  
> -	mem = get_unaligned((const u64 *)mem_ptr);
> -	chunk = mem ? phys_to_virt(mem) : NULL;
> -
> -	/* No preserved physical pages were passed, no deserialization */
> -	if (!chunk)
> -		return false;
> +	return get_unaligned((const u64 *)mem_ptr);
> +}
>  
> +static void __init kho_mem_deserialize(struct khoser_mem_chunk *chunk)
> +{
>  	while (chunk) {
>  		unsigned int i;
>  
> @@ -489,8 +485,6 @@ static bool __init kho_mem_deserialize(const void *fdt)
>  					   &chunk->bitmaps[i]);
>  		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
>  	}
> -
> -	return true;
>  }
>  
>  /*
> @@ -1253,6 +1247,7 @@ bool kho_finalized(void)
>  struct kho_in {
>  	phys_addr_t fdt_phys;
>  	phys_addr_t scratch_phys;
> +	phys_addr_t mem_map_phys;
>  	struct kho_debugfs dbg;
>  };
>  
> @@ -1434,12 +1429,10 @@ static void __init kho_release_scratch(void)
>  
>  void __init kho_memory_init(void)
>  {
> -	if (kho_in.scratch_phys) {
> +	if (kho_in.mem_map_phys) {
>  		kho_scratch = phys_to_virt(kho_in.scratch_phys);
>  		kho_release_scratch();
> -
> -		if (!kho_mem_deserialize(kho_get_fdt()))
> -			kho_in.fdt_phys = 0;
> +		kho_mem_deserialize(phys_to_virt(kho_in.mem_map_phys));
>  	} else {
>  		kho_reserve_scratch();
>  	}
> @@ -1448,8 +1441,9 @@ void __init kho_memory_init(void)
>  void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  			 phys_addr_t scratch_phys, u64 scratch_len)
>  {
> -	void *fdt = NULL;
>  	struct kho_scratch *scratch = NULL;
> +	phys_addr_t mem_map_phys;
> +	void *fdt = NULL;
>  	int err = 0;
>  	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
>  
> @@ -1475,6 +1469,14 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  		goto out;
>  	}
>  
> +	mem_map_phys = kho_get_mem_map_phys(fdt);
> +	if (!mem_map_phys) {
> +		pr_warn("setup: handover FDT (0x%llx) present but no preserved memory found\n",
> +			fdt_phys);

Enabling KHO but not using it is a perfectly normal use case. This
should not be a warning. I don't think we should print anything here
TBH.

> +		err = -ENOENT;
> +		goto out;
> +	}
> +
>  	scratch = early_memremap(scratch_phys, scratch_len);
>  	if (!scratch) {
>  		pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
> @@ -1515,6 +1517,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  
>  	kho_in.fdt_phys = fdt_phys;
>  	kho_in.scratch_phys = scratch_phys;
> +	kho_in.mem_map_phys = mem_map_phys;

Nit: not a fan of duplicating information. This is already contained in
the FDT. Perhaps make kho_memory_init() also call
kho_get_mem_map_phys()? And while at it, perhaps make it
kho_get_mem_map() and the return type struct khoser_mem_chunk * ?

No strong opinion, so fine either way, but I do think it is cleaner.

>  	kho_scratch_cnt = scratch_cnt;
>  	pr_info("found kexec handover data.\n");
>  
>
> base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66

-- 
Regards,
Pratyush Yadav


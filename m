Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90123CA5FF1
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 07:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bb3xkMpeNpnybd9Na8Isc5XENxO7ZKbU0IXQYY84igE=; b=TupaPZ0z2ri7D4qxPGVGHKSWh7
	3/0bbOJiFowp11qpiZto1HwybfQDWPy64nyfeLY+GOmWySVY2Rj8tNFCXf69S3GGvQPEK1vE+cdmW
	fSe/Hd4S7VepAR1LXadfDmcnq54Ysb/IOSeoljzJ6M1Qi5tqylKoYydNPvDX9Qk4pSFsn/fFl+YOp
	h9X8JbjUtalbwROkWwlco82pJ9955TrKy90OuLpsnJ6/DPSu5zMfsh0PJlLImxtemLhnwcd/mcRyt
	3+rOg1F3fGRg9CbfP8bmHCeOX5tf5E1gDq62WsN/rUi2jei2wkOVaXlNsW6JpDiJECzHq7Z92QPFY
	LLh1J1og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjKN-00000001Ri7-3EIk;
	Mon, 19 Jan 2026 07:05:31 +0000
Received: from out-173.mta1.migadu.com ([95.215.58.173])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjKH-00000001Rhc-0T5t
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 07:05:27 +0000
Message-ID: <4f7e180d-f7bb-4a21-ae2b-f42cc969401d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768806319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bb3xkMpeNpnybd9Na8Isc5XENxO7ZKbU0IXQYY84igE=;
	b=EvclKCuZlg7ifGbmHKL+RgT9befhs9UroGPdqC0TP0IrHcmdjq9+EpZElp1YHgXCPiJOqW
	7jzdt7ISwzQe3wrIIT70lxeL53lrGIAO9uNztt6xjt+fBF5mtZcojqTM+XY+8uVo3JYubs
	fUY1C5COy2sskFonjvKYshEUIVRZ1NA=
Date: Sun, 18 Jan 2026 23:04:58 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v4] kho: validate preserved memory map during population
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
 rppt@kernel.org, graf@amazon.com, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org, pratyush@kernel.org,
 ricardo.neri-calderon@linux.intel.com
References: <20251223140140.2090337-1-pasha.tatashin@soleen.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251223140140.2090337-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260118_230525_627861_8878B86E 
X-CRM114-Status: GOOD (  23.31  )
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

在 2025/12/23 6:01, Pasha Tatashin 写道:
> If the previous kernel enabled KHO but did not call kho_finalize()
> (e.g., CONFIG_LIVEUPDATE=n or userspace skipped the finalization step),
> the 'preserved-memory-map' property in the FDT remains empty/zero.
> 
> Previously, kho_populate() would succeed regardless of the memory map's
> state, reserving the incoming scratch regions in memblock. However,
> kho_memory_init() would later fail to deserialize the empty map. By that
> time, the scratch regions were already registered, leading to partial
> initialization and subsequent list corruption (freeing scratch area
> twice) during kho_init().
> 
> Move the validation of the preserved memory map earlier into
> kho_populate(). If the memory map is empty/NULL:
> 1. Abort kho_populate() immediately with -ENOENT.
> 2. Do not register or reserve the incoming scratch memory, allowing the new
>     kernel to reclaim those pages as standard free memory.
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
> Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes v4:
> - Addressed Tested-by
> - Addressed review comments from Pratyush.
> 
>   kernel/liveupdate/kexec_handover.c | 37 +++++++++++++++---------------
>   1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 9dc51fab604f..d4482b6e3cae 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -460,27 +460,23 @@ static void __init deserialize_bitmap(unsigned int order,
>   	}
>   }
>   
> -/* Return true if memory was deserizlied */
> -static bool __init kho_mem_deserialize(const void *fdt)
> +/* Returns physical address of the preserved memory map from FDT */
> +static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
>   {
> -	struct khoser_mem_chunk *chunk;
>   	const void *mem_ptr;
> -	u64 mem;
>   	int len;
>   
>   	mem_ptr = fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
>   	if (!mem_ptr || len != sizeof(u64)) {
>   		pr_err("failed to get preserved memory bitmaps\n");
> -		return false;
> +		return 0;
>   	}
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
>   	while (chunk) {
>   		unsigned int i;
>   
> @@ -489,8 +485,6 @@ static bool __init kho_mem_deserialize(const void *fdt)
>   					   &chunk->bitmaps[i]);
>   		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
>   	}
> -
> -	return true;
>   }
>   
>   /*
> @@ -1253,6 +1247,7 @@ bool kho_finalized(void)
>   struct kho_in {
>   	phys_addr_t fdt_phys;
>   	phys_addr_t scratch_phys;
> +	phys_addr_t mem_map_phys;
>   	struct kho_debugfs dbg;
>   };
>   
> @@ -1434,12 +1429,10 @@ static void __init kho_release_scratch(void)
>   
>   void __init kho_memory_init(void)
>   {
> -	if (kho_in.scratch_phys) {
> +	if (kho_in.mem_map_phys) {
>   		kho_scratch = phys_to_virt(kho_in.scratch_phys);
>   		kho_release_scratch();
> -
> -		if (!kho_mem_deserialize(kho_get_fdt()))
> -			kho_in.fdt_phys = 0;
> +		kho_mem_deserialize(phys_to_virt(kho_in.mem_map_phys));
>   	} else {
>   		kho_reserve_scratch();
>   	}
> @@ -1448,8 +1441,9 @@ void __init kho_memory_init(void)
>   void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>   			 phys_addr_t scratch_phys, u64 scratch_len)
>   {
> -	void *fdt = NULL;
>   	struct kho_scratch *scratch = NULL;
> +	phys_addr_t mem_map_phys;
> +	void *fdt = NULL;
>   	int err = 0;
>   	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
>   
> @@ -1475,6 +1469,12 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>   		goto out;
>   	}
>   
> +	mem_map_phys = kho_get_mem_map_phys(fdt);
> +	if (!mem_map_phys) {
> +		err = -ENOENT;
> +		goto out;
> +	}
> +
>   	scratch = early_memremap(scratch_phys, scratch_len);
>   	if (!scratch) {
>   		pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
> @@ -1515,6 +1515,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>   
>   	kho_in.fdt_phys = fdt_phys;
>   	kho_in.scratch_phys = scratch_phys;
> +	kho_in.mem_map_phys = mem_map_phys;
>   	kho_scratch_cnt = scratch_cnt;
>   	pr_info("found kexec handover data.\n");
>   
> 
> base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
The base-commit is

commit cc3aa43b44bdb43dfbac0fcb51c56594a11338a8 (HEAD -> 
upstream/master, tag: next-20251219)
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Fri Dec 19 14:12:19 2025 +1100

     Add linux-next specific files for 20251219

     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Now this commit can not be applied to the 6.19-rc5.

Zhu Yanjun


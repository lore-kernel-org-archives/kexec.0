Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62D7D2ECF7
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 15:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CUtpmFDmLNiTFlIK3X8Uw2GEumNSuKgQOqkNqnM02+Y=; b=HUsXaSwWTDBNkRa7IGZhSyvdlP
	GxXhXNqtQ4i1ocgSVZguJyFXdTzVVKnyFAcgbAOY0ERDMP/v6rzinhyaEB5tSXNgZJU/wZluilLyb
	HRWbdr2M3lJ9TogMojK4jFF2GiTx4H+M+Yu+CUpDXL2nf2aL0FsTQAB6OPjS/rzcQt6xzfTdABa4o
	MxKtt3ffa5Gtu7L6Sla5w0rbzTi1bLDAvH0i/3s4+rfNXnFhKuWPiQyjRfU8FX0A8QMXLH0jDA9QH
	tvwqfOt7BvhmkVQsco9+xg27g1pzqELuL3NVMPeQ+DflnTbn3iJQlIer3z9U7tw+XnNrgX4vVeXN4
	N9iKf9Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viDOV-000000043Vj-3Bao;
	Tue, 20 Jan 2026 15:11:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viDOT-000000043V9-24yl
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 15:11:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6DF3441846;
	Tue, 20 Jan 2026 15:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79283C16AAE;
	Tue, 20 Jan 2026 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768921904;
	bh=L0kijvKmmnnVJts9P035SvIiJZGDcTy18QVATluzDTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pqNBI0K4mNIsrekd8AQKjzjwr7TpaE02BvkUwCFkvouaKATK39xHpsYYUwhlDz/F8
	 xvMXfZuXW10ipkYaIXa6VJnj+Xrb7tHqCH6m8QGJd7+1BY3+qrnKOO9f2tv38MyMeP
	 R3XumRvZvWK4kZjucabXR6uQLPsS/cG/QNj5PrGRqV8pw4gT86SVseb42WeazYWfE9
	 6rdi1BynKj+Iht7MSeFAG8sPuI6zzH4srLDTx51YsQ78T8l3+pqdZDUUP6nqwDmLq1
	 JJgZ9YoaaExJx7qmFJqPXm5+pD6iy9ak7d8jOIgP7BYIdDhU2edmZDtbx0TTA8E12o
	 k1hkwtG2XrgEg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Breno Leitao <leitao@debian.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  akpm@linux-foundation.org,
  graf@amazon.com,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  ricardo.neri-calderon@linux.intel.com,  kernel-team@meta.com
Subject: Re: [PATCH v4] kho: validate preserved memory map during population
In-Reply-To: <aWx5qHHYEXJXNuXm@kernel.org> (Mike Rapoport's message of "Sun,
	18 Jan 2026 08:11:52 +0200")
References: <20251223140140.2090337-1-pasha.tatashin@soleen.com>
	<jixxiqeajngwox3nh2u3pwf2rivhmqxxmpyttqxu32pixshyde@4jdn5jvg5hvk>
	<2vxzo6mt7cl3.fsf@kernel.org> <aWx5qHHYEXJXNuXm@kernel.org>
Date: Tue, 20 Jan 2026 15:11:41 +0000
Message-ID: <2vxzv7gwe2tu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_071145_578892_D53A229F 
X-CRM114-Status: GOOD (  49.76  )
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

On Sun, Jan 18 2026, Mike Rapoport wrote:

> On Fri, Jan 16, 2026 at 04:21:28PM +0000, Pratyush Yadav wrote:
>> Hi Breno,
>> 
>> On Thu, Jan 08 2026, Breno Leitao wrote:
>> 
>> > Hello Pasha,
>> >
>> > On Tue, Dec 23, 2025 at 09:01:40AM -0500, Pasha Tatashin wrote:
>> >> If the previous kernel enabled KHO but did not call kho_finalize()
>> >> (e.g., CONFIG_LIVEUPDATE=n or userspace skipped the finalization step),
>> >> the 'preserved-memory-map' property in the FDT remains empty/zero.
>> >> 
>> >> Previously, kho_populate() would succeed regardless of the memory map's
>> >> state, reserving the incoming scratch regions in memblock. However,
>> >> kho_memory_init() would later fail to deserialize the empty map. By that
>> >> time, the scratch regions were already registered, leading to partial
>> >> initialization and subsequent list corruption (freeing scratch area
>> >> twice) during kho_init().
>> >
>> > While trying my new patchset [0] on top of this patch, I got the
>> > following issue:
>> >
>> > 	[    0.000000] KHO: disabling KHO revival: -2
>> >
>> > Trying to solve it, I come up with a change in kho_get_mem_map_phys() to
>> > distinguish no memory and error, see the patch attached later.
>> >
>> > This is what I used to test [0] on top of linux-next. Is this useful?
>> >
>> > Link: https://lore.kernel.org/all/20260108-kho-v3-1-b1d6b7a89342@debian.org/ [0]
>> >
>> > thanks
>> > --breno
>> >
>> > commit 5d7855fede8110d74942e1b67056ba589a1cb54a
>> > Author: Breno Leitao <leitao@debian.org>
>> > Date:   Thu Jan 8 07:44:08 2026 -0800
>> >
>> >     kho: allow KHO to work when no memory is preserved
>> >     
>> >     Fix KHO initialization failing when no memory pages were preserved by
>> >     the previous kernel.
>> >     
>> >     Commit eda79a683a0a ("kho: validate preserved memory map during
>> >     population") introduced kho_get_mem_map_phys() which returns the physical
>> >     address of the preserved memory map directly as its return value. The
>> >     caller then validates it with:
>> >     
>> >         mem_map_phys = kho_get_mem_map_phys(fdt);
>> >         if (!mem_map_phys) {
>> >             err = -ENOENT;
>> >             goto out;
>> >         }
>> >     
>> >     This creates an ambiguity: physical address 0 is used both as an error
>> >     indicator (property missing/malformed) and as a valid value (property
>> >     exists with value 0, meaning no memory was preserved).
>> >     
>> >     "No memory preserved" is a legitimate state. KHO provides features beyond
>> >     memory page preservation, such as previous kernel version tracking and
>> >     kexec count tracking. When the previous kernel enables KHO but doesn't
>> >     preserve any memory pages, it sets 'preserved-memory-map' to 0. This is
>> >     semantically different from "KHO not initialized" - it means "KHO is
>> >     active, there's just nothing in the memory map."
>> 
>> This isn't true. If you hand over _any_ state, you will at least need
>> the KHO FDT. And the KHO FDT is preserved memory (see the
>> kho_alloc_preserve() call in kho_init()). So I don't see how you can
>> ever have valid KHO with no memory.
>> 
>> mem_map_phys _can_ be 0, but only when KHO was enabled but not used. And
>> that is of course also a valid use case.
>> 
>> We want to treat mem_map_phys == 0 the same as the error path, just
>> without the error print. This lets us discard all previous scratch areas
>> since they don't have anything useful anyway, and have a fresh start.
>> 
>> So while you are seeing this error message, I don't think it should
>> break anything and KHO should still be working fine. You can
>> double-check this by inspecting /sys/kernel/debug/kho/out.
>> 
>> So I think the patch is certainly a useful fix, it just needs some
>> re-wording and fixups.
>> 
>> Some comments on the code below.
>> 
>> >     
>> >     Before eda79a683a0a, the code handled this gracefully in
>> >     kho_mem_deserialize():
>> >     
>> >         chunk = mem ? phys_to_virt(mem) : NULL;
>> >         if (!chunk)
>> >             return false;  // No pages, but KHO could still work
>> >     
>> >     After eda79a683a0a, the early validation conflated "no property" with
>> >     "property value is 0", causing KHO to be completely disabled in both
>> >     cases.
>> >     
>> >     Fix this by changing kho_get_mem_map_phys() to return an error code and
>> >     pass the physical address via pointer. This allows distinguishing between:
>> >      - Property missing/malformed: return -ENOENT (KHO fails)
>> >      - Property exists with value 0: return 0 (KHO succeeds, no memory to
>> >        restore)
>> >     
>> >     Fixes: eda79a683a0a ("kho: validate preserved memory map during population")
>> >     Signed-off-by: Breno Leitao <leitao@debian.org>
>> >
>> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> > index 271d90198a08..3cf2dc6840c9 100644
>> > --- a/kernel/liveupdate/kexec_handover.c
>> > +++ b/kernel/liveupdate/kexec_handover.c
>> > @@ -471,8 +471,8 @@ static void __init deserialize_bitmap(unsigned int order,
>> >  	}
>> >  }
>> >  
>> > -/* Returns physical address of the preserved memory map from FDT */
>> > -static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
>> > +/* Returns 0 on success and stores physical address in *phys_out */
>> > +static int __init kho_get_mem_map_phys(const void *fdt, phys_addr_t *phys_out)
>> >  {
>> >  	const void *mem_ptr;
>> >  	int len;
>> > @@ -480,10 +480,11 @@ static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
>> >  	mem_ptr = fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
>> >  	if (!mem_ptr || len != sizeof(u64)) {
>> >  		pr_err("failed to get preserved memory bitmaps\n");
>> > -		return 0;
>> > +		return -ENOENT;
>> >  	}
>> >  
>> > -	return get_unaligned((const u64 *)mem_ptr);
>> > +	*phys_out = get_unaligned((const u64 *)mem_ptr);
>> > +	return 0;
>> >  }
>> >  
>> >  static void __init kho_mem_deserialize(struct khoser_mem_chunk *chunk)
>> > @@ -1439,7 +1440,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>> >  			 phys_addr_t scratch_phys, u64 scratch_len)
>> >  {
>> >  	struct kho_scratch *scratch = NULL;
>> > -	phys_addr_t mem_map_phys;
>> > +	phys_addr_t mem_map_phys = 0;
>> >  	void *fdt = NULL;
>> >  	int err = 0;
>> >  	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
>> > @@ -1466,11 +1467,9 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>> >  		goto out;
>> >  	}
>> >  
>> > -	mem_map_phys = kho_get_mem_map_phys(fdt);
>> > -	if (!mem_map_phys) {
>> > -		err = -ENOENT;
>> > +	err = kho_get_mem_map_phys(fdt, &mem_map_phys);
>> > +	if (err)
>> 
>> This will break when mem_map_phys == 0. As I explained earlier, when
>> that happens we want to discard all previous scratch info and start with
>> a clean slate.
>> 
>> Making this if (err || !mem_map_phys) should do the trick. The if (err)
>> check before the print should make sure the error message is not printed
>> when we have a valid property but its value is 0.
>
> While we are on it, I'd suggest to change kho_populate() error handling to
> use goto, (i.e like below)
> Then a simple if (err) will do and that's much clearer.

Yeah, looks like a good cleanup.

>
> Another thing I noticed it that assigning err to -EFAULT or -EINVAL after
> printks is completely redundant, since we anyway report what went wrong, so
> printing the error value in the end just not needed.
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index feffeafa51b7..2bba111149c4 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1453,27 +1453,27 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  	if (!fdt) {
>  		pr_warn("setup: failed to memremap FDT (0x%llx)\n", fdt_phys);
>  		err = -EFAULT;
> -		goto out;
> +		goto err_report;
>  	}
>  	err = fdt_check_header(fdt);
>  	if (err) {
>  		pr_warn("setup: handover FDT (0x%llx) is invalid: %d\n",
>  			fdt_phys, err);
>  		err = -EINVAL;
> -		goto out;
> +		goto err_unmap_fdt;
>  	}
>  	err = fdt_node_check_compatible(fdt, 0, KHO_FDT_COMPATIBLE);
>  	if (err) {
>  		pr_warn("setup: handover FDT (0x%llx) is incompatible with '%s': %d\n",
>  			fdt_phys, KHO_FDT_COMPATIBLE, err);
>  		err = -EINVAL;
> -		goto out;
> +		goto err_unmap_fdt;
>  	}
>  
>  	mem_map_phys = kho_get_mem_map_phys(fdt);
>  	if (!mem_map_phys) {
>  		err = -ENOENT;
> -		goto out;
> +		goto err_unmap_fdt;
>  	}
>  
>  	scratch = early_memremap(scratch_phys, scratch_len);
> @@ -1481,7 +1481,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  		pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
>  			scratch_phys, scratch_len);
>  		err = -EFAULT;
> -		goto out;
> +		goto err_unmap_scratch;
>  	}
>  
>  	/*
> @@ -1498,7 +1498,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  		if (WARN_ON(err)) {
>  			pr_warn("failed to mark the scratch region 0x%pa+0x%pa: %pe",
>  				&area->addr, &size, ERR_PTR(err));
> -			goto out;
> +			goto err_unmap_scratch;
>  		}
>  		pr_debug("Marked 0x%pa+0x%pa as scratch", &area->addr, &size);
>  	}
> @@ -1520,13 +1520,14 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  	kho_scratch_cnt = scratch_cnt;
>  	pr_info("found kexec handover data.\n");
>  
> -out:
> -	if (fdt)
> -		early_memunmap(fdt, fdt_len);
> -	if (scratch)
> -		early_memunmap(scratch, scratch_len);
> -	if (err)
> -		pr_warn("disabling KHO revival: %d\n", err);
> +	return;
> +
> +err_unmap_scratch:
> +	early_memunmap(scratch, scratch_len);
> +err_unmap_fdt:
> +	early_memunmap(fdt, fdt_len);
> +err_report:
> +	pr_warn("disabling KHO revival: %d\n", err);
>  }
>  
>  /* Helper functions for kexec_file_load */
>  
>> >  		goto out;
>> > -	}
>> >  
>> >  	scratch = early_memremap(scratch_phys, scratch_len);
>> >  	if (!scratch) {
>> 
>> -- 
>> Regards,
>> Pratyush Yadav

-- 
Regards,
Pratyush Yadav


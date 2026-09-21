Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BA6C982E1
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 05:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DfKCxDkGmiGAvVKE3w2w5luUgwycfNwU8vR07vCusUo=; b=jKj6N2/hcD+Ve+X67dasnTAwt6
	Ty5jRJh3wpZpF1sScIqgFSHCysGpbbRqu2M4bohLxbA/ZqH0XDj+cmNuhTFGXoqCJ4OdwKVD3kH9A
	x7j6h3B1hD9IoXO4PRdrEEazLErISS14ZfpGOxsr6b5q28bMK9t0bHWxQmMZFeSn11zZ+tzXVp18w
	RaRRzS8M1sK6/T/CtnQzlvpx51hqnNjpMunqjMhw5JIkKbl14zzjeZVmUcge1NdfPCSOsw5LHGR6Q
	R+AdrN16txunTkQyVfghTSlUIugXcJjSKAxoaxuEhxRXyUPDvQZ4uJ8J2XRHSbDMwgrbcOcZNSJ4k
	dPBIKJ8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8WtR-00000000xpj-2EmE;
	Mon, 21 Sep 2026 05:48:45 +0000
Received: from out-109.mta0.migadu.com ([2001:41d0:1004:224b::6d] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8WtO-00000000xnJ-0Vtv
	for kexec@lists.infradead.org;
	Mon, 21 Sep 2026 05:48:43 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=jhV/vw4+vWN8dqMOnDQNzr0Wd/YKWAZ5SZrLjVrKgJI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789969718; v=1; x=1790574518;
 b=wsWyZ/itCi6fu86wCCcJ0RZGEFvh1E6p15NlDx9Adkkv4ElC8H2tSzAL4teGcsjDOD6R85qz
 ElMAx70yL56Y1inpsiwWZHt2hrRRGoQ/lXhLrDGO15qK0CXIIZPbnue43uUKvmPYjDQXRaCwlcP
 2RBx/KWVKMVfSuslG0ikOMXY=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id 417d6ee2dae11de6;
	Mon, 21 Sep 2026 05:48:38 +0000
X-Mizu-Trace-ID: 417d6ee2dae11de6
X-Migadu-Flow: FLOW_OUT
Date: Mon, 21 Sep 2026 13:48:34 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, robh@kernel.org,
	saravanak@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	m.szyprowski@samsung.com, mark.rutland@arm.com, kernel@xen0n.name,
	alex@ghiti.fr, hpa@zytor.com, ruirui.yang@linux.dev,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v6 02/10] riscv: build crash_mem ranges from memblock
 instead of resource tree
Message-ID: <arDFMqcUr6xkTn-h@fedora>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-3-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902073116.802752-3-chenwandun1@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_224842_299917_F52B07D5 
X-CRM114-Status: GOOD (  16.93  )
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

On 09/02/26 at 03:31pm, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> Replace walk_system_ram_res() with for_each_mem_range(). A later patch
> introduces MEMBLOCK_NODUMP in memblock, the reserved-memory regions
> marked with MEMBLOCK_NODUMP can be excluded from the vmcore by walking
> memblock.
> 
> for_each_mem_range() iterates memblock.memory, which is freed after
> init unless ARCH_KEEP_MEMBLOCK is selected. riscv needs ARCH_KEEP_MEMBLOCK
> to filter reserved memory from the vmcore, so extend its condition
> (ACPI || KEXEC) with CRASH_DUMP. arm64 and loongarch already select
> ARCH_KEEP_MEMBLOCK unconditionally.
> 
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> ---
>  arch/riscv/Kconfig                     |  2 +-
>  arch/riscv/kernel/machine_kexec_file.c | 31 ++++++++++----------------
>  2 files changed, 13 insertions(+), 20 deletions(-)

This looks good to me, FWIW,

Acked-by: Baoquan He <baoquan.he@linux.dev>

> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d6c2dbf8455c..1de14a2d5aba 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -58,7 +58,7 @@ config RISCV
>  	select ARCH_HAS_UBSAN
>  	select ARCH_HAS_VDSO_ARCH_DATA
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> -	select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC
> +	select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC || CRASH_DUMP
>  	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
> index 26cd2a8bd0cd..808e872f4063 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -37,39 +37,32 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  }
>  
>  #ifdef CONFIG_CRASH_DUMP
> -static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
> -{
> -	unsigned int *nr_ranges = arg;
> -
> -	(*nr_ranges)++;
> -	return 0;
> -}
> -
>  unsigned int arch_get_system_nr_ranges(void)
>  {
>  	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* For exclusion of crashkernel region */
> +	u64 i;
> +	phys_addr_t start, end;
>  
> -	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> +	for_each_mem_range(i, &start, &end)
> +		nr_ranges++;
>  
>  	return nr_ranges;
>  }
>  
> -static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
> +int arch_crash_populate_cmem(struct crash_mem *cmem)
>  {
> -	struct crash_mem *cmem = arg;
> +	u64 i;
> +	phys_addr_t start, end;
>  
> -	cmem->ranges[cmem->nr_ranges].start = res->start;
> -	cmem->ranges[cmem->nr_ranges].end = res->end;
> -	cmem->nr_ranges++;
> +	for_each_mem_range(i, &start, &end) {
> +		cmem->ranges[cmem->nr_ranges].start = start;
> +		cmem->ranges[cmem->nr_ranges].end = end - 1;
> +		cmem->nr_ranges++;
> +	}
>  
>  	return 0;
>  }
>  
> -int arch_crash_populate_cmem(struct crash_mem *cmem)
> -{
> -	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
> -}
> -
>  static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
>  				 unsigned long cmdline_len)
>  {
> -- 
> 2.43.0
> 


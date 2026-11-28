Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E850606A323
	for <kexec@archiver.kernel.org>; Sat, 28 Nov 2026 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P1Uoyl2y;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQaEGDjV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2LkjI5OfW/AcnfuRn8Nh+CH9bv/zi8GddO0OWp2WwlM=; b=P1Uoyl2y8gl4DuoPRp6xg5Rron
	OGT07xiOSgCuarQi44R4QUzDCCS+33q7USgVjXjnnevjXsZvyWK4K7QmViVjLhvCZLFiDHheRE7vL
	0qz6U5fhN2zL5skm4QiRNJaVK2V1zF3Jmu4WMfOqu5/VRF6a6FXeUPK2mzXnURHTqqJp/6XBkLVj+
	vtwoTL2u/1rwt4jEgDPS+n/W344yUD9whNlkVxDpWIX6y0/ASKz4aOsq/OJXqQFnTKgeShfuNivGX
	ZYTkv3SLPv9CKSDi7k6sNiGoSBhjDrg3r0xd6AzMsxwjjO1wY+DnQtqn6iOAtkG+vgjmX4svN1obn
	paa8gCVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXEWv-00000000ZOG-0fVl;
	Sat, 28 Nov 2026 09:15:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXEWs-00000000ZNv-1B52
	for kexec@lists.infradead.org;
	Sat, 28 Nov 2026 09:15:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6D19C60CF9;
	Sat, 28 Nov 2026 09:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96751F000C1;
	Sat, 28 Nov 2026 09:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795857333;
	bh=2LkjI5OfW/AcnfuRn8Nh+CH9bv/zi8GddO0OWp2WwlM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bQaEGDjVXgLY77DJDFcKNY6FEKrR1bVERqqddKt7HtsuA4KC/iCBZvMyUWzVqlFPL
	 vfnd/Et8FVdpHlL2oQO7cinUfOl5L9dQPaAjT7zP9bThjrYQO3FLRt1+LchiSZamNa
	 FxK7GCV+JKe6gc2ZU7pmL6kr1TbX+mPiLcuYWH4ojcBqWej50iKuGTZe0bsdKpqRQN
	 41cDsYuYo0hQOXc7hGcX3WP6lEpk+0zyclz6CQaAMH5keye+rK8ydGRo2VkbsG81Sp
	 E9jF0eLCex2SJhAdYaoPBwzt88y/eUkIQBabnflUwnQLi+Xm52O1/kYd25ln8ImdMb
	 vAuni7F5jYosg==
Message-ID: <sashiko-outbox-238578@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 7/8] of: reserved_mem: mark /reserved-memory entries
 with MEMBLOCK_NODUMP
To: "Wandun Chen" <chenwandun1@gmail.com>, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, ruanjinjie@huawei.com, devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, conor+dt@kernel.org
In-Reply-To: <20261127090723.741253-8-chenwandun1@gmail.com>
References: <20261127090723.741253-1-chenwandun1@gmail.com>
 <20261127090723.741253-8-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 09:15:31 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] of: reserved_mem: sub-page memblock split in
  fdt_mark_reserve_mem_nodump()
- [Medium] of: reserved_mem: early nodump split in
  unflatten_device_tree() before kasan
--

commit 47a5a6000f1f57782ed8a71e5ff4a13ee231c6bd
Author: Wandun Chen <chenwandun@lixiang.com>

of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP

This commit adds fdt_mark_reserve_mem_nodump() and calls it from
unflatten_device_tree() to mark page-clamped non-dumpable
/reserved-memory regions with MEMBLOCK_NODUMP.

Link: https://sashiko.dev/#/message/sashiko-outbox-181183@kernel.org [1]

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index a58efdcbac7f1..f3a766310d119 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1283,6 +1283,8 @@ void __init unflatten_device_tree(void)
>  {
>  	void *fdt =3D initial_boot_params;
> =20
> +	fdt_mark_reserve_mem_nodump();
> +
>  	/* Populate an empty root node when bootloader doesn't provide one */
>  	if (!fdt) {
>  		fdt =3D (void *) __dtb_empty_root_begin;

[Severity: Medium]
Does calling fdt_mark_reserve_mem_nodump() in unflatten_device_tree()
split memblock.memory too early for kasan_init() and kvm_hyp_reserve()?

Mapped (!no-map) reserved-memory regions were previously only recorded in
memblock.reserved, keeping memblock.memory contiguous.  Splitting
memblock.memory with MEMBLOCK_NODUMP at PAGE_SIZE boundaries before the
rest of setup_arch() causes for_each_mem_range() and
for_each_mem_region() to iterate over the split ranges separately.

On arm64 and loongarch, when a mapped non-dumpable region boundary is
PAGE_SIZE-aligned but not aligned to PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT
(e.g. 32 KiB or 64 KiB on 4 KiB pages), the two adjacent regions share a
KASAN shadow page.  Because kasan_pte_populate() checks pte_none() only in
its do-while loop condition after the first iteration, the second region
allocates a duplicate shadow page, overwrites the PTE, and leaks the first
page:

arch/arm64/mm/kasan_init.c:kasan_pte_populate() {
    ...
	do {
		phys_addr_t page_phys =3D early ?
				__pa_symbol(kasan_early_shadow_page)
					: kasan_alloc_raw_page(node);
		if (!early)
			memset(__va(page_phys), KASAN_SHADOW_INIT, PAGE_SIZE);
		next =3D addr + PAGE_SIZE;
		__set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PAGE_KERNEL));
	} while (ptep++, addr =3D next, addr !=3D end && pte_none(__ptep_get(ptep)=
));
}

On riscv, splitting 16 MiB physical ranges before kasan_init() prevents
kasan_populate_pmd() from mapping a full 2 MiB shadow PMD, falling back to
4 KiB PTEs.  On arm64 with pKVM, splitting memblock.memory before
bootmem_init() -> kvm_hyp_reserve() consumes extra slots in the fixed
128-entry hyp_memory[] array and increases per-region hypervisor
page-table and vmemmap reservations.

[ ... ]

> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index a5cd8c2fffc35..cef444d4c1a38 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -610,6 +610,36 @@ static void __init fdt_init_reserved_mem_node(unsign=
ed long node, const char *un
>  	reserved_mem_count++;
>  }
> =20
> +void __init fdt_mark_reserve_mem_nodump(void)
> +{
> +	struct reserved_mem *rmem;
> +	int i;
> +
> +	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
> +		return;
> +
> +	if (!IS_ENABLED(CONFIG_KEXEC_FILE) && !IS_ENABLED(CONFIG_CRASH_HOTPLUG))
> +		return;
> +
> +	if (reserved_mem_reserve_failed)
> +		return;
> +
> +	for (i =3D 0; i < reserved_mem_count; i++) {
> +		phys_addr_t base, end;
> +
> +		rmem =3D &reserved_mem[i];
> +		if (!rmem->size || rmem->dumpable)
> +			continue;
> +
> +		base =3D round_up(rmem->base, PAGE_SIZE);
> +		end =3D round_down(rmem->base + rmem->size, PAGE_SIZE);
> +		if (base >=3D end)
> +			continue;
> +
> +		memblock_mark_nodump(base, end - base);
> +	}
> +}

[Severity: High]
Can clamping each region to PAGE_SIZE here leave sub-page fragments in
memblock.memory when a no-map region or an adjacent region is not
page-aligned?

During fdt_scan_reserved_mem(), no-map regions are marked with
MEMBLOCK_NOMAP in memblock.memory at byte granularity (for example,
cont_splash_mem in arch/arm64/boot/dts/exynos/exynos2200-g0s.dts has size
0x9a3f80, and 4 KiB-aligned no-map regions are unaligned under 16 KiB or
64 KiB PAGE_SIZE).  Because fdt_mark_reserve_mem_nodump() does not skip
MEMBLOCK_NOMAP regions, calling memblock_mark_nodump(base, end - base) on
the page-clamped interior range gives [base, end) flags
MEMBLOCK_NOMAP | MEMBLOCK_NODUMP while leaving the unaligned head
[rmem->base, base) and tail [end, rmem->base + rmem->size) as sub-page
regions with only MEMBLOCK_NOMAP.

Similarly, if a mapped non-dumpable region abuts an unaligned no-map
region, clamping inward to PAGE_SIZE leaves a sub-page MEMBLOCK_NONE
fragment between the two regions; and if two adjacent non-dumpable regions
meet at a sub-page boundary, clamping each entry before coalescing leaves
their shared page unmarked.

On riscv, init_resources() converts every memblock.memory region
(including MEMBLOCK_NOMAP) using PFN_UP for start and PFN_DOWN - 1 for
end:

arch/riscv/kernel/setup.c:init_resources() {
    ...
	for_each_mem_region(region) {
		res =3D &mem_res[res_idx--];
		non_resv_res++;

		if (unlikely(memblock_is_nomap(region))) {
			res->name =3D "Reserved";
			res->flags =3D IORESOURCE_MEM | IORESOURCE_EXCLUSIVE;
		} else {
			res->name =3D "System RAM";
			res->flags =3D IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
		}

		res->start =3D __pfn_to_phys(memblock_region_memory_base_pfn(region));
		res->end =3D __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;

		ret =3D add_resource(&iomem_resource, res);
		if (ret < 0)
			goto error;
	}
    ...
}

Any sub-page fragment produces res->start > res->end, which fails
add_resource() and tears down iomem_resource.  On arm64 and loongarch, a
sub-page MEMBLOCK_NONE fragment likewise produces res->start > res->end in
request_standard_resources() / resource_init(), and an unaligned no-map
region split by MEMBLOCK_NODUMP is broken into multiple reserved entries
in /proc/iomem.

Since crash_should_skip_region() already skips MEMBLOCK_NOMAP regions,
skipping no-map entries and coalescing adjacent non-dumpable ranges before
clamping to page boundaries would avoid creating sub-page MEMBLOCK_NOMAP
splits and unmarked shared pages.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127090723.7412=
53-1-chenwandun1@gmail.com?part=3D7


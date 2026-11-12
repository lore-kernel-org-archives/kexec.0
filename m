Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A209606A336
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Lo63xS7u;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNpDs8Or
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NvKWITkPVoSG8d6eyNemOjAl3LRApkKJD8vkm/Uw8dI=; b=Lo63xS7uhDYp9QH+wyvNPzvkLj
	v6VUIsrVBke78JeFWTL5QKdeCVlq9+5HoMkFQUt7erJMHMJ9vXwoEylW9UQsQ5iv0VqsL5Se0VVJM
	0a1d9T1YRekMULMrnZfHQhSaKAU0mX6e4p4f1JOcQs4nEKiSF8pHyMf8aoeMPoPCFNpPBpM4z6Rwr
	pqtvLN5dPDfK2fPYMncE0s74JCl/q9lnFJg9rGo7dTWehnAqWjbO+vlnwA+Y9Oc7zB7YYMfCkb1RQ
	3NBWKBjMGyjonZMIWaQPrakelJWcfCCT8cE4QweFcFuKntqXxVZc0mqUVoavQcH82RvZAwWdz377z
	/IFGi9jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRTMT-00000009mqU-3mMa;
	Thu, 12 Nov 2026 11:53:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRTMS-00000009mpg-1mty
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 11:53:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C0FA363668;
	Thu, 12 Nov 2026 11:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AE31F00A0A;
	Thu, 12 Nov 2026 11:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484379;
	bh=NvKWITkPVoSG8d6eyNemOjAl3LRApkKJD8vkm/Uw8dI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hNpDs8Or60ABLt6mYuD+VCEbtYgzNpnPPYhlCb9EiRk+MjxduJc9baSa8eS1AMCQ8
	 vqLfBX8PnBt8QxJAk2tPzRKetcFAKAt/dpN15PmBYU0AqbVp5mj0VBnePp7SUiCt3E
	 869fuqJxmP5CcjCdPqgNyE9MyFj8kvAizroIsa0COXTjpaZTEQQGcnbQ4ErOAt4sa3
	 qSYLYeoe7pzwxRRJ1oxmrBXv3+b+XEs6N2BBzbNxpXW3Z1a7UJZR1269nTFKSZEWQU
	 2kh7Ee+nx07lCYX7HdLwPQ2Ngw5bqUZEpSNhsqfy/fynw128nCBcvpQoZad0s8YgKX
	 mwHwHb5nJQcqQ==
Message-ID: <sashiko-outbox-211051@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/8] s390/kdump: Use crashkernel CMA memory in the
 kdump kernel
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Jiri Bohac" <jbohac@suse.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Usama Arif" <usama.arif@linux.dev>, linux-s390@vger.kernel.org, kexec@lists.infradead.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112112105.1169118-7-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
 <20261112112105.1169118-7-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:52:58 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] s390/kdump: unmapped hole aborts __set_memory_4k() in
  vmem_map_init()
- [Medium] s390/kdump: uncapped ident_map_size and nokaslr truncate CMA
  ranges
- [Medium] s390/kdump: setup_usable_memory() loses CMA ranges below
  oldmem_data.size
- [Medium] s390/kdump: uncapped ident_map_size lets
  reserve_crashkernel() run in kdump
- [Low] s390/kdump: missing KASAN zero shadow in kasan_populate_shadow()
  holes
--

commit 9e7830ee8f173942437ec5cda601c7a5e6920ddc
Author: Mikhail Zaslonko <zaslonko@linux.ibm.com>

s390/kdump: Use crashkernel CMA memory in the kdump kernel

This commit stops capping ident_map_size to oldmem_data.size when crashkern=
el
CMA ranges are present and instead registers [0, oldmem_data.size) and the
CMA ranges as usable physical memory ranges in setup_usable_memory().

> diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
> index 111b146a3332f..dba1dfc0ee499 100644
> --- a/arch/s390/boot/startup.c
> +++ b/arch/s390/boot/startup.c
> @@ -197,6 +197,22 @@ static void deploy_kernel(void *output)
>  }
>  #endif
> =20
> +static void setup_usable_memory(void)
> +{
> +	unsigned long start;
> +	int i;
> +
> +	if (!IS_ENABLED(CONFIG_CRASH_DUMP) || !oldmem_data.start) {
> +		physmem_add_usable_range(0, ident_map_size);
> +		return;
> +	}
> +	physmem_add_usable_range(0, oldmem_data.size);
> +	for (i =3D 0; i < ARRAY_SIZE(oldmem_data.crashk_cma) && oldmem_data.cra=
shk_cma[i].size; i++) {
> +		start =3D oldmem_data.crashk_cma[i].start;
> +		physmem_add_usable_range(start, start + oldmem_data.crashk_cma[i].size=
);
> +	}
> +}

[Severity: Medium]
Can registering discontiguous usable ranges here leave crashk_cma mapped wi=
th
large pages when debug_pagealloc is enabled?

In setup_vmem(), pgtable_populate() only populates identity mappings for
for_each_physmem_usable_range(), using 1MB or 2GB large pages while leaving
the hole starting at __va(oldmem_data.size) unmapped.  Later, vmem_map_init=
()
calls __set_memory_4k(__va(0), absolute_pointer(__va(0)) + ident_map_size),
which walks the range linearly and aborts with -EINVAL in walk_pmd_level()
at the first unmapped entry at __va(oldmem_data.size):

arch/s390/mm/pageattr.c:walk_pmd_level() {
	...
		pmd =3D pmdp_get(pmdp);
		if (pmd_none(pmd))
			return -EINVAL;
	...
}

As a result, the large-page mappings for the CMA ranges above the hole are
never split into 4KB PTEs.  When mem_init() frees those CMA pages to the
buddy allocator, __kernel_map_pages() calls virt_to_kpte() on leaf PMD/PUD
entries and passes the physical CMA data frames to ipte_range() or set_pte(=
),
corrupting memory or triggering a program check during kdump boot.

[Severity: Medium]
What happens if a crashk_cma range was allocated below oldmem_data.size in
the primary kernel?

reserve_crashkernel() calls reserve_crashkernel_cma() with a base of 0, so
cma_declare_contiguous() can place CMA ranges below oldmem_data.size (for
example, above 4GB when crash_size > 4GB, or via the top-down fallback when
memory above 4GB is full).  When kdump triggers, purgatory swaps physical
[0, oldmem_data.size) with [oldmem_data.start, oldmem_data.start +
oldmem_data.size), moving any CMA range in that region into the
oldmem_data.start area.

Because setup_usable_memory() passes the unswapped crashk_cma[i].start to
physmem_add_usable_range(), any CMA range with start <=3D oldmem_data.size =
is
merged into the [0, oldmem_data.size) range instead of adding the swapped
frames inside [oldmem_data.start, oldmem_data.start + oldmem_data.size),
losing that CMA memory in the kdump kernel.

[ ... ]

> @@ -287,7 +304,9 @@ static void setup_ident_map_size(unsigned long max_ph=
ysmem_end)
>  #ifdef CONFIG_CRASH_DUMP
>  	if (oldmem_data.start) {
>  		__kaslr_enabled =3D 0;
> -		ident_map_size =3D min(ident_map_size, oldmem_data.size);
> +		/* no CMA ranges handed over to the crashkernel */
> +		if (!oldmem_data.crashk_cma[0].size)
> +			ident_map_size =3D min(ident_map_size, oldmem_data.size);
>  		boot_debug("kdump memory limit:  0x%016lx\n", oldmem_data.size);
>  	} else if (ipl_block_valid && is_ipl_block_dump()) {

[Severity: Medium]
Can leaving ident_map_size uncapped at max_physmem_end while forcing
__kaslr_enabled =3D 0 cause crashk_cma ranges to be truncated on large-memo=
ry
systems?

In setup_kernel_memory_layout(), a non-KASAN kernel with default
CONFIG_KERNEL_IMAGE_BASE only selects 4-level paging (_REGION1_SIZE) when
vsize > _REGION2_SIZE && kaslr_enabled():

arch/s390/boot/startup.c:setup_kernel_memory_layout() {
	...
	if (IS_ENABLED(CONFIG_KASAN) || __NO_KASLR_END_KERNEL > _REGION2_SIZE ||
	    (vsize > _REGION2_SIZE && kaslr_enabled())) {
		asce_limit =3D _REGION1_SIZE;
	...
	} else {
		asce_limit =3D _REGION2_SIZE;
		rte_size =3D _REGION3_SIZE;
	}
}

While the primary kernel with KASLR enabled upgrades to 4-level paging and
can reserve crashk_cma ranges at higher physical addresses, the kdump kernel
has __kaslr_enabled =3D 0 and stays in 3-level paging (4TB).  Because
ident_map_size is left at max_physmem_end instead of the end of the highest
usable CMA range, vmalloc_size and vmemmap are sized for max_physmem_end,
pushing vmemmap_start down within the 4TB space.  setup_kernel_memory_layou=
t()
then clamps ident_map_size to vmemmap_start, and physmem_add_usable_range()
silently clips and drops any crashk_cma ranges above that limit.

[Severity: Medium]
Does leaving ident_map_size uncapped also allow reserve_crashkernel() to
succeed inside the kdump kernel when crashkernel=3D is on the kdump command
line?

In reserve_crashkernel(), parse_crashkernel(boot_command_line,
ident_map_size, ...) previously saw ident_map_size capped to oldmem_data.si=
ze
and rejected the reservation because crash_size >=3D system_ram.  With
ident_map_size left at max_physmem_end, parse_crashkernel() succeeds: when
crash_base is 0, reserve_crashkernel() sets crashk_res to
[oldmem_data.start, oldmem_data.start + crash_size - 1], and
setup_resources() adds that range to memblock even though
setup_usable_memory() excluded oldmem_data.start from the identity mapping.

[Severity: Low]
When CONFIG_KASAN is enabled, does leaving ident_map_size above the last
usable CMA range leave KASAN shadow holes unmapped?

In kasan_populate_shadow(), the loop over for_each_physmem_usable_range()
only populates POPULATE_KASAN_ZERO_SHADOW for inter-range gaps when
physmem_info.info_source =3D=3D MEM_DETECT_DIAG260, and the untracked shadow
population after the loop starts at __identity_va(ident_map_size) rather th=
an
at the end of the last usable range (memgap_start):

arch/s390/boot/vmem.c:kasan_populate_shadow() {
	...
	for_each_physmem_usable_range(iter, &start, &end) {
		kasan_populate((unsigned long)__identity_va(start),
			       (unsigned long)__identity_va(end),
			       POPULATE_KASAN_MAP_SHADOW);
		if (memgap_start && physmem_info.info_source =3D=3D MEM_DETECT_DIAG260) {
			kasan_populate((unsigned long)__identity_va(memgap_start),
				       (unsigned long)__identity_va(start),
				       POPULATE_KASAN_ZERO_SHADOW);
		}
		memgap_start =3D end;
	}
	...
	kasan_populate((unsigned long)__identity_va(ident_map_size), VMALLOC_START,
		       POPULATE_KASAN_ZERO_SHADOW);
}

This leaves the identity-map holes between usable ranges (when info_source =
is
not MEM_DETECT_DIAG260) and between the last CMA range and ident_map_size
without KASAN shadow mappings, which will fault if a DCSS segment is mapped
into those regions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112112105.1169=
118-1-zaslonko@linux.ibm.com?part=3D6


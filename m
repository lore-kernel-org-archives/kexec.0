Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA7606A326
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oJ1o0wDh;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KoojDrfl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Pw1RA8b/0wqWpwAG8rn8nMbI8/CS2La9EFhpCnYgEt4=; b=oJ1o0wDhnjC3TlPlOqc8VWfwdY
	W7bNEnvmEGkbrMA8Md3YoAVXdodaXzyDt/ts0mAnhQQzgYfcvz0kvY5vBUPv0ee8wbTMco4zUW3NS
	XJG+uKuBcF4Se0LVbBURO/qVst3yNf43Hqx7u1cdOfriNi+WoQXu0SliJRV/S4FBbZXaw1KZwSYXM
	lE1o/H/NJ9f70B0/0dkTYjPcaj+LQwMhZ13gz8b4LEoxotY8pxcar8/eGZMFUvqYEXqOOkzvh6qOq
	Zx7CL0G3NuBoQAiPFCsiBBIeG5qqn4/ZYMiQuOPkU2plxjGecw1ohZ6Q+gY9vOgIDePnQ7IZjGQM7
	6snpgi8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOW4j-00000004edW-46uA;
	Wed, 04 Nov 2026 08:10:29 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOW4f-00000004eaY-3HIO
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 08:10:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 008D260D9B;
	Wed,  4 Nov 2026 08:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178811F00A02;
	Wed,  4 Nov 2026 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793779824;
	bh=Pw1RA8b/0wqWpwAG8rn8nMbI8/CS2La9EFhpCnYgEt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KoojDrflsyT352+kmH6suq8he+NSQ6/q6xmVHkGlSicSPJjOeWsqaXFoQ7hIB8OFX
	 YVtkEK9bOARfkuo/urulh2JSAXw612CS1tUEjXQASxf4obq5lilY4IgBXG+6HiwOld
	 scTQVVre6Gq0jzmFai+h55fzFB+XejmC5wDvDkSLWOG8m4PKVItjB5l7OVULSarR+p
	 UeCaVPkVzinfoYpzgwd6QYJh+6wQpXEv9zRRSrZBUtzhGirQWWP4kZt8sVtKps5k/E
	 4A41XuinKlgZwFv63c37Rml1ZcF07flt71FjoPVGLVW6u28r6GLh6x5UOvrIEy7yV2
	 hjIViDB11k3jA==
Message-ID: <sashiko-outbox-196857@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] riscv: Add support for kexec handover (KHO)
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org
In-Reply-To: <20261103080926.2079-4-cp0613@linux.alibaba.com>
References: <20261103080926.2079-1-cp0613@linux.alibaba.com>
 <20261103080926.2079-4-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 08:10:23 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] riscv: kho: bootmem reservation fails when DRAM starts at or abo=
ve 4 GiB
--

commit 25f3cc12aa8edcc1fbb1363f837f61e462a57ad6
Author: Chen Pei <cp0613@linux.alibaba.com>

riscv: Add support for kexec handover (KHO)

This commit enables kexec handover (KHO) support on 64-bit RISC-V systems w=
ith
MMU enabled by defining ARCH_SUPPORTS_KEXEC_HANDOVER in arch/riscv/Kconfig.

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 435da07132437..e11463a923a32 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -1125,6 +1125,9 @@ config ARCH_SELECTS_KEXEC_FILE
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
>  	def_bool ARCH_SUPPORTS_KEXEC_FILE
> =20
> +config ARCH_SUPPORTS_KEXEC_HANDOVER
> +	def_bool 64BIT && MMU

[Severity: Medium]
As reported by Sashiko on v1 [1], will kho_reserve_bootmem() fail on 64-bit
RISC-V platforms where DRAM starts at or above 4 GiB, or record a 0-byte
region when all DRAM lies below 4 GiB?

Unlike arm64 (which defines ARCH_LOW_ADDRESS_LIMIT as arm64_dma_phys_limit =
- 1
and clamps it to memblock_end_of_DRAM() when DRAM starts above 4 GiB), RISC=
-V
falls back to the default in include/linux/memblock.h:

#ifndef ARCH_LOW_ADDRESS_LIMIT
#define ARCH_LOW_ADDRESS_LIMIT  0xffffffffUL
#endif

However, 64-bit RISC-V supports platforms where all DRAM starts at or above
4 GiB, as seen in arch/riscv/mm/init.c:arch_mm_preinit():

	bool swiotlb =3D max_pfn > PFN_DOWN(dma32_phys_limit) &&
		       memblock_start_of_DRAM() < dma32_phys_limit;

When KHO is enabled at boot, mm_core_init() -> kho_memory_init() ->
kho_reserve_bootmem() unconditionally allocates both lowmem and global boot=
mem
without checking whether their computed sizes in bootmem_size_update() are =
0:

kernel/liveupdate/kexec_handover.c:kho_reserve_bootmem() {
	...
	size =3D bootmem_size_lowmem;
	addr =3D memblock_phys_alloc_range(size, BOOTMEM_ALIGNMENT_BYTES, 0,
					 ARCH_LOW_ADDRESS_LIMIT);
	if (!addr) {
		pr_err("Failed to reserve lowmem bootmem\n");
		goto err_free_bootmem_desc;
	}

	kho_bootmem[i].addr =3D addr;
	kho_bootmem[i].size =3D size;
	i++;

	/* reserve large contiguous area for allocations without nid */
	size =3D bootmem_size_global;
	addr =3D memblock_phys_alloc(size, BOOTMEM_ALIGNMENT_BYTES);
	if (!addr) {
		pr_err("Failed to reserve global bootmem\n");
		goto err_free_bootmem_areas;
	}
	...
}

On 64-bit RISC-V systems where DRAM starts at or above 4 GiB,
bootmem_size_lowmem is 0 and memblock_phys_alloc_range(0, ..., 0,
ARCH_LOW_ADDRESS_LIMIT) finds no memory below 0xffffffffUL, returning 0 and
disabling KHO. Conversely, when all DRAM lies below 4 GiB, bootmem_size_glo=
bal
is 0 and kho_reserve_bootmem() records a 0-byte entry in kho_bootmem[], whi=
ch
later causes kho_locate_mem_hole() to construct an inverted struct resource
with end =3D start - 1.

[1] https://lore.kernel.org/r/sashiko-outbox-183678@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080926.2079=
-1-cp0613@linux.alibaba.com?part=3D3


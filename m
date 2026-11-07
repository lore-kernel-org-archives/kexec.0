Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36176606A32C
	for <kexec@archiver.kernel.org>; Sat,  7 Nov 2026 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fqyrDquQ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXOXgSf3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vzXZdhnaevFG7m6vfikATmsg/E5a/qIjqv85ia5RRoc=; b=fqyrDquQ7aRxje5HApUE0WVMSU
	X4d98oStxtFM9m258R6rZagCc9qmV2vegFOFonHzHgsJTBnLI1wu+9GdNPJLKOyZGZNwRGtaBhNJI
	587qT8xAi3eWMFxgbiRy1JWRweZj9ldQsgJV1Cmsdi6B9RxvDurJW8/M42Ig0HNmuG/KiZOQw7DqV
	zwh17eBXGNfkkh1BbBNNlGMo62bTe5bTBxsNGSnY1nCiiUfFu9aBWcGEqQBxysZhmF4OQFUFTtldq
	MdZ7o+bx94faG59K5+CuU91UAIYnt4w8ikYBv3eaV3F8EqhNsaZAOx8rDRdrwkfurG9VzN93gHJ70
	JNMsei0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPaeK-0000000EIxN-1ovN;
	Sat, 07 Nov 2026 07:15:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPaeF-0000000EIwY-1kmV
	for kexec@lists.infradead.org;
	Sat, 07 Nov 2026 07:15:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C9FAE437A3;
	Sat,  7 Nov 2026 07:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2352A1F0089F;
	Sat,  7 Nov 2026 07:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794035734;
	bh=vzXZdhnaevFG7m6vfikATmsg/E5a/qIjqv85ia5RRoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lXOXgSf3CTPIOLuzygqugyz/m3Kblgh8MJs48+8iMsrQjzG/qreHEh6jO47pbs2re
	 3Uurw9Fnc9zQFse+AdXIM57kpmzdsdr1ooxzZqIvRiCYXeJlt07zQ8jYqlkv8E8OLB
	 BUay2w1iDEsNeXgnApmBVX/YkfaRTnV5iO8RYzy2pKRTix0uDbT98nUisN3fax9Vm9
	 AWVEq0WetPaNznRKVC8P1r3D+YP4JRnSVN+EpNFOKu1I600ottqeNwplAml/t5VSHC
	 N0BsVidOkEyx3RLTv4wvcJq0/hAHxAWeZytzszlFcTY2vEhrcSIW2Q919aFyhUE1q/
	 R2sd0rh6zc5tw==
Message-ID: <sashiko-outbox-202683@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] riscv: Add support for kexec handover (KHO)
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org
In-Reply-To: <20261106071459.2003-3-cp0613@linux.alibaba.com>
References: <20261106071459.2003-1-cp0613@linux.alibaba.com>
 <20261106071459.2003-3-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 07:15:33 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] riscv: kho: BUG_ON() in linear_mapping_pa_to_va() during
  efi_init()
- [Medium] riscv: kho: kho_reserve_bootmem() fails when DRAM starts at
  or above 4 GiB
--

commit 9359adbe095f746cadb4028ea618b75e0af09036
Author: Chen Pei <cp0613@linux.alibaba.com>

riscv: Add support for kexec handover (KHO)

This commit enables ARCH_SUPPORTS_KEXEC_HANDOVER on 64-bit RISC-V systems
with MMU support.

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bde1f1885038f..bffef6b903e13 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -1125,6 +1125,9 @@ config ARCH_SELECTS_KEXEC_FILE
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
>  	def_bool ARCH_SUPPORTS_KEXEC_FILE
> =20
> +config ARCH_SUPPORTS_KEXEC_HANDOVER
> +	def_bool 64BIT && MMU
> +
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y

[Severity: High]
Does enabling KEXEC_HANDOVER here hit BUG_ON(!kernel_map.va_pa_offset) in
linear_mapping_pa_to_va() during early boot on UEFI systems with
CONFIG_DEBUG_VIRTUAL=3Dy?

In setup_arch(), parse_dtb() populates kho_in.fdt_phys, and then
efi_init() runs before paging_init():

arch/riscv/kernel/setup.c:setup_arch() {
    ...
	parse_dtb();
    ...
	efi_init();
	paging_init();
    ...
}

efi_init() -> reserve_regions() -> is_kho_boot() -> kho_get_fdt() calls
phys_to_virt(kho_in.fdt_phys), which translates to __va() ->
linear_mapping_pa_to_va().  On 64-bit RISC-V, kernel_map.va_pa_offset is
still 0 at that point because it is not initialized until paging_init() ->
setup_bootmem().

[Severity: Medium]
Can kho_reserve_bootmem() fail on 64-bit RISC-V systems where DRAM starts
at or above 4 GiB?

RISC-V does not define ARCH_LOW_ADDRESS_LIMIT, so it defaults to
0xffffffffUL in include/linux/memblock.h.  When all DRAM starts at or
above 4 GiB, bootmem_size_update() sets bootmem_size_lowmem to 0, and
kho_reserve_bootmem() unconditionally calls memblock_phys_alloc_range()
below ARCH_LOW_ADDRESS_LIMIT:

kernel/liveupdate/kexec_handover.c:kho_reserve_bootmem() {
    ...
	size =3D bootmem_size_lowmem;
	addr =3D memblock_phys_alloc_range(size, BOOTMEM_ALIGNMENT_BYTES, 0,
					 ARCH_LOW_ADDRESS_LIMIT);
	if (!addr) {
		pr_err("Failed to reserve lowmem bootmem\n");
		goto err_free_bootmem_desc;
	}
    ...
}

Because no memory exists below 4 GiB, the allocation returns 0 and aborts
KHO initialization.  Conversely, when all DRAM lies below 4 GiB,
bootmem_size_global is 0 and kho_reserve_bootmem() records a 0-byte entry
in kho_bootmem[], which causes kho_walk_bootmem() to build an inverted
struct resource with end =3D start - 1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106071459.2003=
-1-cp0613@linux.alibaba.com?part=3D2


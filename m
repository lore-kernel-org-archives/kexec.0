Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE062606A31E
	for <kexec@archiver.kernel.org>; Sat, 24 Oct 2026 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0zZniJMt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LeUcH5/C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/Zbp6hwg8Ccxg77Nh+HU8tqPsmnjtWe7rjEvXgWG/LM=; b=0zZniJMtI+gO8qx+8Da68ipogM
	AEBAob/Fk8uDsRS7Cz3A/6u1uqe1Vc2DJeEvAKcM5Do5+Am5Ibtf9CwuW/arwj4VqeRyQGVJV5qBT
	6bjL7kJTu8+HmRBTDGwYXcM1PZwLHoFPP7GzNdI8W+7mYAvcrIixr3lojpKXgyJTqY+PaMET5RY7+
	jI0EpRdbUuYnQsT3WoXJin2yyqL6Z5YRbZUlL6d0K4UtKio58Y+MD7TOwrMZpTUHgrlgTIqoNiE+I
	KF5Fz0+V29IhVveJ6oddCU7isRTdd9cZEqrRpPifMKVgCEtJ/XNtYID/r9UPFwXfm9CCJoCNJmqw5
	gKWGRqEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKZjs-000000007i9-1nni;
	Sat, 24 Oct 2026 11:16:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKZjq-000000007hf-24eV
	for kexec@lists.infradead.org;
	Sat, 24 Oct 2026 11:16:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9E3B660A52;
	Sat, 24 Oct 2026 11:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9841F01825;
	Sat, 24 Oct 2026 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792840597;
	bh=/Zbp6hwg8Ccxg77Nh+HU8tqPsmnjtWe7rjEvXgWG/LM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LeUcH5/CLGo+IP45EjHeSOa7VZVNrX1SXGxpUAEPredzfGIiMjCwjvKPKBSRZUj9/
	 z98zDrgFPA7+kOC6k+qlrMUld3wcbZWs4VaUQ/r+qE1GJ2ZSF3JAHN4VAiGVuWmhmC
	 mCMfRzdUxBsxLZpvvkLxXpEvpwdQNYjhcrPELDlhuRxVvi6mkayL37k0MW4ZBjDM/Q
	 RcfftQuBRLyNw5gj8NXfWnH95oC1rpemluxTgrECQaF7xVabkaIDbRx2V84lMDAzVt
	 HaRHITxX5WS+Ed4ZG3L39CYx4HWk5/wxQ2Q4gk1flUUcpynZoIUMrnL6hHfOpHPii/
	 lW7vrYJHzK5ZQ==
Message-ID: <sashiko-outbox-183678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] riscv: Add support for kexec handover (KHO)
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org
In-Reply-To: <20261023111612.2134-3-cp0613@linux.alibaba.com>
References: <20261023111612.2134-1-cp0613@linux.alibaba.com>
 <20261023111612.2134-3-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 11:16:36 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] riscv: kho: BUG_ON() in linear_mapping_pa_to_va() during efi_init()
- [Medium] riscv: kho: bootmem reservation fails when DRAM starts at or abo=
ve 4 GiB
--

commit 82f9788fea5dca057c5c8476c422bb40724521df
Author: Chen Pei <cp0613@linux.alibaba.com>

riscv: Add support for kexec handover (KHO)

This commit enables ARCH_SUPPORTS_KEXEC_HANDOVER on 64-bit RISC-V systems
with MMU support so that kexec handover (KHO) can be used on RISC-V.

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e7891a2a89da6..a5c56252ff44a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -1125,6 +1125,9 @@ config ARCH_SELECTS_KEXEC_FILE
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
>  	def_bool ARCH_SUPPORTS_KEXEC_FILE
> =20
> +config ARCH_SUPPORTS_KEXEC_HANDOVER
> +	def_bool 64BIT && MMU

[Severity: High]
Can enabling ARCH_SUPPORTS_KEXEC_HANDOVER trigger a BUG_ON() in
linear_mapping_pa_to_va() during efi_init() when booting a KHO kexec kernel
on a 64-bit RISC-V UEFI system?

In arch/riscv/kernel/setup.c:setup_arch(), parse_dtb() runs before
efi_init(), and efi_init() runs before paging_init():

    parse_dtb();
    setup_initial_init_mm(_stext, _etext, _edata, _end);

    *cmdline_p =3D boot_command_line;

    early_ioremap_setup();
    sbi_init();
    jump_label_init();
     parse_early_param();

    efi_init();
    paging_init();

During parse_dtb(), early_init_dt_scan() -> early_init_dt_check_kho() ->
kho_populate() sets kho_in.fdt_phys to the physical address of the handover
FDT.

Next, efi_init() -> reserve_regions() in drivers/firmware/efi/efi-init.c
checks is_kho_boot(), which calls kho_get_fdt() in
kernel/liveupdate/kexec_handover.c:

    static const void *kho_get_fdt(void)
    {
            return kho_in.fdt_phys ? phys_to_virt(kho_in.fdt_phys) : NULL;
    }

However, on 64-bit RISC-V, kernel_map.va_pa_offset is initialized to 0UL in
setup_vm() and is not populated until paging_init() -> setup_bootmem() in
arch/riscv/mm/init.c:

    /*
     * In 64-bit, any use of __va/__pa before this point is wrong as we
     * did not know the start of DRAM before.
     */
    if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_MMU))
            kernel_map.va_pa_offset =3D PAGE_OFFSET - phys_ram_base;

When CONFIG_DEBUG_VIRTUAL=3Dy is enabled, calling phys_to_virt(kho_in.fdt_p=
hys)
before setup_bootmem() reaches linear_mapping_pa_to_va() in
arch/riscv/mm/physaddr.c:

    void *linear_mapping_pa_to_va(unsigned long x)
    {
            BUG_ON(!kernel_map.va_pa_offset);

            return ((void *)((unsigned long)(x) + kernel_map.va_pa_offset));
    }

Would this panic the incoming kernel during efi_init() (or compute an
untranslated address in kho_get_fdt() when CONFIG_DEBUG_VIRTUAL=3Dn)?

[Severity: Medium]
Also, will kho_reserve_bootmem() fail on 64-bit RISC-V platforms where DRAM
starts at or above 4 GiB, or record a 0-byte region when all DRAM lies below
4 GiB?

Unlike arm64 (which defines ARCH_LOW_ADDRESS_LIMIT via arm64_dma_phys_limit=
),
RISC-V uses the default ARCH_LOW_ADDRESS_LIMIT of 0xffffffffUL from
include/linux/memblock.h, while arch_mm_preinit() in arch/riscv/mm/init.c
supports systems where memblock_start_of_DRAM() >=3D dma32_phys_limit (4 Gi=
B)
or max_pfn <=3D PFN_DOWN(dma32_phys_limit).

In kernel/liveupdate/kexec_handover.c:kho_reserve_bootmem(), both the lowmem
and global allocations are performed unconditionally without checking wheth=
er
bootmem_size_lowmem or bootmem_size_global is 0:

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

On systems where all DRAM starts at or above 4 GiB, bootmem_size_lowmem is 0
and memblock_phys_alloc_range(0, BOOTMEM_ALIGNMENT_BYTES, 0,
ARCH_LOW_ADDRESS_LIMIT) finds no memory below 0xffffffffUL, returning 0 and
disabling KHO. Conversely, on systems where all DRAM is below 4 GiB,
bootmem_size_global is 0 and memblock_phys_alloc(0, BOOTMEM_ALIGNMENT_BYTES)
records a 0-byte entry in kho_bootmem[].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023111612.2134=
-1-cp0613@linux.alibaba.com?part=3D2


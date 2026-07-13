Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18217C43458
	for <kexec@archiver.kernel.org>; Mon, 13 Jul 2026 13:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1JZ+jUbgiNbISG81jCDR/cTHkAMPJnKZyn2UCpJwgV4=; b=KsclNl8z714rOWT8hURsAOXWIE
	b10UIE7rKKKNepTE3x+enCaKD5yQwR8yyLN+V+llOn0D+DAzz+g+Emhie1EumKIQpd/P+Lkxd0Mvk
	42fkCWqhiFZ4LHC22vatejrP1OBuSybyXi/Mk2A/Ir/vuvkah7+jNEtC4qqucsG3v6IK/e+mUYPAy
	bhDQLcQwkmaC1qQujnjXnuwsy510X8/bu56ZnHqfo0YAdkLGUJCOVOR9uR48bqEjkhLgqyjN7oPYY
	vSaUScTJbb8UE+rHeR7rAHBe6K5jnqPGooJ3DA2x+T0lSuJ+B+wsvbJZKxlA03u3Q7H840gFaRQa4
	bJm6MXPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjH64-00000009Saz-1Y1B;
	Mon, 13 Jul 2026 13:53:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjH62-00000009Sal-3hsQ
	for kexec@lists.infradead.org;
	Mon, 13 Jul 2026 13:53:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ECFD2600D8;
	Mon, 13 Jul 2026 13:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355461F000E9;
	Mon, 13 Jul 2026 13:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783950801;
	bh=1JZ+jUbgiNbISG81jCDR/cTHkAMPJnKZyn2UCpJwgV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MyCiIiJ4Z9PQMTe3vSTzQZjL3wKH3oq36AhbOGoKljo9Op8Y16arXocVLbzr5h8ss
	 u/Mp9/VNgcEY1+mLXvifJSjxQ7PlWOTiqsQaWARzohogCB2BMxl52A4LcnmuRENFy9
	 RnXgdT3fd7JOWjV0MPZI/0g4tCdPS3qaeQ3DuPdcRZIk2nqi6GS0f9GY5Ans2xY/1/
	 lcD5BVKPLq5vMStTF5bcK9GDjT6+XJYclDUKo6FcZpHlNoBOf3+Bzu+gEV0k/08+PV
	 KBDTWYDnUOJF2vfuHAczxsTQNf3Nf7UWXNhNLu7fu5RY+K+kdTNQRs8aUJUkVdzojM
	 7DOEsnr+LAerA==
From: Pratyush Yadav <pratyush@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: Huacai Chen <chenhuacai@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Shuah Khan <shuah@kernel.org>,  George Guo
 <guodongtai@kylinos.cn>,  WANG Xuerui <kernel@xen0n.name>,  Alexander Graf
 <graf@amazon.com>,  loongarch@lists.linux.dev,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org,  Kexin Liu
 <liukexin@kylinos.cn>
Subject: Re: [PATCH v3 1/3] LoongArch: kexec: add KHO support for FDT-based
In-Reply-To: <20260601093930.112758-1-dongtai.guo@linux.dev> (George Guo's
	message of "Mon, 1 Jun 2026 17:39:28 +0800")
References: <20260601092823.110362-1-dongtai.guo@linux.dev>
	<20260601093930.112758-1-dongtai.guo@linux.dev>
Date: Mon, 13 Jul 2026 15:53:17 +0200
Message-ID: <2vxzjyqzj8s2.fsf@kernel.org>
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

On Mon, Jun 01 2026, George Guo wrote:

> From: George Guo <guodongtai@kylinos.cn>
>
> Enable Kexec Handover (KHO) on LoongArch64 for FDT-based systems.
>
> - Kconfig: select ARCH_SUPPORTS_KEXEC_HANDOVER for CONFIG_64BIT
> - kexec.h: add fdt/fdt_mem fields to kimage_arch to hold the KHO FDT
>   kexec segment virtual and physical addresses
> - machine_kexec_file.c: add kho_load_fdt() which copies the running
>   kernel's FDT (initial_boot_params), appends linux,kho-fdt and
>   linux,kho-scratch properties to /chosen, and loads the result as a
>   kexec segment; called from load_other_segments().  Returns -EINVAL
>   when initial_boot_params is NULL (ACPI-only boot) since that path
>   requires separate handling.
> - machine_kexec.c: before jumping to the new kernel, update the
>   DEVICE_TREE_GUID entry in the EFI config table to point to the KHO
>   FDT segment so the second kernel finds it via efi_fdt_pointer() and
>   early_init_dt_check_kho() calls kho_populate()
>
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  arch/loongarch/Kconfig                     |   3 +
>  arch/loongarch/include/asm/kexec.h         |   4 +
>  arch/loongarch/kernel/machine_kexec.c      |  27 +++++
>  arch/loongarch/kernel/machine_kexec_file.c | 118 +++++++++++++++++++++
>  4 files changed, 152 insertions(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 606597da46b8..d494418545f5 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -684,6 +684,9 @@ config ARCH_SUPPORTS_KEXEC
>  config ARCH_SUPPORTS_KEXEC_FILE
>  	def_bool 64BIT
>  
> +config ARCH_SUPPORTS_KEXEC_HANDOVER
> +	def_bool 64BIT
> +
>  config ARCH_SELECTS_KEXEC_FILE
>  	def_bool 64BIT
>  	depends on KEXEC_FILE
> diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/asm/kexec.h
> index 209fa43222e1..adf54bfcdd49 100644
> --- a/arch/loongarch/include/asm/kexec.h
> +++ b/arch/loongarch/include/asm/kexec.h
> @@ -39,6 +39,10 @@ struct kimage_arch {
>  	unsigned long efi_boot;
>  	unsigned long cmdline_ptr;
>  	unsigned long systable_ptr;
> +#ifdef CONFIG_KEXEC_HANDOVER
> +	void *fdt;		/* virtual address of KHO FDT segment buffer */
> +	unsigned long fdt_mem;	/* physical address of KHO FDT segment */
> +#endif
>  };
>  
>  #ifdef CONFIG_KEXEC_FILE
> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
> index ad27fef098f1..98529c71d001 100644
> --- a/arch/loongarch/kernel/machine_kexec.c
> +++ b/arch/loongarch/kernel/machine_kexec.c
> @@ -6,6 +6,7 @@
>   */
>  #include <linux/compiler.h>
>  #include <linux/cpu.h>
> +#include <linux/efi.h>
>  #include <linux/kexec.h>
>  #include <linux/crash_dump.h>
>  #include <linux/delay.h>
> @@ -289,6 +290,32 @@ void machine_kexec(struct kimage *image)
>  	pr_notice("We will call new kernel at 0x%lx\n", start_addr);
>  	pr_notice("Bye ...\n");
>  
> +#ifdef CONFIG_KEXEC_HANDOVER
> +	/*
> +	 * Point the EFI FDTPTR config table entry at the modified FDT so the
> +	 * second kernel picks up the linux,kho-fdt and linux,kho-scratch
> +	 * properties via early_init_dt_check_kho().
> +	 */
> +	if (internal->fdt_mem) {
> +		/*
> +		 * FDT-based system: DEVICE_TREE_GUID already exists in the EFI
> +		 * config table; just update its pointer to our KHO FDT.
> +		 */
> +		efi_system_table_t *st =
> +			(efi_system_table_t *)TO_CACHE(systable_ptr);
> +		efi_config_table_t *ct =
> +			(efi_config_table_t *)TO_CACHE((unsigned long)st->tables);
> +		unsigned long i;
> +
> +		for (i = 0; i < st->nr_tables; i++) {
> +			if (!efi_guidcmp(ct[i].guid, DEVICE_TREE_GUID)) {
> +				ct[i].table = (void *)internal->fdt_mem;
> +				break;
> +			}
> +		}
> +	}
> +#endif

Honestly this and the ACPI stuff looks worse to me than what your
previous version did. Now I am not an expert on EFI and architecture
stuff, and know nothing about Loongarch, but to me this looks hacky and
I am not sure if it is doing the right thing.

I think you should get some alignment with Loongarch maintainers on what
the kexec boot protocol looks like. It looked odd to me, but if the
Loongarch maintainers are fine with using the kernel cmdline for
bootloader to pass data to the kernel, then I think we should go back to
that.

Huacai, do you have any thoughts? For KHO we essentially need a way for
the pre-kexec kernel to tell the post-kexec kernel about a blob of
memory that has some information it can use. For x86, we do that via
setup data. See arch/x86/include/uapi/asm/setup_data.h and struct
kho_data for example. On arm64, we use the boot FDT's /chosen node. See
kho_add_chosen() in drivers/of/kexec.c.

Ideally, all device tree platforms should use the FDT path. But
Loongarch also has ACPI only and I don't know what a good idea for that
is.

So, do you have any suggestions on where to best place a pointer to this
blob of data on Loongarch? v1 of this series put it in the kernel
commandline, but I found that odd and asked if it can be done via DT
instead. But to me, this code looks even more hacky.

> +
>  	/* Make reboot code buffer available to the boot CPU. */
>  	flush_cache_all();
>  
[...]

-- 
Regards,
Pratyush Yadav


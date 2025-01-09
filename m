Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A20E77197
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 16:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nsXcsmVYuVSj7qklpRx1pY2LQ7GC0raTrwhSEFt+lKY=; b=2FEhQTK1rPBRsN92K9dv3gddKH
	gCIWjoATQFUlW+5ptssuxDsAnfwMnPWjL5KXociplkrCcy9vqiDCqw0tTMwgjAQx8olhu2gY4X1jx
	/ozLz2gq35WsDBvEyFrVFe2DllRlvP2wjU0B8i1crvCSViIAOBbhWC8PPKiCOlPfWfz5RhaXNoztm
	G39gQFzYn9GYuGREhpcFK90CsOecNDb8tab8sMtYx42gGMeK08QnzDJo+CPypEQdZc4dWpxG0ipWk
	Mb+edBJX51dZBEo0A1YHcoqkazOq1U5UfHwCapCjuzSLIuN5dcfp2c3JPR9ZCo1jCZsTwLw16H+9P
	rDB+A/RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVvBu-0000000CdXD-3p3X;
	Thu, 09 Jan 2025 16:15:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVvBs-0000000CdW8-1nFQ
	for kexec@lists.infradead.org;
	Thu, 09 Jan 2025 16:15:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E8CDC5C5C8D
	for <kexec@lists.infradead.org>; Thu,  9 Jan 2025 16:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FE8C4CED6
	for <kexec@lists.infradead.org>; Thu,  9 Jan 2025 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439323;
	bh=qCtk5pfLZyjZcPyM6VJTEyV+PYMtmo6DSOVdTmKsAlI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZSzElXffYVnIjM2iuNOv26CfYNPXphh3xbTTCTyq8Hq1W8+OJWqH5BFNO7lhVKWbN
	 Fbdlmvs5FktY2yrKQCCoeXa9BhpUgCS+KIQra4rL5KXzt7wE9O4JHYHT1Jfyjy0dNe
	 KUxzlv1axsP8aWOtxKUsJs3dwifojpe+UFMF0cer3MoJwLDY1cx8QvzdZZCVrxXoKG
	 yLgJcN9kT5Z8kskDBxzhFGCadJKiUY9wnkEy+xIUkoTJE1gYeMN/VYgYKozLdPXcoy
	 uNm9m4/FhnR8rJ1t2TtPkAz6dhbqmvKvKNpVuM0nh2ZRvp+YYHEIp0kofMQhMipXjd
	 NuO/Ctn1PZHSA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401be44b58so1055952e87.0
        for <kexec@lists.infradead.org>; Thu, 09 Jan 2025 08:15:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+EPxZNV8T/XaUxuGkyyb0AgFOKwIRb0DPbKuMxEiWy1MhWFVNi7Ly0gnF0L0tNwTC45jJBg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyihMG4HNs+L0ypnRLiGwqHp49MU5nxaEdFDjt36uKD6qcxcnfD
	CD6L4dEgtxUIa1Qwm1TK7xR3lwtWwcSSbqrglGQR/pRWdKx4Hwif8IWYpgU2xVx/+1gQnpO3Zui
	SxtYb3A9MHLPgtKKlV1eKxmnu8V0=
X-Google-Smtp-Source: AGHT+IEgDc3Ath4/1uyTCs9JWOOHZZDwY9mK/b9amglFhjwS7HHJIIvUsHf0MoF/tIeatS4zttGxIxrfylS/16CHrcE=
X-Received: by 2002:a05:6512:304f:b0:540:2339:3761 with SMTP id
 2adb3069b0e04-542845d61e4mr2632246e87.31.1736439321978; Thu, 09 Jan 2025
 08:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com> <20250108215957.3437660-3-usamaarif642@gmail.com>
In-Reply-To: <20250108215957.3437660-3-usamaarif642@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 9 Jan 2025 17:15:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
X-Gm-Features: AbW1kvYuGkq4yLIfsQUdM5PMmU94RQMf4rX_EMMrLutlK12hhu_mxZhaeTrMs-4
Message-ID: <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	hannes@cmpxchg.org, dyoung@redhat.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_081524_554146_E4AEF8B8 
X-CRM114-Status: GOOD (  29.19  )
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

On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>
> When this area is not reserved, it comes up as usable in
> /sys/firmware/memmap. This means that kexec, which uses that memmap
> to find usable memory regions, can select the region where
> efi_mem_attr_table is and overwrite it and relocate_kernel.
>
> Since the patch in [1] was merged, all boots after kexec
> are producing the warning that it introduced.
>
> Having a fix in firmware can be difficult to get through.

I don't follow. I don't think there is anything wrong with the
firmware here. Could you elaborate?


> The next ideal place would be in libstub. However, it looks like
> InstallMemoryAttributesTable [2] is not available as a boot service
> call option [3], [4], and install_configuration_table does not
> seem to work as a valid substitute.
>

To do what, exactly?

> As a last option for a fix, this patch marks that region as reserved in
> e820_table_firmware if it is currently E820_TYPE_RAM so that kexec doesn't
> use it for kernel segments.
>
> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
> [2] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Core/Dxe/Misc/MemoryAttributesTable.c#L100
> [3] https://github.com/tianocore/edk2/blob/42a141800c0c26a09d2344e84a89ce4097a263ae/MdeModulePkg/Core/Dxe/DxeMain/DxeMain.c#L41
> [4] https://elixir.bootlin.com/linux/v6.12.6/source/drivers/firmware/efi/libstub/efistub.h#L327
>
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  arch/x86/include/asm/e820/api.h | 2 ++
>  arch/x86/kernel/e820.c          | 6 ++++++
>  arch/x86/platform/efi/efi.c     | 9 +++++++++
>  drivers/firmware/efi/memattr.c  | 1 +
>  include/linux/efi.h             | 7 +++++++
>  5 files changed, 25 insertions(+)
>
> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
> index 2e74a7f0e935..4e9aa24f03bd 100644
> --- a/arch/x86/include/asm/e820/api.h
> +++ b/arch/x86/include/asm/e820/api.h
> @@ -16,6 +16,8 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
>
>  extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
> +extern u64  e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
> +                                       enum e820_type new_type);
>  extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
>  extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 82b96ed9890a..01d7d3c0d299 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -538,6 +538,12 @@ u64 __init e820__range_update_table(struct e820_table *t, u64 start, u64 size,
>         return __e820__range_update(t, start, size, old_type, new_type);
>  }
>
> +u64 __init e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
> +                                      enum e820_type new_type)
> +{
> +       return __e820__range_update(e820_table_firmware, start, size, old_type, new_type);
> +}
> +
>  /* Remove a range of memory from the E820 table: */
>  u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
>  {
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index a7ff189421c3..13684c5d7c05 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -168,6 +168,15 @@ static void __init do_add_efi_memmap(void)
>         e820__update_table(e820_table);
>  }
>
> +/* Reserve firmware area if it was marked as RAM */
> +void arch_update_firmware_area(u64 addr, u64 size)
> +{
> +       if (e820__get_entry_type(addr, addr + size) == E820_TYPE_RAM) {
> +               e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +               e820__update_table(e820_table_firmware);
> +       }
> +}
> +
>  /*
>   * Given add_efi_memmap defaults to 0 and there is no alternative
>   * e820 mechanism for soft-reserved memory, import the full EFI memory
> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> index d3bc161361fb..d131781e2d7b 100644
> --- a/drivers/firmware/efi/memattr.c
> +++ b/drivers/firmware/efi/memattr.c
> @@ -53,6 +53,7 @@ int __init efi_memattr_init(void)
>         size = tbl->num_entries * tbl->desc_size;
>         tbl_size = sizeof(*tbl) + size;
>         memblock_reserve(efi_mem_attr_table, tbl_size);
> +       arch_update_firmware_area(efi_mem_attr_table, tbl_size);
>         set_bit(EFI_MEM_ATTR, &efi.flags);
>
>  unmap:
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index e5815867aba9..8eb9698bd6a4 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1358,4 +1358,11 @@ extern struct blocking_notifier_head efivar_ops_nh;
>  void efivars_generic_ops_register(void);
>  void efivars_generic_ops_unregister(void);
>
> +#ifdef CONFIG_X86_64
> +void __init arch_update_firmware_area(u64 addr, u64 size);
> +#else
> +static inline void __init arch_update_firmware_area(u64 addr, u64 size)
> +{
> +}
> +#endif
>  #endif /* _LINUX_EFI_H */
> --
> 2.43.5
>


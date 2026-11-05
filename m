Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F41606A32E
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Nruj/xOa;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XFuaSYbA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1jOK42kEV/R7k8n51sIGLXDORmkNj62Y+kfJMXSo5Mc=; b=Nruj/xOaYAdv2frUJyW8pwlfDH
	pTmS6T4jx9sQBpvjuhaM8dVJzSX7ulMtLHMS5pju2Mt7cWHJtUvApmdcgN3FBJma2euGI/7xsuDYp
	f5lzZNYLhWwBLuHJ3FZzwidb1NTE8V5KzTZMBEP1VC00tyOZMmM3XUWdnmVaI/nbCWrVraWiXrRwv
	UVJcpBATf951tYOPHQ7EmNEKq91cmBTFcMcEUEGc1TVueDjmz1+iRU/aYvfqUsImq1DJ31XYWIRlu
	8syw2N+ZOKrIPWgB8VnD2b9VF8n1HxBwwsaJWCmHjCJBXPJoF74+24UFB/Umu9C4oIa67LSk46F8p
	P/mdY27Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOxBP-000000094cH-0LHo;
	Thu, 05 Nov 2026 13:07:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOxBM-000000094bd-1xiB;
	Thu, 05 Nov 2026 13:07:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B70C960267;
	Thu,  5 Nov 2026 13:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805411F000C1;
	Thu,  5 Nov 2026 13:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884027;
	bh=1jOK42kEV/R7k8n51sIGLXDORmkNj62Y+kfJMXSo5Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XFuaSYbAn6Wzfg2xYzR2T2rOKC0XDbDYhBWedM5J/RUQvjbBWRjzNw4K4Dn/iQ0pF
	 dSQ+7RvtRYpBTa099A8orQ6Eoq0V5fe9WiOoUXLjtRgOgAQfU0xXOlZ0vTQXkEkXgu
	 KhEdHwOq6KB2VVmaJviQHb2UVnhjNnwRasKvHuuLi/RCLBovWXTXG2Kzg30H2E/hBR
	 jaktqUPHCfXxQqnxAnd3VasCNIvl5thBnv+GSakC2ip8kbNsnxNBgqP9PzvcDFP+aR
	 ocLUpRelVHZhyx0N/goW4szRfWco2GGXiVwl+gLHV7g/U/TuyWb0AGwAN3fy0m7uJe
	 vaUjtb8+88F9Q==
Date: Thu, 5 Nov 2026 15:07:00 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr,
	pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com,
	shuah@kernel.org, guoren@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2 1/5] kho: Do not translate the handover FDT address in
 is_kho_boot()
Message-ID: <aux_dPnvXk3LYDxs@kernel.org>
References: <20261103080926.2079-1-cp0613@linux.alibaba.com>
 <20261103080926.2079-2-cp0613@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103080926.2079-2-cp0613@linux.alibaba.com>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chen,

On Tue, Nov 03, 2026 at 04:09:22PM +0800, Chen Pei wrote:
> is_kho_boot() only has to say whether a handover FDT was recorded, but
> it asks kho_get_fdt() for one and so converts kho_in.fdt_phys with
> phys_to_virt() just to throw the pointer away. Both callers use it as a
> boolean and never dereference the result.
> 
> On riscv64 that conversion is not valid yet when efi_init() reaches it:
> setup_vm() leaves kernel_map.va_pa_offset at 0 and setup_bootmem()
> assigns it later, so a handover boot that came through UEFI panics in
> linear_mapping_pa_to_va(). Only debug builds fail -- without
> CONFIG_DEBUG_VIRTUAL __va() degenerates to "phys + 0" and the boolean
> stays correct -- but the panic also goes unnoticed without an earlycon.
> 
> Check the physical address instead. Nothing needs the translation, and
> architectures stay free to bring their linear mapping up whenever they
> like.
> 
> Fixes: d6d511639185 ("kexec: introduce is_kho_boot()")
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---

There was very similar patch: 

https://lore.kernel.org/all/20261023054518.3258350-1-gthelen@google.com

and while both Greg's and your patch are correct they both have that wall
of text with too many details commit messages that I don't like.
 
> Tested on qemu-system-riscv64 (virt, -cpu max, TCG): edk2
> RISCV_VIRT_CODE.fd/VARS.fd on pflash with OpenSBI fw_dynamic.bin below
> it, and a GPT disk holding an ESP with grub plus the kernel and an ext4
> partition as rootfs.  Kernel config is riscv defconfig plus
> DEBUG_KERNEL, DEBUG_VIRTUAL, KEXEC_FILE, KEXEC_HANDOVER and the kho
> selftest fragment; the outgoing kernel gets "kho=on" and the kho
> selftest init does kexec_file_load() followed by reboot(RB_KEXEC).
> 
> Before, the first handover panics.  earlycon= is needed to see it: the
> BUG precedes console registration, so without an earlycon the machine
> goes silent right after kexec.
> 
>   KHO: found kexec handover data.
>   efi: EFI v2.7 by EDK II
>   kernel BUG at arch/riscv/mm/physaddr.c:47!
>   epc : linear_mapping_pa_to_va+0x1c/0x1e
>    ra : is_kho_boot+0x18/0x28
> 
> After, the same setup keeps handing over until the window closes, 29
> consecutive boots and no BUG.
> 
>   KHO: found kexec handover data.
>   KHO: exec from: 7.4.0-rc1-next-20261102-00005-gfca49e548231 (count 29)
> 
>  kernel/liveupdate/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 6f1f55fe3181..6ab181de345c 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1643,7 +1643,7 @@ EXPORT_SYMBOL_GPL(kho_restore_free);
>   */
>  bool is_kho_boot(void)
>  {
> -	return !!kho_get_fdt();
> +	return kho_in.fdt_phys != 0;
>  }
>  EXPORT_SYMBOL_GPL(is_kho_boot);
>  
> -- 
> 2.50.1
> 

-- 
Sincerely yours,
Mike.


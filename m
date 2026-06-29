Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267A6C43327
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 14:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TsWICWmCbFgOrwIgQkr26i3mCTVFW8ZK2mjI3gYPCOc=; b=CpnaDPRdyfOREq7Tv4TA+ZMWlR
	s6CPd6z5B6i2V5ZBFietNSLi11tfNMcI2pU7a31iSY6/1pbgxA8CsxbpcXitIH79svT/ecFGrhABl
	ofyWoUGFCJ+8AdBydJD0OEXGgjnzVEiR9giw9N0RmJk/Xl5etRCDMWF+9rzPVDgyZHAj0mI8WJx87
	bI2beRj38GSKWQcU+I+KCgmTAEm6Vq2WmYPt0z2aVnu4BPvGAm6Nfd9DiT7F0y+D9VJcMMCDxitMV
	ORYrXRbyNbBq+DycVFIsFpUPgKucOdVECUTir0EwKmqsVYBShTiG/z2k9NNblrUUbOJM6OyKU+mbW
	KW6OPSKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weCdM-0000000Epmr-13Vt;
	Mon, 29 Jun 2026 14:06:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weCdL-0000000EpmP-01pN
	for kexec@lists.infradead.org;
	Mon, 29 Jun 2026 14:06:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BD9676001D
	for <kexec@lists.infradead.org>; Mon, 29 Jun 2026 14:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BFC1F00A3A
	for <kexec@lists.infradead.org>; Mon, 29 Jun 2026 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782742004;
	bh=TsWICWmCbFgOrwIgQkr26i3mCTVFW8ZK2mjI3gYPCOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=buQkPgzWyFJqQ7Y66P7XHlSFzIw99omalCsFi03WEotCt0tnCcyYXQl1t6QAimkla
	 IB0LPW0rooXODndOLkrcI8Pzy7QEYx5eHxPZosBrn2tKk2rM7D38cqquelJYEmmqZ0
	 uNjYOdvO+ighyOK4Y2b69LVupHl2mnSOa9Xqj06voGMjdNa18RN/tpXl+ttS/e4UwZ
	 MBn037Bl3QovNQ0SnKoGN1QLZuR0C4m/WE7oGf0N9Obc4YAPpMRmtoEyxfx8HblaQW
	 eu0w5AGlbnZ9rWrt20URLAjkzACd8+bhj+jfbKSxr5EB231OD0Sl9RXZF0yLUfaj/Y
	 /6mMtLR3A5Vow==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so5821343a12.2
        for <kexec@lists.infradead.org>; Mon, 29 Jun 2026 07:06:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqxre18AWyeQKovkWS1icU1gzYEh6PIqjzGMYmTLOgphzjKu37N0edHRGfzXyK3n3K/SjtPcA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzDvvrS4tZgMSzRmEytnhZAXCPwlqXiEXiDZ0RMCfdrK/3LMZrJ
	EwG+Ur992VvZVX/R49l9TvnLEUfyV8zc84LiH/oxdKJ9PXZOG1SW3aJgn3KD/q4R+tIV03R0tr6
	CWaOx3Ca33HzXIOTSV/5Z392SPp3whmw=
X-Received: by 2002:a05:6402:1941:b0:697:fc6b:10c2 with SMTP id
 4fb4d7f45d1cf-69836541a48mr4573055a12.16.1782742003131; Mon, 29 Jun 2026
 07:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260604114106.391502-1-dongtai.guo@linux.dev>
In-Reply-To: <20260604114106.391502-1-dongtai.guo@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 29 Jun 2026 22:06:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7JBakFFEhRCe=KHPCHLmQYmqaXN7dv8DzLCUJ2pEe8=g@mail.gmail.com>
X-Gm-Features: AVVi8CcPUW9BdyuDm2g4t8sg63P9dez3lhyd5K8WSCVo5tjNvVay-mEGd7YVPIg
Message-ID: <CAAhV-H7JBakFFEhRCe=KHPCHLmQYmqaXN7dv8DzLCUJ2pEe8=g@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: kexec: use core control page for relocation
 trampoline to avoid QEMU FDT conflict
To: George Guo <dongtai.guo@linux.dev>
Cc: maobibo@loongson.cn, loongarch@lists.linux.dev, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi, George,

On Thu, Jun 4, 2026 at 7:41=E2=80=AFPM George Guo <dongtai.guo@linux.dev> w=
rote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> KEXEC_CONTROL_CODE was hardcoded to TO_CACHE(0x100000).  QEMU places its
> machine FDT at physical 0x100000 when booting with '-kernel', so
> machine_kexec_prepare() overwrote the FDT with the relocation trampoline.
> The kexec'd kernel's fdt_setup() then read trampoline code instead of a
> valid FDT, earlycon auto-detection failed, and the second kernel booted
> silently with no console output.
>
> The trampoline does not need a fixed address.  It is executed by the
> current kernel to relocate and enter the new kernel, and is dead once the
> new kernel starts.  Drop KEXEC_CONTROL_CODE and reuse the
> control_code_page that the kexec core already allocates (as arm64 and
> riscv do).  That page is excluded from the relocation copy and lives
> nowhere near 0x100000, so the QEMU FDT is left intact.
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
> Changes in v3:
> - Only the relocation trampoline is moved off the hardcoded address onto
>   the core-allocated control_code_page.  v2 also moved the kernel command
>   line to a kexec control page, but as Huacai pointed out a control page
>   only avoids being clobbered by the relocation copy in the current
>   kernel; it is not reserved in the new kernel, which reads the command
>   line early in boot.  The command line therefore stays at the existing
>   fixed KEXEC_CMDLINE_ADDR in the reserved first 2MB (unchanged).
Then how to avoid the cmdline overlapping FDT, and how to avoid the
control page being corrupted by the new kernel?

Huacai

>
> Changes in v2:
> - Instead of moving KEXEC_CONTROL_CODE to a different fixed address, reus=
e
>   the kexec core's control_code_page for the trampoline.
>
> v2: https://lore.kernel.org/all/20260601033820.38805-1-dongtai.guo@linux.=
dev/
> v1: https://lore.kernel.org/all/20260528135828.196953-1-dongtai.guo@linux=
.dev/
>
>  arch/loongarch/kernel/machine_kexec.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kerne=
l/machine_kexec.c
> index d7fafda1d541..3527da57234d 100644
> --- a/arch/loongarch/kernel/machine_kexec.c
> +++ b/arch/loongarch/kernel/machine_kexec.c
> @@ -21,8 +21,14 @@
>  #include <asm/cacheflush.h>
>  #include <asm/page.h>
>
> -/* 0x100000 ~ 0x200000 is safe */
> -#define KEXEC_CONTROL_CODE     TO_CACHE(0x100000UL)
> +/*
> + * The kexec'd kernel reads its command line from this pointer early in
> + * boot, so the command line must live in memory the new kernel will not
> + * reuse.  Keep it at a fixed address in the first 2MB, which both the
> + * current and the kexec'd kernel always keep reserved (see
> + * memblock_reserve(PHYS_OFFSET, 0x200000) in arch/loongarch/kernel/mem.=
c).
> + * 0x108000 does not overlap QEMU's machine FDT at 0x100000.
> + */
>  #define KEXEC_CMDLINE_ADDR     TO_CACHE(0x108000UL)
>
>  static unsigned long reboot_code_buffer;
> @@ -72,9 +78,14 @@ int machine_kexec_prepare(struct kimage *kimage)
>                 }
>         }
>
> -       /* kexec/kdump need a safe page to save reboot_code_buffer */
> -       kimage->control_code_page =3D virt_to_page((void *)KEXEC_CONTROL_=
CODE);
> -
> +       /*
> +        * kexec/kdump need a safe page to save reboot_code_buffer.  Reus=
e the
> +        * control_code_page allocated by the kexec core (as arm64 and ri=
scv
> +        * do) instead of a fixed address: the trampoline is only execute=
d by
> +        * the current kernel before entering the new kernel, so it needs=
 no
> +        * fixed or reserved location.  This also stops machine_kexec_pre=
pare()
> +        * from overwriting QEMU's machine FDT at 0x100000.
> +        */
>         reboot_code_buffer =3D (unsigned long)page_address(kimage->contro=
l_code_page);
>         memcpy((void *)reboot_code_buffer, relocate_new_kernel, relocate_=
new_kernel_size);
>
> --
> 2.25.1
>


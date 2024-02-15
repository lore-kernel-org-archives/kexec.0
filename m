Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A15C4829E
	for <kexec@archiver.kernel.org>; Thu, 15 Feb 2024 07:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lsnbs7ZysN2w10P5ZWOA7zyU2Edn7Dgaa02kSMpGgww=; b=S9qzEEhvh9E+WL
	ufGof4KAgK5/o70XO67aSQN9TP+/BgcsNHTYY6aHbyEJSfMyiTNTSAJW/POetPU3Qr4f0MLdjOq07
	30M3oy7X9RXVhp5roUD7f6ZCRyIGZ9h4zTi+u++PidS+tYOuWKvbaSlktwIu4V4fodPGSSCzNG9Ze
	LDjedV6rRkdZ5gPTHCFDGNuBMnpI2FbAhNXzdTZ1meV9qgn85WpEhIR/Vd/ntm+zMhPOTO6vWZLiM
	ezxRJ2cvdZTsxEinei2iNA+Dh686LcbEN08XKoz6XhRkTwAFUu+teo219s0KnM7DwdGHx17/rrLVW
	u56Rc8zH/R8/PzF7EfAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raWbr-0000000FH9H-1ipz;
	Thu, 15 Feb 2024 07:56:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raWbo-0000000FH8f-0eAo
	for kexec@lists.infradead.org;
	Thu, 15 Feb 2024 07:56:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A5F9961C9C
	for <kexec@lists.infradead.org>; Thu, 15 Feb 2024 07:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF63CC4166B
	for <kexec@lists.infradead.org>; Thu, 15 Feb 2024 07:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707983798;
	bh=xfCSlQh3j9vziRPtoUADhlf5DGySWnxhTzmYirfEjQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dv+0mG+Cl9GeB0FTjPzOM3gI5demZy+pHuklwpTeWX9PHyM5hxNMa39Viqa7xglJX
	 AlkrOoDtYApixFgEZnN3tVpM6dzkB1H4gQOZVP2Wq7psPyHnhbQth19w9KXyluENcn
	 jgiSJDDuVgyR54gj6VEhj4niffZDsywBBSerIIbnpLdSzZzcpURfVe4URlvBdNCIdz
	 4YaTcJyzMNaoRyAs+8jU24i2ZrEdyal4CGLKbfnEA+5Qzu++ixaE2Fa0WinwWlMuTG
	 wQnec8rXuPUCepgbz6k8nwm1SLUm9EmF3XMa3UPB4i+kZtMU0JIHulStOI/zhqPZP5
	 z9rZrYs9tgSQA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51187830d6dso605332e87.3
        for <kexec@lists.infradead.org>; Wed, 14 Feb 2024 23:56:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUod1mMQ01DhOrWItChYhclkVIvcenPKtLJlSG6r6aowASE/u4w8R9kmvDlrZCHBmq2N6vBLjTu3GE+Iq1T9jwmI3KEOG9xKjwy
X-Gm-Message-State: AOJu0YyYMn8bq+1UxwdUX71ZH8Hgk1Go3twhW4jH9NlPifBTAttZOyOq
	OgtqyjQeG6TCVBEQR004b+Wz8rzHo/2rz8z5SatiwzuqA0blbS3/aibhdQ5e2WaB2022J0y81dN
	S2LpQZPmtsphImmX7k8qS68I8uRc=
X-Google-Smtp-Source: AGHT+IFA6RWY4UG2hD5HrcveuMn0XzIXulhltm/OPlLpFX1tCGIskA3QzenmIrMy2g42ftRPvNAHNHzec8Ze0zvC/P8=
X-Received: by 2002:ac2:43cd:0:b0:512:87a2:adf6 with SMTP id
 u13-20020ac243cd000000b0051287a2adf6mr528637lfl.22.1707983796842; Wed, 14 Feb
 2024 23:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-2-ross.philipson@oracle.com>
In-Reply-To: <20240214221847.2066632-2-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 08:56:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com>
Message-ID: <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com>
Subject: Re: [PATCH v8 01/15] x86/boot: Place kernel_info at a fixed offset
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_235640_310896_069C78B3 
X-CRM114-Status: GOOD (  34.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> From: Arvind Sankar <nivedita@alum.mit.edu>
>
> There are use cases for storing the offset of a symbol in kernel_info.
> For example, the trenchboot series [0] needs to store the offset of the
> Measured Launch Environment header in kernel_info.
>

Why? Is this information consumed by the bootloader?

I'd like to get away from x86 specific hacks for boot code and boot
images, so I would like to explore if we can avoid kernel_info, or at
least expose it in a generic way. We might just add a 32-bit offset
somewhere in the first 64 bytes of the bootable image: this could
co-exist with EFI bootable images, and can be implemented on arm64,
RISC-V and LoongArch as well.

> Since commit (note: commit ID from tip/master)
>
> commit 527afc212231 ("x86/boot: Check that there are no run-time relocations")
>
> run-time relocations are not allowed in the compressed kernel, so simply
> using the symbol in kernel_info, as
>
>         .long   symbol
>
> will cause a linker error because this is not position-independent.
>
> With kernel_info being a separate object file and in a different section
> from startup_32, there is no way to calculate the offset of a symbol
> from the start of the image in a position-independent way.
>
> To enable such use cases, put kernel_info into its own section which is
> placed at a predetermined offset (KERNEL_INFO_OFFSET) via the linker
> script. This will allow calculating the symbol offset in a
> position-independent way, by adding the offset from the start of
> kernel_info to KERNEL_INFO_OFFSET.
>
> Ensure that kernel_info is aligned, and use the SYM_DATA.* macros
> instead of bare labels. This stores the size of the kernel_info
> structure in the ELF symbol table.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Ross Philipson <ross.philipson@oracle.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/boot/compressed/kernel_info.S | 19 +++++++++++++++----
>  arch/x86/boot/compressed/kernel_info.h | 12 ++++++++++++
>  arch/x86/boot/compressed/vmlinux.lds.S |  6 ++++++
>  3 files changed, 33 insertions(+), 4 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/kernel_info.h
>
> diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
> index f818ee8fba38..c18f07181dd5 100644
> --- a/arch/x86/boot/compressed/kernel_info.S
> +++ b/arch/x86/boot/compressed/kernel_info.S
> @@ -1,12 +1,23 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>
> +#include <linux/linkage.h>
>  #include <asm/bootparam.h>
> +#include "kernel_info.h"
>
> -       .section ".rodata.kernel_info", "a"
> +/*
> + * If a field needs to hold the offset of a symbol from the start
> + * of the image, use the macro below, eg
> + *     .long   rva(symbol)
> + * This will avoid creating run-time relocations, which are not
> + * allowed in the compressed kernel.
> + */
> +
> +#define rva(X) (((X) - kernel_info) + KERNEL_INFO_OFFSET)
>
> -       .global kernel_info
> +       .section ".rodata.kernel_info", "a"
>
> -kernel_info:
> +       .balign 16
> +SYM_DATA_START(kernel_info)
>         /* Header, Linux top (structure). */
>         .ascii  "LToP"
>         /* Size. */
> @@ -19,4 +30,4 @@ kernel_info:
>
>  kernel_info_var_len_data:
>         /* Empty for time being... */
> -kernel_info_end:
> +SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
> diff --git a/arch/x86/boot/compressed/kernel_info.h b/arch/x86/boot/compressed/kernel_info.h
> new file mode 100644
> index 000000000000..c127f84aec63
> --- /dev/null
> +++ b/arch/x86/boot/compressed/kernel_info.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef BOOT_COMPRESSED_KERNEL_INFO_H
> +#define BOOT_COMPRESSED_KERNEL_INFO_H
> +
> +#ifdef CONFIG_X86_64
> +#define KERNEL_INFO_OFFSET 0x500
> +#else /* 32-bit */
> +#define KERNEL_INFO_OFFSET 0x100
> +#endif
> +
> +#endif /* BOOT_COMPRESSED_KERNEL_INFO_H */
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 083ec6d7722a..718c52f3f1e6 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -7,6 +7,7 @@ OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
>
>  #include <asm/cache.h>
>  #include <asm/page_types.h>
> +#include "kernel_info.h"
>
>  #ifdef CONFIG_X86_64
>  OUTPUT_ARCH(i386:x86-64)
> @@ -27,6 +28,11 @@ SECTIONS
>                 HEAD_TEXT
>                 _ehead = . ;
>         }
> +       .rodata.kernel_info KERNEL_INFO_OFFSET : {
> +               *(.rodata.kernel_info)
> +       }
> +       ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
> +
>         .rodata..compressed : {
>                 *(.rodata..compressed)
>         }
> --
> 2.39.3
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

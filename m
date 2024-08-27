Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213E5C54735
	for <kexec@archiver.kernel.org>; Tue, 27 Aug 2024 10:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZIx31D6l42/gkQU+8lE8UIM0FtTRGmy3hk8pE7zJPHU=; b=TrmOcWzzkUhV/F
	rs/nE9zomt9B4OoSVJqM83U7g0ct6zf1kNS9xp2HYv5bfWgfG5Uesgb1zkKpR8GZQDqeWU9xgaGmU
	0yEPp8z/Cox0cgprndo01pa5C2FtNlFjb+eutBofYf8SIu00zhDnW/XJoQo4Yv740KK19V5/eCe4Q
	rrsgFsxBPctR3vZQYVB7LhMbXkXbOaClGi+dy2mqokKJ6LiJ6M+5VXnJKNqhLzGRriQEeXxrRNRam
	pMZu9f7Fr8XEEMV3CJ0Q8mGSjQDZ/Aj+JPE6Veda4MLS2QuWq+yna+vPN9jLNEOKIe2Mz6FHpVwrt
	viyM6Am9IADVgj8OxcNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sitSw-0000000AoTF-3DHe;
	Tue, 27 Aug 2024 10:30:22 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sitSt-0000000AoR8-3Za3
	for kexec@lists.infradead.org;
	Tue, 27 Aug 2024 10:30:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5072ECE1196
	for <kexec@lists.infradead.org>; Tue, 27 Aug 2024 10:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE41C8B7AA
	for <kexec@lists.infradead.org>; Tue, 27 Aug 2024 10:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724754613;
	bh=+g9xoCkYNp53kFgqB/xv9zVOr2LekqHj3NvYFP/LbgI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=muwGsXsCs+5oDw8h6m3kVAeJwH+4vqrsluVM+YV9jVC9b2KI1cPOry+W3f4LDXz70
	 0UGl1YKxwGX5cSZ4w53YRXRcaEQJCnQdX2fNxkKr7s9inaJK7qqvah2f3FKvihjTs8
	 y+0orJy3Iqxeqhl0DzNUE1pbvLeg2ar7ZB263ErtW32XjplFdHMX4TP19ed+z9rwq2
	 L/L8GRNOHKE3jDcfMyWy7Fx9uid3IuCUX++ZuQ9OMYoxHIbEOaNZjEwaRFV5dMgcay
	 0BPwBDoJJGZYDkVaGeUQIo97LiEu/IMzSQ4RezqNNtiYiKZoW97CAMu8cYMGbjPdJJ
	 1+X2IlloW49Qw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f3f90295a9so56938371fa.0
        for <kexec@lists.infradead.org>; Tue, 27 Aug 2024 03:30:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUT1a66Y4aSuiqd4ChSQQMQhCYufFHsBd2BBzxGSy/lWOTNPEx8DETw4ryTKKC79oTfFcYg6A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwNMpiKhJ14UwSf3CZqQVQT72d29rnKctPTi809HlTd22zeRd8m
	35Fo0uZEzzUG9KIBu87Q4dQ4btC9yCH/xbJIav7kQqdz0MTLtTYGQxarENaERdDp88w7aGMf6Ku
	HzGcMu4ao5hpGUUYJF3pRY2dsDcM=
X-Google-Smtp-Source: AGHT+IHkZQ1KnddghDNMKm850oN8OkL7VQ4mHclRlcVnbsvfr1cg7Nl96LUFIwu6PQVJKn87y1kakTQ21hDf2PiXD6o=
X-Received: by 2002:a05:6512:2812:b0:530:e323:b1ca with SMTP id
 2adb3069b0e04-534387850e7mr7594496e87.25.1724754611868; Tue, 27 Aug 2024
 03:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240826223835.3928819-1-ross.philipson@oracle.com> <20240826223835.3928819-9-ross.philipson@oracle.com>
In-Reply-To: <20240826223835.3928819-9-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Aug 2024 12:29:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGMMsB6BMAC9eWd2gKdEHHXGCLTXjavAK70dCz=-OyJug@mail.gmail.com>
Message-ID: <CAMj1kXGMMsB6BMAC9eWd2gKdEHHXGCLTXjavAK70dCz=-OyJug@mail.gmail.com>
Subject: Re: [PATCH v10 08/20] x86/boot: Place TXT MLE header in the
 kernel_info section
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_033020_247312_E100D885 
X-CRM114-Status: GOOD (  27.87  )
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

On Tue, 27 Aug 2024 at 00:42, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> The MLE (measured launch environment) header must be locatable by the
> boot loader and TXT must be setup to do a launch with this header's
> location. While the offset to the kernel_info structure does not need
> to be at a fixed offset, the offsets in the header must be relative
> offsets from the start of the setup kernel. The support in the linker
> file achieves this.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/boot/compressed/kernel_info.S | 50 +++++++++++++++++++++++---
>  arch/x86/boot/compressed/vmlinux.lds.S |  7 ++++
>  2 files changed, 53 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
> index f818ee8fba38..a0604a0d1756 100644
> --- a/arch/x86/boot/compressed/kernel_info.S
> +++ b/arch/x86/boot/compressed/kernel_info.S
> @@ -1,12 +1,20 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>
> +#include <linux/linkage.h>
>  #include <asm/bootparam.h>
>
> -       .section ".rodata.kernel_info", "a"
> +/*
> + * The kernel_info structure is not placed at a fixed offest in the
> + * kernel image. So this macro and the support in the linker file
> + * allow the relative offsets for the MLE header within the kernel
> + * image to be configured at build time.
> + */
> +#define roffset(X) ((X) - kernel_info)
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
> @@ -17,6 +25,40 @@ kernel_info:
>         /* Maximal allowed type for setup_data and setup_indirect structs. */
>         .long   SETUP_TYPE_MAX
>
> +       /* Offset to the MLE header structure */
> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> +       .long   roffset(mle_header_offset)
> +#else
> +       .long   0
> +#endif
> +
>  kernel_info_var_len_data:
>         /* Empty for time being... */
> -kernel_info_end:
> +SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
> +
> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> +       /*
> +        * The MLE Header per the TXT Specification, section 2.1
> +        * MLE capabilities, see table 4. Capabilities set:
> +        * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
> +        * bit 1: Support for RLP wakeup using MONITOR address
> +        * bit 2: The ECX register will contain the pointer to the MLE page table
> +        * bit 5: TPM 1.2 family: Details/authorities PCR usage support
> +        * bit 9: Supported format of TPM 2.0 event log - TCG compliant
> +        */
> +SYM_DATA_START(mle_header)
> +       .long   0x9082ac5a  /* UUID0 */
> +       .long   0x74a7476f  /* UUID1 */
> +       .long   0xa2555c0f  /* UUID2 */
> +       .long   0x42b651cb  /* UUID3 */
> +       .long   0x00000034  /* MLE header size */
> +       .long   0x00020002  /* MLE version 2.2 */
> +       .long   roffset(sl_stub_entry_offset) /* Linear entry point of MLE (virt. address) */
> +       .long   0x00000000  /* First valid page of MLE */
> +       .long   0x00000000  /* Offset within binary of first byte of MLE */
> +       .long   roffset(_edata_offset) /* Offset within binary of last byte + 1 of MLE */
> +       .long   0x00000227  /* Bit vector of MLE-supported capabilities */
> +       .long   0x00000000  /* Starting linear address of command line (unused) */
> +       .long   0x00000000  /* Ending linear address of command line (unused) */
> +SYM_DATA_END(mle_header)
> +#endif
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 083ec6d7722a..f82184801462 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -118,3 +118,10 @@ SECTIONS
>         }
>         ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
>  }
> +
> +#ifdef CONFIG_SECURE_LAUNCH
> +PROVIDE(kernel_info_offset      = ABSOLUTE(kernel_info - startup_32));
> +PROVIDE(mle_header_offset       = kernel_info_offset + ABSOLUTE(mle_header - startup_32));
> +PROVIDE(sl_stub_entry_offset    = kernel_info_offset + ABSOLUTE(sl_stub_entry - startup_32));
> +PROVIDE(_edata_offset           = kernel_info_offset + ABSOLUTE(_edata - startup_32));
> +#endif
> --
> 2.39.3
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

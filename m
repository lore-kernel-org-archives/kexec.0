Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760BBC19F32
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 06:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BXe1OVwp3L9kmSA8/jSt65mE27JFo4uhBYuBWPF90zE=; b=SEpZB2evWbzzy6dTe0d8qGMy+P
	VJLKNokYIvqlYvjmBRZKhPcF+nP+Ok3SuRoLIE1N6J9JTZDhs2fV0/udwHvLgjpdzkKSumbH/0ORX
	iwiz7/AfXd/JqECJaFNI7Vco8qO1quATt9Sai7MByqe3+fpY6NeBAEqvmQMyXR1iZsV7z0pYf8EpG
	FzAiKi58rqZOA3gl3F1D7S7A61MCrcfGbwqoP687v8kjRyBRI66DCoVE47VjidhHJCBxS9MuuuiWY
	Yu8lGkaI5izNWcKsqZoBeacPSfUzamlfQMVuzkvM44OPjXgtogsPINn8Hki92u2YIKuMt1+d2r8PV
	hT0rCL+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqRZ0-0000000DMaE-2yxD;
	Fri, 07 Mar 2025 06:52:06 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqRY2-0000000DMTw-1TZ0
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 06:51:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8A11AA45535;
	Fri,  7 Mar 2025 06:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A99DC4CED1;
	Fri,  7 Mar 2025 06:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741330264;
	bh=6ZI3dCObpML4Ufp4w1iQZ0U98W7z0VOCfaMcxrJlCIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=foE95WbjLJUGTYyscTXMtsFf9MeH/But/AEKvbezNXoxDg6qRlEz4XfAzplYYZQem
	 raf6W+rXGPu8aIEO1ZZY78yBG1EHTpXKoh5n0sFncxZgkba8GpPsiskg/UKP0sNJ4V
	 ozkLvrit/URKrTMhsyDSUkkzHvI8LFMiJehSw0j0PwyYaQ4DjHQrEP4YhLA5oP/mg8
	 ABvwQspdwsa2Elj4PiDw9z/+o2qd5xqVB+Ht4KKRLtoRSiOAzo2ONaKnu+mxXN3omZ
	 JkqAGDps79dDUt7fi9DxoMFXfTukI+i5r0rqSMV3MBcD83z2PluXhRvaie+exIx3u8
	 xF1jQAyUUU/0Q==
Date: Fri, 7 Mar 2025 08:51:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 08/19] x86/boot: Place TXT MLE header in the
 kernel_info section
Message-ID: <Z8qXVLiab5L-XkgP@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-9-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-9-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_225106_573016_DA64E596 
X-CRM114-Status: GOOD (  28.49  )
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

On Thu, Dec 19, 2024 at 11:42:05AM -0800, Ross Philipson wrote:
> The MLE (measured launch environment) header must be locatable by the
> boot loader and TXT must be setup to do a launch with this header's

(cutting the hairs) nit: /TXT/Intel TXT/

> location. While the offset to the kernel_info structure does not need
> to be at a fixed offset, the offsets in the header must be relative
> offsets from the start of the setup kernel. The support in the linker
> file achieves this.

This is too obfuscated and also sort of misses the action taken by
the patch.

I presume the goal here is to add relative offset to the MLE header?
Please state that explicitly.

Like for any possible kernel patch:

1. Come out clean 110% transparent.
2. Full exposure what you're doing.

;-)

That's the fastest possible path to actual results. 

> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
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
> -	.section ".rodata.kernel_info", "a"
> +/*
> + * The kernel_info structure is not placed at a fixed offest in the
> + * kernel image. So this macro and the support in the linker file
> + * allow the relative offsets for the MLE header within the kernel
> + * image to be configured at build time.
> + */
> +#define roffset(X) ((X) - kernel_info)
>  
> -	.global kernel_info
> +	.section ".rodata.kernel_info", "a"
>  
> -kernel_info:
> +	.balign	16
> +SYM_DATA_START(kernel_info)
>  	/* Header, Linux top (structure). */
>  	.ascii	"LToP"
>  	/* Size. */
> @@ -17,6 +25,40 @@ kernel_info:
>  	/* Maximal allowed type for setup_data and setup_indirect structs. */
>  	.long	SETUP_TYPE_MAX
>  
> +	/* Offset to the MLE header structure */
> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> +	.long	roffset(mle_header_offset)
> +#else
> +	.long	0
> +#endif
> +
>  kernel_info_var_len_data:
>  	/* Empty for time being... */
> -kernel_info_end:
> +SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
> +
> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
> +	/*
> +	 * The MLE Header per the TXT Specification, section 2.1
> +	 * MLE capabilities, see table 4. Capabilities set:
> +	 * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
> +	 * bit 1: Support for RLP wakeup using MONITOR address
> +	 * bit 2: The ECX register will contain the pointer to the MLE page table
> +	 * bit 5: TPM 1.2 family: Details/authorities PCR usage support
> +	 * bit 9: Supported format of TPM 2.0 event log - TCG compliant
> +	 */
> +SYM_DATA_START(mle_header)
> +	.long	0x9082ac5a  /* UUID0 */
> +	.long	0x74a7476f  /* UUID1 */
> +	.long	0xa2555c0f  /* UUID2 */
> +	.long	0x42b651cb  /* UUID3 */
> +	.long	0x00000034  /* MLE header size */
> +	.long	0x00020002  /* MLE version 2.2 */
> +	.long	roffset(sl_stub_entry_offset) /* Linear entry point of MLE (virt. address) */
> +	.long	0x00000000  /* First valid page of MLE */
> +	.long	0x00000000  /* Offset within binary of first byte of MLE */
> +	.long	roffset(_edata_offset) /* Offset within binary of last byte + 1 of MLE */
> +	.long	0x00000227  /* Bit vector of MLE-supported capabilities */
> +	.long	0x00000000  /* Starting linear address of command line (unused) */
> +	.long	0x00000000  /* Ending linear address of command line (unused) */

Nit: I'd consider aligning these to few tab offsets after even tho it
might cause checkpatch complain (which is fine when there are legitimite
reasons to do so).

Would be easier to read.

> +SYM_DATA_END(mle_header)
> +#endif
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 083ec6d7722a..f82184801462 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -118,3 +118,10 @@ SECTIONS
>  	}
>  	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
>  }
> +
> +#ifdef CONFIG_SECURE_LAUNCH
> +PROVIDE(kernel_info_offset      = ABSOLUTE(kernel_info - startup_32));
> +PROVIDE(mle_header_offset       = kernel_info_offset + ABSOLUTE(mle_header - startup_32));
> +PROVIDE(sl_stub_entry_offset    = kernel_info_offset + ABSOLUTE(sl_stub_entry - startup_32));
> +PROVIDE(_edata_offset           = kernel_info_offset + ABSOLUTE(_edata - startup_32));

I'd enumerate these one by one in the commit message. I.e. what is added
explicitly.

> +#endif
> -- 
> 2.39.3
> 

BR, Jarkko


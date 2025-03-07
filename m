Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B27C19F32
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 05:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uTkonqFUz3mAleytulpBg9UY017gfCq+Dz1narXOmms=; b=V7pWroorNi2DQM8ZzVTKV3NGdR
	n0dbmvskOwQC4Pa7J9WAP0Conwsxr6G70DfO4Wb7zejsHxDEkNPlM7NOfkwaP9qMFjRZPqUw8MhZm
	bLZz/Hx/VGhQ2adgmEaj6+BNu63XG77H1YzGEstWM2BoEihdjRA4bANeUIUihFxqGv+COPFdTCw/M
	AcQLKQ8AuhJQlS67pBDO7RCwR9VQfYAmJVBXdY3BWaL+zIEdgC2lzmGF7qV4eIJLMsu0klGN2lIPs
	GrO5hJU0WR2329peDrCSNFaMXQxImLIQX8lNnV401TDBvQg+Ia/7hLyhXLztpwo8XatwBBgtLq+MX
	r1a47J8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqQOE-0000000DE05-3ccH;
	Fri, 07 Mar 2025 05:36:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqQOB-0000000DDz3-0riC
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 05:36:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AFD605C5C01;
	Fri,  7 Mar 2025 05:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C5AC4CED1;
	Fri,  7 Mar 2025 05:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741325810;
	bh=9QaH+vm07d39qN8cufv/JiMHH2odvyuaWM82iz6NdKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlkIHdXPGM9njYUBUxDdK8xs8t3idwKwsPWkP2wvPc9oP4CJW/dRs+TgER9Jn2xOB
	 MZNqRpx2aDzy0328cV+FGog7U5h/vMcQ1kklrSf010F2CRP/wMCHzRM1VukWA79/TF
	 dUCBmloSPeRxFQmIzoPezNvhu8NXdUCtmYjtj5XXcuOESSXwWA96wPoRFpzTLco91O
	 PxnVuGWfYh9u/UcZKpyVz3KD+bVyfidrclafPFfkmhgI6QB+tXzRp1aR5Qmt7oFEp6
	 6XVX4IHGLOLWOqkxkQVq+gHhQUzlZvHtsXUN5al4RN7xUQ0NOw1B57mwfjGtVQTs20
	 PYouPxJKYv1cQ==
Date: Fri, 7 Mar 2025 07:36:45 +0200
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
Subject: Re: [PATCH v12 06/19] x86: Add early SHA-256 support for Secure
 Launch early measurements
Message-ID: <Z8qF7bP7vSL6c_Z9@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-7-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-7-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_213651_359049_E13DE0EE 
X-CRM114-Status: GOOD (  17.17  )
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

On Thu, Dec 19, 2024 at 11:42:03AM -0800, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> The SHA-256 algorithm is necessary to measure configuration information into
> the TPM as early as possible before using the values. This implementation
> uses the established approach of #including the SHA-256 libraries directly in
> the code since the compressed kernel is not uncompressed at this point.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/boot/compressed/Makefile | 2 +-
>  arch/x86/boot/compressed/sha256.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/boot/compressed/sha256.c
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 7eb03afb841b..40dc0b9babd5 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -107,7 +107,7 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>  vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>  
> -vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sha1.o
> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sha1.o $(obj)/sha256.o
>  
>  $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
>  	$(call if_changed,ld)
> diff --git a/arch/x86/boot/compressed/sha256.c b/arch/x86/boot/compressed/sha256.c
> new file mode 100644
> index 000000000000..293742a90ddc
> --- /dev/null
> +++ b/arch/x86/boot/compressed/sha256.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Apertus Solutions, LLC
> + */
> +
> +#include "../../../../lib/crypto/sha256.c"
> -- 
> 2.39.3
> 

Ditto, nothing particular on this at this point of time. Probably 80-90%
what it should be. 

BR, Jarkko


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74ADFC19F32
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 05:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EYPkN9eCOqF7xbc5dA8yKpy8ftNL7tGwoHrCrsASPaI=; b=UnhbmNzrGEJxv/vovi13weCMRu
	k1tBD0R9mg7ChFeL3POmgBsZHYh745vjre973aS0YqvjQ3/bg6BkutBWc8Pcx50aoW7IGngMhxcW2
	MLEmrkYebYz6EdJhQBuxug2edeE4a1DxhluckA+E1yaljJpJp0ESv7Ayup7Ky8cQIxFIqMPHExotW
	6VjsFc5O2TICUyIOoAxGClqqSo0ffo1SiP3CtIotDSBThrqAL4uTct1+H7AwC+KyhRDhLqiggZ83o
	QPbFhvwEj2ypacpqlQlRJ1qv9fud7+MjFNma0aT4D8E9ospF3XDaVRl1lSfXrFTsB7rYdpTLSrkiH
	I3kuT4bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqQNT-0000000DDqE-0dEs;
	Fri, 07 Mar 2025 05:36:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqQNQ-0000000DDoY-19zq
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 05:36:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C3A645C5AB5;
	Fri,  7 Mar 2025 05:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74388C4CEE2;
	Fri,  7 Mar 2025 05:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741325762;
	bh=boei5N6UlmoAMPlzgq5VIWFcm60SZWwfz3TA9by7qJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNW/dhx8rYYGJtm4lQKEOrd4NYNLyuCHNrPxxXKIkBoQ1qI5F/iM3f7JroHawql6o
	 Tts5NW6ZsekGtBDkyI13pXLvEc4xBZ8nZVniSio2GtV7wPazkdIilE038S8VBfPElk
	 ErjEhC2+wnGNkIaYzHE9D+/BxyuCIHm/Rf+6OF+mBOU1eiZSijAerIMMYt2hKUXFXX
	 /f0DrZbVG2mSel8Mvu5J5YEsB5xhPTk3uFhtxbsrj3ZQFajDHKMw4dQqrapXhEt/nO
	 TBn7XuHy7WyfVXCJCTwzYogbN0jZH5mbeho/TF5v4RpjJ6FFlaMiEbbxVAeJJmAXVH
	 Tr5SLm3j3WlSg==
Date: Fri, 7 Mar 2025 07:35:57 +0200
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
Subject: Re: [PATCH v12 05/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
Message-ID: <Z8qFvYEE19yv7z-8@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-6-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-6-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_213604_420656_7781C37F 
X-CRM114-Status: GOOD (  33.49  )
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

On Thu, Dec 19, 2024 at 11:42:02AM -0800, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> Secure Launch is written to be compliant with the Intel TXT Measured Launch
> Developer's Guide. The MLE Guide dictates that the system can be configured to
> use both the SHA-1 and SHA-2 hashing algorithms.
> 
> Regardless of the preference towards SHA-2, if the firmware elected to start
> with the SHA-1 and SHA-2 banks active and the dynamic launch was configured to
> include SHA-1, Secure Launch is obligated to record measurements for all
> algorithms requested in the launch configuration.
> 
> The user environment or the integrity management does not desire to use SHA-1,
> it is free to just ignore the SHA-1 bank in any integrity operation with the
> TPM. If there is a larger concern about the SHA-1 bank being active, it is free
> to deliberately cap the SHA-1 PCRs, recording the event in the D-RTM log.
> 
> The SHA-1 code here has its origins in the code from the main kernel:
> 
> commit c4d5b9f ("crypto: sha1 - implement base layer for SHA-1")
> 
> A modified version of this code was introduced to the lib/crypto/sha1.c to bring
> it in line with the SHA-256 code and allow it to be pulled into the setup kernel
> in the same manner as SHA-256 is.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/boot/compressed/Makefile |  2 +
>  arch/x86/boot/compressed/sha1.c   |  6 +++
>  include/crypto/sha1.h             |  1 +
>  lib/crypto/sha1.c                 | 81 +++++++++++++++++++++++++++++++
>  4 files changed, 90 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/sha1.c
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index f2051644de94..7eb03afb841b 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -107,6 +107,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>  vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>  
> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/sha1.o
> +
>  $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
>  	$(call if_changed,ld)
>  
> diff --git a/arch/x86/boot/compressed/sha1.c b/arch/x86/boot/compressed/sha1.c
> new file mode 100644
> index 000000000000..d754489941ac
> --- /dev/null
> +++ b/arch/x86/boot/compressed/sha1.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Apertus Solutions, LLC.
> + */
> +
> +#include "../../../../lib/crypto/sha1.c"
> diff --git a/include/crypto/sha1.h b/include/crypto/sha1.h
> index 044ecea60ac8..d715dd5332e1 100644
> --- a/include/crypto/sha1.h
> +++ b/include/crypto/sha1.h
> @@ -42,5 +42,6 @@ extern int crypto_sha1_finup(struct shash_desc *desc, const u8 *data,
>  #define SHA1_WORKSPACE_WORDS	16
>  void sha1_init(__u32 *buf);
>  void sha1_transform(__u32 *digest, const char *data, __u32 *W);
> +void sha1(const u8 *data, unsigned int len, u8 *out);
>  
>  #endif /* _CRYPTO_SHA1_H */
> diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
> index ebb60519ae93..0bd32df31743 100644
> --- a/lib/crypto/sha1.c
> +++ b/lib/crypto/sha1.c
> @@ -137,5 +137,86 @@ void sha1_init(__u32 *buf)
>  }
>  EXPORT_SYMBOL(sha1_init);
>  
> +static void __sha1_transform(u32 *digest, const char *data)
> +{
> +	u32 ws[SHA1_WORKSPACE_WORDS];
> +
> +	sha1_transform(digest, data, ws);
> +
> +	/* Ensure local data for generating digest is cleared in all cases */
> +	memzero_explicit(ws, sizeof(ws));
> +}
> +
> +static void sha1_update(struct sha1_state *sctx, const u8 *data, unsigned int len)
> +{
> +	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> +	int blocks;
> +
> +	sctx->count += len;
> +
> +	if (unlikely((partial + len) < SHA1_BLOCK_SIZE))
> +		goto out;
> +
> +	if (partial) {
> +		int p = SHA1_BLOCK_SIZE - partial;
> +
> +		memcpy(sctx->buffer + partial, data, p);
> +		data += p;
> +		len -= p;
> +
> +		__sha1_transform(sctx->state, sctx->buffer);
> +	}
> +
> +	blocks = len / SHA1_BLOCK_SIZE;
> +	len %= SHA1_BLOCK_SIZE;
> +
> +	if (blocks) {
> +		while (blocks--) {
> +			__sha1_transform(sctx->state, data);
> +			data += SHA1_BLOCK_SIZE;
> +		}
> +	}
> +	partial = 0;
> +
> +out:
> +	memcpy(sctx->buffer + partial, data, len);
> +}
> +
> +static void sha1_final(struct sha1_state *sctx, u8 *out)
> +{
> +	const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
> +	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> +	__be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
> +	__be32 *digest = (__be32 *)out;
> +	int i;
> +
> +	sctx->buffer[partial++] = 0x80;
> +	if (partial > bit_offset) {
> +		memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
> +		partial = 0;
> +
> +		__sha1_transform(sctx->state, sctx->buffer);
> +	}
> +
> +	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
> +	*bits = cpu_to_be64(sctx->count << 3);
> +	__sha1_transform(sctx->state, sctx->buffer);
> +
> +	for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
> +		put_unaligned_be32(sctx->state[i], digest++);
> +
> +	*sctx = (struct sha1_state){};
> +}
> +
> +void sha1(const u8 *data, unsigned int len, u8 *out)
> +{
> +	struct sha1_state sctx = {0};
> +
> +	sha1_init(sctx.state);
> +	sha1_update(&sctx, data, len);
> +	sha1_final(&sctx, out);
> +}
> +EXPORT_SYMBOL(sha1);
> +
>  MODULE_DESCRIPTION("SHA-1 Algorithm");
>  MODULE_LICENSE("GPL");
> -- 
> 2.39.3
> 

This looks pretty good and we had already the SHA-1 discussion in
the past :-)

BR, Jarkko


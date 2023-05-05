Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D0FC77B7F
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GjCpIVIMlC1Ua/jZDmGZ0fqE/0Vw8MAHEMZ2J/mxk5g=; b=Rn3mFjiRfTcOpA
	OibkVLLxwWyBY6kFy0zMPc/hGCAkeDqw2sY5aftdsZMX8G+dHH/QKbRs2NOdjXoo/GfonUX6KH9hc
	RXJe+pO2lsiYJy5lQMqcEiAcKw2KKjspZC9ieq7/YE+WxyRDMoRPWHHsPlJHqr105kj77CqWtZ8NL
	X/yzuT/1o2bVfEA5O8MnSW69iKz6dKpwLJPh9gVF/D+gWRiauPpMceJNC1e7yTo9ZUrvKdurlEZqD
	cvj2Ekl+4oW1GQ3HyaxwgwVTqXctWbp+i7bmJvzk65bhRgMSDcvtisoONdp+KFZYJNuOoQl3g/6jz
	iTwCQI6Lqq6ozB6G3KAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puyOf-00BJdy-24;
	Fri, 05 May 2023 16:35:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puyOb-00BJcP-32
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 16:35:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3656863F30;
	Fri,  5 May 2023 16:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB357C433EF;
	Fri,  5 May 2023 16:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683304500;
	bh=XBj3MnRDqmp/nZRO0PTCx4vob7yL6wLvJYcQ5Zl+etg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCgP/AAln+zIVhqIZT+SqtVzI8LDmrhiKOxRREGctr0mTP5kM8PQMyVTx/Tt1dzLt
	 YipX2aEq1ZFjYBO41EM3lw8KuSVMVG6lKW7rBW9slzXJlsvw+eYf8qohwJ+Cq6f0WS
	 dbN9QbyQ7iJBO/kQ6RP+MOhFspiurVcBFSMmqsNwuWp8t9eMQnEed91fBdIRxlt8qx
	 afGY/+oiQ2kLfW5ZtErYR9bKh5+NlAHnHSVxDc0AqgC5mHz/rYXfbxPPOHdJ5VKk8l
	 9e/9xWc90h8jWW8zx8wYRBv/MisoCOsmqaEtXfL1LA3HdGNHzx9rGmgntPXfefIEhu
	 LvUHq+IOsM6Rw==
Date: Fri, 5 May 2023 18:34:54 +0200
From: Simon Horman <horms@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <ZFUwLjPfhz8Ch9bE@kernel.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-7-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_093502_149416_E65959F2 
X-CRM114-Status: GOOD (  26.20  )
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

On Thu, May 04, 2023 at 02:50:15PM +0000, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> The SHA algorithms are necessary to measure configuration information into
> the TPM as early as possible before using the values. This implementation
> uses the established approach of #including the SHA libraries directly in
> the code since the compressed kernel is not uncompressed at this point.
> 
> The SHA code here has its origins in the code from the main kernel:
> 
> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> 
> That code could not be pulled directly into the setup portion of the
> compressed kernel because of other dependencies it pulls in. The result
> is this is a modified copy of that code that still leverages the core
> SHA algorithms.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/boot/compressed/Makefile       |  2 +
>  arch/x86/boot/compressed/early_sha1.c   | 97 +++++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/early_sha1.h   | 17 ++++++
>  arch/x86/boot/compressed/early_sha256.c |  7 +++
>  lib/crypto/sha1.c                       |  4 ++
>  lib/crypto/sha256.c                     |  8 +++
>  6 files changed, 135 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/early_sha1.c
>  create mode 100644 arch/x86/boot/compressed/early_sha1.h
>  create mode 100644 arch/x86/boot/compressed/early_sha256.c
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 6b6cfe6..1d327d4 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -112,6 +112,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>  vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>  
> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
> +
>  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>  	$(call if_changed,ld)
>  
> diff --git a/arch/x86/boot/compressed/early_sha1.c b/arch/x86/boot/compressed/early_sha1.c
> new file mode 100644
> index 0000000..524ec23
> --- /dev/null
> +++ b/arch/x86/boot/compressed/early_sha1.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Apertus Solutions, LLC.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/linkage.h>
> +#include <linux/string.h>
> +#include <asm/boot.h>
> +#include <asm/unaligned.h>
> +
> +#include "early_sha1.h"
> +
> +#define SHA1_DISABLE_EXPORT

Hi Ross,

I could be mistaken, but it seems to me that *_DISABLE_EXPORT
is a mechanism of this patch to disable exporting symbols
(use of EXPORT_SYMBOL), at compile time.

If so, this doesn't strike me as something that should be part of upstream
kernel code.  Could you consider dropping this part of the patch?

...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1d3ldJ-0003hr-Hz
 for kexec@lists.infradead.org; Thu, 27 Apr 2017 15:47:07 +0000
Date: Thu, 27 Apr 2017 17:46:31 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 06/32] x86/mm: Add Secure Memory Encryption (SME)
 support
Message-ID: <20170427154631.2tsqgax4kqcvydnx@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211727.10190.18774.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170418211727.10190.18774.stgit@tlendack-t1.amdoffice.net>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Apr 18, 2017 at 04:17:27PM -0500, Tom Lendacky wrote:
> Add support for Secure Memory Encryption (SME). This initial support
> provides a Kconfig entry to build the SME support into the kernel and
> defines the memory encryption mask that will be used in subsequent
> patches to mark pages as encrypted.

...

> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> new file mode 100644
> index 0000000..d5c4a2b
> --- /dev/null
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -0,0 +1,42 @@
> +/*
> + * AMD Memory Encryption Support
> + *
> + * Copyright (C) 2016 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +

These ifdeffery closing #endif markers look strange:

> +#ifndef __X86_MEM_ENCRYPT_H__
> +#define __X86_MEM_ENCRYPT_H__
> +
> +#ifndef __ASSEMBLY__
> +
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +
> +extern unsigned long sme_me_mask;
> +
> +static inline bool sme_active(void)
> +{
> +	return !!sme_me_mask;
> +}
> +
> +#else	/* !CONFIG_AMD_MEM_ENCRYPT */
> +
> +#ifndef sme_me_mask
> +#define sme_me_mask	0UL
> +
> +static inline bool sme_active(void)
> +{
> +	return false;
> +}
> +#endif

this endif is the sme_me_mask closing one and it has sme_active() in it.
Shouldn't it be:

#ifndef sme_me_mask
#define sme_me_mask  0UL
#endif

and have sme_active below it, in the !CONFIG_AMD_MEM_ENCRYPT branch?

The same thing is in include/linux/mem_encrypt.h

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

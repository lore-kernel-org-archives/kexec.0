Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOzxt-00EeLV-RX
 for kexec@lists.infradead.org; Sat, 11 Sep 2021 10:10:31 +0000
Date: Sat, 11 Sep 2021 12:10:14 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 3/8] x86/sev: Add an x86 version of cc_platform_has()
Message-ID: <YTyAhmPf39Vqd7G9@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <f9951644147e27772bf4512325e8ba6472e363b7.1631141919.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f9951644147e27772bf4512325e8ba6472e363b7.1631141919.git.thomas.lendacky@amd.com>
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
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Christoph Hellwig <hch@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Wed, Sep 08, 2021 at 05:58:34PM -0500, Tom Lendacky wrote:
> diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
> new file mode 100644
> index 000000000000..3c9bacd3c3f3
> --- /dev/null
> +++ b/arch/x86/kernel/cc_platform.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Confidential Computing Platform Capability checks
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + */
> +
> +#include <linux/export.h>
> +#include <linux/cc_platform.h>
> +#include <linux/mem_encrypt.h>
> +
> +bool cc_platform_has(enum cc_attr attr)
> +{
> +	if (sme_me_mask)

Why are you still checking the sme_me_mask here? AFAIR, we said that
we'll do that only when the KVM folks come with a valid use case...

> +		return amd_cc_platform_has(attr);
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(cc_platform_has);
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index ff08dc463634..18fe19916bc3 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -20,6 +20,7 @@
>  #include <linux/bitops.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/virtio_config.h>
> +#include <linux/cc_platform.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/fixmap.h>
> @@ -389,6 +390,26 @@ bool noinstr sev_es_active(void)
>  	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
>  }
>  
> +bool amd_cc_platform_has(enum cc_attr attr)
> +{
> +	switch (attr) {
> +	case CC_ATTR_MEM_ENCRYPT:
> +		return sme_me_mask != 0;

No need for the "!= 0"

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

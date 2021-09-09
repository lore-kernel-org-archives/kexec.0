Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pegase2.c-s.fr ([93.17.235.10])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOEan-008S4M-PN
 for kexec@lists.infradead.org; Thu, 09 Sep 2021 07:35:32 +0000
Subject: Re: [PATCH v3 2/8] mm: Introduce a function to check for confidential
 computing features
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <0a7618d54e7e954ee56c22ad1b94af2ffe69543a.1631141919.git.thomas.lendacky@amd.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <96aa160a-e35e-452e-b785-24410265b0f6@csgroup.eu>
Date: Thu, 9 Sep 2021 07:35:21 +0000
MIME-Version: 1.0
In-Reply-To: <0a7618d54e7e954ee56c22ad1b94af2ffe69543a.1631141919.git.thomas.lendacky@amd.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@infradead.org>, Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>



On 9/8/21 10:58 PM, Tom Lendacky wrote:
> In prep for other confidential computing technologies, introduce a generic
> helper function, cc_platform_has(), that can be used to check for specific

I have little problem with that naming.

For me CC has always meant Compiler Collection.

> active confidential computing attributes, like memory encryption. This is
> intended to eliminate having to add multiple technology-specific checks to
> the code (e.g. if (sev_active() || tdx_active())).
> 
> Co-developed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   arch/Kconfig                |  3 ++
>   include/linux/cc_platform.h | 88 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 91 insertions(+)
>   create mode 100644 include/linux/cc_platform.h
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 3743174da870..ca7c359e5da8 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1234,6 +1234,9 @@ config RELR
>   config ARCH_HAS_MEM_ENCRYPT
>   	bool
>   
> +config ARCH_HAS_CC_PLATFORM
> +	bool
> +
>   config HAVE_SPARSE_SYSCALL_NR
>          bool
>          help
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> new file mode 100644
> index 000000000000..253f3ea66cd8
> --- /dev/null
> +++ b/include/linux/cc_platform.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Confidential Computing Platform Capability checks
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + */
> +
> +#ifndef _CC_PLATFORM_H
> +#define _CC_PLATFORM_H
> +
> +#include <linux/types.h>
> +#include <linux/stddef.h>
> +
> +/**
> + * enum cc_attr - Confidential computing attributes
> + *
> + * These attributes represent confidential computing features that are
> + * currently active.
> + */
> +enum cc_attr {
> +	/**
> +	 * @CC_ATTR_MEM_ENCRYPT: Memory encryption is active
> +	 *
> +	 * The platform/OS is running with active memory encryption. This
> +	 * includes running either as a bare-metal system or a hypervisor
> +	 * and actively using memory encryption or as a guest/virtual machine
> +	 * and actively using memory encryption.
> +	 *
> +	 * Examples include SME, SEV and SEV-ES.
> +	 */
> +	CC_ATTR_MEM_ENCRYPT,
> +
> +	/**
> +	 * @CC_ATTR_HOST_MEM_ENCRYPT: Host memory encryption is active
> +	 *
> +	 * The platform/OS is running as a bare-metal system or a hypervisor
> +	 * and actively using memory encryption.
> +	 *
> +	 * Examples include SME.
> +	 */
> +	CC_ATTR_HOST_MEM_ENCRYPT,
> +
> +	/**
> +	 * @CC_ATTR_GUEST_MEM_ENCRYPT: Guest memory encryption is active
> +	 *
> +	 * The platform/OS is running as a guest/virtual machine and actively
> +	 * using memory encryption.
> +	 *
> +	 * Examples include SEV and SEV-ES.
> +	 */
> +	CC_ATTR_GUEST_MEM_ENCRYPT,
> +
> +	/**
> +	 * @CC_ATTR_GUEST_STATE_ENCRYPT: Guest state encryption is active
> +	 *
> +	 * The platform/OS is running as a guest/virtual machine and actively
> +	 * using memory encryption and register state encryption.
> +	 *
> +	 * Examples include SEV-ES.
> +	 */
> +	CC_ATTR_GUEST_STATE_ENCRYPT,
> +};
> +
> +#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> +
> +/**
> + * cc_platform_has() - Checks if the specified cc_attr attribute is active
> + * @attr: Confidential computing attribute to check
> + *
> + * The cc_platform_has() function will return an indicator as to whether the
> + * specified Confidential Computing attribute is currently active.
> + *
> + * Context: Any context
> + * Return:
> + * * TRUE  - Specified Confidential Computing attribute is active
> + * * FALSE - Specified Confidential Computing attribute is not active
> + */
> +bool cc_platform_has(enum cc_attr attr);

This declaration make it impossible for architectures to define this 
function inline.

For such function, having it inline would make more sense as it would 
allow GCC to perform constant folding and avoid the overhead  of calling 
a sub-function.

> +
> +#else	/* !CONFIG_ARCH_HAS_CC_PLATFORM */
> +
> +static inline bool cc_platform_has(enum cc_attr attr) { return false; }
> +
> +#endif	/* CONFIG_ARCH_HAS_CC_PLATFORM */
> +
> +#endif	/* _CC_PLATFORM_H */
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

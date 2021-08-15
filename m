Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-mw2nam08on2085.outbound.protection.outlook.com
 ([40.107.101.85] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFGa7-00FK31-LY
 for kexec@lists.infradead.org; Sun, 15 Aug 2021 13:53:47 +0000
Subject: Re: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
 <YRgUxyhoqVJ0Kxvt@zn.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <4710eb91-d054-7b31-5106-09e3e54bba9e@amd.com>
Date: Sun, 15 Aug 2021 08:53:31 -0500
In-Reply-To: <YRgUxyhoqVJ0Kxvt@zn.tnic>
Content-Language: en-US
MIME-Version: 1.0
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
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <jroedel@suse.de>

On 8/14/21 2:08 PM, Borislav Petkov wrote:
> On Fri, Aug 13, 2021 at 11:59:22AM -0500, Tom Lendacky wrote:
>> diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
>> new file mode 100644
>> index 000000000000..51e4eefd9542
>> --- /dev/null
>> +++ b/arch/x86/include/asm/protected_guest.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Protected Guest (and Host) Capability checks
>> + *
>> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
>> + */
>> +
>> +#ifndef _X86_PROTECTED_GUEST_H
>> +#define _X86_PROTECTED_GUEST_H
>> +
>> +#include <linux/mem_encrypt.h>
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +static inline bool prot_guest_has(unsigned int attr)
>> +{
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +	if (sme_me_mask)
>> +		return amd_prot_guest_has(attr);
>> +#endif
>> +
>> +	return false;
>> +}
>> +
>> +#endif	/* __ASSEMBLY__ */
>> +
>> +#endif	/* _X86_PROTECTED_GUEST_H */
> 
> I think this can be simplified more, diff ontop below:
> 
> - no need for the ifdeffery as amd_prot_guest_has() has versions for
> both when CONFIG_AMD_MEM_ENCRYPT is set or not.

Ugh, yeah, not sure why I put that in for this version since I have the 
static inline for when CONFIG_AMD_MEM_ENCRYPT is not set.

> 
> - the sme_me_mask check is pushed there too.
> 
> - and since this is vendor-specific, I'm checking the vendor bit. Yeah,
> yeah, cross-vendor but I don't really believe that.

It's not a cross-vendor thing as opposed to a KVM or other hypervisor 
thing where the family doesn't have to be reported as AMD or HYGON. That's 
why I made the if check be for sme_me_mask. I think that is the safer way 
to go.

Thanks,
Tom

> 
> ---
> diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
> index 51e4eefd9542..8541c76d5da4 100644
> --- a/arch/x86/include/asm/protected_guest.h
> +++ b/arch/x86/include/asm/protected_guest.h
> @@ -12,18 +12,13 @@
>   
>   #include <linux/mem_encrypt.h>
>   
> -#ifndef __ASSEMBLY__
> -
>   static inline bool prot_guest_has(unsigned int attr)
>   {
> -#ifdef CONFIG_AMD_MEM_ENCRYPT
> -	if (sme_me_mask)
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>   		return amd_prot_guest_has(attr);
> -#endif
>   
>   	return false;
>   }
>   
> -#endif	/* __ASSEMBLY__ */
> -
>   #endif	/* _X86_PROTECTED_GUEST_H */
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index edc67ddf065d..5a0442a6f072 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -392,6 +392,9 @@ bool noinstr sev_es_active(void)
>   
>   bool amd_prot_guest_has(unsigned int attr)
>   {
> +	if (!sme_me_mask)
> +		return false;
> +
>   	switch (attr) {
>   	case PATTR_MEM_ENCRYPT:
>   		return sme_me_mask != 0;
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

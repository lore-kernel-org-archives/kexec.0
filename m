Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-sn1nam01on0053.outbound.protection.outlook.com
 ([104.47.32.53] helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d6Hh2-0007X8-Fm
 for kexec@lists.infradead.org; Thu, 04 May 2017 14:25:21 +0000
Subject: Re: [PATCH v5 06/32] x86/mm: Add Secure Memory Encryption (SME)
 support
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211727.10190.18774.stgit@tlendack-t1.amdoffice.net>
 <20170427154631.2tsqgax4kqcvydnx@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <d9d9f10a-0ce5-53e8-41f5-f8690dbd7362@amd.com>
Date: Thu, 4 May 2017 09:24:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170427154631.2tsqgax4kqcvydnx@pd.tnic>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 4/27/2017 10:46 AM, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 04:17:27PM -0500, Tom Lendacky wrote:
>> Add support for Secure Memory Encryption (SME). This initial support
>> provides a Kconfig entry to build the SME support into the kernel and
>> defines the memory encryption mask that will be used in subsequent
>> patches to mark pages as encrypted.
>
> ...
>
>> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
>> new file mode 100644
>> index 0000000..d5c4a2b
>> --- /dev/null
>> +++ b/arch/x86/include/asm/mem_encrypt.h
>> @@ -0,0 +1,42 @@
>> +/*
>> + * AMD Memory Encryption Support
>> + *
>> + * Copyright (C) 2016 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>
> These ifdeffery closing #endif markers look strange:
>
>> +#ifndef __X86_MEM_ENCRYPT_H__
>> +#define __X86_MEM_ENCRYPT_H__
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +
>> +extern unsigned long sme_me_mask;
>> +
>> +static inline bool sme_active(void)
>> +{
>> +	return !!sme_me_mask;
>> +}
>> +
>> +#else	/* !CONFIG_AMD_MEM_ENCRYPT */
>> +
>> +#ifndef sme_me_mask
>> +#define sme_me_mask	0UL
>> +
>> +static inline bool sme_active(void)
>> +{
>> +	return false;
>> +}
>> +#endif
>
> this endif is the sme_me_mask closing one and it has sme_active() in it.
> Shouldn't it be:
>
> #ifndef sme_me_mask
> #define sme_me_mask  0UL
> #endif
>
> and have sme_active below it, in the !CONFIG_AMD_MEM_ENCRYPT branch?
>
> The same thing is in include/linux/mem_encrypt.h

I did this so that an the include order wouldn't cause issues (including
asm/mem_encrypt.h followed by later by a linux/mem_encrypt.h include).
I can make this a bit clearer by having separate #defines for each
thing, e.g.:

#ifndef sme_me_mask
#define sme_me_mask 0UL
#endif

#ifndef sme_active
#define sme_active sme_active
static inline ...
#endif

Is that better/clearer?

Thanks,
Tom

>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

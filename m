Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com
 ([40.107.237.65] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSjCd-005Hfb-RQ
 for kexec@lists.infradead.org; Tue, 21 Sep 2021 17:05:09 +0000
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
 <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
Date: Tue, 21 Sep 2021 12:04:58 -0500
In-Reply-To: <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
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
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Christoph Hellwig <hch@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>

On 9/20/21 2:23 PM, Kirill A. Shutemov wrote:
> On Wed, Sep 08, 2021 at 05:58:36PM -0500, Tom Lendacky wrote:
>> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
>> index 470b20208430..eff4d19f9cb4 100644
>> --- a/arch/x86/mm/mem_encrypt_identity.c
>> +++ b/arch/x86/mm/mem_encrypt_identity.c
>> @@ -30,6 +30,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/mm.h>
>>   #include <linux/mem_encrypt.h>
>> +#include <linux/cc_platform.h>
>>   
>>   #include <asm/setup.h>
>>   #include <asm/sections.h>
>> @@ -287,7 +288,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>>   	unsigned long pgtable_area_len;
>>   	unsigned long decrypted_base;
>>   
>> -	if (!sme_active())
>> +	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
>>   		return;
>>   
>>   	/*
> 
> This change break boot for me (in KVM on Intel host). It only reproduces
> with allyesconfig. More reasonable config works fine, but I didn't try to
> find exact cause in config.

Looks like instrumentation during early boot. I worked with Boris offline 
to exclude arch/x86/kernel/cc_platform.c from some of the instrumentation 
and that allowed an allyesconfig to boot.

Thanks,
Tom

> 
> Convertion to cc_platform_has() in __startup_64() in 8/8 has the same
> effect.
> 
> I believe it caused by sme_me_mask access from __startup_64() without
> fixup_pointer() magic. I think __startup_64() requires special treatement
> and we should avoid cc_platform_has() there (or have a special version of
> the helper). Note that only AMD requires these cc_platform_has() to return
> true.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

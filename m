Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-sn1nam02on0061.outbound.protection.outlook.com
 ([104.47.36.61] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d6Hv4-00009b-Jg
 for kexec@lists.infradead.org; Thu, 04 May 2017 14:39:52 +0000
Subject: Re: [PATCH v5 12/32] x86/mm: Insure that boot memory areas are mapped
 properly
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211822.10190.67435.stgit@tlendack-t1.amdoffice.net>
 <20170504101609.vazu4tuc3gqapaqk@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <2384de89-4c55-a181-148e-128943f18d5f@amd.com>
Date: Thu, 4 May 2017 09:39:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170504101609.vazu4tuc3gqapaqk@pd.tnic>
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

On 5/4/2017 5:16 AM, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 04:18:22PM -0500, Tom Lendacky wrote:
>> The boot data and command line data are present in memory in a decrypted
>> state and are copied early in the boot process.  The early page fault
>> support will map these areas as encrypted, so before attempting to copy
>> them, add decrypted mappings so the data is accessed properly when copied.
>>
>> For the initrd, encrypt this data in place. Since the future mapping of the
>> initrd area will be mapped as encrypted the data will be accessed properly.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/include/asm/mem_encrypt.h |   11 +++++
>>  arch/x86/include/asm/pgtable.h     |    3 +
>>  arch/x86/kernel/head64.c           |   30 ++++++++++++--
>>  arch/x86/kernel/setup.c            |   10 +++++
>>  arch/x86/mm/mem_encrypt.c          |   77 ++++++++++++++++++++++++++++++++++++
>>  5 files changed, 127 insertions(+), 4 deletions(-)
>
> ...
>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index 603a166..a95800b 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -115,6 +115,7 @@
>>  #include <asm/microcode.h>
>>  #include <asm/mmu_context.h>
>>  #include <asm/kaslr.h>
>> +#include <asm/mem_encrypt.h>
>>
>>  /*
>>   * max_low_pfn_mapped: highest direct mapped pfn under 4GB
>> @@ -374,6 +375,15 @@ static void __init reserve_initrd(void)
>>  	    !ramdisk_image || !ramdisk_size)
>>  		return;		/* No initrd provided by bootloader */
>>
>> +	/*
>> +	 * If SME is active, this memory will be marked encrypted by the
>> +	 * kernel when it is accessed (including relocation). However, the
>> +	 * ramdisk image was loaded decrypted by the bootloader, so make
>> +	 * sure that it is encrypted before accessing it.
>> +	 */
>> +	if (sme_active())
>
> That test is not needed here because __sme_early_enc_dec() already tests
> sme_me_mask. There you should change that test to sme_active() instead.

Yeah, I was probably thinking slightly ahead to SEV where the initrd
will already be encrypted and so we only want to do this for SME.
That change can come in the SEV support patches, though.

Thanks,
Tom

>
>> +		sme_early_encrypt(ramdisk_image, ramdisk_end - ramdisk_image);
>> +
>>  	initrd_start = 0;
>>
>>  	mapped_size = memblock_mem_size(max_pfn_mapped);
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

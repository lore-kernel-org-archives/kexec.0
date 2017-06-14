Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm3nam03on0066.outbound.protection.outlook.com
 ([104.47.41.66] helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dLEIG-0000Px-2x
 for kexec@lists.infradead.org; Wed, 14 Jun 2017 19:49:34 +0000
Subject: Re: [PATCH v6 25/34] swiotlb: Add warnings for use of bounce buffers
 with SME
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <20170607191732.28645.42876.stgit@tlendack-t1.amdoffice.net>
 <20170614165052.fyn5t4gkq5leczcc@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <33d1debc-c684-cba1-7d95-493678f086d0@amd.com>
Date: Wed, 14 Jun 2017 14:49:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170614165052.fyn5t4gkq5leczcc@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 6/14/2017 11:50 AM, Borislav Petkov wrote:
> On Wed, Jun 07, 2017 at 02:17:32PM -0500, Tom Lendacky wrote:
>> Add warnings to let the user know when bounce buffers are being used for
>> DMA when SME is active.  Since the bounce buffers are not in encrypted
>> memory, these notifications are to allow the user to determine some
>> appropriate action - if necessary.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/include/asm/mem_encrypt.h |    8 ++++++++
>>   include/asm-generic/mem_encrypt.h  |    5 +++++
>>   include/linux/dma-mapping.h        |    9 +++++++++
>>   lib/swiotlb.c                      |    3 +++
>>   4 files changed, 25 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
>> index f1215a4..c7a2525 100644
>> --- a/arch/x86/include/asm/mem_encrypt.h
>> +++ b/arch/x86/include/asm/mem_encrypt.h
>> @@ -69,6 +69,14 @@ static inline bool sme_active(void)
>>   	return !!sme_me_mask;
>>   }
>>   
>> +static inline u64 sme_dma_mask(void)
>> +{
>> +	if (!sme_me_mask)
>> +		return 0ULL;
>> +
>> +	return ((u64)sme_me_mask << 1) - 1;
>> +}
>> +
>>   /*
>>    * The __sme_pa() and __sme_pa_nodebug() macros are meant for use when
>>    * writing to or comparing values from the cr3 register.  Having the
>> diff --git a/include/asm-generic/mem_encrypt.h b/include/asm-generic/mem_encrypt.h
>> index b55c3f9..fb02ff0 100644
>> --- a/include/asm-generic/mem_encrypt.h
>> +++ b/include/asm-generic/mem_encrypt.h
>> @@ -22,6 +22,11 @@ static inline bool sme_active(void)
>>   	return false;
>>   }
>>   
>> +static inline u64 sme_dma_mask(void)
>> +{
>> +	return 0ULL;
>> +}
>> +
>>   /*
>>    * The __sme_set() and __sme_clr() macros are useful for adding or removing
>>    * the encryption mask from a value (e.g. when dealing with pagetable
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 4f3eece..e2c5fda 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -10,6 +10,7 @@
>>   #include <linux/scatterlist.h>
>>   #include <linux/kmemcheck.h>
>>   #include <linux/bug.h>
>> +#include <linux/mem_encrypt.h>
>>   
>>   /**
>>    * List of possible attributes associated with a DMA mapping. The semantics
>> @@ -577,6 +578,10 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
>>   
>>   	if (!dev->dma_mask || !dma_supported(dev, mask))
>>   		return -EIO;
>> +
>> +	if (sme_active() && (mask < sme_dma_mask()))
>> +		dev_warn(dev, "SME is active, device will require DMA bounce buffers\n");
> 
> Something looks strange here:
> 
> you're checking sme_active() before calling sme_dma_mask() and yet in
> it, you're checking !sme_me_mask again. What gives?
> 

I guess I don't need the sme_active() check since the second part of the
if statement can only ever be true if SME is active (since mask is
unsigned).

Thanks,
Tom

> Why not move the sme_active() check into sme_dma_mask() and thus
> simplify callers?
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

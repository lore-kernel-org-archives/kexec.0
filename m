Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-co1nam03on0066.outbound.protection.outlook.com
 ([104.47.40.66] helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dLE8N-0004vb-KS
 for kexec@lists.infradead.org; Wed, 14 Jun 2017 19:39:21 +0000
Subject: Re: [PATCH v6 24/34] x86, swiotlb: Add memory encryption support
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <20170607191721.28645.96519.stgit@tlendack-t1.amdoffice.net>
 <20170614164553.jwcfgugpizz5pc2e@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <c1a59a06-2850-b215-5c08-27adff6fecde@amd.com>
Date: Wed, 14 Jun 2017 14:38:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170614164553.jwcfgugpizz5pc2e@pd.tnic>
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

On 6/14/2017 11:45 AM, Borislav Petkov wrote:
> On Wed, Jun 07, 2017 at 02:17:21PM -0500, Tom Lendacky wrote:
>> Since DMA addresses will effectively look like 48-bit addresses when the
>> memory encryption mask is set, SWIOTLB is needed if the DMA mask of the
>> device performing the DMA does not support 48-bits. SWIOTLB will be
>> initialized to create decrypted bounce buffers for use by these devices.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
> 
> ...
> 
> 
>> diff --git a/init/main.c b/init/main.c
>> index df58a41..7125b5f 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -488,6 +488,10 @@ void __init __weak thread_stack_cache_init(void)
>>   }
>>   #endif
>>   
>> +void __init __weak mem_encrypt_init(void)
>> +{
>> +}
> 
> void __init __weak mem_encrypt_init(void) { }
> 
> saves some real estate. Please do that for the rest of the stubs you're
> adding, for the next version.

Ok, will do.

Thanks,
Tom

> 
>> +
>>   /*
>>    * Set up kernel memory allocators
>>    */
>> @@ -640,6 +644,15 @@ asmlinkage __visible void __init start_kernel(void)
>>   	 */
>>   	locking_selftest();
>>   
>> +	/*
>> +	 * This needs to be called before any devices perform DMA
>> +	 * operations that might use the SWIOTLB bounce buffers.
>> +	 * This call will mark the bounce buffers as decrypted so
>> +	 * that their usage will not cause "plain-text" data to be
>> +	 * decrypted when accessed.
> 
> s/This call/It/
> 
>> +	 */
>> +	mem_encrypt_init();
>> +
>>   #ifdef CONFIG_BLK_DEV_INITRD
>>   	if (initrd_start && !initrd_below_start_ok &&
>>   	    page_to_pfn(virt_to_page((void *)initrd_start)) < min_low_pfn) {
>> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
>> index a8d74a7..74d6557 100644
>> --- a/lib/swiotlb.c
>> +++ b/lib/swiotlb.c
>> @@ -30,6 +30,7 @@
>>   #include <linux/highmem.h>
>>   #include <linux/gfp.h>
>>   #include <linux/scatterlist.h>
>> +#include <linux/mem_encrypt.h>
>>   
>>   #include <asm/io.h>
>>   #include <asm/dma.h>
>> @@ -155,6 +156,17 @@ unsigned long swiotlb_size_or_default(void)
>>   	return size ? size : (IO_TLB_DEFAULT_SIZE);
>>   }
>>   
>> +void __weak swiotlb_set_mem_attributes(void *vaddr, unsigned long size)
>> +{
>> +}
> 
> As above.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

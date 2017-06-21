Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn3nam01on0041.outbound.protection.outlook.com
 ([104.47.33.41] helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dNhhr-0005s8-Ul
 for kexec@lists.infradead.org; Wed, 21 Jun 2017 15:38:13 +0000
Subject: Re: [PATCH v7 25/36] swiotlb: Add warnings for use of bounce buffers
 with SME
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185435.18967.26665.stgit@tlendack-t1.amdoffice.net>
 <20170621105026.lcbtkklaenyi2wqe@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <7b9f8b6d-60f2-0a78-b582-0821401d17eb@amd.com>
Date: Wed, 21 Jun 2017 10:37:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170621105026.lcbtkklaenyi2wqe@pd.tnic>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, linux-doc@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>

On 6/21/2017 5:50 AM, Borislav Petkov wrote:
> On Fri, Jun 16, 2017 at 01:54:36PM -0500, Tom Lendacky wrote:
>> Add warnings to let the user know when bounce buffers are being used for
>> DMA when SME is active.  Since the bounce buffers are not in encrypted
>> memory, these notifications are to allow the user to determine some
>> appropriate action - if necessary.  Actions can range from utilizing an
>> IOMMU, replacing the device with another device that can support 64-bit
>> DMA, ignoring the message if the device isn't used much, etc.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   include/linux/dma-mapping.h |   11 +++++++++++
>>   include/linux/mem_encrypt.h |    8 ++++++++
>>   lib/swiotlb.c               |    3 +++
>>   3 files changed, 22 insertions(+)
>>
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 4f3eece..ee2307e 100644
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
>> @@ -577,6 +578,11 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
>>   
>>   	if (!dev->dma_mask || !dma_supported(dev, mask))
>>   		return -EIO;
>> +
>> +	/* Since mask is unsigned, this can only be true if SME is active */
>> +	if (mask < sme_dma_mask())
>> +		dev_warn(dev, "SME is active, device will require DMA bounce buffers\n");
>> +
>>   	*dev->dma_mask = mask;
>>   	return 0;
>>   }
>> @@ -596,6 +602,11 @@ static inline int dma_set_coherent_mask(struct device *dev, u64 mask)
>>   {
>>   	if (!dma_supported(dev, mask))
>>   		return -EIO;
>> +
>> +	/* Since mask is unsigned, this can only be true if SME is active */
>> +	if (mask < sme_dma_mask())
>> +		dev_warn(dev, "SME is active, device will require DMA bounce buffers\n");
> 
> Looks to me like those two checks above need to be a:
> 
> void sme_check_mask(struct device *dev, u64 mask)
> {
>          if (!sme_me_mask)
>                  return;
> 
>          /* Since mask is unsigned, this can only be true if SME is active */
>          if (mask < (((u64)sme_me_mask << 1) - 1))
>                  dev_warn(dev, "SME is active, device will require DMA bounce buffers\n");
> }
> 
> which gets called and sme_dma_mask() is not really needed.

Makes a lot of sense, I'll update the patch.

Thanks,
Tom

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

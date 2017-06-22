Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bl2nam02on0048.outbound.protection.outlook.com
 ([104.47.38.48] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dO5IC-0000Ga-Vt
 for kexec@lists.infradead.org; Thu, 22 Jun 2017 16:49:19 +0000
Subject: Re: [PATCH v7 27/36] iommu/amd: Allow the AMD IOMMU to work with
 memory encryption
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185459.18967.72790.stgit@tlendack-t1.amdoffice.net>
 <20170622105637.g7twdaae2v5eaown@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <379702e6-31f1-2df1-8889-3498241aea49@amd.com>
Date: Thu, 22 Jun 2017 11:48:46 -0500
MIME-Version: 1.0
In-Reply-To: <20170622105637.g7twdaae2v5eaown@pd.tnic>
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

On 6/22/2017 5:56 AM, Borislav Petkov wrote:
> On Fri, Jun 16, 2017 at 01:54:59PM -0500, Tom Lendacky wrote:
>> The IOMMU is programmed with physical addresses for the various tables
>> and buffers that are used to communicate between the device and the
>> driver. When the driver allocates this memory it is encrypted. In order
>> for the IOMMU to access the memory as encrypted the encryption mask needs
>> to be included in these physical addresses during configuration.
>>
>> The PTE entries created by the IOMMU should also include the encryption
>> mask so that when the device behind the IOMMU performs a DMA, the DMA
>> will be performed to encrypted memory.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   drivers/iommu/amd_iommu.c       |   30 ++++++++++++++++--------------
>>   drivers/iommu/amd_iommu_init.c  |   34 ++++++++++++++++++++++++++++------
>>   drivers/iommu/amd_iommu_proto.h |   10 ++++++++++
>>   drivers/iommu/amd_iommu_types.h |    2 +-
>>   4 files changed, 55 insertions(+), 21 deletions(-)
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>
> 
> Btw, I'm assuming the virt_to_phys() difference on SME systems is only
> needed in a handful of places. Otherwise, I'd suggest changing the
> virt_to_phys() function/macro directly. But I guess most of the places
> need the real physical address without the enc bit.

Correct.

Thanks,
Tom

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

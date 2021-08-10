Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm6nam11on2046.outbound.protection.outlook.com
 ([40.107.223.46] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDYje-004tDS-Tc
 for kexec@lists.infradead.org; Tue, 10 Aug 2021 20:52:34 +0000
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org> <20210624092930.GA802261@MiWiFi-R3L-srv>
 <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
 <20210805065410.GA2051@MiWiFi-R3L-srv>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <5df93c4e-ffdd-88c5-db4a-1a09826d047a@amd.com>
Date: Tue, 10 Aug 2021 15:52:25 -0500
In-Reply-To: <20210805065410.GA2051@MiWiFi-R3L-srv>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, rientjes@google.com, rppt@linux.ibm.com, brijesh.singh@amd.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, m.szyprowski@samsung.com

On 8/5/21 1:54 AM, Baoquan He wrote:
> On 06/24/21 at 11:47am, Robin Murphy wrote:
>> On 2021-06-24 10:29, Baoquan He wrote:
>>> On 06/24/21 at 08:40am, Christoph Hellwig wrote:
>>>> So reduce the amount allocated.  But the pool is needed for proper
>>>> operation on systems with memory encryption.  And please add the right
>>>> maintainer or at least mailing list for the code you're touching next
>>>> time.
>>>
>>> Oh, I thoutht it's memory issue only, should have run
>>> ./scripts/get_maintainer.pl. sorry.
>>>
>>> About reducing the amount allocated, it may not help. Because on x86_64,
>>> kdump kernel doesn't put any page of memory into buddy allocator of DMA
>>> zone. Means it will defenitely OOM for atomic_pool_dma initialization.
>>>
>>> Wondering in which case or on which device the atomic pool is needed on
>>> AMD system with mem encrytion enabled. As we can see, the OOM will
>>> happen too in kdump kernel on Intel system, even though it's not
>>> necessary.
> 
> Sorry for very late response, and thank both for your comments.
> 
>>
>> Hmm, I think the Kconfig reshuffle has actually left a slight wrinkle here.
>> For DMA_DIRECT_REMAP=y we can assume an atomic pool is always needed, since
>> that was the original behaviour anyway. However the implications of
>> AMD_MEM_ENCRYPT=y are different - even if support is enabled, it still
>> should only be relevant if mem_encrypt_active(), so it probably does make
>> sense to have an additional runtime gate on that.
> 
>>
>> From a quick scan, use of dma_alloc_from_pool() already depends on
>> force_dma_unencrypted() so that's probably fine already, but I think we'd
>> need a bit of extra protection around dma_free_from_pool() to prevent
>> gen_pool_has_addr() dereferencing NULL if the pools are uninitialised, even
>> with your proposed patch as it is. Presumably nothing actually called
>> dma_direct_free() when you tested this?
> 
> Yes, enforcing the conditional check of force_dma_unencrypted() around
> dma_free_from_pool sounds reasonable, just as we have done in
> dma_alloc_from_pool().
> 
> I have tested this patchset on normal x86_64 systems and one amd system
> with SME support, disabling atomic pool can fix the issue that there's no
> managed pages in dma zone then requesting page from dma zone will cause
> allocation failure. And even disabling atomic pool in 1st kernel didn't
> cause any problem on one AMD EPYC system which supports SME. I am not
> expert of DMA area, wondering how atomic pool is supposed to do in
> SME/SEV system. 

I think the atomic pool is used by the NVMe driver. My understanding is
that driver will do a dma_alloc_coherent() from interrupt context, so it
needs to use GFP_ATOMIC. The pool was created because dma_alloc_coherent()
would perform a set_memory_decrypted() call, which can sleep. The pool
eliminates that issue (David can correct me if I got that wrong).

Thanks,
Tom

> 
> Besides, even though atomic pool is disabled, slub page for allocation
> of dma-kmalloc also triggers page allocation failure. So I change to
> take another way to fix them, please check v2 post. The atomic pool
> disabling an be a good to have change.
> 
> Thanks
> Baoquan
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

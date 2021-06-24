Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwMtb-00EE6S-2s
 for kexec@lists.infradead.org; Thu, 24 Jun 2021 10:47:44 +0000
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org> <20210624092930.GA802261@MiWiFi-R3L-srv>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
Date: Thu, 24 Jun 2021 11:47:31 +0100
MIME-Version: 1.0
In-Reply-To: <20210624092930.GA802261@MiWiFi-R3L-srv>
Content-Language: en-GB
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
To: Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, rientjes@google.com, rppt@linux.ibm.com, thomas.lendacky@amd.com, brijesh.singh@amd.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, m.szyprowski@samsung.com

On 2021-06-24 10:29, Baoquan He wrote:
> On 06/24/21 at 08:40am, Christoph Hellwig wrote:
>> So reduce the amount allocated.  But the pool is needed for proper
>> operation on systems with memory encryption.  And please add the right
>> maintainer or at least mailing list for the code you're touching next
>> time.
> 
> Oh, I thoutht it's memory issue only, should have run
> ./scripts/get_maintainer.pl. sorry.
> 
> About reducing the amount allocated, it may not help. Because on x86_64,
> kdump kernel doesn't put any page of memory into buddy allocator of DMA
> zone. Means it will defenitely OOM for atomic_pool_dma initialization.
> 
> Wondering in which case or on which device the atomic pool is needed on
> AMD system with mem encrytion enabled. As we can see, the OOM will
> happen too in kdump kernel on Intel system, even though it's not
> necessary.

Hmm, I think the Kconfig reshuffle has actually left a slight wrinkle 
here. For DMA_DIRECT_REMAP=y we can assume an atomic pool is always 
needed, since that was the original behaviour anyway. However the 
implications of AMD_MEM_ENCRYPT=y are different - even if support is 
enabled, it still should only be relevant if mem_encrypt_active(), so it 
probably does make sense to have an additional runtime gate on that.

 From a quick scan, use of dma_alloc_from_pool() already depends on 
force_dma_unencrypted() so that's probably fine already, but I think 
we'd need a bit of extra protection around dma_free_from_pool() to 
prevent gen_pool_has_addr() dereferencing NULL if the pools are 
uninitialised, even with your proposed patch as it is. Presumably 
nothing actually called dma_direct_free() when you tested this?

Robin.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

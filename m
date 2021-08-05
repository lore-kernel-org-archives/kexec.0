Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBXIS-008HhD-3w
 for kexec@lists.infradead.org; Thu, 05 Aug 2021 06:56:06 +0000
Date: Thu, 5 Aug 2021 14:54:10 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
Message-ID: <20210805065410.GA2051@MiWiFi-R3L-srv>
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org>
 <20210624092930.GA802261@MiWiFi-R3L-srv>
 <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
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
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, rientjes@google.com, rppt@linux.ibm.com, thomas.lendacky@amd.com, brijesh.singh@amd.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, m.szyprowski@samsung.com

On 06/24/21 at 11:47am, Robin Murphy wrote:
> On 2021-06-24 10:29, Baoquan He wrote:
> > On 06/24/21 at 08:40am, Christoph Hellwig wrote:
> > > So reduce the amount allocated.  But the pool is needed for proper
> > > operation on systems with memory encryption.  And please add the right
> > > maintainer or at least mailing list for the code you're touching next
> > > time.
> > 
> > Oh, I thoutht it's memory issue only, should have run
> > ./scripts/get_maintainer.pl. sorry.
> > 
> > About reducing the amount allocated, it may not help. Because on x86_64,
> > kdump kernel doesn't put any page of memory into buddy allocator of DMA
> > zone. Means it will defenitely OOM for atomic_pool_dma initialization.
> > 
> > Wondering in which case or on which device the atomic pool is needed on
> > AMD system with mem encrytion enabled. As we can see, the OOM will
> > happen too in kdump kernel on Intel system, even though it's not
> > necessary.

Sorry for very late response, and thank both for your comments.

> 
> Hmm, I think the Kconfig reshuffle has actually left a slight wrinkle here.
> For DMA_DIRECT_REMAP=y we can assume an atomic pool is always needed, since
> that was the original behaviour anyway. However the implications of
> AMD_MEM_ENCRYPT=y are different - even if support is enabled, it still
> should only be relevant if mem_encrypt_active(), so it probably does make
> sense to have an additional runtime gate on that.

> 
> From a quick scan, use of dma_alloc_from_pool() already depends on
> force_dma_unencrypted() so that's probably fine already, but I think we'd
> need a bit of extra protection around dma_free_from_pool() to prevent
> gen_pool_has_addr() dereferencing NULL if the pools are uninitialised, even
> with your proposed patch as it is. Presumably nothing actually called
> dma_direct_free() when you tested this?

Yes, enforcing the conditional check of force_dma_unencrypted() around
dma_free_from_pool sounds reasonable, just as we have done in
dma_alloc_from_pool().

I have tested this patchset on normal x86_64 systems and one amd system
with SME support, disabling atomic pool can fix the issue that there's no
managed pages in dma zone then requesting page from dma zone will cause
allocation failure. And even disabling atomic pool in 1st kernel didn't
cause any problem on one AMD EPYC system which supports SME. I am not
expert of DMA area, wondering how atomic pool is supposed to do in
SME/SEV system. 

Besides, even though atomic pool is disabled, slub page for allocation
of dma-kmalloc also triggers page allocation failure. So I change to
take another way to fix them, please check v2 post. The atomic pool
disabling an be a good to have change.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

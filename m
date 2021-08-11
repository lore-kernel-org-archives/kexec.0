Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDdu6-005Hnk-MW
 for kexec@lists.infradead.org; Wed, 11 Aug 2021 02:23:40 +0000
Date: Wed, 11 Aug 2021 10:23:27 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
Message-ID: <20210811022327.GF23322@MiWiFi-R3L-srv>
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org>
 <20210624092930.GA802261@MiWiFi-R3L-srv>
 <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
 <20210805065410.GA2051@MiWiFi-R3L-srv>
 <5df93c4e-ffdd-88c5-db4a-1a09826d047a@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5df93c4e-ffdd-88c5-db4a-1a09826d047a@amd.com>
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
To: Tom Lendacky <thomas.lendacky@amd.com>, rientjes@google.com
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, rppt@linux.ibm.com, brijesh.singh@amd.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, m.szyprowski@samsung.com

On 08/10/21 at 03:52pm, Tom Lendacky wrote:
> On 8/5/21 1:54 AM, Baoquan He wrote:
> > On 06/24/21 at 11:47am, Robin Murphy wrote:
> >> On 2021-06-24 10:29, Baoquan He wrote:
> >>> On 06/24/21 at 08:40am, Christoph Hellwig wrote:
> >>>> So reduce the amount allocated.  But the pool is needed for proper
> >>>> operation on systems with memory encryption.  And please add the right
> >>>> maintainer or at least mailing list for the code you're touching next
> >>>> time.
> >>>
> >>> Oh, I thoutht it's memory issue only, should have run
> >>> ./scripts/get_maintainer.pl. sorry.
> >>>
> >>> About reducing the amount allocated, it may not help. Because on x86_64,
> >>> kdump kernel doesn't put any page of memory into buddy allocator of DMA
> >>> zone. Means it will defenitely OOM for atomic_pool_dma initialization.
> >>>
> >>> Wondering in which case or on which device the atomic pool is needed on
> >>> AMD system with mem encrytion enabled. As we can see, the OOM will
> >>> happen too in kdump kernel on Intel system, even though it's not
> >>> necessary.
> > 
> > Sorry for very late response, and thank both for your comments.
> > 
> >>
> >> Hmm, I think the Kconfig reshuffle has actually left a slight wrinkle here.
> >> For DMA_DIRECT_REMAP=y we can assume an atomic pool is always needed, since
> >> that was the original behaviour anyway. However the implications of
> >> AMD_MEM_ENCRYPT=y are different - even if support is enabled, it still
> >> should only be relevant if mem_encrypt_active(), so it probably does make
> >> sense to have an additional runtime gate on that.
> > 
> >>
> >> From a quick scan, use of dma_alloc_from_pool() already depends on
> >> force_dma_unencrypted() so that's probably fine already, but I think we'd
> >> need a bit of extra protection around dma_free_from_pool() to prevent
> >> gen_pool_has_addr() dereferencing NULL if the pools are uninitialised, even
> >> with your proposed patch as it is. Presumably nothing actually called
> >> dma_direct_free() when you tested this?
> > 
> > Yes, enforcing the conditional check of force_dma_unencrypted() around
> > dma_free_from_pool sounds reasonable, just as we have done in
> > dma_alloc_from_pool().
> > 
> > I have tested this patchset on normal x86_64 systems and one amd system
> > with SME support, disabling atomic pool can fix the issue that there's no
> > managed pages in dma zone then requesting page from dma zone will cause
> > allocation failure. And even disabling atomic pool in 1st kernel didn't
> > cause any problem on one AMD EPYC system which supports SME. I am not
> > expert of DMA area, wondering how atomic pool is supposed to do in
> > SME/SEV system. 
> 
> I think the atomic pool is used by the NVMe driver. My understanding is
> that driver will do a dma_alloc_coherent() from interrupt context, so it
> needs to use GFP_ATOMIC. The pool was created because dma_alloc_coherent()
> would perform a set_memory_decrypted() call, which can sleep. The pool
> eliminates that issue (David can correct me if I got that wrong).

Thanks for the information.

While from the code comment around which atomic pool is requested,
on amd system it's used to satisfy decrypting memory because that
can't block. Combined with your saying, it's because NVMe driver
need decrypted memory on AMD system? 

void *dma_direct_alloc(struct device *dev, size_t size,
                dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
{
	......
        /*
         * Remapping or decrypting memory may block. If either is required and
         * we can't block, allocate the memory from the atomic pools.
         */
        if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
            !gfpflags_allow_blocking(gfp) &&
            (force_dma_unencrypted(dev) ||
             (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !dev_is_dma_coherent(dev))))
                return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
	......
}

Looking at the those related commits, the below one from David tells 
that atomic dma pool is used when device require non-blocking and
unencrypted buffer. When I checked the system I borrowed, it's AMD EYPC
and SME is enabled. And it has many pci devices, as you can see, its 'ls
pci' outputs 113 lines. But disabling the three atomic pools didn't
trigger any error on that AMD system. Does it mean only specific devices
need this atomic pool in SME/SEV enabling case? Should we add more
details in document or code comment to make clear this? 

commit 82fef0ad811fb5976cf36ccc3d2c3bc0195dfb72
Author: David Rientjes <rientjes@google.com>
Date:   Tue Apr 14 17:05:01 2020 -0700

    x86/mm: unencrypted non-blocking DMA allocations use coherent pools
    
    When CONFIG_AMD_MEM_ENCRYPT is enabled and a device requires unencrypted
    DMA, all non-blocking allocations must originate from the atomic DMA
    coherent pools.
    
    Select CONFIG_DMA_COHERENT_POOL for CONFIG_AMD_MEM_ENCRYPT.
    
    Signed-off-by: David Rientjes <rientjes@google.com>
    Signed-off-by: Christoph Hellwig <hch@lst.de>

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d6104ea8af0..2bf2222819d3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1520,6 +1520,7 @@ config X86_CPA_STATISTICS
 config AMD_MEM_ENCRYPT
        bool "AMD Secure Memory Encryption (SME) support"
        depends on X86_64 && CPU_SUP_AMD
+       select DMA_COHERENT_POOL
        select DYNAMIC_PHYSICAL_MASK
        select ARCH_USE_MEMREMAP_PROT
        select ARCH_HAS_FORCE_DMA_UNENCRYPTED


[~]# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              32
On-line CPU(s) list: 0-31
Thread(s) per core:  2
Core(s) per socket:  16
Socket(s):           1
NUMA node(s):        4
Vendor ID:           AuthenticAMD
BIOS Vendor ID:      AMD
CPU family:          23
Model:               1
Model name:          AMD EPYC 7351P 16-Core Processor
BIOS Model name:     AMD EPYC 7351P 16-Core Processor               
Stepping:            2
CPU MHz:             2395.439
BogoMIPS:            4790.87
Virtualization:      AMD-V
L1d cache:           32K
L1i cache:           64K
L2 cache:            512K
L3 cache:            8192K
......

[~]# lspci| wc -l
113

> 
> 
> > 
> > Besides, even though atomic pool is disabled, slub page for allocation
> > of dma-kmalloc also triggers page allocation failure. So I change to
> > take another way to fix them, please check v2 post. The atomic pool
> > disabling an be a good to have change.
> > 
> > Thanks
> > Baoquan
> > 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

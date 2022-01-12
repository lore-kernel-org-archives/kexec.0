From: john.p.donnelly@oracle.com <john.p.donnelly@oracle.com>
Date: Wed, 12 Jan 2022 10:25:42 -0600
Subject: [PATCH v4 0/3] Handle warning of allocation failure on DMA zone
 w/o managed pages
In-Reply-To: <20211223094435.248523-1-bhe@redhat.com>
References: <20211223094435.248523-1-bhe@redhat.com>
Message-ID: <57939078-f292-305a-b16d-6ab497ef2edd@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 12/23/21 3:44 AM, Baoquan He wrote:
> **Problem observed:
> On x86_64, when crash is triggered and entering into kdump kernel, page
> allocation failure can always be seen.
> 
>   ---------------------------------
>   DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
>   swapper/0: page allocation failure: order:5, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
>   CPU: 0 PID: 1 Comm: swapper/0
>   Call Trace:
>    dump_stack+0x7f/0xa1
>    warn_alloc.cold+0x72/0xd6
>    ......
>    __alloc_pages+0x24d/0x2c0
>    ......
>    dma_atomic_pool_init+0xdb/0x176
>    do_one_initcall+0x67/0x320
>    ? rcu_read_lock_sched_held+0x3f/0x80
>    kernel_init_freeable+0x290/0x2dc
>    ? rest_init+0x24f/0x24f
>    kernel_init+0xa/0x111
>    ret_from_fork+0x22/0x30
>   Mem-Info:
>   ------------------------------------
> 
> ***Root cause:
> In the current kernel, it assumes that DMA zone must have managed pages
> and try to request pages if CONFIG_ZONE_DMA is enabled. While this is not
> always true. E.g in kdump kernel of x86_64, only low 1M is presented and
> locked down at very early stage of boot, so that this low 1M won't be
> added into buddy allocator to become managed pages of DMA zone. This
> exception will always cause page allocation failure if page is requested
> from DMA zone.
> 
> ***Investigation:
> This failure happens since below commit merged into linus's tree.
>    1a6a9044b967 x86/setup: Remove CONFIG_X86_RESERVE_LOW and reservelow= options
>    23721c8e92f7 x86/crash: Remove crash_reserve_low_1M()
>    f1d4d47c5851 x86/setup: Always reserve the first 1M of RAM
>    7c321eb2b843 x86/kdump: Remove the backup region handling
>    6f599d84231f x86/kdump: Always reserve the low 1M when the crashkernel option is specified
> 
> Before them, on x86_64, the low 640K area will be reused by kdump kernel.
> So in kdump kernel, the content of low 640K area is copied into a backup
> region for dumping before jumping into kdump. Then except of those firmware
> reserved region in [0, 640K], the left area will be added into buddy
> allocator to become available managed pages of DMA zone.
> 
> However, after above commits applied, in kdump kernel of x86_64, the low
> 1M is reserved by memblock, but not released to buddy allocator. So any
> later page allocation requested from DMA zone will fail.
> 
> At the beginning, if crashkernel is reserved, the low 1M need be locked
> down because AMD SME encrypts memory making the old backup region
> mechanims impossible when switching into kdump kernel.
> 
> Later, it was also observed that there are BIOSes corrupting memory
> under 1M. To solve this, in commit f1d4d47c5851, the entire region of
> low 1M is always reserved after the real mode trampoline is allocated.
> 
> Besides, recently, Intel engineer mentioned their TDX (Trusted domain
> extensions) which is under development in kernel also needs to lock down
> the low 1M. So we can't simply revert above commits to fix the page allocation
> failure from DMA zone as someone suggested.
> 
> ***Solution:
> Currently, only DMA atomic pool and dma-kmalloc will initialize and
> request page allocation with GFP_DMA during bootup.
> 
> So only initializ DMA atomic pool when DMA zone has available managed
> pages, otherwise just skip the initialization.
> 
> For dma-kmalloc(), for the time being, let's mute the warning of
> allocation failure if requesting pages from DMA zone while no manged
> pages. Meanwhile, change code to use dma_alloc_xx/dma_map_xx API to
> replace kmalloc(GFP_DMA), or do not use GFP_DMA when calling kmalloc()
> if not necessary. Christoph is posting patches to fix those under
> drivers/scsi/. Finally, we can remove the need of dma-kmalloc() as
> people suggested.
> 
> Changelog:
> v3->v4:
>   - Split the old v3 into two separate patchset. The first two clean
>     up/improvement patches in v3 have been sent out in a independent
>     patchset. The fixes patchs are adapted and sent in this patchset.
>   - Do not change dma-kmalloc(), mute the warning of allocation failure
>     instead if it's requesting page from DMA zone which has no managed
>     pages.
> 
> v2-Resend -> v3:
>   - Re-implement has_managed_dma() according to David's suggestion.
>   - Add Fixes tag and cc stable.
> 
> v2->v2 RESEND:
>   - John pinged to push the repost of this patchset. So fix one typo of
>     suject of patch 3/5; Fix a building error caused by mix declaration in
>     patch 5/5. Both of them are found by John from his testing.
>   - Rewrite cover letter to add more information.
> 
> v1->v2:
>   Change to check if managed DMA zone exists. If DMA zone has managed
>   pages, go further to request page from DMA zone to initialize. Otherwise,
>   just skip to initialize stuffs which need pages from DMA zone.
> 
> v3:
> https://urldefense.com/v3/__https://lore.kernel.org/all/20211213122712.23805-1-bhe at redhat.com/T/*u__;Iw!!ACWV5N9M2RV99hQ!e1KjpVuZycBkxdeNxcsRUQ7MH92KQQk7FfCZs5tzEcBVusUiph0w9zpxOgKpS2Y0ecPm$
> 
> V2 RESEND post:
> https://urldefense.com/v3/__https://lore.kernel.org/all/20211207030750.30824-1-bhe at redhat.com/T/*u__;Iw!!ACWV5N9M2RV99hQ!e1KjpVuZycBkxdeNxcsRUQ7MH92KQQk7FfCZs5tzEcBVusUiph0w9zpxOgKpSzZmH18k$
> 
> v2 post:
> https://urldefense.com/v3/__https://lore.kernel.org/all/20210810094835.13402-1-bhe at redhat.com/T/*u__;Iw!!ACWV5N9M2RV99hQ!e1KjpVuZycBkxdeNxcsRUQ7MH92KQQk7FfCZs5tzEcBVusUiph0w9zpxOgKpS0Fbih0f$
> 
> v1 post:
> https://urldefense.com/v3/__https://lore.kernel.org/all/20210624052010.5676-1-bhe at redhat.com/T/*u__;Iw!!ACWV5N9M2RV99hQ!e1KjpVuZycBkxdeNxcsRUQ7MH92KQQk7FfCZs5tzEcBVusUiph0w9zpxOgKpSwc3nQBz$
> 
> 
> 
> Baoquan He (3):
>    mm_zone: add function to check if managed dma zone exists
>    dma/pool: create dma atomic pool only if dma zone has managed pages
>    mm/page_alloc.c: do not warn allocation failure on zone DMA if no
>      managed pages
> 
>   include/linux/mmzone.h |  9 +++++++++
>   kernel/dma/pool.c      |  4 ++--
>   mm/page_alloc.c        | 18 +++++++++++++++++-
>   3 files changed, 28 insertions(+), 3 deletions(-)
> 


Tested-by: John Donnelly

I don't see GFP malloc failures when the CD-ROM is enumerated anymore 
either when kdump kernel is started.

tested on 5.15.13.







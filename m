From: Baoquan He <bhe@redhat.com>
Date: Mon, 21 Feb 2022 11:22:58 +0800
Subject: [PATCH v20 2/5] arm64: kdump: introduce some macros for crash
 kernel reservation
In-Reply-To: <69da7ed5-4ef4-3655-8965-4181c7d7bf0b@huawei.com>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-3-thunder.leizhen@huawei.com>
 <YgY89RxkAl12n/dd@MiWiFi-R3L-srv>
 <69da7ed5-4ef4-3655-8965-4181c7d7bf0b@huawei.com>
Message-ID: <YhMFkgkqnZ4A3ysK@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 02/14/22 at 02:22pm, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/2/11 18:39, Baoquan He wrote:
> > On 01/24/22 at 04:47pm, Zhen Lei wrote:
> >> From: Chen Zhou <chenzhou10@huawei.com>
> >>
> >> Introduce macro CRASH_ALIGN for alignment, macro CRASH_ADDR_LOW_MAX
> >> for upper bound of low crash memory, macro CRASH_ADDR_HIGH_MAX for
> >> upper bound of high crash memory, use macros instead.
> >>
> >> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> >> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> >> ---
> >>  arch/arm64/mm/init.c | 11 ++++++++---
> >>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index 90f276d46b93bc6..6c653a2c7cff052 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -65,6 +65,12 @@ EXPORT_SYMBOL(memstart_addr);
> >>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
> >>  
> >>  #ifdef CONFIG_KEXEC_CORE
> >> +/* Current arm64 boot protocol requires 2MB alignment */
> >> +#define CRASH_ALIGN		SZ_2M
> >> +
> >> +#define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
> >> +#define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
> > 
> > MEMBLOCK_ALLOC_ACCESSIBLE is obvoiously a alloc flag for memblock
> > allocator, I don't think it's appropriate to make HIGH_MAX get its value.
> 
> Right, thanks.
> 
> > You can make it as memblock.current_limit, or do not define it, but using
> > MEMBLOCK_ALLOC_ACCESSIBLE direclty in memblock_phys_alloc_range() with
> > a code comment. 
> 
> This patch is not required at present. These macros are added to eliminate
> differences to share code with x86.

So this patch may not be needed in this series. It can be added in
another post when you start to do the clean up and code unification
among ARCHes, with my udnerstanding. At that time you can consider how
to abstract the common code to handle the difference.



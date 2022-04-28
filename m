From: Baoquan He <bhe@redhat.com>
Date: Thu, 28 Apr 2022 11:52:38 +0800
Subject: [PATCH v22 5/9] arm64: kdump: Reimplement crashkernel=X
In-Reply-To: <YmoMvV1wzHT5V1aw@MiWiFi-R3L-srv>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-6-thunder.leizhen@huawei.com>
 <YmgzxsrrMlCDYsWp@arm.com>
 <ee8daaa9-3258-e7e8-e5c4-c51dc9841580@huawei.com>
 <Ymk34NsIFqUgfk3b@arm.com>
 <ae7211ad-e2ac-f5b1-5aa0-701802132e73@huawei.com>
 <YmlphvZVMsGfFksp@arm.com> <YmoMvV1wzHT5V1aw@MiWiFi-R3L-srv>
Message-ID: <YmoPhvkXQFZQOcIO@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 04/28/22 at 11:40am, Baoquan He wrote:
> Hi Catalin, Zhen Lei,
> 
> On 04/27/22 at 05:04pm, Catalin Marinas wrote:
> > On Wed, Apr 27, 2022 at 09:49:20PM +0800, Leizhen (ThunderTown) wrote:
> > > On 2022/4/27 20:32, Catalin Marinas wrote:
> > > > I think one could always pass a default command line like:
> > > > 
> > > > 	crashkernel=1G,high crashkernel=128M,low
> > > > 
> > > > without much knowledge of the SoC memory layout.
> > > 
> > > Yes, that's what the end result is. The user specify crashkernel=128M,low
> > > and the implementation ensure the 128M low memory is allocated from DMA zone.
> > > We use arm64_dma_phys_limit as the upper limit for crash low memory.
> > > 
> > > +#define CRASH_ADDR_LOW_MAX             arm64_dma_phys_limit
> > > +       unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> > > +       crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> > >                                                crash_base, crash_max);
> > > 
> > > > Another option is to only introduce crashkernel=Y,low and, when that is
> > > > passed, crashkernel=Y can go above arm64_dma_phys_limit. We won't need a
> > > > 'high' option at all:
> > > > 
> > > > 	crashkernel=1G				- all within ZONE_DMA
> > > > 	crashkernel=1G crashkernel=128M,low	- 128M in ZONE_DMA
> > > > 						  1G above ZONE_DMA
> > > > 
> > > > If ZONE_DMA is not present or it extends to the whole RAM, we can ignore
> > > > the 'low' option.
> > > 
> > > I think although the code is hard to make generic, the interface is better to
> > > be relatively uniform. A user might have to maintain both x86 and arm64, and
> > > so on. It's not a good thing that the difference is too big.
> > 
> > There will be some difference as the 4G limit doesn't always hold for
> > arm64 (though it's true in most cases). Anyway, we can probably simplify
> > things a bit while following the documented behaviour:
> > 
> > 	crashkernel=Y		- current behaviour within ZONE_DMA
> > 	crashkernel=Y,high	- allocate from above ZONE_DMA
> > 	crashkernel=Y,low	- allocate within ZONE_DMA
> > 
> > There is no fallback from crashkernel=Y.
> > 
> > The question is whether we still want a default low allocation if
> > crashkernel=Y,low is missing but 'high' is present. If we add this, I
> > think we'd be consistent with kernel-parameters.txt for the 'low'
> > description. A default 'low' is probably not that bad but I'm tempted to
> > always mandate both 'high' and 'low'.
> 
> Sorry to interrupt. Seems the ,high ,low and fallback are main concerns
> about this version. And I have the same concerns about them which comes
> from below points:
> 1) we may need to take best effort to keep ,high, ,low behaviour
> consistent on all ARCHes. Otherwise user/admin may be confused when they
> deploy/configure kdump on different machines of different ARCHes in the
> same LAB. I think we should try to avoid the confusion.
> 2) Fallback behaviour is important to our distros. The reason is we will
> provide default value with crashkernel=xxxM along kernel of distros. In
> this case, we hope the reservation will succeed by all means. The ,high
> and ,low is an option if customer likes to take with expertise.
> 
> After going through arm64 memory init code, I got below summary about
> arm64_dma_phys_limit which is the first zone's upper limit. I think we
> can make use of it to facilitate to simplify code.
> ================================================================================
>                         DMA                      DMA32                    NORMAL
> 1)Raspberry Pi4         0~1G                     3G~4G                    (above 4G)
> 2)Normal machine        0~4G                     0                        (above 4G)
> 3)Special machine       (above 4G)~MAX
> 4)No DMA|DMA32                                                            (above 4G)~MAX
> 
> -------------------------------------------
>                       arm64_dma_phys_limit
> 1)Raspberry Pi4         1G                     
> 2)Normal machine        4G                     
> 3)Special machine       MAX
> 4)No DMA|DMA32          MAX
> 
> Note: 3)Special machine means the machine's starting physical address is above 4G.
> WHile 4)No DMA|DMA32 means kernel w/o CONFIG_ZONE_DMA|DMA32, and has
> IOMMU hardware supporting.
> ===================================================================================
> 
> I made a draft patch based on this patchset, please feel free to check and
> see if it's OK, or anything missing or wrongly understood. I removed
> reserve_crashkernel_high() and only keep reserve_crashkernel() and
> reserve_crashkernel_low() as the v21 did.

Sorry, forgot attaching the draft patch.

By the way, we can also have a simple version with basic ,high, ,low
support, no fallback. We can add fallback and other optimization later.
This can be plan B.


-------------- next part --------------
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 4a8200f29b35..aa1fbea47c46 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -84,11 +84,7 @@ EXPORT_SYMBOL(memstart_addr);
  * Note: Page-granularity mappings are necessary for crash kernel memory
  * range for shrinking its size via /sys/kernel/kexec_crash_size interface.
  */
-#if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
 phys_addr_t __ro_after_init arm64_dma_phys_limit;
-#else
-phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
-#endif
 
 bool crash_low_mem_page_map __initdata;
 static bool crash_high_mem_reserved __initdata;
@@ -132,63 +128,6 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 	return 0;
 }
 
-static void __init reserve_crashkernel_high(void)
-{
-	unsigned long long crash_base, crash_size;
-	char *cmdline = boot_command_line;
-	int ret;
-
-	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
-		return;
-
-	/* crashkernel=X[@offset] */
-	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
-				&crash_size, &crash_base);
-	if (ret || !crash_size) {
-		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
-		if (ret || !crash_size)
-			return;
-	} else if (!crash_base) {
-		crash_low_mem_page_map = true;
-	}
-
-	crash_size = PAGE_ALIGN(crash_size);
-
-	/*
-	 * For the case crashkernel=X, may fall back to reserve memory above
-	 * 4G, make reservations here in advance. It will be released later if
-	 * the region is successfully reserved under 4G.
-	 */
-	if (!crash_base) {
-		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
-						       crash_base, CRASH_ADDR_HIGH_MAX);
-		if (!crash_base)
-			return;
-
-		crash_high_mem_reserved = true;
-	}
-
-	/* Mark the memory range that requires page-level mappings */
-	crashk_res.start = crash_base;
-	crashk_res.end   = crash_base + crash_size - 1;
-}
-
-static void __init hand_over_reserved_high_mem(void)
-{
-	crashk_res_high.start = crashk_res.start;
-	crashk_res_high.end   = crashk_res.end;
-
-	crashk_res.start = 0;
-	crashk_res.end   = 0;
-}
-
-static void __init take_reserved_high_mem(unsigned long long *crash_base,
-					  unsigned long long *crash_size)
-{
-	*crash_base = crashk_res_high.start;
-	*crash_size = resource_size(&crashk_res_high);
-}
-
 static void __init free_reserved_high_mem(void)
 {
 	memblock_phys_free(crashk_res_high.start, resource_size(&crashk_res_high));
@@ -225,7 +164,8 @@ static void __init reserve_crashkernel(void)
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
-	hand_over_reserved_high_mem();
+	if (crashk_res.end)
+		return;
 
 	/* crashkernel=X[@offset] */
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
@@ -245,11 +185,6 @@ static void __init reserve_crashkernel(void)
 
 		high = true;
 		crash_max = CRASH_ADDR_HIGH_MAX;
-
-		if (crash_high_mem_reserved) {
-			take_reserved_high_mem(&crash_base, &crash_size);
-			goto reserve_low;
-		}
 	}
 
 	fixed_base = !!crash_base;
@@ -267,12 +202,8 @@ static void __init reserve_crashkernel(void)
 		 * to high memory, the minimum required low memory will be
 		 * reserved later.
 		 */
-		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
-			if (crash_high_mem_reserved) {
-				take_reserved_high_mem(&crash_base, &crash_size);
-				goto reserve_low;
-			}
-
+		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX
+		    && crash_max <CRASH_ADDR_HIGH_MAX)) {
 			crash_max = CRASH_ADDR_HIGH_MAX;
 			goto retry;
 		}
@@ -289,7 +220,7 @@ static void __init reserve_crashkernel(void)
 	 * description of "crashkernel=X,high" option, add below 'high'
 	 * condition to make sure the crash low memory will be reserved.
 	 */
-	if ((crash_base >= CRASH_ADDR_LOW_MAX) || high) {
+	if (crash_base >= CRASH_ADDR_LOW_MAX ) {
 reserve_low:
 		/* case #3 of crashkernel,low reservation */
 		if (!high)
@@ -299,14 +230,7 @@ static void __init reserve_crashkernel(void)
 			memblock_phys_free(crash_base, crash_size);
 			return;
 		}
-	} else if (crash_high_mem_reserved) {
-		/*
-		 * The crash memory is successfully allocated under 4G, and the
-		 * previously reserved high memory is no longer required.
-		 */
-		free_reserved_high_mem();
 	}
-
 	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
 		crash_base, crash_base + crash_size, crash_size >> 20);
 
@@ -520,10 +444,10 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
+	arm64_dma_phys_limit = memblock_end_of_DRAM();
+
 	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
 		reserve_crashkernel();
-	else
-		reserve_crashkernel_high();
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }

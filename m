Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBeKw-00010o-Jk
 for kexec@lists.infradead.org; Wed, 03 Apr 2019 11:45:48 +0000
Received: by mail-pf1-f193.google.com with SMTP id z5so7011627pfn.3
 for <kexec@lists.infradead.org>; Wed, 03 Apr 2019 04:45:46 -0700 (PDT)
Subject: Re: [PATCH 2/9] arm64: mm: Flip kernel VA space
References: <20190218170245.14915-1-steve.capper@arm.com>
 <20190218170245.14915-3-steve.capper@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <407534e2-75c0-49fe-2873-4526dd75bc02@redhat.com>
Date: Wed, 3 Apr 2019 17:14:53 +0530
MIME-Version: 1.0
In-Reply-To: <20190218170245.14915-3-steve.capper@arm.com>
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
To: Steve Capper <steve.capper@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: crecklin@redhat.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, James Morse <james.morse@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Steve,

On 02/18/2019 10:32 PM, Steve Capper wrote:
> Put the direct linear map in the lower addresses of the kernel VA range
> and everything else in the higher ranges.
> 
> This allows us to make room for an inline KASAN shadow that operates
> under both 48 and 52 bit kernel VA sizes. For example with a 52-bit VA,
> if KASAN_SHADOW_END < 0xFFF8000000000000 (it is in the lower addresses
> of the kernel VA range), this will be below the start of the minimum
> 48-bit kernel VA address of 0xFFFF000000000000.
> 
> We need to adjust:
>   *) KASAN shadow region placement logic,
>   *) KASAN_SHADOW_OFFSET computation logic,
>   *) virt_to_phys, phys_to_virt checks,
>   *) page table dumper.
> 
> These are all small changes, that need to take place atomically, so they
> are bundled into this commit.

May be its a good opportunity to update the memory layout documentation 
(see [0]) with this patch, where we say:

AArch64 Linux memory layout with 64KB pages + 3 levels:

Start			End			Size		Use
-----------------------------------------------------------------------
0000000000000000	0000ffffffffffff	 256TB		user
ffff000000000000	ffffffffffffffff	 256TB		kernel

Now, with 52-bit addressing capabilities the kernel space would start 
from 0xFFF0_0000_0000_0000 and go all the way up to 0xFFFF_FFFF_FFFF_FFFF.

Also the 'Translation table lookup with 64KB pages:' section needs an 
update to indicate increased bits for 52-bit PA changes.

Alternatively we may want to have a doc dedicated to 52-bit address 
space details on arm64, similar to what we have currently for x86 (see 
[1a] and [1b]) where we can capture some of the details already 
available in your excellent talk on this subject (see [2]).

If you need any help with the same, do let me know.

[0]. https://www.kernel.org/doc/Documentation/arm64/memory.txt
[1a]. 
https://github.com/torvalds/linux/blob/master/Documentation/x86/x86_64/5level-paging.txt
[1b]. 
https://github.com/torvalds/linux/blob/master/Documentation/x86/x86_64/mm.txt
[2]. https://connect.linaro.org/resources/yvr18/sessions/yvr18-119/

Thanks,
Bhupesh

> Signed-off-by: Steve Capper <steve.capper@arm.com>
> ---
>   arch/arm64/Makefile              |  2 +-
>   arch/arm64/include/asm/memory.h  | 10 +++++-----
>   arch/arm64/include/asm/pgtable.h |  2 +-
>   arch/arm64/mm/dump.c             |  8 ++++----
>   arch/arm64/mm/init.c             |  9 +--------
>   arch/arm64/mm/kasan_init.c       |  6 +++---
>   arch/arm64/mm/mmu.c              |  4 ++--
>   7 files changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index b025304bde46..2dad2ae6b181 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -115,7 +115,7 @@ KBUILD_AFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
>   #				 - (1 << (64 - KASAN_SHADOW_SCALE_SHIFT))
>   # in 32-bit arithmetic
>   KASAN_SHADOW_OFFSET := $(shell printf "0x%08x00000000\n" $$(( \
> -	(0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 32))) \
> +	(0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 1 - 32))) \
>   	+ (1 << ($(CONFIG_ARM64_VA_BITS) - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) \
>   	- (1 << (64 - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) )) )
>   
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 617071dbad06..46a7aba44e9b 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -49,10 +49,10 @@
>    */
>   #define VA_BITS			(CONFIG_ARM64_VA_BITS)
>   #define VA_START		(UL(0xffffffffffffffff) - \
> -	(UL(1) << VA_BITS) + 1)
> -#define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
>   	(UL(1) << (VA_BITS - 1)) + 1)
> -#define PAGE_OFFSET_END		(~0UL)
> +#define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
> +	(UL(1) << VA_BITS) + 1)
> +#define PAGE_OFFSET_END		(VA_START)
>   #define KIMAGE_VADDR		(MODULES_END)
>   #define BPF_JIT_REGION_START	(VA_START + KASAN_SHADOW_SIZE)
>   #define BPF_JIT_REGION_SIZE	(SZ_128M)
> @@ -60,7 +60,7 @@
>   #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
>   #define MODULES_VADDR		(BPF_JIT_REGION_END)
>   #define MODULES_VSIZE		(SZ_128M)
> -#define VMEMMAP_START		(PAGE_OFFSET - VMEMMAP_SIZE)
> +#define VMEMMAP_START		(-VMEMMAP_SIZE)
>   #define PCI_IO_END		(VMEMMAP_START - SZ_2M)
>   #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
>   #define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
> @@ -243,7 +243,7 @@ extern u64			vabits_user;
>    * space. Testing the top bit for the start of the region is a
>    * sufficient check.
>    */
> -#define __is_lm_address(addr)	(!!((addr) & BIT(VA_BITS - 1)))
> +#define __is_lm_address(addr)	(!((addr) & BIT(VA_BITS - 1)))
>   
>   #define __lm_to_phys(addr)	(((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
>   #define __kimg_to_phys(addr)	((addr) - kimage_voffset)
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index de70c1eabf33..766def2ed788 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -32,7 +32,7 @@
>    *	and fixed mappings
>    */
>   #define VMALLOC_START		(MODULES_END)
> -#define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
> +#define VMALLOC_END		(- PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
>   
>   #define vmemmap			((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
>   
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index 99bb8facb5cb..3dd9b884bd39 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -30,6 +30,8 @@
>   #include <asm/ptdump.h>
>   
>   static const struct addr_marker address_markers[] = {
> +	{ PAGE_OFFSET,			"Linear Mapping start" },
> +	{ VA_START,			"Linear Mapping end" },
>   #ifdef CONFIG_KASAN
>   	{ KASAN_SHADOW_START,		"Kasan shadow start" },
>   	{ KASAN_SHADOW_END,		"Kasan shadow end" },
> @@ -43,10 +45,8 @@ static const struct addr_marker address_markers[] = {
>   	{ PCI_IO_START,			"PCI I/O start" },
>   	{ PCI_IO_END,			"PCI I/O end" },
>   #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -	{ VMEMMAP_START,		"vmemmap start" },
> -	{ VMEMMAP_START + VMEMMAP_SIZE,	"vmemmap end" },
> +	{ VMEMMAP_START,		"vmemmap" },
>   #endif
> -	{ PAGE_OFFSET,			"Linear mapping" },
>   	{ -1,				NULL },
>   };
>   
> @@ -380,7 +380,7 @@ static void ptdump_initialize(void)
>   static struct ptdump_info kernel_ptdump_info = {
>   	.mm		= &init_mm,
>   	.markers	= address_markers,
> -	.base_addr	= VA_START,
> +	.base_addr	= PAGE_OFFSET,
>   };
>   
>   void ptdump_check_wx(void)
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 7205a9085b4d..0574e17fd28d 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -354,7 +354,7 @@ static void __init fdt_enforce_memory_region(void)
>   
>   void __init arm64_memblock_init(void)
>   {
> -	const s64 linear_region_size = -(s64)PAGE_OFFSET;
> +	const s64 linear_region_size = BIT(VA_BITS - 1);
>   
>   	/* Handle linux,usable-memory-range property */
>   	fdt_enforce_memory_region();
> @@ -362,13 +362,6 @@ void __init arm64_memblock_init(void)
>   	/* Remove memory above our supported physical address size */
>   	memblock_remove(1ULL << PHYS_MASK_SHIFT, ULLONG_MAX);
>   
> -	/*
> -	 * Ensure that the linear region takes up exactly half of the kernel
> -	 * virtual address space. This way, we can distinguish a linear address
> -	 * from a kernel/module/vmalloc address by testing a single bit.
> -	 */
> -	BUILD_BUG_ON(linear_region_size != BIT(VA_BITS - 1));
> -
>   	/*
>   	 * Select a suitable value for the base of physical memory.
>   	 */
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 4b55b15707a3..ee5ec343d009 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -219,10 +219,10 @@ void __init kasan_init(void)
>   	kasan_map_populate(kimg_shadow_start, kimg_shadow_end,
>   			   early_pfn_to_nid(virt_to_pfn(lm_alias(_text))));
>   
> -	kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
> -				    (void *)mod_shadow_start);
> +	kasan_populate_early_shadow(kasan_mem_to_shadow((void *) VA_START),
> +				   (void *)mod_shadow_start);
>   	kasan_populate_early_shadow((void *)kimg_shadow_end,
> -				    kasan_mem_to_shadow((void *)PAGE_OFFSET));
> +				   (void *)KASAN_SHADOW_END);
>   
>   	if (kimg_shadow_start > mod_shadow_end)
>   		kasan_populate_early_shadow((void *)mod_shadow_end,
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b6f5aa52ac67..7401a8481f78 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -389,7 +389,7 @@ static phys_addr_t pgd_pgtable_alloc(void)
>   static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
>   				  phys_addr_t size, pgprot_t prot)
>   {
> -	if (virt < VMALLOC_START) {
> +	if ((virt >= VA_START) && (virt < VMALLOC_START)) {
>   		pr_warn("BUG: not creating mapping for %pa at 0x%016lx - outside kernel range\n",
>   			&phys, virt);
>   		return;
> @@ -416,7 +416,7 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>   static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
>   				phys_addr_t size, pgprot_t prot)
>   {
> -	if (virt < VMALLOC_START) {
> +	if ((virt >= VA_START) && (virt < VMALLOC_START)) {
>   		pr_warn("BUG: not updating mapping for %pa at 0x%016lx - outside kernel range\n",
>   			&phys, virt);
>   		return;
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

From: Frank van der Linden <fllinden@amazon.com>
Date: Fri, 14 Jan 2022 23:27:29 +0000
Subject: [PATCH 1/3] memblock: define functions to set the usable memory
 range
In-Reply-To: <YeBiV8fuCCLWyHYb@kernel.org>
References: <20220110210809.3528-1-fllinden@amazon.com>
 <20220110210809.3528-2-fllinden@amazon.com> <Yd1cnquQFZoNE7FP@kernel.org>
 <20220111204441.GA36458@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
 <YeBiV8fuCCLWyHYb@kernel.org>
Message-ID: <20220114232729.GA35066@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, Jan 13, 2022 at 07:33:11PM +0200, Mike Rapoport wrote:
> On Tue, Jan 11, 2022 at 08:44:41PM +0000, Frank van der Linden wrote:
> > On Tue, Jan 11, 2022 at 12:31:58PM +0200, Mike Rapoport wrote:
> > > > --- a/include/linux/memblock.h
> > > > +++ b/include/linux/memblock.h
> > > > @@ -481,6 +481,8 @@ phys_addr_t memblock_reserved_size(void);
> > > >  phys_addr_t memblock_start_of_DRAM(void);
> > > >  phys_addr_t memblock_end_of_DRAM(void);
> > > >  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> > > > +void memblock_set_usable_range(phys_addr_t base, phys_addr_t size);
> > > > +void memblock_enforce_usable_range(void);
> > > >  void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
> > > >  void memblock_mem_limit_remove_map(phys_addr_t limit);
> > >
> > > We already have 3 very similar interfaces that deal with memory capping.
> > > Now you suggest to add fourth that will "generically" solve a single use
> > > case of DT, EFI and kdump interaction on arm64.
> > >
> > > Looks like a workaround for a fundamental issue of incompatibility between
> > > DT and EFI wrt memory registration.
> >
> > Yep, I figured this would be the main argument against this - arm64
> > already added several other more-or-less special cased interfaces over
> > time.
> >
> > I'm more than happy to solve this in a different way.
> >
> > What would you suggest:
> >
> > 1) Try to merge the similar interfaces in to one.
> > 2) Just deal with it at a lower (arm64) level?
> > 3) Some other way?
> 
> We've discussed this with Ard on IRC, and our conclusion was that on arm64
> kdump kernel should have memblock.memory exactly the same as the normal
> kernel. Then, the memory outside usable-memory-range should be reserved so
> that kdump kernel won't step over it.
> 
> With that, simple (untested) patch below could be what we need:
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bdca35284ceb..371418dffaf1 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1275,7 +1275,8 @@ void __init early_init_dt_scan_nodes(void)
>         of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> 
>         /* Handle linux,usable-memory-range property */
> -       memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
> +       memblock_reserve(0, cap_mem_addr);
> +       memblock_reserve(cap_mem_addr + cap_mem_size, PHYS_ADDR_MAX);
>  }
> 
>  bool __init early_init_dt_scan(void *params)

Ok, tested this on 5.17-rc, and it's working OK there. Main kernel has
32G, crash kernel gets 512M:

Main kernel:

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000000b96ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000786effff]
[    0.000000]   node   0: [mem 0x00000000786f0000-0x000000007872ffff]
[    0.000000]   node   0: [mem 0x0000000078730000-0x000000007bbfffff]
[    0.000000]   node   0: [mem 0x000000007bc00000-0x000000007bfdffff]
[    0.000000]   node   0: [mem 0x000000007bfe0000-0x000000007fffffff]
[    0.000000]   node   0: [mem 0x0000000400000000-0x0000000b96ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x0000000b96ffffff]
[    0.000000] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.000000] cma: Reserved 64 MiB at 0x000000007c000000
[    0.000000] crashkernel reserved: 0x0000000054400000 - 0x0000000074400000 (512 MB)


Crash kernel:

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000054400000-0x000000007bfdffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000054400000-0x00000000743fffff]
[    0.000000]   node   0: [mem 0x00000000786f0000-0x000000007872ffff]
[    0.000000]   node   0: [mem 0x000000007bc00000-0x000000007bfdffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000054400000-0x000000007bfdffff]
[    0.000000] On node 0, zone DMA: 17408 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 17136 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 13520 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 16416 pages in unavailable ranges

Not sure why I had trouble with the same on 5.15, I'll have to look
at that again. But this seems fine for 5.16+

Thanks,

- Frank


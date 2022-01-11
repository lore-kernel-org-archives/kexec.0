From: Frank van der Linden <fllinden@amazon.com>
Date: Tue, 11 Jan 2022 20:44:41 +0000
Subject: [PATCH 1/3] memblock: define functions to set the usable memory
 range
In-Reply-To: <Yd1cnquQFZoNE7FP@kernel.org>
References: <20220110210809.3528-1-fllinden@amazon.com>
 <20220110210809.3528-2-fllinden@amazon.com> <Yd1cnquQFZoNE7FP@kernel.org>
Message-ID: <20220111204441.GA36458@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, Jan 11, 2022 at 12:31:58PM +0200, Mike Rapoport wrote:
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -481,6 +481,8 @@ phys_addr_t memblock_reserved_size(void);
> >  phys_addr_t memblock_start_of_DRAM(void);
> >  phys_addr_t memblock_end_of_DRAM(void);
> >  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> > +void memblock_set_usable_range(phys_addr_t base, phys_addr_t size);
> > +void memblock_enforce_usable_range(void);
> >  void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
> >  void memblock_mem_limit_remove_map(phys_addr_t limit);
> 
> We already have 3 very similar interfaces that deal with memory capping.
> Now you suggest to add fourth that will "generically" solve a single use
> case of DT, EFI and kdump interaction on arm64.
> 
> Looks like a workaround for a fundamental issue of incompatibility between
> DT and EFI wrt memory registration.

Yep, I figured this would be the main argument against this - arm64
already added several other more-or-less special cased interfaces over
time.

I'm more than happy to solve this in a different way.

What would you suggest:

1) Try to merge the similar interfaces in to one.
2) Just deal with it at a lower (arm64) level?
3) Some other way?

Thanks,

- Frank


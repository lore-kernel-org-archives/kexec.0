Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fIBiA-0000uL-Aj
 for kexec@lists.infradead.org; Mon, 14 May 2018 11:32:19 +0000
Date: Mon, 14 May 2018 08:31:55 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: Re: [PATCH makedumpfile] handle mem_section as either a pointer or
 an array
Message-ID: <20180514113154.GC3402@calabresa>
References: <20180219200459.27159-1-cascardo@canonical.com>
 <20180302143316.GG5441@siri.cascardo.eti.br>
 <61D4E5D821F1674CB87C99F080A210BE01180726@BPXM01GP.gisp.nec.co.jp>
 <61D4E5D821F1674CB87C99F080A210BE011ABB43@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61D4E5D821F1674CB87C99F080A210BE011ABB43@BPXM01GP.gisp.nec.co.jp>
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
To: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Keiichi Nakamura <kei-nakamura@vt.jp.nec.com>

On Mon, May 14, 2018 at 07:40:21AM +0000, Masaki Tachibana wrote:
> Hi Thadeu,
> 
> So sorry for the late reply.
> I will merge the patch into V1.6.4 with the following modifying 
> because I have already accepted "Always use bigger SECTION_MAP_MASK" patch.
> 
> 63,68c63,64
> <       if (info->kernel_version < KERNEL_VERSION(4, 13, 0))
> < -             map &= SECTION_MAP_MASK_4_12;
> < +             mask = SECTION_MAP_MASK_4_12;
> <       else
> < -             map &= SECTION_MAP_MASK;
> < +             mask = SECTION_MAP_MASK;
> ---
> > -     map &= SECTION_MAP_MASK;
> > +     mask = SECTION_MAP_MASK;
> 

Ack. That should be enough for a fixup.
Thanks.
Cascardo.

> 
> Thanks
> Tachibana
> 
> > -----Original Message-----
> > From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Masaki Tachibana
> > Sent: Monday, March 05, 2018 6:16 PM
> > To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> > Cc: Hayashi Masahiko() <mas-hayashi@tg.jp.nec.com>; kexec@lists.infradead.org
> > Subject: RE: [PATCH makedumpfile] handle mem_section as either a pointer or an array
> > 
> > Hi Thadeu,
> > 
> > Sorry for the late reply.
> > "handle mem_section as either a pointer or an array" patch and
> > "Always use bigger SECTION_MAP_MASK" patch modify the same line.
> > I would like to reply about both patches by the end of the next week.
> > 
> > 
> > Thanks
> > Tachibana
> > 
> > 
> > > -----Original Message-----
> > > From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Thadeu Lima de Souza Cascardo
> > > Sent: Friday, March 02, 2018 11:33 PM
> > > To: kexec@lists.infradead.org
> > > Subject: Re: [PATCH makedumpfile] handle mem_section as either a pointer or an array
> > >
> > > Any comments or reviews on the patch below?
> > >
> > > Thanks.
> > > Cascardo.
> > >
> > > On Mon, Feb 19, 2018 at 05:04:59PM -0300, Thadeu Lima de Souza Cascardo wrote:
> > > > Some kernel versions that have been recently shipped have mem_section point to
> > > > a pointer to the array, instead of pointing directly to the array. That only
> > > > happens on SPARSEMEM_EXTREME configurations.
> > > >
> > > > As dwarf information might not be present that would have allowed us to detect
> > > > which type it is, we need to try it either as an array or as the pointer to the
> > > > array. Then, we validate all section_mem_map: they must either be present or
> > > > null. If any problems are found when traversing it, consider it invalid. Only
> > > > one way may be valid. Otherwise, fail.
> > > >
> > > > This has been tested with both types of kernels and succeeded in producing a
> > > > compressed dump that could be analyzed with crash 7.2.1.
> > > >
> > > > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> > > > ---
> > > >  makedumpfile.c | 153 +++++++++++++++++++++++++++++++++++++++++++--------------
> > > >  makedumpfile.h |   1 +
> > > >  2 files changed, 118 insertions(+), 36 deletions(-)
> > > >
> > > > diff --git a/makedumpfile.c b/makedumpfile.c
> > > > index ed138d3..cd3fa4d 100644
> > > > --- a/makedumpfile.c
> > > > +++ b/makedumpfile.c
> > > > @@ -3297,7 +3297,7 @@ get_mm_discontigmem(void)
> > > >  	return TRUE;
> > > >  }
> > > >
> > > > -unsigned long
> > > > +static unsigned long
> > > >  nr_to_section(unsigned long nr, unsigned long *mem_sec)
> > > >  {
> > > >  	unsigned long addr;
> > > > @@ -3311,17 +3311,17 @@ nr_to_section(unsigned long nr, unsigned long *mem_sec)
> > > >  		addr = SYMBOL(mem_section) + (nr * SIZE(mem_section));
> > > >  	}
> > > >
> > > > -	if (!is_kvaddr(addr))
> > > > -		return NOT_KV_ADDR;
> > > > -
> > > >  	return addr;
> > > >  }
> > > >
> > > > -unsigned long
> > > > -section_mem_map_addr(unsigned long addr)
> > > > +static unsigned long
> > > > +section_mem_map_addr(unsigned long addr, unsigned long *map_mask)
> > > >  {
> > > >  	char *mem_section;
> > > >  	unsigned long map;
> > > > +	unsigned long mask;
> > > > +
> > > > +	*map_mask = 0;
> > > >
> > > >  	if (!is_kvaddr(addr))
> > > >  		return NOT_KV_ADDR;
> > > > @@ -3338,15 +3338,19 @@ section_mem_map_addr(unsigned long addr)
> > > >  	}
> > > >  	map = ULONG(mem_section + OFFSET(mem_section.section_mem_map));
> > > >  	if (info->kernel_version < KERNEL_VERSION(4, 13, 0))
> > > > -		map &= SECTION_MAP_MASK_4_12;
> > > > +		mask = SECTION_MAP_MASK_4_12;
> > > >  	else
> > > > -		map &= SECTION_MAP_MASK;
> > > > +		mask = SECTION_MAP_MASK;
> > > > +	*map_mask = map & ~mask;
> > > > +	if (map == 0x0)
> > > > +		*map_mask |= SECTION_MARKED_PRESENT;
> > > > +	map &= mask;
> > > >  	free(mem_section);
> > > >
> > > >  	return map;
> > > >  }
> > > >
> > > > -unsigned long
> > > > +static unsigned long
> > > >  sparse_decode_mem_map(unsigned long coded_mem_map, unsigned long section_nr)
> > > >  {
> > > >  	unsigned long mem_map;
> > > > @@ -3354,17 +3358,110 @@ sparse_decode_mem_map(unsigned long coded_mem_map, unsigned long section_nr)
> > > >  	mem_map =  coded_mem_map +
> > > >  	    (SECTION_NR_TO_PFN(section_nr) * SIZE(page));
> > > >
> > > > -	if (!is_kvaddr(mem_map))
> > > > -		return NOT_KV_ADDR;
> > > >  	return mem_map;
> > > >  }
> > > > +
> > > > +/*
> > > > + * On some kernels, mem_section may be a pointer or an array, when
> > > > + * SPARSEMEM_EXTREME is on.
> > > > + *
> > > > + * We assume that section_mem_map is either 0 or has the present bit set.
> > > > + *
> > > > + */
> > > > +
> > > > +static int
> > > > +validate_mem_section(unsigned long *mem_sec,
> > > > +		     unsigned long mem_section_ptr, unsigned int mem_section_size,
> > > > +		     unsigned long *mem_maps, unsigned int num_section)
> > > > +{
> > > > +	unsigned int section_nr;
> > > > +	unsigned long map_mask;
> > > > +	unsigned long section, mem_map;
> > > > +	if (!readmem(VADDR, mem_section_ptr, mem_sec, mem_section_size)) {
> > > > +		ERRMSG("Can't read mem_section array.\n");
> > > > +		return FALSE;
> > > > +	}
> > > > +	for (section_nr = 0; section_nr < num_section; section_nr++) {
> > > > +		section = nr_to_section(section_nr, mem_sec);
> > > > +		if (section == NOT_KV_ADDR) {
> > > > +			mem_map = NOT_MEMMAP_ADDR;
> > > > +		} else {
> > > > +			mem_map = section_mem_map_addr(section, &map_mask);
> > > > +			if (!(map_mask & SECTION_MARKED_PRESENT)) {
> > > > +				return FALSE;
> > > > +			}
> > > > +			if (mem_map == 0) {
> > > > +				mem_map = NOT_MEMMAP_ADDR;
> > > > +			} else {
> > > > +				mem_map = sparse_decode_mem_map(mem_map,
> > > > +								section_nr);
> > > > +				if (!is_kvaddr(mem_map)) {
> > > > +					return FALSE;
> > > > +				}
> > > > +			}
> > > > +		}
> > > > +		mem_maps[section_nr] = mem_map;
> > > > +	}
> > > > +	return TRUE;
> > > > +}
> > > > +
> > > > +static int
> > > > +get_mem_section(unsigned int mem_section_size, unsigned long *mem_maps,
> > > > +		unsigned int num_section)
> > > > +{
> > > > +	unsigned long mem_section_ptr;
> > > > +	int ret = FALSE;
> > > > +	unsigned long *mem_sec = NULL;
> > > > +
> > > > +	if ((mem_sec = malloc(mem_section_size)) == NULL) {
> > > > +		ERRMSG("Can't allocate memory for the mem_section. %s\n",
> > > > +		    strerror(errno));
> > > > +		return FALSE;
> > > > +	}
> > > > +	ret = validate_mem_section(mem_sec, SYMBOL(mem_section),
> > > > +				   mem_section_size, mem_maps, num_section);
> > > > +
> > > > +	if (is_sparsemem_extreme()) {
> > > > +		int symbol_valid = ret;
> > > > +		int pointer_valid;
> > > > +		int mem_maps_size = sizeof(*mem_maps) * num_section;
> > > > +		unsigned long *mem_maps_ex = NULL;
> > > > +		if (!readmem(VADDR, SYMBOL(mem_section), &mem_section_ptr,
> > > > +			     sizeof(mem_section_ptr)))
> > > > +			goto out;
> > > > +
> > > > +		if ((mem_maps_ex = malloc(mem_maps_size)) == NULL) {
> > > > +			ERRMSG("Can't allocate memory for the mem_maps. %s\n",
> > > > +			    strerror(errno));
> > > > +			goto out;
> > > > +		}
> > > > +
> > > > +		pointer_valid = validate_mem_section(mem_sec,
> > > > +						     mem_section_ptr,
> > > > +						     mem_section_size,
> > > > +						     mem_maps_ex,
> > > > +						     num_section);
> > > > +		if (pointer_valid)
> > > > +			memcpy(mem_maps, mem_maps_ex, mem_maps_size);
> > > > +		if (mem_maps_ex)
> > > > +			free(mem_maps_ex);
> > > > +		ret = symbol_valid ^ pointer_valid;
> > > > +		if (!ret) {
> > > > +			ERRMSG("Could not validate mem_section.\n");
> > > > +		}
> > > > +	}
> > > > +out:
> > > > +	if (mem_sec != NULL)
> > > > +		free(mem_sec);
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  int
> > > >  get_mm_sparsemem(void)
> > > >  {
> > > >  	unsigned int section_nr, mem_section_size, num_section;
> > > >  	mdf_pfn_t pfn_start, pfn_end;
> > > > -	unsigned long section, mem_map;
> > > > -	unsigned long *mem_sec = NULL;
> > > > +	unsigned long *mem_maps = NULL;
> > > >
> > > >  	int ret = FALSE;
> > > >
> > > > @@ -3379,13 +3476,12 @@ get_mm_sparsemem(void)
> > > >  		info->sections_per_root = _SECTIONS_PER_ROOT();
> > > >  		mem_section_size = SIZE(mem_section) * NR_SECTION_ROOTS();
> > > >  	}
> > > > -	if ((mem_sec = malloc(mem_section_size)) == NULL) {
> > > > -		ERRMSG("Can't allocate memory for the mem_section. %s\n",
> > > > -		    strerror(errno));
> > > > +	if ((mem_maps = malloc(sizeof(*mem_maps) * num_section)) == NULL) {
> > > > +		ERRMSG("Can't allocate memory for the mem_maps. %s\n",
> > > > +			strerror(errno));
> > > >  		return FALSE;
> > > >  	}
> > > > -	if (!readmem(VADDR, SYMBOL(mem_section), mem_sec,
> > > > -	    mem_section_size)) {
> > > > +	if (!get_mem_section(mem_section_size, mem_maps, num_section)) {
> > > >  		ERRMSG("Can't get the address of mem_section.\n");
> > > >  		goto out;
> > > >  	}
> > > > @@ -3397,31 +3493,16 @@ get_mm_sparsemem(void)
> > > >  		goto out;
> > > >  	}
> > > >  	for (section_nr = 0; section_nr < num_section; section_nr++) {
> > > > -		section = nr_to_section(section_nr, mem_sec);
> > > > -		if (section == NOT_KV_ADDR) {
> > > > -			mem_map = NOT_MEMMAP_ADDR;
> > > > -		} else {
> > > > -			mem_map = section_mem_map_addr(section);
> > > > -			if (mem_map == 0) {
> > > > -				mem_map = NOT_MEMMAP_ADDR;
> > > > -			} else {
> > > > -				mem_map = sparse_decode_mem_map(mem_map,
> > > > -								section_nr);
> > > > -				if (!is_kvaddr(mem_map))
> > > > -					mem_map = NOT_MEMMAP_ADDR;
> > > > -			}
> > > > -		}
> > > >  		pfn_start = section_nr * PAGES_PER_SECTION();
> > > >  		pfn_end   = pfn_start + PAGES_PER_SECTION();
> > > >  		if (info->max_mapnr < pfn_end)
> > > >  			pfn_end = info->max_mapnr;
> > > > -		dump_mem_map(pfn_start, pfn_end, mem_map, section_nr);
> > > > +		dump_mem_map(pfn_start, pfn_end, mem_maps[section_nr], section_nr);
> > > >  	}
> > > >  	ret = TRUE;
> > > >  out:
> > > > -	if (mem_sec != NULL)
> > > > -		free(mem_sec);
> > > > -
> > > > +	if (mem_maps != NULL)
> > > > +		free(mem_maps);
> > > >  	return ret;
> > > >  }
> > > >
> > > > diff --git a/makedumpfile.h b/makedumpfile.h
> > > > index 01eece2..58e1aaa 100644
> > > > --- a/makedumpfile.h
> > > > +++ b/makedumpfile.h
> > > > @@ -184,6 +184,7 @@ isAnon(unsigned long mapping)
> > > >  #define SECTIONS_PER_ROOT()	(info->sections_per_root)
> > > >  #define SECTION_ROOT_MASK()	(SECTIONS_PER_ROOT() - 1)
> > > >  #define SECTION_NR_TO_ROOT(sec)	((sec) / SECTIONS_PER_ROOT())
> > > > +#define SECTION_MARKED_PRESENT  (1UL<<0)
> > > >  #define SECTION_IS_ONLINE	(1UL<<2)
> > > >  #define SECTION_MAP_LAST_BIT	(1UL<<3)
> > > >  #define SECTION_MAP_MASK_4_12	(~(SECTION_IS_ONLINE-1))
> > > > --
> > > > 2.14.1
> > > >
> > > >
> > > > _______________________________________________
> > > > kexec mailing list
> > > > kexec@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/kexec
> > >
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

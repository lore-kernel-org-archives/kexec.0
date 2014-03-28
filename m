Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTXLh-0006Zy-N8
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 14:01:34 +0000
Date: Fri, 28 Mar 2014 10:01:02 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 2/4] x86: Store memory ranges globally used for crash
 kernel to boot into
Message-ID: <20140328140102.GE2089@redhat.com>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
 <1395216241-13983-3-git-send-email-chaowang@redhat.com>
 <20140327223233.GQ13816@redhat.com>
 <20140328052349.GD2944@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140328052349.GD2944@dhcp-17-89.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, ebiederm@xmission.com

On Fri, Mar 28, 2014 at 01:23:49PM +0800, WANG Chao wrote:

[..]
> > And even if we have to, then why do we need to return pointer to
> > crash_memory_range array?
> 
> For historical reason, get_crash_memory_ranges() is not only set
> crash_memory_range but also return the pointer of another copy of
> crash_memory_range:
> 
> static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
> 				   int kexec_flags, unsigned long lowmem_limit)
> {
> 	[..]
> 	crash_memory_range = xxx;
> 	[..]
> 	*range = crash_memory_range;
> 	*ranges = memory_range;
> }
> 

Current implementation if fine. I saves all entries in a static array and
then returns pointer to that static array so that others could use it. So
point seems to be that access this array using returned pointer and one
can't access it directly. There is no extra array copy.

Once we start storing crash array entries in kexec_info, we should not
have to do any cleanup here and be able to access crash entries array
everywhere.

Thanks
Vivek

> I was just trying to keep the change as minimal as possible, so that the
> reviewers can be more clear of what the patch does instead of something
> looks messed up. But if you have no problem review it, I can do some
> clean up within this patch. However I think it's better to be addressed
> the cleanup in the future, or at least as a separated patch in this
> series.
> 
> Thanks
> WANG Chao
> 
> > 
> > Thanks
> > Vivek
> > 
> > > 
> > > Signed-off-by: WANG Chao <chaowang@redhat.com>
> > > Tested-by: Linn Crosetto <linn@hp.com>
> > > ---
> > >  kexec/arch/i386/crashdump-x86.c | 134 ++++++++++++++++++++++------------------
> > >  kexec/arch/i386/crashdump-x86.h |   5 +-
> > >  2 files changed, 77 insertions(+), 62 deletions(-)
> > > 
> > > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > > index 979c2bd..c55a6b1 100644
> > > --- a/kexec/arch/i386/crashdump-x86.c
> > > +++ b/kexec/arch/i386/crashdump-x86.c
> > > @@ -179,7 +179,8 @@ static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end);
> > >  
> > >  /* Stores a sorted list of RAM memory ranges for which to create elf headers.
> > >   * A separate program header is created for backup region */
> > > -static struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
> > > +struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
> > > +int crash_memory_ranges;
> > >  
> > >  /* Memory region reserved for storing panic kernel and other data. */
> > >  #define CRASH_RESERVED_MEM_NR	8
> > > @@ -201,7 +202,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
> > >  				   int kexec_flags, unsigned long lowmem_limit)
> > >  {
> > >  	const char *iomem = proc_iomem();
> > > -	int memory_ranges = 0, gart = 0, i;
> > > +	int gart = 0, i;
> > >  	char line[MAX_LINE];
> > >  	FILE *fp;
> > >  	unsigned long long start, end;
> > > @@ -218,7 +219,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
> > >  		char *str;
> > >  		int type, consumed, count;
> > >  
> > > -		if (memory_ranges >= CRASH_MAX_MEMORY_RANGES)
> > > +		if (crash_memory_ranges >= CRASH_MAX_MEMORY_RANGES)
> > >  			break;
> > >  		count = sscanf(line, "%Lx-%Lx : %n",
> > >  			&start, &end, &consumed);
> > > @@ -250,17 +251,17 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
> > >  			continue;
> > >  		}
> > >  
> > > -		crash_memory_range[memory_ranges].start = start;
> > > -		crash_memory_range[memory_ranges].end = end;
> > > -		crash_memory_range[memory_ranges].type = type;
> > > +		crash_memory_range[crash_memory_ranges].start = start;
> > > +		crash_memory_range[crash_memory_ranges].end = end;
> > > +		crash_memory_range[crash_memory_ranges].type = type;
> > >  
> > > -		segregate_lowmem_region(&memory_ranges, lowmem_limit);
> > > +		segregate_lowmem_region(&crash_memory_ranges, lowmem_limit);
> > >  
> > > -		memory_ranges++;
> > > +		crash_memory_ranges++;
> > >  	}
> > >  	fclose(fp);
> > >  	if (kexec_flags & KEXEC_PRESERVE_CONTEXT) {
> > > -		for (i = 0; i < memory_ranges; i++) {
> > > +		for (i = 0; i < crash_memory_ranges; i++) {
> > >  			if (crash_memory_range[i].end > 0x0009ffff) {
> > >  				crash_reserved_mem[0].start = \
> > >  					crash_memory_range[i].start;
> > > @@ -278,17 +279,17 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
> > >  	}
> > >  
> > >  	for (i = 0; i < crash_reserved_mem_nr; i++)
> > > -		if (exclude_region(&memory_ranges, crash_reserved_mem[i].start,
> > > +		if (exclude_region(&crash_memory_ranges, crash_reserved_mem[i].start,
> > >  				crash_reserved_mem[i].end) < 0)
> > >  			return -1;
> > >  
> > >  	if (gart) {
> > >  		/* exclude GART region if the system has one */
> > > -		if (exclude_region(&memory_ranges, gart_start, gart_end) < 0)
> > > +		if (exclude_region(&crash_memory_ranges, gart_start, gart_end) < 0)
> > >  			return -1;
> > >  	}
> > >  	*range = crash_memory_range;
> > > -	*ranges = memory_ranges;
> > > +	*ranges = crash_memory_ranges;
> > >  
> > >  	return 0;
> > >  }
> > > @@ -324,7 +325,7 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
> > >  	}
> > >  
> > >  	*range = crash_memory_range;
> > > -	*ranges = j;
> > > +	*ranges = crash_memory_ranges = j;
> > >  
> > >  	qsort(*range, *ranges, sizeof(struct memory_range), compare_ranges);
> > >  
> > > @@ -417,8 +418,8 @@ static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end)
> > >  
> > >  /* Adds a segment from list of memory regions which new kernel can use to
> > >   * boot. Segment start and end should be aligned to 1K boundary. */
> > > -static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
> > > -								size_t size)
> > > +static int add_memmap(struct memory_range *memmap_p, int *nr_range,
> > > +					unsigned long long addr, size_t size)
> > >  {
> > >  	int i, j, nr_entries = 0, tidx = 0, align = 1024;
> > >  	unsigned long long mstart, mend;
> > > @@ -450,29 +451,23 @@ static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
> > >  		else if (addr > mend)
> > >  			tidx = i+1;
> > >  	}
> > > -		/* Insert the memory region. */
> > > -		for (j = nr_entries-1; j >= tidx; j--)
> > > -			memmap_p[j+1] = memmap_p[j];
> > > -		memmap_p[tidx].start = addr;
> > > -		memmap_p[tidx].end = addr + size - 1;
> > > +	/* Insert the memory region. */
> > > +	for (j = nr_entries-1; j >= tidx; j--)
> > > +		memmap_p[j+1] = memmap_p[j];
> > > +	memmap_p[tidx].start = addr;
> > > +	memmap_p[tidx].end = addr + size - 1;
> > > +	memmap_p[tidx].type = RANGE_RAM;
> > > +	*nr_range = nr_entries + 1;
> > >  
> > > -	dbgprintf("Memmap after adding segment\n");
> > > -	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
> > > -		mstart = memmap_p[i].start;
> > > -		mend = memmap_p[i].end;
> > > -		if (mstart == 0 && mend == 0)
> > > -			break;
> > > -		dbgprintf("%016llx - %016llx\n",
> > > -			mstart, mend);
> > > -	}
> > > +	dbgprint_mem_range("Memmap after adding segment", memmap_p, *nr_range);
> > >  
> > >  	return 0;
> > >  }
> > >  
> > >  /* Removes a segment from list of memory regions which new kernel can use to
> > >   * boot. Segment start and end should be aligned to 1K boundary. */
> > > -static int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
> > > -								size_t size)
> > > +static int delete_memmap(struct memory_range *memmap_p, int *nr_range,
> > > +					unsigned long long addr, size_t size)
> > >  {
> > >  	int i, j, nr_entries = 0, tidx = -1, operation = 0, align = 1024;
> > >  	unsigned long long mstart, mend;
> > > @@ -534,24 +529,17 @@ static int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
> > >  		for (j = nr_entries-1; j > tidx; j--)
> > >  			memmap_p[j+1] = memmap_p[j];
> > >  		memmap_p[tidx+1] = temp_region;
> > > +		*nr_range = nr_entries + 1;
> > >  	}
> > >  	if ((operation == -1) && tidx >=0) {
> > >  		/* Delete the exact match memory region. */
> > >  		for (j = i+1; j < CRASH_MAX_MEMMAP_NR; j++)
> > >  			memmap_p[j-1] = memmap_p[j];
> > >  		memmap_p[j-1].start = memmap_p[j-1].end = 0;
> > > +		*nr_range = nr_entries - 1;
> > >  	}
> > >  
> > > -	dbgprintf("Memmap after deleting segment\n");
> > > -	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
> > > -		mstart = memmap_p[i].start;
> > > -		mend = memmap_p[i].end;
> > > -		if (mstart == 0 && mend == 0) {
> > > -			break;
> > > -		}
> > > -		dbgprintf("%016llx - %016llx\n",
> > > -			mstart, mend);
> > > -	}
> > > +	dbgprint_mem_range("Memmap after deleting segment", memmap_p, *nr_range);
> > >  
> > >  	return 0;
> > >  }
> > > @@ -626,6 +614,9 @@ static int cmdline_add_memmap(char *cmdline, struct memory_range *memmap_p)
> > >  			/* All regions traversed. */
> > >  			break;
> > >  
> > > +		if (memmap_p[i].type != RANGE_RAM)
> > > +			continue;
> > > +
> > >  		/* A region is not worth adding if region size < 100K. It eats
> > >  		 * up precious command line length. */
> > >  		if ((endk - startk) < min_sizek)
> > > @@ -797,6 +788,25 @@ static void get_backup_area(struct kexec_info *info,
> > >  	info->backup_src_size = BACKUP_SRC_END - BACKUP_SRC_START + 1;
> > >  }
> > >  
> > > +static void exclude_ram(struct memory_range *mr, int *nr_mr)
> > > +{
> > > +	int ranges, i, j, m;
> > > +
> > > +	ranges = *nr_mr;
> > > +	for (i = 0, j = 0; i < ranges; i++) {
> > > +		if (mr[j].type == RANGE_RAM) {
> > > +			dbgprintf("Remove RAM %016llx-%016llxx: (%d)\n", mr[j].start, mr[j].end, mr[j].type);
> > > +			for (m = j; m < *nr_mr; m++)
> > > +				mr[m] = mr[m+1];
> > > +			(*nr_mr)--;
> > > +		} else {
> > > +			j++;
> > > +		}
> > > +	}
> > > +
> > > +	dbgprint_mem_range("After remove RAM", mr, *nr_mr);
> > > +}
> > > +
> > >  /* Loads additional segments in case of a panic kernel is being loaded.
> > >   * One segment for backup region, another segment for storing elf headers
> > >   * for crash memory image.
> > > @@ -807,7 +817,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> > >  	void *tmp;
> > >  	unsigned long sz, bufsz, memsz, elfcorehdr;
> > >  	int nr_ranges = 0, align = 1024, i;
> > > -	struct memory_range *mem_range, *memmap_p;
> > > +	struct memory_range *mem_range;
> > >  	struct crash_elf_info elf_info;
> > >  	unsigned kexec_arch;
> > >  
> > > @@ -850,10 +860,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> > >  
> > >  	get_backup_area(info, mem_range, nr_ranges);
> > >  
> > > -	dbgprintf("CRASH MEMORY RANGES\n");
> > > -
> > > -	for(i = 0; i < nr_ranges; ++i)
> > > -		dbgprintf("%016Lx-%016Lx\n", mem_range[i].start, mem_range[i].end);
> > > +	dbgprint_mem_range("CRASH MEMORY RANGES", mem_range, nr_ranges);
> > >  
> > >  	/*
> > >  	 * if the core type has not been set on command line, set it here
> > > @@ -878,17 +885,6 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> > >  	if (get_kernel_vaddr_and_size(info, &elf_info))
> > >  		return -1;
> > >  
> > > -	/* Memory regions which panic kernel can safely use to boot into */
> > > -	sz = (sizeof(struct memory_range) * CRASH_MAX_MEMMAP_NR);
> > > -	memmap_p = xmalloc(sz);
> > > -	memset(memmap_p, 0, sz);
> > > -	add_memmap(memmap_p, info->backup_src_start, info->backup_src_size);
> > > -	for (i = 0; i < crash_reserved_mem_nr; i++) {
> > > -		sz = crash_reserved_mem[i].end - crash_reserved_mem[i].start +1;
> > > -		if (add_memmap(memmap_p, crash_reserved_mem[i].start, sz) < 0)
> > > -			return ENOCRASHKERNEL;
> > > -	}
> > > -
> > >  	/* Create a backup region segment to store backup data*/
> > >  	if (!(info->kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
> > >  		sz = _ALIGN(info->backup_src_size, align);
> > > @@ -898,8 +894,6 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> > >  						0, max_addr, -1);
> > >  		dbgprintf("Created backup segment at 0x%lx\n",
> > >  			  info->backup_start);
> > > -		if (delete_memmap(memmap_p, info->backup_start, sz) < 0)
> > > -			return EFAILED;
> > >  	}
> > >  
> > >  	/* Create elf header segment and store crash image data. */
> > > @@ -915,6 +909,23 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> > >  						ELF_CORE_HEADER_ALIGN) < 0)
> > >  			return EFAILED;
> > >  	}
> > > +
> > > +	/* Memory regions which panic kernel can safely use to boot into */
> > > +	exclude_ram(crash_memory_range, &crash_memory_ranges);
> > > +
> > > +	add_memmap(crash_memory_range, &crash_memory_ranges, info->backup_src_start, info->backup_src_size);
> > > +	for (i = 0; i < crash_reserved_mem_nr; i++) {
> > > +		sz = crash_reserved_mem[i].end - crash_reserved_mem[i].start +1;
> > > +		if (add_memmap(crash_memory_range, &crash_memory_ranges, crash_reserved_mem[i].start, sz) < 0)
> > > +			return ENOCRASHKERNEL;
> > > +	}
> > > +
> > > +	/* exclude backup region from crash dump memory range */
> > > +	sz = _ALIGN(info->backup_src_size, align);
> > > +	if (delete_memmap(crash_memory_range, &crash_memory_ranges, info->backup_start, sz) < 0) {
> > > +		return EFAILED;
> > > +	}
> > > +
> > >  	/* the size of the elf headers allocated is returned in 'bufsz' */
> > >  
> > >  	/* Hack: With some ld versions (GNU ld version 2.14.90.0.4 20030523),
> > > @@ -934,9 +945,9 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> > >  	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
> > >  							max_addr, -1);
> > >  	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
> > > -	if (delete_memmap(memmap_p, elfcorehdr, memsz) < 0)
> > > +	if (delete_memmap(crash_memory_range, &crash_memory_ranges, elfcorehdr, memsz) < 0)
> > >  		return -1;
> > > -	cmdline_add_memmap(mod_cmdline, memmap_p);
> > > +	cmdline_add_memmap(mod_cmdline, crash_memory_range);
> > >  	if (!bzImage_support_efi_boot)
> > >  		cmdline_add_efi(mod_cmdline);
> > >  	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
> > > @@ -951,6 +962,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> > >  		end = mem_range[i].end;
> > >  		cmdline_add_memmap_acpi(mod_cmdline, start, end);
> > >  	}
> > > +
> > >  	return 0;
> > >  }
> > >  
> > > diff --git a/kexec/arch/i386/crashdump-x86.h b/kexec/arch/i386/crashdump-x86.h
> > > index b61cf0a..633ee0e 100644
> > > --- a/kexec/arch/i386/crashdump-x86.h
> > > +++ b/kexec/arch/i386/crashdump-x86.h
> > > @@ -20,7 +20,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
> > >  /* Kernel text size */
> > >  #define X86_64_KERNEL_TEXT_SIZE  (512UL*1024*1024)
> > >  
> > > -#define CRASH_MAX_MEMMAP_NR	(KEXEC_MAX_SEGMENTS + 1)
> > > +#define CRASH_MAX_MEMMAP_NR	CRASH_MAX_MEMORY_RANGES
> > >  #define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
> > >  
> > >  /* Backup Region, First 640K of System RAM. */
> > > @@ -28,4 +28,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
> > >  #define BACKUP_SRC_END		0x0009ffff
> > >  #define BACKUP_SRC_SIZE	(BACKUP_SRC_END - BACKUP_SRC_START + 1)
> > >  
> > > +extern struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
> > > +extern int crash_memory_ranges;
> > > +
> > >  #endif /* CRASHDUMP_X86_H */
> > > -- 
> > > 1.8.5.3
> > > 
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

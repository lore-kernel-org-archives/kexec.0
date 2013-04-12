Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQfqE-0006mN-He
 for kexec@lists.infradead.org; Fri, 12 Apr 2013 15:24:44 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
 <1365683207-42425-6-git-send-email-trenn@suse.de>
Date: Fri, 12 Apr 2013 08:24:12 -0700
In-Reply-To: <1365683207-42425-6-git-send-email-trenn@suse.de> (Thomas
 Renninger's message of "Thu, 11 Apr 2013 14:26:47 +0200")
Message-ID: <87bo9ju603.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] kexec: X86: Pass memory ranges via e820 table instead
 of memmap= boot parameter
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
To: Thomas Renninger <trenn@suse.de>
Cc: kexec@lists.infradead.org, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, yinghai@kernel.org, cpw@sgi.com, vgoyal@redhat.com

Thomas Renninger <trenn@suse.de> writes:

> Currently ranges are passed via kernel boot parameters:
> memmap=exactmap memmap=X#Y memmap=
>
> Pass them via e820 table directly instead.

Reading through this code I am not seeing us mark areas of memory that
we may not use as reserved.  Am I missing something?

Those areas need to be marked reserved or else the pci resource
allocator in the kernel will think it is ok to put pci memory there.

Eric


> CC: Simon Horman <horms@verge.net.au>
> CC: kexec@lists.infradead.org
> CC: H. Peter Anvin <hpa@zytor.com>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> CC: vgoyal@redhat.com
> CC: yinghai@kernel.org
> CC: cpw@sgi.com
>
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>
> ---
>  kexec/arch/i386/crashdump-x86.c   |  221 ++++++++++++++++++-------------------
>  kexec/arch/i386/x86-linux-setup.c |   11 ++-
>  2 files changed, 116 insertions(+), 116 deletions(-)
>
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index f7821bc..8009efe 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -659,70 +659,6 @@ static void ultoa(unsigned long i, char *str)
>  	}
>  }
>  
> -static void cmdline_add_memmap_internal(char *cmdline, unsigned long startk,
> -					unsigned long endk, int type)
> -{
> -	int cmdlen, len;
> -	char str_mmap[256], str_tmp[20];
> -
> -	strcpy (str_mmap, " memmap=");
> -	ultoa((endk-startk), str_tmp);
> -	strcat (str_mmap, str_tmp);
> -
> -	if (type == RANGE_RAM)
> -		strcat (str_mmap, "K@");
> -	else if (type == RANGE_RESERVED)
> -		strcat (str_mmap, "K$");
> -	else if (type == RANGE_ACPI || type == RANGE_ACPI_NVS)
> -		strcat (str_mmap, "K#");
> -
> -	ultoa(startk, str_tmp);
> -	strcat (str_mmap, str_tmp);
> -	strcat (str_mmap, "K");
> -	len = strlen(str_mmap);
> -	cmdlen = strlen(cmdline) + len;
> -	if (cmdlen > (COMMAND_LINE_SIZE - 1))
> -		die("Command line overflow\n");
> -	strcat(cmdline, str_mmap);
> -}
> -
> -/* Adds the appropriate memmap= options to command line, indicating the
> - * memory regions the new kernel can use to boot into. */
> -static int cmdline_add_memmap(char *cmdline, struct memory_range *memmap_p)
> -{
> -	int i, cmdlen, len;
> -	unsigned long min_sizek = 100;
> -	char str_mmap[256];
> -
> -	/* Exact map */
> -	strcpy(str_mmap, " memmap=exactmap");
> -	len = strlen(str_mmap);
> -	cmdlen = strlen(cmdline) + len;
> -	if (cmdlen > (COMMAND_LINE_SIZE - 1))
> -		die("Command line overflow\n");
> -	strcat(cmdline, str_mmap);
> -
> -	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
> -		unsigned long startk, endk;
> -		startk = (memmap_p[i].start/1024);
> -		endk = ((memmap_p[i].end + 1)/1024);
> -		if (!startk && !endk)
> -			/* All regions traversed. */
> -			break;
> -
> -		/* A region is not worth adding if region size < 100K. It eats
> -		 * up precious command line length. */
> -		if ((endk - startk) < min_sizek)
> -			continue;
> -		cmdline_add_memmap_internal(cmdline, startk, endk, RANGE_RAM);
> -	}
> -
> -	dbgprintf("Command line after adding memmap\n");
> -	dbgprintf("%s\n", cmdline);
> -
> -	return 0;
> -}
> -
>  /* Adds the elfcorehdr= command line parameter to command line. */
>  static int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr)
>  {
> @@ -803,26 +739,6 @@ static enum coretype get_core_type(struct crash_elf_info *elf_info,
>  	}
>  }
>  
> -/* Appends memmap=X#Y commandline for ACPI to command line*/
> -static int cmdline_add_memmap_acpi(char *cmdline, unsigned long start,
> -					unsigned long end)
> -{
> -	int align = 1024;
> -	unsigned long startk, endk;
> -
> -	if (!(end - start))
> -		return 0;
> -
> -	startk = start/1024;
> -	endk = (end + align - 1)/1024;
> -	cmdline_add_memmap_internal(cmdline, startk, endk, RANGE_ACPI);
> -
> -	dbgprintf("Command line after adding acpi memmap\n");
> -	dbgprintf("%s\n", cmdline);
> -
> -	return 0;
> -}
> -
>  /* Appends 'acpi_rsdp=' commandline for efi boot crash dump */
>  static void cmdline_add_efi(char *cmdline)
>  {
> @@ -881,24 +797,101 @@ static void get_backup_area(struct kexec_info *info,
>  	info->backup_src_size = BACKUP_SRC_END - BACKUP_SRC_START + 1;
>  }
>  
> -/* Appends memmap=X$Y commandline for reserved memory to command line*/
> -static int cmdline_add_memmap_reserved(char *cmdline, unsigned long start,
> -					unsigned long end)
> +/*
> + * This function takes reserved (all kind of) memory from global
> + * crash_memory_range[] memory ranges and takes memory the kdump/crash
> + * kernel is allowed to use from the passed usable_mem memory ranges. 
> + * The passed usable_mem ranges are zero (!start && !end) terminated.
> + *
> + * The final memory map is again written into crash_memory_range[]
> + * and intended to get passed as e820 table to the crash kernel
> + */
> +static int create_final_crash_map(struct memory_range *usable_mem)
>  {
> -	int align = 1024;
> -	unsigned long startk, endk;
> +	int i, m, c, tmp_map1_ranges, tmp_map2_ranges;
> +	unsigned long min_sizek = 100;
> +	/* crash_memory_map with usable memory ranges cut out */
> +	struct memory_range tmp_map1[MAX_MEMORY_RANGES];
> +	/* merge_map, but small ranges cut out */
> +	struct memory_range tmp_map2[MAX_MEMORY_RANGES];
>  
> -	if (!(end - start))
> -		return 0;
> +	/*
> +	 * Ignore usable memory ranges for kdump kernel smaller
> +	 * than 100k to avoid too much ranges passed
> +	 * Save the new ranges (exluding lower than 100k ranges) in tmp_map
> +	 * and store the number of elements in tmp_map_ranges
> +	 */
> +	for (m = 0, i = 0; i < CRASH_MAX_MEMMAP_NR; i++) {
> +		unsigned long startk, endk;
> +		startk = (usable_mem[i].start/1024);
> +		endk = ((usable_mem[i].end + 1)/1024);
> +		if (!startk && !endk)
> +			/* All regions traversed. */
> +			break;
> +
> +		/* A region is not worth adding if region size < 100K. It eats
> +		 * up precious command line length. */
> +		if ((endk - startk) < min_sizek) {
> +			dbgprintf("Removing: %luk - %luk\n", startk, endk);
> +			continue;
> +		} else {
> +			tmp_map1[m].start = usable_mem[i].start;
> +			tmp_map1[m].end   = usable_mem[i].end;
> +			tmp_map1[m].type = usable_mem[i].type;
> +			m++;
> +		}
> +	}
> +	/* No need to check for !start && !end anymore */
> +	tmp_map1_ranges = m;
>  
> -	startk = start/1024;
> -	endk = (end + align - 1)/1024;
> -	cmdline_add_memmap_internal(cmdline, startk, endk, RANGE_RESERVED);
> +	for(i = 0; i < tmp_map1_ranges; ++i)
> +		dbgprintf("%016Lx-%016Lx (%d)\n", tmp_map1[i].start,
> +			  tmp_map1[i].end, tmp_map1[i].type);
> +
> +	/*
> +	 * Cut out RANGE_RAM regions from crash_memory_ranges and store
> +	 * them in tmp_map2_ranges
> +	 */
> +	for (c = 0, i = 0; i < crash_ranges; i++) {
> +		if (crash_memory_range[i].type == RANGE_RAM)
> +			continue;
> +		tmp_map2[c].start = crash_memory_range[i].start;
> +		tmp_map2[c].end = crash_memory_range[i].end;
> +		tmp_map2[c].type = crash_memory_range[i].type;
> +		c++;
> +	}
> +	tmp_map2_ranges = c;
> +
> +	/*
> +	 * TBD: Check that no ranges overlap?
> +	 * Can this happen at all?
> +	 */
> +	for (c = 0, m = 0, i = 0; i < MAX_MEMORY_RANGES; i++) {
> +		if (m < tmp_map1_ranges &&
> +		    (c >= tmp_map2_ranges ||
> +		     tmp_map2[c].start > tmp_map1[m].start)) {
> +			crash_memory_range[i].start = tmp_map1[m].start;
> +			crash_memory_range[i].end   = tmp_map1[m].end;
> +			crash_memory_range[i].type  = RANGE_RAM;
> +			m++;
> +			continue;
> +		} else if (c < tmp_map2_ranges) {
> +			crash_memory_range[i] = tmp_map2[c];
> +			c++;
> +			continue;
> +		} else
> +			break;
> +	}
> +	crash_ranges = i;
> +
> +	/*
> +	 * End address has to be exlusive for e820 map
> +	 * x        - 00010000
> +	 * 00010000 - y
> +	 */
> +	for(i = 0; i < crash_ranges; ++i)
> +		crash_memory_range[i].end++;
>  
> -#ifdef DEBUG
> -		printf("Command line after adding reserved memmap\n");
> -		printf("%s\n", cmdline);
> -#endif
>  	return 0;
>  }
>  
> @@ -944,6 +937,12 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  		return -1;
>  	}
>  
> +	/*
> +	 * From now on the memory regions are stored in crash_memory_range[]
> +	 * Currently the end address is inclusive at this point:
> +	 * x        - 0000ffff
> +	 * 00010000 - y
> +	 */
>  	if (xen_present()) {
>  		if (get_crash_memory_ranges_xen(&mem_range, &crash_ranges,
>  						elf_info.lowmem_limit) < 0)
> @@ -971,7 +970,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  
>  	get_backup_area(info, mem_range, crash_ranges);
>  
> -	dbgprintf("CRASH MEMORY RANGES\n");
> +	dbgprintf("TEMPORARY CRASH MEMORY RANGES\n");
>  
>  	for(i = 0; i < crash_ranges; ++i)
>  		dbgprintf("%016Lx-%016Lx (%d)\n", mem_range[i].start,
> @@ -1063,24 +1062,18 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
>  	if (delete_memmap(memmap_p, elfcorehdr, memsz) < 0)
>  		return -1;
> -	cmdline_add_memmap(mod_cmdline, memmap_p);
>  	cmdline_add_efi(mod_cmdline);
>  	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
>  
> -	/* Inform second kernel about the presence of ACPI tables. */
> -	for (i = 0; i < MAX_MEMORY_RANGES; i++) {
> -		unsigned long start, end;
> -		if ( !( mem_range[i].type == RANGE_ACPI
> -			|| mem_range[i].type == RANGE_ACPI_NVS
> -			|| mem_range[i].type == RANGE_RESERVED) )
> -			continue;
> -		start = mem_range[i].start;
> -		end = mem_range[i].end;
> -		if (mem_range[i].type == RANGE_RESERVED)
> -			cmdline_add_memmap_reserved(mod_cmdline, start, end);
> -		else
> -			cmdline_add_memmap_acpi(mod_cmdline, start, end);
> -	}
> +	/*
> +	 * Redo crash_memory_range so that it can get passed as e820 info
> +	 */
> +	create_final_crash_map(memmap_p);
> +
> +	dbgprintf("FINAL CRASH MEMORY RANGES\n");
> +	for(i = 0; i < crash_ranges; ++i)
> +		dbgprintf("%016Lx-%016Lx (%d)\n", mem_range[i].start,
> +			  mem_range[i].end, mem_range[i].type);
>  	return 0;
>  }
>  
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index c538897..82b4bb9 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -505,8 +505,15 @@ void setup_linux_system_parameters(struct kexec_info *info,
>  	/* another safe default */
>  	real_mode->aux_device_info = 0;
>  
> -	range = info->memory_range;
> -	ranges = info->memory_ranges;
> +	if (info->kexec_flags & KEXEC_ON_CRASH || 
> +	    info->kexec_flags & KEXEC_PRESERVE_CONTEXT) {
> +		range = crash_memory_range;
> +		ranges = crash_ranges;
> +	} else {
> +		range = info->memory_range;
> +		ranges = info->memory_ranges;
> +	}
> +
>  	if (ranges > E820MAX) {
>  		if (!(info->kexec_flags & KEXEC_ON_CRASH))
>  			/*

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

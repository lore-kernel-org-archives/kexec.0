Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UJ6Fb-0005nz-A2
 for kexec@lists.infradead.org; Fri, 22 Mar 2013 17:59:36 +0000
Date: Fri, 22 Mar 2013 13:59:25 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump, x86: Process multiple Crash kernel in /proc/iomem
Message-ID: <20130322175925.GA10004@redhat.com>
References: <20130320163131.GE2273@redhat.com>
 <1363807494-25127-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1363807494-25127-1-git-send-email-yinghai@kernel.org>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Wed, Mar 20, 2013 at 12:24:54PM -0700, Yinghai Lu wrote:
> Vivek found specical handling crashkernel low in not good.
> We should extend kexec-tools to handle multiple Crash kernel instead.
> 
> Extend crash_reserved_mem to array instead and use
> kexec_iomem_for_each_line directly.  After that we can drop
> crashkernel low.

Hi Yinghai,

I get following error while loading kernel.

parse_iomem_single failed.
Could not get memory layout

I think you need to handle parse_iomem_single("Crash Kernel") in
kexec-x86-common.c. It assumes that there is a single contiguous
reserved region of memory and set mem_min and mem_max based on
that. But that will not work when there are multiple "Crash Kernel"
entries.

In case of kexec_on_panic, we seem to have all the memory ranges in
info->memory_ranges[]. I guess we don't need that. We just need ranges
which are reserved for crash kernel and marked by "Crash Kernel". In
that case we will be able to handle multiple "Crash Kernel" ranges. 

Thanks
Vivek

> 
> Suggested-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  kexec/arch/i386/crashdump-x86.c |   91 ++++++++++++++++++----------------------
>  1 file changed, 43 insertions(+), 48 deletions(-)
> 
> Index: kexec-tools/kexec/arch/i386/crashdump-x86.c
> ===================================================================
> --- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
> +++ kexec-tools/kexec/arch/i386/crashdump-x86.c
> @@ -188,9 +188,9 @@ static int exclude_region(int *nr_ranges
>  static struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
>  
>  /* Memory region reserved for storing panic kernel and other data. */
> -static struct memory_range crash_reserved_mem;
> -/* under 4G parts */
> -static struct memory_range crash_reserved_low_mem;
> +#define CRASH_RESERVED_MEM_NR	8
> +static struct memory_range crash_reserved_mem[CRASH_RESERVED_MEM_NR];
> +static int crash_reserved_mem_nr;
>  
>  /* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom to
>   * create Elf headers. Keeping it separate from get_memory_ranges() as
> @@ -207,7 +207,7 @@ static int get_crash_memory_ranges(struc
>  				   int kexec_flags, unsigned long lowmem_limit)
>  {
>  	const char *iomem = proc_iomem();
> -	int memory_ranges = 0, gart = 0;
> +	int memory_ranges = 0, gart = 0, i;
>  	char line[MAX_LINE];
>  	FILE *fp;
>  	unsigned long long start, end;
> @@ -268,29 +268,28 @@ static int get_crash_memory_ranges(struc
>  	}
>  	fclose(fp);
>  	if (kexec_flags & KEXEC_PRESERVE_CONTEXT) {
> -		int i;
>  		for (i = 0; i < memory_ranges; i++) {
>  			if (crash_memory_range[i].end > 0x0009ffff) {
> -				crash_reserved_mem.start = \
> +				crash_reserved_mem[0].start = \
>  					crash_memory_range[i].start;
>  				break;
>  			}
>  		}
> -		if (crash_reserved_mem.start >= mem_max) {
> +		if (crash_reserved_mem[0].start >= mem_max) {
>  			fprintf(stderr, "Too small mem_max: 0x%llx.\n",
>  				mem_max);
>  			return -1;
>  		}
> -		crash_reserved_mem.end = mem_max;
> -		crash_reserved_mem.type = RANGE_RAM;
> +		crash_reserved_mem[0].end = mem_max;
> +		crash_reserved_mem[0].type = RANGE_RAM;
> +		crash_reserved_mem_nr = 1;
>  	}
> -	if (exclude_region(&memory_ranges, crash_reserved_mem.start,
> -				crash_reserved_mem.end) < 0)
> -		return -1;
> -	if (crash_reserved_low_mem.start &&
> -	    exclude_region(&memory_ranges, crash_reserved_low_mem.start,
> -				crash_reserved_low_mem.end) < 0)
> -		return -1;
> +
> +	for (i = 0; i < crash_reserved_mem_nr; i++)
> +		if (exclude_region(&memory_ranges, crash_reserved_mem[i].start,
> +				crash_reserved_mem[i].end) < 0)
> +			return -1;
> +
>  	if (gart) {
>  		/* exclude GART region if the system has one */
>  		if (exclude_region(&memory_ranges, gart_start, gart_end) < 0)
> @@ -351,9 +350,10 @@ static int get_crash_memory_ranges_xen(s
>  
>  	qsort(*range, *ranges, sizeof(struct memory_range), compare_ranges);
>  
> -	if (exclude_region(ranges, crash_reserved_mem.start,
> -						crash_reserved_mem.end) < 0)
> -		goto err;
> +	for (i = 0; i < crash_reserved_mem_nr; i++)
> +		if (exclude_region(ranges, crash_reserved_mem[i].start,
> +						crash_reserved_mem[i].end) < 0)
> +			goto err;
>  
>  	ret = 0;
>  
> @@ -434,9 +434,10 @@ static int get_crash_memory_ranges_xen(s
>  
>  	qsort(*range, *ranges, sizeof(struct memory_range), compare_ranges);
>  
> -	if (exclude_region(ranges, crash_reserved_mem.start,
> -						crash_reserved_mem.end) < 0)
> -		goto err;
> +	for (i = 0; i < crash_reserved_mem_nr; i++)
> +		if (exclude_region(ranges, crash_reserved_mem[i].start,
> +						crash_reserved_mem[i].end) < 0)
> +			goto err;
>  
>  	ret = 0;
>  
> @@ -1022,15 +1023,10 @@ int load_crashdump_segments(struct kexec
>  	memmap_p = xmalloc(sz);
>  	memset(memmap_p, 0, sz);
>  	add_memmap(memmap_p, info->backup_src_start, info->backup_src_size);
> -	sz = crash_reserved_mem.end - crash_reserved_mem.start +1;
> -	if (add_memmap(memmap_p, crash_reserved_mem.start, sz) < 0) {
> -		return ENOCRASHKERNEL;
> -	}
> -
> -	if (crash_reserved_low_mem.start) {
> -		sz = crash_reserved_low_mem.end - crash_reserved_low_mem.start
> -					 +1;
> -		add_memmap(memmap_p, crash_reserved_low_mem.start, sz);
> +	for (i = 0; i < crash_reserved_mem_nr; i++) {
> +		sz = crash_reserved_mem[i].end - crash_reserved_mem[i].start +1;
> +		if (add_memmap(memmap_p, crash_reserved_mem[i].start, sz) < 0)
> +			return ENOCRASHKERNEL;
>  	}
>  
>  	/* Create a backup region segment to store backup data*/
> @@ -1101,25 +1097,24 @@ int load_crashdump_segments(struct kexec
>  	return 0;
>  }
>  
> -int is_crashkernel_mem_reserved(void)
> +static int crashkernel_mem_callback(void *UNUSED(data), int nr,
> +                                          char *UNUSED(str),
> +                                          unsigned long base,
> +                                          unsigned long length)
>  {
> -	uint64_t start, end;
> -
> -	if (parse_iomem_single("Crash kernel\n", &start, &end) || start == end)
> -		return 0;
> -
> -	crash_reserved_mem.start = start;
> -	crash_reserved_mem.end = end;
> -	crash_reserved_mem.type = RANGE_RAM;
> -
> -	/* If there is no Crash low kernel, still can go on */
> -	if (parse_iomem_single("Crash kernel low\n", &start, &end) ||
> -					start == end)
> +	if (nr >= CRASH_RESERVED_MEM_NR)
>  		return 1;
>  
> -	crash_reserved_low_mem.start = start;
> -	crash_reserved_low_mem.end = end;
> -	crash_reserved_low_mem.type = RANGE_RAM;
> +	crash_reserved_mem[nr].start = base;
> +	crash_reserved_mem[nr].end   = base + length - 1;
> +	crash_reserved_mem[nr].type  = RANGE_RAM;
> +	return 0;
> +}
> +
> +int is_crashkernel_mem_reserved(void)
> +{
> +	crash_reserved_mem_nr = kexec_iomem_for_each_line("Crash kernel\n",
> +                                       crashkernel_mem_callback, NULL);
>  
> -	return 1;
> +	return !!crash_reserved_mem_nr;
>  }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

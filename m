Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTJbc-0004nk-Fm
 for kexec@lists.infradead.org; Thu, 27 Mar 2014 23:21:06 +0000
Date: Thu, 27 Mar 2014 18:50:14 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 4/4] x86: Pass memory range via E820 for kdump
Message-ID: <20140327225014.GR13816@redhat.com>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
 <1395216241-13983-5-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395216241-13983-5-git-send-email-chaowang@redhat.com>
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

On Wed, Mar 19, 2014 at 04:04:01PM +0800, WANG Chao wrote:
> command line size is restricted by kernel, sometimes memmap=exactmap has
> too many memory ranges to pass to cmdline. A better approach, to pass the
> memory ranges for crash kernel to boot into, is filling the memory
> ranges into E820.
> 
> boot_params only got 128 slots for E820 map to fit in, when the number of
> memory map exceeds 128, use setup_data to pass the rest as extended E820
> memory map.
> 
> kexec boot could also benefit from setup_data in case E820 memory map
> exceeds 128.
> 
> Now this new approach becomes default instead of memmap=exactmap.
> saved_max_pfn users can specify --pass-memmap-cmdline to use the
> exactmap approach.

I think it is worth to also mention that kaslr enabled kernel does not
work with memmap=exactmap.

This patch in general looks good. Two minor nits below.

> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>
> Tested-by: Linn Crosetto <linn@hp.com>
> Reviewed-by: Linn Crosetto <linn@hp.com>
> ---
>  kexec/arch/i386/crashdump-x86.c   |  25 +++---
>  kexec/arch/i386/crashdump-x86.h   |   1 +
>  kexec/arch/i386/x86-linux-setup.c | 171 +++++++++++++++++++++++++-------------
>  3 files changed, 130 insertions(+), 67 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index c55a6b1..cb19e7d 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -182,6 +182,8 @@ static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end);
>  struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
>  int crash_memory_ranges;
>  
> +int pass_memmap_cmdline;
> +
>  /* Memory region reserved for storing panic kernel and other data. */
>  #define CRASH_RESERVED_MEM_NR	8
>  static struct memory_range crash_reserved_mem[CRASH_RESERVED_MEM_NR];
> @@ -947,20 +949,23 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
>  	if (delete_memmap(crash_memory_range, &crash_memory_ranges, elfcorehdr, memsz) < 0)
>  		return -1;
> -	cmdline_add_memmap(mod_cmdline, crash_memory_range);
>  	if (!bzImage_support_efi_boot)
>  		cmdline_add_efi(mod_cmdline);
>  	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
>  
> -	/* Inform second kernel about the presence of ACPI tables. */
> -	for (i = 0; i < CRASH_MAX_MEMORY_RANGES; i++) {
> -		unsigned long start, end;
> -		if ( !( mem_range[i].type == RANGE_ACPI
> -			|| mem_range[i].type == RANGE_ACPI_NVS) )
> -			continue;
> -		start = mem_range[i].start;
> -		end = mem_range[i].end;
> -		cmdline_add_memmap_acpi(mod_cmdline, start, end);
> +	pass_memmap_cmdline = arch_options.pass_memmap_cmdline;
> +	if (pass_memmap_cmdline) {
> +		cmdline_add_memmap(mod_cmdline, crash_memory_range);
> +		/* Inform second kernel about the presence of ACPI tables. */
> +		for (i = 0; i < CRASH_MAX_MEMORY_RANGES; i++) {
> +			unsigned long start, end;
> +			if ( !( mem_range[i].type == RANGE_ACPI
> +						|| mem_range[i].type == RANGE_ACPI_NVS) )
> +				continue;
> +			start = mem_range[i].start;
> +			end = mem_range[i].end;
> +			cmdline_add_memmap_acpi(mod_cmdline, start, end);
> +		}
>  	}
>  
>  	return 0;
> diff --git a/kexec/arch/i386/crashdump-x86.h b/kexec/arch/i386/crashdump-x86.h
> index 633ee0e..e68b626 100644
> --- a/kexec/arch/i386/crashdump-x86.h
> +++ b/kexec/arch/i386/crashdump-x86.h
> @@ -30,5 +30,6 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
>  
>  extern struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
>  extern int crash_memory_ranges;
> +extern int pass_memmap_cmdline;
>  
>  #endif /* CRASHDUMP_X86_H */
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index 5884f4d..e8865e1 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -35,8 +35,7 @@
>  #include "kexec-x86.h"
>  #include "x86-linux-setup.h"
>  #include "../../kexec/kexec-syscall.h"
> -
> -#define SETUP_EFI	4
> +#include "crashdump-x86.h"
>  
>  void init_linux_parameters(struct x86_linux_param_header *real_mode)
>  {
> @@ -502,6 +501,11 @@ struct efi_setup_data {
>  struct setup_data {
>  	uint64_t next;
>  	uint32_t type;
> +#define SETUP_NONE	0
> +#define SETUP_E820_EXT	1
> +#define SETUP_DTB	2
> +#define SETUP_PCI	3
> +#define SETUP_EFI	4
>  	uint32_t len;
>  	uint8_t data[0];
>  } __attribute__((packed));
> @@ -602,6 +606,17 @@ struct efi_info {
>  	uint32_t efi_memmap_hi;
>  };
>  
> +static void add_setup_data(struct kexec_info *info,
> +			   struct x86_linux_param_header *real_mode,
> +			   struct setup_data *sd)
> +{

What is setup_data? A little comment above function will make it easy
to read. Is it that list of elements which contains extra memory map
entries?

> +	int sdsize = sizeof(struct setup_data) + sd->len;
> +
> +	sd->next = real_mode->setup_data;
> +	real_mode->setup_data = add_buffer(info, sd, sdsize, sdsize, getpagesize(),
> +			    0x100000, ULONG_MAX, INT_MAX);
> +}
> +
>  /*
>   * setup_efi_data will collect below data and pass them to 2nd kernel.
>   * 1) SMBIOS, fw_vendor, runtime, config_table, they are passed via x86
> @@ -611,11 +626,11 @@ struct efi_info {
>  static int setup_efi_data(struct kexec_info *info,
>  			  struct x86_linux_param_header *real_mode)
>  {
> -	int64_t setup_data_paddr, memmap_paddr;
> +	int64_t memmap_paddr;
>  	struct setup_data *sd;
>  	struct efi_setup_data *esd;
>  	struct efi_mem_descriptor *maps;
> -	int nr_maps, size, sdsize, ret = 0;
> +	int nr_maps, size, ret = 0;
>  	struct efi_info *ei = (struct efi_info *)real_mode->efi_info;
>  
>  	ret = access("/sys/firmware/efi/systab", F_OK);
> @@ -648,10 +663,8 @@ static int setup_efi_data(struct kexec_info *info,
>  	sd->len = sizeof(*esd);
>  	memcpy(sd->data, esd, sizeof(*esd));
>  	free(esd);
> -	sdsize = sd->len + sizeof(struct setup_data);
> -	setup_data_paddr = add_buffer(info, sd, sdsize, sdsize, getpagesize(),
> -					0x100000, ULONG_MAX, INT_MAX);
> -	real_mode->setup_data = setup_data_paddr;
> +
> +	add_setup_data(info, real_mode, sd);
>  
>  	size = nr_maps * sizeof(struct efi_mem_descriptor);
>  	memmap_paddr = add_buffer(info, maps, size, size, getpagesize(),
> @@ -669,6 +682,98 @@ out:
>  	return ret;
>  }
>  
> +static void add_e820_map_from_mr(struct x86_linux_param_header *real_mode,
> +			struct e820entry *e820, struct memory_range *range, int nr_range)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_range; i++) {
> +		e820[i].addr = range[i].start;
> +		e820[i].size = range[i].end - range[i].start;
> +		switch (range[i].type) {
> +			case RANGE_RAM:
> +				e820[i].type = E820_RAM;
> +				break;
> +			case RANGE_ACPI:
> +				e820[i].type = E820_ACPI;
> +				break;
> +			case RANGE_ACPI_NVS:
> +				e820[i].type = E820_NVS;
> +				break;
> +			default:
> +			case RANGE_RESERVED:
> +				e820[i].type = E820_RESERVED;
> +				break;
> +		}
> +		dbgprintf("%016lx-%016lx (%d)\n",
> +				e820[i].addr,
> +				e820[i].addr + e820[i].size - 1,
> +				e820[i].type);
> +
> +		if (range[i].type != RANGE_RAM)
> +			continue;
> +		if ((range[i].start <= 0x100000) && range[i].end > 0x100000) {
> +			unsigned long long mem_k = (range[i].end >> 10) - (0x100000 >> 10);
> +			real_mode->ext_mem_k = mem_k;
> +			real_mode->alt_mem_k = mem_k;
> +			if (mem_k > 0xfc00) {
> +				real_mode->ext_mem_k = 0xfc00; /* 64M */
> +			}
> +			if (mem_k > 0xffffffff) {
> +				real_mode->alt_mem_k = 0xffffffff;
> +			}
> +		}
> +	}
> +}
> +
> +static void setup_e820_ext(struct kexec_info *info, struct x86_linux_param_header *real_mode,
> +			   struct memory_range *range, int nr_range)
> +{
> +	struct setup_data *sd;
> +	struct e820entry *e820;
> +	int nr_range_ext;
> +
> +	nr_range_ext = nr_range - E820MAX;
> +	sd = xmalloc(sizeof(struct setup_data) + nr_range_ext * sizeof(struct e820entry));
> +	sd->next = 0;
> +	sd->len = nr_range_ext * sizeof(struct e820entry);
> +	sd->type = SETUP_E820_EXT;
> +
> +	e820 = (struct e820entry *) sd->data;
> +	dbgprintf("Extended E820 via setup_data:\n");
> +	add_e820_map_from_mr(real_mode, e820, range + E820MAX, nr_range_ext);
> +	add_setup_data(info, real_mode, sd);
> +}
> +
> +static void setup_e820(struct kexec_info *info, struct x86_linux_param_header *real_mode)
> +{
> +	struct memory_range *range;
> +	int nr_range, nr_range_saved;
> +
> +
> +	if (info->kexec_flags & KEXEC_ON_CRASH && !pass_memmap_cmdline) {
> +		range = crash_memory_range;
> +		nr_range = crash_memory_ranges;

You know what, it might be a good idea to store the pointer to
crash_memory_range in kexec_info too, (like memory_range and
memory_ranges).

> +	} else {
> +		range = info->memory_range;
> +		nr_range = info->memory_ranges;
> +	}
> +
> +	nr_range_saved = nr_range;
> +	if (nr_range > E820MAX) {
> +		nr_range = E820MAX;
> +	}
> +
> +	real_mode->e820_map_nr = nr_range;
> +	dbgprintf("E820 memmap:\n");
> +	add_e820_map_from_mr(real_mode, real_mode->e820_map, range, nr_range);
> +
> +	if (nr_range_saved > E820MAX) {
> +		dbgprintf("extra E820 memmap are passed via setup_data\n");
> +		setup_e820_ext(info, real_mode, range, nr_range_saved);
> +	}
> +}
> +
>  static int
>  get_efi_mem_desc_version(struct x86_linux_param_header *real_mode)
>  {
> @@ -702,10 +807,6 @@ static void setup_efi_info(struct kexec_info *info,
>  void setup_linux_system_parameters(struct kexec_info *info,
>  				   struct x86_linux_param_header *real_mode)
>  {
> -	/* Fill in information the BIOS would usually provide */
> -	struct memory_range *range;
> -	int i, ranges;
> -
>  	/* get subarch from running kernel */
>  	setup_subarch(real_mode);
>  	if (bzImage_support_efi_boot)
> @@ -746,51 +847,7 @@ void setup_linux_system_parameters(struct kexec_info *info,
>  	/* another safe default */
>  	real_mode->aux_device_info = 0;
>  
> -	range = info->memory_range;
> -	ranges = info->memory_ranges;
> -	if (ranges > E820MAX) {
> -		if (!(info->kexec_flags & KEXEC_ON_CRASH))
> -			/*
> -			 * this e820 not used for capture kernel, see
> -			 * do_bzImage_load()
> -			 */
> -			fprintf(stderr,
> -				"Too many memory ranges, truncating...\n");
> -		ranges = E820MAX;
> -	}
> -	real_mode->e820_map_nr = ranges;
> -	for(i = 0; i < ranges; i++) {
> -		real_mode->e820_map[i].addr = range[i].start;
> -		real_mode->e820_map[i].size = range[i].end - range[i].start;
> -		switch (range[i].type) {
> -		case RANGE_RAM:
> -			real_mode->e820_map[i].type = E820_RAM; 
> -			break;
> -		case RANGE_ACPI:
> -			real_mode->e820_map[i].type = E820_ACPI; 
> -			break;
> -		case RANGE_ACPI_NVS:
> -			real_mode->e820_map[i].type = E820_NVS;
> -			break;
> -		default:
> -		case RANGE_RESERVED:
> -			real_mode->e820_map[i].type = E820_RESERVED; 
> -			break;
> -		}
> -		if (range[i].type != RANGE_RAM)
> -			continue;
> -		if ((range[i].start <= 0x100000) && range[i].end > 0x100000) {
> -			unsigned long long mem_k = (range[i].end >> 10) - (0x100000 >> 10);
> -			real_mode->ext_mem_k = mem_k;
> -			real_mode->alt_mem_k = mem_k;
> -			if (mem_k > 0xfc00) {
> -				real_mode->ext_mem_k = 0xfc00; /* 64M */
> -			}
> -			if (mem_k > 0xffffffff) {
> -				real_mode->alt_mem_k = 0xffffffff;
> -			}
> -		}
> -	}
> +	setup_e820(info, real_mode);
>  
>  	/* fill the EDD information */
>  	setup_edd_info(real_mode);
> -- 
> 1.8.5.3
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTNS2-0008Hu-6K
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 03:27:27 +0000
Date: Fri, 28 Mar 2014 11:28:19 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 4/4] x86: Pass memory range via E820 for kdump
Message-ID: <20140328032819.GE26116@dhcp-16-126.nay.redhat.com>
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
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On 03/19/14 at 04:04pm, WANG Chao wrote:
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

Could you split the above add_setup_data to another patch?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

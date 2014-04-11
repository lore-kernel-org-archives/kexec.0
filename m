Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYRD9-0000dM-VD
 for kexec@lists.infradead.org; Fri, 11 Apr 2014 02:29:00 +0000
Date: Fri, 11 Apr 2014 10:28:32 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 09/10] x86: Pass memory range via E820 for kdump
Message-ID: <20140411022831.GG5493@dhcp-16-198.nay.redhat.com>
References: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
 <1397121186-9353-14-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397121186-9353-14-git-send-email-chaowang@redhat.com>
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

On 04/10/14 at 05:13pm, WANG Chao wrote:
> command line size is restricted by kernel, sometimes memmap=exactmap has
> too many memory ranges to pass to cmdline. And also memmap=exactmap and
> kASLR doesn't work together.
> 
> A better approach, to pass the memory ranges for crash kernel to boot
> into, is filling the memory ranges into E820.
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
> Signed-off-by: WANG Chao <chaowang@redhat.com>
> ---
>  kexec/arch/i386/crashdump-x86.c   |   6 +-
>  kexec/arch/i386/x86-linux-setup.c | 149 +++++++++++++++++++++++++-------------
>  kexec/arch/i386/x86-linux-setup.h |   1 +
>  3 files changed, 103 insertions(+), 53 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 2a6871d..2c0dbe3 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -979,7 +979,8 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
>  	if (delete_memmap(memmap_p, &nr_memmap_p, elfcorehdr, memsz) < 0)
>  		return -1;
> -	cmdline_add_memmap(mod_cmdline, memmap_p);
> +	if (arch_options.pass_memmap_cmdline)
> +		cmdline_add_memmap(mod_cmdline, memmap_p);
>  	if (!bzImage_support_efi_boot)
>  		cmdline_add_efi(mod_cmdline);
>  	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
> @@ -995,7 +996,8 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  		type = mem_range[i].type;
>  		size = end - start;
>  		add_memmap(memmap_p, &nr_memmap_p, start, size, type);
> -		cmdline_add_memmap_acpi(mod_cmdline, start, end);
> +		if (arch_options.pass_memmap_cmdline)
> +			cmdline_add_memmap_acpi(mod_cmdline, start, end);
>  	}
>  
>  	/* Store 2nd kernel boot memory ranges for later reference in
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index 8ed36cc..2f9bb97 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -36,8 +36,6 @@
>  #include "x86-linux-setup.h"
>  #include "../../kexec/kexec-syscall.h"
>  
> -#define SETUP_EFI	4
> -
>  void init_linux_parameters(struct x86_linux_param_header *real_mode)
>  {
>  	/* Fill in the values that are usually provided by the kernel. */
> @@ -502,6 +500,11 @@ struct efi_setup_data {
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
> @@ -684,6 +687,98 @@ out:
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

I see it's same as original code but I still feel it should be end - start + 1;

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

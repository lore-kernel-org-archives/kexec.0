Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hTeDH-0001B7-VP
 for kexec@lists.infradead.org; Thu, 23 May 2019 03:16:17 +0000
Date: Thu, 23 May 2019 11:16:09 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 2/4] x86: Introduce helpers for getting RSDP address
Message-ID: <20190523031609.GB8174@dhcp-128-65.nay.redhat.com>
References: <20190514050959.21093-1-kasong@redhat.com>
 <20190514050959.21093-3-kasong@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190514050959.21093-3-kasong@redhat.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>

On 05/14/19 at 01:09pm, Kairui Song wrote:
> On x86 RSDP is fundamental for booting the machine. When second kernel
> is incapable of parsing the RSDP address (eg. kexec next kernel on an EFI
> system with EFI service disabled), kexec should prepare the RSDP address
> for second kernel.
> 
> Introduce helpers for getting RSDP from multiple sources, including boot
> params, cmdline and EFI firmware.
> 
> For legacy BIOS interface, there is no better way to find the RSDP address
> rather than scanning the memory region and search for it, and this will
> always be done by the kernel as a fallback, so this is no need to try to
> get the RSDP address for that case.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  kexec/arch/i386/kexec-x86-common.c | 60 ++++++++++++++++++++++++++++++
>  kexec/arch/i386/kexec-x86.h        |  1 +
>  kexec/arch/i386/x86-linux-setup.c  |  3 +-
>  kexec/arch/i386/x86-linux-setup.h  |  1 +
>  4 files changed, 63 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
> index de99758..4b8eb26 100644
> --- a/kexec/arch/i386/kexec-x86-common.c
> +++ b/kexec/arch/i386/kexec-x86-common.c
> @@ -39,6 +39,7 @@
>  #include "../../firmware_memmap.h"
>  #include "../../crashdump.h"
>  #include "kexec-x86.h"
> +#include "x86-linux-setup.h"
>  #include "../../kexec-xen.h"
>  
>  /* Used below but not present in (older?) xenctrl.h */
> @@ -392,4 +393,63 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
>  	return ret;
>  }
>  
> +static uint64_t cmdline_get_acpi_rsdp(void) {
> +	uint64_t acpi_rsdp = 0;
> +	char *tmp_cmdline, *rsdp_param;
>  
> +	tmp_cmdline = get_command_line();
> +	rsdp_param = strstr(tmp_cmdline, "acpi_rsdp=");

strstr will locate the first acpi_rsdp, what about multiple acpi_rsdp
provided?

BTW, if one provide a wrong adress in acpi_rsdp= cmdline then it is not
usable.

So not sure if adding this cmdline param is necessary, maybe only add
efi case will be reliable.

> +
> +	if (rsdp_param)
> +		sscanf(rsdp_param, "acpi_rsdp=%lx", &acpi_rsdp);
> +
> +	free(tmp_cmdline);
> +	return acpi_rsdp;
> +}
> +
> +static uint64_t bootparam_get_acpi_rsdp(void) {
> +	uint64_t acpi_rsdp = 0;
> +	off_t offset = offsetof(struct x86_linux_param_header, acpi_rsdp_addr);
> +
> +	if (get_bootparam(&acpi_rsdp, offset, sizeof(acpi_rsdp)))
> +		return 0;
> +
> +	return acpi_rsdp;
> +}
> +
> +static uint64_t efi_get_acpi_rsdp(void) {
> +	FILE *fp;
> +	char line[MAX_LINE], *s;
> +	uint64_t acpi_rsdp = 0;
> +
> +	fp = fopen("/sys/firmware/efi/systab", "r");
> +	if (!fp)
> +		return acpi_rsdp;
> +
> +	while(fgets(line, sizeof(line), fp) != 0) {
> +		/* ACPI20= always goes before ACPI= */
> +		if ((strstr(line, "ACPI20=")) || (strstr(line, "ACPI="))) {
> +			s = strchr(line, '=') + 1;
> +			sscanf(s, "0x%lx", &acpi_rsdp);
> +			break;
> +		}
> +	}
> +	fclose(fp);
> +
> +	return acpi_rsdp;
> +}
> +
> +uint64_t get_acpi_rsdp(void)
> +{
> +	uint64_t acpi_rsdp = 0;
> +
> +	acpi_rsdp = cmdline_get_acpi_rsdp();
> +
> +	if (!acpi_rsdp)
> +		acpi_rsdp = bootparam_get_acpi_rsdp();
> +
> +	if (!acpi_rsdp)
> +		acpi_rsdp = efi_get_acpi_rsdp();
> +
> +	return acpi_rsdp;
> +}
> diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
> index c2bcd37..1b58c3b 100644
> --- a/kexec/arch/i386/kexec-x86.h
> +++ b/kexec/arch/i386/kexec-x86.h
> @@ -86,4 +86,5 @@ int nbi_load(int argc, char **argv, const char *buf, off_t len,
>  void nbi_usage(void);
>  
>  extern unsigned xen_e820_to_kexec_type(uint32_t type);
> +extern uint64_t get_acpi_rsdp(void);
>  #endif /* KEXEC_X86_H */
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index 8fad115..5ca7c25 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -123,7 +123,6 @@ void setup_linux_bootloader_parameters_high(
>  	cmdline_ptr[cmdline_len - 1] = '\0';
>  }
>  
> -static int get_bootparam(void *buf, off_t offset, size_t size);
>  static int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
>  {
>  	struct fb_fix_screeninfo fix;
> @@ -452,7 +451,7 @@ char *find_mnt_by_fsname(char *fsname)
>  	return mntdir;
>  }
>  
> -static int get_bootparam(void *buf, off_t offset, size_t size)
> +int get_bootparam(void *buf, off_t offset, size_t size)
>  {
>  	int data_file;
>  	char *debugfs_mnt, *sysfs_mnt;
> diff --git a/kexec/arch/i386/x86-linux-setup.h b/kexec/arch/i386/x86-linux-setup.h
> index f5d23d3..0c651e5 100644
> --- a/kexec/arch/i386/x86-linux-setup.h
> +++ b/kexec/arch/i386/x86-linux-setup.h
> @@ -21,6 +21,7 @@ static inline void setup_linux_bootloader_parameters(
>  }
>  void setup_linux_system_parameters(struct kexec_info *info,
>  	struct x86_linux_param_header *real_mode);
> +int get_bootparam(void *buf, off_t offset, size_t size);
>  
>  
>  #define SETUP_BASE    0x90000
> -- 
> 2.20.1
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

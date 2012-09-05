Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g6t0185.atlanta.hp.com ([15.193.32.62])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T9Oj3-0005xY-Ft
 for kexec@lists.infradead.org; Wed, 05 Sep 2012 23:09:38 +0000
Message-ID: <5047DBA9.8030000@hp.com>
Date: Wed, 05 Sep 2012 17:09:29 -0600
From: Khalid Aziz <khalid.aziz@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH]kdump: pass noefi and acpi_rsdp= to 2nd kernel
References: <20120905054445.GA6370@dhcp-16-143.nay.redhat.com>
In-Reply-To: <20120905054445.GA6370@dhcp-16-143.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, dyoung@redhat.com
Cc: horms@verge.net.au, vgoyal@redhat.com

On 09/04/2012 11:44 PM, Dave Young wrote:
> In case efi booting, kdump need kernel parameter noefi and acpi_rsdp=
> to disable efi reinit and retrieve the acpi root table physical address.
>
> Add a function cmdline_add_efi to get the address from /sys/firmware/efi/systab
> If there's no such file or read fail the function will just do nothing.
>
> Tested efi boot Fedora 17 on thinkpad T420.
>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>   kexec/arch/i386/crashdump-x86.c |   47 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>
> --- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
> +++ kexec-tools/kexec/arch/i386/crashdump-x86.c
> @@ -27,6 +27,7 @@
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <unistd.h>
> +#include <fcntl.h>
>   #include "../../kexec.h"
>   #include "../../kexec-elf.h"
>   #include "../../kexec-syscall.h"
> @@ -658,6 +659,51 @@ static int cmdline_add_memmap_acpi(char
>   	return 0;
>   }
>   
> +/* Appends 'noefi acpi_rsdp=' commandline for efi boot crash dump */
> +static void cmdline_add_efi(char *cmdline)
> +{
> +	int cmdlen, len, fd, ret, i = 0;
> +	char str_efi[64], str_tmp[32];
> +
> +	memset(str_efi, 0x0, sizeof(str_efi));
> +	memset(str_tmp, 0x0, sizeof(str_tmp));
> +	snprintf(str_efi, 18, "%s", " noefi acpi_rsdp=");
> +
> +	fd = open("/sys/firmware/efi/systab", O_RDONLY);
> +	if (fd < 0)
> +		return;
> +
> +	while(1) {
> +		ret = read(fd, &str_tmp[i], 1);
> +		if (ret <= 0)
> +			goto out_close;
> +		if (str_tmp[i] == '\n') {
> +			str_tmp[i] = '\0';
> +			break;
> +		}
> +		i++;
> +	}
> +
> +	if (!(strncmp(str_tmp, "ACPI20=", 7)))
> +		strcat(str_efi, &str_tmp[7]);
> +	else if (!(strncmp(str_tmp, "ACPI=", 5)))
> +		strcat(str_efi, &str_tmp[5]);
> +	else
> +		goto out_close;

This will evaluate only the first line in systab. I do not believe you 
are guaranteed to see ACPI20= or ACPI= in the first line. Here is the 
systab file from my machine:

MPS=0xf4cf0
ACPI20=0xcac3e000
ACPI=0xcac3e000
SMBIOS=0xcac4cf98

We need to parse all the lines in systab.
> +
> +	len = strlen(str_efi);
> +	cmdlen = strlen(cmdline) + len;
> +	if (cmdlen > (COMMAND_LINE_SIZE - 1))
> +		die("Command line overflow\n");
> +	strcat(cmdline, str_efi);
> +
> +	dbgprintf("Command line after adding efi\n");
> +	dbgprintf("%s\n", cmdline);
> +
> +out_close:
> +	close(fd);
> +}
> +
>   static void get_backup_area(unsigned long *start, unsigned long *end)
>   {
>   	const char *iomem = proc_iomem();
> @@ -830,6 +876,7 @@ int load_crashdump_segments(struct kexec
>   	if (delete_memmap(memmap_p, elfcorehdr, memsz) < 0)
>   		return -1;
>   	cmdline_add_memmap(mod_cmdline, memmap_p);
> +	cmdline_add_efi(mod_cmdline);
>   	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
>   
>   	/* Inform second kernel about the presence of ACPI tables. */
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

I think running a kexec/kdump kernel with "noefi" is not a good idea. 
Today kernel makes very little use of UEFI run time services but this 
might change shortly. I have already seen ideas being proposed to use 
UEFI variables to store kernel panic information which would require 
accessing UEFI runtime services. If the kdump kernel runs into a panic, 
it would be good to be able to use UEFI variables to store some sort of 
tombstone. We might also start using UEFI runtime clock services one of 
these days especially now that all PCs soon will have UEFI due to 
Windows 8 requirements. There might be other ways to deal with EFI 
virtualization issue. I have solved it on a custom ia64 kernel by 
passing the kexec'd kernel a "kexec_reboot" on command line, although I 
wouldn't recommend that approach as a general approach. Creating a new 
kernel command line parameter just to tell the kernel to not virtualize 
EFI sounds excessive. May be we can come up with a different way to tell 
a kexec/kdump kernel to not virtualize EFI, like create a new signature, 
for example "EL32_KEXEC" and "EL64_KEXEC", for 
boot_params.efi_info.efi_loader_signature which tells the kexec/kdump 
kernel to enable EFI but skip the step of virtualizing it. More work 
will be needed to make this work, for example pass the EFI runtime 
service memory map from one kernel to the next so we keep it mapped in 
exact same spot, and other similar mapping issues.

-- 
Khalid

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

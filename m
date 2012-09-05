Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9AJF-0006vi-77
 for kexec@lists.infradead.org; Wed, 05 Sep 2012 07:46:02 +0000
Date: Wed, 5 Sep 2012 16:45:55 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH]kdump: pass noefi and acpi_rsdp= to 2nd kernel
Message-ID: <20120905074550.GA11575@verge.net.au>
References: <20120905054445.GA6370@dhcp-16-143.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120905054445.GA6370@dhcp-16-143.nay.redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, vgoyal@redhat.com

On Wed, Sep 05, 2012 at 01:44:45PM +0800, Dave Young wrote:
> 
> In case efi booting, kdump need kernel parameter noefi and acpi_rsdp=
> to disable efi reinit and retrieve the acpi root table physical address.
> 
> Add a function cmdline_add_efi to get the address from /sys/firmware/efi/systab
> If there's no such file or read fail the function will just do nothing.
> 
> Tested efi boot Fedora 17 on thinkpad T420.

Hi Dave,

conceptually I am fine with this patch.
However, I do have a few nits in relation to the string handling
as explained below.

> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  kexec/arch/i386/crashdump-x86.c |   47 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> --- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
> +++ kexec-tools/kexec/arch/i386/crashdump-x86.c
> @@ -27,6 +27,7 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <unistd.h>
> +#include <fcntl.h>
>  #include "../../kexec.h"
>  #include "../../kexec-elf.h"
>  #include "../../kexec-syscall.h"
> @@ -658,6 +659,51 @@ static int cmdline_add_memmap_acpi(char 
>  	return 0;
>  }
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

strncpy() might be be easier on the eyes.

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

It seems to me that the above code may overflow str_tmp.

Also, I wonder if read(fd, str_tmp, sizeof str_tmp) might make
things a bit easier over all.

Finally, I have a personal preference for "a + i" over "&a[i]".
Though I'm not going to get excited about it.

> +
> +	if (!(strncmp(str_tmp, "ACPI20=", 7)))
> +		strcat(str_efi, &str_tmp[7]);
> +	else if (!(strncmp(str_tmp, "ACPI=", 5)))
> +		strcat(str_efi, &str_tmp[5]);
> +	else
> +		goto out_close;

I wonder if strncat() would be better above, though I don't think
an overflow can actually occur if str_tmp is null-terminated.

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
>  static void get_backup_area(unsigned long *start, unsigned long *end)
>  {
>  	const char *iomem = proc_iomem();
> @@ -830,6 +876,7 @@ int load_crashdump_segments(struct kexec
>  	if (delete_memmap(memmap_p, elfcorehdr, memsz) < 0)
>  		return -1;
>  	cmdline_add_memmap(mod_cmdline, memmap_p);
> +	cmdline_add_efi(mod_cmdline);
>  	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
>  
>  	/* Inform second kernel about the presence of ACPI tables. */
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

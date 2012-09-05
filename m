Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9FVQ-00033i-Fj
 for kexec@lists.infradead.org; Wed, 05 Sep 2012 13:18:57 +0000
Date: Wed, 5 Sep 2012 09:18:52 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH]kdump: pass noefi and acpi_rsdp= to 2nd kernel
Message-ID: <20120905131852.GB19749@redhat.com>
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
Cc: horms@verge.net.au, kexec@lists.infradead.org

On Wed, Sep 05, 2012 at 01:44:45PM +0800, Dave Young wrote:
> 
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

Hi Dave,

It might be better to break it down in two functions. One for each
command line parameter.

Also, what's the corelation of efi and acpi_rsdp. Is acpi_rsdp required
only on EFI boot or in general it is required? If it is required in 
general, why kdump works currently.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

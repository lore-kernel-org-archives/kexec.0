Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9SM3-0004vl-4b
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 03:02:09 +0000
Message-ID: <5048114F.4050108@redhat.com>
Date: Thu, 06 Sep 2012 10:58:23 +0800
From: Dave Young <dyoung@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH]kdump: pass noefi and acpi_rsdp= to 2nd kernel
References: <20120905054445.GA6370@dhcp-16-143.nay.redhat.com>
 <20120905131852.GB19749@redhat.com>
In-Reply-To: <20120905131852.GB19749@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

On 09/05/2012 09:18 PM, Vivek Goyal wrote:

> On Wed, Sep 05, 2012 at 01:44:45PM +0800, Dave Young wrote:
>>
>> In case efi booting, kdump need kernel parameter noefi and acpi_rsdp=
>> to disable efi reinit and retrieve the acpi root table physical address.
>>
>> Add a function cmdline_add_efi to get the address from /sys/firmware/efi/systab
>> If there's no such file or read fail the function will just do nothing.
>>
>> Tested efi boot Fedora 17 on thinkpad T420.
>>
>> Signed-off-by: Dave Young <dyoung@redhat.com>
>> ---
>>  kexec/arch/i386/crashdump-x86.c |   47 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>
>> --- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
>> +++ kexec-tools/kexec/arch/i386/crashdump-x86.c
>> @@ -27,6 +27,7 @@
>>  #include <sys/types.h>
>>  #include <sys/stat.h>
>>  #include <unistd.h>
>> +#include <fcntl.h>
>>  #include "../../kexec.h"
>>  #include "../../kexec-elf.h"
>>  #include "../../kexec-syscall.h"
>> @@ -658,6 +659,51 @@ static int cmdline_add_memmap_acpi(char 
>>  	return 0;
>>  }
>>  
>> +/* Appends 'noefi acpi_rsdp=' commandline for efi boot crash dump */
>> +static void cmdline_add_efi(char *cmdline)
>> +{
> 
> Hi Dave,
> 
> It might be better to break it down in two functions. One for each
> command line parameter.


Ok, will do

> 
> Also, what's the corelation of efi and acpi_rsdp. Is acpi_rsdp required
> only on EFI boot or in general it is required? If it is required in 
> general, why kdump works currently.


Hi, here is the background of this issue:
http://lists.infradead.org/pipermail/kexec/2010-March/003889.html

> 
> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



-- 
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

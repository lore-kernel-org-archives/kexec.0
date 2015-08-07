Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g2t2353.austin.hp.com ([15.217.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZNWGc-0001mg-V2
 for kexec@lists.infradead.org; Fri, 07 Aug 2015 01:16:15 +0000
Message-ID: <1438910038.3109.116.camel@hp.com>
Subject: Re: kexec, x86: Need a new e820 type support for kexec
From: Toshi Kani <toshi.kani@hp.com>
Date: Thu, 06 Aug 2015 19:13:58 -0600
In-Reply-To: <20150806081231.GA16699@dhcp-128-28.nay.redhat.com>
References: <1437697592.3214.373.camel@hp.com>
 <20150806081231.GA16699@dhcp-128-28.nay.redhat.com>
Mime-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>, dan.j.williams@intel.com, hch@lst.de
Cc: linux-nvdimm@ml01.01.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, 2015-08-06 at 16:12 +0800, Baoquan He wrote:
> Hi Toshi,
> 
> Does this patch work for you?

Hi Baoquan,

I have tested the patch with both E820_PMEM and E820_PRAM setups, and
confirmed it works fine for both cases. :-)  I did multiple kexec reboots
followed by a kdump in my testing.  So, please feel free to add:
 
Tested-by: Toshi Kani <toshi.kani@hp.com>

> There are things I am not sure. When jump to kexec/kdump kernel is this
> PMEM still needed by system? 

Yes, after a kexec reboot, the kernel needs to be able to use NVDIMM as
before.  While the kernel actually uses NFIT table, not e820, the range
should be marked as PMEM for consistency.  The same goes to kdump kernel
since NVDIMM may be used as a dump device in future.

> And what's the difference between PRAM and
> PMEM? I saw in kernel commit ec776ef6 it introduced E820_PRAM for the
> non-standard protected e820 type, then in kernel commit ad5fb870 it
> introduced E820_PMEM for ACPI 6.0 persistent memory types. While it
> doesn't add complete support for E820_PMEM like E820_PRAM if I
> understand it correctly.

ACPI 6.0 spec defines E820_PMEM, which is used for NVDIMM devices from now
on.  ACPI 6.0 also defines NFIT table for NVDIMM along with this type.

Before these are defined in ACPI, E820_PRAM type was "unofficially" used by
some NVDIMM devices.  So, E820_PRAM was added for such legacy NVDIMMs. 
 Since the E820_PRAM case is very simple (it does not have any other FW
tables), it can be easily emulated with the "memmap=nn!ss" option.  So,
people may use the memmap option to emulate this legacy NVDIMM.    

>  In this patch I simply pass E820_PMEM to kdump
> kernel as E820_PRAM when it emerges since kernel can parse E820_PRAM
> only in parse_memmap_one(), otherwise E820_PMEM has to be discarded or
> need be passed as E820_RESERVED. What do you think about this, need
> E820_PMEM be differentiated with E820_PRAM strictly? If yes, I think a
> kernel patch need be posted to fix this. If not, this patch is enough
> for supporting both of them in kexec.

E820_PMEM cannot be emulated by the "memmap=" option.  Do you have to use
the "memmap=" options to pass the ranges for kdump kernel?  If so, I'd
rather ignore E820_PMEM and let it be passed as E820_RESERVED.  The kdump
kernel can still obtain the info from NFIT if necessary.

As for the code change...

> @@ -640,6 +644,8 @@ static void cmdline_add_memmap_internal(char *cmdline, 
> unsigned long startk,
>  		strcat (str_mmap, "K$");
>  	else if (type == RANGE_ACPI || type == RANGE_ACPI_NVS)
>  		strcat (str_mmap, "K#");
> +	else if (type == RANGE_PMEM || type == RANGE_PRAM)
> +		strcat (str_mmap, "K!");

It should only check with RANGE_PRAM, but I do not think this change matters
much unless you also modify the caller cmdline_add_memmap(), which has the
following check to skip other types.  I do not think we will use legacy
NVDIMM device as a dump device, so you may ignore RANGE_PRAM and let it be
passed as RESERVED as well (which is likely the case I tested with).

                /* Only adding memory regions of RAM and ACPI */
                if (type != RANGE_RAM &&
                    type != RANGE_ACPI &&
                    type != RANGE_ACPI_NVS)
                        continue;

Thanks,
-Toshi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

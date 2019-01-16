Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjbwk-0007mW-8H
 for kexec@lists.infradead.org; Wed, 16 Jan 2019 03:32:56 +0000
Date: Wed, 16 Jan 2019 11:32:43 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
Message-ID: <20190116033243.GB9649@dhcp-128-65.nay.redhat.com>
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115231005.GF6596@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: rafael.j.wysocki@intel.com, Kairui Song <kasong@redhat.com>, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robert.moore@intel.com, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, erik.schmauss@intel.com, akpm@linux-foundation.org, Chao Fan <fanc.fnst@cn.fujitsu.com>, lenb@kernel.org

On 01/16/19 at 12:10am, Borislav Petkov wrote:
> On Tue, Jan 15, 2019 at 05:58:34PM +0800, Kairui Song wrote:
> > When efi=noruntime or efi=oldmap is used, EFI services won't be available
> > in the second kernel, therefore the second kernel will not be able to get
> > the ACPI RSDP address from firmware by calling EFI services and won't
> > boot. Previously we are expecting the user to set the acpi_rsdp=<addr>
> > on kernel command line for second kernel as there was no way to pass RSDP
> > address to second kernel.
> > 
> > After commit e6e094e053af ('x86/acpi, x86/boot: Take RSDP address from
> > boot params if available'), now it's possible to set an acpi_rsdp_addr
> > parameter in the boot_params passed to second kernel, this commit make
> > use of it, detect and set the RSDP address when it's required for second
> > kernel to boot.
> > 
> > Tested with an EFI enabled KVM VM with efi=noruntime.
> > 
> > Suggested-by: Dave Young <dyoung@redhat.com>
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > ---
> >  arch/x86/kernel/kexec-bzimage64.c | 21 +++++++++++++++++++++
> >  drivers/acpi/acpica/tbxfroot.c    |  3 +--
> >  include/acpi/acpixf.h             |  2 +-
> >  3 files changed, 23 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> > index 53917a3ebf94..0a90dcbd041f 100644
> > --- a/arch/x86/kernel/kexec-bzimage64.c
> > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/efi.h>
> >  #include <linux/verification.h>
> > +#include <linux/acpi.h>
> >  
> >  #include <asm/bootparam.h>
> >  #include <asm/setup.h>
> > @@ -255,8 +256,28 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
> >  	/* Setup EFI state */
> >  	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
> >  			efi_setup_data_offset);
> > +
> > +#ifdef CONFIG_ACPI
> > +	/* Setup ACPI RSDP pointer in case EFI is not available in second kernel */
> > +	if (!acpi_disabled && (!efi_enabled(EFI_RUNTIME_SERVICES) || efi_enabled(EFI_OLD_MEMMAP))) {
> > +		/* Copied from acpi_os_get_root_pointer accordingly */
> > +		params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
> > +		if (!params->acpi_rsdp_addr) {
> > +			if (efi_enabled(EFI_CONFIG_TABLES)) {
> > +				if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
> > +					params->acpi_rsdp_addr = efi.acpi20;
> > +				else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
> > +					params->acpi_rsdp_addr = efi.acpi;
> > +			} else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
> > +				acpi_find_root_pointer(&params->acpi_rsdp_addr);
> > +			}
> > +		}
> > +		if (!params->acpi_rsdp_addr)
> > +			pr_warn("RSDP is not available for second kernel\n");
> > +	}
> >  #endif
> 
> Amazing the amount of ACPI RDSP parsing and fiddling patches flying
> around these days...
> 
> In any case, this needs to be synchronized with:
> 
> https://lkml.kernel.org/r/20190107032243.25324-1-fanc.fnst@cn.fujitsu.com
> 
> and checked whether the above can be used instead of sprinkling of ACPI
> parsing code left and right.

Both Baoquan and Chao are cced for comments.
The above KASLR patches seems some early code to parsing acpi, but I think in this
patch just call acpi function to get the root pointer no need to add the
duplicate logic of if/else/else if. 

Kairui,  do you have any reason for the checking?  Is there some simple
acpi function to just return the root pointer?

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

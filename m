Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hKcZ2-0003dz-6C
 for kexec@lists.infradead.org; Sun, 28 Apr 2019 05:41:25 +0000
Date: Sun, 28 Apr 2019 13:41:14 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v5 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190428054114.GS3584@localhost.localdomain>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190427161121.GC12360@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190427161121.GC12360@zn.tnic>
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
Cc: x86@kernel.org, kasong@redhat.com, fanc.fnst@cn.fujitsu.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, j-nomura@ce.jp.nec.com, tglx@linutronix.de, dyoung@redhat.com

On 04/27/19 at 06:11pm, Borislav Petkov wrote:
> On Wed, Apr 24, 2019 at 05:29:43PM +0800, Baoquan He wrote:
> > From: Kairui Song <kasong@redhat.com>
> > 
> > The current code only builds identity mapping for physical memory during
> > kexec-type loading. The regions reserved by firmware are not covered.
> > In the next patch, the boot decompressing code of kexec-ed kernel tries
> 
> There's no guarantee that when this patch gets applied, the next patch
> will be the one you mean. So explain what you mean here instead.

All agreed, will update all of them, thanks.

About this place, do you think below change is OK to you?

~~~
The current code only builds identity mapping for physical memory during
kexec-type loading. The regions reserved by firmware are not covered.
In the later code change, the boot decompressing code of kexec-ed kernel
will try to access EFI systab and ACPI tables, lacking identity mapping for
them will cause error and reset system to firmware.

Thanks
Baoquan

> > 
> > This error doesn't happen on all systems. Because kexec enables gbpages
> > to build identity mapping, the EFI systab and ACPI tables could have been
> > covered if they share the same 1 GB area with physical memory. To make
> > sure, we should map them always.
> > 
> > So here add mapping for them.
> > 
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> 
> When you send someone else's patch, you need to add your SOB. Lemme
> point you to
> 
>   Documentation/process/submitting-patches.rst
> 
> again. Please have a deeper look.
> 
> > ---
> >  arch/x86/kernel/machine_kexec_64.c | 86 ++++++++++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > index ceba408ea982..77b40c3e28d7 100644
> > --- a/arch/x86/kernel/machine_kexec_64.c
> > +++ b/arch/x86/kernel/machine_kexec_64.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/io.h>
> >  #include <linux/suspend.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/efi.h>
> >  
> >  #include <asm/init.h>
> >  #include <asm/pgtable.h>
> > @@ -29,6 +30,48 @@
> >  #include <asm/setup.h>
> >  #include <asm/set_memory.h>
> >  
> > +#ifdef CONFIG_ACPI
> > +/**
> 
> Two stars '**' are kernel-doc style but this comment is implementation
> detail and is irrelevant for kernel-doc ouput.
> 
> > + * Used while adding mapping for ACPI tables.
> > + * Can be reused when other iomem regions need be mapped
> > + */
> > +struct init_pgtable_data {
> > +	struct x86_mapping_info *info;
> > +	pgd_t *level4p;
> > +};
> > +
> > +static int mem_region_callback(struct resource *res, void *arg)
> > +{
> > +	struct init_pgtable_data *data = arg;
> > +	unsigned long mstart, mend;
> > +
> > +	mstart = res->start;
> > +	mend = mstart + resource_size(res) - 1;
> > +
> > +	return kernel_ident_mapping_init(data->info,
> > +			data->level4p, mstart, mend);
> 
> Do not break that line.
> 
> > +}
> > +
> > +static int init_acpi_pgtable(struct x86_mapping_info *info,
> > +				   pgd_t *level4p)
> 
> static int
> map_acpi_tables(...)
> 
> > +{
> > +	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> > +	struct init_pgtable_data data;
> > +
> > +	data.info = info;
> > +	data.level4p = level4p;
> > +	flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> > +	return walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
> > +				   &data, mem_region_callback);
> > +}
> > +#else
> > +static int init_acpi_pgtable(struct x86_mapping_info *info,
> > +				   pgd_t *level4p)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >  #ifdef CONFIG_KEXEC_FILE
> >  const struct kexec_file_ops * const kexec_file_loaders[] = {
> >  		&kexec_bzImage64_ops,
> > @@ -36,6 +79,37 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
> >  };
> >  #endif
> >  
> > +#ifdef CONFIG_EFI
> > +static int init_efi_systab_pgtable(struct x86_mapping_info *info,
> > +				   pgd_t *level4p)
> 
> This function's name is wrong. Make it like this:
> 
> static int
> map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
> {
> #ifdef CONFIG_EFI
> 
> 	...
> 
> #endif
> 
> 	return 0;
> }
> 
> and drop the #else ifdeffery.
> 
> 
> > +{
> > +	unsigned long mstart, mend;
> > +
> > +	if (!efi_enabled(EFI_BOOT))
> > +		return 0;
> > +
> > +	mstart = (boot_params.efi_info.efi_systab |
> > +			((u64)boot_params.efi_info.efi_systab_hi<<32));
> > +
> > +	if (efi_enabled(EFI_64BIT))
> > +		mend = mstart + sizeof(efi_system_table_64_t);
> > +	else
> > +		mend = mstart + sizeof(efi_system_table_32_t);
> > +
> > +	if (mstart)
> > +		return kernel_ident_mapping_init(info,
> > +				level4p, mstart, mend);
> 
> Flip that logic:
> 
> 	if (!mstart)
> 		return 0;
> 
> 	return kernel_ident_mapping_init(info, level4p, mstart, mend);
> 
> and let the function stick out.
> 
> > +
> > +	return 0;
> > +}
> > +#else
> > +static inline int init_efi_systab_pgtable(struct x86_mapping_info *info,
> > +					  pgd_t *level4p)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >  static void free_transition_pgtable(struct kimage *image)
> >  {
> >  	free_page((unsigned long)image->arch.p4d);
> > @@ -159,6 +233,18 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
> >  			return result;
> >  	}
> >  
> > +	/**
> 
> Two stars '**' are kernel-doc style comments above function names but
> not here.
> 
> > +	 * Prepare EFI systab and ACPI table mapping for kexec kernel,
> > +	 * since they are not covered by pfn_mapped.
> > +	 */
> > +	result = init_efi_systab_pgtable(&info, level4p);
> > +	if (result)
> > +		return result;
> > +
> > +	result = init_acpi_pgtable(&info, level4p);
> > +	if (result)
> > +		return result;
> > +
> >  	return init_transition_pgtable(image, level4p);
> >  }
> >  
> > -- 
> > 2.17.2
> > 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

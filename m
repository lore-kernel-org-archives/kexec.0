Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqI1F-004TTf-JY
 for kexec@lists.infradead.org; Mon, 07 Jun 2021 16:22:32 +0000
Date: Mon, 7 Jun 2021 19:22:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed kernel
Message-ID: <YL5HvUqtsDXx5CzM@smile.fi.intel.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <YLdEZoSWI41fcTB1@smile.fi.intel.com>
 <YLdG91qspr19heDS@smile.fi.intel.com>
 <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Javier =?iso-8859-1?B?VGnh?= <javier.tia@gmail.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-efi <linux-efi@vger.kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>, Ard Biesheuvel <ardb@kernel.org>

On Sat, Jun 05, 2021 at 03:51:05PM +0800, Dave Young wrote:
> Hi,
> On 06/02/21 at 11:53am, Andy Shevchenko wrote:
> > +Cc: Ard
> > 
> > On Wed, Jun 02, 2021 at 11:42:14AM +0300, Andy Shevchenko wrote:
> > > On Fri, Dec 02, 2016 at 09:54:14PM +0200, Andy Shevchenko wrote:
> > > > Until now DMI information is lost when kexec'ing. Fix this in the same way as
> > > > it has been done for ACPI RSDP.
> > > > 
> > > > Series has been tested on Galileo Gen2 where DMI is used by drivers, in
> > > > particular the default I2C host speed is choosen based on DMI system
> > > > information and now gets it correct.
> > > 
> > > Still nothing happens for a while and problem still exists.
> > > Can we do something about it, please?
> 
> Seems I totally missed this thread. Old emails lost.

You can always access to it via lore :-)
https://lore.kernel.org/linux-efi/20161217105721.GB6922@dhcp-128-65.nay.redhat.com/T/#u

(Okay, it's not full, but contains main parts anyway)


> The question Ard asked is to confirm if the firmware converted the
> SMBIOS3 addr to a virtual address after exit boot service. I do not
> remember some easy way to check it due to lost the context of the code.
> But you can try to check it via dmesg|grep SMBIOS both in normal boot
> and kexeced boot log.  And then compare if those addresses are
> identical.
> 
> If the SMBIOS3 addr in kexec kernel is different then it should have
> been modified by firmware. Then we need patch kernel and kexec-tools to
> support it.
> 
> You can try below patch to see if it works:

So, AFAIU I have to apply patch to kexec tools for the fist kernel + userspace
and apply kernel patch for the second kernel? Or it's all for the first one?

> apply a kexec-tools patch to kexec-tools if you do not use kexec -s
> (kexec_file_load):

Here is how we are using it:
https://github.com/andy-shev/buildroot/blob/intel/board/intel/common/netboot/udhcpc-script.sh#L54

> --- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c
> +++ kexec-tools/kexec/arch/i386/x86-linux-setup.c
> @@ -533,7 +533,8 @@ struct efi_setup_data {
>  	uint64_t runtime;
>  	uint64_t tables;
>  	uint64_t smbios;
> -	uint64_t reserved[8];
> +	uint64_t smbios3;
> +	uint64_t reserved[7];
>  };
>  
>  struct setup_data {
> @@ -580,6 +581,8 @@ static int get_efi_values(struct efi_set
>  
>  	ret = get_efi_value("/sys/firmware/efi/systab", "SMBIOS=0x",
>  			    &esd->smbios);
> +	ret |= get_efi_value("/sys/firmware/efi/systab", "SMBIOS3=0x",
> +			    &esd->smbios3);
>  	ret |= get_efi_value("/sys/firmware/efi/fw_vendor", "0x",
>  			     &esd->fw_vendor);
>  	ret |= get_efi_value("/sys/firmware/efi/runtime", "0x",
> 
> =============================================
> Kernel patch:
> 
> --- linux-x86.orig/arch/x86/include/asm/efi.h
> +++ linux-x86/arch/x86/include/asm/efi.h
> @@ -167,7 +167,8 @@ struct efi_setup_data {
>  	u64 __unused;
>  	u64 tables;
>  	u64 smbios;
> -	u64 reserved[8];
> +	u64 smbios3;
> +	u64 reserved[7];
>  };
>  
>  extern u64 efi_setup;
> --- linux-x86.orig/arch/x86/kernel/kexec-bzimage64.c
> +++ linux-x86/arch/x86/kernel/kexec-bzimage64.c
> @@ -144,6 +144,7 @@ prepare_add_efi_setup_data(struct boot_p
>  	esd->fw_vendor = efi_fw_vendor;
>  	esd->tables = efi_config_table;
>  	esd->smbios = efi.smbios;
> +	esd->smbios3 = efi.smbios3;
>  
>  	sd->type = SETUP_EFI;
>  	sd->len = sizeof(struct efi_setup_data);
> --- linux-x86.orig/arch/x86/platform/efi/quirks.c
> +++ linux-x86/arch/x86/platform/efi/quirks.c
> @@ -497,8 +497,8 @@ void __init efi_free_boot_services(void)
>   * their physical addresses therefore we pass them via setup_data and
>   * correct those entries to their respective physical addresses here.
>   *
> - * Currently only handles smbios which is necessary for some firmware
> - * implementation.
> + * Currently only handles smbios and smbios3 which is necessary for
> + * some firmware implementation.
>   */
>  int __init efi_reuse_config(u64 tables, int nr_tables)
>  {
> @@ -521,7 +521,7 @@ int __init efi_reuse_config(u64 tables,
>  		goto out;
>  	}
>  
> -	if (!data->smbios)
> +	if (!data->smbios  && !data->smbios3)
>  		goto out_memremap;
>  
>  	sz = sizeof(efi_config_table_64_t);
> @@ -538,8 +538,10 @@ int __init efi_reuse_config(u64 tables,
>  
>  		guid = ((efi_config_table_64_t *)p)->guid;
>  
> -		if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
> +		if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID) && data->smbios)
>  			((efi_config_table_64_t *)p)->table = data->smbios;
> +		else if (!efi_guidcmp(guid, SMBIOS3_TABLE_GUID) && data->smbios3)
> +			((efi_config_table_64_t *)p)->table = data->smbios3;
>  		p += sz;
>  	}
>  	early_memunmap(tablep, nr_tables * sz);
> 
> 
> Thanks
> Dave
> 

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

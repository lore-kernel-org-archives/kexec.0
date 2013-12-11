Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqoaH-0004O6-D6
 for kexec@lists.infradead.org; Wed, 11 Dec 2013 18:32:34 +0000
Date: Wed, 11 Dec 2013 19:32:03 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 07/14] efi: export more efi table variable to sysfs
Message-ID: <20131211183203.GF23793@pd.tnic>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-8-git-send-email-dyoung@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386582147-9802-8-git-send-email-dyoung@redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Mon, Dec 09, 2013 at 05:42:20PM +0800, Dave Young wrote:
> Export fw_vendor, runtime and config table physical addresses to
> /sys/firmware/efi/fw_vendor, /sys/firmware/efi/runtime and
> /sys/firmware/efi/config_table because kexec kernel will need them.

you might wanna shorten:

... sys/firmware/efi/{fw_vendor,runtime,config_table} ...

> 
> From EFI spec these 3 variables will be updated to
> virtual address after entering virtual mode. But
> kernel startup code will need the physical address.
> 
> changelog:
> Greg: add standalone sysfs files instead of add lines to systab
> Document them as testing ABI
> Greg: use group attrs and is_visible
> Boris: align comments lines
> Boris: add macros for _show functions
> Matt: Documentation fixes.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  Documentation/ABI/testing/sysfs-firmware-efi | 24 +++++++++++++++++
>  arch/x86/platform/efi/efi.c                  |  4 +++
>  drivers/firmware/efi/efi.c                   | 39 ++++++++++++++++++++++++++++
>  include/linux/efi.h                          |  3 +++
>  4 files changed, 70 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-efi
> 
> diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation/ABI/testing/sysfs-firmware-efi
> new file mode 100644
> index 0000000..8c6e460
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-firmware-efi
> @@ -0,0 +1,24 @@
> +What:		/sys/firmware/efi/fw_vendor
> +Date:		December 2013
> +Contact:	Dave Young <dyoung@redhat.com>
> +Description:
> +		It shows the physical address of firmware vendor field in the

Why doesn't this start at the same line as "Description:"?

> +		EFI system table.
> +

Superfluous newline.

> +Users:		Kexec
> +
> +What:		/sys/firmware/efi/runtime
> +Date:		December 2013
> +Contact:	Dave Young <dyoung@redhat.com>
> +Description:
> +		It shows the physical address of runtime service table entry in
> +		the EFI system table.
> +Users:		Kexec
> +
> +What:		/sys/firmware/efi/config_table
> +Date:		December 2013
> +Contact:	Dave Young <dyoung@redhat.com>
> +Description:
> +		It shows the physical address of config table entry in the EFI
> +		system table.
> +Users:		Kexec
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 7778b5f..3e8b760 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -653,6 +653,10 @@ void __init efi_init(void)
>  
>  	set_bit(EFI_SYSTEM_TABLES, &x86_efi_facility);
>  
> +	efi.config_table = (unsigned long)efi.systab->tables;
> +	efi.fw_vendor	 = (unsigned long)efi.systab->fw_vendor;
> +	efi.runtime	 = (unsigned long)efi.systab->runtime;
> +
>  	/*
>  	 * Show what we know for posterity
>  	 */
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index b716a66..0ecccab 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -32,6 +32,9 @@ struct efi __read_mostly efi = {
>  	.hcdp       = EFI_INVALID_TABLE_ADDR,
>  	.uga        = EFI_INVALID_TABLE_ADDR,
>  	.uv_systab  = EFI_INVALID_TABLE_ADDR,
> +	.fw_vendor  = EFI_INVALID_TABLE_ADDR,
> +	.runtime    = EFI_INVALID_TABLE_ADDR,
> +	.config_table  = EFI_INVALID_TABLE_ADDR,
>  };
>  EXPORT_SYMBOL(efi);
>  
> @@ -71,13 +74,49 @@ static ssize_t systab_show(struct kobject *kobj,
>  static struct kobj_attribute efi_attr_systab =
>  			__ATTR(systab, 0400, systab_show, NULL);
>  
> +#define EFI_FIELD(var) efi.var
> +
> +#define EFI_ATTR_SHOW(name) \
> +static ssize_t name##_show(struct kobject *kobj, \
> +				struct kobj_attribute *attr, char *buf) \
> +{ \
> +	return sprintf(buf, "0x%lx\n", EFI_FIELD(name)); \
> +}
> +
> +EFI_ATTR_SHOW(fw_vendor);
> +EFI_ATTR_SHOW(runtime);
> +EFI_ATTR_SHOW(config_table);
> +
> +static struct kobj_attribute efi_attr_fw_vendor = __ATTR_RO(fw_vendor);
> +static struct kobj_attribute efi_attr_runtime = __ATTR_RO(runtime);
> +static struct kobj_attribute efi_attr_config_table = __ATTR_RO(config_table);
> +
>  static struct attribute *efi_subsys_attrs[] = {
>  	&efi_attr_systab.attr,
> +	&efi_attr_fw_vendor.attr,
> +	&efi_attr_runtime.attr,
> +	&efi_attr_config_table.attr,
>  	NULL,	/* maybe more in the future? */
		^^^^^

Now that there's more, you can drop that wise guy comment :)

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjXL6-0008E1-1B
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 16:42:48 +0000
Date: Thu, 21 Nov 2013 08:42:24 -0800
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [patch 5/9 v3] efi: export more efi table variable to sysfs
Message-ID: <20131121164224.GA15083@kroah.com>
References: <20131121061704.363730447@dhcp-16-126.nay.redhat.com>
 <20131121061754.887381332@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131121061754.887381332@dhcp-16-126.nay.redhat.com>
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
To: dyoung@redhat.com
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Thu, Nov 21, 2013 at 02:17:09PM +0800, dyoung@redhat.com wrote:
> Export fw_vendor, runtime and config tables physical
> addresses to /sys/firmware/efi/systab becaue kexec
> kernel will need them.
> 
> >From EFI spec these 3 variables will be updated to
> virtual address after entering virtual mode. But
> kernel startup code will need the physical address.
> 
> changelog:
> Greg: add standalone sysfs files instead of add lines to systab
> Document them as testing ABI
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  Documentation/ABI/testing/sysfs-firmware-efi |   26 +++++++++
>  arch/x86/platform/efi/efi.c                  |    4 +
>  drivers/firmware/efi/efi.c                   |   71 +++++++++++++++++++++++++--
>  include/linux/efi.h                          |    3 +
>  4 files changed, 101 insertions(+), 3 deletions(-)
> 
> --- efi.orig/drivers/firmware/efi/efi.c
> +++ efi/drivers/firmware/efi/efi.c
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
> @@ -71,6 +74,31 @@ static ssize_t systab_show(struct kobjec
>  static struct kobj_attribute efi_attr_systab =
>  			__ATTR(systab, 0400, systab_show, NULL);
>  
> +static ssize_t fw_vendor_show(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "0x%lx\n", efi.fw_vendor);
> +}
> +
> +static ssize_t runtime_show(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "0x%lx\n", efi.runtime);
> +}
> +
> +static ssize_t config_table_show(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "0x%lx\n", efi.config_table);
> +}
> +
> +static struct kobj_attribute efi_attr_fw_vendor =
> +				__ATTR(fw_vendor, 0400, fw_vendor_show, NULL);
> +static struct kobj_attribute efi_attr_runtime =
> +			__ATTR(runtime, 0400, runtime_show, NULL);
> +static struct kobj_attribute efi_attr_config_table =
> +			__ATTR(config_table, 0400, config_table_show, NULL);
> +
>  static struct attribute *efi_subsys_attrs[] = {
>  	&efi_attr_systab.attr,
>  	NULL,	/* maybe more in the future? */
> @@ -123,21 +151,58 @@ static int __init efisubsys_init(void)
>  
>  	error = sysfs_create_group(efi_kobj, &efi_subsys_attr_group);
>  	if (error) {
> -		pr_err("efi: Sysfs attribute export failed with error %d.\n",
> -		       error);
> +		pr_err("efi: Sysfs attribute %s export failed with error %d.\n",
> +		       efi_attr_systab.attr.name, error);
>  		goto err_unregister;
>  	}
>  
> +	if (efi.fw_vendor != EFI_INVALID_TABLE_ADDR) {
> +		error = sysfs_create_file(efi_kobj, &efi_attr_fw_vendor.attr);
> +		if (error) {
> +			pr_err("efi: Sysfs attribute %s export failed with error %d.\n",
> +				efi_attr_fw_vendor.attr.name, error);
> +			goto err_remove_group;
> +		}
> +	}
> +
> +	if (efi.runtime != EFI_INVALID_TABLE_ADDR) {
> +		error = sysfs_create_file(efi_kobj, &efi_attr_runtime.attr);
> +		if (error) {
> +			pr_err("efi: Sysfs attribute %s export failed with error %d.\n",
> +				efi_attr_runtime.attr.name, error);
> +			goto err_remove_fw_vendor;
> +		}
> +	}
> +
> +	if (efi.config_table != EFI_INVALID_TABLE_ADDR) {
> +		error = sysfs_create_file(efi_kobj,
> +					&efi_attr_config_table.attr);
> +		if (error) {
> +			pr_err("efi: Sysfs attribute %s export failed with error %d.\n",
> +				efi_attr_config_table.attr.name, error);
> +			goto err_remove_runtime;
> +		}
> +	}

You don't need to do this "if SOMETHING then create the file", just use
the "is_visible" attribute in the group to do this as a callback to
determine this when the group is registered.

That should clean up this logic a bunch.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

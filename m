Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqhCV-0006qs-LI
 for kexec@lists.infradead.org; Wed, 11 Dec 2013 10:39:32 +0000
Date: Wed, 11 Dec 2013 10:39:03 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH v5 02/14] efi: use early_memremap and early_memunmap
Message-ID: <20131211103903.GC19196@console-pimps.org>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-3-git-send-email-dyoung@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386582147-9802-3-git-send-email-dyoung@redhat.com>
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
Cc: mjg59@srcf.ucam.org, Mark Salter <msalter@redhat.com>, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

(Cc'ing Leif and Mark for the ARM-side of things)

On Mon, 09 Dec, at 05:42:15PM, Dave Young wrote:
> In arch/x86/platform/efi/efi.c and drivers/firmware/efi/efi.c turn to use
> early_memremap/early_memunmap instead of early_ioremap/early_iounmap so sparse
> will be happy.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/platform/efi/efi.c | 20 ++++++++++----------
>  drivers/firmware/efi/efi.c  |  4 ++--
>  2 files changed, 12 insertions(+), 12 deletions(-)
 
This looks like a rather nice cleanup but the commit log could use a
little bit of tweaking...

  - Please start your commit title (the part after the subsystem tag)
    with a capital letter, e.g.

      efi: Use early_memremap...

  - You need to explain in the commit title that you're fixing a sparse
    warning. Anyone reading the patch subject will have no idea _why_
    you're using early_memremap() and early_memunmap().

  - In the commit message body explain why sparse is currently unhappy.

Leif, Mark, does this patch look OK for ARM? We'd need to introduce a
new early_memunmap() function so that things still build, but that
should be straight forward. You'd even be able to get rid of the
asymmetry in uefi_init() where you map efi.systab with early_memremap()
but unmap it with early_iounmap().

> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index f8ec4da..ef471d5 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -456,7 +456,7 @@ void __init efi_unmap_memmap(void)
>  {
>  	clear_bit(EFI_MEMMAP, &x86_efi_facility);
>  	if (memmap.map) {
> -		early_iounmap(memmap.map, memmap.nr_map * memmap.desc_size);
> +		early_memunmap(memmap.map, memmap.nr_map * memmap.desc_size);
>  		memmap.map = NULL;
>  	}
>  }
> @@ -493,7 +493,7 @@ static int __init efi_systab_init(void *phys)
>  		efi_system_table_64_t *systab64;
>  		u64 tmp = 0;
>  
> -		systab64 = early_ioremap((unsigned long)phys,
> +		systab64 = early_memremap((unsigned long)phys,
>  					 sizeof(*systab64));
>  		if (systab64 == NULL) {
>  			pr_err("Couldn't map the system table!\n");
> @@ -524,7 +524,7 @@ static int __init efi_systab_init(void *phys)
>  		efi_systab.tables = systab64->tables;
>  		tmp |= systab64->tables;
>  
> -		early_iounmap(systab64, sizeof(*systab64));
> +		early_memunmap(systab64, sizeof(*systab64));
>  #ifdef CONFIG_X86_32
>  		if (tmp >> 32) {
>  			pr_err("EFI data located above 4GB, disabling EFI.\n");
> @@ -534,7 +534,7 @@ static int __init efi_systab_init(void *phys)
>  	} else {
>  		efi_system_table_32_t *systab32;
>  
> -		systab32 = early_ioremap((unsigned long)phys,
> +		systab32 = early_memremap((unsigned long)phys,
>  					 sizeof(*systab32));
>  		if (systab32 == NULL) {
>  			pr_err("Couldn't map the system table!\n");
> @@ -555,7 +555,7 @@ static int __init efi_systab_init(void *phys)
>  		efi_systab.nr_tables = systab32->nr_tables;
>  		efi_systab.tables = systab32->tables;
>  
> -		early_iounmap(systab32, sizeof(*systab32));
> +		early_memunmap(systab32, sizeof(*systab32));
>  	}
>  
>  	efi.systab = &efi_systab;
> @@ -586,7 +586,7 @@ static int __init efi_runtime_init(void)
>  	 * address of several of the EFI runtime functions, needed to
>  	 * set the firmware into virtual mode.
>  	 */
> -	runtime = early_ioremap((unsigned long)efi.systab->runtime,
> +	runtime = early_memremap((unsigned long)efi.systab->runtime,
>  				sizeof(efi_runtime_services_t));
>  	if (!runtime) {
>  		pr_err("Could not map the runtime service table!\n");
> @@ -606,7 +606,7 @@ static int __init efi_runtime_init(void)
>  	 * virtual mode.
>  	 */
>  	efi.get_time = phys_efi_get_time;
> -	early_iounmap(runtime, sizeof(efi_runtime_services_t));
> +	early_memunmap(runtime, sizeof(efi_runtime_services_t));
>  
>  	return 0;
>  }
> @@ -614,7 +614,7 @@ static int __init efi_runtime_init(void)
>  static int __init efi_memmap_init(void)
>  {
>  	/* Map the EFI memory map */
> -	memmap.map = early_ioremap((unsigned long)memmap.phys_map,
> +	memmap.map = early_memremap((unsigned long)memmap.phys_map,
>  				   memmap.nr_map * memmap.desc_size);
>  	if (memmap.map == NULL) {
>  		pr_err("Could not map the memory map!\n");
> @@ -656,14 +656,14 @@ void __init efi_init(void)
>  	/*
>  	 * Show what we know for posterity
>  	 */
> -	c16 = tmp = early_ioremap(efi.systab->fw_vendor, 2);
> +	c16 = tmp = early_memremap(efi.systab->fw_vendor, 2);
>  	if (c16) {
>  		for (i = 0; i < sizeof(vendor) - 1 && *c16; ++i)
>  			vendor[i] = *c16++;
>  		vendor[i] = '\0';
>  	} else
>  		pr_err("Could not map the firmware vendor!\n");
> -	early_iounmap(tmp, 2);
> +	early_memunmap(tmp, 2);
>  
>  	pr_info("EFI v%u.%.02u by %s\n",
>  		efi.systab->hdr.revision >> 16,
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 2e2fbde..b716a66 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -253,7 +253,7 @@ int __init efi_config_init(efi_config_table_type_t *arch_tables)
>  			if (table64 >> 32) {
>  				pr_cont("\n");
>  				pr_err("Table located above 4GB, disabling EFI.\n");
> -				early_iounmap(config_tables,
> +				early_memunmap(config_tables,
>  					       efi.systab->nr_tables * sz);
>  				return -EINVAL;
>  			}
> @@ -269,6 +269,6 @@ int __init efi_config_init(efi_config_table_type_t *arch_tables)
>  		tablep += sz;
>  	}
>  	pr_cont("\n");
> -	early_iounmap(config_tables, efi.systab->nr_tables * sz);
> +	early_memunmap(config_tables, efi.systab->nr_tables * sz);
>  	return 0;
>  }
> -- 
> 1.8.3.1
> 

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

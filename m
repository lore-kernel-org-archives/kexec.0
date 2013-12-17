Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VspiP-0004Ml-Gp
 for kexec@lists.infradead.org; Tue, 17 Dec 2013 08:09:18 +0000
Date: Tue, 17 Dec 2013 16:08:42 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v7 09/14] efi: passing kexec necessary efi data via
 setup_data
Message-ID: <20131217080842.GA13339@dhcp-16-126.nay.redhat.com>
References: <1387186235-15972-1-git-send-email-dyoung@redhat.com>
 <1387186235-15972-10-git-send-email-dyoung@redhat.com>
 <20131217080140.GB12621@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131217080140.GB12621@dhcp-16-126.nay.redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: mjg59@srcf.ucam.org, msalter@redhat.com, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, leif.lindholm@linaro.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, mingo@kernel.org, vgoyal@redhat.com


Hello Boris

Does this version looks good to you? Only mapping once in print_efi_memmap..

BTW, forgot to remove 'Re:' in subject.

Please let me know if there's any other issues or need I resend the series.

Most changes vs previous version are below:

> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index b1fff8e..5438083 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -78,6 +78,8 @@ static __initdata efi_config_table_type_t arch_tables[] = {
>  
>  static void *efi_runtime_map;
>  static int nr_efi_runtime_map;
> +u64 efi_setup;		/* efi setup_data physical address */
> +u32 efi_data_len;	/* efi setup_data payload length */
>  

[snip]

> +
> +static void get_nr_runtime_map(void)
> +{
> +	if (!efi_setup)
> +		return;
> +
> +	nr_efi_runtime_map = (efi_data_len - sizeof(struct efi_setup_data)) /
> +			     sizeof(efi_memory_desc_t);
> +}
> +
>  void __init efi_init(void)
>  {
>  	efi_char16_t *c16;
> @@ -638,6 +719,7 @@ void __init efi_init(void)
>  	int i = 0;
>  	void *tmp;
>  
> +	get_nr_runtime_map();
>  #ifdef CONFIG_X86_32
>  	if (boot_params.efi_info.efi_systab_hi ||
>  	    boot_params.efi_info.efi_memmap_hi) {
> @@ -676,6 +758,9 @@ void __init efi_init(void)
>  
		efi.systab->hdr.revision >> 16,
[snip]

>  
>  	/*
> diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
> index 7b3ec6e..249b183 100644
> --- a/arch/x86/platform/efi/efi_32.c
> +++ b/arch/x86/platform/efi/efi_32.c
> @@ -48,6 +48,7 @@ void __init efi_map_region(efi_memory_desc_t *md)
>  }
>  
>  void __init efi_map_region_fixed(efi_memory_desc_t *md) {}
> +void __init parse_efi_setup(u64 phys_addr, u32 data_len) {}
>  
>  void efi_call_phys_prelog(void)
>  {
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index ff08cb1..324b651 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -228,3 +228,9 @@ void __iomem *__init efi_ioremap(unsigned long phys_addr, unsigned long size,
>  
>  	return (void __iomem *)__va(phys_addr);
>  }
> +
> +void __init parse_efi_setup(u64 phys_addr, u32 data_len)
> +{
> +	efi_setup = phys_addr + sizeof(struct setup_data);
> +	efi_data_len = data_len - sizeof(struct setup_data);
> +}
> -- 
> 1.8.3.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

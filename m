Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708F606A326
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qzyoN48M;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q/C847ur
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=T/LFH12Z4WZEglTbKhXQW4K9eV4VYPQ2vTkGE/YeZdw=; b=qzyoN48MAs4wo5
	55KLeejXxY/6TseDnb8zFxkazS5i38aUku3CDvabeud0nHx87QfnBQNynlUfSkFW9Ghrusqd3xBBM
	RxzSUfsiDqZm065wE8yCzq20T0UzRK02pVMcUFAS+CKNJ6igpo56n1wbGFFpAjam0JRsx5udPMlWl
	luw4SMk5DcM6w6J5shKaDUlSd13nA4qpBw3nfeVCsyOcroWu3tpYhNgv8ipYwRiJtORYgx8hAAlxy
	LOKvof5NOAKXGquEcpmXOT25NAHM/ecW8Oim2UxQGuMuxoSCV+pOpDV6h+ROLlPZOUrv/pqrXEQdW
	EDgkWuuoM3hzCsCOpHfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcOL-00000005hfC-2GBT;
	Wed, 04 Nov 2026 14:55:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcOI-00000005hdy-352H
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 14:55:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793804104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/LFH12Z4WZEglTbKhXQW4K9eV4VYPQ2vTkGE/YeZdw=;
	b=Q/C847urvGS1C/LPUXwQgLM2a1+ZQ2w/nJxsw6URIr41G4qLcbTr9Qq4nPrO0D4AIIF03O
	VlskAOSM67YRERFAjFbOZZH0Ow4vSjP7/YrwuoL4u7Q42WkgFMZz445nC2qbSVfsSPvrCs
	Bn3O9arP543geiP+zkuRUZiEfjSOG0w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-87Q41rnWMSqvuUJn2VsYNQ-1; Wed, 04 Nov 2026 09:54:59 -0500
X-MC-Unique: 87Q41rnWMSqvuUJn2VsYNQ-1
X-Mimecast-MFC-AGG-ID: 87Q41rnWMSqvuUJn2VsYNQ_1793804099
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b0a9de9c2aso130586a91.2
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 06:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804099; x=1794408899;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/LFH12Z4WZEglTbKhXQW4K9eV4VYPQ2vTkGE/YeZdw=;
        b=ZedzF3T+t/SC22dpG2E0s49YGOkUf1Yh2ORaLDJErFCzYhbNK++7K/Ed5krLfC9zk0
         Wm4QgTep3gIdlbeUlBM4Csq8e7k5Yt0aW+Zd2G7WE7Od21/AaCiit9MPgrWcs/hY8kDs
         N+HaCZB+0vqKNunDzARjPXRjTMCQH6zy/fG7Sun7+7CMeFxX74GzWvW5HH1FroKlWy9d
         f/EzishGOzZW+qbDtyBkJUufDrkoIbFsVVP5RINRkXLBis3vYxsp3DJ3Exk0t45RLcur
         +e3eFZCKNop2O5wJ+YzoHHfM3XqOnY0vraVsiQFboHwAtHX4tJc47LmW6bD2Zo/tAcyQ
         scdA==
X-Forwarded-Encrypted: i=1; AKwUvBzlCUVQEmuXIWU2diVOxTHkugEoyC9iQOOiTYh7flP3JBKZIVxPsv0Wr2JdX6Pa3AJoiMfImQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z853TCAWSDVc8KBRg8aRs/rwWlaqtYpOOQ61x/VOn9Y9jEYFSvK
	4GpVducBmhDtVZafuuE83gtaMrfVhFGs3SOJZ8P//C4/O0mkqjjMUjn/hf1deSic4J6y3n/EISW
	AxYNwPsyaYK6nvfowln+NqgYKbH9iVxbt4LFk1H24YZpR121c962qF72s24a74w==
X-Gm-Gg: AYBFou2XQrxbx1XTwOHSFJ6SAq86LxelUd37A+0mUSpcdA93NhWISPaPhoRGIBSIPwo
	h74Av8n4EjfUSdDYQMZecAAwjRHAUmEUOlBY2+mOTG6u1t3ogpf8oGsdow5N/b5sUs2cxhX6jN0
	PG1s0s4GBuiW8uUmbJyfcQFn6SkDudEbtatf5o4cyyvr1g3jVCvjxAkq0NI4SesYOvOmiO3YXtz
	iwT5bGao/KXxvWFPXELrCDN8/iNdwsxuiwB6NQoRNW9/bIqUsHZeW1SQ5rV7ATu50Um/7qS7l6P
	noF72X/FyrGbrgokauMbEpheYS+eSEsV3wwTfWSvhFY+I0m7pJZiBCTQaIVP2rM6l8tHp9qIwYY
	6M071nVEx8W81RFjUna/kzjPo11ExVsSpWIe4rKkfRkWFzQEsOLQgDT4AAufl6tAOxYH+n10y/y
	GTaX2L78UvK5zCWcwPTY9kM65mThtftneWePXIjHxZifw=
X-Received: by 2002:a17:90b:48cd:b0:3b0:a970:caad with SMTP id 98e67ed59e1d1-3b0a970ce14mr563084a91.28.1793804098485;
        Wed, 04 Nov 2026 06:54:58 -0800 (PST)
X-Received: by 2002:a17:90b:48cd:b0:3b0:a970:caad with SMTP id 98e67ed59e1d1-3b0a970ce14mr563055a91.28.1793804097848;
        Wed, 04 Nov 2026 06:54:57 -0800 (PST)
Received: from ?IPV6:2401:4900:1f28:63e0:edae:927e:c670:b679? ([2401:4900:1f28:63e0:edae:927e:c670:b679])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b096994650sm2176379a91.2.2026.11.04.06.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 06:54:57 -0800 (PST)
Message-ID: <99670aa8-a33c-4a36-b8dd-66b02c6b6159@redhat.com>
Date: Wed, 4 Nov 2026 20:24:47 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] efi: Pass KHO state to the next kernel in a
 configuration table
To: George Guo <dongtai.guo@linux.dev>, rppt@kernel.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, chenhuacai@kernel.org,
 ardb@kernel.org, shuah@kernel.org
Cc: ilias.apalodimas@linaro.org, akpm@linux-foundation.org,
 baoquan.he@linux.dev, ruirui.yang@linux.dev, guodongtai@kylinos.cn,
 kernel@xen0n.name, graf@amazon.com, liukexin@kylinos.cn,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-efi@vger.kernel.org
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
 <20261029172956.20791-2-dongtai.guo@linux.dev>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20261029172956.20791-2-dongtai.guo@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cI-rbuDOoCwD-Qg1ng4KpslBTvU1t7e62VNbI3UAaTE_1793804099
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_065506_947737_077A1FB1 
X-CRM114-Status: GOOD (  41.43  )
X-Spam-Score: -2.8 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi George,

On 29/10/26 10:59 pm, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> KHO has to give the next kernel two addresses: the KHO FDT and the
> bootmem area list. arm64 and riscv put them under /chosen in the boot
> FDT. LoongArch systems booting with EFI and ACPI do not require a boot
> FDT, so KHO needs another way to pass this information.
> 
> Add a Linux EFI configuration table for them, under
> LINUX_EFI_KEXEC_HANDOVER_GUID. It points to a struct linux_efi_kho_data.
> 
>   - On a cold boot, the LoongArch EFI stub installs the table, zeroed.
>     Each kexec'd kernel is given the same EFI system table, so it finds
>     the same table.
> 
>   - In early boot, efi_config_parse_tables() reserves the table so
>     neither the page allocator nor kexec segments use it, and calls
>     kho_populate() if the table holds KHO state.
> 
>   - Provide efi_kho_update() to update the table before kexec. Map the
>     table during boot so updates do not require allocation or mapping
>     at panic time.
> 
>   - efi_kho_table_found() tells architecture code whether the table was
>     found at boot, so it can turn KHO off when the table is missing.
> 
> Only the LoongArch stub installs the table, and only with
> CONFIG_KEXEC_HANDOVER. Elsewhere there is no table and this code does
> nothing.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  drivers/firmware/efi/efi.c               | 68 ++++++++++++++++++++++++
>  drivers/firmware/efi/libstub/efi-stub.c  | 22 ++++++++
>  drivers/firmware/efi/libstub/efistub.h   |  2 +
>  drivers/firmware/efi/libstub/loongarch.c |  2 +
>  include/linux/efi.h                      | 40 ++++++++++++++
>  5 files changed, 134 insertions(+)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 0327a39d31fa..e409e4a57378 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -24,6 +24,7 @@
>  #include <linux/initrd.h>
>  #include <linux/io.h>
>  #include <linux/kexec.h>
> +#include <linux/kexec_handover.h>
>  #include <linux/platform_device.h>
>  #include <linux/random.h>
>  #include <linux/reboot.h>
> @@ -62,6 +63,7 @@ unsigned long __ro_after_init efi_rng_seed = EFI_INVALID_TABLE_ADDR;
>  static unsigned long __initdata mem_reserve = EFI_INVALID_TABLE_ADDR;
>  static unsigned long __initdata rt_prop = EFI_INVALID_TABLE_ADDR;
>  static unsigned long __initdata initrd = EFI_INVALID_TABLE_ADDR;
> +static unsigned long efi_kho __initdata = EFI_INVALID_TABLE_ADDR;
>  
>  extern unsigned long primary_display_table;
>  
> @@ -629,6 +631,7 @@ static const efi_config_table_type_t common_tables[] __initconst = {
>  	{EFI_TCG2_FINAL_EVENTS_TABLE_GUID,	&efi.tpm_final_log,	"TPMFinalLog"	},
>  	{EFI_CC_FINAL_EVENTS_TABLE_GUID,	&efi.tpm_final_log,	"CCFinalLog"	},
>  	{LINUX_EFI_MEMRESERVE_TABLE_GUID,	&mem_reserve,		"MEMRESERVE"	},
> +	{LINUX_EFI_KEXEC_HANDOVER_GUID,		&efi_kho,		"KHO"		},
>  	{LINUX_EFI_INITRD_MEDIA_GUID,		&initrd,		"INITRD"	},
>  	{EFI_RT_PROPERTIES_TABLE_GUID,		&rt_prop,		"RTPROP"	},
>  #ifdef CONFIG_OVMF_DEBUG_LOG
> @@ -806,6 +809,23 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>  		}
>  	}
>  
> +	if (efi_kho != EFI_INVALID_TABLE_ADDR) {
> +		struct linux_efi_kho_data *kho;
> +
> +		/* Keep the buddy allocator and kexec segments off the table. */
> +		memblock_reserve(efi_kho, sizeof(*kho));
> +
> +		kho = early_memremap(efi_kho, sizeof(*kho));
> +		if (kho) {
> +			if (kho->fdt_addr)
> +				kho_populate((phys_addr_t)kho->fdt_addr, kho->fdt_size,
> +					     (phys_addr_t)kho->bootmem_addr, kho->bootmem_size);
> +			early_memunmap(kho, sizeof(*kho));
> +		} else {
> +			pr_warn("Could not map UEFI KHO table!\n");
This is a Linux EFI configuration table, not a __UEFI KHO table__, so
IMHO; UEFI wording is wrong here.

> +		}
> +	}
> +
>  	if (rt_prop != EFI_INVALID_TABLE_ADDR) {
>  		efi_rt_properties_table_t *tbl;
>  
> @@ -1171,6 +1191,54 @@ static int __init efi_memreserve_root_init(void)
>  }
>  early_initcall(efi_memreserve_root_init);
>  
> +static struct linux_efi_kho_data *efi_kho_table __ro_after_init;
> +
> +/* Did the previous kernel or the EFI stub pass a KHO table? */
> +bool __init efi_kho_table_found(void)
> +{
> +	return efi_kho != EFI_INVALID_TABLE_ADDR;
> +}
> +
> +static int __init efi_kho_table_init(void)
> +{
> +	if (efi_kho == EFI_INVALID_TABLE_ADDR)
> +		return 0;
> +
> +	/* Map it now: the table is also written at panic time. */
> +	efi_kho_table = memremap(efi_kho, sizeof(*efi_kho_table), MEMREMAP_WB);
> +	if (WARN_ON_ONCE(!efi_kho_table))
> +		efi_kho_table = ERR_PTR(-ENOMEM);
> +
> +	return 0;
> +}
> +early_initcall(efi_kho_table_init);
> +
> +/*
> + * Write the KHO addresses the next kernel should use, or zeroes
> + * if it should boot without KHO.
> + */
> +int efi_kho_update(phys_addr_t fdt_addr, u64 fdt_size,
> +		   phys_addr_t bootmem_addr, u64 bootmem_size)
> +{
> +	struct linux_efi_kho_data *kho = efi_kho_table;
> +
> +	/*
> +	 * No table: either the architecture passes the KHO state some other
> +	 * way, or it turned KHO off at boot because the table was missing.
> +	 */
> +	if (!kho)
> +		return 0;
> +	if (IS_ERR(kho))
> +		return PTR_ERR(kho);
> +
> +	kho->fdt_addr		= fdt_addr;
> +	kho->fdt_size		= fdt_size;
> +	kho->bootmem_addr	= bootmem_addr;
> +	kho->bootmem_size	= bootmem_size;
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_KEXEC
>  static int update_efi_random_seed(struct notifier_block *nb,
>  				  unsigned long code, void *unused)
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index 42d6073bcd06..0fb0d4041d1c 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -100,6 +100,28 @@ static void install_memreserve_table(void)
>  		efi_err("Failed to install memreserve config table!\n");
>  }
>  
> +void install_kho_table(void)
> +{
> +	struct linux_efi_kho_data *kho;
> +	efi_guid_t kho_table_guid = LINUX_EFI_KEXEC_HANDOVER_GUID;
> +	efi_status_t status;
> +
> +	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER))
> +		return;
> +
> +	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(*kho), (void **)&kho);
> +	if (status != EFI_SUCCESS) {
> +		efi_err("Failed to allocate KHO config table!\n");
> +		return;
> +	}
> +
> +	*kho = (struct linux_efi_kho_data){};
> +
> +	status = efi_bs_call(install_configuration_table, &kho_table_guid, kho);

> +	if (status != EFI_SUCCESS)
> +		efi_err("Failed to install KHO config table!\n");
When install_configuration_table fails, the pool allocation made
just above using efi_bs_callis never freed, so a page of
EFI_LOADER_DATA is leaked until ExitBootServices, This is a minor leak
so mentioned here for review completeness.

> +}
> +
>  static u32 get_supported_rt_services(void)
>  {
>  	const efi_rt_properties_table_t *rt_prop_table;
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index fd91fc15ec81..9e0034c1260a 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -1057,6 +1057,8 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
>  efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
>  			     unsigned long kernel_addr, char *cmdline_ptr);
>  
> +void install_kho_table(void);
> +
>  void *get_fdt(unsigned long *fdt_size);
>  
>  efi_status_t efi_alloc_virtmap(efi_memory_desc_t **virtmap,
> diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/efi/libstub/loongarch.c
> index 2b0c87dc9908..c2df097771e4 100644
> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -74,6 +74,8 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
>  	efi_status_t status;
>  	u32 desc_ver;
>  
> +	install_kho_table();
> +
>  	status = efi_alloc_virtmap(&priv.runtime_map, &desc_size, &desc_ver);
>  	if (status != EFI_SUCCESS) {
>  		efi_err("Unable to retrieve UEFI memory map.\n");
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index aa15ff88539b..253e98bf9922 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -422,6 +422,7 @@ void efi_native_runtime_setup(void);
>  #define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
>  #define LINUX_EFI_BOOT_MEMMAP_GUID		EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
>  #define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
> +#define LINUX_EFI_KEXEC_HANDOVER_GUID		EFI_GUID(0xc941b6c7, 0x7b3f, 0x4af6,  0x9e, 0x50, 0xfc, 0xb3, 0xa8, 0x86, 0x8a, 0x17)
>  
>  #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
>  
> @@ -1273,6 +1274,45 @@ struct linux_efi_memreserve {
>  
>  void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
>  
> +/**
> + * struct linux_efi_kho_data - KHO state passed to the next kernel
> + * @fdt_addr: physical address of the KHO FDT, 0 if there is none
> + * @fdt_size: size of the KHO FDT
> + * @bootmem_addr: physical address of the bootmem area list
> + * @bootmem_size: size of the bootmem area list
> + *
> + * Pointed to by the LINUX_EFI_KEXEC_HANDOVER_GUID configuration table.
> + *
> + * The EFI stub installs this table zeroed on a cold boot. It stays
> + * in place across kexec; the running kernel rewrites it just before
> + * each kexec, and the next kernel reads it during early boot.
This statement is only true for the LoongArch and on arm64/riscv/x86 no
table exists, so the comment describes a kernel-wide invariant that does
not hold.

> + *
> + * The layout is fixed. Changing it requires a new GUID.
> + */
> +struct linux_efi_kho_data {
> +	u64 fdt_addr;
> +	u64 fdt_size;
> +	u64 bootmem_addr;
> +	u64 bootmem_size;
> +};
> +
> +#ifdef CONFIG_EFI
> +bool efi_kho_table_found(void);
> +int efi_kho_update(phys_addr_t fdt_addr, u64 fdt_size,
> +		   phys_addr_t bootmem_addr, u64 bootmem_size);
> +#else
> +static inline bool efi_kho_table_found(void)
> +{
> +	return false;
> +}
> +
> +static inline int efi_kho_update(phys_addr_t fdt_addr, u64 fdt_size,
> +				 phys_addr_t bootmem_addr, u64 bootmem_size)
> +{
> +	return 0;
> +}
> +#endif
> +
>  /*
>   * The LINUX_EFI_MOK_VARIABLE_TABLE_GUID config table can be provided
>   * to the kernel by an EFI boot loader. The table contains a packed

-- 
Regards,
Mukesh Pilaniya



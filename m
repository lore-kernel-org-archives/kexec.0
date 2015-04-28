Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 28 Apr 2015 17:19:35 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [v2 1/5] arm64: kdump: reserve memory for crash dump kernel
Message-ID: <20150428091935.GJ15033@dhcp-16-116.nay.redhat.com>
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
 <1429861989-8417-2-git-send-email-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1429861989-8417-2-git-send-email-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, hbabus@us.ibm.com, linaro-kernel@lists.linaro.org, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, broonie@kernel.org, david.griego@linaro.org, kexec@lists.infradead.org, vgoyal@redhat.com

> +#ifdef CONFIG_CRASH_DUMP
> +/*
> + * reserve_elfcorehdr() - reserves memory for elf core header
> + *
> + * This function reserves memory area given in "elfcorehdr=" kernel command
> + * line parameter. The memory reserved is used by a dump capture kernel to
> + * identify the memory used by primary kernel.
> + */

Hi AKASHI,

May I know why elfcorehdr need be reserved separately but not locate a
memory region in crashkernel reserved region like all other ARCHs? Is
there any special reason?

Thanks
Baoquan

> +static void __init reserve_elfcorehdr(void)
> +{
> +	if (!elfcorehdr_size)
> +		return;
> +
> +	if (memblock_is_region_reserved(elfcorehdr_addr, elfcorehdr_size)) {
> +		pr_warn("elfcorehdr reservation failed - memory is in use (0x%llx)\n",
> +			elfcorehdr_addr);
> +		return;
> +	}
> +
> +	if (memblock_reserve(elfcorehdr_addr, elfcorehdr_size)) {
> +		pr_warn("elfcorehdr reservation failed - out of memory\n");
> +		return;
> +	}
> +
> +	pr_info("Reserving %lldKB of memory at %lldMB for elfcorehdr\n",
> +		elfcorehdr_size >> 10, elfcorehdr_addr >> 20);
> +}
> +#endif /* CONFIG_CRASH_DUMP */
>  /*
>   * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
>   * currently assumes that for memory starting above 4G, 32-bit devices will
> @@ -170,6 +247,13 @@ void __init arm64_memblock_init(void)
>  		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
>  #endif
>  
> +#ifdef CONFIG_KEXEC
> +	reserve_crashkernel(memory_limit);
> +#endif
> +#ifdef CONFIG_CRASH_DUMP
> +	reserve_elfcorehdr();
> +#endif
> +
>  	early_init_fdt_scan_reserved_mem();
>  
>  	/* 4GB maximum for 32-bit only capable devices */
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YriJD-00024z-Ax
 for kexec@lists.infradead.org; Mon, 11 May 2015 07:39:28 +0000
Received: by pdbqd1 with SMTP id qd1so140001467pdb.2
 for <kexec@lists.infradead.org>; Mon, 11 May 2015 00:39:05 -0700 (PDT)
Message-ID: <55505C91.8070503@linaro.org>
Date: Mon, 11 May 2015 16:38:57 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
MIME-Version: 1.0
Subject: Re: [v2 1/5] arm64: kdump: reserve memory for crash dump kernel
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
 <1429861989-8417-2-git-send-email-takahiro.akashi@linaro.org>
 <20150428091935.GJ15033@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20150428091935.GJ15033@dhcp-16-116.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, hbabus@us.ibm.com, linaro-kernel@lists.linaro.org, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, broonie@kernel.org, david.griego@linaro.org, kexec@lists.infradead.org, vgoyal@redhat.com

Hi Baoquan,

On 04/28/2015 06:19 PM, Baoquan He wrote:
>> +#ifdef CONFIG_CRASH_DUMP
>> +/*
>> + * reserve_elfcorehdr() - reserves memory for elf core header
>> + *
>> + * This function reserves memory area given in "elfcorehdr=" kernel command
>> + * line parameter. The memory reserved is used by a dump capture kernel to
>> + * identify the memory used by primary kernel.
>> + */
>
> Hi AKASHI,
>
> May I know why elfcorehdr need be reserved separately but not locate a
> memory region in crashkernel reserved region like all other ARCHs? Is
> there any special reason?

I don't get your point, but arm as well as arm64 locates elfcorehdr
in a crash kernel's memory region.
See kexec/arch/arm{,64}/crashdump-arm{,64}.c in kexec-tools.

And this region is reserved at boot time *on crash kernel* because we don't want
to corrupt it accidentally.
(After Mark's comment, we might better remove the mmu mapping for this region, too.)


Make sense?

-Takahiro AKASHI

> Thanks
> Baoquan
>
>> +static void __init reserve_elfcorehdr(void)
>> +{
>> +	if (!elfcorehdr_size)
>> +		return;
>> +
>> +	if (memblock_is_region_reserved(elfcorehdr_addr, elfcorehdr_size)) {
>> +		pr_warn("elfcorehdr reservation failed - memory is in use (0x%llx)\n",
>> +			elfcorehdr_addr);
>> +		return;
>> +	}
>> +
>> +	if (memblock_reserve(elfcorehdr_addr, elfcorehdr_size)) {
>> +		pr_warn("elfcorehdr reservation failed - out of memory\n");
>> +		return;
>> +	}
>> +
>> +	pr_info("Reserving %lldKB of memory at %lldMB for elfcorehdr\n",
>> +		elfcorehdr_size >> 10, elfcorehdr_addr >> 20);
>> +}
>> +#endif /* CONFIG_CRASH_DUMP */
>>   /*
>>    * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
>>    * currently assumes that for memory starting above 4G, 32-bit devices will
>> @@ -170,6 +247,13 @@ void __init arm64_memblock_init(void)
>>   		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
>>   #endif
>>
>> +#ifdef CONFIG_KEXEC
>> +	reserve_crashkernel(memory_limit);
>> +#endif
>> +#ifdef CONFIG_CRASH_DUMP
>> +	reserve_elfcorehdr();
>> +#endif
>> +
>>   	early_init_fdt_scan_reserved_mem();
>>
>>   	/* 4GB maximum for 32-bit only capable devices */
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

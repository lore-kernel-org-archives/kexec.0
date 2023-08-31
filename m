Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6504DC83F10
	for <kexec@archiver.kernel.org>; Thu, 31 Aug 2023 03:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ltxPpWw1WwKhoM+sPyPmeVPJytmqRA/7C5iGAkc7Hk4=; b=l29Pmd9Q4Ccf507TxM6jH1njPG
	lETTLHYpTAPGaVBqeiCTVo7KXrXHN8fMENLWSy3EmLW4w3xQ7YvrZ7LEj3e7rXWdzF9lZDXvq9AFl
	yDQfX9uFfWikBK9nIz8nbzRDE7dhnG6sqU0Ef30ehWjIM3iCyqOdfBJlwDsuXCxH+zrdmkjyjjn7B
	HifjKofpdPzT98cI2cwQl5DsuAxDX+GN1foxmCLMpSVPDbspdGipwdIBWmug28CLBOW1q/rYFC8Hz
	gh/Joit7o+B558GrCPBxfwbk/ZzDUlSWI1BoAakQUrZqVHH8G541oPqrsKW+dZiJoXv97G/2xDmpb
	dLitQ/SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbYbH-00EZmj-2U;
	Thu, 31 Aug 2023 03:44:07 +0000
Received: from [45.249.212.56] (helo=dggsgout12.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbYbD-00EZly-1f;
	Thu, 31 Aug 2023 03:44:06 +0000
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rbn875jnwz4f3npg;
	Thu, 31 Aug 2023 11:43:51 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgBH1qh5DPBkeSH8Bw--.465S3;
	Thu, 31 Aug 2023 11:43:55 +0800 (CST)
Subject: Re: [PATCH v2 6/8] x86: kdump: use generic interface to simplify
 crashkernel reservation code
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com,
 thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
 samuel.holland@sifive.com, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-7-bhe@redhat.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <5b53d460-7134-e292-77ec-967016e89003@huaweicloud.com>
Date: Thu, 31 Aug 2023 11:43:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230829121610.138107-7-bhe@redhat.com>
Content-Language: en-US
X-CM-TRANSID: gCh0CgBH1qh5DPBkeSH8Bw--.465S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFy5tr43Cw48JF17Zw15XFb_yoWfAw17pr
	y3JF4fArWDtFyDG3y7Arn7CrW8A3Za9a4j9r15Jr95Jr9rKrnxKr43uw12gryUKr95WFy8
	tFWrXF9Yga10qrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_204403_881020_68EF2429 
X-CRM114-Status: GOOD (  40.34  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 2023/8/29 20:16, Baoquan He wrote:
> With the help of newly changed function parse_crashkernel() and
> generic reserve_crashkernel_generic(), crashkernel reservation can be
> simplified by steps:
> 
> 1) Add a new header file <asm/crash_core.h>, and define CRASH_ALIGN,
>    CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX and
>    DEFAULT_CRASH_KERNEL_LOW_SIZE in <asm/crash_core.h>;
> 
> 2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
>    reserve_crashkernel_generic(), and do the ARCH specific work if
>    needed.
> 
> 3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
>    arch/x86/Kconfig.
> 
> When adding DEFAULT_CRASH_KERNEL_LOW_SIZE, add crash_low_size_default()
> to calculate crashkernel low memory because x86_64 has special
> requirement.
> 
> The old reserve_crashkernel_low() and reserve_crashkernel() can be
> removed.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/Kconfig                  |   3 +
>  arch/x86/include/asm/crash_core.h |  34 +++++++
>  arch/x86/kernel/setup.c           | 144 ++++--------------------------
>  3 files changed, 53 insertions(+), 128 deletions(-)
>  create mode 100644 arch/x86/include/asm/crash_core.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8d9e4b362572..c4539dc35985 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2037,6 +2037,9 @@ config KEXEC_FILE
>  config ARCH_HAS_KEXEC_PURGATORY
>  	def_bool KEXEC_FILE
>  
> +config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +	def_bool CRASH_CORE
> +
>  config KEXEC_SIG
>  	bool "Verify kernel signature during kexec_file_load() syscall"
>  	depends on KEXEC_FILE
> diff --git a/arch/x86/include/asm/crash_core.h b/arch/x86/include/asm/crash_core.h
> new file mode 100644
> index 000000000000..5fc5e4f94521
> --- /dev/null
> +++ b/arch/x86/include/asm/crash_core.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _X86_CRASH_CORE_H
> +#define _X86_CRASH_CORE_H
> +
> +/* 16M alignment for crash kernel regions */
> +#define CRASH_ALIGN             SZ_16M
> +
> +/*
> + * Keep the crash kernel below this limit.
> + *
> + * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
> + * due to mapping restrictions.
> + *
> + * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
> + * the upper limit of system RAM in 4-level paging mode. Since the kdump
> + * jump could be from 5-level paging to 4-level paging, the jump will fail if
> + * the kernel is put above 64 TB, and during the 1st kernel bootup there's
> + * no good way to detect the paging mode of the target kernel which will be
> + * loaded for dumping.
> + */
> +
> +#ifdef CONFIG_X86_32
> +# define CRASH_ADDR_LOW_MAX     SZ_512M
> +# define CRASH_ADDR_HIGH_MAX    SZ_512M
> +#else
> +# define CRASH_ADDR_LOW_MAX     SZ_4G
> +# define CRASH_ADDR_HIGH_MAX    SZ_64T
> +#endif
> +
> +# define DEFAULT_CRASH_KERNEL_LOW_SIZE crash_low_size_default()
> +
> +extern unsigned long crash_low_size_default(void);
> +
> +#endif /* _X86_CRASH_CORE_H */
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 382c66d2cf71..559a5c4141db 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -474,152 +474,40 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>  /*
>   * --------- Crashkernel reservation ------------------------------
>   */
> -
> -/* 16M alignment for crash kernel regions */
> -#define CRASH_ALIGN		SZ_16M
> -
> -/*
> - * Keep the crash kernel below this limit.
> - *
> - * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
> - * due to mapping restrictions.
> - *
> - * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
> - * the upper limit of system RAM in 4-level paging mode. Since the kdump
> - * jump could be from 5-level paging to 4-level paging, the jump will fail if
> - * the kernel is put above 64 TB, and during the 1st kernel bootup there's
> - * no good way to detect the paging mode of the target kernel which will be
> - * loaded for dumping.
> - */
> -#ifdef CONFIG_X86_32
> -# define CRASH_ADDR_LOW_MAX	SZ_512M
> -# define CRASH_ADDR_HIGH_MAX	SZ_512M
> -#else
> -# define CRASH_ADDR_LOW_MAX	SZ_4G
> -# define CRASH_ADDR_HIGH_MAX	SZ_64T
> -#endif
> -
> -static int __init reserve_crashkernel_low(void)
> +unsigned long crash_low_size_default(void)
>  {
>  #ifdef CONFIG_X86_64
> -	unsigned long long base, low_base = 0, low_size = 0;
> -	unsigned long low_mem_limit;
> -	int ret;
> -
> -	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
> -
> -	/* crashkernel=Y,low */
> -	ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
> -	if (ret) {
> -		/*
> -		 * two parts from kernel/dma/swiotlb.c:
> -		 * -swiotlb size: user-specified with swiotlb= or default.
> -		 *
> -		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
> -		 * to 8M for other buffers that may need to stay low too. Also
> -		 * make sure we allocate enough extra low memory so that we
> -		 * don't run out of DMA buffers for 32-bit devices.
> -		 */
> -		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
> -	} else {
> -		/* passed with crashkernel=0,low ? */
> -		if (!low_size)
> -			return 0;
> -	}
> -
> -	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> -	if (!low_base) {
> -		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
> -		       (unsigned long)(low_size >> 20));
> -		return -ENOMEM;
> -	}
> -
> -	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (low RAM limit: %ldMB)\n",
> -		(unsigned long)(low_size >> 20),
> -		(unsigned long)(low_base >> 20),
> -		(unsigned long)(low_mem_limit >> 20));
> -
> -	crashk_low_res.start = low_base;
> -	crashk_low_res.end   = low_base + low_size - 1;
> -	insert_resource(&iomem_resource, &crashk_low_res);
> -#endif
> +	return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
> +#else
>  	return 0;
> +#endif
>  }
>  
> -static void __init reserve_crashkernel(void)
> +static void __init arch_reserve_crashkernel(void)
>  {
> -	unsigned long long crash_size, crash_base, total_mem;
> +	unsigned long long crash_base, crash_size, low_size = 0;
> +	char *cmdline = boot_command_line;
>  	bool high = false;
>  	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
>  
> -	total_mem = memblock_phys_mem_size();
> -
> -	/* crashkernel=XM */
> -	ret = parse_crashkernel(boot_command_line, total_mem,
> -				&crash_size, &crash_base, NULL, NULL);
> -	if (ret != 0 || crash_size <= 0) {
> -		/* crashkernel=X,high */
> -		ret = parse_crashkernel_high(boot_command_line, total_mem,
> -					     &crash_size, &crash_base);
> -		if (ret != 0 || crash_size <= 0)
> -			return;
> -		high = true;
> -	}
> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> +				&crash_size, &crash_base,
> +				&low_size, &high);
> +	if (ret)
> +		return;
>  
>  	if (xen_pv_domain()) {
>  		pr_info("Ignoring crashkernel for a Xen PV domain\n");
>  		return;
>  	}
>  
> -	/* 0 means: find the address automatically */
> -	if (!crash_base) {
> -		/*
> -		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> -		 * crashkernel=x,high reserves memory over 4G, also allocates
> -		 * 256M extra low memory for DMA buffers and swiotlb.
> -		 * But the extra memory is not required for all machines.
> -		 * So try low memory first and fall back to high memory
> -		 * unless "crashkernel=size[KMG],high" is specified.
> -		 */
> -		if (!high)
> -			crash_base = memblock_phys_alloc_range(crash_size,
> -						CRASH_ALIGN, CRASH_ALIGN,
> -						CRASH_ADDR_LOW_MAX);
> -		if (!crash_base)
> -			crash_base = memblock_phys_alloc_range(crash_size,
> -						CRASH_ALIGN, CRASH_ALIGN,
> -						CRASH_ADDR_HIGH_MAX);
> -		if (!crash_base) {
> -			pr_info("crashkernel reservation failed - No suitable area found.\n");
> -			return;
> -		}
> -	} else {
> -		unsigned long long start;
> -
> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> -						  crash_base + crash_size);
> -		if (start != crash_base) {
> -			pr_info("crashkernel reservation failed - memory is in use.\n");
> -			return;
> -		}
> -	}
> -
> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
> -		memblock_phys_free(crash_base, crash_size);
> -		return;
> -	}
> -
> -	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
> -		(unsigned long)(crash_size >> 20),
> -		(unsigned long)(crash_base >> 20),
> -		(unsigned long)(total_mem >> 20));
> +	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
> +				    low_size, high);
>  
> -	crashk_res.start = crash_base;
> -	crashk_res.end   = crash_base + crash_size - 1;
> -	insert_resource(&iomem_resource, &crashk_res);
> +	return;

This can be omitted.

>  }
>  
>  static struct resource standard_io_resources[] = {
> @@ -1231,7 +1119,7 @@ void __init setup_arch(char **cmdline_p)
>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>  	 * won't consume hotpluggable memory.
>  	 */
> -	reserve_crashkernel();
> +	arch_reserve_crashkernel();
>  
>  	memblock_find_dma_reserve();
>  
> 

-- 
Regards,
  Zhen Lei


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

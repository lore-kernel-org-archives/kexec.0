Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658B6C83F2B
	for <kexec@archiver.kernel.org>; Thu, 31 Aug 2023 03:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BV0nsytNgQrnbQGt7Tz7APA3vpBYHiSZXcljyOjLYbA=; b=gHVra87ZHPI1sKvlLXj5E35FqP
	jsydfx/PIQXBP05JZK8Sk6OuEq1I+PqiLRpT015Rmler+fUEbzRge63dpE/ogCGHI1OMkI6708NIJ
	BhfUOZMR0fDcBhRd6Jqlhv1eY6QDT+MvBe/jokPtifo+8XCNEwjRK2UC6zoT+rxTXHzdJjulTqPsG
	iNOLlJeOYF2txvFGHkFXOoZqXS69/45iaPMiU496Umj93zpJ+lM+7tZiiIC+f8aA4rm1ACW8LwyZj
	p/CMpeVJnookJC0eM9I6MU9PjkleTxPX8RzmGSx3f0HlS/PB/2hhqD9PXF078M6nDOAKQio2g3RE2
	qyjPFKQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbYiH-00EaVj-1L;
	Thu, 31 Aug 2023 03:51:21 +0000
Received: from [45.249.212.51] (helo=dggsgout11.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbYiE-00EaUn-0A;
	Thu, 31 Aug 2023 03:51:20 +0000
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RbnJV14cMz4f3lg6;
	Thu, 31 Aug 2023 11:51:06 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgD3hqkqDvBkLoz8Bw--.42583S3;
	Thu, 31 Aug 2023 11:51:07 +0800 (CST)
Subject: Re: [PATCH v2 7/8] arm64: kdump: use generic interface to simplify
 crashkernel reservation
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com,
 thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
 samuel.holland@sifive.com, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-8-bhe@redhat.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <54bb7826-ef3b-0ab2-68b3-e73c7e0d6b35@huaweicloud.com>
Date: Thu, 31 Aug 2023 11:51:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230829121610.138107-8-bhe@redhat.com>
Content-Language: en-US
X-CM-TRANSID: gCh0CgD3hqkqDvBkLoz8Bw--.42583S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFy7XF4ftryfCF17uF1fCrg_yoW3Wry3pr
	1fJF4rJr1DtF1DCay5ZrZrCrW8Za1S9a45uFyYyr9Ygr9Fqr98Kr45uF13WrWUKr95Wa10
	yFsYqas0va1jq3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUOyCJDUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_205118_412582_9E5D881E 
X-CRM114-Status: GOOD (  33.52  )
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
>    reserve_crashkernel_generic();
> 
> 3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
>    arch/arm64/Kconfig.
> 
> The old reserve_crashkernel_low() and reserve_crashkernel() can be
> removed.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm64/Kconfig                  |   3 +
>  arch/arm64/include/asm/crash_core.h |  10 ++
>  arch/arm64/mm/init.c                | 140 ++--------------------------
>  3 files changed, 21 insertions(+), 132 deletions(-)
>  create mode 100644 arch/arm64/include/asm/crash_core.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 29db061db9bb..07fb8c71339d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1481,6 +1481,9 @@ config KEXEC_FILE
>  	  for kernel and initramfs as opposed to list of segments as
>  	  accepted by previous system call.
>  
> +config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +	def_bool CRASH_CORE
> +
>  config KEXEC_SIG
>  	bool "Verify kernel signature during kexec_file_load() syscall"
>  	depends on KEXEC_FILE
> diff --git a/arch/arm64/include/asm/crash_core.h b/arch/arm64/include/asm/crash_core.h
> new file mode 100644
> index 000000000000..9f5c8d339f44
> --- /dev/null
> +++ b/arch/arm64/include/asm/crash_core.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ARM64_CRASH_CORE_H
> +#define _ARM64_CRASH_CORE_H
> +
> +/* Current arm64 boot protocol requires 2MB alignment */
> +#define CRASH_ALIGN                     SZ_2M
> +
> +#define CRASH_ADDR_LOW_MAX              arm64_dma_phys_limit
> +#define CRASH_ADDR_HIGH_MAX             (PHYS_MASK + 1)
> +#endif
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 4ad637508b75..48ab23531bb6 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -64,15 +64,6 @@ EXPORT_SYMBOL(memstart_addr);
>   */
>  phys_addr_t __ro_after_init arm64_dma_phys_limit;
>  
> -/* Current arm64 boot protocol requires 2MB alignment */
> -#define CRASH_ALIGN			SZ_2M
> -
> -#define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
> -#define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
> -#define CRASH_HIGH_SEARCH_BASE		SZ_4G
> -
> -#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
> -
>  /*
>   * To make optimal use of block mappings when laying out the linear
>   * mapping, round down the base of physical memory to a size that can
> @@ -100,140 +91,25 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
>  #define ARM64_MEMSTART_ALIGN	(1UL << ARM64_MEMSTART_SHIFT)
>  #endif
>  
> -static int __init reserve_crashkernel_low(unsigned long long low_size)
> -{
> -	unsigned long long low_base;
> -
> -	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> -	if (!low_base) {
> -		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
> -		return -ENOMEM;
> -	}
> -
> -	pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
> -		low_base, low_base + low_size, low_size >> 20);
> -
> -	crashk_low_res.start = low_base;
> -	crashk_low_res.end   = low_base + low_size - 1;
> -	insert_resource(&iomem_resource, &crashk_low_res);
> -
> -	return 0;
> -}
> -
> -/*
> - * reserve_crashkernel() - reserves memory for crash kernel
> - *
> - * This function reserves memory area given in "crashkernel=" kernel command
> - * line parameter. The memory reserved is used by dump capture kernel when
> - * primary kernel is crashing.
> - */
> -static void __init reserve_crashkernel(void)
> +static void __init arch_reserve_crashkernel(void)
>  {
> -	unsigned long long crash_low_size = 0, search_base = 0;
> -	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> +	unsigned long long low_size = 0;
>  	unsigned long long crash_base, crash_size;
>  	char *cmdline = boot_command_line;
> -	bool fixed_base = false;
>  	bool high = false;
>  	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
>  
> -	/* crashkernel=X[@offset] */
>  	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> -				&crash_size, &crash_base, NULL, NULL);
> -	if (ret == -ENOENT) {
> -		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> -		if (ret || !crash_size)
> -			return;
> -
> -		/*
> -		 * crashkernel=Y,low can be specified or not, but invalid value
> -		 * is not allowed.
> -		 */
> -		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
> -		if (ret == -ENOENT)
> -			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> -		else if (ret)
> -			return;
> -
> -		search_base = CRASH_HIGH_SEARCH_BASE;
> -		crash_max = CRASH_ADDR_HIGH_MAX;
> -		high = true;
> -	} else if (ret || !crash_size) {
> -		/* The specified value is invalid */
> +				&crash_size, &crash_base,
> +				&low_size, &high);
> +	if (ret)
>  		return;
> -	}
> -
> -	crash_size = PAGE_ALIGN(crash_size);
> -
> -	/* User specifies base address explicitly. */
> -	if (crash_base) {
> -		fixed_base = true;
> -		search_base = crash_base;
> -		crash_max = crash_base + crash_size;
> -	}
> -
> -retry:
> -	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> -					       search_base, crash_max);
> -	if (!crash_base) {
> -		/*
> -		 * For crashkernel=size[KMG]@offset[KMG], print out failure
> -		 * message if can't reserve the specified region.
> -		 */
> -		if (fixed_base) {
> -			pr_warn("crashkernel reservation failed - memory is in use.\n");
> -			return;
> -		}
> -
> -		/*
> -		 * For crashkernel=size[KMG], if the first attempt was for
> -		 * low memory, fall back to high memory, the minimum required
> -		 * low memory will be reserved later.
> -		 */
> -		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
> -			crash_max = CRASH_ADDR_HIGH_MAX;
> -			search_base = CRASH_ADDR_LOW_MAX;
> -			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> -			goto retry;
> -		}
> -
> -		/*
> -		 * For crashkernel=size[KMG],high, if the first attempt was
> -		 * for high memory, fall back to low memory.
> -		 */
> -		if (high && crash_max == CRASH_ADDR_HIGH_MAX) {
> -			crash_max = CRASH_ADDR_LOW_MAX;
> -			search_base = 0;
> -			goto retry;
> -		}
> -		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> -			crash_size);
> -		return;
> -	}
> -
> -	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
> -	     reserve_crashkernel_low(crash_low_size)) {
> -		memblock_phys_free(crash_base, crash_size);
> -		return;
> -	}
> -
> -	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> -		crash_base, crash_base + crash_size, crash_size >> 20);
> -
> -	/*
> -	 * The crashkernel memory will be removed from the kernel linear
> -	 * map. Inform kmemleak so that it won't try to access it.
> -	 */
> -	kmemleak_ignore_phys(crash_base);
> -	if (crashk_low_res.end)
> -		kmemleak_ignore_phys(crashk_low_res.start);
>  
> -	crashk_res.start = crash_base;
> -	crashk_res.end = crash_base + crash_size - 1;
> -	insert_resource(&iomem_resource, &crashk_res);
> +	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
> +				    low_size, high);
>  }
>  
>  /*
> @@ -481,7 +357,7 @@ void __init bootmem_init(void)
>  	 * request_standard_resources() depends on crashkernel's memory being
>  	 * reserved, so do it here.
>  	 */
> -	reserve_crashkernel();
> +	arch_reserve_crashkernel();
>  
>  	memblock_dump_all();
>  }
> 

-- 
Regards,
  Zhen Lei


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7471C83F14
	for <kexec@archiver.kernel.org>; Thu, 31 Aug 2023 02:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=SOewb3NeS64w2ZMq8jruUU0MnjtnBf2votiSqvBlxjA=; b=nVStC5AZWbUCNS7pPPTP0X7jm0
	o2ZJHd+BWokAXr7xYS6F6qUpaQZviy+D0q4fIZBYAMINS85x41n4Vp5Jo/8qDmmc2th4GoEYCOkRY
	Zn05GcwjE0gT5vBWQc4V5FQMBuhrj7v+j/Hk3ywszEbfUbHYbAVdxrCJxcwtxh0ctle/PzcLJtIwQ
	JapBrMherS+h3HJh6ZUemz3vxBLf3nIN0ptli74PHPmBugo9TaDYczqgkNoxc51lRDztfmawqaExT
	J3m/vLrEkq6H73/f4b5evIejic7YfBlAn/2tKIcZsgCkNAYoUHkHBPzEPvlo3zYbZmfZUkftfJUqB
	FMcJCDGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbXS9-00EV5N-0R;
	Thu, 31 Aug 2023 02:30:37 +0000
Received: from [45.249.212.56] (helo=dggsgout12.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbXS5-00EV4V-0v;
	Thu, 31 Aug 2023 02:30:35 +0000
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RblWG5DwTz4f3s5l;
	Thu, 31 Aug 2023 10:30:18 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgBH16k8++9kWev3Bw--.61986S3;
	Thu, 31 Aug 2023 10:30:22 +0800 (CST)
Subject: Re: [PATCH v2 2/8] crash_core: change the prototype of function
 parse_crashkernel()
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com,
 thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
 samuel.holland@sifive.com, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-3-bhe@redhat.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <77c34c98-f6b1-75e1-dbf3-a148691e7f9d@huaweicloud.com>
Date: Thu, 31 Aug 2023 10:30:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230829121610.138107-3-bhe@redhat.com>
Content-Language: en-US
X-CM-TRANSID: gCh0CgBH16k8++9kWev3Bw--.61986S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFW5uw17JF4kAw1xGr45Wrg_yoWfZFykpr
	1UAF4rKr4jyFykCa4xAr93urWrJ3Wv9a47WFyUAr95tF9rXF15tr4rW3W7WrWjqrs093WI
	yasYqFsaga10gaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_193033_660282_072E6CE8 
X-CRM114-Status: GOOD (  19.61  )
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
> Add two parameters 'low_size' and 'high' to function parse_crashkernel(),
> later crashkernel=,high|low parsing will be added. Make adjustments in all
> call sites of parse_crashkernel() in arch.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm/kernel/setup.c              |  3 ++-
>  arch/arm64/mm/init.c                 |  2 +-
>  arch/ia64/kernel/setup.c             |  2 +-
>  arch/loongarch/kernel/setup.c        |  4 +++-
>  arch/mips/kernel/setup.c             |  3 ++-
>  arch/powerpc/kernel/fadump.c         |  2 +-
>  arch/powerpc/kexec/core.c            |  2 +-
>  arch/powerpc/mm/nohash/kaslr_booke.c |  2 +-
>  arch/riscv/mm/init.c                 |  2 +-
>  arch/s390/kernel/setup.c             |  4 ++--
>  arch/sh/kernel/machine_kexec.c       |  2 +-
>  arch/x86/kernel/setup.c              |  3 ++-
>  include/linux/crash_core.h           |  3 ++-
>  kernel/crash_core.c                  | 15 ++++++++++++---
>  14 files changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index c66b560562b3..e2bb7afd0683 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -1010,7 +1010,8 @@ static void __init reserve_crashkernel(void)
>  
>  	total_mem = get_total_mem();
>  	ret = parse_crashkernel(boot_command_line, total_mem,
> -				&crash_size, &crash_base);
> +				&crash_size, &crash_base,
> +				NULL, NULL);
>  	/* invalid value specified or crashkernel=0 */
>  	if (ret || !crash_size)
>  		return;
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 4fcb88a445ef..4ad637508b75 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -142,7 +142,7 @@ static void __init reserve_crashkernel(void)
>  
>  	/* crashkernel=X[@offset] */
>  	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> -				&crash_size, &crash_base);
> +				&crash_size, &crash_base, NULL, NULL);
>  	if (ret == -ENOENT) {
>  		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
>  		if (ret || !crash_size)
> diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
> index 5a55ac82c13a..4faea2d2cf07 100644
> --- a/arch/ia64/kernel/setup.c
> +++ b/arch/ia64/kernel/setup.c
> @@ -277,7 +277,7 @@ static void __init setup_crashkernel(unsigned long total, int *n)
>  	int ret;
>  
>  	ret = parse_crashkernel(boot_command_line, total,
> -			&size, &base);
> +			&size, &base, NULL, NULL);
>  	if (ret == 0 && size > 0) {
>  		if (!base) {
>  			sort_regions(rsvd_region, *n);
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index 9d830ab4e302..776a068d8718 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -267,7 +267,9 @@ static void __init arch_parse_crashkernel(void)
>  	unsigned long long crash_base, crash_size;
>  
>  	total_mem = memblock_phys_mem_size();
> -	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
> +	ret = parse_crashkernel(boot_command_line, total_mem,
> +				&crash_size, &crash_base,
> +				NULL, NULL);
>  	if (ret < 0 || crash_size <= 0)
>  		return;
>  
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index cb871eb784a7..08321c945ac4 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -460,7 +460,8 @@ static void __init mips_parse_crashkernel(void)
>  
>  	total_mem = memblock_phys_mem_size();
>  	ret = parse_crashkernel(boot_command_line, total_mem,
> -				&crash_size, &crash_base);
> +				&crash_size, &crash_base,
> +				NULL, NULL);
>  	if (ret != 0 || crash_size <= 0)
>  		return;
>  
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index ea0a073abd96..7dbdeba56e74 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -313,7 +313,7 @@ static __init u64 fadump_calculate_reserve_size(void)
>  	 * memory at a predefined offset.
>  	 */
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> -				&size, &base);
> +				&size, &base, NULL, NULL);
>  	if (ret == 0 && size > 0) {
>  		unsigned long max_size;
>  
> diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
> index de64c7962991..9346c960b296 100644
> --- a/arch/powerpc/kexec/core.c
> +++ b/arch/powerpc/kexec/core.c
> @@ -109,7 +109,7 @@ void __init reserve_crashkernel(void)
>  	total_mem_sz = memory_limit ? memory_limit : memblock_phys_mem_size();
>  	/* use common parsing */
>  	ret = parse_crashkernel(boot_command_line, total_mem_sz,
> -			&crash_size, &crash_base);
> +			&crash_size, &crash_base, NULL, NULL);
>  	if (ret == 0 && crash_size > 0) {
>  		crashk_res.start = crash_base;
>  		crashk_res.end = crash_base + crash_size - 1;
> diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
> index 2fb3edafe9ab..b4f2786a7d2b 100644
> --- a/arch/powerpc/mm/nohash/kaslr_booke.c
> +++ b/arch/powerpc/mm/nohash/kaslr_booke.c
> @@ -178,7 +178,7 @@ static void __init get_crash_kernel(void *fdt, unsigned long size)
>  	int ret;
>  
>  	ret = parse_crashkernel(boot_command_line, size, &crash_size,
> -				&crash_base);
> +				&crash_base, NULL, NULL);
>  	if (ret != 0 || crash_size == 0)
>  		return;
>  	if (crash_base == 0)
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index e4c35ac2357f..a9ef0824f905 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1332,7 +1332,7 @@ static void __init reserve_crashkernel(void)
>  	}
>  
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> -				&crash_size, &crash_base);
> +				&crash_size, &crash_base, NULL, NULL);
>  	if (ret || !crash_size)
>  		return;
>  
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index c744104e4a9c..98204a5f62b1 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -626,8 +626,8 @@ static void __init reserve_crashkernel(void)
>  	phys_addr_t low, high;
>  	int rc;
>  
> -	rc = parse_crashkernel(boot_command_line, ident_map_size, &crash_size,
> -			       &crash_base);
> +	rc = parse_crashkernel(boot_command_line, ident_map_size,
> +			       &crash_size, &crash_base, NULL, NULL);
>  
>  	crash_base = ALIGN(crash_base, KEXEC_CRASH_MEM_ALIGN);
>  	crash_size = ALIGN(crash_size, KEXEC_CRASH_MEM_ALIGN);
> diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
> index 223c14f44af7..fa3a7b36190a 100644
> --- a/arch/sh/kernel/machine_kexec.c
> +++ b/arch/sh/kernel/machine_kexec.c
> @@ -154,7 +154,7 @@ void __init reserve_crashkernel(void)
>  	int ret;
>  
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> -			&crash_size, &crash_base);
> +			&crash_size, &crash_base, NULL, NULL);
>  	if (ret == 0 && crash_size > 0) {
>  		crashk_res.start = crash_base;
>  		crashk_res.end = crash_base + crash_size - 1;
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index fd975a4a5200..382c66d2cf71 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -558,7 +558,8 @@ static void __init reserve_crashkernel(void)
>  	total_mem = memblock_phys_mem_size();
>  
>  	/* crashkernel=XM */
> -	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
> +	ret = parse_crashkernel(boot_command_line, total_mem,
> +				&crash_size, &crash_base, NULL, NULL);
>  	if (ret != 0 || crash_size <= 0) {
>  		/* crashkernel=X,high */
>  		ret = parse_crashkernel_high(boot_command_line, total_mem,
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e..2e76289699ff 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -78,7 +78,8 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  void final_note(Elf_Word *buf);
>  
>  int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
> -		unsigned long long *crash_size, unsigned long long *crash_base);
> +		unsigned long long *crash_size, unsigned long long *crash_base,
> +		unsigned long long *low_size, bool *high);
>  int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base);
>  int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index f27b4e45d410..f6a5c219e2e1 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -280,10 +280,19 @@ static int __init __parse_crashkernel(char *cmdline,
>  int __init parse_crashkernel(char *cmdline,
>  			     unsigned long long system_ram,
>  			     unsigned long long *crash_size,
> -			     unsigned long long *crash_base)
> +			     unsigned long long *crash_base,
> +			     unsigned long long *low_size,
> +			     bool *high)
>  {
> -	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> -				NULL);
> +	int ret;
> +
> +	/* crashkernel=X[@offset] */
> +	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
> +				crash_base, NULL);
> +	if (!high)
> +		return ret;
> +
> +	return 0;
>  }
>  
>  int __init parse_crashkernel_high(char *cmdline,
> 

-- 
Regards,
  Zhen Lei


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

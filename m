Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9147FC982D2
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 08:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T0JHVWPEX+y53lIHPhD5/BSPnjVOTml/jp7Miw8vUP8=; b=KZ9/Axcqb1Hy/56XpqO3ea9kUe
	dOzhUeV6PLb9ArmZU7gmfRhOGtWhRMlOIXQYYScCpgClCNoRzAAvbGXAEEQOmk7uzqNuWBpxIZ3CF
	g/gqbA8JfMOpIt7pI6+0y+0+/I4DrgE1CjhWcBWuOWZEqKniRiYGXyYNln9YHZMT3pdLodLwsKuCi
	HFZ6OkGE5VrGsBG9QGb/ReNYp9vArEF7wmNKWtOZ2n6HdsZ7YeuQwmrHQ3Z6cRKnpkkLz5O+/FEtG
	nNEFfY3rb5L+LKpHQuobFI5XjU5FVNQETc6AkIFXhTtK4NAqyN3/K9NVUzNfhLm9zSmlq99DYGCrM
	n1c96/YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7UEY-0000000Dqt9-0Psz;
	Fri, 18 Sep 2026 08:46:14 +0000
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7UET-0000000Dqs6-2yF3
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 08:46:11 +0000
Received: by mail-pj2-x0b.google.com with SMTP id 98e67ed59e1d1-398a0a87595so665526a91.1
        for <kexec@lists.infradead.org>; Fri, 18 Sep 2026 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789721169; x=1790325969; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0JHVWPEX+y53lIHPhD5/BSPnjVOTml/jp7Miw8vUP8=;
        b=RNgwGZ2GGHxcG8/4mWKLKB1yRXlsQNBcTDzXPg4ALlURxKkopGuuqH+h29f380D/vv
         0uJCLH8yraQpO20QgDT64V/LEAM0hEaCmCmGm/3ID9qg5OeaMNJZLZDYX0rZ7Nx5x/wO
         inlblU3Nl1PXEpvSxb6ZekFnA2Yc/moNNNCfx/9woR8izttJJ/R7RZJUoHiwMNJgJ1R5
         5ooF3729xrBTOjcNaQjjNDuy8/R2xktO7h6SWTP/Mnw8HLvsNvAcDTK7nL+szWnkLmRX
         AT5awYJOuZS4E04AgU0pw5u+gftmgOhNj6kMRsxu1GYrojLmLFRnDmTzC+0NJJNVbifo
         JQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789721169; x=1790325969;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T0JHVWPEX+y53lIHPhD5/BSPnjVOTml/jp7Miw8vUP8=;
        b=kBI9+CCyKONi6ivTSlGldHAk96rf4Wl/+afcSIFBFQLI7+p9Us4SmFucAB6ibZ9zYq
         tzioJ+1LwQIQ1DA9KIjEikUiULxWEijg0DN0/xLwZ6VdzIHvUWFZVfPQU1ztatKmcwsg
         rthfiGsusvcYOOkQzh2Jvrk29BN7+whqBUl5eoWjnwFNQbkZW87puudPNQxwLaEZwFMN
         bXys2WdquiyBPbyPB91mA7tnJphH9ObKotkW8/2eC9vvm5ytgc7BKlKU3CGEB7ogqs5O
         ftrmtMq7cpoKdupYHaFRDiaLyeEyE6QXsl0zPPkcjgR3OjJ4WJl3vfrzl3BehOaNGvSz
         hM9g==
X-Forwarded-Encrypted: i=1; AKwUvBwQqmCe0GFAn0JNAMRf8BiUX8TLPO1HY11uMRYy54b7hVogjhE7OF9sBQtEZnxPJQLHSG7FLA==@lists.infradead.org
X-Gm-Message-State: AFuF++msioZryvxSe0+hqlodp1CnT2GpNwurMoI0vq2prtw7A5Cw7Ebh
	cQBuNtc98czGVYLwWDd3tW2cVflCFkTWMYZse5Tknk3hgeJlQ68ooDPq
X-Gm-Gg: AYBFou3n6DhbxBaEEZjlQY+8o1o64X8MjSw4v0WXs+QrFWybVCibqhKr2qyXO7DOjHL
	qZSFwKpeDf1ETy/36SGzNo2wLrvv5fKMYEnHPnm5uEs9l2QbKIY7cmwz/N4ZWHRZruOOjCpJJv9
	76UG5G6gYm3FxZVOeOpWVbXdj+ejwqgtZuQxHj9f++sfDNRaSOGFAUUiT1DbZKdnEaDVo6tpQ/7
	9u2Lw+gSoBp6DMk1UlSrEptU3v98N9FwznTEeJOmURH6DWEsXoLH4s1GiBxx2Eh2B1DUjQ3Ln9B
	Umh+LfCpiG3Gt8rZbNZlAOfk5fh2sTFGzNx/lHgfnN/F+vlUfMbJv4B9DzcybgWBRNRybD7zV+b
	OHYcJGHXYXujaHJZlM90m+x/tPlbFrpmopPkHuZrSK1zKLfTWAoSVPRkcCnXVQ1k7LinnyGt6KD
	NfFo5NVlA4bI4L8BYoCSeSQFB1bUDIid9+6S/z6aoKSwM86NBkERx4LDfthctCilQwKGU0cR0Ed
	f/fYw==
X-Received: by 2002:a17:90b:5784:b0:39d:f5b1:e365 with SMTP id 98e67ed59e1d1-39e54f35b9cmr3920258a91.25.1789721168773;
        Fri, 18 Sep 2026 01:46:08 -0700 (PDT)
Received: from [10.125.112.20] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e59e4a508sm2264153a91.0.2026.09.18.01.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 01:46:08 -0700 (PDT)
Message-ID: <c58e9b6a-e421-4265-aa77-48c07a4fb8e4@gmail.com>
Date: Fri, 18 Sep 2026 16:45:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/10] crash_core: fold duplicated memblock arch hooks
 into the weak default
To: Baoquan He <baoquan.he@linux.dev>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
 rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 m.szyprowski@samsung.com, mark.rutland@arm.com, kernel@xen0n.name,
 alex@ghiti.fr, hpa@zytor.com, ruirui.yang@linux.dev, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 iommu@lists.linux.dev
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-4-chenwandun1@gmail.com> <aqzolBceoRchBdbx@fedora>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <aqzolBceoRchBdbx@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_014609_812833_65920909 
X-CRM114-Status: GOOD (  22.75  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 9/18/26 15:30, Baoquan He wrote:
> On 09/02/26 at 03:31pm, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> arm64, loongarch and riscv open-code the same memblock walk in
>> arch_get_system_nr_ranges() and arch_crash_populate_cmem(). Move it into
>> the __weak defaults in kernel/crash_core.c and delete the arch copies.
>>
>> No functional change.
> 
> In one version, you also tried to remove these functions on x86, I could
> remember it wrong. 

Yes, the x86 implementation can also remove these functions and use the same
approach as arm64, RISC-V, and LoongArch. However since this change would not
reduce the vmcore size on x86 at all, I did not include it in the current series.

I plan to refactor this part on x86 after this series.

Best regards,
Wandun


> 
> Anyway, this looks good to me.
> 
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> 
>>
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
>> ---
>>  arch/arm64/kernel/machine_kexec_file.c     | 29 ----------------------
>>  arch/loongarch/kernel/machine_kexec_file.c | 27 --------------------
>>  arch/riscv/kernel/machine_kexec_file.c     | 26 -------------------
>>  kernel/crash_core.c                        | 25 +++++++++++++++++--
>>  4 files changed, 23 insertions(+), 84 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>> index 854d872dfd0f..34d944d3f22f 100644
>> --- a/arch/arm64/kernel/machine_kexec_file.c
>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>> @@ -14,7 +14,6 @@
>>  #include <linux/kernel.h>
>>  #include <linux/kexec.h>
>>  #include <linux/libfdt.h>
>> -#include <linux/memblock.h>
>>  #include <linux/of.h>
>>  #include <linux/of_fdt.h>
>>  #include <linux/slab.h>
>> @@ -39,34 +38,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>>  	return kexec_image_post_load_cleanup_default(image);
>>  }
>>  
>> -#ifdef CONFIG_CRASH_DUMP
>> -unsigned int arch_get_system_nr_ranges(void)
>> -{
>> -	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
>> -	phys_addr_t start, end;
>> -	u64 i;
>> -
>> -	for_each_mem_range(i, &start, &end)
>> -		nr_ranges++;
>> -
>> -	return nr_ranges;
>> -}
>> -
>> -int arch_crash_populate_cmem(struct crash_mem *cmem)
>> -{
>> -	phys_addr_t start, end;
>> -	u64 i;
>> -
>> -	for_each_mem_range(i, &start, &end) {
>> -		cmem->ranges[cmem->nr_ranges].start = start;
>> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
>> -		cmem->nr_ranges++;
>> -	}
>> -
>> -	return 0;
>> -}
>> -#endif
>> -
>>  /*
>>   * Tries to add the initrd and DTB to the image. If it is not possible to find
>>   * valid locations, this function will undo changes to the image and return non
>> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
>> index 5412aa9f3568..481b8f906a56 100644
>> --- a/arch/loongarch/kernel/machine_kexec_file.c
>> +++ b/arch/loongarch/kernel/machine_kexec_file.c
>> @@ -13,7 +13,6 @@
>>  #include <linux/ioport.h>
>>  #include <linux/kernel.h>
>>  #include <linux/kexec.h>
>> -#include <linux/memblock.h>
>>  #include <linux/slab.h>
>>  #include <linux/string.h>
>>  #include <linux/types.h>
>> @@ -56,32 +55,6 @@ static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmpl
>>  }
>>  
>>  #ifdef CONFIG_CRASH_DUMP
>> -unsigned int arch_get_system_nr_ranges(void)
>> -{
>> -	int nr_ranges = 2; /* for exclusion of crashkernel region */
>> -	phys_addr_t start, end;
>> -	uint64_t i;
>> -
>> -	for_each_mem_range(i, &start, &end)
>> -		nr_ranges++;
>> -
>> -	return nr_ranges;
>> -}
>> -
>> -int arch_crash_populate_cmem(struct crash_mem *cmem)
>> -{
>> -	phys_addr_t start, end;
>> -	uint64_t i;
>> -
>> -	for_each_mem_range(i, &start, &end) {
>> -		cmem->ranges[cmem->nr_ranges].start = start;
>> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
>> -		cmem->nr_ranges++;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>  /*
>>   * Add the "mem=size@start" command line parameter to command line, indicating the
>>   * memory region the new kernel can use to boot into.
>> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
>> index 808e872f4063..fdc6695e8588 100644
>> --- a/arch/riscv/kernel/machine_kexec_file.c
>> +++ b/arch/riscv/kernel/machine_kexec_file.c
>> @@ -37,32 +37,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>>  }
>>  
>>  #ifdef CONFIG_CRASH_DUMP
>> -unsigned int arch_get_system_nr_ranges(void)
>> -{
>> -	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* For exclusion of crashkernel region */
>> -	u64 i;
>> -	phys_addr_t start, end;
>> -
>> -	for_each_mem_range(i, &start, &end)
>> -		nr_ranges++;
>> -
>> -	return nr_ranges;
>> -}
>> -
>> -int arch_crash_populate_cmem(struct crash_mem *cmem)
>> -{
>> -	u64 i;
>> -	phys_addr_t start, end;
>> -
>> -	for_each_mem_range(i, &start, &end) {
>> -		cmem->ranges[cmem->nr_ranges].start = start;
>> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
>> -		cmem->nr_ranges++;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>  static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
>>  				 unsigned long cmdline_len)
>>  {
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 2b36aa9fade0..77285ae3ce60 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -281,8 +281,29 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
>>  	return cmem;
>>  }
>>  
>> -unsigned int __weak arch_get_system_nr_ranges(void) { return 0; }
>> -int __weak arch_crash_populate_cmem(struct crash_mem *cmem) { return -1; }
>> +unsigned int __weak arch_get_system_nr_ranges(void)
>> +{
>> +	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* crashk_res + crashk_low_res, +CMA splits */
>> +	phys_addr_t start, end;
>> +	u64 i;
>> +
>> +	for_each_mem_range(i, &start, &end)
>> +		nr_ranges++;
>> +	return nr_ranges;
>> +}
>> +
>> +int __weak arch_crash_populate_cmem(struct crash_mem *cmem)
>> +{
>> +	phys_addr_t start, end;
>> +	u64 i;
>> +
>> +	for_each_mem_range(i, &start, &end) {
>> +		cmem->ranges[cmem->nr_ranges].start = start;
>> +		cmem->ranges[cmem->nr_ranges].end = end - 1;
>> +		cmem->nr_ranges++;
>> +	}
>> +	return 0;
>> +}
>>  int __weak arch_crash_exclude_ranges(struct crash_mem *cmem) { return 0; }
>>  
>>  int __weak arch_crash_exclude_mem_range(struct crash_mem **mem,
>> -- 
>> 2.43.0
>>



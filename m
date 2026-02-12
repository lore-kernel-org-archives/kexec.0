Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B977EFD5310
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 08:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RZTcbKUpf2wubcUUQwFd4TLSwyssXimapX4rFbyIz5A=; b=jF5xwj4E64R8mL0fA+s0QrrSOS
	Vv1AGZMHXmBA4Kd+qHfaDVjkY68aJqyie/eZ/xL4kY21g68TNvpFJdPMMHMIL6KuNxdAYVtL+Z1DB
	YCszJEF7o4iDIh8Y8YGtC8k9Oft32Y0cc/yb0Ma2XcbXRuk5fyJ8y9+KWCaZ9NVDuMSz2RnvXk0NS
	/GFXWTO1A2m8OdmIPw4z3hpLJYwSUUQQFqq9AHhH/4dgpFzY/5U9mqrAXfC5ANhqmRPXueX1JIVZW
	8CF4EK+LHFSHuo/bOsss6wR6Dx83mzMtf+ygcBCdOE47jinGk7+AGH0lo9xkh2JAzru4J7X0ViBXm
	UMtpzvig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvtN1-000000080CP-0nA5;
	Fri, 27 Feb 2026 08:38:47 +0000
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqNNx-00000001bYX-0fKw;
	Thu, 12 Feb 2026 03:29:02 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RZTcbKUpf2wubcUUQwFd4TLSwyssXimapX4rFbyIz5A=;
	b=cXMfoad+w/Ix+LI9YndMWoNmF4Iu3IJhXflwlT1MxUXYGZVZzdihNCJKOT0lufO87rj8TPJxq
	3rCoLyHgE6YQfJO7OcmMQHWBZTvKnoxt4QdFUAjcXo3Ou/NK7Ychs3Q1erI52ZOjhspHUesfzbk
	tjGTeV7nVTLFy9vfIpqFDy4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fBLHs1gjWzRhRT;
	Thu, 12 Feb 2026 11:24:09 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 7371340567;
	Thu, 12 Feb 2026 11:28:47 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Feb 2026 11:28:43 +0800
Message-ID: <31c2ae53-cbb7-bfad-9b8f-f9e1a254491e@huawei.com>
Date: Thu, 12 Feb 2026 11:28:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/3] crash: Exclude crash kernel memory in crash core
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, <corbet@lwn.net>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<rdunlap@infradead.org>, <pmladek@suse.com>, <feng.tang@linux.alibaba.com>,
	<pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<arnd@arndb.de>, <lirongqing@baidu.com>, <fvdl@google.com>,
	<leitao@debian.org>, <rppt@kernel.org>, <ardb@kernel.org>, <jbohac@suse.cz>,
	<osandov@fb.com>, <ryan.roberts@arm.com>, <cfsworks@gmail.com>,
	<tangyouling@kylinos.cn>, <ritesh.list@gmail.com>, <thuth@redhat.com>,
	<hbathini@linux.ibm.com>, <eajames@linux.ibm.com>, <bjorn@rivosinc.com>,
	<songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<samuel.holland@sifive.com>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <dwmw@amazon.co.uk>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kai.huang@intel.com>, <ubizjak@gmail.com>,
	<coxu@redhat.com>, <liaoyuanhong@vivo.com>, <fuqiang.wang@easystack.cn>,
	<brgerst@gmail.com>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
References: <20260209095931.2813152-1-ruanjinjie@huawei.com>
 <20260209095931.2813152-2-ruanjinjie@huawei.com>
 <50693f0c-c610-4347-86aa-40d50dc681fc@linux.ibm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <50693f0c-c610-4347-86aa-40d50dc681fc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_192900_340404_2E701B26 
X-CRM114-Status: GOOD (  32.01  )
X-Mailman-Approved-At: Fri, 27 Feb 2026 00:38:19 -0800
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



On 2026/2/10 20:30, Sourabh Jain wrote:
> Hello Jinjie,
> 
> On 09/02/26 15:29, Jinjie Ruan wrote:
>> The exclude of crashk_res, crashk_low_res and crashk_cma memory
>> are almost identical across different architectures, handling them
>> in the crash core would eliminate a lot of duplication, so do
>> them in the common code.
>>
>> And move the size calculation (and the realloc if needed) into the
>> generic crash core so that:
>>
>> - New CMA regions or future crash-memory types can automatically
>>    accounted for in crash core;
>>
>> - Each architecture no longer has to play whack-a-mole with
>>    its private array size.
>>
>> To achieve the above goal, 4 architecture-specific functions are
>> introduced:
>>
>> - arch_get_system_nr_ranges() and arch_prepare_elf64_ram_headers().
>>    The 1st function pre-counts the number of memory ranges, and
>>    the 2st function fill the memory ranges into the cmem->ranges[] array,
>>    and count the actual number of ranges filled. The default
>> implementation
>>    is consistent with arm64 and loongson.
>>
>> - arch_crash_exclude_mem_range(). Realloc for powerpc. The default
>>    implementation is crash_exclude_mem_range(), and use
>>    crash_exclude_mem_range_guarded() to implement the arch version
>>    for powerpc.
>>
>> - arch_get_crash_memory_ranges(). Get crash memory ranges for arch and
>>    the default implementation is generic across x86, arm64, riscv, and
>>    loongson by using the first two arch functions above. powerpc has its
>>    own implementation by calling get_crash_memory_ranges().
>>
>> Tested on x86, arm64 and riscv with QEMU.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   arch/arm64/kernel/machine_kexec_file.c     |  47 +--------
>>   arch/loongarch/kernel/machine_kexec_file.c |  45 +-------
>>   arch/powerpc/include/asm/kexec.h           |  13 +++
>>   arch/powerpc/kexec/crash.c                 |  52 ++++++----
>>   arch/powerpc/kexec/file_load_64.c          |  17 ++-
>>   arch/powerpc/kexec/ranges.c                |  18 +---
>>   arch/riscv/include/asm/kexec.h             |  10 ++
>>   arch/riscv/kernel/machine_kexec_file.c     |  37 ++-----
>>   arch/x86/include/asm/kexec.h               |  10 ++
>>   arch/x86/kernel/crash.c                    | 104 ++-----------------
>>   include/linux/crash_core.h                 | 114 +++++++++++++++++++--
>>   kernel/crash_core.c                        |  71 +++++++++++--
>>   12 files changed, 269 insertions(+), 269 deletions(-)
>>

[...]

>>   extern void crash_ipi_callback(struct pt_regs *regs);
>> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
>> index a325c1c02f96..5ade9a853fb0 100644
>> --- a/arch/powerpc/kexec/crash.c
>> +++ b/arch/powerpc/kexec/crash.c
>> @@ -419,30 +419,21 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>>       return sizeof(struct elfhdr) + (phdr_cnt * sizeof(Elf64_Phdr));
>>   }
>>   -/**
>> - * update_crash_elfcorehdr() - Recreate the elfcorehdr and replace it
>> with old
>> - *                   elfcorehdr in the kexec segment array.
>> - * @image: the active struct kimage
>> - * @mn: struct memory_notify data handler
>> - */
>> -static void update_crash_elfcorehdr(struct kimage *image, struct
>> memory_notify *mn)
>> +int arch_get_crash_memory_ranges(struct crash_mem **cmem, unsigned
>> long *nr_mem_ranges,
>> +                 struct kimage *image, struct memory_notify *mn)
>>   {
>> +    unsigned long base_addr, size;
>>       int ret;
>> -    struct crash_mem *cmem = NULL;
>> -    struct kexec_segment *ksegment;
>> -    void *ptr, *mem, *elfbuf = NULL;
>> -    unsigned long elfsz, memsz, base_addr, size;
>>   -    ksegment = &image->segment[image->elfcorehdr_index];
>> -    mem = (void *) ksegment->mem;
>> -    memsz = ksegment->memsz;
>> -
>> -    ret = get_crash_memory_ranges(&cmem);
>> +    ret = get_crash_memory_ranges(cmem);
>>       if (ret) {
>>           pr_err("Failed to get crash mem range\n");
>> -        return;
>> +        return ret;
>>       }
>>   +    if (!image || !mn)
>> +        return 0;
>> +
>>       /*
>>        * The hot unplugged memory is part of crash memory ranges,
>>        * remove it here.
>> @@ -450,14 +441,34 @@ static void update_crash_elfcorehdr(struct
>> kimage *image, struct memory_notify *
>>       if (image->hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY) {
>>           base_addr = PFN_PHYS(mn->start_pfn);
>>           size = mn->nr_pages * PAGE_SIZE;
>> -        ret = remove_mem_range(&cmem, base_addr, size);
>> +        ret = remove_mem_range(cmem, base_addr, size);
> 
> I like the overall design for handling crashkernel memory exclusion
> in this patch series, especially the way you managed to free the
> crash_mem object (mem) in the generic code (crash_prepare_elf64_headers()).

Thanks for the review.

> 
> However, the way crash memory is prepared after a memory hotplug
> event on powerpc by calling remove_mem_range(), can leave the crash
> memory ranges unsorted. This can cause issues in the generic code
> when excluding crashkernel memory, because crash_exclude_mem_range()
> expects crash_mem to be sorted.

You are absolutely correct.

> 
> So I wrote a simple patch to cover this scenario. Including the
> patch below as the first patch in this series would be helpful.
> https://lore.kernel.org/all/20260210120803.433978-1-sourabhjain@linux.ibm.com/

Thanks for the additional patch. I'll add it as the first patch in the
next revision to ensure crash_mem remains sorted after memory hotplug
events on powerpc.

Best regards,
Jinjie

> 
> Jinjie, will it be possible for you to include the above patch in this
> patch series?

My pleasure.

>>           if (ret) {
>>               pr_err("Failed to remove hot-unplugged memory from crash
>> memory ranges\n");
>> -            goto out;
>> +            return ret;
>>           }
>>       }
>>   -    ret = crash_prepare_elf64_headers(cmem, false, &elfbuf, &elfsz);
>> +    return 0;
>> +}
>> +
>> +/**
>> + * update_crash_elfcorehdr() - Recreate the elfcorehdr and replace it
>> with old
>> + *                   elfcorehdr in the kexec segment array.
>> + * @image: the active struct kimage
>> + * @mn: struct memory_notify data handler
>> + */
>> +static void update_crash_elfcorehdr(struct kimage *image, struct
>> memory_notify *mn)
>> +{
>> +    void *ptr, *mem, *elfbuf = NULL;
>> +    struct kexec_segment *ksegment;
>> +    unsigned long elfsz, memsz;
>> +    int ret;
>> +
>> +    ksegment = &image->segment[image->elfcorehdr_index];
>> +    mem = (void *) ksegment->mem;
>> +    memsz = ksegment->memsz;
>> +
>> +    ret = crash_prepare_elf64_headers(false, &elfbuf, &elfsz, NULL,
>> image, mn);
>>       if (ret) {
>>           pr_err("Failed to prepare elf header\n");
>>           goto out;
>> @@ -486,7 +497,6 @@ static void update_crash_elfcorehdr(struct kimage
>> *image, struct memory_notify *
>>           xchg(&kexec_crash_image, image);
>>       }
>>   out:
>> -    kvfree(cmem);
>>       kvfree(elfbuf);
>>   }

[...]

>> +int crash_prepare_elf64_headers(int need_kernel_map, void **addr,
>> +                unsigned long *sz, unsigned long *nr_mem_ranges,
>> +                struct kimage *image, struct memory_notify *mn)
>>   {
>> -    Elf64_Ehdr *ehdr;
>> -    Elf64_Phdr *phdr;
>>       unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
>> -    unsigned char *buf;
>> -    unsigned int cpu, i;
>>       unsigned long long notes_addr;
>> +    struct crash_mem *mem = NULL;
>>       unsigned long mstart, mend;
>> +    unsigned int cpu, i;
>> +    unsigned char *buf;
>> +    Elf64_Ehdr *ehdr;
>> +    Elf64_Phdr *phdr;
>> +    int ret = 0;
>> +
>> +    ret = arch_get_crash_memory_ranges(&mem, nr_mem_ranges, image, mn);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (mem) {
>> +        ret = crash_exclude_mem_ranges(mem, nr_mem_ranges);
>> +        if (ret)
>> +            goto out;
>> +    }
>>         /* extra phdr for vmcoreinfo ELF note */
>>       nr_phdr = nr_cpus + 1;
>> @@ -192,8 +240,10 @@ int crash_prepare_elf64_headers(struct crash_mem
>> *mem, int need_kernel_map,
>>       elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
>>         buf = vzalloc(elf_sz);
>> -    if (!buf)
>> -        return -ENOMEM;
>> +    if (!buf) {
>> +        ret = -ENOMEM;
>> +        goto out;
>> +    }
>>         ehdr = (Elf64_Ehdr *)buf;
>>       phdr = (Elf64_Phdr *)(ehdr + 1);
>> @@ -262,7 +312,10 @@ int crash_prepare_elf64_headers(struct crash_mem
>> *mem, int need_kernel_map,
>>         *addr = buf;
>>       *sz = elf_sz;
>> -    return 0;
>> +
>> +out:
>> +    kvfree(mem);
>> +    return ret;
>>   }
>>     /**
> 


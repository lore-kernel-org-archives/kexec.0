Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1872C02182
	for <kexec@archiver.kernel.org>; Thu, 23 Jan 2025 11:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zYqQJ0RlScW1AWoz1ZDTT9p8Jxg1S0uJj18dKwChOVA=; b=XKFxfi18RTBC+3BpeoJB+x3KG5
	L/pZ8cTwBvpFSFyttVrHgB7cTYnX/SKuXKWM7IDjQyatHxEtd3eb5fi2uH0yTjOLUVKrBUMS4RAgQ
	h8BOCc01RNlbEOFTKKl/N1fhaJxJOpKXE8PXJfTG3uIEBm51dUS29SF9aL9H9ny0LblGTb8SJhbry
	Vc8+Q/1kgpRtbUjyAbWaqNrhM1QQ+mkR+oytAlOezLRBJSIeDUx/N20pBln6EzK9ObNO9MMW7Y9po
	cB/m9YTfgpgUFH1fs3Ae/xyQAcOdDJnohZx5Loz9WmFA6cV0fhfgXNHdJEeKcG7/Fayi0Z2HLahuk
	2A0juxrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tavnK-0000000COiD-132C;
	Thu, 23 Jan 2025 11:54:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tavlu-0000000COZ7-471T
	for kexec@lists.infradead.org;
	Thu, 23 Jan 2025 11:53:20 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N2Eprd016750;
	Thu, 23 Jan 2025 11:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zYqQJ0
	RlScW1AWoz1ZDTT9p8Jxg1S0uJj18dKwChOVA=; b=Ir36ju4rmfKT0IOBQHvOzK
	9KX9gTl89njzpfaypAtUtOGUuJo1IvDv26jJJwJhjW1vDeXhoK3aJTAkcAQt7RNE
	q/qddu1nrQE+jA8TeQTazWJo2AuJ6utPqc1FRFhXSo65S2UayF1MY4szPE7IzKxM
	x3BXnguvIcgFia5IjKD1bNTJIJNVIb5NXvZ3VAlJUB/26pdxwXqpudD+R2Cbh/F/
	mj5x/2m8Ts95NcyQNuqexjWY3u7vxsIB43OZcVNN62QcLd47he24zB3OFj4+A/Eq
	n5VDIf+JwW88HfxOeFTYmz+lxUA051MPxfMLsMLh7ilWLkE91eRKv/1UYfsN4ELQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44b3gtvtys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 11:53:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50N8P696032223;
	Thu, 23 Jan 2025 11:53:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448rujw0xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 11:53:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NBr7UQ20709858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 11:53:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D7262004B;
	Thu, 23 Jan 2025 11:53:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 502FE20040;
	Thu, 23 Jan 2025 11:53:05 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 11:53:05 +0000 (GMT)
Message-ID: <10b22e23-7865-424d-95d2-eeab366e7cc3@linux.ibm.com>
Date: Thu, 23 Jan 2025 17:23:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] powerpc/crash: use generic crashkernel reservation
To: Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>
References: <20250121115442.1278458-1-sourabhjain@linux.ibm.com>
 <20250121115442.1278458-6-sourabhjain@linux.ibm.com>
 <79ecc981-f2ac-44b0-8e36-70e9d01df3ba@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <79ecc981-f2ac-44b0-8e36-70e9d01df3ba@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UKHgEB5IDP49E_JYhgJ71iMuNxcZGXEp
X-Proofpoint-GUID: UKHgEB5IDP49E_JYhgJ71iMuNxcZGXEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_05,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_035319_148884_DF6E800B 
X-CRM114-Status: GOOD (  33.64  )
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

Hello Hari,


On 23/01/25 16:15, Hari Bathini wrote:
> Hi Sourabh,
>
> On 21/01/25 5:24 pm, Sourabh Jain wrote:
>> Commit 0ab97169aa05 ("crash_core: add generic function to do
>> reservation") added a generic function to reserve crashkernel memory.
>> So let's use the same function on powerpc and remove the
>> architecture-specific code that essentially does the same thing.
>>
>> The generic crashkernel reservation also provides a way to split the
>> crashkernel reservation into high and low memory reservations, which can
>> be enabled for powerpc in the future.
>>
>> Along with moving to the generic crashkernel reservation, the code
>> related to finding the base address for the crashkernel has been
>> separated into its own function name get_crash_base() for better
>> readability and maintainability.
>>
>> To prevent crashkernel memory from being added to iomem_resource, the
>> function arch_add_crash_res_to_iomem() has been introduced. For further
>> details on why this should not be done for the PowerPC architecture,
>> please refer to the previous commit titled "crash: let arch decide crash
>> memory export to iomem_resource.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan he <bhe@redhat.com>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> CC: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: kexec@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/Kconfig                     |  3 +
>>   arch/powerpc/include/asm/crash_reserve.h | 18 +++++
>>   arch/powerpc/include/asm/kexec.h         |  4 +-
>>   arch/powerpc/kernel/prom.c               |  2 +-
>>   arch/powerpc/kexec/core.c                | 90 ++++++++++--------------
>>   5 files changed, 63 insertions(+), 54 deletions(-)
>>   create mode 100644 arch/powerpc/include/asm/crash_reserve.h
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index db9f7b2d07bf..880d35fadf40 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -718,6 +718,9 @@ config ARCH_SUPPORTS_CRASH_HOTPLUG
>>       def_bool y
>>       depends on PPC64
>>   +config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>> +    def_bool CRASH_RESERVE
>> +
>>   config FA_DUMP
>>       bool "Firmware-assisted dump"
>>       depends on CRASH_DUMP && PPC64 && (PPC_RTAS || PPC_POWERNV)
>> diff --git a/arch/powerpc/include/asm/crash_reserve.h 
>> b/arch/powerpc/include/asm/crash_reserve.h
>> new file mode 100644
>> index 000000000000..f5e60721de41
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/crash_reserve.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_POWERPC_CRASH_RESERVE_H
>> +#define _ASM_POWERPC_CRASH_RESERVE_H
>> +
>> +/* crash kernel regions are Page size agliged */
>> +#define CRASH_ALIGN             PAGE_SIZE
>> +
>> +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>> +
>
>> +static inline bool arch_add_crash_res_to_iomem(void)
>> +{
>> +    return false;
>> +}
>> +#define arch_add_crash_res_to_iomem arch_add_crash_res_to_iomem
>
> This is probably not needed if commit c40dd2f766440 can be reverted.
> Othewise..

Agree. Since I am reverting c40dd2f766440 in next series so I will the 
above change.

>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>

Thanks for the Ack!

- Sourabh Jain


>
>> +#endif
>> +
>> +#endif /* _ASM_POWERPC_CRASH_RESERVE_H */
>> +
>> diff --git a/arch/powerpc/include/asm/kexec.h 
>> b/arch/powerpc/include/asm/kexec.h
>> index 270ee93a0f7d..64741558071f 100644
>> --- a/arch/powerpc/include/asm/kexec.h
>> +++ b/arch/powerpc/include/asm/kexec.h
>> @@ -113,9 +113,9 @@ int setup_new_fdt_ppc64(const struct kimage 
>> *image, void *fdt, struct crash_mem
>>     #ifdef CONFIG_CRASH_RESERVE
>>   int __init overlaps_crashkernel(unsigned long start, unsigned long 
>> size);
>> -extern void reserve_crashkernel(void);
>> +extern void arch_reserve_crashkernel(void);
>>   #else
>> -static inline void reserve_crashkernel(void) {}
>> +static inline void arch_reserve_crashkernel(void) {}
>>   static inline int overlaps_crashkernel(unsigned long start, 
>> unsigned long size) { return 0; }
>>   #endif
>>   diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index e0059842a1c6..9ed9dde7d231 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -860,7 +860,7 @@ void __init early_init_devtree(void *params)
>>        */
>>       if (fadump_reserve_mem() == 0)
>>   #endif
>> -        reserve_crashkernel();
>> +        arch_reserve_crashkernel();
>>       early_reserve_mem();
>>         if (memory_limit > memblock_phys_mem_size())
>> diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
>> index 4945b33322ae..b21cfa814492 100644
>> --- a/arch/powerpc/kexec/core.c
>> +++ b/arch/powerpc/kexec/core.c
>> @@ -80,38 +80,20 @@ void machine_kexec(struct kimage *image)
>>   }
>>     #ifdef CONFIG_CRASH_RESERVE
>> -void __init reserve_crashkernel(void)
>> -{
>> -    unsigned long long crash_size, crash_base, total_mem_sz;
>> -    int ret;
>>   -    total_mem_sz = memory_limit ? memory_limit : 
>> memblock_phys_mem_size();
>> -    /* use common parsing */
>> -    ret = parse_crashkernel(boot_command_line, total_mem_sz,
>> -            &crash_size, &crash_base, NULL, NULL);
>> -    if (ret == 0 && crash_size > 0) {
>> -        crashk_res.start = crash_base;
>> -        crashk_res.end = crash_base + crash_size - 1;
>> -    }
>> -
>> -    if (crashk_res.end == crashk_res.start) {
>> -        crashk_res.start = crashk_res.end = 0;
>> -        return;
>> -    }
>> -
>> -    /* We might have got these values via the command line or the
>> -     * device tree, either way sanitise them now. */
>> -
>> -    crash_size = resource_size(&crashk_res);
>> +static unsigned long long __init get_crash_base(unsigned long long 
>> crash_base)
>> +{
>>     #ifndef CONFIG_NONSTATIC_KERNEL
>> -    if (crashk_res.start != KDUMP_KERNELBASE)
>> +    if (crash_base != KDUMP_KERNELBASE)
>>           printk("Crash kernel location must be 0x%x\n",
>>                   KDUMP_KERNELBASE);
>>   -    crashk_res.start = KDUMP_KERNELBASE;
>> +    return KDUMP_KERNELBASE;
>>   #else
>> -    if (!crashk_res.start) {
>> +    unsigned long long crash_base_align;
>> +
>> +    if (!crash_base) {
>>   #ifdef CONFIG_PPC64
>>           /*
>>            * On the LPAR platform place the crash kernel to mid of
>> @@ -123,45 +105,51 @@ void __init reserve_crashkernel(void)
>>            * kernel starts at 128MB offset on other platforms.
>>            */
>>           if (firmware_has_feature(FW_FEATURE_LPAR))
>> -            crashk_res.start = min_t(u64, ppc64_rma_size / 2, SZ_512M);
>> +            crash_base = min_t(u64, ppc64_rma_size / 2, SZ_512M);
>>           else
>> -            crashk_res.start = min_t(u64, ppc64_rma_size / 2, SZ_128M);
>> +            crash_base = min_t(u64, ppc64_rma_size / 2, SZ_128M);
>>   #else
>> -        crashk_res.start = KDUMP_KERNELBASE;
>> +        crash_base = KDUMP_KERNELBASE;
>>   #endif
>>       }
>>   -    crash_base = PAGE_ALIGN(crashk_res.start);
>> -    if (crash_base != crashk_res.start) {
>> -        printk("Crash kernel base must be aligned to 0x%lx\n",
>> -                PAGE_SIZE);
>> -        crashk_res.start = crash_base;
>> -    }
>> +    crash_base_align = PAGE_ALIGN(crash_base);
>> +    if (crash_base != crash_base_align)
>> +        pr_warn("Crash kernel base must be aligned to 0x%lx\n", 
>> PAGE_SIZE);
>>   +    return crash_base_align;
>>   #endif
>> -    crash_size = PAGE_ALIGN(crash_size);
>> -    crashk_res.end = crashk_res.start + crash_size - 1;
>> +}
>>   -    /* The crash region must not overlap the current kernel */
>> -    if (overlaps_crashkernel(__pa(_stext), _end - _stext)) {
>> -        printk(KERN_WARNING
>> -            "Crash kernel can not overlap current kernel\n");
>> -        crashk_res.start = crashk_res.end = 0;
>> +void __init arch_reserve_crashkernel(void)
>> +{
>> +    unsigned long long crash_size, crash_base, crash_end;
>> +    unsigned long long kernel_start, kernel_size;
>> +    unsigned long long total_mem_sz;
>> +    int ret;
>> +
>> +    total_mem_sz = memory_limit ? memory_limit : 
>> memblock_phys_mem_size();
>> +
>> +    /* use common parsing */
>> +    ret = parse_crashkernel(boot_command_line, total_mem_sz, 
>> &crash_size,
>> +                &crash_base, NULL, NULL);
>> +
>> +    if (ret)
>>           return;
>> -    }
>>   -    printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
>> -            "for crashkernel (System RAM: %ldMB)\n",
>> -            (unsigned long)(crash_size >> 20),
>> -            (unsigned long)(crashk_res.start >> 20),
>> -            (unsigned long)(total_mem_sz >> 20));
>> +    crash_base = get_crash_base(crash_base);
>> +    crash_end = crash_base + crash_size - 1;
>>   -    if (!memblock_is_region_memory(crashk_res.start, crash_size) ||
>> -        memblock_reserve(crashk_res.start, crash_size)) {
>> -        pr_err("Failed to reserve memory for crashkernel!\n");
>> -        crashk_res.start = crashk_res.end = 0;
>> +    kernel_start = __pa(_stext);
>> +    kernel_size = _end - _stext;
>> +
>> +    /* The crash region must not overlap the current kernel */
>> +    if ((kernel_start + kernel_size > crash_base) && (kernel_start 
>> <= crash_end)) {
>> +        pr_warn("Crash kernel can not overlap current kernel\n");
>>           return;
>>       }
>> +
>> +    reserve_crashkernel_generic(crash_size, crash_base, 0, false);
>>   }
>>     int __init overlaps_crashkernel(unsigned long start, unsigned 
>> long size)
>



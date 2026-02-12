Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D06CFD5311
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 08:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ojMHV+TxP6e3FLHmg8fIJfthetl5cVOWSrR8HU/Rc/I=; b=LFXRfTo3BwF+9UPanO/EjTXJ6O
	RH7/ZzyqRkr8UNNVmdr9Kt2Nd8hU6qW3B1g/VhP6c5JvWRz0+h87W7tVT7EMql4klXD/TwmSFHXE7
	fmGjQIHpsUvEovZj6lFRPZUWuRSMk+Ol6EbqnM3utIOmlu8C3DZrSKQSrZG9qvm2l92/mQzPemFle
	aWF4OZs6+5nSzHFOUFS7AKDnBbjWIYG7Nwizo5GvwpQYImUWtggU/7LvpTPv1DfjpKUZM3rPgbM+8
	mKu15VfePW0k09EVP0XhpMt9s8UO5xC5c0xNFaEmpmbdqOaXRXf6U6Aq9GkbCBQLwPHzlaFZJMb99
	t+eerDew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvtN9-000000080MU-37UY;
	Fri, 27 Feb 2026 08:38:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqPyG-00000001fxU-3KE1;
	Thu, 12 Feb 2026 06:14:38 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BFYKsD369791;
	Thu, 12 Feb 2026 06:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ojMHV+
	TxP6e3FLHmg8fIJfthetl5cVOWSrR8HU/Rc/I=; b=Ey17cf9bfbIHupEH0Z0c42
	ETQ1EmhdoqHoKSr9VFi0UrrqyZJS6bAF0Ir9TUvG4I2MJJMtmzkjctMQjbdkcxws
	E+SUFXx7PkDLaXOQ1yRFQ+7fLoKS3ohJUR2mBqinTC77OsPjA/BlEl+GIE08CQzf
	GCEht20jhHb8NRTGtPBaGMuu1yrIpfjlqp+EfLOZfibFIA+OZ/NUKonPzXKlPZI9
	jtwtCW67v7u9qijheZq0SnfyIwG6aIv9iqOzd0hnzpKrD+G3xTpqneMut937gnyt
	EmfYF/wl62aU6LwgfCrISp3z8VAgHQOnCgBQ80+0+FFjLUdz32zQculJmDG5uS2A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696x24ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 06:11:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61C4ZFKh019251;
	Thu, 12 Feb 2026 06:11:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxk8y2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 06:11:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61C6BKpV15008004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 06:11:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3C1D2004D;
	Thu, 12 Feb 2026 06:11:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9437220040;
	Thu, 12 Feb 2026 06:11:01 +0000 (GMT)
Received: from [9.39.27.166] (unknown [9.39.27.166])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Feb 2026 06:11:01 +0000 (GMT)
Message-ID: <5b6f4093-3ddd-477d-ade4-fe31429cf3cd@linux.ibm.com>
Date: Thu, 12 Feb 2026 11:41:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] crash: Exclude crash kernel memory in crash core
To: Jinjie Ruan <ruanjinjie@huawei.com>, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        rdunlap@infradead.org, pmladek@suse.com, feng.tang@linux.alibaba.com,
        pawan.kumar.gupta@linux.intel.com, kees@kernel.org, elver@google.com,
        arnd@arndb.de, lirongqing@baidu.com, fvdl@google.com,
        leitao@debian.org, rppt@kernel.org, ardb@kernel.org, jbohac@suse.cz,
        osandov@fb.com, ryan.roberts@arm.com, cfsworks@gmail.com,
        tangyouling@kylinos.cn, ritesh.list@gmail.com, thuth@redhat.com,
        hbathini@linux.ibm.com, eajames@linux.ibm.com, bjorn@rivosinc.com,
        songshuaishuai@tinylab.org, kevin.brodsky@arm.com,
        samuel.holland@sifive.com, vishal.moola@gmail.com,
        junhui.liu@pigmoral.tech, dwmw@amazon.co.uk, pbonzini@redhat.com,
        thomas.lendacky@amd.com, kai.huang@intel.com, ubizjak@gmail.com,
        coxu@redhat.com, liaoyuanhong@vivo.com, fuqiang.wang@easystack.cn,
        brgerst@gmail.com, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org
References: <20260209095931.2813152-1-ruanjinjie@huawei.com>
 <20260209095931.2813152-2-ruanjinjie@huawei.com>
 <50693f0c-c610-4347-86aa-40d50dc681fc@linux.ibm.com>
 <31c2ae53-cbb7-bfad-9b8f-f9e1a254491e@huawei.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <31c2ae53-cbb7-bfad-9b8f-f9e1a254491e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698d6f0e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=i0EeH86SAAAA:8 a=B_ciY6P1UxUjS-fdd_UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pPQWyo0dBerxEXBQvX-fWAqozUfKAgMU
X-Proofpoint-ORIG-GUID: NJnrqqmFwVChV0NJpqnRbaDGJlc_JaK5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDAzOSBTYWx0ZWRfX3ttwUOBSfW6t
 I/8Hz+DYXVvSSlj/G1NDONhkkFRDOcWcVU8ZWOdCaeQiSqDBoTdIv6+Tc99oUe5HVGftG7lRYeC
 51L9B6eK/zNvaD/TOWeehy7QYHzeOiC8KMMJKPPTR3Xt2B9vcK5BU+o/qLnzLcsSVlo9cZKimqz
 ulVMaPptKVRdY0bjVlTsSHPmhipS7GGPPQoUCKIsYkLSiKIsscPzVZcXkXBlJu93n5DUvZoJgFa
 eO2d6xI6jWJjuPHEG3c3eWKO5rkBYYfOhsQsl9iZouncmrOlkxuxUDiENFvM/CV/MmDZRRhmJfY
 dzsY0+TnQ9Et6vmgImq7ts8pYMkZlJvhVf9ksKIhh6xagoBwd+qGyH+7OQxKgLGqkPIp27VeuSs
 IHivRppL66tOv1wzzSnPdFaTvaoVdda7zpGiTmfzC6304JgPWIwVr5IoU/c2X9EH91PGbdFawpf
 cKNP0JormcRl9vWEjdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_01,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_221436_967848_CDA1F668 
X-CRM114-Status: GOOD (  29.69  )
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



On 12/02/26 08:58, Jinjie Ruan wrote:
>
> On 2026/2/10 20:30, Sourabh Jain wrote:
>> Hello Jinjie,
>>
>> On 09/02/26 15:29, Jinjie Ruan wrote:
>>> The exclude of crashk_res, crashk_low_res and crashk_cma memory
>>> are almost identical across different architectures, handling them
>>> in the crash core would eliminate a lot of duplication, so do
>>> them in the common code.
>>>
>>> And move the size calculation (and the realloc if needed) into the
>>> generic crash core so that:
>>>
>>> - New CMA regions or future crash-memory types can automatically
>>>     accounted for in crash core;
>>>
>>> - Each architecture no longer has to play whack-a-mole with
>>>     its private array size.
>>>
>>> To achieve the above goal, 4 architecture-specific functions are
>>> introduced:
>>>
>>> - arch_get_system_nr_ranges() and arch_prepare_elf64_ram_headers().
>>>     The 1st function pre-counts the number of memory ranges, and
>>>     the 2st function fill the memory ranges into the cmem->ranges[] array,
>>>     and count the actual number of ranges filled. The default
>>> implementation
>>>     is consistent with arm64 and loongson.
>>>
>>> - arch_crash_exclude_mem_range(). Realloc for powerpc. The default
>>>     implementation is crash_exclude_mem_range(), and use
>>>     crash_exclude_mem_range_guarded() to implement the arch version
>>>     for powerpc.
>>>
>>> - arch_get_crash_memory_ranges(). Get crash memory ranges for arch and
>>>     the default implementation is generic across x86, arm64, riscv, and
>>>     loongson by using the first two arch functions above. powerpc has its
>>>     own implementation by calling get_crash_memory_ranges().
>>>
>>> Tested on x86, arm64 and riscv with QEMU.
>>>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>    arch/arm64/kernel/machine_kexec_file.c     |  47 +--------
>>>    arch/loongarch/kernel/machine_kexec_file.c |  45 +-------
>>>    arch/powerpc/include/asm/kexec.h           |  13 +++
>>>    arch/powerpc/kexec/crash.c                 |  52 ++++++----
>>>    arch/powerpc/kexec/file_load_64.c          |  17 ++-
>>>    arch/powerpc/kexec/ranges.c                |  18 +---
>>>    arch/riscv/include/asm/kexec.h             |  10 ++
>>>    arch/riscv/kernel/machine_kexec_file.c     |  37 ++-----
>>>    arch/x86/include/asm/kexec.h               |  10 ++
>>>    arch/x86/kernel/crash.c                    | 104 ++-----------------
>>>    include/linux/crash_core.h                 | 114 +++++++++++++++++++--
>>>    kernel/crash_core.c                        |  71 +++++++++++--
>>>    12 files changed, 269 insertions(+), 269 deletions(-)
>>>
> [...]
>
>>>    extern void crash_ipi_callback(struct pt_regs *regs);
>>> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
>>> index a325c1c02f96..5ade9a853fb0 100644
>>> --- a/arch/powerpc/kexec/crash.c
>>> +++ b/arch/powerpc/kexec/crash.c
>>> @@ -419,30 +419,21 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>>>        return sizeof(struct elfhdr) + (phdr_cnt * sizeof(Elf64_Phdr));
>>>    }
>>>    -/**
>>> - * update_crash_elfcorehdr() - Recreate the elfcorehdr and replace it
>>> with old
>>> - *                   elfcorehdr in the kexec segment array.
>>> - * @image: the active struct kimage
>>> - * @mn: struct memory_notify data handler
>>> - */
>>> -static void update_crash_elfcorehdr(struct kimage *image, struct
>>> memory_notify *mn)
>>> +int arch_get_crash_memory_ranges(struct crash_mem **cmem, unsigned
>>> long *nr_mem_ranges,
>>> +                 struct kimage *image, struct memory_notify *mn)
>>>    {
>>> +    unsigned long base_addr, size;
>>>        int ret;
>>> -    struct crash_mem *cmem = NULL;
>>> -    struct kexec_segment *ksegment;
>>> -    void *ptr, *mem, *elfbuf = NULL;
>>> -    unsigned long elfsz, memsz, base_addr, size;
>>>    -    ksegment = &image->segment[image->elfcorehdr_index];
>>> -    mem = (void *) ksegment->mem;
>>> -    memsz = ksegment->memsz;
>>> -
>>> -    ret = get_crash_memory_ranges(&cmem);
>>> +    ret = get_crash_memory_ranges(cmem);
>>>        if (ret) {
>>>            pr_err("Failed to get crash mem range\n");
>>> -        return;
>>> +        return ret;
>>>        }
>>>    +    if (!image || !mn)
>>> +        return 0;
>>> +
>>>        /*
>>>         * The hot unplugged memory is part of crash memory ranges,
>>>         * remove it here.
>>> @@ -450,14 +441,34 @@ static void update_crash_elfcorehdr(struct
>>> kimage *image, struct memory_notify *
>>>        if (image->hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY) {
>>>            base_addr = PFN_PHYS(mn->start_pfn);
>>>            size = mn->nr_pages * PAGE_SIZE;
>>> -        ret = remove_mem_range(&cmem, base_addr, size);
>>> +        ret = remove_mem_range(cmem, base_addr, size);
>> I like the overall design for handling crashkernel memory exclusion
>> in this patch series, especially the way you managed to free the
>> crash_mem object (mem) in the generic code (crash_prepare_elf64_headers()).
> Thanks for the review.
>
>> However, the way crash memory is prepared after a memory hotplug
>> event on powerpc by calling remove_mem_range(), can leave the crash
>> memory ranges unsorted. This can cause issues in the generic code
>> when excluding crashkernel memory, because crash_exclude_mem_range()
>> expects crash_mem to be sorted.
> You are absolutely correct.
>
>> So I wrote a simple patch to cover this scenario. Including the
>> patch below as the first patch in this series would be helpful.
>> https://lore.kernel.org/all/20260210120803.433978-1-sourabhjain@linux.ibm.com/
> Thanks for the additional patch. I'll add it as the first patch in the
> next revision to ensure crash_mem remains sorted after memory hotplug
> events on powerpc.

Thanks you.

Please use the latest version (v2) available here:
https://lore.kernel.org/all/20260212060159.733023-1-sourabhjain@linux.ibm.com/

Regards,
Sourabh Jain



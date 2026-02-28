Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C0BFD005C
	for <kexec@archiver.kernel.org>; Sun,  1 Mar 2026 11:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e3h6lKPADkarDnV9tMxKLLerzBFFSfZGDUJSV7g45+k=; b=FWLVE9JjQo1WlO8+3qJwHKIBBN
	fmJIz08vNhSMFVQewYyjX1iFYTPX0MGb3YjfW2PtnC4DoLMvcZsTFbBKS//75OXSNKpc5PIpweUWR
	vwreaAHkf/btAR1cSG97Z4kVpSpQ9B0cII+GP1THcC7nk3B+U8NgBRtI11/Q3Z/+TD45oR+A4ddnj
	Yri4caFafQkqf6Ejgh2adS8LfUOenZ9zj/EOD5fKrlp3CKdh055zLgq/DPNTE+/CejvBbb5370Aw+
	aDsNUCd7Y/o4qAKNOl2bJgfXL2lf1Cnbyn3zAX5RoXBSqRmTgEeUDq51vX1TVFUM/8+VKf/usHlQX
	vblCZkqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwfQO-0000000B5FR-3O5s;
	Sun, 01 Mar 2026 11:57:28 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwK4B-00000009qvF-2SiC;
	Sat, 28 Feb 2026 13:09:08 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61S8lkMb2447252;
	Sat, 28 Feb 2026 13:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e3h6lK
	PADkarDnV9tMxKLLerzBFFSfZGDUJSV7g45+k=; b=Hk0p4k/6smPydLZ9oUzc20
	aNTzGjk1n/5sgfK0KV4ceX9Dm6YdaNab5b1xrnIszlnopxp+JuFjIuM4KxxW2b5U
	g4Te7MHDdwLeRg1DOwpHofxhauRWgj/IGpkdZMt+xF/8spsQoq+vYFcXCX/Uc4AF
	//BBJN0zoOPhizc3V1fVdyHvI2kPKjxQrA0Ihf44i4KIRnJa1rCS/8l2887pLJEm
	kn52QT4bWE0Mo6EWHldILKR39ExM+V63Ytbcz5lJOw0wanVZr0VVULqjuqbHSYI3
	ylroQUGK5swb/FPlIkCy3wGLjHl2NC1+MT3VSz9iGV/pIks7OMaQTrpjHOxLZ8sw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrhrwsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Feb 2026 13:08:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61SAMWO5013438;
	Sat, 28 Feb 2026 13:08:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdypsva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Feb 2026 13:08:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61SD8GuF57278852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Feb 2026 13:08:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C9A920040;
	Sat, 28 Feb 2026 13:08:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D495B20043;
	Sat, 28 Feb 2026 13:07:57 +0000 (GMT)
Received: from [9.124.209.149] (unknown [9.124.209.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 28 Feb 2026 13:07:57 +0000 (GMT)
Message-ID: <c20e22cd-e1bf-4993-9ee8-bce62a5c0879@linux.ibm.com>
Date: Sat, 28 Feb 2026 18:37:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] crash: Use crash_exclude_core_ranges() on powerpc
To: Jinjie Ruan <ruanjinjie@huawei.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
        saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, pmladek@suse.com,
        rdunlap@infradead.org, dapeng1.mi@linux.intel.com, kees@kernel.org,
        paulmck@kernel.org, lirongqing@baidu.com, arnd@arndb.de,
        rppt@kernel.org, ardb@kernel.org, leitao@debian.org, jbohac@suse.cz,
        cfsworks@gmail.com, ryan.roberts@arm.com, tangyouling@kylinos.cn,
        ritesh.list@gmail.com, hbathini@linux.ibm.com, eajames@linux.ibm.com,
        songshuaishuai@tinylab.org, samuel.holland@sifive.com,
        kevin.brodsky@arm.com, vishal.moola@gmail.com,
        junhui.liu@pigmoral.tech, coxu@redhat.com, liaoyuanhong@vivo.com,
        brgerst@gmail.com, fuqiang.wang@easystack.cn, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, kexec@lists.infradead.org
References: <20260226130437.1867658-1-ruanjinjie@huawei.com>
 <20260226130437.1867658-4-ruanjinjie@huawei.com>
 <3576865b-65bd-4289-babc-975a543eb775@linux.ibm.com>
 <0a776b5f-5a88-2c71-7305-d30d9240c2cb@huawei.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <0a776b5f-5a88-2c71-7305-d30d9240c2cb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a2e8c6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=i0EeH86SAAAA:8 a=SqbkEvhUw2NNNf05Xa8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDEyMSBTYWx0ZWRfX071lBZNc4yPs
 a+VvK7FC4ZLJ83ujFSxE4qKrT2im2H45r5MaQT28kHvEJTqd6pJVaAyuSjQ3NuM6wUa0qEH2alF
 P1jCkPqkp6CqN0DKLbWKVk21rKn8njj0UZAYJeaU8TzE/4SPRd0l4Zs1QS7ZiiOL/7qs3FoMu6G
 5csaG6FOvpwfilpgha8+Qro/2ZkMmOh4FsC3nEWvKPC+6uws9ppkA2uxtJuI7qYY4767PsvsYoF
 EsF4NUtz447QS7ih5aGhLRWxZs0pYsfIx4JJJmsUkfBQZzN4/aNXD+3Qe9CGx4E+D7TcSZtBXEI
 XFXUL1muBf1u/clq8TG8N1+SmISXqsyGVdsRfh4SMvQngoVyIAT0YOagP6M0o6qk6U4uLYL2oHz
 3Abjnl6QdWdZlzi3KOhcXYOhHL66mqa0R9Vsau62cBWDsTUfJyfY4QGts602vgdSDGI5+I3b7Rt
 tTiPIRyq15vMDpnE3VQ==
X-Proofpoint-GUID: VU3eDeJEliDLLLNFpw6e5qki7AdYAUd0
X-Proofpoint-ORIG-GUID: qiO9pP1xveZBu3XCkKWBR8dO855n6A-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602280121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260228_050907_641758_147BF5A1 
X-CRM114-Status: GOOD (  20.01  )
X-Mailman-Approved-At: Sun, 01 Mar 2026 03:57:27 -0800
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



On 28/02/26 06:51, Jinjie Ruan wrote:
>
> On 2026/2/27 22:50, Sourabh Jain wrote:
>> Resend of:
>> https://lore.kernel.org/all/19cf18b5-362d-4ff2-8b85-e2e72809250c@linux.ibm.com/
>>
>> On 26/02/26 18:34, Jinjie Ruan wrote:
>>> The crash memory exclude of crashk_res and crashk_cma memory on powerpc
>>> are almost identical to the generic crash_exclude_core_ranges().
>>>
>>> By introducing the architecture-specific arch_crash_exclude_mem_range()
>>> function with a default implementation of crash_exclude_mem_range(),
>>> and using crash_exclude_mem_range_guarded as powerpc's separate
>>> implementation, the generic crash_exclude_core_ranges() helper function
>>> can be reused.
>>>
>>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>    arch/powerpc/kexec/ranges.c | 16 ++++------------
>>>    include/linux/crash_core.h  |  4 ++++
>>>    kernel/crash_core.c         | 19 +++++++++++++------
>>>    3 files changed, 21 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
>>> index 6c58bcc3e130..e5fea23b191b 100644
>>> --- a/arch/powerpc/kexec/ranges.c
>>> +++ b/arch/powerpc/kexec/ranges.c
>>> @@ -553,9 +553,9 @@ int get_usable_memory_ranges(struct crash_mem
>>> **mem_ranges)
>>>    #endif /* CONFIG_KEXEC_FILE */
>>>      #ifdef CONFIG_CRASH_DUMP
>>> -int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
>>> -                       unsigned long long mstart,
>>> -                       unsigned long long mend)
>>> +int arch_crash_exclude_mem_range(struct crash_mem **mem_ranges,
>>> +                 unsigned long long mstart,
>>> +                 unsigned long long mend)
>>
>> update_crash_elfcorehdr() in arch/powerpc/kexec/crash.c still calls
>> crash_exclude_mem_range_guarded(), causing a build failure.
>>
>> ld: arch/powerpc/kexec/crash.o: in function `update_crash_elfcorehdr':
>> /root/linux/arch/powerpc/kexec/crash.c:454: undefined reference to
>> `crash_exclude_mem_range_guarded'
>>
>>
>> To fix this:
>> --------------
>> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
>> index 898742a5205c..e59e909c369d 100644
>> --- a/arch/powerpc/kexec/crash.c
>> +++ b/arch/powerpc/kexec/crash.c
>> @@ -451,7 +451,7 @@ static void update_crash_elfcorehdr(struct kimage
>> *image, struct memory_notify *
>>                  base_addr = PFN_PHYS(mn->start_pfn);
>>                  size = mn->nr_pages * PAGE_SIZE;
>>                  end = base_addr + size - 1;
>> -               ret = crash_exclude_mem_range_guarded(&cmem, base_addr,
>> end);
>> +              ret = arch_crash_exclude_mem_range(&cmem, base_addr, end);
>>                  if (ret) {
>>                          pr_err("Failed to remove hot-unplugged memory
>> from crash memory ranges\n");
>>                          goto out;
>>
>> With the above change included, things are working fine on powerpc.
> It seems the declaration of crash_exclude_mem_range_guarded() added in
> arch/powerpc/include/asm/kexec_ranges.h can also be removed.

Yes, lets remove it.

>
>>
>>>    {
>>>        struct crash_mem *tmem = *mem_ranges;
>>>    @@ -604,18 +604,10 @@ int get_crash_memory_ranges(struct crash_mem
>>> **mem_ranges)
>>>                sort_memory_ranges(*mem_ranges, true);
>>>        }
>>>    -    /* Exclude crashkernel region */
>>> -    ret = crash_exclude_mem_range_guarded(mem_ranges,
>>> crashk_res.start, crashk_res.end);
>>> +    ret = crash_exclude_core_ranges(mem_ranges);
>>>        if (ret)
>>>            goto out;
>>>    -    for (i = 0; i < crashk_cma_cnt; ++i) {
>>> -        ret = crash_exclude_mem_range_guarded(mem_ranges,
>>> crashk_cma_ranges[i].start,
>>> -                          crashk_cma_ranges[i].end);
>>> -        if (ret)
>>> -            goto out;
>>> -    }
>>> -
>>>        /*
>>>         * FIXME: For now, stay in parity with kexec-tools but if RTAS/OPAL
>>>         *        regions are exported to save their context at the time of
>>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>>> index 033b20204aca..dbec826dc53b 100644
>>> --- a/include/linux/crash_core.h
>>> +++ b/include/linux/crash_core.h
>>> @@ -68,6 +68,7 @@ extern int crash_prepare_elf64_headers(struct
>>> crash_mem *mem, int need_kernel_ma
>>>                           void **addr, unsigned long *sz);
>>>    extern int crash_prepare_headers(int need_kernel_map, void **addr,
>>>                     unsigned long *sz, unsigned long *nr_mem_ranges);
>>> +extern int crash_exclude_core_ranges(struct crash_mem **cmem);
>>>      struct kimage;
>>>    struct kexec_segment;
>>> @@ -88,6 +89,9 @@ extern int kimage_crash_copy_vmcoreinfo(struct
>>> kimage *image);
>>>    extern unsigned int arch_get_system_nr_ranges(void);
>>>    extern int arch_crash_populate_cmem(struct crash_mem *cmem);
>>>    extern int arch_crash_exclude_ranges(struct crash_mem *cmem);
>>> +extern int arch_crash_exclude_mem_range(struct crash_mem **mem,
>>> +                    unsigned long long mstart,
>>> +                    unsigned long long mend);
>>>      #else /* !CONFIG_CRASH_DUMP*/
>>>    struct pt_regs;
>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>> index 96a96e511f5a..300d44ad5471 100644
>>> --- a/kernel/crash_core.c
>>> +++ b/kernel/crash_core.c
>>> @@ -287,24 +287,31 @@ unsigned int __weak
>>> arch_get_system_nr_ranges(void) { return 0; }
>>>    int __weak arch_crash_populate_cmem(struct crash_mem *cmem) { return
>>> -1; }
>>>    int __weak arch_crash_exclude_ranges(struct crash_mem *cmem) {
>>> return 0; }
>>>    -static int crash_exclude_core_ranges(struct crash_mem *cmem)
>>> +int __weak arch_crash_exclude_mem_range(struct crash_mem **mem,
>>> +                    unsigned long long mstart,
>>> +                    unsigned long long mend)
>>> +{
>>> +    return crash_exclude_mem_range(*mem, mstart, mend);
>>> +}
>>> +
>>> +int crash_exclude_core_ranges(struct crash_mem **cmem)
>>>    {
>>>        int ret, i;
>>>          /* Exclude crashkernel region */
>>> -    ret = crash_exclude_mem_range(cmem, crashk_res.start,
>>> crashk_res.end);
>>> +    ret = arch_crash_exclude_mem_range(cmem, crashk_res.start,
>>> crashk_res.end);
>>>        if (ret)
>>>            return ret;
>>>          if (crashk_low_res.end) {
>>> -        ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
>>> crashk_low_res.end);
>>> +        ret = arch_crash_exclude_mem_range(cmem,
>>> crashk_low_res.start, crashk_low_res.end);
>>>            if (ret)
>>>                return ret;
>>>        }
>>>          for (i = 0; i < crashk_cma_cnt; ++i) {
>>> -        ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
>>> -                          crashk_cma_ranges[i].end);
>>> +        ret = arch_crash_exclude_mem_range(cmem,
>>> crashk_cma_ranges[i].start,
>>> +                           crashk_cma_ranges[i].end);
>>>            if (ret)
>>>                return ret;
>>>        }
>>> @@ -331,7 +338,7 @@ int crash_prepare_headers(int need_kernel_map,
>>> void **addr, unsigned long *sz,
>>>        if (ret)
>>>            goto out;
>>>    -    ret = crash_exclude_core_ranges(cmem);
>>> +    ret = crash_exclude_core_ranges(&cmem);
>>>        if (ret)
>>>            goto out;
>>>    



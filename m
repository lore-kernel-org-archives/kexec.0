Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F207D3941D
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UwLBZY0xAh69HUU4FoGM+gFkY3rpuiGhmJBMb77IXic=; b=3aofRhxuK8+68nVCus780S1nAx
	USVkTRQuivxd1oAL0h0ukO8XAgkqmm1aH61uAs9wESfRDOr1Ycog4lJTMXZTb9pMkTzEGpvQx5zMS
	mJrO+lcbSU+DPbsTRC1XFs4ONncqW+V9c4C42t2jks/AXWdphhg1cm2S3lfv/o59oHauewAYJ8JYt
	ZOjFLTsVPZy6q3+NExxi4jrZtsJQenGOyWErc/hosFrqRJx652CJ+qtG1Vs/NINf3UI6gnFxjqWt+
	N8ngnsIPtg7VcEv+HLziXhrykCiH24qAGyKv/bXxKugVGe7z3IYQsvYz/34fF7sHTmkERjiWD/Qve
	7gsQNkDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HFo-000000003y5-29Ob;
	Thu, 02 Apr 2026 12:34:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4tVH-00000000YLy-0ZZr;
	Tue, 24 Mar 2026 04:36:32 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NNiqj13599991;
	Tue, 24 Mar 2026 04:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UwLBZY
	0xAh69HUU4FoGM+gFkY3rpuiGhmJBMb77IXic=; b=mB9Wv5H1BQQFmjl5i+JJgj
	qn9zW0bW8lQhQu6a9d1rAws2VXcIiQIiTOQ6AbmLb/203lRQvPD4WFheBYcSd+Q4
	k2h/DDlmVJyT9YXLFPfYCF4S1MXTaNoiu1/ZL6QXOqVHf634k5gCN0/b1SQMymjJ
	i3By4hwkn+DB7dhSE4kc1N2nh1lYsNfnu9CB/PIOZOyQxQ97tO4/QTxSSxCAkz9N
	J9SwlOeMwg56JvPu6egjodai8zMXTWZTvoI79/agfx+TOQWbvls2aXuExJkZwdwr
	pHNnfrJ2DEvn0+RIt1yIBqE6TBfZkG3LtmpV2O88ojpBe1d9LnNjDOozNnw7Dcgw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktusa71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 04:30:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62O3hwNd008745;
	Tue, 24 Mar 2026 04:30:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nng532-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 04:30:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62O4U0nh29819348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 04:30:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B60F2004E;
	Tue, 24 Mar 2026 04:30:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC9F32004F;
	Tue, 24 Mar 2026 04:29:47 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 04:29:47 +0000 (GMT)
Message-ID: <595e793d-adc3-4acb-af18-f0a3cf2d5e73@linux.ibm.com>
Date: Tue, 24 Mar 2026 09:59:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/5] arm64/riscv: Add support for crashkernel CMA
 reservation
To: Jinjie Ruan <ruanjinjie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, robh@kernel.org, saravanak@kernel.org, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org,
        peterz@infradead.org, feng.tang@linux.alibaba.com,
        pawan.kumar.gupta@linux.intel.com, dapeng1.mi@linux.intel.com,
        kees@kernel.org, elver@google.com, paulmck@kernel.org,
        lirongqing@baidu.com, safinaskar@gmail.com, rppt@kernel.org,
        ardb@kernel.org, leitao@debian.org, jbohac@suse.cz, cfsworks@gmail.com,
        osandov@fb.com, tangyouling@kylinos.cn, ritesh.list@gmail.com,
        eajames@linux.ibm.com, songshuaishuai@tinylab.org,
        kevin.brodsky@arm.com, samuel.holland@sifive.com,
        vishal.moola@gmail.com, junhui.liu@pigmoral.tech, coxu@redhat.com,
        liaoyuanhong@vivo.com, fuqiang.wang@easystack.cn, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, kexec@lists.infradead.org
References: <20260323072745.2481719-1-ruanjinjie@huawei.com>
 <20260323095548.fa4e13d6e8ae5005ae585e13@linux-foundation.org>
 <4cfde40c-673a-12b0-dfc5-703d582d6ea9@huawei.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <4cfde40c-673a-12b0-dfc5-703d582d6ea9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: yqbo1T1ZaS3NpXm72fU-pbHKExRLmg3o
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c2134e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=i0EeH86SAAAA:8 a=m-v9b-Je9hLO35U8NS8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAzMyBTYWx0ZWRfXzR3+xHlpbmBf
 h/N+fBRudva2vYWP6OptwoTRwOQzk1I8/3wQnvPa8Rt/ZrqSgHhrsvrawZDmpMS0QwmYF43FDLf
 HlCcmZsZgGC9X4WGG+3JZZK+v1BoEcZgoSmWPT7YCzbgc19cK+AUrfnZA/DUdwa/YT8kQD4rVlJ
 +AYgnBwkbmjz7qrae9ZCL552mIuzQ18wgAemKsIkFWdhOLIL4ViVPczjF8UwQTYlK4/5RG8BQ8Q
 tl3FOXuw+eX+JAqN+wSMhGu6UgmoqO7EbJb8S22yBrkRpJwFgdl/rtl8Q0hKyH19wnnthRldQqI
 X/qDqLZ7EhN0SsJ3JFGZ1b1s+r8tmBO0tZUjYSrg9H8a4ceYd1A47+bG1j2tcY2xqcNcb3ffolE
 iJSsS9+xp+U8AIJYdBrf1z4HTVo/7/BmQXix362mLRgyxssrXQT2AO9/MLJgcELw2l/0CYMNHHh
 HrbQML69S4TZV0GnIYA==
X-Proofpoint-GUID: fSy1nmOMAAI_wqT62ef4G42SLgos6nvO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_213631_327520_66E42708 
X-CRM114-Status: GOOD (  23.98  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:24 -0700
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



On 24/03/26 09:32, Jinjie Ruan wrote:
>
> On 2026/3/24 0:55, Andrew Morton wrote:
>> On Mon, 23 Mar 2026 15:27:40 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>>> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
>>> and crashk_cma memory are almost identical across different architectures,
>>> This patch set handle them in crash core in a general way, which eliminate
>>> a lot of duplication code.
>>>
>>> And add support for crashkernel CMA reservation for arm64 and riscv.
>> Thanks.  AI review has completed and it asks questions:
>> 	https://sashiko.dev/#/patchset/20260323072745.2481719-1-ruanjinjie@huawei.com
> I believe it identified 4 valid issues:
>
> - The already discovered crashk_low_res not excluded bug in the existing
> RISC-V code.
>
> - An existing memory leak issue in the existing PowerPC code.

Yes and suggested approach to fix the issue looks good.
Which is basically replace return with goto out.

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 898742a5205c..1426d2099bad 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -440,7 +440,7 @@ static void update_crash_elfcorehdr(struct kimage 
*image, struct memory_notify *
         ret = get_crash_memory_ranges(&cmem);
         if (ret) {
                 pr_err("Failed to get crash mem range\n");
-               return;
+               goto out;
         }

         /*

Are you planning to handle this in this patch series? Or do you want me 
to send a separate fix patch?


>
> - The ordering issue of adding CMA ranges to "linux,usable-memory-range".
>
> - An existing concurrency issue. A Concurrent memory hotplug may occur
> between reading memblock and attempting to fill cmem during kexec_load()
> for almost all existing architectures，I'm not sure if this is a
> practical issue in reality..
>
>   Race Condition Scenario
>
>    Timeline:
>    ---------------------------------------------------------------------
>    T1: kexec_load() syscall starts
>    T2: kexec_trylock() acquires kexec_lock
>    T3: crash_prepare_headers() is called
>    T4: arch_get_system_nr_ranges() queries memblock → finds 100 memory ranges
>    T5: cmem = alloc_cmem(100) allocates buffer for 100 ranges
>    T6: [RACE WINDOW] Another process triggers memory hotplug
>    T7: add_memory() → lock_device_hotplug() → memblock_add_node()
>    T8: New memory region added to memblock
>    T9: arch_crash_populate_cmem() iterates: now finds 102 ranges
>    T10: cmem->ranges[100] → OUT OF BOUNDS WRITE!
>    T11: cmem->ranges[101] → OUT OF BOUNDS WRITE!
>    T12: Kernel crash or memory corruption
>
>    Why This Happens
>
>    1. Different locks used:
>      - kexec_load() uses kexec_trylock (atomic_t)
>      - Memory hotplug uses device_hotplug_lock (mutex)
>    2. No synchronization between these two operations
>    3. Time-of-check to time-of-use (TOCTOU) issue:
>      - Step T4-T5: We query the number of ranges and allocate buffer
>      - Step T6-T9: Memory hotplug adds new ranges between query and
> population
>
>
>
> Any comments or suggestions on the following approach?
>
>
> int crash_prepare_headers(...)
>    {
>        unsigned int max_nr_ranges;
>        struct crash_mem *cmem;
>        int ret;
>
>        lock_device_hotplug();
>
>        max_nr_ranges = arch_get_system_nr_ranges();
>        // ...
>        ret = arch_crash_populate_cmem(cmem);
>        // ...
>
>        unlock_device_hotplug();
>        return ret;
>    }
>
>



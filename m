Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E10EE77197
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 03:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BKGNRek6tyT4tnRvV4cOEDAaOqBuVYRtuGJgnAhlKA4=; b=EyXy2zZdwNN+TMAW19ybgryZFS
	u8enlxxyOdKCXsMwTh/VDdh1ISHC/u/GNyWQWJ6usAvuvOa035IJ+Q24/YDuKOTXwKB92xghz2Ki+
	n0/d3olFwx/3WMSwj4xTl8mliNTumnJLvWOfazAOFaFEvc/IFtVT19S8IwE5RIZ1iYhtcPM1Sluvk
	qhpGOYtPCyZCB1P+o8zuR0geQPGz5w+TXWjoqMlWYQ/VBybTIh423wZLxSPP8HKsM2xT50XpvXg+K
	hTuWBYFgc7//QcVqFfTtrLnNlFRrUmBcN13kDi74nzA0N8fDjOUm3d54OjwkJ9pjNC5swj90+Ym9C
	2FjiCeyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVjbH-0000000AeYG-3ikj;
	Thu, 09 Jan 2025 03:52:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVjSB-0000000Ad1m-2y2J
	for kexec@lists.infradead.org;
	Thu, 09 Jan 2025 03:43:29 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508ICI0Z023325;
	Thu, 9 Jan 2025 03:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BKGNRe
	k6tyT4tnRvV4cOEDAaOqBuVYRtuGJgnAhlKA4=; b=YM2Qsqu15mcqg8JGf6JvB9
	DOOGH3c9bCJxjdGi0hJ64vp3Iey1xdU9Ti7PB2DwI2YbT4dL89F49lWspCzko1Np
	KKxp2VNMFvD3fMihRa1O7dO2xbdnDkrEI6xjTtW085Mc7akmaScehLW9V4sLHGdf
	Ex0ExbH0Qx6yPpB8/u0ZahrB3um1bxstuTpCta+/K5MV3MQVZyiYy8yC79RmPM7f
	IUH/9IfOLFIafW2Kiryv/SWmNYpl0pFx3NRASe20GBIgUVi0ivG0HkiD5CTEsS6S
	VlJQtTDNrUviBhYyTrr40ZpGVQjhJtvSBiCmtxZPFYNPWW+yQxbYjeWu9jOAnZxA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441nj3cn7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 03:43:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 509108PZ016144;
	Thu, 9 Jan 2025 03:43:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtm3409-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 03:43:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5093hESO29688448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 03:43:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C0C920049;
	Thu,  9 Jan 2025 03:43:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46AE820040;
	Thu,  9 Jan 2025 03:43:11 +0000 (GMT)
Received: from [9.43.18.121] (unknown [9.43.18.121])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2025 03:43:11 +0000 (GMT)
Message-ID: <e52cdf5a-dde2-4008-bee4-38080182bf58@linux.ibm.com>
Date: Thu, 9 Jan 2025 09:13:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v1 4/5] powerpc/crash: use generic crashkernel
 reservation
To: mahesh@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
        Baoquan he <bhe@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250108101458.406806-1-sourabhjain@linux.ibm.com>
 <20250108101458.406806-5-sourabhjain@linux.ibm.com>
 <dgn3qq2q35rjem3lm33k646tl7ucxghwnvttplr4fdk35aftfx@2tzxh6ku5m3d>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <dgn3qq2q35rjem3lm33k646tl7ucxghwnvttplr4fdk35aftfx@2tzxh6ku5m3d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XJ32GDhjHOFhoL-XeQpnyUTdjyLqFNJT
X-Proofpoint-GUID: XJ32GDhjHOFhoL-XeQpnyUTdjyLqFNJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_194327_869740_98B5ED42 
X-CRM114-Status: GOOD (  28.19  )
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

Hello Mahesh,

On 08/01/25 22:35, Mahesh J Salgaonkar wrote:
> On 2025-01-08 15:44:57 Wed, Sourabh Jain wrote:
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
>> To prevent crashkernel memory from being added to iomem_resource, the Mahesh.
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
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/Kconfig                     |  3 +
>>   arch/powerpc/include/asm/crash_reserve.h | 18 +++++
>>   arch/powerpc/include/asm/kexec.h         |  4 +-
>>   arch/powerpc/kernel/prom.c               |  2 +-
>>   arch/powerpc/kexec/core.c                | 90 ++++++++++--------------
>>   5 files changed, 63 insertions(+), 54 deletions(-)
>>   create mode 100644 arch/powerpc/include/asm/crash_reserve.h
> [...]
>> @@ -113,9 +113,9 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt, struct crash_mem
>>   
>>   #ifdef CONFIG_CRASH_RESERVE
>>   int __init overlaps_crashkernel(unsigned long start, unsigned long size);
>> -extern void reserve_crashkernel(void);
>> +extern void arch_reserve_crashkernel(void); Mahesh. Mahesh
> Do we really need to rename this ? it is still called from powepc arch
> and not from the common code.

You are right, we don’t. However, all architectures (x86, RISC-V, 
LoongArch, ARM64) that use the
generic crash kernel reservation have named their architecture-specific 
function `arch_reserve_crashkernel()`.
So, I did the same for PowerPC, and this helps sometimes.

Maybe I should justify the name change in the commit to avoid confusion.

Please let me know your opinion.

>
>>   #else
>> -static inline void reserve_crashkernel(void) {}
>> +static inline void arch_reserve_crashkernel(void) {}
>>   static inline int overlaps_crashkernel(unsigned long start, unsigned long size) { return 0; }
>>   #endif
>>   
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index e0059842a1c6..9ed9dde7d231 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -860,7 +860,7 @@ void __init early_init_devtree(void *params)
>>   	 */
>>   	if (fadump_reserve_mem() == 0)
>>   #endif
>> -		reserve_crashkernel();
>> +		arch_reserve_crashkernel();
>>   	early_reserve_mem();
>>   
>>   	if (memory_limit > memblock_phys_mem_size())
> Rest looks good to me.
>
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Thank you for reviewing this.

- Sourabh Jain


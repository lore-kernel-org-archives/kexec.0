Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1F5C61DCD
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 05:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/kRYcn5KBaaxx9SfWmgmLOHBEE085yrBIcMYY/T9Zsc=; b=q8xNhTMnSPwNFTC7XprCWcqtxD
	JIlaC/YLz4ISJibTdNL71BeKXhlCtbWBMZfL537Gq+86a5sfm1ORZc8uwVBVpkzrMgyrQRs+AoWER
	RBFIzNegUecXebgtOUdYQs4WgoU5Qn/h6W60dMBOvWv0FA6GKznHcUi9ao4CYZhg3TqL2qY6EXUha
	tlzvD5NVaPSbnbEkkOiHc0Tf4LY2Ni9mjOab9m8TirykPrbBqwB4mPOP02sBuei92dZ7RsoTyhxxC
	N8ANpK8Do1K8OhIpGZuEQBHuBpnX6C4frwKXwx85VoE/Qap4LYgTGH0Eby59AfCJlQotRqYycJ4Lv
	wLEoZ4CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzpb5-00000005Aq2-3kOH;
	Fri, 28 Aug 2026 05:57:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzpb3-00000005ApW-1XXw;
	Fri, 28 Aug 2026 05:57:50 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67S23MbU680449;
	Fri, 28 Aug 2026 05:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/kRYcn
	5KBaaxx9SfWmgmLOHBEE085yrBIcMYY/T9Zsc=; b=RGC7QzhECywBOnuVavtCZB
	Oxl6un0bCqU7IbkbX8n6nIKtyQe65/N51Ne14JTIXhk/Nnxd9Rxy3WayaPHJMmZg
	xLIlI2gijD67KJr10Jm4cWXA/pq6aq4vNCCh2/Nzdf6aRiYlS2y/gVD/UL+t+XJq
	Az/2mszsoIzBTOjWBBoy475E4P2O9vnJYoDF+fefgiLiigib14npV5uXYdpmkTTH
	5elUpSKqCx00IFlpyelQ3pETR/T1ao3gPhMfW4Of7mJ9bSxJHHmayl5auxZlQFt9
	yv1Mg+qMngyPlutWdwAVrF6Y5cVtutZRIFBQmuMuxjRxGmUOtZmEfd82c6T+f50Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxsxwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 05:57:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uLMi025216;
	Fri, 28 Aug 2026 05:57:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragvejf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 05:57:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67S5vdBn42205498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 05:57:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E5612004B;
	Fri, 28 Aug 2026 05:57:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E7A520040;
	Fri, 28 Aug 2026 05:57:37 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 05:57:36 +0000 (GMT)
Message-ID: <b9ddebaa-6271-4a4e-8f26-cc4e57f94075@linux.ibm.com>
Date: Fri, 28 Aug 2026 11:27:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec_file: remove unused arch_kexec_locate_mem_hole hook
To: Baoquan He <baoquan.he@linux.dev>
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Walmsley <pjw@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org
References: <20260827144452.508328-1-sourabhjain@linux.ibm.com>
 <apDuG6mgDNyJL9rh@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <apDuG6mgDNyJL9rh@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA0NSBTYWx0ZWRfXwNpKBmYAQx12
 y1r0xMqhBsWqDayxqQLUAPfMLSLo36s4fFb36W9fXPvOuYo+7EuA23V917cHePFuiglyxUWPtVp
 Ll9s6/TqqYnpGkgshPUYkkS7B+EF0Bo=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a912356 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Z4Rwk6OoAAAA:8
 a=VwQbUJbxAAAA:8 a=_O3DOGVWAAAA:8 a=7ipKWUHlAAAA:8 a=JfrnYn6hAAAA:8
 a=VnNF1IyMAAAA:8 a=OAGPVbnBEn1HTDi0bR4A:9 a=QEXdDO2ut3YA:10
 a=HkZW87K1Qel5hWWM3VKY:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=gpc5p9EgBqZVLdJeV_V1:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: iwVpfphajSjtONbEnea2VkxBGiN1jCYY
X-Proofpoint-GUID: iwVpfphajSjtONbEnea2VkxBGiN1jCYY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA0NSBTYWx0ZWRfX+LslopHq0aQ0
 sFT+HMzFqpwfd2IAf9NX3QlstSxl1kzsSSRMzM5/XZO7mgnkZHo6k5b1Vdiu6La0X9IBy84KAcB
 aWekC3Ot0rVZQcoHMooEMzXZN8tUid++Od+DLMnmsob00Pet2EV1ktj47Z5Bbi7y+LH1Hnq5sIM
 i1WdJZXntKqsBohG2f/GPwI83tszs2iP6wMisH5N5jQAZLSsK54T7I6iFB83UmrZLh50nZ4LFZS
 aYrsbLXQFl12+HaxaxPZqId9a73VeJtBKhGoh7LPGdBsVTXzEiZjIcaFRYZ6QFR7Udv/yNVvCrS
 PAIZBaenpGPGZ/YrtlX5Til4AeyWFRxfML7Rus/E/LPsXzMSNMEs7lOEX7zHIE2DMig+PC2fHxH
 LUV2MbTGUUmzwQYOZ/i74AImcIDkvHMzVzP+EuBnRtJvpyOH8Wlfoew9i2SR09m1wXc3pH4yRAK
 CBAPhyr+LPCVz+oFicw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280045
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_225749_529683_8F3553F5 
X-CRM114-Status: GOOD (  17.82  )
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



On 28/08/26 07:40, Baoquan He wrote:
> On 08/27/26 at 08:14pm, Sourabh Jain wrote:
>> No architecture provides an implementation of
>> arch_kexec_locate_mem_hole(). Use kexec_locate_mem_hole() directly
>> and remove the unused fallback wrapper from the kexec header.
> Since below commit, the last user was gone:
> commit 6e5250eaa665f ("powerpc/crash: use generic APIs to locate memory hole for kdump")
>
> Acked-by: Baoquan He <baoquan.he@linux.dev>

Thanks for the Ack, Baoquan.

- Sourabh Jain

>
>> This simplifies the kexec memory allocation path without changing
>> its behavior.
>>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan He <baoquan.he@linux.dev>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Cc: Paul Walmsley <pjw@kernel.org>
>> Cc: Pratyush Yadav <pratyush@kernel.org>
>> Cc: linux-riscv@lists.infradead.org
>> Cc: kexec@lists.infradead.org
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/riscv/kernel/kexec_elf.c |  2 +-
>>   include/linux/kexec.h         | 15 ---------------
>>   kernel/kexec_file.c           |  2 +-
>>   3 files changed, 2 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/kexec_elf.c b/arch/riscv/kernel/kexec_elf.c
>> index 3e9a32acb8f2..ca5abbad59e5 100644
>> --- a/arch/riscv/kernel/kexec_elf.c
>> +++ b/arch/riscv/kernel/kexec_elf.c
>> @@ -91,7 +91,7 @@ static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
>>   	kbuf.memsz = ALIGN(kernel_len, PAGE_SIZE);
>>   	kbuf.cma = NULL;
>>   	kbuf.top_down = false;
>> -	ret = arch_kexec_locate_mem_hole(&kbuf);
>> +	ret = kexec_locate_mem_hole(&kbuf);
>>   	if (!ret) {
>>   		*old_pbase = lowest_paddr;
>>   		*new_pbase = kbuf.mem;
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 0af8ae4fdd08..e5f1cfc11fef 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -259,21 +259,6 @@ int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
>>   extern int kexec_add_buffer(struct kexec_buf *kbuf);
>>   int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>>   
>> -#ifndef arch_kexec_locate_mem_hole
>> -/**
>> - * arch_kexec_locate_mem_hole - Find free memory to place the segments.
>> - * @kbuf:                       Parameters for the memory search.
>> - *
>> - * On success, kbuf->mem will have the start address of the memory region found.
>> - *
>> - * Return: 0 on success, negative errno on error.
>> - */
>> -static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
>> -{
>> -	return kexec_locate_mem_hole(kbuf);
>> -}
>> -#endif
>> -
>>   #ifndef arch_kexec_apply_relocations_add
>>   /*
>>    * arch_kexec_apply_relocations_add - apply relocations of type RELA
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 59fb9d71e9d8..9a981359addd 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -784,7 +784,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>>   	kbuf->cma = NULL;
>>   
>>   	/* Walk the RAM ranges and allocate a suitable range for the buffer */
>> -	ret = arch_kexec_locate_mem_hole(kbuf);
>> +	ret = kexec_locate_mem_hole(kbuf);
>>   	if (ret)
>>   		return ret;
>>   
>> -- 
>> 2.55.0
>>



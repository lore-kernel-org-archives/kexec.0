Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4C6C30653
	for <kexec@archiver.kernel.org>; Wed,  3 Jul 2024 18:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=su5U+WzgzgkgMhCJXna+l71RuGRSlLAjS4Ii4hml4FE=; b=P9ybHp8REQRwXi
	FrzjweA79wtXZMBgBGTJV6KsWR3AVniWAxWnHjw+73kBMo8RxOS5CvncnOdDYZ3JqlccGcdO5PGIJ
	7Wrda8lDNyx8KnuYwyXFeeE6OXKKYCR4xTf0U+CLLx7VtsgRIjUb3qYkZTN35lZljaS9rGKaPT7Oo
	64C+HK2ekNTZNUUDHNs4+JJxVXWnqTH3IoFVK8pViYl5Os47bseQVHZqZfPLIV6WzekKx6+Lg2Wn0
	+uDRX4Kk8Okm4hnvvej0dtJt/4ZpZLRzRD+4CaEscfxB5c/VJ1aXh+wyG3UZoz0j7dgxJx5Zsh0Wb
	vc5aaiPz1EvHgjKE9OAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP4Oe-0000000B73b-3ChA;
	Wed, 03 Jul 2024 18:08:00 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP4Ob-0000000B72G-0ifE
	for kexec@lists.infradead.org;
	Wed, 03 Jul 2024 18:07:59 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463Hwxii030970;
	Wed, 3 Jul 2024 18:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=d
	YVam3UD+EawAiMCSsOtNaJ9gImefnCVhVirace5WAM=; b=oDP2XyeO1b+VYtRyO
	Jkt8W0FX06k0k9qUhDH9uSPigS7vdWqZDxkOWf+HYRU5f8sqMXVpRi+aE0tfskZh
	Rjenr1+cqoEtRMXPSKfpzRrKBHjVrPM1mJNnXcw922i0oJBZNTSJMg2rTEb9UKUp
	rs7+m3+kY+bj27pz+yX62Rq5vh73q7M8YS6cIIn2sIegacwO3PtNTkEMImEDqPGm
	UG8pCzot1NWftULuc0B0TR8lyQVh5I5G0aFpIvoj8sT5UcXtPkkZxXx7CuVUku4e
	Femw+SmMTdpXkA0/zG3xP1tkse2SQQpt89Tw3r7O9p+F4veKisjoJGs7R0VSAro6
	Iipvw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 405bgur0pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 18:07:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 463I7jOG011481;
	Wed, 3 Jul 2024 18:07:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 405bgur0pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 18:07:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 463F1K3S005985;
	Wed, 3 Jul 2024 18:07:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vkuc5a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 18:07:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 463I7d5B52756836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jul 2024 18:07:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E414D2004B;
	Wed,  3 Jul 2024 18:07:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17C472004E;
	Wed,  3 Jul 2024 18:07:37 +0000 (GMT)
Received: from [9.43.78.85] (unknown [9.43.78.85])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jul 2024 18:07:36 +0000 (GMT)
Message-ID: <e5c4a391-5af9-4fe7-a813-73f7a6718658@linux.ibm.com>
Date: Wed, 3 Jul 2024 23:37:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] kexec_load: Use new kexec flag for hotplug support
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Aditya Gupta <adityag@linux.ibm.com>,
        Coiby Xu <coxu@redhat.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>
References: <20240702043057.200211-1-sourabhjain@linux.ibm.com>
 <ZoTUEtU6o6wuHvtf@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZoTUEtU6o6wuHvtf@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eCdS_10_mM2PNw6pZVI8JHr9LaYdxvGd
X-Proofpoint-ORIG-GUID: j1jaKQugKj8eAquI8-cUgTVqPN5v0xcQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_12,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_110757_385607_EAF5A54C 
X-CRM114-Status: GOOD (  20.90  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello Baoquan,

On 03/07/24 10:01, Baoquan He wrote:
> On 07/02/24 at 10:00am, Sourabh Jain wrote:
> ......
>> diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
>> index 444cb69..b4947a0 100644
>> --- a/kexec/arch/i386/kexec-x86.c
>> +++ b/kexec/arch/i386/kexec-x86.c
>> @@ -208,3 +208,11 @@ void arch_update_purgatory(struct kexec_info *info)
>>   	elf_rel_set_symbol(&info->rhdr, "panic_kernel",
>>   		&panic_kernel, sizeof(panic_kernel));
>>   }
>> +
>> +int arch_do_exclude_segment(struct kexec_segment *seg_ptr, struct kexec_info *info)
>> +{
>> +	if (info->elfcorehdr == (unsigned long) seg_ptr->mem)
>> +		return 1;
>> +
>> +	return 0;
>> +}
> I know the similar question has been asked in earlier version, I may not
> get it. still raise concern here to ask why x86_64 returns 0 directly,
> while i386 will have the different cases.

Currently, info->elfcorehdr is only getting initialized in 
load_crashdump_segments() in
kexec/arch/i386/crashdump-x86.c. This led me think that elfcorehdr is 
only skipped
for i386 and NOT x86_64.

However, info->elfcorehdr is actually getting initialized for x86_64 
too. Because
load_crashdump_segments() defined under kexec/arch/i386/crashdump-x86.c 
is called for
both i386 and x86_64.

You and Hari are both right; the arch_do_exclude_segment() 
implementation should be
the same for both i386 and x86_64.

I will update the patch.

>
>> diff --git a/kexec/arch/ia64/kexec-ia64.c b/kexec/arch/ia64/kexec-ia64.c
>> index 418d997..8d9c1f3 100644
>> --- a/kexec/arch/ia64/kexec-ia64.c
>> +++ b/kexec/arch/ia64/kexec-ia64.c
>> @@ -245,3 +245,7 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
>>   {
>>   }
>>   
>> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
>                                                              ~~~~~~~
> A tiny nit about the parameter naming, since the existing is taking
> 'struct kexec_segment *segment', can we also take the same way? Not
> strong opinion.
>
> =====
> kexec-tools/kexec/kexec.c:
> static int valid_memory_segment(struct kexec_info *info,
>                                  struct kexec_segment *segment)
> {
>          unsigned long sstart, send;
>          sstart = (unsigned long)segment->mem;
>          send   = sstart + segment->memsz - 1;
>
>          return valid_memory_range(info, sstart, send);
> }

Sure, I will rename the parameter and reorder them just like in the 
above function.

>
>> +{
>> +	return 0;
>> +}
>> diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
>> index ac75030..ee7b9f1 100644
>> --- a/kexec/arch/loongarch/kexec-loongarch.c
>> +++ b/kexec/arch/loongarch/kexec-loongarch.c
>> @@ -381,3 +381,8 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
>>   	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
>>   				    buf_min, buf_max, buf_end, 1);
>>   }
>> +
>> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
>> +{
>> +	return 0;
>> +}
>> diff --git a/kexec/arch/m68k/kexec-m68k.c b/kexec/arch/m68k/kexec-m68k.c
>> index cb54927..0c7dbaf 100644
>> --- a/kexec/arch/m68k/kexec-m68k.c
>> +++ b/kexec/arch/m68k/kexec-m68k.c
>> @@ -108,3 +108,8 @@ void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
>>   {
>>   	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
>>   }
>> +
>> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
>> +{
>> +	return 0;
>> +}
>> diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
>> index d8cbea8..94224ee 100644
>> --- a/kexec/arch/mips/kexec-mips.c
>> +++ b/kexec/arch/mips/kexec-mips.c
>> @@ -189,3 +189,7 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
>>   				    buf_min, buf_max, buf_end, 1);
>>   }
>>   
>> +int arch_do_exclude_segment(const void *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
>> +{
>> +	return 0;
>> +}
>> diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
>> index 03bec36..c8af870 100644
>> --- a/kexec/arch/ppc/kexec-ppc.c
>> +++ b/kexec/arch/ppc/kexec-ppc.c
>> @@ -966,3 +966,7 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
>>   {
>>   }
>>   
>> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
>> +{
>> +	return 0;
>> +}
>> diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
>> index bd5274c..fb27b6b 100644
>> --- a/kexec/arch/ppc64/kexec-ppc64.c
>> +++ b/kexec/arch/ppc64/kexec-ppc64.c
>> @@ -967,3 +967,8 @@ int arch_compat_trampoline(struct kexec_info *UNUSED(info))
>>   void arch_update_purgatory(struct kexec_info *UNUSED(info))
>>   {
>>   }
>> +
>> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
>> +{
>> +	return 0;
>> +}
>> diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
>> index 33ba6b9..0561ee7 100644
>> --- a/kexec/arch/s390/kexec-s390.c
>> +++ b/kexec/arch/s390/kexec-s390.c
>> @@ -267,3 +267,8 @@ int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
>>   {
>>   	return parse_iomem_single("Crash kernel\n", start, end);
>>   }
>> +
>> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
>> +{
>> +	return 0;
>> +}
>> diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
>> index ce341c8..f84c40c 100644
>> --- a/kexec/arch/sh/kexec-sh.c
>> +++ b/kexec/arch/sh/kexec-sh.c
>> @@ -257,3 +257,8 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
>>   	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
>>   				    buf_min, buf_max, buf_end, 1);
>>   }
>> +
>> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
>> +{
>> +	return 0;
>> +}
>> diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
>> index ffd84f0..42af90a 100644
>> --- a/kexec/arch/x86_64/kexec-x86_64.c
>> +++ b/kexec/arch/x86_64/kexec-x86_64.c
>> @@ -188,3 +188,8 @@ void arch_update_purgatory(struct kexec_info *info)
>>   	elf_rel_set_symbol(&info->rhdr, "panic_kernel",
>>   				&panic_kernel, sizeof(panic_kernel));
>>   }
>> +
>> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
>> +{
>> +	return 0;
>> +}
>> diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
>> index 73e5254..4675c46 100644
>> --- a/kexec/kexec-syscall.h
>> +++ b/kexec/kexec-syscall.h
>> @@ -112,7 +112,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
>>   
>>   #define KEXEC_ON_CRASH		0x00000001
>>   #define KEXEC_PRESERVE_CONTEXT	0x00000002
>> -#define KEXEC_UPDATE_ELFCOREHDR	0x00000004
>> +#define KEXEC_CRASH_HOTPLUG_SUPPORT	0x00000008
>>   #define KEXEC_ARCH_MASK		0xffff0000
> Yeah, removing KEXEC_UPDATE_ELFCOREHDR sounds good to avoid collision
> with xen code.

Thanks for the review.

I will make the necessary changes as mentioned above and send v4.

Thanks,
Sourabh Jain

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

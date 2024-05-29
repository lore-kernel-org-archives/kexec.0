Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E746C25B75
	for <kexec@archiver.kernel.org>; Wed, 29 May 2024 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oOQW229iJmswGdKa0KC11sP6QwNfMQS0bCrxeFSpvVw=; b=m3bj919dB6cfh9
	+ufmZMaWlOVhqwuJjbm5E02iVMR1pZ6N8LX8fUdMRklp7t6gjLnCYbtaFfF+JEiJKbVdIC2uuhcgA
	HccGM03WzVtGtrJWAFFOhYFDYPNLlaD7DmDr/TtwoQc+CwqHF+6bxjIxMWvxJRnq9VOdpvaOie/3f
	BE/s97kg//831grG0llX8/khk/WIR6BSCNoG02oOYaFCq017fzCdx1u/Q46pXrUMdbk4xpi7KBPKz
	jl1CBufe91t16gYej+n/ja6OBJHwcn9Ee/DJwgw6XaHfljUDTNiZ6CJKvFpNmUMnLtGmAGZo5DGsT
	6iudCeGmMcuPw9f9ztCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCJ8D-00000004Da2-2r0d;
	Wed, 29 May 2024 13:14:17 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCJ89-00000004DYZ-0lDo
	for kexec@lists.infradead.org;
	Wed, 29 May 2024 13:14:15 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44TCvwpX021611
	for <kexec@lists.infradead.org>; Wed, 29 May 2024 13:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=iYNcaLjGL1jJ0JpfO9hh9TC78QGkc/Po6VHGf57perQ=;
 b=BSAmNyuLdnAinf+AwXL9P3HAM8traqUnrnnpM/1E24U+JvKG+9pQBCp/WoRYWJC5fWAX
 NuXgt58WmabPOs+pQBBjRd8nHHkI1ikWGrlpmoVEPwZPTIIo9sJV6WGwcY3xHhf7Lrg/
 X+SYHnHdKV7HWdBtbbkTQzw3a2ZGotzmJ5yVtoy4j1i+de8mYqYCS0pHYBI2NWlFWdMF
 sXDX70rhJKaWNnOxE3JC7f1BykHw/EOj9KXMP0JUmBW21yKVYJVnIPsZCvoF2uQiPGWn
 ZtFHQf3kw9JBsZoxm1fTcLS018zH8YsOKwG3wKpq9oQnyiRobuUrTLYPLOryQCvgWhET hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye4tu8292-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Wed, 29 May 2024 13:13:50 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44TDDnLW018101
	for <kexec@lists.infradead.org>; Wed, 29 May 2024 13:13:49 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye4tu8290-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 13:13:49 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44TBZKwE002438;
	Wed, 29 May 2024 13:13:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ydpb0kxm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 13:13:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44TDDhth45351400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 13:13:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 763FC20043;
	Wed, 29 May 2024 13:13:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A63620040;
	Wed, 29 May 2024 13:13:41 +0000 (GMT)
Received: from [9.43.10.87] (unknown [9.43.10.87])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 May 2024 13:13:40 +0000 (GMT)
Message-ID: <0891edfc-b391-4639-a486-2a18f3a41363@linux.ibm.com>
Date: Wed, 29 May 2024 18:43:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] kexec_load: Use new kexec flag for hotplug support
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>
References: <20240522131353.198327-1-sourabhjain@linux.ibm.com>
 <xdf5qxbq5nvlgim55b5vsvr7zygkbvl7sofdxb3evp77jcxten@326hrz2qpa6v>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <xdf5qxbq5nvlgim55b5vsvr7zygkbvl7sofdxb3evp77jcxten@326hrz2qpa6v>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hrwV04vlcLtaxgaWClbm_YDoDXeHxMsT
X-Proofpoint-ORIG-GUID: xY61fz41k2L0NsEVOuhD3YWkIeMMKRbq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_07,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405290089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_061413_390529_0F92B5F4 
X-CRM114-Status: GOOD (  31.49  )
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

Hello Aditya,


On 28/05/24 17:03, Aditya Gupta wrote:
> Hello sourabh,
>
> On Wed, May 22, 2024 at 06:43:51PM GMT, Sourabh Jain wrote:
>> Kernel commit 79365026f869 (crash: add a new kexec flag for hotplug
>> support) has introduced a new kexec flag to generalize hotplug support.
>> The newly introduced kexec flags for hotplug allow architectures to
>> exclude all the required kexec segments from SHA calculation so that
>> the kernel can update them on hotplug events. This was not possible
>> earlier with the KEXEC_UPDATE_ELFCOREHDR kexec flags since it was added
>> only for the elfcorehdr segment.
>>
>> To enable architectures to control the list of kexec segments to exclude
>> when hotplug support is enabled, add a new architecture-specific
>> function named arch_do_exclude_segment. During the SHA calculation, this
>> function gets called to let the architecture decide whether a specific
>> kexec segment should be considered for SHA calculation or not.
>>
>> Given that the KEXEC_UPDATE_ELFCOREHDR is no longer required and was
>> colliding with the KEXEC_LIVE_UPDATE update flag, it is removed.
>>
>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Coiby Xu <coxu@redhat.com>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   kexec/arch/arm/kexec-arm.c             |  5 +++++
>>   kexec/arch/arm64/kexec-arm64.c         |  4 ++++
>>   kexec/arch/cris/kexec-cris.c           |  4 ++++
>>   kexec/arch/hppa/kexec-hppa.c           |  5 +++++
>>   kexec/arch/i386/kexec-x86.c            |  8 ++++++++
>>   kexec/arch/ia64/kexec-ia64.c           |  4 ++++
>>   kexec/arch/loongarch/kexec-loongarch.c |  5 +++++
>>   kexec/arch/m68k/kexec-m68k.c           |  5 +++++
>>   kexec/arch/mips/kexec-mips.c           |  4 ++++
>>   kexec/arch/ppc/kexec-ppc.c             |  4 ++++
>>   kexec/arch/ppc64/kexec-ppc64.c         |  5 +++++
>>   kexec/arch/s390/kexec-s390.c           |  5 +++++
>>   kexec/arch/sh/kexec-sh.c               |  5 +++++
>>   kexec/arch/x86_64/kexec-x86_64.c       |  5 +++++
>>   kexec/kexec-syscall.h                  |  2 +-
>>   kexec/kexec.c                          | 14 ++++++++------
>>   kexec/kexec.h                          |  2 ++
>>   17 files changed, 79 insertions(+), 7 deletions(-)
>>
>> diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
>> index 49f35b1..34531f9 100644
>> --- a/kexec/arch/arm/kexec-arm.c
>> +++ b/kexec/arch/arm/kexec-arm.c
>> @@ -148,3 +148,8 @@ int have_sysfs_fdt(void)
>>   {
>>   	return !access(SYSFS_FDT, F_OK);
>>   }
>> +
>> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
>> +{
>> +	return 0;
>> +}
>> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
>> index 4a67b0d..9d052b0 100644
>> --- a/kexec/arch/arm64/kexec-arm64.c
>> +++ b/kexec/arch/arm64/kexec-arm64.c
>> @@ -1363,3 +1363,7 @@ void arch_reuse_initrd(void)
>>   void arch_update_purgatory(struct kexec_info *UNUSED(info))
>>   {
>>   }
>> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
>> +{
>> +	return 0;
>> +}
>> diff --git a/kexec/arch/cris/kexec-cris.c b/kexec/arch/cris/kexec-cris.c
>> index 3b69709..7f09121 100644
>> --- a/kexec/arch/cris/kexec-cris.c
>> +++ b/kexec/arch/cris/kexec-cris.c
>> @@ -109,3 +109,7 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
>>                                       buf_min, buf_max, buf_end, 1);
>>   }
>>   
>> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
>> +{
>> +	return 0;
>> +}
>> diff --git a/kexec/arch/hppa/kexec-hppa.c b/kexec/arch/hppa/kexec-hppa.c
>> index 77c9739..a64dc3d 100644
>> --- a/kexec/arch/hppa/kexec-hppa.c
>> +++ b/kexec/arch/hppa/kexec-hppa.c
>> @@ -146,3 +146,8 @@ unsigned long virt_to_phys(unsigned long addr)
>>   {
>>   	return addr - phys_offset;
>>   }
>> +
>> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
>> +{
>> +	return 0;
>> +}
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
>> diff --git a/kexec/arch/ia64/kexec-ia64.c b/kexec/arch/ia64/kexec-ia64.c
>> index 418d997..8d9c1f3 100644
>> --- a/kexec/arch/ia64/kexec-ia64.c
>> +++ b/kexec/arch/ia64/kexec-ia64.c
>> @@ -245,3 +245,7 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
>>   {
>>   }
>>   
>> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
>> +{
>> +	return 0;
>> +}
>> diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
>> index 32a42d2..9a50ff6 100644
>> --- a/kexec/arch/loongarch/kexec-loongarch.c
>> +++ b/kexec/arch/loongarch/kexec-loongarch.c
>> @@ -378,3 +378,8 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
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
> Should all arch_do_exclude_segment return 1 for elfcorehdr ? Please
> refer my below comment.

No they shouldn't until they have CRASH_HTOPLUG support in the kernel.


>
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
>>   
>>   /* Flags for kexec file based system call */
>> diff --git a/kexec/kexec.c b/kexec/kexec.c
>> index 222f79e..034cea6 100644
>> --- a/kexec/kexec.c
>> +++ b/kexec/kexec.c
>> @@ -701,10 +701,13 @@ static void update_purgatory(struct kexec_info *info)
>>   			continue;
>>   		}
>>   
>> -		/* Don't include elfcorehdr in the checksum, if hotplug
>> -		 * support enabled.
>> +		/*
>> +		 * Let architecture decide which segments to exclude from checksum
>> +		 * if hotplug support is enabled.
>>   		 */
>> -		if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
>> +		if (do_hotplug && arch_do_exclude_segment(&info->segment[i], info)) {
>> +			dbgprintf("Skipping segment mem: 0x%lx from SHA calculation\n",
>> +				  (unsigned long)info->segment[i].mem);
>>   			continue;
>>   		}
> Current behaviour seems to skip elfcorehdr segment in all architectures.
>
> But now as all architectures are returning 0 in arch_do_exclude_segment,
> will elfcorehdr still be skipped ?

Skipping elfcorehdr for architectures that don't support CRASH_HOTPLUG 
is, I think, incorrect.
Therefore, I believe the proposed approach in this patch, which asks the 
architecture which
segments to exclude, is better.

> Rest all looks good to me.

Thanks for the review.


- Sourabh Jain

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

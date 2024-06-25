Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7741C2BBCA
	for <kexec@archiver.kernel.org>; Tue, 25 Jun 2024 08:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r48ViY+IbH4hPCvJyB5N0V8nOKBMa6xfkEdVWDhNJkA=; b=TvYetvCteLE54F
	c5JORTubDk15Eag9Q8jgQ+zDbTQRLT1Zj+P4d3EHqijPKCiUuZB1ltf/yDG/q5NJc1WV8CcIrCZZm
	hYYtWbk263QujIQwQs2nb7ipMUq2ADDqqYvHmdleIf7m5Ihhp15CikJlUBbFqFlyccgQyLXvk7QKM
	b0mI4RptW3P15uQ+OJcr9lTaySdnlNGFtwgz3CCdklzky3R+BGm0PetyUq7Jk9nSwQ2CdkASshd3m
	AQrx+IM9ngnwCO8Uakz4BMSZBwBX47T7F6JfW/yV7zuj35mVkdLsuxnQcdzNxRMkeWjTGDrabD16p
	GshJaHkapQJsAti72bpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM1Qy-000000025W6-3Jd3;
	Tue, 25 Jun 2024 08:21:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM1Qv-000000025VT-2CG7
	for kexec@lists.infradead.org;
	Tue, 25 Jun 2024 08:21:47 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P7UArv022325;
	Tue, 25 Jun 2024 08:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=C
	1LXEmO++PE7g9ZsEEYqI/HHHQ1FGMVGAE8YosD0S9A=; b=jILmfLwM58eSTntpJ
	KNVtkR38+MSxHbuZQmSwYU3SN6vgheCe+ckxGPa/z+pM/x6/sKgDVAIvsusIc5/L
	jV59kc2xwSBjQ15JOgoEZBCylyj1nVG3r+S2OfFk1UXuFmYCyq9OScYaS3nNUJ13
	qjPX3SAov9hzuWLrOiUKRWKSYy2NRkuIXrbh0OjyWUOiOoVbZIb1ZbXg0FmcW3J4
	TLqbLdIAH+JsmNBj6icFiTai+nGx6RRCumwUCV5H1vtskrADzbih7u5PJCCdC1VS
	6Ky7DKrWT9JW0Bv3sat8ldklbnSgaekgWmUCg43TFnrqaQeEgm5d0zVVP78couxZ
	Z4z1A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyshvg47x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 08:21:40 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45P8LekH001628;
	Tue, 25 Jun 2024 08:21:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyshvg47v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 08:21:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45P7ubDU000616;
	Tue, 25 Jun 2024 08:21:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaemw97t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 08:21:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45P8LXbn35586404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 08:21:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B263820043;
	Tue, 25 Jun 2024 08:21:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35DD220040;
	Tue, 25 Jun 2024 08:21:32 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Jun 2024 08:21:32 +0000 (GMT)
Message-ID: <74f5ee40-c2c8-4daa-8457-b6be0deffaa5@linux.ibm.com>
Date: Tue, 25 Jun 2024 13:51:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] kexec_load: Use new kexec flag for hotplug support
To: kexec@lists.infradead.org
Cc: Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>
References: <20240613190738.1852258-1-sourabhjain@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20240613190738.1852258-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lPwhhVdEuH3Zizz3lvrKyFGmFhPH4JVH
X-Proofpoint-GUID: RvO0uD2eof8klTP6S2qPNgo45YLe5uuz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_04,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=880 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240625_012145_783296_68C0FEE9 
X-CRM114-Status: GOOD (  34.19  )
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

Any review/comments on this patch series.


Thnaks
Sourabh Jain

On 14/06/24 00:37, Sourabh Jain wrote:
> Kernel commit 79365026f869 (crash: add a new kexec flag for hotplug
> support) has introduced a new kexec flag to generalize hotplug support.
> The newly introduced kexec flags for hotplug allow architectures to
> exclude all the required kexec segments from SHA calculation so that
> the kernel can update them on hotplug events. This was not possible
> earlier with the KEXEC_UPDATE_ELFCOREHDR kexec flags since it was added
> only for the elfcorehdr segment.
>
> To enable architectures to control the list of kexec segments to exclude
> when hotplug support is enabled, add a new architecture-specific
> function named arch_do_exclude_segment. During the SHA calculation, this
> function gets called to let the architecture decide whether a specific
> kexec segment should be considered for SHA calculation or not.
>
> Given that the KEXEC_UPDATE_ELFCOREHDR is no longer required and was
> colliding with the KEXEC_LIVE_UPDATE update flag, it is removed.
>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Coiby Xu <coxu@redhat.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Simon Horman <horms@kernel.org>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>
> * No changes in v2.
>
> ---
>   kexec/arch/arm/kexec-arm.c             |  5 +++++
>   kexec/arch/arm64/kexec-arm64.c         |  4 ++++
>   kexec/arch/cris/kexec-cris.c           |  4 ++++
>   kexec/arch/hppa/kexec-hppa.c           |  5 +++++
>   kexec/arch/i386/kexec-x86.c            |  8 ++++++++
>   kexec/arch/ia64/kexec-ia64.c           |  4 ++++
>   kexec/arch/loongarch/kexec-loongarch.c |  5 +++++
>   kexec/arch/m68k/kexec-m68k.c           |  5 +++++
>   kexec/arch/mips/kexec-mips.c           |  4 ++++
>   kexec/arch/ppc/kexec-ppc.c             |  4 ++++
>   kexec/arch/ppc64/kexec-ppc64.c         |  5 +++++
>   kexec/arch/s390/kexec-s390.c           |  5 +++++
>   kexec/arch/sh/kexec-sh.c               |  5 +++++
>   kexec/arch/x86_64/kexec-x86_64.c       |  5 +++++
>   kexec/kexec-syscall.h                  |  2 +-
>   kexec/kexec.c                          | 14 ++++++++------
>   kexec/kexec.h                          |  2 ++
>   17 files changed, 79 insertions(+), 7 deletions(-)
>
> diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
> index 49f35b1..34531f9 100644
> --- a/kexec/arch/arm/kexec-arm.c
> +++ b/kexec/arch/arm/kexec-arm.c
> @@ -148,3 +148,8 @@ int have_sysfs_fdt(void)
>   {
>   	return !access(SYSFS_FDT, F_OK);
>   }
> +
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> index 4a67b0d..9d052b0 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -1363,3 +1363,7 @@ void arch_reuse_initrd(void)
>   void arch_update_purgatory(struct kexec_info *UNUSED(info))
>   {
>   }
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/cris/kexec-cris.c b/kexec/arch/cris/kexec-cris.c
> index 3b69709..7f09121 100644
> --- a/kexec/arch/cris/kexec-cris.c
> +++ b/kexec/arch/cris/kexec-cris.c
> @@ -109,3 +109,7 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
>                                       buf_min, buf_max, buf_end, 1);
>   }
>   
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/hppa/kexec-hppa.c b/kexec/arch/hppa/kexec-hppa.c
> index 77c9739..a64dc3d 100644
> --- a/kexec/arch/hppa/kexec-hppa.c
> +++ b/kexec/arch/hppa/kexec-hppa.c
> @@ -146,3 +146,8 @@ unsigned long virt_to_phys(unsigned long addr)
>   {
>   	return addr - phys_offset;
>   }
> +
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
> index 444cb69..b4947a0 100644
> --- a/kexec/arch/i386/kexec-x86.c
> +++ b/kexec/arch/i386/kexec-x86.c
> @@ -208,3 +208,11 @@ void arch_update_purgatory(struct kexec_info *info)
>   	elf_rel_set_symbol(&info->rhdr, "panic_kernel",
>   		&panic_kernel, sizeof(panic_kernel));
>   }
> +
> +int arch_do_exclude_segment(struct kexec_segment *seg_ptr, struct kexec_info *info)
> +{
> +	if (info->elfcorehdr == (unsigned long) seg_ptr->mem)
> +		return 1;
> +
> +	return 0;
> +}
> diff --git a/kexec/arch/ia64/kexec-ia64.c b/kexec/arch/ia64/kexec-ia64.c
> index 418d997..8d9c1f3 100644
> --- a/kexec/arch/ia64/kexec-ia64.c
> +++ b/kexec/arch/ia64/kexec-ia64.c
> @@ -245,3 +245,7 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
>   {
>   }
>   
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
> index ac75030..ee7b9f1 100644
> --- a/kexec/arch/loongarch/kexec-loongarch.c
> +++ b/kexec/arch/loongarch/kexec-loongarch.c
> @@ -381,3 +381,8 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
>   	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
>   				    buf_min, buf_max, buf_end, 1);
>   }
> +
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/m68k/kexec-m68k.c b/kexec/arch/m68k/kexec-m68k.c
> index cb54927..0c7dbaf 100644
> --- a/kexec/arch/m68k/kexec-m68k.c
> +++ b/kexec/arch/m68k/kexec-m68k.c
> @@ -108,3 +108,8 @@ void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
>   {
>   	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
>   }
> +
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
> index d8cbea8..94224ee 100644
> --- a/kexec/arch/mips/kexec-mips.c
> +++ b/kexec/arch/mips/kexec-mips.c
> @@ -189,3 +189,7 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
>   				    buf_min, buf_max, buf_end, 1);
>   }
>   
> +int arch_do_exclude_segment(const void *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
> index 03bec36..c8af870 100644
> --- a/kexec/arch/ppc/kexec-ppc.c
> +++ b/kexec/arch/ppc/kexec-ppc.c
> @@ -966,3 +966,7 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
>   {
>   }
>   
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
> index bd5274c..fb27b6b 100644
> --- a/kexec/arch/ppc64/kexec-ppc64.c
> +++ b/kexec/arch/ppc64/kexec-ppc64.c
> @@ -967,3 +967,8 @@ int arch_compat_trampoline(struct kexec_info *UNUSED(info))
>   void arch_update_purgatory(struct kexec_info *UNUSED(info))
>   {
>   }
> +
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
> index 33ba6b9..0561ee7 100644
> --- a/kexec/arch/s390/kexec-s390.c
> +++ b/kexec/arch/s390/kexec-s390.c
> @@ -267,3 +267,8 @@ int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
>   {
>   	return parse_iomem_single("Crash kernel\n", start, end);
>   }
> +
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
> index ce341c8..f84c40c 100644
> --- a/kexec/arch/sh/kexec-sh.c
> +++ b/kexec/arch/sh/kexec-sh.c
> @@ -257,3 +257,8 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
>   	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
>   				    buf_min, buf_max, buf_end, 1);
>   }
> +
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
> index ffd84f0..42af90a 100644
> --- a/kexec/arch/x86_64/kexec-x86_64.c
> +++ b/kexec/arch/x86_64/kexec-x86_64.c
> @@ -188,3 +188,8 @@ void arch_update_purgatory(struct kexec_info *info)
>   	elf_rel_set_symbol(&info->rhdr, "panic_kernel",
>   				&panic_kernel, sizeof(panic_kernel));
>   }
> +
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> index 73e5254..4675c46 100644
> --- a/kexec/kexec-syscall.h
> +++ b/kexec/kexec-syscall.h
> @@ -112,7 +112,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
>   
>   #define KEXEC_ON_CRASH		0x00000001
>   #define KEXEC_PRESERVE_CONTEXT	0x00000002
> -#define KEXEC_UPDATE_ELFCOREHDR	0x00000004
> +#define KEXEC_CRASH_HOTPLUG_SUPPORT	0x00000008
>   #define KEXEC_ARCH_MASK		0xffff0000
>   
>   /* Flags for kexec file based system call */
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 222f79e..034cea6 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -701,10 +701,13 @@ static void update_purgatory(struct kexec_info *info)
>   			continue;
>   		}
>   
> -		/* Don't include elfcorehdr in the checksum, if hotplug
> -		 * support enabled.
> +		/*
> +		 * Let architecture decide which segments to exclude from checksum
> +		 * if hotplug support is enabled.
>   		 */
> -		if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
> +		if (do_hotplug && arch_do_exclude_segment(&info->segment[i], info)) {
> +			dbgprintf("Skipping segment mem: 0x%lx from SHA calculation\n",
> +				  (unsigned long)info->segment[i].mem);
>   			continue;
>   		}
>   
> @@ -1651,7 +1654,6 @@ int main(int argc, char *argv[])
>   		die("--load-live-update can only be used with xen\n");
>   	}
>   
> -	/* NOTE: Xen KEXEC_LIVE_UPDATE and KEXEC_UPDATE_ELFCOREHDR collide */
>   	if (do_hotplug) {
>   		const char *ces = "/sys/kernel/crash_elfcorehdr_size";
>   		char *buf, *endptr = NULL;
> @@ -1665,8 +1667,8 @@ int main(int argc, char *argv[])
>   		if (!elfcorehdrsz || (endptr && *endptr != '\0'))
>   			die("Path %s does not exist, the kernel needs CONFIG_CRASH_HOTPLUG\n", ces);
>   		dbgprintf("ELFCOREHDR_SIZE %lu\n", elfcorehdrsz);
> -		/* Indicate to the kernel it is ok to modify the elfcorehdr */
> -		kexec_flags |= KEXEC_UPDATE_ELFCOREHDR;
> +		/* Indicate to the kernel it is ok to modify the relevant kexec segments */
> +		kexec_flags |= KEXEC_CRASH_HOTPLUG_SUPPORT;
>   	}
>   
>   	fileind = optind;
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index 1004aff..2d758c9 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -307,6 +307,8 @@ extern int do_hotplug;
>   #define BOOTLOADER_VERSION PACKAGE_VERSION
>   
>   void arch_usage(void);
> +/* Return non-zero if segment needs to be excluded from SHA calculation, else 0. */
> +int arch_do_exclude_segment(struct kexec_segment *seg_ptr, struct kexec_info *info);
>   int arch_process_options(int argc, char **argv);
>   int arch_compat_trampoline(struct kexec_info *info);
>   void arch_update_purgatory(struct kexec_info *info);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A51C27C5E
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 09:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rWaoahlhBJ7ETLBfG0O8AzXBlG8UMR+zsujJFBK90f8=; b=SLK+970kmLDx/W
	934m4SjIhmOs0kjaIFa4a7CGTDn5xSLZ0tF8tcswVxk78MPUysXslvvKLshIjfKibPIFpfY+CTU5w
	EWhl8zNSNpyT1AjjuF10ccssSj7AM+tVBrAmJynQNJhTogCdEutDSCpo+8L62G7vCG0TZ2Sz+fILO
	3Pq1xX0IssGVsUxMJZ1KAawj3L1WEsavYf249dheoFBUTZbBE4jQI3JxNFukCNJ9akY9P9KyaLSkG
	a1DHXIgDmvGWOC+VNUUQl6Gc70OkhYNpBedVjIb+D8n/DLnRaOC/LkNeLXtGqlktLMIAL+ujwBqw1
	kcOomb4TiywF8rhWOqLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGb6w-00000004Q8F-43r9;
	Mon, 10 Jun 2024 09:14:42 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGb6t-00000004Q7T-3YjW
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 09:14:41 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A8wd9o018275
	for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 09:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=4
	Ul7CiJP4J/2JTX/Km1kQPXBgq2JbBfbSeeX39SonYo=; b=kP8hnZMcK38k3xqsV
	ErncF0xPB1EMgZK5yG6IjDEdLxUwav60ULt+xsNHzCmtTFzLrx1P57WF9DXBw0Ll
	6lUhk6+UJSqV+6NgrbcsRrpmBPZXQuKazJ5Ry6H0wFJIZewwE4+o1qPHBWdMhuon
	fsUhr+ZvQdWhjbR8Ev+cRl85Zg3HqBNxPJw64FTLzU+Jia59kuto7lH3M1mPygQs
	IbWOnYZgm3aq5cNjVrSXey2WC5lxcLGcmyYrCdKzmfyUcFLn0a+SzAi20GOJ/vIq
	u86/meRrk4cA2f5Ppw86k92my7CVMX15Uy9l1+dBFRpStqoX9lfTniw0uEhjVusT
	QsHSQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynxerr14t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 09:14:37 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45A9Ea1r011188
	for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 09:14:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynxerr14q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 09:14:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45A7GIIZ003886;
	Mon, 10 Jun 2024 08:52:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn2mpej4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 08:52:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45A8qLGt24445630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 08:52:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE2602004D;
	Mon, 10 Jun 2024 08:52:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAF8E2004B;
	Mon, 10 Jun 2024 08:52:20 +0000 (GMT)
Received: from [9.203.115.195] (unknown [9.203.115.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Jun 2024 08:52:20 +0000 (GMT)
Message-ID: <2373f9fb-5601-4a58-894d-8f9ca84d8834@linux.ibm.com>
Date: Mon, 10 Jun 2024 14:22:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] kexec_load: Use new kexec flag for hotplug support
To: Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org
Cc: Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>
References: <20240522131353.198327-1-sourabhjain@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20240522131353.198327-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lfIsitxDdS1SS8foieDwaw5o6QiNqAK3
X-Proofpoint-ORIG-GUID: qFls9RgDznbLswGJMoFp1efvWlkUegH3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100067
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_021440_287627_725E9AF2 
X-CRM114-Status: GOOD (  26.31  )
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



On 22/05/24 6:43 pm, Sourabh Jain wrote:
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
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
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
> index 32a42d2..9a50ff6 100644
> --- a/kexec/arch/loongarch/kexec-loongarch.c
> +++ b/kexec/arch/loongarch/kexec-loongarch.c
> @@ -378,3 +378,8 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
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

This should also be similar to i386, no?
Except for that, rest looks good..

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

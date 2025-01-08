Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084D0E77188
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 17:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yyOPD9qcVaUXHHE2IbrdGoE4thHZzJpL1nlCYWWtVlA=; b=X8+FtEGB6khpnXjld3/dJSHh76
	6vkdGPqjdlT27kLVD8tIA5YgAbRUH+llC/Npkx3EE4EZHOUAEhSfbffYaTXEyOggRsGP9ZYyaoerc
	keAcS1ZZNIJiJTI9bpka9VlRg0KVW7/T/QjYsTvg5E8d6Y4A4r0RKguL/YO8ljvZ61AHw0sUmEy68
	G28W+8iT+hwUu88UjncRA69odvhDeueWnDMIIJvPtKPxG7WjlYHNR+ruVFZahdKHFYFi9sQpFUUPo
	HRzHJHIKyNgzJQjh5bWMEFEyDiQlJnCydl2Sf2hVX+TCGHMcH6n062tsCboNBL0hDUO0MoVCP+PNe
	l9+QP8oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVZxs-00000009P59-2sRW;
	Wed, 08 Jan 2025 17:35:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVZVG-00000009Jcc-2jNB
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 17:05:59 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508CHKZf026786;
	Wed, 8 Jan 2025 17:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=yyOPD9qcVaUXHHE2IbrdG
	oE4thHZzJpL1nlCYWWtVlA=; b=UmlA6/a1xq0D4fbVq219CeBj9e2KhZBl7MlPo
	DvrF+zVE5hEjuR0gN8Vn4e00q/7XXIWXfLDa6ZqGFBUtBr4m/mTfXzmEFakjXm0C
	m75+1RmCbLZ2fq9KcfZBMkorRqHD3MY5Casbk54PRWvmC2xL3dX18a8tL565aAwV
	DyF7cTv+BfuTWI511vf0fgTP36GLHBTwtRbLtzx/zCQT1IGgdIK8rWvP9WtXq9mb
	fuLfmdLPj9XUoYMumKZOI5xf4AFMH3XNkUz0tYKJ2do1SwLIYUDeGTOkZa21vsQ9
	dHYkvzaRs2SMRP5JxA3k4oQD60v58ARrup3PTBmVCMicbLIhg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441e3b43xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 17:05:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508GVGNJ008861;
	Wed, 8 Jan 2025 17:05:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfq00xw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 17:05:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508H5jJl64160230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 17:05:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 086B920043;
	Wed,  8 Jan 2025 17:05:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A63F520040;
	Wed,  8 Jan 2025 17:05:42 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.20.94])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jan 2025 17:05:42 +0000 (GMT)
Date: Wed, 8 Jan 2025 22:35:36 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
        Baoquan he <bhe@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v1 4/5] powerpc/crash: use generic crashkernel
 reservation
Message-ID: <dgn3qq2q35rjem3lm33k646tl7ucxghwnvttplr4fdk35aftfx@2tzxh6ku5m3d>
References: <20250108101458.406806-1-sourabhjain@linux.ibm.com>
 <20250108101458.406806-5-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108101458.406806-5-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2gBREeBZTiWbtcfDwpoa7ZKrEaVUoORI
X-Proofpoint-GUID: 2gBREeBZTiWbtcfDwpoa7ZKrEaVUoORI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_090558_812169_6AD47D3A 
X-CRM114-Status: GOOD (  29.48  )
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
Reply-To: mahesh@linux.ibm.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2025-01-08 15:44:57 Wed, Sourabh Jain wrote:
> Commit 0ab97169aa05 ("crash_core: add generic function to do
> reservation") added a generic function to reserve crashkernel memory.
> So let's use the same function on powerpc and remove the
> architecture-specific code that essentially does the same thing.
> 
> The generic crashkernel reservation also provides a way to split the
> crashkernel reservation into high and low memory reservations, which can
> be enabled for powerpc in the future.
> 
> Along with moving to the generic crashkernel reservation, the code
> related to finding the base address for the crashkernel has been
> separated into its own function name get_crash_base() for better
> readability and maintainability.
> 
> To prevent crashkernel memory from being added to iomem_resource, the
> function arch_add_crash_res_to_iomem() has been introduced. For further
> details on why this should not be done for the PowerPC architecture,
> please refer to the previous commit titled "crash: let arch decide crash
> memory export to iomem_resource.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> CC: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig                     |  3 +
>  arch/powerpc/include/asm/crash_reserve.h | 18 +++++
>  arch/powerpc/include/asm/kexec.h         |  4 +-
>  arch/powerpc/kernel/prom.c               |  2 +-
>  arch/powerpc/kexec/core.c                | 90 ++++++++++--------------
>  5 files changed, 63 insertions(+), 54 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/crash_reserve.h
[...]
> @@ -113,9 +113,9 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt, struct crash_mem
>  
>  #ifdef CONFIG_CRASH_RESERVE
>  int __init overlaps_crashkernel(unsigned long start, unsigned long size);
> -extern void reserve_crashkernel(void);
> +extern void arch_reserve_crashkernel(void);

Do we really need to rename this ? it is still called from powepc arch
and not from the common code.

>  #else
> -static inline void reserve_crashkernel(void) {}
> +static inline void arch_reserve_crashkernel(void) {}
>  static inline int overlaps_crashkernel(unsigned long start, unsigned long size) { return 0; }
>  #endif
>  
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index e0059842a1c6..9ed9dde7d231 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -860,7 +860,7 @@ void __init early_init_devtree(void *params)
>  	 */
>  	if (fadump_reserve_mem() == 0)
>  #endif
> -		reserve_crashkernel();
> +		arch_reserve_crashkernel();
>  	early_reserve_mem();
>  
>  	if (memory_limit > memblock_phys_mem_size())

Rest looks good to me.

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Thanks,
-Mahesh.


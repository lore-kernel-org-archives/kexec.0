Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E93C02182
	for <kexec@archiver.kernel.org>; Thu, 23 Jan 2025 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QaHVpUMF9VvRhgT1Viq55MNbD/fhTLmDZvPpd9WdkmQ=; b=WvVHNvqetbbPkpx0PqYMXcD2VP
	R0f70FHx0vg64QqZuMHjQdqEExRoIWrSeIb0Bvsxy0w7WchrEKJ08KIkkw4oBCkjl4abaEgKZFk5u
	NrPyK3zQjyJlG8PGFX2iY8rm6xJURgB0d4v+8QxeXfnWkl8BKq/PDoeDw4NBw3wKLDy4hibEpY6bp
	Yw2JZuBVKcYSOsv/sNzxs0cVWm5IvxeJBni5C5fGH8h2CFejON8EdpK4lp4te/ihQ2rHXoz25aUhL
	QULEp1vbvacFVxuti1fAaODDtM5PcuIm3oWZR9VaEx/Qvk64w/CXr/rkmZqzWgswfW5aKoTHE+/ga
	3R9r0rJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tauSJ-0000000CCv5-2sN6;
	Thu, 23 Jan 2025 10:28:59 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tauDa-0000000CAhA-1AZN
	for kexec@lists.infradead.org;
	Thu, 23 Jan 2025 10:13:47 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N3dFSc027470;
	Thu, 23 Jan 2025 10:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QaHVpU
	MF9VvRhgT1Viq55MNbD/fhTLmDZvPpd9WdkmQ=; b=H1SY72l3gCDz2hcssOccg6
	7IT5xTWgLNUxM3GnStFmW5/Tuiqlxew6A4EvGh1GAjhoKacmZI+Ef4pdyWAvrJy0
	4+pgd42jCrpTVA9DKVsScLengsilBJTNFwzOHAdoI4Ztdl4BGhREQklO0Y1Hpv6j
	IBQkdHNbSRlq8D+eUi/R8cwjHQ2KjjRcXpJFcSuA7SuYfeAF4VV2pJoJUg27fKlN
	P4FPSKwA26EYGnXgIamKhIeFHuDeKovNWtp0p//QEUT8XALBQaVefZRcSA6DEDWh
	uYZwP+mzr4YQFLZvfrrHysFdk5VLp4ypZhgjdWAn89/nG9XiW9bZlMR/RRIPCf/A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44b2xymt8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:13:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NA0INY024268;
	Thu, 23 Jan 2025 10:13:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0yd59k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:13:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NADXj960555546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 10:13:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 230FF201BE;
	Thu, 23 Jan 2025 10:13:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9424F201BD;
	Thu, 23 Jan 2025 10:13:31 +0000 (GMT)
Received: from [9.203.114.244] (unknown [9.203.114.244])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 10:13:31 +0000 (GMT)
Message-ID: <bb1f886a-137c-4262-a0c5-417d7063b563@linux.ibm.com>
Date: Thu, 23 Jan 2025 15:43:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] crash: remove an unused argument from
 reserve_crashkernel_generic()
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
References: <20250121115442.1278458-1-sourabhjain@linux.ibm.com>
 <20250121115442.1278458-3-sourabhjain@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20250121115442.1278458-3-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C9IR5QyMKH82KJiP0QCTHbVBDJ29JWgn
X-Proofpoint-ORIG-GUID: C9IR5QyMKH82KJiP0QCTHbVBDJ29JWgn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501230076
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_021346_351640_2D212E3D 
X-CRM114-Status: GOOD (  19.91  )
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



On 21/01/25 5:24 pm, Sourabh Jain wrote:
> cmdline argument is not used in reserve_crashkernel_generic() so remove
> it. Correspondingly, all the callers have been updated as well.
> 
> No functional change intended.
> 

Looks good to me.

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>   arch/arm64/mm/init.c          |  6 ++----
>   arch/loongarch/kernel/setup.c |  5 ++---
>   arch/riscv/mm/init.c          |  6 ++----
>   arch/x86/kernel/setup.c       |  6 ++----
>   include/linux/crash_reserve.h | 11 +++++------
>   kernel/crash_reserve.c        |  9 ++++-----
>   6 files changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9c0b8d9558fc..6c5a1ee4b5d3 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -98,21 +98,19 @@ static void __init arch_reserve_crashkernel(void)
>   {
>   	unsigned long long low_size = 0;
>   	unsigned long long crash_base, crash_size;
> -	char *cmdline = boot_command_line;
>   	bool high = false;
>   	int ret;
>   
>   	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
>   		return;
>   
> -	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> +	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>   				&crash_size, &crash_base,
>   				&low_size, &high);
>   	if (ret)
>   		return;
>   
> -	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
> -				    low_size, high);
> +	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
>   }
>   
>   static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index 56934fe58170..ece9c4266c3f 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -259,18 +259,17 @@ static void __init arch_reserve_crashkernel(void)
>   	int ret;
>   	unsigned long long low_size = 0;
>   	unsigned long long crash_base, crash_size;
> -	char *cmdline = boot_command_line;
>   	bool high = false;
>   
>   	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
>   		return;
>   
> -	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> +	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>   				&crash_size, &crash_base, &low_size, &high);
>   	if (ret)
>   		return;
>   
> -	reserve_crashkernel_generic(cmdline, crash_size, crash_base, low_size, high);
> +	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
>   }
>   
>   static void __init fdt_setup(void)
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 8d167e09f1fe..16b81beb41bf 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1392,21 +1392,19 @@ static void __init arch_reserve_crashkernel(void)
>   {
>   	unsigned long long low_size = 0;
>   	unsigned long long crash_base, crash_size;
> -	char *cmdline = boot_command_line;
>   	bool high = false;
>   	int ret;
>   
>   	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
>   		return;
>   
> -	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> +	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>   				&crash_size, &crash_base,
>   				&low_size, &high);
>   	if (ret)
>   		return;
>   
> -	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
> -				    low_size, high);
> +	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
>   }
>   
>   void __init paging_init(void)
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index f1fea506e20f..15b6823556c8 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -469,14 +469,13 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>   static void __init arch_reserve_crashkernel(void)
>   {
>   	unsigned long long crash_base, crash_size, low_size = 0;
> -	char *cmdline = boot_command_line;
>   	bool high = false;
>   	int ret;
>   
>   	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
>   		return;
>   
> -	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> +	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>   				&crash_size, &crash_base,
>   				&low_size, &high);
>   	if (ret)
> @@ -487,8 +486,7 @@ static void __init arch_reserve_crashkernel(void)
>   		return;
>   	}
>   
> -	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
> -				    low_size, high);
> +	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
>   }
>   
>   static struct resource standard_io_resources[] = {
> diff --git a/include/linux/crash_reserve.h b/include/linux/crash_reserve.h
> index 5a9df944fb80..1fe7e7d1b214 100644
> --- a/include/linux/crash_reserve.h
> +++ b/include/linux/crash_reserve.h
> @@ -32,13 +32,12 @@ int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
>   #define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
>   #endif
>   
> -void __init reserve_crashkernel_generic(char *cmdline,
> -		unsigned long long crash_size,
> -		unsigned long long crash_base,
> -		unsigned long long crash_low_size,
> -		bool high);
> +void __init reserve_crashkernel_generic(unsigned long long crash_size,
> +					unsigned long long crash_base,
> +					unsigned long long crash_low_size,
> +					bool high);
>   #else
> -static inline void __init reserve_crashkernel_generic(char *cmdline,
> +static inline void __init reserve_crashkernel_generic(
>   		unsigned long long crash_size,
>   		unsigned long long crash_base,
>   		unsigned long long crash_low_size,
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index a620fb4b2116..aff7c0fdbefa 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -375,11 +375,10 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>   	return 0;
>   }
>   
> -void __init reserve_crashkernel_generic(char *cmdline,
> -			     unsigned long long crash_size,
> -			     unsigned long long crash_base,
> -			     unsigned long long crash_low_size,
> -			     bool high)
> +void __init reserve_crashkernel_generic(unsigned long long crash_size,
> +					unsigned long long crash_base,
> +					unsigned long long crash_low_size,
> +					bool high)
>   {
>   	unsigned long long search_end = CRASH_ADDR_LOW_MAX, search_base = 0;
>   	bool fixed_base = false;



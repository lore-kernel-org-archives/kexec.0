Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304C5106ACD5
	for <kexec@archiver.kernel.org>; Thu, 12 Mar 2026 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tZmQbfXf+Lgob+7frmXyRxRYgF+3y9QeIVRGctrQpL4=; b=kFUX62haWe0148TaDBzgm4dq6K
	5Ft4tmyTAqPIZ84R0d5xkFgbX06jlpO2ZLsyXItZAmmWzAro2zlU+ib3T7UVCaP2HGY/MVDp3AAXU
	HWe/z7Yap1s1ERNc7wCq8CumZzifzhs0nv76ltjmW+NaTWrlHCE+1djGAU+XOHLJFxfZYM+7IjF5f
	ijfuQBBzKRRWPVfdoBF0ZouQsV7rcX9YIRBwq2yPTdy+sO5Ah89vR/g+Pie/Nq4fP5lvyaF4mDRW5
	C0lD6m93MQ/1aSuiLxrOVwEGlk1jRgwxvKhqzOdXOU9GO4gYSFbrYBrq2Zn3tMSvJCxB+bPhq+I0t
	w3JOCj2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0jAT-0000000Ec96-37yP;
	Thu, 12 Mar 2026 16:45:49 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwwEy-0000000CJpY-35Es;
	Mon, 02 Mar 2026 05:54:50 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6225Tmc7141670;
	Mon, 2 Mar 2026 05:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tZmQbf
	Xf+Lgob+7frmXyRxRYgF+3y9QeIVRGctrQpL4=; b=CxeZNy+uKOTUGj1+g7FBkl
	hO9LII3uYsjWsVBEYw+/JI3c9S40Bm9M6Dq4xvjC8znsUIOMnIXoXUTquOnjIstI
	QNbwyrHOUzIfD4YPmnw6LBbQrBhrVnemVVZBYKMsps1OVzThKrowRk1vTqbLBA4c
	jRsDe6etEn+QR05rUlL5LqXV/gesJc6LnHE/sjTVEeVo8K6ScPo2AdGkMHqorlPj
	pxQHfYczXV57EgwST7ZEtalI44PjeCTxxktEWTlT/DP+BzTikqEv6eOuJtC4J8px
	ZJMy9AXj3/qT+UyPa7Tn2qYZxiQA8GkmQXDxrJLWySqs5kyUyQjN30cjwxcCLIyw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskcn42b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 05:54:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6222GfbA008803;
	Mon, 2 Mar 2026 05:54:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd14658-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 05:54:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6225s0C821889506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 05:54:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C000620049;
	Mon,  2 Mar 2026 05:54:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2969920040;
	Mon,  2 Mar 2026 05:53:49 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 05:53:48 +0000 (GMT)
Message-ID: <04183002-0dbb-46e3-88c5-6bd429ab051e@linux.ibm.com>
Date: Mon, 2 Mar 2026 11:23:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] crash: Exclude crash kernel memory in crash core
To: Jinjie Ruan <ruanjinjie@huawei.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
        saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org,
        pmladek@suse.com, dapeng1.mi@linux.intel.com, kees@kernel.org,
        paulmck@kernel.org, lirongqing@baidu.com, fvdl@google.com,
        rppt@kernel.org, ardb@kernel.org, leitao@debian.org, jbohac@suse.cz,
        cfsworks@gmail.com, osandov@fb.com, tangyouling@kylinos.cn,
        ritesh.list@gmail.com, hbathini@linux.ibm.com, eajames@linux.ibm.com,
        songshuaishuai@tinylab.org, kevin.brodsky@arm.com,
        samuel.holland@sifive.com, vishal.moola@gmail.com,
        junhui.liu@pigmoral.tech, coxu@redhat.com, liaoyuanhong@vivo.com,
        fuqiang.wang@easystack.cn, brgerst@gmail.com, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, kexec@lists.infradead.org
References: <20260302035315.3892241-1-ruanjinjie@huawei.com>
 <20260302035315.3892241-3-ruanjinjie@huawei.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260302035315.3892241-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ueAPtiSSd5pPHRoYC7sDE3WeooudH7cp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA0NyBTYWx0ZWRfX6+yRTIRWq4ia
 +AKnN/1z5tyChPUNRY1PvXQZ8kJywiIxbWTpMggCRkxuMUZzVvpL9s+vnMJsHStwxu9oDvSbyri
 F3a9E+NZlLIMeHoMicJltteO56r78Hf3Zf9RZrMSILFRRgBH5tkshLw1FxcqLO1wQBts2UaZrak
 5CfDiLJiQsCfCZkmDWus82ZgVG5RYJvJpuwTMKUjNeDM8DNTqc0DtFCqFR67fTHY1zYn21rW3HH
 r9uIqQ0iVU0vcWC42tO5HgCjHUyLIRSBCWH0u9ujPRjIetHJSJHPh02av2G5IcmuAzm/k91TQMy
 qwj/eGngFHGkFTEOSyQejtPttDppBuJfI9aHfxdCoC06+VZWlYqNNpyVHIbbj4CuSCQCFAiNa9Y
 4bbwF2GgEF/5NlYHm6TfNSWsYV8/4F8gGYEWcvfMoYIayOdq+XqtFaf1+nqI2Vf4VAROF2klvzY
 ARIKsY55EjEErgbdSLQ==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a525ff cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=Xym5AQag9kXVksbWhf4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4F2fGew1C5xW4-I8OVEzSMPAlVaTWLJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020047
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_215448_799483_817F5622 
X-CRM114-Status: GOOD (  29.44  )
X-Mailman-Approved-At: Thu, 12 Mar 2026 09:45:47 -0700
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


Changes look good to me:

Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

On 02/03/26 09:23, Jinjie Ruan wrote:
> The crash memory alloc, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> handling them in the crash core would eliminate a lot of duplication, so
> do them in the common code.
>
> To achieve the above goal, three architecture-specific functions are
> introduced:
>
> - arch_get_system_nr_ranges(). Pre-counts the max number of memory ranges.
>
> - arch_crash_populate_cmem(). Collects the memory ranges and fills them
>    into cmem.
>
> - arch_crash_exclude_ranges(). Architecture's additional crash memory
>    ranges exclusion, defaulting to empty.
>
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   arch/arm64/kernel/machine_kexec_file.c     | 39 +++-------
>   arch/loongarch/kernel/machine_kexec_file.c | 39 +++-------
>   arch/riscv/kernel/machine_kexec_file.c     | 38 +++------
>   arch/x86/kernel/crash.c                    | 89 +++-------------------
>   include/linux/crash_core.h                 |  5 ++
>   kernel/crash_core.c                        | 82 +++++++++++++++++++-
>   6 files changed, 132 insertions(+), 160 deletions(-)
>
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index fba260ad87a9..c338506a580b 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -40,23 +40,23 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>   }
>   
>   #ifdef CONFIG_CRASH_DUMP
> -static int prepare_elf_headers(void **addr, unsigned long *sz)
> +unsigned int arch_get_system_nr_ranges(void)
>   {
> -	struct crash_mem *cmem;
> -	unsigned int nr_ranges;
> -	int ret;
> -	u64 i;
> +	unsigned int nr_ranges = 2; /* for exclusion of crashkernel region */
>   	phys_addr_t start, end;
> +	u64 i;
>   
> -	nr_ranges = 2; /* for exclusion of crashkernel region */
>   	for_each_mem_range(i, &start, &end)
>   		nr_ranges++;
>   
> -	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
> -	if (!cmem)
> -		return -ENOMEM;
> +	return nr_ranges;
> +}
> +
> +int arch_crash_populate_cmem(struct crash_mem *cmem)
> +{
> +	phys_addr_t start, end;
> +	u64 i;
>   
> -	cmem->max_nr_ranges = nr_ranges;
>   	cmem->nr_ranges = 0;
>   	for_each_mem_range(i, &start, &end) {
>   		cmem->ranges[cmem->nr_ranges].start = start;
> @@ -64,22 +64,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>   		cmem->nr_ranges++;
>   	}
>   
> -	/* Exclude crashkernel region */
> -	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> -	if (ret)
> -		goto out;
> -
> -	if (crashk_low_res.end) {
> -		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
> -
> -out:
> -	kfree(cmem);
> -	return ret;
> +	return 0;
>   }
>   #endif
>   
> @@ -109,7 +94,7 @@ int load_other_segments(struct kimage *image,
>   	void *headers;
>   	unsigned long headers_sz;
>   	if (image->type == KEXEC_TYPE_CRASH) {
> -		ret = prepare_elf_headers(&headers, &headers_sz);
> +		ret = crash_prepare_headers(true, &headers, &headers_sz, NULL);
>   		if (ret) {
>   			pr_err("Preparing elf core header failed\n");
>   			goto out_err;
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
> index 5584b798ba46..4b318a94b564 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -56,23 +56,23 @@ static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmpl
>   }
>   
>   #ifdef CONFIG_CRASH_DUMP
> -
> -static int prepare_elf_headers(void **addr, unsigned long *sz)
> +unsigned int arch_get_system_nr_ranges(void)
>   {
> -	int ret, nr_ranges;
> -	uint64_t i;
> +	int nr_ranges = 2; /* for exclusion of crashkernel region */
>   	phys_addr_t start, end;
> -	struct crash_mem *cmem;
> +	uint64_t i;
>   
> -	nr_ranges = 2; /* for exclusion of crashkernel region */
>   	for_each_mem_range(i, &start, &end)
>   		nr_ranges++;
>   
> -	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
> -	if (!cmem)
> -		return -ENOMEM;
> +	return nr_ranges;
> +}
> +
> +int arch_crash_populate_cmem(struct crash_mem *cmem)
> +{
> +	phys_addr_t start, end;
> +	uint64_t i;
>   
> -	cmem->max_nr_ranges = nr_ranges;
>   	cmem->nr_ranges = 0;
>   	for_each_mem_range(i, &start, &end) {
>   		cmem->ranges[cmem->nr_ranges].start = start;
> @@ -80,22 +80,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>   		cmem->nr_ranges++;
>   	}
>   
> -	/* Exclude crashkernel region */
> -	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> -	if (ret < 0)
> -		goto out;
> -
> -	if (crashk_low_res.end) {
> -		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> -		if (ret < 0)
> -			goto out;
> -	}
> -
> -	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
> -
> -out:
> -	kfree(cmem);
> -	return ret;
> +	return 0;
>   }
>   
>   /*
> @@ -163,7 +148,7 @@ int load_other_segments(struct kimage *image,
>   		void *headers;
>   		unsigned long headers_sz;
>   
> -		ret = prepare_elf_headers(&headers, &headers_sz);
> +		ret = crash_prepare_headers(true, &headers, &headers_sz, NULL);
>   		if (ret < 0) {
>   			pr_err("Preparing elf core header failed\n");
>   			goto out_err;
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
> index 54e2d9552e93..d0e331d87155 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -44,6 +44,15 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>   	return 0;
>   }
>   
> +unsigned int arch_get_system_nr_ranges(void)
> +{
> +	unsigned int nr_ranges = 1; /* For exclusion of crashkernel region */
> +
> +	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> +
> +	return nr_ranges;
> +}
> +
>   static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>   {
>   	struct crash_mem *cmem = arg;
> @@ -55,33 +64,10 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>   	return 0;
>   }
>   
> -static int prepare_elf_headers(void **addr, unsigned long *sz)
> +int arch_crash_populate_cmem(struct crash_mem *cmem)
>   {
> -	struct crash_mem *cmem;
> -	unsigned int nr_ranges;
> -	int ret;
> -
> -	nr_ranges = 1; /* For exclusion of crashkernel region */
> -	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> -
> -	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
> -	if (!cmem)
> -		return -ENOMEM;
> -
> -	cmem->max_nr_ranges = nr_ranges;
>   	cmem->nr_ranges = 0;
> -	ret = walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
> -	if (ret)
> -		goto out;
> -
> -	/* Exclude crashkernel region */
> -	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> -	if (!ret)
> -		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
> -
> -out:
> -	kfree(cmem);
> -	return ret;
> +	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
>   }
>   
>   static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
> @@ -273,7 +259,7 @@ int load_extra_segments(struct kimage *image, unsigned long kernel_start,
>   	if (image->type == KEXEC_TYPE_CRASH) {
>   		void *headers;
>   		unsigned long headers_sz;
> -		ret = prepare_elf_headers(&headers, &headers_sz);
> +		ret = crash_prepare_headers(true, &headers, &headers_sz, NULL);
>   		if (ret) {
>   			pr_err("Preparing elf core header failed\n");
>   			goto out;
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 335fd2ee9766..3ad3f8b758a4 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -152,16 +152,8 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>   	return 0;
>   }
>   
> -/* Gather all the required information to prepare elf headers for ram regions */
> -static struct crash_mem *fill_up_crash_elf_data(void)
> +unsigned int arch_get_system_nr_ranges(void)
>   {
> -	unsigned int nr_ranges = 0;
> -	struct crash_mem *cmem;
> -
> -	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> -	if (!nr_ranges)
> -		return NULL;
> -
>   	/*
>   	 * Exclusion of crash region, crashk_low_res and/or crashk_cma_ranges
>   	 * may cause range splits. So add extra slots here.
> @@ -176,49 +168,16 @@ static struct crash_mem *fill_up_crash_elf_data(void)
>   	 * But in order to lest the low 1M could be changed in the future,
>   	 * (e.g. [start, 1M]), add a extra slot.
>   	 */
> -	nr_ranges += 3 + crashk_cma_cnt;
> -	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
> -	if (!cmem)
> -		return NULL;
> -
> -	cmem->max_nr_ranges = nr_ranges;
> +	unsigned int nr_ranges = 3 + crashk_cma_cnt;
>   
> -	return cmem;
> +	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> +	return nr_ranges;
>   }
>   
> -/*
> - * Look for any unwanted ranges between mstart, mend and remove them. This
> - * might lead to split and split ranges are put in cmem->ranges[] array
> - */
> -static int elf_header_exclude_ranges(struct crash_mem *cmem)
> +int arch_crash_exclude_ranges(struct crash_mem *cmem)
>   {
> -	int ret = 0;
> -	int i;
> -
>   	/* Exclude the low 1M because it is always reserved */
> -	ret = crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
> -	if (ret)
> -		return ret;
> -
> -	/* Exclude crashkernel region */
> -	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> -	if (ret)
> -		return ret;
> -
> -	if (crashk_low_res.end)
> -		ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
> -					      crashk_low_res.end);
> -	if (ret)
> -		return ret;
> -
> -	for (i = 0; i < crashk_cma_cnt; ++i) {
> -		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
> -					      crashk_cma_ranges[i].end);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> +	return crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
>   }
>   
>   static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
> @@ -232,35 +191,9 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>   	return 0;
>   }
>   
> -/* Prepare elf headers. Return addr and size */
> -static int prepare_elf_headers(void **addr, unsigned long *sz,
> -			       unsigned long *nr_mem_ranges)
> +int arch_crash_populate_cmem(struct crash_mem *cmem)
>   {
> -	struct crash_mem *cmem;
> -	int ret;
> -
> -	cmem = fill_up_crash_elf_data();
> -	if (!cmem)
> -		return -ENOMEM;
> -
> -	ret = walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
> -	if (ret)
> -		goto out;
> -
> -	/* Exclude unwanted mem ranges */
> -	ret = elf_header_exclude_ranges(cmem);
> -	if (ret)
> -		goto out;
> -
> -	/* Return the computed number of memory ranges, for hotplug usage */
> -	*nr_mem_ranges = cmem->nr_ranges;
> -
> -	/* By default prepare 64bit headers */
> -	ret = crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
> -
> -out:
> -	vfree(cmem);
> -	return ret;
> +	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
>   }
>   #endif
>   
> @@ -418,7 +351,8 @@ int crash_load_segments(struct kimage *image)
>   				  .buf_max = ULONG_MAX, .top_down = false };
>   
>   	/* Prepare elf headers and add a segment */
> -	ret = prepare_elf_headers(&kbuf.buffer, &kbuf.bufsz, &pnum);
> +	ret = crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &kbuf.buffer,
> +				    &kbuf.bufsz, &pnum);
>   	if (ret)
>   		return ret;
>   
> @@ -529,7 +463,8 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>   	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>   	 * memory resources.
>   	 */
> -	if (prepare_elf_headers(&elfbuf, &elfsz, &nr_mem_ranges)) {
> +	if (crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz,
> +				  &nr_mem_ranges)) {
>   		pr_err("unable to create new elfcorehdr");
>   		goto out;
>   	}
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index d35726d6a415..033b20204aca 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -66,6 +66,8 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
>   				   unsigned long long mend);
>   extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>   				       void **addr, unsigned long *sz);
> +extern int crash_prepare_headers(int need_kernel_map, void **addr,
> +				 unsigned long *sz, unsigned long *nr_mem_ranges);
>   
>   struct kimage;
>   struct kexec_segment;
> @@ -83,6 +85,9 @@ int kexec_should_crash(struct task_struct *p);
>   int kexec_crash_loaded(void);
>   void crash_save_cpu(struct pt_regs *regs, int cpu);
>   extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
> +extern unsigned int arch_get_system_nr_ranges(void);
> +extern int arch_crash_populate_cmem(struct crash_mem *cmem);
> +extern int arch_crash_exclude_ranges(struct crash_mem *cmem);
>   
>   #else /* !CONFIG_CRASH_DUMP*/
>   struct pt_regs;
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 2c1a3791e410..96a96e511f5a 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -170,9 +170,6 @@ static inline resource_size_t crash_resource_size(const struct resource *res)
>   	return !res->end ? 0 : resource_size(res);
>   }
>   
> -
> -
> -
>   int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>   			  void **addr, unsigned long *sz)
>   {
> @@ -274,6 +271,85 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>   	return 0;
>   }
>   
> +static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
> +{
> +	struct crash_mem *cmem;
> +
> +	cmem = kvzalloc_flex(*cmem, ranges, nr_ranges);
> +	if (!cmem)
> +		return NULL;
> +
> +	cmem->max_nr_ranges = nr_ranges;
> +	return cmem;
> +}
> +
> +unsigned int __weak arch_get_system_nr_ranges(void) { return 0; }
> +int __weak arch_crash_populate_cmem(struct crash_mem *cmem) { return -1; }
> +int __weak arch_crash_exclude_ranges(struct crash_mem *cmem) { return 0; }
> +
> +static int crash_exclude_core_ranges(struct crash_mem *cmem)
> +{
> +	int ret, i;
> +
> +	/* Exclude crashkernel region */
> +	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> +	if (ret)
> +		return ret;
> +
> +	if (crashk_low_res.end) {
> +		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < crashk_cma_cnt; ++i) {
> +		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
> +					      crashk_cma_ranges[i].end);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
> +			  unsigned long *nr_mem_ranges)
> +{
> +	unsigned int max_nr_ranges;
> +	struct crash_mem *cmem;
> +	int ret;
> +
> +	max_nr_ranges = arch_get_system_nr_ranges();
> +	if (!max_nr_ranges)
> +		return -ENOMEM;
> +
> +	cmem = alloc_cmem(max_nr_ranges);
> +	if (!cmem)
> +		return -ENOMEM;
> +
> +	ret = arch_crash_populate_cmem(cmem);
> +	if (ret)
> +		goto out;
> +
> +	ret = crash_exclude_core_ranges(cmem);
> +	if (ret)
> +		goto out;
> +
> +	ret = arch_crash_exclude_ranges(cmem);
> +	if (ret)
> +		goto out;
> +
> +	/* Return the computed number of memory ranges, for hotplug usage */
> +	if (nr_mem_ranges)
> +		*nr_mem_ranges = cmem->nr_ranges;
> +
> +	ret = crash_prepare_elf64_headers(cmem, need_kernel_map, addr, sz);
> +
> +out:
> +	kvfree(cmem);
> +	return ret;
> +}
> +
>   /**
>    * crash_exclude_mem_range - exclude a mem range for existing ranges
>    * @mem: mem->range contains an array of ranges sorted in ascending order



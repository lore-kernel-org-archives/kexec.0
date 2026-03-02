Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CF8106ACD8
	for <kexec@archiver.kernel.org>; Thu, 12 Mar 2026 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RXfRpY8UMxxOmHGDKB9MNwVYZZszpBs4+WasORA5OW0=; b=XFyv6y6PSQ7gjzkK5rQ5vyLJT8
	ikO1BIflXH+e2q2v6udXShQCPVO7YuGf4mhlZL1U34uPqaE8qxIL19i+9Q0UOcyQbxyzknrZloj+z
	VVVrrcITnVG2SmwvDFRgbDtUFeu5ir1R3/pfc+mBwFkUPNjkKyxXxlxSx2g1o3FseS75FSmcQpmbn
	VvxkFaAfA6+f4XWZWLwW3j6u1aBKM/dqygBKFp2OU+ZQCGohA49xWMMMt0/nvC9WaMjG135uw6gSF
	yIf+eDA/4W6C5kdlEIDgO6KyCk0IWEhusU1ZNp2T/ZZhO3bVeN1V4lis53Bv4/PPGPMc7yY8rVcEO
	LXwUmwUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0jAU-0000000EcA9-0jtB;
	Thu, 12 Mar 2026 16:45:50 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwwK3-0000000CK9H-3Q1k;
	Mon, 02 Mar 2026 06:00:04 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621MR8KR2020243;
	Mon, 2 Mar 2026 05:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RXfRpY
	8UMxxOmHGDKB9MNwVYZZszpBs4+WasORA5OW0=; b=igNw4I9sJQ6ckC0QKTNTg8
	OBxVihkrI6c8vj7gNHna/Gpb4eQaRC6gMHKpm3ijOSwCIuMjov57donQ3k+mVFo2
	dG8haBqrIQbgr4wcgQtqqBayqEXBCjEoF9lShA/zzY5feHMz8NjJeAggfoJcjI5D
	UNiLPvv7+JsFV1udMmNFSsLPLOWjCjhP2yOkvswkehSeFNCOkrJenyha7Qwtuan7
	NvLuttvsDWAXhxPl2T0zT3m3hfQRdUt1sG8VTmYW8VySGQltQWmXxJafMvF6em03
	pXb9oYWkWNWG23Gj6IWfj4pF26FzvtFnQqdqiUAfJSj/HuzUVGQ10mAcMWrUzhxw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbmx3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 05:59:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6224jVJj003266;
	Mon, 2 Mar 2026 05:59:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2xvkw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 05:59:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6225xJK751511590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 05:59:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D50C920049;
	Mon,  2 Mar 2026 05:59:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0ABF120040;
	Mon,  2 Mar 2026 05:59:08 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 05:59:07 +0000 (GMT)
Message-ID: <19bac132-4cf7-42af-9d1e-e3c4fb54168d@linux.ibm.com>
Date: Mon, 2 Mar 2026 11:29:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] crash: Use crash_exclude_core_ranges() on powerpc
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
 <20260302035315.3892241-4-ruanjinjie@huawei.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260302035315.3892241-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: BMZp4xfDlNqh-vX_Fyssc2drEKv9urt9
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a5273d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=OOSq9K7-CKCezHrCz9oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA0NyBTYWx0ZWRfX0EI2bclQv+It
 vamD9NxRO5crMqF/ntjGtSizcDmvwcBC8KcYFhNtRyQ5VVQS6dKJrqvtW1aX42H4R47tyAHWjbJ
 d1EO5RHhhK/QkZbEkAet2yMhkyT5G8/5BkK8hAasgEg10+eduRj/Iw9IMxZUo1inpK+/Q+1l8Cl
 ojSsESxZw88uiXKRssAAdqyh6ycUNO45PLgyiA62PIIFlykFelCHalCDQJ0mTE5JiBFTi0HzIUr
 C8M+EbZ4gQAggC7cuIDaHVT+K1U2x8CVMRYaneG1E9Jg6PnHaSeWUsEMI9Qzt4iVA7hIHoogyMf
 0ZLkmaRYnYP99aFQ9zVLC1yr/pJZfwG3EuPk9DUMC423tx/lOGGiyBqfEq24pJo90CxIOFJCoGH
 L+CCSe9Bj6I5RSRFuYTejCEiA8kMvhT2uoCa8+25eQVSNT8Or3iCnGFEhGvyhg4idfd7d+h3w5/
 0qmBc5/WsxG1EY6RMRA==
X-Proofpoint-GUID: fxuaIa5Xmleq54BLBXxF9sm88Fn-pKzf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020047
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_220003_987163_726DA62A 
X-CRM114-Status: GOOD (  28.09  )
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


Changes look good to me.
I tested this on LPAR and QEMU, and dump capture works fine with these 
changes.
I even tried reserving kdump memory using crashkernel=xxM,cma.

Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>


On 02/03/26 09:23, Jinjie Ruan wrote:
> The crash memory exclude of crashk_res and crashk_cma memory on powerpc
> are almost identical to the generic crash_exclude_core_ranges().
>
> By introducing the architecture-specific arch_crash_exclude_mem_range()
> function with a default implementation of crash_exclude_mem_range(),
> and using crash_exclude_mem_range_guarded as powerpc's separate
> implementation, the generic crash_exclude_core_ranges() helper function
> can be reused.
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   arch/powerpc/include/asm/kexec_ranges.h |  3 ---
>   arch/powerpc/kexec/crash.c              |  2 +-
>   arch/powerpc/kexec/ranges.c             | 16 ++++------------
>   include/linux/crash_core.h              |  4 ++++
>   kernel/crash_core.c                     | 19 +++++++++++++------
>   5 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kexec_ranges.h b/arch/powerpc/include/asm/kexec_ranges.h
> index ad95e3792d10..8489e844b447 100644
> --- a/arch/powerpc/include/asm/kexec_ranges.h
> +++ b/arch/powerpc/include/asm/kexec_ranges.h
> @@ -7,9 +7,6 @@
>   void sort_memory_ranges(struct crash_mem *mrngs, bool merge);
>   struct crash_mem *realloc_mem_ranges(struct crash_mem **mem_ranges);
>   int add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size);
> -int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
> -				    unsigned long long mstart,
> -				    unsigned long long mend);
>   int get_exclude_memory_ranges(struct crash_mem **mem_ranges);
>   int get_reserved_memory_ranges(struct crash_mem **mem_ranges);
>   int get_crash_memory_ranges(struct crash_mem **mem_ranges);
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index 898742a5205c..e59e909c369d 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -451,7 +451,7 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
>   		base_addr = PFN_PHYS(mn->start_pfn);
>   		size = mn->nr_pages * PAGE_SIZE;
>   		end = base_addr + size - 1;
> -		ret = crash_exclude_mem_range_guarded(&cmem, base_addr, end);
> +		ret = arch_crash_exclude_mem_range(&cmem, base_addr, end);
>   		if (ret) {
>   			pr_err("Failed to remove hot-unplugged memory from crash memory ranges\n");
>   			goto out;
> diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
> index 6c58bcc3e130..e5fea23b191b 100644
> --- a/arch/powerpc/kexec/ranges.c
> +++ b/arch/powerpc/kexec/ranges.c
> @@ -553,9 +553,9 @@ int get_usable_memory_ranges(struct crash_mem **mem_ranges)
>   #endif /* CONFIG_KEXEC_FILE */
>   
>   #ifdef CONFIG_CRASH_DUMP
> -int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
> -					   unsigned long long mstart,
> -					   unsigned long long mend)
> +int arch_crash_exclude_mem_range(struct crash_mem **mem_ranges,
> +				 unsigned long long mstart,
> +				 unsigned long long mend)
>   {
>   	struct crash_mem *tmem = *mem_ranges;
>   
> @@ -604,18 +604,10 @@ int get_crash_memory_ranges(struct crash_mem **mem_ranges)
>   			sort_memory_ranges(*mem_ranges, true);
>   	}
>   
> -	/* Exclude crashkernel region */
> -	ret = crash_exclude_mem_range_guarded(mem_ranges, crashk_res.start, crashk_res.end);
> +	ret = crash_exclude_core_ranges(mem_ranges);
>   	if (ret)
>   		goto out;
>   
> -	for (i = 0; i < crashk_cma_cnt; ++i) {
> -		ret = crash_exclude_mem_range_guarded(mem_ranges, crashk_cma_ranges[i].start,
> -					      crashk_cma_ranges[i].end);
> -		if (ret)
> -			goto out;
> -	}
> -
>   	/*
>   	 * FIXME: For now, stay in parity with kexec-tools but if RTAS/OPAL
>   	 *        regions are exported to save their context at the time of
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 033b20204aca..dbec826dc53b 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -68,6 +68,7 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
>   				       void **addr, unsigned long *sz);
>   extern int crash_prepare_headers(int need_kernel_map, void **addr,
>   				 unsigned long *sz, unsigned long *nr_mem_ranges);
> +extern int crash_exclude_core_ranges(struct crash_mem **cmem);
>   
>   struct kimage;
>   struct kexec_segment;
> @@ -88,6 +89,9 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
>   extern unsigned int arch_get_system_nr_ranges(void);
>   extern int arch_crash_populate_cmem(struct crash_mem *cmem);
>   extern int arch_crash_exclude_ranges(struct crash_mem *cmem);
> +extern int arch_crash_exclude_mem_range(struct crash_mem **mem,
> +					unsigned long long mstart,
> +					unsigned long long mend);
>   
>   #else /* !CONFIG_CRASH_DUMP*/
>   struct pt_regs;
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 96a96e511f5a..300d44ad5471 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -287,24 +287,31 @@ unsigned int __weak arch_get_system_nr_ranges(void) { return 0; }
>   int __weak arch_crash_populate_cmem(struct crash_mem *cmem) { return -1; }
>   int __weak arch_crash_exclude_ranges(struct crash_mem *cmem) { return 0; }
>   
> -static int crash_exclude_core_ranges(struct crash_mem *cmem)
> +int __weak arch_crash_exclude_mem_range(struct crash_mem **mem,
> +					unsigned long long mstart,
> +					unsigned long long mend)
> +{
> +	return crash_exclude_mem_range(*mem, mstart, mend);
> +}
> +
> +int crash_exclude_core_ranges(struct crash_mem **cmem)
>   {
>   	int ret, i;
>   
>   	/* Exclude crashkernel region */
> -	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> +	ret = arch_crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
>   	if (ret)
>   		return ret;
>   
>   	if (crashk_low_res.end) {
> -		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> +		ret = arch_crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
>   		if (ret)
>   			return ret;
>   	}
>   
>   	for (i = 0; i < crashk_cma_cnt; ++i) {
> -		ret = crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
> -					      crashk_cma_ranges[i].end);
> +		ret = arch_crash_exclude_mem_range(cmem, crashk_cma_ranges[i].start,
> +						   crashk_cma_ranges[i].end);
>   		if (ret)
>   			return ret;
>   	}
> @@ -331,7 +338,7 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>   	if (ret)
>   		goto out;
>   
> -	ret = crash_exclude_core_ranges(cmem);
> +	ret = crash_exclude_core_ranges(&cmem);
>   	if (ret)
>   		goto out;
>   



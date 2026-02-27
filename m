Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2509FD005C
	for <kexec@archiver.kernel.org>; Sun,  1 Mar 2026 11:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jtWeGYtlIhoBNrUU/Rn3atorlcVCPhoOvUEbiO3QIXw=; b=rLKYlPgLZFDk+jiiyLpOMR2waR
	kdGg/XBO7M2kR58bdQtyWD0jiZx9LChWRoP2ZVs9B9nqFQyBh9AsLZgsn23Pm9zO9BvYd+PfXGRoW
	VBrCeO+lu+3Azy6P5vQyvRquKuxaq73BjNJdBBiQoR17A9syDOeBJDl0/UyYedZvp6YGF0no1ouaN
	2RA88RWi6mwX6MGC9qOyBulCteq5hdA01LOY1pmqS9ZL06RiyHLNK/SJuG6LNDYU7837gzQvGjKyH
	VR6A1ZYEyDO/WjK5+BB2X4JKe32vhshRxXMSHIZHdZO6eHSrBrmWcaW66cR516++AsIO+U/O2XNHx
	HBpgg55g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwfPL-0000000B55Z-2VOg;
	Sun, 01 Mar 2026 11:56:23 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvzBn-00000008WHE-1uqV;
	Fri, 27 Feb 2026 14:51:36 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RDxhAZ1234657;
	Fri, 27 Feb 2026 14:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jtWeGY
	tlIhoBNrUU/Rn3atorlcVCPhoOvUEbiO3QIXw=; b=ByR2b/L5/X53xebYC874SN
	HUg5T4h+cAVrJ6EU3KJMhkisdx64KFdBPRf4Ngk4eCfYjBXIU3lARM5+RnKDCkF/
	xS88gjyrnPJuuAUezDY0ksb8yQtnJA0q4B6chYE3eE9Nymj0w3Y3CV2rpGVOQoJF
	uA3euifftQjmzNNQd4QBHDwFegtEEeQW/UBG0UClfaK4ALFEgkECCz9OOXqrJR3v
	1pb/SLKT+VEXkjtEh/Q4dR7zFSO+eS0ELvx7MzYTivFyg319JhcS2A/vvEe68LbF
	VEiQX2tjyf5yvQEJl5liX/pP+LF1mnLNtudgLXLWCDkbYNEy/kt6r+ZZ6TtGOzMw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4crd6nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 14:50:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61REM4lC001653;
	Fri, 27 Feb 2026 14:50:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1njpn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 14:50:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61REorr350004244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 14:50:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 988E92004B;
	Fri, 27 Feb 2026 14:50:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2724020043;
	Fri, 27 Feb 2026 14:50:36 +0000 (GMT)
Received: from [9.124.211.61] (unknown [9.124.211.61])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 14:50:35 +0000 (GMT)
Message-ID: <3576865b-65bd-4289-babc-975a543eb775@linux.ibm.com>
Date: Fri, 27 Feb 2026 20:20:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] crash: Use crash_exclude_core_ranges() on powerpc
To: Jinjie Ruan <ruanjinjie@huawei.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
        saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, pmladek@suse.com,
        rdunlap@infradead.org, dapeng1.mi@linux.intel.com, kees@kernel.org,
        paulmck@kernel.org, lirongqing@baidu.com, arnd@arndb.de,
        rppt@kernel.org, ardb@kernel.org, leitao@debian.org, jbohac@suse.cz,
        cfsworks@gmail.com, ryan.roberts@arm.com, tangyouling@kylinos.cn,
        ritesh.list@gmail.com, hbathini@linux.ibm.com, eajames@linux.ibm.com,
        songshuaishuai@tinylab.org, samuel.holland@sifive.com,
        kevin.brodsky@arm.com, vishal.moola@gmail.com,
        junhui.liu@pigmoral.tech, coxu@redhat.com, liaoyuanhong@vivo.com,
        brgerst@gmail.com, fuqiang.wang@easystack.cn, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, kexec@lists.infradead.org
References: <20260226130437.1867658-1-ruanjinjie@huawei.com>
 <20260226130437.1867658-4-ruanjinjie@huawei.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260226130437.1867658-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 8g6pYP6-zbkoGqYlCGxh4H1YVcGADYjR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEzMCBTYWx0ZWRfX30qX6zxbkgBu
 HpVyQ0dsZ1e/hMjf+YXrY/Y7l96+F6Gq/L7EP3s7O+PsvAQrNEOfynr0kGzxpzEyR+LT4GZoDno
 LodhkSjypbg71KtoOKEnOWF8jH31sHW6uu6bhcydiALmeqzWL81zeSzk1IGU/eJZ4a65VsTjivX
 8euHfVyd4ayhP2VXikByN9kDAe8bSJPSLecJ6zyxOpr7D2rY029FW+OGtOcFyLfk3L3Xs+jCFor
 bsaadJIIP7URf3sbJRtO69rQDj8WHIm7iA6maQ8C1SQuRVSNGAiBlWoLDncv301jGSftzY18Dsy
 nNUn7bBREX85qibTDI3thHoqZbz64JGb9R2FihBUK06S08oIQC+4veA0SrZ/YzcwaP8qNbBHl9D
 I/ao1ILtxtGkG9oHacZ7POqXB2GPtYWb+lm4FZqKRCBnKXIeUunEcpOaN+Ip55VwRiEfDlXToUk
 96zssSDnSpwHJRDYYlg==
X-Proofpoint-GUID: IvuRiAQp0mvX7PMUGo7_TumVon-lPwvd
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69a1af53 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=i0EeH86SAAAA:8 a=WpLmoQzK6mnfzqVyAaEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_065135_519606_A96CDE2B 
X-CRM114-Status: GOOD (  26.12  )
X-Mailman-Approved-At: Sun, 01 Mar 2026 03:56:22 -0800
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

Resend of: 
https://lore.kernel.org/all/19cf18b5-362d-4ff2-8b85-e2e72809250c@linux.ibm.com/

On 26/02/26 18:34, Jinjie Ruan wrote:
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
>   arch/powerpc/kexec/ranges.c | 16 ++++------------
>   include/linux/crash_core.h  |  4 ++++
>   kernel/crash_core.c         | 19 +++++++++++++------
>   3 files changed, 21 insertions(+), 18 deletions(-)
>
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


update_crash_elfcorehdr() in arch/powerpc/kexec/crash.c still calls
crash_exclude_mem_range_guarded(), causing a build failure.

ld: arch/powerpc/kexec/crash.o: in function `update_crash_elfcorehdr':
/root/linux/arch/powerpc/kexec/crash.c:454: undefined reference to 
`crash_exclude_mem_range_guarded'


To fix this:
--------------
diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 898742a5205c..e59e909c369d 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -451,7 +451,7 @@ static void update_crash_elfcorehdr(struct kimage 
*image, struct memory_notify *
                 base_addr = PFN_PHYS(mn->start_pfn);
                 size = mn->nr_pages * PAGE_SIZE;
                 end = base_addr + size - 1;
-               ret = crash_exclude_mem_range_guarded(&cmem, base_addr, 
end);
+              ret = arch_crash_exclude_mem_range(&cmem, base_addr, end);
                 if (ret) {
                         pr_err("Failed to remove hot-unplugged memory 
from crash memory ranges\n");
                         goto out;

With the above change included, things are working fine on powerpc.


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



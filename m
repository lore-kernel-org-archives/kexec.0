Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0F3C5DF97
	for <kexec@archiver.kernel.org>; Wed, 26 Aug 2026 05:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g1hDqym6yUm/+1TOtAhRCFfySO2d85EG02AAyjS/3tA=; b=ApO86yTgfdXnkGPITJ9GjsPL3d
	oG1knytroqKnw7tq+s1xyNR3fwk3vB3S86dkRxrjIMZZHXvId1j26sv0NXKnY0sMhy8ONKM2QPPVJ
	HQmitKq2XCTT6Mf9vAlxoMauWvWxV1lCAoghA75/Iuxu6BNxKZNiY91pksEO6MG+//JkdPYxWcCFB
	2N1mWlUq9pCurAdYkKELH+esMlONDyJv9rBPD2wBqE2onuOncXnABu2bzltTIOnpV0ZD+FzGlH1Uv
	O6Bm+iZEqEFV7YfLIhKT7ayw8lDpqNAoxNkkA76vna4YfCElHc+CyCsD/nKu7j+6t8rosfyiNkMX0
	6mZHzDBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz5p2-00000001ubq-1isY;
	Wed, 26 Aug 2026 05:05:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz5oz-00000001ub6-1t6C
	for kexec@lists.infradead.org;
	Wed, 26 Aug 2026 05:05:11 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q3VpmK2831001;
	Wed, 26 Aug 2026 05:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g1hDqy
	m6yUm/+1TOtAhRCFfySO2d85EG02AAyjS/3tA=; b=KaNq55WbIJJ/oswpAkYg3n
	hfdT/ZOSHNzg40sr7TKPihlQqkMjaDJVjfExIxrj4rGYZoulWsvJd84mOQioGd1t
	poUL2b+t6v0EdddLSVe7mHiGrDXB72m6bksyxi64Gr24rn8MdUr5rSLHdptijXKL
	8ZR4UtcybQK/No/J5N/RBkUXEdUhIK/NMphohFnpUw5d7fZKwEH3J3Ck6AXL68Ny
	l7q/KLT5X/k88I9YvxkHKtpSpKM8maPh52nNBshmwWARmLyZvKmxqGZBy92dyl8E
	CVri29t4Pm7MWDI5jQwVsMClWZbdlAnjGJh5inMnPcwkaEJah+LXocchMW8PfpbA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4vmre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 05:04:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q4uIUv006804;
	Wed, 26 Aug 2026 05:04:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh83rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 05:04:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67Q54W2O47383002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 05:04:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 333CB20043;
	Wed, 26 Aug 2026 05:04:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7679E20040;
	Wed, 26 Aug 2026 05:04:28 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 05:04:28 +0000 (GMT)
Message-ID: <3b340caa-d573-43c3-bf18-7ae6f5879627@linux.ibm.com>
Date: Wed, 26 Aug 2026 10:34:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/crash: reserve elfcorehdr for CONFIG_NR_CPUS,
 not CONFIG_NR_CPUS_DEFAULT
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>, x86@kernel.org,
        kexec@lists.infradead.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
        baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com,
        pratyush@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com,
        hbathini@linux.ibm.com, ruanjinjie@huawei.com, include@grrlz.net,
        linux-kernel@vger.kernel.org
References: <20260825075043.42041-1-ionut.nechita@windriver.com>
 <20260825075043.42041-2-ionut.nechita@windriver.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260825075043.42041-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OX8iwBhJy1ABwVnBVJOJSmYjRntrgexW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX9LfS/hIpstgd
 skBAI8pchREukOxPcQP/YfsCLLK9SSdybcJ9ba062NGDCqKMAybxxhtGGqeB3hWtVa1NvZj4ngy
 XcuTYzdgCKIwMZgy/pzqtH1UNiWvFmU=
X-Proofpoint-GUID: OX8iwBhJy1ABwVnBVJOJSmYjRntrgexW
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8e73e3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=t7CeM3EgAAAA:8
 a=VnNF1IyMAAAA:8 a=i0EeH86SAAAA:8 a=jcFIXsoQAAAA:8 a=iGjbNS7Vzi70nOy2QhoA:9
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=M1-Q_cRM6PFdmZSamPpU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfXzUdrslqwyIDe
 JwJUaGVywp4wI5tSzyi5ymvAiulVuVvjWI4IbnLGtwjpSlBpA+j8IJWASDhlz5gqDxM8m2IYGkJ
 rK+T2Ado7SvfuhOy/Cz8ckmsjYRCBpxz1EZ6XzATwhU/Xn0fcwQfHJnvBYN4uZVBUFTrlaHnDm5
 iPD974cxLTlkMhHauFSTHmDRLkCt+i+QdF3Uo50o9EQDe+0E5x39Rgs5clwGnvRCdQnvzeyiz10
 Ii4JEU699R+2A+p+hyggIPxI462VDOj9xvaJM+IZo8YM8rJd8BUF+x++Nb0E5+d9BwnOcnzs/Ru
 BMniv6uBT09Z1xgaGHZB85MH6B1Agwxbir9r3BOVhrPsWrryVrAWLAbVrtfsSOlVc7LWzzjR8f8
 M7f5gdZmsegXKlnhirkkG9BRiteWRmAnVgCmT2T3HwmNFqgtfhcbMDWlVpP5CH3T7cTq75mZl3T
 LCXefZFJQOtndvbOGPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_220509_515106_B501045E 
X-CRM114-Status: GOOD (  43.71  )
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



On 25/08/26 13:20, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
>
> kexec_file_load(2) fails with -EINVAL when loading a crash kernel on a
> machine whose number of possible CPUs exceeds CONFIG_NR_CPUS_DEFAULT,
> even though the classic kexec_load(2) path succeeds on the same machine.

It was surprising because the kexec tool with kexec_load also uses the
same size for elfcorehdr, which is exported via 
/sys/kernel/crash_elfcorehdr_size.

Code snippet from load_crashdump_segments() - 
kexec/arch/i386/crashdump-x86.c:

|/* For hotplug suppoBut I think we should handle the above issue 
separately.rt, override the minimum necessary size just * computed with 
the value from /sys/kernel/crash_elfcorehdr_size. * Properly align the 
size as well. */ if (do_hotplug) { memsz = _ALIGN(elfcorehdrsz, align); }|

Then I found the following code in add_segment_phys_virt() - kexec/kexec.c:

|if (bufsz > memsz) { bufsz = memsz; }|

when adding the segment. This seems wrong to me. What is the point of 
finding
a memory hole smaller than bufsz? It seems like it should be memsz = 
bufsz instead.

This could be the reason you don't see the problem with the kexec_load 
system call.
The kexec tool is truncating bufsz while finding a hole of size memsz.

So, yes, you didn't observe this issue with the kexec_load syscall while 
loading the
kdump kernel. However, given that the elfcorehdr memsz is truncated, you 
may face
problems during dump collection or with the collected dump.

Another problem I see around setting memsz when crash hotplug support is 
enabled
in both the kernel and kexec tool is that memsz is being overridden 
without checking
its current size.

It is possible that the elfcorehdr buffer prepared by the kernel could 
be larger than the
size calculated statically from the kernel configuration.

So I think if kbuf.bufsz for elfcorehdr is larger than (pnum + 1) * 
(sizeof(Elf64_Phdr) , we
should skip updating kbuf.memsz.

With that said the changes introduce here looks good, so feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

But I think we should handle the above issues separately.

- Sourabh Jain
>
> With CONFIG_CRASH_HOTPLUG=y the elfcorehdr segment is over-allocated so
> it can be updated in place on CPU/memory hotplug.  On the
> !CONFIG_MEMORY_HOTPLUG path, crash_load_segments() sizes that
> reservation as:
>
> 	ret = crash_prepare_headers(..., &kbuf.bufsz, &pnum);
> 	...
> 	pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
>
> The value that lands in @pnum is crash_prepare_headers()'s
> @nr_mem_ranges out parameter, i.e. cmem->nr_ranges - the number of
> memory ranges only, not a phdr count.  The header that
> crash_prepare_elf64_headers() actually builds adds one phdr per
> *possible* CPU on top of those ranges:
>
> 	nr_phdr = nr_cpus + 1;		/* + vmcoreinfo */
> 	nr_phdr += mem->nr_ranges;
> 	nr_phdr++;			/* + kernel text map */
>
> So the reservation covers
>
> 	nr_ranges + 2 + CONFIG_NR_CPUS_DEFAULT
>
> phdrs while the buffer holds
>
> 	nr_ranges + 2 + num_possible_cpus()
>
> phdrs, and the buffer exceeds the reservation by
>
> 	(num_possible_cpus() - CONFIG_NR_CPUS_DEFAULT) * sizeof(Elf64_Phdr)
>
> bytes as soon as num_possible_cpus() grows past CONFIG_NR_CPUS_DEFAULT.
> num_possible_cpus() is bounded by CONFIG_NR_CPUS, not by
> CONFIG_NR_CPUS_DEFAULT, so this is reachable on any config that raises
> CONFIG_NR_CPUS above the arch default without CONFIG_MAXSMP.
>
> crash_prepare_elf64_headers() rounds bufsz up to ELF_CORE_HEADER_ALIGN
> and kexec_add_buffer() rounds memsz up to PAGE_SIZE (both 4096), so the
> excess is invisible until it outgrows that padding.  Once it does,
> sanity_check_segment_list() rejects the image:
>
> 	if (image->segment[i].bufsz > image->segment[i].memsz)
> 		return -EINVAL;
>
> kexec_load(2) is unaffected because user space builds the elfcorehdr
> without the hotplug over-allocation.
>
> Observed on a single-socket Xeon 6776P (144 possible CPUs) running a
> PREEMPT_RT kernel with:
>
> 	# CONFIG_MAXSMP is not set
> 	# CONFIG_MEMORY_HOTPLUG is not set
> 	CONFIG_NR_CPUS_RANGE_BEGIN=2
> 	CONFIG_NR_CPUS_RANGE_END=512
> 	CONFIG_NR_CPUS_DEFAULT=64
> 	CONFIG_NR_CPUS=256
>
> At 144 possible CPUs the buffer exceeds the reservation by
> (144 - 64) * 56 = 4480 bytes.  That is more than the 4096 bytes of page
> padding, so the overflow is guaranteed and kexec -p -s fails with
> "kexec_file_load failed: Invalid argument".  Reducing the possible CPU
> count to 72 leaves an excess of (72 - 64) * 56 = 448 bytes, which the
> page rounding still absorbs, and the load succeeds - confirming the
> reservation is the limiting factor.
>
> Reserve the elfcorehdr for CONFIG_NR_CPUS, the compile-time upper bound
> of num_possible_cpus(), so the reservation always covers the header that
> is actually generated.
>
> The CONFIG_MEMORY_HOTPLUG=y path discards @pnum and reserves
> 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES phdrs
> instead.  With the default CONFIG_CRASH_MAX_MEMORY_RANGES=8192 the
> memory range allowance dwarfs the CPU shortfall, so that path does not
> fail in practice; it is switched to CONFIG_NR_CPUS as well for
> consistency and to stay correct for small CONFIG_CRASH_MAX_MEMORY_RANGES
> values.
>
> This does not change the reservation for defconfig-like builds, since
> CONFIG_NR_CPUS defaults to CONFIG_NR_CPUS_DEFAULT.  Only configs that
> raise CONFIG_NR_CPUS reserve more, and the worst case is bounded by the
> top of the range (CONFIG_NR_CPUS=8192 with CONFIG_CPUMASK_OFFSTACK=y),
> which is exactly what CONFIG_MAXSMP already reserves today.
>
> Fixes: ea53ad9cf73b ("x86/crash: add x86 crash hotplug support")
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> ---
>   arch/x86/kernel/crash.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e681ec9cf1dc..e6f23933a6df 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -369,9 +369,9 @@ int crash_load_segments(struct kimage *image)
>   	 * maximum CPUs and maximum memory ranges.
>   	 */
>   	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> -		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
> +		pnum = 2 + CONFIG_NR_CPUS + CONFIG_CRASH_MAX_MEMORY_RANGES;
>   	else
> -		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
> +		pnum += 2 + CONFIG_NR_CPUS;
>   
>   	if (pnum < (unsigned long)PN_XNUM) {
>   		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
> @@ -430,7 +430,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>   	unsigned int sz;
>   
>   	/* kernel_map, VMCOREINFO and maximum CPUs */
> -	sz = 2 + CONFIG_NR_CPUS_DEFAULT;
> +	sz = 2 + CONFIG_NR_CPUS;
>   	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>   		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
>   	sz *= sizeof(Elf64_Phdr);
>
> base-commit: 4b18edbd8e70f7e6860d56370f13244896d0f95c



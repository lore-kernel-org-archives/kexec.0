Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542F9FD5F6C
	for <kexec@archiver.kernel.org>; Wed,  8 Apr 2026 04:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ArkiUJGn25Pw/YpxTPJM/ImhaRVec2/ASRrX1MLo++o=; b=LEyiEb7D3b3j//cSM5mkjIlpt4
	8KZewoGyfO79OhnFe9H+c5yrylQn8K7VsC+i8n6XiSFKbsx84L7zeOXrNjJv0svSjTYAo7Bnn30cW
	kgy+mmDBc1umS69Pp2cU1ThmKhhDrkAvHG7u/ebSsuUVeK3NpnfNwx1m4wyl7M4b2s1u+m5vBNtn8
	RTC4uKMxfh9VvFE9kjTXRMQ9r4YomdoCIiJaZ5yILQ3F8ckg/I1EJZ9uXAfCSy5WR8DcKQ5qlk+iS
	g80IqnOvCiUS9EXM3GOBu4EQu9vc028tqTAzEVtosRPMYRdGWycTmsdkOnEUTjnE47y4T2qG44c1d
	Gc8QXDTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAKag-00000008EEO-2HZp;
	Wed, 08 Apr 2026 04:32:34 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAKaa-00000008EE2-3gkb
	for kexec@lists.infradead.org;
	Wed, 08 Apr 2026 04:32:30 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637MEO8R1472140;
	Wed, 8 Apr 2026 04:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ArkiUJ
	Gn25Pw/YpxTPJM/ImhaRVec2/ASRrX1MLo++o=; b=pYF7WhM+Z8jySeBcdk482a
	ZVWombE+YkjCoaUOWpJvIBYl20mybRIupbownM8huNbMIWGygR5lLyO4U8g0R7DI
	pnDA9Zei5d4vKEZOC8cXggbsXPHJs7XOlxMtoroVK50u0LGG1U9iXndSGA/1PRQI
	LzaLCqT+oTTBGfrNhHeR2KDMkk51wg+jaR8lMjuQIz40wurGb6eIaS0dfwq/uX5u
	Nvx+MZspn7CEeOkUGUsGEQNXe0Losk9moXx1AdE6+piu3kPrVA+tbexXjF94FbB5
	DnKp0QM/qek+vkVOFJa6qdveyxpqgE7r3O6nyI+B0F0UuaO3GIiC/0BrnoNP2G5A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fws0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:32:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637Nm7aV030102;
	Wed, 8 Apr 2026 04:32:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7e04s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:32:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384Vw3842533342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:31:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACCC620043;
	Wed,  8 Apr 2026 04:31:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 745C220040;
	Wed,  8 Apr 2026 04:31:56 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:31:56 +0000 (GMT)
Message-ID: <d584d383-1862-417d-9251-153d9bcf5626@linux.ibm.com>
Date: Wed, 8 Apr 2026 10:01:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash: Support high memory reservation for range syntax
To: Youling Tang <youling.tang@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20260404074103.506793-1-youling.tang@linux.dev>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260404074103.506793-1-youling.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d5da41 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=X1Cf018iDqK5zvsI8wQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ra5goK1N6uoHJQ-BB2RhxDfxlc8PLOov
X-Proofpoint-GUID: ra5goK1N6uoHJQ-BB2RhxDfxlc8PLOov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX3B8uE9KMFCJD
 GhK6BbZSDehZhWiXYLLZ1PdJ4gXs7wtgg3HNZ+c7D551Z2LOxp5vhZeg8fovrgc4bdLuiu4fPBh
 0MF+nqRZ2ONR8cEIjC5ij9G4hVGmR+dPaO98GoiIX76ggGvIV48RxLkpHWSktjAMdRmLK87bZwf
 pHAU1xE40MRnz1f2YoeNMkp9x/f/dzZPC0xpUkoA04p9iOR4vAmcHMF9EJkqU+9c5nGsRzfedm5
 o+arK4acXfnRraZKEL+ki7bBVbULj8WWHTRIOC3mfLsXI994fmORWorn2cWjpC9lnlCdBohwVbF
 VABXrX5XVbvNvmTAEzovtoLBjBoE4d7qoR1D7ZAMCre0MSKkP7pSCjP9oU6Hnml0EZv9IqYWcKk
 NIyM2uXb23oXHwUyot4hM1H98Cq/2lA64HJYsaoNDjkwaOPkX8FyxOMqbRpIM1IbWI7PfV43TdP
 0gS3m+6Oqq3QiZoduBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_213229_069265_D41A21E2 
X-CRM114-Status: GOOD (  39.03  )
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

Hello Youling,

On 04/04/26 13:11, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
>
> The crashkernel range syntax (range1:size1[,range2:size2,...]) allows
> automatic size selection based on system RAM, but it always reserves
> from low memory. When a large crashkernel is selected, this can
> consume most of the low memory, causing subsequent hardware
> hotplug or drivers requiring low memory to fail due to allocation
> failures.


Support for high crashkernel reservation has been added to
address the above problem.

However, high crashkernel reservation is not supported with
range-based crashkernel kernel command-line arguments.
For example: crashkernel=0M-1G:100M,1G-4G:160M,4G-8G:192M

Many users, including some distributions, use range-based
crashkernel configuration. So, adding support for high crashkernel
reservation with range-based configuration would be useful.

>
> Add a new optional conditional suffix ",>boundary" to the crashkernel
> range syntax. When the selected crashkernel size exceeds the specified
> boundary, the kernel will automatically apply the same reservation
> policy as "crashkernel=size,high" - preferring high memory first
> and reserving the default low memory area.

I think the approach to enable high crashkernel reservation
with range-based configuration makes the crashkernel kernel
argument more complex.

If the goal is to support high crashkernel reservation with
range-based kernel command-line arguments, how about:

crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset],high

instead of using >boundary?

>
> Syntax:
>      crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset],>boundary
>
> Example:
>      crashkernel=2G-16G:512M,16G-:1G,>512M
>
> This means:
>    - For 2G-16G RAM: reserve 512M normally
>    - For >16G RAM: reserve 1G with high memory preference (since 1G > 512M)
>
> For systems with >16G RAM, 1G is selected which exceeds 512M, so it
> will be reserved from high memory instead of consuming 1G of
> precious low memory.
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>   Documentation/admin-guide/kdump/kdump.rst     | 25 ++++++++-
>   .../admin-guide/kernel-parameters.txt         |  2 +-
>   kernel/crash_reserve.c                        | 56 ++++++++++++++++---
>   3 files changed, 73 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 7587caadbae1..b5ae4556e9ca 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -293,7 +293,28 @@ crashkernel syntax
>          2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
>          3) if the RAM size is larger than 2G, then reserve 128M
>   
> -3) crashkernel=size,high and crashkernel=size,low
> +3) range1:size1[,range2:size2,...][@offset],>boundary
> +   Optionally, the range list can be followed by a conditional suffix
> +   `,>boundary`. When the selected crashkernel size matches the
> +   condition, the kernel will reserve memory using the same policy as
> +   `crashkernel=size,high` (i.e. prefer high memory first and reserve the
> +   default low memory area).
> +
> +   The syntax is::
> +
> +        crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset],>boundary
> +        range=start-[end]
> +
> +   For example::
> +
> +        crashkernel=2G-16G:512M,16G-:1G,>512M
> +
> +   This would mean:
> +       1) if the RAM size is between 2G and 16G (exclusive), then reserve 512M.
> +       2) if the RAM size is larger than 16G, allocation will behave like
> +          `crashkernel=1G,high`.
> +
> +4) crashkernel=size,high and crashkernel=size,low
>   
>      If memory above 4G is preferred, crashkernel=size,high can be used to
>      fulfill that. With it, physical memory is allowed to be allocated from top,
> @@ -311,7 +332,7 @@ crashkernel syntax
>   
>               crashkernel=0,low
>   
> -4) crashkernel=size,cma
> +5) crashkernel=size,cma
>   
>   	Reserve additional crash kernel memory from CMA. This reservation is
>   	usable by the first system's userspace memory and kernel movable
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 03a550630644..b2e1892ab4d8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1087,7 +1087,7 @@ Kernel parameters
>   			4G when '@offset' hasn't been specified.
>   			See Documentation/admin-guide/kdump/kdump.rst for further details.
>   
> -	crashkernel=range1:size1[,range2:size2,...][@offset]
> +	crashkernel=range1:size1[,range2:size2,...][@offset][,>boundary]
>   			[KNL] Same as above, but depends on the memory
>   			in the running system. The syntax of range is
>   			start-[end] where start and end are both
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 62e60e0223cf..917738412390 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -254,15 +254,47 @@ static __init char *get_last_crashkernel(char *cmdline,
>   	return ck_cmdline;
>   }
>   
> +/*
> + * This function parses command lines in the format
> + *
> + *   crashkernel=ramsize-range:size[,...][@offset],>boundary
> + */
> +static void __init parse_crashkernel_boundary(char *ck_cmdline,
> +					unsigned long long *boundary)
> +{
> +	char *cur = ck_cmdline, *next;
> +	char *first_gt = false;
> +
> +	first_gt = strchr(cur, '>');
> +	if (!first_gt)
> +		return;
> +
> +	cur = first_gt + 1;
> +	if (*cur == '\0' || *cur == ' ' || *cur == ',') {
> +		pr_warn("crashkernel: '>' specified without boundary size, ignoring\n");
> +		return;
> +	}
> +
> +	*boundary = memparse(cur, &next);
> +	if (cur == next) {
> +		pr_warn("crashkernel: invalid boundary size after '>'\n");
> +		return;
> +	}
> +}
> +
>   static int __init __parse_crashkernel(char *cmdline,
>   			     unsigned long long system_ram,
>   			     unsigned long long *crash_size,
>   			     unsigned long long *crash_base,
> -			     const char *suffix)
> +			     const char *suffix,
> +			     bool *high,
> +			     unsigned long long *low_size)
>   {
>   	char *first_colon, *first_space;
>   	char *ck_cmdline;
>   	char *name = "crashkernel=";
> +	unsigned long long boundary = 0;
> +	int ret;
>   
>   	BUG_ON(!crash_size || !crash_base);
>   	*crash_size = 0;
> @@ -283,10 +315,20 @@ static int __init __parse_crashkernel(char *cmdline,
>   	 */
>   	first_colon = strchr(ck_cmdline, ':');
>   	first_space = strchr(ck_cmdline, ' ');
> -	if (first_colon && (!first_space || first_colon < first_space))
> -		return parse_crashkernel_mem(ck_cmdline, system_ram,
> +	if (first_colon && (!first_space || first_colon < first_space)) {
> +		ret = parse_crashkernel_mem(ck_cmdline, system_ram,
>   				crash_size, crash_base);
>   
> +		/* Handle optional ',>boundary' condition for range ':' syntax only. */
> +		parse_crashkernel_boundary(ck_cmdline, &boundary);
> +		if (!ret && *crash_size > boundary) {
> +			*high = true;
> +			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +		}
> +
> +		return ret;
> +	}
> +
>   	return parse_crashkernel_simple(ck_cmdline, crash_size, crash_base);
>   }
>   
> @@ -310,7 +352,7 @@ int __init parse_crashkernel(char *cmdline,
>   
>   	/* crashkernel=X[@offset] */
>   	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
> -				crash_base, NULL);
> +				crash_base, NULL, high, low_size);
>   #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>   	/*
>   	 * If non-NULL 'high' passed in and no normal crashkernel
> @@ -318,7 +360,7 @@ int __init parse_crashkernel(char *cmdline,
>   	 */
>   	if (high && ret == -ENOENT) {
>   		ret = __parse_crashkernel(cmdline, 0, crash_size,
> -				crash_base, suffix_tbl[SUFFIX_HIGH]);
> +				crash_base, suffix_tbl[SUFFIX_HIGH], high, low_size);
>   		if (ret || !*crash_size)
>   			return -EINVAL;
>   
> @@ -327,7 +369,7 @@ int __init parse_crashkernel(char *cmdline,
>   		 * is not allowed.
>   		 */
>   		ret = __parse_crashkernel(cmdline, 0, low_size,
> -				crash_base, suffix_tbl[SUFFIX_LOW]);
> +				crash_base, suffix_tbl[SUFFIX_LOW], high, low_size);
>   		if (ret == -ENOENT) {
>   			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>   			ret = 0;
> @@ -344,7 +386,7 @@ int __init parse_crashkernel(char *cmdline,
>   	 */
>   	if (cma_size)
>   		__parse_crashkernel(cmdline, 0, cma_size,
> -			&cma_base, suffix_tbl[SUFFIX_CMA]);
> +			&cma_base, suffix_tbl[SUFFIX_CMA], high, low_size);
>   #endif
>   	if (!*crash_size)
>   		ret = -EINVAL;



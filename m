Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40B9C02182
	for <kexec@archiver.kernel.org>; Thu, 23 Jan 2025 10:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/axuqOfplzRqeu8Ps/HCNnf4ssDFrofS4hczNmz3VQ8=; b=jrl+9bCn/HBK6P1N+RhRtjCj06
	0p0/nCfskeR13j9yMe/6QkGwXQMP7JMv8WgA/3MYHbklh3voFNNagBNBUSG/uq18dCJju81NWRPTZ
	tQcv6+7g/16brOd7hdZ3ofgH5gnJTnI4yodhFhD9GCsFqM+LDYcG4ap8aSmU/VYN4QbjP7571/v9y
	e+ePWGmgrkdegYcC5YgJhH64TxYsxlhDb7U03ATsEb3N9tFN8MZvIPRhl35XUOHdqQO1Gfc5OaxvS
	LYXe1QRCBwRWYCxOrN2uvD9qTWXNq8AfKhSteh82fSmEtqv7Axqd39wF7jiHktfSB5diU+wDWktBv
	bPTOB6TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tau51-0000000C9Ih-08O8;
	Thu, 23 Jan 2025 10:04:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tau4Y-0000000C9FF-3xnh
	for kexec@lists.infradead.org;
	Thu, 23 Jan 2025 10:04:28 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N20kZa014157;
	Thu, 23 Jan 2025 10:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/axuqO
	fplzRqeu8Ps/HCNnf4ssDFrofS4hczNmz3VQ8=; b=T/79fFUxJBcqN9K7dOj/K+
	PkJ6M0sSZgxPx/SJx5Ug6T7ksZfrRafcLhL/mgZTI0Sof2R7R/ZgxgPwrwzSnRuI
	RnQVE9ywzjnzv4ANsjlLI3uRuzRq/Fx5Fm32f4bgvdNrcaz7H0GTLsP9mPju+vxK
	S5ugUQt+7WMQR3LSPdqQZNFZCCKpbuYLjPq+yfBGIhjRS/7aIvs20JkoYso07WSP
	IRlbRSfJzofFKpKN1TORQ1NxwOxlx4wbGe5lB/kyzcWGXoWkScxQ+bHev8215RxP
	9wDBqRAJUvR5dNaEuHNvbikzCq8zQIlLottSb4vfR+vVKqwj1HWKhaAASOQttpSQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bckysv9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:04:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50N7mxVI032266;
	Thu, 23 Jan 2025 10:04:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448rujvmdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:04:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NA4DVm40698334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 10:04:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7299F200CE;
	Thu, 23 Jan 2025 10:04:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB906200C2;
	Thu, 23 Jan 2025 10:04:11 +0000 (GMT)
Received: from [9.203.114.244] (unknown [9.203.114.244])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 10:04:11 +0000 (GMT)
Message-ID: <7cfe94c9-4ca5-48b1-ab53-bc08fcf8fbc0@linux.ibm.com>
Date: Thu, 23 Jan 2025 15:34:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] kexec: Initialize ELF lowest address to ULONG_MAX
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
References: <20250121115442.1278458-1-sourabhjain@linux.ibm.com>
 <20250121115442.1278458-2-sourabhjain@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20250121115442.1278458-2-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iVIl_PKY5o8bpvR2QGLyZcy1lwgBkRvv
X-Proofpoint-ORIG-GUID: iVIl_PKY5o8bpvR2QGLyZcy1lwgBkRvv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230076
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_020427_108826_4191FD73 
X-CRM114-Status: GOOD (  20.52  )
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
> kexec_elf_load() loads an ELF executable and sets the address of the
> lowest PT_LOAD section to the address held by the lowest_load_addr
> function argument.
> 
> To determine the lowest PT_LOAD address, a local variable lowest_addr
> (type unsigned long) is initialized to UINT_MAX. After loading each
> PT_LOAD, its address is compared to lowest_addr. If a loaded PT_LOAD
> address is lower, lowest_addr is updated. However, setting lowest_addr
> to UINT_MAX won't work when the kernel image is loaded above 4G, as the
> returned lowest PT_LOAD address would be invalid. This is resolved by
> initializing lowest_addr to ULONG_MAX instead.
> 
> This issue was discovered while implementing crashkernel high/low
> reservation on the PowerPC architecture.
> 

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>   kernel/kexec_elf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
> index d3689632e8b9..3a5c25b2adc9 100644
> --- a/kernel/kexec_elf.c
> +++ b/kernel/kexec_elf.c
> @@ -390,7 +390,7 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
>   			 struct kexec_buf *kbuf,
>   			 unsigned long *lowest_load_addr)
>   {
> -	unsigned long lowest_addr = UINT_MAX;
> +	unsigned long lowest_addr = ULONG_MAX;
>   	int ret;
>   	size_t i;
>   



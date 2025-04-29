Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B575C369DC
	for <kexec@archiver.kernel.org>; Tue, 29 Apr 2025 19:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BcdvBrLiMDKoqa0VIJPRb3jP4UHmfILg+1l8AjaUNbs=; b=XG8dDr5+ja4MFMAB1Zk+umkbzu
	eA0ZO9IBMDqWuM9e04k81JfmMmAMy6xKCItKO7U0G6D1V3EbfWXGj3QZ5gD+wx9p/iCo1VGwHdnzA
	gBe0jl0fdLD20SbZ3i9iDSrUi8fAOOSD4k++Qvl24BjPtlgNyxSaJsVy8ovSboa6HSFBgNog94vFt
	hPfEpCvRCXxRUf21f9mJLtjJVPyPdrBJAn44g11+2aDIrkT95mf83fxktzQtmUinXb0QktlnByKu4
	bLy4QVUxdXe2cd1GVpJQ0Z/pPgf9MNG6xx3pyb9VdFvylCg3qBvyp3BRJGN5vICVuQb/EreT02gHa
	8c0SvD3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9qIK-0000000AcwZ-3x4W;
	Tue, 29 Apr 2025 19:07:04 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9qII-0000000AcwB-2Anf
	for kexec@lists.infradead.org;
	Tue, 29 Apr 2025 19:07:03 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TAenNe009168;
	Tue, 29 Apr 2025 19:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BcdvBr
	LiMDKoqa0VIJPRb3jP4UHmfILg+1l8AjaUNbs=; b=HvtvWtKcFJJNZw014msRTq
	MkAdjBfB/y4F4t+e/3JgIOqeqbof4mKM1Vw8QtrAEPACu4muXcda9gL4QFCpQcjz
	/x6YrHsRHmCnpVH0MzY7rRLXDwV4YLuTTvk1Zq+Tlzf8BDUX2IV9xBCrC8Ws0J9v
	puX6jmOt2T329Fn4a20Mrw8L1Q49+bDRKwsD/4wT6da0lhMV4YDo/SzbPQS97xEM
	BBTAoeNJ/ZmpcRyxk9ZZmLccRfvp3vpSHMJq/KNozzq1oxGPCf021a1l7bO/4O/K
	zd2GmLZnDKePv4U1DlhBlXBkYRZZU6HRG5GPHewkEmnqi+xrKggGIS2bImj6ucGA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46aw7t2b90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 19:06:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53THkVd8000644;
	Tue, 29 Apr 2025 19:06:44 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atpcpcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 19:06:44 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TJ6hND33686132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 19:06:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EC9A5806A;
	Tue, 29 Apr 2025 19:06:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1636D58054;
	Tue, 29 Apr 2025 19:06:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 19:06:40 +0000 (GMT)
Message-ID: <f9652da1-78a5-443c-9893-41d76007a974@linux.ibm.com>
Date: Tue, 29 Apr 2025 15:06:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 8/9] ima: make the kexec extra memory configurable
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
 <20250421222516.9830-9-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250421222516.9830-9-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE0MSBTYWx0ZWRfXyad5O9YWwMKl pUFSHK2yC1IOa/JgQKLEdsmOsR+BNqvkBpH01TeKIUaE7Bkuk4AGHpaLb9PMlvWn8BhT8otYRnc E4lr0zQDqFqGomUv5o/1w0XhzSFM2c9pcCpqAvwFnHSfbjiugCiCOgL151is4jM/3dubNr6m6bt
 u1Aow/jJhXp3ZMJxUVsvJZUPXEw2+JBG+w2Avjz6/Fne7WoYpXuc5cv6gPlRBLcnqBDpXYTccAE AK0xMZUdULeNcLUiaCTXx83VXRLykgvAGY/559WQeFwOvXi7NeMqe7vv2a3Ki+jVtRijGURpC04 TNtfgD5QtJfIxE0ajrHiTeHifdT9vwS2IbWfdR69HRZ8+nEyucVKWijWEURl2kMHEd7lolWM8Fu
 LFl1nw3R0jvB4IyR1ld2BN6NekvwAOtTyCPuL0IXZoIrVL5xJmFdfKYfMMOZ6C2IG6787kO2
X-Proofpoint-GUID: V9bKG-VWG5fqWmJX5LxLxIWb4oltzlFi
X-Authority-Analysis: v=2.4 cv=MJRgmNZl c=1 sm=1 tr=0 ts=68112345 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=yMhMjlubAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=d6lEWhlZ57pmn9SoDCoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: V9bKG-VWG5fqWmJX5LxLxIWb4oltzlFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_120702_692715_BD86B40D 
X-CRM114-Status: GOOD (  29.22  )
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



On 4/21/25 6:25 PM, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
> The extra memory allocated for carrying the IMA measurement list across
> kexec is hard-coded as half a PAGE.  Make it configurable.
> 
> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
> extra memory (in kb) to be allocated for IMA measurements added during
> kexec soft reboot.  Ensure the default value of the option is set such
> that extra half a page of memory for additional measurements is allocated
> for the additional measurements.
> 
> Update ima_add_kexec_buffer() function to allocate memory based on the
> Kconfig option value, rather than the currently hard-coded one.
> 
> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>   security/integrity/ima/Kconfig     | 11 +++++++++++
>   security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
>   2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 475c32615006..976e75f9b9ba 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -321,4 +321,15 @@ config IMA_DISABLE_HTABLE
>   	help
>   	   This option disables htable to allow measurement of duplicate records.
>   
> +config IMA_KEXEC_EXTRA_MEMORY_KB
> +	int "Extra memory for IMA measurements added during kexec soft reboot"
> +	range 0 40
> +	depends on IMA_KEXEC
> +	default 0
> +	help
> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
> +	  If set to the default value of 0, an extra half page of memory for those
> +	  additional measurements will be allocated.

If you have an IMA policy taking quite a few measurements and you are 
fast after reboot to log in to initiate the 'kexec load' (While system 
is still starting up), the system may end up with loss of measurements 
very easily if the default is 0 and pages are small. -> Set the default 
to the max? Also, would we expect distros to all go through the new 
config option and choose 40 or will they likely leave it at 0?

> +
>   endif
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index ed867734ee70..d1c9d369ba08 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -118,6 +118,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>   				  .buf_min = 0, .buf_max = ULONG_MAX,
>   				  .top_down = true };
>   	unsigned long binary_runtime_size;
> +	unsigned long extra_memory;
>   
>   	/* use more understandable variable names than defined in kbuf */
>   	size_t kexec_buffer_size = 0;
> @@ -125,15 +126,20 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	int ret;
>   
>   	/*
> -	 * Reserve an extra half page of memory for additional measurements
> -	 * added during the kexec load.
> +	 * Reserve extra memory for measurements added during kexec.
>   	 */
> -	binary_runtime_size = ima_get_binary_runtime_size();
> +	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
> +		extra_memory = PAGE_SIZE / 2;
> +	else
> +		extra_memory = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
> +
> +	binary_runtime_size = ima_get_binary_runtime_size() + extra_memory;
> +
>   	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>   		kexec_segment_size = ULONG_MAX;
>   	else
> -		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
> -					   PAGE_SIZE / 2, PAGE_SIZE);
> +		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
> +
>   	if ((kexec_segment_size == ULONG_MAX) ||
>   	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>   		pr_err("Binary measurement list too large.\n");



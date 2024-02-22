Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04374C54798
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:Date:References:
	In-Reply-To:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7cjcl0u5e65yNa1JXtpkWMs+wyhQVDayE6eN4wFcqX8=; b=kZc8UxaE7aVWwe3ciVOffe9YIT
	Sk6//YtAZRHX1BuLnw5IKzQV/szO/01FBDtneh47OFfAtq9Ff5csE5OL8xAK+Is4Y/AwQvZDyz068
	sepQk4+MeZKw8vRH25ZtlYacAk2rvMOrQi4qOMffDElJPg43S8A0UbQUmyaQndM/AC48NyMdJu14g
	3Hk3VEtQ4PiCiY4nGqrrLutnYntw3nqpHDjdr9G7Gz39FH9UR4H5Y51mkBAfFh3gO+VBzmg/9CDSh
	RbYihqzpORf5sO9MWQEgaKIlryHfBAMT411qf+zK5XQQ4IYLx/+YXzeObMXXxuF5xc+JbJCF7bG0y
	OerF3QCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdAyE-00000005NXt-2srD;
	Thu, 22 Feb 2024 15:26:46 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdAyA-00000005NWb-42Tq
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 15:26:44 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MF7DtX025764;
	Thu, 22 Feb 2024 15:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : in-reply-to : references : content-type : date :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6is4J6faMXa825k9ObNr0T510me85j4o6wij3IOHWAQ=;
 b=VwCbImPhUWrtNPGrh9gLNOPWGvykpkUXTYYTQJSfNOLVCapry3121UjEh6Abo1tc0ZTn
 ZJ7CM20pSJXANlWorl0lSd8ezTz2Z7roXw16R61Hs8Fxs1u44wwlsqoo0gHz+zxxZe15
 q2oQpIpVvRkDVj5W8HI30e6M4r2/2X5ZDMEt7DKhQnSDbnx6E0WNZABX1XMRbFDxUTL9
 PV10fdF2bX/9YIg59Uah91cTZdkCDqTWIek8Yb9rAbh55MghykuSaDbeIl2Y9UZOMYvC
 RASnZNeY0q92y6lB4w01paY7wrVA7WnAEV/3T+F5lVrBNmBh1YWrBpMSwMQ/Kp0Om/5R bg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we8mkghgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 15:26:23 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41ME5wuQ013470;
	Thu, 22 Feb 2024 15:26:22 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h0q8xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 15:26:22 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41MFQKZ711207180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 15:26:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3CD158063;
	Thu, 22 Feb 2024 15:26:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B6205805D;
	Thu, 22 Feb 2024 15:26:17 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.99.109])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Feb 2024 15:26:17 +0000 (GMT)
Message-ID: <c87163b6aae92acec40a98217a4e65b9af4ece2a.camel@linux.ibm.com>
Subject: Re: [PATCH v5 7/8] ima: make the kexec extra memory configurable
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
In-Reply-To: <20240214153827.1087657-8-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	 <20240214153827.1087657-8-tusharsu@linux.microsoft.com>
Date: Thu, 22 Feb 2024 09:13:23 -0500
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HC6JejxVUzYnxr6d_wM70qqaa8GdR82q
X-Proofpoint-ORIG-GUID: HC6JejxVUzYnxr6d_wM70qqaa8GdR82q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_11,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220123
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_072643_299085_110AE449 
X-CRM114-Status: GOOD (  31.06  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Tushar,

On Wed, 2024-02-14 at 07:38 -0800, Tushar Sugandhi wrote:
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
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  security/integrity/ima/Kconfig     |  9 +++++++++
>  security/integrity/ima/ima_kexec.c | 15 ++++++++++-----
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index b98bfe9efd0c..4c0fc53d6aa3 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -320,4 +320,13 @@ config IMA_DISABLE_HTABLE
>  	help
>  	   This option disables htable to allow measurement of duplicate
> records.
>  
> +config IMA_KEXEC_EXTRA_MEMORY_KB
> +	int
> +	depends on IMA_KEXEC
> +	default 0
> +	help
> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
> +	  If set to the default value, an extra half a page of memory for those
> +	  additional measurements will be allocated.
>  endif
> diff --git a/security/integrity/ima/ima_kexec.c
> b/security/integrity/ima/ima_kexec.c
> index dbeeb7f1355e..50903d4ce880 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -126,6 +126,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>  				  .buf_min = 0, .buf_max = ULONG_MAX,
>  				  .top_down = true };
>  	unsigned long binary_runtime_size;
> +	unsigned long extra_size;
>  
>  	/* use more understandable variable names than defined in kbuf */
>  	void *kexec_buffer = NULL;
> @@ -133,15 +134,19 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	int ret;
>  
>  	/*
> -	 * Reserve an extra half page of memory for additional measurements
> -	 * added during the kexec load.
> +	 * Reserve extra memory for measurements added during kexec.
>  	 */
> -	binary_runtime_size = ima_get_binary_runtime_size();
> +	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
> +		extra_size = PAGE_SIZE / 2;
> +	else
> +		extra_size = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
> +	binary_runtime_size = ima_get_binary_runtime_size() + extra_size;

It's clearer if the 'extra_size' is added to the segment_size, not the
binary_runtime_size.  Please revert this change.

> +
>  	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>  		kexec_segment_size = ULONG_MAX;
>  	else
> -		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
> -					   PAGE_SIZE / 2, PAGE_SIZE);
> +		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);

Please replace binary_runtime_size with "ima_get_binary_runtime_size() +
extra_size".

Mimi

>  	if ((kexec_segment_size == ULONG_MAX) ||
>  	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>  		pr_err("Binary measurement list too large.\n");


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

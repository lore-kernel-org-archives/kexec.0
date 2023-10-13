Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3CDCDB474
	for <kexec@archiver.kernel.org>; Fri, 13 Oct 2023 00:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UX/zMew3zxpM9RWXH3egUtNyPKHTHG2Z25/x83f8Vek=; b=Xdt07h6JzbDD7S
	bwYr4KX7RifYfle6i+bp/giPCLN1QmUod2Di8TBL0x9lUk71WymDVu9NCn3/PhHmGsMqUGyVH55f4
	Zc2Il/6J5W2eWPgKOgWO3gJCWWCFG9h/yAtyXOivCrEes83F5VEf7nJCzfki8FSmk9FBL3tnznEpB
	8NGg9K1bkvJhuxT2UXao26izm1zLp00yHiO1tLM9MXRxXHy669ClvGvSeDj2IhAADBY8uIHMNxj4l
	d4jgvBWs7kt8z+7BKCzU2PCHuSSpSrTtMrwdM2y6MCx94gngkOjkKeVTTsf8M3+xvBibVjq9TqKhW
	x43sKz9ZVofQAQmDyTbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qr64G-002B85-0k;
	Fri, 13 Oct 2023 00:30:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qr64D-002B06-1R
	for kexec@lists.infradead.org;
	Fri, 13 Oct 2023 00:30:15 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D0EnMH032246;
	Fri, 13 Oct 2023 00:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DIUantFOsMzEw/QS0BIVbuKoupftEJTPIZ7nY9ajbKI=;
 b=Ae4hudJIZj7dCeJ2aVktn21hfOwjcYZpnBrvcGVkGNGzxZQs9xKUxiXjeVyCQYeJCUSd
 COkxOp2dSWjXDQv97i3+wO9WTAhURR//MU8C/8Zf7dNZev/2Al/1Shxql168rC6I4kKG
 tPGHWBwt/I0lgUOjzSoCcZHv9WR1yuzoWtbaGpd4M2Vf4lrZuMMyU8B5SmZYoFHdetWF
 VncShMtWpd02nYmOtWkgSPoPW6utnf5+FHE3Yu/asRCLl1/mS5qqubvQ1lJK4b3peEbt
 14mSsDG7xg3+9zsKCqithg/DepH/JDBNv2/aN55jUln/WzWCSieyPDqcyl5vppSIRzdI Aw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpu678asv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Oct 2023 00:28:02 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CN4FTw007595;
	Fri, 13 Oct 2023 00:28:00 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tpt5a8e3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Oct 2023 00:28:00 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39D0RxHW21234406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 00:28:00 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA19B58052;
	Fri, 13 Oct 2023 00:27:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 249AD58065;
	Fri, 13 Oct 2023 00:27:59 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Oct 2023 00:27:59 +0000 (GMT)
Message-ID: <a8828617-a296-8498-5e1f-b75a089916e0@linux.ibm.com>
Date: Thu, 12 Oct 2023 20:27:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 6/7] ima: make the memory for events between kexec load
 and exec configurable
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-7-tusharsu@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20231005182602.634615-7-tusharsu@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YcZeWS7rtGvaPuN2C2FwdnQiLBxzF1qf
X-Proofpoint-GUID: YcZeWS7rtGvaPuN2C2FwdnQiLBxzF1qf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=876 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_173013_610235_D7625029 
X-CRM114-Status: GOOD (  26.58  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


On 10/5/23 14:26, Tushar Sugandhi wrote:
> IMA currently allocates half a PAGE_SIZE for the extra events that would
> be measured between kexec 'load' and 'execute'.  Depending on the IMA
> policy and the system state, that memory may not be sufficient to hold
> the extra IMA events measured after kexec 'load'.  The memory
> requirements vary from system to system and they should be configurable.
>
> Define a Kconfig option, IMA_KEXEC_EXTRA_PAGES, to configure the number
> of extra pages to be allocated for IMA measurements added in the window
> from kexec 'load' to kexec 'execute'.
>
> Update ima_add_kexec_buffer() function to allocate memory based on the
> Kconfig option value, rather than the currently hardcoded one.
>
> Signed-off-by: Tushar Sugandhi<tusharsu@linux.microsoft.com>
> ---
>   security/integrity/ima/Kconfig     |  9 +++++++++
>   security/integrity/ima/ima_kexec.c | 13 ++++++++-----
>   2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 60a511c6b583..1b55cd2bcb36 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -338,3 +338,12 @@ config IMA_DISABLE_HTABLE
>   	default n
>   	help
>   	   This option disables htable to allow measurement of duplicate records.
> +
> +config IMA_KEXEC_EXTRA_PAGES
> +	int
> +	depends on IMA && IMA_KEXEC
> +	default 16
> +	help
> +	  IMA_KEXEC_EXTRA_PAGES determines the number of extra
> +	  pages to be allocated for IMA measurements added in the
> +	  window from kexec 'load' to kexec 'execute'.


On ppc64 a page is 64kb. I would ask for additional kb here.


> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 13fbbb90319b..6cd5f46a7208 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -150,15 +150,18 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	int ret;
>   
>   	/*
> -	 * Reserve an extra half page of memory for additional measurements
> -	 * added during the kexec load.
> +	 * Reserve extra memory for measurements added in the window from
> +	 * kexec 'load' to kexec 'execute'.
>   	 */
> -	binary_runtime_size = ima_get_binary_runtime_size();
> +	binary_runtime_size = ima_get_binary_runtime_size() +
> +			      sizeof(struct ima_kexec_hdr) +
> +			      (CONFIG_IMA_KEXEC_EXTRA_PAGES * PAGE_SIZE);
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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

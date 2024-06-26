Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A448C30653
	for <kexec@archiver.kernel.org>; Wed, 26 Jun 2024 10:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TBrgJmabsyUNdzxQCv5CwAhTtA8HbrXnFbMPTxh+mSI=; b=JdIjiVsxR+VTBl
	n5XXjsVSFpeKKrZP0Vhc4oA1UPKQ1qBuLN+2+XO18i8vHMlptCSxO3KAxC2hJYDgfGVTEmIoC6LTT
	WZ44B7T29rDMClLpOPuPoL5+GWMNt3qntv3g6n+9djwIa936+ebW1Vq0N/91/NirT8vWSRJbsO69+
	8ggb6pWhSNhQr/bl99IbLf43wI3WPCfnHC5u+dATMUPUoUR2E89nGYJuhNfkbTL5NmYrQ/U87R4CC
	Xztk0osYn4+9bgJ+KVoYybQuLwwr69nXlA5W5lqmdUFnEuVxM7C6tAYmlaZ33cXwaOz//yTIzR+pe
	S9ziBO2CopeVyaF02G0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMPmA-00000006IrQ-3nY0;
	Wed, 26 Jun 2024 10:21:18 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMPm7-00000006Ipd-2mxC
	for kexec@lists.infradead.org;
	Wed, 26 Jun 2024 10:21:17 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q9xAJV027666;
	Wed, 26 Jun 2024 10:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=X
	koQosriqhnTOhTsbTgPJ7RgdLQLhUbD+rAwUKo9ZdA=; b=J97/wBpDr1MCCVJXx
	Fw2PHZpHFIHjZEPfpXxu3/6Rj1a8VM3nLCfgTXzBwhdGtrOuuosMD8XiDU6b0/2j
	FPTPDUGmXbnzOm8vKP/nmh6sAR3dhaq5I5ggiyk7zfA25wpAbkVYhoPOZLCAAs/k
	qTtZYCjrPySrGLCtpYhWQnWtPIywwDb2bjmOY1VekRNxsJiMs+ubS/mXzT/KZryr
	mqIP7PKZ9K5UYGqt/7qGQnvRn3crfEPs2erjpddmir15c8rTORA4nK/UEt4UuklT
	FA5iLQz8ueFCi8U05h5CrRvpKpguwtelagjtfP+bB7iA+s66ePClastioN5l8hfX
	JFRGg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400gu181r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:21:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45QALBWH027545;
	Wed, 26 Jun 2024 10:21:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400gu181qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:21:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45Q8mG4K008183;
	Wed, 26 Jun 2024 10:21:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9b0uxw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:21:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45QAL4tH11993492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 10:21:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89E5D2004B;
	Wed, 26 Jun 2024 10:21:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E122420043;
	Wed, 26 Jun 2024 10:21:02 +0000 (GMT)
Received: from [9.109.222.128] (unknown [9.109.222.128])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Jun 2024 10:21:02 +0000 (GMT)
Message-ID: <7c06b691-d961-42af-9779-a2a98456c8e3@linux.ibm.com>
Date: Wed, 26 Jun 2024 15:51:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] doc/hotplug: update man and --help
To: Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org
Cc: Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
References: <20240613190738.1852258-1-sourabhjain@linux.ibm.com>
 <20240613190738.1852258-3-sourabhjain@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20240613190738.1852258-3-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XDaVMRaYbdv-gbXjzBa4OvjPLqtOUUQj
X-Proofpoint-GUID: wiyD54ZJA6NysjoN0aOZF_CwbyigUJpF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_04,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_032115_980028_46F25A94 
X-CRM114-Status: GOOD (  19.69  )
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



On 14/06/24 12:37 am, Sourabh Jain wrote:
> Update the man page and --help option to make the description of the
> --hotplug option easier to understand.
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Coiby Xu <coxu@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Simon Horman <horms@kernel.org>

Minor nits below...

Otherwise, looks good.

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> 
> Changelog:
> 
> Since v1:
>    - Updated --hotplug option description
> 
> ---
>   kexec/kexec.8 | 8 ++++----
>   kexec/kexec.c | 4 +++-
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/kexec/kexec.8 b/kexec/kexec.8
> index 9e995fe..92fa3d5 100644
> --- a/kexec/kexec.8
> +++ b/kexec/kexec.8
> @@ -140,10 +140,10 @@ Open a help file for
>   .BR kexec .
>   .TP
>   .B \-\-hotplug
> -Setup for kernel modification of the elfcorehdr. This option performs
> -the steps needed to support kernel updates to the elfcorehdr in the
> -presence of hot un/plug and/or on/offline events. This option only
> -useful for KEXEC_LOAD syscall.
> +Setup kexec segments such that kernel can safely update them on CPU/Memory
> +hot add/remove events. If this option is enabled, kernel does in-kernel

> +update of kexec segments on CPU/Memory hot add/remove events. Helps avoid
> +the need to reload kdump kernel.

s/events. Helps avoid the need/events, thus avoiding the need/

>   .TP
>   .B \-i\ (\-\-no-checks)
>   Fast reboot, no memory integrity checks.
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 034cea6..db8e2b3 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1093,7 +1093,9 @@ void usage(void)
>   	       "                      back to the compatibility syscall when file based\n"
>   	       "                      syscall is not supported or the kernel did not\n"
>   	       "                      understand the image (default)\n"
> -	       " --hotplug            Setup for kernel modification of elfcorehdr.\n"
> +	       " --hotplug            Do in-kernel update of kexec segments on CPU/Memory\n"

> +	       "                      hot add/remove events. This avoids the need to reload\n"

s/events. This avoids/events, avoiding/

> +	       "                      kdump kernel or on/offline events.\n"

s/kernel or on/kernel on online/

>   	       " -d, --debug          Enable debugging to help spot a failure.\n"
>   	       " -S, --status         Return 1 if the type (by default crash) is loaded,\n"
>   	       "                      0 if not.\n"

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

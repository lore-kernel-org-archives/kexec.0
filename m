Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAC3C27C5E
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Xl/I5d0GLcmdAb/5wEwhbaeV2A2QTSEWoW0EA58bFk=; b=rdd2Fv27wR/rZx
	Y1Bxn9JAhdHYHkZtSRQ+eLAChLqup8ihm8x4WcHb4a97ymCIfNkUR8e7ogJkh1MgG9a31SErVjtoo
	JlycLoEXq+/n1EKGBJwlIy4Tf3mlkjf1A0TrYeuuL81gBDMC+HPplHKx3+hxxxJbdZDeE01b6NUb9
	kKyTkJV2VSdtRhrqsHCt8ZyCLasVDeFOxpaJ3Vu6I6ppTPa8myXRADzG39gGJrFO9LOseuFSeMsFl
	mHD6jzZ9SNAvD5fN3EiXlCFQLYAgZvF9HBtMwN+mzrDDvD72GqEUgWJiiUgoL40pPgmoczfqzGnWt
	lrpOJrcUQHEBucWyQ8SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbC3-00000004QsA-0vCE;
	Mon, 10 Jun 2024 09:19:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGbC0-00000004Qqs-0t0I
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 09:19:57 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A8x2Ld019232
	for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 09:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=x
	dTvW2KFGyeqGBrMdLh0ATAVZFMJaw4YnZxAmTW/csI=; b=G41e583UG4ayNzoF5
	nRJomoqNTBW+Fk0kuAOSpONzX1CByuGZrXNd6utvPvUZ4LZ4CGHO9FLhEMEw3lp3
	12CrtM5e6m8CF2RCX48TIs4TUr8qKJleucEKrBABivDpz5SLjs98ejK73y+MZPIi
	U6C+CuAlh7KFHC28PK5WAYMc3Rkqr17e6p+WwCpL2QyScQ8EtF/RfX332e3WxlpF
	f5vy74CvsPkJwI21eScXUvttTVZTtnR+FHhpsyJJBT0gIrekEhxrtPvwv+agzM6q
	wc2lvhtZWP7mJpo5x52KanwvMclr6mA3nRYAUxAShEklDzk77bKDkE+COUze2wXF
	7shxQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynxerr1m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 09:19:54 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45A9JsJr020549
	for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 09:19:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynxerr1m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 09:19:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45A7kZFm020045;
	Mon, 10 Jun 2024 09:19:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34mpjp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 09:19:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45A9JlhH42729796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 09:19:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E412F2006A;
	Mon, 10 Jun 2024 09:19:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3A3B2005A;
	Mon, 10 Jun 2024 09:19:46 +0000 (GMT)
Received: from [9.203.115.195] (unknown [9.203.115.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Jun 2024 09:19:46 +0000 (GMT)
Message-ID: <8ba124ad-13a4-43e3-8838-a29e2b7fd8e7@linux.ibm.com>
Date: Mon, 10 Jun 2024 14:49:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] doc/hotplug: update man and --help
To: Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org
Cc: Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>
References: <20240522131353.198327-1-sourabhjain@linux.ibm.com>
 <20240522131353.198327-3-sourabhjain@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20240522131353.198327-3-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6KjkZ-jsV0Axz-SyqoCRcwDRi-JyDhI1
X-Proofpoint-ORIG-GUID: VMc6CSmmsuZ411lMkn6pLjylEyvTfI-2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100067
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_021956_552263_E60D00F2 
X-CRM114-Status: GOOD (  23.10  )
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



On 22/05/24 6:43 pm, Sourabh Jain wrote:
> Update the man page and --help option to make the description of the
> --hotplug option easier to understand.
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Coiby Xu <coxu@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>   kexec/kexec.8 | 8 ++++----
>   kexec/kexec.c | 3 ++-
>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kexec/kexec.8 b/kexec/kexec.8
> index 9e995fe..7dddae9 100644
> --- a/kexec/kexec.8
> +++ b/kexec/kexec.8
> @@ -140,10 +140,10 @@ Open a help file for
>   .BR kexec .
>   .TP
>   .B \-\-hotplug

Can we have the description changed like:

> -Setup for kernel modification of the elfcorehdr. This option performs
> -the steps needed to support kernel updates to the elfcorehdr in the
> -presence of hot un/plug and/or on/offline events. This option only
> -useful for KEXEC_LOAD syscall.
> +Helps avoid kdump kernel reload on CPU/Memory hotplug or on/offline events.
> +If this option is enabled, the kexec segments will be set up in a way that
> +the kernel can safely update them on CPU/memory hotplug and/or on/offline
> +events. This option is only useful for the KEXEC_LOAD syscall.

"Setup kexec segments such that kernel can safely update them on 
CPU/Memory hot add/remove events. If this option is enabled, kernel does
in-kernel update of kexec segments on CPU/Memory hot add/remove events.
Helps avoid the need to reload kdump kernel."


>   .TP
>   .B \-i\ (\-\-no-checks)
>   Fast reboot, no memory integrity checks.
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 034cea6..2b06438 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1093,7 +1093,8 @@ void usage(void)
>   	       "                      back to the compatibility syscall when file based\n"
>   	       "                      syscall is not supported or the kernel did not\n"
>   	       "                      understand the image (default)\n"
> -	       " --hotplug            Setup for kernel modification of elfcorehdr.\n"

> +	       " --hotplug            Helps avoid kdump kernel reload on CPU/Memory hotplug\n"
> +	       "		      or on/offline events.\n"

"Do in-kernel update of kexec segments on CPU/Memory hot add/remove 
events. This avoids the need to reload kdump kernel."

- Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20778C3271E
	for <kexec@archiver.kernel.org>; Mon,  8 Jul 2024 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hcHtyBDwvJ1iiYLC+uPcULEkS/9FaPecKXOlBjfCdvU=; b=GEwnqe6TdIIsQR
	fNBnJTEdro6a6GCwocBW18Q6ILwhhEaIud67YCTo78ulyt5erMC1YSY8sIlaZeuJEC6lnPPDJzZLW
	rRce6vu6gFWJtuNcjJWh4tN55CnrHSFlfc8BMuENYuxwpgj/yTggDD7YqC36/IHYTYvBfj/xuWVqQ
	4oM3//p0vs6w0oswgWWorzoMbPw6F2QmQ9W7D2CKdtgj11Ze/i3O3O+kdabX54yJeYRs/FAL1lc2b
	cm8pxbOvS2xytsd4BbNu7gTOAZkUpW94A37pHEB3Pin7/YerF9Tqw1WmP06Bq+qcjFB9IwnLxO1PM
	arphOHIQdiAYrh0B9jZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQoOJ-00000003uK5-304i;
	Mon, 08 Jul 2024 13:26:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQoOA-00000003uIV-0Vlx
	for kexec@lists.infradead.org;
	Mon, 08 Jul 2024 13:26:43 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468Cpo6J023136;
	Mon, 8 Jul 2024 13:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=2
	XPor+efyQ9VfH4IeSy9IRIo2GFK0Wzj+L3nTrr1TLE=; b=BP+v23mXvjjmikvKi
	7wOo+E5srBfuGmmCu5AeGuD29byV0dtX+gnIcL/mZXAwy6r51RCWLqpaHxXbDpjZ
	0HlEZipS0kl3ekydghq/oxRktuvqGOx24fKJe/K57FGt7sKmQcNFFusglBA1/sng
	gLsCILdDZSPGo5vW2te809TTpRH0tc3XDKCejGLFZF/dn0TNKzGnsi9hsREnofcV
	BX6ll0+tIKUM03ChyllqcrQe2L32vcJEQCLdMWAsNgxGXfPNrL3i/MIju71LVz6m
	RSQw8y5JjJZaFxrAWT2KI4zO9Qi7Rsy/9Awr0pBijRVcGqq1SbL3v671WlmMIiKa
	O6I8A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408dy90f3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 13:26:35 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 468DQZBn010572;
	Mon, 8 Jul 2024 13:26:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408dy90f28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 13:26:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 468D5GLL024598;
	Mon, 8 Jul 2024 13:22:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrmf1sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 13:22:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 468DMots53412188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jul 2024 13:22:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E93AF20049;
	Mon,  8 Jul 2024 13:22:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C241020040;
	Mon,  8 Jul 2024 13:22:47 +0000 (GMT)
Received: from [9.43.5.84] (unknown [9.43.5.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jul 2024 13:22:47 +0000 (GMT)
Message-ID: <90aa34ed-91eb-4cf8-81d8-ff2fbbdb8767@linux.ibm.com>
Date: Mon, 8 Jul 2024 18:52:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] kexec_load: Use new kexec flag for hotplug support
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Aditya Gupta <adityag@linux.ibm.com>,
        Coiby Xu <coxu@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
References: <20240707152456.87899-1-sourabhjain@linux.ibm.com>
 <20240707152456.87899-2-sourabhjain@linux.ibm.com>
 <Zou/tF+wmuEKVT7c@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Zou/tF+wmuEKVT7c@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -KL0kWwh2xHi6MfTuksbGd9La19XrY6J
X-Proofpoint-GUID: 1hWvoryvaJe9eYVinZ2EdCe0g1DKLRN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_08,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=705
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080100
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_062642_565887_5AA209D1 
X-CRM114-Status: GOOD (  17.36  )
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

Hello Baoquan,

On 08/07/24 16:00, Baoquan He wrote:
> On 07/07/24 at 08:54pm, Sourabh Jain wrote:
>> Kernel commit 79365026f869 (crash: add a new kexec flag for hotplug
>> support) has introduced a new kexec flag to generalize hotplug support.
>> The newly introduced kexec flags for hotplug allow architectures to
>> exclude all the required kexec segments from SHA calculation so that
>> the kernel can update them on hotplug events. This was not possible
>> earlier with the KEXEC_UPDATE_ELFCOREHDR kexec flags since it was added
>> only for the elfcorehdr segment.
>>
>> To enable architectures to control the list of kexec segments to exclude
>> when hotplug support is enabled, add a new architecture-specific
>> function named arch_do_exclude_segment. During the SHA calculation, this
>> function gets called to let the architecture decide whether a specific
>> kexec segment should be considered for SHA calculation or not.
>>
>> Note: To avoid breaking backward compatibility, the new kexec flag
>> KEXEC_CRASH_HOTPLUG_SUPPORT is not used for x86 for now.
>>
>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Coiby Xu <coxu@redhat.com>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   kexec/arch/arm/kexec-arm.c             |  5 ++++
>>   kexec/arch/arm64/kexec-arm64.c         |  5 ++++
>>   kexec/arch/cris/kexec-cris.c           |  4 +++
>>   kexec/arch/hppa/kexec-hppa.c           |  5 ++++
>>   kexec/arch/i386/kexec-x86.c            |  8 ++++++
>>   kexec/arch/ia64/kexec-ia64.c           |  4 +++
>>   kexec/arch/loongarch/kexec-loongarch.c |  5 ++++
>>   kexec/arch/m68k/kexec-m68k.c           |  5 ++++
>>   kexec/arch/mips/kexec-mips.c           |  4 +++
>>   kexec/arch/ppc/kexec-ppc.c             |  4 +++
>>   kexec/arch/ppc64/kexec-ppc64.c         |  5 ++++
>>   kexec/arch/s390/kexec-s390.c           |  5 ++++
>>   kexec/arch/sh/kexec-sh.c               |  5 ++++
>>   kexec/arch/x86_64/kexec-x86_64.c       |  8 ++++++
>>   kexec/kexec-syscall.h                  |  1 +
>>   kexec/kexec.c                          | 40 ++++++++++++++++++++++----
>>   kexec/kexec.h                          |  2 ++
>>   17 files changed, 109 insertions(+), 6 deletions(-)
> LGTM,
>
> Acked-by: Baoquan He <bhe@redhat.com>

Thank you for the Ack.

- Sourabh Jain

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

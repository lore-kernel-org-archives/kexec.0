Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6416E77197
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 03:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZ7QVyUSfzkXf6/dDxrqwaFOVS5wAKlpuMDrvnkvETM=; b=tALQN3wvAQdOs3h0orLY3bNbJ7
	k3eslpzo6f3C/MwhCFcv2zPZQy7vP/GpMFy8t3tY8I+c0hvpZlv9/BNaTVWA9OWBtTHIGT7/xIafW
	n5FnevLjY771A2io+pj7NX0IFQZ4yV5TAv9XD40GTwXbeFKX/PJHCIyOl9OMvy0Crmiak6GQ/H2Mf
	IbRtW0YAyw/cqX0PZo90FwCa0iwHXWaQweKSaRbGR9LO+5gHGpr34D/C1sq5bwdjxIzx+F44HVAM6
	vQ41FhRs380Zq6fGAXKnSPBww8WPHJBPvyquFQTImhNnxlZckqtztBBoVl+pQxYMDYap5J7tiBoFK
	1y80l3wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVjcX-0000000Aerp-2HAc;
	Thu, 09 Jan 2025 03:54:09 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVjX4-0000000AdtQ-0Whv
	for kexec@lists.infradead.org;
	Thu, 09 Jan 2025 03:48:31 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508IbopB022507;
	Thu, 9 Jan 2025 03:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cZ7QVy
	USfzkXf6/dDxrqwaFOVS5wAKlpuMDrvnkvETM=; b=o58ispttm/sU5niYuHi0rK
	coNmhMOORJCdiZXtBWGiQjQCxZzlqcJ1bGVwmvT2Ygt/c5s+iijpuRwiwpnomucY
	wOvJAVEuIlKfjM+1Dw2+Zq9DmtcAYTZgjo+ReigSrFrrasQUqr6C1TtM9NhpraXK
	rTYdS5PqjJfvfzOlW7pLHaFBf2eKnDVs6atudVECDwsLfCWLk2/5Qu/5CzuRhkqx
	EsWlh01aoQrM7eI92CRyaX79PNRXHG8cNDmw4Rnn550upKzYDyoq27M3ef+qCIoJ
	wq+OHcU8ZD14lfX1DnJMsU00NzVSKggXG7UNIDNEDZksa1rXUHMVjIHAJar6iLDA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441nj3cnmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 03:48:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50926I3d026195;
	Thu, 9 Jan 2025 03:48:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yj12awtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 03:48:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5093mIcx65536282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 03:48:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFC4A2004B;
	Thu,  9 Jan 2025 03:48:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57C5C20040;
	Thu,  9 Jan 2025 03:48:15 +0000 (GMT)
Received: from [9.43.18.121] (unknown [9.43.18.121])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2025 03:48:15 +0000 (GMT)
Message-ID: <32441306-ea5e-44e6-8a8a-7d05d97addce@linux.ibm.com>
Date: Thu, 9 Jan 2025 09:18:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v1 1/5] crash: remove an unused argument from
 reserve_crashkernel_generic()
To: Baoquan he <bhe@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250108101458.406806-1-sourabhjain@linux.ibm.com>
 <20250108101458.406806-2-sourabhjain@linux.ibm.com>
 <Z35eja7aQdnY6ZPS@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Z35eja7aQdnY6ZPS@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5b2N8j7YWtCXoSBmBRUWtsbI-t-SERZi
X-Proofpoint-GUID: 5b2N8j7YWtCXoSBmBRUWtsbI-t-SERZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=691 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_194830_295601_A8082032 
X-CRM114-Status: GOOD (  12.00  )
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

Hello Baoquan,


On 08/01/25 16:46, Baoquan he wrote:
> On 01/08/25 at 03:44pm, Sourabh Jain wrote:
>> cmdline argument is not used in reserve_crashkernel_generic() so remove
>> it. Correspondingly, all the callers have been updated as well.
>>
>> No functional change intended.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan he <bhe@redhat.com>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> CC: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: kexec@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/arm64/mm/init.c          |  6 ++----
>>   arch/loongarch/kernel/setup.c |  5 ++---
>>   arch/riscv/mm/init.c          |  6 ++----
>>   arch/x86/kernel/setup.c       |  6 ++----
>>   include/linux/crash_reserve.h | 11 +++++------
>>   kernel/crash_reserve.c        |  9 ++++-----
>>   6 files changed, 17 insertions(+), 26 deletions(-)
> Acked-by: Baoquan He <bhe@redhat.com>
Thanks for the Ack!

- Sourabh Jain


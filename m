Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627E7C02182
	for <kexec@archiver.kernel.org>; Thu, 23 Jan 2025 11:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LR5n9GkVxfTaElMok3QnHOYgkrzpHmgjrAqxzgax9wI=; b=o6RZivmUIH03SF8gFRmnxdxzeA
	zbYp4zm31xKmZb1hz/Tz2BOxCqMlF0LfFvqp8etjWYzkb+5bdSOx+pHN44VaTVU5w8DSymjvTBQkJ
	uTZ2nphpupC+7HpLa2CNjRdPo1eo99inYIF3CcvZaG6bULRh808uvKdhWd2MjMIYf2K76bknVdf1U
	XPwhOKA419JbAFvXhnkGMgFy3EnUudXbPLYKdZL8aP7XW1LIIMhuYgTWnWxFc3ZDWri+W8BN7gjlJ
	v2h7hSoKjP8IB7s+vxPWv5FLfpkEJusIrI0gcW28VjM+JPHmcGxTGIxrbQsw9XWopclrWbOBDxQQX
	rnAiTB0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tavJ7-0000000CJdz-2xqc;
	Thu, 23 Jan 2025 11:23:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tavI1-0000000CJRA-3tdb
	for kexec@lists.infradead.org;
	Thu, 23 Jan 2025 11:22:27 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N3oIZI017109;
	Thu, 23 Jan 2025 11:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LR5n9G
	kVxfTaElMok3QnHOYgkrzpHmgjrAqxzgax9wI=; b=joON4YHz6ebOzUVJuOrRsG
	DkxS3E+mhHEuMuTrLsNpXoGT640d2UfyO1Ul6uQY4vhoPPv8npp8X2mOZ9uEr126
	ghLAkD/CKN45+QX62ASfoyvBY/jbIu/nCBpOpRMW1LHcbqquPN1MNa/Zz338ojv6
	9F/lZvfm20Vxu83SvnNGXwSDGuptAo3w++8gJWDfhn80nC6C/cUoSZAeTuic/4FV
	eTT8rmV+USxMpVxK2vuTS9FTssWrcLbSMPwN5l0D0qHH69mjRqXFl6ameBaryB5M
	t6ywnom2cKi6pQRskil2fBBkunlgMWFwRP+LToLyQ7FHjf82uMY+Brkjny7ISzQA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44b3gtvpq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 11:22:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50N7fXNx029594;
	Thu, 23 Jan 2025 11:22:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmnn8vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 11:22:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NBMCOD19530166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 11:22:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A62B20049;
	Thu, 23 Jan 2025 11:22:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D259520040;
	Thu, 23 Jan 2025 11:22:10 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 11:22:10 +0000 (GMT)
Message-ID: <feff3c37-4998-43a5-9636-121c87e5d393@linux.ibm.com>
Date: Thu, 23 Jan 2025 16:52:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] powerpc/kdump: preserve user-specified memory
 limit
To: Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>
References: <20250121115442.1278458-1-sourabhjain@linux.ibm.com>
 <20250121115442.1278458-5-sourabhjain@linux.ibm.com>
 <43aeaa2c-c266-4d6e-921d-80b99ceb418b@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <43aeaa2c-c266-4d6e-921d-80b99ceb418b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cmluhe-W408j1Z0_tx81-oGiE3ZSFkxB
X-Proofpoint-GUID: cmluhe-W408j1Z0_tx81-oGiE3ZSFkxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230084
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_032226_094086_4CC71A2C 
X-CRM114-Status: GOOD (  17.12  )
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

Hello Hari,


On 23/01/25 16:00, Hari Bathini wrote:
>
>
> On 21/01/25 5:24 pm, Sourabh Jain wrote:
>> Commit 59d58189f3d9 ("crash: fix crash memory reserve exceed system
>> memory bug") fails crashkernel parsing if the crash size is found to be
>> higher than system RAM, which makes the memory_limit adjustment code
>> ineffective due to an early exit from reserve_crashkernel().
>>
>> Regardless lets not violated the user-specified memory limit by
>
> s/violated/violate/

Noted. It will be fixed in next version.

>
>> adjusting it. Remove this adjustment to ensure all reservations stay
>> within the limit. Commit f94f5ac07983 ("powerpc/fadump: Don't update
>> the user-specified memory limit") did the same for fadump.
>>
>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>

Thanks for the Ack!

- Sourabh Jain


>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan he <bhe@redhat.com>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> CC: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: kexec@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/kexec/core.c | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
>> index b8333a49ea5d..4945b33322ae 100644
>> --- a/arch/powerpc/kexec/core.c
>> +++ b/arch/powerpc/kexec/core.c
>> @@ -150,14 +150,6 @@ void __init reserve_crashkernel(void)
>>           return;
>>       }
>>   -    /* Crash kernel trumps memory limit */
>> -    if (memory_limit && memory_limit <= crashk_res.end) {
>> -        memory_limit = crashk_res.end + 1;
>> -        total_mem_sz = memory_limit;
>> -        printk("Adjusted memory limit for crashkernel, now 0x%llx\n",
>> -               memory_limit);
>> -    }
>> -
>>       printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
>>               "for crashkernel (System RAM: %ldMB)\n",
>>               (unsigned long)(crash_size >> 20),
>



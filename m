Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E93AC3DA4A
	for <kexec@archiver.kernel.org>; Thu,  1 Aug 2024 06:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AqpM6xMPdMWHCrmmSvkuTQle5HFqnurr+61TNMm+kRg=; b=mq3QOQj44z7V+u
	H0C0HS15uNF3Rb6l13VinqMUU6BbOFqAx77o9Lux+UM7L7kmOTll1E+Yr3xd+CHuG+W5WFs9LqxCY
	sHb8HbqNgpo6RKgQWYNqKzl9ODKvUy8AzOcLW1KaFoZ/fWGzDA0b1DqUKWeL2NBNdLkivL9PhNNeC
	gQdj3V9LeQtMgAzJsWWGh+N4zGBRdGq6IUq1/I3KaYxV6z72TVgyoGHRLphLG1XNa6CTyKYc7E990
	rcaN+3Y3Wy7D5k7HDoZYWOoYovaHLS+dfc1V1TzEdkhoq4sE9FG9E8TH7Odr3/T5Y+YBfhsz61WW5
	XzDRWI/Ooa+BJ2qiz73w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZPen-000000044CQ-0Aqi;
	Thu, 01 Aug 2024 06:51:25 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZPek-000000044BZ-3HAQ
	for kexec@lists.infradead.org;
	Thu, 01 Aug 2024 06:51:24 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4714CMb7018034;
	Thu, 1 Aug 2024 06:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=N
	Jz+W/LUjbzIDN1b6dYDqUlovtAkropr3W4j2akjwBo=; b=aWMR8Efe7PmA9QMBS
	vT4vQM0qFrPm6SPucTmM8RCzXP32LfMEQ0/MrftUHizAxWI50sbhQRyNExtN9dpf
	rB13qfm6Z9XDz6Ht8JaBTjXuFWNJV9rAqviCkqvhHJYv+gQL7k96bsEueKaH/ae9
	rvTyqYAtR0H02YO6/NYmHto/Zd0eECzjwoewYH7F8CorsFcK5T26hEbRNOaqSoUH
	EJ2+c/Lo2zyOjnAydfURlSaBYKAD/eSrAahwJZigR5+tnHMWDNAIp3JQVBU5lAOX
	Nlt2eLRiOX+YgCaw075mCphl+k2SF+g7qypzcKzdAX9NTtrgAcVMPupDfuczgXSz
	Yn39A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qyup8rqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 06:51:14 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4716pEFu026334;
	Thu, 1 Aug 2024 06:51:14 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qyup8rq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 06:51:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4715q4U2003773;
	Thu, 1 Aug 2024 06:51:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndemr1u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 06:51:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4716p9gI54460682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 06:51:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A085D20043;
	Thu,  1 Aug 2024 06:51:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 789A320040;
	Thu,  1 Aug 2024 06:51:07 +0000 (GMT)
Received: from [9.43.79.112] (unknown [9.43.79.112])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 06:51:07 +0000 (GMT)
Message-ID: <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
Date: Thu, 1 Aug 2024 12:21:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
To: Michael Ellerman <mpe@ellerman.id.au>, bhe@redhat.com
Cc: Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <87v80lnf8d.fsf@mail.lhotse>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <87v80lnf8d.fsf@mail.lhotse>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zZtioG-S0Int-6TxCosUtQhJal0tsM59
X-Proofpoint-ORIG-GUID: xJ8T4tsuDp-ESR4KmDd7rzqItiiBVLcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_03,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010035
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_235122_970200_C4508E55 
X-CRM114-Status: GOOD (  15.32  )
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

Hello Michael,

On 01/08/24 08:04, Michael Ellerman wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>> The following errors are observed when kexec is done with SMT=off on
>> powerpc.
>>
>> [  358.458385] Removing IBM Power 842 compression device
>> [  374.795734] kexec_core: Starting new kernel
>> [  374.795748] kexec: Waking offline cpu 1.
>> [  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>> [  374.935833] kexec: Waking offline cpu 2.
>> [  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>> snip..
>> [  375.515823] kexec: Waking offline cpu 6.
>> [  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>> [  375.695836] kexec: Waking offline cpu 7.
> Are they actually errors though? Do they block the actual kexec from
> happening? Or are they just warnings in dmesg?

The kexec kernel boots fine.

This warning appears regardless of whether the kdump kernel is loaded.

However, when the kdump kernel is loaded, we will not be able to update 
the kdump image (FDT).
I think this should be fine given that kexec is in progress.

Please let me know your opinion.

> Because the fix looks like it could be racy.

It seems like it is racy, but given that kexec takes the lock first and then
brings the CPU up, which triggers the kdump image, which always fails to
update the kdump image because it could not take the same lock.

Note: the kexec lock is not released unless kexec boot fails.

Thanks,
Sourabh Jain

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

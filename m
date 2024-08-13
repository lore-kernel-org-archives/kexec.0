Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB9AC52D7C
	for <kexec@archiver.kernel.org>; Tue, 13 Aug 2024 05:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96ubgP8fsnEWF0t8TD5FMT5sKYtYHrgOnBggKtajdwM=; b=ULyaXDOJ2GZ9wfP8V2KwbcLYke
	UkNhGYkabDTemtRfb4a3gA6XBokb8sg8IYLt2FpT/qa+TZ5xAhYy6/48Yv+cby59K4D2Gj3C6HciJ
	LyBRVXCc/WAIm7JvL/qgGKHekM/1jZ2sXO4bvxowyRnUK7noz5aqbDFxbzeN3+LemtVZvE3Cq9b4D
	yuZyiNip0wsbjcn1RGZEjZASZBPf4QefqKWqO3IRit0RwEvSulzY+mqxBsuYO2CwZqnY7SlWhxLZH
	dCpiir0KCt1zoLVdLDfH7TgT6KENTICNmE52Rwf8wa6471b5U9rCpOOEaRHezniZETgLTEHQv1fEA
	9OT10ngQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdk58-00000002S9U-1jgB;
	Tue, 13 Aug 2024 05:28:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdk54-00000002S8m-1SYG
	for kexec@lists.infradead.org;
	Tue, 13 Aug 2024 05:28:28 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CNlZcL009210;
	Tue, 13 Aug 2024 05:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	/lNn5nU6xFoZkgBpvGqy1oEMvMo3TWepI8F/OAlN3uQ=; b=ITmNG1XJQUhMGpOI
	iCKpSLHyMYfLEarrxX9AUkiRSKaA6xU/3UmDMvLWvu5nBJBPbjwBjhFhHdZSvcYO
	XknWB+ib+sT/iMuFnZA+FqmXNYiWMpFwTnX4doaksAh7M8eLvlyJyOi8QEjrlgzG
	AXqGjZP8gumnKQygyxJesHEVAm8A4q0j3MfXGPCiRHg5I1Hu5lVozASXCNAxnAUt
	dlpvlD3lRo40ClkAs4BYZ0Z4vF76GTKVfrwIKzH6Tr1Z2hCZyjGV6l6DfIWpcFPz
	sHKqgVZB0KQPl4XNE1gpH3cGBsoBypIDTkNneQclTj9S5xhH4v4Af19R0zU+I56I
	Z2C34A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wy0rpn1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 05:28:21 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47D5SL68008157;
	Tue, 13 Aug 2024 05:28:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wy0rpn1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 05:28:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47D3oiH3016309;
	Tue, 13 Aug 2024 05:28:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xkhphyxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 05:28:20 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47D5SGaO48955810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 05:28:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4437820049;
	Tue, 13 Aug 2024 05:28:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D478C2004D;
	Tue, 13 Aug 2024 05:28:13 +0000 (GMT)
Received: from [9.43.76.60] (unknown [9.43.76.60])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Aug 2024 05:28:13 +0000 (GMT)
Message-ID: <4cbbf314-5134-4a1a-8a4d-f6f8c09104d3@linux.ibm.com>
Date: Tue, 13 Aug 2024 10:58:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Document/kexec: Generalize crash hotplug description
To: Baoquan He <bhe@redhat.com>
Cc: Petr Tesarik <petr@tesarici.cz>, Hari Bathini <hbathini@linux.ibm.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
References: <20240812041651.703156-1-sourabhjain@linux.ibm.com>
 <Zrrpcn7cnCigNfWd@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Zrrpcn7cnCigNfWd@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _t_Jy8gzm8GRubRgPR8-NNNKZC7NI_iL
X-Proofpoint-GUID: y3oYdxfQXZBJ9XHE2X8Vd_g5qQcQ6-aA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=897 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_222826_758659_8E31EBDD 
X-CRM114-Status: GOOD (  11.94  )
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

On 13/08/24 10:34, Baoquan He wrote:
> On 08/12/24 at 09:46am, Sourabh Jain wrote:
> ......
>> ---
>>
>> Changelog:
>>
>> Since v1: https://lore.kernel.org/all/20240805050829.297171-1-sourabhjain@linux.ibm.com/
>>    - Update crash_hotplug sysfs document as suggested by Petr T
>>    - Update an error message in crash_handle_hotplug_event and
>>      crash_check_hotplug_support function.
>>
>> ---
> ......
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 63cf89393c6e..c1048893f4b6 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -505,7 +505,7 @@ int crash_check_hotplug_support(void)
>>   	crash_hotplug_lock();
>>   	/* Obtain lock while reading crash information */
>>   	if (!kexec_trylock()) {
>> -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
>> +		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
> Wondering why this need be updated.

In some architectures, additional kexec segments become obsolete during 
a hotplug event,
so simply calling out the `elfcorehdr may be inaccurate` may not be 
sufficient.
Therefore, it has been generalized with the kdump image.


Thanks,
Sourabh Jain

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

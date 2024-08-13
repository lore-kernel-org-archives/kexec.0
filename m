Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F354DC52D7B
	for <kexec@archiver.kernel.org>; Tue, 13 Aug 2024 09:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IjhJvEi4NzpZPMp6kQl1TrmcjURvU+LkVFR9rK4kywM=; b=Cz2DHHknXfc4g5Q6KkkPxQQpZn
	SBOgUhtaKtkLSbmmneBLLFlNiz5py4nlKf8BLlR0NUlfqlAv9UmZLGvEh/Ri6JKU1XMWyfprtA2Gx
	7IZXYY7W/olPQvc71eNPsFPfsTjaF7QvwDttQVBxWhPlb3qTVmppXMFRUh00cJsax+wX4FMwobh9g
	bC9dhbapJKyE0qjwNUsoUKeeTTVGdgxaC978Fq44/A04nEpsL4M+v59tYVuCfVZGaRYonF5N5wS95
	sMMKiYZLeWz0nnM1VJ4fn3ICanmrEYqNEF3KK9Db6kF9RPhJKF6JrPejJGJNc8P0vtDPBwsMdOwnY
	gcSiNlyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdnmj-000000037x0-1Ryu;
	Tue, 13 Aug 2024 09:25:45 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdnme-000000037vI-2jnl
	for kexec@lists.infradead.org;
	Tue, 13 Aug 2024 09:25:43 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D3Vnu3018119;
	Tue, 13 Aug 2024 09:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	Fmjq/sZIUr/Jjcf29Uzb7wEcxNXRFsmGmtFdBtqwT4w=; b=DgLGzXw83GGe7phw
	V7YqY8nOYFFyweTQ4Cj+/OTkFld++bNCqsgzSSeJOZRtF3+yQX/Oc3YrBwZ59IkA
	QRS4xqciI2K1D92EC3Fw8e6dtDYPwl3yzOtr9R8zsRcnhz7BlWcHCYW52Gsd5HQ8
	NddLj7jo3/W2f6uS5rVLdwTZhHw/irBYD/SuGpFp89KTj3qTk4Udwob6LNTxKPIj
	MzgZhin7/jA4p2tWiWauSxqb9+PXFJwXqeND19qjJyz6r/ALiGz+Zfbg/vLiIWKw
	KQqAyQXgx5MSXd43y8x1iojrBie82PVdDZHyB2rzKWOg21FQL1uqF4xGQkXDmAyp
	V2OzMg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40x0bdy878-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 09:25:37 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47D9Pap1013327;
	Tue, 13 Aug 2024 09:25:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40x0bdy874-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 09:25:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47D94o4E030506;
	Tue, 13 Aug 2024 09:25:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xmrmakpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 09:25:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47D9PVvO45941122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 09:25:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D315E2006A;
	Tue, 13 Aug 2024 09:25:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C99CC20040;
	Tue, 13 Aug 2024 09:25:29 +0000 (GMT)
Received: from [9.43.10.252] (unknown [9.43.10.252])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Aug 2024 09:25:29 +0000 (GMT)
Message-ID: <4ccfd375-f588-4b9a-b505-49e021b90817@linux.ibm.com>
Date: Tue, 13 Aug 2024 14:55:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Document/kexec: Generalize crash hotplug description
To: Baoquan He <bhe@redhat.com>
Cc: Petr Tesarik <petr@tesarici.cz>, Hari Bathini <hbathini@linux.ibm.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
References: <20240812041651.703156-1-sourabhjain@linux.ibm.com>
 <Zrrpcn7cnCigNfWd@MiWiFi-R3L-srv>
 <4cbbf314-5134-4a1a-8a4d-f6f8c09104d3@linux.ibm.com>
 <ZrskkDuMlQu+uBN4@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZrskkDuMlQu+uBN4@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o2ld83ZFTe646T1r4Gb-yJqJAyQ9AOhM
X-Proofpoint-ORIG-GUID: mH09R_W4tWPqWPosrpeidR1jZPoCT_Rq
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_01,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=847 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130064
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_022540_866463_ADC45FEC 
X-CRM114-Status: GOOD (  12.68  )
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

Hello Boaquan,

On 13/08/24 14:47, Baoquan He wrote:
> On 08/13/24 at 10:58am, Sourabh Jain wrote:
>> Hello Baoquan,
>>
>> On 13/08/24 10:34, Baoquan He wrote:
>>> On 08/12/24 at 09:46am, Sourabh Jain wrote:
>>> ......
>>>> ---
>>>>
>>>> Changelog:
>>>>
>>>> Since v1: https://lore.kernel.org/all/20240805050829.297171-1-sourabhjain@linux.ibm.com/
>>>>     - Update crash_hotplug sysfs document as suggested by Petr T
>>>>     - Update an error message in crash_handle_hotplug_event and
>>>>       crash_check_hotplug_support function.
>>>>
>>>> ---
>>> ......
>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>>> index 63cf89393c6e..c1048893f4b6 100644
>>>> --- a/kernel/crash_core.c
>>>> +++ b/kernel/crash_core.c
>>>> @@ -505,7 +505,7 @@ int crash_check_hotplug_support(void)
>>>>    	crash_hotplug_lock();
>>>>    	/* Obtain lock while reading crash information */
>>>>    	if (!kexec_trylock()) {
>>>> -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
>>>> +		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
>>> Wondering why this need be updated.
>> In some architectures, additional kexec segments become obsolete during a
>> hotplug event,
>> so simply calling out the `elfcorehdr may be inaccurate` may not be
>> sufficient.
>> Therefore, it has been generalized with the kdump image.
> OK, I forgot the case in ppc, makes sense to me, thx.
>
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks for the Ack!

- Sourabh Jain

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

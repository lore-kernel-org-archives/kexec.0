Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7301CC48BC4
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 05:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mKdI/d0AUC8NMGmuBKYtte4neKM93+GTEkdBekNqmns=; b=hwQjQdNHjkMLgTcDXuU0MYEnMU
	3mkjb9OvStTJ7x+Pjy/Rtsg7HjRTHmjFEBcqNthb1+num3pjPcjiwmWfwPQDVvkPWEE7KPpfteIfA
	/o+OC0af8M4Daz4/ZtD04QDBc6htxrps5IH0TPK/kGzwdrQDs03VeFLL5iJL5mZAfSacoTNB91fEU
	yuqWAXfZB8kLoqO7Om3b4vWaSH8SsU46oHLEgyIMIWvtDSoAq5VPDg1xQLhsB/L/vO0b+Pfk9O0EQ
	cBLrVbuPX5SR2EnwFPzJm8fx9dgrOHARxHQA4Lrih89WIpiUSIcb7n6Hl5ZU4bvHePT3eA/1PZIfq
	s0rwrJ7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdOK0-000000082Gy-34iL;
	Fri, 23 Feb 2024 05:42:08 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdOJs-000000082DF-37uU;
	Fri, 23 Feb 2024 05:42:05 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41N5RXw3004732;
	Fri, 23 Feb 2024 05:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9W7fRpp8Cej2/m5IqM60+RYoP+1x8jnLMKf+yYsewb0=;
 b=YO0gqY9t0bx79WYOElJAN7nfMxSwEMvUjlvxhvpKChKkvWhhMbq5C6e3f3JID70WzZUB
 rPBCjbR++48o+ovfcULGU+OdjbZ4R8nFMX5SfUQvDcU0Ieojf7C0+3Pkk+i3qZBGKol6
 xdbYSNp6gBIDl484VQG7sXpbA3VO+BD4S6UYLA6sTLlR6W8gezf4EYZD4aKIu+DMpJd5
 35eQJeacQafTSwc5cDy7sngWhidEKvsxUgYCF14kz3QykXv+1dQdF2126FH4VuUD3E8h
 muSaq9/gRXVvHlCI57GSuG3fKPKwp+Bz7a/oHCw+PHPETndzRum38dBSdp42+48oPJUB sg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wen7vg7n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 05:41:52 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41N5Sx6S007880;
	Fri, 23 Feb 2024 05:41:51 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wen7vg7mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 05:41:51 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41N3awRg031187;
	Fri, 23 Feb 2024 05:41:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bmawmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 05:41:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41N5fkDf9503378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 05:41:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6C262004B;
	Fri, 23 Feb 2024 05:41:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D0082004D;
	Fri, 23 Feb 2024 05:41:42 +0000 (GMT)
Received: from [9.43.109.8] (unknown [9.43.109.8])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 05:41:42 +0000 (GMT)
Message-ID: <386202f8-852c-477e-b9c4-f37896559a34@linux.ibm.com>
Date: Fri, 23 Feb 2024 11:11:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] Split crash out from kexec and clean up related
 config items
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org, Baoquan He <bhe@redhat.com>, piliu@redhat.com,
        linux-sh@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        ebiederm@xmission.com, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, viro@zeniv.linux.org.uk
References: <20240119145241.769622-1-bhe@redhat.com>
 <9101bb07-70f1-476c-bec9-ec67e9899744@linux.ibm.com>
 <Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv>
 <559f2595-1477-4ef0-80e4-85ae8b426de7@linux.ibm.com>
 <20240221125752.36fbfe9c307496313198b60f@linux-foundation.org>
 <3393a42f-d9b3-4031-bdef-78bb2ce758f1@linux.ibm.com>
 <20240222132936.e7dc50acbf5d1b653cb2e02c@linux-foundation.org>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20240222132936.e7dc50acbf5d1b653cb2e02c@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1e6y87d1DlwScItsjN2uRAkEKSoC1BFr
X-Proofpoint-ORIG-GUID: dp_4k7D0Bmax-JRhiGBq4xwolmlG7ETz
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_214202_052852_14AA604D 
X-CRM114-Status: GOOD (  17.61  )
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



On 23/02/24 2:59 am, Andrew Morton wrote:
> On Thu, 22 Feb 2024 10:47:29 +0530 Hari Bathini <hbathini@linux.ibm.com> wrote:
> 
>>
>>
>> On 22/02/24 2:27 am, Andrew Morton wrote:
>>> On Wed, 21 Feb 2024 11:15:00 +0530 Hari Bathini <hbathini@linux.ibm.com> wrote:
>>>
>>>> On 04/02/24 8:56 am, Baoquan He wrote:
>>>>>>> Hope Hari and Pingfan can help have a look, see if
>>>>>>> it's doable. Now, I make it either have both kexec and crash enabled, or
>>>>>>> disable both of them altogether.
>>>>>>
>>>>>> Sure. I will take a closer look...
>>>>> Thanks a lot. Please feel free to post patches to make that, or I can do
>>>>> it with your support or suggestion.
>>>>
>>>> Tested your changes and on top of these changes, came up with the below
>>>> changes to get it working for powerpc:
>>>>
>>>>    
>>>> https://lore.kernel.org/all/20240213113150.1148276-1-hbathini@linux.ibm.com/
>>>
>>> So can we take it that you're OK with Baoquan's series as-is?
>>
>> Hi Andrew,
>>
>> If you mean
>>
>> v3 (https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/)
>> +
>> follow-up from Baoquan
>> (https://lore.kernel.org/all/Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv/)
>>
>> Yes.
>>
> 
> Can I add your Acked-by: and/or Tested-by: to the patches in this series?

Sure, Andrew.

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

for..

Patches 1-5 & 8 in:

   https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/

and this follow-up patch:

   https://lore.kernel.org/all/Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv/

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

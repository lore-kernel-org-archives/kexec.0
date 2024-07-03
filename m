Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE6CC2BD09
	for <kexec@archiver.kernel.org>; Wed,  3 Jul 2024 18:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yB4StvYBySHxd9RBGldQOvwN0+do+VFgb5Wa3TnphZY=; b=P9p0U6UXChL4kN
	yc3CTnjOh1d93P3tycHuOsF2nnaamSjUjy4P1P8XvTxXIMNl4z3D5eqIhl9MoAz8AqxPqz2QN5CJ7
	z0U6yE/2d7/JDvoZ4RL5DSXa3Mszj3pVn1WgoZrC+cnCL/jntNT03cYLyXl+I5ATIBzKqj0/UQ++2
	1NZWg6npCDiiqWaiFeURwLs86feAuCiWjfIxDwqdYg/e5+mG7YtKylZJnQGYPUZ6ShEWVK4fRdXWV
	EkjxccE2JkTYIZGDpohAkOGEcoplUi+yc+Hgy1GOZYYxEm9fMevcKw3epAt9kqJLbEoKQrPpNM461
	Bbl6/Zs3Y8i57XfaoGNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP4TT-0000000B871-3gXW;
	Wed, 03 Jul 2024 18:12:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP4TQ-0000000B86I-3Oe9
	for kexec@lists.infradead.org;
	Wed, 03 Jul 2024 18:12:58 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463IChUN018337;
	Wed, 3 Jul 2024 18:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=F
	weMSns6bm7twrZ+B8i7d3Lg5RQRPQjszQSwv1he6W8=; b=O44Z4ZRVRIE/EBH7j
	gUJy8yRaxVx+zYHHVVafFLnJPsqcK+VW0whKjt59B0PKohenHGtIwzpWEsfaqLY+
	opjDEsu7+9kV5yHrnvgRXQNGc3xVUQ8TFMlDUeRdHN28Bca2kRahmvyFdp5Ti3eI
	bhaUftGxSXjF/N10PyUhK7ImJvPQinMA4WjMluX1NDTOO1fS1PeDVdMSi+dmaAGW
	H3hyBZbAqaDdaoPu70KTW/P5nokzM+P/6ZWKfJCa8FgG49wnJh0hqgC6rAoQvW1N
	18KxeBsfdTRNmUd4wrBVJ25ZljtBFSj1Sczw0RaCD9zEoSfdab+M65H216bIcHwY
	YhEDg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 405bgur11h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 18:12:52 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 463ICq0k018449;
	Wed, 3 Jul 2024 18:12:52 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 405bgur11d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 18:12:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 463GmKOG009455;
	Wed, 3 Jul 2024 18:12:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 402xtmupte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 18:12:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 463ICkkV56557852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jul 2024 18:12:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05E3C20040;
	Wed,  3 Jul 2024 18:12:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2B5B2004D;
	Wed,  3 Jul 2024 18:12:43 +0000 (GMT)
Received: from [9.43.78.85] (unknown [9.43.78.85])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jul 2024 18:12:43 +0000 (GMT)
Message-ID: <17f42d4e-5b26-4ec4-a570-a58a699d3863@linux.ibm.com>
Date: Wed, 3 Jul 2024 23:42:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] doc/hotplug: update man and --help
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Aditya Gupta <adityag@linux.ibm.com>,
        Coiby Xu <coxu@redhat.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>
References: <20240702043057.200211-1-sourabhjain@linux.ibm.com>
 <20240702043057.200211-3-sourabhjain@linux.ibm.com>
 <ZoTh9E8BJt+E3ctg@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZoTh9E8BJt+E3ctg@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XJsGln_G7O1oi87slHbun1i8H6oCgk9U
X-Proofpoint-ORIG-GUID: zZ5xIcaQhBrPKw8LB662xjZ9-0UF5UhM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_12,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=838 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_111257_014892_C9424770 
X-CRM114-Status: GOOD (  12.51  )
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


On 03/07/24 11:00, Baoquan He wrote:
> On 07/02/24 at 10:00am, Sourabh Jain wrote:
>> Update the man page and --help option to make the description of the
>> --hotplug option easier to understand.
>>
>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Coiby Xu <coxu@redhat.com>
>> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>> Changelog:
>>
>>  From v2 -> v3
>>    - Updated --hotplug option description
>>
>> ---
>>   kexec/kexec.8 | 8 ++++----
>>   kexec/kexec.c | 4 +++-
>>   2 files changed, 7 insertions(+), 5 deletions(-)
> Acked-by: Baoquan He <bhe@redhat.com>
Thanks for Ack!

- Sourabh Jain

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

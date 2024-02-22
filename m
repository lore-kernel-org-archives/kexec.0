Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCC8C48BEB
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 05:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K4bjR8b3h1896rqimaGGOwrT7U5jn95h7h10cU4KTPk=; b=JeKF7P/RI5oIBW3kRj5skmnEbB
	K9wzEzfd9MV+/J99ZYnlv4cZKYwMdBFcaaG3xicIx3APB8K1jUycRFKVrMM08TvXs+57g0f6c3eB6
	YuXWG5JupB2NRt1DA3N9VyfDZpMs1zjoge6phgNu0hO/+Yzr953RWVtGrr6ahXZ9CaS2dM0gXzla+
	BlTJhjcTZRFg8gV3d5IArJnoOn8Y/Y3ZOhKm3iz5WytaNclMjAQyUuncIFHj96b1WxkvkjmGudz11
	qezwjJUGxJ649b5YRD+hb8obM9ml39bB3sSJXkskPCDKwdcIIcp/xMmv6cQ1g0eB7omtwFVv+bRxf
	LU11UvZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd1St-00000003ZT3-3Q0Z;
	Thu, 22 Feb 2024 05:17:47 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd1Sp-00000003ZRJ-3WPH;
	Thu, 22 Feb 2024 05:17:45 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41M4R18H006546;
	Thu, 22 Feb 2024 05:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=K/2wCf7f7QyZDGdorAUOAQQO5+gbW6WWu/gqndqtKoo=;
 b=j2df0zYHchuygCjJA8VvcPJMD5NOOimHOizytE+BsJqendgmCw6liiefKOdO4Xk7oI8Q
 gLl8/2EYckkCCycaJE4Szarj0rlNtu6VXE6fglTkfAs+zC42vvveYZ5Apuzi56mjFD6n
 ht6Ro0ysut5PTMuIhaFaVfKZ+JUHSXg9FO3O7gjfj+HLyqSANQMqT/KDC7PpAcclPX+o
 rcrcpXnXQEEFtArWb/OOPEkml2HwlyEwP6j4+5u7Eu91Xrsu8cRJ71wOeNbqtRSl5DLa
 HMao4YJOoPUb06NpNWUX1AmnN0OKe1mGq5EkL7G7K2+NEqVVboq5N1SbaAjZvCo+cb79 VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdy8g90us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 05:17:39 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41M5El9B013094;
	Thu, 22 Feb 2024 05:17:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdy8g90tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 05:17:38 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41M3Yqmv031143;
	Thu, 22 Feb 2024 05:17:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bm3my2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 05:17:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41M5HXgC65929482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 05:17:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 442CE2004E;
	Thu, 22 Feb 2024 05:17:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CF102004B;
	Thu, 22 Feb 2024 05:17:30 +0000 (GMT)
Received: from [9.203.115.195] (unknown [9.203.115.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Feb 2024 05:17:30 +0000 (GMT)
Message-ID: <3393a42f-d9b3-4031-bdef-78bb2ce758f1@linux.ibm.com>
Date: Thu, 22 Feb 2024 10:47:29 +0530
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
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20240221125752.36fbfe9c307496313198b60f@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Uw-TiETYrrtmy9xa6nwhBWKWx0V7gLnU
X-Proofpoint-ORIG-GUID: pNdWEEFYaOYyVGnBPerBSEQApCC4_Zph
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_03,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_211744_146431_B5497CCB 
X-CRM114-Status: GOOD (  16.27  )
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



On 22/02/24 2:27 am, Andrew Morton wrote:
> On Wed, 21 Feb 2024 11:15:00 +0530 Hari Bathini <hbathini@linux.ibm.com> wrote:
> 
>> On 04/02/24 8:56 am, Baoquan He wrote:
>>>>> Hope Hari and Pingfan can help have a look, see if
>>>>> it's doable. Now, I make it either have both kexec and crash enabled, or
>>>>> disable both of them altogether.
>>>>
>>>> Sure. I will take a closer look...
>>> Thanks a lot. Please feel free to post patches to make that, or I can do
>>> it with your support or suggestion.
>>
>> Tested your changes and on top of these changes, came up with the below
>> changes to get it working for powerpc:
>>
>>   
>> https://lore.kernel.org/all/20240213113150.1148276-1-hbathini@linux.ibm.com/
> 
> So can we take it that you're OK with Baoquan's series as-is?

Hi Andrew,

If you mean

v3 (https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/)
+
follow-up from Baoquan 
(https://lore.kernel.org/all/Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv/)

Yes.

My changes are based on top of the above patches..

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1DDEE57DF
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 06:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9lDVioZfY3LfmcnCNHKIQEMqZii6UQoM5V2m1VYiBGk=; b=jY9Wgx3bukbCgn
	fsuJxeTlshyLB0YRW+NtZW4LkJAwDqdEAtvP3GeBTL1vWRQoZpLMksM6eS6v6jhfOm0/VUdk+zowI
	+l6hpawrKEg46MH6B2VE/uFeAcPeSUj++1EDeABRAPrawlAr/NlMaQ/nq1vw1Su34AFsP/2GDf3//
	cUd8B2jGGBpCFHFEHBWc56mXqIsv5wNw/fG52dMq+2Ruiq0KugmU2DXWpQhW/eoBexxHPylErlp7h
	XrnTCNyOS8K6XD6mG282U5Ab/OVMe8qM1hnVc78L0CUJCmgLyALcbvSAkeGqI09EKQTfg3YtOgANq
	eHbsYWCJiiPFSXUf5baQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfaV9-00HKWT-2C;
	Mon, 11 Sep 2023 06:34:27 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfaV6-00HKVh-0w
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 06:34:25 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B5b0qX024937;
	Mon, 11 Sep 2023 06:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jbaRXs0JDI+EbNI97y0el2icMAsDKOPkHEpxiyV9O44=;
 b=iyfFJKz6sb16lPyew61uIECsoFxacPC5RbD/3IRyDq7y+aqPyyQ8hBKJRYCUl+sgY/5Q
 X75RB23iZART+95IVc1aBuhyIx3nJrmsNG0br6HioMeupnvmLJ6NLG8GDfkGUavqeMp1
 hmQA9RTzuBVk9YmVRRX3LuG84cVwX09agoZ0OR3VvZ4QjI1DePbmOwcYayF8aCkfs9tE
 6z5G3QEWILXu7koc/HZzOUGcDh++t3bEWPPsnVvAE2yFXA9H+pOqOcZgHZhQwYZuXPFU
 xv7p6Pysh0E8DY576zBOnchk7n3dCC1tHgKxfro5Pw6FSYCNDwTRGBDORwBHmjVT8Nxb eA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1ut1jf4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Sep 2023 06:34:14 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38B6T4dp020618;
	Mon, 11 Sep 2023 06:34:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1ut1jf3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Sep 2023 06:34:13 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38B53gpk023099;
	Mon, 11 Sep 2023 06:34:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t141n8e27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Sep 2023 06:34:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38B6YA2w22938340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Sep 2023 06:34:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64DFA2004B;
	Mon, 11 Sep 2023 06:34:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0CED20040;
	Mon, 11 Sep 2023 06:34:09 +0000 (GMT)
Received: from [9.43.41.70] (unknown [9.43.41.70])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Sep 2023 06:34:09 +0000 (GMT)
Message-ID: <70462450-b31f-fdfd-031f-debb89c118ac@linux.ibm.com>
Date: Mon, 11 Sep 2023 12:04:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] kexec: update manpage with explicit mention of clean
 kexec
To: Baoquan He <bhe@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Kexec-ml <kexec@lists.infradead.org>
References: <20230707052929.427625-1-hbathini@linux.ibm.com>
 <63e65749-4ec7-c618-72d3-1568992fff7a@linux.ibm.com>
 <20230828074810.GY3523530@kernel.org> <ZOxr7VjBhBe6WW91@MiWiFi-R3L-srv>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <ZOxr7VjBhBe6WW91@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5BR_jcK3gm0OKLM-u2JUTMgxg_g49-k2
X-Proofpoint-GUID: l8NNiXNpRVGHu77ARYMNUtaqC1-2cUpD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230910_233424_580239_C2AAAD3B 
X-CRM114-Status: GOOD (  25.90  )
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



On 28/08/23 3:12 pm, Baoquan He wrote:
> On 08/28/23 at 09:48am, Simon Horman wrote:
>> On Mon, Aug 28, 2023 at 11:46:14AM +0530, Hari Bathini wrote:
>>> Any comments on this, please..
>>
>> Hi Hari,
>>
>> Sorry, I had missed this.
>>
>>> On 07/07/23 10:59 am, Hari Bathini wrote:
>>>> While the manpage does mention about kexec boot with a clean shutdown,
>>>> it is not explicit about it. Make it explicit.
>>>>
>>>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>>>> ---
>>>>    kexec/kexec.8 | 12 ++++++++++--
>>>>    1 file changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kexec/kexec.8 b/kexec/kexec.8
>>>> index 3a344c5..87e4ab5 100644
>>>> --- a/kexec/kexec.8
>>>> +++ b/kexec/kexec.8
>>>> @@ -95,8 +95,16 @@ then you would use the following command to load the kernel:
>>>>    .RB "\-\-append=" "root=/dev/hda1" "\ \-\-initrd=" /boot/initrd
>>>>    .RE
>>>>    .PP
>>>> -After this kernel is loaded, it can be booted to at any time using the
>>>> -command:
>>>> +After this kernel is loaded, assuming your Linux distribution supports
>>>> +kexec-based rebooting, it can be booted to, with a clean shutdown, using
>>>> +the command:
>>
>> Perhaps user-space would be better than "your Linux distribution".
>> But perhaps that is just kernel developer speak and makes less
>> sense to others.
> 
> Agree, linux distrobution doesn't make sense here. And since this is a
> kexec man page, does it really need to make this change? We know
> kexec-tools loaded a kernel, we will use kexec-tools to trigger the
> reboot. Wondering why we need to stress distros or kernel or kexec-tools
> supports the kexec-based rebooting. 'with a clean shutdown' seems a
> little helpful though.

Yeah. Users did express that lack of clarity on what is the cleaner
approach to use kexec boot after load. That prompted this patch.
I am ok with "user-space" or "your linux distribution".

Simon, do you want to respin with "user-space" change instead?

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

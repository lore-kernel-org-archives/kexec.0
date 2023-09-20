Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404CFCE79CF
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 13:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HT7k2U+8kU+kdln+Pxwupk1dtyYLnJb/zTkYutvZqB0=; b=vhPa1QaPzXPBsn
	4u/oSvz7olsam0L1zDDaeIQrMu4eMy4bq5AUaE4V8VROtuFCE558+XnVUCGDqANuDzmhSfIUADG+z
	Dk0qGMfqiCDZjlwrlgKENJ6xNO2F643kELh1r/2y+ABqrl4hrUAJtouppoPDsNXkQm5mCos/Wo6YU
	Qv23xZAZxhBnifw4rKVwaocZAqTb/7SfaCLF6Bo0DXMKAThGBmfT9UHmlqD154TyFjfZeNaWitGNc
	b9iSsitQ0MDzaaFOcXWnxef3TYATMNV0+7lw80wRhEMBcT36BrMr0aMlsnouXUsMjAjfylhtqbken
	jHtB0WDBI9AZfufpgneA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwpO-0037JS-1F;
	Wed, 20 Sep 2023 13:01:14 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwpK-0037Ij-12
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 13:01:12 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KCcisc025158;
	Wed, 20 Sep 2023 13:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ArGqLlUJX2M5vqRnZJPPeYSX0LEVAZgdc5cKjv8YmyI=;
 b=mOeot4OJGoECH6Z0et6geliJMhdrpFDblkg6KlgnXggyGSoOKwLPu5d3TeVqJKbqV8hj
 K20SvnO/LD3xNobd+F5CVWXbjUyT91IEz8VNJIVEFk0EwheA7hpvmmEeQoEDEqaYP9QW
 JvpOh9nE1OdNUZt0V8krH2oYLuCg7jAMLfSYMeciHACIuo5V5fUrKUeMvCbsNjyBzmuz
 raQ8ebkSK+rv/Sbmryz9N9sGQ/20672juEUT8npcs8IFU8qtKfNDfV5tjAAki0T4YQNR
 xIS0YJ2THgbKK0UrXzzZ+r9qMfyxssnnoygatramjHzYlVJMwiXgfT+cXMatM2DHJFoW eA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7ydwjx48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Sep 2023 13:01:00 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38KCtr0P026353;
	Wed, 20 Sep 2023 13:01:00 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7ydwjx3n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Sep 2023 13:01:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38KA8tki016463;
	Wed, 20 Sep 2023 12:01:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd24xg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Sep 2023 12:01:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38KC17q420447760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Sep 2023 12:01:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27F0120063;
	Wed, 20 Sep 2023 12:01:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6184F2004E;
	Wed, 20 Sep 2023 12:01:06 +0000 (GMT)
Received: from [9.203.106.137] (unknown [9.203.106.137])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Sep 2023 12:01:06 +0000 (GMT)
Message-ID: <ae22754c-18b0-24d2-a773-2792b2986492@linux.ibm.com>
Date: Wed, 20 Sep 2023 17:31:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] kexec: update manpage with explicit mention of clean
 kexec
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, Kexec-ml <kexec@lists.infradead.org>
References: <20230707052929.427625-1-hbathini@linux.ibm.com>
 <63e65749-4ec7-c618-72d3-1568992fff7a@linux.ibm.com>
 <20230828074810.GY3523530@kernel.org> <ZOxr7VjBhBe6WW91@MiWiFi-R3L-srv>
 <70462450-b31f-fdfd-031f-debb89c118ac@linux.ibm.com>
 <20230920114123.GD224399@kernel.org>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20230920114123.GD224399@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tBMApj5gcGw6ya3KxjdtVXvkiUs2EyCm
X-Proofpoint-ORIG-GUID: GmyfSjIQapqgjztVH4D14FWY3em0vtcY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309200102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_060110_772698_7FC6EB5C 
X-CRM114-Status: GOOD (  27.50  )
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



On 20/09/23 5:11 pm, Simon Horman wrote:
> On Mon, Sep 11, 2023 at 12:04:08PM +0530, Hari Bathini wrote:
>>
>>
>> On 28/08/23 3:12 pm, Baoquan He wrote:
>>> On 08/28/23 at 09:48am, Simon Horman wrote:
>>>> On Mon, Aug 28, 2023 at 11:46:14AM +0530, Hari Bathini wrote:
>>>>> Any comments on this, please..
>>>>
>>>> Hi Hari,
>>>>
>>>> Sorry, I had missed this.
>>>>
>>>>> On 07/07/23 10:59 am, Hari Bathini wrote:
>>>>>> While the manpage does mention about kexec boot with a clean shutdown,
>>>>>> it is not explicit about it. Make it explicit.
>>>>>>
>>>>>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>>>>>> ---
>>>>>>     kexec/kexec.8 | 12 ++++++++++--
>>>>>>     1 file changed, 10 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/kexec/kexec.8 b/kexec/kexec.8
>>>>>> index 3a344c5..87e4ab5 100644
>>>>>> --- a/kexec/kexec.8
>>>>>> +++ b/kexec/kexec.8
>>>>>> @@ -95,8 +95,16 @@ then you would use the following command to load the kernel:
>>>>>>     .RB "\-\-append=" "root=/dev/hda1" "\ \-\-initrd=" /boot/initrd
>>>>>>     .RE
>>>>>>     .PP
>>>>>> -After this kernel is loaded, it can be booted to at any time using the
>>>>>> -command:
>>>>>> +After this kernel is loaded, assuming your Linux distribution supports
>>>>>> +kexec-based rebooting, it can be booted to, with a clean shutdown, using
>>>>>> +the command:
>>>>
>>>> Perhaps user-space would be better than "your Linux distribution".
>>>> But perhaps that is just kernel developer speak and makes less
>>>> sense to others.
>>>
>>> Agree, linux distrobution doesn't make sense here. And since this is a
>>> kexec man page, does it really need to make this change? We know
>>> kexec-tools loaded a kernel, we will use kexec-tools to trigger the
>>> reboot. Wondering why we need to stress distros or kernel or kexec-tools
>>> supports the kexec-based rebooting. 'with a clean shutdown' seems a
>>> little helpful though.
>>
>> Yeah. Users did express that lack of clarity on what is the cleaner
>> approach to use kexec boot after load. That prompted this patch.
>> I am ok with "user-space" or "your linux distribution".
>>
>> Simon, do you want to respin with "user-space" change instead?
> 
> Yes, I think that would be best.

Sure, Simon.
Sent v2.

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

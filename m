Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF33C83F11
	for <kexec@archiver.kernel.org>; Mon, 28 Aug 2023 10:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NZCGaOPXk/6P2MK9otrOuYFi7ZH1C+C+ew4WSiKtF88=; b=R/o6eSVEOanaqO
	hnxRv1Sfms7Cd2Qsqg1ktbafOtgY0UqvupyHLrrHlC3gu+Hkx9neBXPgy+cu7AhFuiAkrZC0ymbKb
	GeV8tlcQmUIocgDWI3tm/vt7fG9M6MSLbifOmwPglml7lOeFVLf+LQNPnwZJUXkFCyeN0XzPsvV/U
	rJh8AIR2PWJ1ZPSloAz0MLGHhvC/6xUuOHUAiZmNkuazBSmRPaLP7PdjAZ0a0GFfaswjA59C4iNcb
	NAsSWlwLE0NaohmnQnn6YTTct1v5yHuR2XI+LwGv+Y+y73KFiWJ5DQg4txecTYJ6ELg2z0wvpVQQp
	lmA/XgNxkodWvDi13AbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaZT2-009Qip-1Y;
	Mon, 28 Aug 2023 10:27:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaZSz-009Qdo-0e
	for kexec@lists.infradead.org;
	Mon, 28 Aug 2023 10:27:30 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S9aI8E027559;
	Mon, 28 Aug 2023 10:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YmMjGeyyYaXb83MMjvOqoQJdCsWfxuiCmk0rUQxeIzw=;
 b=q1hKh6sxxdA80dpB+2XpPYyNbkNMDqlKg01A3LCcP+t0dVVuOykU0y6n8hcP2li/4vqu
 GSqmE+DgCtNuo2NVtUMlh/RZjSNuw/ZYBZgjm8FPD9TwlSG1FHf6lbDy2gdA6RPT3h6j
 eLbXuuf7b5Aew3jaZ2AebdCGISWrp9qyUuk0/sz3vGzkVdN8P9zA1rtI2OJVdfpLfyLI
 oNR78N+rX32ADsOPqrITVEQMPwdbJA2jwZLHM1RjTKVrqMYQzBqGrkP0F4wRvdlHdR2f
 MnMajrNoAX1Tthqq1KUalLBrdwV00UF/zaZTIFriCGSGVxNFL/VHz7plMpK6Li5PYGkC /w== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sradxs0r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Aug 2023 10:27:16 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37S8Ilne014114;
	Mon, 28 Aug 2023 10:27:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxjhfsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Aug 2023 10:27:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37SARDGA43647284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Aug 2023 10:27:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAB5020071;
	Mon, 28 Aug 2023 10:27:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C6162006E;
	Mon, 28 Aug 2023 10:27:13 +0000 (GMT)
Received: from [9.203.106.137] (unknown [9.203.106.137])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Aug 2023 10:27:12 +0000 (GMT)
Message-ID: <4f81d535-ff2c-fba3-8285-7e68bd6493bb@linux.ibm.com>
Date: Mon, 28 Aug 2023 15:57:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] kexec: update manpage with explicit mention of clean
 kexec
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: Kexec-ml <kexec@lists.infradead.org>
References: <20230707052929.427625-1-hbathini@linux.ibm.com>
 <63e65749-4ec7-c618-72d3-1568992fff7a@linux.ibm.com>
 <20230828074810.GY3523530@kernel.org>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20230828074810.GY3523530@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2T-UQtYlT004SVY4vb6mCzzsH0eT8w-n
X-Proofpoint-ORIG-GUID: 2T-UQtYlT004SVY4vb6mCzzsH0eT8w-n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_07,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=822 clxscore=1015
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_032729_531459_11BC40EF 
X-CRM114-Status: GOOD (  24.55  )
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



On 28/08/23 1:18 pm, Simon Horman wrote:
> On Mon, Aug 28, 2023 at 11:46:14AM +0530, Hari Bathini wrote:
>> Any comments on this, please..
> 
> Hi Hari,
> 
> Sorry, I had missed this.

No worries. Thanks for the response.

> 
>> On 07/07/23 10:59 am, Hari Bathini wrote:
>>> While the manpage does mention about kexec boot with a clean shutdown,
>>> it is not explicit about it. Make it explicit.
>>>
>>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>>> ---
>>>    kexec/kexec.8 | 12 ++++++++++--
>>>    1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kexec/kexec.8 b/kexec/kexec.8
>>> index 3a344c5..87e4ab5 100644
>>> --- a/kexec/kexec.8
>>> +++ b/kexec/kexec.8
>>> @@ -95,8 +95,16 @@ then you would use the following command to load the kernel:
>>>    .RB "\-\-append=" "root=/dev/hda1" "\ \-\-initrd=" /boot/initrd
>>>    .RE
>>>    .PP
>>> -After this kernel is loaded, it can be booted to at any time using the
>>> -command:
>>> +After this kernel is loaded, assuming your Linux distribution supports
>>> +kexec-based rebooting, it can be booted to, with a clean shutdown, using
>>> +the command:
> 
> Perhaps user-space would be better than "your Linux distribution".
> But perhaps that is just kernel developer speak and makes less
> sense to others.

No strong inclination to putting it either way. Would leave it to you :)

- Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

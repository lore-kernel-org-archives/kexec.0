Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EF5C3271E
	for <kexec@archiver.kernel.org>; Mon,  8 Jul 2024 07:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0b+S5iurKQ/Ue3I7lD4kXwOtGxBMHm2JpI2IbAhj4BM=; b=gK9lzcNc2C9YAj
	iMZdCuRe2AZzU2+aLMkNQOiS9cQHDnTezHsbdWHJCwQ3sKSF6rkPC+x4SpV/NEa5/QKY51k3rF5sf
	PIXmnrdUp9fopH8pJDM0tnERklJ5knroU/N2Q2QLn+jdh8RX5DA8YL9txWN7ZJWF9wiCs6uAe45o6
	NDy/IUSbmO3fARdKzxrOYlX1RlpBj/vMVEKod73l7GHe5r4fDp1fuUVQr8zsXQN8MWdKJ7JZRk6pG
	oUNqlCEfQ5hrbAx9oCHq2ywBuvHkFRxl6y9MNN29pZUEgAP67YYlAe5inNaZBoXzUg6ONYnO2jgMq
	jAC12QBdN89yUByJFpyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQjEO-000000036Fm-1227;
	Mon, 08 Jul 2024 07:56:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQjEI-000000036Ea-1PzZ
	for kexec@lists.infradead.org;
	Mon, 08 Jul 2024 07:56:14 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687R0Mm028400;
	Mon, 8 Jul 2024 07:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=2
	Caj6dvSQ0vWKzYLQgEogj997aZmvRRJ9rOkA7e29Xk=; b=Y6LR78c/CcQxTGLeQ
	3XAyFyw6/omD5gMUcxCGTdd47Wml22oo4fk1j2ytToGJYn9P/ZqwXngr1IQwWBUB
	sGzkFvjxSCn3OXt4/j4tFut0gzRmOGrQ7yjK6pHpdZowq+G8RrfH1has+ZdXFyju
	4OEReRrYucrwiNNBCMDFTL6EGlX4d106BPojdaD11SREQQx81Oy+OWXwG4WSH8PX
	PGsYxzgIfotLBWpHFbYIAkjGJYs/kQwPP/Stdmy7l4jcBtWutWBm7bZ5S/0nzRjY
	Flx0gWpkTRh7/WLDNtfNqzSJkq7Y0Fo7Q3H+zPpeQq7qm2MGMuTmJ6TT8myZzDXo
	Vfgyw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407jpyjh5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 07:55:58 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4687twE7007309;
	Mon, 8 Jul 2024 07:55:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407jpyjh5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 07:55:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4684V7ZE014043;
	Mon, 8 Jul 2024 07:55:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407gn0e261-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 07:55:57 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4687tpCs44630368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jul 2024 07:55:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58F552004F;
	Mon,  8 Jul 2024 07:55:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 006162004E;
	Mon,  8 Jul 2024 07:55:48 +0000 (GMT)
Received: from [9.43.38.106] (unknown [9.43.38.106])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jul 2024 07:55:48 +0000 (GMT)
Message-ID: <102546c9-ccb9-49cd-8c58-ff4a218812bd@linux.ibm.com>
Date: Mon, 8 Jul 2024 13:25:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] kexec_load: Use new kexec flag for hotplug support
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Aditya Gupta <adityag@linux.ibm.com>,
        Coiby Xu <coxu@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
References: <20240707152456.87899-1-sourabhjain@linux.ibm.com>
 <20240707152456.87899-2-sourabhjain@linux.ibm.com>
 <ZotDP0JtnyRIx2dm@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZotDP0JtnyRIx2dm@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _AVNvQyuMcBPhQdP6ff01XyEY1tVjm5c
X-Proofpoint-GUID: Ay9pbHG5eOI7bgi3LvrPXB7vdw8BV8dr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_02,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=535 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_005610_762422_90434387 
X-CRM114-Status: GOOD (  30.80  )
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

On 08/07/24 07:09, Baoquan He wrote:
> Hi Sourabh,
>
> On 07/07/24 at 08:54pm, Sourabh Jain wrote:
>> Kernel commit 79365026f869 (crash: add a new kexec flag for hotplug
>> support) has introduced a new kexec flag to generalize hotplug support.
>> The newly introduced kexec flags for hotplug allow architectures to
>> exclude all the required kexec segments from SHA calculation so that
>> the kernel can update them on hotplug events. This was not possible
>> earlier with the KEXEC_UPDATE_ELFCOREHDR kexec flags since it was added
>> only for the elfcorehdr segment.
>>
>> To enable architectures to control the list of kexec segments to exclude
>> when hotplug support is enabled, add a new architecture-specific
>> function named arch_do_exclude_segment. During the SHA calculation, this
>> function gets called to let the architecture decide whether a specific
>> kexec segment should be considered for SHA calculation or not.
>>
>> Note: To avoid breaking backward compatibility, the new kexec flag
>> KEXEC_CRASH_HOTPLUG_SUPPORT is not used for x86 for now.
> For x86, both KEXEC_UPDATE_ELFCOREHDR and KEXEC_CRASH_HOTPLUG_SUPPORT
> should be OK for kexec_file_load.

Do we even need these flags for kexec_file_load at all?
My understanding is that these flags are only needed for the kexec_load 
system call.


> Your change will make a difference
> between kexec_load and kexec_file_load.

I am confused by the above statement.

Given that we don't even send any of the above flags for 
kexec_file_load, I am not
sure how these changes make a difference between the two system calls.

> But I agree with you on the
> backward cmpatibility with KEXEC_CRASH_HOTPLUG_SUPPORT flag.
>
> Anyway, if it's in a hurry to catch up with Simon's new release, this is
> fine, we can change it later.

It would be great if we could consider this patch series for the next 
release, but not at
the cost of breaking any backward compatibility for x86. If you think 
these changes are
breaking anything for any kernel version, I would prefer to update my 
patch series.

> Otherwise, we may be better to remove the
> difference, namely, not making x86 only be able to accept
> KEXEC_UPDATE_ELFCOREHDR flag on kexec_load. My personal opinion

On x86, passing the KEXEC_CRASH_HOTPLUG_SUPPORT kexec bit to kernel 
versions 6.5 to 6.9
with the kexec_load system call will fail with -EINVAL. However, from 
kernel 6.10 onward,
both KEXEC_UPDATE_ELFCOREHDR and KEXEC_CRASH_HOTPLUG_SUPPORT kexec bits 
are acceptable for x86.

My proposal is to use KEXEC_UPDATE_ELFCOREHDR on x86 for some time 
(maybe a couple of kernel releases),
and eventually switch to KEXEC_CRASH_HOTPLUG_SUPPORT for x86 as well.

This proposal of shifting to the KEXEC_CRASH_HOTPLUG_SUPPORT kexec bit 
for x86 is also mentioned in the
comment for the get_hotplug_kexec_flag function.

Please let me know your opinion.

Thanks,
Sourabh Jain

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

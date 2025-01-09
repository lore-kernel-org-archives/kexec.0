Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC660E77188
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 03:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ev41nye3EYCrH/8qKuYkTcjX/MgP5c6SOfM76NspYuQ=; b=P0+oE52dO+t1BikUSchKtcio0u
	pktwZfdIByi2xrF6lGsEX10HPcEyR9mlB0fX8ONCrC4W5nI2NlNkrpTvlVl3YJkHPLDijR2Ol1R4o
	WfN0eZWebpZ/qXvqn0ZPP3Uptis2Uz5jpF7WAZVsOFMNtTOJnsL3GPMB0x7RuwtbnarnTMqGLZxkT
	e+m+UV/VpP2kfLvdGa/WAhYwB6wO34cMtAm7C8t8uXDInJ+wNB+vyKV7gOOHqO0gZh4wYwCo9fYgQ
	/X1Hn8k9Jknn416tkNK0YcGW14ORlMdan89D31xLxBHXktuUoIOdDwxuA594rtD5wGzWH61e2ceIy
	drNg0vcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVjAB-0000000AZEj-3USZ;
	Thu, 09 Jan 2025 03:24:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVjA9-0000000AZDy-0xal
	for kexec@lists.infradead.org;
	Thu, 09 Jan 2025 03:24:50 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5090lRFL016024;
	Thu, 9 Jan 2025 03:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ev41ny
	e3EYCrH/8qKuYkTcjX/MgP5c6SOfM76NspYuQ=; b=IfKc/qRHSi3too9zjUGngr
	yd5Whg+EMcZmvDUFrUhW0Vvr/nJUD1aLtTTlMT+em4RdcDGZa2UCn7tINV1yewaC
	gmvbQSrvi3qySpIONBfn0BSI+s/rKIxzByrmgTVAAXwwAUBD2mKHuMi++XORau0+
	DstnVuMrpaC+CByzxeAT2B4ucghcNdUJDbqnIsn3hZiCS+FsOB1ll0evW1ncdCNa
	FSd06hoWxqCdGrX9Bjv7CM/kTZ2mFd716aw1920yBcjoCS2d9jTr+DFUmPWFeLn6
	bV3sJJsmEydfmTmv9eiN84o+BYpizEAdfWz5rBK1ZjDadOhE+h9WBE8RIuIOsMig
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441huc5st0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 03:24:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5091oCht027963;
	Thu, 9 Jan 2025 03:24:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhkawqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 03:24:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5093OZ2Y56099216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 03:24:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAEAC20049;
	Thu,  9 Jan 2025 03:24:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E983E20040;
	Thu,  9 Jan 2025 03:24:32 +0000 (GMT)
Received: from [9.43.18.121] (unknown [9.43.18.121])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2025 03:24:32 +0000 (GMT)
Message-ID: <bbad32bd-20fb-4d7b-8744-25d4c3fa7f8e@linux.ibm.com>
Date: Thu, 9 Jan 2025 08:54:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v1 3/5] powerpc/kdump: preserve user-specified
 memory limit
To: mahesh@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
        Baoquan he <bhe@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250108101458.406806-1-sourabhjain@linux.ibm.com>
 <20250108101458.406806-4-sourabhjain@linux.ibm.com>
 <k2eoi22mh5lod4nzee3qfbaagh36yljcqwxcyvvewmzbktcual@mzleqvtlojj3>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <k2eoi22mh5lod4nzee3qfbaagh36yljcqwxcyvvewmzbktcual@mzleqvtlojj3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bZFNVDDvboEUw35uLegZ6MU7qopIFoUk
X-Proofpoint-GUID: bZFNVDDvboEUw35uLegZ6MU7qopIFoUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=850
 bulkscore=0 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501090022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_192449_278959_D802C9BC 
X-CRM114-Status: GOOD (  10.05  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello Mahesh,


On 08/01/25 22:36, Mahesh J Salgaonkar wrote:
> On 2025-01-08 15:44:56 Wed, Sourabh Jain wrote:
>> Commit 59d58189f3d9 ("crash: fix crash memory reserve exceed system
>> memory bug") fails crashkernel parsing if the crash size is found to be
>> higher than system RAM, which makes the memory_limit adjustment code
>> ineffective due to an early exit from reserve_crashkernel().
>>
>> Regardless lets not violated the user-specified memory limit by
>> adjusting it. Remove this adjustment to ensure all reservations stay
>> within the limit. Commit f94f5ac07983 ("powerpc/fadump: Don't update
>> the user-specified memory limit") did the same for fadump.
> Agreed.
>
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Thanks for the review.

- Sourabh Jain


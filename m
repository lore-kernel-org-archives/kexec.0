Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C53F531FC
	for <kexec@archiver.kernel.org>; Wed, 15 Apr 2026 09:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+bzuFm0yHl8nZcfpz6um/mLhwbriL42W2o4b8vm0v2k=; b=GsvlRI3TSR5ETFwd7r0cPY04Tq
	SGjsWl3ONO6hinb770/Ca/rOjTINiirSnBNF3UDUP07JRefYzjIy9s9GXQsDqcbwJ2SRBuRl44ozy
	2TRWWj+D7TxPegMz6BWOTDz43dX6LG7Dwzr6XRsIBWnBkFcFfE6M2CYtpiKsCYKgeCeGi4rvPUfOL
	e6ZdDgnbOLhifbkNU9ELMmzyIRvSReZnkk4j3tJHMCAP9AICVk/9dKExMA7rUHg2XeSRVJGGkV902
	qyEvM+PXNuFk7Nol6Ck7zEIkdUaNIUR9Cd7v3ZxJ1OFbpUM6IYhh+bByyo9JyeI7vOhwSgi8+1JZW
	8AvTJb2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCwSL-00000000tNV-17Gi;
	Wed, 15 Apr 2026 09:22:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCwSK-00000000tNF-0o8A
	for kexec@bombadil.infradead.org;
	Wed, 15 Apr 2026 09:22:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+bzuFm0yHl8nZcfpz6um/mLhwbriL42W2o4b8vm0v2k=; b=f3aJVVBtigTM2jzTL55dXukvt3
	RNgPq0zqsVMzE2LbTFP8ij6oIFGEIFLi3pxq5s+OvR+MNgJFrUmkaqXMuVEoOX7EvgHJA7TOa0VE6
	ur0x16QoRx+cGqBTV2p1crlpC+wVtMBFa3uNEAj6DKew4bCK82rL3Kryh0BDNGwvXFhL3iRrZ8WSk
	UtNcIT+1YNbBwaK7zmqgQthGJv5AOgAPQ5DrAU0Hq3zor1AYvW/X/6UkE9zIkbp10oJFNA6FrtrD/
	Q3TB0AUU8yxnnZ7LgKWLVWyhknvFH0Sj1Df+EuLTuy7WW5UkKkd+h33CaWDnYl04E46HKT26+yoCe
	k7LAN7/A==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCwSE-00000002AGZ-2yir
	for kexec@lists.infradead.org;
	Wed, 15 Apr 2026 09:22:43 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F2DDas1832977;
	Wed, 15 Apr 2026 09:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+bzuFm
	0yHl8nZcfpz6um/mLhwbriL42W2o4b8vm0v2k=; b=Mndx3poVUuNPEWzdtlUabX
	5dUlvcs+XU9vEaSySawlj39gqSYjuFl4LiqbzzezT2E0f4NRbBMJwUjfNf2mnCi7
	KJBpxHXZRhNkKd+77n2/f77YMzqqYL0rQeIZ3TYd6vTumsIBvNK91Doc7dbM2hMk
	W1ueCmfdRy8l7I9qGcqldwoH5CBk+9X9zfxtOKCRGC6J1XVinBYzJLMt0WZSoH5L
	TAA4CoadtuUI+by4/t5QTX9hzM4z6v9eiUUgnodIa7Hdv5q/hGw+/Gy6k1mdX5LH
	j6M4KnMsxjzLLb6rh5VI2yIBkEJ9XDkGiq7AaHp3qZjmjsP4nzs0U++m5xWW13yw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rf9mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 09:22:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F9EVmI025862;
	Wed, 15 Apr 2026 09:22:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujnb7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 09:22:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F9MPJq45154656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 09:22:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C03A42004B;
	Wed, 15 Apr 2026 09:22:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FD632004D;
	Wed, 15 Apr 2026 09:22:24 +0000 (GMT)
Received: from [9.124.217.147] (unknown [9.124.217.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 09:22:24 +0000 (GMT)
Message-ID: <4f77a0d7-9192-4476-a6a1-91704985ae64@linux.ibm.com>
Date: Wed, 15 Apr 2026 14:52:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Dead link in kdump section of MAINTAINERS file
To: Dave Young <ruirui.yang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>
References: <e1e9e200-17d7-4ae9-b0eb-71300f4eb1ac@linux.ibm.com>
 <ad8rrO55DGZqSyZy@darkstar.users.ipa.redhat.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ad8rrO55DGZqSyZy@darkstar.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4NCBTYWx0ZWRfX1G0PeOfIafI0
 zyDicDwBGkk16rCySoQl5tKlR2pD8pW80daDEamARyTc90fjByPcQHx462+wEpV8eBOEWBBD/Zp
 id3zsjMCtiLOBMeQiVwxPxRdE9hIsIgIrjqGw+Weo/NTrVpfdUBqipJFD66uqEn9YswoJoF/6Qk
 r2qvI0xpAfxEIOqYZtyggHBBAjV/astBFTXWay7lUcVaMk3MBb3T0HckiHvy6gb+SN07QqdtXoq
 cUGgIKvA6CrRtTLyRhNl0r7idoCeVTN+g2LB9MQBuAdkwruyA/GMm4u41lRONEOAMSxVdp2HSyS
 u3klRWobkTxo9JVdIA1RxkQhHkC74Nrfl6K3YVq4LsLEkZ/qyhTTpy/CpYxbZecLnhHP93kCU0X
 FLy8YUTIycuKOkL6GMg5z1cKc2ayLSQFA1dkFz76nEX38y7RYWtc7qLCCz2su+47rOEruhCQBKO
 nhTHhullKE+7D5P6mxA==
X-Proofpoint-ORIG-GUID: lsUpYPg-1TcDhnpTxTOx6VB1zH9amkM8
X-Proofpoint-GUID: lsUpYPg-1TcDhnpTxTOx6VB1zH9amkM8
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69df58d4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=FP58Ms26AAAA:8
 a=VnNF1IyMAAAA:8 a=Gs--vbCD33anufAjLe4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150084
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_102241_241538_76BEDDE0 
X-CRM114-Status: GOOD (  13.91  )
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



On 15/04/26 11:39, Dave Young wrote:
> Hi Sourabh,
>
> On Wed, Apr 15, 2026 at 10:26:20AM +0530, Sourabh Jain wrote:
>> Hi all,
>>
>> Noticed a dead link in the kdump section of the MAINTAINERS file:
>>
>> W: http://lse.sourceforge.net/kdump/
>>
>> The URL no longer seems to be accessible. Could this be updated
>> or replaced with a valid reference?
>>
> I have no idea about the old link, I suggest to remove it if nobody
> knows.

Ok. I will wait for a couple of days for others to share
their opinions before sending a patch to remove it.

For reference, below commit added this link:

commit ea6c20891eb25e4884b852c040136f44cb173f3e
Author: Vivek Goyal <vgoyal@in.ibm.com>
Date:   Sat May 20 14:59:55 2006 -0700

     [PATCH] Kdump maintainer info update

- Sourabh Jain


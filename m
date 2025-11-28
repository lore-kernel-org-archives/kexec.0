Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C24ECFD376
	for <kexec@archiver.kernel.org>; Fri, 28 Nov 2025 09:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XJbUF3PC+6PhrqHIyLW1sFUYcX2axr+GelTZvCRV694=; b=zoC/Hr5+Sn0BrJ6WcmTmKdOC+S
	n3/k9aNU4siqtPry6oOVgrXt3chyaHEgyWDdbVVGByt5pWl5GevR0tppxaFNfZlIb9vxsKgzz6NOz
	W/9pC6vpSDLD4bwtp3KzPzIyZy+yoSFdSYCfSqITrLmfY5/kW84WIKYa9fXAtFDMDogXLr8Plprij
	Ov275EqXi/35G0ZNgBJv5Wz5Keek3XmtN2G9p9WQ7lu6WUA+CRqiQzhxFU0EA18BNoLJyifvrlWiw
	Isl58JLqmuCgaHkezSDB6BIpwKwpdsODiKl5GVlLjEx+TSNPVfqKm5NzK+Vz3B5ygaspRAQLLyXsG
	yFfxBm/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOuzQ-00000000F00-2FXc;
	Fri, 28 Nov 2025 09:42:08 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOuzO-00000000Eze-01YW
	for kexec@lists.infradead.org;
	Fri, 28 Nov 2025 09:42:07 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS8SClO011027;
	Fri, 28 Nov 2025 09:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XJbUF3
	PC+6PhrqHIyLW1sFUYcX2axr+GelTZvCRV694=; b=VqidQv1EfcOUdtMhyVhKTX
	aJy7mVzUsluFIhla9c5QCurZZTw0R8MPg+5s7WC1ifrucM/hrJ5DvEF6sZJ7R2g8
	7yNXb8Zv2xoGa/QK/uxDua0BJRARS8lfO/jlefuL02aCa8ViDNfU1bCpjfAWIXpX
	y6uaRPJY8f8uTizpto2jok9Hak66dWSvlKKihAXiSfqh69QDunoLM6zaLII+yxWS
	BQ8JubR5K6c3IpPi0PUuDx86o6B23A3qcNyBDW9yIsqOiOK1dfUbQqhRkLL2kv5X
	s9SiEuxluNiycMavhd8F4Oo/QqHvDKrK3y9JHQti5Z5yIFEvHTz+wHZqCQ4XmJ1w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9wqm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 09:42:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS86rZf013866;
	Fri, 28 Nov 2025 09:42:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akrgnmbaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 09:42:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AS9g1L244499244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 09:42:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71E3720043;
	Fri, 28 Nov 2025 09:42:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A397220040;
	Fri, 28 Nov 2025 09:41:59 +0000 (GMT)
Received: from [9.124.217.199] (unknown [9.124.217.199])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Nov 2025 09:41:59 +0000 (GMT)
Message-ID: <77ce0329-1f82-49be-b18a-73c9e5c3e85e@linux.ibm.com>
Date: Fri, 28 Nov 2025 15:11:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] kexec: print out debugging message if required for
 kexec_load
To: Baoquan He <bhe@redhat.com>, akpm@linux-foundation.org
Cc: Qiang Ma <maqianga@uniontech.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        shivang upadhyay <shivangu@linux.ibm.com>
References: <20251126084427.3222212-1-maqianga@uniontech.com>
 <7aadda55-d2a4-40f9-95ef-d284ec358646@linux.ibm.com>
 <aShunGBgVbEZmCxO@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <aShunGBgVbEZmCxO@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX5XX70ou46Zsx
 mZ/WXonb0vde463KzqWkYjswKl9LR/h9hBiAh6bINP0ZNiYmh3O86rE0884kkP9gPmOUMRsGkvB
 aA5rCyxBBVJjhBNFH5rpaGeexEvaRFVPSHWAMai+3TmB1dq55lVDKypdaLak3cdnxj9SAP/G3i0
 6aUFLzj4hEPT6XmAHlVnpH6msdcG/k/3QTWFnzcf8W0H1XDPrmtfj1wcJ7JLa3tjt9eGhirVOrS
 6jttEsZKDZ0/8GloD0ZxGxIhLY45wFOOyOlnKV92r1STyPAVZsPNJ+Bmigl2sn2m/35uREcD5EW
 ZcbzaLF2KYLU07zPjSsmYzaM+GKPFIelMr23JZngfiVdkGxcQBtastOOnnH9C0vHx16qFAlqgeA
 tE2OQWifwV4GqcICwnOaIJmpL8DXdA==
X-Proofpoint-ORIG-GUID: INLe5-JqZhpqCIFXmK4uliFg1H0IrZ7-
X-Proofpoint-GUID: INLe5-JqZhpqCIFXmK4uliFg1H0IrZ7-
X-Authority-Analysis: v=2.4 cv=TMJIilla c=1 sm=1 tr=0 ts=69296e6c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EDK4Qq837apMNDcd4w8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_014206_057539_02C8D66F 
X-CRM114-Status: GOOD (  17.21  )
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

Hello Baoquan,

On 27/11/25 21:00, Baoquan He wrote:
> On 11/27/25 at 05:31pm, Sourabh Jain wrote:
>> Hello All,
>>
>> Do we have plan to support KEXEC_DEBUG flag?
>>
>> Because upstream kexec-tools already added support for KEXEC_DEBUG flag
>> and that breaks the kexec_load with -d option.
>>
>> - kexec: add kexec flag to support debug printing
>>    https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=71d6fd99af7e
> I think we should revert that kexec-tools commit.

Yeah, userspace changes shouldn't go in until the kernel patches are
finalized. It seems that there are disagreements regarding the approach
and usefulness of this patch series, so reverting the kexec-tools patch
might be the right thing to avoid breaking anything for now.

I have one question: should the kernel advertise KEXEC_DEBUG so that
backward compatibility can be maintained between the kernel and
kexec-tools? Or is that too much for a debugging flag? How was backward
compatibility handled when we added the KEXEC_FILE_DEBUG flag?

> This whole patchset is
> non-sense. Because of my carelessness, that userspace patch was merged.
>
> Hi Sourabh,
>
> Could you go through this patchset and help check if they are really
> needed? I can't find anything to convince myself. Thanks.

Sure I will review this patch series.

Thanks,
Sourabh Jain


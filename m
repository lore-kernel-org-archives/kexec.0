Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7ABFCC9B2
	for <kexec@archiver.kernel.org>; Tue, 10 Mar 2026 03:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z8wzi9FNPp4/XKZYVRleDC4ka3neBIgTHsv9B+jgRvc=; b=KVSPeNyWPLfW/TIf/kI278L8qW
	d3GuFbAMHrrgW2JKG68KUYOWduZY4SJqesel7EXzYwv/SqpOrAQ3cIvmoGkR+Wt2SXdF/UGb752OQ
	PwkPOgKp47V1ZKa7PkUvf7mQ3FJEJhuXKzZ1bATAtbprTfkJ3EGM/XgvTTSOlancsQa4LYx7EE76c
	yLVdy+3OR0KOb0Q7BAeQLnAiIQiIAdViWqNzsRs+ZXaVpV4HJaRtJcUJHk+6xpYRe45VQh3Dsa+Dd
	NKML/pzQBsMp/MfASCZ6bAxNDYJKAcCzm9m3RlXTP4tBk2+nM+yMWeSbfkuSzS9lRm2pIBNNoZ7vi
	/sw3/Y0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vznqb-00000008fQ2-2CBJ;
	Tue, 10 Mar 2026 03:33:29 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vznqV-00000008fPg-2UYX
	for kexec@lists.infradead.org;
	Tue, 10 Mar 2026 03:33:25 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629DnYgS903350;
	Tue, 10 Mar 2026 03:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Z8wzi9
	FNPp4/XKZYVRleDC4ka3neBIgTHsv9B+jgRvc=; b=L+azaVHpieVl/BGd4lCe8h
	9D8H4bOmuMtshAMiI0KVgICRXgFdMbZDppiP7k4+75azBFHm5q50EZCbzrmv4WQt
	KZxqPxrDB/wkXfjUkFL24T8BK2c6xW31G/crHvUOAykiuLY2J35NsQ9CyfRYTpaS
	21onvC4jWeuIjXdnuZbz/j17lS27ksRL+dOlBVCuYsDrRL1Huma7JcUJ2dy3Vgty
	6EPvabuj2omPx9EbG9v1UqpiyQe7ujaoNAmhsH5uTR/ktSSF/75ZvPVzcBW2GSjF
	3So6aCK54CdCMKI26vSbWB1s+RCoq0PfRQXdahrLlSzPen3ufSy9/yBV4inKPd4Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mgy51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 03:33:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62A0JFGD022994;
	Tue, 10 Mar 2026 03:33:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ct8ng0fba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 03:33:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62A3X7cD41419218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 03:33:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A73820043;
	Tue, 10 Mar 2026 03:33:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B8A420040;
	Tue, 10 Mar 2026 03:33:04 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Mar 2026 03:33:04 +0000 (GMT)
Message-ID: <9c9c4500-d703-4ece-89b0-c88fcb04d847@linux.ibm.com>
Date: Tue, 10 Mar 2026 09:03:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/kexec/core: use big-endian types for crash
 variables
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: kernel test robot <lkp@intel.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        kexec@lists.infradead.org
References: <20251224151257.28672-1-sourabhjain@linux.ibm.com>
 <aa3iczOcLm12Y3ln@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <aa3iczOcLm12Y3ln@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69af90f8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=u8TtPYIeZricfBlmIPcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDAyNSBTYWx0ZWRfX6LkqvsvTMNhh
 F7CLSg2LAU4LxTUixApNvzt2LmBcztCor8E0o+dIM4PhE7ne9hArsnR/iSUO+fDAUyXG54IJ/Mr
 VGoN8s/+h28xx2B4ACVq8t3aTPZwiwYKWUUPjfNT1D/ELrjJKhAUARKkuYE8mXR7cmO3ZGAokNS
 eSTbSu9eOhYy0JYDkVJ8Zm+37byNMLk0QtmriEbdxsiL5TRquCY03eHCF3tZhbfjw3gSnwyIa58
 wNvWrIFl3A5w0U+OIq1pwMWsgu7ZCtUFKbQtxMt44wg8z2fScksjj4axhFiHeEGwZHf5vh7/L8Q
 h7RP6h+pG7/KHvTmSpIPxb7WPgUNd0rYEdYKefQNOnJ6MvgTTSF+eqzIrHOQcGgf9RNksv/mAdE
 knaT+N6O2S8MirmSaYbmUac+Ch6+g8rqLwU0wKQ5AcsBUfJECD+qZ60OEGROjrcmcbZOBjpW0Hp
 OIO5Pe2KFSMfNF7Rvqw==
X-Proofpoint-GUID: joi6sjzKVTMNGUQ3z0Lfx_jkLrB_Dxn_
X-Proofpoint-ORIG-GUID: 9VDmsq0HKnZqq_vCEsk2sidhTa1QfnHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100025
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_203324_115916_EC3B2ACC 
X-CRM114-Status: GOOD (  16.95  )
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



On 09/03/26 02:59, Aditya Gupta wrote:
> On 25/12/24 08:42PM, Sourabh Jain wrote:
>> Use explicit word-sized big-endian types for kexec and crash related
>> variables. This makes the endianness unambiguous and avoids type
>> mismatches that trigger sparse warnings.
>>
>> The change addresses sparse warnings like below (seen on both 32-bit
>> and 64-bit builds):
>>
>> <...snip...>
>> ...
>>
>>   /* Values we need to export to the second kernel via the device tree. */
>> -static phys_addr_t crashk_base;
>> -static phys_addr_t crashk_size;
>> -static unsigned long long mem_limit;
>> +static __be_word crashk_base;
>> +static __be_word crashk_size;
>> +static __be_word mem_limit;
>> ...
>>   
>>   static struct property memory_limit_prop = {
>>   	.name = "linux,memory-limit",
>> -	.length = sizeof(unsigned long long),
>> +	.length = sizeof(__be_word),
>>   	.value = &mem_limit,
> 'mem_limit' has slight change here. it used to be 64bit always,
> but now on ppc32 it will be 32bit
>
> I see only one usage of this in arch/powerpc/kernel/prom.c, and don't
> see any issue with usage due to the 32-bit/64-bit memory_limit
>
> For the patch:
> Reviewed-by: Aditya Gupta <adityaglinux.ibm.com>
Thank you for the review.

- Sourabh Jain


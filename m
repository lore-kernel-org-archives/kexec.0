Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C8DC98302
	for <kexec@archiver.kernel.org>; Wed, 23 Sep 2026 04:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IL5T/x9wo2ltEMEZ8/1aNrwgbLXnEAWwAyXPHWtAGlo=; b=EZv1mHv3JeJ347s/twlxCDJGok
	KLIAGVlSWPc8XtiN8MHpEjE9gK8FweV9WWYMqbkVjBeOFe8IHNdpN80+57cdCV8a3yl2/OeChyiGa
	zDjeQgXU900Qjd6oS2KUvt3G+jDaDK6s10cbo/UAF8rZJE33fgFeta2EqnWEGaazyG6mBvPErV0UV
	DnTsW7bKnZYmP74+WB8eh+CrYeXRiqg/9DtxR+HOGlO7D8jZt6EsDwXbqLsZxS7KjYXHSDmX1694R
	TQ6VFza5gfScbKaLbE2p9e/3EL/EQomCcxqNQKMqlfeC76xm+RL7nNF874hibl8OCou/bSqDV/uyM
	Z5ZA7YvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Egx-000000077Jq-3ZMv;
	Wed, 23 Sep 2026 04:34:47 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Egw-000000077JH-0NyW
	for kexec@lists.infradead.org;
	Wed, 23 Sep 2026 04:34:47 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N46M3l2190692;
	Wed, 23 Sep 2026 04:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IL5T/x
	9wo2ltEMEZ8/1aNrwgbLXnEAWwAyXPHWtAGlo=; b=pO00lmFlutDiqbUkdKhc5R
	hZra2OvfsGeowoGlBySClcQgNWzv1OzIZK3bFq/HuOV4vH7SQrxtGPEjHjwQVkgL
	z7sJLUEspqy7ptJBFfi/8OY04wEAx5hgVXtaugwCRVIwixdJ9tpROHyLFHgKIYo1
	zbkdhzks6wL34UJV6gHJrQggPKm5gsEJpwna+cY1EqT5HG+aEPnUMKhV6g6RG0HW
	09DXioGVjsspMG+C5kR1HJM7Yh03by/+48ShoKbqQJf6Mofk8t2ela665vaTXtvO
	HQw55mh3uOXLr1xmQTWwnTKZc53QLqm9sLViodRHl5mGatDnmZwusj4O6N4O9q8w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1gvcq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 04:34:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3lcXs3822101;
	Wed, 23 Sep 2026 04:34:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjvqp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 04:34:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N4YTsm40436114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 04:34:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE9BC20040;
	Wed, 23 Sep 2026 04:34:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68C2020043;
	Wed, 23 Sep 2026 04:34:27 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 04:34:27 +0000 (GMT)
Message-ID: <2c632eee-0a86-4bdf-90c6-66de2c092114@linux.ibm.com>
Date: Wed, 23 Sep 2026 10:04:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kho: fix global scratch size calculation
To: sashiko-reviews@lists.linux.dev
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        George Guo <guodongtai@kylinos.cn>,
        Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>
References: <20260922131217.698809-1-sourabhjain@linux.ibm.com>
 <20260922132738.B15EB1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260922132738.B15EB1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: JymBw-GCVZgIpua2F5lE7y4uPHUhjmhU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxNiBTYWx0ZWRfX4fnr310VoGhS
 ku8sYVZ1ROR6XXfm9qfj97POaQPYccW2YsY/3b9ifmMLSMKqSdJhTWvlJfQY0+QJ39raF3HmRcx
 3SNFEEZmgSyu+ymoB9e9wr1JpWShI44/mnLMwspIy+D34qIQeLsubye3tWhixOpFzPrSOBUGrxz
 D4cw+EzWUblfEvD0LBm24kM8nF8kZrOfRpDOFqy08NNm/PRPwkwMT0lgK5UkkSZq7vWDfqT2m8v
 +EQuIh7UJsOVoWOGKrvqmzlXWnKYKzezT7rD0RCQxkgc/1T0NfT/cnN93TJSwSo34O2NfpK6a9s
 A7I/BPBfl/QMRPrE0aQuDwPYY52UhRdMZvISrQ2XfB5xHcR7Q0TpY0qnfK102WhjvSZ9a3MP26l
 qGpfvmL353guqwavWfkSLVWt9B94/9OUddgINpDPKPocXtgrgQhvtbt0UdOobvCi7wAJeMfHvkD
 gnpwIf7Bg4bH8qexE3g==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab356d8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1qZhHyjmDr2UWPvmznUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxNiBTYWx0ZWRfX3GDmaw5CSYm1
 q1eZOX6F1XIe5Zj/ODLLPPoql/nH958H253hA3yDVQOU0AWYyZmHdj5nAhDJjjgmNb4UeB/1yq1
 rAnaIma1PG25vCH6RsL0QCV5wzpjuRo=
X-Proofpoint-GUID: 6DTDKEWtVzrOZRL56iOSkiCokObvGjJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230016
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_213446_288830_AE2B3D7F 
X-CRM114-Status: GOOD (  23.01  )
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



On 22/09/26 18:57, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kho: lowmem scratch exhaustion due to missing node-specific lowmem reservations
> --
>
> commit 45b67db1813edaa6fb1bdfe7033f0598a814cd63
> Author: Sourabh Jain <sourabhjain@linux.ibm.com>
>
> kho: fix global scratch size calculation
>
> This commit updates the scratch size calculations to correctly distinguish
> between memory reserved for a specific NUMA node and memory reserved with
> NUMA_NO_NODE. It introduces memblock_reserved_size_nid() to calculate
> reserved memory based on reservation type and NUMA node, fixing an issue
> where per-node reservations were incorrectly included in the global scratch
> allocation.
>
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index 7c4d86daf86d5..dc809e1e768c0 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
> [ ... ]
>> @@ -787,17 +787,17 @@ static void __init scratch_size_update(void)
>>   	if (scratch_scale) {
>>   		phys_addr_t size;
>>   
>> -		size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
>> -						   NUMA_NO_NODE);
>> -		size -= memblock_reserved_hugetlb_size(ARCH_LOW_ADDRESS_LIMIT,
>> -						       NUMA_NO_NODE);
>> +		size = memblock_reserved_size_nid(ARCH_LOW_ADDRESS_LIMIT, NUMA_NO_NODE,
>> +						  MEMBLOCK_RSRV_KERN);
> [Severity: High]
> Does checking NUMA_NO_NODE here exclude node-specific lowmem reservations
> (like node-bound DMA pools) from the lowmem scratch size calculation?

No. Node-specific reservations are handled separately. The node-specific
scratch memory size is calculated in scratch_size_node(), so if the kernel
has made a node-specific allocation, KHO will reserve scratch memory on
the corresponding node.

> If the successor kernel requires lowmem for these node-specific reservations
> during early boot, could shrinking the global lowmem scratch memory lead to
> memblock allocation failures and a panic?


With this fix, KHO still reserves both per-node scratch memory and
lowmem scratch memory to meet the needs of the successor kernel.

Per-node scratch memory is reserved on the corresponding node.
The only change is that per-node allocations made in lowmem (below 4G 
by-default)
are no longer counted when calculating the lowmem scratch size.


>> +		size -= memblock_reserved_size_nid(ARCH_LOW_ADDRESS_LIMIT, NUMA_NO_NODE,
>> +						   MEMBLOCK_RSRV_HUGETLB);
>>   		size = size * scratch_scale / 100;
>>   		scratch_size_lowmem = size;
> [ ... ]
>> @@ -815,11 +815,11 @@ static phys_addr_t __init scratch_size_node(int nid)
>>   	phys_addr_t size;
>>   
>>   	if (scratch_scale) {
>> -		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
>> -						   nid);
>> +		size = memblock_reserved_size_nid(MEMBLOCK_ALLOC_ANYWHERE, nid,
>> +						  MEMBLOCK_RSRV_KERN);
> [Severity: High]
> Are the node-specific lowmem reservations that were excluded from
> scratch_size_lowmem now being counted here instead? Since this counts
> with MEMBLOCK_ALLOC_ANYWHERE, will these reservations potentially be satisfied
> using scratch memory in highmem?

No.

>
> If the successor kernel restricts its memblock allocations to
> MEMBLOCK_KHO_SCRATCH regions, won't it be unable to recreate its
> node-specific lowmem reservations if the per-node scratch memory was placed
> in highmem?

The per-node scratch memory will be allocated on the corresponding
node. Therefore, the successor kernel should be able to recreate its
node-specific reservations, even if the per-node scratch memory is
placed in highmem.



>
>>   		/* Do not count HugeTLB pages. */
>> -		size -= memblock_reserved_hugetlb_size(MEMBLOCK_ALLOC_ANYWHERE,
>> -						       nid);
>> +		size -= memblock_reserved_size_nid(MEMBLOCK_ALLOC_ANYWHERE, nid,
>> +						   MEMBLOCK_RSRV_HUGETLB);
>>   		size = size * scratch_scale / 100;
>>   	} else {
>>   		size = scratch_size_pernode;



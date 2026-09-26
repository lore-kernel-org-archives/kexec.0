Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F427C98338
	for <kexec@archiver.kernel.org>; Sat, 26 Sep 2026 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GuVElNNHPxhTvXMJfRPaqVwIwab/ZdlWhq0acISD99k=; b=0aAhbx6weHcrxbEcBUntnlhK88
	QJBkCESh30Q7zzWuWnG++B+InVzBlYFmuwrv57GkW4ST0eoWJBJfafHRL8NQLx6Ceot1blpGESVJN
	pMQ9bAOapkDKvY/+AKzOQr7a4JBI2eZFNsS5F7fi1r1aZSFS5G//bvnIYlRw6VWddYnOtxEWsVj71
	11/JaZBs8M9HLPhwrJL5/ryKSTOLmOynA1WVjjwjSFZ3AxGHkxjE2pm/DubvsHATWJhEFg7qsaisw
	XaBb7PrzedmmOBau+A1Ks095j/q4kSaFulWKZxVNW53I0S5aD/juuszbE2qRgHBYjY6Nu6flgHUDQ
	z7GPSEqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xATg8-0000000FXZj-2wQX;
	Sat, 26 Sep 2026 14:47:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xATg6-0000000FXZK-0Xts
	for kexec@lists.infradead.org;
	Sat, 26 Sep 2026 14:47:03 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QE5lkQ2255700;
	Sat, 26 Sep 2026 14:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GuVElN
	NHPxhTvXMJfRPaqVwIwab/ZdlWhq0acISD99k=; b=UKYHqpcyGxl7bkFErh8PYH
	tEtydmGYRqkiLgud8OZ2Jnt3pMyoKSbHSO/U5NjzC4rwlZeoZEQOU5GVbgnuKQTR
	JBR0dBz3HgrQhx4xLHCmXklG/Y52AdQ54BMnPWaQVdSOtgGxtzHsIwZzYva0Hzks
	8qo2aaJzuzMJQHIcJb8kSx34oy6Mno1ehUQALc1f1Hb5U0TISz3VE+7aUpIly37b
	9ylfkCUpAYERpRw9hxBKZMG86SyL8g2ApESnMXX75I0VGODFzmmyp2VMS2otIZ9m
	nawCoKShBXQKqBqMDcrtoIF0grVAupc4koPczjQx5d6qMP/bknczlJ16eIoL9i7w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qqspug-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 26 Sep 2026 14:46:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68QDlXeb1378649;
	Sat, 26 Sep 2026 14:46:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gwy27asra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Sep 2026 14:46:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68QEkbN526673740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Sep 2026 14:46:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2C8B20043;
	Sat, 26 Sep 2026 14:46:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 811B420040;
	Sat, 26 Sep 2026 14:46:34 +0000 (GMT)
Received: from [9.43.82.149] (unknown [9.43.82.149])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 26 Sep 2026 14:46:34 +0000 (GMT)
Message-ID: <e265fdc8-e224-4815-b94e-9c974210f099@linux.ibm.com>
Date: Sat, 26 Sep 2026 20:16:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kho: fix global scratch size calculation
To: Mike Rapoport <rppt@kernel.org>
Cc: kexec@lists.infradead.org, Alexander Graf <graf@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        George Guo
 <guodongtai@kylinos.cn>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260922131217.698809-1-sourabhjain@linux.ibm.com>
 <areLMLTC-bO1zcXP@kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <areLMLTC-bO1zcXP@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA1OCBTYWx0ZWRfXxvSfSzlMnSzp
 4z9xWrA4kTaGa2K1o6Bnlro/QntTS7aro4k2KZlX0qiBEVHMVJyUBTBaidGMVZuiWXkvZlwB0jx
 gq8LmIZf3qS0WNnXYMxo4ZcCeCnL+pUr9p4HumGdQvNNQB+dVVw0pOizn60xVX62X1iw/K3e2bF
 7QHUahmDgVwJcUOCnFUnyDB+gAL/rpiMHZJ58M67bqfTTxn/W2BPAteDgonG2FMgk8ulG5/9vxK
 7NoqvkBlP2HW/Z7CSv/jO2sVsCoZo/TjamKX7R8iNiZhI0pcJCflWVwbr2E5+pDI3kTEvhte0az
 KYcP/ICHovVco+HTNlEWcSuV3qaOIlQF5FPc6Avje7qD7XtTSHIYVwGX/JX2C8A0n/xcN5p8j4x
 Y1RzFVGnPHliM3xMXcFDJZjQfYtECzBPlj9GbqEzBUUldVXjpk8hf2B9r0an6PKvX7aIa1EcUwo
 vRo7QPdOeMOn924dUbg==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6ab7dad0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=vggBfdFIAAAA:8
 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=7ipKWUHlAAAA:8 a=pGLkceISAAAA:8
 a=37rDS-QxAAAA:8 a=VnNF1IyMAAAA:8 a=bNo-Hw79ofwCn3g4lxgA:9 a=QEXdDO2ut3YA:10
 a=HkZW87K1Qel5hWWM3VKY:22 a=gpc5p9EgBqZVLdJeV_V1:22 a=k1Nq6YrhK2t884LQW06G:22
X-Proofpoint-ORIG-GUID: kzbMAnA0xg_o3d0chYonMeVx77MsnSDA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA1OCBTYWx0ZWRfX1BJ+9hxWRDhF
 Y0HoeQqKTA9R4NDekMNrioz7bEDZbtzVBlL4vmkbuRkNMM1N8aSznXAhDeb/XvgqvVFpveJfOHR
 tiuaYFq5NEBnQC0lBcWltAqQFm7q/f8=
X-Proofpoint-GUID: BDbcgbsLYGFIuH4mxew6Px8aHk3t3IPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609260058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260926_074702_185195_766392B4 
X-CRM114-Status: GOOD (  27.41  )
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

Hello Mike,

On 26/09/26 14:36, Mike Rapoport wrote:
> Hi Sourabh,
>
> On Tue, Sep 22, 2026 at 06:42:16PM +0530, Sourabh Jain wrote:
>> KHO calculates the global scratch size based on memblock-reserved kernel
>> memory. It passes NUMA_NO_NODE to memblock_reserved_kern_size() for
>> this calculation.
>>
>> When memblock_reserved_kern_size() is called with NUMA_NO_NODE, it
>> counts both:
>>
>> - memory reserved for a specific NUMA node
>> - memory reserved with NUMA_NO_NODE
>>
>> KHO needs to distinguish between these two types of reservations.
>> When calculating the size of global scratch memory, KHO only needs to
>> account for reservations made with NUMA_NO_NODE. Reservations made for
>> a specific NUMA node must not be included in the global scratch size.
>>
>> Add memblock_reserved_size_nid() to calculate reserved memory for a
>> given reservation type and NUMA node. When NUMA_NO_NODE is passed, it
>> counts only memory reserved with NUMA_NO_NODE.
>>
>> Use the new API for lowmem, global, and per-node KHO scratch size
>> calculations. For lowmem and global scratch, count only memory
>> reservations that were made with NUMA_NO_NODE. For per-node scratch,
>> count only memory reservations that were made with the corresponding
>> NUMA node ID.
>>
>> Remove memblock_reserved_hugetlb_size() since it has the same
>> implementation as the new API and differs only in the memblock
>> reservation flag being checked. The new API handles both kernel and
>> HugeTLB reservations through its reservation type argument.
>>
>> Define the new helper as a static function in the KHO implementation,
>> since it is only used by KHO and has no users outside
>> kernel/liveupdate/kexec_handover.c.
>>
>> On powerpc, the difference can be seen in the scratch_len values
>> reported by:
>>
>> cat /sys/kernel/debug/kho/out/scratch_len
>>
>> Before this change, the global scratch allocation was 0x12000000
>> (288 MB):
>>
>> 0x1000000   (16 MB)
>> 0x12000000  (288 MB)  <- global allocation
>> 0x5000000   (80 MB)
>>
>> After this change, the global scratch allocation is 0xd000000
>> (208 MB):
>>
>> 0x1000000   (16 MB)
>> 0xd000000   (208 MB)  <- global allocation
>> 0x5000000   (80 MB)
>>
>> The 80 MB difference is the per-node reservation that was previously
>> being included in the global allocation.
>>
>> The same issue also affects lowmem scratch memory, but its impact is
>> limited because the lowmem scratch memory calculation is restricted to
>> the first 4G of memory. The changes also cover the lowmem scratch
>> memory case.
>>
>> Cc: Alexander Graf <graf@amazon.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: George Guo <guodongtai@kylinos.cn>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Cc: Pratyush Yadav <pratyush@kernel.org>
>> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   include/linux/memblock.h           |  1 -
>>   kernel/liveupdate/kexec_handover.c | 49 ++++++++++++++++++++++--------
>>   mm/memblock.c                      | 22 --------------
>>   3 files changed, 37 insertions(+), 35 deletions(-)
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index d62db9e776cf..678fe466529a 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -487,7 +487,6 @@ static inline __init_memblock bool memblock_bottom_up(void)
>>   phys_addr_t memblock_phys_mem_size(void);
>>   phys_addr_t memblock_reserved_size(void);
>>   phys_addr_t memblock_reserved_kern_size(phys_addr_t limit, int nid);
>> -phys_addr_t memblock_reserved_hugetlb_size(phys_addr_t limit, int nid);
>>   unsigned long memblock_estimated_nr_free_pages(void);
>>   phys_addr_t memblock_start_of_DRAM(void);
>>   phys_addr_t memblock_end_of_DRAM(void);
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index 7c4d86daf86d..dc809e1e768c 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -752,6 +752,31 @@ static int __init kho_parse_scratch_size(char *p)
>>   }
>>   early_param("kho_scratch", kho_parse_scratch_size);
>>   
>> +static phys_addr_t __init_memblock memblock_reserved_size_nid(phys_addr_t limit, int nid,
>> +							      enum memblock_flags region_type)
>> +{
> Why is this in kexec_handover.c and not in memblock.c?

I kept it here because KHO is the only user of this. However, I'm happy 
to move it to
memblock.c if you think that would be more appropriate.

>> +	struct memblock_region *r;
>> +	phys_addr_t total = 0;
>> +
>> +	for_each_reserved_mem_region(r) {
>> +		phys_addr_t size = r->size;
>> +
>> +		if (r->base > limit)
>> +			break;
>> +
>> +		if (r->base + r->size > limit)
>> +			size = limit - r->base;
>> +
>> +#ifdef CONFIG_NUMA
>> +		if (nid == memblock_get_region_node(r))
>> +#endif
> Do we really need the #ifdef here?

Yes, otherwise, if CONFIG_NUMA is not set, the lowmem and global sizes 
would be 0.


- Sourabh Jain

>
>> +			if (r->flags & region_type)
>> +				total += size;
>> +	}
>> +
>> +	return total;
>> +}
>> +
>>   static void __init scratch_size_update(void)
>>   {
>>   	/*



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14565606A31B
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 04:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uXLRRBk2;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cRHqsxcP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sfAFk4B+vei+3elSopsi8ObDtXDl01aMMTMLoHAY6zY=; b=uXLRRBk2SK4ZSVXQA+ULQvm7SF
	Am2S3bBI3Zx49AId6mkq57QEZpUKQxW5p8Hpy7NObtzcInKUhwJ3y5VRpn56l2bWN75VyVzSsbon7
	AXANx2Lllhe0MJsDwJa6haFm24ZJgMxKpR5WLZJRRaZD2BW6OidjkZpV86MXyXoztXbIIfLobBrAU
	/v5l1I8/7Pk0k6geYI88FHCHKU0+EEshQwnSnjtuQKzQHzPSTmwoVi63yZ8MyjpE3cpY9KH8MQl/Z
	iTXxZynjaxcobGGDiN8xtTCdM7p5xEFFQz5TobRslTbxOfrEp/MShhVPs60fmu82REI7Y6U3hPp+N
	7H7KyIFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJOPz-0000000B4K6-0AuG;
	Wed, 21 Oct 2026 04:59:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJOPx-0000000B4Jl-08aD
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 04:59:14 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L2F1BR064986;
	Wed, 21 Oct 2026 04:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sfAFk4
	B+vei+3elSopsi8ObDtXDl01aMMTMLoHAY6zY=; b=cRHqsxcP5dhOrCbCl2Ls33
	kA18CiwiE9c+4Fmw2XGI8JFKQduEVtf3JqDeSmZvgvMzehEvCM/LR8wRBrdUHJX+
	K2EeFDwgTJTPu0slwpOcM1RMPFr1caS0wq2x8AWE4+5/24TBN7H4EjUHMVXFv6NK
	9i/5Xxzoz8ucvJCStx+OTxFo+E0C97GoA1x9uAailgfQNufnIzT5RjqXNoYu6MU2
	MIM7W506wPnLEnzfU4qBYSvRZ85XEKU48P5ogUtump2Et/KF430Zo2n821boCdeS
	aCaKtaQvZuWnCOsclQXWlUxbnrpS+DwiNUru9CdJf34cikehX0wrZYvlUapT5KPA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58q106-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 04:59:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69L2JqUJ1230282;
	Wed, 21 Oct 2026 04:59:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefss1dnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 04:59:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69L4wuS045941058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 04:58:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A99D20085;
	Wed, 21 Oct 2026 04:58:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B316220082;
	Wed, 21 Oct 2026 04:58:52 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Oct 2026 04:58:52 +0000 (GMT)
Message-ID: <3d342c03-f12f-462d-b3c6-510f155ff267@linux.ibm.com>
Date: Wed, 21 Oct 2026 10:31:27 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] kho: check scratch vs CMA alignment at runtime
To: Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, Aditya Gupta <adityag@linux.ibm.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20260928083226.107807-1-sourabhjain@linux.ibm.com>
 <20260928083226.107807-2-sourabhjain@linux.ibm.com>
 <2vxzfqybj8it.fsf@kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <2vxzfqybj8it.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: aN4T9DGkggG4gTSFxpsFy0li-llBHITp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxOCBTYWx0ZWRfX4/ekYuLP0jTS
 gfp9csY5GMnBqfzt50/Jn0pvXDa/D3GQiPkoyfw9lrPWTCQCTznGBLoDZKAB8z7LbHQzxOdf0UD
 ZdXJvkKI5gb/WQKn38y5OeTcQRu3DsA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxOCBTYWx0ZWRfX5YLm0P8pI1zz
 RNMCP7xdAfJDzf6yT+bJ8sqjcs6HWse3K0afsDQVQAkCCAvwv+Ixqc95IjdBlLrlD7y6H8va/jH
 EisrwZ+tOCB4MBQribT3Ihbg3mfRHwdKCFc4X8bZwSgvKkAxo/gEtxwmmIhnoPQSQg1+pVLg0ge
 p1i2cfPBHjvApCj/NXfv5/7HddSbCpoeznez/Ffmy/F1xZn8B6uSluPEFydSDLHSYrLRPQU0/9P
 a9ZDMYfTb62gPBJIi07HTVB+rtfBKVgLQl4xRdx43mjuqqgztl9Ff3tv9QDfRV669HE2KalqMSO
 y0tc7po+mOHLZux8FuHF/c6SVgufpcer4Aciw5qLNWozZvW9686//g1I+1QpSm9zIE/7/pow6tW
 uLrfiLZXzIQIqoV3YSpb2C6i08R/VV2pmlEKHzsXGELNEkR51PlQdVXmfujpRXg7RIDVYiYMi1J
 D+UmGl+6+95y29KzsYA==
X-Proofpoint-ORIG-GUID: 3_2FMnQbRqIzSRLEGfDujs0GFUx0wl7r
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6ad84695 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=vggBfdFIAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=7ipKWUHlAAAA:8 a=voM4FWlXAAAA:8 a=rxpbpe3YEeMVxz9nh0AA:9 a=QEXdDO2ut3YA:10
 a=HkZW87K1Qel5hWWM3VKY:22 a=gpc5p9EgBqZVLdJeV_V1:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210018
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_215913_106702_A080AFEB 
X-CRM114-Status: GOOD (  26.01  )
X-Spam-Score: -2.6 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 12/10/26 20:00, Pratyush Yadav wrote:
> On Mon, Sep 28 2026, Sourabh Jain wrote:
>
>> KHO requires the scratch alignment to be at least CMA_MIN_ALIGNMENT_BYTES,
>> and this is currently enforced with a static_assert().
>>
>> That assertion breaks the build on powerpc once CONFIG_KEXEC_HANDOVER is
>> enabled together with CONFIG_TRANSPARENT_HUGEPAGE or CONFIG_HUGETLB_PAGE:
>>
>>      kernel/liveupdate/kexec_handover.c:49:39: error: expression in static assertion is not constant
>>         49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>>      ./include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
>>         80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>>            |                                                        ^~~~
>>      kernel/liveupdate/kexec_handover.c:49:1: note: in expansion of macro 'static_assert'
>>         49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>>
>> CMA_MIN_ALIGNMENT_BYTES depends on pageblock_order, which is not a
>> compile-time constant with certain configs, such as
>> CONFIG_HUGETLB_PAGE_SIZE_VARIABLE on powerpc. The next patch in this
>> series enables KHO on powerpc, so the alignment must be checked at
>> runtime instead.
>>
>> Replace the static_assert() with a runtime check at the start of
>> kho_reserve_scratch(), before any scratch memory is reserved. If the
>> scratch alignment is smaller than the CMA minimum alignment, warn once
>> and disable KHO rather than continue with a misaligned reservation.
>>
>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>> Cc: Alexander Graf <graf@amazon.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan He <baoquan.he@linux.dev>
>> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Cc: Pratyush Yadav <pratyush@kernel.org>
>> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
>> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   kernel/liveupdate/kexec_handover.c | 23 +++++++++++++++--------
>>   1 file changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index 7c4d86daf86d..dc76dd6b74da 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -39,15 +39,7 @@
>>   #include "../kexec_internal.h"
>>   #include "kexec_handover_internal.h"
>>   
>> -/*
>> - * This is the minimal alignment required by deferred struct page init.
>> - * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
>> - * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
>> - * If KHO scratch is not aligned to that value, buddy can access uninitialized
>> - * struct pages, which can cause a crash.
>> - */
>>   #define SCRATCH_ALIGNMENT_BYTES (PAGE_SIZE * MAX_ORDER_NR_PAGES)
>> -static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>>   
>>   /* The magic token for preserved pages */
>>   #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
>> @@ -836,6 +828,21 @@ static void __init kho_reserve_scratch(void)
>>   	if (!kho_enable)
>>   		return;
>>   
>> +	/*
>> +	 * This is the minimal alignment required by deferred struct page init.
>> +	 * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
>> +	 * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
>> +	 * If KHO scratch is not aligned to that value, buddy can access uninitialized
>> +	 * struct pages, which can cause a crash.
>> +	 */
>> +	if (WARN_ON_ONCE(SCRATCH_ALIGNMENT_BYTES < CMA_MIN_ALIGNMENT_BYTES)) {
> Nit: do we need both the WARN_ON_ONCE() and the pr_err()? Can't we drop
> the WARN and keep the pr_err only?

Yes pr_err is good enough. I will remove WARN_ON_ONCE()...

>
> LGTM otherwise.

Thanks for the review.

- Sourabh Jain

>
>> +		pr_err("scratch alignment %lu < CMA minimum %lu, disabling\n",
>> +		       (unsigned long)SCRATCH_ALIGNMENT_BYTES,
>> +		       (unsigned long)CMA_MIN_ALIGNMENT_BYTES);
>> +		kho_enable = false;
>> +		return;
>> +	}
>> +
>>   	scratch_size_update();
>>   
>>   	/* FIXME: deal with node hot-plug/remove */



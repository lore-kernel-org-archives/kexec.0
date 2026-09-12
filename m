Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22BCC79FB6
	for <kexec@archiver.kernel.org>; Sat, 12 Sep 2026 06:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4RNmo+4WoxE2g15yZPvbjcpEViUf3OM7Y0Mtx31j8P4=; b=kWQOz5plsCH5nZJauIyNbt8QvV
	nENLkumKXQsI8etfceb3viGM4IXG74BdhSB/zto29/M43/5afrwGCeNXxS/TivhUlabkQNcxRH5+l
	HW6I0tiof1xfQgKTigmOPAoCrYtdh0chzJdIW3TXIZODNTIPUwp5FolqJT5GEr2z6I7YnkKZE3llK
	EOzqt3waIfqjcnPt+d1H28pww7OXnn6s4AhArshj9Q3GNZTHKzZCkMP9e78VXYVhkDu8L7G+SyFbf
	2DVGk7Ky1iT1vjz9UIVbYtKA2G77RMBnP/zO086gnvL8XlAHocK/XZQIlAP9lC63AZwHDSihyAHFV
	YB9gi9HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5HJA-00000000Zwj-3bFT;
	Sat, 12 Sep 2026 06:33:52 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5HJ8-00000000ZwM-39wv
	for kexec@lists.infradead.org;
	Sat, 12 Sep 2026 06:33:52 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68C4VoMq3768969;
	Sat, 12 Sep 2026 06:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4RNmo+
	4WoxE2g15yZPvbjcpEViUf3OM7Y0Mtx31j8P4=; b=KfA+sl2gNR4Pbx5qmgBcqp
	gSmt7Vp0RxYI5Ma/8vABc842dCTuwqCyje0BxWT8be08VV2Wx5esZTGx07L9HCj/
	EksWqYv4SOe3iaILjZPZU88KqWBKNWcbIfXLESbTKELArh7NF+0uykrIrf5YevKD
	0gzGHCZOQgpIYLQCK1crMvH98REFPUp3C/4grcRgApQ4dAliudWh/q/DPqtl3m9D
	zng9zlKSUrf4xkzvXDUJOJP+PJxMRM5+8nE+nokKMXJTM9OzdyHRT/wI7Fu9dy7Z
	2nvrrOKZw69z1mkhXCm+xO5OcP9Za9WpGrI9+NPu6fA6sbhSHD5pD5PKaKHJMsIg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx838ha6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 06:33:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68C4Z8Og2798858;
	Sat, 12 Sep 2026 06:33:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvq328rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 06:33:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68C6XUgK50528660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Sep 2026 06:33:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16C9E20043;
	Sat, 12 Sep 2026 06:33:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D93EB20040;
	Sat, 12 Sep 2026 06:33:26 +0000 (GMT)
Received: from [9.43.64.172] (unknown [9.43.64.172])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Sep 2026 06:33:26 +0000 (GMT)
Message-ID: <616daf17-4598-4a30-8574-16480dfc23cb@linux.ibm.com>
Date: Sat, 12 Sep 2026 12:03:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] liveupdate: kho: calculate per-node scratch sizes
 before allocation
To: George Guo <dongtai.guo@linux.dev>, rppt@kernel.org,
        pasha.tatashin@soleen.com, pratyush@kernel.org
Cc: graf@amazon.com, changyuanl@google.com, akpm@linux-foundation.org,
        chenhuacai@kernel.org, liukexin@kylinos.cn, guodongtai@kylinos.cn,
        kexec@lists.infradead.org, linux-mm@kvack.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260904025101.9959-1-dongtai.guo@linux.dev>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260904025101.9959-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDA5MSBTYWx0ZWRfX25w+EaHMFsm2
 d+X1CprFRpge415e1vwniAV1kiokXFX4f+ETuUslm/MBK4TrtrW23SILO6inwyptbuLGU9gZsy1
 sBotOme+XGw/GsFIkwyW5cvZz41NvIn1wvSgU7qNvbmKG5Vei0J9gmpWXsKJYpmDqnA9efyly92
 W8oJLN3m4zSq/hELjyiXb8YuBDFSU0gIwjlTDbPX9zY7WoIA+fc5svU/jr1XaXv6oa4//kaBlCj
 l9zQHSwKicmo3ziKqCMLFF8cGNhzoZFKQ6SWRb/nbCPK3nQpkrw85VrQy3DsCFp9gVtGw2olxNf
 /g8b/MWpdOmmJkeQUKSGz3BitZjZDkfUQr8wAuVBIp6qG+wenDVjNRLcIPor+udvvJkyLAYaKJs
 vgtUpYFkKX6U06ejFgP/fOP/AZx/XGytIkvlWyZ2HdMXguqfpyMBaZFXs30I3keVLj2RsoEmm4u
 THI04Ymt3daBMPTRYMQ==
X-Proofpoint-ORIG-GUID: XNWTD0E44k6lxweEtfGvaeOeadPXw11z
X-Proofpoint-GUID: 1Vm-Cuyp1KnAeCvctDU71vuMSaQ1NNRP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDA5MSBTYWx0ZWRfXyFMgVIpwG6Wf
 LJPB59B1uj0QQihp5O5HLvHpErjKV2CSCWX/4vaY2edJEK7nwl2c/H4PdGjsNprOVxmbnsO91wc
 KW6/PPi1M9TZdgPGo6NGKhrqO5p41MQ=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aa4f23d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=YPOtRuTLPIpNHsc8iuEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_02,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_233350_803705_88E6C3BC 
X-CRM114-Status: GOOD (  27.49  )
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

Hello George,

On 04/09/26 08:21, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
>
> The default percentage-based policy sizes scratch areas from the current
> kernel's MEMBLOCK_RSRV_KERN footprint. This is a reasonable heuristic for
> predicting the early memory demand of the next kernel.
>
> scratch_size_update() calculates the lowmem and global sizes before either
> area is allocated. However, kho_reserve_scratch() calculates each per-node
> size only after allocating the lowmem and global areas. Since memblock
> allocations are marked MEMBLOCK_RSRV_KERN, the per-node calculation
> includes those newly allocated scratch areas and scales them again.

I may be missing something here, but doesn't memblock_reserved_kern_size()
check the node ID of the region before checking the region flag 
(MEMBLOCK_RSRV_KERN)?

Code snippet from memblock_reserved_kern_size()
```
if (nid == memblock_get_region_node(r) || !numa_valid_node(nid))
     if (r->flags & MEMBLOCK_RSRV_KERN)
         total += size;
```

For a valid nid, my understanding is that the global and lowmem scratch
areas should not be counted because they are allocated with NUMA_NO_NODE
(-1). So, ideally, these regions should be excluded when calculating the
reserved memory for a specific node ID.

Based on this, I am not sure that marking the lowmem and global areas as
MEMBLOCK_RSRV_KERN is what causes the per-node size calculation to be
inflated. I am looking into the code further to better understand the
actual cause of the issue that this patch is trying to address.

With that said, I wonder if this fix might be more of a stop-gap solution.
As mentioned above, since NUMA_NO_NODE (-1) is used for the lowmem and
global allocations, my understanding is that these areas ideally should
not be included when calculating the size for a specific node ID.

I could be missing something in my understanding, so I would appreciate
your thoughts on these observations.

- Sourabh Jain

> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Reported-by: Kexin Liu <liukexin@kylinos.cn>
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>   kernel/liveupdate/kexec_handover.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 7c4d86daf86d..39f489a258d9 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -847,6 +847,17 @@ static void __init kho_reserve_scratch(void)
>   		goto err_disable_kho;
>   	}
>   
> +	/*
> +	 * Calculate the per-node sizes before reserving any scratch areas.
> +	 * memblock allocations are marked MEMBLOCK_RSRV_KERN, so calculating
> +	 * them later would count the lowmem and global scratch areas as kernel
> +	 * allocations and scale them again.
> +	 */
> +	i = 2;
> +	for_each_node_state(nid, N_MEMORY)
> +		kho_scratch[i++].size = scratch_size_node(nid);
> +	i = 0;
> +
>   	/*
>   	 * reserve scratch area in low memory for lowmem allocations in the
>   	 * next kernel
> @@ -880,7 +891,7 @@ static void __init kho_reserve_scratch(void)
>   	 * memoryless nodes, as we can not allocate scratch areas there.
>   	 */
>   	for_each_node_state(nid, N_MEMORY) {
> -		size = scratch_size_node(nid);
> +		size = kho_scratch[i].size;
>   		addr = memblock_alloc_range_nid(size, SCRATCH_ALIGNMENT_BYTES,
>   						0, MEMBLOCK_ALLOC_ACCESSIBLE,
>   						nid, true);



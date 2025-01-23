Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3105C0218D
	for <kexec@archiver.kernel.org>; Thu, 23 Jan 2025 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ElgwOmg4zurIGAG33KrdB9qV6Qn3O8n1JN+1ytDaaQ4=; b=c9xaOICfqbhJBeIHTB8N0YGTiZ
	ITKoDy7k8jDiFqaqO/jleimtxKOZZJYpfJeOEECNJqf4IH8aLUC7Mg42aB50+JOeHXeX9PAwr6J14
	4JIVMePMVWjhDadh1YdZ7BNlcLFdFzKAPv+Ej+zz7BWXPDEnQshFtIY8ChhHpgsk6J68S2il817cI
	aWjqV/7kqPb2CU5r1iiOZFaDmtvJ1WUc+3uHcHaM2nRXjYJz2tX0vurqhy3CKWoAr3R4IuC/gE2MH
	6Wcqbgb1p3FfZ5DzI0vVrmbuy1KJ+31xLlO6XY8XugvGNY1I3sUBNMQ1Ht376xg1F1u3zDvFtYafF
	9oba1PYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tauTl-0000000CDVB-1hDV;
	Thu, 23 Jan 2025 10:30:29 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tauTj-0000000CDU6-2Oq6
	for kexec@lists.infradead.org;
	Thu, 23 Jan 2025 10:30:28 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N7Y7ZY031746;
	Thu, 23 Jan 2025 10:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ElgwOm
	g4zurIGAG33KrdB9qV6Qn3O8n1JN+1ytDaaQ4=; b=Sri3esO25xNK9bRMTJPS/L
	dLLKCccE9DfluAZVF6kSh9DAvvxPWazNbPArz+7XDMi3tXV2HXNsl1nmkdv588Vy
	N4UpaGWUEfDtqzKkPBz/PaURBrDU/g+aMd6v9hLIjNJfPJojUtWWHs5u7Y1Yybkg
	0Tfk+QfkpMqAwxTyW34ZJ26qG9qK4n2labKGi+PV962XnC3Ru8KPtcZhbikGhMbD
	Ju+ZpHu46JcmPBxvYSsfoBHdD/Gngqu07S7U2CUGnrFiikJtPuIWe92j6GNldUwQ
	EHTSDyDtWskl3OiLhVXXQKWgmVDT/yfF/RBTuVWEQEYGpQBalFGcs/EKsL9WZ5jA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bhfpgtfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:30:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50N7hopa022642;
	Thu, 23 Jan 2025 10:30:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4kcyag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 10:30:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NAUGO354985174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 10:30:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 186CA2004F;
	Thu, 23 Jan 2025 10:30:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5429D20040;
	Thu, 23 Jan 2025 10:30:14 +0000 (GMT)
Received: from [9.203.114.244] (unknown [9.203.114.244])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 10:30:14 +0000 (GMT)
Message-ID: <43aeaa2c-c266-4d6e-921d-80b99ceb418b@linux.ibm.com>
Date: Thu, 23 Jan 2025 16:00:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] powerpc/kdump: preserve user-specified memory
 limit
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>
References: <20250121115442.1278458-1-sourabhjain@linux.ibm.com>
 <20250121115442.1278458-5-sourabhjain@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20250121115442.1278458-5-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: znjyydUgdRDLatsnRWlibUpXi4ANAtb7
X-Proofpoint-ORIG-GUID: znjyydUgdRDLatsnRWlibUpXi4ANAtb7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_023027_751589_F940FD04 
X-CRM114-Status: GOOD (  18.68  )
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



On 21/01/25 5:24 pm, Sourabh Jain wrote:
> Commit 59d58189f3d9 ("crash: fix crash memory reserve exceed system
> memory bug") fails crashkernel parsing if the crash size is found to be
> higher than system RAM, which makes the memory_limit adjustment code
> ineffective due to an early exit from reserve_crashkernel().
> 
> Regardless lets not violated the user-specified memory limit by

s/violated/violate/

> adjusting it. Remove this adjustment to ensure all reservations stay
> within the limit. Commit f94f5ac07983 ("powerpc/fadump: Don't update
> the user-specified memory limit") did the same for fadump.
> 

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> CC: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>   arch/powerpc/kexec/core.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
> index b8333a49ea5d..4945b33322ae 100644
> --- a/arch/powerpc/kexec/core.c
> +++ b/arch/powerpc/kexec/core.c
> @@ -150,14 +150,6 @@ void __init reserve_crashkernel(void)
>   		return;
>   	}
>   
> -	/* Crash kernel trumps memory limit */
> -	if (memory_limit && memory_limit <= crashk_res.end) {
> -		memory_limit = crashk_res.end + 1;
> -		total_mem_sz = memory_limit;
> -		printk("Adjusted memory limit for crashkernel, now 0x%llx\n",
> -		       memory_limit);
> -	}
> -
>   	printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
>   			"for crashkernel (System RAM: %ldMB)\n",
>   			(unsigned long)(crash_size >> 20),



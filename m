Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072CAEE4998
	for <kexec@archiver.kernel.org>; Wed, 11 Sep 2024 11:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Cc:To:From:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z8nizZfmeMfMrcMy+Gd5ObtXhJwzixPOWU2h5yH/YhY=; b=I4Mfhhod8+d9toeU2VoW4cvTl4
	LN2vQGJio/bk97n6PyBmIOwMvTOv6WhCW0Oig0gZCevAK50xpeZa6Q7dQm3i/hh8BmSyvclPyIaAr
	ir1Ak7SYIbRWm6O+zcRyFgINDY3wOU+ZY+81AXDflev7sLjDSLPCYwlhr7q46nMtBe4yquJXySXiQ
	sp4JODDWz0ngAjKU5piW4P69rP0N6tFywk73seQ3lgGwQleGST/9vGH2K2hmjmVAHcvRRX/4syMuE
	CHjb9t+5lB9TTMgviv2tXKUx8+4FCZNWGjAy6r1hxGgPUnvkp/6mR3T+SuefR6E1Jzmfu0BJuWV3G
	x/AnmhBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soLXT-00000009IUZ-31eN;
	Wed, 11 Sep 2024 11:29:35 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soLTh-00000009HfD-2Pbq
	for kexec@lists.infradead.org;
	Wed, 11 Sep 2024 11:25:43 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B1nUPw012586;
	Wed, 11 Sep 2024 11:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	sywYchqhTAQV+RCPprqliDsB9dTSqAw/2IhHgB76NhE=; b=P8MFS+PWLb1Zr5fa
	NXjwneUkUS8yggXDhoJr8Hot3t3IkEXJ1V5RyHQkYRQ8YhGlceEDlzgbbIpdcgnt
	5/D7pFsmpfeRzNHRfqWt4qiYJAAIqPZqR6u7NlfysChywmd2AbJF1dzOH4wE4oU5
	q+EiiCek2M7eDN5zqRccQRHJujrQY1WItHF3sn9cDfFsUm3TgARb2ZKjJV/x9bIB
	cMj0IM3We7BWsdREBGcddG9Zo/UFJX087fM6ltcoypD6Lxq3XKkRd8AEN4B22O4p
	tcxoYjUzSz1rf8D1JgqQGoLw6oiv38VHX7vyo6ZcFpFlMZ+QaCYVCBTJt4ZQEYhF
	ccDwvA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qdh8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:25:34 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48BBM67k014261;
	Wed, 11 Sep 2024 11:25:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qdh87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:25:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48BAEHoF019899;
	Wed, 11 Sep 2024 11:25:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25q154a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:25:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48BBPScY12648720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 11:25:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 552E520043;
	Wed, 11 Sep 2024 11:25:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32D8E20040;
	Wed, 11 Sep 2024 11:25:25 +0000 (GMT)
Received: from [9.43.116.75] (unknown [9.43.116.75])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Sep 2024 11:25:24 +0000 (GMT)
Message-ID: <051bff75-e21a-468e-958b-5eead2e5c8c2@linux.ibm.com>
Date: Wed, 11 Sep 2024 16:55:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kexec/crash: no crash update when kexec in progress
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: bhe@redhat.com
Cc: Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
References: <20240911111528.104303-1-sourabhjain@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240911111528.104303-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JYHQ6pVXKWof2VG3slyjEUbPV9nDC49B
X-Proofpoint-ORIG-GUID: IKogUM0QbkfR-Rsl13s6SeHboUzSYGkW
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_042541_753062_0E34BB3D 
X-CRM114-Status: GOOD (  27.27  )
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

Hello all,

Please ignore this patch. V2 has been resent with an updated 
linuxppc-dev mailing list address:
https://lore.kernel.org/all/20240911112111.108056-1-sourabhjain@linux.ibm.com/

Apologies for the noise.

Thanks,
Sourabh Jain

On 11/09/24 16:45, Sourabh Jain wrote:
> The following errors are observed when kexec is done with SMT=off on
> powerpc.
>
> [  358.458385] Removing IBM Power 842 compression device
> [  374.795734] kexec_core: Starting new kernel
> [  374.795748] kexec: Waking offline cpu 1.
> [  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [  374.935833] kexec: Waking offline cpu 2.
> [  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> snip..
> [  375.515823] kexec: Waking offline cpu 6.
> [  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [  375.695836] kexec: Waking offline cpu 7.
>
> To avoid kexec kernel boot failure on PowerPC, all the present CPUs that
> are offline are brought online during kexec. For more information, refer
> to commit e8e5c2155b00 ("powerpc/kexec: Fix orphaned offline CPUs across
> kexec"). Bringing the CPUs online triggers the crash hotplug handler,
> crash_handle_hotplug_event(), to update the kdump image. Since the
> system is on the kexec kernel boot path and the kexec lock is held, the
> crash_handle_hotplug_event() function fails to acquire the same lock to
> update the kdump image, resulting in the error messages mentioned above.
>
> To fix this, return from crash_handle_hotplug_event() without printing
> the error message if kexec is in progress.
>
> The same applies to the crash_check_hotplug_support() function. Return
> 0 if kexec is in progress because kernel is not in a position to update
> the kdump image.
>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> Cc: linuxppc-dev@ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> Reported-by: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>
> Changelog:
>
> Since v1:
>   - Keep the kexec_in_progress check within kexec_trylock() - Baoquan He
>   - Include the reason why PowerPC brings offline CPUs online
>     during the kexec kernel boot path - Baoquan He
>   - Rebased on top of #next-20240910 to avoid conflict with the patch below
>     https://lore.kernel.org/all/20240812041651.703156-1-sourabhjain@linux.ibm.com/T/#u
>
> ---
>   kernel/crash_core.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index c1048893f4b6..078fe5bc5a74 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -505,7 +505,8 @@ int crash_check_hotplug_support(void)
>   	crash_hotplug_lock();
>   	/* Obtain lock while reading crash information */
>   	if (!kexec_trylock()) {
> -		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
> +		if (!kexec_in_progress)
> +			pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
>   		crash_hotplug_unlock();
>   		return 0;
>   	}
> @@ -547,7 +548,8 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>   	crash_hotplug_lock();
>   	/* Obtain lock while changing crash information */
>   	if (!kexec_trylock()) {
> -		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
> +		if (!kexec_in_progress)
> +			pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
>   		crash_hotplug_unlock();
>   		return;
>   	}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

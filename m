Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3091CDB474
	for <kexec@archiver.kernel.org>; Tue, 17 Oct 2023 10:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DRAbGjWaWAj5wVQO+d1Mo2/zEzYlYr/Bev65hGsxC+4=; b=ttlTqby1jtwWoI
	WEh2wTZ/FX5SwYtBtfKm1S8KN4rc2cQ+cDd1+5f6JyTzxv1+EA5VyhOku5fAxSLkOpCt9aKuxAe67
	qBke2FRQ60cI+j1i1VrqkzmdnLKZVxgZ+wM17Tcs/xhGuUp8ftguvwm6+gFdAi16RyapfzcjftlCV
	gGXICXIwahlhZPp0O+2LyM+sui3qV8/Gp+B6ZCSd+t5NloWLpdnSbqLgJH0l4zQBk6FAdPI/31ekZ
	sqGmtlCXADfvOtD3XPlf7i+IiTTf2MwrZ8fZMTVDgpXW9RGPXj9PzrRYYb8JIJeCf5TmZRCU5PhOO
	BKksWSZgaGFCuT7i5cWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qshOC-00C66X-0I;
	Tue, 17 Oct 2023 10:33:28 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qshO7-00C62c-2Y
	for kexec@lists.infradead.org;
	Tue, 17 Oct 2023 10:33:25 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HATQxj021740;
	Tue, 17 Oct 2023 10:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Tlf+oTVxCcnecV21J9ROPtWMY0jET//PlIcawPM8rPk=;
 b=szyyRuQ0E4JmVuUI/lB8vjmMfqsU0X1R1LpR2JWxPvd4az5hxesqyj50QOwqs+5W/BUh
 W/vaKB/93VQCJxakFYW1CWdWK+yTFVBciezRQjYkWF29Z79IaFMKa/MxPLfKLIvE5Eaw
 O1Ugge6QvniAtEUKVr5tV/hPrjvr/045t1khPUjjoX55+x1NI/q82+0Li0ejfDnnqw3X
 p56Ci7a4ilM4z6P4Kr8Eiz64vQ347AYpuStWTHFYnjdRIBQ+er7KH0xCN69IIGMMM/im
 j3gQvUtVldwpdlUET+BSmPLJkk0kU8Cdbzc+oadHZQmhyNv2cr6UnpJO0c26/ftOWBYH rg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsrjd06eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Oct 2023 10:32:56 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39HATjPV023056;
	Tue, 17 Oct 2023 10:32:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsrjd0550-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Oct 2023 10:32:08 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39H8t1vJ012871;
	Tue, 17 Oct 2023 10:31:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5py8d7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Oct 2023 10:31:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39HAV6VV43713096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 10:31:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B49A92004B;
	Tue, 17 Oct 2023 10:31:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFC9720043;
	Tue, 17 Oct 2023 10:31:04 +0000 (GMT)
Received: from [9.43.86.173] (unknown [9.43.86.173])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Oct 2023 10:31:04 +0000 (GMT)
Message-ID: <15e9830a-800f-24b3-29bc-af36fade447e@linux.ibm.com>
Date: Tue, 17 Oct 2023 16:01:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv9 1/2] powerpc/setup : Enable boot_cpu_hwid for PPC32
Content-Language: en-US
To: Pingfan Liu <piliu@redhat.com>, linuxppc-dev@lists.ozlabs.org
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Ming Lei <ming.lei@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
        Sourabh Jain
 <sourabhjain@linux.ibm.com>,
        Wen Xiong <wenxiong@us.ibm.com>
References: <20231017022806.4523-1-piliu@redhat.com>
 <20231017022806.4523-2-piliu@redhat.com>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20231017022806.4523-2-piliu@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WJ43DWB2YgHBkYCKaapMUY5DBcAXlxDQ
X-Proofpoint-GUID: oXFClmMtoBHp_6stgKRrmeldR4IApy7I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_033324_181044_BEFF8E14 
X-CRM114-Status: GOOD (  26.14  )
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



On 17/10/23 7:58 am, Pingfan Liu wrote:
> In order to identify the boot cpu, its intserv[] should be recorded and
> checked in smp_setup_cpu_maps().
> 
> smp_setup_cpu_maps() is shared between PPC64 and PPC32. Since PPC64 has
> already used boot_cpu_hwid to carry that information, enabling this
> variable on PPC32 so later it can also be used to carry that information
> for PPC32 in the coming patch.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Wen Xiong <wenxiong@us.ibm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: kexec@lists.infradead.org
> To: linuxppc-dev@lists.ozlabs.org

LGTM.

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> ---
>   arch/powerpc/include/asm/smp.h     | 2 +-
>   arch/powerpc/kernel/prom.c         | 3 +--
>   arch/powerpc/kernel/setup-common.c | 2 --
>   3 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
> index aaaa576d0e15..5db9178cc800 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -26,7 +26,7 @@
>   #include <asm/percpu.h>
>   
>   extern int boot_cpuid;
> -extern int boot_cpu_hwid; /* PPC64 only */
> +extern int boot_cpu_hwid;
>   extern int spinning_secondaries;
>   extern u32 *cpu_to_phys_id;
>   extern bool coregroup_enabled;
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 0b5878c3125b..ec82f5bda908 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -372,8 +372,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
>   	    be32_to_cpu(intserv[found_thread]));
>   	boot_cpuid = found;
>   
> -	if (IS_ENABLED(CONFIG_PPC64))
> -		boot_cpu_hwid = be32_to_cpu(intserv[found_thread]);
> +	boot_cpu_hwid = be32_to_cpu(intserv[found_thread]);
>   
>   	/*
>   	 * PAPR defines "logical" PVR values for cpus that
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 2f1026fba00d..707f0490639d 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -87,9 +87,7 @@ EXPORT_SYMBOL(machine_id);
>   int boot_cpuid = -1;
>   EXPORT_SYMBOL_GPL(boot_cpuid);
>   
> -#ifdef CONFIG_PPC64
>   int boot_cpu_hwid = -1;
> -#endif
>   
>   /*
>    * These are used in binfmt_elf.c to put aux entries on the stack

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

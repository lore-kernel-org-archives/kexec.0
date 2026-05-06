Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEE9CD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ymwz81ZT0ee0A7Z40TanQ1NtaixY2fopOfoPKPPt9/k=; b=SailLFvgFneC+PZtyVtvOIp/Pm
	F/9wvX+35EOzIJ69Gum9FX0NegrAZwaj6lHAFiJhHnUbxOjqMLw3EUCbkowfTpqhb4J+8opvQ6mp2
	DsqgpdJvGKfYRt2yjG51XAY8NN0zxvXBNJZwfDshEcReMQlHSdM0uAiK8Ujk81stZQunkCCzoK9Pp
	Y3GEbS/7AKQlveTGkYmdkBKhCGhniL0/bIEqT1Zb0VOySMHZloD+xUk2HB2rm4RAitUwsybM5tcue
	TpN0n2V0JDB8zIah4fMHLUeuQmHpRbY+sinzQLv43M8sV92p8QMMC8w9Jw0p0KRtnf0SPgefkOY+a
	PfYcB0rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKdKS-000000016if-1eIs;
	Wed, 06 May 2026 14:34:24 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKdKQ-000000016hg-4AdJ
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 14:34:23 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646BrxfF2727273;
	Wed, 6 May 2026 14:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ymwz81
	ZT0ee0A7Z40TanQ1NtaixY2fopOfoPKPPt9/k=; b=O5Pq70/YkAkSVUyqh+XX7R
	aAeE5jUMlrmMPh8roT38myDj3X3e4gMphQn/K1GPQu8e7xTYWEhVQNrmB0TUl3GR
	glIhRQuCZILHBgPTCl5GBqhgrou5XCJHTwVrW0MKbs0mfHJpAS2pUQLIMOtigqoF
	/z3KTNkem3QbdNEBF02W2rO5ShadKbruomCXBWWhF6yNsbCXY3AX+/dCZZv2iO13
	rDEC5WckotU9U+e/FUzEKqtYCGz2j8U3AR5MLNnELmbG12HPKnq/O3b/apMFdTGw
	dE/WupJtjTH5HQscLqtVCPTS/QUEqvcj0vOo1foUzR7spfXpJZEwir18NL0wPkog
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4s4bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:33:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646EOsUc010060;
	Wed, 6 May 2026 14:33:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yec75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:33:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646EXous49611230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 14:33:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7CAF20043;
	Wed,  6 May 2026 14:33:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7170420040;
	Wed,  6 May 2026 14:33:46 +0000 (GMT)
Received: from [9.124.208.31] (unknown [9.124.208.31])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 14:33:46 +0000 (GMT)
Message-ID: <23784559-1e11-4e14-bf23-6ffebd7b2d30@linux.ibm.com>
Date: Wed, 6 May 2026 20:03:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] crash_dump: Improve readability of
 config_keys_restore_store
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>, Coiby Xu <coxu@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
 <20260501234342.2518281-8-coiby.xu@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260501234342.2518281-8-coiby.xu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzOSBTYWx0ZWRfX3eMw0+MkNrHj
 E5OesnVX0cE3eyAYoM333wb4ckoS8BPnUsKs16I2YZbY0WgNWr3WAWaH1XjP4jrRN2uCakfoCbb
 Qz7PKv8OAfFGe2aipUz/4AoWpGTTHAcTLFem+CjK2bdvL8GcSPUBFS6qQy63GJtkIg6/B1h+j0s
 zSuMnMrBZTpNz+G7jbv54Ltu7LyT+0NuJK+UOKE3RGX5wKChti8XNttfsr6V2AlPgrnKQjKZElE
 CEz6xJzajROf4YLby/g8/KXVjsjcvlYlbDG8G8gdxyf6Xw+hgcJjNhwmTpVoA/FBtYRH94Qlg5f
 9z7xusUGcd0Jrp6jlZNPE8Pe81VwEbEjBv5ombxFAQC6LqwZrpg32BsPWgnSkykPxkUDu1VXlj6
 BC6y7KxcDam7ft0lCBigKXsZlgf6w5PoX+pSY+lDs6xirVumQMp21g/L0XFqFiYNCpZd/7XEERT
 qpwkoXt0osFYRnU79ww==
X-Proofpoint-ORIG-GUID: jJN_-9ggJJLQRngugQXjIPG0B-DpvNne
X-Proofpoint-GUID: Q1rK92zJdTSiNgq7akaad138bPJcbYCj
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fb5151 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=LpzC2sJZ3Km07TKc-7cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060139
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_073423_042224_6B2BE83B 
X-CRM114-Status: GOOD (  20.97  )
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



On 02/05/26 05:13, Coiby Xu wrote:
> config_keys_restore_store currently doesn't validate the user input
> before restoring dm-crypt keys. Although it's not necessary for the case
> of vmcore dumping, it's better to do it for the sake of consistency and
> code readability. Also check the return code of
> restore_dm_crypt_keys_to_thread_keyring.
>
> Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>   kernel/crash_dump_dm_crypt.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 545d712428d3..36e51807d94f 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -358,12 +358,16 @@ static ssize_t config_keys_restore_show(struct config_item *item, char *page)
>   static ssize_t config_keys_restore_store(struct config_item *item,
>   					  const char *page, size_t count)
>   {
> -	if (!restore)
> -		restore_dm_crypt_keys_to_thread_keyring();
> +	bool val;
>   
> -	if (kstrtobool(page, &restore))
> +	if (kstrtobool(page, &val))
>   		return -EINVAL;
>   
> +	if (val && !restore) {
> +		if (!restore_dm_crypt_keys_to_thread_keyring())
> +			restore = true;
> +	}

Nit:
I think it would be good to warn the user if they try to
restore it when it has already been restored.


- Sourabh Jain
> +
>   	return count;
>   }
>   



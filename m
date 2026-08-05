Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0D6C55174
	for <kexec@archiver.kernel.org>; Wed,  5 Aug 2026 11:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AYF6P0djNhDiGhwzzy+BIuGuXh70PYPlqhuEevS50oM=; b=UNKUGXIJDmSf5LdqTp0SfB6lHR
	bnhvR8J6OFO9uowv4d7Qip1c+qBkxE6MhQuTDYgegw7+vWinlzpUu9e7b9AoUS6BfvP4UY8HoJVUo
	B54t8aRwc3q1XGHQGIaXrKLxi3IoQJfa0ldV0bjpl3s2sJ6MMnnkE9H0n14Tc8uli2Hzngr1mNyMD
	OlJJkxAPe9uXgINJGJyC4L3wRaBq/rlNx54dqUPirjeNe1Y7sG7VGsmZRFSHTqCePUCxPWuscrBDy
	sHqa4IaPM07qhi6R7R1B/9RW77ZesxQ8sOuVbDEBuZ/knMOph7lQ5Vl2IZHLubTlb0lW4esznlar7
	tV8KLGNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wraB5-00000003psq-12eu;
	Wed, 05 Aug 2026 11:52:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wraB2-00000003psT-1s1O
	for kexec@lists.infradead.org;
	Wed, 05 Aug 2026 11:52:53 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lfNc3288619;
	Wed, 5 Aug 2026 11:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AYF6P0
	djNhDiGhwzzy+BIuGuXh70PYPlqhuEevS50oM=; b=c//2tKEgZboCS19JgcPvPk
	x1iuDHo7ODiziU+u1OTnt+b4ROVoz2y3soRlI8LY5HkLEoecrgR3jUccH5gchlfY
	KahSLR2BldPNX9g86BQ+trA8144nfINotgQPUsQSUjB90S0LZmuGmvo/ZaJcgXuG
	BuDfCf0NIH6B/qc+R+w5/1JitWujaL5uGli3Q+xntLeRE1WBz0en2TqmBN+IH+tB
	hEYbwkqsIMn2xGttdJb4cY+3WIm8PK+LiSlgMql8wXttEix7TJ54Nh1T/obJzrS2
	busAsTBtAGMoXvdM4fgEJpUYxz0tbxuHGBgaRMz+Sh1KIXQQyzQBiADM3Gr5LmmA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67htky8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:52:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BfGYM008615;
	Wed, 5 Aug 2026 11:52:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbge6ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:52:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675Bqi9f50331920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:52:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1302320043;
	Wed,  5 Aug 2026 11:52:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2E5120040;
	Wed,  5 Aug 2026 11:52:40 +0000 (GMT)
Received: from [9.39.28.63] (unknown [9.39.28.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:52:40 +0000 (GMT)
Message-ID: <816ce698-c4f1-4179-9741-798f5842742e@linux.ibm.com>
Date: Wed, 5 Aug 2026 17:22:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] crash_dump: Improve readability of
 config_keys_restore_store
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, Coiby Xu <coxu@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-8-coiby.xu@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260729033654.311541-8-coiby.xu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfX/0bDz8xsCbKO
 FcL3Y/4vrgXbKNuQkCXm/Bux/F3v0dJGGSjKFuzRAHO/rD0FWO02md//v1jMQfncHYzN58+HpXm
 Nbl8fGYiNChmfT+BfNT7g7Smoo5/h40=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a73240f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=LpzC2sJZ3Km07TKc-7cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfX4sLlAjaN06Nj
 yf1MR1ZpgkxRY7CLVGQNR4KZ5Q1ERMQtGZNn1nYVwQbtuGDTRuWO4yhoZzZ7t9Ijk0NgSbv3Zaz
 JwPdIBYjHgtHIXk5BKATjMo6nwjSwkwXiidi+fcBJQhG7bOMbErgXiT1BQh5v/Y1AlKQsKqQND9
 l6o/Qie6uEV0LUzBoRi4/BQJHUfyAzQNcEBriNKQLdCGYidxTENLooUZXRm2WgS6NeyyBQA/5sz
 Qlh/Nfxnf8w3AmHCmfSVHBrCXlN6PTA3MHJdmWAsYFlS+miBkPYiJU8OOkdRc4tf9aNZDzBQe28
 VagkfCItcrk0WMNpR9ZlHEm1bwtaCkOOyOh1sE8lW0mXZt3m+esrdJiY4/qWAAyKquh7IkYYemm
 oNbpCtFGCSUFWEuSDzMiRrVv7jqSaX29HXzBQ21IbPfKediZJLQdy+Ea4HmX1XukyIkI9a04yvo
 bTZF+h7tOc4cmKMY2YQ==
X-Proofpoint-ORIG-GUID: AfO9A2ZOSLaLlDyBeDzMTtUltJS7s2Dk
X-Proofpoint-GUID: 9CzXtDP2XU5XDbiqxcUPx1YYAoFPd18F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_045252_629935_8841A512 
X-CRM114-Status: GOOD (  19.92  )
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



On 29/07/26 09:06, Coiby Xu wrote:
> config_keys_restore_store currently doesn't validate the user input
> before restoring dm-crypt keys. Although it's not necessary for the case
> of vmcore dumping, it's better to do it for the sake of consistency and
> code readability. Also check the return code of
> restore_dm_crypt_keys_to_thread_keyring.
>
> Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>   kernel/crash_dump_dm_crypt.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 3ee01996778f..1f4549956824 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -370,12 +370,19 @@ static ssize_t config_keys_restore_show(struct config_item *item, char *page)
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
> +	if (val) {
> +		if (restore) {
> +			pr_warn("dm-crypt keys already restored!\n");
> +			return count;
> +		} else if (!restore_dm_crypt_keys_to_thread_keyring())
> +			restore = true;
> +	}
> +
>   	return count;

Nit: returns count even when restore fails.

Rest of changes looks good to me.
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

>   }
>   



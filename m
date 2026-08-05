Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07559C55174
	for <kexec@archiver.kernel.org>; Wed,  5 Aug 2026 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+wU/E2III1+IEGabZ6DMayf6jdR6xyftcMC18GFCeBk=; b=UFphqsvhpElC55vFPPWxw77fH4
	gSH8DcmqTLfB3X9OeAroy7/BnDNz9dQ5MmwjpFO9GWSJdHAsgLZ9r7sSqfeOvLA7XNd7xluMbDi8q
	QBhGVW/biqHakIyzhXY1dxdllXyHcBAHjtU46WOyukoL1k/pKrzqzbfPSmxofLCDXmjjDeKSPS1Sc
	eBmd9D2hgWfkIQRBUhtAmyBAuSlaAuDPI4RAyfx778KqRZPS+ein2AuwA1uymlYLjckEsAjsuUFDO
	D92QK0uz+D4f2t5X99lZ5loXqgc0GbPoh7gsa46HOpoaXxCkWEkKhYT+QF3b1vvQ/u9/DK3Xb1Vrn
	LVdtcF1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wraLE-00000003rSO-3XmY;
	Wed, 05 Aug 2026 12:03:24 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wraLB-00000003rRf-3Iwu
	for kexec@lists.infradead.org;
	Wed, 05 Aug 2026 12:03:23 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lY3g3387227;
	Wed, 5 Aug 2026 12:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+wU/E2
	III1+IEGabZ6DMayf6jdR6xyftcMC18GFCeBk=; b=O/3a6bodpmTtFEBUIb5FlL
	7Fs1/0sKcK1nq6Oj1EJ6rgBu6w+gjRJOICmL864I7pTiC2z1Al2mQ9mLFGC6FyIc
	3XwoIFj2IF/cSux6MPJeLKOS0JnHQiuTICnhEjoKh+DEUtq+uVjdLbsbXYzSrbaT
	gGET0z33nkIACPhwEAovTO3p/+dScNXCvY5itc9MlIGniy1M/az3o6XjpRYpSGlp
	UVtwd1MM3YbMWs423GoHezQlblVqY6iahsopGu4k1+/12JZdExuOLJoTfBH/Uz0s
	sLSMAx7BA8FY3GmNmGUsCSafC0TLASCTs9WUBcgqX3QGaXCJOpISVocP+ihZJZrQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h52v7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 12:03:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BuuQB010210;
	Wed, 5 Aug 2026 12:03:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw6h3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 12:03:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675C3DUJ15597972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 12:03:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6C252004B;
	Wed,  5 Aug 2026 12:03:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D14F320040;
	Wed,  5 Aug 2026 12:03:09 +0000 (GMT)
Received: from [9.39.28.63] (unknown [9.39.28.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 12:03:09 +0000 (GMT)
Message-ID: <1128fe70-41b7-4f68-8c90-34f291434b3a@linux.ibm.com>
Date: Wed, 5 Aug 2026 17:33:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] crash_dump: Check the function return codes in
 restore_dm_crypt_keys_to_thread_keyring
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-9-coiby.xu@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260729033654.311541-9-coiby.xu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfX1V5ag8HPlBTd
 aNWhHuDRe15MGB5BATPBH3rptM+0D3fOQC/b3KaA2Q3IkLimEU2uHNe4KmV8gBPvHIBLaodgrIF
 nYWNs01nsppEF/NqFemrkfZlmBi0uyc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfX76vZhRttpPkH
 lRZjcy9ErzxFq6SLi4eAA7brCLzodqD8DzQCQFO9d1HEGcJiPqFXH/thhdMQi04Opr80VQ43QOV
 clF6R09UqbDfV71662lF9G0exi/cM1X85buEDomivxbln4BIvZX6x/R49WIo7RzbsthFrpVpdAf
 rzD52POBBV/LogRHYW+z++ZKzVjoddfB+8nyokqG3Qt4vWI9uVPC5oU0TMGkHZcWDwHepvdYBy7
 tg+TcJ3WlIeOG5Deq4mGYGfTGCVkVyHMjV2TMGr8Plg5BQQwWSx2r9U9g+/flTefWdXwtPEfZkr
 Mid7jZlPRSF2F9YeCKtQpdQkQDY9vgSe2Yo/HfIlLeqHxVJd4JkBvh333bhJYzQEX8zCUEKUyEM
 9RUbgmTnThJ/chD+5ZGkpgVJ0DsvThN2Xa2hOcA8+7aZb5AJs8kyu+q2llKQaMgmuzJwtJbe6fl
 Q/VI9LlPDWYpQqjEUbg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a732685 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=CmFqFwAlXTw2FQRxuVIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nEwzqt20qbSkTro8TjGRW5nQ0BPPFHDd
X-Proofpoint-GUID: AR2qFdSYRcVkyAOJfpM58lqZU1mNxujs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_050321_838207_95F96490 
X-CRM114-Status: GOOD (  22.79  )
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
> We should check the return codes so we can abort if keyring allocation
> or reading old memory fails.
>
> Note there is no need to refer a key add_key_to_keyring, so delete
> related code.
>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>   kernel/crash_dump_dm_crypt.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 1f4549956824..b5b78656cf06 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -65,7 +65,7 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
>   			      key_ref_t keyring_ref)
>   {
>   	key_ref_t key_ref;
> -	int r;
> +	int r = 0;
>   
>   	/* create or update the requested key and add it to the target keyring */
>   	key_ref = key_create_or_update(keyring_ref, "user", dm_key->key_desc,
> @@ -73,8 +73,6 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
>   				       KEY_USR_ALL, KEY_ALLOC_IN_QUOTA);
>   
>   	if (!IS_ERR(key_ref)) {
> -		r = key_ref_to_ptr(key_ref)->serial;
> -		key_ref_put(key_ref);
>   		pr_debug("Success adding key %s", dm_key->key_desc);
>   	} else {
>   		r = PTR_ERR(key_ref);
> @@ -133,9 +131,14 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
>   	}
>   
>   	addr = dm_crypt_keys_addr;
> -	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
> +	ret = dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
> +	if (ret < 0) {
> +		pr_err("Failed to read the number of dm-crypt keys\n");
> +		goto out;
> +	}
> +
>   	if (key_count > KEY_NUM_MAX) {
> -		pr_warn("Failed to read the number of dm-crypt keys\n");
> +		pr_warn("Read %u dm-crypt keys (max=%u)\n", key_count, KEY_NUM_MAX);
>   		ret = -1;
>   		goto out;
>   	}
> @@ -150,12 +153,18 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
>   		goto out;
>   	}
>   
> -	dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
> +	ret = dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
> +	if (ret < 0) {
> +		pr_err("Failed to read dm-crypt keys\n");
> +		goto out;
> +	}
>   
>   	for (int i = 0; i < keys_header->total_keys; i++) {
>   		key = &keys_header->keys[i];
>   		pr_debug("Get key (size=%u)\n", key->key_size);
> -		add_key_to_keyring(key, keyring_ref);
> +		ret = add_key_to_keyring(key, keyring_ref);
> +		if (ret)
> +			break;
>   	}
>   
>   out:

Changes looks good to me. Feel free to add.
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>


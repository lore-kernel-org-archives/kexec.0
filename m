Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89066C55ABA
	for <kexec@archiver.kernel.org>; Wed,  5 Aug 2026 11:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YA789FDwlkJIWs5hfghSLRxPgwxZ9MGFWmedi+cV5sQ=; b=1tuqUs8F2wMnuay4fWxVXv9LtZ
	L9BpOuMLK9EctiuDYk6uA/5w9sCj/NsWyDTT4nI1ZKCj71htBnrelO7cjsXxnKk/EqrDa9l1XauoX
	hwExzO6vHtMPuHwzMCYZgpRQJ0hhjWgwnvP38i67LoKR2GdYIHP8UUe0IJ6atnVnMwzXbeR8rUfd4
	6IO45a86hNTpDeBxL/uN5If/Miqf8Y4x1tvhtDRpWkH6m16TrOf0lE1PVGIuVtn+X7aJG/S0KOcmd
	CbzYj8H0JTgW67VzbL/XWlitwy20oHkaVx/9wB3rGiiJHNTvZ/zHNQb85M+CoK1WdaCbaAIls3ou1
	ZrWcXPIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrZvb-00000003pHP-3N31;
	Wed, 05 Aug 2026 11:36:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrZvZ-00000003pGx-2ukY
	for kexec@lists.infradead.org;
	Wed, 05 Aug 2026 11:36:55 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758ljF43288699;
	Wed, 5 Aug 2026 11:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YA789F
	DwlkJIWs5hfghSLRxPgwxZ9MGFWmedi+cV5sQ=; b=o0dSR1p0zAlIWeu/ihnhNd
	YURLOgD93zkiGcuMan171jNdMvQPRBigSne7T1+l6empRDtRkfHA8PUtrnpK4Gcd
	FrBk9/xQhGVQRcl158osFN7KhWBb0FCiRAvbGR1P5dCmavMudb8QXGUnu9Skdufw
	ZcglQsrpFD1I56C+/5uggmlA+2dbpR9cy7UQBPgL4dNkr1s9PAKHrhVJZFvOjzws
	Alht7KY0ix6HCiepk+hd7c2rXoYV4ZoGe4UwG7EIiDC1poVoKYPU0KVyTf7b8eDK
	LFsWJoJns2WxEn368DhuyUpNS5ys97oRrfzeG1xrqlvewwM1O0j9MUrteRfoIJFA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67htj3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:36:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BBEti005762;
	Wed, 5 Aug 2026 11:36:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbge4jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:36:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BaibU8782226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:36:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B35E320040;
	Wed,  5 Aug 2026 11:36:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 619E22004B;
	Wed,  5 Aug 2026 11:36:41 +0000 (GMT)
Received: from [9.39.28.63] (unknown [9.39.28.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:36:41 +0000 (GMT)
Message-ID: <4eb634a2-375b-45ae-8cc0-7d5ea9f6e264@linux.ibm.com>
Date: Wed, 5 Aug 2026 17:06:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] crash_dump: Only use kexec_dprintk during the
 kexec_file_load syscall
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, Coiby Xu <coxu@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-7-coiby.xu@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260729033654.311541-7-coiby.xu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5MCBTYWx0ZWRfXwL2hunZNAWnQ
 GyBVIbx5GmpWx2vM5uoEEhzhRS/1GQnkC2Z+gNO9P+DIAEavg5/gQCt4N9s9J1ay1EGwE//9oo/
 i5AlaJ74Z7Y7SUd67LFwMUksGWBctWY=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a73204f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=V2yfwe0RlgjpGSOtMskA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5MCBTYWx0ZWRfXyPw4i80axUIk
 pWVfLSglR3sxSuwzZPf/CAONvrzE76XCS6+pSTteGGLf3tTv2l7yWT/LVw8LIooTZoFk154ZRcl
 GL6tutpYO4FlK4uX5/G7N1FuClawsvSR1t+z6YcKFV46rEC1NfAZLxDbx/dKETLEz4zmSnwg80n
 GEYp2V1rUiMngoUb7vlNubScujCfPNBpsjxpe3KoUmS8nbXQdLWg7bmMJdgAzY5v3V52k1K5OAn
 P+snfjx+B1dOlknFKtepH7ksVrwY4sBwBqyJRE4V2Vxa5WJK3I9LP0JsTn9a8BqmwVc+ZxBo6oA
 ps9s68RunjNHEXcjKNAqJ5K9aC9s52p1lssmsZzBeJJEdNy2ymkXjG0DQZRl1h1ECCLkfJf7K/o
 246hf4hssMA+YE80RPwkfhbs/ntOAK5fz3OhrqQtm68V4Yz7b97Q+EjrsbMsjGcQYp1fSgVWkLz
 wKVuY1OwkcHpcpacqvA==
X-Proofpoint-ORIG-GUID: g5cL8f5vf9M1cL4lHs9e8-lWNKEw0kLn
X-Proofpoint-GUID: 5F1ET3WeNPfbcFCO0RkPXUObIyB2Cl5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_043653_862210_06F1B599 
X-CRM114-Status: GOOD (  22.00  )
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
> kexec_dprintk will only be activated by "kexec -d" during
> kexec_file_load syscall. So use pr_* outside of this syscall.
>
> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
> Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>   kernel/crash_dump_dm_crypt.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 9a64e2d6841b..3ee01996778f 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -75,10 +75,10 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
>   	if (!IS_ERR(key_ref)) {
>   		r = key_ref_to_ptr(key_ref)->serial;
>   		key_ref_put(key_ref);
> -		kexec_dprintk("Success adding key %s", dm_key->key_desc);
> +		pr_debug("Success adding key %s", dm_key->key_desc);

Missing a newline in the above debug message.

>   	} else {
>   		r = PTR_ERR(key_ref);
> -		kexec_dprintk("Error when adding key");
> +		pr_warn("Error when adding key");
>   	}

Missing a newline. Also, I think printing the error code (r) would be 
helpful.

Apart from these two minor nits, the changes look good to me.

Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

>   
>   	return r;
> @@ -128,19 +128,19 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
>   	keyring_ref =
>   		lookup_user_key(KEY_SPEC_USER_KEYRING, 0x01, KEY_NEED_WRITE);
>   	if (IS_ERR(keyring_ref)) {
> -		kexec_dprintk("Failed to get the user keyring\n");
> +		pr_warn("Failed to get the user keyring\n");
>   		return PTR_ERR(keyring_ref);
>   	}
>   
>   	addr = dm_crypt_keys_addr;
>   	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
>   	if (key_count > KEY_NUM_MAX) {
> -		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
> +		pr_warn("Failed to read the number of dm-crypt keys\n");
>   		ret = -1;
>   		goto out;
>   	}
>   
> -	kexec_dprintk("There are %u keys\n", key_count);
> +	pr_debug("There are %u keys\n", key_count);
>   	addr = dm_crypt_keys_addr;
>   
>   	keys_header_size = get_keys_header_size(key_count);
> @@ -154,7 +154,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
>   
>   	for (int i = 0; i < keys_header->total_keys; i++) {
>   		key = &keys_header->keys[i];
> -		kexec_dprintk("Get key (size=%u)\n", key->key_size);
> +		pr_debug("Get key (size=%u)\n", key->key_size);
>   		add_key_to_keyring(key, keyring_ref);
>   	}
>   
> @@ -309,8 +309,7 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
>   	int r;
>   
>   	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
> -		kexec_dprintk(
> -			"dm-crypt keys haven't be saved to crash-reserved memory\n");
> +		pr_debug("dm-crypt keys haven't be saved to crash-reserved memory\n");
>   		return -EINVAL;
>   	}
>   



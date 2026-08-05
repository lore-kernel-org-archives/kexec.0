Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C787C55822
	for <kexec@archiver.kernel.org>; Wed,  5 Aug 2026 10:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SlVt/Gt4BthsrjqFz0nrv3ocRpvVezu608M8w7ykBfE=; b=dYagbYCHVl9mP0K+en5q47hw1X
	7KJgkZFJsLEVEcwoPn493euwc3YlxMm/5RkhGI7wyo/GHYOBrcyCOgMspruTqI+URZ7BEKh85Gc42
	IWWyDVr8orQtlSGFQ99pg5cIiAKsrYHxey+i+qkv94BmtRvTNQDkDLrKab5dR1tPRblEdLxI18piW
	LeGgomTTPcnRSKac22R+cSA6wS64iGhYS0HLhKmQ9SM07fFF5DOnawo5US0ZPtQZoXbxmxn+wk70p
	z3k2tXFn05McWFTm/WSb8lbotIJTCYd7lg0rrJOHptMV/D3cHhWmSYlB2PE06BDYH36+zfi63tIkD
	oywyXC6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrYtx-00000003kMk-0iNG;
	Wed, 05 Aug 2026 10:31:09 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrYtu-00000003kLr-34q6
	for kexec@lists.infradead.org;
	Wed, 05 Aug 2026 10:31:08 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lWcP3387171;
	Wed, 5 Aug 2026 10:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SlVt/G
	t4BthsrjqFz0nrv3ocRpvVezu608M8w7ykBfE=; b=KPJIl54p60CIeQge93spc1
	GJqLoIg6HH4jglijGHVheBwJrqQHUyXmnWyr0fpp+9gGJoirKXVNuIWgIL/6O+3H
	loPFlfd2klQarhbLeMaylBuepbjjaZoFkfM3/E50lYeo4Q4fTfVtDWoPe33oWS2v
	Nj9dl8LkcVnZIqLxmG+yCy6rZemrphXxczOX94S3GyR2xp+9jaWYiZUGsZbCuVvn
	lylgM6+D1ft+u3mOrna5MYWh4Iz3IM5GZFRA5dOe3dObTRX5pXxZCK2HhpqiJew+
	ejIzexwHrMjfjTPQJDB4mybLP4o5nhcsXHXPtIGpyFrERiUnJBtOhlsdiJ8uERmg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h52jkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 10:31:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AQHb4021625;
	Wed, 5 Aug 2026 10:30:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k63qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 10:30:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675AUuZF15597982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 10:30:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A546C2004D;
	Wed,  5 Aug 2026 10:30:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4713720040;
	Wed,  5 Aug 2026 10:30:53 +0000 (GMT)
Received: from [9.39.28.63] (unknown [9.39.28.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 10:30:52 +0000 (GMT)
Message-ID: <3010bbe1-844f-4513-9941-f4e92e581769@linux.ibm.com>
Date: Wed, 5 Aug 2026 16:00:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] crash_dump: Disallow writing to dm-crypt
 configfs during kexec_file_load syscall
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, Coiby Xu <coxu@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-4-coiby.xu@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260729033654.311541-4-coiby.xu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4MSBTYWx0ZWRfX7gzgYwdN90ki
 kLqlAfUI8aer0EJ/eHHL+PKTW8Yl4Z67YF9RjhQVsy0/P0QfL/kYk9qafETNuETh7F2m3DduUeM
 ImeOSITGkdSsJhcx+oQpL2oHnprpOnE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4MSBTYWx0ZWRfX0zWEHJKQId/R
 u17Y0qdhwVdpmtHs+PVQAot52URf5QOr8nIHyfGw2Q4XqVZeIOIIpd29qR0cUDexB5yldJdvD6S
 bMmH7meEi8pytTX9+Wj3ii0RPdGskWKi5vxO7YALWxr9DgUc7zij0AoqQHcCqbGL3pEkFFK6MZn
 EzGidPqo76uC3jjmOUPYhLs9qBNoc4Y1Gtuxm8m75CB1pseFw2Ijyjg0y1ihgD47/SeiDta7vsv
 5RALeL2JHGtbPmpjmK6YLdV/e5hVVesxQr1C2xYCB8+RFZHCFELwUYDunswjzGgWoqSnF4l2UZv
 jiNbLn2HGrFQB2SJcoL8TQkdlQXF+fK/+QWAzWXE/41xsy+RP8OeqYhfw8nMtAqPcpxUVWsYHLJ
 JxftE52vuc6M+E5mS0VjOd52+DpWeJZYr1P6s3xpT7obJJDpCNmbRvsSUUF9mx6oVAi8un0Nn2x
 NoOk3Fe0xYZxXG+MZww==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a7310e4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=qB5L7vjBzVN11irf6e0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bHvENgRU6N_wDshmNENwktW58PeysO_u
X-Proofpoint-GUID: -q2g72MqoFLV_YVMmIpVM7QksTSMsIIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_033106_786607_C062DCF2 
X-CRM114-Status: GOOD (  27.51  )
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
> If writing to the configfs group happens concurrently during
> kexec_file_load syscall, it may lead to the following issues,
>    - buffer overflow if dm-crypt keys are added after allocation
>    - stale total_keys if dm-crypt keys are removed during iteration
>    - keys_header will not be freed if config/crash_dm_crypt_key/reuse is
>      set true
>
> So hold config_keys_subsys.su_mutex for the entire sequence during the
> kexec_file_load syscall to ensure a consistent snapshot.
>
> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>   kernel/crash_dump_dm_crypt.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 4335b6cb1fc4..d2e66c6fe6f3 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -293,6 +293,7 @@ static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
>   static ssize_t config_keys_reuse_store(struct config_item *item,
>   					   const char *page, size_t count)
>   {
> +	struct mutex *lock;
>   	bool val;
>   	int r;
>   
> @@ -302,8 +303,12 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
>   		return -EINVAL;
>   	}
>   
> +	lock = &to_config_group(item)->cg_subsys->su_mutex;
> +	mutex_lock(lock);

Is this lock only protecting against races between key reuse and 
kexec_file_load(),
or does it also handle the case where a new key is added during key reuse or
kexec_file_load() is running?

If it is only intended to protect key reuse versus kexec_file_load(), 
why can't we use
the kexec lock instead?

The reason I'm asking is that, in upcoming patches, the key reuse path 
accesses
kexec_crash_image properties and the crash reserved region directly. 
Doing so
without taking the kexec lock (using kexec_trylock()) could lead to race 
conditions.

- Sourabh Jain
> +
> +	r = -EINVAL;
>   	if (kstrtobool(page, &val) || !val)
> -		return -EINVAL;
> +		goto unlock;

The jump above skips setting count, causing the function to return count 
instead of -EINVAL.
Is this really intended?

>   
>   	if (is_dm_key_reused) {
>   		pr_info("Already got dm-crypt keys, please continue with kexec_file_load syscall\n");
> @@ -311,11 +316,15 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
>   		r = get_keys_from_kdump_reserved_memory();
>   		if (r) {
>   			pr_warn("Failed to get dm-crypt keys from reserved memory\n");
> -			return r;
> +			goto unlock;
>   		}
>   		is_dm_key_reused = true;
>   	}
>   
> +	r = count;
> +
> +unlock:
> +	mutex_unlock(lock);
>   	return count;
>   }
>   
> @@ -421,6 +430,8 @@ static int build_keys_header(void)
>   	return 0;
>   }
>   
> +static bool mutex_acquired;
> +
>   int crash_load_dm_crypt_keys(struct kimage *image)
>   {
>   	struct kexec_buf kbuf = {
> @@ -432,6 +443,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   	};
>   	int r = 0;
>   
> +	mutex_lock(&config_keys_subsys.su_mutex);
> +	mutex_acquired = true;
> +
>   	if (key_count <= 0) {
>   		kexec_dprintk("No dm-crypt keys\n");
>   		return 0;
> @@ -481,6 +495,11 @@ void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>   		kfree_sensitive(keys_header);
>   		keys_header = NULL;
>   	}
> +
> +	if (mutex_acquired) {
> +		mutex_unlock(&config_keys_subsys.su_mutex);
> +		mutex_acquired = false;
> +	}
>   }
>   
>   static int __init configfs_dmcrypt_keys_init(void)



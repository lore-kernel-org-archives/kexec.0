Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23477C61DD7
	for <kexec@archiver.kernel.org>; Sat, 29 Aug 2026 07:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kgp9E9Eym2dL0hHX7aAFcoVnuORC81499j8SgEBGJO4=; b=gDZGqr5SgcSHzU5hjMDmDSrkWH
	QHfArFElZQodPYA093BTe3JIS8pe84UFuFbRsYF1673Uov1Nzng9vMA+NUzqeqdbNx1qc7eZeY9+r
	7M4DQJHpKb/iO32HBodzl/vJ4Twxo3rgE1hV3QyzqfKGNKCVK7hFYjmr393eEgR570c0yJd5oQkLo
	ETj0Fa0bvbUDfaitA2yzClra1tLx/Q8HxohQnTGdMMvI5d9aTr3w3NdqEICG9DTIco2uU5TCYZFwQ
	5KGwD/dcJhoBgwcoiFXtQuxSHPSwfFXNQ8lFKkHJFK8M+DPldUXabJbkTk72K2w1s8OyNt8Jet537
	dHbc1E0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0D5m-00000006o7G-0a9C;
	Sat, 29 Aug 2026 07:03:06 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0D5j-00000006o6o-1Z6p
	for kexec@lists.infradead.org;
	Sat, 29 Aug 2026 07:03:04 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67T5VgLl079981;
	Sat, 29 Aug 2026 07:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kgp9E9
	Eym2dL0hHX7aAFcoVnuORC81499j8SgEBGJO4=; b=KPQTOVKEyBjNIuhlZG2Gvm
	txGyT3n3SFiaoW1a9b/m/oeClp8xTdvmRbS0vs0nh8RTLEL/Pk0tgOyErEw4pbup
	WbPEVW/mvmO/IPkeFq28rzU1AR5S5/2rRiw8aZ4cE3BY9almEPlJeEYr0SCjIkAs
	UUh3qJYqKwb996hy5uCUjxNuD7CvYwa1q9cJQtOhVwBt7gGtTmyiOGpa+JxIAwc/
	DKOl858HJ1jVN6Fv37gWok7b7vc0s+ejpd8EE3U7LFPZXMMgg/+JUW3nRiFag9k7
	7xzJo52YlHCHDTy7xe6vaGBlBn3qgWmavBgYOVK54AMQPQ0D2VKqdYF2drMwZ78Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2srkag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Aug 2026 07:02:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67T6uHgC015350;
	Sat, 29 Aug 2026 07:02:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rah263b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Aug 2026 07:02:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67T72qNX25625156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Aug 2026 07:02:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B007320043;
	Sat, 29 Aug 2026 07:02:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FF0320040;
	Sat, 29 Aug 2026 07:02:48 +0000 (GMT)
Received: from [9.67.168.106] (unknown [9.67.168.106])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 29 Aug 2026 07:02:48 +0000 (GMT)
Message-ID: <86f3b10d-6fc2-4dbc-a20b-5d2365601be2@linux.ibm.com>
Date: Sat, 29 Aug 2026 12:32:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] crash_dump: Disallow writing to dm-crypt configfs
 during kexec_file_load syscall
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
 <20260828084900.1496839-3-coiby.xu@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260828084900.1496839-3-coiby.xu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a92841f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=qB5L7vjBzVN11irf6e0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA1OSBTYWx0ZWRfXwF/upvELz7dE
 A8dF5CBEGApjFdJDyFmfEx1TQFECq+NMACuDUqcNX4w4A6O7+LduNGHLiN3hw+i9s7o9SBlDNnA
 czipNkNeWJZGfM4TVzysZhYh6Tsjzzs=
X-Proofpoint-ORIG-GUID: ZvVGOsM6rQs9pyie3E9vGxNwjDMWbLrX
X-Proofpoint-GUID: HEeFwjPPEteVzn4Clz4tAvemJvGVmajp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA1OSBTYWx0ZWRfX0skYbYZFDSlU
 NrZeiRXcLEf4ZpqgPAabd3pab3rd4l8oAX3S0YWYAmvEUjqFiNmT/9q5vCQ3G+W2cNlCbvc/Wxa
 7gEvcFdftJBPPhLyM7Ls6jdbDh4+8+xHihAJv9JAJDedX76bwTdeKPKzoi68vnofyhIkQ0dPFsP
 ASFomG94tBKsjbpSCaJqjOokAI7LcKQc2msFsgjpXNuWIseim2g/94SoKcUn9sOn47kHg5dHNLw
 my4/4UHQa/bEE89W651H0VFAM5fM3wkDYFRlGT9F6JKC8Qcu3PoYXHfcCNUzBZpMm7rIv2umT6i
 KU10kgJhPs8wOKNT4jfYyNqofnWpB8M22adOqa6yNhTbW0RM+C8Ojh0YKCCrZx8BVf1YQvWlJ6D
 LYwDD51YKDmyJYUlK9NldzYyBdGt7YuoAnXV2VuZOy5LO5ZSwQEJCg65dFnjaPOyzS3Yiv25Y4p
 3ncdjR3Qrje6iCbcKxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608290059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260829_000303_560208_A703C079 
X-CRM114-Status: GOOD (  25.55  )
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



On 28/08/26 14:18, Coiby Xu wrote:
> If writing to the configfs group happens concurrently during
> kexec_file_load syscall, it may lead to the following issues,
>    - buffer overflow if dm-crypt keys are added after allocation
>    - stale total_keys if dm-crypt keys are removed during iteration
>    - keys_header will not be freed if config/crash_dm_crypt_key/reuse is
>      set true
>
> So hold config_keys_subsys.su_mutex for the entire sequence during the
> kexec_file_load syscall to ensure a consistent snapshot. To have serial
> access to config/crash_dm_crypt_key/reuse, use the kexec lock as we also
> need to access kexec_crash_image serially.
>
> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>   kernel/crash_dump_dm_crypt.c | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 4335b6cb1fc4..026c7de4ad85 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -7,6 +7,7 @@
>   #include <linux/configfs.h>
>   #include <linux/module.h>
>   #include <linux/sysfs.h>
> +#include "kexec_internal.h"
>   
>   #define KEY_NUM_MAX 128	/* maximum dm crypt keys */
>   #define KEY_SIZE_MAX 256	/* maximum dm crypt key size */
> @@ -296,14 +297,20 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
>   	bool val;
>   	int r;
>   
> +	if (!kexec_trylock()) {
> +		r = -EBUSY;
> +		goto unlock;


Are we unlocking a lock that we didn't acquire? How about returning 
-EBUSY directly instead?


> +	}
> +
> +	r = -EINVAL;
>   	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
>   		kexec_dprintk(
>   			"dm-crypt keys haven't be saved to crash-reserved memory\n");
> -		return -EINVAL;
> +		goto unlock;
>   	}
>   
>   	if (kstrtobool(page, &val) || !val)
> -		return -EINVAL;
> +		goto unlock;
>   
>   	if (is_dm_key_reused) {
>   		pr_info("Already got dm-crypt keys, please continue with kexec_file_load syscall\n");
> @@ -311,12 +318,15 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
>   		r = get_keys_from_kdump_reserved_memory();
>   		if (r) {
>   			pr_warn("Failed to get dm-crypt keys from reserved memory\n");
> -			return r;
> +			goto unlock;
>   		}
>   		is_dm_key_reused = true;
[...]
>   	}
>   
> -	return count;
> +	r = count;
> +unlock:
> +	kexec_unlock();
> +	return r;
>   }
>   
>   CONFIGFS_ATTR(config_keys_, reuse);
> @@ -421,6 +431,8 @@ static int build_keys_header(void)
>   	return 0;
>   }
>   
> +static bool mutex_acquired;
> +
>   int crash_load_dm_crypt_keys(struct kimage *image)
>   {
>   	struct kexec_buf kbuf = {
> @@ -432,6 +444,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   	};
>   	int r = 0;
>   
> +	mutex_lock(&config_keys_subsys.su_mutex);
> +	mutex_acquired = true;
> +
>   	if (key_count <= 0) {
>   		kexec_dprintk("No dm-crypt keys\n");
>   		return 0;
> @@ -481,6 +496,11 @@ void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)

I explored the kexec_file_load syscall entry path and noticed
that there is a path where the call to
kimage_file_post_load_cleanup() can be skipped.

For example, if kexec_file_load is called and everything goes well
but kexec_post_load() fails, we skip
kimage_file_post_load_cleanup(), and consequently
kexec_file_post_load_cleanup_dm_crypt() as well.

If that happens, the config_keys_subsys.su_mutex remains locked,
which could cause problems with the next kexec load, right?

- Sourabh Jain

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



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4D4CD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R7lvIC0bxt4661XQeHUXYJKGM0xgbkG8N/Q+Sev8WqM=; b=jbqSs2LpNNT4ydtfNvhr0FWz0g
	pjBO9zvzz0B4BZ+MJOb7tA5prTnVLn/gIi7VC0cOCkQh3zUzd/x8V6Er8Wf+W5QtL2GSU56jxnG9K
	5zdizTQL4gZYNDcqE01p1T3LYfAwF536TdtzbdSqe+d0b8SO146btXQ6I5V6VNnJxY63jBj2tet8T
	kPbrEX7e6w1+J3xjRzqiorYWo3k9xolkjJKxYpWhiBV9SDBb69KzE/C+2dizKoqkXq+h5Rzm6rslg
	LolNh0jhwUwrXQeDamlsbi545FrROuPLmEgVogRQmdYFpHnaQtUuXI5Yl1NCnEc6A3Mn2UPmdv/6l
	WC8B6Otw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKep6-00000001SL3-3jIW;
	Wed, 06 May 2026 16:10:08 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKep5-00000001SKZ-40I9
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 16:10:08 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6463ISFI1381065;
	Wed, 6 May 2026 16:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R7lvIC
	0bxt4661XQeHUXYJKGM0xgbkG8N/Q+Sev8WqM=; b=XV8NvTYFwraDAMzouWWnXu
	uxcROIYy3qbUaj22IOd/JsM6E7ZEjJBKarCetkgwxLZEwxhh1GDA9LqV0jvXoUgG
	FbhSgtflGf0lVZv5vunXEfL5qy8JhL5EkhU+Zvdf/THBa4iEQAfTw4qkTm39QB5+
	yAZGifrUTxNouanPfBzTTlrLkplo0MyB+aR5f3hNIWW4pUUDIUqJy4IG2BK92YdE
	dwUk3CZPlh/OhCEtdBJe4/5F1MP98HVNqDsnM0SEnwxYfEBPt2l0NKgbC4y/micl
	ikBYKsW7FeZHM5WNAfwYBl+xpJNBI9nLiQUkSvwYlZABafFoqgAgfU5UJPcfvXgQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4sj9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 16:09:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646G9Ye4023993;
	Wed, 6 May 2026 16:09:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h6wuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 16:09:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646G9g3R12976486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 16:09:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A9642004B;
	Wed,  6 May 2026 16:09:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA57220040;
	Wed,  6 May 2026 16:09:37 +0000 (GMT)
Received: from [9.124.208.31] (unknown [9.124.208.31])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 16:09:37 +0000 (GMT)
Message-ID: <5af6fd0b-0eca-4089-b76c-45dcc4bf01ed@linux.ibm.com>
Date: Wed, 6 May 2026 21:39:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] crash_dump: Disallow
 configfs/crash_dm_crypt_key/reuse if CONFIG_CRASH_HOTPLUG enabled
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Coiby Xu <coxu@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
 <20260501234342.2518281-9-coiby.xu@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260501234342.2518281-9-coiby.xu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE1OCBTYWx0ZWRfX9vEydiAyv6/h
 bIdaqRP0cDBpnu/Q4rBAsvqMtRuWQM8COohpwlH/id7D0mmgYGrAwzbpuDv7pnjpxnp9l7XNAyn
 9I7pJYEK5KpDXo55qI9mDl7w3h4xO+ic3AryzUH0+pcHwDRiYzD/fgnB57Gqp0lW3VfdkceyXJH
 Rr+Im1H98NPYD4FOq54UUVRg+1Hc0gKR2zt3kmvEqSYcOO4t4cTnsIBLFpJXo18l+pzUizNMf6t
 OurTJh2WPyLq/oGuoWdWL5FZQtSIZz9m8zWI34MwrN1Db0njffOfRo9xe0QibPfUDiIjfLziG3I
 0of6At05X0YaH+UX5kSoAlWfJbjLbQuhGcfIzI7cqiqMKMh6pqnU17ufOUhwupgnrHsPKjz0Rm5
 ODAB3+u33Z9aevoUvPlJGNzM2fmPU7Kn8gWAq3nvmvNhZZi+fMWVD9DJ4nPVTF8EXkH7BOBBHAL
 5TW45vPLMfsxjKS1p9A==
X-Proofpoint-ORIG-GUID: M9zjn8nAJ53d_-FP2PjULB3AD-cpGVm6
X-Proofpoint-GUID: nDB7-9AbbLcAw4vmxN5TmVz8ATWXCOJc
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fb67c9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=FAMLr4mYtRK9mEqtjuQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060158
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_091008_005610_4C09220C 
X-CRM114-Status: GOOD (  27.08  )
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
> If CONFIG_CRASH_HOTPLUG is enabled, dm-crypt keys saved to reserved
> memory will be took care of automatically. Thus it doesn't make sense
> to use configfs/crash_dm_crypt_key/reuse. Reserving
> image->dm_crypt_keys_addr is also unnecessary. Currently x86_64 and
> ppc64le have implemented CONFIG_CRASH_HOTPLUG feature.
>
> Also update the doc accordingly. Note two doc issues are fixed as well.
>
> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>   Documentation/admin-guide/kdump/kdump.rst |  9 ++++++---
>   kernel/crash_dump_dm_crypt.c              | 14 +++++++++++---
>   2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 7587caadbae1..73f2e9500c60 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -577,9 +577,10 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
>   
>   1. Tell the first kernel what logon keys are needed to unlock the disk volumes,
>       # Add key #1
> -    mkdir /sys/kernel/config/crash_dm_crypt_keys/7d26b7b4-e342-4d2d-b660-7426b0996720
> +    VOL1_UUID=7d26b7b4-e342-4d2d-b660-7426b0996720
> +    mkdir /sys/kernel/config/crash_dm_crypt_keys/$VOL1_UUID
>       # Add key #1's description
> -    echo cryptsetup:7d26b7b4-e342-4d2d-b660-7426b0996720 > /sys/kernel/config/crash_dm_crypt_keys/description
> +    echo cryptsetup:$VOL1_UUID > /sys/kernel/config/crash_dm_crypt_keys/$VOL1_UUID/description
>   
>       # how many keys do we have now?
>       cat /sys/kernel/config/crash_dm_crypt_keys/count
> @@ -593,7 +594,9 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
>   
>       # To support CPU/memory hot-plugging, reuse keys already saved to reserved
>       # memory
> -    echo true > /sys/kernel/config/crash_dm_crypt_key/reuse
> +    # Note if CONFIG_CRASH_HOTPLUG is enabled, this API is totally unnecessary
> +    # thus will be disabled.
> +    echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
>   
>   2. Load the dump-capture kernel
>   
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 36e51807d94f..7a7cae17f578 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -304,6 +304,11 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
>   	bool val;
>   	int r;
>   
> +	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
> +		pr_info("CONFIG_CRASH_HOTPLUG already enabled");
> +		return -EINVAL;
> +	}
> +

Deciding this solely at compile time can create issues. For example, the 
kernel
may be built with CONFIG_CRASH_HOTPLUG, but if kexec tool loads the kdump
kernel using the kexec_load system call without hotplug support, it can
cause problems. It is rare but possible.

How about this:

#ifdef CONFIG_CRASH_HOTPLUG
     if (kexec_crash_image->hotplug_support) {
pr_info("crash image is loaded with hotplug support\n");return -EINVAL;
     }
#endif

This code should be placed after validating kexec_crash_image.


- Sourabh Jain

>   	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
>   		pr_info("dm-crypt keys haven't be saved to crash-reserved memory\n");
>   		return -EINVAL;
> @@ -486,15 +491,18 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>   {
>   	/*
> -	 * For CPU/memory hot-plugging, the kdump image will be reloaded. Prevent
> -	 * keys_header from being cleaned up during unloading when
> -	 * is_dm_key_reused=true
> +	 * For CPU/memory hot-plugging without CONFIG_CRASH_HOTPLUG, the whole kdump
> +	 * image will be reloaded. Prevent keys_header from being cleaned up during
> +	 * unloading when is_dm_key_reused=true
>   	 */
>   	if (!is_dm_key_reused) {
>   		kfree_sensitive(keys_header);
>   		keys_header = NULL;
>   	}
>   
> +	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG))
> +		image->dm_crypt_keys_addr = 0;
> +
>   	if (mutex_is_locked(&config_keys_subsys.su_mutex))
>   		mutex_unlock(&config_keys_subsys.su_mutex);
>   }



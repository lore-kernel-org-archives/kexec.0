Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC6DCD3436
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 12:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y7SinFsGEyOHDRVj+UzeYfKWeHPlpAClMeAC0iTYdU4=; b=Pqp/+Q0QIdniMU/lMaTT+Hch9U
	+5pV5BN3mXsStU07tPztTFoUjDt6QJUJ+el3O9dTLmMal0iVDK/lHsII/7f/QHhn3Ce2q3w2rk4x+
	PDI5X8s1gJpt0Pfebqpqrt2DdmAMj5m9GTGi1tpGGJmd6cipLK7MQYVT5rh5WMn0ArXzYYTwLAUdJ
	djWd5Hsub3snuhNOoJPm+keS4bl/huRAS9hVObLyQb6tgiyPoyEN9QtvewlgzEDEiNnhEwt4o7+c0
	jkKckT14TyE0TMWSv1oUSgKdbzKMnqgKlyQXoMEXpOvLXMrQWsBeXMxJUmlIrkoNOWLo1o22ORSoj
	DvkPD97A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKbMz-00000000l0K-24kh;
	Wed, 06 May 2026 12:28:53 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKbMy-00000000kyJ-0FV8
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 12:28:52 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645MtRdY989845;
	Wed, 6 May 2026 12:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y7SinF
	sGEyOHDRVj+UzeYfKWeHPlpAClMeAC0iTYdU4=; b=hloIuNOLsjyHB7rvmIYVrI
	AXsno1QYhxN5ncob2lKExWZkB7NYi4nVnkp6gA3eIzl1u8wZ+nhrpm0wiYSKLfqw
	RkOL9vvdjz5CRCoKzfesJEjtYFPuhwQ3iJ92smSF2Vku2fiYqCByIjuReMKnuR3K
	HgwBoI/d/uFKIrhBUj2t4thH/3V0sbuc05YZMu1LlT/sXTlYHYouqlx1napDWlQa
	VTwz7J3mqN2LXd0gckBpReJmmrILMb7h5N3UIcYziWTCgZ6yIygtu2JSxiKXv7uP
	P4YzIKsX5dzwU3e+G/l0WwlQ7U9EaDLBRfwukhoZwho2Q7qkdV0vjjljEDn2zUzA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6fxnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 12:28:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646COXUW020236;
	Wed, 6 May 2026 12:28:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjx5cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 12:28:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646CSaOm54985164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 12:28:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F07620040;
	Wed,  6 May 2026 12:28:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F0E820043;
	Wed,  6 May 2026 12:28:33 +0000 (GMT)
Received: from [9.124.208.31] (unknown [9.124.208.31])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 12:28:32 +0000 (GMT)
Message-ID: <fdb25929-2b47-4f92-b6a9-8caea1642fff@linux.ibm.com>
Date: Wed, 6 May 2026 17:58:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] crash_dump: Fix potential double free and UAF of
 keys_header
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>, Coiby Xu <coxu@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
 <20260501234342.2518281-3-coiby.xu@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260501234342.2518281-3-coiby.xu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fb33f7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=I70h1RQKpaBsh-Z0TpcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JD-CYPXAfm4PAwpWfO_lDTqj4hEgOzFE
X-Proofpoint-GUID: f0WmOEGzJnn026jZ1vvX50ogxj61sIfO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDExOSBTYWx0ZWRfX/vz9+dp3k02/
 uKI/rSdv55G9Lt4fZYTbzbr4LPYRe5FbyVlQal60l5fsYdhmIqusTAgFXTCFdBD7mbThP+T93AB
 eGVBVKRy4+uCO8GIPqKRgyE4voUapDx3QWosBSmy4l0CavIHr6t+MneeC+yvMTSv1pVL1TffTcy
 Vt0+5OQ0nYu1L6uVneGKAimTyfbBJjuW6kTT/iemUruiuSw/k9WAnh+nrEIYIuv08PHJ/PvCgvQ
 amR+hzEyQpTAxal3cEgbC0xbaBgdwz1lVFZaEtYGnf07tG4PTDSj9ILYkwD2Yeq3647W10BLkpa
 hgDGw+JeBGwsiLFtPAIPKrG+j/0ug2b/w+gm/fC+clhZ+EUbLlxw1Qk8BS6/vZ1+sRjwx04yHKf
 EWlsAanewiTYWyO774sK7TBTTqctP09lMLQN4cebc0H2KAIMI+VIsOZHNaBNYSyNAuYFrQSpNF/
 5/kvD5Jooc+0iu9u9vQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_052852_225756_F6AA1653 
X-CRM114-Status: GOOD (  36.55  )
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

Hello Coiby,

On 02/05/26 05:13, Coiby Xu wrote:
> If kexec_add_buffer somehow fails, keys_header will be freed. Depending
> on /sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
> following two problems if the kexec_file_load syscall is called again,
>    1. Double free of keys_header if reuse=false
>    2. UAF of keys_header if reuse=true
>
> To address these problems and also make it easier to reason about the
> code, keep two invariants,
>    1. keys_header will always be freed at the end of kexec_file_load
>       syscall except during kdump image unloading for CPU/memory
>       hot-plugging support
>    2. There will always be valid keys_header if reuse=true
>
> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>   include/linux/kexec.h        |  6 ++++
>   kernel/crash_dump_dm_crypt.c | 65 ++++++++++++++++++++++++++----------
>   kernel/kexec_file.c          |  2 ++
>   3 files changed, 56 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 8a22bc9b8c6c..91256d7ff434 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -552,6 +552,12 @@ void set_kexec_sig_enforced(void);
>   static inline void set_kexec_sig_enforced(void) {}
>   #endif
>   
> +#ifdef CONFIG_CRASH_DM_CRYPT
> +void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image);
> +#else
> +static inline void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image) {}
> +#endif
> +
>   #endif /* !defined(__ASSEBMLY__) */
>   
>   #endif /* LINUX_KEXEC_H */
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index eac4f436a8d4..4d8a3331bbe7 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -84,18 +84,25 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
>   	return r;
>   }
>   
> -static void get_keys_from_kdump_reserved_memory(void)
> +static int get_keys_from_kdump_reserved_memory(void)
>   {
>   	struct keys_header *keys_header_loaded;
> +	size_t keys_header_size;
>   
> -	arch_kexec_unprotect_crashkres();
> +	keys_header_size = get_keys_header_size(key_count);
> +	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
> +	if (!keys_header)
> +		return -ENOMEM;
>   
> +	arch_kexec_unprotect_crashkres();
>   	keys_header_loaded = kmap_local_page(pfn_to_page(
>   		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));

Accessing kexec_crash_image without holding the kexec lock could lead to
undefined behavior.

I think this section of code should be called by holding kexec lock.


>   
> -	memcpy(keys_header, keys_header_loaded, get_keys_header_size(key_count));
> +	memcpy(keys_header, keys_header_loaded, keys_header_size);
>   	kunmap_local(keys_header_loaded);
>   	arch_kexec_protect_crashkres();
> +
> +	return 0;
>   }
>   
>   static int restore_dm_crypt_keys_to_thread_keyring(void)
> @@ -283,17 +290,28 @@ static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
>   static ssize_t config_keys_reuse_store(struct config_item *item,
>   					   const char *page, size_t count)
>   {
> +	bool val;
> +	int r;
> +
>   	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {

The above check should be performed after acquiring the kexec lock.



>   		kexec_dprintk(
>   			"dm-crypt keys haven't be saved to crash-reserved memory\n");
>   		return -EINVAL;
>   	}
>   
> -	if (kstrtobool(page, &is_dm_key_reused))
> +	if (kstrtobool(page, &val) || !val)
>   		return -EINVAL;

Why can’t we allow the user to set is_dm_key_reused = false and free the
key_header? That way, the next kdump kernel load will recreate the 
key_header.

For example, a user may add more keys and want the new keys to be included
in the kdump image from next kdump kernel load.


>   
> -	if (is_dm_key_reused)
> -		get_keys_from_kdump_reserved_memory();
> +	if (is_dm_key_reused) {
> +		pr_info("Already got dm-crypt keys, please continue with kexec_file_load syscall\n");
> +	} else {
> +		r = get_keys_from_kdump_reserved_memory();
> +		if (r) {
> +			pr_warn("Failed to get dm-crypt keys from reserved memory\n");
> +			return r;
> +		}
> +		is_dm_key_reused = true;
> +	}
>   
>   	return count;
>   }
> @@ -366,9 +384,6 @@ static int build_keys_header(void)
>   	struct config_key *key;
>   	int i, r;
>   
> -	if (keys_header != NULL)
> -		kvfree(keys_header);
> -
>   	keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
>   	if (!keys_header)
>   		return -ENOMEM;
> @@ -412,7 +427,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   		.top_down = false,
>   		.random = true,
>   	};
> -	int r;
> +	int r = 0;
>   
>   
>   	if (key_count <= 0) {
> @@ -421,14 +436,15 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   	}
>   
>   	if (!is_dm_key_reused) {
> -		image->dm_crypt_keys_addr = 0;
>   		r = build_keys_header();
> -		if (r) {
> -			pr_err("Failed to build dm-crypt keys header, ret=%d\n", r);
> -			return r;
> -		}
> +		if (r)
> +			goto out;
>   	}
>   
> +	/*
> +	 * keys_header will be copied to reserver memory later and then be
> +	 * cleaned up at the end of kexec_file_load syscall
> +	 */
>   	kbuf.buffer = keys_header;
>   	kbuf.bufsz = get_keys_header_size(key_count);
>   
> @@ -438,18 +454,33 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   	r = kexec_add_buffer(&kbuf);
>   	if (r) {
>   		pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
> -		kvfree((void *)kbuf.buffer);
> -		return r;
> +		goto out;
>   	}
> +
>   	image->dm_crypt_keys_addr = kbuf.mem;
>   	image->dm_crypt_keys_sz = kbuf.bufsz;
>   	kexec_dprintk(
>   		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
>   		kbuf.bufsz, kbuf.memsz);
>   
> +out:
> +	is_dm_key_reused = false;
>   	return r;
>   }
>   
> +void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
> +{
> +	/*
> +	 * For CPU/memory hot-plugging, the kdump image will be reloaded. Prevent
> +	 * keys_header from being cleaned up during unloading when
> +	 * is_dm_key_reused=true
> +	 */
> +	if (!is_dm_key_reused) {
> +		kfree_sensitive(keys_header);
> +		keys_header = NULL;

Since crash_load_dm_crypt_keys() sets is_dm_key_reused = false, 
keys_header will
always be released here, right? Then why is the above free under an if 
condition?

IIUC, for the case where CONFIG_CRASH_HOTPLUG is not enabled, this is 
how key
restore works:

After loading the kdump kernel for the first time, the state of the 
variables is:

is_dm_key_reused = false
keys_header = NULL

For example, if 2 CPUs are hot-removed and kdump is reloaded twice:

Then the sequence of operations needed to ensure the loaded keys can be 
reused is:

Udev rule triggered on the 1st CPU hotplug:
echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
Restore the key header from the reserved area
Reload the kdump service/kernel

Udev rule triggered on the 2nd CPU hotplug:
echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
Restore the key header from the reserved area
Reload the kdump service/kernel

What I don’t understand is the need to restore the key header from 
crashkernel
memory for every hotplug operation.


- Sourabh Jain

> +	}
> +}
> +
>   static int __init configfs_dmcrypt_keys_init(void)
>   {
>   	int ret;
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 2bfbb2d144e6..0421f1e89791 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -139,6 +139,8 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>   	kfree(image->image_loader_data);
>   	image->image_loader_data = NULL;
>   
> +	kexec_file_post_load_cleanup_dm_crypt(image);
> +
>   	kexec_file_dbg_print = false;
>   }
>   



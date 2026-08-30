Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B2BC61DD9
	for <kexec@archiver.kernel.org>; Sun, 30 Aug 2026 07:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lu+vAGYY1/IhP+5rOWy0tWICWs2JcD4m4308r2/zK2o=; b=17IZtxM6aBwKuR+zFLcU4dT3A5
	U8RQVhYe653222EsNPKGNrgnJYpmc1mYg6F+gzWl556JdNd4xkyJ3PrEzm2kVOIQVDZpyYQF8Ts3U
	0aa/7klSMEELI2haJ8Oa21WJRlxe+GBxq2roI1aHiHqFr5/PmDlddn6Nt0jqoMdC6JfDUyIO9+E47
	OdAUJgrjt2euujm5y+2vIGIzUJnUSlO/efbonHarMQy2UAT0hH/9f2NioVDlXChhdlMVn7/TKhnDI
	SSIrcs4wEwKimOHHa0u+XHZb+q8ZgSLIL+PqrlzFGU3C381tcxoqkXbboLGPKvI/+lCCYEJ73xzKD
	jRlopxuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0Zdx-00000007XH2-0e3j;
	Sun, 30 Aug 2026 07:07:53 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0Zdr-00000007XGh-27HY
	for kexec@lists.infradead.org;
	Sun, 30 Aug 2026 07:07:51 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67U620pm939289;
	Sun, 30 Aug 2026 07:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lu+vAG
	YY1/IhP+5rOWy0tWICWs2JcD4m4308r2/zK2o=; b=gZ77KADIUKZZBJPn+hpL2X
	J5p+a2Yh2YrabfI6wWMNx+/uc5+mTNhuWKgM9Cl6Y+GxyjA9/679OziIV8A9ySQp
	uYLCsfW3R+nR7xWZRNYB3PCFFby+wgwkTpV23kzNt2LGZ7G5rc7NxUUcyCmko38G
	WEar68MhYD2m2NvHzyanqgQwQlWU8ZFVubsdygA1V6x717YJuU69yZ4SRIOKm4Ri
	G2JNzais0fbztoGxWDd2wV8J9DgAiJF0SHRGmvVhh/RbPX6p8qs9V2rk8t+pYKF8
	dqUQurTtpkK3O1hxEk+pUGeEupmKFfdULWqGsRoKL7bmViFWCC+AACWaWkqUc0dw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3qusr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Aug 2026 07:07:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67U6uKR3032374;
	Sun, 30 Aug 2026 07:07:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq0u2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Aug 2026 07:07:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67U77cQ940894764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Aug 2026 07:07:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC83420043;
	Sun, 30 Aug 2026 07:07:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC11E20040;
	Sun, 30 Aug 2026 07:07:33 +0000 (GMT)
Received: from [9.67.21.115] (unknown [9.67.21.115])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 30 Aug 2026 07:07:33 +0000 (GMT)
Message-ID: <30053e95-1f02-485c-9e92-19e688c5ed0c@linux.ibm.com>
Date: Sun, 30 Aug 2026 12:37:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] crash_dump: Fix potential double free and UAF of
 keys_header
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
 <20260828084900.1496839-2-coiby.xu@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260828084900.1496839-2-coiby.xu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a93d6bd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=PgKvj6gwfOeylU_sgQsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMwMDA1NyBTYWx0ZWRfX5+S9SAPi87L8
 uqWXTBDPu5/Uay7tQorfpYMcR8rQs5vPk9yCk05FERNrosVyUQQWUmzZL9YadvqPzSTTPNGJibb
 UeKlpKIJ3290uRkPjl8SL3GliANSAB+Qv4jFIlxrsNpV9sU1fZHU5zNxEyhFT1p6iMudRgzKpC9
 L4EE0X6PgnssGLMTaGcAYlnrqmlvE4mlV2+GIys320BJvu9BB4LB8n4tgAjnin9kgBkrTQJDKhV
 AntRdY8UCgjYKyu4I41a5W7Xm/tcNLau/vY+9Pir34crXdmQWUPIWvbfBO/sfaY6FZokeq2liE5
 +uX/+4jdmnKpDQ92ntmqglrCFkKngEF7kYTidCdHtr1umGIstF39brVNIuQ71kDymctxi5DQ/Pa
 gaYS6i5+ajxLHqLbkiXDBNegWsZhT2iKgfmsZ1iEn7cFgkoZRiZbe0ui/wHxHaruC4w3WecA0YI
 q+ZV6N/yhcqafjLtgHQ==
X-Proofpoint-GUID: 2ZTFMqE6aiOzj2NxQ9hjy0kFYkdjPrYB
X-Proofpoint-ORIG-GUID: g_QiJ88hmuN0GxcbNfQkcCA2i0E3jr_h
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMwMDA1NyBTYWx0ZWRfX5rPbDcbe/sAQ
 f3NLIHFj/5TQqZLCO9znWuGi1EW7luLN9TPNmWQTaROb7iWBJ4UWAWQ3oD6wt9FAM9g2qd09kTd
 1W7AQmvybsGg7SW/4gMIzfG2Qah7zSw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-30_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608300057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_000747_564762_7692E93F 
X-CRM114-Status: GOOD (  31.13  )
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


Nit: I feel 2/9 should be the first patch.

The changes on this patch looks good to me. Feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

- Sourabh Jain

On 28/08/26 14:18, Coiby Xu wrote:
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
>   kernel/crash_dump_dm_crypt.c | 66 ++++++++++++++++++++++++++----------
>   kernel/kexec_file.c          |  2 ++
>   3 files changed, 56 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0af8ae4fdd08..0fa8bac04576 100644
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
> index c685497cd470..4335b6cb1fc4 100644
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
> @@ -286,17 +293,28 @@ static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
>   static ssize_t config_keys_reuse_store(struct config_item *item,
>   					   const char *page, size_t count)
>   {
> +	bool val;
> +	int r;
> +
>   	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
>   		kexec_dprintk(
>   			"dm-crypt keys haven't be saved to crash-reserved memory\n");
>   		return -EINVAL;
>   	}
>   
> -	if (kstrtobool(page, &is_dm_key_reused))
> +	if (kstrtobool(page, &val) || !val)
>   		return -EINVAL;
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
> @@ -369,9 +387,6 @@ static int build_keys_header(void)
>   	struct config_key *key;
>   	int i, r;
>   
> -	if (keys_header != NULL)
> -		kvfree(keys_header);
> -
>   	keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
>   	if (!keys_header)
>   		return -ENOMEM;
> @@ -415,8 +430,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   		.top_down = false,
>   		.random = true,
>   	};
> -	int r;
> -
> +	int r = 0;
>   
>   	if (key_count <= 0) {
>   		kexec_dprintk("No dm-crypt keys\n");
> @@ -424,14 +438,15 @@ int crash_load_dm_crypt_keys(struct kimage *image)
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
> @@ -441,18 +456,33 @@ int crash_load_dm_crypt_keys(struct kimage *image)
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
> +	}
> +}
> +
>   static int __init configfs_dmcrypt_keys_init(void)
>   {
>   	int ret;
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 59fb9d71e9d8..062f7e79016d 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -140,6 +140,8 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>   	kfree(image->image_loader_data);
>   	image->image_loader_data = NULL;
>   
> +	kexec_file_post_load_cleanup_dm_crypt(image);
> +
>   	kexec_file_dbg_print = false;
>   }
>   



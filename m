Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2701C61DD3
	for <kexec@archiver.kernel.org>; Mon, 31 Aug 2026 07:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=65FDGHnCiKKtgz8gBgPjyNHG770Wgp2UgN2FNs1zkgg=; b=4ik6DlCtYD9dxOrCHU4jPREL/h
	eJgrg/4IWjxVcPowOkeoODHvwZaHyJQKBlpJszMeIenAJsLToCWDLAZoemRA1n4wLkfbnR4LKCGzu
	Bn7EcOpYdr3pcfzeRtvAHv8IwcmOH5zpFowbLX7F8FOU71HtrlMa8OyndpQLWNKjo+eUhWcb2PViD
	z58FI3wDfXcEhKib8UTmNSlPZtlj1K+0xm06GcA/xRUPkgjawqOJTjXPaBGaZyIWq3CQ3Qg6/QVP2
	HTAtX3UG3JjtQmyRK7/0wQI0jcdGGbtHJudmrRQkgPGW4C2fmasnzSvc/JXCMwY7y+DXP1B1wv/ZA
	O0PSM/Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0wcY-00000008kYU-2iFC;
	Mon, 31 Aug 2026 07:39:58 +0000
Received: from canpmsgout07.his.huawei.com ([113.46.200.222])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0wcQ-00000008kXJ-1YMU
	for kexec@lists.infradead.org;
	Mon, 31 Aug 2026 07:39:53 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=65FDGHnCiKKtgz8gBgPjyNHG770Wgp2UgN2FNs1zkgg=;
	b=s1DdZ87wvVz0jwRB9bhZEceeo0NAqmw4W7sQm09oPj0zjsVwDBp3csQQkkWR3x/Wms/QMzL/w
	JAU+CjAZ4oRfX2TQLOgXNJ8M/S7EJJRxea0Re1FvrFzjCUuCPZQvV2gnwUz/3cpkvRwhh7dfp6C
	1KiIZwLQ7uEAP+6KG/bNyN4=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hYLFr5rxNzLlYL;
	Mon, 31 Aug 2026 15:28:48 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 83F0C4048B;
	Mon, 31 Aug 2026 15:39:37 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 31 Aug 2026 15:39:36 +0800
Message-ID: <76f634e3-9adb-4ae2-b2b0-a7e13a2f93c3@huawei.com>
Date: Mon, 31 Aug 2026 15:39:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] crash_dump: Fix potential double free and UAF of
 keys_header
To: Coiby Xu <coiby.xu@gmail.com>, <kexec@lists.infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Sourabh Jain
	<sourabhjain@linux.ibm.com>, Baoquan He <baoquan.he@linux.dev>, Dave Young
	<ruirui.yang@linux.dev>, Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, open list
	<linux-kernel@vger.kernel.org>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
 <20260828084900.1496839-2-coiby.xu@gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260828084900.1496839-2-coiby.xu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_003951_096945_E947AE95 
X-CRM114-Status: GOOD (  29.83  )
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



在 2026/8/28 16:48, Coiby Xu 写道:
> If kexec_add_buffer somehow fails, keys_header will be freed. Depending
> on /sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
> following two problems if the kexec_file_load syscall is called again,
>   1. Double free of keys_header if reuse=false
>   2. UAF of keys_header if reuse=true
> 
> To address these problems and also make it easier to reason about the
> code, keep two invariants,
>   1. keys_header will always be freed at the end of kexec_file_load
>      syscall except during kdump image unloading for CPU/memory
>      hot-plugging support
>   2. There will always be valid keys_header if reuse=true
> 
> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  include/linux/kexec.h        |  6 ++++
>  kernel/crash_dump_dm_crypt.c | 66 ++++++++++++++++++++++++++----------
>  kernel/kexec_file.c          |  2 ++
>  3 files changed, 56 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0af8ae4fdd08..0fa8bac04576 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -552,6 +552,12 @@ void set_kexec_sig_enforced(void);
>  static inline void set_kexec_sig_enforced(void) {}
>  #endif
>  
> +#ifdef CONFIG_CRASH_DM_CRYPT
> +void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image);
> +#else
> +static inline void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image) {}
> +#endif
> +
>  #endif /* !defined(__ASSEBMLY__) */
>  
>  #endif /* LINUX_KEXEC_H */
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index c685497cd470..4335b6cb1fc4 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -84,18 +84,25 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
>  	return r;
>  }
>  
> -static void get_keys_from_kdump_reserved_memory(void)
> +static int get_keys_from_kdump_reserved_memory(void)
>  {
>  	struct keys_header *keys_header_loaded;
> +	size_t keys_header_size;
>  
> -	arch_kexec_unprotect_crashkres();
> +	keys_header_size = get_keys_header_size(key_count);
> +	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
> +	if (!keys_header)
> +		return -ENOMEM;
>  
> +	arch_kexec_unprotect_crashkres();
>  	keys_header_loaded = kmap_local_page(pfn_to_page(
>  		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
>  
> -	memcpy(keys_header, keys_header_loaded, get_keys_header_size(key_count));
> +	memcpy(keys_header, keys_header_loaded, keys_header_size);
>  	kunmap_local(keys_header_loaded);
>  	arch_kexec_protect_crashkres();
> +
> +	return 0;
>  }
>  
>  static int restore_dm_crypt_keys_to_thread_keyring(void)
> @@ -286,17 +293,28 @@ static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
>  static ssize_t config_keys_reuse_store(struct config_item *item,
>  					   const char *page, size_t count)
>  {
> +	bool val;
> +	int r;
> +
>  	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
>  		kexec_dprintk(
>  			"dm-crypt keys haven't be saved to crash-reserved memory\n");
>  		return -EINVAL;
>  	}
>  
> -	if (kstrtobool(page, &is_dm_key_reused))
> +	if (kstrtobool(page, &val) || !val)
>  		return -EINVAL;
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
>  	return count;
>  }
> @@ -369,9 +387,6 @@ static int build_keys_header(void)
>  	struct config_key *key;
>  	int i, r;
>  
> -	if (keys_header != NULL)
> -		kvfree(keys_header);
> -
>  	keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
>  	if (!keys_header)
>  		return -ENOMEM;
> @@ -415,8 +430,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>  		.top_down = false,
>  		.random = true,
>  	};
> -	int r;
> -
> +	int r = 0;
>  
>  	if (key_count <= 0) {
>  		kexec_dprintk("No dm-crypt keys\n");
> @@ -424,14 +438,15 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>  	}
>  
>  	if (!is_dm_key_reused) {
> -		image->dm_crypt_keys_addr = 0;
>  		r = build_keys_header();
> -		if (r) {
> -			pr_err("Failed to build dm-crypt keys header, ret=%d\n", r);
> -			return r;
> -		}
> +		if (r)
> +			goto out;
>  	}
>  
> +	/*
> +	 * keys_header will be copied to reserver memory later and then be
> +	 * cleaned up at the end of kexec_file_load syscall
> +	 */
>  	kbuf.buffer = keys_header;
>  	kbuf.bufsz = get_keys_header_size(key_count);
>  
> @@ -441,18 +456,33 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>  	r = kexec_add_buffer(&kbuf);
>  	if (r) {
>  		pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
> -		kvfree((void *)kbuf.buffer);
> -		return r;
> +		goto out;
>  	}
> +
>  	image->dm_crypt_keys_addr = kbuf.mem;
>  	image->dm_crypt_keys_sz = kbuf.bufsz;
>  	kexec_dprintk(
>  		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
>  		kbuf.bufsz, kbuf.memsz);
>  
> +out:
> +	is_dm_key_reused = false;

I think there's still a bug for arm64 here.

When is_dm_key_reused set to true, the outer while loop prematurely
clears the is_dm_key_reused flag at the end of
crash_load_dm_crypt_keys() in the very first iteration.

Consequently, subsequent re-entrant calls to crash_load_dm_crypt_keys()
falsely perceive the keys as not reused, forcing a redundant execution
of build_keys_header() which overwrites the global keys_header pointer;

This induces a silent kernel memory leak.

92 >-------/*
 93 >------- * The location of the kernel segment may make it impossible
to satisfy
 94 >------- * the other segment requirements, so we try repeatedly to
find a
 95 >------- * location that will work.
 96 >------- */
 97 >-------while ((ret = kexec_add_buffer(&kbuf)) == 0) {
 98 >------->-------/* Try to load additional data */
 99 >------->-------kernel_segment = &image->segment[kernel_segment_number];
100 >------->-------ret = load_other_segments(image, kernel_segment->mem,
101 >------->------->------->------->-------  kernel_segment->memsz, initrd,
102 >------->------->------->------->-------  initrd_len, cmdline);
103 >------->-------if (!ret)
104 >------->------->-------break;
105
106 >------->-------/*
107 >------->------- * We couldn't find space for the other segments;
erase the
108 >------->------- * kernel segment and try the next available hole.
109 >------->------- */
110 >------->-------image->nr_segments -= 1;
111 >------->-------kbuf.buf_min = kernel_segment->mem +
kernel_segment->memsz;
112 >------->-------kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
113 >-------}


>  	return r;
>  }
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
>  static int __init configfs_dmcrypt_keys_init(void)
>  {
>  	int ret;
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 59fb9d71e9d8..062f7e79016d 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -140,6 +140,8 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>  	kfree(image->image_loader_data);
>  	image->image_loader_data = NULL;
>  
> +	kexec_file_post_load_cleanup_dm_crypt(image);
> +
>  	kexec_file_dbg_print = false;
>  }
>  



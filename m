Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D40FC624C6
	for <kexec@archiver.kernel.org>; Mon, 31 Aug 2026 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zeB+rbTGQuZxuhW3Jvl57BKDPYStEwcC60NnCSXea14=; b=L16YKtX6zutN2ICqTTDM/g17bP
	nRpuRUwDZkklcWrrw2v4S3nHDtdjw5YRdz2iAkpwx2THncz/+D88MPROlsoL+EwBIyoZgoRmzcAZn
	Zc9YW03VxT+A525SrsR0jJO7XcYPnqwZRKB5wpYkIjsOsEauM66kYbc2BXnGEEbELg5QQyLpCINXA
	9QtMtkbSGzuan4H2lftvEqd3gkLbZdhqoPBLOUbqIe4+Pl9GaWPXGUvgmYDXgyvKdCqbc7UeNrCDw
	GQZ8QH8C9IL4buBDRX7NpWXdYTUj1mVQ+3HYLmloTSmZmOMRYdUoFAiDKVH21gGCHgtOEJLJ/jyO1
	3QB1Am+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12Jx-00000009V6v-1QdH;
	Mon, 31 Aug 2026 13:45:09 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12Jt-00000009V5S-462x
	for kexec@lists.infradead.org;
	Mon, 31 Aug 2026 13:45:07 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2d72ae08fa1so28820665ad.2
        for <kexec@lists.infradead.org>; Mon, 31 Aug 2026 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788183905; x=1788788705; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zeB+rbTGQuZxuhW3Jvl57BKDPYStEwcC60NnCSXea14=;
        b=Bd+fVb/8qW6g8kNIHgse++lkehbuI/xWcIPWfrq0I2Qmui8dq4Sr0NR6mpglE1QmM2
         ZAkQlgzso5UEwqRrpmfVeZtKwUGjC8wcNXVXJrBCXlI4ltmA989Xra/91OVGLXJWdXxB
         fkIbGMk+dOm/OWpmfTF6Z7Gca5W1B7hZmzO63KFLxKWbVAxs0OQKD6OqESJsIg+4d1Y0
         ZEhJLlDKbl1vMkD/Qy8xLrwJGuq8kPy9QGqhvtaOjOpU0eEkhsOi38C51Orcvc33I3of
         +/msZt22XWmJNLterPLZmF8cPsujs/QPs2yEYYhDAgHGe4Fke8kc9CLILWmidbQaFUNa
         LDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183905; x=1788788705;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zeB+rbTGQuZxuhW3Jvl57BKDPYStEwcC60NnCSXea14=;
        b=audgRTPdoanL8aOOsu2LJCABIl2BePlE5jrrlQM/347AB6qLN2x3Ophxtn4xH1NIkO
         a75UbE3/qMfsIbvtUIgpNd6Ig+DWajy3hkNPWuplEJ6cpXOLJUbkfpsTjfMMJpOP6CS2
         gGD1yv0UoWDZPhBjKkAU9VQ0T9KEa/ER+GNjxJBsDRpR2hd0D0U+N1xJV+MrioXu1VxM
         l9NXHFRx/1OyP0zCEM8DZtDcwaD0EzsF3pEtG2l8E30frFwWastVkZp8DH1fDudDIvQX
         f4je1cKqUKHBkbl/kPXfgoKk+U6xRcTm2y7RQAgAxHllsz0AvUFs9HXeAFbp6ncP3lMb
         ZErA==
X-Gm-Message-State: AFuF++nTo44Xne25b5328ft6m4LBS6K8X5jqijZgi3yjCapftCWRs0ma
	PZEFhgCSFhLXexZZLTbL3GYPXlGw8zO9+4U62CBW3AWX9ybetyVt+EtU
X-Gm-Gg: AYBFou1OXMJGhnmRnA1AxKEEMja85anM22NGf6YqerBWg/vaDexIJNlGCh3qI4FsDE2
	JVL7i1UTsGGaQnlz5qia1MD0ZP2kUX7lT5IqOKBDQr37J8WvvwM2Gwfv0H77b9dezUrYfXj7FPN
	NOq9ztli+jLSMuRJla8B/42Z9AzCYKHPFQniFD9rsj4+zizO0VMxWjJMmvqEoX2ePbuSXOllsmB
	AHpfG2mV8jUuDxko8nN8nCjbdH7sy9rOJxFBismipvUQc+oblYqazNT7n8qq58x3CjMGoyoe530
	FyRhOiqEk/3gWgJrbZd+SCMSrs//nZ4mTERr7hJ+NXXhDhlQQYVEO/eGpNDL3gEG3XnCnck8qv2
	EiVl/SstFvjyGdVTKc8jBpRrz2kpY/5yc/sk2ksbqH9Fb1nhB35/ZqV1+hox4jx8a67MS2BrkAx
	NPccK6B5hgHI4GbCKI/96J3UFpoceZPBbdlubhkOWq6W8ZKAsBbSA0eg==
X-Received: by 2002:a17:90b:55cc:b0:398:de86:5ff0 with SMTP id 98e67ed59e1d1-39907db4f3amr1229981a91.19.1788183904771;
        Mon, 31 Aug 2026 06:45:04 -0700 (PDT)
Received: from localhost ([45.112.44.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-398aa3a9b54sm4848324a91.4.2026.08.31.06.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:45:04 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 31 Aug 2026 21:44:31 +0800
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Sourabh Jain <sourabhjain@linux.ibm.com>, Baoquan He <baoquan.he@linux.dev>, 
	Dave Young <ruirui.yang@linux.dev>, Pratyush Yadav <pratyush@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/9] crash_dump: Fix potential double free and UAF of
 keys_header
Message-ID: <apWEBBMz6aFBeefa@Rk>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
 <20260828084900.1496839-2-coiby.xu@gmail.com>
 <76f634e3-9adb-4ae2-b2b0-a7e13a2f93c3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76f634e3-9adb-4ae2-b2b0-a7e13a2f93c3@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_064506_696088_1C62254C 
X-CRM114-Status: GOOD (  30.40  )
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

On Mon, Aug 31, 2026 at 03:39:35PM +0800, Jinjie Ruan wrote:
>
>
>在 2026/8/28 16:48, Coiby Xu 写道:
>> If kexec_add_buffer somehow fails, keys_header will be freed. Depending
>> on /sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
>> following two problems if the kexec_file_load syscall is called again,
>>   1. Double free of keys_header if reuse=false
>>   2. UAF of keys_header if reuse=true
>>
>> To address these problems and also make it easier to reason about the
>> code, keep two invariants,
>>   1. keys_header will always be freed at the end of kexec_file_load
>>      syscall except during kdump image unloading for CPU/memory
>>      hot-plugging support
>>   2. There will always be valid keys_header if reuse=true
>>
>> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
>> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
>> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>> ---
>>  include/linux/kexec.h        |  6 ++++
>>  kernel/crash_dump_dm_crypt.c | 66 ++++++++++++++++++++++++++----------
>>  kernel/kexec_file.c          |  2 ++
>>  3 files changed, 56 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 0af8ae4fdd08..0fa8bac04576 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -552,6 +552,12 @@ void set_kexec_sig_enforced(void);
>>  static inline void set_kexec_sig_enforced(void) {}
>>  #endif
>>
>> +#ifdef CONFIG_CRASH_DM_CRYPT
>> +void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image);
>> +#else
>> +static inline void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image) {}
>> +#endif
>> +
>>  #endif /* !defined(__ASSEBMLY__) */
>>
>>  #endif /* LINUX_KEXEC_H */
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> index c685497cd470..4335b6cb1fc4 100644
>> --- a/kernel/crash_dump_dm_crypt.c
>> +++ b/kernel/crash_dump_dm_crypt.c
>> @@ -84,18 +84,25 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
>>  	return r;
>>  }
>>
>> -static void get_keys_from_kdump_reserved_memory(void)
>> +static int get_keys_from_kdump_reserved_memory(void)
>>  {
>>  	struct keys_header *keys_header_loaded;
>> +	size_t keys_header_size;
>>
>> -	arch_kexec_unprotect_crashkres();
>> +	keys_header_size = get_keys_header_size(key_count);
>> +	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
>> +	if (!keys_header)
>> +		return -ENOMEM;
>>
>> +	arch_kexec_unprotect_crashkres();
>>  	keys_header_loaded = kmap_local_page(pfn_to_page(
>>  		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
>>
>> -	memcpy(keys_header, keys_header_loaded, get_keys_header_size(key_count));
>> +	memcpy(keys_header, keys_header_loaded, keys_header_size);
>>  	kunmap_local(keys_header_loaded);
>>  	arch_kexec_protect_crashkres();
>> +
>> +	return 0;
>>  }
>>
>>  static int restore_dm_crypt_keys_to_thread_keyring(void)
>> @@ -286,17 +293,28 @@ static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
>>  static ssize_t config_keys_reuse_store(struct config_item *item,
>>  					   const char *page, size_t count)
>>  {
>> +	bool val;
>> +	int r;
>> +
>>  	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
>>  		kexec_dprintk(
>>  			"dm-crypt keys haven't be saved to crash-reserved memory\n");
>>  		return -EINVAL;
>>  	}
>>
>> -	if (kstrtobool(page, &is_dm_key_reused))
>> +	if (kstrtobool(page, &val) || !val)
>>  		return -EINVAL;
>>
>> -	if (is_dm_key_reused)
>> -		get_keys_from_kdump_reserved_memory();
>> +	if (is_dm_key_reused) {
>> +		pr_info("Already got dm-crypt keys, please continue with kexec_file_load syscall\n");
>> +	} else {
>> +		r = get_keys_from_kdump_reserved_memory();
>> +		if (r) {
>> +			pr_warn("Failed to get dm-crypt keys from reserved memory\n");
>> +			return r;
>> +		}
>> +		is_dm_key_reused = true;
>> +	}
>>
>>  	return count;
>>  }
>> @@ -369,9 +387,6 @@ static int build_keys_header(void)
>>  	struct config_key *key;
>>  	int i, r;
>>
>> -	if (keys_header != NULL)
>> -		kvfree(keys_header);
>> -
>>  	keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
>>  	if (!keys_header)
>>  		return -ENOMEM;
>> @@ -415,8 +430,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  		.top_down = false,
>>  		.random = true,
>>  	};
>> -	int r;
>> -
>> +	int r = 0;
>>
>>  	if (key_count <= 0) {
>>  		kexec_dprintk("No dm-crypt keys\n");
>> @@ -424,14 +438,15 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  	}
>>
>>  	if (!is_dm_key_reused) {
>> -		image->dm_crypt_keys_addr = 0;
>>  		r = build_keys_header();
>> -		if (r) {
>> -			pr_err("Failed to build dm-crypt keys header, ret=%d\n", r);
>> -			return r;
>> -		}
>> +		if (r)
>> +			goto out;
>>  	}
>>
>> +	/*
>> +	 * keys_header will be copied to reserver memory later and then be
>> +	 * cleaned up at the end of kexec_file_load syscall
>> +	 */
>>  	kbuf.buffer = keys_header;
>>  	kbuf.bufsz = get_keys_header_size(key_count);
>>
>> @@ -441,18 +456,33 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  	r = kexec_add_buffer(&kbuf);
>>  	if (r) {
>>  		pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>> -		kvfree((void *)kbuf.buffer);
>> -		return r;
>> +		goto out;
>>  	}
>> +
>>  	image->dm_crypt_keys_addr = kbuf.mem;
>>  	image->dm_crypt_keys_sz = kbuf.bufsz;
>>  	kexec_dprintk(
>>  		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
>>  		kbuf.bufsz, kbuf.memsz);
>>
>> +out:
>> +	is_dm_key_reused = false;
>
>I think there's still a bug for arm64 here.
>
>When is_dm_key_reused set to true, the outer while loop prematurely
>clears the is_dm_key_reused flag at the end of
>crash_load_dm_crypt_keys() in the very first iteration.
>
>Consequently, subsequent re-entrant calls to crash_load_dm_crypt_keys()
>falsely perceive the keys as not reused, forcing a redundant execution
>of build_keys_header() which overwrites the global keys_header pointer;
>
>This induces a silent kernel memory leak.

Thanks for reviewing this patch and raising the concern! Unless I miss
something, I don't think the global keys_header will be overwritten
because kexec_file_post_load_cleanup_dm_crypt will called to free the
memory during the end of kexec_file_load syscall.

>
>92 >-------/*
> 93 >------- * The location of the kernel segment may make it impossible
>to satisfy
> 94 >------- * the other segment requirements, so we try repeatedly to
>find a
> 95 >------- * location that will work.
> 96 >------- */
> 97 >-------while ((ret = kexec_add_buffer(&kbuf)) == 0) {
> 98 >------->-------/* Try to load additional data */
> 99 >------->-------kernel_segment = &image->segment[kernel_segment_number];
>100 >------->-------ret = load_other_segments(image, kernel_segment->mem,
>101 >------->------->------->------->-------  kernel_segment->memsz, initrd,
>102 >------->------->------->------->-------  initrd_len, cmdline);
>103 >------->-------if (!ret)
>104 >------->------->-------break;
>105
>106 >------->-------/*
>107 >------->------- * We couldn't find space for the other segments;
>erase the
>108 >------->------- * kernel segment and try the next available hole.
>109 >------->------- */
>110 >------->-------image->nr_segments -= 1;
>111 >------->-------kbuf.buf_min = kernel_segment->mem +
>kernel_segment->memsz;
>112 >------->-------kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>113 >-------}

Btw, I assume the above text is not related to the discussion, right? 

[...]

-- 
Best regards,
Coiby


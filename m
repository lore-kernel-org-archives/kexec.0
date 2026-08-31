Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5994C624CF
	for <kexec@archiver.kernel.org>; Mon, 31 Aug 2026 13:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yd2Ar3RmTJ9F/ZDeMnk183eBg6DrdUsQr78JTCYkyuQ=; b=JfP4G1M0eCdY2DdnF4WMonZJo8
	Vrq/2LoOt9CpvQW55Ql5+OhotnA8xLERqW1JyEcccb0SVACk7fD+DuFLq2HJAfl4crL2npk11LLER
	Lf8DbCZ+jlO3GJONlKJ50j0AcX1wPVSloT0xv8DJr0OrRg1hHn8jtEAQwTgN1/l9HPir/tUTOr/7l
	V9I2zaHLhNc806YTX4k2LJD+ckPoCFeiGR9ybX7V85GKyqYzUNkGtrnm3PA9VbiO55pS4+l4cZaog
	EPsvTBZ+qCexm/5F66k3Yq/IPga4dOe0Wo8e12iSjw6J5blGcH8FomjxtsqvzcT0AdFYEeMqQFTNe
	Hk4Azxxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12FD-00000009Si7-0Vve;
	Mon, 31 Aug 2026 13:40:15 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12F7-00000009Scn-2bjD
	for kexec@lists.infradead.org;
	Mon, 31 Aug 2026 13:40:11 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2918345a91.0
        for <kexec@lists.infradead.org>; Mon, 31 Aug 2026 06:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788183609; x=1788788409; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yd2Ar3RmTJ9F/ZDeMnk183eBg6DrdUsQr78JTCYkyuQ=;
        b=SF8poewSk/mKYfsMP1aUWajFgnUDwBapvxU5SIHXkbvg85eBb440A3rutyTJKWurL9
         zlkeOfc6+OejB627F9/32z21lXMmz90KukY1WwWc7f+CupASuxw8Xon1vJUGZ+j4ciF9
         uybflPxDjuMk7QLXK2olYSJ3eieEirmBwtjtDBeMVASohyJ++V34lHt1Ulq5Yyw3LkPX
         zv62j1zSPo+XwfM9kILNd3dVDJQluK/muSLo4IN1G2PrWAquwugUAwusYZjGT9p1mwQ9
         K+PbviV6EuCOo4BUlp6o4zpMhyx+UHXVl9Jbuq+5CXkLOP9Sf1cSniPaBbGtcSlpmSJ/
         os4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183609; x=1788788409;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yd2Ar3RmTJ9F/ZDeMnk183eBg6DrdUsQr78JTCYkyuQ=;
        b=B88hkgRxpyG8pwgat3jIisjHACriO57nV2NojUESWuTurq6K/FPX0xeji2VEaS+4v9
         iccKaxla/XG7ggAnFu+IfDU8lvYyndm0w0AR9uvPzHAEfRrbo2TsP4qD4ABCZjoJ9jIL
         AX6qeZ2nPLN5BjSYC2elKJB1A2PfkQbcSxvrWUYrre2mj8lnm3zM9Y265aKTGzv72S6Q
         D+NTW6LRrlHHIrlldUpum9PrNlx3GSCXtemma2MIsH8OUXHUwoK6b5aMIhBPTcvyEkoS
         ps7x/tcUWPNWKv1gA8sMDj77iP33xY079JjYD5HdlpTeuBHqfxNG+/Tqlpe13G+ybSIz
         pkcw==
X-Gm-Message-State: AFuF++lMqsX9Ou6MFkJZuX9PfprCjp9Jk9hkKcjfd3tbhCMvlD7mOSQp
	5nHs5usgmnPohNS/m5UtlVX9gsw/fZ3c/u8s5fbLkPIpL2n6k14tkusv
X-Gm-Gg: AYBFou2HODPGtO+OO/KRfy3KSNroLfJzoQqxu/Ef3SMNTNybRGNeWIk9Wghkls1UG2k
	u31wDFRISHWzDKkDUrqQV840CxDvfVUgfPOxxyP66qcvA96n07WzDdGio1Cp1RMyjtvldT4TF0K
	BY0Sgmccl66l/vILNhSYCo2FmV5Ck9XfZefnCC1oiwx+0OMLU9I7VPlHKFKwBxKIibkDjXdMQb6
	xU2wy15CQxPO9iCboix3H4UW0jdYN5wR3vlUctCGX5seDbDY4x8T1WUuCqrVdrEqATQH7xg+SXb
	uMzZmYJh/I1K8Kxfjk4VOLxULiU3WOPIFzDk1P1o35f326xBMpJiRCNzlwgAkh22nZ4nEQdTQTC
	uIL6LM4CNBVWuLJSAK7zvIgrXQf8Y33JLqF+OF3s3ic11f6r/zarO45LcK3TYW0NSYJ8N+lE6j/
	oPuE444FTTrgt6WXkUcvNTcrhCRt51eteP9h3VGJIut32RcmqZy1KS2A==
X-Received: by 2002:a17:90b:164b:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-396d0c79e8amr39123637a91.0.1788183608423;
        Mon, 31 Aug 2026 06:40:08 -0700 (PDT)
Received: from localhost ([45.112.44.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f959575sm30280525eec.15.2026.08.31.06.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:40:07 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 31 Aug 2026 21:39:10 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, open list <linux-kernel@vger.kernel.org>, 
	Jinjie Ruan <ruanjinjie@huawei.com>
Subject: Re: [PATCH v4 1/9] crash_dump: Fix potential double free and UAF of
 keys_header
Message-ID: <apWDq7EZJhL41hdS@Rk>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
 <20260828084900.1496839-2-coiby.xu@gmail.com>
 <f8994152-7f77-4338-a496-aca67f85ca2a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f8994152-7f77-4338-a496-aca67f85ca2a@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_064010_183132_C0908FB0 
X-CRM114-Status: GOOD (  20.15  )
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

On Sun, Aug 30, 2026 at 12:00:40PM +0530, Sourabh Jain wrote:
>Hello Coiby,
>
>On 28/08/26 14:18, Coiby Xu wrote:
>>If kexec_add_buffer somehow fails, keys_header will be freed. Depending
>>on /sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
>>following two problems if the kexec_file_load syscall is called again,
>>   1. Double free of keys_header if reuse=false
>>   2. UAF of keys_header if reuse=true
>>
>>To address these problems and also make it easier to reason about the
>>code, keep two invariants,
>>   1. keys_header will always be freed at the end of kexec_file_load
>>      syscall except during kdump image unloading for CPU/memory
>>      hot-plugging support
>>   2. There will always be valid keys_header if reuse=true
>>
>>Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
>>Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>---
>>  include/linux/kexec.h        |  6 ++++
>>  kernel/crash_dump_dm_crypt.c | 66 ++++++++++++++++++++++++++----------
>>  kernel/kexec_file.c          |  2 ++
>>  3 files changed, 56 insertions(+), 18 deletions(-)
>>
>>diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>index 0af8ae4fdd08..0fa8bac04576 100644
>>--- a/include/linux/kexec.h
>>+++ b/include/linux/kexec.h
>>@@ -552,6 +552,12 @@ void set_kexec_sig_enforced(void);
>>  static inline void set_kexec_sig_enforced(void) {}
>>  #endif
>>+#ifdef CONFIG_CRASH_DM_CRYPT
>>+void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image);
>>+#else
>>+static inline void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image) {}
>>+#endif
>>+
>>  #endif /* !defined(__ASSEBMLY__) */
>>  #endif /* LINUX_KEXEC_H */
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index c685497cd470..4335b6cb1fc4 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -84,18 +84,25 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
>>  	return r;
>>  }
>>-static void get_keys_from_kdump_reserved_memory(void)
>>+static int get_keys_from_kdump_reserved_memory(void)
>>  {
>>  	struct keys_header *keys_header_loaded;
>>+	size_t keys_header_size;
>>-	arch_kexec_unprotect_crashkres();
>>+	keys_header_size = get_keys_header_size(key_count);
>>+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
>>+	if (!keys_header)
>>+		return -ENOMEM;
>>+	arch_kexec_unprotect_crashkres();
>>  	keys_header_loaded = kmap_local_page(pfn_to_page(
>>  		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
>>-	memcpy(keys_header, keys_header_loaded, get_keys_header_size(key_count));
>>+	memcpy(keys_header, keys_header_loaded, keys_header_size);
>>  	kunmap_local(keys_header_loaded);
>>  	arch_kexec_protect_crashkres();
>>+
>>+	return 0;
>>  }
>>  static int restore_dm_crypt_keys_to_thread_keyring(void)
>>@@ -286,17 +293,28 @@ static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
>>  static ssize_t config_keys_reuse_store(struct config_item *item,
>>  					   const char *page, size_t count)
>>  {
>>+	bool val;
>>+	int r;
>>+
>>  	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
>>  		kexec_dprintk(
>>  			"dm-crypt keys haven't be saved to crash-reserved memory\n");
>>  		return -EINVAL;
>>  	}
>>-	if (kstrtobool(page, &is_dm_key_reused))
>>+	if (kstrtobool(page, &val) || !val)
>>  		return -EINVAL;
>>-	if (is_dm_key_reused)
>>-		get_keys_from_kdump_reserved_memory();
>>+	if (is_dm_key_reused) {
>>+		pr_info("Already got dm-crypt keys, please continue with kexec_file_load syscall\n");
>>+	} else {
>>+		r = get_keys_from_kdump_reserved_memory();
>>+		if (r) {
>>+			pr_warn("Failed to get dm-crypt keys from reserved memory\n");
>>+			return r;
>>+		}
>>+		is_dm_key_reused = true;
>>+	}
>>  	return count;
>>  }
>>@@ -369,9 +387,6 @@ static int build_keys_header(void)
>>  	struct config_key *key;
>>  	int i, r;
>>-	if (keys_header != NULL)
>>-		kvfree(keys_header);
>>-
>>  	keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
>>  	if (!keys_header)
>>  		return -ENOMEM;
>>@@ -415,8 +430,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  		.top_down = false,
>>  		.random = true,
>>  	};
>>-	int r;
>>-
>>+	int r = 0;
>>  	if (key_count <= 0) {
>>  		kexec_dprintk("No dm-crypt keys\n");
>>@@ -424,14 +438,15 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  	}
>>  	if (!is_dm_key_reused) {
>>-		image->dm_crypt_keys_addr = 0;
>>  		r = build_keys_header();
>>-		if (r) {
>>-			pr_err("Failed to build dm-crypt keys header, ret=%d\n", r);
>>-			return r;
>>-		}
>>+		if (r)
>>+			goto out;
>>  	}
>>+	/*
>>+	 * keys_header will be copied to reserver memory later and then be
>>+	 * cleaned up at the end of kexec_file_load syscall
>>+	 */
>>  	kbuf.buffer = keys_header;
>>  	kbuf.bufsz = get_keys_header_size(key_count);
>>@@ -441,18 +456,33 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  	r = kexec_add_buffer(&kbuf);
>>  	if (r) {
>>  		pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>>-		kvfree((void *)kbuf.buffer);
>>-		return r;
>>+		goto out;
>>  	}
>>+
>>  	image->dm_crypt_keys_addr = kbuf.mem;
>>  	image->dm_crypt_keys_sz = kbuf.bufsz;
>>  	kexec_dprintk(
>>  		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
>>  		kbuf.bufsz, kbuf.memsz);
>>+out:
>>+	is_dm_key_reused = false;
>>  	return r;
>>  }
>>+void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>>+{
>>+	/*
>>+	 * For CPU/memory hot-plugging, the kdump image will be reloaded. Prevent
>>+	 * keys_header from being cleaned up during unloading when
>>+	 * is_dm_key_reused=true
>>+	 */
>>+	if (!is_dm_key_reused) {
>>+		kfree_sensitive(keys_header);
>>+		keys_header = NULL;
>
>The below patch from Jinjie has proposed to free and reset the 
>keys_header in
>the below patch:
>
>https://lore.kernel.org/all/20260826092541.3905933-8-ruanjinjie@huawei.com/
>
>I suggest to Jinjie to consider dropping his patch and review this one 
>instead.
>
>I CCed you on the above patch series so feel free share you thoughts.

Thanks for pointing me to Jinjie's patch and making the suggestion!

>
>- Sourabh Jain
>
>>+	}
>>+}
>>+
>>  static int __init configfs_dmcrypt_keys_init(void)
>>  {
>>  	int ret;
>>diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>index 59fb9d71e9d8..062f7e79016d 100644
>>--- a/kernel/kexec_file.c
>>+++ b/kernel/kexec_file.c
>>@@ -140,6 +140,8 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>>  	kfree(image->image_loader_data);
>>  	image->image_loader_data = NULL;
>>+	kexec_file_post_load_cleanup_dm_crypt(image);
>>+
>>  	kexec_file_dbg_print = false;
>>  }
>

-- 
Best regards,
Coiby


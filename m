Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5840CC79F9E
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pEGP2cE8iQS2fH0kTojaUbqz8qtcGorsOVsNdP0l2Cc=; b=FA4BcOgZ8t3zrdI3NN4ambr1NT
	HiN9U4l204Atnhf/8+gW3jgHS/kF/b7IrW1pW1XjotmH3OiaSDir2DyIsVGJXDccddZjQ1APzPfbz
	YTA9XwxGIHIQF449DjW7l0g4gfJjPVVQT3kvMiMpfF0QQQLZtNfUw8IXT5rogjbGeNpmCWy9PEafi
	3uf1wajYmtFW8pn5ecO4Sh3Y5/Pabl3xohtCf0WjhKHRFF3aIxveqxxdF05vGqQxxEfLjv/3nTsZ0
	NrTtVRed/4RZCONA5wQbYx3zOC6DMtUI8hmsednsl0omHhHx0gEPx1rn7Flvj5gRwRXrbTMrhKctx
	z+IXetxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46HM-0000000AV2U-2b51;
	Wed, 09 Sep 2026 00:35:08 +0000
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46HK-0000000AV20-0dck
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 00:35:07 +0000
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso519055a91.3
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 17:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788914105; x=1789518905; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pEGP2cE8iQS2fH0kTojaUbqz8qtcGorsOVsNdP0l2Cc=;
        b=DOUBd+nJEwjsfqy5LqTlf5crArdgHR+WxAOR8Dwy/OjyF+v1tiDFVNwC28G1k4CE+B
         /QmZfMaYZ7m396hZBideh6rXQ3eam7Q8SQ9qnTSMH2fzgxyFFoaTEm4cSNXxuRRxXMCW
         jlEy/Q8bn1GZMn066xBW+ww6b52USOWOocw5Ygq8mWR2FmTTGL/rhCmLDI7wkjGqqXqs
         wZHkoMJ6k7AC3D5SjNCaEH8NFxwdaNWQG+8p7hA69U1TQ8C3TrEFJVnqPvpENF/cAMOl
         uiM7v4NInYDCSIJuHYOsR1ufLtUspn/nNpkCKjze5VTBpf7Jp8iSzmZZwDMp97s/rEia
         TOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788914105; x=1789518905;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pEGP2cE8iQS2fH0kTojaUbqz8qtcGorsOVsNdP0l2Cc=;
        b=ikktH76harw83YgU7K9kttqgNELkSpujBokiprYWzwn+GfUTxHlGuuBVyg8Q8eWj73
         TB+1hVWEqPEZ093SKGeSjUb8D3mzs/b2ctt6J+8s8RN9oJdxIsQvSoT8lPQZYENIpP3b
         mZXiH5gTWf9/dqcNtbMckSyiavejNOKMA8DXF0poOG1NYvJsXPCvYdOlQS6uze5PlkQt
         PkgrZ20OU/y5mI8lZi6Eek+Vtuk4e44Qv+Nhi0aPJkk8A3V1ystYvULpw+6Fef93ysMx
         hQ8y8zTsg+gP28XN8mC3I8ESC6xoHsoFJ6jbiu2JM2bRMt8YV7sG6Jy+VqZ5B7XvlwM9
         Rt1Q==
X-Gm-Message-State: AFuF++mw/MYQVzo79unnu/O7B8gzq88z69m5PrsF227/KF4VQ9jpwJFT
	NEsz3ArY/s292k/SYFLIkQks3kXUM1ct5DlucRuwBKoFLWxudHq8gHn3
X-Gm-Gg: AYBFou30pYvRQ7myIF/UvU1uEJ10040U0Pab3K1vuJCUMV/MndRAR7f8YuXWmp0TAQX
	FWAuXIU78NUIBTuxk6g4du/d++TBiaZtKOFK9eYSYHg1jVluhYT1A7vXYaHt567WeWED9qRLmPq
	Uz6RNo75Ds3Ny8bxJQaONphARJ1RBSEv+WSYeScrL1tqAQNNirtpi0YomAAgI5l1kVZ39mXLOCL
	7dbL5pVcGf0EKtvxw27hvKiIG3tFjmDDsP9AKEncnNZ2jw0q6zLv4RJrlyszeYHMo4NdlhK0CXn
	7j+HzWQKodHjpw3t2pe9opjkUbtpTleJ1h8FkNEVzUwCxiXo9OncMG4uSZOjSUPD+TtMl25OGH1
	dsNZgsqSjsZHgxFrqkzfdTaqv7O9W+XVJ8nHIMIOKi4ySa3TtN6S+suo01295eDL4D9uNqA086y
	8Sp0WUNav0nB65nSp4VUA+9mDIAoSdGHnYmbxWPtJ96+m/H7L11tQGQksIZMEZcA==
X-Received: by 2002:a17:90a:d005:b0:398:a2ed:7b5c with SMTP id 98e67ed59e1d1-39bac4571c4mr3556469a91.24.1788914104697;
        Tue, 08 Sep 2026 17:35:04 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:1b67:ddd8:990d:9d6f:13b8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ca63b3sm34649650a91.11.2026.09.08.17.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 17:35:03 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Wed, 9 Sep 2026 08:31:57 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/9] crash_dump: Fix potential double free and UAF of
 keys_header
Message-ID: <aqCZtP9WEhlWaLfh@Rk>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
 <20260828084900.1496839-2-coiby.xu@gmail.com>
 <30053e95-1f02-485c-9e92-19e688c5ed0c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <30053e95-1f02-485c-9e92-19e688c5ed0c@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_173506_202753_BBFF849A 
X-CRM114-Status: GOOD (  22.93  )
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

On Sun, Aug 30, 2026 at 12:37:32PM +0530, Sourabh Jain wrote:
>
>Nit: I feel 2/9 should be the first patch.

Thanks for the suggestion! I don't have enough experience to tell which
problem is more likely to happen. But [PATCH v4 2/9] will depend on
[PATCH v4 3/9] in next version to only acquire configfs mutex lock when
is_dm_key_reused=False.

>
>The changes on this patch looks good to me. Feel free to add:
>Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thank for ack'ing the patch! I'll send a new version to address a memory
leak issue pointed out by Jinjie. I think the change is not trivial so
it's better to not add your Reviewed-by tag.

>
>- Sourabh Jain
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


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5164CD3427
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 23:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=isFMffa6fJYWa8WRwMnFwL6A7a7hUVq61Jbed7g/xXE=; b=cH518xfJmBq8C2TvYrtHIPgm/D
	B9achYwmuw4/mADWWoJHuL0oeWWLAzF9sMVjfgNGMrAzXsx30TMalTgdvSnoT/6isIOOSnI2q23+Z
	AeeWsgvdO3bxMGKnyCWUo9NwBIwC6lCRNFw1aqmZmq3pOaE1Ud54n3OuomtCqAu4SbhvqBcLbCpFx
	1pY+NXQBh51WDZSB1AbexzjPvhhHSUUi29YQsZgKOjxwp1R9U4DDkQ2SqP9x6icTElnR+dNZ3i25Y
	ZjHBrFHDgEPb7oE8qCoqDA6sqSo0Vv7rgUnl1DcqlKDcZR5PxItOWOWHrJ3nhacDa0SBJ1hfEKpuQ
	5ZK8UaYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxWn-00000007qYu-1HNL;
	Fri, 01 May 2026 23:44:13 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxWk-00000007qXt-3S1I
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 23:44:12 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so1703081a91.2
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 16:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777679050; x=1778283850; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isFMffa6fJYWa8WRwMnFwL6A7a7hUVq61Jbed7g/xXE=;
        b=iWPj9fzGQ5EuXaSq4PoVUJ/mHQXFz8SXtFJaXdQFGQ0WnOq+LG6mf4vj0K+8p0nS2f
         IeVWyhbevE61wXmHmx3nPADbAuj3imQY1a7F8Fp2fFxQuPs889bmeKJlUG3U2ub82h4b
         eP6io7B39+wqI+n4uwWFA9LQfSN/BFnNY0Ye91JR9tYTKjM3ujintC1TiVtyNCbyqamz
         Fd7BxkVK79aaAsVy5Bz8Tg6dNrIVDI62Xzjc2zDqS1c9sb+drMJaWpHZk53Fb9FDyW67
         /A3/X8Zie6ml/ibSDDGxxp6gZf8HUXvwxn7o6h2+pr+3LQtC52EmTZYf59vqCeqrXdVY
         Fpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777679050; x=1778283850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=isFMffa6fJYWa8WRwMnFwL6A7a7hUVq61Jbed7g/xXE=;
        b=j0CPERwHl+ny6rL9uzwVPiuZUMc96F82BSi0yG8iFd8jtalOSn6OXQwhcYNBQNqeEU
         iA414zTBmFVUOu5ADQYjRKfw76u5va2yhviVxZlLyxTCxEm/fFKdPUXgyFaDOHEcNypL
         nY+x2BX1rcnn5++kkab9tqDOAv2Iswtvk916WqNOE+FpgE1TQHyOXCwQ/Xxfp757Hg9F
         Uy1QcxjZh93aNN2Yr2FCHTHz9sPv0SrKgQC8UnJku+WFzHBEO5SujPrhYiMsdQmxt73k
         iv7tHtA8F3D3EfVsbbo6PVndTmTzULq5AvgeAfS6vfSEsLyqF64o1vD2uFrXjpHlZ6+U
         BiFQ==
X-Gm-Message-State: AOJu0Yzix6FcTQ926Uvh6AnXm/wv6kFsRt8BhOm/LACu4qStHB5uVFhm
	rfWv4ccUJQFnAbGU+GP1lG2IA4BfbHQNoo7QNIx+6922ynGjnzWs6XFbWe44Ays19KEb1g==
X-Gm-Gg: AeBDiesjedM/zyfUKw0e6+afDcHy4iNp4FAoVYx7QwQF6QuFAWaH18bREzhkOpr7f4+
	ubDOgBhSdj04mDSE2NolHq3bYcjca11N+qkuCB4ACURYtvHhD4AXZPF/9GaywXsLnr0xmrMOydQ
	05hlmp/VZbU12isqiT4QZuyvtV3G9znHfbpmSNXtw4Bzab0d0ouYAd4co0fbTqVWXHbDqlrqfdf
	KOaBpDUsCbjdXdpGiJ4I/riG967+vzEE/DG0mPRIYn+lHUe+4qD5YusSWuvzE91LNRkKFLmQU9L
	aoCbDQh0ASzABttNOrndNa8Zb62fOV/gZ7yUo5cWrxhrb4pzIEMaWNrHmKfedzH9+1R8whChqgZ
	gqrtlAZq2HWn9VulH0SbjCorYfznExKRi+8TI6MKkWkysFHbHIRRUP48dbkkRc384yZBNp3KULs
	bQo5U5EBCkIykOznFBjZ+Zy5Hccdh2Hw==
X-Received: by 2002:a17:903:1cd:b0:2b2:4a9a:b149 with SMTP id d9443c01a7336-2b9f25653abmr12012465ad.9.1777679049811;
        Fri, 01 May 2026 16:44:09 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae11939sm33752105ad.49.2026.05.01.16.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:44:09 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Coiby Xu <coxu@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/9] crash_dump: Fix potential double free and UAF of keys_header
Date: Sat,  2 May 2026 07:43:31 +0800
Message-ID: <20260501234342.2518281-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501234342.2518281-1-coiby.xu@gmail.com>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_164410_863311_0D08C3DA 
X-CRM114-Status: GOOD (  19.82  )
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

If kexec_add_buffer somehow fails, keys_header will be freed. Depending
on /sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
following two problems if the kexec_file_load syscall is called again,
  1. Double free of keys_header if reuse=false
  2. UAF of keys_header if reuse=true

To address these problems and also make it easier to reason about the
code, keep two invariants,
  1. keys_header will always be freed at the end of kexec_file_load
     syscall except during kdump image unloading for CPU/memory
     hot-plugging support
  2. There will always be valid keys_header if reuse=true

Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 include/linux/kexec.h        |  6 ++++
 kernel/crash_dump_dm_crypt.c | 65 ++++++++++++++++++++++++++----------
 kernel/kexec_file.c          |  2 ++
 3 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8a22bc9b8c6c..91256d7ff434 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -552,6 +552,12 @@ void set_kexec_sig_enforced(void);
 static inline void set_kexec_sig_enforced(void) {}
 #endif
 
+#ifdef CONFIG_CRASH_DM_CRYPT
+void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image);
+#else
+static inline void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image) {}
+#endif
+
 #endif /* !defined(__ASSEBMLY__) */
 
 #endif /* LINUX_KEXEC_H */
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index eac4f436a8d4..4d8a3331bbe7 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -84,18 +84,25 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
 	return r;
 }
 
-static void get_keys_from_kdump_reserved_memory(void)
+static int get_keys_from_kdump_reserved_memory(void)
 {
 	struct keys_header *keys_header_loaded;
+	size_t keys_header_size;
 
-	arch_kexec_unprotect_crashkres();
+	keys_header_size = get_keys_header_size(key_count);
+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
+	if (!keys_header)
+		return -ENOMEM;
 
+	arch_kexec_unprotect_crashkres();
 	keys_header_loaded = kmap_local_page(pfn_to_page(
 		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
 
-	memcpy(keys_header, keys_header_loaded, get_keys_header_size(key_count));
+	memcpy(keys_header, keys_header_loaded, keys_header_size);
 	kunmap_local(keys_header_loaded);
 	arch_kexec_protect_crashkres();
+
+	return 0;
 }
 
 static int restore_dm_crypt_keys_to_thread_keyring(void)
@@ -283,17 +290,28 @@ static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
 static ssize_t config_keys_reuse_store(struct config_item *item,
 					   const char *page, size_t count)
 {
+	bool val;
+	int r;
+
 	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
 		kexec_dprintk(
 			"dm-crypt keys haven't be saved to crash-reserved memory\n");
 		return -EINVAL;
 	}
 
-	if (kstrtobool(page, &is_dm_key_reused))
+	if (kstrtobool(page, &val) || !val)
 		return -EINVAL;
 
-	if (is_dm_key_reused)
-		get_keys_from_kdump_reserved_memory();
+	if (is_dm_key_reused) {
+		pr_info("Already got dm-crypt keys, please continue with kexec_file_load syscall\n");
+	} else {
+		r = get_keys_from_kdump_reserved_memory();
+		if (r) {
+			pr_warn("Failed to get dm-crypt keys from reserved memory\n");
+			return r;
+		}
+		is_dm_key_reused = true;
+	}
 
 	return count;
 }
@@ -366,9 +384,6 @@ static int build_keys_header(void)
 	struct config_key *key;
 	int i, r;
 
-	if (keys_header != NULL)
-		kvfree(keys_header);
-
 	keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
 	if (!keys_header)
 		return -ENOMEM;
@@ -412,7 +427,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 		.top_down = false,
 		.random = true,
 	};
-	int r;
+	int r = 0;
 
 
 	if (key_count <= 0) {
@@ -421,14 +436,15 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	}
 
 	if (!is_dm_key_reused) {
-		image->dm_crypt_keys_addr = 0;
 		r = build_keys_header();
-		if (r) {
-			pr_err("Failed to build dm-crypt keys header, ret=%d\n", r);
-			return r;
-		}
+		if (r)
+			goto out;
 	}
 
+	/*
+	 * keys_header will be copied to reserver memory later and then be
+	 * cleaned up at the end of kexec_file_load syscall
+	 */
 	kbuf.buffer = keys_header;
 	kbuf.bufsz = get_keys_header_size(key_count);
 
@@ -438,18 +454,33 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	r = kexec_add_buffer(&kbuf);
 	if (r) {
 		pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
-		kvfree((void *)kbuf.buffer);
-		return r;
+		goto out;
 	}
+
 	image->dm_crypt_keys_addr = kbuf.mem;
 	image->dm_crypt_keys_sz = kbuf.bufsz;
 	kexec_dprintk(
 		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
 		kbuf.bufsz, kbuf.memsz);
 
+out:
+	is_dm_key_reused = false;
 	return r;
 }
 
+void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
+{
+	/*
+	 * For CPU/memory hot-plugging, the kdump image will be reloaded. Prevent
+	 * keys_header from being cleaned up during unloading when
+	 * is_dm_key_reused=true
+	 */
+	if (!is_dm_key_reused) {
+		kfree_sensitive(keys_header);
+		keys_header = NULL;
+	}
+}
+
 static int __init configfs_dmcrypt_keys_init(void)
 {
 	int ret;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2bfbb2d144e6..0421f1e89791 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -139,6 +139,8 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	kfree(image->image_loader_data);
 	image->image_loader_data = NULL;
 
+	kexec_file_post_load_cleanup_dm_crypt(image);
+
 	kexec_file_dbg_print = false;
 }
 
-- 
2.54.0



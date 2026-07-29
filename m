Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFE4C53219
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 03:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tu5Y2pXtD7EYXho8m2Td0vTpaq76oKkvCI7opHYUzCY=; b=B2EvLlqZUbB7DV7i4qWqHuvaoA
	JtKAyh88VZvBeUdVuKOCbe1mdStER0AjZCn/5SwDu/eIhitvHsbuzgandWHL2y/fXb0ynyXFZ0SXb
	IRG/d/eI/34zMAk/ZnPdQ0lpGaEF1GyJAz9kG9Z0BwhKiXeDsQSz1JM5LJvu4njPDEN6bT1R/K6vb
	o1J7jU7fiWe94HYMfN/YlQa4RSauZUsE70mrwHgE5em4x6KuwMsBmu4H6/67TUtMj78d2nnaiAVCX
	EE6wi1CtgW+CQv+WYcqoR7PtFnPG2CDwBWV9lhLMzzLXbXG4KZfyv+TNR1QlqLxuyyGteA7b6rVXx
	tRHZr1vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6T-00000006lNl-0P32;
	Wed, 29 Jul 2026 03:37:09 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6Q-00000006lMc-260B
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 03:37:07 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2ceaf8a1265so6222645ad.2
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 20:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296226; x=1785901026; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tu5Y2pXtD7EYXho8m2Td0vTpaq76oKkvCI7opHYUzCY=;
        b=K+YABKljpERG1bKwGs5sxUqHwl7+8LcS6EZyi5ACiyM88+KZX31OwwoFmtSILMQTDt
         QWQAcAvjSWijkEjsYv+IdX1W2k2XDokcHOronIYW8OqLd99HYxt3k7oWNqJJFVPjAuxt
         w9laISmtkVoO9U3FnyZOJujP4FrE3KWWlfUFT8bdz/hsN0rcBpccC0PqllkZFri2okq3
         t9kLQ8wI11ItQ4Y+z7E31J1rQEj4F8Xr4ezNmBKcgE6P5cVGpRKyvMxXzl/pHihwcuyo
         NiW+m3AyhCX2VAuqKbfM2X6is6y2hIgk5DzL/r2ltsfedgmZy3FOge4u813H8HGlJ1Lj
         spCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296226; x=1785901026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tu5Y2pXtD7EYXho8m2Td0vTpaq76oKkvCI7opHYUzCY=;
        b=WvqKQpYV8BanW3vRP7jiOwBXjCypZ+0FVfwdS2O2WZR2XOH/ga7PBk3uS5ISAT5bG2
         Jw83dnuWoyGg+j3SVpjjFiJE/zxbpaUExh5eW3Fu2nHJ85rCuSPySfPDAFXgEYra5HRp
         59yu403Xcn2IPemD+OlAXXm4naMDFxdMCJPYSk5Z3+u0DXukmkWVwHQsOtDi8TkFhrrK
         7yD0BHQWwgeYkYSWs20bFQ/2f3H+ycL3NVTDlK3GQeNAXoTj34/lT/L66NQVBB1VdnhX
         7UqOkZlaG4nMvdMP2BzaR4TUN6d19syxSUm94/DmsxCE+FrZut7O6dCeGJ6Zl+IfJ74N
         gg9w==
X-Gm-Message-State: AOJu0YxWiyay2Hbo8fH+Y/1LuCGRtk3+DgnnmG0lOiQZ4GxMXSnAUTZi
	yXo6cZMv9dp4hltAUQX/NmjunPTJCBPPFcTU7ngZRgVtT9F4wYbpuT8zdIvslx1m76he1g==
X-Gm-Gg: AR+sD12SqcaOKGzJ9vWs57ZiUC2XJpZbSSERxiXCU/HNrudiOpYA1nEoQ6hLhTDoitR
	LqgBKWGHL4/QE9saIXZmvJhlG/nvg2Y9KWkr5QsvzIF9/Bjy8CHhJsiy5cbJXF4craY2pwYiQjQ
	n1topWKaHKYxfyboMZM8el15uQiLxnZRiSiSPcA2J38dNtrQhxenx7pL1l0KEUjX3aHAB+I76X+
	KxJRSpgfW4wStjl19DINBewFsYFi+MGIp4XYxXHnuY9KN07K9W1KfQHqLn5jOIIBFn8sOxZGbFq
	hfPQCWHeeczFVFQq4uYNbplab9OBJX8CCp7DNxC+PdQbbfgklHS99alWMGsc48PkTMYjbhUPvqp
	UjeYGwwr7/4C31F2XyNBaVINO8IGJGpxs8b2Wac0qDTl4kY5Ksm3kI3dGEXKpBX64kswNG8qN4C
	kg/u8v/6I7RDBjpmsNZo+12Lm4pIYouHyqs80LdSilmFc=
X-Received: by 2002:a17:902:ced0:b0:2ce:b096:e517 with SMTP id d9443c01a7336-2d015ace388mr57857065ad.5.1785296225577;
        Tue, 28 Jul 2026 20:37:05 -0700 (PDT)
Received: from localhost ([2a09:bac5:42f2:1e1e::300:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bcad98sm4346605ad.54.2026.07.28.20.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:37:05 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Coiby Xu <coxu@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 02/10] crash_dump: Fix potential double free and UAF of keys_header
Date: Wed, 29 Jul 2026 11:36:42 +0800
Message-ID: <20260729033654.311541-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729033654.311541-1-coiby.xu@gmail.com>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_203706_547150_A1A8B9A2 
X-CRM114-Status: GOOD (  20.54  )
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
 kernel/crash_dump_dm_crypt.c | 66 ++++++++++++++++++++++++++----------
 kernel/kexec_file.c          |  2 ++
 3 files changed, 56 insertions(+), 18 deletions(-)

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
index c685497cd470..4335b6cb1fc4 100644
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
@@ -286,17 +293,28 @@ static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
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
@@ -369,9 +387,6 @@ static int build_keys_header(void)
 	struct config_key *key;
 	int i, r;
 
-	if (keys_header != NULL)
-		kvfree(keys_header);
-
 	keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
 	if (!keys_header)
 		return -ENOMEM;
@@ -415,8 +430,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 		.top_down = false,
 		.random = true,
 	};
-	int r;
-
+	int r = 0;
 
 	if (key_count <= 0) {
 		kexec_dprintk("No dm-crypt keys\n");
@@ -424,14 +438,15 @@ int crash_load_dm_crypt_keys(struct kimage *image)
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
 
@@ -441,18 +456,33 @@ int crash_load_dm_crypt_keys(struct kimage *image)
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
2.55.0



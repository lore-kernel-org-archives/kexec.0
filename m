Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734B8C61DCD
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 08:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pocGFIirgSi1A7XDDdcVKS31AoGl5aEaP8HYQb/Z4kY=; b=fQYRcL4eNa/LX677lAqLHjDPJO
	qvhT8mHrbkj/gpVrjHwkmXLybFGHBj+HxR11L0QcprxPWlJAH7djw+fDxy8x74x2J9XiLglDwRf1e
	/L+RZLODV1nSHfC59B9Vc+LXNRoIefux9AOoQ2oDcWMY1dCXMFMrrfVoVa11+c/c9J/Lyc3nea9w4
	/+4FBcQiLSI/okQ/mApgeQYi58jJx1h+ppGz6mpcjBSfuM5bDET2JO+jHXBKtX/eiOTNzf0U/ks4A
	AqPYueyWV1g4hJyyZuiyp1lEq47e2KWcAvuhnQambEueUVAfz/w9RlcN1a5fClQcGd/XIrhKlu/XG
	XGc8eaZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsGt-00000005LND-1Ul4;
	Fri, 28 Aug 2026 08:49:11 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsGr-00000005LLr-3OuU
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 08:49:10 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2d530328efbso7205795ad.0
        for <kexec@lists.infradead.org>; Fri, 28 Aug 2026 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906949; x=1788511749; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pocGFIirgSi1A7XDDdcVKS31AoGl5aEaP8HYQb/Z4kY=;
        b=C5JUxomYIFMwTvlnyyXhlpu9XkkVpNYJeY12JGgbgOa8qG4FpQrvDl92/akjI+liwU
         /J4e1ChfQqsRWIDCHXKuvV+R13/IyZPhTPkxZp7FNWuznDb+1EmKgscBXrBjl6OjEJ9B
         DrcXwqbhye8N7SxOWoluBkPocIsoPOgGz8rmXQTmbBZWHm92vWdKtgRuPMFKAkGny0FP
         /IlkhiTaWzhLnoH5B6vzJjTFUvAPvLpqXr6jpxqC1UBt8I+1MZ6T0GbUmxWjwOZ1RSS9
         wVy083Q3Wz7VOTNF65pzglwO5A4S312OspNvJb1c3FGTgDbAZ3Y0ypzlWStOAJEAs2wA
         i7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906949; x=1788511749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pocGFIirgSi1A7XDDdcVKS31AoGl5aEaP8HYQb/Z4kY=;
        b=URq/h4N/N2im3dTIRDniCjwemaM/ixQEdSJCld9OTrNqOSzUUumBVgyJbt+fh3R1sB
         OfjzwsFSJChNS1jR5SUaexq76hypgzr6v2Q5tRGsXUmXkQXoJaElFskxlogQECTmSI8Y
         cwtE1AUdEzz4l+qlNaS0+pNNcwjo6W/2XLRLus1Yy/beM03EIbBbHogHbMjWlVa8iT+A
         LtVThmdt6uxtsQl/Oq7/fLyK3eNOUJjX38qnE10/ZfBXQmH5h3cfufVOcqCafuoGMQIK
         Gz4u+GWo6ytwLAuHvSnA44uPWGbkVV06jaXwFxib0QPTGw91LUqh2pYFJBbcNodw7wnE
         HRrg==
X-Gm-Message-State: AFuF++lhkr9OSfYCNY/oSr5zw/54W0FBPfGI/WAYsPQAaz7KKm8x3YhQ
	zBeT7KwjEiPTMoaYUQAVsLrF/+T9bybpaFVZQBw4p7GwR27P3axglQOWXjnSqusbT+A=
X-Gm-Gg: AR+sD11HHisk6FBEUlfA06Jj6zpHJU/e/JfSJliRL+/FMgEr36iSPFU0EtYqPT+c+Iy
	lu6YydNH2t5PlGos5a7IUi+x4Mt3OAHbrH7UVHN+leSwe8ngtdnTRmOZUAYu/GS0Dt8PRWen4BJ
	N8YI54S1dtYbfNE9cVDhcOPWDtNuxR8OFIj3knyUBcO/6jiJgoSFvbkdugPOhyvK/tZPregc7Yg
	+/PVkYlFz3AP6p7D1fPvwCnfBHtM1A2bbOyJYUcq4yhe8MNj2f2AnBGRoeQlLZKvTUPmpjfV7DW
	Kv6mYCpyOwswC2jm2/U+wNLxJJYWf03s11ulN4pGseiFK2pslcSXVA2AP120XekLZ3LOS/gjZIX
	7SA+sb7Jgbpb8XSuwhrH3bmqMvdQmtrKi7DGUqc0ztA4Q4s89QrIFnzXHUd2NtN1MBWJTH0Lmxf
	7b9p9vtrHQ7OZxA5oQDehKpickUeTzsiau8vUHYZpcmfaqJIlF6+LaVsenvvIBtqVgLJ2/0A==
X-Received: by 2002:a17:903:46cb:b0:2d6:3c22:99bf with SMTP id d9443c01a7336-2d74deed252mr104246205ad.9.1787906948801;
        Fri, 28 Aug 2026 01:49:08 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:a97:707e:a14f:cfbf:3e23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9595bbsm3918689eec.14.2026.08.28.01.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:49:08 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/9] crash_dump: Fix potential double free and UAF of keys_header
Date: Fri, 28 Aug 2026 16:48:47 +0800
Message-ID: <20260828084900.1496839-2-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828084900.1496839-1-coiby.xu@gmail.com>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_014909_855785_1F7144B8 
X-CRM114-Status: GOOD (  19.50  )
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
index 0af8ae4fdd08..0fa8bac04576 100644
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
index 59fb9d71e9d8..062f7e79016d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -140,6 +140,8 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	kfree(image->image_loader_data);
 	image->image_loader_data = NULL;
 
+	kexec_file_post_load_cleanup_dm_crypt(image);
+
 	kexec_file_dbg_print = false;
 }
 
-- 
2.55.0



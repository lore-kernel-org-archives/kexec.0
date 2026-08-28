Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B930C61DCD
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ahU4MpfS6Yf/uSMGEJ479IVkDuuOkM6vl8lIUM4s9Q=; b=CSNaIA/Ct5A0svbXOcmQSw1vmC
	EkcDqQwbmpa5G4OLVUgBxn3I5u4ASmqFcrrRkFEMdCCCtJk0HrQKiOcWymQ/jJ/6BqW3MuYS9QjLe
	v8Igjq8yzd5MEO7tGAHkfzgKKLrj0Z6bitGxsQmVFaKiBB/ut3/e5ceQfFza0tWzIrxB9Qbx5cBck
	wv6ILuKr/x3fG9j9I3jD77ztgWY3czidZR03NsfUJq667DRqHgiJuN8dmfbhN84yXIRM6rjN7REci
	rRtby1dnmOf+owcYCnrSPv5QfrhBTE9jN6RCxbyhvOUXYKWTQb93pkt/yE+gkjZKoNgS6X+AJsUap
	c7eXzj9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsH3-00000005LWR-0JvR;
	Fri, 28 Aug 2026 08:49:21 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsGy-00000005LRn-3JyW
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 08:49:18 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2d71a50caa9so9719585ad.0
        for <kexec@lists.infradead.org>; Fri, 28 Aug 2026 01:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906956; x=1788511756; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ahU4MpfS6Yf/uSMGEJ479IVkDuuOkM6vl8lIUM4s9Q=;
        b=RZjnjLLjDOZL1HuF2NtUCT5Faux86lBHpSQbZptxKGj2u2nDkWa8dHC3lXqZN2Ct8W
         4nBwEVTXYC7eUKQUSvBNrTkKWJTyEvr6SHUUcI7AKu0InLxdJuANHQ7Abaf5+jz3pqpn
         u0BaPfoMVlxB4DSA4/p/E9DgvmQHI+WBusDCisO7CeI/wNTDnXeHIQYfyty9kbrJWCAu
         3D2G9Ts8yDWvHAq0YVPZCWn8DOBh8SCcOxDxMamUgppFjwSuZ2nXl61HrxHAafNI3Evx
         wFwu080BpWNQlMOtBlZJpCEzg8uUgDTiIQqaznsFya7FIHpJVHLlHmjpomWUwZX89vvB
         iKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906956; x=1788511756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ahU4MpfS6Yf/uSMGEJ479IVkDuuOkM6vl8lIUM4s9Q=;
        b=Jr/ViylpsEA70TV2mOdq9Z7m3NZcDYqFy2xrpA9XXLHS0gsmANxbXmF9NFL6a+LbNF
         ny99KEOaTerpDGZ/F+4bmRdd7uBktkn5Ms3UbMmbZPjjjWyVMg+kTGLs+yjTx4HSvUJ+
         UPGt25aueW7htmSJm6BCMP09n0u+2afjIvxXB7SaXlgcmHbZG66pLIrQCbcUIGL20I0M
         YW2b6JsZLxniQyMRqSGutmz73i+TNQzujg00vziM/1crcvtwVGwFMwwMe0OiQxOeAmP6
         oDuwAShUUG7nxetEHltxz5FgfAZOfCXOFuWdWXsMPtCxDc0/y/wWo+CoeEF8swf1st+H
         P0Vw==
X-Gm-Message-State: AFuF++lpMokOu/LZMNCjpDc+YX1ok60qVzgpNMdrz2bf8VXUzn7fA/fc
	KMHyCQ0pGKA2FnVuSrCBikd68cuQceRdLxWcp/lE3fVHgpWJ8wkSl6SOPI1a0HXrKLg=
X-Gm-Gg: AR+sD1347wFFWCbOOhEQGbtOKByVIaCIZKWGfkQFe6pmeiITFk2d/XPuLOc82zvy4mm
	UkX7FS+EM3nNKmXKi4X80T++KVkN4pOwQwHZ1NG6hay2t5Xo1By+N3er3n9padROOLTxSMhwqcB
	qKSdbcQ/YFAoLk2tFD7F67iU7biw+wjzxxKc8Se+EaShOWf4TAWG31Wu1hBrGlqPzoSC5TlZWPq
	TLT/K6BmqJEK9vz8s+N2P1arBsxrxgQpo7xsuT5deCwmL4ziAJJPqv8tl9Jt5SFW9MvLT5knlFW
	PuSWqsnbMwURVGJ1fnXTx2kzo5pposHzVzm5o1gEaZJXdFW6gyVCafX22vrenavtVe6zl4v4K63
	I78cVnVvC1gIa+k+oKKHQzDoSn6JKrxDY/vF2iTTKhZ3AYL4wQ9v4Wzml4sErmjljHJOFDQUDX9
	gk7fA59gxU66syMdqEOAwZK28XeE1IR03UOGBVzsNLNQC+afkOHat2OiO0hjln
X-Received: by 2002:a17:902:d2c7:b0:2d7:7cb:a44a with SMTP id d9443c01a7336-2d74ddc21d7mr99437415ad.11.1787906955877;
        Fri, 28 Aug 2026 01:49:15 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:a97:707e:a14f:cfbf:3e23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f995e60sm3698598eec.22.2026.08.28.01.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:49:15 -0700 (PDT)
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
Subject: [PATCH v4 3/9] crash_dump: Read the number of dm-crypt keys from reserved memory
Date: Fri, 28 Aug 2026 16:48:49 +0800
Message-ID: <20260828084900.1496839-4-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828084900.1496839-1-coiby.xu@gmail.com>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_014916_833804_18C2B748 
X-CRM114-Status: GOOD (  13.40  )
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

In case user adds/deletes the keys by mistake, it's safer to read the
number of keys from reserved memory.

Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
Reported-and-Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 026c7de4ad85..0b9e09c60745 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -89,21 +89,31 @@ static int get_keys_from_kdump_reserved_memory(void)
 {
 	struct keys_header *keys_header_loaded;
 	size_t keys_header_size;
-
-	keys_header_size = get_keys_header_size(key_count);
-	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
-	if (!keys_header)
-		return -ENOMEM;
+	int r = 0;
 
 	arch_kexec_unprotect_crashkres();
 	keys_header_loaded = kmap_local_page(pfn_to_page(
 		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
 
+	if (keys_header_loaded->total_keys <= 0 ||
+	    keys_header_loaded->total_keys > KEY_NUM_MAX) {
+		pr_warn("keys_header saved to reserved memory may be corrupt\n");
+		r = -EINVAL;
+		goto kunmap;
+	}
+
+	keys_header_size = get_keys_header_size(keys_header_loaded->total_keys);
+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
+	if (!keys_header) {
+		r = -ENOMEM;
+		goto kunmap;
+	}
+
 	memcpy(keys_header, keys_header_loaded, keys_header_size);
+kunmap:
 	kunmap_local(keys_header_loaded);
 	arch_kexec_protect_crashkres();
-
-	return 0;
+	return r;
 }
 
 static int restore_dm_crypt_keys_to_thread_keyring(void)
@@ -447,12 +457,12 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	mutex_lock(&config_keys_subsys.su_mutex);
 	mutex_acquired = true;
 
-	if (key_count <= 0) {
-		kexec_dprintk("No dm-crypt keys\n");
-		return 0;
-	}
-
 	if (!is_dm_key_reused) {
+		if (key_count <= 0) {
+			kexec_dprintk("No dm-crypt keys\n");
+			return 0;
+		}
+
 		r = build_keys_header();
 		if (r)
 			goto out;
@@ -463,7 +473,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	 * cleaned up at the end of kexec_file_load syscall
 	 */
 	kbuf.buffer = keys_header;
-	kbuf.bufsz = get_keys_header_size(key_count);
+	kbuf.bufsz = get_keys_header_size(keys_header->total_keys);
 
 	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
-- 
2.55.0



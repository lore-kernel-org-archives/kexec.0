Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1EEC53219
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 03:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vxmlwNVtuVCj9KzbSqHlJa35Lwuk28K9I8I/7plDAtE=; b=Zfsf6HmQNXxZikJPvPRF359ayS
	A/zatPpnAmDKgZMyhzJ8S8ib2LNXCRR6u57DgZeqAGOScdiZfZ4V6y/OKOzch4g4lYEhz1FraGR/U
	YO99WmaklpF6O/Ur14GZIA7XSGVf5SsJ0EQXg4BlFprsXP9B6nMyfy83ZVTJ1iBZmt80OhXigRnpl
	QYAfWooEZ+hCYNQk8gY+2/hRA83JM/qt0GQopBz8FZ8r/0J89DEsKQra78TRMTq47bS5J3xuSfrYX
	XUXQVISbzXfGKop8K8KJFgbMn2vlCM7VMOHde538IBa5SqxrBxEmfy7h7m5NN+IWXWBX1iv62ago5
	V+c7wUNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6j-00000006lW2-33A4;
	Wed, 29 Jul 2026 03:37:25 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6h-00000006lUv-264g
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 03:37:24 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-848643382fcso566280b3a.1
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 20:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296243; x=1785901043; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vxmlwNVtuVCj9KzbSqHlJa35Lwuk28K9I8I/7plDAtE=;
        b=qxm0bHmIaLzKDhUCW69kz4ZgAtftyLvE5IlcXW/z/GQVkIhTl55QS+woSuas1yVWrN
         jRKiR7WGuamT3Ynl3fiMGzTwE4sA+JdXLBp4FNes417g8CR8nG/LZg/lfhTSkx4ONCFP
         Tfb74dfafZ7kRdxQzOugnH8EpN5/x4vk/sE0wqmzUAmJBnYhzXPQBqBfPXLrGi6bie6w
         IxPj08ezXcLz1fYDqJxz+iaGdfRmx6Wh+vIukUptavN5J8pkF+bfI6fcBTt4TbR3W5Dg
         KwPrjat2VJffjGD8Ou5ur7CZE5TQJJC0qPWAge5yjZODqiRGmyH/RF9+aloDR8oHpwb7
         jXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296243; x=1785901043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vxmlwNVtuVCj9KzbSqHlJa35Lwuk28K9I8I/7plDAtE=;
        b=kXK8yQHkd/m3atj7v44T7VEEWECbi9JY1yndfjqKTyrQYf92ctHppVxWBD7bjcYiiC
         /jHNc+eTcSXl6sWyuc4N6+tBz8jWUAjWntIY6716suy+xpxgfMB6JHyP3D0VNL9674wn
         8CjfVKlpv9uMddlIkuyyLM1ZHJ5VlzpspbGb5QNzxo2eyeUd3aoD0JZ9aCohBVUbLGz5
         YHzi8rw07KogHJ2xM+5TuL3p4WCrwsGHvKfZwvBPKWLLCkl535Bg9gcIWGki91I1VlU8
         vRDmWvt2945aqYPlQf4irto7lvLEsKUQ5Qg1N7dHlM8KOBYlMPmv2tKJYsxUY0PeyMW0
         4U1Q==
X-Gm-Message-State: AOJu0Ywwy/G3+xJzTizc+l2AwZQ1dZrH8vT4zMtVml0JEwfUHSsO5tvl
	LhiUCkOIDh5FJx3meCiIo5Edoa6/btTf6SIGymNYBqAKcaWHOOsRQ9MOHXo8yWrMep5Gmw==
X-Gm-Gg: AR+sD11AKgfpc8HcPrgCAGMigSfn0YO0NY6VrFtNPeCUqY57Ng5dkOQioQvmFBwI8F5
	6YwUKtxVn694P+n886V/P0wszXxNG+vKo4ZGJiBX817GoQDGurErpsHBqDZDiWJSLH4Ug7oNpaR
	2CNUTglODHrab5JIasX2fT8qF24AQbdxgZI5g6/QYKjlLa6VmndSf3CVwWeQx9L9nIld6AfOgEP
	ospKqflNgV5RcvW8hunxmQ2Iv60avQJkazzVpnruzTyI3uKCCoadxvtkwuKZjBrt/rV73m4cAa+
	d3K3tlfTj+urFEk3Yrm20dQSqA4sg5WoSbqQ0KcX9BPWbLHcrGFb5Kbjn7vS66P1yLgMqGRSTyM
	K7wgf1GyM8cBBzm6IqcahZRRcbRpx+/cc9GkRHFsIEkCuEYpH808Cg9dKM9xVjM2zD5igHQOD4V
	kTGbosR+1KJ3acV/21MPj/QlN8IUGP0ICwOr/+eDKC6FM=
X-Received: by 2002:a05:6a00:1152:b0:847:968d:b101 with SMTP id d2e1a72fcca58-84e93234afemr5348185b3a.21.1785296242830;
        Tue, 28 Jul 2026 20:37:22 -0700 (PDT)
Received: from localhost ([2a09:bac5:42f2:1e1e::300:30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe2393csm694329b3a.10.2026.07.28.20.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:37:22 -0700 (PDT)
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
Subject: [PATCH v3 06/10] crash_dump: Only use kexec_dprintk during the kexec_file_load syscall
Date: Wed, 29 Jul 2026 11:36:46 +0800
Message-ID: <20260729033654.311541-7-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729033654.311541-1-coiby.xu@gmail.com>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_203723_580437_52D0E6B4 
X-CRM114-Status: GOOD (  13.06  )
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

kexec_dprintk will only be activated by "kexec -d" during
kexec_file_load syscall. So use pr_* outside of this syscall.

Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 9a64e2d6841b..3ee01996778f 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -75,10 +75,10 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
 	if (!IS_ERR(key_ref)) {
 		r = key_ref_to_ptr(key_ref)->serial;
 		key_ref_put(key_ref);
-		kexec_dprintk("Success adding key %s", dm_key->key_desc);
+		pr_debug("Success adding key %s", dm_key->key_desc);
 	} else {
 		r = PTR_ERR(key_ref);
-		kexec_dprintk("Error when adding key");
+		pr_warn("Error when adding key");
 	}
 
 	return r;
@@ -128,19 +128,19 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 	keyring_ref =
 		lookup_user_key(KEY_SPEC_USER_KEYRING, 0x01, KEY_NEED_WRITE);
 	if (IS_ERR(keyring_ref)) {
-		kexec_dprintk("Failed to get the user keyring\n");
+		pr_warn("Failed to get the user keyring\n");
 		return PTR_ERR(keyring_ref);
 	}
 
 	addr = dm_crypt_keys_addr;
 	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
 	if (key_count > KEY_NUM_MAX) {
-		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
+		pr_warn("Failed to read the number of dm-crypt keys\n");
 		ret = -1;
 		goto out;
 	}
 
-	kexec_dprintk("There are %u keys\n", key_count);
+	pr_debug("There are %u keys\n", key_count);
 	addr = dm_crypt_keys_addr;
 
 	keys_header_size = get_keys_header_size(key_count);
@@ -154,7 +154,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 
 	for (int i = 0; i < keys_header->total_keys; i++) {
 		key = &keys_header->keys[i];
-		kexec_dprintk("Get key (size=%u)\n", key->key_size);
+		pr_debug("Get key (size=%u)\n", key->key_size);
 		add_key_to_keyring(key, keyring_ref);
 	}
 
@@ -309,8 +309,7 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
 	int r;
 
 	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
-		kexec_dprintk(
-			"dm-crypt keys haven't be saved to crash-reserved memory\n");
+		pr_debug("dm-crypt keys haven't be saved to crash-reserved memory\n");
 		return -EINVAL;
 	}
 
-- 
2.55.0



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CBFC4345F
	for <kexec@archiver.kernel.org>; Thu, 25 Apr 2024 10:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CyVEZf9vT6+rVWgJvZ/wS9BiM/fwQbF9iT47qSXbAsE=; b=XinEP7OTH357co
	zDMPcFx8YJAmF4tWwcT2FobUBUVcv6b2ARY8kvEZSQ6dnZQSKl0hMLf/6cpwbRf+BSAChfqzz6yEO
	Raby2ZQoiQE+er4CQH53takmw6qDo78Pzc3ZY7oYzmFbuawrCPUGhkU67Bxd2kc0E9j/NttZ30P4V
	RXTX7p8k7tAjdpS3wVktxIJLitrmTiX5x/Tl3cROk2OVlQ+nevnRlWnVUJcHIW4V8CW4nuevxtyAU
	T6FhWZt991BDNMdhqeUGZOc58rfOM/tQv4HLPqPlU9DltmoWr8JIFJpaOrUjw/F0aa9cb/mnC4g6d
	YfMhjVoHTBHSp43MsWJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyQ-00000007kmO-3sv1;
	Thu, 25 Apr 2024 10:05:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyN-00000007kiS-1aH2
	for kexec@lists.infradead.org;
	Thu, 25 Apr 2024 10:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtIYIJYKyy/5qzi0n/PqpS95u6O7t7oyOgbotIXFy7M=;
	b=GnY0pNynEcwRu28ktWM+0AS9CAMt1aWqAavPNwtXv8yUrl66NvZ1lz9bFOXuQd8mk8CzhT
	yUx2owYdMmi47CYdWP9Xr8BR3QiVKFAS0FekbbPBlvSM7bvswxkN5V3FL+bCg8eTTH4SFc
	HRSzID7TMKhxYs0+40SdhcfPkihhQew=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-LltrqzsCNAm-u89FFrAFTg-1; Thu, 25 Apr 2024 06:04:57 -0400
X-MC-Unique: LltrqzsCNAm-u89FFrAFTg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e2a5cb5455so10042345ad.2
        for <kexec@lists.infradead.org>; Thu, 25 Apr 2024 03:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039495; x=1714644295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtIYIJYKyy/5qzi0n/PqpS95u6O7t7oyOgbotIXFy7M=;
        b=lt7istGbh0r8EkM3DuhsFPWqbLmpmYIelnJcQFr4+pQ617ZlXkdC7TOLFig9OSbrN8
         KTRT5IR2iCOZdoGjzNA9+QR/qLHBKF4XnMewQj4XM33TrQsNey0iqPB1Y8LFsxWBSmHQ
         HQaVqf6oEElxS1aF+YGVSlONYJlpC01fXzFB/JOBxoxohsNHW3JgH6gHgEGT7AD7B3Ji
         MtD7Hc2swn9pIGp5idUNghGOzugN9d37ndqMjhi1K/bv505kp96VXB+FvFdFK4AiP9CX
         R8BIJf6zvyNJ12H3zHaA6XI+Bj/d0bDj+Vu9+o0nOM4Jf9u3ICrv4TiGqx1mbcEbd/dY
         5C2A==
X-Gm-Message-State: AOJu0YzaLDZKxserGcQnnHM86EZIl+KcO9ZXYGp2HSi7kqid+UXKRLEk
	qZcBM4KsshrW5XnaEiHiYJLwxnHvi1DcRyPM9uyLqReYjuRFVAYnL8LV4IZeqOux1utgaeF0cYx
	tM66Wyb/DqnH7ERNYZf6BZIWIjy1+7uXWkDrK9VReeo8EbyHsTH5pxML4QiLVasyH5II6YCaRyd
	I23a3apxDYsINTgxjibZeEun7Rl4C7ya7FD/gcYvUjzP9b
X-Received: by 2002:a17:902:f60c:b0:1e4:514a:55af with SMTP id n12-20020a170902f60c00b001e4514a55afmr6469113plg.68.1714039494700;
        Thu, 25 Apr 2024 03:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4PhFmtr7NGtfSylsFrnAzg2TwlhAltH+JWa9HYv31v9hDfa9bCYeS47K2qWKVTo0k9n+0Ng==
X-Received: by 2002:a17:902:f60c:b0:1e4:514a:55af with SMTP id n12-20020a170902f60c00b001e4514a55afmr6469053plg.68.1714039494088;
        Thu, 25 Apr 2024 03:04:54 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b001dcfaf4db22sm13411417ple.2.2024.04.25.03.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:04:53 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v3 5/7] crash_dump: retrieve dm crypt keys in kdump kernel
Date: Thu, 25 Apr 2024 18:04:29 +0800
Message-ID: <20240425100434.198925-6-coxu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425100434.198925-1-coxu@redhat.com>
References: <20240425100434.198925-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_030459_602414_4534C22F 
X-CRM114-Status: GOOD (  19.40  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Crash kernel will retrieve the dm crypt keys based on the dmcryptkeys
command line parameter. When user space writes the key description to
/sys/kernel/crash_dm_crypt_key, the crash kernel will save the
encryption keys to the user keyring. Then user space e.g. cryptsetup's
--volume-key-keyring API can use it to unlock the encrypted device.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h   |  1 +
 kernel/crash_dump_dm_crypt.c | 99 +++++++++++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 1f3d5a4fa6c1..1996e0739b6d 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -38,6 +38,7 @@ static inline void arch_kexec_unprotect_crashkres(void) { }
 int crash_sysfs_dm_crypt_keys_read(char *buf);
 int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
 int crash_load_dm_crypt_keys(struct kimage *image);
+ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
 #else
 static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
 #endif
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 6ac1fabdb6cb..9ddfe4c4d755 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -33,12 +33,67 @@ struct keys_header {
 	struct dm_crypt_key keys[] __counted_by(key_count);
 } *keys_header;
 
+unsigned long long dm_crypt_keys_addr;
+EXPORT_SYMBOL_GPL(dm_crypt_keys_addr);
+
+static int __init setup_dmcryptkeys(char *arg)
+{
+	char *end;
+
+	if (!arg)
+		return -EINVAL;
+	dm_crypt_keys_addr = memparse(arg, &end);
+	if (end > arg)
+		return 0;
+
+	dm_crypt_keys_addr = 0;
+	return -EINVAL;
+}
+
+early_param("dmcryptkeys", setup_dmcryptkeys);
+
 static size_t get_keys_header_size(struct keys_header *keys_header,
 				   size_t key_count)
 {
 	return struct_size(keys_header, keys, key_count);
 }
 
+/*
+ * Architectures may override this function to read dm crypt key
+ */
+ssize_t __weak dm_crypt_keys_read(char *buf, size_t count, u64 *ppos)
+{
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	return read_from_oldmem(&iter, count, ppos, false);
+}
+
+static int add_key_to_keyring(struct dm_crypt_key *dm_key,
+			      key_ref_t keyring_ref)
+{
+	key_ref_t key_ref;
+	int r;
+
+	/* create or update the requested key and add it to the target keyring */
+	key_ref = key_create_or_update(keyring_ref, "user", dm_key->key_desc,
+				       dm_key->data, dm_key->key_size,
+				       KEY_USR_ALL, KEY_ALLOC_IN_QUOTA);
+
+	if (!IS_ERR(key_ref)) {
+		r = key_ref_to_ptr(key_ref)->serial;
+		key_ref_put(key_ref);
+		pr_alert("Success adding key %s", dm_key->key_desc);
+	} else {
+		r = PTR_ERR(key_ref);
+		pr_alert("Error when adding key");
+	}
+
+	key_ref_put(keyring_ref);
+	return r;
+}
+
 static int init(const char *buf)
 {
 	unsigned int total_keys;
@@ -120,11 +175,53 @@ static int process_cmd(const char *buf, size_t count)
 	return -EINVAL;
 }
 
+static int restore_dm_crypt_keys_to_thread_keyring(const char *key_desc)
+{
+	struct dm_crypt_key *key;
+	key_ref_t keyring_ref;
+	u64 addr;
+
+	/* find the target keyring (which must be writable) */
+	keyring_ref =
+		lookup_user_key(KEY_SPEC_USER_KEYRING, 0x01, KEY_NEED_WRITE);
+	if (IS_ERR(keyring_ref)) {
+		pr_alert("Failed to get keyring");
+		return PTR_ERR(keyring_ref);
+	}
+
+	addr = dm_crypt_keys_addr;
+	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
+	if (key_count < 0 || key_count > KEY_NUM_MAX) {
+		pr_info("Failed to the number of dm_crypt keys\n");
+		return -1;
+	}
+
+	pr_debug("There are %u keys\n", key_count);
+	addr = dm_crypt_keys_addr;
+
+	keys_header_size = get_keys_header_size(keys_header, key_count);
+
+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
+	if (!keys_header)
+		return -ENOMEM;
+
+	dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
+
+	for (int i = 0; i < keys_header->key_count; i++) {
+		key = &keys_header->keys[i];
+		pr_alert("Get key (size=%u): %8ph...\n", key->key_size, key->data);
+		add_key_to_keyring(key, keyring_ref);
+	}
+
+	return 0;
+}
+
 int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count)
 {
 	if (!is_kdump_kernel())
 		return process_cmd(buf, count);
-	return -EINVAL;
+	else
+		return restore_dm_crypt_keys_to_thread_keyring(buf);
 }
 EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_write);
 
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

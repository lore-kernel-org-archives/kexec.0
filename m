Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5512EC02183
	for <kexec@archiver.kernel.org>; Thu, 16 Jan 2025 07:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BviejlZNnl86qGI7QFJAbkZWtNOpYFXBNGiYqPEuqFo=; b=Hn4aJEXC8RXzRiVx9ut0ETkgG9
	OR0A7WclSca5F5pNb0RJXPaLGHRgrIVe/H4Xwyc02+MjO1XN6TT76oU5r2TMz0YONEbISu9cW4eGi
	hGjQRBF7zmT7UT7Sr7iXICNYGmoCE8KLyxbJ0QpP1LN+Y7SvoASi5fLTsQGWetMtDL64euY8xTHXR
	ojY1yM/uTqS2siX4bfCLDk7acFmn9wiHTAizdlKvodv7q6L1ZFlD09fDzKUPJra38Gl4GaKGRr2bO
	hfI6YF21gdFIyxrcp9p+7Kpsp3AQaefFlonTdW0Bazilj6WjTo//Hm5lSkhwXrpu08oOuzLhmxiuh
	uDY7FNEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYKKf-0000000E31C-1JE5;
	Thu, 16 Jan 2025 07:30:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYKJR-0000000E2ig-45K4
	for kexec@lists.infradead.org;
	Thu, 16 Jan 2025 07:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737012549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BviejlZNnl86qGI7QFJAbkZWtNOpYFXBNGiYqPEuqFo=;
	b=XYR2KjPF7HbxuiB+amJZ/qvWU2PgHSQ6ZDpFE5TBhFVHxxwq+TIz36PYXfCqEzLJOFWnDh
	k+zZrlcQLakmSPrgtvkmTiemeTrB/a1NoLkfsGQaQ3afjPnAh/jFaxvcwC8cJvEsoEnMzx
	NvVvTXLX4ugkUtC8VAH7Qom6yC4e8pc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-zivd9jBmMmSbxBXYK5-_VQ-1; Thu, 16 Jan 2025 02:29:07 -0500
X-MC-Unique: zivd9jBmMmSbxBXYK5-_VQ-1
X-Mimecast-MFC-AGG-ID: zivd9jBmMmSbxBXYK5-_VQ
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21648c8601cso11765875ad.2
        for <kexec@lists.infradead.org>; Wed, 15 Jan 2025 23:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737012542; x=1737617342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BviejlZNnl86qGI7QFJAbkZWtNOpYFXBNGiYqPEuqFo=;
        b=UAIIy0ETvdUFhrterWHCqGDV9D5uMU5DcQfx05ULoXceh13oWrVxGCrqXl7cCpKCqU
         J/Ge5yv03oZvOoKCW6SWlEpA5owGuepOvcbyYNXavcD9grabpBpROggAb7RNORkgDNYo
         RWByPG+qFJiHfQYK1bWIIzE+FVanfNPpXX6rBl3tmaKN4cN8zXAqY/TV6CYyME8KVV8m
         3NPePpyREHDftDO/FaxNvReVzxmryt5nWjfMmMrrbTfGWULtZItSjaQf3oQqzKnCqcdn
         i5F3BPAq3NWKgTum5XsSI5Rjzz75FMy8AVwQZOqnA0PgKIRzSDNR337ueVvlxzX4Ai4p
         393Q==
X-Gm-Message-State: AOJu0Yzc3pheegJoSUzF2ZXmeusj5JxqnKgykc1Por0+XEDTGIk/v/7h
	lwhGyc5esVWpPD2X+CbAGet8wuSSWbYRp1UkqPbq9CE4Ype94WvsxZZR+3TlmhP2n/vd0n2B138
	wLIj9aJjTK68tliQ5xKuHjLPGnn/Fa5JM0aO9fL5kb+7gTpEx1RASEY4diWQWWdfIK3r6iTTqJF
	2FRPg1MTXXGG68koPrdAmiR/8tjc9JfdcHkHOujew=
X-Gm-Gg: ASbGncvldaQmRW7rcelHzPvnVib5B81ELFFuqprWmNWNGzd2omLzZ82g5PFi1BHAkaX
	CZeK+9iavY74JGivX9/a4ABQgHkLn0KEvnU0tS8eQU9+XnDbN2lDHQ86Ry3/HlzN+DgrUva0u+i
	JDuJrdJ9240euGjUfCPA/13gYTBrHDUlhhEaSqydKKalMukA6zH1A7fiUG94p8iGgjPfAGu6j5s
	vv7k1bTibxby89C2SynxtJp76FO/c6MzXh+ViJQwT4XRWlI
X-Received: by 2002:a05:6a20:4393:b0:1e1:ca91:b0e3 with SMTP id adf61e73a8af0-1e88d09e17fmr54696917637.36.1737012541756;
        Wed, 15 Jan 2025 23:29:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHio3Q2Kz/zxkpeLrjgicFr6Y9U5ULOIgFM/y3NNp5ky9pUuLwqSiLamGdZ9OG5RK5mUgglkA==
X-Received: by 2002:a05:6a20:4393:b0:1e1:ca91:b0e3 with SMTP id adf61e73a8af0-1e88d09e17fmr54696866637.36.1737012541275;
        Wed, 15 Jan 2025 23:29:01 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4054847esm10654849b3a.11.2025.01.15.23.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 23:29:00 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v7 5/7] crash_dump: retrieve dm crypt keys in kdump kernel
Date: Thu, 16 Jan 2025 15:28:57 +0800
Message-ID: <20250116072858.1043529-1-coxu@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116065825.1041558-1-coxu@redhat.com>
References: <20250116065825.1041558-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kjuTJ7m_XUoZlFGqqCbBec3x-ruhUwplTRTWZad-fYc_1737012547
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_232910_081531_1252FED5 
X-CRM114-Status: GOOD (  22.99  )
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

Crash kernel will retrieve the dm crypt keys based on the dmcryptkeys
command line parameter. When user space writes the key description to
/sys/kernel/config/crash_dm_crypt_key/restore, the crash kernel will
save the encryption keys to the user keyring. Then user space e.g.
cryptsetup's --volume-key-keyring API can use it to unlock the encrypted
device.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h   |   1 +
 include/linux/crash_dump.h   |   2 +
 kernel/crash_dump_dm_crypt.c | 134 ++++++++++++++++++++++++++++++++++-
 3 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 2e6782239034..d35726d6a415 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -36,6 +36,7 @@ static inline void arch_kexec_unprotect_crashkres(void) { }
 
 #ifdef CONFIG_CRASH_DM_CRYPT
 int crash_load_dm_crypt_keys(struct kimage *image);
+ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
 #else
 static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
 #endif
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index acc55626afdc..dfd8e4fe6129 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -15,6 +15,8 @@
 extern unsigned long long elfcorehdr_addr;
 extern unsigned long long elfcorehdr_size;
 
+extern unsigned long long dm_crypt_keys_addr;
+
 #ifdef CONFIG_CRASH_DUMP
 extern int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size);
 extern void elfcorehdr_free(unsigned long long addr);
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 328d3dd0d8f6..993d9e08d774 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -3,6 +3,7 @@
 #include <linux/keyctl.h>
 #include <keys/user-type.h>
 #include <linux/crash_dump.h>
+#include <linux/cc_platform.h>
 #include <linux/configfs.h>
 #include <linux/module.h>
 
@@ -28,6 +29,61 @@ static size_t get_keys_header_size(size_t total_keys)
 	return struct_size(keys_header, keys, total_keys);
 }
 
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
+/*
+ * Architectures may override this function to read dm crypt keys
+ */
+ssize_t __weak dm_crypt_keys_read(char *buf, size_t count, u64 *ppos)
+{
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	return read_from_oldmem(&iter, count, ppos, cc_platform_has(CC_ATTR_MEM_ENCRYPT));
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
+		kexec_dprintk("Success adding key %s", dm_key->key_desc);
+	} else {
+		r = PTR_ERR(key_ref);
+		kexec_dprintk("Error when adding key");
+	}
+
+	key_ref_put(keyring_ref);
+	return r;
+}
+
 static void get_keys_from_kdump_reserved_memory(void)
 {
 	struct keys_header *keys_header_loaded;
@@ -42,6 +98,47 @@ static void get_keys_from_kdump_reserved_memory(void)
 	arch_kexec_protect_crashkres();
 }
 
+static int restore_dm_crypt_keys_to_thread_keyring(void)
+{
+	struct dm_crypt_key *key;
+	size_t keys_header_size;
+	key_ref_t keyring_ref;
+	u64 addr;
+
+	/* find the target keyring (which must be writable) */
+	keyring_ref =
+		lookup_user_key(KEY_SPEC_USER_KEYRING, 0x01, KEY_NEED_WRITE);
+	if (IS_ERR(keyring_ref)) {
+		kexec_dprintk("Failed to get the user keyring\n");
+		return PTR_ERR(keyring_ref);
+	}
+
+	addr = dm_crypt_keys_addr;
+	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
+	if (key_count < 0 || key_count > KEY_NUM_MAX) {
+		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
+		return -1;
+	}
+
+	kexec_dprintk("There are %u keys\n", key_count);
+	addr = dm_crypt_keys_addr;
+
+	keys_header_size = get_keys_header_size(key_count);
+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
+	if (!keys_header)
+		return -ENOMEM;
+
+	dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
+
+	for (int i = 0; i < keys_header->total_keys; i++) {
+		key = &keys_header->keys[i];
+		kexec_dprintk("Get key (size=%u)\n", key->key_size);
+		add_key_to_keyring(key, keyring_ref);
+	}
+
+	return 0;
+}
+
 static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
 {
 	const struct user_key_payload *ukp;
@@ -211,6 +308,37 @@ static const struct config_item_type config_keys_type = {
 	.ct_owner = THIS_MODULE,
 };
 
+static bool restore;
+
+static ssize_t config_keys_restore_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", restore);
+}
+
+static ssize_t config_keys_restore_store(struct config_item *item,
+					  const char *page, size_t count)
+{
+	if (!restore)
+		restore_dm_crypt_keys_to_thread_keyring();
+
+	if (kstrtobool(page, &restore))
+		return -EINVAL;
+
+	return count;
+}
+
+CONFIGFS_ATTR(config_keys_, restore);
+
+static struct configfs_attribute *kdump_config_keys_attrs[] = {
+	&config_keys_attr_restore,
+	NULL,
+};
+
+static const struct config_item_type kdump_config_keys_type = {
+	.ct_attrs = kdump_config_keys_attrs,
+	.ct_owner = THIS_MODULE,
+};
+
 static struct configfs_subsystem config_keys_subsys = {
 	.su_group = {
 		.cg_item = {
@@ -302,11 +430,15 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	return r;
 }
 
-
 static int __init configfs_dmcrypt_keys_init(void)
 {
 	int ret;
 
+	if (is_kdump_kernel()) {
+		config_keys_subsys.su_group.cg_item.ci_type =
+			&kdump_config_keys_type;
+	}
+
 	config_group_init(&config_keys_subsys.su_group);
 	mutex_init(&config_keys_subsys.su_mutex);
 	ret = configfs_register_subsystem(&config_keys_subsys);
-- 
2.47.1



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2690AC02192
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 08:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K4HLB2l94cxI2U1OdfZtSwsiylrY7VkACKgIHY5nsyc=; b=J+aA21mNbZ1XCWoyMLQnh07rfs
	4bgd9VHYE99+wudhfzdxRUAuKfk79KtPEEKt9wzmi6jr0wnW5YBs/wRX8pm+VDksZxfpo2VrP6/hE
	Gl3dr9JTMKLCxMYIfLG0HHiJB6dAHok8fhjtOQh/rgEN976dDrd9vMFf1KagPnflYMbE5PT8gp3cQ
	DZDo+5cVxt3W9kjSFxb/z0fkAGYb2Cn0b/JAlLo8SWvKsIoSO5ByIn8K6cO7CDonLlaVfCuN++Zlc
	vtsmltlGrv42uypDoYFEcyj6Nz1yhvt17IvJdbaF+sUw2rni3DK8bDB9VSz93wcMlu1FX5SffG1PP
	fbCDMwmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJQy-00000008lC0-3Vjm;
	Fri, 07 Feb 2025 08:09:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJPu-00000008knZ-3Xgg
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 08:08:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738915730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4HLB2l94cxI2U1OdfZtSwsiylrY7VkACKgIHY5nsyc=;
	b=RP7uj69KfZ1NcGGJQg4ceJ1YAJIbiVaRe1JP7z06kITn76WBii8BzwWK4vqhbzB2nmUerB
	np9bRndAFNqWFIJiV6R2W2mRZg58croFHJk1Ui6Tq8shKT4mZVppw+QWNfUTXd9o2bqurN
	JJ/G/cUELZ8L0Tqt/EQyvDu2RZ2k2fI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-HvqokkKvOZi-Ok6mVuMiIQ-1; Fri, 07 Feb 2025 03:08:49 -0500
X-MC-Unique: HvqokkKvOZi-Ok6mVuMiIQ-1
X-Mimecast-MFC-AGG-ID: HvqokkKvOZi-Ok6mVuMiIQ
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2163dc0f689so59432985ad.1
        for <kexec@lists.infradead.org>; Fri, 07 Feb 2025 00:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738915724; x=1739520524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4HLB2l94cxI2U1OdfZtSwsiylrY7VkACKgIHY5nsyc=;
        b=srVy1L1wLFli2B1CB3RJHlgk6gO/Urw+mPRmsE8/yAUeXGhdP5qkIcZ/aB8SCV6BvO
         NFPrZZHmbRIlfu5yKc+yPLJnBf90F/VEiWctiSzKhAratbEBBzVCkBPE2ufV/CGsbbMJ
         OKIby+60eW9wr4/Z2A6lUOaLqlj6OEbBeuuRbTeOifNUgkpIX5iiFEWh90qwZJ0963AJ
         /cJ1NeX+jLIv0NcGgDCf7nCGKJcNbYn0jHcg6NEFOXP9DkEe/roFShj/mFKY4Nsmeajf
         nUSmBOGw1v3YDPg53y/NqXqluJgGoCScqqijwd/gZPHoagwYU8M33bvw21FSB18YuH92
         xUqg==
X-Gm-Message-State: AOJu0Yw6EuOE9mxoHZ5UGRE9JDvSe26ePlNoMukato/nP2eVS/freafC
	2+ojXtiUjdnsr62UZXtZ/QmLsN57vQLEAnZIBo1D7SRxLdIRJDfVOxqbXqBgt/2mAI6I+eZeDHX
	zbsC3vzN79yf/1IjeOi21muzG4TxqkyP4wm7rWzr7xgF+ps1KMEjPPdRyYX/I+C45CKW6yK4Nf2
	dD6CCE1qrl7oe5tXCqbVCFn1sf9ndXHVm5W0qdBFyJfw==
X-Gm-Gg: ASbGncvdc9BH9bUOyxeUShjvVRzxnxBn+QKtUVtU7r9ur7GH/p80TvzkohKYqigqO7O
	t51ZeDM/Skv0r+80/l+vSgdJpjbK341nVzmFLbuqkcPNl3aUErbZfJk+nLsTehrZsErJw9NauWj
	3WUW8h5oeb1jk68FOkdsYPUikijf7Qmb3b0+e5FnqhkMNiMUb7FBAEF7EKN4auL6WNafUzHMg5M
	7KhCbVSbWFGFMOrsY0G7m//T6kDe40a8WvtefRf1qjBTlV5HPLgxg16sMttw8anRot+hvNw
X-Received: by 2002:a17:903:28d:b0:211:ce91:63ea with SMTP id d9443c01a7336-21f4e6f449amr40653105ad.15.1738915723642;
        Fri, 07 Feb 2025 00:08:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEG/Nl/sdNxE3d9AYSZmlVVB64Sgy2HwYPMVzmQGwxFjzAN+7LrOpduVERhXyu9f9J9OA/vpQ==
X-Received: by 2002:a17:903:28d:b0:211:ce91:63ea with SMTP id d9443c01a7336-21f4e6f449amr40652485ad.15.1738915723069;
        Fri, 07 Feb 2025 00:08:43 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a184cdsm2738670a91.13.2025.02.07.00.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 00:08:42 -0800 (PST)
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
Subject: [PATCH v8 5/7] crash_dump: retrieve dm crypt keys in kdump kernel
Date: Fri,  7 Feb 2025 16:08:13 +0800
Message-ID: <20250207080818.129165-6-coxu@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207080818.129165-1-coxu@redhat.com>
References: <20250207080818.129165-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bl75KFIIxjYg3_RP-Z5-NBbGjS_ZcCrVhcLH94AJC8M_1738915728
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_000850_962919_FC6DF176 
X-CRM114-Status: GOOD (  21.07  )
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
 kernel/crash_dump_dm_crypt.c | 133 +++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)

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
index 2f2555e6407c..dd6fc3b2133b 100644
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
index e4e0cc1c3399..993d9e08d774 100644
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
@@ -306,6 +434,11 @@ static int __init configfs_dmcrypt_keys_init(void)
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
2.48.1



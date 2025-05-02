Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4DEC3ABB2
	for <kexec@archiver.kernel.org>; Fri,  2 May 2025 01:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1MajVo0eN+bOY/uhsAvuKiRsP8lMRdWSlIoFJzdsFWA=; b=sqKW1Eq61j8QJpiT3SX66KmoBR
	Q2W54pUdjtcCO776aByD8ZyYCU+r+ySLgOHFMDXgdmtiOABmURPKC11T2ft/7FXsixN5qLJSBhH2/
	Mi3a45badoQx0G5TZwUWkx7srXOUk03gqOXS8kC+C8SxfhnytV2FPtME5iuIawwH65nF9vojsAYyz
	YF0a3cUzmCg+5RnXkM7t87ubOZzCpivY2+QTMRPczWpt4iKFtBc6ev5vehf/aIHCD+XUT1vDBILhX
	V192uZS+CCyVl+XUIeYFThKUbdAeouZl80SlBAhffe38anrGHUCGaU4uaunQZSx/DO3RLuDhWunzw
	QfRzHBmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAf0O-00000000UHh-0y9r;
	Fri, 02 May 2025 01:15:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAexr-00000000TgF-2gIz
	for kexec@lists.infradead.org;
	Fri, 02 May 2025 01:13:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746148398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MajVo0eN+bOY/uhsAvuKiRsP8lMRdWSlIoFJzdsFWA=;
	b=SJE3pWeEpT7OwKP+NxINIcBUBj2R1yIYTDshIt+R9l5DzvcdaNsfvFXk3qGvzDd+TrcJ9t
	btM2jRgCsN+ulcbnWnnVLYS1HLgHvut0UYv5ywpAuVKMQaGo9MCsgA9AAOLrEpqZ1WhJ+e
	9YmYsYkpI2h4ssw2dNKos6qk0sU+nWg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-nx4hi4biPS636V3DKSBuww-1; Thu, 01 May 2025 21:13:18 -0400
X-MC-Unique: nx4hi4biPS636V3DKSBuww-1
X-Mimecast-MFC-AGG-ID: nx4hi4biPS636V3DKSBuww_1746148397
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-736cd36189bso2176090b3a.2
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 18:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746148396; x=1746753196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MajVo0eN+bOY/uhsAvuKiRsP8lMRdWSlIoFJzdsFWA=;
        b=ONIUzNw0bowee+981nhss47JAUSpbPa9/LQcku/NVkXWsQ9nfzI9YMy5mhcMcmyJyc
         zEBEaZdlUSkldmPfHztrzfa1TWUfPlhf3OZmsKtTrksvxS6VC8/gF3hNYWrw3V80oJr7
         EOfz1nvDmYWpdDUpxm+AxydzjMFfieSR0zCC3zj2k4HfgvxD/Qq+re3FpJK/C+XTnEJa
         0gNeiKVEf0yjbmqKROUfkoPsu3f3W6dHFyJGUb89sed2cqFUBffGkZzP6nF0lNRA2TVe
         Hn6p5XiKdSl7Bosv74Eu6oWsXPJhGhVKToKl6yFGDJgDC9cFCuEeS6Gkri6O4uYSSymj
         kxRg==
X-Gm-Message-State: AOJu0YzzaRVqhadjhIXz2I54cdIi1Xu6RvNBvfDuZWId3AdcIn65A9W8
	UOpV6/FynCuFW+IE75qh6qiuU0a+gN1UfxLHcy8eAWx81b2M4SN1s2+T3a2Wouf+aQOXdLTNktS
	lKOElSOgyODV2m05V2Ifmo7PaqfjVboSbWFbFdWm+VbR0qhUoTa65R4dN2FvYJ94xF5DbxO6Q+e
	C1rzxRhcg7SkT8IaOMZd6V5YPPFlOqPfOLULmZvVTeNw==
X-Gm-Gg: ASbGnctSv50BAixwbdktWbfGFJSLfOw3vYDfdJnR9ejzO8HRQj+cfvYM+O1l9RbKued
	rInH0jRvO8yae7uZwCkVa3XiHFWUZfnbWXcFHrOGC3ivvnE1QJ+vWkG6Z8J+HGjWJsPxC15aiI4
	ctPHRSd5NslM5kYHJm5lSYOwBX4bzHMWzJ3TA9YYkaXm8rXIxr1JG+dcqJZGd3nA+ttymp7U5kv
	m2e2qF0iJjXdRl+22PJ2SSMyXaqxgffIWhYsXoZO2yYylGWeB8MHzfHGPRquGXjVVjuxQvyY466
	26k=
X-Received: by 2002:a05:6a21:9996:b0:1f5:5614:18d3 with SMTP id adf61e73a8af0-20cde374c45mr1332915637.8.1746148395673;
        Thu, 01 May 2025 18:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4p97v8it9sU5P5Sp05N+A9sBa8f61f+FHOAD5ZIDeBPK7a45C8c4sAtjySQ38fIl40uqCOQ==
X-Received: by 2002:a05:6a21:9996:b0:1f5:5614:18d3 with SMTP id adf61e73a8af0-20cde374c45mr1332865637.8.1746148395168;
        Thu, 01 May 2025 18:13:15 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fa8609193sm298494a12.72.2025.05.01.18.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 18:13:14 -0700 (PDT)
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
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v9 5/8] crash_dump: retrieve dm crypt keys in kdump kernel
Date: Fri,  2 May 2025 09:12:39 +0800
Message-ID: <20250502011246.99238-6-coxu@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502011246.99238-1-coxu@redhat.com>
References: <20250502011246.99238-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DvX4WzTiqnhD9WwrIl9IW-Aqh_XmUTZLmtqDj1MQtio_1746148397
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_181319_749893_01A7DA17 
X-CRM114-Status: GOOD (  21.97  )
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
Acked-by: Baoquan He <bhe@redhat.com>
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
index 5f4a62389150..401423ba477d 100644
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
@@ -311,6 +439,11 @@ static int __init configfs_dmcrypt_keys_init(void)
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
2.49.0



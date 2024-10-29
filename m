Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DABD5B87C
	for <kexec@archiver.kernel.org>; Tue, 29 Oct 2024 05:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AnKO20Za1by7mQ5PFB9cbIGCuqZlpoJCJKnoIomPMx8=; b=HbZK6Zlb3Uzm8p
	ij0bODWCNt1r0ZrcmQhhmRvJ7gsnM1JF7A4V7AAd5554alORXCUYXaj+/I32SMr7rmco5J5TltHJT
	pXXnRXpB805EqVvRCOv5Gg4EtNM0t0li4dJ4FOI03aU6pAdxcFzmx/BpXo7klXutNm7duKTZz3ahg
	V/BaHcQqOlBAW2ugVdRxjigW75mqOuOon6xjWCkvF2/5LYF4OeUPZHACMlKCZePBGNyE98YKgbXx9
	VhZ3tB/+8z+vjpDY7eaQC2/YVDmNgIw/viLPGvzNtwfkhxA7NPJAttVs1poIU6z7tZ0k/k6SKC58D
	PJ9SBXn9gGTriU8T1bEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5fAB-0000000DIKO-19VF;
	Tue, 29 Oct 2024 05:53:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5fA8-0000000DIHn-1mg8
	for kexec@lists.infradead.org;
	Tue, 29 Oct 2024 05:53:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730181183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZg6/j2slJCNip4CZzSegjPi2gvUTG55985ztTmoO0Y=;
	b=LLGKra/1vF8hUixm9A3wSvcFOZG+U+7/NIGeqol1uzTpw1eD9mVhBXZnGwP3JPgZCuyACd
	BH+Kg15EKwxkiLnHV8TJskoD2DShQVjLGntqYbZfiHWipBEwoXcRzkgzkQwpQaNA4ySeLm
	T9F4voECMRFq3wDKrGfki6OvKiSdJwk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-Z55GDpEVNkaZg0xa-EwRNg-1; Tue, 29 Oct 2024 01:53:02 -0400
X-MC-Unique: Z55GDpEVNkaZg0xa-EwRNg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7db4c1a55f5so4613114a12.3
        for <kexec@lists.infradead.org>; Mon, 28 Oct 2024 22:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181176; x=1730785976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZg6/j2slJCNip4CZzSegjPi2gvUTG55985ztTmoO0Y=;
        b=ZZ+yXbA/DK+pTpf4wfNcGQTkwUO37GOUG+2npZQnfzbuNdC5xdUR6cHBRMpkBIXbm5
         MUhzwX7rghLg1WvLelJQY+iFeyX3bKlJgJHR3geWEeTUHehRJswEWYfFyv7H/TTV/Mx3
         7Rrw/qAvreNQ+du8BD2a2wnMBi8jH6OeI/TbZ4tMgOMxViUDEzEdHFrzoOgCjlXT+sVu
         Mq3ryIB2OvlDlOp95nmxuGF3zHHfTYePKLLCDnUBzmU02KJ0BT66RieHi40pYFuZOjd8
         MpbahADVuL8BmLk5oR5aaaqeukN9psqS250WqVi/iaEwGiV8U7vtl6GmlH7TSp708w33
         k55g==
X-Gm-Message-State: AOJu0YyRCcjM3cJ+iI4zZM/auwIC+J/YkqU1sIk+7oT411c5TgdOCzQJ
	FnEJtf0NY6O5D2Z3Ed7VylFWJj90NylU4NmK/IVM3Kmn64sr4cxiiAIQRe6RzU32hbOt8TQ3RS+
	Ghf7oZFI6UkT8HtspXZvVBYpbHsyhErx+UmVWziqEfdQzFknRFaxXY5gmEU2f0tb19ReB1ExLh+
	iuuBZMVe3QkKak4nS4SyVIifc6RWJVAlvt/05KifqqQtxV
X-Received: by 2002:a17:902:f546:b0:20b:9f8c:e9de with SMTP id d9443c01a7336-210c68995ccmr134170255ad.13.1730181176430;
        Mon, 28 Oct 2024 22:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk9Es5TcHJ+1fDLYHIVVDN7Qi0lRdnOpcpue5a43EpNjkaC+h6H+NJ0KXWLPIin0nJAJGNfg==
X-Received: by 2002:a17:902:f546:b0:20b:9f8c:e9de with SMTP id d9443c01a7336-210c68995ccmr134169925ad.13.1730181175900;
        Mon, 28 Oct 2024 22:52:55 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf44321sm59445635ad.30.2024.10.28.22.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:52:55 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v6 5/7] crash_dump: retrieve dm crypt keys in kdump kernel
Date: Tue, 29 Oct 2024 13:52:18 +0800
Message-ID: <20241029055223.210039-6-coxu@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029055223.210039-1-coxu@redhat.com>
References: <20241029055223.210039-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_225304_566161_DD3DB36A 
X-CRM114-Status: GOOD (  22.91  )
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
index 51431f93fc1e..f72a88b7d106 100644
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
2.47.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

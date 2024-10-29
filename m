Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C104D5B87A
	for <kexec@archiver.kernel.org>; Tue, 29 Oct 2024 05:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tf4D8Oo9DCTLQR7rFAXr00enO8yJXuT6rGpLZu/+2TA=; b=xvqaRT8/HsLICf
	eTgIMiefAHFKkD/qxqsxqI/MWV3G4+TRTu3jhY8JRJMhOxwBXKMNfzeGpQtTWraD2BUiccenv+oEr
	nXDeF1EZI8jV5Ast6lXjfzYLcrD+nlnQDp/aIhnbCDTZ6oA//aTmz+41olaOz6nLN1oGbkIgmfZzQ
	R8Xtrk8X9wGYL+aCF8iY1Ds4Zq6HVn+rpeV7Z9FnA7foqSq5/SYCNuwMg9Q1hypCazSoGd/MrTTem
	/8UjBCboPKFHEjwd6e+ZJlrqsLQkRoYvAz5AWSQeXJoek8Yk/S6L+DGyww3YZLinkmKX5uxKnMNri
	L9OkszHl1XcFkVEBugFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5fA9-0000000DIJA-36zP;
	Tue, 29 Oct 2024 05:53:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5fA6-0000000DIG6-1tok
	for kexec@lists.infradead.org;
	Tue, 29 Oct 2024 05:53:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730181181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue6MNdOcnLTaMHu3j/S0yuX7xj3aU0+QyusUiHz2OBc=;
	b=Zm0FEE9mYB6A+wKh4cr2sviov7/DpIc0VOAI7HiO2antsZnCHL6Os73mcfLet1zJ7+XIZv
	yzJwu7vJj+AHgt3KjLHvWjkRqesTa/ly5ZmCiimkLieVJgyc+98FuojgV44QUiQ3pr7E5D
	19vtEevcNuUMCnVjoiZQSLzshJ/qaVY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-TJ2wV9TnMvqMztZ7sSGYvg-1; Tue, 29 Oct 2024 01:52:50 -0400
X-MC-Unique: TJ2wV9TnMvqMztZ7sSGYvg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e2bb354e91so5066561a91.2
        for <kexec@lists.infradead.org>; Mon, 28 Oct 2024 22:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181164; x=1730785964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ue6MNdOcnLTaMHu3j/S0yuX7xj3aU0+QyusUiHz2OBc=;
        b=C5wdxJTbPDc6C47KgaU1C1cxZwGLT8e2YVTMIY5bjO6uC+fEOhErdthd2PXyAY2KmR
         gttG53mvJ71RXlPbBdhbYWB9vPgon3wBX7Dj9W/W3rEca9ZoymxxO+IfTlV4b1q3bKpi
         boscvRuWA7CJKgZdmU4dmsFf5D0SX5n2QMDK5totfJUavgT0Q4t5VKR0TQ357mhn2cMr
         Y/fV4e52NekAlS+bTlcDXLQ3fa0faAxO9q+t9pD+86uZZihOyYxb27dZX/Pe5IL2C/Cu
         aM/9Z7MvMqJ5sOwNcJmttwV4sFfpCtNA0Cyo9QV/VN4B4SMc7XumUQPeUbncma0lTs5G
         fEqQ==
X-Gm-Message-State: AOJu0YzaYRd7jrATsAS/5iEJl0o8cU9/az3xb2FTIY+gGGPiNp9iGJqr
	AdXTOTFFX41JBfUYaxPUOjv5SbO4tmULUxeGyoe1GFdHv9SGOpxGTVsyKlGSSYA/FlgzFWwYpTM
	NAVlstcH5LXi9V4cIQP5PtiJ+5rTFU+ITBWzFJMjxFBOY3SzRaIZC/yZBMHbA8Fr5+qixaynJ1P
	3V6c+zI0rO503zRtepVDxhrjT3BX2MwHXfylcG7lvy89Af
X-Received: by 2002:a17:90a:780a:b0:2e0:cac6:15f7 with SMTP id 98e67ed59e1d1-2e8f0d5dc37mr12203240a91.0.1730181164483;
        Mon, 28 Oct 2024 22:52:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXNSApOHp5LxPu6upUbkZyjY7lVTpe+dj4/6+cnO8DL3RuJSlwTfDsx4oR9LJijhRuCmJCow==
X-Received: by 2002:a17:90a:780a:b0:2e0:cac6:15f7 with SMTP id 98e67ed59e1d1-2e8f0d5dc37mr12203213a91.0.1730181164007;
        Mon, 28 Oct 2024 22:52:44 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3555c71sm8472340a91.11.2024.10.28.22.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:52:43 -0700 (PDT)
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
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by\b)
Subject: [PATCH v6 3/7] crash_dump: store dm crypt keys in kdump reserved memory
Date: Tue, 29 Oct 2024 13:52:16 +0800
Message-ID: <20241029055223.210039-4-coxu@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029055223.210039-1-coxu@redhat.com>
References: <20241029055223.210039-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_225302_576427_1EABAC9F 
X-CRM114-Status: GOOD (  19.37  )
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

When the kdump kernel image and initrd are loaded, the dm crypts keys
will be read from keyring and then stored in kdump reserved memory.

Assume a key won't exceed 256 bytes thus MAX_KEY_SIZE=256 according to
"cryptsetup benchmark".

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h   |   6 +-
 include/linux/kexec.h        |   4 ++
 kernel/crash_dump_dm_crypt.c | 129 +++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 44305336314e..2e6782239034 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -34,7 +34,11 @@ static inline void arch_kexec_protect_crashkres(void) { }
 static inline void arch_kexec_unprotect_crashkres(void) { }
 #endif
 
-
+#ifdef CONFIG_CRASH_DM_CRYPT
+int crash_load_dm_crypt_keys(struct kimage *image);
+#else
+static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
+#endif
 
 #ifndef arch_crash_handle_hotplug_event
 static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0dc66ca2506a..5bda0978bab3 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -396,6 +396,10 @@ struct kimage {
 	void *elf_headers;
 	unsigned long elf_headers_sz;
 	unsigned long elf_load_addr;
+
+	/* dm crypt keys buffer */
+	unsigned long dm_crypt_keys_addr;
+	unsigned long dm_crypt_keys_sz;
 };
 
 /* kexec interface functions */
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 62a3c47d8b3b..ec2ec2967242 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -1,14 +1,62 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/key.h>
+#include <linux/keyctl.h>
 #include <keys/user-type.h>
 #include <linux/crash_dump.h>
 #include <linux/configfs.h>
 #include <linux/module.h>
 
 #define KEY_NUM_MAX 128	/* maximum dm crypt keys */
+#define KEY_SIZE_MAX 256	/* maximum dm crypt key size */
 #define KEY_DESC_MAX_LEN 128	/* maximum dm crypt key description size */
 
 static unsigned int key_count;
 
+struct dm_crypt_key {
+	unsigned int key_size;
+	char key_desc[KEY_DESC_MAX_LEN];
+	u8 data[KEY_SIZE_MAX];
+};
+
+static struct keys_header {
+	unsigned int total_keys;
+	struct dm_crypt_key keys[] __counted_by(total_keys);
+} *keys_header;
+
+static size_t get_keys_header_size(size_t total_keys)
+{
+	return struct_size(keys_header, keys, total_keys);
+}
+
+static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
+{
+	const struct user_key_payload *ukp;
+	struct key *key;
+
+	kexec_dprintk("Requesting key %s", dm_key->key_desc);
+	key = request_key(&key_type_logon, dm_key->key_desc, NULL);
+
+	if (IS_ERR(key)) {
+		pr_warn("No such key %s\n", dm_key->key_desc);
+		return PTR_ERR(key);
+	}
+
+	ukp = user_key_payload_locked(key);
+	if (!ukp)
+		return -EKEYREVOKED;
+
+	if (ukp->datalen > KEY_SIZE_MAX) {
+		pr_err("Key size %u exceeds maximum (%u)\n", ukp->datalen, KEY_SIZE_MAX);
+		return -EINVAL;
+	}
+
+	memcpy(dm_key->data, ukp->data, ukp->datalen);
+	dm_key->key_size = ukp->datalen;
+	kexec_dprintk("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
+		      dm_key->key_desc, dm_key->data);
+	return 0;
+}
+
 struct config_key {
 	struct config_item item;
 	const char *description;
@@ -130,6 +178,87 @@ static struct configfs_subsystem config_keys_subsys = {
 	},
 };
 
+static int build_keys_header(void)
+{
+	struct config_item *item = NULL;
+	struct config_key *key;
+	int i, r;
+
+	if (keys_header != NULL)
+		kvfree(keys_header);
+
+	keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
+	if (!keys_header)
+		return -ENOMEM;
+
+	keys_header->total_keys = key_count;
+
+	i = 0;
+	list_for_each_entry(item, &config_keys_subsys.su_group.cg_children,
+			    ci_entry) {
+		if (item->ci_type != &config_key_type)
+			continue;
+
+		key = to_config_key(item);
+
+		strscpy(keys_header->keys[i].key_desc, key->description,
+			KEY_DESC_MAX_LEN);
+		r = read_key_from_user_keying(&keys_header->keys[i]);
+		if (r != 0) {
+			kexec_dprintk("Failed to read key %s\n",
+				      keys_header->keys[i].key_desc);
+			return r;
+		}
+		i++;
+		kexec_dprintk("Found key: %s\n", item->ci_name);
+	}
+
+	return 0;
+}
+
+int crash_load_dm_crypt_keys(struct kimage *image)
+{
+	struct kexec_buf kbuf = {
+		.image = image,
+		.buf_min = 0,
+		.buf_max = ULONG_MAX,
+		.top_down = false,
+		.random = true,
+	};
+	int r;
+
+
+	if (key_count <= 0) {
+		kexec_dprintk("No dm-crypt keys\n");
+		return -EINVAL;
+	}
+
+	image->dm_crypt_keys_addr = 0;
+	r = build_keys_header();
+	if (r)
+		return r;
+
+	kbuf.buffer = keys_header;
+	kbuf.bufsz = get_keys_header_size(key_count);
+
+	kbuf.memsz = kbuf.bufsz;
+	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	r = kexec_add_buffer(&kbuf);
+	if (r) {
+		kvfree((void *)kbuf.buffer);
+		return r;
+	}
+	image->dm_crypt_keys_addr = kbuf.mem;
+	image->dm_crypt_keys_sz = kbuf.bufsz;
+	kexec_dprintk(
+		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
+		kbuf.bufsz, kbuf.bufsz);
+
+	return r;
+}
+
+
 static int __init configfs_dmcrypt_keys_init(void)
 {
 	int ret;
-- 
2.47.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

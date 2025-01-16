Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FCDE77188
	for <kexec@archiver.kernel.org>; Thu, 16 Jan 2025 07:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tQvCsR9EXSN3ga2DmGxkK/BjC0F26mqQj7WZLS4qcAw=; b=YLmIbBjrMtMABaAi3qat2rDcsK
	jjfhKF+gq7ceTgsqoP4RA60WJd8eomsNddVhsCZBZFe83Z864wZbAgyMo/cBtc+Ggybb1rCqSemOB
	h4PeEYdMgK9TjQaWtsgSW+ReCVi7AJOcbbuuddNxZBxNftl2v+j5MYQwnpx/80O7ou80O5A/TN2Jy
	FbNu++g69DF+Nshylae6ofrl+Du0xEKoj0K6FXjo99Vf7o48bPLvF5jFM2+ZpGzKhk5WweL2vS3WQ
	eoYCS4I7ajVXZnQxNhR91f6fuLF8F1TH/Tob/JR6pdaT6TZEwDvcoWQhOFrjTuNWAaMn1M5hRm5dD
	3sbtQW7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJrJ-0000000Dzrs-2w4c;
	Thu, 16 Jan 2025 07:00:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJq4-0000000Dzb6-3Qn6
	for kexec@lists.infradead.org;
	Thu, 16 Jan 2025 06:58:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737010728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQvCsR9EXSN3ga2DmGxkK/BjC0F26mqQj7WZLS4qcAw=;
	b=GrXs+BlJhsJRyJzlFhApK1veuHoUu/jQza1WcRwnrBEvWAng3A+9/LC++0atBgFUKREGyc
	f3bUvFiJgW2chTZyzeCo/3yiLsDrI7H2b6zxbq0jWiUOjmqxJubR/EvCRfLn9WwhPN7xHU
	qVV+upcKZR0I9X4UESl9oH1BzetRRDo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-NIhjloVMO2ajlsW4AdhkKg-1; Thu, 16 Jan 2025 01:58:46 -0500
X-MC-Unique: NIhjloVMO2ajlsW4AdhkKg-1
X-Mimecast-MFC-AGG-ID: NIhjloVMO2ajlsW4AdhkKg
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2164fad3792so11335945ad.0
        for <kexec@lists.infradead.org>; Wed, 15 Jan 2025 22:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737010721; x=1737615521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQvCsR9EXSN3ga2DmGxkK/BjC0F26mqQj7WZLS4qcAw=;
        b=StA6wWgpxwDfZwH44lirBiOsZLvHGF01wosWeQxceyLlt3M+m0KCEliTGgiqUe+8ib
         5qX/vtadivwisvX98AcjcVO+EtAWy0SfeBbi+4VW2YhvIB1tadmpY7tjtob6hoYC20Wq
         95I9zSEdhgc4RJHwQas/AEn8YHMABB/MfS1LSNEWpFUDDjFZ5bxBHSCNVq3Ep/a9eN91
         Ute6iFI/afvQjYrmDQihIDFZJPIRHLYJqIqXKbaTvBIPPIj0iuOdKsEL90yLK+l0arUI
         B9C3aotljo+LHqmXLj/lVmIEUw8zhXUzaz6r8TJapteLi0TlEOV30tHi3xQ/X8hkRmC9
         uoBQ==
X-Gm-Message-State: AOJu0YwCphG1BKs7oEC0zq9KghbpGvS1d8CN9pIE96ED/wZvOodM8ZaE
	jZswLiyRbKGiYq+de9EIpLZ2EFE6m2GNAHLA8OR5jhs2hesh4FyacDEvL9mMcylQMd4NTcKbKX3
	5IVh/eoXJ53fckx6pXa2SxDnI3eDDntCIN1ZWNBFnc82xqMjb5y2vzj6jkiWrwZdhr3/OJWOeMX
	NH3MitjkYbRrwg1sP3M4S/5tiPyS+Xk1q6cP18w4lYdg==
X-Gm-Gg: ASbGncufUxAT1DgaVm/SMXxKTBxDglLjx+K4yiORsL5H/p4MxH5MZvgRgsdQ0DXPrCs
	x46v79mWdB0dGnVYD/oxPtrZyla8kYG+VclpXu5PmqWhLZZcQKBgF5kgio8dkJNYTnjN8KHR15d
	lnZHZG9kJju/Mr7936Q8woLaiOkgShxo5OYo0D0EXlONzVJ1ws2gugu5TKpCh7h9SlhlPeuuyEk
	0LeyrgDdDoSToQ5jNePApmYEHRe0kw0v4VJiNjYuWYXGHJ2
X-Received: by 2002:a05:6a20:4325:b0:1e1:b062:f3fa with SMTP id adf61e73a8af0-1e88d1dba97mr60123661637.34.1737010720676;
        Wed, 15 Jan 2025 22:58:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0mUbg5KfGVjWvvefswEmAHcx/8ryY08l4nYmf/QtfmhIT1/A0W8mtD2C6GcsE+LcNZkwPgw==
X-Received: by 2002:a05:6a20:4325:b0:1e1:b062:f3fa with SMTP id adf61e73a8af0-1e88d1dba97mr60123596637.34.1737010720061;
        Wed, 15 Jan 2025 22:58:40 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658efdsm10700322b3a.90.2025.01.15.22.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 22:58:39 -0800 (PST)
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
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH v7 3/7] crash_dump: store dm crypt keys in kdump reserved memory
Date: Thu, 16 Jan 2025 14:58:18 +0800
Message-ID: <20250116065825.1041558-4-coxu@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116065825.1041558-1-coxu@redhat.com>
References: <20250116065825.1041558-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bMUOnPmATRnjI58fTbAYbmELaIjaVxQsgLHeFp-GJ3o_1737010726
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_225848_928233_F5DCDFBE 
X-CRM114-Status: GOOD (  19.36  )
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
index 61269e97502a..ec7504ba80e9 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -398,6 +398,10 @@ struct kimage {
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
index 62a3c47d8b3b..8c093c743d58 100644
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
+		return -ENOENT;
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
+		kbuf.bufsz, kbuf.memsz);
+
+	return r;
+}
+
+
 static int __init configfs_dmcrypt_keys_init(void)
 {
 	int ret;
-- 
2.47.1



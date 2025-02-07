Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F135BC0219D
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 08:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wiArPs1+avBHMZbi2nWrtxJACPoRgCcLG1Yosqozl6w=; b=FBS3G3WUALYHXLKolzjFuzBkcK
	B0AcLjwij2Ny994tGy9BDSqAUuY4nhZcD7P1uC6y32EHRD/sEPXoVZhyBAz6dnd7PdPEsA/rtxBww
	S57FvTvfjFvPtQBHwV0oKXISTgVspFtRD4gXFv1gBlczbpdpfHbQleJ+xQ6dMaZ6RaAGfgfnxf6aA
	U/7nBHsiTfEqJ5eZ4esewDLikp14Y+TfuI5tuywVXtQhr5aNR8RASeayIMjyRNn4+z+VpN16YqY2k
	Af341OOfgay5fZfqQ0Iq0xj/6rw9viVtrYyIPrGWJ4+FmOXRmVUCIz4yggYEeUNMgXtWvRUHDdH+m
	D3pJjh+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJQx-00000008l9z-2qrF;
	Fri, 07 Feb 2025 08:09:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJPk-00000008kgt-2P3g
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 08:08:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738915719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiArPs1+avBHMZbi2nWrtxJACPoRgCcLG1Yosqozl6w=;
	b=MRlF67aucAqvDteyGmkOmmicMxJC8pANC7okIOh6uiZAmjejZcwJPvv8g1PcZ5581qhDnf
	sHdWx0WainlaAEHHXECpq8yKt7VLkfu7ZhxPQer8nMIm+VGnMnbvsT29+jprz8YwOgCxva
	ebgUXFHpASCPNv6Ed5CN0rZFUAtD+BE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-vhzlvAOHMeCwFsmXIqMvUw-1; Fri, 07 Feb 2025 03:08:38 -0500
X-MC-Unique: vhzlvAOHMeCwFsmXIqMvUw-1
X-Mimecast-MFC-AGG-ID: vhzlvAOHMeCwFsmXIqMvUw
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21f5060ef10so25200495ad.2
        for <kexec@lists.infradead.org>; Fri, 07 Feb 2025 00:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738915714; x=1739520514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiArPs1+avBHMZbi2nWrtxJACPoRgCcLG1Yosqozl6w=;
        b=wHgXivWDEbEkIjVz8hhqq5+YNFZxYetY/IBrEhvqHZRMMAuusozl882jIjv4P+Ee9n
         eXb9VT8yaw7OS9GKVOCP3Q9MgBGXOhApgTegwRmTU/sG4df71GXP4KWlgg72U0V/awZt
         idqGoDH7aEPWIiyuoiTtk6b5aRrhdbSh5itb1cqfknaXF3bEvOA9DpmovKaEs76LGiOQ
         7RAzsJYKmBKL4smYPqZklSWhHBlx1dD4UgjRaSvUzhGAKlQ/cJomybOgpxSwxKDax+Vd
         EQP8Bh7xrmnaUfo0ibbnAKUDWuXl9UAmk4yTIt47dZo6cLiXJ7xo/TcrA9zgRQS9l0JN
         t81Q==
X-Gm-Message-State: AOJu0YzV4InxkPwTYLwLtjKavRLiSQlXjZHR5nXeHi6NZF5a8bALnLdf
	Jh/7sxDMXRjXFCzzPHroKuHPR59ab5B8x1QJsraYUat6YMcItZNMYv1A7D5VI8Hd8JPO9xjTV+R
	qxo+vdRC91psxNqnvp+aslfqpQatTfRyF5RYq7PNbDxBrNAEgf6Esfd4pyBzDjSI/vufLcg/+rY
	1xKJgs7P4eMDVcUOtwSMEHFhFbpRaP35BvBBkw2Qod50l2
X-Gm-Gg: ASbGncs+wyqj5BLVvPWeVoseer2BhSZKWWfcNwfTTHxDYL7Ahh+l0YWDHcNJK2ogwo2
	E9MMNpqLbjjNX1tHgBw8v1Ikg7AxACrpquJuhfhkwb5QGUmIbU5ClqAe0e8FFe1u7InoTlDl6u3
	WV0b5PbBovhX7wfg0dJZe/FnMBJm7FOUTdP77MXr6jbX3DQbYZmRwCCt6deqJ0KH4jKlNMZ3WFy
	JV+UomRP++VgSNx2o0hd8u+2bgyN4FiHW9fhsAZr2FoxlbZyb8NUPz8mFPIebKaXiF8o5uU
X-Received: by 2002:a17:902:e552:b0:219:cdf1:a0b8 with SMTP id d9443c01a7336-21f4e70becemr33812855ad.30.1738915714476;
        Fri, 07 Feb 2025 00:08:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOy2GKcmqR9hVKPcRIgrcrNltxpouvX9yK078gbyYuEyZ9aHqEHHcHMDTXf7Funzs6C/FVgQ==
X-Received: by 2002:a17:902:e552:b0:219:cdf1:a0b8 with SMTP id d9443c01a7336-21f4e70becemr33812455ad.30.1738915714085;
        Fri, 07 Feb 2025 00:08:34 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650cd10sm24776065ad.31.2025.02.07.00.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 00:08:33 -0800 (PST)
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
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH v8 3/7] crash_dump: store dm crypt keys in kdump reserved memory
Date: Fri,  7 Feb 2025 16:08:11 +0800
Message-ID: <20250207080818.129165-4-coxu@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207080818.129165-1-coxu@redhat.com>
References: <20250207080818.129165-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mBAOwsjcPOIqb-VoT9bQCThSWVDdtie0kdXxynZSbxE_1738915717
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_000840_705677_AFA4228F 
X-CRM114-Status: GOOD (  18.12  )
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
 kernel/crash_dump_dm_crypt.c | 128 +++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 1 deletion(-)

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
index 62a3c47d8b3b..00dc6a3f71ca 100644
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
@@ -130,6 +178,86 @@ static struct configfs_subsystem config_keys_subsys = {
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
 static int __init configfs_dmcrypt_keys_init(void)
 {
 	int ret;
-- 
2.48.1



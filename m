Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3112C27C55
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BeAVickqTyRBIqQ6KENwjpdAoJxCI9Hx1RyRuzhGx5E=; b=y5cE2TdkRo9ypV
	vOeiW0bNZwCJl/C957umTAoIfihRzFjmTlOyK/9aC04xY1FvrKimisaXej7EQbAhOrc8dGh0kKY0H
	LyPV+3b28JHFuzgRIGi2aiewbzrwU25iGKyTVTzSjwcCZywzJeNy3TNfcdzaPq84lHkUubcpPZVj+
	q1mnsep7Zm7ASTRqIYCXSPXdrpaxAQg+hCTRkJ9FLchpwLIDYYWTe5Jak2njdl2TBjp+oWGGNEgln
	sD1hCxINJbjkglFQjfvsVRwWWVvH1v/NHQZ15O12hFKcHwx4j+3G0KJAGaKJqZUVV84JngRFnjYTB
	qPAR/GWs5DEQodXyXYCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYgJ-0000000Duam-47E5;
	Fri, 07 Jun 2024 12:26:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYgG-0000000DuWq-0gzH
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:26:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NY6MlWJnYNHj2CGE0jYmgrV3LdjseoctScg0CAsxuF4=;
	b=eVK4YfNc1+wC5/Ns7v4nEb0/9y41Q0jrPaCgAlL5uetqOewN4eZvbCAsvOHLEYMWSgGhac
	hdmZmlqLHbBQZH7nKEjhO6GklyAAmG5R+z85vlScEEYZCYKRvS/WMuaX+m7S2L5vOxttsp
	lliqfsxwlyJmuGbblpQEr6pkszxvI/c=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-C84kiQM6OgqYfZ3vEmKfDA-1; Fri, 07 Jun 2024 08:26:47 -0400
X-MC-Unique: C84kiQM6OgqYfZ3vEmKfDA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6e53ddbbb1fso152416a12.0
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763205; x=1718368005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NY6MlWJnYNHj2CGE0jYmgrV3LdjseoctScg0CAsxuF4=;
        b=EYf5vGYl5QOiKQsZS48FUJ2pUpyAErhZWILVbk+U6fKfc69HtiYXynclY9Ieh2m5gu
         JOl8ra9HZHipfXZ16VlxI5EZmC768JtBWbGdJ1Z8jerGPk3RZC7ipFPZrF9+21FdroAq
         gSwdBD0wSwPEmjkHbRO5LBNe+qML5WokamNLZo/O1AQzXrHrvISQ37uFVgLkdLrtA45n
         Yv8eSu648riBoFFEGwJGMWtOm5/Tv8mh51bFn9BexN28kZVzOuIfieQL7eygjts8Gf4O
         fb8epjTqJXACxP9jP2jO7LjRdbNDkH+0bxBdZUNJimaqMuShpPvrMGCWwr7L9yRvtxgg
         /uXQ==
X-Gm-Message-State: AOJu0YxCPug6PIrOt03+YWvqoRbekH4ezpfKc9kf1v/AJg18TWWtCurN
	6+LqYlH2VncnN7U+FeMRNhKmH11TNZPE92jesTh6WBzuSSPyNmf624HjWB1WqmNInzROuSYQUZH
	16By8n21XTcnUzN4C4H4uHg578huI3E5hHs8ufd/iO/K74IRWjVIu+dutogq3b7uy6Cw6J1qDyH
	MVbIjIJErs6Iz0lwGnWQYZcdbJOAcmfVXOjEgtZIO6GPDv
X-Received: by 2002:a17:903:32d2:b0:1f6:39d8:dc4f with SMTP id d9443c01a7336-1f6d02c0542mr26933255ad.10.1717763204759;
        Fri, 07 Jun 2024 05:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpdAyFSQcoxBOdQJBinBNNpDMf5FnhUP8x16FFmg6d0auNXsy7A03SjZ++vuIxTUa+Qb9LFA==
X-Received: by 2002:a17:903:32d2:b0:1f6:39d8:dc4f with SMTP id d9443c01a7336-1f6d02c0542mr26932625ad.10.1717763203770;
        Fri, 07 Jun 2024 05:26:43 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7eddf1sm33133565ad.249.2024.06.07.05.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:26:43 -0700 (PDT)
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
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v5 3/7] crash_dump: store dm crypt keys in kdump reserved memory
Date: Fri,  7 Jun 2024 20:26:13 +0800
Message-ID: <20240607122622.167228-4-coxu@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607122622.167228-1-coxu@redhat.com>
References: <20240607122622.167228-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052652_718292_92590E6B 
X-CRM114-Status: GOOD (  15.91  )
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

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h   |  3 ++
 include/linux/crash_dump.h   |  2 +
 include/linux/kexec.h        |  4 ++
 kernel/crash_dump_dm_crypt.c | 87 ++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 6bff1c24efa3..ab20829d0bc9 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -37,6 +37,9 @@ static inline void arch_kexec_unprotect_crashkres(void) { }
 #ifdef CONFIG_CRASH_DM_CRYPT
 int crash_sysfs_dm_crypt_keys_read(char *buf);
 int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
+int crash_load_dm_crypt_keys(struct kimage *image);
+#else
+static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
 #endif
 
 #ifndef arch_crash_handle_hotplug_event
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
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c45bfc727737..cb6275928fbd 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -372,6 +372,10 @@ struct kimage {
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
index 608bde3aaa8e..0033152668ae 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/key.h>
+#include <linux/keyctl.h>
 #include <keys/user-type.h>
 #include <linux/crash_dump.h>
 
@@ -128,3 +130,88 @@ int crash_sysfs_dm_crypt_keys_read(char *buf)
 	return sysfs_emit(buf, "%s\n", STATE_STR[state]);
 }
 EXPORT_SYMBOL_GPL(crash_sysfs_dm_crypt_keys_read);
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
+	memcpy(dm_key->data, ukp->data, ukp->datalen);
+	dm_key->key_size = ukp->datalen;
+	kexec_dprintk("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
+		      dm_key->key_desc, dm_key->data);
+	return 0;
+}
+
+static int build_keys_header(void)
+{
+	int i, r;
+
+	for (i = 0; i < key_count; i++) {
+		r = read_key_from_user_keying(&keys_header->keys[i]);
+		if (r != 0) {
+			pr_err("Failed to read key %s\n", keys_header->keys[i].key_desc);
+			return r;
+		}
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
+
+	int r;
+
+	if (state == FRESH)
+		return 0;
+
+	if (key_count != keys_header->total_keys) {
+		kexec_dprintk("Only record %u keys (%u in total)\n", key_count,
+			      keys_header->total_keys);
+		return -EINVAL;
+	}
+
+	image->dm_crypt_keys_addr = 0;
+	r = build_keys_header();
+	if (r)
+		return r;
+
+	kbuf.buffer = keys_header;
+	kbuf.bufsz = keys_header_size;
+
+	kbuf.memsz = kbuf.bufsz;
+	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	r = kexec_add_buffer(&kbuf);
+	if (r) {
+		kvfree((void *)kbuf.buffer);
+		return r;
+	}
+	state = LOADED;
+	image->dm_crypt_keys_addr = kbuf.mem;
+	image->dm_crypt_keys_sz = kbuf.bufsz;
+	kexec_dprintk("Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
+		      kbuf.bufsz, kbuf.bufsz);
+
+	return r;
+}
-- 
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

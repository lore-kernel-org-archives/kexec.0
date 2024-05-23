Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08769C25B75
	for <kexec@archiver.kernel.org>; Thu, 23 May 2024 05:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q/S7Oi9atPLkNxXWOK3JglufqqaaJ5Pdzc3K71oXfEc=; b=FhVdLpAEvw4VMW
	wzqUAPcX+38wJy5rlMQpR4da/5FcL0zGELgZaNabjvMCW4Mrp79Y/H4kFPnmffGCp0dzqIpBPV3E3
	DR9wldbNRcSQP86DjTvOMmzY5vILAqoRwK6gF1yvY6WWRh7bySK2JtTmDTqN22sWiDU19gFYGqLn6
	VYybZTfCMamawdyd4o4UMU9Ssxm9EXQ7r1q7nQl6W9vaEd3BjJEGkuWCQIIvFbz/oqGr5hLsNXuWB
	9Q72ltkn3KQMuNEWQz2aoFXqzor2eOT4rirm/EkUT2Tob/TMDQOvhdXjyUknBAeS0CUzCG+uIIk/n
	e0C4diunislC15806Gxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA0dj-000000053sA-0hna;
	Thu, 23 May 2024 05:05:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA0dc-000000053nR-3o13
	for kexec@lists.infradead.org;
	Thu, 23 May 2024 05:05:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716440711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18YOd0+Wa5jPqylPxPMlv7Y+0C4u9S8TvIRTMzUpGf0=;
	b=iMpAD0duH88gF/O0P+smszUD5gU8QTESQ0QmG4X4zcr8ZfwBnpepbeXLxvveMrpeE04y0p
	2dA4i0+sTLEUkgPvMoxZM2CHxWmPAQ+l9jrmoQDjoGNPo5vjlr0NhD7s97lYPwgmN/Oeef
	ei9sj9sAhfMan5r4DILzhsbWCWrcfwY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-tvrRkF2IPTGo66GRedaAyg-1; Thu, 23 May 2024 01:05:10 -0400
X-MC-Unique: tvrRkF2IPTGo66GRedaAyg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1f31943bee9so18001065ad.0
        for <kexec@lists.infradead.org>; Wed, 22 May 2024 22:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440708; x=1717045508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18YOd0+Wa5jPqylPxPMlv7Y+0C4u9S8TvIRTMzUpGf0=;
        b=DB6+P2EsWa+OYk81RRn3l5IQC2i1pyHa7QgFh39TquQz0/M7PHkdbTNlkY8D9ox1++
         9KJL9uiFTl7mj0qFkTBL+dGlCPRPVoU8+YoavltPfRuLFkwOoloHuzr2y9HjVVXQAhAo
         tVpqrLT6GSEm30QiZAQ3jtUcAmLigHDTx3Q56kZLtvUhf00XXkUW5DwyRY+PK9OlDZpH
         0JYAe7klgCYwT7IQlqbDeOCXqKN/uf47kAvPD0lznSjaVd3+N9JJO1FYcf0Bf45AvMRP
         h25xCvDCMRpnRt29G3nvn2SxpQMkiZ0S0pig1YbDuk0VJKuNQIyKX00ZKr1nffweUSa3
         euaQ==
X-Gm-Message-State: AOJu0YyOnucIY11QMNuIc9JX6PrScCmKsp3NsG2MbWNktglsxtWBJDZL
	KiPDKL7IAra+CYfm5/f1ktk+dzDdFgL7Me422pR6QmxXIqQNoyrJPjF74biN2dfyKlWtMn2SJgS
	GzEVsSi2pG2ssFxB83HGVXV6/WR4RNP8IW2gaKYVBwRusH75fFVfEMGmID3mtendg0D3CaQqHkX
	CMgDzMelW3OsnxbZ2NMYOssIbxyzIoc1jSsDiqHD4J0Tnc
X-Received: by 2002:a17:902:db11:b0:1f3:39d9:b2c3 with SMTP id d9443c01a7336-1f339d9b4d2mr17003715ad.50.1716440707123;
        Wed, 22 May 2024 22:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRzZMAyDpsUmfR6YQ3M3Cp6U7ziKK4PidDnLj0rz4oSMtKMe54QBcMLcgMyZ5mWzKqYrss7g==
X-Received: by 2002:a17:902:db11:b0:1f3:39d9:b2c3 with SMTP id d9443c01a7336-1f339d9b4d2mr17003275ad.50.1716440706265;
        Wed, 22 May 2024 22:05:06 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f34076df6asm3603595ad.37.2024.05.22.22.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:05:05 -0700 (PDT)
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
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v4 3/7] crash_dump: store dm keys in kdump reserved memory
Date: Thu, 23 May 2024 13:04:44 +0800
Message-ID: <20240523050451.788754-4-coxu@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240523050451.788754-1-coxu@redhat.com>
References: <20240523050451.788754-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_220514_712113_E4947EC4 
X-CRM114-Status: GOOD (  16.25  )
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
index cc81b8a903ab..bd40f4208e1f 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -370,6 +370,10 @@ struct kimage {
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
index 78809189084a..89fec768fba8 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/key.h>
+#include <linux/keyctl.h>
 #include <keys/user-type.h>
 #include <linux/crash_dump.h>
 
@@ -111,3 +113,88 @@ int crash_sysfs_dm_crypt_keys_read(char *buf)
 	return sprintf(buf, "%s\n", STATE_STR[state]);
 }
 EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_read);
+
+static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
+{
+	const struct user_key_payload *ukp;
+	struct key *key;
+
+	pr_debug("Requesting key %s", dm_key->key_desc);
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
+	pr_debug("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
+		 dm_key->key_desc, dm_key->data);
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
+	if (key_count != keys_header->key_count) {
+		pr_err("Only record %u keys (%u in total)\n", key_count,
+		       keys_header->key_count);
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
+	pr_debug("Loaded dm crypt keys at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		 image->dm_crypt_keys_addr, kbuf.bufsz, kbuf.bufsz);
+
+	return r;
+}
-- 
2.45.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

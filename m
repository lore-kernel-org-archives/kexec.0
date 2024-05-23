Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C02BC25B75
	for <kexec@archiver.kernel.org>; Thu, 23 May 2024 05:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PNHLqi3f0hkGTXtHToq5nT98/vddTK9Tz0+lyPRCXp0=; b=bny9gT9JsZ2c+T
	v9AoRQ6biLVZgwKYBK25/t+9IT2kyIxmC0hZAIq04dk4C72lq7Nb3FfTtnh0kr0uyWQ43b1392JhY
	vvv1fvNn/ezLawy6Tovay6aWKrplaU7NcbcPvqPIUF/xRFGwN5Ztpp4RsfS4k+U7NIPSy4Hor4Aaz
	7o+ckthNHcVVuDH8oXIbWt4PberiTbiCB7u4fXFBnGapkkCwDncpru1PDQzQR0Gj8cuE4NehemzfI
	5FTRbOWgzWwmA3NpeAUY0YDXfCq3msTu/uKFyjtiOoWbDGXTTk8+VuJ+bL+V4hlC91I7ZF3bC49yZ
	3xQPWGZaf4vTCn4155oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA0dq-000000053yg-1zpw;
	Thu, 23 May 2024 05:05:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA0dk-000000053tG-1kle
	for kexec@lists.infradead.org;
	Thu, 23 May 2024 05:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716440719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fa72I6mP4bkKPgXlioSXRQnIrhjQErXvO71QcCop5iA=;
	b=HhLftxVoWyu8oL+7fiZ0UBzJyU1xYPphmwCp6PBEudDYmsOoEKY7TAFrsxoPVwKU4t4OG4
	yJRsNTUBpRkWI+92hA2ob8S1qvPz0g3wSM1W5DMU2AdMhOuT2gfwc+rn17IQI5GpS6aaG2
	csJu9/xvnnHdFAAVpG/Uc9q5UaEaAPg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-qbq_XLDwPEC84v9IYrY0cA-1; Thu, 23 May 2024 01:05:17 -0400
X-MC-Unique: qbq_XLDwPEC84v9IYrY0cA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1f32359a24cso17475185ad.2
        for <kexec@lists.infradead.org>; Wed, 22 May 2024 22:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440716; x=1717045516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa72I6mP4bkKPgXlioSXRQnIrhjQErXvO71QcCop5iA=;
        b=lwMYOLSKhbvv/ZZb2/RX/DALzGfJonGO6mKGpkjSW33bpDzAcnt1Ps+dLyEVpeZXbi
         UHP/eDmqGrmXL3TGdUq+BIvQy6D0DY/VCZH0tkkhtwudgcYfWC1zhIXTWQSL1ckZ4guo
         Pmy/JpNeFVuRz3Fy53KixfYsuSbDhjBp4UQ9UwdX82dafAmGfV83uO/2W/RYM26MYUAo
         B1FTjW9wqWhwvxBKLOAJEkTAdLIarUGep7Bezz2iQlPoHzyNW+zrjlfEtBNeL7Mia/UN
         130GL3L0vmI1hof0uCGVsdrw8pCf6i/F/p+bNZIlgfLI86h5QAFk0h1jNohVq9hE2SyF
         EqiQ==
X-Gm-Message-State: AOJu0YwUpiUhWda0r3iln9FdW1EsZJGDpVCvb86SG8rdoegkmucE2KYr
	DNzRt/ZiTIiZKBmAuI0PDwKfBqVImUkLfHhN7SP/LsU1tuWbmnOv9FNtSQRWAytahaYmBNnmLpc
	zkG5frqbZ6q2YXobGHkDuGEerJd7MHDcYRbYTSjZkf/lJqiFAZ0MtTy0M0+Bxf5IGVXivSUzbPX
	Z7DkB69RWX9A2faszPMoTTHDZm8AjbaAw+yHE4T6v1ww==
X-Received: by 2002:a17:902:ff0a:b0:1ee:a09e:c7b0 with SMTP id d9443c01a7336-1f31c98db57mr32586415ad.37.1716440715215;
        Wed, 22 May 2024 22:05:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHesrH0cqL5v8PGClCEwXynBSxt1oIPal3K2H0JK1dua8ax6gHHJh4QCElpHvpZJQCyMDnSkw==
X-Received: by 2002:a17:902:ff0a:b0:1ee:a09e:c7b0 with SMTP id d9443c01a7336-1f31c98db57mr32586005ad.37.1716440714356;
        Wed, 22 May 2024 22:05:14 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f336103357sm7676865ad.128.2024.05.22.22.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:05:13 -0700 (PDT)
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
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v4 5/7] crash_dump: retrieve dm crypt keys in kdump kernel
Date: Thu, 23 May 2024 13:04:46 +0800
Message-ID: <20240523050451.788754-6-coxu@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240523050451.788754-1-coxu@redhat.com>
References: <20240523050451.788754-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_220520_719790_7BFEA9A4 
X-CRM114-Status: GOOD (  19.30  )
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
index ab20829d0bc9..d7308b6e83f4 100644
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
index b4dc881cc867..dd818581858b 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -33,12 +33,67 @@ static struct keys_header {
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
2.45.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

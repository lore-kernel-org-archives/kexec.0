Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7757DC27C53
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=045CleRtcs1PvAaBU6oRyQLeBb57lQyZr/OPC3+3c8Y=; b=eSQvUDjXXJcX6n
	YyHrfy6oQVg/NBVM/wSDaSgLRzCZwiqHYo3kk48wd6N4H3s0FrzwR6+axBKZ8eUJsgg09OoBTGqci
	3nNd8UrgemtzAmlVFnTYqZp2DYvGCfM3ztUSatCqE51bJQJqqwKbPLL625dE5L+k6PSc+gxUw3Cvq
	/FKp15E4Wfidiol/5DvyfznJyk7UCNt2MUQSfFBpwyVtcrZqTJ2whX1oEetjrfA2iNrJkQtdNQ2eu
	61jz331JYHuRhVYqDKq/+wngOQhRifwiMIHUER6Bfap74PNkNif6PrZ6hWfjuMszRk1wDBbgBjKA/
	gsU1AHgaHMGkBNPuL8Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYgR-0000000Duey-0ij6;
	Fri, 07 Jun 2024 12:27:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYgN-0000000Ducm-2MtF
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:27:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PnrGjun192AtksvBWoEeo2xFayBkQDU9eM35Zfke7SA=;
	b=HMMfX8jXtnSs4HWJsM/uO/GlgngOEnx3yFzbcGknGQsArM6G54jnZ0NSPb25YPIKmsEWC3
	7/6yOg+rhpo8fjaTh+xMo3R76E0YuQogAd7XkURCclxNMiG9Gn+FRxyeL8+RpsbVDHTf16
	N77W4/QQ3jA1JYhuYvN46hP1LJCtwto=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-Q_KrhFWYPLunmShsrZOtbA-1; Fri, 07 Jun 2024 08:26:57 -0400
X-MC-Unique: Q_KrhFWYPLunmShsrZOtbA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c1b396d80aso1773389a91.1
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763215; x=1718368015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnrGjun192AtksvBWoEeo2xFayBkQDU9eM35Zfke7SA=;
        b=AhCqUwei4eWhxKfSlpoydVdl2eFFlT3GsHaAsIljgoO7aWjLVYyqd3h3zYZlnaH46M
         ZhAZAvgSobGX4Rvl4ByA33bjx3edGKDiLC0eBk1HTj6Xmiq9yGqr07tT61kUpqUZZ/4y
         TpY1f1sKG45QvReg+Ko6xe3DGJxJcc3FDK8Ja34F+l/fqFaWzeFYsZUfrcjVBXs7oJk4
         nCoiVg+gLPtJiHaFlfrcCOTAyoxDaljfzwCaYujwIfDmAHZ4vS2R/RDcV0PRwfsPS/XL
         wkkt6bC7w+8zH7AFzawLKVvt9+s76L5tmGkk7dM0b5jIxWTXsT2Wu9gHDuoYPgbwuw9V
         ns+g==
X-Gm-Message-State: AOJu0YzAbFQOFgVo0Iot/W10jsv5x+B8vXn2Z9i207wigD1s08b3u2eR
	6Sz+kzeCZSprr1qWufcwN2LvhFwXfgYNihu3ih+1dWwj4e4Cu7ey6qrujqE2w2GZy08wy4cJZsF
	mye4YZEHZeA3/PPT2TySAPWV6HHCGxBlI/tzP6sNC9+Iw9JB39rkmjBFrCSze2J4KE5Q4ZMEMUn
	UTFbydhMcjag85gtT3grrvrC7mvIW2fDMoBJjizU1D0Zbh
X-Received: by 2002:a17:90a:ce8d:b0:2c2:d442:aa10 with SMTP id 98e67ed59e1d1-2c2d442ab77mr88258a91.45.1717763215128;
        Fri, 07 Jun 2024 05:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVjl4mp00EGKOz+YDE5MMuMdnmKS1XOHdz89KRwxto50YFnqTs7CRYSuimTnD6kBsJW/UMEA==
X-Received: by 2002:a17:90a:ce8d:b0:2c2:d442:aa10 with SMTP id 98e67ed59e1d1-2c2d442ab77mr88213a91.45.1717763214227;
        Fri, 07 Jun 2024 05:26:54 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2c5c05208sm1129893a91.16.2024.06.07.05.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:26:53 -0700 (PDT)
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
Subject: [PATCH v5 5/7] crash_dump: retrieve dm crypt keys in kdump kernel
Date: Fri,  7 Jun 2024 20:26:15 +0800
Message-ID: <20240607122622.167228-6-coxu@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607122622.167228-1-coxu@redhat.com>
References: <20240607122622.167228-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052659_713832_3CAD09C2 
X-CRM114-Status: GOOD (  22.29  )
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
 Documentation/ABI/testing/crash_dm_crypt_keys |   3 +
 include/linux/crash_core.h                    |   1 +
 kernel/crash_dump_dm_crypt.c                  | 101 +++++++++++++++++-
 3 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/crash_dm_crypt_keys b/Documentation/ABI/testing/crash_dm_crypt_keys
index 7426c9d8de97..56a4b878a4dd 100644
--- a/Documentation/ABI/testing/crash_dm_crypt_keys
+++ b/Documentation/ABI/testing/crash_dm_crypt_keys
@@ -29,4 +29,7 @@ Description:	read/write
         the kdump kernel has been loaded with the dm crypt keys stored to kdump
         reserved memory
 
+    After the kdump kernel gets booted, user space can write anything to this API
+    so the dm crypt keys can be restored to the keyring.
+
 User:		Kdump service
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
index 9a6bd39adf76..00223343473b 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -40,12 +40,67 @@ static struct keys_header {
 	struct dm_crypt_key keys[] __counted_by(total_keys);
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
 				   size_t total_keys)
 {
 	return struct_size(keys_header, keys, total_keys);
 }
 
+/*
+ * Architectures may override this function to read dm crypt keys
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
 /*
  * Let the kernel know the number of dm crypt keys and allocate memory to
  * initialize related structures.
@@ -139,11 +194,53 @@ static int process_cmd(const char *buf, size_t count)
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
+		kexec_dprintk("Failed to get keyring %s\n", key_desc);
+		return PTR_ERR(keyring_ref);
+	}
+
+	addr = dm_crypt_keys_addr;
+	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
+	if (key_count < 0 || key_count > KEY_NUM_MAX) {
+		pr_info("Failed to read the number of dm_crypt keys\n");
+		return -1;
+	}
+
+	kexec_dprintk("There are %u keys\n", key_count);
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
+	for (int i = 0; i < keys_header->total_keys; i++) {
+		key = &keys_header->keys[i];
+		kexec_dprintk("Get key (size=%u)\n", key->key_size);
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
 EXPORT_SYMBOL_GPL(crash_sysfs_dm_crypt_keys_write);
 
@@ -184,7 +281,7 @@ static int build_keys_header(void)
 	for (i = 0; i < key_count; i++) {
 		r = read_key_from_user_keying(&keys_header->keys[i]);
 		if (r != 0) {
-			pr_err("Failed to read key %s\n", keys_header->keys[i].key_desc);
+			kexec_dprintk("Failed to read key %s\n", keys_header->keys[i].key_desc);
 			return r;
 		}
 	}
-- 
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

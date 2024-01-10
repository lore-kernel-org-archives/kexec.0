Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD72C47258
	for <kexec@archiver.kernel.org>; Wed, 10 Jan 2024 07:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pA9jXsqmQx8DE+MIbWK+VABSgR0k7lFdGSJrdcQYn1M=; b=Om3Rjsj5f4nXi2
	7XncHDRmMivZXxQcwUi1hZ9U+8sCey4dpMdy+tpZnvcTsnfNYuadLmMgOWxmEGvW+M6dIy4BGZOR5
	6ZFmEZlPKdDujZnk1g3jvs4tzWpUx/dTwISjVfNHkGoD9+8lWz/cAn8Alm4hGNYN3y4dVdfjeGf3n
	zlNrHnwob/eHjPkXLpIKhjMHrE+HBOp/fN9aa4MBXm7qL56x6jPgWevCHTFOOJyKNlL1GVghZgOQx
	TCFZqUoaSzuZwaKeBNstxtBBEoWHGTD6k2bL/0KcfWf0yL6QQ+dTqeVsmJPPJJaqGig9FVnNwHN16
	lX6kOxUBG25jk6QrG4hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNSpw-00AaLf-1n;
	Wed, 10 Jan 2024 07:17:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNSpu-00AaL9-08
	for kexec@lists.infradead.org;
	Wed, 10 Jan 2024 07:17:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704871033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3LBEoP+OVX8UUvtwqHYPUzM09NfmAQKAOTayWOj3vA=;
	b=Wc6z0upkfnj5QO01viHGN9mIpbUWadhVg07+xmUS/W71nQi6QjiJVN9W5fNNKJG+BG0De+
	BkAgwLyqawaChrfpD/H5DQluwLcu9o5dSl5ZvT3xRGrP6IghwxPC8EW4z7qMJQe+XyHAS+
	V+gpEgNKt2JqQ5vLipfTzuPiUXYaBRE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-gktdrsLuO3S7dSkXkhIkew-1; Wed, 10 Jan 2024 02:15:39 -0500
X-MC-Unique: gktdrsLuO3S7dSkXkhIkew-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5ce105ddef5so1654957a12.2
        for <kexec@lists.infradead.org>; Tue, 09 Jan 2024 23:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704870937; x=1705475737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3LBEoP+OVX8UUvtwqHYPUzM09NfmAQKAOTayWOj3vA=;
        b=az0PeXdUM8l9ubSU2e7NgVeiRBFHN/M7PaN7GabI91c2hYoUVNFd7BGnyh1dJks3tp
         o2n+agVGpvllZmBylPVmjDtNKnGjuf5NALKdLdppzZKmvPxM2cK2zY8Pp5t5mOJgcstr
         K0GJWTtgU1lR2ePwsjeeKhf4aXpE6prx0ZIXXsPufayE3srhmnHWVbr1g10FLxa37IKp
         pA2pqxTSJrXy8IDWNNy9QxmsR3g0zn/Q6Ez6jSkuCPgXxR4OWGvoVlhPMKPhwrevZ3hb
         amcDSZ+HumsfVbfLsWJuGqWBbH5RT5oAIwgKBq7geLow3+WkvEtZEv3Cp4vgoxnJF0P4
         UKiQ==
X-Gm-Message-State: AOJu0YxEqmDVBo8ednlSPiz8HX7R0QTFNwlNi/wFGOrgTzfcPHTePPxM
	A7PtyVAklHEaRtobgDp8s5mSU/RoyJVnuvbOehwgvZAhkZ+TcyBD/p4jOhgemT6NqG2/7jP22r5
	JyQQBZXPHOImSkvf9/7Fn2D8+4s5kDmgq56pEoYkPkdpZHVqYe4oUTDk9/7DSwkFo2wnVZYTgBH
	93Q0W+DExNzBu39Ng=
X-Received: by 2002:a05:6a20:549e:b0:199:c19b:a256 with SMTP id i30-20020a056a20549e00b00199c19ba256mr404154pzk.48.1704870937188;
        Tue, 09 Jan 2024 23:15:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3nLLyWzEHi8GA97DXbubxlvK/ZzzZcacj++eTqbSYnzzAxKQ7SEAvlr+1Nh2nV5RIQChmgA==
X-Received: by 2002:a05:6a20:549e:b0:199:c19b:a256 with SMTP id i30-20020a056a20549e00b00199c19ba256mr404133pzk.48.1704870936721;
        Tue, 09 Jan 2024 23:15:36 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001d46a313b42sm2888381pls.268.2024.01.09.23.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:15:36 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v2 3/5] crash_dump: retrieve dm crypt key in kdump kernel
Date: Wed, 10 Jan 2024 15:15:18 +0800
Message-ID: <20240110071522.1308935-4-coxu@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110071522.1308935-1-coxu@redhat.com>
References: <20240110071522.1308935-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_231714_154187_59BD96E2 
X-CRM114-Status: GOOD (  22.04  )
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

Crash kernel will retrieve the dm crypt volume key based on the
dmcryptkey command line parameter. When user space writes the key
description to /sys/kernel/crash_dm_crypt_key, the crash kernel will
save the encryption key to the user keyring. Then user space e.g.
cryptsetup's --volume-key-keyring API can use it to unlock the encrypted
device.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_dump.h   |   2 +
 kernel/crash_dump_dm_crypt.c | 115 ++++++++++++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index acc55626afdc..b44adc3962da 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -15,6 +15,8 @@
 extern unsigned long long elfcorehdr_addr;
 extern unsigned long long elfcorehdr_size;
 
+extern unsigned long long luks_volume_key_addr;
+
 #ifdef CONFIG_CRASH_DUMP
 extern int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size);
 extern void elfcorehdr_free(unsigned long long addr);
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 3a0b0b773598..755017fa5c1b 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -1,7 +1,82 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/key.h>
+#include <linux/keyctl.h>
 #include <keys/user-type.h>
 #include <linux/crash_dump.h>
 
+unsigned long long dm_crypt_key_addr;
+EXPORT_SYMBOL_GPL(dm_crypt_key_addr);
+
+static int __init setup_dmcryptkey(char *arg)
+{
+	char *end;
+
+	if (!arg)
+		return -EINVAL;
+	dm_crypt_key_addr = memparse(arg, &end);
+	if (end > arg)
+		return 0;
+
+	dm_crypt_key_addr = 0;
+	return -EINVAL;
+}
+
+early_param("dmcryptkey", setup_dmcryptkey);
+
+/*
+ * Architectures may override this function to read dm crypt key
+ */
+ssize_t __weak dm_crypt_key_read(char *buf, size_t count, u64 *ppos)
+{
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	return read_from_oldmem(&iter, count, ppos, false);
+}
+
+static int retrive_kdump_dm_crypt_key(u8 *buffer, unsigned int *sz)
+{
+	unsigned int key_size;
+	size_t dm_crypt_keybuf_sz;
+	unsigned int *size_ptr;
+	char *dm_crypt_keybuf;
+	u64 addr;
+	int r;
+
+	if (dm_crypt_key_addr == 0) {
+		pr_debug("dm crypt key memory address inaccessible");
+		return -EINVAL;
+	}
+
+	addr = dm_crypt_key_addr;
+
+	/* Read dm crypt key size */
+	r = dm_crypt_key_read((char *)&key_size, sizeof(unsigned int), &addr);
+
+	if (r < 0)
+		return r;
+
+	pr_debug("Retrieve dm crypt key: size=%u\n", key_size);
+	/* Read in dm cryptrkey */
+	dm_crypt_keybuf_sz = sizeof(unsigned int) + key_size * sizeof(u8);
+	dm_crypt_keybuf = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					      get_order(dm_crypt_keybuf_sz));
+	if (!dm_crypt_keybuf)
+		return -ENOMEM;
+
+	addr = dm_crypt_key_addr;
+	r = dm_crypt_key_read((char *)dm_crypt_keybuf, dm_crypt_keybuf_sz, &addr);
+
+	if (r < 0)
+		return r;
+	size_ptr = (unsigned int *)dm_crypt_keybuf;
+	memcpy(buffer, size_ptr + 1, key_size * sizeof(u8));
+	pr_debug("Retrieve dm crypt key (size=%u): %48ph...\n", key_size, buffer);
+	*sz = key_size;
+	return 0;
+}
+
 static u8 *dm_crypt_key;
 static unsigned int dm_crypt_key_size;
 
@@ -23,6 +98,43 @@ static DECLARE_DELAYED_WORK(wipe_dm_crypt_key_work, _wipe_dm_crypt_key);
 
 static unsigned __read_mostly wipe_key_delay = 120; /* 2 mins */
 
+static int retore_dm_crypt_key_to_thread_keyring(const char *key_desc)
+{
+	key_ref_t keyring_ref, key_ref;
+	int ret;
+
+	/* find the target keyring (which must be writable) */
+	keyring_ref = lookup_user_key(KEY_SPEC_USER_KEYRING, 0x01, KEY_NEED_WRITE);
+	if (IS_ERR(keyring_ref)) {
+		pr_alert("Failed to get keyring");
+		return PTR_ERR(keyring_ref);
+	}
+
+	dm_crypt_key = kmalloc(128, GFP_KERNEL);
+	ret = retrive_kdump_dm_crypt_key(dm_crypt_key, &dm_crypt_key_size);
+	if (ret) {
+		kfree(dm_crypt_key);
+		return ret;
+	}
+
+	/* create or update the requested key and add it to the target keyring */
+	key_ref = key_create_or_update(keyring_ref, "user", key_desc,
+				       dm_crypt_key, dm_crypt_key_size,
+				       KEY_USR_ALL, KEY_ALLOC_IN_QUOTA);
+
+	if (!IS_ERR(key_ref)) {
+		ret = key_ref_to_ptr(key_ref)->serial;
+		key_ref_put(key_ref);
+		pr_alert("Success adding key %s", key_desc);
+	} else {
+		ret = PTR_ERR(key_ref);
+		pr_alert("Error when adding key");
+	}
+
+	key_ref_put(keyring_ref);
+	return ret;
+}
+
 static int crash_save_temp_dm_crypt_key(const char *key_desc, size_t count)
 {
 	const struct user_key_payload *ukp;
@@ -60,7 +172,8 @@ int crash_sysfs_dm_crypt_key_write(const char *key_desc, size_t count)
 {
 	if (!is_kdump_kernel())
 		return crash_save_temp_dm_crypt_key(key_desc, count);
-	return -EINVAL;
+	else
+		return retore_dm_crypt_key_to_thread_keyring(key_desc);
 }
 EXPORT_SYMBOL(crash_sysfs_dm_crypt_key_write);
 
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

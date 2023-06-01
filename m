Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4664C77B7A
	for <kexec@archiver.kernel.org>; Thu,  1 Jun 2023 07:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KVabb3FGOXO6gbWh8UoRJUijlon+m74DeXRXWMJrAnA=; b=rNGIW5kco0NEnf
	76hS0RXR5jmvri8UghkDhKEpsw2k13ydE1gY4VLoLPK3pdHHLisFg3OdQacFLRVCGAxMYGewDs8K8
	as8L93NMZsAaRg0u/JL8iCy8JynNVPEFC5Wu3Kvwr/74V8FD75tHfgblMVDBlVJDkkYKA+PTdd2gT
	17fzcceBWW+u8AwRYKat5rPU7xg7DhGWjesdUSbwthGbt4StWsQnUFPjqeI8o5HFw19ZO/yazjKCG
	Os7B105dZU8dTr225pIUYh04+oNkF11VT+lOnNaeUGo1DiODYHqMSKWsXQT/Tncqx179rNOxAU5Xd
	MdC8JPUl/qXM/KkucNtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4ci8-002Lyq-2y;
	Thu, 01 Jun 2023 07:27:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4ci6-002LxH-0d
	for kexec@lists.infradead.org;
	Thu, 01 Jun 2023 07:27:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685604421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSdEOOvVOvBHgbxdtA0aSxX16fM93R7Xrib46N4HMRQ=;
	b=MmWZZJ1RZ94cLAnY99J93v3xkDCsE8MEMFwoFap0AHaJMbg1VpAcTebaFO9ahFyEWS0X7e
	P9lUCOg4Zo2pmGhHPivesZp38cG9bvaABNnNB6a9ANB784aCDdqnBDLmKlL8PSjgijn+sG
	GYnMaRdVJf/eB8FICnvp/yuZKCTF0dk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-ERyqzBppNnOz5GwiNnxXrw-1; Thu, 01 Jun 2023 03:25:01 -0400
X-MC-Unique: ERyqzBppNnOz5GwiNnxXrw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-64d24df4852so254249b3a.2
        for <kexec@lists.infradead.org>; Thu, 01 Jun 2023 00:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604300; x=1688196300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSdEOOvVOvBHgbxdtA0aSxX16fM93R7Xrib46N4HMRQ=;
        b=KGf33R+B260FpOjifLQY+T0J3O33l3tM+4bCsNrfAYSLEaxPLLtsTGGYhatz/AypAt
         HQpA/L1J0efyP3I0kmol3qkLMT01Q74OAy6zPwHmjT7DS5ove5yfxY4XBiNNSWE11pg9
         jqsIIOeuYhegbKCVoyPu68dOsTlBfXBmnSCB+bwvZxLbIv/DG+bsjxsCzyvaA1bNFKxZ
         EtJfNe3ZQ6dyB3VkzyrAyDBIDNPcEGwrU4/C+UO+OOtv0+tp7NnkJL5wcEmn3yHU0eiw
         YItB3/PwKbzlek835Y3nR47Vvsig7xlGtPRX39ziM4R/V+e9bPgY3F11cAifu6n+2u46
         KmzQ==
X-Gm-Message-State: AC+VfDx6yfWP383yBsFNMkhbABsPgO3hsLcyFllqYQX9fE0YgR+ls23Q
	TriIE3QAqRjd49VuoubMdZLUzJDRM7QtOekRpQwYzWVeTL++YvYE5kB0JlgypZkgyWhRQw8eWTU
	iAXhjuYZ2SAc4OwuF2n4xPRny1i+uC0la7DW7TjZLZ2Uo7Fe2fVecU3L3VgaFsOKrLzAhPH1rYH
	rIDhy1
X-Received: by 2002:a05:6a00:1a51:b0:63b:5496:7af5 with SMTP id h17-20020a056a001a5100b0063b54967af5mr7757662pfv.1.1685604300358;
        Thu, 01 Jun 2023 00:25:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7dvgVyrzGCsjuOATzcCkMb2NCswn1qLkQ0iET/24u8jgUcZoCb8ABgYZHVIPusFMkwCuiucw==
X-Received: by 2002:a05:6a00:1a51:b0:63b:5496:7af5 with SMTP id h17-20020a056a001a5100b0063b54967af5mr7757634pfv.1.1685604299873;
        Thu, 01 Jun 2023 00:24:59 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f18-20020aa78b12000000b0064d27a28451sm4433388pfd.100.2023.06.01.00.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:24:59 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
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
Subject: [PATCH 3/5] crash_dump: retrieve LUKS volume key in kdump kernel
Date: Thu,  1 Jun 2023 15:24:42 +0800
Message-Id: <20230601072444.2033855-4-coxu@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601072444.2033855-1-coxu@redhat.com>
References: <20230601072444.2033855-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_002702_309508_1C194AF6 
X-CRM114-Status: GOOD (  21.07  )
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

Crash kernel will retrieve the LUKS volume key based on the
luksvolumekey command line parameter. When libcryptsetup writes the key
description to /sys/kernel/crash_luks_volume_key, crash kernel will
create a thread keyring and add a logon key.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_dump.h |   2 +
 kernel/crash_dump_luks.c   | 116 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 0f3a656293b0..bc848e058c64 100644
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
diff --git a/kernel/crash_dump_luks.c b/kernel/crash_dump_luks.c
index 2d88b77a93f8..63718db318c3 100644
--- a/kernel/crash_dump_luks.c
+++ b/kernel/crash_dump_luks.c
@@ -1,7 +1,82 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/key.h>
+#include <linux/keyctl.h>
 #include <keys/user-type.h>
 #include <linux/crash_dump.h>
 
+unsigned long long luks_volume_key_addr;
+EXPORT_SYMBOL_GPL(luks_volume_key_addr);
+
+static int __init setup_luksvolumekey(char *arg)
+{
+	char *end;
+
+	if (!arg)
+		return -EINVAL;
+	luks_volume_key_addr = memparse(arg, &end);
+	if (end > arg)
+		return 0;
+
+	luks_volume_key_addr = 0;
+	return -EINVAL;
+}
+
+early_param("luksvolumekey", setup_luksvolumekey);
+
+/*
+ * Architectures may override this function to read LUKS master key
+ */
+ssize_t __weak luks_key_read(char *buf, size_t count, u64 *ppos)
+{
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	return read_from_oldmem(&iter, count, ppos, false);
+}
+
+static int retrive_kdump_luks_volume_key(u8 *buffer, unsigned int *sz)
+{
+	unsigned int key_size;
+	size_t lukskeybuf_sz;
+	unsigned int *size_ptr;
+	char *lukskeybuf;
+	u64 addr;
+	int r;
+
+	if (luks_volume_key_addr == 0) {
+		pr_debug("LUKS master key memory address inaccessible");
+		return -EINVAL;
+	}
+
+	addr = luks_volume_key_addr;
+
+	/* Read LUKS master key size */
+	r = luks_key_read((char *)&key_size, sizeof(unsigned int), &addr);
+
+	if (r < 0)
+		return r;
+
+	pr_debug("Retrieve LUKS master key: size=%u\n", key_size);
+	/* Read in LUKS maste rkey */
+	lukskeybuf_sz = sizeof(unsigned int) + key_size * sizeof(u8);
+	lukskeybuf = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					      get_order(lukskeybuf_sz));
+	if (!lukskeybuf)
+		return -ENOMEM;
+
+	addr = luks_volume_key_addr;
+	r = luks_key_read((char *)lukskeybuf, lukskeybuf_sz, &addr);
+
+	if (r < 0)
+		return r;
+	size_ptr = (unsigned int *)lukskeybuf;
+	memcpy(buffer, size_ptr + 1, key_size * sizeof(u8));
+	pr_debug("Retrieve LUKS master key (size=%u): %48ph...\n", key_size, buffer);
+	*sz = key_size;
+	return 0;
+}
+
 static u8 *luks_volume_key;
 static unsigned int luks_volume_key_size;
 
@@ -23,12 +98,48 @@ static DECLARE_DELAYED_WORK(wipe_luks_volume_key_work, _wipe_luks_volume_key);
 
 static unsigned __read_mostly wipe_key_delay = 3600; /* 1 hour */
 
+static int retore_luks_volume_key_to_thread_keyring(const char *key_desc)
+{
+	key_ref_t keyring_ref, key_ref;
+	int ret;
+
+	/* find the target keyring (which must be writable) */
+	keyring_ref = lookup_user_key(KEY_SPEC_THREAD_KEYRING, 0x01, KEY_NEED_WRITE);
+	if (IS_ERR(keyring_ref)) {
+		pr_alert("Failed to get keyring");
+		return PTR_ERR(keyring_ref);
+	}
+
+	luks_volume_key = kmalloc(128, GFP_KERNEL);
+	ret = retrive_kdump_luks_volume_key(luks_volume_key, &luks_volume_key_size);
+	if (ret) {
+		kfree(luks_volume_key);
+		return ret;
+	}
+
+	/* create or update the requested key and add it to the target keyring */
+	key_ref = key_create_or_update(keyring_ref, "logon", key_desc,
+				       luks_volume_key, luks_volume_key_size,
+				       KEY_PERM_UNDEF, KEY_ALLOC_IN_QUOTA);
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
 static int crash_save_temp_luks_volume_key(const char *key_desc, size_t count)
 {
 	const struct user_key_payload *ukp;
 	struct key *key;
 
-
 	if (luks_volume_key) {
 		memset(luks_volume_key, 0, luks_volume_key_size * sizeof(u8));
 		kfree(luks_volume_key);
@@ -61,7 +172,8 @@ int crash_sysfs_luks_volume_key_write(const char *key_desc, size_t count)
 {
 	if (!is_kdump_kernel())
 		return crash_save_temp_luks_volume_key(key_desc, count);
-	return -EINVAL;
+	else
+		return retore_luks_volume_key_to_thread_keyring(key_desc);
 }
 EXPORT_SYMBOL(crash_sysfs_luks_volume_key_write);
 
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

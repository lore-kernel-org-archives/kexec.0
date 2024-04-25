Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93895C4345F
	for <kexec@archiver.kernel.org>; Thu, 25 Apr 2024 10:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CEygw5eZvhTnFFlslAu/oMqwIKmgtCHMb8H5feXc4I4=; b=tGX8Pd7yKmZ7wU
	ULN/isMNh2aoIO8ENAR3vTXlc3WuCggIayFLf92D8K7oUmYmTi0gGPoTxDZxvRciuPlBDZ09d636n
	j33Fml/Zzmy+A243nYLe8nMsJb/dpcgQtnglIDRZIFSPlonSYaxTREzV5kQvwqi+R0yjQGVuMVFau
	Ue4YiXVPf5ki4AkKH40lLCHq/FF90oaoq5rhjBg9TdFkROLjqFEcNR2NiyvmLupaF4DLjTw3i8EEK
	opubeNQ4wOzqbuf6zOB/u541x8BuyK1YIlA0udqyh1+kf1fmGKPMBqLJoK0VlF7b2Tc3sm+F1meqH
	YRHwHYkspVRHjhggWZvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyK-00000007kga-11aH;
	Thu, 25 Apr 2024 10:04:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyH-00000007kcr-07cI
	for kexec@lists.infradead.org;
	Thu, 25 Apr 2024 10:04:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSAzgqiOHIuKA09Cs5shkE69JGVMkIODKj0EL1ZNyW4=;
	b=YM+EVEB6WTWDUZz/MqlkADvXw0+sKKFMr8zSfTI0scBUjnptH3zH1izgrsfpgzeHfdSX9M
	h2hJ/xzjt5TQ2A0Z5wDLgL/AUnAYplrb+WOPkmlGkUC+0kwEqUGWvaAYi9hu3CTi+stSWd
	QoQWKfHYUDSvT19lCdzyzUYRQRtpDDk=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-tKJox3fgOtiKvTsf1DerqQ-1; Thu, 25 Apr 2024 06:04:50 -0400
X-MC-Unique: tKJox3fgOtiKvTsf1DerqQ-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a1a2f396aso8520505ab.3
        for <kexec@lists.infradead.org>; Thu, 25 Apr 2024 03:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039489; x=1714644289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSAzgqiOHIuKA09Cs5shkE69JGVMkIODKj0EL1ZNyW4=;
        b=RDrtsTdCAb1wpXIY5/bkds48uonGdINbAG/Zsm/rcorpazrK4a+8R6aPXzKnvKmjiX
         O42/7hS9h3VPZ4zHjqYlXGdPWLE6K8AdbzaK7sUhhrfAgJBBwycbwRQI4k7n83JLBG5f
         7xY4qMtWJ7sc4Fh8XqdlhFxUFPJBe9W1bZnhZDzN1QyNh6TFJMRiOheSak6cQxV/HUKW
         8FkwH0C8UaTXwsnVlDA8tNx1mdT4GpwIt0o00TstVE/U0bSqgmWT664lrSfPo7UoXZdt
         rtj7EBvave3rI/hS3eEP9fPxqjRsS12KELB3GQ2jboYdcXhNJJyZjdBRN34MnZib5eFe
         Wv7g==
X-Gm-Message-State: AOJu0YxV+jDwYeC8mBG/Xuz5RATO8y/SYhWzrm3qfwauz9x9Ofk/DxCK
	RDmgTi3AJLyuAVzvhmQsZ3U/LqS9zPrZ+ndk0fVm8/4Y1lqvFqq4FvghQhuAJ28WBBgE0Zz3VjV
	jwlwj40dd9ohZvs1aIsur2QBosmvw+1SdCIjMVCMpZe0gi6vTww5tSuM7pqGnPQU87w8mWl7rFZ
	0sC1HtpamKKMz1oOlB72oDpmWJdCb74kFoEg9E3nDPfxLw
X-Received: by 2002:a05:6e02:1745:b0:36a:2934:a8e5 with SMTP id y5-20020a056e02174500b0036a2934a8e5mr5635775ill.9.1714039488543;
        Thu, 25 Apr 2024 03:04:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoMQilVk8BI7H+0dXhYwX2dauRoxQgUM6e36ENJnKqLls92oinsXqpyWO930vlNvqn3rst5Q==
X-Received: by 2002:a05:6e02:1745:b0:36a:2934:a8e5 with SMTP id y5-20020a056e02174500b0036a2934a8e5mr5635712ill.9.1714039487818;
        Thu, 25 Apr 2024 03:04:47 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v28-20020a63481c000000b005f7536fbebfsm12282033pga.11.2024.04.25.03.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:04:47 -0700 (PDT)
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
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v3 3/7] crash_dump: store dm keys in kdump reserved memory
Date: Thu, 25 Apr 2024 18:04:27 +0800
Message-ID: <20240425100434.198925-4-coxu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425100434.198925-1-coxu@redhat.com>
References: <20240425100434.198925-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_030453_335335_BE739A74 
X-CRM114-Status: GOOD (  16.22  )
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
index 98825b7e0ea6..1f3d5a4fa6c1 100644
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
index fc1e20d565d5..b6cedce66828 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -368,6 +368,10 @@ struct kimage {
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
index 847499cdcd42..b9997fb53351 100644
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
+		vfree((void *)kbuf.buffer);
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
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

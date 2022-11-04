Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A0AC4332F
	for <kexec@archiver.kernel.org>; Fri,  4 Nov 2022 11:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z0VgG3sBi/q9Wcy/iOFZj1+HsaDh2FQoxYUVIRzB840=; b=eA1aha9ZYjITsI
	kSYakcuzW2N1IYoPLzB+CJqXUXjgZsCA0/fBo1ZpzP8tYSIzsoL2McREJYGCUFT+9/mq2Xxb6OQ33
	mZDWLDzi/NQZU1jNUtmjS/lGd4u/6rMw4XhiPE72TD4lMq4pXjkYgnVvIk7I717b+iJHT7KEHP8L8
	5DiqGLPddxxh2/ZLiqpPr8w6AUAVd6UT73y3AkXF4FApSnZ2bhPbVlNpV0nx3/JpesAgeDaZCdgmN
	lRAV5+DkuYNIsm6pHuWYUfwm1RU08HJpGkZcITH8dwlzg3mbF0MJnTA0tsEPc0z6anxDnxpY6r07/
	lZyB4sXousOQkqP20Hrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oquw0-003MDE-FE; Fri, 04 Nov 2022 11:32:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oquvx-003MBB-Cw
	for kexec@lists.infradead.org; Fri, 04 Nov 2022 11:32:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667561544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tChygk51qSEpKRajoEIhCZC1g4gkmcKbQyIR3WZ7WJ0=;
	b=Pl3GOqcy73FKwOXSj5RlFv/sDD8X6ziDx79G7WtZkqw1eEK5SDzs+vqDhnQzlcvcv+10vk
	v0aJ8WRFOON0xsX6x4ZOxuKi1WkNFYXvGss4sYV2cR9LgtSko4lSeIi7KiiLnRyJDKcvbB
	oVxop+3yFsDoqOJHZGMD++q1AgTsivM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-Cr1KvMBWNxGVWv4UGzzTZA-1; Fri, 04 Nov 2022 07:30:55 -0400
X-MC-Unique: Cr1KvMBWNxGVWv4UGzzTZA-1
Received: by mail-pf1-f198.google.com with SMTP id y15-20020aa7804f000000b0056c9b4a58d3so2325438pfm.18
        for <kexec@lists.infradead.org>; Fri, 04 Nov 2022 04:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tChygk51qSEpKRajoEIhCZC1g4gkmcKbQyIR3WZ7WJ0=;
        b=nLO5HICTpbhDsBzcnF5H/zHPQm7Fw8Yq7mv0PTb4Tkl8E9tScBjMVqoo5MoXvlqkOD
         /w+SFgbyVtIFDJUdquvw7o7HvziR8oRTvvj5itEsRnhwaG03YRxfOvO7pFeP/a/O2q1y
         BP9L+m9LK9+ENU+LYGtYKb24GuBLZkrnI5ZXvTtj0AwnPh7hKZAD9T0XVDdO3xktcErs
         XHK61K1Mx5AOd21bb38DFxMndDGKzFrwLpFQz4lcga/5R1T5u6SEs8vZPdvWqD4EpFIM
         x7nCusv31d2rPcK9Em6rwlkD2mQveuHeKv8LI8w/L9Av1fOdRRYMCQ4PnwoRfhDk18E5
         XMXA==
X-Gm-Message-State: ACrzQf3BKtZiAQvMmbHzEmyYgh2Y6b2e8caurrPXKkwjw2qgjEAAvv62
	ZFNsHHf8QmUV0WFiTHydDFiwFRWzs3XHWEeFNaZjfbgCtCwxm0ee80ido8OeLPM2j2wgurC/qQf
	nd4B8yjj9fO003GK0Ia0+nuSW3Z328fH+RWn4DJX6dFLJ9kQQ85zUfQdADfVnSZJoiVM=
X-Received: by 2002:a05:6a00:3698:b0:56d:3180:e88f with SMTP id dw24-20020a056a00369800b0056d3180e88fmr32007721pfb.66.1667561454266;
        Fri, 04 Nov 2022 04:30:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6/YFb404UDQuedNToGLAqLTqEInClQiUntzz+pWfWaKxI00OswIw7b6D7Q0zuVJH1Lqg4s3g==
X-Received: by 2002:a05:6a00:3698:b0:56d:3180:e88f with SMTP id dw24-20020a056a00369800b0056d3180e88fmr32007679pfb.66.1667561453799;
        Fri, 04 Nov 2022 04:30:53 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ca8-20020a17090af30800b0020669c8bd87sm1483003pjb.36.2022.11.04.04.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:30:53 -0700 (PDT)
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
	Vivek Goyal <vgoyal@redhat.com>
Subject: [RFC v2 5/5] crash_dump: retrieve LUKS volume key in kdump kernel
Date: Fri,  4 Nov 2022 19:30:00 +0800
Message-Id: <20221104113000.487098-6-coxu@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221104113000.487098-1-coxu@redhat.com>
References: <20221104113000.487098-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_043225_536678_26766FBE 
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

Crash kernel will retrieve the LUKS volume key based on the
luksvolumekey command line parameter. When libcryptsetup writes the key
description to /sys/kernel/crash_luks_volume_key, crash kernel will
create a thread keyring and add a logon key.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_dump.h |   2 +
 kernel/crash_dump.c        | 116 ++++++++++++++++++++++++++++++++++++-
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
diff --git a/kernel/crash_dump.c b/kernel/crash_dump.c
index 9c202bffbb8d..77a6b84415e8 100644
--- a/kernel/crash_dump.c
+++ b/kernel/crash_dump.c
@@ -5,7 +5,10 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 
+#include <linux/key.h>
+#include <linux/keyctl.h>
 #include <keys/user-type.h>
+
 /*
  * stores the physical address of elf header of crash image
  *
@@ -16,6 +19,8 @@
 unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
 EXPORT_SYMBOL_GPL(elfcorehdr_addr);
 
+unsigned long long luks_volume_key_addr;
+EXPORT_SYMBOL_GPL(luks_volume_key_addr);
 /*
  * stores the size of elf header of crash image
  */
@@ -41,6 +46,76 @@ static int __init setup_elfcorehdr(char *arg)
 }
 early_param("elfcorehdr", setup_elfcorehdr);
 
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
 
@@ -62,12 +137,48 @@ static DECLARE_DELAYED_WORK(wipe_luks_volume_key_work, _wipe_luks_volume_key);
 
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
@@ -100,7 +211,8 @@ int crash_sysfs_luks_volume_key_write(const char *key_desc, size_t count)
 {
 	if (!is_kdump_kernel())
 		return crash_save_temp_luks_volume_key(key_desc, count);
-	return -EINVAL;
+	else
+		return retore_luks_volume_key_to_thread_keyring(key_desc);
 }
 EXPORT_SYMBOL(crash_sysfs_luks_volume_key_write);
 
-- 
2.37.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225D2C53219
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 03:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iAvbwMsP6u3CRel/M6F31lU9QmM+5c0AKpJB0BJsLjQ=; b=BKzEWcopeRkOEa03M/8qu2oHgk
	zXG1jqrs6y71pbjh313ng7oL8O6gJnd10SB4MoAiNCk5UEZGXYjyHdQz0B9qjx+cIw+xIuBc1K7cy
	9uDh4BZwWPalAcspP4cEHQECFkOHah9apGtIc14slV2qClQfhxeAho1n3+OrM5Gtvz3V0SjyR0EMC
	MEGs0OF0npPZ9hYyerXtyUTVzs79HykJvJKqdYvkdYrGNmMuEwU+kDHuqZSyvgMrb8KK7OKFu9ExI
	VQRhQ2zQCBwW3B7eO6WyEAKAmltfbRBUlPkpCqSb9FwsCDPHHv86ZGQr24Rp8U0Nq8u6BR+6obYiw
	199LCz5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6w-00000006lcO-0UOQ;
	Wed, 29 Jul 2026 03:37:38 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6t-00000006lan-49r0
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 03:37:37 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-848d21bbaffso523349b3a.0
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 20:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296255; x=1785901055; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iAvbwMsP6u3CRel/M6F31lU9QmM+5c0AKpJB0BJsLjQ=;
        b=NXILeMEjIaDQ4nX4sRdxuInaUtqPhbWduO3vEYm0kPo0M8xdu9IxaxQj7qz2DPjdO2
         GPZn4RHK8qBjpGIKaIX3Sp3H15gaDNf3YTfl2t2+2OPkc41O3S2JK9pi0Ux2h8uvuE6y
         6NZkeUZmky6UvxfUKZb019uUqfMYfPto5YXB2Q2q5TzerheT43MVniCqJvrM06aGLJ9o
         KFa2OoJ3eI16D5WuCxmsP5+i49hlBsFoR0Llcpb7ekfdbEIKX8eIuOvdQRacF9vo3S8f
         8NWTVjqeWmsRGJ27jGHq8PeQms/fOHApGh0e1mf4oss1ODaTdA/476A4/Rk/OFg7kS0x
         k46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296255; x=1785901055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iAvbwMsP6u3CRel/M6F31lU9QmM+5c0AKpJB0BJsLjQ=;
        b=o07mKLPDRCsXKKVC1ougtiOeogrEN6aoIDNZHb9ZaUO9euGVChc+7AodgoE4/g1RH4
         c0RyFKcFl2OZONmzcxBIARmp5Mu9+3APXmt20jK+d66citlRf3A4wotHbE0wKWcA86Mi
         thhqOjQw/IMh5gQs8Y55Z4QcWAkRC1V6WrlIvsuyh4bKGwv104lshx5KS8ShqHaPZfMV
         inKEb5f7ghtr0vZ5gpQwncuiVMse9kVLT6vUQzqw5b25TiT0lIDn1bcQ0oyLA0M/K4ho
         YOS7jrQa8srbPwOoGv/4d02D64+8ngZRSaO8zEh4gh4njDU79vM2PCQLk3lHCd/vW8fH
         wUEg==
X-Gm-Message-State: AOJu0Yy7tHB6DRxqsyWv/8pAVg6R9z8e7RNfSViP2e3pgl+TuoDavHiV
	f8zMfCyeEF/4mE4i5lkID3yUWOBAke0jbqlaxkEX2UGg7Rp6AypnuInJO+Gns0DDJSolwQ==
X-Gm-Gg: AR+sD12bUfdnPmhcCRJvHgzym5FDm4t7cdmzbl41rJ1VNHdussAHWsEAZUwZYMUdW8G
	4c+BWqrty4btI5Aea0lwNznkoG08ho9dUtjZMpZSNaEO59OMl6sg5DV0prxdsvShnUmwR/W04+t
	+468FBTjU0ihYHWh0e+eZYMKm4Mrn8zVwwzZ5oB59Rl210450kVpcSriiEc7yyejayk3VZ9SpcP
	Yh6E3A7uPcEB4+a+OE2UJd1X9cfnp3PIoAAfBeT9UCpVaCEY4KOm3nGmylKcVhAkdXNhvrP8AYy
	4y/8Z64A1doQmxTvBXhyNW+wmx2szh0/c2e0dX2sJ/sLWqEhf89GJn5vv2BKVzSdRWbMnBZ7W5z
	ZzwQ2ED4ZQn8qEvUZcwoXjXT0/hTZtxv4ud6VDIVgl/vTtRjQiTqdUKVJLbpTkUkAyggOigctr8
	GDJyjGZQcYjSzTPMKtfUoOXDjTJs2sXDr3hB1IPPydcYw=
X-Received: by 2002:a05:6a00:400b:b0:847:9386:3ee2 with SMTP id d2e1a72fcca58-84e93264387mr5083267b3a.42.1785296255122;
        Tue, 28 Jul 2026 20:37:35 -0700 (PDT)
Received: from localhost ([2a09:bac5:42f2:1e1e::300:30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb7a99a7dsm282177a12.5.2026.07.28.20.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:37:34 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Coiby Xu <coxu@redhat.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 09/10] crash_dump: Disallow configfs/crash_dm_crypt_key/reuse if crash hotplug supported
Date: Wed, 29 Jul 2026 11:36:49 +0800
Message-ID: <20260729033654.311541-10-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729033654.311541-1-coiby.xu@gmail.com>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_203736_040366_CD17E9A2 
X-CRM114-Status: GOOD (  16.62  )
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

If crash hotplug is supported, dm-crypt keys saved to reserved memory
will be taken care of automatically. Thus it doesn't make sense to use
configfs/crash_dm_crypt_key/reuse. Reserving image->dm_crypt_keys_addr
is also unnecessary. Currently x86_64 and ppc64le have implemented
crash hotplug feature.

Also update the doc accordingly. Note two doc issues are fixed as well.

Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 Documentation/admin-guide/kdump/kdump.rst | 16 ++++++++++------
 kernel/crash_dump_dm_crypt.c              | 23 ++++++++++++++++++++---
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 7587caadbae1..0bf2eb100a05 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -577,9 +577,10 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
 
 1. Tell the first kernel what logon keys are needed to unlock the disk volumes,
     # Add key #1
-    mkdir /sys/kernel/config/crash_dm_crypt_keys/7d26b7b4-e342-4d2d-b660-7426b0996720
+    VOL1_UUID=7d26b7b4-e342-4d2d-b660-7426b0996720
+    mkdir /sys/kernel/config/crash_dm_crypt_keys/$VOL1_UUID
     # Add key #1's description
-    echo cryptsetup:7d26b7b4-e342-4d2d-b660-7426b0996720 > /sys/kernel/config/crash_dm_crypt_keys/description
+    echo cryptsetup:$VOL1_UUID > /sys/kernel/config/crash_dm_crypt_keys/$VOL1_UUID/description
 
     # how many keys do we have now?
     cat /sys/kernel/config/crash_dm_crypt_keys/count
@@ -591,15 +592,18 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
     cat /sys/kernel/config/crash_dm_crypt_keys/count
     2
 
-    # To support CPU/memory hot-plugging, reuse keys already saved to reserved
-    # memory
-    echo true > /sys/kernel/config/crash_dm_crypt_key/reuse
-
 2. Load the dump-capture kernel
 
 3. After the dump-capture kerne get booted, restore the keys to user keyring
    echo yes > /sys/kernel/crash_dm_crypt_keys/restore
 
+For CPU/memory hot-plugging, you can reuse keys already saved to reserved
+memory before reloading the kdump image,
+    echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
+
+Note if crash hotplug is supported, this API is totally unnecessary thus will
+be disabled automatically.
+
 Contact
 =======
 
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index b5b78656cf06..46d6b31c3ca4 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -310,6 +310,15 @@ static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
 	return sysfs_emit(page, "%d\n", is_dm_key_reused);
 }
 
+static bool crash_hotplug_support(struct kimage *image)
+{
+#ifdef CONFIG_CRASH_HOTPLUG
+	return image->hotplug_support;
+#else
+	return false;
+#endif
+}
+
 static ssize_t config_keys_reuse_store(struct config_item *item,
 					   const char *page, size_t count)
 {
@@ -317,6 +326,11 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
 	bool val;
 	int r;
 
+	if (kexec_crash_image && crash_hotplug_support(kexec_crash_image)) {
+		pr_debug("Crash hotplug supported\n");
+		return -EINVAL;
+	}
+
 	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
 		pr_debug("dm-crypt keys haven't be saved to crash-reserved memory\n");
 		return -EINVAL;
@@ -513,9 +527,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
 {
 	/*
-	 * For CPU/memory hot-plugging, the kdump image will be reloaded. Prevent
-	 * keys_header from being cleaned up during unloading when
-	 * is_dm_key_reused=true
+	 * For CPU/memory hot-plugging without CONFIG_CRASH_HOTPLUG, the whole kdump
+	 * image will be reloaded. Prevent keys_header from being cleaned up during
+	 * unloading when is_dm_key_reused=true
 	 */
 	if (!is_dm_key_reused) {
 		kfree_sensitive(keys_header);
@@ -526,6 +540,9 @@ void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
 		mutex_unlock(&config_keys_subsys.su_mutex);
 		mutex_acquired = false;
 	}
+
+	if (crash_hotplug_support(image))
+		image->dm_crypt_keys_addr = 0;
 }
 
 static int __init configfs_dmcrypt_keys_init(void)
-- 
2.55.0



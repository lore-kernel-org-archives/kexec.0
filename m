Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72164C61DC6
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 08:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IoRqUM+47pfba3G9EFhzXQlo7kPydRkr+L2gqXTvUTw=; b=yW7/39vmB4XVy0+QvZk0c0ku8g
	YJ7wAflIzqAUXe1agL7QXnWMGVs2IE91y9Xk97DeR5JSNKZcmp8o0TApn2/zysXMRnkGtO/dxnm0U
	Z3Jwdkinkq5C0xE8MGAfFmzn0YMeSEK2VR+1Z8i//OGnFhWt5gaYcotcku2MgMxwAY4jo5U2ITZKu
	AtT35vhSbWSl8bkTqqAou5FhepPmpCSiG7/E5aDewT7KmzDHxnYmqzyYGsGGb7SwCnSldl6TAdjRZ
	VAR+BRE407iMJ2lmb9eKb3jF4T9qxgm44NiR+JPPrh0l9zj82lDv7LN6cZE6wKfms2/C4VjXdmOzW
	qe8Lkfyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsHE-00000005LlW-2867;
	Fri, 28 Aug 2026 08:49:32 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsH6-00000005LZ0-1zUU
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 08:49:25 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1349476a91.0
        for <kexec@lists.infradead.org>; Fri, 28 Aug 2026 01:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906963; x=1788511763; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IoRqUM+47pfba3G9EFhzXQlo7kPydRkr+L2gqXTvUTw=;
        b=rco4lKzcrfQrEddefRPCq89EI7helc6Grqumk4Bfai33qkzOSvz4ledcixsBKK9P8R
         BRuwVYRNo9+cR5bZaA6xabYGulfyHwP147mMeBtxBkXMNuHRRpi1kvb20Xw3kVcYXkN5
         MALEmEJljBj+YwMgPjAgeRp/tPKPvm89Kz+ZrMw9riexyZV8+kgMsL3YRtsQkuvd1uZQ
         0y0JOqqQkjTVAnnCeF4PgulDT2ppz1w59ZpLxhpJy65rnfyxope1RnDqivWe5ShfX2Xk
         RtD2nIvntPh9pmtAfgS8PhBJ2HpEdDI9poBoUWomAeogrFc1F/iPNxA4DVIcUZddBnya
         qowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906963; x=1788511763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IoRqUM+47pfba3G9EFhzXQlo7kPydRkr+L2gqXTvUTw=;
        b=i4nCo1GR4p95sGz0cWwZ79uN4kMR9kKn36FEjr7raffJJiEwyjbJYBrGIu0eIbBrY3
         pnLm8MYDYEyEFMCLgLE04DvmH+bfoXeGA+HxuSeXESro6ZxglvujP7xk929dL9qgscr9
         hR5yfzn8mLN4B2wV4SdETWnnY/obC01tWIyaQGUDRwEXxwiKG/vvdStAEGYhV1srLYnX
         kTLq+pmnvafu6kKYVmVAh51Eg5nSitj/cnhBjJgaIMsJ4boP9YY9Tg9vIBs8CiNfpyB5
         h5T4xSNXV4wHJSrmQLaZctng+Nrc01kW2BVC9CFRyQFd+FYo+dxPYaQ+p8j/SkN0u/Jr
         AatA==
X-Gm-Message-State: AFuF++lgR6uwP+7bZWaXOXrvvq9xuROYqWSBitAQLGBCBFZL7WjCG3yQ
	x04BVedc57alRxNqOwmsxdonKpm9izBhPZnj9yAi0bNq8EmSlPbG2cdnbHBMZ7uQBrg=
X-Gm-Gg: AR+sD12kjVEDfaSiRyV65ieJ945SDOvL9h0gJhb4m51NlAYUtK8bl852JmZObC+Vus/
	I7L+lKhxy1Qqbfw2whq64YM047OYFCl18sMB428ecmL+9k8tO/MK1FO99cNnf9goUB077gz9EHV
	txxWlgrJIlgRt9h/9g0HQb6ciBYGXNVAir+CJ0Swhrah/jocDK6FZL2beZYbmBWdHlJNU7OQEKY
	zHJI2rZFbmcmIOsxfUmPwtAOZLXVBtBZkfc3NopKfLkzyc4dMqw+TeNJ8vu0tH3PfNzPyCq9NOY
	jPiMSg9c11gcjpsgeEYZu9xVaUxu+Bh1556FKs8zlkvoAN0jIR01E2u3RXWGseiTn+vrINpQp2B
	3Mf18mtXkOV9gD8TNNePLbJ41rFZw7UlU6DI7r4OAZkIFmJA0qcLS9KS1GCqus1E8dKV663SF7o
	tZKWJbetHKV2XcBBDbEh1iBAbAZIfRuZ3ZpAMT1w14YsghbwZ7xHOq1WSCFeuR+Y+OilXR0w==
X-Received: by 2002:a17:90b:4c4c:b0:396:635a:9b10 with SMTP id 98e67ed59e1d1-396d0ebfb0amr9370873a91.11.1787906963332;
        Fri, 28 Aug 2026 01:49:23 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:a97:707e:a14f:cfbf:3e23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d1abbdsm3975657c88.2.2026.08.28.01.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:49:22 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 5/9] crash_dump: Only use kexec_dprintk during the kexec_file_load syscall
Date: Fri, 28 Aug 2026 16:48:51 +0800
Message-ID: <20260828084900.1496839-6-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828084900.1496839-1-coiby.xu@gmail.com>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_014924_577798_44D9F6F6 
X-CRM114-Status: GOOD (  12.08  )
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

kexec_dprintk will only be activated by "kexec -d" during
kexec_file_load syscall. So use pr_* outside of this syscall.

Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 91b7a5413b62..9ccc7b5320a3 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -76,10 +76,10 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
 	if (!IS_ERR(key_ref)) {
 		r = key_ref_to_ptr(key_ref)->serial;
 		key_ref_put(key_ref);
-		kexec_dprintk("Success adding key %s", dm_key->key_desc);
+		pr_debug("Success adding key %s\n", dm_key->key_desc);
 	} else {
 		r = PTR_ERR(key_ref);
-		kexec_dprintk("Error when adding key");
+		pr_warn("Error when adding key, ret=%d\n", r);
 	}
 
 	return r;
@@ -129,19 +129,19 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 	keyring_ref =
 		lookup_user_key(KEY_SPEC_USER_KEYRING, 0x01, KEY_NEED_WRITE);
 	if (IS_ERR(keyring_ref)) {
-		kexec_dprintk("Failed to get the user keyring\n");
+		pr_warn("Failed to get the user keyring\n");
 		return PTR_ERR(keyring_ref);
 	}
 
 	addr = dm_crypt_keys_addr;
 	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
 	if (key_count > KEY_NUM_MAX) {
-		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
+		pr_warn("Failed to read the number of dm-crypt keys\n");
 		ret = -1;
 		goto out;
 	}
 
-	kexec_dprintk("There are %u keys\n", key_count);
+	pr_debug("There are %u keys\n", key_count);
 	addr = dm_crypt_keys_addr;
 
 	keys_header_size = get_keys_header_size(key_count);
@@ -155,7 +155,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 
 	for (int i = 0; i < keys_header->total_keys; i++) {
 		key = &keys_header->keys[i];
-		kexec_dprintk("Get key (size=%u)\n", key->key_size);
+		pr_debug("Get key (size=%u)\n", key->key_size);
 		add_key_to_keyring(key, keyring_ref);
 	}
 
@@ -315,8 +315,7 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
 
 	r = -EINVAL;
 	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
-		kexec_dprintk(
-			"dm-crypt keys haven't be saved to crash-reserved memory\n");
+		pr_debug("dm-crypt keys haven't be saved to crash-reserved memory\n");
 		goto unlock;
 	}
 
-- 
2.55.0



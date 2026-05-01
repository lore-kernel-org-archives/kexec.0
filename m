Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AEECCFA13
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 23:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7yG+7nozXqY2jD1ConB/MN0MOX8qKIWBN1J+a4MYII=; b=LxhyzUwe8YPClpdgvGSauGdNsM
	Ds8GowDYWsJUatwb3f9T+IR0Z5nigghaKXr9PLkYDzmLtqQmTIor0BMwpi9wzvn+LpPnUwlGw/EEH
	JOnb0h3bllA+i6FEv4qc0mBNddq2Wg53B1vJLTJNTi/KDYVjvwyBHv3+JEmHH+qUflGPq66bZ0dg2
	7B9UCYllr8WyIgaONzWPN3OhwttGS9EkK2qdyrVeMXH34boeJDSxAZ/WNIkPU1IoYOoQhQcQTVcOT
	SF7/Rp5qHUP1KOI9P3rWevSwfn8UUafoJBY1sbKIQ7sheQKIA9Q4rxon7/vvAHPd3xcPdR9mrb8Gy
	7FmDtSNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxXN-00000007qkZ-2fZ3;
	Fri, 01 May 2026 23:44:49 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxXL-00000007qjp-1PY4
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 23:44:48 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso1749271a91.0
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 16:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777679086; x=1778283886; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7yG+7nozXqY2jD1ConB/MN0MOX8qKIWBN1J+a4MYII=;
        b=ERFiWGiOsGL66kLriCtm9YeS5z+2aoi6mtMbBczSFeZQ1CQTnhHybL7cfpzCSJrUe4
         btsLwO0znOI+6Q47ODBcB84LTOhpFFbr4HAjczCjBZqmEBL58kZ9iKoRyNIIxYfFz7DU
         5EKzsY5vurHPiXk3f5DEEuWU8MyE1T+1Bh8caiIoMOjZBD9YrrPg4NACFPs1dQA+ly5t
         sXcPECJI/gmXc4rJ4hMtnYbBTyU505jFGnWNiGzTHb7mruvhsTuBGbe3zOAc3blOCEdz
         w8PQTPSrAXmYabfQkH4zXlSI2sI+ANQfdFZGqY9NhekK7Iwbarktad3x4V0vTRqWq0vM
         rdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777679086; x=1778283886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7yG+7nozXqY2jD1ConB/MN0MOX8qKIWBN1J+a4MYII=;
        b=eyZ2zlOE2JaNew1H52ki33Efp0DG+jfgu3jQfOmZY1rxrqnxZ9Bz5W58DHDgUYBGbB
         6CjH2ETiHNCJ2cxyEHJ8rJQoEeqbC0zOEJcZR8g8nqK0xiH0L2jBDuzkH7iHP4QieIQh
         K4mOa/vtOl9/fdNjv5V8ONsOG4S6U3nSu0Bo4iY4/OSegewbWbOw3XE2X17JxjYmwmU8
         wXm7MWu9oYoiMLhPQgcfgbEAm1oc0uktxAG+gUkmns23nv61IU5eRl1eia8uI/G2g1xI
         RweYZ90+kpW1oAy17koJQZD9DboqAiv4jYtXKiOq8bguyO46IJax1jYY+h5Slk0/NIPm
         Smug==
X-Gm-Message-State: AOJu0YwSSHqpxfdKzfo9yWKuY/rbCYFIk/eR8dEgddkG5YBsZqfezlhZ
	zgGi7UwuLkAelbEkcTQiQh5tUeXkDkuMU/C73cxvgNIckM2Qq3S+DvN0XXxQcUxXKrlKQA==
X-Gm-Gg: AeBDieuVl7/u2OAkOI8Y0KJUjIaODFOvH40ZpvGJjqARFHqC8OTDiuMeszFjTbhAL/N
	yONRu5LVhHIKhWVvNMe7H5zvhxZ6Pimbbu0kS+1Jh2a0gBZFBqsr2rSZDLtAvcbiBjIYX04s1aw
	bvOiT2lKQXE/EHyHQsyLmKdHzNZK5/h1dqw8LCOCjgH9v7N5kYAzvS/9i/MXatIwCbVLanDBqz8
	79Y4MszQYAqnnoySde5b/N8ihMYZIhJ5TcqrLXX3cbZmwfOJPCyaZJP7j6R6xuqa0d9v/wUm+/7
	pGr2LGiuECsjrLTAEXj92im4wT4uFvaID2yxTD6mbf+wcRcTFYxZmlehabEQu6d+5M7n9v/A93X
	AbPpW+E6gH1jKyEgIT8o1SZH3vbc781UhNhBtoG/EtcW+pk8JqLLBn53m/W/hNF8VbGAroJsojg
	7+ENU23Ep0spbPb2G5+Urtg5814F84FA==
X-Received: by 2002:a17:90b:518c:b0:35b:e51a:ec77 with SMTP id 98e67ed59e1d1-3650ce38376mr1164990a91.16.1777679086499;
        Fri, 01 May 2026 16:44:46 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caaaf0e5sm32537925ad.18.2026.05.01.16.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:44:46 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Coiby Xu <coxu@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 6/9] crash_dump: Only use kexec_dprintk during the kexec_file_load syscall
Date: Sat,  2 May 2026 07:43:35 +0800
Message-ID: <20260501234342.2518281-7-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501234342.2518281-1-coiby.xu@gmail.com>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_164447_375271_A8944898 
X-CRM114-Status: GOOD (  12.04  )
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
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 72ae2dffb077..545d712428d3 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -75,10 +75,10 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
 	if (!IS_ERR(key_ref)) {
 		r = key_ref_to_ptr(key_ref)->serial;
 		key_ref_put(key_ref);
-		kexec_dprintk("Success adding key %s", dm_key->key_desc);
+		pr_debug("Success adding key %s", dm_key->key_desc);
 	} else {
 		r = PTR_ERR(key_ref);
-		kexec_dprintk("Error when adding key");
+		pr_warn("Error when adding key");
 	}
 
 	return r;
@@ -127,18 +127,18 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
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
 		return -1;
 	}
 
-	kexec_dprintk("There are %u keys\n", key_count);
+	pr_debug("There are %u keys\n", key_count);
 	addr = dm_crypt_keys_addr;
 
 	keys_header_size = get_keys_header_size(key_count);
@@ -152,7 +152,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 
 	for (int i = 0; i < keys_header->total_keys; i++) {
 		key = &keys_header->keys[i];
-		kexec_dprintk("Get key (size=%u)\n", key->key_size);
+		pr_debug("Get key (size=%u)\n", key->key_size);
 		add_key_to_keyring(key, keyring_ref);
 	}
 
@@ -305,8 +305,7 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
 	int r;
 
 	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
-		kexec_dprintk(
-			"dm-crypt keys haven't be saved to crash-reserved memory\n");
+		pr_info("dm-crypt keys haven't be saved to crash-reserved memory\n");
 		return -EINVAL;
 	}
 
-- 
2.54.0



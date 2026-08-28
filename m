Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C787C61DCD
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 08:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lBCqnFd2ROR09ubLzgkPheF5ruoB300JChyTgSHw5pM=; b=D0munduC6PpKrAeDV0KQsP5R4Z
	qZD9qdfeIgEMbTZl6TwhAFAfu9fBs9ygmuRVqiinO3NHl22aPq7yOJMUD6wYdJA7Zvyx06JFJPRWj
	yuCd+0ElAdhD4SsTAuX/R5arvZtaKsSIohQmLrSfnx9rzsZR2ASuwWmhrmLObK1c8htWjjQsyvP7L
	6reMd+L7QMH/0c0z/1op2wlGdORttOn5yK9VnFZA679Ck0/vpbBHd0Ey0zTyww9Rkwq4FzB4xDF1q
	UVjiOBryKqMQ7HSFZRaFK6qAMo/bwjCkiUqLzK2oxhvG4Rl6pVPqOzV8/bKb2YAigSeUB7uBX5+IN
	OQf9VLRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsHI-00000005LsG-2ZRm;
	Fri, 28 Aug 2026 08:49:36 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsHC-00000005LjD-3OAF
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 08:49:34 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1014337a91.0
        for <kexec@lists.infradead.org>; Fri, 28 Aug 2026 01:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906970; x=1788511770; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lBCqnFd2ROR09ubLzgkPheF5ruoB300JChyTgSHw5pM=;
        b=Meiy1Z2otIv8H5MnEE5ivWFGBQY3/v3LoCa2b2RM47qptRMH7w6YqKh+1Ztzq3gYsX
         QKEwAcvM9YS885lCi7jX4rz4bzhZchcu0Hx/vC7aiV+ZxK+lEp6VRldC1JC+sMn0+rXo
         RsGSLizy1I95Hh6baXGGlxm0Q4UiGxykQ21fDiSf6l955aPxeS60piqeQQnj0KYx/sk1
         5oWWdLH8CurQWc2oOfaBWghSfTOrDbHJ0OVe97qEFOGMJxv7rIwLHn2erCctEpjvsHLt
         ZCKoI7/0BLhQRX8PWmnOZaWXJfVzUqEYfgf7GDN4ru2gG83PMflz0VHdkiDY1e2cVkNs
         zwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906970; x=1788511770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lBCqnFd2ROR09ubLzgkPheF5ruoB300JChyTgSHw5pM=;
        b=kujlGrha8MOoZ9sm/70tuTJRofG2zLrYjXIIzde/p5+lM96QGO26NKAy1inORFJ6Rl
         hd6kcMwfg0Wd9oXwEf5OH9fiLMtjvTXFYQdmo5bamxFLFk0W58WCyVMyryrZvWsE+yej
         NYAyw3ZOJ1e53x4EtwlgvSLaQNQfDH3TQYqkLF51i3t3agZBgGiNnXTG8VxOyZyAG9IJ
         Zx2z/KH1jEgwlDteDxGm+hdWzTpNa0moFKZNXQPNoeTJ1ZAZopXG4RWLJAHrvOPXge0b
         GxedsRrX6g2vrIQkdo1IegE334LYxgtThJbw3sQT5KeY2qUKSzsToT30eeto+yKkQSNX
         5bag==
X-Gm-Message-State: AFuF++m46A6UIMpC2eCrD/LkuidgwGajy390oGiQI8RghEcadkedDLN6
	J0QDqUky40t8WPzVCH/NrjvtTsnk4gKvXsaePLlRanIoKDm8wPgd9vwJTP6Hb2cLmfw=
X-Gm-Gg: AR+sD13EutorfXPehHPN2825v2aEZVlqUrDbA4M0ETr7VJgYGQ96/0un48TtZndJmRR
	SyHNYe0witLVxPdFtbb1srSAyFC4UwsXMGFlnowRObF2Cll3nkHtt1j3tZt6AeJ+ZCjBwHoZm7r
	mSpvXYDYIk6tNGDf8e6PJEDchZ7lWXQhWeCJeiD5y+wJ2140mvdE/22yfd/4kl3i8yvwc77uk9i
	Vn34lXCJj9qqBZOJ7jBfiV7fkFkwRvwLCqd+rKfbyyULjycSmU04t0lvWAeECBAI9WnoPDJ3j2p
	XOItAiXRDgJuoU5gz9pyj4BazR14PWglqOY0c9fi1PEDTAMNQun7szocRq+xEe6eoIZe3aetQbU
	zi+UDvsbpBe/KPSz0vrY/XiotUrWsRkCJh8B0uviaUMvP3YG7rc9UjbSM84IzeUPdHKfqXMa+Wo
	RLurMfCrFumgkw4L2ZyuaCldOPNY1WF5vS7F6jyrWkgp32sPu4wYymBR5X/1E=
X-Received: by 2002:a17:90b:39ab:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-396d0f74e3cmr10497076a91.10.1787906970180;
        Fri, 28 Aug 2026 01:49:30 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:a97:707e:a14f:cfbf:3e23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0dc898dsm4040503c88.9.2026.08.28.01.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:49:29 -0700 (PDT)
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
Subject: [PATCH v4 7/9] crash_dump: Check the function return codes in restore_dm_crypt_keys_to_thread_keyring
Date: Fri, 28 Aug 2026 16:48:53 +0800
Message-ID: <20260828084900.1496839-8-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828084900.1496839-1-coiby.xu@gmail.com>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_014930_864435_5301B2E6 
X-CRM114-Status: GOOD (  14.39  )
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

We should check the return codes so we can abort if keyring allocation
or reading old memory fails.

Note there is no need to refer a key add_key_to_keyring, so delete
related code.

Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index e82693df73fb..b7629174e4db 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -66,7 +66,7 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
 			      key_ref_t keyring_ref)
 {
 	key_ref_t key_ref;
-	int r;
+	int r = 0;
 
 	/* create or update the requested key and add it to the target keyring */
 	key_ref = key_create_or_update(keyring_ref, "user", dm_key->key_desc,
@@ -74,8 +74,6 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
 				       KEY_USR_ALL, KEY_ALLOC_IN_QUOTA);
 
 	if (!IS_ERR(key_ref)) {
-		r = key_ref_to_ptr(key_ref)->serial;
-		key_ref_put(key_ref);
 		pr_debug("Success adding key %s\n", dm_key->key_desc);
 	} else {
 		r = PTR_ERR(key_ref);
@@ -134,9 +132,14 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 	}
 
 	addr = dm_crypt_keys_addr;
-	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
+	ret = dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
+	if (ret < 0) {
+		pr_err("Failed to read the number of dm-crypt keys\n");
+		goto out;
+	}
+
 	if (key_count > KEY_NUM_MAX) {
-		pr_warn("Failed to read the number of dm-crypt keys\n");
+		pr_warn("Read %u dm-crypt keys (max=%u)\n", key_count, KEY_NUM_MAX);
 		ret = -1;
 		goto out;
 	}
@@ -151,12 +154,18 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 		goto out;
 	}
 
-	dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
+	ret = dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
+	if (ret < 0) {
+		pr_err("Failed to read dm-crypt keys\n");
+		goto out;
+	}
 
 	for (int i = 0; i < keys_header->total_keys; i++) {
 		key = &keys_header->keys[i];
 		pr_debug("Get key (size=%u)\n", key->key_size);
-		add_key_to_keyring(key, keyring_ref);
+		ret = add_key_to_keyring(key, keyring_ref);
+		if (ret)
+			break;
 	}
 
 out:
-- 
2.55.0



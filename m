Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B06C53219
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 03:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z41o0ObBkb9PG0abYLZeVrJjA+L2Zru5sYALSsH0Tb0=; b=4WsfkvQbeUrnzfP+n9s6oER9mu
	/YHhX2llfAgykmf5pNdzYXM6jAmvpi9aED+hD5qZNu8OvYctt9baLS0yOB40afH622468XUeatGJD
	+rRsG5hsjCblxCnLcubLlEBFhWbLXahr6g6Q2XqfZxHm1UK6vyhjJ7jzTq6jqfjhTqbbfM7YBLJ4m
	4q7JjI7HGt+vjMnSnEmNsh7l26vzVWqIOpz72R8/mqTyXXAKAIDixXrx4s/w7YjcStz/5d4F6Rrji
	nm/Fh6gCP5NGoF3YgeE6zv5c6UQj+8DHkshHS1IPCtCqKJAKrDVtxSfPICuOGjj+3gbamJnz2ngmM
	+2aAA4EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6s-00000006laE-40Vb;
	Wed, 29 Jul 2026 03:37:34 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6p-00000006lYZ-1PJi
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 03:37:33 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2cee9b74ee1so4471285ad.3
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 20:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296250; x=1785901050; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z41o0ObBkb9PG0abYLZeVrJjA+L2Zru5sYALSsH0Tb0=;
        b=d7jD3qQDjeJ31/SAZHKsckaoPhsT0120R4N/N3mgXE5zx7QUy0+B4u4jA+y8/4xQlx
         62uqFU0ZMoAHBakaQKN5o1rAY5+fgke8hDPx/QT4AuVnMM10IN2pXdzqwQP3JWdmFY1P
         jY4DIj/09ti2IbqtcsEpXTzrDw2Sj5Vsg08tB6GnUoKWYHZLa6jUqmrjHgjPlYaeaeIK
         OOh9uma1eG/zHYA10vAEzlvWObGrI8PwKy6hHI8UHalSIwIu8YjSE9PqTYNx2xJEeIp0
         e0GeAqGXpEXxih4yoWLqs1H66SrVqwYe4IbNHJPZYTzsmnQhkIY73wm2qgeOJgt3HPeI
         +UVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296250; x=1785901050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z41o0ObBkb9PG0abYLZeVrJjA+L2Zru5sYALSsH0Tb0=;
        b=HUNGrYVzIOwQoTSdBhyjyc3Q13dVtg89AdH44LQOtXNpmgZZLoqy2D+QlO+TpBaGcW
         Wx0ZYMIb1N2LfRI+qCjFQblGToZrHofqHfC29C62i1iAs7i14UYmVFgXE3+b8VNp5Ibp
         m6A95ZdNpd45L4WvVOmv7xXuYc5blhlP/zKe7QS1oWaIMYvprA8F6xlrIfbD2PVX8Mpq
         FI7Y5A/WYt/8G7fO7o6ayLpO32y7s66h3vS5Sr9B9G+GV9Afu0gM8cMu4bgiItU9u0Os
         HdzCHMb2tokK6CD0wqZ7dwyE1k8hUKyA2cEXcYrbbvdG8qOn8kF8IDunDLrggELk9EVT
         WyRQ==
X-Gm-Message-State: AOJu0Yxx9pWKkWsF30Ivu8kLlQX61Zg7Rw+CLcRx+UmGTBq6zBAHG0zq
	szvvPvCVG+oOJVxkp/TVlY5WOl8naF6NXKe89cgUoeuzVCMORdZRwMYOIGySQSLkCeVTyg==
X-Gm-Gg: AR+sD11oAP5PKcCT2vuMvQbjkKPTtSerVtXK5pG1sf0LyT3WCDYkqPnkxXJGRH277DP
	8ki8h506DK9LxRhFpHyEHUOOkFMaSMMBiBrp2qNQIdm2f7+jMRT2l/AogM7ijLlSbXDKCG+/7kj
	TdMD5D4EP5/JI1l+N56ftVblNHciPAlEKeDkfZv4/8Jjb12L1eZjmvmgVsYkRrVJuzhk8VKfuom
	SEC26HzmzlXr9x9yz2neaL775Bq0Zpr/uqlJI2ZCOkt+FFvHjrw0rcI1VNP2bFabkEjrPPoCRCJ
	xYNUA8lMgaF2jrHug5Md2YtpeZZUe+qVPFTBW6C0M+CegOQi/Dl5M4gFJO/aJalNkOzSEMUe/I/
	NVRoNL86f+yLMRVL/bgA0Ee3qrABpeK16RjA0S3/r5Bwim7pkEGSPiM5hQCZh1Qkqq7qvS3CAJM
	vNwxQO2pzniZKxRVJilfnp/3IdvQ1bXhOsV6SpoSGGm8g=
X-Received: by 2002:a05:6a21:d8a:b0:3c3:92ba:c61f with SMTP id adf61e73a8af0-3c8aaf78e1amr6304133637.8.1785296250572;
        Tue, 28 Jul 2026 20:37:30 -0700 (PDT)
Received: from localhost ([2a09:bac5:42f2:1e14::2ff:53])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba3519a5sm275060a12.18.2026.07.28.20.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:37:30 -0700 (PDT)
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
Subject: [PATCH v3 08/10] crash_dump: Check the function return codes in restore_dm_crypt_keys_to_thread_keyring
Date: Wed, 29 Jul 2026 11:36:48 +0800
Message-ID: <20260729033654.311541-9-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729033654.311541-1-coiby.xu@gmail.com>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_203731_411208_D5D9C164 
X-CRM114-Status: GOOD (  15.53  )
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

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 1f4549956824..b5b78656cf06 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -65,7 +65,7 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
 			      key_ref_t keyring_ref)
 {
 	key_ref_t key_ref;
-	int r;
+	int r = 0;
 
 	/* create or update the requested key and add it to the target keyring */
 	key_ref = key_create_or_update(keyring_ref, "user", dm_key->key_desc,
@@ -73,8 +73,6 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
 				       KEY_USR_ALL, KEY_ALLOC_IN_QUOTA);
 
 	if (!IS_ERR(key_ref)) {
-		r = key_ref_to_ptr(key_ref)->serial;
-		key_ref_put(key_ref);
 		pr_debug("Success adding key %s", dm_key->key_desc);
 	} else {
 		r = PTR_ERR(key_ref);
@@ -133,9 +131,14 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
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
@@ -150,12 +153,18 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
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



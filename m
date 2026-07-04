Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DBEC43458
	for <kexec@archiver.kernel.org>; Sat,  4 Jul 2026 11:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EQ2gUxeIt6NcRAiJifRuF+TIWRe9oGJ0XFsRE5fqQJU=; b=R7SyWmlU1K7+zmARF6DjeYxfBk
	r767AqHtjmM9X/480i5yTH0kis+Da5u55kO/6MeBA4NO0YgqrsRgr607Anqf5RFBMnhl8+GCYknue
	5JtbKF6b8A5IkwHy2gb+fwsPWzYzN1dNQeSf35wW+YLmLMWLwemLpxqIEhPyovLLQ9vt4glmVutwY
	OgRvimEMYNZ/OcSJ7GT2MsMauz/pvW4Gja1sE2NwKLF3S/earxPbXYpx2Hb9D+QyfqtL+oau/S5pc
	ie6ho2j/MFAeVPf/OQc3yA4Xf89F54ny/XD8CsFTnweKfwYkkMJ0l4NzUsBrXpSfROzLCmovy6TSs
	vLNmaDYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfyWy-00000008NuM-1HL1;
	Sat, 04 Jul 2026 11:27:32 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfyWw-00000008Ntw-3BA7
	for kexec@lists.infradead.org;
	Sat, 04 Jul 2026 11:27:31 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-8475eca3a66so1979133b3a.2
        for <kexec@lists.infradead.org>; Sat, 04 Jul 2026 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783164450; x=1783769250; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EQ2gUxeIt6NcRAiJifRuF+TIWRe9oGJ0XFsRE5fqQJU=;
        b=U7mkOZivOGxXieUSto3q4HQcLy7bH3Mc+TB9oaCBBgXnb1qyM1+Ee9ACCQ1rhmz4Ek
         gdKtR35njBxv7e35DcLNBWV/N+r8Zgwc940/4aS6QpUWBRe64iUZszf5FRi4sbNk9ahz
         xvgRFZDTKLHeXkbPVzdRJuWM5n7RurvDWwaG2GLPE4GgaDoYwnQR8pmXOta44K5MxZIf
         Bxw+JIXCov8gZcX3hcDao39NRWI1Bkz1ag45We0NI37Adv9wBx7fJZ0Z1F8HJwfZiumz
         qtzOt+E5xclBJjCtfnORxPKru3OyXWM+psdZJT7NMVZOZyKDX3tH96e9oBiyP+QRNxCY
         wtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783164450; x=1783769250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EQ2gUxeIt6NcRAiJifRuF+TIWRe9oGJ0XFsRE5fqQJU=;
        b=U0ET2LqVoJ4GKRLkAKtgzQ7MIgsOOYD1rMVTjal9tHkgJI+bguxitAoiBD8b7eXx8J
         /x6rw2V8T+oHOwiSb1awlAUyY2uVUQsbuvf5RoqQKNqOjHgyBz3LoRd0u6Bi15DHj0H1
         zZXk384KG+zURoylE8f+p32oEu1BqTE+3Efy1e20DWNotkOwFWqVP2BNQMTI+pas/WXj
         8DSiCOtKhDqgNAgnA0ORbZRLEyJUxsN+VluNaW94FTTN4G6awHEQURMPylEfCXWQ8qX1
         zaj3EfhMD5ROP93p9SJKsIPRCOkVx7kvCcPPustA6dZoJwMeLDHBAQA/f/hSpSIjE1tg
         gI/g==
X-Forwarded-Encrypted: i=1; AHgh+RoFn4p6dWho1aLpCo1Gu56ILN0dapa/fUQisUrjpEZXHyVaijPMKnMdea0eoUxSDu+pSztBuA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwTRZgLJOHUjA7jMJA4TJN72G/yGuRWSk4h0HzQ+jrDWCTqbzDL
	G89o1RE3QAqAAQ5T7qtQOS49yHNQCkTs/VraX2G1en2MvWZASGVFDM+z
X-Gm-Gg: AfdE7cnGlK1I1Xx49dVeVIkEkPHKA9urBOaGO7c8DfdfSR4PNFedWqccP03nLgdA5qd
	QYnCVvUB6ZRjIDAqto07wRJU59n2+slmz00+y92ZI21Fk0GzKurzv9+pRxyoCkksoMfPh7IYIZU
	2y1ckpKy4GUiqvIQR80WyBfW2jAOMe8UtLTuI+338KnlSyrLr6AxQCdOzhYbwfAtGrBIWUMgDP+
	+0Yi2NGX+tKcIsv1Z6vEdM3v5zqGc5gO9v7+9TOmF3VU3JYGSyBYmvyTjU3PPBhc861bofn4jfi
	MaTs7v4LrberO5u2fnFge34eQ5VUgkwrvUyKMkAJh6ju9fNf41cpIcwWthgbfd0GI3w7BbRq89K
	fd2I9oBJSElCnovfZMQNqI+q4ew1SygZ7Bu5BiJCweftX5R/tcrKEWv1Ms0Ax7e8sQqMKo+o=
X-Received: by 2002:a05:6a00:2e9a:b0:847:9200:21f8 with SMTP id d2e1a72fcca58-847f6b51320mr3148114b3a.0.1783164449727;
        Sat, 04 Jul 2026 04:27:29 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7a935sm1113690b3a.47.2026.07.04.04.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 04:27:29 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Coiby Xu <coxu@redhat.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH v2] crash_dump: release keyring reference at the correct time
Date: Sat,  4 Jul 2026 19:25:09 +0800
Message-ID: <20260704112509.3717884-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260704_042730_801852_77424645 
X-CRM114-Status: GOOD (  14.32  )
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

restore_dm_crypt_keys_to_thread_keyring() gets a reference to the user
keyring before restoring the saved dm-crypt keys.

The same keyring reference is then passed to add_key_to_keyring() for each
saved key, but add_key_to_keyring() drops that reference on every call.
This is only balanced when exactly one key is restored. With multiple
keys, the keyring reference is dropped too many times and may trigger a
refcount underflow or use-after-free.

When more than five keys are restored, a refcount underflow/use-after-free
warning can be triggered.

The early error paths after lookup_user_key() also return without dropping
the keyring reference.

Keep ownership of the keyring reference in
restore_dm_crypt_keys_to_thread_keyring(), drop it once on all exit paths,
and make add_key_to_keyring() only use the reference without consuming it.

Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Mention the refcount underflow/use-after warning seen when restoring
    more than five keys, as suggested by Coiby Xu.
  - Order local variables in reverse Christmas tree style.

 kernel/crash_dump_dm_crypt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index cb875ddb6ba6..c685497cd470 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -81,7 +81,6 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
 		kexec_dprintk("Error when adding key");
 	}
 
-	key_ref_put(keyring_ref);
 	return r;
 }
 
@@ -104,6 +103,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 	struct dm_crypt_key *key;
 	size_t keys_header_size;
 	key_ref_t keyring_ref;
+	int ret = 0;
 	u64 addr;
 
 	/* find the target keyring (which must be writable) */
@@ -118,7 +118,8 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
 	if (key_count > KEY_NUM_MAX) {
 		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	kexec_dprintk("There are %u keys\n", key_count);
@@ -126,8 +127,10 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 
 	keys_header_size = get_keys_header_size(key_count);
 	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
-	if (!keys_header)
-		return -ENOMEM;
+	if (!keys_header) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
 
@@ -137,7 +140,9 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 		add_key_to_keyring(key, keyring_ref);
 	}
 
-	return 0;
+out:
+	key_ref_put(keyring_ref);
+	return ret;
 }
 
 static int read_key_from_user_keyring(struct dm_crypt_key *dm_key)
-- 
2.43.0



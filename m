Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96475CD6E57
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 13:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jk62JU5ik5+dUH1rmHCPjoy12XeXhXtNgodX+2d0sIM=; b=4XidUDo0zNSmrUJkMRtPmBcZUa
	lrc46kW4HYwDtrWS7FSaymtWcOjLu6Tb+vDrT48QzJb8qsmCQ7/AK3Jxkm2EXEq5sg/PPDrxtAeCc
	YmsGZtpMuisS5nHzHw7GPXOxAYEuVCZC6AZTv4TVPInC5vV+1jQh7ORHJLc5LzNOWFmXyQzm6LDQJ
	xv/FRpy679VcC5bt32wB3/lWzDol16LcQ/RbI5PGBhAvYJHzpaE2CUgEBP7ax9ffwhxg/gUk+MmG0
	Np5N+D7ECG/yVoQopL8ImuZEra+/42YBTmpNdeOdAA3qs2Air2lVNJhj/o5uO6Rdw+GBM7/NkMZHP
	N/gL5u+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUm6n-0000000FD58-3YtP;
	Wed, 03 Jun 2026 13:58:13 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUm6j-0000000FD4E-1lYk
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 13:58:10 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso36577565ad.0
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780495088; x=1781099888; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jk62JU5ik5+dUH1rmHCPjoy12XeXhXtNgodX+2d0sIM=;
        b=Ed7dCFJ+IeU0EIBPe7UCGufdU6rDwcSLKQmhmwcintiHd/BQE1CeIhkMhMid5JiQ5u
         yHYBIoGW4xz0uiQ+89eB6sJkdR3/kwIMGN4xcsrkTGJWra3yJ2rZBpDMxO64e8EIYNiW
         CXky6dEoRGjpK6BMFAO0Z/OB3Hr06KU+jhM3fULpcHmgst+IqutEoLrmFn+9qWGed5HU
         XgLn/TBOPpKKKNoqkK5vLDiLSkiAW09t6baZp5+9MS7rGJ2S6CipdBMQ9ZFFVuIVmegM
         GFM4TS4BL7UXIcb87Q/9CP6lLGkkLy+JYP4tXwCTMtVU9Eoks9W8vGALWorC5pjme/um
         JZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495088; x=1781099888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jk62JU5ik5+dUH1rmHCPjoy12XeXhXtNgodX+2d0sIM=;
        b=gJwJZp/Yhuld7BOXIOP1GdRgJZ9aXz1pHE8Hze/uBJVZNTrygmExEKybLvdCCun5ve
         uUHYvtdvDw4GXZa2OUBYvYWWGAuVxSrcu9taMB42o1qAyk2c/DyLvh7zWc+kozsqW8mZ
         zvlKeUIBVg72QAtm8xtRfvVH7MJTuS/cysDWPTtZQ3HtN2GRim04Pz+ct98ChKgqUKPN
         IX3D/2yBq8tgGxj25Ylp8LVInPIg0tNUN0DeY4R7hD6iOqJO2EZ2Zwthg+UZS4oVG9Gp
         LhWUjSFoo5LX0pZ7ODnwzFlFRi2OrHZAQrrSwEftLn2ZhG7qC1jwcB2FTWJfS+dn5Hsn
         dT0g==
X-Forwarded-Encrypted: i=1; AFNElJ9Fg0URp22WmyaD91rblcu0Y9FFHXXTvD+xZXIOxlMkgQycHQNSmasREt1Y+VcjIBJvW6e9Bw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyJ39GUc4CJggeff9RccsAP/h8JT2wZ45hzd72VFy2enqh//g0l
	xosGikfwEwNgycOGV3ZJGTe2eBUCMi2jnoGLYt4OHuyiinEHIlSjihx0
X-Gm-Gg: Acq92OGWXrKyCueBCYam/c67ciux1nhlX69+/PAurDJMN+iPQV5RbnM1tpRZHU9UeIb
	dxV8WXNjj3cVJxWA93ItwXo4/HINunoc0kvMAYMLYNObO6AVO0mWy0WIl1ZWbbZd2Jv345lCeu3
	MRAf2I7NvFe75U/UKt+axQUw7tzC+c+nTFaluNjZOhBfUBNYe8f1f4OYBSY+YL4hk3IC6qEzd1E
	ZYmeZ1QfshR7LF4K0SooCPcupcHlc03p4bZTE7KpLP7ZVW3zkIyAR2hnL0HmRkzrPXh6Dqr4xHQ
	inGFy0LmEVUXmRsOhTOBKZttIQimi/AxYIxXwUBXZyxnx2+IP+7nk/xZjmHbvWrj/ySDpMZyUdX
	6b5vbmtWX8bWQNPoQWGdnaQiGKO2famEObWdw4cSzCVViwibiUhXZ6yqxoQEEGW2H4Es2Xo4hR0
	gNR+RKyRfh0zI3Wj9h
X-Received: by 2002:a17:903:234c:b0:2bc:eea4:83c3 with SMTP id d9443c01a7336-2c163fa4889mr36746735ad.25.1780495088038;
        Wed, 03 Jun 2026 06:58:08 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e096sm27109875ad.44.2026.06.03.06.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:58:07 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Coiby Xu <coxu@redhat.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] crash_dump: release keyring reference at the correct time
Date: Wed,  3 Jun 2026 21:50:56 +0800
Message-ID: <20260603135056.1397084-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_065809_729400_697D9D7F 
X-CRM114-Status: GOOD (  14.25  )
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

The early error paths after lookup_user_key() also return without dropping
the keyring reference.

Keep ownership of the keyring reference in
restore_dm_crypt_keys_to_thread_keyring(), drop it once on all exit paths,
and make add_key_to_keyring() only use the reference without consuming it.

Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index a20d4097744a..641c290f1270 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -80,7 +80,6 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
 		kexec_dprintk("Error when adding key");
 	}
 
-	key_ref_put(keyring_ref);
 	return r;
 }
 
@@ -104,6 +103,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 	size_t keys_header_size;
 	key_ref_t keyring_ref;
 	u64 addr;
+	int ret = 0;
 
 	/* find the target keyring (which must be writable) */
 	keyring_ref =
@@ -117,7 +117,8 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
 	if (key_count < 0 || key_count > KEY_NUM_MAX) {
 		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
-		return -1;
+		ret = -1;
+		goto out;
 	}
 
 	kexec_dprintk("There are %u keys\n", key_count);
@@ -125,8 +126,10 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 
 	keys_header_size = get_keys_header_size(key_count);
 	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
-	if (!keys_header)
-		return -ENOMEM;
+	if (!keys_header) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
 
@@ -136,7 +139,9 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
 		add_key_to_keyring(key, keyring_ref);
 	}
 
-	return 0;
+out:
+	key_ref_put(keyring_ref);
+	return ret;
 }
 
 static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
-- 
2.43.0



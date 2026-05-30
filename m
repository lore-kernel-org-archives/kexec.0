Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7FCCD6E49
	for <kexec@archiver.kernel.org>; Sat, 30 May 2026 22:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WamWMdUBlghIACFozBjX6pZ6qu316jN4xzYIhWYXbwQ=; b=4mYiREf5qRzVlOONhmneCMScLa
	mrlbMOf3UW6JKqvltrIakfqUhpxUxcw/ehZDrPe+bP4cAcFfkOjfBLJYDW6t2110K12NfRWFAcgE5
	6a4kvOhj+SWy2mGs0jefqMEKcborHzbTEVTUjE91Jj9PJLwuWBFOcvpUcT+6KeA88MnQLMaXQ1MgI
	1+evU7i5H1bWSYfdx3i2hE66D4yMFj3hH8x2fc5yDUhm2f930tU2Y85mMr7aB+tuYfZSDzhVDrJmu
	EwHwQ2KuGZ6KvHZJoTWvkRavz8/3itVssVtzavADX+qeweqcsRFC8Tx4MRzNXEBReVl5Um1mo3JDD
	ESYXpdRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS2A-000000095qA-2Ros;
	Sat, 30 May 2026 22:19:58 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS27-000000095nI-2nIm
	for kexec@lists.infradead.org;
	Sat, 30 May 2026 22:19:56 +0000
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-9155183b42cso13939485a.0
        for <kexec@lists.infradead.org>; Sat, 30 May 2026 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780179594; x=1780784394; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WamWMdUBlghIACFozBjX6pZ6qu316jN4xzYIhWYXbwQ=;
        b=RsvJpCNQDyxN5qnc7++3eukruSYs76QKgN7RSt4NERgh1KnCGu5ERmPvgaj4cbpI9a
         rpXIwxCpxKhDEH2h9B7BJLGsVRIKz9VacsVOY4cL9mT2k+uXhCFHd4DGgh+IQx8sqI/j
         bZHKxlwIYUjYcdjtPyfEm3a+fjMJ/cxDkVWCn9ZP16n3x5LtDWdPF1NEGF+jJOJe6EYv
         OwcE7XEckGZP+oNgr2yBcLvs/X1DLtWMixnCG6EJfUa0BwG7GCqVTaw73VRPm6IA7vbs
         chfr5gZUivAFAROOFxMaoBF7rJBqvMwNFb7z9r7/9qjq1wd98i45po8c9Ki/i1Bw5ufw
         q/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780179594; x=1780784394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WamWMdUBlghIACFozBjX6pZ6qu316jN4xzYIhWYXbwQ=;
        b=qF8Ahu6wC95v7gqerjBRtCDqmDUAjyq8BAZCTDebDMdSvMXHdrKdOFvmK5uE79EPfT
         jLWP62OfozjzE9VoYA/DXMkQEqQptuPNWhf8jvh9pJTcH2Fqm2mC2vxoaxg2xlNX6ZUt
         0YCZshLfDt4T2SdSQ77mhOCyAwWFbPClO4kGE7FkqoEDxScHpBiT0dMxXa4wi2IeJJXW
         Dy5Tx2EO/PTkxKAUtFGVJWzsD2LS5oVnt5ek7VnBFuvz2SgrlCCObEZwRl5pNxWSWGwM
         AbT1+9sazbRouZMLtRWpiQwzsUzwJJiU4dKWIvyWJlZhPRRUM4pOMR5MJE3DHHmyRQfe
         7EnQ==
X-Forwarded-Encrypted: i=1; AFNElJ8z9KItKEkyP0CXheL3qDiX1drEwJBfcJq0nZWXFrA0JJ0UgM9b6qgvb3PaOznD6e8pao7mZg==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywdcj4mIgRMoDK1MZJ5MZ1JC3W+L5OM1avYxiQ/dI9/kBV2YwVV
	uCon7NpGU9pkagUqJvfw0UPvx8FWgmbncT8OwmVF7nt0tXcxlITp96GjgGtfExdjvl8=
X-Gm-Gg: Acq92OH/Kg2YX7tKwIFH6+5ucytkTwMx27gVrvBydyE9X7MLzDi4GJmuKUcr+AtXInu
	wWcuLt3kIX1dKYKv8c5JN0yRo7IMqWHG5ZmiBrsB9qnicDQsf90x139c1YJY6uS42R5D6ZQFp57
	D5KtgFcXbdWxKf+l/moG2audjhLlHjN8uxcWkLq4Y7MYAOfvToshZADDhngHF6KRA5QGT9ak06C
	M479Lxd2jkvkJLCTDDfGOCCDMZKSL2Oaf2/upDRau4p6z8CffwSjJICGPUrBQRzph+QpC9hF7DP
	wo9L5K3u3GqVuykDbzKbUWiyPa+S5ntigbp4xgQifQtG073wmFD7Uxjpi0JQAc7c/NuyImk4r4O
	A2Nw/k0IEG8Ert9OLeWn1kxAf6F5Yn5DuUTQxDT1GDaRPM0/Xbpxv3itEZ7C77AQ1VKRB0XKb1O
	zyiJmw3HvYs8geHbFmQExf3Ublpe1UEPXnabr82stKxeQt++dXJRiVq2B1Hj06+A==
X-Received: by 2002:a05:620a:198e:b0:8d6:6db0:88de with SMTP id af79cd13be357-9152fa4cdfdmr980466785a.44.1780179594396;
        Sat, 30 May 2026 15:19:54 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324868a0sm651790085a.18.2026.05.30.15.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 15:19:53 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH v4 06/13] liveupdate: Extract luo_session_deserialize_one helper
Date: Sat, 30 May 2026 22:19:31 +0000
Message-ID: <20260530221938.115978-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530221938.115978-1-pasha.tatashin@soleen.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260530_151955_712796_9D1CEC6F 
X-CRM114-Status: GOOD (  12.97  )
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

Extract the logic for deserializing single entries for sessions into
separate helper functions. In preparation to a linked-block
serialization for sessions.

This is a pure code movement, no other changes intended.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 62 +++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 3b760fefa7b9..b728fd9e3ed2 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -525,6 +525,40 @@ int __init luo_session_setup_incoming(u64 sessions_pa)
 	return 0;
 }
 
+static int luo_session_deserialize_one(struct luo_session_header *sh,
+				       struct luo_session_ser *ser)
+{
+	struct luo_session *session;
+	int err;
+
+	session = luo_session_alloc(ser->name);
+	if (IS_ERR(session)) {
+		pr_warn("Failed to allocate session [%.*s] during deserialization %pe\n",
+			(int)sizeof(ser->name), ser->name, session);
+		return PTR_ERR(session);
+	}
+
+	err = luo_session_insert(sh, session);
+	if (err) {
+		pr_warn("Failed to insert session [%s] %pe\n",
+			session->name, ERR_PTR(err));
+		luo_session_free(session);
+		return err;
+	}
+
+	scoped_guard(mutex, &session->mutex) {
+		err = luo_file_deserialize(&session->file_set,
+					   &ser->file_set_ser);
+	}
+	if (err) {
+		pr_warn("Failed to deserialize files for session [%s] %pe\n",
+			session->name, ERR_PTR(err));
+		return err;
+	}
+
+	return 0;
+}
+
 int luo_session_deserialize(void)
 {
 	struct luo_session_header *sh = &luo_session_global.incoming;
@@ -555,33 +589,9 @@ int luo_session_deserialize(void)
 	 * reliably reset devices and reclaim memory.
 	 */
 	for (int i = 0; i < sh->header_ser->count; i++) {
-		struct luo_session *session;
-
-		session = luo_session_alloc(sh->ser[i].name);
-		if (IS_ERR(session)) {
-			pr_warn("Failed to allocate session [%.*s] during deserialization %pe\n",
-				(int)sizeof(sh->ser[i].name),
-				sh->ser[i].name, session);
-			return PTR_ERR(session);
-		}
-
-		err = luo_session_insert(sh, session);
-		if (err) {
-			pr_warn("Failed to insert session [%s] %pe\n",
-				session->name, ERR_PTR(err));
-			luo_session_free(session);
-			return err;
-		}
-
-		scoped_guard(mutex, &session->mutex) {
-			err = luo_file_deserialize(&session->file_set,
-						   &sh->ser[i].file_set_ser);
-		}
-		if (err) {
-			pr_warn("Failed to deserialize files for session [%s] %pe\n",
-				session->name, ERR_PTR(err));
+		err = luo_session_deserialize_one(sh, &sh->ser[i]);
+		if (err)
 			return err;
-		}
 	}
 
 	kho_restore_free(sh->header_ser);
-- 
2.53.0



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9531ECD4F47
	for <kexec@archiver.kernel.org>; Thu, 14 May 2026 22:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5DzA3L8/isnr0sHad5OpiNWdq+EP7DXQ1j7lGoEnI0Q=; b=AMzqylpe1mWrJIevkHJ+hxl2EB
	180W4dRvpjRxB961AdGgEhUeqvGI0DetOdIUAx0MRUWd2rgiqwalRgeyPtslhFtfWu/Pki8X1me46
	65HguzaKt3sfb32e+83T4AEmyjFOUviKql+A0hSDRmYnR7PcMdojycmY6OSJ46sCHfCJSytunbU9L
	DJPNDIPiSL5dtEXyfQBn9xv7aC62Y4vNHm3alr6Tr1moieScMdHcR8lUC6+9An9pKxOW9Zj8XWjQz
	PJXDGyC6sVyAE2x/YNJp38R0Wl8tkcs5ACCEkZdAtNdVeHeEZg9of889XPB23lO0ivmiDVouuqJi/
	brq9AlZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeVt-00000006iIA-2FAG;
	Thu, 14 May 2026 22:26:41 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeVq-00000006iG7-1kpk
	for kexec@lists.infradead.org;
	Thu, 14 May 2026 22:26:39 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-512f09ecc67so59903211cf.3
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 15:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778797597; x=1779402397; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DzA3L8/isnr0sHad5OpiNWdq+EP7DXQ1j7lGoEnI0Q=;
        b=Xvl79N6MHLUoO8+Dqul2nS0NglMjtp/ryv1hftKZpBauJaYvj7opgKoHgTVdjpldUk
         x+do7oH3djAxmOr2R76llUqYK50NMrxJfTMO5MkhCnCyfdRnP4xDqSO75hzSM0NsOyKP
         CUvDeq4rymmwSeBRPoAlbuBzjHNgXGZA/rxEhRmUaYo+JB2MT7K/u4feQmkqAk/Q6Eaw
         N3tEhrTXC7mlkri5HAtIE7PkaElwbw2lGAPeMn+kxsOZmeT27UzYlYX4BBPo1qPHnWvQ
         zZtAy2V8k2B33rn1mCWK/7BhTHC09KONPNcHIjueZcsgMvf0+TV1ye6m7Zdn2LsHza8y
         D/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778797597; x=1779402397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5DzA3L8/isnr0sHad5OpiNWdq+EP7DXQ1j7lGoEnI0Q=;
        b=cgAAWqEUhFDQeR+kZQaWZRc3b1SFLe0wdaJaOz1xhDORwPuAzkSU5qs8/Bt3vUbj3q
         uMC36PChstdTr3XhCosaDXQNcEMCorhha214jf55CDnE3QF/bNLEiujwMd4ICXJj2DCV
         PASq2xpBTcbftOn0FUBDsKgEoTz2Lqnkx6ARJw7RYyRzS9orBYWB4LEJqplR5+knf7DW
         Id+WPu1kK7BWmD4rsfspUEf1xR3j4JwM6ulOC3/bcbZWgIAPSvWI2uqDhs5fTnKr3aAy
         RGr1JUgeF1EbQjNIrtis2QMIgoL3fXMzYHTowwxDHlXRp6QchJnqdqnGkl1Ue67h+XIT
         G2aA==
X-Forwarded-Encrypted: i=1; AFNElJ/dvWDUFASu5jO05Nxe9LTGAT4rEf7b1Z5nKZv5Scz4DLDGloMyidU95HLE1FDXtRIsFP+IuA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwEqYki34ObLk7YjK1XKX34Q60wLs13mTzaKKp4DXz/4CqWJA70
	BZobxC3Elz0b+gTJhQpGB81FlTkjWmxaZh9vk4Cqnhwmh3pmq+4gRDp9QU6ZbPYLXB8L/f9nHId
	oWDRTAyo=
X-Gm-Gg: Acq92OGWQnnncv1b33vlY4LUyoc2r2I6a6a1khtgOEtpnooUSS7ucb22S8msAZWnKwq
	2vjnGGIudS4qhfZU4ESTPxrJUcGTUYmGpwLiaxe0UEgr7ogj23rlzuK3o/AiO03XklzT1sUjjBY
	z2RmpcnTvSKT2nUnpqHi1uQ8yjRibCFYlD1jBtvPYy6qvvI45oM8yxT0lwWBEsZTu8avaR/hvWD
	hT9GlQI8XxJpkWjrsA5WcJRepq5lC6z16+My9urDfdkFfxGcfDq1jvL6GeID5HEO3e8N0JXhBXm
	kV2doMNXelDrLV6PlgKc2Qilo9FysMpV5WyVFtFDGo6tfzsHK6k6LNVFI73hU2kgMvwoX7UxHx+
	lgcSo/L/pZD2BSok6loQZlC+oH1wOXwjqwzN+/WCRNzglx/jSZYt40+azvrIraM04lX8D2bWb3O
	DjJNEIzS8f6rFc1LfWe21j5EWHegRAizPb1x7as+EJrbRRegh9R+M=
X-Received: by 2002:a05:622a:1814:b0:50b:893f:7d93 with SMTP id d75a77b69052e-5165a00061amr19897201cf.2.1778797597005;
        Thu, 14 May 2026 15:26:37 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456ba92fsm28671901cf.9.2026.05.14.15.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 15:26:35 -0700 (PDT)
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
Subject: [PATCH v2 03/10] liveupdate: Extract luo_session_deserialize_one helper
Date: Thu, 14 May 2026 22:26:21 +0000
Message-ID: <20260514222628.931312-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514222628.931312-1-pasha.tatashin@soleen.com>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_152638_488869_F2A45420 
X-CRM114-Status: GOOD (  12.64  )
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

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 62 +++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 915ab9ce0f34..c08733a328bc 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -489,6 +489,40 @@ int __init luo_session_setup_incoming(u64 sessions_pa)
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
@@ -519,33 +553,9 @@ int luo_session_deserialize(void)
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



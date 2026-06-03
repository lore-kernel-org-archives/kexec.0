Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E110CD6E57
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QfziVgpqRfO53l/kiKYNLloUUY6f9C5CrjqJQDvl8iE=; b=V2ILSkKYtgyD2jTx99N4r4UHo5
	6F3vAG9yKAmWDT6mfuNFqEBSG41cXG93bu5LxxgaFG5bMRvrlftezAhS+kwapIXUhrDRKp/Qy3dNa
	zC75UtqKqjRX2bxw3vamMMhbXwm9bzotQgNQlHzOYULMcNVMB77t3UrH7OTdJ5FxgYu7euAUHYIEL
	oHyOD3zwa6mmh8t6GLa40wlXJLhYMiwdBXrH2QzOWZoPGkKSYrDJa4/GYbYKPoGEvb+ZZvxF63sK/
	RzHb2FkkuT7JIpXicmq2ygUxd0LoFjsY/zKhrHobhxlqx2P7QOxH/cibvAlUt3++EqCiFuBFuINrT
	GgHEoycg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnmP-0000000FRxn-3nVv;
	Wed, 03 Jun 2026 15:45:17 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnmO-0000000FRxA-0QZ0
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 15:45:17 +0000
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-9157b94a07aso253818685a.0
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780501515; x=1781106315; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfziVgpqRfO53l/kiKYNLloUUY6f9C5CrjqJQDvl8iE=;
        b=WPJO/QhiqCXfrZUmidvUQOszbxY8m1NSIE4BtM9DabPUePs6rcDNkgn1i9I85Icaqf
         981LGQtuqSQJ2V1ms1OBmPKYIy+8u4URClu5NxFD7rswM+/6H/Noi7BeSP0NOJ8K4bYu
         b1aMUpAuFFs2TGk7MlRIS+kyQbE4HVW9v0hti7ZFUZKQP+w6XNfHMPjC0Eaye6hnp0dT
         +PW/6CwmxxlMWoHVfktSMDV0jp1f35f+Qem8cKlsd4V0esVNP2u+ynmuBWM7C7PiV3xY
         h6OqosYbuKQIVz/34UANyKBFrNbWkKIkbss3VsaOUdTidu7So0PwKpX6hJFm9g20X6Mb
         CyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501515; x=1781106315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QfziVgpqRfO53l/kiKYNLloUUY6f9C5CrjqJQDvl8iE=;
        b=mk/gORbF012yo8p5aolexlolxYaWvD5cqFAzEwxpPj0IO2Byq6kuFBlhe4Snl0J17p
         ha862GIUeOo45FpF5CgD5iIworPgFX+QV6Pw+644JTGrlWnw1qLPZfuHcDQKDBLWhNnA
         mGWXLMYj1y/Cd6CbfuT4v7LuZsM6v/T+08ql4etA5qPkyY6ChlX3DpKBOLxSQTtUKq6r
         Di5JW7T7Vcu6DFTirVHZcfCdVt5cBueZxuFYk4B6HAHZh6DVaAkhpNo90ERJXuacR2uD
         dNPNyrLB7oxASQ+gnYzJu8OVVJxa3IJScBmJaVAt0+DThmNY8DHtMnBgak4bq1dLHupe
         rgcw==
X-Forwarded-Encrypted: i=1; AFNElJ8NzNWQXjtRE7jiiR6xwg2K5//QqGNfJYwt2c83Y6LbM2PchTLn3tIe4/nRsaXqjtvoEdRHAw==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywe0BjKcpOQizDdG4CPKhqvMLZgx60DJn1l7xpAq0iM6kC0Ayzn
	LuIo9e95kr7lT2Z9sMTwB8CyCknFLLIGrFMLxwqkEHPGDAdYMEJ/6pA303wWCnYJuzI=
X-Gm-Gg: Acq92OEud7QH6+cVP4VO/5CBNCO95LHz5SbeRXPSa2i4F6t9KLRU9NsHPORcZ8WXRhP
	YcFeYKuMREN7g5nBIuyjIc+gSkVHyn5ZHm4XFr1OmWu70uTSUUMfZkUt6fSfyhuSW0ikYGY+J13
	cr69YeqCSd3zNQJ1iHG3yMo1NQoGswCDLKyPvbZsgS07RdkTFHWrY6TbNO7vcUGted2PENjIF9V
	+qw7TSzC02DeTy7QKXNUl2nlioYMQL14J0kiPuDwKXq9xZpA1jbGwwg4bRRZiFTyeD1lKVeVMrO
	nsgVtcJ1j7TiBC2Dhx/Ty65BO1ZZvin/VHiwpKoTU+aRiJVKhH4kSsCFTobDSVjeYkIKF2EI8kY
	4EKoGoOCY/45gak2/vkZHXSLU1p006UVUCRrZLMKE9aFPpk3eTju0JpZ2f75TnrOJ15jbQAZVs/
	TTn50Ht+g6l8BThk9hsxgCrS6mohC0NQ+3XZIlEwQLyBnlxr3IvCfkoQ3Z/IfTQg==
X-Received: by 2002:a05:620a:2406:10b0:915:6c4d:d74b with SMTP id af79cd13be357-9158a7aa7d7mr477899185a.31.1780501514839;
        Wed, 03 Jun 2026 08:45:14 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a237330sm280242385a.16.2026.06.03.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:45:14 -0700 (PDT)
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
Subject: [PATCH v7 06/13] liveupdate: Extract luo_session_deserialize_one helper
Date: Wed,  3 Jun 2026 15:43:55 +0000
Message-ID: <20260603154402.468928-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603154402.468928-1-pasha.tatashin@soleen.com>
References: <20260603154402.468928-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_084516_143306_DD5AE266 
X-CRM114-Status: GOOD (  12.75  )
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
 kernel/liveupdate/luo_session.c | 63 +++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 85782c6f3d6c..1cd315e0f6de 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -555,6 +555,40 @@ int __init luo_session_setup_incoming(u64 sessions_pa)
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
@@ -586,34 +620,9 @@ int luo_session_deserialize(void)
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
-			err = PTR_ERR(session);
-			goto save_err;
-		}
-
-		err = luo_session_insert(sh, session);
-		if (err) {
-			pr_warn("Failed to insert session [%s] %pe\n",
-				session->name, ERR_PTR(err));
-			luo_session_free(session);
-			goto save_err;
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
 			goto save_err;
-		}
 	}
 
 	kho_restore_free(sh->header_ser);
-- 
2.53.0



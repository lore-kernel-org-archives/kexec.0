Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC2ECD6E60
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 15:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C9xWUzUEP3GatCDCPhqDCyXoyiDq9Ol5847oPRS2f7E=; b=aDt+MR8GD/w/XXJdVWHii8Csmu
	4gJH08FrEwFZlHSXY0SDrgpbJ773rLhL4PdxLvbW17vqjEZzDFOTacuMmMXf2S6xUQAByIG3a1F1U
	OlfIT9AtlAYRycCgAwOff8/XWCZF9DY0pE3xyw+DvzOAH8B1Eb2l2/rCQet4WnpC+Qh/8XSPV7T0A
	Cwiu0I/Zr7he/9MF0dvTzkjnodj/Gq7MeFUQCwc/vZS21C+USEC2v3PQSbI3XKJdio2jLEzC+tU9q
	0k24AIJNF5MAgDU4nvNIciSM6nLSn5du8cjaz/AR0JRhNO520VcKYyWOSk5tvt9JrnVdtMsiuwDfX
	E2uRUHlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnn1-0000000FS8C-0WjA;
	Wed, 03 Jun 2026 15:45:55 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnmw-0000000FS6v-42uZ
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 15:45:53 +0000
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-91574384cc2so312475185a.2
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780501550; x=1781106350; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9xWUzUEP3GatCDCPhqDCyXoyiDq9Ol5847oPRS2f7E=;
        b=f5EOBkTel6zuZqLOCV0KE4wQ3tPeUQDemG3NmtX80+Rbj15hBDSLlxcJYSqUC+kUqd
         ZdSsf9M2NOHyvpCGKLJUmujF1AmJzNa/zNnUtErXqqb7uQsYm2ASoF6AYYZzyiabd0Xn
         xfPm9cJCP1LMdZMAm1sYdKnLediOuiO+f3fCMIaMcp/1m4hsyOjoisaweNsRQHlWme6b
         nxkS614FbFaJVDXhB6w+E9sGJp/ZpOSsUgQFcjpjQDbN0C8DS7fwErE81dwyuhYrbOjA
         Wa5I2ETedPGEh+Nm0au1wwIxv9ywOuVFdiJJzTR2LqN8Meptt0/Gbiw1f1b39qmwKYj7
         Iveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501550; x=1781106350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C9xWUzUEP3GatCDCPhqDCyXoyiDq9Ol5847oPRS2f7E=;
        b=dAURZL5rvlKjtaMmEAKt7Au6YnhDfm9Wy7l2bM8uz1B1UFomCk9hwPplpX11yjr5CR
         ulLJOCSdK5jBNzaaFtYKkdrubc6vnCBBuxxSNpv5PTAKl8sTM6y6yd+lS9iOw9/d4+n1
         hkD9Q9I0h05Gg1VoJp/qxoEggOPIUssKJSgEJDpkfiPIP/7mtZW03jG9TqY1d9wzAp1H
         i6VmM6fKEr+r9ZyXbgFSwK0PCR2/A3RkTsW7BzV0CU4GCVIrJAlxDPqhAq438E2u8jHg
         Q5J3mCqm++TcKE3dhhJOx8G2/Kkzdn+c7t1vNQEKMHSxIE38dnx1iBX1r3qhP7EQmkRM
         h6NA==
X-Forwarded-Encrypted: i=1; AFNElJ8N0l9Ijny90Dcn5vMkx/ld09K16xSAeZe1YPKOS5A69Nwrmbn5kWLZBR7JSepI+6bvlGNIHQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxXY98AsgJj1lOFM/WTDCqYpoMXQdyteAZfNjzId09TnZdBe+7C
	NVD3YTruldYHTsuYbfmlmh7yEYHqTHctJg4bot2v2uPvAUk9hlTaZ2w92tNDrjpEQW8=
X-Gm-Gg: Acq92OFEBhBf4wBDa1zFhCwP7SzszWkq5Rrf0dlG0Fn+Uu7nsd3J3be6ro4YE3zRXwk
	ocumhPK/BgECmxJSCNVffB/uoNbvOO+/mHKW4peGZ0WrouIoF8iOTG76r/8tR/qewJDqwbTXiHT
	SGmK+c2DJFoK5vx4LQ4KEF8eTi84R1GwUly28pOc3OL677O/4I7JMwsOW387ShURefOSw4hjxWn
	6bIu6YWaX2RelL7j5zSXZSMYGpCf6/Mce9gRCd/CNoEhS2X/3CH2Kgwduuv2ukgZw33DiEAhlNA
	nhm9pC0+jALzPO+StCmz116Q1IcJJ5dRmqA7/8SJjfGnf/GC2XZ+bJWjQCJ2UUdJ3IrTlR5BO6t
	yudakK0AScK32Lsmg+XoqToRSupPmp99D5FHWUSk5l3RbAE6zG/qywkA5la7vK0mTOQHY+ktMhg
	Tus8gT8tRYXs1y+p6PXypZTuoH6F0xVYH4AhbliK8wd8dCa5PxhIcRt4TJB4vufA==
X-Received: by 2002:a05:620a:25cf:b0:90d:b6b7:caa2 with SMTP id af79cd13be357-9158a64528cmr652914085a.11.1780501538664;
        Wed, 03 Jun 2026 08:45:38 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00ba04sm272435585a.7.2026.06.03.08.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:45:38 -0700 (PDT)
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
Subject: [PATCH v7 08/13] liveupdate: defer session block allocation and physical address setting
Date: Wed,  3 Jun 2026 15:43:57 +0000
Message-ID: <20260603154402.468928-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603154402.468928-1-pasha.tatashin@soleen.com>
References: <20260603154402.468928-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_084551_018922_6868F353 
X-CRM114-Status: GOOD (  17.96  )
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

Currently, luo_session_setup_outgoing() allocates the session block and
sets its physical address in the header immediately. With upcoming
dynamic block-based session management, this makes the first block
different from the rest. Move the allocation to where it is first needed.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_core.c     |  4 +-
 kernel/liveupdate/luo_internal.h |  2 +-
 kernel/liveupdate/luo_session.c  | 68 ++++++++++++++++++++------------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 69b00e7d0f8f..1b2bda22902d 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -165,9 +165,7 @@ static int __init luo_state_setup(void)
 	strscpy(luo_ser->compatible, LUO_ABI_COMPATIBLE, sizeof(luo_ser->compatible));
 	luo_ser->liveupdate_num = luo_global.liveupdate_num + 1;
 
-	err = luo_session_setup_outgoing(&luo_ser->sessions_pa);
-	if (err)
-		goto exit_free_luo_ser;
+	luo_session_setup_outgoing(&luo_ser->sessions_pa);
 
 	err = luo_flb_setup_outgoing(&luo_ser->flbs_pa);
 	if (err)
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index fe22086bfbeb..ee18f9a11b91 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -79,7 +79,7 @@ extern struct rw_semaphore luo_register_rwlock;
 
 int luo_session_create(const char *name, struct file **filep);
 int luo_session_retrieve(const char *name, struct file **filep);
-int __init luo_session_setup_outgoing(u64 *sessions_pa);
+void __init luo_session_setup_outgoing(u64 *sessions_pa);
 int __init luo_session_setup_incoming(u64 sessions_pa);
 int luo_session_serialize(void);
 int luo_session_deserialize(void);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 1cd315e0f6de..2411849a34e3 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -108,15 +108,16 @@ static DECLARE_RWSEM(luo_session_serialize_rwsem);
 
 /**
  * struct luo_session_header - Header struct for managing LUO sessions.
- * @count:      The number of sessions currently tracked in the @list.
- * @list:       The head of the linked list of `struct luo_session` instances.
- * @rwsem:      A read-write semaphore providing synchronized access to the
- *              session list and other fields in this structure.
- * @header_ser: The header data of serialization array.
- * @ser:        The serialized session data (an array of
- *              `struct luo_session_ser`).
- * @active:     Set to true when first initialized. If previous kernel did not
- *              send session data, active stays false for incoming.
+ * @count:       The number of sessions currently tracked in the @list.
+ * @list:        The head of the linked list of `struct luo_session` instances.
+ * @rwsem:       A read-write semaphore providing synchronized access to the
+ *               session list and other fields in this structure.
+ * @header_ser:  The header data of serialization array.
+ * @ser:         The serialized session data (an array of
+ *               `struct luo_session_ser`).
+ * @sessions_pa: Points to the location of sessions_pa within struct luo_ser.
+ * @active:      Set to true when first initialized. If previous kernel did not
+ *               send session data, active stays false for incoming.
  */
 struct luo_session_header {
 	long count;
@@ -124,6 +125,7 @@ struct luo_session_header {
 	struct rw_semaphore rwsem;
 	struct luo_session_header_ser *header_ser;
 	struct luo_session_ser *ser;
+	u64 *sessions_pa;
 	bool active;
 };
 
@@ -171,10 +173,30 @@ static void luo_session_free(struct luo_session *session)
 	kfree(session);
 }
 
+static int luo_session_grow_ser(struct luo_session_header *sh)
+{
+	struct luo_session_header_ser *header_ser;
+
+	if (sh->count == LUO_SESSION_MAX)
+		return -ENOMEM;
+
+	if (sh->header_ser)
+		return 0;
+
+	header_ser = kho_alloc_preserve(LUO_SESSION_PGCNT << PAGE_SHIFT);
+	if (IS_ERR(header_ser))
+		return PTR_ERR(header_ser);
+
+	sh->header_ser = header_ser;
+	sh->ser = (void *)(header_ser + 1);
+	return 0;
+}
+
 static int luo_session_insert(struct luo_session_header *sh,
 			      struct luo_session *session)
 {
 	struct luo_session *it;
+	int err;
 
 	guard(rwsem_write)(&sh->rwsem);
 
@@ -183,8 +205,9 @@ static int luo_session_insert(struct luo_session_header *sh,
 	 * for new session.
 	 */
 	if (sh == &luo_session_global.outgoing) {
-		if (sh->count == LUO_SESSION_MAX)
-			return -ENOMEM;
+		err = luo_session_grow_ser(sh);
+		if (err)
+			return err;
 	}
 
 	/*
@@ -524,21 +547,10 @@ int luo_session_retrieve(const char *name, struct file **filep)
 	return err;
 }
 
-int __init luo_session_setup_outgoing(u64 *sessions_pa)
+void __init luo_session_setup_outgoing(u64 *sessions_pa)
 {
-	struct luo_session_header_ser *header_ser;
-
-	header_ser = kho_alloc_preserve(LUO_SESSION_PGCNT << PAGE_SHIFT);
-	if (IS_ERR(header_ser))
-		return PTR_ERR(header_ser);
-
-	*sessions_pa = virt_to_phys(header_ser);
-
-	luo_session_global.outgoing.header_ser = header_ser;
-	luo_session_global.outgoing.ser = (void *)(header_ser + 1);
+	luo_session_global.outgoing.sessions_pa = sessions_pa;
 	luo_session_global.outgoing.active = true;
-
-	return 0;
 }
 
 int __init luo_session_setup_incoming(u64 sessions_pa)
@@ -644,6 +656,8 @@ int luo_session_serialize(void)
 
 	down_write(&luo_session_serialize_rwsem);
 	down_write(&sh->rwsem);
+	*sh->sessions_pa = 0;
+
 	list_for_each_entry(session, &sh->list, list) {
 		err = luo_session_freeze_one(session, &sh->ser[i]);
 		if (err)
@@ -653,7 +667,11 @@ int luo_session_serialize(void)
 			sizeof(sh->ser[i].name));
 		i++;
 	}
-	sh->header_ser->count = sh->count;
+
+	if (sh->header_ser && sh->count > 0) {
+		sh->header_ser->count = sh->count;
+		*sh->sessions_pa = virt_to_phys(sh->header_ser);
+	}
 	up_write(&sh->rwsem);
 
 	return 0;
-- 
2.53.0



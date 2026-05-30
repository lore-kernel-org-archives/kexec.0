Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E003DCD6E49
	for <kexec@archiver.kernel.org>; Sat, 30 May 2026 22:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ssXPv2DRhDSGHaylMjR7rg2Io0bTsFx1rhCfXPl0Sk=; b=jzcbx2gAxd3zsBFIsI2Y1P5Cn6
	jxYbTKeqtuuRwSsi2GiBZIejQYRFFhXlOI3PuetKPWgwdEcnZ+U62/xheK6EqGHcw/iFnXkonrHaL
	dj5grxmfqYkGm9FqWDplGMNsqGcxxoUI0LPCFtCRalRpYpD45lFYXGHCC+O6YbSYZUgJiWttsb57F
	9o+7io4Z+QNMX0dzAw68Mw0y+AxrM+By5xnduw2N2C5WCGcq17v/1MUgTONbZvQ19x+kJEC60TBxV
	5CdCDmGDi10AfYkj9pR1EpXaAxmDRwt1+vo9DzragM5jcqnQacNR0G+BBZJT+J7WqoweaOAqZC3R+
	cas2ivGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS2D-000000095u7-3e3S;
	Sat, 30 May 2026 22:20:01 +0000
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS2B-000000095qY-2HWs
	for kexec@lists.infradead.org;
	Sat, 30 May 2026 22:20:00 +0000
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-8ce9d444173so1797566d6.2
        for <kexec@lists.infradead.org>; Sat, 30 May 2026 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780179598; x=1780784398; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ssXPv2DRhDSGHaylMjR7rg2Io0bTsFx1rhCfXPl0Sk=;
        b=T9nLSKDmRdbbL18/NS/rs1AQFixG22lip1x9HhJ3TIpkI0+61znzO451OwtlRHlJgu
         y0ceqiN6jpXv0OtILO1zOgLtcXRBsVaIcCcO8gjxPs19r/KorPJ877bJL2TjQh/Nf66l
         XbHm3CUSXswF/CjV6hkf3nXJleFsOBSJx43vBkS+hlSJl6P1JwhoOpag8f4QfJtEiIcd
         aTPoVWzpC4qHVRZqAEJjfIkMLVAm8jibsy4hHcFSv2qYwP85X5BJJ3NPes0BfNKXFdyH
         e4hQHvDj7Hw5d3STtK2bRHgCKmn7Oy+zeed5PjjqkrFnyyZ4rRejWps8n9T7C0onLKc2
         XRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780179598; x=1780784398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ssXPv2DRhDSGHaylMjR7rg2Io0bTsFx1rhCfXPl0Sk=;
        b=Zb5Yktls6yis/1pPObPIy90Y0m5//FL5rFaS0MndmJxgTwlcQi8QhXOWUo4fVWF4b+
         QZF1bwkAcfMK+9kHNxmag+mr/lMoNlcJNETrdSR/7hvzaEItuCVyQ7jGiRi7V4040KK9
         u4PpUHikFLmsUHpR6dc/oNGEe82weYJMy8w4s0AjfgcqFuiSZnLXyQ+UsEAEDwffbDlH
         jhrmHXMb/SYUbFxTtnf6gC2Z/9H+e+HoDy+JsUUfIHnULIVDmyuaOp5ATr7AM5wXsS5c
         qB+Xa5stOYPLH1NdUJBLhyMRC6duvJ+wWXKkPQMXuqXD/XMT1oZ1Lv1tpc78b/6Jd2YW
         GVeg==
X-Forwarded-Encrypted: i=1; AFNElJ+khIfAv3g4aIE3IEw9NJQLqkiwDivjFOgqWVomjt889WZjlMWnnZuQu3UCGgamhza3XQHK0g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxcbVbfF9IZLQVj+AnqPw7n3hBe+JowU/xJGm+nGvkPeG6GzK9U
	hbHS01XrdzeixzqrDDhfckN8qAlobk6TRuAmYZNQCdZQaIKBf5xpSm8bsL9nYDpfYJU=
X-Gm-Gg: Acq92OESc3CG0Pa+kajFEj5LdItiE8b38co1yhRmMht0A7w/w0e5k+z4XdSh4O514OW
	4phrVzEYTWbNackReDwcX0GqhixcSACi5Ha6TOSa72kYNTFnvZQOxzqhIoirUHlGlE1hnIz3Ohy
	9cy1aHr4nLQ7b2C+Kq5fd3XSZbwtwG9PuyOweYGB+wK6oS5M+6iTOTG1tBhNwfUo38uQeSvDdmW
	Gn3l7PbeuYJUEvO63/nQ5k/i5OtpE7di0LsKtHN3XqjHZ7E2B3LwVI6qlRZZTnz2Yuz+DhxT/+l
	YZVsKFwqB4Xb2FIWm+dmLGedeW83WeBq0xQXqTtHmuvyQM+QCzBkC4BXmsdI/HV8PgF1xrwgzJe
	8tj+5JNNMnz6Qviy7gLV3+mSGu1aM0uXqplAiml/8i9cyOOE9elBLtNVRnWHAcPud7H12hqy32j
	hRldlQ+y1Qiw3sAOHpDz+K99Rk0dqxaMlLieKiIR3swpElkcGdD7DPmqtLciXZLA==
X-Received: by 2002:a05:620a:a19c:10b0:914:c01e:6f92 with SMTP id af79cd13be357-9153d9709f3mr614876885a.18.1780179598221;
        Sat, 30 May 2026 15:19:58 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324868a0sm651790085a.18.2026.05.30.15.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 15:19:57 -0700 (PDT)
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
Subject: [PATCH v4 08/13] liveupdate: defer session block allocation and PA setting
Date: Sat, 30 May 2026 22:19:33 +0000
Message-ID: <20260530221938.115978-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530221938.115978-1-pasha.tatashin@soleen.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260530_151959_600259_541FEF25 
X-CRM114-Status: GOOD (  18.33  )
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
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_core.c     |  4 +-
 kernel/liveupdate/luo_internal.h |  2 +-
 kernel/liveupdate/luo_session.c  | 68 ++++++++++++++++++++------------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index e261a03a1b47..fef7fc6765e3 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -161,9 +161,7 @@ static int __init luo_state_setup(void)
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
index b728fd9e3ed2..0548d48bb014 100644
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
@@ -494,21 +517,10 @@ int luo_session_retrieve(const char *name, struct file **filep)
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
@@ -610,6 +622,8 @@ int luo_session_serialize(void)
 
 	down_write(&luo_session_serialize_rwsem);
 	down_write(&sh->rwsem);
+	*sh->sessions_pa = 0;
+
 	list_for_each_entry(session, &sh->list, list) {
 		err = luo_session_freeze_one(session, &sh->ser[i]);
 		if (err)
@@ -619,7 +633,11 @@ int luo_session_serialize(void)
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



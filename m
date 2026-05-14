Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62C2CD4F42
	for <kexec@archiver.kernel.org>; Thu, 14 May 2026 22:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eb8o2KCzs8bbwuZWDFPZ38APTKPTdJK2DFY1v5TRs6Q=; b=RaFeuuSzm40KIGbWgTmHduZF24
	qjFc+zQznNGWoD//bollAVX6aw1BTn3J7mADCGYjPZ8662YR3AKg4fwZvlTTQWCvti6obK0Aw5o70
	6cLjPAdPOSZ+03ubyimrYJytR04vbiBFrwydBbpgCdm6G0syViHAdyDlCVAkSgUWCsybcxPV26OAL
	mKRIGVi5rEHv+5uKggxprrnG+gSzzhn50iVOuylZURMUpC7X9ZDAQ2LEtZdWsYzItzJJOyiexih24
	UXRTWyEN4M4ab+6leIWOQ8Ttj7h9JTZzottc36phbk6CriL5/MUBo30KRDXXhq88QJs+jP6FYQEvW
	1ssutnKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeVx-00000006iLN-0niT;
	Thu, 14 May 2026 22:26:45 +0000
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeVt-00000006iHW-0hjY
	for kexec@lists.infradead.org;
	Thu, 14 May 2026 22:26:42 +0000
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-9102e90bcbeso250077485a.1
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778797600; x=1779402400; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eb8o2KCzs8bbwuZWDFPZ38APTKPTdJK2DFY1v5TRs6Q=;
        b=jdX2eq/BR3Szplzom65/WE4+pakT05ppePvUHfRcHb48xbAYOZWeSHEXyZeYHa7Uhj
         yBY1scrR+M0Y4k2x2478QLTBcEq2UCRR76lY+jXHwZQ27HoDbCgtLLAnvMwLQPNSpVJM
         WhYn68UQy0TLjJTOmgyorg3bhDG8sCKDcSGmjM3f9cK0AQNlEJ6WrqLFvPGjSPZOX0n0
         7zBU8f3xLQ+7l0aPA2FaVMbLAst5b8lDWe7VjtqPEcAtDRGF5A3A+pH8pAVGll7aRrr6
         Tno3MS42LXDIMlSmAdSa1ab7k0p/cY8fB6rMd7O6umm4lxQPrnDIRRJyANo97ONQocSS
         plCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778797600; x=1779402400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eb8o2KCzs8bbwuZWDFPZ38APTKPTdJK2DFY1v5TRs6Q=;
        b=RJki2FV+GWGMC/Nta6kqla9J6SCnCnq8+yaAGsaoUg9vejZZ5Rc7r1YWTyyMSxuvki
         WPbdvqngewmzAmxHrxYwlYiEwOpetdZQjCAW9LfhPOippFb2jYBTUB3klro0RqU78S6G
         aLkXzAMleBSskguHe/v04mBfhHM8wq9Bh+RQvImiHugWBq875lo8hDulupi4Ffr51lGz
         4mg9VpEzGQLd/xcSqsw/TVF9VzOCFfNqVs9yqFO1Ji4r6Yr63lR+bhK4fp0O8hF7a5N2
         +qhuZHULtVSkgOy3hyH4/ruBdnYLElDLaw5voFxZa6LodOdmSpe/D3EtKDMtFGx6DDd/
         zsLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9L+B15FNCNlh3zWLJTkjF1Yo6GyBebU85FpQk3w5hU24khEPuMyZiJ8MQnFOBb9rTZvttNKA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyB6O6ybolHbOG2tZb4/ONXHCyIyC2R8QpaVS4CWkyh3bDPDJO6
	7V7VgiUjySq3Pcumtv8wed8rvYbZj+sI0rt7PEueNd6YS1O2izNueNnPMwoXCfv4Dzg=
X-Gm-Gg: Acq92OH17LJOa4Y6Rfivb0EW0FS4ZsA9gyPc1KJ60m56Is416G9EcqdIZgtWAfVKmvv
	SzbqooKEIRg0An4A5MV/AltIp8m/9+BRac8MEg6ewhOwN10Ynfr8ctQqs7GuDp9RFnu/SXOQwu9
	0UGLu04oG2LxW5IeRrtrVoeBQj2lN/IScHilTy+vYPlr1yXo0O0KgpY1p/+zUUCRRjqoEyp/4Ml
	uF2EsAOvLB2mmaer3i0/oIThjzdmn4TeTwOC7L9Z+EFv1ymaatNB5mQEANvlkCdJ6GIDxjWndD9
	1r9ix1JF74vvklhXbccmEFxUa5kZlDxmxMR9wlFlw0ksHAnl6LTZ8+B6U9/jLBiQkP4ibJ2TopN
	B7N+bzqji2/Sa9g0O1pSi+Lekdg0/vf+5hfVvdJ7PBOVfRa1YGJO6MU92Xmt3ZOtehd0IsGKXL1
	+H4hQPbol0HMc5kckFhaR5Y8XNE9kGqB6N/vINnjnS7JYFoOTpW4E=
X-Received: by 2002:ac8:5cc5:0:b0:50e:601a:217f with SMTP id d75a77b69052e-5165a076dcamr19672381cf.25.1778797599975;
        Thu, 14 May 2026 15:26:39 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456ba92fsm28671901cf.9.2026.05.14.15.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 15:26:39 -0700 (PDT)
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
Subject: [PATCH v2 05/10] liveupdate: defer session block allocation and PA setting
Date: Thu, 14 May 2026 22:26:23 +0000
Message-ID: <20260514222628.931312-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514222628.931312-1-pasha.tatashin@soleen.com>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_152641_371762_3BD286A5 
X-CRM114-Status: GOOD (  17.95  )
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

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_core.c     |  4 +-
 kernel/liveupdate/luo_internal.h |  2 +-
 kernel/liveupdate/luo_session.c  | 68 ++++++++++++++++++++------------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 9bd649b22029..5dd7f1e7dddb 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -189,9 +189,7 @@ static int __init luo_fdt_setup(void)
 	if (err)
 		goto exit_free_luo_ser;
 
-	err = luo_session_setup_outgoing(&luo_ser->sessions_pa);
-	if (err)
-		goto exit_free_luo_ser;
+	luo_session_setup_outgoing(&luo_ser->sessions_pa);
 
 	err = luo_flb_setup_outgoing(&luo_ser->flbs_pa);
 	if (err)
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 04f31319ccdf..090078ad771c 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -126,7 +126,7 @@ extern struct rw_semaphore luo_register_rwlock;
 
 int luo_session_create(const char *name, struct file **filep);
 int luo_session_retrieve(const char *name, struct file **filep);
-int __init luo_session_setup_outgoing(u64 *sessions_pa);
+void __init luo_session_setup_outgoing(u64 *sessions_pa);
 int __init luo_session_setup_incoming(u64 sessions_pa);
 int luo_session_serialize(void);
 int luo_session_deserialize(void);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index c08733a328bc..339514e8122c 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -77,15 +77,16 @@
 
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
@@ -93,6 +94,7 @@ struct luo_session_header {
 	struct rw_semaphore rwsem;
 	struct luo_session_header_ser *header_ser;
 	struct luo_session_ser *ser;
+	u64 *sessions_pa;
 	bool active;
 };
 
@@ -140,10 +142,30 @@ static void luo_session_free(struct luo_session *session)
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
 
@@ -152,8 +174,9 @@ static int luo_session_insert(struct luo_session_header *sh,
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
@@ -458,21 +481,10 @@ int luo_session_retrieve(const char *name, struct file **filep)
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
@@ -573,6 +585,8 @@ int luo_session_serialize(void)
 	int err;
 
 	guard(rwsem_write)(&sh->rwsem);
+	*sh->sessions_pa = 0;
+
 	list_for_each_entry(session, &sh->list, list) {
 		err = luo_session_freeze_one(session, &sh->ser[i]);
 		if (err)
@@ -582,7 +596,11 @@ int luo_session_serialize(void)
 			sizeof(sh->ser[i].name));
 		i++;
 	}
-	sh->header_ser->count = sh->count;
+
+	if (sh->header_ser && sh->count > 0) {
+		sh->header_ser->count = sh->count;
+		*sh->sessions_pa = virt_to_phys(sh->header_ser);
+	}
 
 	return 0;
 
-- 
2.53.0



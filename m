Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E3ACD6E6A
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 03:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C9xWUzUEP3GatCDCPhqDCyXoyiDq9Ol5847oPRS2f7E=; b=WQXVV3/QPa+DURJjLRLAPURbz5
	2lP5EtkhVg+cealBlrlS1TyOPmN/X2BRood7KeLC77RO/ygAIrsQ8YjhlBJA2CpBZ1WtDUu5Z9jlf
	pj/oauQZR/KhpOm6TMdoNsDxh4BW2jsT/vLc33drSUn0quEovKS8+fn1h5HRGrGSmzKWwEnyKnmc2
	JvvV7QVUC78jVYNRA1erP3UJWjK1El6nTNvvpHpwAEnFuHtCzaYoCbUu8bkH3V+B5dgRz/+HuqyeI
	hnGsxv99hXZ2ecKa7eFynrJBM9CqwWF9bgu771AYU9zmUeJQJeiFWDKbGq4rkRSlZPIklLGaT9o9Y
	Ahl5yImQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcIE-0000000EB2f-2nAg;
	Wed, 03 Jun 2026 03:29:22 +0000
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcIC-0000000EAyo-0HXM
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 03:29:21 +0000
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-8cbe69b122bso119523326d6.2
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 20:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780457359; x=1781062159; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9xWUzUEP3GatCDCPhqDCyXoyiDq9Ol5847oPRS2f7E=;
        b=PhqIOFA4ZmxFmTqs53EPLq0OyJM3fF6xDkuZChNjikTgfGapkbmGGZ9LEZqDs67paq
         9m1vzdv7TEvDl1UEp2EdW2pxvAjDjh371Yh5an8xrdgHSC7SLBk1n0CLw+DF9j6xJsIW
         NC8t5o+m4Km3Kg9fE8wNfTUC6b+9t7LyFgC2Z6tGsPIvMz15lXGXWeXnUTdnZAESviCz
         cu2i+sH+s5jbg1M2o+fvORzbCfgfCwoU6Y5UFb+7JY40ANb6qmTNZTgT5kH4JyFeUChN
         uZQyyO8ALtWTYz6YS3X233cFfjJlbbspECyWeJovTVbMPY8v5lYtW0YC4+aik61ATGQa
         WftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780457359; x=1781062159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C9xWUzUEP3GatCDCPhqDCyXoyiDq9Ol5847oPRS2f7E=;
        b=DEKV4YEN1AYhVJGtVUtI1Lw0NLmQAsc7yNDH5WSECl0ieO9NsK2JoZLbWjw/MUjX9W
         h6Rrx8f/q4/CH71wHFq+5kiov/B5yCM3G2UGuy6qlrwqmOX9+JxrZSsWxheOAV2iui8w
         P8HSxg9TiSej8VL5SPrqNQRRMDPOEhmvXMj2Z9llKyA2X1X8hp7nL8OTKjOIJB6Gb7Sm
         06AehIznbf4fCr3hp/QgMFJw/fQBvOXd0VOYSuE0CAGCxPCnh2OaMYwESALGahPmMent
         nktHa78vuo4f0rfPa1fVVpNHqXbzCdYzVIByWdNdDQuKOuDa079vQR1YCNI7GfB3uCDN
         gHVg==
X-Forwarded-Encrypted: i=1; AFNElJ/RdSCIF3jSoCADmirkCDJ6p1SSqM1FJjU99TqFylv+Jb/vsq1+fC3fvJWzoDljp9tXwGoTAw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz2rC+NgE+epMOyO5Czc+40AWz7GfwES6U56XHXpVzSrSA3io9s
	p/3EaGWQlb9Kty5MVcJ2RubYxQg01TT+dNOpAFkT7Ji8VoQqKEzCh0pOLiAguBJfrrM=
X-Gm-Gg: Acq92OEgddSMD10DRVqvkvcozViuhb/vyjTXS8/8FEBJ+dA19Fj74AZufjl3Wvu2vEC
	1RzenjS9qr2JX9jdRUW9nrFfyRVncgqCbWhKgr9T2hXb/h8grCYZ8tBow6whjy1UN0Y98f7cHZl
	3th9SzZRO+M0nZU5rqs63PhlG4tE71nKZYDpn2kEaAE6GyJlB+0OfmBmr5ne1hleohrODHyp6c6
	Y1fJnv8Iklg6SZeNrwr2IRQ9540w2Gb5bkBkESRi9tQjJqlQ3vq+pmN0CaUgOMdn+uY/IIKWAJ4
	Kd4QIVpJzbw/E/HhBO1W2k6Ao4bkYa1U4laFnATecLiTd9v/izBODb+Cvq0d3ZF83fF0OkMjcIc
	cJgP3+KEKvZ7Ifa4wdGGT3v1e8eImvAkFsa3BslnyfKhF8kkWnSTV97OgAxlEckrAJHGCvcvw6i
	fezbETWCrvuI1AgyR5v4bLeSDbKNvPxm/4dr5yIItThm/HDWFfELw42Pb3Wn4Zdw==
X-Received: by 2002:a05:6214:c24:b0:8ca:10c9:845d with SMTP id 6a1803df08f44-8cecdf0ca03mr21814626d6.31.1780457358504;
        Tue, 02 Jun 2026 20:29:18 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b3b9sm9244566d6.45.2026.06.02.20.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:29:17 -0700 (PDT)
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
Subject: [PATCH v6 08/13] liveupdate: defer session block allocation and physical address setting
Date: Wed,  3 Jun 2026 03:28:59 +0000
Message-ID: <20260603032905.344462-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603032905.344462-1-pasha.tatashin@soleen.com>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_202920_132548_E13E7ABB 
X-CRM114-Status: GOOD (  18.27  )
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



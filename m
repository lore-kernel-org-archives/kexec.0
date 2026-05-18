Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0366CD4F55
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 12:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SjCAR24a3aXEcLHVCaUoQg6OsgL27BMZ1Zf8TbpqV0k=; b=uIjN5ZTwWz48JavGuouokNbwRf
	ZaDeFpezRxOL8MJGUXSqXvnJtxvNaHgUporOYOh+i9Z7KAm45CnRkcMB8//rWAvWGNJakzPu3mrVY
	oILPAJ9FfasD1Uo+VyiMXhHbZPwt0mAt+c8DWENofNbXyQ1BfTV1PYlZn/uWzd8N1ztWOd2m7/Eut
	xGvAwFlFd6tChSBv6v0mJN+5dwyar5xW5uJM/05PFIDzlXHuAn2kKCk8REiw2eKW3lionWAeAnaBy
	mL3WIZAL/Pg4GgVz/xHkydxKmsWTcAziYsBGTm5xlwOIe62Z+h2KngCAf9Qn8rw4Ghfd4upYvQB2u
	8U6hMf5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxV0-0000000FiKv-3iHz;
	Mon, 18 May 2026 12:55:10 +0000
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxUx-0000000FiHN-1HD9
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 12:55:09 +0000
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-90fe17c157aso275933585a.0
        for <kexec@lists.infradead.org>; Mon, 18 May 2026 05:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779108906; x=1779713706; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjCAR24a3aXEcLHVCaUoQg6OsgL27BMZ1Zf8TbpqV0k=;
        b=J4L9cKUbRkDJqTCh1sMbAnUKj3UrGrIo+djSLUU9RkzG1vztlE7AfG/hnstc3XmdCE
         LcEhC6+Ej7vBwcOTy41rt+OTo+WhL7rzP7eB6yExtI0gwcfs+7fDorhTYq3N5WuKvXez
         2shCXt6LfjGlsZL6Tj4r25L2JvNizKrMbknUDWemeCJWmTxixQX0rgfqqTg9fuWyFc1L
         mCnO0QsWkgIOBQihU8a/AABffsNAZps03ySyNS0BNOckyNVPM2GyrfSMhIZgNRqUqnqt
         RO4wCpVobp5qQQ556F5nX7HuE0cbgaHJl6gtBYRpf6kis3UuqDW3YY6sgRvdCbawiFkU
         GZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108906; x=1779713706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SjCAR24a3aXEcLHVCaUoQg6OsgL27BMZ1Zf8TbpqV0k=;
        b=mN3Dl2HGDQqBMb4ATcd/mA5VTbqItdgdUyq5/gExLjNn6nghogROYajO4ASa/o++7e
         tn1eZzT9ouszxPPSnggD6j8bKjUCn+o8aijU5xCAo+tFvthJxMCIFU3uJS+N+0H0C8nM
         YCREM9Lt+3cqguoH5He5vwyhGQnn5l1t23nOGvVuN6QiR9QL/qqkPBdW1xo4rfhrFKP9
         /UDg5ZopE9dMl/8eHtok4W9IYwaIw5hCDvlprC034tacNeSXWDI0KfCaOKLOIBNQQxcJ
         IWowpGjjIfqc87fP78rpChVfWmb9gtJueLfRGtcdqqx6wmzUyI8ej6eKj/atKwfJOwRl
         IuvA==
X-Forwarded-Encrypted: i=1; AFNElJ/XDSBtwBSPgY0hhSKsSMONe8kvXz8Q9yiLu89NrRX7wNlNFYgDq0f2KwGft4ioHyLfLFAX4Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+6a6/DSB47lrmXbqPKqFwYcJTjw1zQyNIKIlzPIiOafhw4Dhm
	5vncWid8uERj+fu6vyWBtOpLRwAufhht91hSD4x1kRc6+S5KJKxeZiJ5K2vfr9PO1NA=
X-Gm-Gg: Acq92OGA7a3Pmb2FqttjZ9Y8BgOfP6KfUgG4WTQnqfT851r4wpI7s52C1HwVKICdpjA
	Vi6lVYIb1YVJWTu8I4tkzersqCjLRLRc8KcYuv68epMXYes6tOpzJycks8QLwOvHMfgCn7ekPob
	s8BUdp575KhEMdslkQPZEL3g6tdOn4pPNe8uwEXES88qSeBqUVHGap3jGHH9zrnMszHdcKg/e+M
	f8lZAfzSIp1NWd07/iLqyXli/Ss9a6Oirdl7zzHqwHUifFlil8BoUvKramTdoJgdQbWxAnDW7Bg
	F04Na+jMLlvmdBcNnF/fgbCVXtSS6TqKFUa2L2MpBoPHpzhFeEOEbrZso4El3BtfNdhZpX1nqeQ
	7Af/P2PlOmhU9H36VVuofMxOv103j93tyInwo7/8jWEgnEcRrj8mXbicFs9nMgGWC37cxpD3b6F
	39qqMI7zHDcDIaehxEEu2uUmIYR0VYqI1hHri7t6NiEInFe5ioUlLeYcOGjbV0ow==
X-Received: by 2002:a0c:f109:0:b0:89c:4f67:8d17 with SMTP id 6a1803df08f44-8ca0f5c46ddmr189867536d6.8.1779108905929;
        Mon, 18 May 2026 05:55:05 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3608c1desm54511756d6.2.2026.05.18.05.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:55:05 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v5 3/5] liveupdate: block session mutations during reboot
Date: Mon, 18 May 2026 12:54:57 +0000
Message-ID: <20260518125459.1092373-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
References: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_055507_426766_C1A5821B 
X-CRM114-Status: GOOD (  14.40  )
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

During the reboot() syscall, user processes may still be running
concurrently and attempting to mutate sessions (e.g., creating,
retrieving, or releasing sessions). To prevent this, introduce
luo_session_serialize_rwsem to synchronize mutations with the
serialization process.

All session mutation operations (create, retrieve, release, ioctl) take
the read lock. The serialization process (luo_session_serialize) takes
the write lock and holds it indefinitely on success. This effectively
freezes the LUO session subsystem during the transition to the new
kernel. If serialization fails, the lock is released to allow recovery.

Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 59b37d17db6b..812f09152ec1 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -75,6 +75,13 @@
 		sizeof(struct luo_session_header_ser)) /		\
 		sizeof(struct luo_session_ser))
 
+/*
+ * Protects session mutations during serialization. All session mutation
+ * operations must hold the read lock. The serialization process holds the write
+ * lock indefinitely on success to block all concurrent and future mutations.
+ */
+static DECLARE_RWSEM(luo_session_serialize_rwsem);
+
 /**
  * struct luo_session_header - Header struct for managing LUO sessions.
  * @count:      The number of sessions currently tracked in the @list.
@@ -205,6 +212,7 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
 	struct luo_session *session = filep->private_data;
 	struct luo_session_header *sh;
 
+	guard(rwsem_read)(&luo_session_serialize_rwsem);
 	/* If retrieved is set, it means this session is from incoming list */
 	if (session->retrieved) {
 		int err = luo_session_finish_one(session);
@@ -354,6 +362,7 @@ static long luo_session_ioctl(struct file *filep, unsigned int cmd,
 	if (ret)
 		return ret;
 
+	guard(rwsem_read)(&luo_session_serialize_rwsem);
 	return op->execute(session, &ucmd);
 }
 
@@ -389,14 +398,17 @@ int luo_session_create(const char *name, struct file **filep)
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
+	down_read(&luo_session_serialize_rwsem);
 	err = luo_session_insert(&luo_session_global.outgoing, session);
 	if (err)
 		goto err_free;
 
-	scoped_guard(mutex, &session->mutex)
-		err = luo_session_getfile(session, filep);
+	mutex_lock(&session->mutex);
+	err = luo_session_getfile(session, filep);
+	mutex_unlock(&session->mutex);
 	if (err)
 		goto err_remove;
+	up_read(&luo_session_serialize_rwsem);
 
 	return 0;
 
@@ -404,6 +416,7 @@ int luo_session_create(const char *name, struct file **filep)
 	luo_session_remove(&luo_session_global.outgoing, session);
 err_free:
 	luo_session_free(session);
+	up_read(&luo_session_serialize_rwsem);
 
 	return err;
 }
@@ -415,6 +428,7 @@ int luo_session_retrieve(const char *name, struct file **filep)
 	struct luo_session *it;
 	int err;
 
+	guard(rwsem_read)(&luo_session_serialize_rwsem);
 	guard(rwsem_read)(&sh->rwsem);
 	list_for_each_entry(it, &sh->list, list) {
 		if (!strncmp(it->name, name, sizeof(it->name))) {
@@ -582,7 +596,8 @@ int luo_session_serialize(void)
 	int i = 0;
 	int err;
 
-	guard(rwsem_write)(&sh->rwsem);
+	down_write(&luo_session_serialize_rwsem);
+	down_write(&sh->rwsem);
 	list_for_each_entry(session, &sh->list, list) {
 		err = luo_session_freeze_one(session, &sh->ser[i]);
 		if (err)
@@ -593,6 +608,7 @@ int luo_session_serialize(void)
 		i++;
 	}
 	sh->header_ser->count = sh->count;
+	up_write(&sh->rwsem);
 
 	return 0;
 
@@ -602,6 +618,8 @@ int luo_session_serialize(void)
 		luo_session_unfreeze_one(session, &sh->ser[i]);
 		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
 	}
+	up_write(&sh->rwsem);
+	up_write(&luo_session_serialize_rwsem);
 
 	return err;
 }
-- 
2.53.0



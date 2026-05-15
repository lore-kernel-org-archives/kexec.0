Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3BCCD4F41
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 00:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ooju6KHmBOGujIo2QdXWz5njvmf9DOuV9WEiCEZZ98=; b=BEJ9zD9T60zpxXFzB6oRuXKKh4
	dmeCuaiFGFUY4SAXD3sEenL0+j3ai5jW+Bpu9tkGXXdTr0OXdcH+JLqsz1ilJB9OARSH1pZ/LNdlq
	PWRogRMjBBkoTQBsr4H2HwM0iIsrHXZ2Ey7L0aAaQYmJGAJ11HlLIAMlkbRh9MKkTG5uDee8h/Ml1
	OOblgWlQ3KQ8evwmdlukHVJSGE0AN9TWvAx+3HIhrftPWc+nZKeod61Hx0WR+YbLa4oLGZTA3mCOB
	pAVpRbdmR8IDa4gilLcBKDp5u7ELQ1ZZ0e6Xu/nmVNA8vxnD53a81d2Vg328d5Wdgq9FxbmVS2XQ8
	1apZVBJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgYU-00000006vmz-286l;
	Fri, 15 May 2026 00:37:30 +0000
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgYT-00000006vlo-0b0t
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 00:37:30 +0000
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so94005946d6.1
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 17:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778805448; x=1779410248; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ooju6KHmBOGujIo2QdXWz5njvmf9DOuV9WEiCEZZ98=;
        b=NzaLcfUsXrEe3AMLCaY2UWO/naeU5nIPGwV99KKsFyvHZeBXhtdocLkwJEX6MRYmis
         lr8nHgIJgoIieR1gkPWjCT0cfqMBzm1dzrrXWhDd41HhzeuO4YIjcgt03xBNt9iUU+aH
         C+9QtPYyoQeuMqrBLNwfl8n7GQlR1FXKZiMURnoVxYu861Ws4Qh3KkGG9R4+prZV4sFV
         LGYV3/fRqXTMRrI0n46czE9Wlhy/lep7lcHh/jqYHELySsoc765VINHpDgV189+808uT
         HMdmnRuuvj72GdbTSE3Ud6jHFZ/Ffny2kTuJ0SB2EUFVXNsLrXIXMBc5Z1MvOOFmevab
         8lBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778805448; x=1779410248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ooju6KHmBOGujIo2QdXWz5njvmf9DOuV9WEiCEZZ98=;
        b=ljETtyA0rIlTWVH+wAhDSU4A0MJez08WFwA9m0klF1EnYNomFhOAMamX27EmzqfvVu
         4NzzDxScpGo2Kv8LFkXlBIkZtpytU8euYU4pDmd1ZA8cB2Mo8dJlmLEeZpLGo0GXioST
         PL7oXx80yyhutwFxKqKRPxnLl+fnDBcC+tLxa9CmDLtq+RyBKa5+Es4CvRKLTvwgdngZ
         koi6VP0qciTRCG00HtyT/WJLbHJkdfYdb+mh36HL4xU3wzXH2yXBsNnVMr9nPaGh0/cJ
         wyHSfhLNXQBYFmNGHj0RfrBtYL3K8aYRN6qvA1zHaot74gX0GDPoU4MItQD+LBYG8n6Y
         8dDA==
X-Forwarded-Encrypted: i=1; AFNElJ+QPzCI1K0erM5LQ4d2Q9YsnFUBxdWikTjvO4jpwnXGJFrot1zK9A8Fibol6JA8thGaxfoj3A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyS5wsKlHM0kRLLUILuqZyiQ/xXeuTZKs9uXXOwXfztuq/TGVUk
	7X+ailp8xciNhE5ulH8CuGOm2rcD0Mw7wnvm7Liid0JTpfhclbP3mBC1fdZC+ojJHEY=
X-Gm-Gg: Acq92OHFWBWafSydx6UjYLH6KxHoNLXLwtm6x5yrdO2Zs4vtQt8QN7ppcq0bDR6yIM7
	DmBGOhh0FZ7bszneEWi8+cq4Nuxg1Kzf/bnz/iku79iLbba0/tq8lkfeuS34A0Vm9qE9MWHKIs5
	3SeM18DRF8bmvOcT4f9a0Z5QaBXAy8m5yaF2JoOL0nrmQlUOHDClBzF7wUGFWxE8GAKko95AYZx
	2UrnbP1CfdjNkliggfYvqGq9QRyW4PCPMm2cYXtl7vqhoG7Zxx3bvajyHriHaItodXwcR+yFiEg
	wzDG7XYinikpRdCEBsOSGqUclh29epeGtq3MVKHicqrkVPAFhZasSzdRD5ie5NIg3jKTTr6g9en
	QE183ikAdoMX0hzLOcoz/r1RO4gzk8tnVKzk0PA2rY7yQmStisnAVCVUBbslpnt6YpuJWm3aWy/
	XC53aXI/i2sKfE8UD9pNn192BzAhqMxSRhQKmeZmTUUWvZsMvnpDc=
X-Received: by 2002:a05:6214:8083:b0:8ae:6587:3d54 with SMTP id 6a1803df08f44-8ca0f69eab2mr32523036d6.26.1778805447605;
        Thu, 14 May 2026 17:37:27 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c16366csm36918236d6.40.2026.05.14.17.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 17:37:26 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kees@kernel.org,
	rppt@kernel.org,
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
Subject: [PATCH v3 2/5] liveupdate: block session mutations during reboot
Date: Fri, 15 May 2026 00:37:19 +0000
Message-ID: <20260515003722.938123-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515003722.938123-1-pasha.tatashin@soleen.com>
References: <20260515003722.938123-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_173729_188359_BA33C327 
X-CRM114-Status: GOOD (  13.28  )
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
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index a3327a28fc1f..5aa0011d9643 100644
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
 
@@ -385,6 +394,7 @@ int luo_session_create(const char *name, struct file **filep)
 	struct luo_session *session;
 	int err;
 
+	guard(rwsem_read)(&luo_session_serialize_rwsem);
 	session = luo_session_alloc(name);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
@@ -415,6 +425,7 @@ int luo_session_retrieve(const char *name, struct file **filep)
 	struct luo_session *it;
 	int err;
 
+	guard(rwsem_read)(&luo_session_serialize_rwsem);
 	scoped_guard(rwsem_read, &sh->rwsem) {
 		list_for_each_entry(it, &sh->list, list) {
 			if (!strncmp(it->name, name, sizeof(it->name))) {
@@ -583,7 +594,8 @@ int luo_session_serialize(void)
 	int i = 0;
 	int err;
 
-	guard(rwsem_write)(&sh->rwsem);
+	down_write(&luo_session_serialize_rwsem);
+	down_write(&sh->rwsem);
 	list_for_each_entry(session, &sh->list, list) {
 		err = luo_session_freeze_one(session, &sh->ser[i]);
 		if (err)
@@ -603,6 +615,8 @@ int luo_session_serialize(void)
 		luo_session_unfreeze_one(session, &sh->ser[i]);
 		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
 	}
+	up_write(&sh->rwsem);
+	up_write(&luo_session_serialize_rwsem);
 
 	return err;
 }
-- 
2.53.0



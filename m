Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB3ECD4F3D
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IaFXHj+nOOniyoasttf/PvlR/IAc0qdJJnVbcz5jRsQ=; b=dSYsUIPQk96kYIEkSFNRaKjQXV
	tAMhi7Mq4n7Eg2kwizaO8ZDOzAAV+Mx6VhQzXk4P+kdbG915Hgx09GbrXFZ4Mh5vCqfW8iA8/q6RI
	Wr9ouQ3Yq626jcbEH2sofkFD5mfp3myVTTT6s/37FCNmfSu71Zf2FWZkJLgL7UOIACp7X7Oy0jgSK
	G71uU1bUBTAEWT1zR6o6AF6hLzmvyMjgFkKa6tkvISXk3OvFX8oHkoJhtlo5gct1K0Ue32JT2XWfd
	40a78P9dWB6qUI9Kk5u8un8sezd5tcBUgyFF+qQ2yfCMrNGY1v5T/7X4L80nscvJtbyEdoXmcMHgA
	JRQ8MhKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOh8g-0000000DKTf-0K54;
	Sun, 17 May 2026 19:27:02 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOh8d-0000000DKQQ-33FX
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 19:27:00 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-50fb1ad3734so30410351cf.1
        for <kexec@lists.infradead.org>; Sun, 17 May 2026 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779046018; x=1779650818; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IaFXHj+nOOniyoasttf/PvlR/IAc0qdJJnVbcz5jRsQ=;
        b=h52fu1v7+t03h3DzgQFH8YUSh8przlOZrJZGF8HFeJjPsguDVLiWbknv//e7rNHv4K
         QSKMDwU59GTp9AHYdh2LgufMG18qo96B0cHxUqOtyREnVAgV4DP+vbM1uirnjCDx3dKR
         fRNvbQpzcpWZO5tiayAsAz+1xjwsxlWuIxJlKkdEx8dgXsEyvTYOHwFh25udi8HsWy8X
         nD0FY1Yezrx+7Nc28SIq2sNSsPfQ3dE0q+2bkYqsoQKdvdU5PoG/0UkFfAhgaAlKDP37
         z+vQ/wqlGjN+zuddfwtigGVJQH7DiXzKpxZW2XWXyZQungR6TxPy16bxObJxzku75QLf
         cWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779046018; x=1779650818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IaFXHj+nOOniyoasttf/PvlR/IAc0qdJJnVbcz5jRsQ=;
        b=resnaSYUCyf002v+fSbOXpfzsfyzr6UO80TxwAYDhBzg1v0ba0ivcMZYZOQM7GxpoQ
         MCA62EnGYe9a7cFYFSsbkMuXpyUiuIjI9Mg3nG+6ulNoBNix/ZnDH2/ZV8azdn3lDXwY
         hVuUQV2L0bBkK9XsBM6S4DkFL7IU7WvQRWCrZhvtIRCCjxW+BcBijALyQtwo+by4RisT
         EgNu1wsoyFuf2NBI5xPW+wTkVaesytM0z6wXnp5ROUp6mOnmrkzs75TIzPlHy+akvjYP
         Q1BZEQywr7wsTRYZ+WAqkX6PMM6mu/91IjR4h6rfyAgwC+cVG9FyYe2dn8GHKOQTJlen
         Nu2A==
X-Forwarded-Encrypted: i=1; AFNElJ9Zl8mo5eCmGPhM6CQc+2aelrGLagIlHlBJ8svHp9Jc9u2C3159YJ0g/dbWEyTYmhNy52BuEA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzs+SOiQWL/lmUB2LfnL8ezCARTZfnZ3eWk9cB4cGxD8ZWfgoaW
	eGPmjngOWhbkLzuOP4rZYtFXx8kZ3IH24P93aoGG6G4w3gOgYSioIS11Uvj0tr/+yFs=
X-Gm-Gg: Acq92OHARYzwKxROhYZRZV+9wc6h8jirK6cpDOK+y2Bk7MLk0xX+snZR6k6soystqly
	ifr3lsEVRRCXwbTVDcmAD8CI94GNRACuryoyckdUd4FKHzERmqZH+IMGS37bRA50S0ejSbsWuej
	ks5WA4rCA4WMlBqITlDm3qOdYjn8L0mWf7JTv5Gbn0toR1N0tYh/+vVOYDA9zr5SiSIEupUI1Lz
	F8D8mfk1hX6QyiO8omjfEfDklb2j7GfQXKHnUc8D34IJSkz26UHAj8emnI3Uz9vTqi1Y3zFQGag
	TxNgqe1Jyq8yz5Xxzaf16an6u8Rn4jdnit7D163IVpJ3EdUC3wLWdvPfVB4h9RbCbYqEZWCUNTU
	bEH+B97mBiALqyxL50muXS2bZSbhnh9ibjSJvIKFTXA+oy0nNmMxcj9K9U5Xezj+Z/baCwydKgW
	LCcFnZc+qhkqCnqX8uc6JQMj04eJt+Q2ONoUoRpYR67FOF068SjLdZ+jG0O2YMZg==
X-Received: by 2002:a05:622a:4acd:b0:50e:61ea:d8e0 with SMTP id d75a77b69052e-5165984aa8bmr143676721cf.21.1779046018539;
        Sun, 17 May 2026 12:26:58 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456d5c4dsm108828621cf.12.2026.05.17.12.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 12:26:57 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	liaoyuanhong@vivo.com,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v4 3/5] liveupdate: block session mutations during reboot
Date: Sun, 17 May 2026 19:26:48 +0000
Message-ID: <20260517192650.1019314-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
References: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_122659_802370_24A72AB4 
X-CRM114-Status: GOOD (  14.27  )
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
 kernel/liveupdate/luo_session.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 59b37d17db6b..6099213275d8 100644
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
 
@@ -385,9 +394,12 @@ int luo_session_create(const char *name, struct file **filep)
 	struct luo_session *session;
 	int err;
 
+	down_read(&luo_session_serialize_rwsem);
 	session = luo_session_alloc(name);
-	if (IS_ERR(session))
-		return PTR_ERR(session);
+	if (IS_ERR(session)) {
+		err = PTR_ERR(session);
+		goto err_unlock;
+	}
 
 	err = luo_session_insert(&luo_session_global.outgoing, session);
 	if (err)
@@ -398,12 +410,16 @@ int luo_session_create(const char *name, struct file **filep)
 	if (err)
 		goto err_remove;
 
+	up_read(&luo_session_serialize_rwsem);
+
 	return 0;
 
 err_remove:
 	luo_session_remove(&luo_session_global.outgoing, session);
 err_free:
 	luo_session_free(session);
+err_unlock:
+	up_read(&luo_session_serialize_rwsem);
 
 	return err;
 }
@@ -415,6 +431,7 @@ int luo_session_retrieve(const char *name, struct file **filep)
 	struct luo_session *it;
 	int err;
 
+	guard(rwsem_read)(&luo_session_serialize_rwsem);
 	guard(rwsem_read)(&sh->rwsem);
 	list_for_each_entry(it, &sh->list, list) {
 		if (!strncmp(it->name, name, sizeof(it->name))) {
@@ -582,7 +599,8 @@ int luo_session_serialize(void)
 	int i = 0;
 	int err;
 
-	guard(rwsem_write)(&sh->rwsem);
+	down_write(&luo_session_serialize_rwsem);
+	down_write(&sh->rwsem);
 	list_for_each_entry(session, &sh->list, list) {
 		err = luo_session_freeze_one(session, &sh->ser[i]);
 		if (err)
@@ -593,6 +611,7 @@ int luo_session_serialize(void)
 		i++;
 	}
 	sh->header_ser->count = sh->count;
+	up_write(&sh->rwsem);
 
 	return 0;
 
@@ -602,6 +621,8 @@ int luo_session_serialize(void)
 		luo_session_unfreeze_one(session, &sh->ser[i]);
 		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
 	}
+	up_write(&sh->rwsem);
+	up_write(&luo_session_serialize_rwsem);
 
 	return err;
 }
-- 
2.53.0



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F311099B31
	for <kexec@archiver.kernel.org>; Fri, 20 Mar 2026 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zFcjBe+mvrvbkiJzQPLvMjEPcNe5xRrIkckbRoMHOoU=; b=fuPVhqjotuZQ7OZotq9yMFLIxx
	DMixYUSqkBbsaMO0amlFfKVEau2t/Q2467dLrDJHafCrkZvZ5vE4kypSh6SPFWaXhC+2GyWl7H0BP
	IJ79A2NSDNlsuzrodcd+RrpXBxZ4kHxFK77O7Adv2eT8psh9AJHOafEfa5pGFVv96z8zj6MotJsEn
	+cnH6pszOYbzngr9pZVri5+QIAZPTq4kDscITGinbOzPLUBCmzPq39Fttjv17prwvWoZYD81U6G3z
	k/Slqqq/RfX8StNWW9sb8IFcb0l6DwnTfY7QnmnxDSIDWMPDhhsf/02YXf2oGlKc/1u4OF4cOEDaQ
	AbEp9v+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3e9S-0000000DLCG-141M;
	Fri, 20 Mar 2026 18:00:50 +0000
Received: from ip74-208-171-129.pbiaas.com ([74.208.171.129] helo=kansas-city-edge.smtp.mymangomail.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3e9B-0000000DLB8-3LMK
	for kexec@lists.infradead.org;
	Fri, 20 Mar 2026 18:00:48 +0000
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTP id CA6965D9CF;
	Fri, 20 Mar 2026 12:40:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774024849;
	bh=QWzd64L8DpR90a0dwQiBIkOjZTFKBpBjyJYEA80DZcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVlr5fcb4wlv/TtO3vW3AC/Jm6ICTm/eyKjhDPV/8VMUuIjXTpJsD0mdi8g71aYpf
	 0JIxHH9sE2RXzitN6IGUmCNVCy2ZwMms3/ZFHO0kL/QzBc2i/kETtbp69tnH8JJtOg
	 7T4KVWl6vtg2ax/fKQpnQizf1s2t4Gah5V5DMuq4=
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
Received: from authenticated-user (smtp.mymangomail.com [205.185.121.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTPSA id 92A775D9B1;
	Fri, 20 Mar 2026 12:39:37 -0400 (EDT)
From: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Subject: [PATCH 2/5] kexec: abort liveupdate handover on kernel_kexec() unwind
Date: Fri, 20 Mar 2026 17:37:17 +0100
Message-ID: <20260320163720.100456-2-oskar@gerlicz.space>
In-Reply-To: <20260320163720.100456-1-oskar@gerlicz.space>
References: <20260320163720.100456-1-oskar@gerlicz.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_110042_325570_EF7CFB2E 
X-CRM114-Status: GOOD (  14.19  )
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

Once outgoing sessions are blocked during reboot, every failure path
after liveupdate_reboot() must release that state again. Today
kernel_kexec() sets liveupdate_prepared only after
liveupdate_reboot() returns successfully, so a partial failure inside
liveupdate_reboot() skips the abort path entirely. The
kho_finalize() failure path also leaves the LUO session state frozen.

This is dangerous because a failed kexec attempt can leave userspace
with outgoing sessions stuck in reboot state, blocking release and
preserve paths until the next reboot.

Export a liveupdate_reboot_abort() helper, call it from the
kho_finalize() error path, and mark liveupdate as prepared before
entering liveupdate_reboot(). That makes every failed handover attempt
unwind the session state and wake blocked waiters.

Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
---
 include/linux/liveupdate.h       |  5 +++++
 kernel/kexec_core.c              |  4 ++++
 kernel/liveupdate/luo_core.c     | 11 ++++++++++-
 kernel/liveupdate/luo_internal.h |  1 +
 kernel/liveupdate/luo_session.c  | 23 +++++++++++++++++++++++
 5 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index dd11fdc76a5f..d93b043a0421 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -226,6 +226,7 @@ bool liveupdate_enabled(void);
 
 /* Called during kexec to tell LUO that entered into reboot */
 int liveupdate_reboot(void);
+void liveupdate_reboot_abort(void);
 
 int liveupdate_register_file_handler(struct liveupdate_file_handler *fh);
 int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh);
@@ -250,6 +251,10 @@ static inline int liveupdate_reboot(void)
 	return 0;
 }
 
+static inline void liveupdate_reboot_abort(void)
+{
+}
+
 static inline int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 2fea396d29b9..492c17f7e96f 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1139,6 +1139,7 @@ bool kexec_load_permitted(int kexec_image_type)
 int kernel_kexec(void)
 {
 	int error = 0;
+	bool liveupdate_prepared = false;
 
 	if (!kexec_trylock())
 		return -EBUSY;
@@ -1147,6 +1148,7 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
+	liveupdate_prepared = true;
 	error = liveupdate_reboot();
 	if (error)
 		goto Unlock;
@@ -1231,6 +1233,8 @@ int kernel_kexec(void)
 #endif
 
  Unlock:
+	if (error && liveupdate_prepared)
+		liveupdate_reboot_abort();
 	kexec_unlock();
 	return error;
 }
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index dda7bb57d421..95a0b81ce60d 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -233,8 +233,9 @@ int liveupdate_reboot(void)
 	err = kho_finalize();
 	if (err) {
 		pr_err("kho_finalize failed %d\n", err);
+		liveupdate_reboot_abort();
 		/*
-		 * kho_finalize() may return libfdt errors, to aboid passing to
+		 * kho_finalize() may return libfdt errors, to avoid passing to
 		 * userspace unknown errors, change this to EAGAIN.
 		 */
 		err = -EAGAIN;
@@ -243,6 +244,14 @@ int liveupdate_reboot(void)
 	return err;
 }
 
+void liveupdate_reboot_abort(void)
+{
+	if (!liveupdate_enabled())
+		return;
+
+	luo_session_abort_reboot();
+}
+
 /**
  * liveupdate_enabled - Check if the live update feature is enabled.
  *
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 8083d8739b09..ad09ea756156 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -82,6 +82,7 @@ int luo_session_retrieve(const char *name, struct file **filep);
 int __init luo_session_setup_outgoing(void *fdt);
 int __init luo_session_setup_incoming(void *fdt);
 int luo_session_serialize(void);
+void luo_session_abort_reboot(void);
 int luo_session_deserialize(void);
 bool luo_session_quiesce(void);
 void luo_session_resume(void);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index ee5ea2a8ed3f..39215e5eda7a 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -649,6 +649,29 @@ int luo_session_serialize(void)
 	return err;
 }
 
+void luo_session_abort_reboot(void)
+{
+	struct luo_session_header *sh = &luo_session_global.outgoing;
+	struct luo_session *session;
+	int i = 0;
+
+	guard(rwsem_write)(&sh->rwsem);
+	if (!READ_ONCE(sh->rebooting))
+		return;
+
+	list_for_each_entry(session, &sh->list, list) {
+		if (i >= sh->header_ser->count)
+			break;
+
+		luo_session_unfreeze_one(session, &sh->ser[i]);
+		memset(&sh->ser[i], 0, sizeof(sh->ser[i]));
+		i++;
+	}
+
+	sh->header_ser->count = 0;
+	luo_session_reboot_done(sh);
+}
+
 /**
  * luo_session_quiesce - Ensure no active sessions exist and lock session lists.
  *
-- 
2.53.0



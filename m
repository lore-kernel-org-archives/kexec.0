Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49D61094478
	for <kexec@archiver.kernel.org>; Sat, 21 Mar 2026 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bRI3gi1rj7sgjUnDtTTIzUk4ldjLipnVZsAhyw+Xi5g=; b=4tFtjF9AuWB6wjZx1Dm8J2lQ9u
	fOpBvD4k1yJFQy2F7xW3X1SQahSJukap+frWywgzRZKTxJbj1y2ZAprPVWaNyTlWKyvtXLIZm5HtZ
	SSXzcLtB6sRTLJY8q1ps7oYeqHBnd0+O/nBrHZd7k4e2w6xSXEHM6gbk8jxiwZ4Wy97WtggdZK5qT
	Fzgt6XtlAQlPSkGznzI9bRhTW50vmr9U9MtVHFm92rH4XiYqQNlFFTbT+fvMwwbamFQyOBIqS//hf
	PEsOpKIcdEJGOGhBPIz0AYMtCoA1Q6uwmWnVv8k/xq4+Gf6j2jo2aRfio+QpYQ/VRp0uk9EKeCHRc
	aG3DwKEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3xUa-0000000EXvl-2wnJ;
	Sat, 21 Mar 2026 14:39:56 +0000
Received: from hillsboro-edge.smtp.mymangomail.com ([5.78.130.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3xUY-0000000EXvM-3ah8
	for kexec@lists.infradead.org;
	Sat, 21 Mar 2026 14:39:55 +0000
Received: from smtp.mymangomail.com (localhost [127.0.0.1])
	by smtp.mymangomail.com (Mango Mail) with ESMTP id 38265408C6;
	Sat, 21 Mar 2026 10:39:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774103977;
	bh=jz9Jb4ua+BZoDIIioX5BJmmKHIi5gc9v+wumLKcLorw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVqdmvMKUvq7LkIocLlE+laSboKDD8eUR7gtgbTJNfrEUqkWY7oww1mbKyjxe15ZH
	 +B46IAuq0t89QKyh2cxDSV/TKkLdndJ0H2bh7Y4CajAdagVA5N9j1wwXjFrbgDafcT
	 jExo16mpKfZI0hj7IJrVuaBXiN3EI6DRSKsOOehY=
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
	by smtp.mymangomail.com (Mango Mail) with ESMTPSA id 2255641648;
	Sat, 21 Mar 2026 10:38:15 -0400 (EDT)
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
Subject: [PATCH v3 2/5] kexec: abort liveupdate handover on kernel_kexec()
 unwind
Date: Sat, 21 Mar 2026 15:36:39 +0100
Message-ID: <20260321143642.166313-2-oskar@gerlicz.space>
In-Reply-To: <20260321143642.166313-1-oskar@gerlicz.space>
References: <20260321143642.166313-1-oskar@gerlicz.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_073954_940897_7D30F4FA 
X-CRM114-Status: GOOD (  15.18  )
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

liveupdate_reboot() can freeze outgoing session state before the kexec
transition completes. v2 only unwound that state when kernel_kexec()
returned a non-zero error, which misses the preserve_context path where
machine_kexec() can return to the old kernel with error == 0.

If that return path skips the abort, outgoing sessions remain stuck in
the reboot state and later user space operations cannot make progress.

Treat every return to the original kernel after a prepared liveupdate
handover as an unwind point and call liveupdate_reboot_abort() there as
well.

Fixes: 8b32d3ced269 ("kexec: abort liveupdate handover on kernel_kexec() unwind")
Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
---
 include/linux/liveupdate.h       |  5 +++++
 kernel/kexec_core.c              |  6 +++++-
 kernel/liveupdate/luo_core.c     | 11 ++++++++++-
 kernel/liveupdate/luo_internal.h |  1 +
 kernel/liveupdate/luo_session.c  | 23 +++++++++++++++++++++++
 5 files changed, 44 insertions(+), 2 deletions(-)

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
index 2fea396d29b9..95710a7d5e56 100644
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
@@ -1230,7 +1232,9 @@ int kernel_kexec(void)
 	}
 #endif
 
- Unlock:
+Unlock:
+	if (liveupdate_prepared)
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
index 0cfc0269d746..8a6b1f6c9b4f 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -88,6 +88,7 @@ int luo_session_retrieve(const char *name, struct file **filep);
 int __init luo_session_setup_outgoing(void *fdt);
 int __init luo_session_setup_incoming(void *fdt);
 int luo_session_serialize(void);
+void luo_session_abort_reboot(void);
 int luo_session_deserialize(void);
 bool luo_session_quiesce(void);
 void luo_session_resume(void);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index d97ec91e1118..200dd3b8229c 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -788,6 +788,29 @@ int luo_session_serialize(void)
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



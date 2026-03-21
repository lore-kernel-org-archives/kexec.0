Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF511094478
	for <kexec@archiver.kernel.org>; Sat, 21 Mar 2026 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h+HanHTyFc9rRinieUfKka3/7aq/7tvNhr3nQ0O56VQ=; b=fgedyRzYRZKVucasE92GHjz6dY
	Z26NrO01wgpqss7yUEG4z1zJIg79apHY91qUFAvzMqAfcCBoKPKvl0bWVyAm9kA/nQkYart4sDQaG
	srPYePOi/Ipzq3YCvfcnNdQS6tFv10TSKi4zvKc8dzZpsdlnbpcBmzkHnwM//SKYtAf8ZcT54XsF6
	t6nk29pIPzCO0ikA8YCkYFf87+oKY1y+k1sUtiZjkixE17OvCT7YU7IztliJLUjZ5JqV0S25nGeHG
	ykvEIYvlolsa272AxHIFLOKqw8jg2Gw2cmhouRDaaiR0VdJkN/u4tSZEAlecfqvbbcSIfInb0Q8Ap
	NS4a+84Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3xYW-0000000EYJn-1Xkt;
	Sat, 21 Mar 2026 14:44:00 +0000
Received: from hillsboro-edge.smtp.mymangomail.com ([5.78.130.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3xYS-0000000EYJC-0F2q
	for kexec@lists.infradead.org;
	Sat, 21 Mar 2026 14:43:57 +0000
Received: from smtp.mymangomail.com (localhost [127.0.0.1])
	by smtp.mymangomail.com (Mango Mail) with ESMTP id 0A4B14162F;
	Sat, 21 Mar 2026 10:43:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774104210;
	bh=iijof/0zlMIHD/7/fVF2LLJM8239N8q06Cog8S4qnEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOeGJKtxlJtcUM3CqUoQVPwcUk2Z32Ql85ogfV/JiPVLPt6qlXIjjxgBGds10Ch5B
	 VrMv0s7Cwpce9/yg5zCRq+OmlcRD56mIt+SDiE0YH/XR2H8egsMNAlnx/Vpg0MI7Z3
	 I7AW64pBdCpxPGCrVvqSBRf5OKN+WI/X2Ti9DPIg=
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
	by smtp.mymangomail.com (Mango Mail) with ESMTPSA id C666141627;
	Sat, 21 Mar 2026 10:42:26 -0400 (EDT)
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
Subject: [PATCH v3 5/5] liveupdate: harden FLB lifetime and teardown paths
Date: Sat, 21 Mar 2026 15:36:42 +0100
Message-ID: <20260321143642.166313-5-oskar@gerlicz.space>
In-Reply-To: <20260321143642.166313-4-oskar@gerlicz.space>
References: <20260321143642.166313-1-oskar@gerlicz.space>
 <20260321143642.166313-2-oskar@gerlicz.space>
 <20260321143642.166313-3-oskar@gerlicz.space>
 <20260321143642.166313-4-oskar@gerlicz.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_074356_141793_738DB5E0 
X-CRM114-Status: GOOD (  20.98  )
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

The remaining FLB teardown paths still had a few lifetime holes. Incoming
counters could underflow, the returned incoming object was not pinned
against concurrent finish, and copied incoming FLB metadata could be
freed while another thread was still scanning it.

That makes incoming FLB teardown racy and can leave callers with stale
objects or freed metadata.

Guard the FLB counters, make liveupdate_flb_get_incoming() hold the
incoming FLB lock until the caller releases it, and serialize access to
the copied incoming FLB metadata while it is being retrieved or
discarded.

Fixes: 8c31961065ee ("liveupdate: harden FLB and incoming teardown paths")
Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
---
 include/linux/liveupdate.h       |  5 ++
 kernel/liveupdate/luo_flb.c      | 78 ++++++++++++++++++++++++--------
 kernel/liveupdate/luo_internal.h |  1 +
 lib/tests/liveupdate.c           |  2 +
 4 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 611907f57127..dd34587a9c4e 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -240,6 +240,7 @@ int liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
 			      struct liveupdate_flb *flb);
 
 int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp);
+void liveupdate_flb_put_incoming(struct liveupdate_flb *flb);
 int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp);
 
 #else /* CONFIG_LIVEUPDATE */
@@ -286,6 +287,10 @@ static inline int liveupdate_flb_get_incoming(struct liveupdate_flb *flb,
 	return -EOPNOTSUPP;
 }
 
+static inline void liveupdate_flb_put_incoming(struct liveupdate_flb *flb)
+{
+}
+
 static inline int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb,
 					      void **objp)
 {
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index cdd293408138..2cd5864c8b26 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -70,6 +70,8 @@ struct luo_flb_global {
 	long count;
 };
 
+static DEFINE_MUTEX(luo_flb_incoming_lock);
+
 static struct luo_flb_global luo_flb_global = {
 	.list = LIST_HEAD_INIT(luo_flb_global.list),
 };
@@ -128,6 +130,9 @@ static void luo_flb_file_unpreserve_one(struct liveupdate_flb *flb)
 	struct luo_flb_private *private = luo_flb_get_private(flb);
 
 	scoped_guard(mutex, &private->outgoing.lock) {
+		if (WARN_ON_ONCE(!private->outgoing.count))
+			return;
+
 		private->outgoing.count--;
 		if (!private->outgoing.count) {
 			struct liveupdate_flb_op_args args = {0};
@@ -161,22 +166,24 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 	if (private->incoming.retrieved)
 		return 0;
 
-	if (!fh->active)
-		return -ENODATA;
-
-	for (int i = 0; i < fh->header_ser->count; i++) {
-		if (strnlen(fh->ser[i].name, sizeof(fh->ser[i].name)) ==
-		    sizeof(fh->ser[i].name))
-			return -EINVAL;
+	scoped_guard(mutex, &luo_flb_incoming_lock) {
+		if (!fh->active)
+			return -ENODATA;
 
-		if (!strcmp(fh->ser[i].name, flb->compatible)) {
-			if (!fh->ser[i].count)
+		for (int i = 0; i < fh->header_ser->count; i++) {
+			if (strnlen(fh->ser[i].name, sizeof(fh->ser[i].name)) ==
+			    sizeof(fh->ser[i].name))
 				return -EINVAL;
 
-			private->incoming.data = fh->ser[i].data;
-			private->incoming.count = fh->ser[i].count;
-			found = true;
-			break;
+			if (!strcmp(fh->ser[i].name, flb->compatible)) {
+				if (!fh->ser[i].count)
+					return -EINVAL;
+
+				private->incoming.data = fh->ser[i].data;
+				private->incoming.count = fh->ser[i].count;
+				found = true;
+				break;
+			}
 		}
 	}
 
@@ -201,8 +208,12 @@ static void luo_flb_file_finish_one(struct liveupdate_flb *flb)
 	struct luo_flb_private *private = luo_flb_get_private(flb);
 	u64 count;
 
-	scoped_guard(mutex, &private->incoming.lock)
+	scoped_guard(mutex, &private->incoming.lock) {
+		if (WARN_ON_ONCE(!private->incoming.count))
+			return;
+
 		count = --private->incoming.count;
+	}
 
 	if (!count) {
 		struct liveupdate_flb_op_args args = {0};
@@ -303,6 +314,17 @@ void luo_flb_file_finish(struct liveupdate_file_handler *fh)
 		luo_flb_file_finish_one(iter->flb);
 }
 
+void luo_flb_discard_incoming(void)
+{
+	struct luo_flb_header *fh = &luo_flb_global.incoming;
+
+	guard(mutex)(&luo_flb_incoming_lock);
+	kfree(fh->header_ser);
+	fh->header_ser = NULL;
+	fh->ser = NULL;
+	fh->active = false;
+}
+
 /**
  * liveupdate_register_flb - Associate an FLB with a file handler and register it globally.
  * @fh:   The file handler that will now depend on the FLB.
@@ -490,7 +512,8 @@ int liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
  * @objp: Output parameter; will be populated with the live shared object.
  *
  * Returns a pointer to its shared live object for the incoming (post-reboot)
- * path.
+ * path. The returned pointer remains valid until
+ * liveupdate_flb_put_incoming() is called.
  *
  * If this is the first time the object is requested in the new kernel, this
  * function will trigger the FLB's .retrieve() callback to reconstruct the
@@ -508,17 +531,30 @@ int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp)
 	if (!liveupdate_enabled())
 		return -EOPNOTSUPP;
 
-	if (!private->incoming.obj) {
+	if (!READ_ONCE(private->incoming.obj)) {
 		int err = luo_flb_retrieve_one(flb);
 
 		if (err)
 			return err;
 	}
 
-	guard(mutex)(&private->incoming.lock);
+	mutex_lock(&private->incoming.lock);
+	if (!private->incoming.obj)
+		goto err_unlock;
 	*objp = private->incoming.obj;
 
 	return 0;
+
+err_unlock:
+	mutex_unlock(&private->incoming.lock);
+	return -ENODATA;
+}
+
+void liveupdate_flb_put_incoming(struct liveupdate_flb *flb)
+{
+	struct luo_flb_private *private = luo_flb_get_private(flb);
+
+	mutex_unlock(&private->incoming.lock);
 }
 
 /**
@@ -640,9 +676,11 @@ int __init luo_flb_setup_incoming(void *fdt_in)
 	if (!header_copy)
 		return -ENOMEM;
 
-	luo_flb_global.incoming.header_ser = header_copy;
-	luo_flb_global.incoming.ser = (void *)(header_copy + 1);
-	luo_flb_global.incoming.active = true;
+	scoped_guard(mutex, &luo_flb_incoming_lock) {
+		luo_flb_global.incoming.header_ser = header_copy;
+		luo_flb_global.incoming.ser = (void *)(header_copy + 1);
+		luo_flb_global.incoming.active = true;
+	}
 
 	return 0;
 }
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 4842c7dbeb63..e4d1919370f1 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -113,6 +113,7 @@ void luo_flb_file_unpreserve(struct liveupdate_file_handler *fh);
 void luo_flb_file_finish(struct liveupdate_file_handler *fh);
 int __init luo_flb_setup_outgoing(void *fdt);
 int __init luo_flb_setup_incoming(void *fdt);
+void luo_flb_discard_incoming(void);
 void luo_flb_serialize(void);
 
 #ifdef CONFIG_LIVEUPDATE_TEST
diff --git a/lib/tests/liveupdate.c b/lib/tests/liveupdate.c
index 496d6ef91a30..620cefd52229 100644
--- a/lib/tests/liveupdate.c
+++ b/lib/tests/liveupdate.c
@@ -105,6 +105,8 @@ static void liveupdate_test_init(void)
 			pr_err("liveupdate_flb_get_incoming for %s failed: %pe\n",
 			       flb->compatible, ERR_PTR(err));
 		}
+		if (!err)
+			liveupdate_flb_put_incoming(flb);
 	}
 	initialized = true;
 }
-- 
2.53.0



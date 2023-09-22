Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E53CE7A88
	for <kexec@archiver.kernel.org>; Fri, 22 Sep 2023 23:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nfteTgj2Nj5fa586eKmlzvjs9oo4Q0W2qdThm3drnXk=; b=2Qw8vaxOZQu38P
	vXIGuQ5AfGEsZDPYA5zEUex7uFpN3RFxLQPoPIn4yoo10czFjINiWCpoHQd12hmR1hIdfG4sjewRv
	TTMOtUCC0qw3IESJW4/6+eQn2Fk9bIF8JQAuND40BXEF2NNWe2vIp/Xx4Dmftgti/BjWUOpNJbn3F
	S7hcbS25ULmKFFCQ9ZSDpvyT7uBkLa2cISTmduPaNC+dSHRgtaLbBPuullvbgLwGHNPIs51Q1Lrtr
	bKyqFZTky6/yG4ic/j1NrpF8/tXlXyDjmQkcHFVJn7Eig1p7T+R9r7WVU/VDBHw7/rK64Swfcu7i7
	cpK7pQOEZcpmzc4ssa0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjpzD-00A0ST-2D;
	Fri, 22 Sep 2023 23:55:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjpzA-00A0Rn-2z
	for kexec@lists.infradead.org;
	Fri, 22 Sep 2023 23:55:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695426899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ug4xq4MmjF/eNTz6hVE4ZYshILz5hWhatCObvUptJOw=;
	b=JmC0TC2sFRz8j4LgDSEIGwgBvlgbxtUzJVjE+Bs5pGuy8pLcvpO5gW9DnLt6glIsX+arO+
	+wJ4u/6nvhN7JEm5tVb9XpDlwLEIJ1ghwUHx7jDMrm6NEtIfU0LcpQO5pjptjLBY/UgFoN
	EpSMR56tkqAS69Qstgi3huHZ7OYVtRw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-V8w9XqGvMqKEr0mKR8g8JQ-1; Fri, 22 Sep 2023 19:54:54 -0400
X-MC-Unique: V8w9XqGvMqKEr0mKR8g8JQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C57243C0E44D;
	Fri, 22 Sep 2023 23:54:53 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B295D51E3;
	Fri, 22 Sep 2023 23:54:49 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	eric.devolder@oracle.com,
	vschneid@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	sourabhjain@linux.ibm.com,
	konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH] Crash: add lock to serialize crash hotplug handling
Date: Sat, 23 Sep 2023 07:54:46 +0800
Message-ID: <20230922235446.260966-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_165501_077322_1393E101 
X-CRM114-Status: GOOD (  12.57  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Eric reported that handling corresponding crash hotplug event can be
failed easily when many momery hotplug event are notified in a short period.
They failed because failing to take __kexec_lock.

=======
[   78.714569] Fallback order for Node 0: 0
[   78.714575] Built 1 zonelists, mobility grouping on.  Total pages: 1817886
[   78.717133] Policy zone: Normal
[   78.724423] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
[   78.727207] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
[   80.056643] PEFILE: Unsigned PE binary
=======

The memory hotplug events are notified very quickly and very many,
while the handling of crash hotplug is much slower relatively. So the
atomic variable __kexec_lock and kexec_trylock() can't guarantee the
serialization of crash hotplug handling.

Here, add a new mutex lock __crash_hotplug_lock to serialize crash
hotplug handling specifically. This doesn't impact the usage of
__kexec_lock.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c     |  3 +++
 kernel/kexec_core.c     |  1 +
 kernel/kexec_internal.h | 11 +++++++++++
 3 files changed, 15 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 03a7932cde0a..e8851724a530 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -783,9 +783,11 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 {
 	struct kimage *image;
 
+	crash_hotplug_lock();
 	/* Obtain lock while changing crash information */
 	if (!kexec_trylock()) {
 		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		crash_hotplug_unlock();
 		return;
 	}
 
@@ -852,6 +854,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 out:
 	/* Release lock now that update complete */
 	kexec_unlock();
+	crash_hotplug_unlock();
 }
 
 static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 9dc728982d79..b95a73f35d9a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -48,6 +48,7 @@
 #include "kexec_internal.h"
 
 atomic_t __kexec_lock = ATOMIC_INIT(0);
+DEFINE_MUTEX(__crash_hotplug_lock);
 
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 74da1409cd14..1db31625ef20 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -28,6 +28,17 @@ static inline void kexec_unlock(void)
 	atomic_set_release(&__kexec_lock, 0);
 }
 
+/*
+ * Different than kexec/kdump loading/unloading/crash or kexec jumping/shrinking
+ * which usually rarely happen, there will be many crash hotplug events notified
+ * during one short period, e.g one memory board is hot added and memory regions
+ * are online. So mutex lock  __crash_hotplug_lock is used to serialize the crash
+ * hotplug handling specificially.
+ * */
+extern struct mutex __crash_hotplug_lock;
+#define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
+#define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
+
 #ifdef CONFIG_KEXEC_FILE
 #include <linux/purgatory.h>
 void kimage_file_post_load_cleanup(struct kimage *image);
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

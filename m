Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340A6CE7A91
	for <kexec@archiver.kernel.org>; Mon, 25 Sep 2023 03:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RM4vs6Nd5SI5CK0US2C4QIynjFPjnq6fZkzO8mqU13A=; b=QT7pY0K10Kkdz+
	qK2i9dz79zkurqX4nJBAFKuLk3Rw4C9HMYPkO/JlWJSO0nDiLzSyjJneJ2Q3VvZyPOjpIaQWVd9LK
	nMyE3gfJ/4rBtwhkW3kUb/pOUnz/2EoWFlQ1yT0HOnVjsHnDIppiTZ6aX4X9PGpwL4C9o9C76kd+N
	yyJbTOwUqK6JsQl7SS/AEbV6eBcFykgFzFglexJ/ecUlmzufGu+qyMycmBaktbPb4bjz2qmnpB9m5
	bHSdPrpNs3faU/t7tRq3Cj+OSQe3XvH0F7a1FFAVtPT9h9gOjPSbJmg1JtD0MQBNLMQHUH/4lp7+H
	seA1St67bmRY4cHkDjZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkbwL-00DDBg-2J;
	Mon, 25 Sep 2023 03:07:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkbwI-00DDAx-2r
	for kexec@lists.infradead.org;
	Mon, 25 Sep 2023 03:07:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695611233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LibzKZdeb1DOWmi/oEB5Gnb73A+4XGeHqkUmug2NkOM=;
	b=A7cTMStrailhu43oYkeiepvHiQmHd+VYUnvCOheFQ4gsKJN3WoAI3xkglLHmNpF9J5pV2x
	LWwEPZojhznv2nJ8eVuHpxmYccZtayn+TPBXIrOwd8MESMpyxT3Comumk1nYF0J8NHyTV3
	3znyNKaiXqb12Nk/qcEbRO1RxGD1pvI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-uZKBFWG_Pa2dv_Xgk2SIig-1; Sun, 24 Sep 2023 23:07:08 -0400
X-MC-Unique: uZKBFWG_Pa2dv_Xgk2SIig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C756C85A5A8;
	Mon, 25 Sep 2023 03:07:07 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 69B5B2026D68;
	Mon, 25 Sep 2023 03:07:04 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	akpm@linux-foundation.org,
	eric.devolder@oracle.com,
	vschneid@redhat.com,
	dyoung@redhat.com,
	sourabhjain@linux.ibm.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2] Crash: add lock to serialize crash hotplug handling
Date: Mon, 25 Sep 2023 11:07:01 +0800
Message-ID: <20230925030701.338672-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230924_200714_998600_FB626E1B 
X-CRM114-Status: GOOD (  12.33  )
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
failed easily when many memory hotplug event are notified in a short
period. They failed because failing to take __kexec_lock.

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
v1->v2:
 - Move mutex lock definition into CONFIG_CRASH_HOTPLUG ifdeffery
   scope in kernel/crash_core.c because the lock is only needed and
   used in that scope. Suggested by Eric.

 kernel/crash_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 03a7932cde0a..5951d6366b72 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -739,6 +739,17 @@ subsys_initcall(crash_notes_memory_init);
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
 
+/*
+ * Different than kexec/kdump loading/unloading/jumping/shrinking which
+ * usually rarely happen, there will be many crash hotplug events notified
+ * during one short period, e.g one memory board is hot added and memory
+ * regions are online. So mutex lock  __crash_hotplug_lock is used to
+ * serialize the crash hotplug handling specifically.
+ */
+DEFINE_MUTEX(__crash_hotplug_lock);
+#define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
+#define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
+
 /*
  * This routine utilized when the crash_hotplug sysfs node is read.
  * It reflects the kernel's ability/permission to update the crash
@@ -783,9 +794,11 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 {
 	struct kimage *image;
 
+	crash_hotplug_lock();
 	/* Obtain lock while changing crash information */
 	if (!kexec_trylock()) {
 		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		crash_hotplug_unlock();
 		return;
 	}
 
@@ -852,6 +865,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 out:
 	/* Release lock now that update complete */
 	kexec_unlock();
+	crash_hotplug_unlock();
 }
 
 static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

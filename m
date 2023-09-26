Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA03E7E62E
	for <kexec@archiver.kernel.org>; Tue, 26 Sep 2023 12:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cFqrd1QnX18KORy5ncYBt2Ijr1w11MswlHZ1WC1GnC8=; b=xYOcl3o4PAiYxE
	mfMMnsm9HTIriF12sbA6AkUIMwWhFhRn3MxjywXMYlbQbqJ+GUE2ZLg0sje7yW6yV2b1aTsk0sORW
	GJY27A4Rxtt9G8sbYyrzEF3GY5eyyHl5kUf+Uux6gRUfJRVaKGY67B3T/P553IzgBTqTUp47q/6xr
	FZb69KTXh64KMvWPMnBLWiUpB2FkXHOkKPvvKMjF04C8o7KR+l7xP/TxONBBilmfcKbRtSvB9bppm
	PuoukL0xmx3bYHkjIKeP7f8V5tX8h/JXtVDxMzrdag8oAVpSvLrloJjiITEWfz8nzM2voOysfNT8w
	b1gbYT5JGQGJNlQn8NMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ql6sV-00GKgE-1A;
	Tue, 26 Sep 2023 12:09:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ql6sR-00GKdf-1A
	for kexec@lists.infradead.org;
	Tue, 26 Sep 2023 12:09:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695730156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jimOcMvQCcdItEjwgV6HXjLHWStYRcQsZMjaE32LDyE=;
	b=H2ZFiN9n+2lQoNoY9m+OeSLJJcomCC5Ka2XiSf0bnd+M9PnpCf+1hbOTrp6V909PwQ9tFz
	OR+uinXiEDiBIWLB3xn+A8tNEHj180sGFVSt9aJnEpq9HOOt1RNhLR/YcTLXV0bz9YfpRq
	kVS/rdC2ZrBauuT4JfK7IipqKhCSbag=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-ilM1DyNsNf--dzhCtfc2KA-1; Tue, 26 Sep 2023 08:09:12 -0400
X-MC-Unique: ilM1DyNsNf--dzhCtfc2KA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52ACA1C0CCAD;
	Tue, 26 Sep 2023 12:09:12 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3EA09140E950;
	Tue, 26 Sep 2023 12:09:07 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	akpm@linux-foundation.org,
	eric.devolder@oracle.com,
	vschneid@redhat.com,
	sourabhjain@linux.ibm.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3] Crash: add lock to serialize crash hotplug handling
Date: Tue, 26 Sep 2023 20:09:05 +0800
Message-ID: <20230926120905.392903-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230926_050919_912728_338D0E6F 
X-CRM114-Status: GOOD (  13.69  )
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
v2->v3:
 - crash_check_update_elfcorehdr() need take __crash_hotplug_lock
   too because there's tiny racing window when kexec_load interface
   is taken. Eric pointed out this.
v1->v2:
 - Move mutex lock definition into CONFIG_CRASH_HOTPLUG ifdeffery
   scope in kernel/crash_core.c because the lock is only needed and
   used in that scope. Suggested by Eric.
 kernel/crash_core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 03a7932cde0a..2f675ef045d4 100644
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
@@ -748,9 +759,11 @@ int crash_check_update_elfcorehdr(void)
 {
 	int rc = 0;
 
+	crash_hotplug_lock();
 	/* Obtain lock while reading crash information */
 	if (!kexec_trylock()) {
 		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		crash_hotplug_unlock();
 		return 0;
 	}
 	if (kexec_crash_image) {
@@ -761,6 +774,7 @@ int crash_check_update_elfcorehdr(void)
 	}
 	/* Release lock now that update complete */
 	kexec_unlock();
+	crash_hotplug_unlock();
 
 	return rc;
 }
@@ -783,9 +797,11 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 {
 	struct kimage *image;
 
+	crash_hotplug_lock();
 	/* Obtain lock while changing crash information */
 	if (!kexec_trylock()) {
 		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		crash_hotplug_unlock();
 		return;
 	}
 
@@ -852,6 +868,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
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

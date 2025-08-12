Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2102DCA0EC4
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oEDfd5YwQwP//qNNRp60/4j9gVHcNuQdiFWm+KANNic=; b=tVOKtfT8zdU+HfxTnZAvF9KK9u
	QiBZOQoFPJ0opWIi45p2N96VL/uvbXSlyxx8VL5J0eZ6LLpr0fhv0who7Dq6YGnPN0wuQLweZ45cn
	mwZvBrYSH+IupE0VszWQ5p/xzz3lN2rA5Wsw76uX8dqzioAq3JWbMgnAm/xLUahyYjcGvR0boTg/6
	qC1QiVgRq63rujj8iJ98UaGPdFw56oPnPffAMKHE0+tFBFU8Xtjlnj+L5y6CpdFBlvPFm1sqShBQ+
	AqGHKTaVLRtt0RquJytmPy139gpTjKOYebgNEcy53JAJSTqj5RQGqS5YkpTicRORQ02tSDs/6H7Gq
	U4PkU9ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulrmG-0000000BNtM-0zks;
	Tue, 12 Aug 2025 16:23:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uloSC-0000000Apy4-0y71
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 12:50:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755003011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEDfd5YwQwP//qNNRp60/4j9gVHcNuQdiFWm+KANNic=;
	b=E9vgAKaM+6ZMWq20snS7HSJpGCcYYW44wEXtrKIwxtQdi3QH8H1KOwsotEpdsc0x19qHiE
	CQAmhf21bNW92mTMJ5ZXcM8G6QMosETRHohLMlLc92nbnKRVn34W8+viY76XcPj51VgDhL
	5qu2V2nkKXpicD5EsF1DJtrkpRXiel4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-pB9e8V-hNSCSigDe8LiZ2g-1; Tue,
 12 Aug 2025 08:50:10 -0400
X-MC-Unique: pB9e8V-hNSCSigDe8LiZ2g-1
X-Mimecast-MFC-AGG-ID: pB9e8V-hNSCSigDe8LiZ2g_1755003008
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8214119560B1;
	Tue, 12 Aug 2025 12:50:07 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E97330001A1;
	Tue, 12 Aug 2025 12:49:59 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	elver@google.com,
	snovitoll@gmail.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 02/12] mm/kasan: move kasan= code to common place
Date: Tue, 12 Aug 2025 20:49:31 +0800
Message-ID: <20250812124941.69508-3-bhe@redhat.com>
In-Reply-To: <20250812124941.69508-1-bhe@redhat.com>
References: <20250812124941.69508-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_055012_349728_A1708C28 
X-CRM114-Status: GOOD (  16.18  )
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

This allows generic and sw_tags to be set in kernel cmdline too.

When at it, rename 'kasan_arg' to 'kasan_arg_disabled' as a bool
variable. And expose 'kasan_flag_enabled' to kasan common place
too.

This is prepared for later adding kernel parameter kasan=on|off for
all kasan modes.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kasan-enabled.h |  4 +++-
 mm/kasan/common.c             | 25 +++++++++++++++++++++++++
 mm/kasan/hw_tags.c            | 35 ++---------------------------------
 3 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 6f612d69ea0c..32f2d19f599f 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,10 +4,12 @@
 
 #include <linux/static_key.h>
 
-#ifdef CONFIG_KASAN_HW_TAGS
+extern bool kasan_arg_disabled;
 
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
+#ifdef CONFIG_KASAN_HW_TAGS
+
 static __always_inline bool kasan_enabled(void)
 {
 	return static_branch_likely(&kasan_flag_enabled);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 9142964ab9c9..69a848f2a8aa 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -32,6 +32,31 @@
 #include "kasan.h"
 #include "../slab.h"
 
+/*
+ * Whether KASAN is enabled at all.
+ * The value remains false until KASAN is initialized.
+ */
+DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
+EXPORT_SYMBOL(kasan_flag_enabled);
+
+bool kasan_arg_disabled __ro_after_init;
+/* kasan=off/on */
+static int __init early_kasan_flag(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!strcmp(arg, "off"))
+		kasan_arg_disabled = true;
+	else if (!strcmp(arg, "on"))
+		kasan_arg_disabled = false;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("kasan", early_kasan_flag);
+
 struct slab *kasan_addr_to_slab(const void *addr)
 {
 	if (virt_addr_valid(addr))
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 9a6927394b54..377e9c285a74 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -22,12 +22,6 @@
 
 #include "kasan.h"
 
-enum kasan_arg {
-	KASAN_ARG_DEFAULT,
-	KASAN_ARG_OFF,
-	KASAN_ARG_ON,
-};
-
 enum kasan_arg_mode {
 	KASAN_ARG_MODE_DEFAULT,
 	KASAN_ARG_MODE_SYNC,
@@ -41,17 +35,9 @@ enum kasan_arg_vmalloc {
 	KASAN_ARG_VMALLOC_ON,
 };
 
-static enum kasan_arg kasan_arg __ro_after_init;
 static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
 
-/*
- * Whether KASAN is enabled at all.
- * The value remains false until KASAN is initialized by kasan_init_hw_tags().
- */
-DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
-EXPORT_SYMBOL(kasan_flag_enabled);
-
 /*
  * Whether the selected mode is synchronous, asynchronous, or asymmetric.
  * Defaults to KASAN_MODE_SYNC.
@@ -85,23 +71,6 @@ unsigned int kasan_page_alloc_sample_order = PAGE_ALLOC_SAMPLE_ORDER_DEFAULT;
 
 DEFINE_PER_CPU(long, kasan_page_alloc_skip);
 
-/* kasan=off/on */
-static int __init early_kasan_flag(char *arg)
-{
-	if (!arg)
-		return -EINVAL;
-
-	if (!strcmp(arg, "off"))
-		kasan_arg = KASAN_ARG_OFF;
-	else if (!strcmp(arg, "on"))
-		kasan_arg = KASAN_ARG_ON;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-early_param("kasan", early_kasan_flag);
-
 /* kasan.mode=sync/async/asymm */
 static int __init early_kasan_mode(char *arg)
 {
@@ -209,7 +178,7 @@ void kasan_init_hw_tags_cpu(void)
 	 * When this function is called, kasan_flag_enabled is not yet
 	 * set by kasan_init_hw_tags(). Thus, check kasan_arg instead.
 	 */
-	if (kasan_arg == KASAN_ARG_OFF)
+	if (kasan_arg_disabled)
 		return;
 
 	/*
@@ -227,7 +196,7 @@ void __init kasan_init_hw_tags(void)
 		return;
 
 	/* If KASAN is disabled via command line, don't initialize it. */
-	if (kasan_arg == KASAN_ARG_OFF)
+	if (kasan_arg_disabled)
 		return;
 
 	switch (kasan_arg_mode) {
-- 
2.41.0



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6517CD116F3
	for <kexec@archiver.kernel.org>; Fri, 28 Nov 2025 03:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UdCEhX0QnAccjf1ifoDBiGeeToccBUA00HLj78ygtME=; b=ZNpT7VXshXHaawzWaOwX62h7N8
	IeiwpOkM+8yt7nUhKVNoRdYRs6h5MI+FehXlcWuklF0PD7c1MXeYkVGbNjmnMLYlW8PwayScT2lrL
	01RZM1TAggICFBSsMKSQvc5zXviLSMh72zWYZ/t6uinb7jIxbcZ08ykCs+UA3wcf9s+E+/sEvm47c
	zdROpJEsriUZC4IZrNAOJeKDJbBJLv1nnI5D6YmtxBxUlERTUhyp51coGzHMdaFCmt/4J/aH9a9Ry
	hH5Fus/ii/dG+4K2jUrPu1S9N51qONpUhau3drYmVfqykV186eZW3+RhKEElFk7f5dwI5GKFs9Ut5
	aGfAOtYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOpF3-0000000HWWH-3qCh;
	Fri, 28 Nov 2025 03:33:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOpF1-0000000HWVi-1pfF
	for kexec@lists.infradead.org;
	Fri, 28 Nov 2025 03:33:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764300830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UdCEhX0QnAccjf1ifoDBiGeeToccBUA00HLj78ygtME=;
	b=b4nTnSmUp0lJHYX4pYsu0NXOw8LsunQ9l1McsaW4iSl+MCWhu80K+dIBOUTDbn9kzcD55V
	2J3/dI/akwJeQAeY9zt5/NGW0twecyBqIhGC46XoDZPhFR/YjG53xatgzp53q/cBWmWgDO
	RECg3Zbp/H8HYbYpIwdWckPnAyNq8JY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-UOimTxoJOkekNTmxQjBXig-1; Thu,
 27 Nov 2025 22:33:46 -0500
X-MC-Unique: UOimTxoJOkekNTmxQjBXig-1
X-Mimecast-MFC-AGG-ID: UOimTxoJOkekNTmxQjBXig_1764300824
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE5031956095;
	Fri, 28 Nov 2025 03:33:43 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 003BC19560B7;
	Fri, 28 Nov 2025 03:33:34 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	elver@google.com,
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	snovitoll@gmail.com,
	christophe.leroy@csgroup.eu,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 01/12] mm/kasan: add conditional checks in functions to return directly if kasan is disabled
Date: Fri, 28 Nov 2025 11:33:09 +0800
Message-ID: <20251128033320.1349620-2-bhe@redhat.com>
In-Reply-To: <20251128033320.1349620-1-bhe@redhat.com>
References: <20251128033320.1349620-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_193351_568022_844D8465 
X-CRM114-Status: GOOD (  16.69  )
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

The current codes only check if kasan is disabled for hw_tags
mode. Here add the conditional checks for functional functions of
generic mode and sw_tags mode.

This is prepared for later adding kernel parameter kasan=on|off for
all three kasan modes.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/kasan/generic.c    | 17 +++++++++++++++--
 mm/kasan/init.c       |  6 ++++++
 mm/kasan/quarantine.c |  3 +++
 mm/kasan/report.c     |  4 +++-
 mm/kasan/shadow.c     | 11 ++++++++++-
 mm/kasan/sw_tags.c    |  3 +++
 6 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 2b8e73f5f6a7..aff822aa2bd6 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -214,12 +214,13 @@ bool kasan_byte_accessible(const void *addr)
 
 void kasan_cache_shrink(struct kmem_cache *cache)
 {
-	kasan_quarantine_remove_cache(cache);
+	if (kasan_enabled())
+		kasan_quarantine_remove_cache(cache);
 }
 
 void kasan_cache_shutdown(struct kmem_cache *cache)
 {
-	if (!__kmem_cache_empty(cache))
+	if (kasan_enabled() && !__kmem_cache_empty(cache))
 		kasan_quarantine_remove_cache(cache);
 }
 
@@ -239,6 +240,9 @@ void __asan_register_globals(void *ptr, ssize_t size)
 	int i;
 	struct kasan_global *globals = ptr;
 
+	if (!kasan_enabled())
+		return;
+
 	for (i = 0; i < size; i++)
 		register_global(&globals[i]);
 }
@@ -369,6 +373,9 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	unsigned int rem_free_meta_size;
 	unsigned int orig_alloc_meta_offset;
 
+	if (!kasan_enabled())
+		return;
+
 	if (!kasan_requires_meta())
 		return;
 
@@ -518,6 +525,9 @@ size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
 {
 	struct kasan_cache *info = &cache->kasan_info;
 
+	if (!kasan_enabled())
+		return 0;
+
 	if (!kasan_requires_meta())
 		return 0;
 
@@ -543,6 +553,9 @@ void kasan_record_aux_stack(void *addr)
 	struct kasan_alloc_meta *alloc_meta;
 	void *object;
 
+	if (!kasan_enabled())
+		return;
+
 	if (is_kfence_address(addr) || !slab)
 		return;
 
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index f084e7a5df1e..c78d77ed47bc 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -447,6 +447,9 @@ void kasan_remove_zero_shadow(void *start, unsigned long size)
 	unsigned long addr, end, next;
 	pgd_t *pgd;
 
+	if (!kasan_enabled())
+		return;
+
 	addr = (unsigned long)kasan_mem_to_shadow(start);
 	end = addr + (size >> KASAN_SHADOW_SCALE_SHIFT);
 
@@ -482,6 +485,9 @@ int kasan_add_zero_shadow(void *start, unsigned long size)
 	int ret;
 	void *shadow_start, *shadow_end;
 
+	if (!kasan_enabled())
+		return 0;
+
 	shadow_start = kasan_mem_to_shadow(start);
 	shadow_end = shadow_start + (size >> KASAN_SHADOW_SCALE_SHIFT);
 
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 6958aa713c67..a6dc2c3d8a15 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -405,6 +405,9 @@ static int __init kasan_cpu_quarantine_init(void)
 {
 	int ret = 0;
 
+	if (!kasan_enabled())
+		return 0;
+
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mm/kasan:online",
 				kasan_cpu_online, kasan_cpu_offline);
 	if (ret < 0)
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 62c01b4527eb..884357fa74ed 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -576,7 +576,9 @@ bool kasan_report(const void *addr, size_t size, bool is_write,
 	unsigned long irq_flags;
 	struct kasan_report_info info;
 
-	if (unlikely(report_suppressed_sw()) || unlikely(!report_enabled())) {
+	if (unlikely(report_suppressed_sw()) ||
+	    unlikely(!report_enabled()) ||
+	    !kasan_enabled()) {
 		ret = false;
 		goto out;
 	}
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 29a751a8a08d..f73a691421de 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -164,6 +164,8 @@ void kasan_unpoison(const void *addr, size_t size, bool init)
 {
 	u8 tag = get_tag(addr);
 
+	if (!kasan_enabled())
+		return;
 	/*
 	 * Perform shadow offset calculation based on untagged address, as
 	 * some of the callers (e.g. kasan_unpoison_new_object) pass tagged
@@ -277,7 +279,8 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
 
 static int __init kasan_memhotplug_init(void)
 {
-	hotplug_memory_notifier(kasan_mem_notifier, DEFAULT_CALLBACK_PRI);
+	if (kasan_enabled())
+		hotplug_memory_notifier(kasan_mem_notifier, DEFAULT_CALLBACK_PRI);
 
 	return 0;
 }
@@ -658,6 +661,9 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
 	size_t shadow_size;
 	unsigned long shadow_start;
 
+	if (!kasan_enabled())
+		return 0;
+
 	shadow_start = (unsigned long)kasan_mem_to_shadow(addr);
 	scaled_size = (size + KASAN_GRANULE_SIZE - 1) >>
 				KASAN_SHADOW_SCALE_SHIFT;
@@ -694,6 +700,9 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
 
 void kasan_free_module_shadow(const struct vm_struct *vm)
 {
+	if (!kasan_enabled())
+		return;
+
 	if (IS_ENABLED(CONFIG_UML))
 		return;
 
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index c75741a74602..6c1caec4261a 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -79,6 +79,9 @@ bool kasan_check_range(const void *addr, size_t size, bool write,
 	u8 *shadow_first, *shadow_last, *shadow;
 	void *untagged_addr;
 
+	if (!kasan_enabled())
+		return true;
+
 	if (unlikely(size == 0))
 		return true;
 
-- 
2.41.0



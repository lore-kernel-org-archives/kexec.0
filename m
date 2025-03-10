Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF423C28B30
	for <kexec@archiver.kernel.org>; Mon, 10 Mar 2025 12:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9sCYhPB2JXvpHRR7mGAnOD5wFhzVOzlRXeW9jewkrPs=; b=Q4NbtPqCpVIteeJsRyAgmxiNG0
	NqFL86QG77hM3zC5VQ1pxLlTZpBBc0W4Tyj390yRiz9+oJNpDrdGCYJnG8cgMvBuAD4+6UMF48Neb
	ogIYZmmAqMk1hkmtTQEwEH6AEt7upeTPCDXhbwk8dvAyp0+1RHgPfPgW8KyUOiWGeH513CI7Qjxjs
	T9kA9ACrwdFPd+4dbchOTvIkawVxBO35DDWJd2JVvVdNwdAGM+FmnGRuChSohZ7myEFxtuaUa/kJ5
	cEeGeaFAKVt390/p0yRx/voD5tCPDr1+ZZu1LF5rp5XoR5hn4OvB0skZ5tJYyrzRwiXQ9RMDXB5Nz
	KRWzx4KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trc42-00000002ZRk-2Jgf;
	Mon, 10 Mar 2025 12:16:58 +0000
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trbri-00000002WHQ-14r2
	for kexec@lists.infradead.org;
	Mon, 10 Mar 2025 12:04:15 +0000
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D8CAE60EAF;
	Mon, 10 Mar 2025 15:04:12 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id s3o0lL2FT0U0-nBaQjWYT;
	Mon, 10 Mar 2025 15:04:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1741608252;
	bh=9sCYhPB2JXvpHRR7mGAnOD5wFhzVOzlRXeW9jewkrPs=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=tKVDYRr1Fc9PZMG5kcffLo5ML52XYvjB9fT2RP6/B4ZrI68qC5XErlG3jfkkQS0xQ
	 LrPykZVjqAxqEQcIvjW8Q1fYRGUY3Nxe3UrpdFO1uG7CnyBvoqCzCxivetoS5oBrG4
	 Z3/CxdprsbnC7nsU6PIIrdFT3yANX6Z3kGq3BFqU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v2 5/7] x86, kstate: Add the ability to preserve memory pages across kexec.
Date: Mon, 10 Mar 2025 13:03:16 +0100
Message-ID: <20250310120318.2124-6-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250310120318.2124-1-arbn@yandex-team.com>
References: <20250310120318.2124-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_050414_465129_BDA6C04E 
X-CRM114-Status: GOOD (  19.49  )
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

This adds ability to specify page of memory that kstate needs to
preserve across kexec.

kstate_register_page() stores struct page in the special list of
'struct kpage_state's. At kexec reboot stage this list iterated, pfns
saved into kstate's data stream. The new kernel after kexec reads
pfns from the stream and marks memory as reserved to keep it
intact.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 include/linux/kstate.h |  30 ++++++++++
 kernel/kexec_core.c    |   3 +-
 kernel/kstate.c        | 124 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/include/linux/kstate.h b/include/linux/kstate.h
index ae583d090111..36cfefd87572 100644
--- a/include/linux/kstate.h
+++ b/include/linux/kstate.h
@@ -88,6 +88,8 @@ struct kstate_field {
 };
 
 enum kstate_ids {
+	KSTATE_RSVD_MEM_ID = 1,
+	KSTATE_STRUCT_PAGE_ID,
 	KSTATE_LAST_ID = -1,
 };
 
@@ -124,6 +126,8 @@ static inline unsigned long kstate_get_ulong(struct kstate_stream *stream)
         return ret;
 }
 
+extern struct kstate_description page_state;
+
 #ifdef CONFIG_KSTATE
 
 void kstate_init(void);
@@ -141,6 +145,12 @@ void restore_kstate(struct kstate_stream *stream, int id,
 		const struct kstate_description *kstate, void *obj);
 int kstate_load_migrate_buf(struct kimage *image);
 
+int kstate_page_save(struct kstate_stream *stream, void *obj,
+		const struct kstate_field *field);
+int kstate_register_page(struct page *page, int order);
+
+bool kstate_range_is_preserved(unsigned long start, unsigned long end);
+
 #else
 
 static inline void kstate_init(void) { }
@@ -150,6 +160,11 @@ static inline int kstate_save_state(void) { return 0; }
 static inline void free_kstate_stream(void) { }
 
 static inline int kstate_load_migrate_buf(struct kimage *image) { return 0; }
+
+static inline bool kstate_range_is_preserved(unsigned long start,
+					unsigned long end)
+{ return 0; }
+
 #endif
 
 
@@ -176,6 +191,21 @@ static inline int kstate_load_migrate_buf(struct kimage *image) { return 0; }
 		.offset = offsetof(_state, _f),		\
 	}
 
+#define KSTATE_PAGE(_f, _state)				\
+	{						\
+		.name = "page",				\
+		.flags = KS_CUSTOM,			\
+		.offset = offsetof(_state, _f),		\
+		.save = kstate_page_save,		\
+	},						\
+	KSTATE_ADDRESS(_f, _state, KS_VMEMMAP_ADDR),	\
+	{ 						\
+		.name = "struct_page",			\
+		.flags = KS_STRUCT | KS_POINTER,	\
+		.offset = offsetof(_state, _f),		\
+		.ksd = &page_state,			\
+	}
+
 #define KSTATE_END_OF_LIST() {	\
 		.flags = KS_END,\
 	}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 7c79addeb93b..5d001b7a9e44 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/kexec.h>
+#include <linux/kstate.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
@@ -261,7 +262,7 @@ int kimage_is_destination_range(struct kimage *image,
 			return 1;
 	}
 
-	return 0;
+	return kstate_range_is_preserved(start, end);
 }
 
 int kimage_is_control_page(struct kimage *image,
diff --git a/kernel/kstate.c b/kernel/kstate.c
index d35996287b76..68a1272abceb 100644
--- a/kernel/kstate.c
+++ b/kernel/kstate.c
@@ -309,6 +309,13 @@ int kstate_register(struct kstate_description *state, void *obj)
 	return 0;
 }
 
+int kstate_page_save(struct kstate_stream *stream, void *obj,
+		const struct kstate_field *field)
+{
+	kstate_register_page(*(struct page **)obj, 0);
+	return 0;
+}
+
 static int __init setup_kstate(char *arg)
 {
 	char *end;
@@ -323,7 +330,124 @@ static int __init setup_kstate(char *arg)
 }
 early_param("kstate_stream", setup_kstate);
 
+/*
+ * TODO: probably should use folio instead/in addition,
+ * also will need to think/decide what fields
+ * to preserve or not
+ */
+struct kstate_description page_state = {
+	.name = "struct_page",
+	.id = KSTATE_STRUCT_PAGE_ID,
+	.state_list = LIST_HEAD_INIT(page_state.state_list),
+	.fields = (const struct kstate_field[]) {
+		KSTATE_BASE_TYPE(_mapcount, struct page, atomic_t),
+		KSTATE_BASE_TYPE(_refcount, struct page, atomic_t),
+		KSTATE_END_OF_LIST()
+	},
+};
+
+struct state_entry preserved_se;
+
+struct preserved_pages {
+	unsigned int nr_pages;
+	struct list_head list;
+};
+struct kpage_state {
+	struct list_head list;
+	u8 order;
+	struct page *page;
+};
+
+struct preserved_pages preserved_pages = {
+	.list = LIST_HEAD_INIT(preserved_pages.list)
+};
+
+int kstate_register_page(struct page *page, int order)
+{
+	struct kpage_state *state;
+
+	state = kmalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	state->page = page;
+	state->order = order;
+	list_add(&state->list, &preserved_pages.list);
+	preserved_pages.nr_pages++;
+	return 0;
+}
+
+static int kstate_pages_save(struct kstate_stream *stream, void *obj,
+			const struct kstate_field *field)
+{
+	struct kpage_state *p_state;
+	int ret;
+
+	list_for_each_entry(p_state, &preserved_pages.list, list) {
+		unsigned long paddr = page_to_phys(p_state->page);
+
+		ret = kstate_save_data(stream, &p_state->order,
+				sizeof(p_state->order));
+		if (ret)
+			return ret;
+		ret = kstate_save_data(stream, &paddr, sizeof(paddr));
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+bool kstate_range_is_preserved(unsigned long start, unsigned long end)
+{
+	struct kpage_state *p_state;
+
+	list_for_each_entry(p_state, &preserved_pages.list, list) {
+		unsigned long pstart, pend;
+		pstart = page_to_boot_pfn(p_state->page);
+		pend = pstart + (p_state->order << PAGE_SHIFT) - 1;
+		if ((end >= pstart) && (start <= pend))
+			return 1;
+	}
+	return 0;
+}
+
+static int __init kstate_pages_restore(struct kstate_stream *stream, void *obj,
+			const struct kstate_field *field)
+{
+	struct preserved_pages *preserved_pages = obj;
+	int nr_pages, i;
+
+	nr_pages = preserved_pages->nr_pages;
+	for (i = 0; i < nr_pages; i++) {
+		int order = kstate_get_byte(stream);
+		unsigned long phys = kstate_get_ulong(stream);
+
+		memblock_reserve(phys, PAGE_SIZE << order);
+	}
+	return 0;
+}
+
+struct kstate_description kstate_preserved_mem = {
+	.name = "preserved_range",
+	.id = KSTATE_RSVD_MEM_ID,
+	.state_list = LIST_HEAD_INIT(kstate_preserved_mem.state_list),
+	.fields = (const struct kstate_field[]) {
+		KSTATE_BASE_TYPE(nr_pages, struct preserved_pages, unsigned int),
+		{
+			.name = "pages",
+			.flags = KS_CUSTOM,
+			.size = sizeof(struct preserved_pages),
+			.save = kstate_pages_save,
+			.restore = kstate_pages_restore,
+		},
+
+		KSTATE_END_OF_LIST()
+	},
+};
+
 void __init kstate_init(void)
 {
 	memblock_reserve(kstate_stream_addr, kstate_size);
+	__kstate_register(&kstate_preserved_mem, &preserved_pages,
+			&preserved_se);
 }
-- 
2.45.3



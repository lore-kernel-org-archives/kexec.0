Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741BDFEC119
	for <kexec@archiver.kernel.org>; Tue, 24 Mar 2026 21:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YxRFc7uh7OYBC1FI+3Cfq5eHLRVPi8Gp+Wbi4PZaBWc=; b=1DCZ9dzbuydORtIchPwZKvHOha
	gPlRFUOkfBBf6w+taGvjn5mTM3zAnGkOlNjxt6V4a7J+hn6zCnH3XKPXFmgd6x8de8TNqEAukZA8H
	HIQMzLq8Vvjazu8qI9Zi2r5b29ms4s1XHPRAzAd9hGfA+z59/aj2YDX0sfFo0Gm5RyXkoVIhwsJ59
	qBOFF5ot7j34Vhoc4iHreeCvJNuV1IFZRFsl8MVLQ1O5cVd3qovF8BhCUwvyF8+KihIZN6dIT3RXe
	a5jjYOqw3AWbgtAGd8qZtLN5TnAh2ule7PeGDFw14d3sYFTnRsVu4/SeA2OR8P5ldFsS6d1g3WMvF
	/0ZKvdxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w59ZT-00000002GmX-2Lc8;
	Tue, 24 Mar 2026 21:45:55 +0000
Received: from hillsboro-edge.smtp.mymangomail.com ([5.78.130.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w59ZP-00000002Gm8-44tU
	for kexec@lists.infradead.org;
	Tue, 24 Mar 2026 21:45:53 +0000
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by las-vegas.smtp.mymangomail.com (Mango Mail) with ESMTP id 7356A4194B;
	Tue, 24 Mar 2026 17:45:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774388744;
	bh=lWHZ27jpaeNf1LgsrlADwKO4VSTm1w5BLNpfZfNmdTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PUkK1ws2AkwDWdXHbCNNTXLg/0pJqhRAkDImMzJj4mIUWdPdwnAc9jrborlVe7KJ0
	 rHJoB9gnBz9ZpVeG1MhUcLV/D9eDj+wwb6JrcWscaEkIJ82PjgZwWcF726U0eSYUd5
	 dqAQuU7sybEOYe2YVN8mLnhItpcWKaX0/nVeFq90=
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
	by las-vegas.smtp.mymangomail.com (Mango Mail) with ESMTPSA id 013E741694;
	Tue, 24 Mar 2026 17:44:02 -0400 (EDT)
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
Subject: [PATCH v4 5/5] liveupdate: harden FLB lifetime and remaining teardown
 paths
Date: Tue, 24 Mar 2026 22:39:09 +0100
Message-ID: <20260324213909.75643-3-oskar@gerlicz.space>
In-Reply-To: <20260324213909.75643-2-oskar@gerlicz.space>
References: <20260324212730.65290-3-oskar@gerlicz.space>
 <20260324213909.75643-1-oskar@gerlicz.space>
 <20260324213909.75643-2-oskar@gerlicz.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_144552_108762_73A8A6D5 
X-CRM114-Status: GOOD (  26.48  )
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

The earlier cleanup patches fix the primary deserialize rollback paths, but
some teardown and lifetime edges are still open.

Incoming FLB objects can still race with finish(), copied incoming FLB
metadata can be torn down while another thread scans it, and the remaining
raw serialized file cleanup still needs a bounded, handler-aware abort path.
The quiesce path also has to reject the /dev/liveupdate open window, not
just non-empty session lists.

Tighten the remaining teardown paths by:

- making incoming FLB access hold the incoming lock until the caller drops
  it
- discarding copied incoming FLB metadata once the last incoming session is
  gone or rollback aborts it
- adding bounded raw serialized file cleanup and a known-format memfd abort
  helper
- teaching KHO about the size of a restorable block so cleanup and retrieve
  paths can validate preserved extents before walking them
- rejecting handler registration changes while /dev/liveupdate is busy

This leaves the series on the simpler rebooting + mutex + refcount model,
while closing the remaining lifetime and cleanup holes around incoming
teardown.

Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
---
 include/linux/kexec_handover.h     |   8 ++
 include/linux/liveupdate.h         |   9 +-
 kernel/kexec_core.c                |   2 +-
 kernel/liveupdate/kexec_handover.c |  15 ++-
 kernel/liveupdate/luo_core.c       |   5 +
 kernel/liveupdate/luo_file.c       | 156 ++++++++++++++++++++++++++---
 kernel/liveupdate/luo_flb.c        |  87 +++++++++++-----
 kernel/liveupdate/luo_internal.h   |   3 +
 kernel/liveupdate/luo_session.c    | 127 ++++++++++++++++++-----
 lib/tests/liveupdate.c             |   2 +
 mm/memfd_luo.c                     | 128 ++++++++++++++++-------
 11 files changed, 437 insertions(+), 105 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index af8284a440bf..1ceca20a4dc4 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -2,6 +2,7 @@
 #ifndef LINUX_KEXEC_HANDOVER_H
 #define LINUX_KEXEC_HANDOVER_H
 
+#include <linux/bug.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/types.h>
@@ -30,6 +31,7 @@ void *kho_alloc_preserve(size_t size);
 void kho_unpreserve_free(void *mem);
 void kho_restore_free(void *mem);
 bool kho_is_restorable_phys(phys_addr_t phys);
+size_t kho_restorable_size(phys_addr_t phys);
 struct folio *kho_restore_folio(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
@@ -85,6 +87,12 @@ static inline bool kho_is_restorable_phys(phys_addr_t phys)
 {
 	return false;
 }
+static inline size_t kho_restorable_size(phys_addr_t phys)
+{
+	if (phys)
+		WARN_ON_ONCE(!IS_ENABLED(CONFIG_KEXEC_HANDOVER));
+	return 0;
+}
 
 static inline struct folio *kho_restore_folio(phys_addr_t phys)
 {
diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 611907f57127..b278f7efc3c4 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -239,7 +239,10 @@ int liveupdate_register_flb(struct liveupdate_file_handler *fh,
 int liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
 			      struct liveupdate_flb *flb);
 
-int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp);
+int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp)
+	__acquires(&ACCESS_PRIVATE(flb, private).incoming.lock);
+void liveupdate_flb_put_incoming(struct liveupdate_flb *flb)
+	__releases(&ACCESS_PRIVATE(flb, private).incoming.lock);
 int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp);
 
 #else /* CONFIG_LIVEUPDATE */
@@ -286,6 +289,10 @@ static inline int liveupdate_flb_get_incoming(struct liveupdate_flb *flb,
 	return -EOPNOTSUPP;
 }
 
+static inline void liveupdate_flb_put_incoming(struct liveupdate_flb *flb)
+{
+}
+
 static inline int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb,
 					      void **objp)
 {
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 95710a7d5e56..2276ef1f8f7a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1232,7 +1232,7 @@ int kernel_kexec(void)
 	}
 #endif
 
-Unlock:
+ Unlock:
 	if (liveupdate_prepared)
 		liveupdate_reboot_abort();
 	kexec_unlock();
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 215b27f5f85f..105a4816320d 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -291,16 +291,25 @@ struct folio *kho_restore_folio(phys_addr_t phys)
 }
 EXPORT_SYMBOL_GPL(kho_restore_folio);
 
-bool kho_is_restorable_phys(phys_addr_t phys)
+size_t kho_restorable_size(phys_addr_t phys)
 {
 	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
 	union kho_page_info info;
 
 	if (!page || !PAGE_ALIGNED(phys))
-		return false;
+		return 0;
 
 	info.page_private = READ_ONCE(page->private);
-	return info.magic == KHO_PAGE_MAGIC && info.order <= MAX_PAGE_ORDER;
+	if (info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER)
+		return 0;
+
+	return PAGE_SIZE << info.order;
+}
+EXPORT_SYMBOL_GPL(kho_restorable_size);
+
+bool kho_is_restorable_phys(phys_addr_t phys)
+{
+	return kho_restorable_size(phys) != 0;
 }
 EXPORT_SYMBOL_GPL(kho_is_restorable_phys);
 
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 95a0b81ce60d..f4a045687fe8 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -451,6 +451,11 @@ static struct luo_device_state luo_dev = {
 	.in_use = ATOMIC_INIT(0),
 };
 
+bool luo_device_busy(void)
+{
+	return atomic_read(&luo_dev.in_use);
+}
+
 static int __init liveupdate_ioctl_init(void)
 {
 	if (!liveupdate_enabled())
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 3eb9aeee6524..83b263590541 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -112,6 +112,17 @@
 #include <linux/string.h>
 #include "luo_internal.h"
 
+#if IS_ENABLED(CONFIG_LIVEUPDATE_MEMFD)
+extern bool luo_file_abort_known_serialized(const char *compatible,
+					    u64 serialized_data);
+#else
+static inline bool luo_file_abort_known_serialized(const char *compatible,
+						   u64 serialized_data)
+{
+	return false;
+}
+#endif
+
 static LIST_HEAD(luo_file_handler_list);
 
 /* 2 4K pages, give space for 128 files per file_set */
@@ -170,6 +181,19 @@ struct luo_file {
 	u64 token;
 };
 
+static struct liveupdate_file_handler *
+luo_file_find_handler(const char *compatible)
+{
+	struct liveupdate_file_handler *fh;
+
+	list_private_for_each_entry(fh, &luo_file_handler_list, list) {
+		if (!strcmp(fh->compatible, compatible))
+			return fh;
+	}
+
+	return NULL;
+}
+
 static int luo_alloc_files_mem(struct luo_file_set *file_set)
 {
 	size_t size;
@@ -660,6 +684,60 @@ static void luo_file_abort_one(struct luo_file *luo_file)
 	args.retrieve_status = luo_file->retrieve_status;
 
 	luo_file->fh->ops->abort(&args);
+	luo_flb_file_finish(luo_file->fh);
+}
+
+static void luo_file_abort_serialized_one(struct liveupdate_file_handler *fh,
+					  const struct luo_file_ser *file_ser)
+{
+	struct liveupdate_file_op_args args = {0};
+
+	args.handler = fh;
+	args.serialized_data = file_ser->data;
+	fh->ops->abort(&args);
+	luo_flb_file_finish(fh);
+}
+
+static void luo_file_abort_unhandled_serialized(const struct luo_file_ser *file_ser)
+{
+	/*
+	 * serialized_data is opaque outside the owning handler. Only use a
+	 * handler-specific fallback when the serialized entry still carries a
+	 * known type tag.
+	 */
+	if (luo_file_abort_known_serialized(file_ser->compatible,
+					    file_ser->data))
+		return;
+
+	pr_warn("Leaving serialized file payload for unhandled type '%s'\n",
+		file_ser->compatible);
+}
+
+static void luo_file_abort_serialized_range(struct luo_file_ser *file_ser,
+					    u64 start, u64 count)
+{
+	u64 i;
+
+	for (i = start; i < count; i++) {
+		struct liveupdate_file_handler *fh;
+
+		if (strnlen(file_ser[i].compatible,
+			    sizeof(file_ser[i].compatible)) ==
+		    sizeof(file_ser[i].compatible)) {
+			pr_warn("Skipping unterminated serialized file handler name during abort\n");
+			continue;
+		}
+
+		fh = luo_file_find_handler(file_ser[i].compatible);
+		if (!fh) {
+			pr_warn("Skipping serialized file with missing handler '%s' during abort\n",
+				file_ser[i].compatible);
+			luo_file_abort_unhandled_serialized(&file_ser[i]);
+			continue;
+		}
+
+		luo_file_abort_serialized_one(fh, &file_ser[i]);
+	}
 }
 
 /**
@@ -753,6 +831,46 @@ void luo_file_abort_deserialized(struct luo_file_set *file_set)
 	file_set->files = NULL;
 }
 
+void luo_file_abort_serialized(const struct luo_file_set_ser *file_set_ser)
+{
+	struct luo_file_ser *file_ser;
+	size_t bytes;
+	u64 count;
+
+	if (!file_set_ser->count) {
+		if (file_set_ser->files)
+			pr_warn("Ignoring serialized file pointer in empty file set\n");
+		/*
+		 * The pointer is malformed relative to count, so ownership is
+		 * unclear here. Leave it untouched rather than risk freeing a
+		 * block which is still owned elsewhere.
+		 */
+		return;
+	}
+
+	if (!file_set_ser->files || !kho_is_restorable_phys(file_set_ser->files)) {
+		pr_warn("Skipping invalid serialized file set pointer during abort\n");
+		return;
+	}
+
+	bytes = kho_restorable_size(file_set_ser->files);
+	file_ser = phys_to_virt(file_set_ser->files);
+	if (bytes < sizeof(*file_ser)) {
+		pr_warn("Serialized file set block is too small for cleanup\n");
+		kho_restore_free(file_ser);
+		return;
+	}
+
+	count = min_t(u64, file_set_ser->count, LUO_FILE_MAX);
+	count = min_t(u64, count, bytes / sizeof(*file_ser));
+	if (count != file_set_ser->count)
+		pr_warn("Clamping serialized file abort from %llu to %llu entries\n",
+			file_set_ser->count, count);
+
+	luo_file_abort_serialized_range(file_ser, 0, count);
+	kho_restore_free(file_ser);
+}
+
 /**
  * luo_file_deserialize - Reconstructs the list of preserved files in the new kernel.
  * @file_set:     The incoming file_set to fill with deserialized data.
@@ -782,6 +900,8 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 			 struct luo_file_set_ser *file_set_ser)
 {
 	struct luo_file_ser *file_ser;
+	size_t bytes;
+	u64 count;
 	u64 i;
 	int err;
 
@@ -797,13 +917,22 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 	if (!kho_is_restorable_phys(file_set_ser->files))
 		return -EINVAL;
 
-	file_set->count = file_set_ser->count;
+	bytes = kho_restorable_size(file_set_ser->files);
+	if (file_set_ser->count > bytes / sizeof(*file_ser))
+		return -EINVAL;
+
+	count = file_set_ser->count;
+	file_set->count = 0;
+	/*
+	 * file_set owns the top-level serialized array from this point on. The
+	 * success path frees it via luo_file_finish(), and any deserialize
+	 * failure frees it via luo_file_abort_deserialized().
+	 */
 	file_set->files = phys_to_virt(file_set_ser->files);
 
 	file_ser = file_set->files;
-	for (i = 0; i < file_set->count; i++) {
+	for (i = 0; i < count; i++) {
 		struct liveupdate_file_handler *fh;
-		bool handler_found = false;
 		struct luo_file *luo_file;
 
 		if (strnlen(file_ser[i].compatible,
@@ -813,14 +942,8 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 			goto err_discard;
 		}
 
-		list_private_for_each_entry(fh, &luo_file_handler_list, list) {
-			if (!strcmp(fh->compatible, file_ser[i].compatible)) {
-				handler_found = true;
-				break;
-			}
-		}
-
-		if (!handler_found) {
+		fh = luo_file_find_handler(file_ser[i].compatible);
+		if (!fh) {
 			pr_warn("No registered handler for compatible '%s'\n",
 				file_ser[i].compatible);
 			err = -ENOENT;
@@ -839,11 +962,20 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 		luo_file->token = file_ser[i].token;
 		mutex_init(&luo_file->mutex);
 		list_add_tail(&luo_file->list, &file_set->files_list);
+		file_set->count++;
 	}
 
 	return 0;
-
 err_discard:
+	/*
+	 * Entries already materialized into file_set are owned by the
+	 * deserialized objects. Abort only the raw tail here and then let
+	 * deserialized cleanup drop the constructed prefix and free the
+	 * top-level serialized array owned by file_set.
+	 */
+	luo_file_abort_serialized_range(file_ser, file_set->count, count);
+	file_set_ser->files = 0;
+	file_set_ser->count = 0;
 	luo_file_abort_deserialized(file_set);
 	return err;
 }
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index cdd293408138..b3b6344b1680 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -128,6 +128,9 @@ static void luo_flb_file_unpreserve_one(struct liveupdate_flb *flb)
 	struct luo_flb_private *private = luo_flb_get_private(flb);
 
 	scoped_guard(mutex, &private->outgoing.lock) {
+		if (WARN_ON_ONCE(!private->outgoing.count))
+			return;
+
 		private->outgoing.count--;
 		if (!private->outgoing.count) {
 			struct liveupdate_flb_op_args args = {0};
@@ -191,7 +194,7 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 		return err;
 
 	private->incoming.obj = args.obj;
-	private->incoming.retrieved = true;
+	WRITE_ONCE(private->incoming.retrieved, true);
 
 	return 0;
 }
@@ -199,30 +202,38 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 static void luo_flb_file_finish_one(struct liveupdate_flb *flb)
 {
 	struct luo_flb_private *private = luo_flb_get_private(flb);
-	u64 count;
-
-	scoped_guard(mutex, &private->incoming.lock)
-		count = --private->incoming.count;
-
-	if (!count) {
+	for (;;) {
 		struct liveupdate_flb_op_args args = {0};
+		bool need_retrieve = false;
+		u64 count;
 
-		if (!private->incoming.retrieved) {
-			int err = luo_flb_retrieve_one(flb);
-
-			if (WARN_ON(err))
+		scoped_guard(mutex, &private->incoming.lock) {
+			if (READ_ONCE(private->incoming.finished))
 				return;
+
+			if (!private->incoming.count) {
+				need_retrieve = !READ_ONCE(private->incoming.retrieved);
+				count = 1;
+			} else {
+				count = --private->incoming.count;
+				if (!count) {
+					args.flb = flb;
+					args.obj = private->incoming.obj;
+					flb->ops->finish(&args);
+
+					private->incoming.data = 0;
+					private->incoming.obj = NULL;
+					WRITE_ONCE(private->incoming.retrieved, false);
+					WRITE_ONCE(private->incoming.finished, true);
+				}
+			}
 		}
 
-		scoped_guard(mutex, &private->incoming.lock) {
-			args.flb = flb;
-			args.obj = private->incoming.obj;
-			flb->ops->finish(&args);
+		if (!need_retrieve)
+			return;
 
-			private->incoming.data = 0;
-			private->incoming.obj = NULL;
-			private->incoming.finished = true;
-		}
+		if (WARN_ON(luo_flb_retrieve_one(flb)))
+			return;
 	}
 }
 
@@ -303,6 +314,16 @@ void luo_flb_file_finish(struct liveupdate_file_handler *fh)
 		luo_flb_file_finish_one(iter->flb);
 }
 
+void luo_flb_discard_incoming(void)
+{
+	struct luo_flb_header *fh = &luo_flb_global.incoming;
+
+	kfree(fh->header_ser);
+	fh->header_ser = NULL;
+	fh->ser = NULL;
+	fh->active = false;
+}
+
 /**
  * liveupdate_register_flb - Associate an FLB with a file handler and register it globally.
  * @fh:   The file handler that will now depend on the FLB.
@@ -502,25 +523,38 @@ int liveupdate_unregister_flb(struct liveupdate_file_handler *fh,
  * data, and -EOPNOTSUPP when live update is disabled or not configured.
  */
 int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp)
+	__acquires(&ACCESS_PRIVATE(flb, private).incoming.lock)
 {
 	struct luo_flb_private *private = luo_flb_get_private(flb);
 
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
+	if (!private->incoming.obj) {
+		mutex_unlock(&private->incoming.lock);
+		return -ENODATA;
+	}
 	*objp = private->incoming.obj;
 
 	return 0;
 }
 
+void liveupdate_flb_put_incoming(struct liveupdate_flb *flb)
+	__releases(&ACCESS_PRIVATE(flb, private).incoming.lock)
+{
+	struct luo_flb_private *private = luo_flb_get_private(flb);
+
+	mutex_unlock(&private->incoming.lock);
+}
+
 /**
  * liveupdate_flb_get_outgoing - Retrieve the outgoing FLB object.
  * @flb:  The FLB definition.
@@ -631,10 +665,17 @@ int __init luo_flb_setup_incoming(void *fdt_in)
 		return -EINVAL;
 	}
 
+	if (kho_restorable_size(header_ser_pa) < sizeof(*header_ser) ||
+	    sizeof(*header_ser) +
+	    header_ser->count * sizeof(*luo_flb_global.incoming.ser) >
+	    kho_restorable_size(header_ser_pa)) {
+		kho_restore_free(header_ser);
+		return -EINVAL;
+	}
+
 	header_copy = kmemdup(header_ser,
 			      sizeof(*header_copy) +
-			      header_ser->count *
-			      sizeof(*luo_flb_global.incoming.ser),
+			      header_ser->count * sizeof(*luo_flb_global.incoming.ser),
 			      GFP_KERNEL);
 	kho_restore_free(header_ser);
 	if (!header_copy)
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 94ca236cde21..f95b23b5bfdd 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -91,6 +91,7 @@ void luo_session_abort_reboot(void);
 int luo_session_deserialize(void);
 bool luo_session_quiesce(void);
 void luo_session_resume(void);
+bool luo_device_busy(void);
 
 int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
 void luo_file_unpreserve_files(struct luo_file_set *file_set);
@@ -102,6 +103,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 		      struct file **filep);
 int luo_file_finish(struct luo_file_set *file_set);
 void luo_file_abort_deserialized(struct luo_file_set *file_set);
+void luo_file_abort_serialized(const struct luo_file_set_ser *file_set_ser);
 int luo_file_deserialize(struct luo_file_set *file_set,
 			 struct luo_file_set_ser *file_set_ser);
 void luo_file_set_init(struct luo_file_set *file_set);
@@ -112,6 +114,7 @@ void luo_flb_file_unpreserve(struct liveupdate_file_handler *fh);
 void luo_flb_file_finish(struct liveupdate_file_handler *fh);
 int __init luo_flb_setup_outgoing(void *fdt);
 int __init luo_flb_setup_incoming(void *fdt);
+void luo_flb_discard_incoming(void);
 void luo_flb_serialize(void);
 
 #ifdef CONFIG_LIVEUPDATE_TEST
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 0c9c82cd4ddc..741427d5f9e5 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -51,6 +51,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/anon_inodes.h>
+#include <linux/atomic.h>
 #include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -144,6 +145,7 @@ static struct luo_session *luo_session_alloc(const char *name)
 	INIT_LIST_HEAD(&session->file_set.files_list);
 	luo_file_set_init(&session->file_set);
 	INIT_LIST_HEAD(&session->list);
+	/* The caller transfers this reference to list membership on insert. */
 	refcount_set(&session->refs, 1);
 	mutex_init(&session->mutex);
 
@@ -168,6 +170,15 @@ static void luo_session_put(struct luo_session *session)
 		luo_session_free(session);
 }
 
+static int luo_session_finish_retrieved(struct luo_session *session)
+{
+	lockdep_assert_held(&session->mutex);
+	if (!session->retrieved)
+		return -EINVAL;
+
+	return luo_file_finish(&session->file_set);
+}
+
 static int luo_session_insert(struct luo_session_header *sh,
 			      struct luo_session *session)
 {
@@ -285,25 +296,11 @@ static void luo_session_wait_reboot(struct luo_session_header *sh)
 	finish_wait(&sh->reboot_waitq, &wait);
 }
 
-static int luo_session_finish_retrieved(struct luo_session *session)
-{
-	lockdep_assert_held(&session->mutex);
-	if (!session->retrieved)
-		return -EINVAL;
-
-	return luo_file_finish(&session->file_set);
-}
-
-static void luo_session_unfreeze_one(struct luo_session *session,
-				     struct luo_session_ser *ser)
-{
-	guard(mutex)(&session->mutex);
-	luo_file_unfreeze(&session->file_set, &ser->file_set_ser);
-}
-
-static void luo_session_discard_deserialized(struct luo_session_header *sh)
+static void luo_session_discard_deserialized(struct luo_session_header *sh,
+					     u64 abort_from)
 {
 	struct luo_session *session;
+	u64 i;
 
 	down_write(&sh->rwsem);
 	while (!list_empty(&sh->list)) {
@@ -313,6 +310,18 @@ static void luo_session_discard_deserialized(struct luo_session_header *sh)
 		luo_session_put(session);
 	}
 	up_write(&sh->rwsem);
+
+	for (i = abort_from; i < sh->header_ser->count; i++)
+		luo_file_abort_serialized(&sh->ser[i].file_set_ser);
+
+	luo_flb_discard_incoming();
+}
+
+static void luo_session_unfreeze_one(struct luo_session *session,
+				     struct luo_session_ser *ser)
+{
+	guard(mutex)(&session->mutex);
+	luo_file_unfreeze(&session->file_set, &ser->file_set_ser);
 }
 
 static int luo_session_release(struct inode *inodep, struct file *filep)
@@ -320,6 +329,7 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
 	struct luo_session *session = filep->private_data;
 	struct luo_session_header *sh = &luo_session_global.incoming;
 	int ret = 0;
+	bool discard_flb = false;
 	bool removed = false;
 
 	if (session->incoming) {
@@ -327,13 +337,26 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
 			if (session->retrieved) {
 				ret = luo_session_finish_retrieved(session);
 				if (!ret) {
+					/*
+					 * Make the session undiscoverable before
+					 * publishing it as not retrieved again,
+					 * otherwise luo_session_retrieve() can
+					 * reopen it through the incoming list
+					 * while close() is consuming it.
+					 */
 					down_write(&sh->rwsem);
 					if (!list_empty(&session->list)) {
 						__luo_session_remove(sh, session);
+						discard_flb = !sh->count;
 						removed = true;
 					}
 					up_write(&sh->rwsem);
 				}
+				/*
+				 * If close() is the implicit finish path, clear
+				 * retrieved even on failure so the session can
+				 * be retrieved again after this file is gone.
+				 */
 				WRITE_ONCE(session->retrieved, false);
 			}
 		}
@@ -341,12 +364,15 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
 		if (ret) {
 			pr_warn("Unable to finish session [%s] on release\n",
 				session->name);
+			/* Drop the anon_inode_getfile() reference. */
 			luo_session_put(session);
 			return ret;
 		}
 
 		if (removed)
 			luo_session_put(session);
+		if (discard_flb)
+			luo_flb_discard_incoming();
 		luo_session_put(session);
 		return 0;
 	}
@@ -366,6 +392,11 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
 		break;
 	}
 
+	/*
+	 * Once close() passes the rebooting gate it holds session->mutex, so
+	 * serialization will either wait for teardown to finish or observe the
+	 * session removed from the outgoing list.
+	 */
 	luo_file_unpreserve_files(&session->file_set);
 
 	down_write(&sh->rwsem);
@@ -373,9 +404,11 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
 	up_write(&sh->rwsem);
 	mutex_unlock(&session->mutex);
 
+	/* Drop the list reference and the anon inode file reference. */
 	luo_session_put(session);
 	luo_session_put(session);
-	return 0;
+
+	return ret;
 }
 
 static int luo_session_preserve_fd(struct luo_session *session,
@@ -444,15 +477,28 @@ static int luo_session_finish(struct luo_session *session,
 {
 	struct liveupdate_session_finish *argp = ucmd->cmd;
 	struct luo_session_header *sh = &luo_session_global.incoming;
+	bool discard_flb = false;
 	bool removed = false;
 	int err;
 
+	/*
+	 * FINISH consumes a retrieved incoming session. After a successful
+	 * finish it is removed from the incoming list; release() then only
+	 * drops the remaining file reference.
+	 */
 	scoped_guard(mutex, &session->mutex) {
 		err = luo_session_finish_retrieved(session);
 		if (!err) {
+			/*
+			 * Remove the session from the incoming list before it
+			 * becomes observable as not retrieved. Otherwise a
+			 * concurrent retrieve-by-name can take a new file
+			 * reference to a session that FINISH is consuming.
+			 */
 			down_write(&sh->rwsem);
 			if (!list_empty(&session->list)) {
 				__luo_session_remove(sh, session);
+				discard_flb = !sh->count;
 				removed = true;
 			}
 			up_write(&sh->rwsem);
@@ -464,6 +510,8 @@ static int luo_session_finish(struct luo_session *session,
 
 	if (removed)
 		luo_session_put(session);
+	if (discard_flb)
+		luo_flb_discard_incoming();
 
 	return luo_ucmd_respond(ucmd, sizeof(*argp));
 }
@@ -550,6 +598,7 @@ static int luo_session_getfile(struct luo_session *session, struct file **filep)
 
 	lockdep_assert_held(&session->mutex);
 	snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
+	/* anon_inode_getfile() keeps the session alive until .release(). */
 	luo_session_get(session);
 	file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);
 	if (IS_ERR(file)) {
@@ -583,6 +632,11 @@ int luo_session_create(const char *name, struct file **filep)
 	return 0;
 
 err_remove:
+	/*
+	 * Serializer synchronizes outgoing session visibility with
+	 * session->mutex. Keep the same lock while removing a create() failure
+	 * so it cannot freeze a session whose file was never published.
+	 */
 	scoped_guard(mutex, &session->mutex)
 		luo_session_remove(&luo_session_global.outgoing, session);
 err_free:
@@ -617,9 +671,9 @@ int luo_session_retrieve(const char *name, struct file **filep)
 		err = -EINVAL;
 	else
 		err = luo_session_getfile(session, filep);
-
 	if (!err)
 		WRITE_ONCE(session->retrieved, true);
+
 	luo_session_put(session);
 
 	return err;
@@ -708,8 +762,10 @@ int __init luo_session_setup_incoming(void *fdt_in)
 int luo_session_deserialize(void)
 {
 	struct luo_session_header *sh = &luo_session_global.incoming;
+	size_t bytes;
 	static bool is_deserialized;
 	static int err;
+	u64 abort_from = 0;
 
 	/* If has been deserialized, always return the same error code */
 	if (is_deserialized)
@@ -726,9 +782,21 @@ int luo_session_deserialize(void)
 		goto out_free_header;
 	}
 
+	bytes = kho_restorable_size(virt_to_phys(sh->header_ser));
+	if (bytes < sizeof(*sh->header_ser) ||
+	    sh->header_ser->count >
+	    (bytes - sizeof(*sh->header_ser)) / sizeof(*sh->ser)) {
+		pr_warn("Serialized session block is too small for %llu sessions\n",
+			sh->header_ser->count);
+		err = -EINVAL;
+		goto out_free_header;
+	}
+
 	for (int i = 0; i < sh->header_ser->count; i++) {
 		struct luo_session *session;
 
+		abort_from = i;
+
 		if (strnlen(sh->ser[i].name, sizeof(sh->ser[i].name)) ==
 		    sizeof(sh->ser[i].name)) {
 			pr_warn("Session name is not NUL-terminated\n");
@@ -743,15 +811,15 @@ int luo_session_deserialize(void)
 			err = PTR_ERR(session);
 			goto out_discard;
 		}
-		session->incoming = true;
 
+		session->incoming = true;
 		err = luo_session_insert(sh, session);
 		if (err) {
-			pr_warn("Failed to insert session [%s] %pe\n",
-				session->name, ERR_PTR(err));
-			luo_session_put(session);
-			goto out_discard;
-		}
+				pr_warn("Failed to insert session [%s] %pe\n",
+					session->name, ERR_PTR(err));
+				luo_session_put(session);
+				goto out_discard;
+			}
 
 		scoped_guard(mutex, &session->mutex)
 			err = luo_file_deserialize(&session->file_set,
@@ -759,6 +827,7 @@ int luo_session_deserialize(void)
 		if (err) {
 			pr_warn("Failed to deserialize session [%s] files %pe\n",
 				session->name, ERR_PTR(err));
+			abort_from = i;
 			goto out_discard;
 		}
 	}
@@ -773,7 +842,7 @@ int luo_session_deserialize(void)
 	return err;
 
 out_discard:
-	luo_session_discard_deserialized(sh);
+	luo_session_discard_deserialized(sh, abort_from);
 	goto out_free_header;
 }
 
@@ -833,6 +902,7 @@ int luo_session_serialize(void)
 		}
 	}
 	sh->header_ser->count = 0;
+	/* Reset rebooting flag on serialization failure. */
 	luo_session_reboot_done(sh);
 	goto out_put_sessions;
 }
@@ -879,10 +949,13 @@ void luo_session_abort_reboot(void)
  */
 bool luo_session_quiesce(void)
 {
+	if (luo_device_busy())
+		return false;
+
 	down_write(&luo_session_global.incoming.rwsem);
 	down_write(&luo_session_global.outgoing.rwsem);
 
-	if (luo_session_global.incoming.count ||
+	if (luo_device_busy() || luo_session_global.incoming.count ||
 	    luo_session_global.outgoing.count) {
 		up_write(&luo_session_global.outgoing.rwsem);
 		up_write(&luo_session_global.incoming.rwsem);
diff --git a/lib/tests/liveupdate.c b/lib/tests/liveupdate.c
index 496d6ef91a30..87d9302462d6 100644
--- a/lib/tests/liveupdate.c
+++ b/lib/tests/liveupdate.c
@@ -104,6 +104,8 @@ static void liveupdate_test_init(void)
 		if (err && err != -ENODATA && err != -ENOENT) {
 			pr_err("liveupdate_flb_get_incoming for %s failed: %pe\n",
 			       flb->compatible, ERR_PTR(err));
+		} else if (!err) {
+			liveupdate_flb_put_incoming(flb);
 		}
 	}
 	initialized = true;
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index b7f996176ad8..ef69e4935ada 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -77,10 +77,14 @@
 #include <linux/kho/abi/memfd.h>
 #include <linux/liveupdate.h>
 #include <linux/shmem_fs.h>
+#include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <linux/memfd.h>
 #include "internal.h"
 
+bool luo_file_abort_known_serialized(const char *compatible,
+				     u64 serialized_data);
+
 static int memfd_luo_preserve_folios(struct file *file,
 				     struct kho_vmalloc *kho_vmalloc,
 				     struct memfd_luo_folio_ser **out_folios_ser,
@@ -358,32 +362,90 @@ static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_se
 	}
 }
 
-static void memfd_luo_abort(struct liveupdate_file_op_args *args)
+static u64 memfd_luo_folios_capacity(const struct memfd_luo_ser *ser)
 {
-	struct memfd_luo_folio_ser *folios_ser;
-	struct memfd_luo_ser *ser;
+	return ((u64)ser->folios.total_pages << PAGE_SHIFT) /
+	       sizeof(struct memfd_luo_folio_ser);
+}
 
-	if (!args->serialized_data ||
-	    !kho_is_restorable_phys(args->serialized_data))
-		return;
+static bool memfd_luo_folio_desc_valid(const struct memfd_luo_ser *ser)
+{
+	if (!!ser->nr_folios != !!ser->folios.first.phys)
+		return false;
 
-	ser = phys_to_virt(args->serialized_data);
-	if (!ser)
-		return;
+	if (!ser->nr_folios)
+		return true;
 
-	if (ser->nr_folios) {
-		folios_ser = kho_restore_vmalloc(&ser->folios);
-		if (!folios_ser)
-			goto out;
+	return ser->nr_folios <= memfd_luo_folios_capacity(ser);
+}
 
-		memfd_luo_discard_folios(folios_ser, ser->nr_folios);
-		vfree(folios_ser);
+static bool memfd_luo_serialized_valid(const struct memfd_luo_ser *ser)
+{
+	if (ser->size > MAX_LFS_FILESIZE)
+		return false;
+
+	if (!memfd_luo_folio_desc_valid(ser))
+		return false;
+
+	/*
+	 * Invariant: memfd without serialized folios must have size == 0.
+	 * Preserve serializes page-backed content for every page in a non-empty
+	 * memfd, including holes.
+	 */
+	if (!ser->nr_folios)
+		return !ser->size;
+
+	return ser->nr_folios <= ((ser->size - 1) >> PAGE_SHIFT) + 1;
+}
+
+static void memfd_luo_discard_serialized(struct memfd_luo_ser *ser)
+{
+	struct memfd_luo_folio_ser *folios_ser;
+
+	if (memfd_luo_folio_desc_valid(ser) && ser->folios.first.phys) {
+		folios_ser = kho_restore_vmalloc(&ser->folios);
+		if (folios_ser) {
+			memfd_luo_discard_folios(folios_ser, ser->nr_folios);
+			vfree(folios_ser);
+		}
 	}
 
-out:
 	kho_restore_free(ser);
 }
 
+static bool memfd_luo_abort_serialized_data(u64 serialized_data)
+{
+	struct memfd_luo_ser *ser;
+	size_t bytes;
+
+	if (!serialized_data || !kho_is_restorable_phys(serialized_data))
+		return false;
+
+	bytes = kho_restorable_size(serialized_data);
+	ser = phys_to_virt(serialized_data);
+	if (bytes < sizeof(*ser)) {
+		kho_restore_free(ser);
+		return true;
+	}
+
+	memfd_luo_discard_serialized(ser);
+	return true;
+}
+
+bool luo_file_abort_known_serialized(const char *compatible, u64 serialized_data)
+{
+	if (strcmp(compatible, MEMFD_LUO_FH_COMPATIBLE))
+		return false;
+
+	return memfd_luo_abort_serialized_data(serialized_data);
+}
+
+static void memfd_luo_abort(struct liveupdate_file_op_args *args)
+{
+	if (!memfd_luo_abort_serialized_data(args->serialized_data))
+		return;
+}
+
 static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 {
 	/*
@@ -521,33 +583,21 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 		return -EINVAL;
 
 	ser = phys_to_virt(args->serialized_data);
-	if (!ser)
+	if (kho_restorable_size(args->serialized_data) < sizeof(*ser)) {
+		kho_restore_free(ser);
 		return -EINVAL;
-
-	if (!!ser->nr_folios != !!ser->folios.first.phys) {
-		err = -EINVAL;
-		goto free_ser;
-	}
-
-	if (ser->nr_folios >
-	    (((u64)ser->folios.total_pages << PAGE_SHIFT) /
-	     sizeof(*folios_ser))) {
-		err = -EINVAL;
-		goto free_ser;
 	}
 
-	if (ser->nr_folios &&
-	    (!ser->size ||
-	     ser->nr_folios > ((ser->size - 1) >> PAGE_SHIFT) + 1)) {
+	if (!memfd_luo_serialized_valid(ser)) {
 		err = -EINVAL;
-		goto free_ser;
+		goto discard_ser;
 	}
 
 	file = memfd_alloc_file("", 0);
 	if (IS_ERR(file)) {
 		pr_err("failed to setup file: %pe\n", file);
 		err = PTR_ERR(file);
-		goto free_ser;
+		goto discard_ser;
 	}
 
 	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
@@ -557,13 +607,13 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 		folios_ser = kho_restore_vmalloc(&ser->folios);
 		if (!folios_ser) {
 			err = -EINVAL;
-			goto put_file;
+			goto put_file_discard;
 		}
 
 		err = memfd_luo_retrieve_folios(file, folios_ser, ser->nr_folios);
 		vfree(folios_ser);
 		if (err)
-			goto put_file;
+			goto put_file_discard;
 	}
 
 	args->file = file;
@@ -571,10 +621,12 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 
 	return 0;
 
-put_file:
+discard_ser:
+	memfd_luo_discard_serialized(ser);
+	return err;
+put_file_discard:
 	fput(file);
-free_ser:
-	kho_restore_free(ser);
+	memfd_luo_discard_serialized(ser);
 	return err;
 }
 
-- 
2.53.0



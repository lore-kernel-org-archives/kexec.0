Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD43EFEC11B
	for <kexec@archiver.kernel.org>; Tue, 24 Mar 2026 21:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Aur9BDOPRlM1dKHCq5GcVyxPESfZWjSglhCr/pAvMUM=; b=Y6v/ys7Fjdbd41gYlOHuC9GFKa
	eCq0UPSPTDC0BvDSDR15FjasL3x9JO8jHZnFlFwAKunRP7Up5Ada72ej9afONGNk0fyhQV4Ws41Hs
	a2AoUiJedQWrqZ0frJdYxCHhwqdyFAoMVsM5fam5hcKAh2EVdluArlhsiu7sQqoQ5+5BkcTAhOmCl
	pzHL1i4WXfMtU4g45K1sex6ACcXVIXmecQgFm0EVoRJeEkwhP7E7j2endW0tlDRgtBGKPq+4Wt8Zs
	YYqvDPigjrbaHPS0PnVbY9c2tXBUJbXkeg1oIi+8A2HAPNaLB0pufDX9W5J7j+AcJ66SJu5+r+7PQ
	TVaa+9OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w59Xk-00000002Gbo-2LVb;
	Tue, 24 Mar 2026 21:44:08 +0000
Received: from [209.141.44.239] (helo=smtp3.mymangomail.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w59Xj-00000002GbS-0SdZ
	for kexec@lists.infradead.org;
	Tue, 24 Mar 2026 21:44:08 +0000
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTP id EB7E75D9D6;
	Tue, 24 Mar 2026 17:43:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774388639;
	bh=14Xnm0a3nPFOUHWtQ9DCqgB1B79alC0yjKR2puLpbKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEo82PMx7Uc/0khFhumtB10gSMiug7e1UIbrU7UhjA38j8UywVDhZcS+gP4gK6XV7
	 6a2vTK/bmxtWQcumprZtJFGLMxpS2zAlmAK4US+Q1LjvJqaEtZ6b0OXlNy+Zak0eER
	 iVh1fRJYvUx1x5FjGnJDTLbdHSuqfJjhJIyLLMLs=
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
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTPSA id 024EC5D9B4;
	Tue, 24 Mar 2026 17:42:08 -0400 (EDT)
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
Subject: [PATCH v4 4/5] liveupdate: validate handover metadata before using it
Date: Tue, 24 Mar 2026 22:39:08 +0100
Message-ID: <20260324213909.75643-2-oskar@gerlicz.space>
In-Reply-To: <20260324213909.75643-1-oskar@gerlicz.space>
References: <20260324212730.65290-3-oskar@gerlicz.space>
 <20260324213909.75643-1-oskar@gerlicz.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_144407_216193_D62A87D9 
X-CRM114-Status: GOOD (  20.64  )
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

The incoming handover path was still trusting counts and preserved
addresses more than it should. Corrupted metadata could drive
phys_to_virt() or kho_restore_free() with invalid addresses, and memfd
restore could walk beyond the serialized folio array.

That turns malformed handover state into out-of-bounds iteration,
invalid restore frees, or partially restored incoming state.

Validate session, file and FLB metadata before consuming it, reject
non-restorable preserved addresses, and bound memfd folio restore by
both the serialized size and the restored vmalloc backing.

Fixes: 1c18e3e1efcd ("liveupdate: validate handover metadata before using it")
Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
---
 include/linux/kexec_handover.h     |  5 +++
 kernel/liveupdate/kexec_handover.c | 13 +++++++
 kernel/liveupdate/luo_file.c       | 22 +++++++++---
 kernel/liveupdate/luo_flb.c        | 33 ++++++++++++++++--
 kernel/liveupdate/luo_session.c    | 29 ++++++++++++++--
 mm/memfd_luo.c                     | 56 ++++++++++++++++++++++++++++--
 6 files changed, 147 insertions(+), 11 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index ac4129d1d741..af8284a440bf 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -29,6 +29,7 @@ void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
 void *kho_alloc_preserve(size_t size);
 void kho_unpreserve_free(void *mem);
 void kho_restore_free(void *mem);
+bool kho_is_restorable_phys(phys_addr_t phys);
 struct folio *kho_restore_folio(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
@@ -80,6 +81,10 @@ static inline void *kho_alloc_preserve(size_t size)
 
 static inline void kho_unpreserve_free(void *mem) { }
 static inline void kho_restore_free(void *mem) { }
+static inline bool kho_is_restorable_phys(phys_addr_t phys)
+{
+	return false;
+}
 
 static inline struct folio *kho_restore_folio(phys_addr_t phys)
 {
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index cc68a3692905..215b27f5f85f 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -291,6 +291,19 @@ struct folio *kho_restore_folio(phys_addr_t phys)
 }
 EXPORT_SYMBOL_GPL(kho_restore_folio);
 
+bool kho_is_restorable_phys(phys_addr_t phys)
+{
+	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
+	union kho_page_info info;
+
+	if (!page || !PAGE_ALIGNED(phys))
+		return false;
+
+	info.page_private = READ_ONCE(page->private);
+	return info.magic == KHO_PAGE_MAGIC && info.order <= MAX_PAGE_ORDER;
+}
+EXPORT_SYMBOL_GPL(kho_is_restorable_phys);
+
 /**
  * kho_restore_pages - restore list of contiguous order 0 pages.
  * @phys: physical address of the first page.
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 939ef8d762ce..3eb9aeee6524 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -785,10 +785,17 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 	u64 i;
 	int err;
 
-	if (!file_set_ser->files) {
-		WARN_ON(file_set_ser->count);
-		return 0;
-	}
+	if (!file_set_ser->count)
+		return file_set_ser->files ? -EINVAL : 0;
+
+	if (!file_set_ser->files)
+		return -EINVAL;
+
+	if (file_set_ser->count > LUO_FILE_MAX)
+		return -EINVAL;
+
+	if (!kho_is_restorable_phys(file_set_ser->files))
+		return -EINVAL;
 
 	file_set->count = file_set_ser->count;
 	file_set->files = phys_to_virt(file_set_ser->files);
@@ -799,6 +806,13 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 		bool handler_found = false;
 		struct luo_file *luo_file;
 
+		if (strnlen(file_ser[i].compatible,
+			    sizeof(file_ser[i].compatible)) ==
+		    sizeof(file_ser[i].compatible)) {
+			err = -EINVAL;
+			goto err_discard;
+		}
+
 		list_private_for_each_entry(fh, &luo_file_handler_list, list) {
 			if (!strcmp(fh->compatible, file_ser[i].compatible)) {
 				handler_found = true;
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index f52e8114837e..cdd293408138 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -165,7 +165,14 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 		return -ENODATA;
 
 	for (int i = 0; i < fh->header_ser->count; i++) {
+		if (strnlen(fh->ser[i].name, sizeof(fh->ser[i].name)) ==
+		    sizeof(fh->ser[i].name))
+			return -EINVAL;
+
 		if (!strcmp(fh->ser[i].name, flb->compatible)) {
+			if (!fh->ser[i].count)
+				return -EINVAL;
+
 			private->incoming.data = fh->ser[i].data;
 			private->incoming.count = fh->ser[i].count;
 			found = true;
@@ -578,6 +585,7 @@ int __init luo_flb_setup_outgoing(void *fdt_out)
 
 int __init luo_flb_setup_incoming(void *fdt_in)
 {
+	struct luo_flb_header_ser *header_copy;
 	struct luo_flb_header_ser *header_ser;
 	int err, header_size, offset;
 	const void *ptr;
@@ -609,10 +617,31 @@ int __init luo_flb_setup_incoming(void *fdt_in)
 	}
 
 	header_ser_pa = get_unaligned((u64 *)ptr);
+	if (!header_ser_pa) {
+		pr_err("FLB header address is missing\n");
+		return -EINVAL;
+	}
+
+	if (!kho_is_restorable_phys(header_ser_pa))
+		return -EINVAL;
+
 	header_ser = phys_to_virt(header_ser_pa);
+	if (header_ser->pgcnt != LUO_FLB_PGCNT || header_ser->count > LUO_FLB_MAX) {
+		kho_restore_free(header_ser);
+		return -EINVAL;
+	}
+
+	header_copy = kmemdup(header_ser,
+			      sizeof(*header_copy) +
+			      header_ser->count *
+			      sizeof(*luo_flb_global.incoming.ser),
+			      GFP_KERNEL);
+	kho_restore_free(header_ser);
+	if (!header_copy)
+		return -ENOMEM;
 
-	luo_flb_global.incoming.header_ser = header_ser;
-	luo_flb_global.incoming.ser = (void *)(header_ser + 1);
+	luo_flb_global.incoming.header_ser = header_copy;
+	luo_flb_global.incoming.ser = (void *)(header_copy + 1);
 	luo_flb_global.incoming.active = true;
 
 	return 0;
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index e35e53efb355..0c9c82cd4ddc 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -688,6 +688,14 @@ int __init luo_session_setup_incoming(void *fdt_in)
 	}
 
 	header_ser_pa = get_unaligned((u64 *)ptr);
+	if (!header_ser_pa) {
+		pr_err("Session header address is missing\n");
+		return -EINVAL;
+	}
+
+	if (!kho_is_restorable_phys(header_ser_pa))
+		return -EINVAL;
+
 	header_ser = phys_to_virt(header_ser_pa);
 
 	luo_session_global.incoming.header_ser = header_ser;
@@ -712,9 +720,22 @@ int luo_session_deserialize(void)
 	if (!sh->active)
 		return err;
 
+	if (sh->header_ser->count > LUO_SESSION_MAX) {
+		pr_warn("Invalid session count %llu\n", sh->header_ser->count);
+		err = -EINVAL;
+		goto out_free_header;
+	}
+
 	for (int i = 0; i < sh->header_ser->count; i++) {
 		struct luo_session *session;
 
+		if (strnlen(sh->ser[i].name, sizeof(sh->ser[i].name)) ==
+		    sizeof(sh->ser[i].name)) {
+			pr_warn("Session name is not NUL-terminated\n");
+			err = -EINVAL;
+			goto out_discard;
+		}
+
 		session = luo_session_alloc(sh->ser[i].name);
 		if (IS_ERR(session)) {
 			pr_warn("Failed to allocate session [%s] during deserialization %pe\n",
@@ -743,9 +764,11 @@ int luo_session_deserialize(void)
 	}
 
 out_free_header:
-	kho_restore_free(sh->header_ser);
-	sh->header_ser = NULL;
-	sh->ser = NULL;
+	if (sh->header_ser) {
+		kho_restore_free(sh->header_ser);
+		sh->header_ser = NULL;
+		sh->ser = NULL;
+	}
 
 	return err;
 
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 8a453c8bfdf5..b7f996176ad8 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -363,6 +363,10 @@ static void memfd_luo_abort(struct liveupdate_file_op_args *args)
 	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
 
+	if (!args->serialized_data ||
+	    !kho_is_restorable_phys(args->serialized_data))
+		return;
+
 	ser = phys_to_virt(args->serialized_data);
 	if (!ser)
 		return;
@@ -399,10 +403,16 @@ static int memfd_luo_retrieve_folios(struct file *file,
 {
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
+	u64 max_index = i_size_read(inode);
+	u64 prev_index = 0;
 	struct folio *folio;
+	long put_from = 0;
 	int err = -EIO;
 	long i;
 
+	if (max_index)
+		max_index = (max_index - 1) >> PAGE_SHIFT;
+
 	for (i = 0; i < nr_folios; i++) {
 		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
 		phys_addr_t phys;
@@ -412,6 +422,19 @@ static int memfd_luo_retrieve_folios(struct file *file,
 		if (!pfolio->pfn)
 			continue;
 
+		put_from = i;
+		if (pfolio->flags &
+		    ~(MEMFD_LUO_FOLIO_DIRTY | MEMFD_LUO_FOLIO_UPTODATE)) {
+			err = -EINVAL;
+			goto put_folios;
+		}
+
+		if (pfolio->index > max_index ||
+		    (i && pfolio->index <= prev_index)) {
+			err = -EINVAL;
+			goto put_folios;
+		}
+
 		phys = PFN_PHYS(pfolio->pfn);
 		folio = kho_restore_folio(phys);
 		if (!folio) {
@@ -419,7 +442,9 @@ static int memfd_luo_retrieve_folios(struct file *file,
 			       phys);
 			goto put_folios;
 		}
+		put_from = i + 1;
 		index = pfolio->index;
+		prev_index = index;
 		flags = pfolio->flags;
 
 		/* Set up the folio for insertion. */
@@ -469,10 +494,15 @@ static int memfd_luo_retrieve_folios(struct file *file,
 	 * Note: don't free the folios already added to the file. They will be
 	 * freed when the file is freed. Free the ones not added yet here.
 	 */
-	for (long j = i + 1; j < nr_folios; j++) {
+	for (long j = put_from; j < nr_folios; j++) {
 		const struct memfd_luo_folio_ser *pfolio = &folios_ser[j];
+		phys_addr_t phys;
+
+		if (!pfolio->pfn)
+			continue;
 
-		folio = kho_restore_folio(pfolio->pfn);
+		phys = PFN_PHYS(pfolio->pfn);
+		folio = kho_restore_folio(phys);
 		if (folio)
 			folio_put(folio);
 	}
@@ -487,10 +517,32 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	struct file *file;
 	int err;
 
+	if (!kho_is_restorable_phys(args->serialized_data))
+		return -EINVAL;
+
 	ser = phys_to_virt(args->serialized_data);
 	if (!ser)
 		return -EINVAL;
 
+	if (!!ser->nr_folios != !!ser->folios.first.phys) {
+		err = -EINVAL;
+		goto free_ser;
+	}
+
+	if (ser->nr_folios >
+	    (((u64)ser->folios.total_pages << PAGE_SHIFT) /
+	     sizeof(*folios_ser))) {
+		err = -EINVAL;
+		goto free_ser;
+	}
+
+	if (ser->nr_folios &&
+	    (!ser->size ||
+	     ser->nr_folios > ((ser->size - 1) >> PAGE_SHIFT) + 1)) {
+		err = -EINVAL;
+		goto free_ser;
+	}
+
 	file = memfd_alloc_file("", 0);
 	if (IS_ERR(file)) {
 		pr_err("failed to setup file: %pe\n", file);
-- 
2.53.0



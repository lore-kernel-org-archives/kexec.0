Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E681099B28
	for <kexec@archiver.kernel.org>; Fri, 20 Mar 2026 18:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L1z4EZkU3hfJQofS/LDV30v6HLPNLGEIDJUPrfGbrKw=; b=wqtZo/B+YgJxwlsti+Kr6BMrwi
	hocOviipiHeEXyOmvpp65BMDqhPH5Ad9xLFZCcU0xpBcg1bPi087rfzoN9AgFhqaYEcE4YyoQzIiU
	NZanKwccByZpC498hga/7jxthSl/dUejzLs39d5o6NcSSJn5dliooxhKYpD4tJMN1SNUplcqvzrh3
	5UJk8SeXlZ+TwB8X6q6oNRoyy8WyTa6BXVwNnuGj0f9wK1yJqdRoRx8f3K5qCKWGdz+ZVZ34LxH2q
	H4v6oEzX5waeHQS5/1uPRLiqNxib1hpUze/QGJ2mcKK50Aso2bpoSEpdfszFQu0KCjgKvkmkIBYG7
	wvgdQy4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3eNg-0000000DMNX-3OOt;
	Fri, 20 Mar 2026 18:15:32 +0000
Received: from [209.141.44.239] (helo=smtp3.mymangomail.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3eNb-0000000DMMb-3fyp
	for kexec@lists.infradead.org;
	Fri, 20 Mar 2026 18:15:29 +0000
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTP id 0DEFF5F42D;
	Fri, 20 Mar 2026 12:43:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774024994;
	bh=u/53CXeIQwpaCO0/ObR0JkGhc5pmW6NGabn8LdjoAx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4JMMpLIgq5X05nmJTKspuN7lxap4g9KpDg+VGCPrv3DVE/BYK3iSNYrXZjTisFBS
	 5f0ofj9asGTjIuc8IBEhp0n02kvoFh1ydRdyJjzrA2Ekj0JjV3blkBHrvjcKc6PoNG
	 wXHWxfBJNopmD6bCmBwacuVx4URqQ3+vxp54CEdo=
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
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTPSA id 6812E5D9B1;
	Fri, 20 Mar 2026 12:42:00 -0400 (EDT)
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
Subject: [PATCH 4/5] liveupdate: validate handover metadata before using it
Date: Fri, 20 Mar 2026 17:37:19 +0100
Message-ID: <20260320163720.100456-4-oskar@gerlicz.space>
In-Reply-To: <20260320163720.100456-1-oskar@gerlicz.space>
References: <20260320163720.100456-1-oskar@gerlicz.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_111528_876823_BE74ED6C 
X-CRM114-Status: GOOD (  17.30  )
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

The handover restore path currently trusts counts, strings and
addresses copied from the previous kernel. A truncated or corrupted
handover can feed invalid header addresses, oversized counts,
unterminated names or impossible memfd folio layouts straight into
restore code.

That is dangerous because it can turn a bad handover into
out-of-bounds iteration, bogus phys_to_virt() translations or
inconsistent shmem state in the new kernel.

Add cheap sanity checks before consuming the metadata. Validate
session and file counts, require non-zero serialized pointers when
data is present, reject unterminated names, sanity-check FLB headers,
and make memfd_luo reject impossible folio indices and unsupported
flags.

Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
---
 kernel/liveupdate/luo_file.c    | 19 +++++++++++++++----
 kernel/liveupdate/luo_flb.c     | 14 ++++++++++++++
 kernel/liveupdate/luo_session.c | 16 ++++++++++++++++
 mm/memfd_luo.c                  | 26 ++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index cc0fd7e9c332..94d49255115d 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -765,10 +765,14 @@ int luo_file_deserialize(struct luo_file_set *file_set,
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
 
 	file_set->count = file_set_ser->count;
 	file_set->files = phys_to_virt(file_set_ser->files);
@@ -779,6 +783,13 @@ int luo_file_deserialize(struct luo_file_set *file_set,
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
index f52e8114837e..3672cbf8e075 100644
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
@@ -609,7 +616,14 @@ int __init luo_flb_setup_incoming(void *fdt_in)
 	}
 
 	header_ser_pa = get_unaligned((u64 *)ptr);
+	if (!header_ser_pa) {
+		pr_err("FLB header address is missing\n");
+		return -EINVAL;
+	}
+
 	header_ser = phys_to_virt(header_ser_pa);
+	if (header_ser->pgcnt != LUO_FLB_PGCNT || header_ser->count > LUO_FLB_MAX)
+		return -EINVAL;
 
 	luo_flb_global.incoming.header_ser = header_ser;
 	luo_flb_global.incoming.ser = (void *)(header_ser + 1);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 77afa913d6c7..9a08e9794062 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -542,6 +542,11 @@ int __init luo_session_setup_incoming(void *fdt_in)
 	}
 
 	header_ser_pa = get_unaligned((u64 *)ptr);
+	if (!header_ser_pa) {
+		pr_err("Session header address is missing\n");
+		return -EINVAL;
+	}
+
 	header_ser = phys_to_virt(header_ser_pa);
 
 	luo_session_global.incoming.header_ser = header_ser;
@@ -565,9 +570,20 @@ int luo_session_deserialize(void)
 	if (!sh->active)
 		return 0;
 
+	if (sh->header_ser->count > LUO_SESSION_MAX) {
+		pr_warn("Invalid session count %llu\n", sh->header_ser->count);
+		return -EINVAL;
+	}
+
 	for (int i = 0; i < sh->header_ser->count; i++) {
 		struct luo_session *session;
 
+		if (strnlen(sh->ser[i].name, sizeof(sh->ser[i].name)) ==
+		    sizeof(sh->ser[i].name)) {
+			pr_warn("Session name is not NUL-terminated\n");
+			return -EINVAL;
+		}
+
 		session = luo_session_alloc(sh->ser[i].name);
 		if (IS_ERR(session)) {
 			pr_warn("Failed to allocate session [%s] during deserialization %pe\n",
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index b8edb9f981d7..75f3f7226e6e 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -394,10 +394,15 @@ static int memfd_luo_retrieve_folios(struct file *file,
 {
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
+	u64 max_index = i_size_read(inode);
+	u64 prev_index = 0;
 	struct folio *folio;
 	int err = -EIO;
 	long i;
 
+	if (max_index)
+		max_index = (max_index - 1) >> PAGE_SHIFT;
+
 	for (i = 0; i < nr_folios; i++) {
 		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
 		phys_addr_t phys;
@@ -407,6 +412,18 @@ static int memfd_luo_retrieve_folios(struct file *file,
 		if (!pfolio->pfn)
 			continue;
 
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
@@ -415,6 +432,7 @@ static int memfd_luo_retrieve_folios(struct file *file,
 			goto put_folios;
 		}
 		index = pfolio->index;
+		prev_index = index;
 		flags = pfolio->flags;
 
 		/* Set up the folio for insertion. */
@@ -486,6 +504,14 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	if (!ser)
 		return -EINVAL;
 
+	if (!!ser->nr_folios != !!ser->folios.first.phys)
+		return -EINVAL;
+
+	if (ser->nr_folios &&
+	    (!ser->size ||
+	     ser->nr_folios > ((ser->size - 1) >> PAGE_SHIFT) + 1))
+		return -EINVAL;
+
 	file = memfd_alloc_file("", 0);
 	if (IS_ERR(file)) {
 		pr_err("failed to setup file: %pe\n", file);
-- 
2.53.0



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C01606A333
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l+cyPXLw;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lbgs/yar
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xzj+m2zx9cLSChoVXv7HfacxXNo3CyS+OFptqcCaQh4=; b=l+cyPXLwb76Ysn
	SVfzbJkLqFtd0mSC0q7NAx/PxlkohjYuA5PHAVvo7RmB5yhXSbuQ8dgUVQrDK6wWQSClzPOn2O7nN
	7yX8k1l/nPtxGRvTp7Z5kgfI22PMUyEfBcM6+Tjpstk4xrQvwYn/WDDpV/xZAwAoR7tl7IhKsLXzZ
	jWO2t5xS0I0R1QyYqwKurV2Gc7mi2dqnUedhjiLiUaxb7MYYFT2cr9UhGbAGyXR2lfsuzlVakqDdN
	naeCX9u3aUbyuF8k4cM0FDdLUxAmvmbSq3XA6eApryHUfpSj5J9M0v6H3jgdipIg1maSyx0wYygDG
	div/q3j0aeRwvGooZ1rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQq7i-00000004kKX-23Bo;
	Tue, 10 Nov 2026 17:59:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQq7g-00000004kJI-2H82
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 17:59:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5044D41E6E;
	Tue, 10 Nov 2026 17:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F801F008A1;
	Tue, 10 Nov 2026 17:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333548;
	bh=xzj+m2zx9cLSChoVXv7HfacxXNo3CyS+OFptqcCaQh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lbgs/yare/CCf7+Zqw6RNxf3VwmYHd1Jo3R2x7UcNonyOoUMTK9cT+XCjUpNLCFzY
	 HTUVoLANeBAew9qEtYlst28H/vY2rim7qBbujGKxlAG6pMG+L3u2RHryhuLTalN/W3
	 CgsxXiQfh7NKQQ9lXqvtlTQW7MraRjsZewAtxPxzQA6ZuOQ5hqxTELKR1oG/AKHA00
	 xuNeeIpHU3IozEZwVIcMuWeprY2W9dF02AGZBJmnu7rjgC2nzQcS99GAUaKo+Kn2K2
	 uvswAgUeOa1kgfz+B4IRMXnTtMdPsXVpu8tEcXvDpaoSS/+pmESkmiwRegVBo/uVvU
	 nAc/xnr7OXBug==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/2] mm/memfd_luo: keep memfd frozen until finish
Date: Tue, 10 Nov 2026 18:58:53 +0100
Message-ID: <20261110175855.2437084-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
In-Reply-To: <20261110175855.2437084-1-pratyush@kernel.org>
References: <20261110175855.2437084-1-pratyush@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

After a memfd is retrieved, it immediately goes back into "normal"
operation. The file comes back unfrozen, and its pages can migrate, it
can be truncated, and so on. If the memfd is depended on by something,
like iommufd, that can open a window for folios to move around before
the consumer can re-establish its references.

Finish is the conceptual point when a retrieved file can start to behave
as "normal". So take an extra reference on the folios and freeze the
memfd on retrieve until finish.

Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 mm/memfd_luo.c | 87 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 19 deletions(-)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 9fd9abf9fedf6..50dbbda47ad3c 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -55,6 +55,14 @@
  *   Only seals known to this LUO version (see ``MEMFD_LUO_ALL_SEALS``) may
  *   be present; preservation fails with ``-EOPNOTSUPP`` otherwise.
  *
+ * Restrictions
+ * ============
+ *
+ * While a memfd is preserved, and after it is retrieved until the session is
+ * finished, its size can't be changed and holes can't be punched in it.
+ * Operations that would do so (``ftruncate()``, ``fallocate()``, writes past
+ * the end of the file) fail.
+ *
  * Non-Preserved Properties
  * ========================
  *
@@ -456,33 +464,56 @@ static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_se
 	}
 }
 
+/* Drop the references retrieve() holds on the folios added to the file. */
+static void
+memfd_luo_put_retrieved_folios(const struct memfd_luo_folio_ser *folios_ser,
+			       u64 nr_folios)
+{
+	for (u64 i = 0; i < nr_folios; i++) {
+		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+
+		if (pfolio->pfn)
+			folio_put(pfn_folio(pfolio->pfn));
+	}
+}
+
 static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 {
 	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
 
-	/*
-	 * If retrieve was successful, nothing to do. If it failed, retrieve()
-	 * already cleaned up everything it could. So nothing to do there
-	 * either. Only need to clean up when retrieve was not called.
-	 */
-	if (args->retrieve_status)
+	/* If retrieve failed, it already cleaned up everything it could. */
+	if (args->retrieve_status < 0)
 		return;
 
 	ser = phys_to_virt(args->serialized_data);
 	if (!ser)
 		return;
 
-	if (ser->nr_folios) {
-		folios_ser = kho_restore_vmalloc(&ser->folios);
-		if (!folios_ser)
-			goto out;
+	if (args->retrieve_status > 0) {
+		/*
+		 * Retrieve was successful, release the folios and unfreeze the
+		 * file so it can be used normally.
+		 */
+		struct inode *inode = file_inode(args->file);
+
+		folios_ser = args->private_data;
+
+		inode_lock(inode);
+		memfd_luo_put_retrieved_folios(folios_ser, ser->nr_folios);
+		shmem_freeze(inode, false);
+		inode_unlock(inode);
 
-		memfd_luo_discard_folios(folios_ser, ser->nr_folios);
 		vfree(folios_ser);
+	} else if (args->retrieve_status == 0 && ser->nr_folios) {
+		/* Retrieve was not called, discard the preserved folios. */
+		folios_ser = kho_restore_vmalloc(&ser->folios);
+		if (folios_ser) {
+			memfd_luo_discard_folios(folios_ser, ser->nr_folios);
+			vfree(folios_ser);
+		}
 	}
 
-out:
 	kho_restore_free(ser);
 }
 
@@ -552,7 +583,10 @@ static int memfd_luo_retrieve_folios(struct file *file,
 		nr_added_pages += npages;
 		folio_add_lru(folio);
 		folio_unlock(folio);
-		folio_put(folio);
+		/*
+		 * Keep the reference from kho_restore_folio(). It is dropped
+		 * in finish().
+		 */
 	}
 
 	shmem_recalc_inode(inode, nr_added_pages, 0);
@@ -566,9 +600,12 @@ static int memfd_luo_retrieve_folios(struct file *file,
 	folio_put(folio);
 put_folios:
 	/*
-	 * Note: don't free the folios already added to the file. They will be
-	 * freed when the file is freed. Free the ones not added yet here.
+	 * Drop the references held on the folios already added to the file.
+	 * The folios themselves will be freed when the file is freed.
 	 */
+	memfd_luo_put_retrieved_folios(folios_ser, i);
+
+	/* Free the ones not added yet here. */
 	for (long j = i + 1; j < nr_folios; j++) {
 		const struct memfd_luo_folio_ser *pfolio = &folios_ser[j];
 		phys_addr_t phys;
@@ -589,7 +626,7 @@ static int memfd_luo_retrieve_folios(struct file *file,
 
 static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 {
-	struct memfd_luo_folio_ser *folios_ser;
+	struct memfd_luo_folio_ser *folios_ser = NULL;
 	struct memfd_luo_ser *ser;
 	struct file *file;
 	int err;
@@ -624,6 +661,17 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
 	i_size_write(file_inode(file), ser->size);
 
+	/*
+	 * Keep the file frozen until finish(). Other preserved objects might
+	 * depend on it.
+	 *
+	 * The file isn't visible to anyone yet, but take the lock anyway since
+	 * shmem_freeze() requires it.
+	 */
+	inode_lock(file_inode(file));
+	shmem_freeze(file_inode(file), true);
+	inode_unlock(file_inode(file));
+
 	if (ser->nr_folios) {
 		folios_ser = kho_restore_vmalloc(&ser->folios);
 		if (!folios_ser) {
@@ -632,16 +680,17 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 		}
 
 		err = memfd_luo_retrieve_folios(file, folios_ser, ser->nr_folios);
-		vfree(folios_ser);
 		if (err)
-			goto put_file;
+			goto free_folios_ser;
 	}
 
 	args->file = file;
-	kho_restore_free(ser);
+	args->private_data = folios_ser;
 
 	return 0;
 
+free_folios_ser:
+	vfree(folios_ser);
 put_file:
 	fput(file);
 free_ser:
-- 
2.56.0.542.g3ef89b7020-goog



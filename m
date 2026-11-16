Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451F4606A8BF
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EqnBRnE1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ekrNzw2m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=o58Uk0z5/VSRQnQFdmkvJUPFvXFWWXuI0VIVQWg8Ntc=; b=EqnBRnE1Tr9Rrv
	sGmj+FEHU9GtAkp4DpEegs2gHDKbovPeJL4vxphCZHEXA1jsF8EfScpbm4HtXFO3LaIcM8mLxV0//
	3b/K2iaLUHQyDzM9lAUpg3wLPxZvY7AwYC35COFG8Lqy3omYxCoXfDnl6WqekVL/cOE1SWjb0/7F8
	kVvd+bbNbd4kAqXLNtkRS90IwU1o3o9QGjkzvRToMGmWFzXehe4TV3qszEYEi44yQEQJIHQV4vItr
	mhd66dLQoGv7Uu/rAqdYk1as282bhnaEw2T8rMiUA7J947g9fuPqV3g6IYy5Tepxfnvn/pVu2KN7q
	IO6Rt+mvJiYROmKwLE2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwwr-00000002fXU-3r1B;
	Mon, 16 Nov 2026 13:40:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwwq-00000002fVi-0G77
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 13:40:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4407262B75;
	Mon, 16 Nov 2026 13:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B331F000C8;
	Mon, 16 Nov 2026 13:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794836439;
	bh=o58Uk0z5/VSRQnQFdmkvJUPFvXFWWXuI0VIVQWg8Ntc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ekrNzw2mvFn2PJisggTurCwF2ov2lnxA6T8q36VvLLlstkTzn+0BbvitSMnVMSDXl
	 bFKl4pZiIgN896OsTJNTHnfxmJUldVYAoAK4HjrUHdo8IvqetGOuXvc97KcWET8D9C
	 yGgPHcO4Zy0x/0QjK8pKyK/qv/kXL8xYFEDgDNnqWuPrQuOPblsO3tTfOxxI3Ttd/y
	 npNGfGsDRuHg2ZfGJLmMKZ9TnLV8YH8vZi0TFeIZC4TZjqzhjEPUSdXUm9CLrFNPaj
	 4RfJ+Pmb/KL4XO/FxxVbXAm5mEQNbd7lgQbKFDLEA3kaDmhyinvdM4xvaDQrLLN1fF
	 vFhftlq/Zdw7A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tarun Sahu <tarunsahu@google.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 5/5] mm/memfd_luo: use KHO map for tracking folios
Date: Mon, 16 Nov 2026 14:40:10 +0100
Message-ID: <20261116134013.1636689-6-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116134013.1636689-1-pratyush@kernel.org>
References: <20261116134013.1636689-1-pratyush@kernel.org>
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

Currently the folios of the memfd are tracked in a vmalloc-ed array.
Each entry takes 16 bytes. 8 bytes for the index and another 8 for the
folio info. This is inefficient for memfds with order 0 folios. Updating
the map after preservation is also impractical. This makes supporting
sparse memfds more difficult.

Use a KHO map to track the folios instead. The key is the index of the
folio in the file, so it no longer needs to be stored in the entry, and
each entry shrinks to a single u64 holding the PFN and the folio flags.

struct memfd_luo_ser now embeds struct kho_map_ser in place of the
folios array and nr_folios. This changes the ABI, so bump the compatible
string to "memfd-v3".

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kho/abi/memfd.h |  39 +++--
 mm/memfd_luo.c                | 292 +++++++++++++++-------------------
 2 files changed, 151 insertions(+), 180 deletions(-)

diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 08b10fea2afc8..b17ada3af7abb 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -11,8 +11,11 @@
 #ifndef _LINUX_KHO_ABI_MEMFD_H
 #define _LINUX_KHO_ABI_MEMFD_H
 
+#include <linux/bits.h>
+#include <linux/build_bug.h>
 #include <linux/types.h>
 #include <linux/kho/abi/kexec_handover.h>
+#include <linux/kho/abi/map.h>
 
 /**
  * DOC: memfd Live Update ABI
@@ -23,6 +26,10 @@
  * The state is serialized into a packed structure `struct memfd_luo_ser`
  * which is handed over to the next kernel via the KHO mechanism.
  *
+ * The folios of the file are stored in a KHO map. The value at a folio index
+ * is a ``union memfd_luo_folio_ser``. A value of 0 means there is no folio at
+ * that offset.
+ *
  * This interface is a contract. Any modification to the structure layout
  * constitutes a breaking change. Such changes require incrementing the
  * version number in the MEMFD_LUO_FH_COMPATIBLE string.
@@ -45,16 +52,21 @@
 #define MEMFD_LUO_FOLIO_UPTODATE	BIT(1)
 
 /**
- * struct memfd_luo_folio_ser - Serialized state of a single folio.
- * @pfn:       The page frame number of the folio.
- * @flags:     Flags to describe the state of the folio.
- * @index:     The page offset (pgoff_t) of the folio within the original file.
+ * union memfd_luo_folio_ser - Serialized state of a single folio.
+ * @val:   The raw value stored in the KHO map.
+ * @pfn:   The page frame number of the folio.
+ * @flags: Flags to describe the state of the folio.
  */
-struct memfd_luo_folio_ser {
-	u64 pfn:52;
-	u64 flags:12;
-	u64 index;
-} __packed;
+union memfd_luo_folio_ser {
+	u64 val;
+	struct {
+		u64 pfn:52;
+		u64 flags:12;
+	};
+};
+
+/* It must fit into a KHO map entry. */
+static_assert(sizeof(union memfd_luo_folio_ser) == sizeof(u64));
 
 /*
  * The set of seals this version supports preserving. If support for any new
@@ -74,20 +86,17 @@ struct memfd_luo_folio_ser {
  * @seals:     The seals present on the memfd. The seals are uABI so it is safe
  *             to directly use them in the ABI.
  * @flags:     Flags for the file. Unused flag bits must be set to 0.
- * @nr_folios: Number of folios in the folios array.
- * @folios:    KHO vmalloc descriptor pointing to the array of
- *             struct memfd_luo_folio_ser.
+ * @folios:    Folios in the file.
  */
 struct memfd_luo_ser {
 	u64 pos;
 	u64 size;
 	u32 seals;
 	u32 flags;
-	u64 nr_folios;
-	struct kho_vmalloc folios;
+	struct kho_map_ser folios;
 } __packed;
 
 /* The compatibility string for memfd file handler */
-#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
+#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v3"
 
 #endif /* _LINUX_KHO_ABI_MEMFD_H */
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 50dbbda47ad3c..26cdb41f40532 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -84,31 +84,25 @@
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/memfd.h>
+#include <linux/kho_map.h>
 #include <linux/liveupdate.h>
 #include <linux/migrate.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/shmem_fs.h>
 #include <linux/swap.h>
-#include <linux/vmalloc.h>
 #include <linux/memfd.h>
 #include <uapi/linux/memfd.h>
 
 #include "internal.h"
 
-static void memfd_luo_put_folios(const struct memfd_luo_folio_ser *folios_ser,
-				 u64 nr_folios)
+static void memfd_luo_put_folios(struct kho_map *map)
 {
-	u64 i;
+	union memfd_luo_folio_ser entry;
+	u64 index;
 
-	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
-		struct folio *folio;
-
-		if (!pfolio->pfn)
-			continue;
-
-		folio = pfn_folio(pfolio->pfn);
+	kho_map_for_each(map, index, entry.val) {
+		struct folio *folio = pfn_folio(entry.pfn);
 
 		kho_unpreserve_folio(folio);
 		folio_put(folio);
@@ -190,9 +184,9 @@ static int memfd_luo_get_folio(struct inode *inode, pgoff_t index,
 	return 0;
 }
 
-static int memfd_luo_preserve_folio(struct folio *folio,
-				    struct memfd_luo_folio_ser *pfolio)
+static int memfd_luo_preserve_folio(struct folio *folio, struct kho_map *map)
 {
+	union memfd_luo_folio_ser entry = {};
 	int err;
 
 	err = kho_preserve_folio(folio);
@@ -210,7 +204,7 @@ static int memfd_luo_preserve_folio(struct folio *folio,
 	 * might still be a mapping of the file at freeze().
 	 *
 	 * To see why this is a problem, say a folio is clean at
-	 * preserve, but gets dirtied later. The pfolio flags will mark
+	 * preserve, but gets dirtied later. The preserved flags will mark
 	 * it as clean. After retrieve, the next kernel might try to
 	 * reclaim this folio under memory pressure, losing user data.
 	 *
@@ -220,46 +214,31 @@ static int memfd_luo_preserve_folio(struct folio *folio,
 	 */
 	folio_mark_dirty(folio);
 
-	pfolio->pfn = folio_pfn(folio);
-	pfolio->flags = MEMFD_LUO_FOLIO_DIRTY | MEMFD_LUO_FOLIO_UPTODATE;
-	pfolio->index = folio->index;
+	entry.pfn = folio_pfn(folio);
+	entry.flags = MEMFD_LUO_FOLIO_DIRTY | MEMFD_LUO_FOLIO_UPTODATE;
+	err = kho_map_set(map, folio->index, entry.val);
+	if (err) {
+		kho_unpreserve_folio(folio);
+		return err;
+	}
 
 	return 0;
 }
 
-static int memfd_luo_preserve_folios(struct file *file,
-				     struct kho_vmalloc *kho_vmalloc,
-				     struct memfd_luo_folio_ser **out_folios_ser,
-				     u64 *nr_foliosp)
+static int memfd_luo_preserve_folios(struct file *file, struct kho_map *map)
 {
-	struct memfd_luo_folio_ser *folios_ser, *shrunk;
 	struct inode *inode = file_inode(file);
-	u64 nr_folios = 0, max_folios;
 	unsigned int pin_flags;
 	pgoff_t index = 0, end;
 	int err;
 	loff_t size;
 
 	size = i_size_read(inode);
-	/*
-	 * If the file has zero size, then the folios and nr_folios properties
-	 * are not set.
-	 */
-	if (!size) {
-		*nr_foliosp = 0;
-		*out_folios_ser = NULL;
+	/* If the file has zero size, then the folios map is left empty. */
+	if (!size)
 		return 0;
-	}
 
-	/*
-	 * Guess the number of folios based on inode size. Real number might end
-	 * up being smaller if there are higher order folios.
-	 */
 	end = DIV_ROUND_UP_ULL(size, PAGE_SIZE);
-	max_folios = end;
-	folios_ser = vmalloc_array(max_folios, sizeof(*folios_ser));
-	if (!folios_ser)
-		return -ENOMEM;
 
 	/*
 	 * The folios are held until the next kernel, so keep newly allocated
@@ -281,75 +260,41 @@ static int memfd_luo_preserve_folios(struct file *file,
 			goto err_restore;
 		}
 
-		if (WARN_ON_ONCE(nr_folios >= max_folios)) {
-			err = -EINVAL;
-			goto err_restore;
-		}
-
 		err = memfd_luo_get_folio(inode, index, &folio);
 		if (err)
 			goto err_restore;
 
-		err = memfd_luo_preserve_folio(folio, &folios_ser[nr_folios]);
+		err = memfd_luo_preserve_folio(folio, map);
 		index = folio_next_index(folio);
 		folio_unlock(folio);
 		if (err) {
 			folio_put(folio);
 			goto err_restore;
 		}
-		nr_folios++;
 	}
 	memalloc_pin_restore(pin_flags);
 
-	/*
-	 * Free the unused tail so it doesn't get preserved. If vrealloc fails,
-	 * the folios_ser is still valid.
-	 */
-	shrunk = vrealloc(folios_ser, array_size(nr_folios, sizeof(*folios_ser)),
-			  GFP_KERNEL);
-	if (shrunk)
-		folios_ser = shrunk;
-
-	err = kho_preserve_vmalloc(folios_ser, kho_vmalloc);
-	if (err)
-		goto err_put;
-
-	*nr_foliosp = nr_folios;
-	*out_folios_ser = folios_ser;
-
-	/*
-	 * Note: folios_ser is purposely not freed here. It is preserved
-	 * memory (via KHO). In the 'unpreserve' path, we use the vmap pointer
-	 * that is passed via private_data.
-	 */
 	return 0;
 
 err_restore:
 	memalloc_pin_restore(pin_flags);
-err_put:
-	memfd_luo_put_folios(folios_ser, nr_folios);
-	vfree(folios_ser);
+	memfd_luo_put_folios(map);
+	kho_map_destroy(map);
 	return err;
 }
 
-static void memfd_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
-					struct memfd_luo_folio_ser *folios_ser,
-					u64 nr_folios)
+static void memfd_luo_unpreserve_folios(struct kho_map *map)
 {
-	if (!nr_folios)
-		return;
-
-	kho_unpreserve_vmalloc(kho_vmalloc);
-	memfd_luo_put_folios(folios_ser, nr_folios);
-	vfree(folios_ser);
+	memfd_luo_put_folios(map);
+	kho_map_destroy(map);
 }
 
 static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
-	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
-	u64 nr_folios, inode_size;
+	struct kho_map *folios;
+	u64 inode_size;
 	int err = 0, seals;
 
 	inode_lock(inode);
@@ -380,19 +325,38 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	ser->size = inode_size;
 	ser->seals = seals;
 
-	err = memfd_luo_preserve_folios(args->file, &ser->folios,
-					&folios_ser, &nr_folios);
-	if (err)
+	/*
+	 * The runtime handle of the folios map is needed until unpreserve(),
+	 * so keep it in private_data.
+	 */
+	folios = kmalloc_obj(*folios);
+	if (!folios) {
+		err = -ENOMEM;
 		goto err_free_ser;
+	}
+
+	kho_map_init(folios, &ser->folios);
+	/*
+	 * Preserve the empty tree right away, so every node allocated for the
+	 * tree is auto-preserved.
+	 */
+	err = kho_map_preserve(folios);
+	if (err)
+		goto err_free_folios;
+
+	err = memfd_luo_preserve_folios(args->file, folios);
+	if (err)
+		goto err_free_folios;
 
-	ser->nr_folios = nr_folios;
 	inode_unlock(inode);
 
-	args->private_data = folios_ser;
 	args->serialized_data = virt_to_phys(ser);
+	args->private_data = folios;
 
 	return 0;
 
+err_free_folios:
+	kfree(folios);
 err_free_ser:
 	kho_unpreserve_free(ser);
 err_unlock:
@@ -432,27 +396,26 @@ static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 
 	ser = phys_to_virt(args->serialized_data);
 
-	memfd_luo_unpreserve_folios(&ser->folios, args->private_data,
-				    ser->nr_folios);
+	memfd_luo_unpreserve_folios(args->private_data);
+	kfree(args->private_data);
 
 	kho_unpreserve_free(ser);
 	inode_unlock(inode);
 }
 
-static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_ser,
-				     u64 nr_folios)
+/*
+ * Restore and free all folios in @map with keys starting from @start. @map must
+ * already be restored.
+ */
+static void memfd_luo_discard_folios(struct kho_map *map, u64 start)
 {
-	u64 i;
+	union memfd_luo_folio_ser entry;
+	u64 index;
 
-	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+	kho_map_for_each_from(map, index, entry.val, start) {
+		phys_addr_t phys = PFN_PHYS(entry.pfn);
 		struct folio *folio;
-		phys_addr_t phys;
 
-		if (!pfolio->pfn)
-			continue;
-
-		phys = PFN_PHYS(pfolio->pfn);
 		folio = kho_restore_folio(phys);
 		if (!folio) {
 			pr_warn_ratelimited("Unable to restore folio at physical address: %llx\n",
@@ -464,22 +427,25 @@ static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_se
 	}
 }
 
-/* Drop the references retrieve() holds on the folios added to the file. */
-static void
-memfd_luo_put_retrieved_folios(const struct memfd_luo_folio_ser *folios_ser,
-			       u64 nr_folios)
+/*
+ * Drop the references retrieve() holds on the folios added to the file, i.e.
+ * the folios in @map with keys below @end.
+ */
+static void memfd_luo_put_retrieved_folios(struct kho_map *map, u64 end)
 {
-	for (u64 i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+	union memfd_luo_folio_ser entry;
+	u64 index;
 
-		if (pfolio->pfn)
-			folio_put(pfn_folio(pfolio->pfn));
+	kho_map_for_each(map, index, entry.val) {
+		if (index >= end)
+			break;
+
+		folio_put(pfn_folio(entry.pfn));
 	}
 }
 
 static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 {
-	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
 
 	/* If retrieve failed, it already cleaned up everything it could. */
@@ -496,48 +462,51 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 		 * file so it can be used normally.
 		 */
 		struct inode *inode = file_inode(args->file);
-
-		folios_ser = args->private_data;
+		struct kho_map *retrieved = args->private_data;
 
 		inode_lock(inode);
-		memfd_luo_put_retrieved_folios(folios_ser, ser->nr_folios);
+		memfd_luo_put_retrieved_folios(retrieved, U64_MAX);
 		shmem_freeze(inode, false);
 		inode_unlock(inode);
 
-		vfree(folios_ser);
-	} else if (args->retrieve_status == 0 && ser->nr_folios) {
+		kho_map_destroy(retrieved);
+		kfree(retrieved);
+	} else {
 		/* Retrieve was not called, discard the preserved folios. */
-		folios_ser = kho_restore_vmalloc(&ser->folios);
-		if (folios_ser) {
-			memfd_luo_discard_folios(folios_ser, ser->nr_folios);
-			vfree(folios_ser);
+		struct kho_map folios;
+
+		if (kho_map_restore(&folios, &ser->folios)) {
+			pr_warn("Unable to restore folios map\n");
+			goto out;
 		}
+
+		memfd_luo_discard_folios(&folios, 0);
+		kho_map_destroy(&folios);
 	}
 
+out:
 	kho_restore_free(ser);
 }
 
-static int memfd_luo_retrieve_folios(struct file *file,
-				     struct memfd_luo_folio_ser *folios_ser,
-				     u64 nr_folios)
+/*
+ * Add the folios in @folios to @file. @folios must already be restored. On
+ * success, a reference is kept on each added folio, which is dropped in
+ * finish(). On failure, everything is cleaned up except @folios itself.
+ */
+static int memfd_luo_retrieve_folios(struct file *file, struct kho_map *folios)
 {
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
-	struct folio *folio;
 	long npages, nr_added_pages = 0;
+	union memfd_luo_folio_ser entry;
+	struct folio *folio;
 	int err = -EIO;
-	long i;
+	u64 index;
 
-	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
-		phys_addr_t phys;
-		u64 index;
-		int flags;
+	kho_map_for_each(folios, index, entry.val) {
+		phys_addr_t phys = PFN_PHYS(entry.pfn);
+		unsigned long flags = entry.flags;
 
-		if (!pfolio->pfn)
-			continue;
-
-		phys = PFN_PHYS(pfolio->pfn);
 		folio = kho_restore_folio(phys);
 		if (!folio) {
 			pr_err("Unable to restore folio at physical address: %llx\n",
@@ -545,8 +514,6 @@ static int memfd_luo_retrieve_folios(struct file *file,
 			err = -EIO;
 			goto put_folios;
 		}
-		index = pfolio->index;
-		flags = pfolio->flags;
 
 		/* Set up the folio for insertion. */
 		__folio_set_locked(folio);
@@ -554,16 +521,16 @@ static int memfd_luo_retrieve_folios(struct file *file,
 
 		err = mem_cgroup_charge(folio, NULL, mapping_gfp_mask(mapping));
 		if (err) {
-			pr_err("shmem: failed to charge folio index %ld: %d\n",
-			       i, err);
+			pr_err("shmem: failed to charge folio index %llu: %d\n",
+			       index, err);
 			goto unlock_folio;
 		}
 
 		err = shmem_add_to_page_cache(folio, mapping, index, NULL,
 					      mapping_gfp_mask(mapping));
 		if (err) {
-			pr_err("shmem: failed to add to page cache folio index %ld: %d\n",
-			       i, err);
+			pr_err("shmem: failed to add to page cache folio index %llu: %d\n",
+			       index, err);
 			goto unlock_folio;
 		}
 
@@ -575,8 +542,8 @@ static int memfd_luo_retrieve_folios(struct file *file,
 		npages = folio_nr_pages(folio);
 		err = shmem_inode_acct_blocks(inode, npages);
 		if (err) {
-			pr_err("shmem: failed to account folio index %ld(%ld pages): %d\n",
-			       i, npages, err);
+			pr_err("shmem: failed to account folio index %llu(%ld pages): %d\n",
+			       index, npages, err);
 			goto remove_from_cache;
 		}
 
@@ -603,21 +570,10 @@ static int memfd_luo_retrieve_folios(struct file *file,
 	 * Drop the references held on the folios already added to the file.
 	 * The folios themselves will be freed when the file is freed.
 	 */
-	memfd_luo_put_retrieved_folios(folios_ser, i);
+	memfd_luo_put_retrieved_folios(folios, index);
 
 	/* Free the ones not added yet here. */
-	for (long j = i + 1; j < nr_folios; j++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[j];
-		phys_addr_t phys;
-
-		if (!pfolio->pfn)
-			continue;
-
-		phys = PFN_PHYS(pfolio->pfn);
-		folio = kho_restore_folio(phys);
-		if (folio)
-			folio_put(folio);
-	}
+	memfd_luo_discard_folios(folios, index + 1);
 
 	shmem_recalc_inode(inode, nr_added_pages, 0);
 
@@ -626,8 +582,8 @@ static int memfd_luo_retrieve_folios(struct file *file,
 
 static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 {
-	struct memfd_luo_folio_ser *folios_ser = NULL;
 	struct memfd_luo_ser *ser;
+	struct kho_map *folios;
 	struct file *file;
 	int err;
 
@@ -672,25 +628,31 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	shmem_freeze(file_inode(file), true);
 	inode_unlock(file_inode(file));
 
-	if (ser->nr_folios) {
-		folios_ser = kho_restore_vmalloc(&ser->folios);
-		if (!folios_ser) {
-			err = -EINVAL;
-			goto put_file;
-		}
+	folios = kmalloc_obj(*folios);
+	if (!folios) {
+		err = -ENOMEM;
+		goto put_file;
+	}
 
-		err = memfd_luo_retrieve_folios(file, folios_ser, ser->nr_folios);
-		if (err)
-			goto free_folios_ser;
+	err = kho_map_restore(folios, &ser->folios);
+	if (err) {
+		pr_err("failed to restore folios map: %pe\n", ERR_PTR(err));
+		goto free_folios;
 	}
 
+	err = memfd_luo_retrieve_folios(file, folios);
+	if (err)
+		goto destroy_folios;
+
 	args->file = file;
-	args->private_data = folios_ser;
+	args->private_data = folios;
 
 	return 0;
 
-free_folios_ser:
-	vfree(folios_ser);
+destroy_folios:
+	kho_map_destroy(folios);
+free_folios:
+	kfree(folios);
 put_file:
 	fput(file);
 free_ser:
-- 
2.56.0.611.g1030f0b940-goog



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78B6606A31A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GMBQmPf0;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aF6xwySZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0rXX72QkkMNxUUHqhgUYPlP4XJOtkfbvlqTiUHhhmKA=; b=GMBQmPf0R26Yoq
	OKSXy0JDQ9rHN+tZM8HqBQNj6PwYSBELSJ9Qb5W9nq7iaNY9mDtM7v+LKMTR4EdNJ8V8Oe9S+7Vof
	KwTS2MNCEVUj1Xnwf2Okb/1ieAtjzuZx+Xn2L20/LKp8KFBVqHmST5mba4Qqa/BeA0zj4GePqOlyy
	AeYf1rxrP5eYVKo8khasY/CM9BqriSbz5kiVPE9E6tg2uzw/v6okDfbOqQaWpJEHlojpcDwv5YDuk
	oyjRd/4mJsyaTxFXfq3axS4IuLT9T1aflHOqK1FMnmPtXEvBmuohwIE39t03Roy13qnkccMdLHu0G
	wX/hfsziGNpxAfcsq+hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLl0w-00000005Sza-2GRr;
	Tue, 27 Oct 2026 17:31:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLl0u-00000005Syp-30c4
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 17:31:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2F39342DAB;
	Tue, 27 Oct 2026 17:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363341F01828;
	Tue, 27 Oct 2026 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793122268;
	bh=0rXX72QkkMNxUUHqhgUYPlP4XJOtkfbvlqTiUHhhmKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aF6xwySZZApmTdpaCXSatBfnZOOotDVkR8I9FkO8yyQ+Cs4uq13zPHKU/3ixjDepY
	 8JdleieyT5tKH9Y/pUSFeZRxl94f5TfnRu2sjweU96LACHrKcQQxK8CEwErEVpOnHy
	 rFpGUKDOZZTiXestura3Qyb8exjTZZdNHYYK3LxJGkSq3Sa0pDLJypB7epi5mhuEaD
	 r2UXNflmSzRbC2cNyxlrjXDe+XThO74Lt/uHmRnv/4p6kOinjIpDTzHo2T1/vSfHdU
	 BCtxgBWxGZ6fIb8iF52KdauoT5bJ3+d6B/CHlvovKVeXS9695U1D+TmplXLh0UNl1F
	 bXu0n9iDHSbsQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Subject: [PATCH 3/3] mm: shmem: use mapping_set_frozen() for memfd preservation
Date: Tue, 27 Oct 2026 18:30:28 +0100
Message-ID: <20261027173031.763213-4-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027173031.763213-1-pratyush@kernel.org>
References: <20261027173031.763213-1-pratyush@kernel.org>
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

memfd preservation via LUO freezes the shmem mapping with
SHMEM_F_MAPPING_FROZEN. That flag only blocks size changes and
fallocate(), so other paths can still change the page cache of a
preserved memfd. memfd_luo avoids it by pinning all folios and faulting
in all the holes.

The page cache now natively supports freezing mappings. Switch over the
code to use that instead.

Disallow any type of truncation on frozen mappings, even one with same
size, since it might drop fallocated folios past EOF, and would fail in
shmem_undo_range() with a warning.

memfd_luo_preserve() now freezes the mapping after grabbing the folios,
instead of before. The grabbing fills holes in the file and may migrate
folios, both of which a frozen mapping refuses. The inode lock is held
throughout, so truncate, fallocate and writes can't change the file in
between.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/shmem_fs.h | 17 -----------------
 mm/memfd_luo.c           | 11 ++++++++---
 mm/shmem.c               | 15 +++++++--------
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index a7c7a96a7cbf9..5b48598a7b952 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -23,14 +23,6 @@
 #define SHMEM_F_NORESERVE	BIT(0)
 /* Disallow swapping. */
 #define SHMEM_F_LOCKED		BIT(1)
-/*
- * Disallow growing, shrinking, or hole punching in the inode. Combined with
- * folio pinning, makes sure the inode's mapping stays fixed.
- *
- * In some ways similar to F_SEAL_GROW | F_SEAL_SHRINK, but can be removed and
- * isn't directly visible to userspace.
- */
-#define SHMEM_F_MAPPING_FROZEN	BIT(2)
 
 struct shmem_inode_info {
 	spinlock_t		lock;
@@ -202,15 +194,6 @@ static inline bool shmem_file(struct file *file)
 	return shmem_mapping(file->f_mapping);
 }
 
-/* Must be called with inode lock taken exclusive. */
-static inline void shmem_freeze(struct inode *inode, bool freeze)
-{
-	if (freeze)
-		SHMEM_I(inode)->flags |= SHMEM_F_MAPPING_FROZEN;
-	else
-		SHMEM_I(inode)->flags &= ~SHMEM_F_MAPPING_FROZEN;
-}
-
 /*
  * If fallocate(FALLOC_FL_KEEP_SIZE) has been used, there may be pages
  * beyond i_size's notion of EOF, which fallocate has committed to reserving:
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index fe182d5057890..ec5abd41ecb8b 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -84,6 +84,7 @@
 #include <linux/swap.h>
 #include <linux/vmalloc.h>
 #include <linux/memfd.h>
+#include <linux/pagemap.h>
 #include <uapi/linux/memfd.h>
 
 #include "internal.h"
@@ -323,7 +324,6 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	int err = 0, seals;
 
 	inode_lock(inode);
-	shmem_freeze(inode, true);
 
 	/* Allocate the main serialization structure in preserved memory */
 	ser = kho_alloc_preserve(sizeof(*ser));
@@ -355,6 +355,12 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	if (err)
 		goto err_free_ser;
 
+	/*
+	 * All the folios in the file are now stable. Freeze the mapping to make
+	 * sure new ones can't be added.
+	 */
+	mapping_set_frozen(inode->i_mapping);
+
 	ser->nr_folios = nr_folios;
 	inode_unlock(inode);
 
@@ -366,7 +372,6 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 err_free_ser:
 	kho_unpreserve_free(ser);
 err_unlock:
-	shmem_freeze(inode, false);
 	inode_unlock(inode);
 	return err;
 }
@@ -398,7 +403,7 @@ static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 		return;
 
 	inode_lock(inode);
-	shmem_freeze(inode, false);
+	mapping_clear_frozen(inode->i_mapping);
 
 	ser = phys_to_virt(args->serialized_data);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 6507b4246c8af..1c70fd306bec2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1570,8 +1570,6 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 			return -EPERM;
 
 		if (newsize != oldsize) {
-			if (info->flags & SHMEM_F_MAPPING_FROZEN)
-				return -EPERM;
 			error = shmem_reacct_size(SHMEM_I(inode)->flags,
 					oldsize, newsize);
 			if (error)
@@ -1583,6 +1581,11 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 		}
 		if (newsize <= oldsize) {
 			loff_t holebegin = round_up(newsize, PAGE_SIZE);
+
+			/* No truncation allowed on a frozen mapping. */
+			if (mapping_frozen(inode->i_mapping))
+				return -EBUSY;
+
 			if (oldsize > holebegin)
 				unmap_mapping_range(inode->i_mapping,
 							holebegin, 0, 1);
@@ -3482,10 +3485,6 @@ shmem_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 			return -EPERM;
 	}
 
-	if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
-		     pos + len > inode->i_size))
-		return -EPERM;
-
 	ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
 	if (ret)
 		return ret;
@@ -3860,8 +3859,8 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 
 	inode_lock(inode);
 
-	if (info->flags & SHMEM_F_MAPPING_FROZEN) {
-		error = -EPERM;
+	if (mapping_frozen(inode->i_mapping)) {
+		error = -EBUSY;
 		goto out;
 	}
 
-- 
2.56.0.307.g5fe7bd680c-goog



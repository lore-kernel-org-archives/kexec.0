Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624C9E83821
	for <kexec@archiver.kernel.org>; Mon, 16 Feb 2026 19:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wnvj/HkYJBtIyNZW9YmFC2m8Xgq/jLT4NAZgHs+lqUw=; b=c6rNiZwiWA+VRo/1uOSW+09a/J
	LLaWygVDPHX+8PbgDE6jUuZYVHWKrUm4/zkf7/LfF+YDsH6q6hl4jcob8S4xIV7jW6Un9BC1zFckd
	1JjYAKqnZ0zR8eNRwCOxYJGMNYv9+g2kW3PrvZCYvR2OZv/9VJJ3Z3v+q4AYveqF2Y4mu+0nWjyk5
	K/JspBpd7RPEGhVo5f5/rlkSaA32NDn7u8Xm7v+izwh1slsqQ0/DWR7bRK1u0ZoZI3ypet9wt6zUE
	PCR5TvSUR8O6r5edDwOt0TAvt87uodHpBOWF8fBL0YKVArwYLrUXD50ukGTkaP+GFtPAFTyILZD7N
	6Du6zSMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs3pG-00000007Av2-26Ei;
	Mon, 16 Feb 2026 19:00:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs3pF-00000007AuO-0FOC
	for kexec@lists.infradead.org;
	Mon, 16 Feb 2026 19:00:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 78B7E60145;
	Mon, 16 Feb 2026 19:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C246C2BC86;
	Mon, 16 Feb 2026 19:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771268404;
	bh=rDOaaAXfsrj1RbVbSoaAqlUcovoTYZIHYJI6Tev+jiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WB0rrATCc8Fbi5vyGG8WQkNokaNW1LgErS/3q32Ighfuf0ahEGDeJY9f6O/Se2cuo
	 CTXwAVY4Vkd/yhyQ2LEo6iz/dKeafOBFuVBLApOwWRxwHSl33QfG4qtG4p5X8Lnddp
	 FAUbjSrRxJYtpGjrWOqXZY4PgvloHvg2jOJi7QmIDacsAbydDVEzAnXxchRaIKA+ic
	 AcU+782hhuzKCsU8YUzWUFxtx+nhsTeRVpsk02QNYKk824asOqIshbCZzjqs453VAg
	 QzObg1aBpfVZZ5ma2OyOlf0j1dj+bJXM07jn1t/05mbhcQBsJlcOwK/jen7HfOkUgk
	 w0Az9nnUvBxmQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm: memfd_luo: preserve file seals
Date: Mon, 16 Feb 2026 19:59:33 +0100
Message-ID: <20260216185946.1215770-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
In-Reply-To: <20260216185946.1215770-1-pratyush@kernel.org>
References: <20260216185946.1215770-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

File seals are used on memfd for making shared memory communication with
untrusted peers safer and simpler. Seals provide a guarantee that
certain operations won't be allowed on the file such as writes or
truncations. Maintaining these guarantees across a live update will help
keeping such use cases secure.

These guarantees will also be needed for IOMMUFD preservation with LUO.
Normally when IOMMUFD maps a memfd, it pins all its pages to make sure
any truncation operations on the memfd don't lead to IOMMUFD using freed
memory. This doesn't work with LUO since the preserved memfd might have
completely different pages after a live update, and mapping them back to
the IOMMUFD will cause all sorts of problems. Using and preserving the
seals allows IOMMUFD preservation logic to trust the memfd.

Since the uABI defines seals as an int, preserve them by introducing a
new u32 field. There are currently only 6 possible seals, so the extra
bits are unused and provide room for future expansion. Since the seals
are uABI, it is safe to use them directly in the ABI. While at it, also
add a u32 flags field. It makes sure the struct is nicely aligned, and
can be used later to support things like MFD_CLOEXEC.

Since the serialization structure is changed, bump the version number to
"memfd-v2".

It is important to note that the memfd-v2 version only supports seals
that existed when this version was defined. This set is defined by
MEMFD_LUO_ALL_SEALS. Any new seal might bring a completely different
semantic with it and the parser for memfd-v2 cannot be expected to deal
with that. If there are any future seals added, they will need another
version bump.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kho/abi/memfd.h | 18 +++++++++++++++++-
 mm/memfd_luo.c                | 35 +++++++++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 68cb6303b846..08b10fea2afc 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -56,10 +56,24 @@ struct memfd_luo_folio_ser {
 	u64 index;
 } __packed;
 
+/*
+ * The set of seals this version supports preserving. If support for any new
+ * seals is needed, add it here and bump version.
+ */
+#define MEMFD_LUO_ALL_SEALS (F_SEAL_SEAL | \
+			     F_SEAL_SHRINK | \
+			     F_SEAL_GROW | \
+			     F_SEAL_WRITE | \
+			     F_SEAL_FUTURE_WRITE | \
+			     F_SEAL_EXEC)
+
 /**
  * struct memfd_luo_ser - Main serialization structure for a memfd.
  * @pos:       The file's current position (f_pos).
  * @size:      The total size of the file in bytes (i_size).
+ * @seals:     The seals present on the memfd. The seals are uABI so it is safe
+ *             to directly use them in the ABI.
+ * @flags:     Flags for the file. Unused flag bits must be set to 0.
  * @nr_folios: Number of folios in the folios array.
  * @folios:    KHO vmalloc descriptor pointing to the array of
  *             struct memfd_luo_folio_ser.
@@ -67,11 +81,13 @@ struct memfd_luo_folio_ser {
 struct memfd_luo_ser {
 	u64 pos;
 	u64 size;
+	u32 seals;
+	u32 flags;
 	u64 nr_folios;
 	struct kho_vmalloc folios;
 } __packed;
 
 /* The compatibility string for memfd file handler */
-#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v1"
+#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
 
 #endif /* _LINUX_KHO_ABI_MEMFD_H */
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index a34fccc23b6a..1089dbcf5ca6 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -79,6 +79,8 @@
 #include <linux/shmem_fs.h>
 #include <linux/vmalloc.h>
 #include <linux/memfd.h>
+#include <uapi/linux/memfd.h>
+
 #include "internal.h"
 
 static int memfd_luo_preserve_folios(struct file *file,
@@ -222,7 +224,7 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
 	u64 nr_folios;
-	int err = 0;
+	int err = 0, seals;
 
 	inode_lock(inode);
 	shmem_freeze(inode, true);
@@ -234,8 +236,21 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 		goto err_unlock;
 	}
 
+	seals = memfd_get_seals(args->file);
+	if (seals < 0) {
+		err = seals;
+		goto err_free_ser;
+	}
+
+	/* Make sure the file only has the seals supported by this version. */
+	if (seals & ~MEMFD_LUO_ALL_SEALS) {
+		err = -EOPNOTSUPP;
+		goto err_free_ser;
+	}
+
 	ser->pos = args->file->f_pos;
 	ser->size = i_size_read(inode);
+	ser->seals = seals;
 
 	err = memfd_luo_preserve_folios(args->file, &ser->folios,
 					&folios_ser, &nr_folios);
@@ -444,13 +459,29 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	if (!ser)
 		return -EINVAL;
 
-	file = memfd_alloc_file("", 0);
+	/* Make sure the file only has seals supported by this version. */
+	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
+		err = -EOPNOTSUPP;
+		goto free_ser;
+	}
+
+	/*
+	 * The seals are preserved. Allow sealing here so they can be added
+	 * later.
+	 */
+	file = memfd_alloc_file("", MFD_ALLOW_SEALING);
 	if (IS_ERR(file)) {
 		pr_err("failed to setup file: %pe\n", file);
 		err = PTR_ERR(file);
 		goto free_ser;
 	}
 
+	err = memfd_add_seals(file, ser->seals);
+	if (err) {
+		pr_err("failed to add seals: %pe\n", ERR_PTR(err));
+		goto put_file;
+	}
+
 	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
 	file->f_inode->i_size = ser->size;
 
-- 
2.53.0.335.g19a08e0c02-goog



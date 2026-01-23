Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3280DD7236B
	for <kexec@archiver.kernel.org>; Fri, 23 Jan 2026 09:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6hw+/r3HAiYrTGWwcntrPr2cywMCf4Arlv4MVexb0BQ=; b=MDGMTsRoNNCghbQ9SiIaF0fYU9
	hwkNRnnoa+1m2VnZHyVQYI2vO/XB7lERgcMVGJ+8OemRqya4A/REtlrS6beuL2rFiNAJqVgulJBDa
	POZ64Mqh8OZUH5/Sh6QTqu1TjH6Mt0JJtMCdf753hH8GuWrzJ+NJC7GDEvL/bWLM9mY8B4Ne6Unvn
	aFsCUY3wR+PM2QItB/TJLWs8p8ZnmjIPx+fx2wsAObybKBEcNujvHeiV63qHkAGvlj9MaobULRdSg
	m33rteft085RngWQU5wSUnQdPr4TwDsomiTaa2sHR819xW1oFY/3yNPRBEGO8gYkinVgZ89y3hdtp
	UivmMYFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjDwf-00000008f47-3brT;
	Fri, 23 Jan 2026 09:59:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjDwd-00000008f2K-358S
	for kexec@lists.infradead.org;
	Fri, 23 Jan 2026 09:59:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6DCA2442A2;
	Fri, 23 Jan 2026 09:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E86C4CEF1;
	Fri, 23 Jan 2026 09:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769162351;
	bh=1YfoW2OKTDLDdQexCVzUsywJpWB4iHKtpLSFlvpGsVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADfhbIZTSW/JeHR3m/hz+tmXTOVNIVfm+MKoDbN+kLAceLLgcSgGVmiFUwx+c+zcY
	 FC5L7IfKDwsbAqBAksQ6Yk4y6gVTtG7esgGKTU3o4wPt/TCtdh7fXxpDmSXhFJi3Bw
	 Kl/hP7XfTv20AtEEn1vfEgbgmh0TP1GMTkIYJCyc2fj8xglrmb7uH0HSgWlIvPW1hs
	 0JVk6V2QLP11QJAhxWozOh2KbEDeTmrhvjmD9vr3tN+BuEVLNBd4z2R4eRiUzgspV2
	 JMLAk7RMMJROoinzwI+5QqxR8KTz4imQSg2wN1KdiSdw/s9IKfGV5i9pH0tdES+VH2
	 yz/w/e4tN1+PA==
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
Subject: [PATCH 2/2] mm: memfd_luo: preserve file seals
Date: Fri, 23 Jan 2026 10:58:51 +0100
Message-ID: <20260123095854.535058-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260123095854.535058-1-pratyush@kernel.org>
References: <20260123095854.535058-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260123_015911_817179_01D21CDC 
X-CRM114-Status: GOOD (  20.57  )
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

Preserve the seals by introducing a new 8-bit-wide bitfield. There are
currently only 6 possible seals but 2 extra bits are used to provide
room for future expansion. Since the seals are UAPI, it is safe to use
them directly in the ABI.

Back the 8-bit field with a u64, leaving 56 unused bits. This is done to
keep the struct nice and aligned. The unused bits can be used to add new
flags later, potentially without even needing to bump the version
number.

Since the serialization structure is changed, bump the version number to
"memfd-v2".

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kho/abi/memfd.h |  9 ++++++++-
 mm/memfd_luo.c                | 23 +++++++++++++++++++++--
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 68cb6303b846..bd549c81f1d2 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -60,6 +60,11 @@ struct memfd_luo_folio_ser {
  * struct memfd_luo_ser - Main serialization structure for a memfd.
  * @pos:       The file's current position (f_pos).
  * @size:      The total size of the file in bytes (i_size).
+ * @seals:     The seals present on the memfd. The seals are UAPI so it is safe
+ *             to directly use them in the ABI. Note: currently there are 6
+ *             seals possible but this field is 8 bits to leave room for future
+ *             expansion.
+ * @__reserved: Reserved bits. May be used later to add more flags.
  * @nr_folios: Number of folios in the folios array.
  * @folios:    KHO vmalloc descriptor pointing to the array of
  *             struct memfd_luo_folio_ser.
@@ -67,11 +72,13 @@ struct memfd_luo_folio_ser {
 struct memfd_luo_ser {
 	u64 pos;
 	u64 size;
+	u64 seals:8;
+	u64 __reserved:56;
 	u64 nr_folios;
 	struct kho_vmalloc folios;
 } __packed;
 
 /* The compatibility string for memfd file handler */
-#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v1"
+#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
 
 #endif /* _LINUX_KHO_ABI_MEMFD_H */
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index a34fccc23b6a..eb68e0b5457f 100644
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
@@ -234,8 +236,15 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 		goto err_unlock;
 	}
 
+	seals = memfd_get_seals(args->file);
+	if (seals < 0) {
+		err = seals;
+		goto err_free_ser;
+	}
+
 	ser->pos = args->file->f_pos;
 	ser->size = i_size_read(inode);
+	ser->seals = seals;
 
 	err = memfd_luo_preserve_folios(args->file, &ser->folios,
 					&folios_ser, &nr_folios);
@@ -444,13 +453,23 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	if (!ser)
 		return -EINVAL;
 
-	file = memfd_alloc_file("", 0);
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
2.52.0.457.g6b5491de43-goog



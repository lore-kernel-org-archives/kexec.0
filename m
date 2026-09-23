Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B58C9830D
	for <kexec@archiver.kernel.org>; Wed, 23 Sep 2026 22:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5nQ+hBf6qVec8z+IXo2hdLde0/quAUf4P/g17WYv1iw=; b=yi5F/4udTMVQWnNR4OJ0pBrdyk
	iDC6uGCyQpQLfWOJW262qpZ3FySa7HM29fW5nMtNJqG0UCJwj9qH4fdr2UrdFruWwR1D7H7Yxr6T+
	kK7c19d/COlWScrwwMF2zz+Hz8ZtxVk8d2nziSdOEVD6CYCDZludq1R3dpWVD2BUgHspYCcRequo+
	WIVdtQMRziw4p0swXt/P8NtClUMkDtAN1POUWFG/ABMLkFKqSD5YoSFYS+U23xoBEvPXWkH4+doyt
	b+pK3nm/MIeV5BaymP+D79tVvH2FCkCBxQyY/u9O+IcQU9L0U9785eRpkrYOnU8O4WHXezds5gkZa
	f6CBKsgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9VhT-00000009fc7-38wb;
	Wed, 23 Sep 2026 22:44:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9VhS-00000009fbW-0vQH
	for kexec@lists.infradead.org;
	Wed, 23 Sep 2026 22:44:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5695560216;
	Wed, 23 Sep 2026 22:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D4C1F000FF;
	Wed, 23 Sep 2026 22:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790203465;
	bh=5nQ+hBf6qVec8z+IXo2hdLde0/quAUf4P/g17WYv1iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i6SWVv8JLcwPyjTj/ZDmJk2VviUSkDwPsJXxoiR+68IM0XkG2b/fK11NvvSzU1pUr
	 1QY4Nv5LrjQFn+aUKbtb0oehm0nI8M4hQNRrQSnb8f8Vk+4Nwg61O4TVn/5bfO7kDG
	 WRJgBF0aN5ghNfbptXbCvvvM/IHl2/k3bBVfQ699CFcZgTxhuMoaxWde76uHDTD1AJ
	 esysnoUGA8ha6czLuP7V5/2FL0G7zB6+NtUSaKQ3nVu9yEO/Hgi0kQpXMymT0AF2xx
	 a4L+ue7xBokmi5+T5BLMctK8w6q7SJ7KjPf+fDarlrpngQ2DmuhEyTyjGKQyUoeMR1
	 gbdRrYSdIIc0Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/6] shmem: add tmpfs_create_mount() to create tmpfs mounts internally
Date: Thu, 24 Sep 2026 00:44:01 +0200
Message-ID: <20260923224408.3745689-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923224408.3745689-1-pratyush@kernel.org>
References: <20260923224408.3745689-1-pratyush@kernel.org>
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

Upcoming commits will add support for preserving a tmpfs mount via LUO.
While the retrieve logic can create the mount by constructing an options
string from its preserved data, it is simpler to let it directly pass
the parameters.

tmpfs_create_mount() allows creating a mount with the specified
max_blocks and mode. The function only takes max_blocks and mode for now
because that is all the tmpfs preservation will use. All other values
are left to their defaults.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 mm/internal.h |  1 +
 mm/shmem.c    | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index 38b1165212c9..d82c92c8fddd 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1436,6 +1436,7 @@ int shmem_add_to_page_cache(struct folio *folio,
 			    pgoff_t index, void *expected, gfp_t gfp);
 int shmem_inode_acct_blocks(struct inode *inode, long pages);
 bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped);
+struct vfsmount *tmpfs_create_mount(unsigned long max_blocks, umode_t mode);
 
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
diff --git a/mm/shmem.c b/mm/shmem.c
index 897fa2b61346..8660405b6ab8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5313,6 +5313,44 @@ static struct file_system_type shmem_fs_type = {
 	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 
+/**
+ * tmpfs_create_mount - Create a new tmpfs instance from explicit parameters.
+ * @max_blocks: Block limit of the filesystem, in PAGE_SIZE units, as held by
+ *              shmem_sb_info::max_blocks.
+ * @mode:       Mode of the root directory.
+ *
+ * Creates a new tmpfs superblock and returns a mount for it. Everything not
+ * named above is left at its default.
+ *
+ * The returned mount belongs to no mount namespace and is owned by the caller,
+ * who must either mntput() it or hand it to something that takes it over.
+ *
+ * Return: the new mount, or an ERR_PTR.
+ */
+struct vfsmount *tmpfs_create_mount(unsigned long max_blocks, umode_t mode)
+{
+	struct shmem_options *ctx;
+	struct fs_context *fc;
+	struct vfsmount *mnt;
+
+	if (!IS_ENABLED(CONFIG_TMPFS))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	fc = fs_context_for_mount(&shmem_fs_type, 0);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
+
+	ctx = fc->fs_private;
+	ctx->blocks = max_blocks;
+	ctx->seen |= SHMEM_SEEN_BLOCKS;
+	ctx->mode = mode;
+
+	mnt = fc_mount(fc);
+	put_fs_context(fc);
+
+	return mnt;
+}
+
 #if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)
 
 #define __INIT_KOBJ_ATTR(_name, _mode, _show, _store)			\
-- 
2.56.0.rc1.310.g51773c2048-goog



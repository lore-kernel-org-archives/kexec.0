Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E3DC9830D
	for <kexec@archiver.kernel.org>; Wed, 23 Sep 2026 22:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TG50/Oj6obc8zTFrv/jURXZ3Tcj121N/yUWt0s9C2mM=; b=Rm/AhpM+dvWY23Q+OdPgEBh1aA
	tej8cmtSSb2E1ObngnPbWQWdg91jXxLAb2FdxrJKP+ZBbqjdWgDyQm9a97HHtqppHaSo2SDYnSqpc
	SJ9UhgYPHZsMKJ5EAx/mCI/TVAxSPEkZyck8/YuNpOfzXuBOyyTcKfzo0zxcXQYJA8np7HSnPLHzG
	VgwnTZWWjNdPCIxO/bv6DE45+AOpUl2fZ9pq14pdc9j469XbuhoViF3Vhj3Ux8qm0upF8RQdMa2mw
	jMWs6ZPtL2Ah53Zm9Sq1Ep5YnDQaCBp4iiE/PUBbU4ro5G+aTegsBeTNGkA2uwtZWrF0PKDkMTnhH
	JrYuuAxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9VhY-00000009fea-3o2c;
	Wed, 23 Sep 2026 22:44:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9VhX-00000009fdb-1LyD
	for kexec@lists.infradead.org;
	Wed, 23 Sep 2026 22:44:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B3EA26021E;
	Wed, 23 Sep 2026 22:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BA51F000FF;
	Wed, 23 Sep 2026 22:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790203470;
	bh=TG50/Oj6obc8zTFrv/jURXZ3Tcj121N/yUWt0s9C2mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NEtO2rLNYVXZMv8r5AhB1e8KxUAjgw2pw4WHDdKLtR5m7AGMbRnG4Oalfr1s5P5Vw
	 BFuuwCXaEItYhL18UnClzyKxlIUyX8u2qMyYKcTrB1LPc8oQtd2dpze3rSIRHsD5ji
	 k83hcubX09ocbH5Xq58qFgcCf0BwVYFVuaN/hfZ5m2zyuUHu/FQZA9kY7HV8orxI9S
	 m/kIamQfGD7uQzrD3txboo8boabrvHfu/LQqz0hjq+8MttBOVahtKNVOCSQrtyd1eQ
	 JPjVVlJ5blLHAxkIHF2nVDfAEAuq+V3v6qRgHr/d2aFRQmRrRD0fF10lIvIAQFUzlj
	 oTSD9afL6GQaw==
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
Subject: [RFC PATCH 4/6] mm/memfd_luo: allow preserving a tmpfs mount
Date: Thu, 24 Sep 2026 00:44:03 +0200
Message-ID: <20260923224408.3745689-5-pratyush@kernel.org>
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

A memfd can be preserved across a live update, but it has no name, so
anything that needs a filesystem path cannot use one.

The main use case is to fetch VMM binaries that need to be kept on the
host memory during a live update to avoid the latency of fetching them
from network. The host does not have any attached local storage to store
the binaries.

Allow preserving a tmpfs mount. The mount is identified with a file
pointing to it. Only preserve the number of blocks and root directory
mode. All other options are reset to their default values and can be set
up again by a remount. The retrieved file points to a detached mount
that can be attached to a path with move_mount(2).

Mounts with memory policies, quotas, ID mappings, and casefolding are
not supported.

Move SHMEM_SB() into shmem_fs.h to it can be used in memfd_luo.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 Documentation/core-api/liveupdate.rst   |   1 +
 Documentation/mm/index.rst              |   1 +
 Documentation/mm/tmpfs_preservation.rst |  24 +++
 MAINTAINERS                             |   1 +
 include/linux/kho/abi/tmpfs.h           |  48 +++++
 include/linux/shmem_fs.h                |   5 +
 mm/memfd_luo.c                          | 238 +++++++++++++++++++++++-
 mm/shmem.c                              |   5 -
 8 files changed, 315 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/mm/tmpfs_preservation.rst
 create mode 100644 include/linux/kho/abi/tmpfs.h

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 5a292d0f3706..c92a0a8f6b90 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -34,6 +34,7 @@ The following types of file descriptors can be preserved
    :maxdepth: 1
 
    ../mm/memfd_preservation
+   ../mm/tmpfs_preservation
 
 Public API
 ==========
diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index 13a79f5d092c..46c83fa8db8a 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -72,6 +72,7 @@ documentation, or deleted if it has served its purpose.
    page_table_check
    remap_file_pages
    split_page_table_lock
+   tmpfs_preservation
    transhuge
    unevictable-lru
    vmalloced-kernel-stacks
diff --git a/Documentation/mm/tmpfs_preservation.rst b/Documentation/mm/tmpfs_preservation.rst
new file mode 100644
index 000000000000..0c7f5bdaf7ee
--- /dev/null
+++ b/Documentation/mm/tmpfs_preservation.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==========================
+tmpfs Preservation via LUO
+==========================
+
+.. kernel-doc:: mm/memfd_luo.c
+   :doc: tmpfs Preservation via LUO
+
+tmpfs Preservation ABI
+======================
+
+.. kernel-doc:: include/linux/kho/abi/tmpfs.h
+   :doc: tmpfs Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/tmpfs.h
+   :internal:
+
+See Also
+========
+
+- :doc:`/mm/memfd_preservation`
+- :doc:`/core-api/liveupdate`
+- :doc:`/core-api/kho/index`
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..0527e92fd7ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15185,6 +15185,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	Documentation/core-api/liveupdate.rst
 F:	Documentation/mm/memfd_preservation.rst
+F:	Documentation/mm/tmpfs_preservation.rst
 F:	Documentation/userspace-api/liveupdate.rst
 F:	include/linux/kho/abi/
 F:	include/linux/liveupdate.h
diff --git a/include/linux/kho/abi/tmpfs.h b/include/linux/kho/abi/tmpfs.h
new file mode 100644
index 000000000000..bed41048a19b
--- /dev/null
+++ b/include/linux/kho/abi/tmpfs.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2026, Google LLC.
+ * Pratyush Yadav <pratyush@kernel.org>
+ */
+
+#ifndef _LINUX_KHO_ABI_TMPFS_H
+#define _LINUX_KHO_ABI_TMPFS_H
+
+#include <linux/limits.h>
+#include <linux/types.h>
+#include <linux/kho/abi/kexec_handover.h>
+#include <linux/kho/abi/memfd.h>
+
+/**
+ * DOC: tmpfs Live Update ABI
+ *
+ * tmpfs uses the ABI defined below for preserving a mount and the regular
+ * files in it across a kexec reboot using the LUO.
+ *
+ * The mount metadata is preserved via `tmpfs_luo_mnt_ser`.
+ *
+ * This interface is a contract. Any modification to the structure layout
+ * constitutes a breaking change. Such changes require incrementing the version
+ * number in the corresponding compatible string.
+ */
+
+/**
+ * struct tmpfs_luo_mnt_ser - Serialized state of a preserved tmpfs mount.
+ * @max_blocks: The block limit of the filesystem in PAGE_SIZE units. 0 means
+ *              unlimited.
+ * @mode:       The mode of the root directory.
+ * @flags:      Flags for the mount. Unused flag bits must be set to 0.
+ *
+ * Ownership is not preserved; the restored root directory belongs to whoever
+ * retrieves the mount.
+ */
+struct tmpfs_luo_mnt_ser {
+	u64 max_blocks;
+	u32 mode;
+	u32 flags;
+} __packed;
+
+/* The compatibility string for the tmpfs mount file handler */
+#define TMPFS_LUO_MNT_FH_COMPATIBLE	"tmpfs-mnt-v1"
+
+#endif /* _LINUX_KHO_ABI_TMPFS_H */
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 5663dff53186..d41d38541c73 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -95,6 +95,11 @@ static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
 	return container_of(inode, struct shmem_inode_info, vfs_inode);
 }
 
+static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
 /*
  * Functions in mm/shmem.c called directly from elsewhere:
  */
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 59de210bee5f..f29571666364 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -71,12 +71,19 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bits.h>
+#include <linux/dcache.h>
 #include <linux/err.h>
 #include <linux/file.h>
+#include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/memfd.h>
+#include <linux/kho/abi/tmpfs.h>
+#include <linux/limits.h>
 #include <linux/liveupdate.h>
+#include <linux/magic.h>
+#include <linux/mount.h>
+#include <linux/quotaops.h>
 #include <linux/shmem_fs.h>
 #include <linux/vmalloc.h>
 #include <linux/memfd.h>
@@ -606,17 +613,242 @@ static struct liveupdate_file_handler memfd_luo_handler = {
 	.compatible = MEMFD_LUO_FH_COMPATIBLE,
 };
 
+/**
+ * DOC: tmpfs Preservation via LUO
+ *
+ * Overview
+ * ========
+ *
+ * tmpfs mounts can be preserved via LUO. This allows userspace to preserve an
+ * in-memory filesystem across kexec.
+ *
+ * Preservation is not transparent. Only the properties listed below survive;
+ * everything else comes back at its default.
+ *
+ * Preserving
+ * ==========
+ *
+ * A mount is preserved through a file descriptor for its root. An ``O_PATH``
+ * descriptor is rejected, so one obtained from fsmount(2) has to be reopened
+ * first with ``openat(fsmount_fd, ".", O_RDONLY | O_DIRECTORY)``.
+ *
+ * Mounts with memory policies, id mappings, quotas, and casefolding are not
+ * supported.
+ *
+ * Attaching a memory policy after preserve will fail the freeze.
+ *
+ * Restoring
+ * =========
+ *
+ * The mount comes back as a detached mount file descriptor with the same
+ * semantics as fsmount(2). Userspace attaches it with::
+ *
+ *	move_mount(fd, "", AT_FDCWD, "/some/path", MOVE_MOUNT_F_EMPTY_PATH);
+ *
+ * Closing the mount descriptor without ever attaching it tears the mount down,
+ * and everything in it goes too.
+ *
+ * Like fsmount(2)'s, the restored mount descriptor is an ``O_PATH`` one, so
+ * preserving the same mount again for a second live update means reopening its
+ * root.
+ *
+ * Preserved Properties
+ * ====================
+ *
+ * ``nr_blocks=``:
+ *   The block limit. Restoring file contents is charged against it.
+ *
+ * Root directory mode
+ *   Including the sticky and setgid bits.
+ *
+ * Not Preserved
+ * =============
+ *
+ * All properties which are not preserved must be assumed to be reset to
+ * default. This section describes some of those properties which may be more of
+ * note.
+ *
+ * Ownership
+ *   Everything comes back owned by whoever retrieves it. If different ownership
+ *   is needed, userspace must do that after retrieving the mount.
+ *
+ * Timestamps, inode numbers, extended attributes and ACLs
+ *   A restored mount root is a new inode with fresh timestamps and a new
+ *   number. utimensat(2) can set the timestamps again once the mount is
+ *   attached.
+ */
+
+static unsigned long tmpfs_luo_mnt_id(struct super_block *sb)
+{
+	return (unsigned long)sb;
+}
+
+static bool tmpfs_luo_mnt_can_preserve(struct liveupdate_file_handler *fh,
+				       struct file *file)
+{
+	struct vfsmount *mnt = file->f_path.mnt;
+	struct super_block *sb = mnt->mnt_sb;
+
+	if (sb->s_magic != TMPFS_MAGIC)
+		return false;
+
+	/* The root of a whole filesystem, not a bind mount of a subdirectory. */
+	if (file->f_path.dentry != mnt->mnt_root || mnt->mnt_root != sb->s_root)
+		return false;
+
+	/* These features are not supported. */
+	if (SHMEM_SB(sb)->mpol || sb_has_quota_active(sb, USRQUOTA) ||
+	    sb_has_encoding(sb) || is_idmapped_mnt(mnt))
+		return false;
+
+	return true;
+}
+
+static unsigned long tmpfs_luo_mnt_get_id(struct file *file)
+{
+	return tmpfs_luo_mnt_id(file->f_path.mnt->mnt_sb);
+}
+
+static int tmpfs_luo_mnt_preserve(struct liveupdate_file_op_args *args)
+{
+	struct tmpfs_luo_mnt_ser *ser;
+
+	ser = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	/*
+	 * ser only saves mode and max_blocks. Since they can change by a
+	 * remount, save them on freeze(). So nothing to save for now.
+	 */
+	args->serialized_data = virt_to_phys(ser);
+
+	return 0;
+}
+
+static int tmpfs_luo_mnt_freeze(struct liveupdate_file_op_args *args)
+{
+	struct super_block *sb = args->file->f_path.mnt->mnt_sb;
+	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+	struct tmpfs_luo_mnt_ser *ser;
+
+	/*
+	 * A remount can install a memory policy after can_preserve() accepted
+	 * the mount.
+	 */
+	if (sbinfo->mpol)
+		return -EOPNOTSUPP;
+
+	ser = phys_to_virt(args->serialized_data);
+	ser->max_blocks = sbinfo->max_blocks;
+	ser->mode = sbinfo->mode & 07777;
+
+	return 0;
+}
+
+static void tmpfs_luo_mnt_unpreserve(struct liveupdate_file_op_args *args)
+{
+	kho_unpreserve_free(phys_to_virt(args->serialized_data));
+}
+
+static int tmpfs_luo_mnt_retrieve(struct liveupdate_file_op_args *args)
+{
+	struct tmpfs_luo_mnt_ser *ser;
+	struct vfsmount *mnt;
+	struct file *file;
+	int err;
+
+	if (!args->serialized_data)
+		return -EINVAL;
+
+	ser = phys_to_virt(args->serialized_data);
+
+	if ((ser->mode & ~07777) || ser->flags) {
+		err = -EINVAL;
+		goto free_ser;
+	}
+
+	mnt = tmpfs_create_mount(ser->max_blocks, ser->mode);
+	if (IS_ERR(mnt)) {
+		pr_err("failed to create tmpfs mount: %pe\n", mnt);
+		err = PTR_ERR(mnt);
+		goto free_ser;
+	}
+
+	file = vfs_open_detached_mount(mnt);
+	if (IS_ERR(file)) {
+		pr_err("failed to open detached tmpfs mount: %pe\n", file);
+		err = PTR_ERR(file);
+		goto free_ser;
+	}
+
+	args->file = file;
+	kho_restore_free(ser);
+
+	return 0;
+
+free_ser:
+	kho_restore_free(ser);
+	return err;
+}
+
+static void tmpfs_luo_mnt_finish(struct liveupdate_file_op_args *args)
+{
+	/*
+	 * A successful retrieve() already freed the serialized state, and a
+	 * failed one cleaned up everything it could. Only an un-retrieved
+	 * mount is left to clean up here.
+	 */
+	if (args->retrieve_status || !args->serialized_data)
+		return;
+
+	kho_restore_free(phys_to_virt(args->serialized_data));
+}
+
+static const struct liveupdate_file_ops tmpfs_luo_mnt_ops = {
+	.freeze = tmpfs_luo_mnt_freeze,
+	.finish = tmpfs_luo_mnt_finish,
+	.retrieve = tmpfs_luo_mnt_retrieve,
+	.preserve = tmpfs_luo_mnt_preserve,
+	.unpreserve = tmpfs_luo_mnt_unpreserve,
+	.can_preserve = tmpfs_luo_mnt_can_preserve,
+	.get_id = tmpfs_luo_mnt_get_id,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_file_handler tmpfs_luo_mnt_handler = {
+	.ops = &tmpfs_luo_mnt_ops,
+	.compatible = TMPFS_LUO_MNT_FH_COMPATIBLE,
+};
+
 static int __init memfd_luo_init(void)
 {
-	int err = liveupdate_register_file_handler(&memfd_luo_handler);
+	int err;
 
-	if (err && err != -EOPNOTSUPP) {
-		pr_err("Could not register luo filesystem handler: %pe\n",
+	err = liveupdate_register_file_handler(&memfd_luo_handler);
+	if (err) {
+		if (err == -EOPNOTSUPP)
+			return 0;
+
+		pr_err("Could not register luo memfd handler: %pe\n",
 		       ERR_PTR(err));
 
 		return err;
 	}
 
+	err = liveupdate_register_file_handler(&tmpfs_luo_mnt_handler);
+	if (err) {
+		pr_err("Could not register luo tmpfs mount handler: %pe\n",
+		       ERR_PTR(err));
+
+		goto err_unregister_memfd;
+	}
+
 	return 0;
+
+err_unregister_memfd:
+	liveupdate_unregister_file_handler(&memfd_luo_handler);
+
+	return err;
 }
 late_initcall(memfd_luo_init);
diff --git a/mm/shmem.c b/mm/shmem.c
index 8660405b6ab8..c76dd3646f6f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -162,11 +162,6 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			struct folio **foliop, enum sgp_type sgp, gfp_t gfp,
 			struct vm_fault *vmf, vm_fault_t *fault_type);
 
-static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
-{
-	return sb->s_fs_info;
-}
-
 /*
  * shmem_file_setup pre-accounts the whole fixed size of a VM object,
  * for shared memory and for shared anonymous (/dev/zero) mappings
-- 
2.56.0.rc1.310.g51773c2048-goog



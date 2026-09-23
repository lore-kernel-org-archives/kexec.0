Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E4DC98315
	for <kexec@archiver.kernel.org>; Wed, 23 Sep 2026 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7qvuMFxeBj+B+G3C9EN8sSVcZBEZuVQAHrFO4Xty0ZA=; b=ZIhE2GyJUNFp9MImksmb2Bw60V
	zYLrcCXfTZu+0xeTGFVzdjWB5hDswkLn5Ug5zZoxhv9yZqCWeK30+t1vHhShRUdioy/gQ05H+dQYn
	cph9DKYPUogM6MRDQsvW4QWkBDZZ42dJJqHZM1CRjPLy82ntiiMImJwmZumvTDNKWOkgduBsy7Mb+
	lj2t/BCVHz4N8uGUFgYHHTK8AZy4Cgj5eqg849pMPH99s/nV+EY+zKAYXTsb5ETXp6cYlO0Lljt+i
	EN6Qd13YOLyTFJta44h8icuRgaVJ97w8RbcEhRuYXW8vODGatmPjHiRfbnL+sxqGUKiN2leu/B0ku
	lG2IPjJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9VhV-00000009fcq-3UJ6;
	Wed, 23 Sep 2026 22:44:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9VhU-00000009fcO-2S76
	for kexec@lists.infradead.org;
	Wed, 23 Sep 2026 22:44:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0AE1D60209;
	Wed, 23 Sep 2026 22:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5BB1F00893;
	Wed, 23 Sep 2026 22:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790203467;
	bh=7qvuMFxeBj+B+G3C9EN8sSVcZBEZuVQAHrFO4Xty0ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pa/cjCtODH8tQvSaIgT1T1D3gbx8C2FVjR5J83eGcAOvlSe2xloUgJBbPpAsjxZ7U
	 Ad5qy5KJDhE5OQLNeMDHo41xi0JyCwQ0AeUqJ+KkpKTkme/G4wt58b4+AOzFI0TTZ6
	 EIf1UQkvhx+MgN9o5eo+YOxdtusXX0Sc4xrCDYkHvKjnE+AJ1hd4UX8QoptrbXJcYF
	 QgAdlDAHeP6/PD8OmoJdxomH7kvsTd24Dmmxcz0Eku56bSPwHwK6VvraMiBeMOnavh
	 wge2I68bX0Nis0ZFQJl9JC1FpuPxVxJDheQkHVuwwVH/6N6WdEX8CKdF0ce+RCcK60
	 E1F0cm+jUc67A==
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
Subject: [RFC PATCH 3/6] fs/namespace: Add vfs_open_detached_mount()
Date: Thu, 24 Sep 2026 00:44:02 +0200
Message-ID: <20260923224408.3745689-4-pratyush@kernel.org>
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

A mount created in the kernel by fc_mount() and friends has mnt_ns ==
NULL, and userspace cannot attach such a mount anywhere.

The missing step is the tail of fsmount(2): allocate an anonymous mount
namespace, insert the mount as its root, open an O_PATH file on it and
mark the file FMODE_NEED_UNMOUNT so the mount is torn down on the final
fput() if it is never attached. The anonymous namespace is what gives
the detached mount an owning user namespace for permission checks, a
place for child mounts, and a lifetime tied to the file.

None of the pieces are reachable from outside fs/namespace.c:
alloc_mnt_ns() and mnt_add_to_ns() are static, and the sequence is
already open-coded twice, in fsmount(2) and in open_detached_copy().

Factor it out so an in-kernel creator of a mount can hand it to
userspace. The Live Update Orchestrator needs this to return a tmpfs it
re-created from state preserved across a kexec; userspace attaches the
resulting fd with move_mount(), exactly as it would an fsmount(2) fd.

Only add the helper. Converting fsmount() and open_detached_copy() to it
is an obvious follow-up but is left out to keep this small. It is not
exported, as the only caller is built in.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

---

This patch is entirely LLM generated. It works, but I am not competent
enough with VFS APIs to even guess if it is sensible. So please don't
take it too seriously. It makes the RFC testable, but for a proper
series I will do a lot more homework to make sure this doesn't
completely abuse VFS APIs.
---
 fs/namespace.c        | 59 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mount.h |  1 +
 2 files changed, 60 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1ecd96c918b3..5e7ba2b61dd9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4435,6 +4435,65 @@ static unsigned int attr_flags_to_mnt_flags(u64 attr_flags)
 	return mnt_flags;
 }
 
+/**
+ * vfs_open_detached_mount - Publish a new mount as a detached mount file.
+ * @mnt: The mount to publish. Must not be attached to a mount namespace. The
+ *       caller's reference is consumed on success.
+ *
+ * Places @mnt into a new anonymous mount namespace and opens an O_PATH file on
+ * its root, marked FMODE_NEED_UNMOUNT. This is what fsmount(2) hands back, and
+ * the resulting file behaves the same way: it can be attached to the
+ * filesystem hierarchy with
+ *
+ *	move_mount(fd, "", dfd, path, MOVE_MOUNT_F_EMPTY_PATH)
+ *
+ * and the mount is torn down on the final fput() if it never was.
+ *
+ * A mount that is not the root of an anonymous mount namespace cannot be
+ * attached by userspace at all, so a mount freshly made by fc_mount() and
+ * friends has to go through here before it can be given away.
+ *
+ * Return: the new file, or an ERR_PTR. On failure the caller's reference to
+ *         @mnt is dropped, as the mount cannot be published.
+ */
+struct file *vfs_open_detached_mount(struct vfsmount *mnt)
+{
+	struct path path __free(path_put) = {};
+	struct mnt_namespace *ns;
+	struct file *file;
+
+	if (WARN_ON_ONCE(real_mount(mnt)->mnt_ns))
+		return ERR_PTR(-EINVAL);
+
+	ns = alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns, true);
+	if (IS_ERR(ns)) {
+		mntput(mnt);
+		return ERR_CAST(ns);
+	}
+
+	/* The caller's reference becomes the namespace's reference. */
+	ns->root = real_mount(mnt);
+	ns->nr_mounts = 1;
+	mnt_add_to_ns(ns, real_mount(mnt));
+
+	path.mnt = mntget(mnt);
+	path.dentry = dget(mnt->mnt_root);
+
+	file = dentry_open(&path, O_PATH, current_cred());
+	if (IS_ERR(file)) {
+		dissolve_on_fput(mnt);
+		return file;
+	}
+
+	/*
+	 * An apparent O_PATH fd, with a note that the mount needs to be
+	 * unmounted on the final fput() rather than simply put.
+	 */
+	file->f_mode |= FMODE_NEED_UNMOUNT;
+
+	return file;
+}
+
 /*
  * Create a kernel mount representation for a new, prepared superblock
  * (specified by fs_fd) and attach to an open_tree-like file descriptor.
diff --git a/include/linux/mount.h b/include/linux/mount.h
index acfe7ef86a1b..44c1141bc574 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -89,6 +89,7 @@ extern struct vfsmount *vfs_create_mount(struct fs_context *fc);
 extern struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 				      int flags, const char *name,
 				      void *data);
+struct file *vfs_open_detached_mount(struct vfsmount *mnt);
 
 extern void mnt_set_expiry(struct vfsmount *mnt, struct list_head *expiry_list);
 extern void mark_mounts_for_expiry(struct list_head *mounts);
-- 
2.56.0.rc1.310.g51773c2048-goog



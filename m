Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C73F94CDE
	for <kexec@archiver.kernel.org>; Wed, 22 Apr 2026 11:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h2tueksW6B63AlVLAgmeWvyMXWYiyJaskMo9TSOBXBQ=; b=Zqgltb64XV9rgqzGYL/EaiPikA
	OdS9Tch5icKZugT7AmjPpH0ocgjV3riEdlLuoRD7N0GG55+0ex9MqI6L0ElVe6t/3SKLVLQ0yv1Qi
	ImWbPq6dndY7NdfEJEdpD9iJoBlgs1NONqW2aNRP1XKs+m13OgCFrpkOfoxDTVgALcwN7UJS6qZgO
	UMJ8mXPcMUJWd/fnUcORUpa6DEncdzOU7vecZNzOttOV/bLNhQLbVxjPGGhdN3W/c92gij9O4DBLd
	QLcocOnuCQxESGf7c6q5S5MLcpT2oNPHQmyHWYk/RrOQxVsDOdCmdmmrw594KnNkn1+nOSat5cOpX
	GYGeTQgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFWDh-0000000A1FR-2DyD;
	Wed, 22 Apr 2026 11:58:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFWDf-0000000A1FK-2igz
	for kexec@lists.infradead.org;
	Wed, 22 Apr 2026 11:58:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9031F60133;
	Wed, 22 Apr 2026 11:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB228C19425;
	Wed, 22 Apr 2026 11:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776859094;
	bh=cM9cPH2DCZmZdCi7xoLbSQL3YQeciVQoXm80O1Nkuss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnBPIVd74nEAAmwRfET7plTicvo1oNKW6RrJ7sBHUUmwy1XfZgZxWisb1h9FPUdPE
	 GoLAagWxTMww5QS8DCGNwWI9kW7G8V0sY4+Jrqnox8VMPSrCwrTAJ0FaBAdrEY/NAu
	 LLPqCuU5IzlBWeRwbSrxO4loMQu4C+x7qFMrml7jNf3ZFYRvRQlwncLAFPBobNwGx7
	 T/VFb1epO3lsbwd5C196Fn03S75Tn0Iw6IxLMkondmUoPwZzd7Qzp3BhOANg7jH/cG
	 /TEpqL0pL/xXJxaqWWqY/gPkQeI4sZQmd+c3kVbQYuH0NRnGf7nL0Abdm/mjbKkt6W
	 rAwEAvy6yBTJw==
Date: Wed, 22 Apr 2026 13:58:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: pasha.tatashin@soleen.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pratyush@kernel.org, linux-kernel@vger.kernel.org, 
	luca.boccassi@gmail.com
Subject: Re: [PATCH v9 3/6] liveupdate: add LUO_SESSION_MAGIC magic inode type
Message-ID: <20260422-liege-klotz-cfd84db12d91@brauner>
References: <20260420141741.2688371-1-luca.boccassi@gmail.com>
 <20260420141741.2688371-4-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420141741.2688371-4-luca.boccassi@gmail.com>
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

On Mon, Apr 20, 2026 at 03:15:11PM +0100, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> In userspace when managing LUO sessions we want to be able to identify
> a FD as a LUO session, in order to be able to do the special handling
> that they require in order to function as intended on kexec.
> 
> Currently this requires scraping procfs and doing string matching on
> the prefix of the dname, which is not an ideal interface.
> 
> Add a singleton inode type with a magic value, so that we can
> programmatically identify a fd as a LUO session via fstatfs().
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---

Fold the following diff [1] into this commit (and the test), please.

Btw, I see that currently you only allow to retrieve one file per
session. If you ever want to allow multiple files for a session
but single shared inode amongst the same session so that different files
for the same session still compare as identical I added a mechanism
called path_from_stashed() which would easily allow for this. The luo
session just needs to stash a dentry pointer to achieve this. Just a
heads-up.

[1]:
From 7a11a931eaf4766e70c81d32093668ecd60f4952 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Apr 2026 12:41:25 +0200
Subject: [PATCH] liveupdate: allocate per-session inodes

The luo_session pseudo-fs handed every session the same singleton inode,
so fstat() on two session fds could not tell them apart. Give each
session its own inode via new_inode_pseudo(), with a unique cookie for
i_ino (and the upper bits in i_generation so 32-bit configs still get
distinct inode numbers).

Leave inode->i_fop unset. Session file descriptors must only come from
the LIVEUPDATE_IOCTL_{CREATE,RETRIEVE}_SESSION ioctls, so an unset i_fop
makes open() on /proc/<pid>/fd/N fail.

Lifetime continues to hang off file->private_data and the .release
callback; this patch only changes where the inode comes from.

Rename LUO_SESSION_MAGIC to LUO_FS_MAGIC and flip the session_fstat
selftest to assert distinct inode numbers.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/uapi/linux/magic.h                    |  2 +-
 kernel/liveupdate/luo_session.c               | 59 +++++++++++++------
 .../testing/selftests/liveupdate/liveupdate.c | 13 ++--
 3 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 4f51005522ff..afc3f935d00d 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -105,6 +105,6 @@
 #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
 #define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */
 #define NULL_FS_MAGIC		0x4E554C4C	/* "NULL" */
-#define LUO_SESSION_MAGIC	0x4c554f53	/* "LUOS" */
+#define LUO_FS_MAGIC		0x4c554f53	/* "LUOS" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 885e1f346caa..2484feaf102a 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -51,6 +51,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/cleanup.h>
+#include <linux/cookie.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/file.h>
@@ -380,17 +381,43 @@ static const struct file_operations luo_session_fops = {
 };
 
 static struct vfsmount *luo_session_mnt __ro_after_init;
-static struct inode *luo_session_inode __ro_after_init;
 
-/*
- * Reject all attribute changes on the singleton session inode.
- * Without this the VFS falls back to simple_setattr(), allowing
- * fchmod()/fchown() to modify the shared inode.
- */
+DEFINE_COOKIE(luo_session_cookie);
+
+static u64 luo_session_alloc_ino(void)
+{
+	guard(preempt)();
+	return gen_cookie_next(&luo_session_cookie);
+}
+
+/* .setattr rejects attribute changes to prevent fchmod()/fchown(). */
 static const struct inode_operations luo_session_inode_operations = {
 	.setattr	= anon_inode_setattr,
 };
 
+static struct inode *luo_new_inode(struct super_block *sb)
+{
+	struct inode *inode;
+	u64 ino;
+
+	inode = new_inode_pseudo(sb);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	ino = luo_session_alloc_ino();
+	inode->i_ino		= ino;
+	inode->i_generation	= ino >> 32;
+	inode->i_flags		|= S_IMMUTABLE | S_PRIVATE | S_ANON_INODE;
+	inode->i_mode		|= S_IRUSR | S_IWUSR;
+	inode->i_uid		= current_fsuid();
+	inode->i_gid		= current_fsgid();
+	inode->i_op		= &luo_session_inode_operations;
+	/* i_fop left unset: session fds must not be reopenable via procfs. */
+	simple_inode_init_ts(inode);
+
+	return inode;
+}
+
 static char *luo_session_dname(struct dentry *dentry, char *buffer, int buflen)
 {
 	return dynamic_dname(buffer, buflen, "luo_session:[%s]",
@@ -410,7 +437,7 @@ static int luo_session_init_fs_context(struct fs_context *fc)
 {
 	struct pseudo_fs_context *ctx;
 
-	ctx = init_pseudo(fc, LUO_SESSION_MAGIC);
+	ctx = init_pseudo(fc, LUO_FS_MAGIC);
 	if (!ctx)
 		return -ENOMEM;
 
@@ -432,17 +459,20 @@ static struct file_system_type luo_session_fs_type = {
 static int luo_session_getfile(struct luo_session *session, struct file **filep)
 {
 	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH + 1];
+	struct inode *inode;
 	struct file *file;
 
 	lockdep_assert_held(&session->mutex);
 
-	ihold(luo_session_inode);
+	inode = luo_new_inode(luo_session_mnt->mnt_sb);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
 
 	snprintf(name_buf, sizeof(name_buf), "%s", session->name);
-	file = alloc_file_pseudo(luo_session_inode, luo_session_mnt, name_buf,
+	file = alloc_file_pseudo(inode, luo_session_mnt, name_buf,
 				 O_RDWR, &luo_session_fops);
 	if (IS_ERR(file)) {
-		iput(luo_session_inode);
+		iput(inode);
 		return PTR_ERR(file);
 	}
 
@@ -731,19 +761,10 @@ int __init luo_session_fs_init(void)
 	luo_session_mnt = kern_mount(&luo_session_fs_type);
 	if (IS_ERR(luo_session_mnt))
 		panic("Cannot create LUO Session pseudo-fs");
-
-	luo_session_inode = alloc_anon_inode(luo_session_mnt->mnt_sb);
-	if (IS_ERR(luo_session_inode)) {
-		kern_unmount(luo_session_mnt);
-		return PTR_ERR(luo_session_inode);
-	}
-	luo_session_inode->i_op = &luo_session_inode_operations;
-
 	return 0;
 }
 
 void __init luo_session_fs_cleanup(void)
 {
-	iput(luo_session_inode);
 	kern_unmount(luo_session_mnt);
 }
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index c21354dc9b93..34f3ecb21396 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -410,8 +410,9 @@ TEST_F(liveupdate_device, create_session_empty_name)
  * Test Case: Session fstat
  *
  * Verifies that fstatfs() on a session file descriptor reports the
- * LUO_SESSION_MAGIC filesystem type, and that fstat() returns consistent
- * inode numbers across different sessions (shared singleton inode).
+ * LUO_FS_MAGIC filesystem type, and that fstat() returns distinct inode
+ * numbers across different sessions so userspace can compare two session
+ * file descriptors for equality using stat().
  */
 TEST_F(liveupdate_device, session_fstat)
 {
@@ -430,14 +431,14 @@ TEST_F(liveupdate_device, session_fstat)
 	session_fd2 = create_session(self->fd1, "fstat-session-2");
 	ASSERT_GE(session_fd2, 0);
 
-	/* Verify the filesystem type is LUO_SESSION_MAGIC */
+	/* Verify the filesystem type is LUO_FS_MAGIC */
 	ASSERT_EQ(fstatfs(session_fd1, &sfs), 0);
-	EXPECT_EQ(sfs.f_type, LUO_SESSION_MAGIC);
+	EXPECT_EQ(sfs.f_type, LUO_FS_MAGIC);
 
-	/* Verify both sessions share the same inode number */
+	/* Each session has its own inode, so inode numbers must differ. */
 	ASSERT_EQ(fstat(session_fd1, &st1), 0);
 	ASSERT_EQ(fstat(session_fd2, &st2), 0);
-	EXPECT_EQ(st1.st_ino, st2.st_ino);
+	EXPECT_NE(st1.st_ino, st2.st_ino);
 
 	ASSERT_EQ(close(session_fd1), 0);
 	ASSERT_EQ(close(session_fd2), 0);
-- 
2.47.3



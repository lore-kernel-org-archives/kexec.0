Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AE2C678D7
	for <kexec@archiver.kernel.org>; Sat, 14 Jan 2023 01:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=erDD+ORV+mRVZJKF//SIg+a3dlA1eK06rFqa1ft7K4Y=; b=PxwGLC40Gvm8rp
	9NNSL1tQVnYKRMmOFoLTO411GUQcWYIoQ+ZKHSmEQrUc4lxsv2GcZ6PKnTogiSIFXdhf5oIltAZnb
	Iycse9X6n44noECbEafcjqeiXNEeeXQ+JH3seT78gb72Lj/QaKb2Ge7ZrTFkZu+7Efupbz5lNVB8O
	u37SMW5CRHDA0Jlq/8tQrjBUPaowgprzT19OsOqOUEsPUC3Z5AsWfLcCbHhedRbS7FrtG09lEH0jT
	SJpCP3AfIEadMkSELIfs4zMw0wv7MXBJxCwJsAgFe4rwW9AjNGWPgxzibDd7tgnF/4aw/EMtFESz1
	kDck7x+RF1sN1Tbm90Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGVco-0050Wh-6J; Sat, 14 Jan 2023 01:46:26 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGUUs-004tvx-Sg; Sat, 14 Jan 2023 00:34:10 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hch@infradead.org,
	djwong@kernel.org,
	song@kernel.org,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	bvanassche@acm.org,
	ebiederm@xmission.com
Cc: mchehab@kernel.org,
	keescook@chromium.org,
	p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org,
	kernel@tuxforce.de,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v3 01/24] fs: unify locking semantics for fs freeze / thaw
Date: Fri, 13 Jan 2023 16:33:46 -0800
Message-Id: <20230114003409.1168311-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230114003409.1168311-1-mcgrof@kernel.org>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Right now freeze_super()  and thaw_super() are called with
different locking contexts. To expand on this is messy, so
just unify the requirement to require grabbing an active
reference and keep the superblock locked.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c    |  5 ++++-
 fs/f2fs/gc.c    |  5 +++++
 fs/gfs2/super.c |  9 +++++++--
 fs/gfs2/sys.c   |  6 ++++++
 fs/gfs2/util.c  |  5 +++++
 fs/ioctl.c      | 12 ++++++++++--
 fs/super.c      | 51 ++++++++++++++-----------------------------------
 7 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index edc110d90df4..8fd3a7991c02 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -251,7 +251,7 @@ int freeze_bdev(struct block_device *bdev)
 		error = sb->s_op->freeze_super(sb);
 	else
 		error = freeze_super(sb);
-	deactivate_super(sb);
+	deactivate_locked_super(sb);
 
 	if (error) {
 		bdev->bd_fsfreeze_count--;
@@ -289,6 +289,8 @@ int thaw_bdev(struct block_device *bdev)
 	sb = bdev->bd_fsfreeze_sb;
 	if (!sb)
 		goto out;
+	if (!get_active_super(bdev))
+		goto out;
 
 	if (sb->s_op->thaw_super)
 		error = sb->s_op->thaw_super(sb);
@@ -298,6 +300,7 @@ int thaw_bdev(struct block_device *bdev)
 		bdev->bd_fsfreeze_count++;
 	else
 		bdev->bd_fsfreeze_sb = NULL;
+	deactivate_locked_super(sb);
 out:
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 	return error;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 7444c392eab1..4c681fe487ee 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2139,7 +2139,10 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 	if (err)
 		return err;
 
+	if (!get_active_super(sbi->sb->s_bdev))
+		return -ENOTTY;
 	freeze_super(sbi->sb);
+
 	f2fs_down_write(&sbi->gc_lock);
 	f2fs_down_write(&sbi->cp_global_sem);
 
@@ -2190,6 +2193,8 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 out_err:
 	f2fs_up_write(&sbi->cp_global_sem);
 	f2fs_up_write(&sbi->gc_lock);
+	/* We use the same active reference from freeze */
 	thaw_super(sbi->sb);
+	deactivate_locked_super(sbi->sb);
 	return err;
 }
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 999cc146d708..48df7b276b64 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -661,7 +661,12 @@ void gfs2_freeze_func(struct work_struct *work)
 	struct gfs2_sbd *sdp = container_of(work, struct gfs2_sbd, sd_freeze_work);
 	struct super_block *sb = sdp->sd_vfs;
 
-	atomic_inc(&sb->s_active);
+	if (!get_active_super(sb->s_bdev)) {
+		fs_info(sdp, "GFS2: couldn't grap super for thaw for filesystem\n");
+		gfs2_assert_withdraw(sdp, 0);
+		return;
+	}
+
 	error = gfs2_freeze_lock(sdp, &freeze_gh, 0);
 	if (error) {
 		gfs2_assert_withdraw(sdp, 0);
@@ -675,7 +680,7 @@ void gfs2_freeze_func(struct work_struct *work)
 		}
 		gfs2_freeze_unlock(&freeze_gh);
 	}
-	deactivate_super(sb);
+	deactivate_locked_super(sb);
 	clear_bit_unlock(SDF_FS_FROZEN, &sdp->sd_flags);
 	wake_up_bit(&sdp->sd_flags, SDF_FS_FROZEN);
 	return;
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index d87ea98cf535..d0b80552a678 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -162,6 +162,9 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (!get_active_super(sb->s_bdev))
+		return -ENOTTY;
+
 	switch (n) {
 	case 0:
 		error = thaw_super(sdp->sd_vfs);
@@ -170,9 +173,12 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 		error = freeze_super(sdp->sd_vfs);
 		break;
 	default:
+		deactivate_locked_super(sb);
 		return -EINVAL;
 	}
 
+	deactivate_locked_super(sb);
+
 	if (error) {
 		fs_warn(sdp, "freeze %d error %d\n", n, error);
 		return error;
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 7a6aeffcdf5c..3a0cd5e9ad84 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -345,10 +345,15 @@ int gfs2_withdraw(struct gfs2_sbd *sdp)
 	set_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
 
 	if (sdp->sd_args.ar_errors == GFS2_ERRORS_WITHDRAW) {
+		if (!get_active_super(sb->s_bdev)) {
+			fs_err(sdp, "could not grab super on withdraw for file system\n");
+			return -1;
+		}
 		fs_err(sdp, "about to withdraw this file system\n");
 		BUG_ON(sdp->sd_args.ar_debug);
 
 		signal_our_withdraw(sdp);
+		deactivate_locked_super(sb);
 
 		kobject_uevent(&sdp->sd_kobj, KOBJ_OFFLINE);
 
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 80ac36aea913..3d2536e1ea58 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -386,6 +386,7 @@ static int ioctl_fioasync(unsigned int fd, struct file *filp,
 static int ioctl_fsfreeze(struct file *filp)
 {
 	struct super_block *sb = file_inode(filp)->i_sb;
+	int ret;
 
 	if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
@@ -394,10 +395,17 @@ static int ioctl_fsfreeze(struct file *filp)
 	if (sb->s_op->freeze_fs == NULL && sb->s_op->freeze_super == NULL)
 		return -EOPNOTSUPP;
 
+	if (!get_active_super(sb->s_bdev))
+		return -ENOTTY;
+
 	/* Freeze */
 	if (sb->s_op->freeze_super)
-		return sb->s_op->freeze_super(sb);
-	return freeze_super(sb);
+		ret = sb->s_op->freeze_super(sb);
+	ret = freeze_super(sb);
+
+	deactivate_locked_super(sb);
+
+	return ret;
 }
 
 static int ioctl_fsthaw(struct file *filp)
diff --git a/fs/super.c b/fs/super.c
index 12c08cb20405..a31a41b313f3 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -39,8 +39,6 @@
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
-static int thaw_super_locked(struct super_block *sb);
-
 static LIST_HEAD(super_blocks);
 static DEFINE_SPINLOCK(sb_lock);
 
@@ -830,7 +828,6 @@ struct super_block *get_active_super(struct block_device *bdev)
 		if (sb->s_bdev == bdev) {
 			if (!grab_super(sb))
 				goto restart;
-			up_write(&sb->s_umount);
 			return sb;
 		}
 	}
@@ -1003,13 +1000,13 @@ void emergency_remount(void)
 
 static void do_thaw_all_callback(struct super_block *sb)
 {
-	down_write(&sb->s_umount);
+	if (!get_active_super(sb->s_bdev))
+		return;
 	if (sb->s_root && sb->s_flags & SB_BORN) {
 		emergency_thaw_bdev(sb);
-		thaw_super_locked(sb);
-	} else {
-		up_write(&sb->s_umount);
+		thaw_super(sb);
 	}
+	deactivate_locked_super(sb);
 }
 
 static void do_thaw_all(struct work_struct *work)
@@ -1651,22 +1648,15 @@ int freeze_super(struct super_block *sb)
 {
 	int ret;
 
-	atomic_inc(&sb->s_active);
-	down_write(&sb->s_umount);
-	if (sb->s_writers.frozen != SB_UNFROZEN) {
-		deactivate_locked_super(sb);
+	if (sb->s_writers.frozen != SB_UNFROZEN)
 		return -EBUSY;
-	}
 
-	if (!(sb->s_flags & SB_BORN)) {
-		up_write(&sb->s_umount);
+	if (!(sb->s_flags & SB_BORN))
 		return 0;	/* sic - it's "nothing to do" */
-	}
 
 	if (sb_rdonly(sb)) {
 		/* Nothing to do really... */
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
-		up_write(&sb->s_umount);
 		return 0;
 	}
 
@@ -1686,7 +1676,6 @@ int freeze_super(struct super_block *sb)
 		sb->s_writers.frozen = SB_UNFROZEN;
 		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
 		wake_up(&sb->s_writers.wait_unfrozen);
-		deactivate_locked_super(sb);
 		return ret;
 	}
 
@@ -1702,7 +1691,6 @@ int freeze_super(struct super_block *sb)
 			sb->s_writers.frozen = SB_UNFROZEN;
 			sb_freeze_unlock(sb, SB_FREEZE_FS);
 			wake_up(&sb->s_writers.wait_unfrozen);
-			deactivate_locked_super(sb);
 			return ret;
 		}
 	}
@@ -1712,19 +1700,22 @@ int freeze_super(struct super_block *sb)
 	 */
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
 	lockdep_sb_freeze_release(sb);
-	up_write(&sb->s_umount);
 	return 0;
 }
 EXPORT_SYMBOL(freeze_super);
 
-static int thaw_super_locked(struct super_block *sb)
+/**
+ * thaw_super -- unlock filesystem
+ * @sb: the super to thaw
+ *
+ * Unlocks the filesystem and marks it writeable again after freeze_super().
+ */
+int thaw_super(struct super_block *sb)
 {
 	int error;
 
-	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
-		up_write(&sb->s_umount);
+	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
 		return -EINVAL;
-	}
 
 	if (sb_rdonly(sb)) {
 		sb->s_writers.frozen = SB_UNFROZEN;
@@ -1739,7 +1730,6 @@ static int thaw_super_locked(struct super_block *sb)
 			printk(KERN_ERR
 				"VFS:Filesystem thaw failed\n");
 			lockdep_sb_freeze_release(sb);
-			up_write(&sb->s_umount);
 			return error;
 		}
 	}
@@ -1748,19 +1738,6 @@ static int thaw_super_locked(struct super_block *sb)
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out:
 	wake_up(&sb->s_writers.wait_unfrozen);
-	deactivate_locked_super(sb);
 	return 0;
 }
-
-/**
- * thaw_super -- unlock filesystem
- * @sb: the super to thaw
- *
- * Unlocks the filesystem and marks it writeable again after freeze_super().
- */
-int thaw_super(struct super_block *sb)
-{
-	down_write(&sb->s_umount);
-	return thaw_super_locked(sb);
-}
 EXPORT_SYMBOL(thaw_super);
-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

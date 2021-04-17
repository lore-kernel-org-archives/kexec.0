Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYXf-009nku-Sq
 for kexec@lists.infradead.org; Sat, 17 Apr 2021 00:10:33 +0000
Received: by mail-pj1-f52.google.com with SMTP id s14so10005626pjl.5
 for <kexec@lists.infradead.org>; Fri, 16 Apr 2021 17:10:31 -0700 (PDT)
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v2 2/6] fs: add frozen sb state helpers
Date: Sat, 17 Apr 2021 00:10:22 +0000
Message-Id: <20210417001026.23858-3-mcgrof@kernel.org>
In-Reply-To: <20210417001026.23858-1-mcgrof@kernel.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: rafael@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org, jeyu@kernel.org, ebiederm@xmission.com
Cc: mchehab@kernel.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, kernel@tuxforce.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>

The question of whether or not a superblock is frozen needs to be
augmented in the future to account for differences between a user
initiated freeze and a kernel initiated freeze done automatically
on behalf of the kernel.

Provide helpers so that these can be used instead so that we don't
have to expand checks later in these same call sites as we expand
the definition of a frozen superblock.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/ext4/ext4_jbd2.c |  2 +-
 fs/super.c          |  4 ++--
 fs/xfs/xfs_trans.c  |  3 +--
 include/linux/fs.h  | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index be799040a415..efda50563feb 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -72,7 +72,7 @@ static int ext4_journal_check_start(struct super_block *sb)
 
 	if (sb_rdonly(sb))
 		return -EROFS;
-	WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
+	WARN_ON(sb_is_frozen(sb));
 	journal = EXT4_SB(sb)->s_journal;
 	/*
 	 * Special case here: if the journal has aborted behind our
diff --git a/fs/super.c b/fs/super.c
index e24d0849d935..72b445a69a45 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1629,7 +1629,7 @@ static int freeze_locked_super(struct super_block *sb)
 {
 	int ret;
 
-	if (sb->s_writers.frozen != SB_UNFROZEN)
+	if (!sb_is_unfrozen(sb))
 		return -EBUSY;
 
 	if (!(sb->s_flags & SB_BORN))
@@ -1734,7 +1734,7 @@ static int thaw_super_locked(struct super_block *sb)
 {
 	int error;
 
-	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
+	if (!sb_is_frozen(sb)) {
 		up_write(&sb->s_umount);
 		return -EINVAL;
 	}
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index bcc978011869..b4669dd65c9e 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -272,8 +272,7 @@ xfs_trans_alloc(
 	 * Zero-reservation ("empty") transactions can't modify anything, so
 	 * they're allowed to run while we're frozen.
 	 */
-	WARN_ON(resp->tr_logres > 0 &&
-		mp->m_super->s_writers.frozen == SB_FREEZE_COMPLETE);
+	WARN_ON(resp->tr_logres > 0 && sb_is_frozen(mp->m_super));
 	ASSERT(!(flags & XFS_TRANS_RES_FDBLKS) ||
 	       xfs_sb_version_haslazysbcount(&mp->m_sb));
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..3dcf2c1968e5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1885,6 +1885,40 @@ static inline bool sb_start_intwrite_trylock(struct super_block *sb)
 	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
 }
 
+/**
+ * sb_is_frozen_by_user - is superblock frozen by a user call
+ * @sb: the super to check
+ *
+ * Returns true if the super freeze was initiated by userspace, for instance,
+ * an ioctl call.
+ */
+static inline bool sb_is_frozen_by_user(struct super_block *sb)
+{
+	return sb->s_writers.frozen == SB_FREEZE_COMPLETE;
+}
+
+/**
+ * sb_is_frozen - is superblock frozen
+ * @sb: the super to check
+ *
+ * Returns true if the super is frozen.
+ */
+static inline bool sb_is_frozen(struct super_block *sb)
+{
+	return sb_is_frozen_by_user(sb);
+}
+
+/**
+ * sb_is_unfrozen - is superblock unfrozen
+ * @sb: the super to check
+ *
+ * Returns true if the super is unfrozen.
+ */
+static inline bool sb_is_unfrozen(struct super_block *sb)
+{
+	return sb->s_writers.frozen == SB_UNFROZEN;
+}
+
 bool inode_owner_or_capable(struct user_namespace *mnt_userns,
 			    const struct inode *inode);
 
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

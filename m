Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYXe-009nk6-4U
 for kexec@lists.infradead.org; Sat, 17 Apr 2021 00:10:31 +0000
Received: by mail-pf1-f170.google.com with SMTP id i190so19362221pfc.12
 for <kexec@lists.infradead.org>; Fri, 16 Apr 2021 17:10:29 -0700 (PDT)
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v2 1/6] fs: provide unlocked helper for freeze_super()
Date: Sat, 17 Apr 2021 00:10:21 +0000
Message-Id: <20210417001026.23858-2-mcgrof@kernel.org>
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
Cc: mchehab@kernel.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, kernel@tuxforce.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Dave Chinner <david@fromorbit.com>

freeze_super() holds a write lock, however we wish to also enable
callers which already hold the write lock. To do this provide a helper
and make freeze_super() use it. This way, all that freeze_super() does
now is lock handling and active count management.

This change has no functional changes.

Suggested-by: Dave Chinner <david@fromorbit.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/super.c | 100 +++++++++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 45 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 11b7e7213fd1..e24d0849d935 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1624,59 +1624,20 @@ static void sb_freeze_unlock(struct super_block *sb)
 		percpu_up_write(sb->s_writers.rw_sem + level);
 }
 
-/**
- * freeze_super - lock the filesystem and force it into a consistent state
- * @sb: the super to lock
- *
- * Syncs the super to make sure the filesystem is consistent and calls the fs's
- * freeze_fs.  Subsequent calls to this without first thawing the fs will return
- * -EBUSY.
- *
- * During this function, sb->s_writers.frozen goes through these values:
- *
- * SB_UNFROZEN: File system is normal, all writes progress as usual.
- *
- * SB_FREEZE_WRITE: The file system is in the process of being frozen.  New
- * writes should be blocked, though page faults are still allowed. We wait for
- * all writes to complete and then proceed to the next stage.
- *
- * SB_FREEZE_PAGEFAULT: Freezing continues. Now also page faults are blocked
- * but internal fs threads can still modify the filesystem (although they
- * should not dirty new pages or inodes), writeback can run etc. After waiting
- * for all running page faults we sync the filesystem which will clean all
- * dirty pages and inodes (no new dirty pages or inodes can be created when
- * sync is running).
- *
- * SB_FREEZE_FS: The file system is frozen. Now all internal sources of fs
- * modification are blocked (e.g. XFS preallocation truncation on inode
- * reclaim). This is usually implemented by blocking new transactions for
- * filesystems that have them and need this additional guard. After all
- * internal writers are finished we call ->freeze_fs() to finish filesystem
- * freezing. Then we transition to SB_FREEZE_COMPLETE state. This state is
- * mostly auxiliary for filesystems to verify they do not modify frozen fs.
- *
- * sb->s_writers.frozen is protected by sb->s_umount.
- */
-int freeze_super(struct super_block *sb)
+/* Caller takes lock and handles active count */
+static int freeze_locked_super(struct super_block *sb)
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
 
@@ -1705,7 +1666,6 @@ int freeze_super(struct super_block *sb)
 			sb->s_writers.frozen = SB_UNFROZEN;
 			sb_freeze_unlock(sb);
 			wake_up(&sb->s_writers.wait_unfrozen);
-			deactivate_locked_super(sb);
 			return ret;
 		}
 	}
@@ -1714,9 +1674,59 @@ int freeze_super(struct super_block *sb)
 	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
 	 */
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+	return 0;
+}
+
+/**
+ * freeze_super - lock the filesystem and force it into a consistent state
+ * @sb: the super to lock
+ *
+ * Syncs the super to make sure the filesystem is consistent and calls the fs's
+ * freeze_fs.  Subsequent calls to this without first thawing the fs will return
+ * -EBUSY.
+ *
+ * During this function, sb->s_writers.frozen goes through these values:
+ *
+ * SB_UNFROZEN: File system is normal, all writes progress as usual.
+ *
+ * SB_FREEZE_WRITE: The file system is in the process of being frozen.  New
+ * writes should be blocked, though page faults are still allowed. We wait for
+ * all writes to complete and then proceed to the next stage.
+ *
+ * SB_FREEZE_PAGEFAULT: Freezing continues. Now also page faults are blocked
+ * but internal fs threads can still modify the filesystem (although they
+ * should not dirty new pages or inodes), writeback can run etc. After waiting
+ * for all running page faults we sync the filesystem which will clean all
+ * dirty pages and inodes (no new dirty pages or inodes can be created when
+ * sync is running).
+ *
+ * SB_FREEZE_FS: The file system is frozen. Now all internal sources of fs
+ * modification are blocked (e.g. XFS preallocation truncation on inode
+ * reclaim). This is usually implemented by blocking new transactions for
+ * filesystems that have them and need this additional guard. After all
+ * internal writers are finished we call ->freeze_fs() to finish filesystem
+ * freezing. Then we transition to SB_FREEZE_COMPLETE state. This state is
+ * mostly auxiliary for filesystems to verify they do not modify frozen fs.
+ *
+ * sb->s_writers.frozen is protected by sb->s_umount.
+ */
+int freeze_super(struct super_block *sb)
+{
+	int error;
+
+	atomic_inc(&sb->s_active);
+
+	down_write(&sb->s_umount);
+	error = freeze_locked_super(sb);
+	if (error) {
+		deactivate_locked_super(sb);
+		goto out;
+	}
 	lockdep_sb_freeze_release(sb);
 	up_write(&sb->s_umount);
-	return 0;
+
+out:
+	return error;
 }
 EXPORT_SYMBOL(freeze_super);
 
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

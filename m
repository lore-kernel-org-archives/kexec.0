Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f179.google.com ([209.85.210.179])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYXi-009nmF-Dt
 for kexec@lists.infradead.org; Sat, 17 Apr 2021 00:10:38 +0000
Received: by mail-pf1-f179.google.com with SMTP id a12so19360644pfc.7
 for <kexec@lists.infradead.org>; Fri, 16 Apr 2021 17:10:34 -0700 (PDT)
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v2 4/6] fs: distinguish between user initiated freeze and kernel
 initiated freeze
Date: Sat, 17 Apr 2021 00:10:24 +0000
Message-Id: <20210417001026.23858-5-mcgrof@kernel.org>
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

Userspace can initiate a freeze call using ioctls. If the kernel decides
to freeze a filesystem later it must be able to distinguish if userspace
had initiated the freeze, so that it does not unfreeze it later
automatically on resume.

Likewise if the kernel is initiating a freeze on its own it should *not*
fail to freeze a filesystem if a user had already frozen it on our behalf.
This same concept applies to thawing, even if its not possible for
userspace to beat the kernel in thawing a filesystem. This logic however
has never applied to userspace freezing and thawing, two consecutive
userspace freeze calls will results in only the first one succeeding, so
we must retain the same behaviour in userspace.

This doesn't implement yet kernel initiated filesystem freeze calls,
this will be done in subsequent calls. This change should introduce
no functional changes, it just extends the definitions a frozen
filesystem to account for future kernel initiated filesystem freeze.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/super.c         | 27 ++++++++++++++++++---------
 include/linux/fs.h | 17 +++++++++++++++--
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 744b2399a272..53106d4c7f56 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -40,7 +40,7 @@
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
-static int thaw_super_locked(struct super_block *sb);
+static int thaw_super_locked(struct super_block *sb, bool usercall);
 
 static LIST_HEAD(super_blocks);
 static DEFINE_SPINLOCK(sb_lock);
@@ -977,7 +977,7 @@ static void do_thaw_all_callback(struct super_block *sb)
 	down_write(&sb->s_umount);
 	if (sb->s_root && sb->s_flags & SB_BORN) {
 		emergency_thaw_bdev(sb);
-		thaw_super_locked(sb);
+		thaw_super_locked(sb, false);
 	} else {
 		up_write(&sb->s_umount);
 	}
@@ -1625,10 +1625,13 @@ static void sb_freeze_unlock(struct super_block *sb)
 }
 
 /* Caller takes lock and handles active count */
-static int freeze_locked_super(struct super_block *sb)
+static int freeze_locked_super(struct super_block *sb, bool usercall)
 {
 	int ret;
 
+	if (!usercall && sb_is_frozen(sb))
+		return 0;
+
 	if (!sb_is_unfrozen(sb))
 		return -EBUSY;
 
@@ -1673,7 +1676,10 @@ static int freeze_locked_super(struct super_block *sb)
 	 * For debugging purposes so that fs can warn if it sees write activity
 	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
 	 */
-	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+	if (usercall)
+		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+	else
+		sb->s_writers.frozen = SB_FREEZE_COMPLETE_AUTO;
 	return 0;
 }
 
@@ -1717,7 +1723,7 @@ int freeze_super(struct super_block *sb)
 	atomic_inc(&sb->s_active);
 
 	down_write(&sb->s_umount);
-	error = freeze_locked_super(sb);
+	error = freeze_locked_super(sb, true);
 	if (error) {
 		deactivate_locked_super(sb);
 		goto out;
@@ -1731,10 +1737,13 @@ int freeze_super(struct super_block *sb)
 EXPORT_SYMBOL(freeze_super);
 
 /* Caller deals with the sb->s_umount */
-static int __thaw_super_locked(struct super_block *sb)
+static int __thaw_super_locked(struct super_block *sb, bool usercall)
 {
 	int error;
 
+	if (!usercall && sb_is_unfrozen(sb))
+		return 0;
+
 	if (!sb_is_frozen(sb))
 		return -EINVAL;
 
@@ -1763,11 +1772,11 @@ static int __thaw_super_locked(struct super_block *sb)
 }
 
 /* Handles unlocking of sb->s_umount for you */
-static int thaw_super_locked(struct super_block *sb)
+static int thaw_super_locked(struct super_block *sb, bool usercall)
 {
 	int error;
 
-	error = __thaw_super_locked(sb);
+	error = __thaw_super_locked(sb, usercall);
 	if (error) {
 		up_write(&sb->s_umount);
 		return error;
@@ -1787,6 +1796,6 @@ static int thaw_super_locked(struct super_block *sb)
 int thaw_super(struct super_block *sb)
 {
 	down_write(&sb->s_umount);
-	return thaw_super_locked(sb);
+	return thaw_super_locked(sb, true);
 }
 EXPORT_SYMBOL(thaw_super);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3dcf2c1968e5..6980e709e94a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1406,9 +1406,10 @@ enum {
 	SB_FREEZE_FS = 3,		/* For internal FS use (e.g. to stop
 					 * internal threads if needed) */
 	SB_FREEZE_COMPLETE = 4,		/* ->freeze_fs finished successfully */
+	SB_FREEZE_COMPLETE_AUTO = 5,	/* same but initiated automatically */
 };
 
-#define SB_FREEZE_LEVELS (SB_FREEZE_COMPLETE - 1)
+#define SB_FREEZE_LEVELS (SB_FREEZE_COMPLETE_AUTO - 2)
 
 struct sb_writers {
 	int				frozen;		/* Is sb frozen? */
@@ -1897,6 +1898,18 @@ static inline bool sb_is_frozen_by_user(struct super_block *sb)
 	return sb->s_writers.frozen == SB_FREEZE_COMPLETE;
 }
 
+/**
+ * sb_is_frozen_by_kernel - is superblock frozen by the kernel automatically
+ * @sb: the super to check
+ *
+ * Returns true if the super freeze was initiated by the kernel, automatically,
+ * for instance during system sleep or hibernation.
+ */
+static inline bool sb_is_frozen_by_kernel(struct super_block *sb)
+{
+	return sb->s_writers.frozen == SB_FREEZE_COMPLETE_AUTO;
+}
+
 /**
  * sb_is_frozen - is superblock frozen
  * @sb: the super to check
@@ -1905,7 +1918,7 @@ static inline bool sb_is_frozen_by_user(struct super_block *sb)
  */
 static inline bool sb_is_frozen(struct super_block *sb)
 {
-	return sb_is_frozen_by_user(sb);
+	return sb_is_frozen_by_user(sb) || sb_is_frozen_by_kernel(sb);
 }
 
 /**
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

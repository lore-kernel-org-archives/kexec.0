Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYXg-009nlW-LX
 for kexec@lists.infradead.org; Sat, 17 Apr 2021 00:10:37 +0000
Received: by mail-pf1-f171.google.com with SMTP id m11so19374182pfc.11
 for <kexec@lists.infradead.org>; Fri, 16 Apr 2021 17:10:32 -0700 (PDT)
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v2 3/6] fs: add a helper for thaw_super_locked() which does not
 unlock
Date: Sat, 17 Apr 2021 00:10:23 +0000
Message-Id: <20210417001026.23858-4-mcgrof@kernel.org>
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

The thaw_super_locked() expects the caller to hold the sb->s_umount
semaphore. It also handles the unlocking of the semaphore for you.
Allow for cases where the caller will do the unlocking of the semaphore.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/super.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 72b445a69a45..744b2399a272 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1730,14 +1730,13 @@ int freeze_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(freeze_super);
 
-static int thaw_super_locked(struct super_block *sb)
+/* Caller deals with the sb->s_umount */
+static int __thaw_super_locked(struct super_block *sb)
 {
 	int error;
 
-	if (!sb_is_frozen(sb)) {
-		up_write(&sb->s_umount);
+	if (!sb_is_frozen(sb))
 		return -EINVAL;
-	}
 
 	if (sb_rdonly(sb)) {
 		sb->s_writers.frozen = SB_UNFROZEN;
@@ -1752,7 +1751,6 @@ static int thaw_super_locked(struct super_block *sb)
 			printk(KERN_ERR
 				"VFS:Filesystem thaw failed\n");
 			lockdep_sb_freeze_release(sb);
-			up_write(&sb->s_umount);
 			return error;
 		}
 	}
@@ -1761,10 +1759,25 @@ static int thaw_super_locked(struct super_block *sb)
 	sb_freeze_unlock(sb);
 out:
 	wake_up(&sb->s_writers.wait_unfrozen);
-	deactivate_locked_super(sb);
 	return 0;
 }
 
+/* Handles unlocking of sb->s_umount for you */
+static int thaw_super_locked(struct super_block *sb)
+{
+	int error;
+
+	error = __thaw_super_locked(sb);
+	if (error) {
+		up_write(&sb->s_umount);
+		return error;
+	}
+
+	deactivate_locked_super(sb);
+
+	return 0;
+ }
+
 /**
  * thaw_super -- unlock filesystem
  * @sb: the super to thaw
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

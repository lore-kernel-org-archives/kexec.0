Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0207AC7EE2D
	for <kexec@archiver.kernel.org>; Mon,  8 May 2023 01:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZtvGSp37wiLpcnoPMpaqhS7uXe0frMBcbtJpsHUDohM=; b=r5pzcHGHcQ+Q+t
	jA2/qvsm+URtYYhouoFrCKSMMnjJvomB2A4GNlzKreCHHgdxwNRsTnWWPcX9FS8frT8P7sbWnN+O3
	rgKY81+oCjQc/hFOv+1JFvgFi0wUijkuNyksHhjxJy6iD+DNK9uXUgIZYuT1+MjpoU6KoXXDrj91W
	exilGbOT06arcd/y8Ei2YG5CbBPC6PMuqrVvqPrP3Om0vbybKwHAxlMIsIbALUM3bupKgYz4gp8iH
	/iKNqjrmTEEojkZvqmgqOZZCoAJLwyYx8boUKAIx/GU8mfMIMDwQ5qA5LhQnOCYsWdXWGEDeBhJiJ
	OzgOQ0MlaTqXDwjFMWyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvpVI-00Gvdv-2Y;
	Mon, 08 May 2023 01:17:28 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pvpV8-00GvZ8-04;
	Mon, 08 May 2023 01:17:18 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hch@infradead.org,
	djwong@kernel.org,
	sandeen@sandeen.net,
	song@kernel.org,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	jikos@kernel.org,
	bvanassche@acm.org,
	ebiederm@xmission.com
Cc: mchehab@kernel.org,
	keescook@chromium.org,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org,
	kernel@tuxforce.de,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 6/6] fs: add automatic kernel fs freeze / thaw and remove kthread freezing
Date: Sun,  7 May 2023 18:17:17 -0700
Message-Id: <20230508011717.4034511-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508011717.4034511-1-mcgrof@kernel.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
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

Add support to automatically handle freezing and thawing filesystems
during the kernel's suspend/resume cycle.

This is needed so that we properly really stop IO in flight without
races after userspace has been frozen. Without this we rely on
kthread freezing and its semantics are loose and error prone.
For instance, even though a kthread may use try_to_freeze() and end
up being frozen we have no way of being sure that everything that
has been spawned asynchronously from it (such as timers) have also
been stopped as well.

A long term advantage of also adding filesystem freeze / thawing
supporting during suspend / hibernation is that long term we may
be able to eventually drop the kernel's thread freezing completely
as it was originally added to stop disk IO in flight as we hibernate
or suspend.

This does not remove the superfluous freezer calls on all filesystems.
Each filesystem must remove all the kthread freezer stuff and peg
the fs_type flags as supporting auto-freezing with the FS_AUTOFREEZE
flag.

Subsequent patches remove the kthread freezer usage from each
filesystem, one at a time to make all this work bisectable.
Once all filesystems remove the usage of the kthread freezer we
can remove the FS_AUTOFREEZE flag.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/super.c             | 50 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h     | 14 ++++++++++++
 kernel/power/process.c | 15 ++++++++++++-
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index d5eab6b38b03..148674429ab8 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1910,3 +1910,53 @@ int sb_init_dio_done_wq(struct super_block *sb)
 		destroy_workqueue(wq);
 	return 0;
 }
+
+#ifdef CONFIG_PM_SLEEP
+static bool super_should_freeze(struct super_block *sb)
+{
+	if (!(sb->s_type->fs_flags & FS_AUTOFREEZE))
+		return false;
+	/*
+	 * We don't freeze virtual filesystems, we skip those filesystems with
+	 * no backing device.
+	 */
+	if (sb->s_bdi == &noop_backing_dev_info)
+		return false;
+
+	return true;
+}
+
+int fs_suspend_freeze_sb(struct super_block *sb, void *priv)
+{
+	int error = 0;
+
+	if (!super_should_freeze(sb))
+		goto out;
+
+	pr_info("%s (%s): freezing\n", sb->s_type->name, sb->s_id);
+
+	error = freeze_super(sb, false);
+	if (error && error != -EBUSY)
+		pr_notice("%s (%s): Unable to freeze, error=%d",
+			  sb->s_type->name, sb->s_id, error);
+out:
+	return error;
+}
+
+int fs_suspend_thaw_sb(struct super_block *sb, void *priv)
+{
+	int error = 0;
+
+	if (!super_should_freeze(sb))
+		goto out;
+
+	pr_info("%s (%s): thawing\n", sb->s_type->name, sb->s_id);
+
+	error = thaw_super(sb, false);
+	if (error && error != -EBUSY)
+		pr_notice("%s (%s): Unable to unfreeze, error=%d",
+			  sb->s_type->name, sb->s_id, error);
+out:
+	return error;
+}
+#endif /* CONFIG_PM_SLEEP */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 22dd697ab703..92c85c8ec1ed 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2247,6 +2247,7 @@ struct file_system_type {
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
+#define FS_AUTOFREEZE           (1<<16)	/*  temporary as we phase kthread freezer out */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
 	struct dentry *(*mount) (struct file_system_type *, int,
@@ -2322,6 +2323,19 @@ extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
 extern int freeze_super(struct super_block *super, bool usercall);
 extern int thaw_super(struct super_block *super, bool usercall);
+#ifdef CONFIG_PM_SLEEP
+int fs_suspend_freeze_sb(struct super_block *sb, void *priv);
+int fs_suspend_thaw_sb(struct super_block *sb, void *priv);
+#else
+static inline int fs_suspend_freeze_sb(struct super_block *sb, void *priv)
+{
+	return 0;
+}
+static inline int fs_suspend_thaw_sb(struct super_block *sb, void *priv)
+{
+	return 0;
+}
+#endif
 extern __printf(2, 3)
 int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
 extern int super_setup_bdi(struct super_block *sb);
diff --git a/kernel/power/process.c b/kernel/power/process.c
index cae81a87cc91..7ca7688f0b5d 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -140,6 +140,16 @@ int freeze_processes(void)
 
 	BUG_ON(in_atomic());
 
+	pr_info("Freezing filesystems ... ");
+	error = iterate_supers_reverse_excl(fs_suspend_freeze_sb, NULL);
+	if (error) {
+		pr_cont("failed\n");
+		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
+		thaw_processes();
+		return error;
+	}
+	pr_cont("done.\n");
+
 	/*
 	 * Now that the whole userspace is frozen we need to disable
 	 * the OOM killer to disallow any further interference with
@@ -149,8 +159,10 @@ int freeze_processes(void)
 	if (!error && !oom_killer_disable(msecs_to_jiffies(freeze_timeout_msecs)))
 		error = -EBUSY;
 
-	if (error)
+	if (error) {
+		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
 		thaw_processes();
+	}
 	return error;
 }
 
@@ -188,6 +200,7 @@ void thaw_processes(void)
 	pm_nosig_freezing = false;
 
 	oom_killer_enable();
+	iterate_supers_excl(fs_suspend_thaw_sb, NULL);
 
 	pr_info("Restarting tasks ... ");
 
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

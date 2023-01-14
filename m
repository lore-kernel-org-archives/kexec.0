Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAAFC6379F
	for <kexec@archiver.kernel.org>; Sat, 14 Jan 2023 01:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FR4bDUASe5J2jiLvmiuBFvFsNC2MC628MbjhJjwv9L8=; b=LfIwyLHZGzWvCw
	BjCJPSZYhDI5BuEQ/C9sginDGJTh3E0t03PngF617VRpBHTkwu6teneqT9DeMnzvbXfYfWWYnz3jl
	dFtDBW5zudvalz12rGuDb2KvZQMI2zUVrvm1Eq9v2thiA7bIhg5F6AcoJ6ZX0HloD7z9AHM1Ekwok
	C2JJOW8PSySoDzfsdoxzJMarxJE/pCe+NqpeedUgsJAtZfoe4wu4HAy1j3+OqolQFrLNNqfUXPeD1
	DYa7mHmn4aS3XUGBYDoxfcgMRFZU0LHaUv6Vp///bdn7k6U9QZaLUBICkOfp64T6JfN6NHq1LtitZ
	e4sV+ruWBTgjKb/sD5yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGVcu-0050fH-FH; Sat, 14 Jan 2023 01:46:32 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGUUs-004tvz-UW; Sat, 14 Jan 2023 00:34:10 +0000
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
Subject: [RFC v3 02/24] fs: add frozen sb state helpers
Date: Fri, 13 Jan 2023 16:33:47 -0800
Message-Id: <20230114003409.1168311-3-mcgrof@kernel.org>
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

Provide helpers so that we can check a superblock frozen state.
This will make subsequent changes easier to read. This makes
no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/ext4/ext4_jbd2.c |  2 +-
 fs/gfs2/sys.c       |  2 +-
 fs/quota/quota.c    |  4 ++--
 fs/super.c          |  4 ++--
 fs/xfs/xfs_trans.c  |  3 +--
 include/linux/fs.h  | 22 ++++++++++++++++++++++
 6 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 77f318ec8abb..ef441f15053b 100644
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
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index d0b80552a678..b98be03d0d1e 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -146,7 +146,7 @@ static ssize_t uuid_show(struct gfs2_sbd *sdp, char *buf)
 static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
 {
 	struct super_block *sb = sdp->sd_vfs;
-	int frozen = (sb->s_writers.frozen == SB_UNFROZEN) ? 0 : 1;
+	int frozen = sb_is_unfrozen(sb) ? 0 : 1;
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", frozen);
 }
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 052f143e2e0e..d8147c21bf03 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -890,13 +890,13 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 	sb = user_get_super(dev, excl);
 	if (!sb)
 		return ERR_PTR(-ENODEV);
-	if (thawed && sb->s_writers.frozen != SB_UNFROZEN) {
+	if (thawed && sb_is_unfrozen(sb)) {
 		if (excl)
 			up_write(&sb->s_umount);
 		else
 			up_read(&sb->s_umount);
 		wait_event(sb->s_writers.wait_unfrozen,
-			   sb->s_writers.frozen == SB_UNFROZEN);
+			   sb_is_unfrozen(sb));
 		put_super(sb);
 		goto retry;
 	}
diff --git a/fs/super.c b/fs/super.c
index a31a41b313f3..fdcf5a87af0a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -883,7 +883,7 @@ int reconfigure_super(struct fs_context *fc)
 
 	if (fc->sb_flags_mask & ~MS_RMT_MASK)
 		return -EINVAL;
-	if (sb->s_writers.frozen != SB_UNFROZEN)
+	if (!(sb_is_unfrozen(sb)))
 		return -EBUSY;
 
 	retval = security_sb_remount(sb, fc->security);
@@ -907,7 +907,7 @@ int reconfigure_super(struct fs_context *fc)
 			down_write(&sb->s_umount);
 			if (!sb->s_root)
 				return 0;
-			if (sb->s_writers.frozen != SB_UNFROZEN)
+			if (!sb_is_unfrozen(sb))
 				return -EBUSY;
 			remount_ro = !sb_rdonly(sb);
 		}
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 7bd16fbff534..ceb4890a4c96 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -267,8 +267,7 @@ xfs_trans_alloc(
 	 * Zero-reservation ("empty") transactions can't modify anything, so
 	 * they're allowed to run while we're frozen.
 	 */
-	WARN_ON(resp->tr_logres > 0 &&
-		mp->m_super->s_writers.frozen == SB_FREEZE_COMPLETE);
+	WARN_ON(resp->tr_logres > 0 && sb_is_frozen(mp->m_super));
 	ASSERT(!(flags & XFS_TRANS_RES_FDBLKS) ||
 	       xfs_has_lazysbcount(mp));
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5042f5ab74a4..c0cab61f9f9a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1604,6 +1604,28 @@ static inline bool sb_start_intwrite_trylock(struct super_block *sb)
 	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
 }
 
+/**
+ * sb_is_frozen - is superblock frozen
+ * @sb: the super to check
+ *
+ * Returns true if the super is frozen.
+ */
+static inline bool sb_is_frozen(struct super_block *sb)
+{
+	return sb->s_writers.frozen == SB_FREEZE_COMPLETE;
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
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

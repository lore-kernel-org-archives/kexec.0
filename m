Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973A8C3DA78
	for <kexec@archiver.kernel.org>; Sat, 14 Jan 2023 01:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8oAl8lAA7ItNwqk1pAOPZmkFUv8bWtDQIdkYtAVDm+A=; b=3ULNCJfxihOQ2t
	xI4JTgyD9BNF2G49KKWjQ6jkpetORW9AbR7vz9PpQ1sE/RDVa/uCHxzH1R2m2GSdPuhzrBmRYQeUu
	3x+sXdzJLjmP6cZTfhqZiRrh9oqUJ+bjtGvuK+Q04QkL3AjHLffbnjWAwggOvnnwUqYa5nvo4igJn
	1Naunun4T2/mrPXcWNWsWK/fDgjpvYHiveqtzS5WV7EENnPhRX7LLmrhn2cPN6XSIvf0YdpZLEGf6
	B0lWhlCjjnlVX70C/H4o7AAA18BgX116l2dpaEjzr7xpuz6DjFLQc+Uln4WTLKIH+F2k6NHVMY/80
	v/HhpF7dN8W4QkMwCPfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGVcl-0050Ut-6Z; Sat, 14 Jan 2023 01:46:23 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGUUt-004twJ-Dw; Sat, 14 Jan 2023 00:34:11 +0000
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
Subject: [RFC v3 12/24] jfs: replace kthread freezing with auto fs freezing
Date: Fri, 13 Jan 2023 16:33:57 -0800
Message-Id: <20230114003409.1168311-13-mcgrof@kernel.org>
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

The kernel power management now supports allowing the VFS
to handle filesystem freezing freezes and thawing. Take advantage
of that and remove the kthread freezing. This is needed so that we
properly really stop IO in flight without races after userspace
has been frozen. Without this we rely on kthread freezing and
its semantics are loose and error prone.

The filesystem therefore is in charge of properly dealing with
quiescing of the filesystem through its callbacks if it thinks
it knows better than how the VFS handles it.

The following Coccinelle rule was used as to remove the now superflous
freezer calls:

spatch --sp-file fs-freeze-cleanup.cocci --in-place --timeout 120 --dir fs/jfs --jobs 12 --use-gitgrep

@ remove_set_freezable @
expression time;
statement S, S2;
expression task, current;
@@

(
-       set_freezable();
|
-       if (try_to_freeze())
-               continue;
|
-       try_to_freeze();
|
-       freezable_schedule();
+       schedule();
|
-       freezable_schedule_timeout(time);
+       schedule_timeout(time);
|
-       if (freezing(task)) { S }
|
-       if (freezing(task)) { S }
-       else
	    { S2 }
|
-       freezing(current)
)

@ remove_wq_freezable @
expression WQ_E, WQ_ARG1, WQ_ARG2, WQ_ARG3, WQ_ARG4;
identifier fs_wq_fn;
@@

(
    WQ_E = alloc_workqueue(WQ_ARG1,
-                              WQ_ARG2 | WQ_FREEZABLE,
+                              WQ_ARG2,
			   ...);
|
    WQ_E = alloc_workqueue(WQ_ARG1,
-                              WQ_ARG2 | WQ_FREEZABLE | WQ_ARG3,
+                              WQ_ARG2 | WQ_ARG3,
			   ...);
|
    WQ_E = alloc_workqueue(WQ_ARG1,
-                              WQ_ARG2 | WQ_ARG3 | WQ_FREEZABLE,
+                              WQ_ARG2 | WQ_ARG3,
			   ...);
|
    WQ_E = alloc_workqueue(WQ_ARG1,
-                              WQ_ARG2 | WQ_ARG3 | WQ_FREEZABLE | WQ_ARG4,
+                              WQ_ARG2 | WQ_ARG3 | WQ_ARG4,
			   ...);
|
	    WQ_E =
-               WQ_ARG1 | WQ_FREEZABLE
+               WQ_ARG1
|
	    WQ_E =
-               WQ_ARG1 | WQ_FREEZABLE | WQ_ARG3
+               WQ_ARG1 | WQ_ARG3
|
    fs_wq_fn(
-               WQ_FREEZABLE | WQ_ARG2 | WQ_ARG3
+               WQ_ARG2 | WQ_ARG3
    )
|
    fs_wq_fn(
-               WQ_FREEZABLE | WQ_ARG2
+               WQ_ARG2
    )
|
    fs_wq_fn(
-               WQ_FREEZABLE
+               0
    )
)

@ add_auto_flag @
expression E1;
identifier fs_type;
@@

struct file_system_type fs_type = {
	.fs_flags = E1
+                   | FS_AUTOFREEZE
	,
};

Generated-by: Coccinelle SmPL
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/jfs/jfs_logmgr.c | 11 +++--------
 fs/jfs/jfs_txnmgr.c | 31 +++++++++----------------------
 fs/jfs/super.c      |  2 +-
 3 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 695415cbfe98..32df79fc09a2 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -2317,14 +2317,9 @@ int jfsIOWait(void *arg)
 			spin_lock_irq(&log_redrive_lock);
 		}
 
-		if (freezing(current)) {
-			spin_unlock_irq(&log_redrive_lock);
-			try_to_freeze();
-		} else {
-			set_current_state(TASK_INTERRUPTIBLE);
-			spin_unlock_irq(&log_redrive_lock);
-			schedule();
-		}
+		set_current_state(TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&log_redrive_lock);
+		schedule();
 	} while (!kthread_should_stop());
 
 	jfs_info("jfsIOWait being killed!");
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index ffd4feece078..6c6dee3a16cc 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -2696,6 +2696,7 @@ int jfs_lazycommit(void *arg)
 	struct tblock *tblk;
 	unsigned long flags;
 	struct jfs_sb_info *sbi;
+	DECLARE_WAITQUEUE(wq, current);
 
 	do {
 		LAZY_LOCK(flags);
@@ -2742,19 +2743,11 @@ int jfs_lazycommit(void *arg)
 		}
 		/* In case a wakeup came while all threads were active */
 		jfs_commit_thread_waking = 0;
-
-		if (freezing(current)) {
-			LAZY_UNLOCK(flags);
-			try_to_freeze();
-		} else {
-			DECLARE_WAITQUEUE(wq, current);
-
-			add_wait_queue(&jfs_commit_thread_wait, &wq);
-			set_current_state(TASK_INTERRUPTIBLE);
-			LAZY_UNLOCK(flags);
-			schedule();
-			remove_wait_queue(&jfs_commit_thread_wait, &wq);
-		}
+		add_wait_queue(&jfs_commit_thread_wait, &wq);
+		set_current_state(TASK_INTERRUPTIBLE);
+		LAZY_UNLOCK(flags);
+		schedule();
+		remove_wait_queue(&jfs_commit_thread_wait, &wq);
 	} while (!kthread_should_stop());
 
 	if (!list_empty(&TxAnchor.unlock_queue))
@@ -2931,15 +2924,9 @@ int jfs_sync(void *arg)
 		}
 		/* Add anon_list2 back to anon_list */
 		list_splice_init(&TxAnchor.anon_list2, &TxAnchor.anon_list);
-
-		if (freezing(current)) {
-			TXN_UNLOCK();
-			try_to_freeze();
-		} else {
-			set_current_state(TASK_INTERRUPTIBLE);
-			TXN_UNLOCK();
-			schedule();
-		}
+		set_current_state(TASK_INTERRUPTIBLE);
+		TXN_UNLOCK();
+		schedule();
 	} while (!kthread_should_stop());
 
 	jfs_info("jfs_sync being killed");
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index d2f82cb7db1b..8ca77aa0b6f9 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -906,7 +906,7 @@ static struct file_system_type jfs_fs_type = {
 	.name		= "jfs",
 	.mount		= jfs_do_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_AUTOFREEZE,
 };
 MODULE_ALIAS_FS("jfs");
 
-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF55C3DA78
	for <kexec@archiver.kernel.org>; Sat, 14 Jan 2023 01:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VNVTUKs/QQDqjeG0HDUQM7rPm3/g3NRId3/r0WkoTEw=; b=hAonqKOfdyNeP7
	JiEv/eFz3Fk1GHkinQaXW4C2GvovyuSSz14hej+qM2CZjYeI4TzOgT0fzO4ljAqgCzyUcLW0PgyXJ
	YXTXe1fiwzmxO7ELQ3O3HNR2kceQUQWee8dnU5PAhf3XdBQl+KM8i/xAvxkhLb57tmtUtRKS6FcdQ
	Mz4v5vO6IR9SaJImBR7uEl4nAuuWvmtz/0LZi2MaOzIXdWvdijpJhPsgUeEap6mfe/jXdq1KAFhhj
	v7rn+JBSPAicvPxZyMdsIHMVrJ04g8SzA9hJa7sWDJEjjwgqnEw4IaLPAvPEfbBm29z20hCmICtnu
	mVAD/DfGUAlaAV1C1+yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGVcp-0050YW-Md; Sat, 14 Jan 2023 01:46:27 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGUUt-004twD-9G; Sat, 14 Jan 2023 00:34:11 +0000
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
Subject: [RFC v3 09/24] f2fs: replace kthread freezing with auto fs freezing
Date: Fri, 13 Jan 2023 16:33:54 -0800
Message-Id: <20230114003409.1168311-10-mcgrof@kernel.org>
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

spatch --sp-file fs-freeze-cleanup.cocci --in-place --timeout 120 --dir fs/f2fs --jobs 12 --use-gitgrep

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
 fs/f2fs/gc.c      | 3 +--
 fs/f2fs/segment.c | 6 +-----
 fs/f2fs/super.c   | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8eac3042786b..627a7ea95851 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -42,12 +42,11 @@ static int gc_thread_func(void *data)
 
 	wait_ms = gc_th->min_sleep_time;
 
-	set_freezable();
 	do {
 		bool sync_mode, foreground = false;
 
 		wait_event_interruptible_timeout(*wq,
-				kthread_should_stop() || freezing(current) ||
+				kthread_should_stop() ||
 				waitqueue_active(fggc_wq) ||
 				gc_th->gc_wake,
 				msecs_to_jiffies(wait_ms));
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e2f95f46d298..11cad5287047 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1682,11 +1682,9 @@ static int issue_discard_thread(void *data)
 	unsigned int wait_ms = dcc->min_discard_issue_time;
 	int issued;
 
-	set_freezable();
-
 	do {
 		wait_event_interruptible_timeout(*q,
-				kthread_should_stop() || freezing(current) ||
+				kthread_should_stop() ||
 				dcc->discard_wake,
 				msecs_to_jiffies(wait_ms));
 
@@ -1704,8 +1702,6 @@ static int issue_discard_thread(void *data)
 		if (atomic_read(&dcc->queued_discard))
 			__wait_all_discard_cmd(sbi, NULL);
 
-		if (try_to_freeze())
-			continue;
 		if (f2fs_readonly(sbi->sb))
 			continue;
 		if (kthread_should_stop())
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 87d56a9883e6..e9c6fb04c713 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4645,7 +4645,7 @@ static struct file_system_type f2fs_fs_type = {
 	.name		= "f2fs",
 	.mount		= f2fs_mount,
 	.kill_sb	= kill_f2fs_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_AUTOFREEZE,
 };
 MODULE_ALIAS_FS("f2fs");
 
-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

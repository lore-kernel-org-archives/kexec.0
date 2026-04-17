Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9FBF99C60
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 20:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4EPT7zWcCinytY3BaO+Twey5rBa32BGFjr6gRfkUHZo=; b=Dp2NowqaMRWc9C0qhF2xAdAi9+
	7IC6y6x+8FrBjGGRAHb4/3/Pziyd0hIEFYSeCC6w2zWgdXlLm+1lPj2o9fEORkCgd/K4xjn68MasZ
	76G51jwjXlYqN3VDldZ+HA3i5pHYkOh8ZS9AfTTyrrutcM0m93S5hOC8jjHI9jRMLm1Ljqrv5dAqq
	CaHTE/bzkevD8vu/hTzQbanAvGT2/I7TdlSnPsOVjabp9R+PXiqspNzhZS4BXgy6eeBbJjzV5v+BC
	l9kGFXscvpErOF6HnQbVDY2k2V8++9qht3KcuoPrzc0/LTgRA4b1x38+9UHspuCQ1VgbZairAmwK8
	YYzmK5Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDpzd-00000004SUd-1AW2;
	Fri, 17 Apr 2026 20:40:49 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDpza-00000004STy-1q19
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 20:40:47 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso9647585e9.3
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776458444; x=1777063244; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4EPT7zWcCinytY3BaO+Twey5rBa32BGFjr6gRfkUHZo=;
        b=M71+w+ooQ++5yDyahYVQujqITX2nIJayk/lhJc/XwT0IFR23s6hazoGf0WMYlvYXYS
         yialoSdzYJQh5GZZDt2P3tFxAa34X/BKkc6M70hAMeNO6wzV73l/HdOn3V0462uiJZLG
         4SJEIQh9lyo/OGOOHexbZaE3kTEntPZkiAKPDwyvR5pNm/Z+K9HNRuT4+jyAdPecHoJH
         R5RQ+8esqiogiqZbFwCu8l497zbXbKk2blD5bgjllaxPlxr0T295fnLknjQhBxWEU/dH
         klgvLG7/AVLLfpC04z/YRVW7RZd60rgQy0oWRYdHuj2BX3e9nqC6UJtMnjNDRWgRZLRh
         8FMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776458444; x=1777063244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EPT7zWcCinytY3BaO+Twey5rBa32BGFjr6gRfkUHZo=;
        b=Kqfuy6l74o964CTTzGfQqr92uklhxr4WTEQM1tt5tqEp4Cf0cO91ONm/m+ZmQW/0nA
         Nx0Aazxdhs+vjKfD9w1dy2HHgYc5Tz8MAfjcmFrfN5RlWohfRnigdwaYRMIm+GM5q5Rh
         wO1SEMU/Pe6P1JEgGdDAV821IQcWyNjD/xTHSQ+agGQ8fBv0vnWNCLbPOoMGbKh/z3Nj
         GkpuauwjHpBPVxTgKs5e8II6jViANOGTcXyFGUfFyLmOnfBozQ8N8/D4C3xA7LE5ncYZ
         uNlx9knYi4QHQkj/WHEvbsQyHtfOzFvxuqWJKsZUCX6kQ4w5RADa3GNdfMxzLW7ssy0+
         p4aA==
X-Gm-Message-State: AOJu0YxUQoNxUSp49SYAmm5QcImzxZsqGtL7JlmNuxnySagAUugr84LN
	ZRjSh3jULI4U5l7cL8Z1ITyJ0K/40Fpvpy5A+xt+WFf9BtT7o31eWRn04uSDjA==
X-Gm-Gg: AeBDietKdXtHbktzaCH/L9moufcoq7z8iVL2JJcjVPdPm7ZjbKl0cJqQ9u1O6EUysr0
	5p8PQQDg3mcq+RHtMtlvqIsOBKmuA5J6ZBqNL8rlLmMB/Z8KdI4OAT5YQE9/UKDRi0K086w+aet
	/jNbnDEdE5NvorxT2Jt1ZNVpN1huhSaiX//p4HRUmc+ZbvTLSMctPXpJVawGOk7b5hv8T62dSH9
	uvO5IbL7SL3VTiEfb9VFR0i76UQ1fheRaJvsWtTs9AxB4kCmvKIahQkCv2oVc3zHhddaog6foFG
	Dpn9i3JddgZRwpB6cF6OaDa1ikzZXpn0PdE6Gub3Xsv4PdrCRkWtCBPjl7Hw/hhhIxbbNjM8eXW
	MJqqwqnaEMLkKUUB2ZRCtpCjPQJwBAYb6R/3Ab6VPbdgWuHMkyemJx9LAp6ANZCT0dEpq9/Cv2/
	deBWVQ2O2ypgr5C5rKgyBKqaYWbKfMgGvcXJB6gsI=
X-Received: by 2002:a05:600c:4e0e:b0:485:557d:9fe with SMTP id 5b1f17b1804b1-488fb74d67dmr62314255e9.12.1776458443859;
        Fri, 17 Apr 2026 13:40:43 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:9586:30a1:a0a6:f076])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc100162sm76043665e9.5.2026.04.17.13.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 13:40:43 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	brauner@kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v3] liveupdate: add LUO_SESSION_MAGIC magic inode type
Date: Fri, 17 Apr 2026 21:40:00 +0100
Message-ID: <20260417204039.1827319-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_134046_525452_9003FF04 
X-CRM114-Status: GOOD (  21.78  )
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

From: Luca Boccassi <luca.boccassi@gmail.com>

In userspace when managing LUO sessions we want to be able to identify
a FD as a LUO session, in order to be able to do the special handling
that they require in order to function as intended on kexec.

Currently this requires scraping procfs and doing string matching on
the prefix of the dname, which is not an ideal interface.

Add a singleton inode type with a magic value, so that we can
programmatically identify a fd as a LUO session via fstat().

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
This was requested by Lennart and Christian when discussing integration
with systemd for LUO management.

v2: apply one fix from bot review about cleanup on error path:
    https://sashiko.dev/#/patchset/20260415184536.1155220-1-luca.boccassi%40gmail.com
    the other comments are invalid: luo is not a kmod, and the write hooks are not set up
v3: add test case to liveupdate selftest

 include/uapi/linux/magic.h                    |  1 +
 kernel/liveupdate/luo_core.c                  | 10 ++-
 kernel/liveupdate/luo_internal.h              |  2 +
 kernel/liveupdate/luo_session.c               | 73 +++++++++++++++++--
 .../testing/selftests/liveupdate/liveupdate.c | 40 ++++++++++
 5 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 4f2da935a76cc..4f51005522ffe 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -105,5 +105,6 @@
 #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
 #define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */
 #define NULL_FS_MAGIC		0x4E554C4C	/* "NULL" */
+#define LUO_SESSION_MAGIC	0x4c554f53	/* "LUOS" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index dda7bb57d421c..f1a63ebe4fa44 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -197,9 +197,17 @@ static int __init luo_late_startup(void)
 	if (!liveupdate_enabled())
 		return 0;
 
+	err = luo_session_fs_init();
+	if (err) {
+		luo_global.enabled = false;
+		return err;
+	}
+
 	err = luo_fdt_setup();
-	if (err)
+	if (err) {
+		luo_session_fs_cleanup();
 		luo_global.enabled = false;
+	}
 
 	return err;
 }
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 8083d8739b093..d4ac7b4c58829 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -79,6 +79,8 @@ struct luo_session {
 
 int luo_session_create(const char *name, struct file **filep);
 int luo_session_retrieve(const char *name, struct file **filep);
+int __init luo_session_fs_init(void);
+void __init luo_session_fs_cleanup(void);
 int __init luo_session_setup_outgoing(void *fdt);
 int __init luo_session_setup_incoming(void *fdt);
 int luo_session_serialize(void);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index af9e498206d24..f30151c37bd43 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -50,7 +50,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/anon_inodes.h>
 #include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -62,7 +61,10 @@
 #include <linux/libfdt.h>
 #include <linux/list.h>
 #include <linux/liveupdate.h>
+#include <linux/magic.h>
+#include <linux/mount.h>
 #include <linux/mutex.h>
+#include <linux/pseudo_fs.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
@@ -376,18 +378,58 @@ static const struct file_operations luo_session_fops = {
 	.unlocked_ioctl = luo_session_ioctl,
 };
 
+static struct vfsmount *luo_session_mnt __ro_after_init;
+static struct inode *luo_session_inode __ro_after_init;
+
+static char *luo_session_dname(struct dentry *dentry, char *buffer, int buflen)
+{
+	return dynamic_dname(buffer, buflen, "luo_session:%s",
+			     dentry->d_name.name);
+}
+
+static const struct dentry_operations luo_session_dentry_operations = {
+	.d_dname	= luo_session_dname,
+};
+
+static int luo_session_init_fs_context(struct fs_context *fc)
+{
+	struct pseudo_fs_context *ctx;
+
+	ctx = init_pseudo(fc, LUO_SESSION_MAGIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	fc->s_iflags |= SB_I_NOEXEC;
+	fc->s_iflags |= SB_I_NODEV;
+	ctx->dops = &luo_session_dentry_operations;
+	return 0;
+}
+
+static struct file_system_type luo_session_fs_type = {
+	.name = "luo_session",
+	.init_fs_context = luo_session_init_fs_context,
+	.kill_sb = kill_anon_super,
+};
+
 /* Create a "struct file" for session */
 static int luo_session_getfile(struct luo_session *session, struct file **filep)
 {
-	char name_buf[128];
+	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH + 1];
 	struct file *file;
 
 	lockdep_assert_held(&session->mutex);
-	snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
-	file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);
-	if (IS_ERR(file))
+
+	ihold(luo_session_inode);
+
+	snprintf(name_buf, sizeof(name_buf), "%s", session->name);
+	file = alloc_file_pseudo(luo_session_inode, luo_session_mnt, name_buf,
+				 O_RDWR, &luo_session_fops);
+	if (IS_ERR(file)) {
+		iput(luo_session_inode);
 		return PTR_ERR(file);
+	}
 
+	file->private_data = session;
 	*filep = file;
 
 	return 0;
@@ -662,3 +704,24 @@ void luo_session_resume(void)
 	up_write(&luo_session_global.outgoing.rwsem);
 	up_write(&luo_session_global.incoming.rwsem);
 }
+
+int __init luo_session_fs_init(void)
+{
+	luo_session_mnt = kern_mount(&luo_session_fs_type);
+	if (IS_ERR(luo_session_mnt))
+		return PTR_ERR(luo_session_mnt);
+
+	luo_session_inode = alloc_anon_inode(luo_session_mnt->mnt_sb);
+	if (IS_ERR(luo_session_inode)) {
+		kern_unmount(luo_session_mnt);
+		return PTR_ERR(luo_session_inode);
+	}
+
+	return 0;
+}
+
+void __init luo_session_fs_cleanup(void)
+{
+	iput(luo_session_inode);
+	kern_unmount(luo_session_mnt);
+}
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index bdc1cedc4f944..27b3cbff6c739 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -22,9 +22,12 @@
 #include <fcntl.h>
 #include <string.h>
 #include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/vfs.h>
 #include <unistd.h>
 
 #include <linux/liveupdate.h>
+#include <linux/magic.h>
 
 #include "../kselftest.h"
 #include "../kselftest_harness.h"
@@ -416,4 +419,41 @@ TEST_F(liveupdate_device, get_session_name_max_length)
 	ASSERT_EQ(close(session_fd), 0);
 }
 
+/*
+ * Test Case: Session fstat
+ *
+ * Verifies that fstatfs() on a session file descriptor reports the
+ * LUO_SESSION_MAGIC filesystem type, and that fstat() returns consistent
+ * inode numbers across different sessions (shared singleton inode).
+ */
+TEST_F(liveupdate_device, session_fstat)
+{
+	int session_fd1, session_fd2;
+	struct statfs sfs;
+	struct stat st1, st2;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd1 = create_session(self->fd1, "fstat-session-1");
+	ASSERT_GE(session_fd1, 0);
+
+	session_fd2 = create_session(self->fd1, "fstat-session-2");
+	ASSERT_GE(session_fd2, 0);
+
+	/* Verify the filesystem type is LUO_SESSION_MAGIC */
+	ASSERT_EQ(fstatfs(session_fd1, &sfs), 0);
+	EXPECT_EQ(sfs.f_type, LUO_SESSION_MAGIC);
+
+	/* Verify both sessions share the same inode number */
+	ASSERT_EQ(fstat(session_fd1, &st1), 0);
+	ASSERT_EQ(fstat(session_fd2, &st2), 0);
+	EXPECT_EQ(st1.st_ino, st2.st_ino);
+
+	ASSERT_EQ(close(session_fd1), 0);
+	ASSERT_EQ(close(session_fd2), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.3



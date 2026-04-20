Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3785AF588DF
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M1sjF4LQS9btS3anaMkMUdTrbJ6r/ruqhuae7ESZnko=; b=s3iOvjHTfzuM0hy4+BcUYbF6pF
	1gVLdGIl/O1RJHEsnPepbLFHGbRr5JTpGdGmy9ZpccOqw2nFcPXvfc8//ung/19Bj6YEaE3tUP2ZY
	4o1mR4kNErUqdoZ3AMrn95MnbzM/a+R8JB8fHYaSOu3l8ECsv2tkRRujoV4YmqtzzCKc8r8Vo6x92
	shvB/wNcAyX6M2rk6YiOqXaSH+KBkHiQ//83ha6rmBpkyq32XfKOltY89x1/IhW2JVgHPHuCK6Z4I
	V1sM7i5HQ9OwX8ciF2wtdho1m1uZabpeo1oR95RvEkd9HrlswzsTZ9F6vQIfJ6XCzQDC18myzhYwU
	aPypwnYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpRj-000000079ub-10NH;
	Mon, 20 Apr 2026 14:17:55 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpRe-000000079qf-3g1V
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 14:17:51 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-43eada6d900so3130139f8f.0
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776694669; x=1777299469; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1sjF4LQS9btS3anaMkMUdTrbJ6r/ruqhuae7ESZnko=;
        b=hHI5010kanlDI62nQNO88adC4djzVZxcdrvdso/Fv9igAnZjkTwARNqEIA5LWNEwlF
         uAVPiyVEs6tFkW9Z8fvMZ5oa+uz4necsyCyCujsod/P/T52PZK9O6GwBlJ/s4NQ/mXUH
         Kq/0269tkXooT33F3YoFPyDrVrq7YC4axgyFF65uxUIjBzVvsCC49u3jVmIGVplbESep
         TgyyIWUt77/dHNKwxtuoQbluZHIn0dLM9Nqe4D47Ics3urzIay3ZRWCxrcIVppBNouaI
         Sm4lv2zMryasEkBb+egK1jTbqgCuR6cwin2rgivlOepPxLFa4pjeXX8yVoJhl5pPAWW8
         VkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694669; x=1777299469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M1sjF4LQS9btS3anaMkMUdTrbJ6r/ruqhuae7ESZnko=;
        b=jZxF6LI1TyI5Al3iKRXJJEX5pt08Wk8WLlIxJS08q7yQfTXFH3Znquds3QpOmL2akd
         A5jJTUzb7DLOWrkPD1L4JHrWDWXxm+GWVYAvuKGOhpT8LuJi4cL/8AUDhwANDeOY8uxk
         dT0ElPNq9spEFTfrHhzyrrr7oRK4p1CgUm25JxHxqVwc26uTxUzLvj72MWy9mZZS4z/h
         9i6SqJwcGh7uXzrWEpTWmyje+nF/E1C33WwwWE2GqUCa/PgSTiDsYdhph5kc3i72nsKT
         XpWt4wfKl/u36maqp7XjAqQHjpkH4jAF4O8qGYfP0RJ0eOojLM1yoPpKUj66Vixwl0ny
         FY+A==
X-Gm-Message-State: AOJu0Yz9Zd6OX6wXIqN8bOQcSO6deSUCf+HFJbxl4wqDykWPEiaBC8Ug
	kGxqFaC6MZqIZYFKqUj/KiDAb4TPLguQdFIMYNkkYS61tTNUO8LTACq/c/uq/A==
X-Gm-Gg: AeBDiev748zM5OlBLBG+ZB+0fjIMFHZ55PUoqH2EjicttyYDjDACpnbctKMGECoMmd7
	PCixrGbP9L9MAOZxEWxREZNnPWHU94htsVF807xZyNzkQmDAGS71LRDmiVV6vzYXTxn1RA4J+FK
	8U1YLTe/IP195o1noPj+rq47FvQB4Vz0BJqL45lMzmPGocg0DlMeh37Zc3024ZgCg+dokJy/9mS
	c9LNJae502kH+pnZhUNB3iwQ7Ydbwgr4KT6yN/PSH3MBlBZVuKrGWStgfTSbq+IHcfjjvph3UTX
	oJbsk/0W2yMCHjJwLNqe7Rem9ncek3TC1BS9HGsFo9y8CBLw5CE/YxeCkuztjgrgd41jO24PP5w
	vgxWx+FBHxmprB/Fkk/G36a3Li/4varuWo3wWkZueY5Skkp/Hnf5I+eKCG05fz/9O8RQCp1t7kU
	pgkshIlFtQJPOfxLSxBwGjyl0+0V2o4l3pEs9fzEg=
X-Received: by 2002:a5d:5f43:0:b0:43c:fde6:212d with SMTP id ffacd0b85a97d-43fe3e13d46mr21731613f8f.33.1776694668709;
        Mon, 20 Apr 2026 07:17:48 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:355d:3be4:308b:c943])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4cb1405sm28641928f8f.4.2026.04.20.07.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:17:48 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v9 3/6] liveupdate: add LUO_SESSION_MAGIC magic inode type
Date: Mon, 20 Apr 2026 15:15:11 +0100
Message-ID: <20260420141741.2688371-4-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420141741.2688371-1-luca.boccassi@gmail.com>
References: <20260420141741.2688371-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_071750_959626_748653A1 
X-CRM114-Status: GOOD (  22.08  )
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
programmatically identify a fd as a LUO session via fstatfs().

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/uapi/linux/magic.h       |  1 +
 kernel/liveupdate/luo_core.c     | 10 +++-
 kernel/liveupdate/luo_internal.h |  2 +
 kernel/liveupdate/luo_session.c  | 91 ++++++++++++++++++++++++++++++--
 4 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 4f2da935a76c..4f51005522ff 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -105,5 +105,6 @@
 #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
 #define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */
 #define NULL_FS_MAGIC		0x4E554C4C	/* "NULL" */
+#define LUO_SESSION_MAGIC	0x4c554f53	/* "LUOS" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index dda7bb57d421..f1a63ebe4fa4 100644
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
index 8083d8739b09..d4ac7b4c5882 100644
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
index 5e316a4c5d71..9e343b6ce513 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -50,7 +50,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/anon_inodes.h>
 #include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -62,11 +61,15 @@
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
 #include <uapi/linux/liveupdate.h>
+#include "../fs/internal.h"
 #include "luo_internal.h"
 
 /* 16 4K pages, give space for 744 sessions */
@@ -363,18 +366,74 @@ static const struct file_operations luo_session_fops = {
 	.unlocked_ioctl = luo_session_ioctl,
 };
 
+static struct vfsmount *luo_session_mnt __ro_after_init;
+static struct inode *luo_session_inode __ro_after_init;
+
+/*
+ * Reject all attribute changes on the singleton session inode.
+ * Without this the VFS falls back to simple_setattr(), allowing
+ * fchmod()/fchown() to modify the shared inode.
+ */
+static const struct inode_operations luo_session_inode_operations = {
+	.setattr	= anon_inode_setattr,
+};
+
+static char *luo_session_dname(struct dentry *dentry, char *buffer, int buflen)
+{
+	return dynamic_dname(buffer, buflen, "luo_session:[%s]",
+			     dentry->d_name.name);
+}
+
+static const struct dentry_operations luo_session_dentry_operations = {
+	.d_dname	= luo_session_dname,
+};
+
+static const struct super_operations luo_session_sops = {
+	.drop_inode	= inode_just_drop,
+	.statfs		= simple_statfs,
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
+	ctx->s_d_flags |= DCACHE_DONTCACHE;
+	ctx->dops = &luo_session_dentry_operations;
+	ctx->ops = &luo_session_sops;
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
@@ -653,3 +712,25 @@ void luo_session_resume(void)
 	up_write(&luo_session_global.outgoing.rwsem);
 	up_write(&luo_session_global.incoming.rwsem);
 }
+
+int __init luo_session_fs_init(void)
+{
+	luo_session_mnt = kern_mount(&luo_session_fs_type);
+	if (IS_ERR(luo_session_mnt))
+		panic("Cannot create LUO Session pseudo-fs");
+
+	luo_session_inode = alloc_anon_inode(luo_session_mnt->mnt_sb);
+	if (IS_ERR(luo_session_inode)) {
+		kern_unmount(luo_session_mnt);
+		return PTR_ERR(luo_session_inode);
+	}
+	luo_session_inode->i_op = &luo_session_inode_operations;
+
+	return 0;
+}
+
+void __init luo_session_fs_cleanup(void)
+{
+	iput(luo_session_inode);
+	kern_unmount(luo_session_mnt);
+}
-- 
2.47.3



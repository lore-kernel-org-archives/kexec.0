Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B4FF99C80
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 11:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CwXFSSY9CL4wYMLHlpKxN2D5JLK22sZ4JptUsMLRIyg=; b=2B/PXO0P9VlYhzOKY75Rs3wDhb
	XicmaIN2XhlUHILY2V6WR3EBQCJCS1OSIwI3aN43SVDHwNE1A7fW4IGDuA2xTl+mMMnAQGkGiYFLA
	SuR3jGRTGtJian33A5dOaK+0Gm0eTNWVnC/rYznUOqrvvEOBy27dC2d7iO4GJLHJrAgjZKOTgZlqM
	/hpTmvl4GRk/t+K7povPvKpEasox/V6xqyEfNnWFEj1CE1Kgm0mKEpPqUANkV5XvbL7PycbjxT+Lk
	UPbRKk82VIaUmOImXqij5083dqf8UUcz7eO1BIDiNM/1kk+7zIiR6NjmnBZqZAujN8d8RpSjG10n9
	/judVHuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE41v-00000004wzM-1ma2;
	Sat, 18 Apr 2026 11:40:07 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE41r-00000004wxM-1q8r
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 11:40:05 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-488b8efed61so15416035e9.1
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776512400; x=1777117200; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CwXFSSY9CL4wYMLHlpKxN2D5JLK22sZ4JptUsMLRIyg=;
        b=rd80ySbxNWmGUqFjKExe4zUHlyeXMTLnmSWp38uMno1C7MyV9aagnjEObsgvMKHpN7
         9Z6ZF30wKd3Yefv/x58aq/EDEQU6N/bM7UP/D4HnzzJ2J8Ng9gGneFxejvceSGYl6pCV
         BgaA5nLE1EgstnvHzQNLsfh3R7Fivy3ZP0244lbURdlIb0ssZH1nLnzM7GR+X+OchzZ2
         DR9N/MRPOoa4Z7nBzO2k6uImtsvyxbqpb3MiK9iGnQKVB56hLW43DGEzhNcY9h7tNH+c
         CZzRvzijMAX5U8ELIjsgnFtBxySGneb2nGVIOAh7Q7IVboiiXlcSYrcZ4XM+PUOqYvES
         RzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776512400; x=1777117200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwXFSSY9CL4wYMLHlpKxN2D5JLK22sZ4JptUsMLRIyg=;
        b=Gweik4vTJWso7F3l6iiIFvcN6R3wHAdyqhwRIASdt9C6xLaR0sENRGBMUvpJDWM8Id
         b03fcxmja2RBkxc2lF4j5twSEDCZPDJ3XxXeVOg80YIleThtn9mhlBO6uCb36uy8RnIY
         ZWyCmI4tidjmYG79kVvgrD8IyvTBH8duIbJH53/t3ShE9/Tq6Bjr89xPDse5BRvSFReh
         NKEkMRCPEknbGCHGoUJFBLBmwD+Im/1Mv5zk0uj++EQMzbqPJ2d0Od74nalU3OA+eQNH
         H7WZG+WoviIPaHPEz9o3v5WFjc2PKEdjWoZHy/8pEQZBEO6RqrwYoW18plNu6aTl6uFG
         6eOA==
X-Gm-Message-State: AOJu0Yzfwzd0Alx0ZXCcQVsvJJuww5Vm8YaF1UxVq6YjV6ZOIG3/TuzU
	qWpzcfCrTsuukXj70BDiZm8VpfO/6uCPfA2R6ojUmA6pBPtGNsOwRxeq0FpLNQ==
X-Gm-Gg: AeBDiesX902MF9BjtT6yqhFFa9+GkzsLVmnqg1g8H7vb7oyvJwsShiSO+VrLu183Fho
	KcX2VzwvAAIZcOMLLlSVkcCw2Sgrk+gZINoj+R8l5Q83WRmqa+tGfv9ip4ONaKmTJRMgFAyVdWW
	32k7fGLjq039ZFB0S0bjjWKFUer+Fn8kQRsklA8sRwoCYXEuW7A7bMBDLbqMwalUEZHISJzGvO7
	p0f5fvdvsUa+kwJToTTWk1TnaTBgnTTNwXmQ3HC1UBJBN5IdMNmHtFGNZZe3BqP5XtScP0Wg31m
	Yd1K2EjF96v4Gnk4SBoUZgdd+xuaEs2JQVzGc54Bj0aqlfhxiMSAJTxRnczjT9uo83RyjWo7+Vx
	Nh3Xlg9JXWPijBgO73IHxUyISa8ijJnKHXvZAx1qqJRaBKjXKN3tLz/pP8Jdfo8eIWKouApBsUq
	JWZwl4+91FKuRrHCLr7ROOp1YnhT4V13KewMYn21AXBBUpznS3kQ==
X-Received: by 2002:a05:600c:4749:b0:488:c6e9:1e0c with SMTP id 5b1f17b1804b1-488fb889385mr82585635e9.5.1776512399669;
        Sat, 18 Apr 2026 04:39:59 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:3ab1:89ce:8d93:ae6c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc1070bfsm119872455e9.7.2026.04.18.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 04:39:58 -0700 (PDT)
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
Subject: [PATCH v6 1/4] liveupdate: add LUO_SESSION_MAGIC magic inode type
Date: Sat, 18 Apr 2026 12:38:38 +0100
Message-ID: <20260418113956.2146648-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_044003_518550_631DD560 
X-CRM114-Status: GOOD (  21.24  )
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
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
This was requested by Lennart and Christian when discussing integration
with systemd for LUO management.

v2: apply one fix from bot review about cleanup on error path:
    https://sashiko.dev/#/patchset/20260415184536.1155220-1-luca.boccassi%40gmail.com
    the other comments are invalid: luo is not a kmod, and the write hooks are not set up
v3: add test case to liveupdate selftest
v4: split test case in separate follow-up patch
v5: add r-b tag, merge series with LIVEUPDATE_SESSION_GET_NAME ioctl
    as they both change the same unit test source file, to avoid merge conflicts

 include/uapi/linux/magic.h       |  1 +
 kernel/liveupdate/luo_core.c     | 10 ++++-
 kernel/liveupdate/luo_internal.h |  2 +
 kernel/liveupdate/luo_session.c  | 73 +++++++++++++++++++++++++++++---
 4 files changed, 80 insertions(+), 6 deletions(-)

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
index 25ae704d7787..5e315cc0dfd5 100644
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
@@ -363,18 +365,58 @@ static const struct file_operations luo_session_fops = {
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
@@ -649,3 +691,24 @@ void luo_session_resume(void)
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
-- 
2.47.3



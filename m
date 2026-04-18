Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EB2F99C87
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8aNn7SeD8N8v13CLxmWBmteIS/DK7+pVMQT0YQ8OKsQ=; b=ChmE9Uv2+giRt58OsJabCKrmVd
	IOsbKBdGPCBSBLLOXqrDu2Jrs+C/UzkATFg+8XEHlM1Ia+tnkFdhn0vyUD77MecMty7Q1B6muFQFP
	Wqh68Hqgm+EqdcgMOddYiGsfQuNkE3hcGKaF0uh3FP4qbd+yrvc5BYbl00haWmSdGeFg/5Q60qe5/
	ao5Y4GzwiL3rKauu01p2wHm8UZEe8vG8d8GfleZqK2tnGP8qixo2Y1hyuL+i4Fzcq389RJVGTmrpl
	cBfHQJUVvmcRYlm7iArZydhnyGSr1w3YSDzwrXn2MnICPhdh6NBEf0Qe0a4uex72CUG6RVw8UzWk7
	XLvGOGEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE6OS-0000000517M-04UQ;
	Sat, 18 Apr 2026 14:11:32 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE6OP-0000000516M-0YEo
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 14:11:30 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-488b8efed61so16282805e9.1
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521487; x=1777126287; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8aNn7SeD8N8v13CLxmWBmteIS/DK7+pVMQT0YQ8OKsQ=;
        b=e7dQXn8FRwBwTL6aGsHs3GG3Gv5dT6i7toN2xJF006YYM4kr0jTDMkZaQeKP7fGrTK
         fl2btrJSk6Tk7BW5AR0VmRqEzdIpPCIfR5PwFNwC5JTn5FBmvu1jaED2wdMAO6EZOWja
         zaVIUiQ4D2uZ7wuw+6yTrd6nvkOrX7vetEt8bp3UftiMKw1DhNHq2mUeGlaridEE4ryl
         qi62ZM9jJOutbP68FR01V6HFSMiAqO29UIoFThp8a5km7a85va+ODr8ob+4Un2W1zOBp
         9OESMApFXbsacwKWtcrtEC6DM3g3tJDX7CIPLLuL9MursmrYJroxdjVt6Z7GiWOjEJ0Y
         nJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521487; x=1777126287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aNn7SeD8N8v13CLxmWBmteIS/DK7+pVMQT0YQ8OKsQ=;
        b=rdPJom0AIAnGnn/CR9+6ZHDd0OzGgZMdj6XNIDFEHhL247MKzaMPPjJB1kPsP6eK6n
         HkLogiGbdjaxj1dUMHwla0zn6YltnPq4T8UBk4a5WteiM3zWVdnSDvUcF89sew12QNAb
         weAWVCX8yNWxvVFozW/Qkq9coz+UGrMXurBXkmjMNDOgko+BLK7t31v/LXus0iEoyVTZ
         QBOaQ8D8pOPk78XHkUPUOTLPLpmtBFj9XfQ8Snvc2UxgE5wYPlpJaqgTHSSY+HbJpA5z
         LmCi0CAxUxlPsZlUBjcEFw0DK8k7imfzgqVQFIDTXTZseKDGloVsRXMO3PQxR87ulODC
         jBzw==
X-Gm-Message-State: AOJu0YxpHpk9wm4DEEVUYJXpyycuck8sY6SxmGysIqscbf5y8LsHF36r
	TxfskzxhWp7mIf6FvuKuhgAHwnNKInp8hlOqQSA9rqAV1ACtGtLcq8bCTdxDng==
X-Gm-Gg: AeBDievhqq+2bi1uwmXaTjrq7ZA6NHiSbhIumdOwmo0jKxrSUYeBqw5rYxhl8FvtMVB
	i+DY7cVVqXAirVjvrnPrTg6/znBZPp5Lhdpi9sTwvpcSRG13dYKP/Cqmuq7pXYXjfrRfzCWNI4+
	a5saMXWq4KtXGVaNW3QbuNgcT8nokYx29NMv3Jgx9Eca0NqZzpSVaFLQ1AhbemrZqNfgkQ4XvWA
	TzMvGVMbBhbJG28qS5yHzEHulklEicpayAdcRwXUB52lj9QMsyQvFSh6a3clND4VhO8E6JyxH8n
	uSEbTYiIWBYw2Zkg6ItE//dSAiXkYo2iJLvZMQ9nl6v1c4QNwIcZ//xc83tAzYbrEdz8LSkA4T1
	Ac+kIdkWkWJFOu+QUissXBsUKD2MhRoKbZcwrIPtM7XJ7NEmT5kHJfwydmwfwbFQjKAGF0PPvYF
	2gs80YPz/ViUWm5Z7GV2MeaneuhPNh/VT5WND9mJM=
X-Received: by 2002:a05:600c:1e28:b0:488:8be1:ca3a with SMTP id 5b1f17b1804b1-488fb8b56bcmr99045135e9.15.1776521486419;
        Sat, 18 Apr 2026 07:11:26 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:4429:3762:47dc:91a3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e46471sm12255364f8f.28.2026.04.18.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:11:25 -0700 (PDT)
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
Subject: [PATCH v7 1/4] liveupdate: add LUO_SESSION_MAGIC magic inode type
Date: Sat, 18 Apr 2026 15:09:37 +0100
Message-ID: <20260418141123.2193917-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_071129_274147_17E0361A 
X-CRM114-Status: GOOD (  22.71  )
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
This was requested by Lennart and Christian when discussing integration
with systemd for LUO management.

v2: apply one fix from bot review about cleanup on error path:
    https://sashiko.dev/#/patchset/20260415184536.1155220-1-luca.boccassi%40gmail.com
    the other comments are invalid: luo is not a kmod, and the write hooks are not set up
v3: add test case to liveupdate selftest
v4: split test case in separate follow-up patch
v5: add r-b tag, merge series with LIVEUPDATE_SESSION_GET_NAME ioctl
    as they both change the same unit test source file, to avoid merge conflicts
v7: apply suggestion from review bot to stub out setattr ops,
    like it was done in 22bdf3d6581a

 include/uapi/linux/magic.h       |  1 +
 kernel/liveupdate/luo_core.c     | 10 +++-
 kernel/liveupdate/luo_internal.h |  2 +
 kernel/liveupdate/luo_session.c  | 89 ++++++++++++++++++++++++++++++--
 4 files changed, 96 insertions(+), 6 deletions(-)

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
index 25ae704d7787..1d35379e4e52 100644
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
@@ -363,18 +365,73 @@ static const struct file_operations luo_session_fops = {
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
+static int luo_session_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			       struct iattr *attr)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct inode_operations luo_session_inode_operations = {
+	.setattr	= luo_session_setattr,
+};
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
@@ -649,3 +706,25 @@ void luo_session_resume(void)
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



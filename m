Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DD0F99C88
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iDd2UIv043iC7kIf40D4/RY2UYV+v4l+fWgRNClaM/s=; b=TqjbqQ4tPpw4qjAOaPm4kVd9L1
	AqmT9xCunmqBW1hcwV9pVzNDqIx8DKxy55Icl085PtT6GC1QUHFWHEx+8KbqmIm/bEqJEVvxO1094
	uiBO8B+hDtyR1uL9pfbp6aJoVQgLgSFpblz9nN7k82nriqo8Unti/05wRqc9KsPS9rAfne01XI0YA
	VVdVGrsseIH057cQ73HQntYJnew0OqIYaQVL595IfAgvbGqesRErcPE1geKIbl3Nvvb/fitESX2/4
	ZInxgcTaW+pwEMxpjGm4p8vMMC0SxvdzS4mQZagxqEZCCT8za27E/VL7+jVp0XckOSXu9B/sI2N9A
	+4ykNmfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8ce-000000055l9-1U2F;
	Sat, 18 Apr 2026 16:34:20 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8cX-000000055iU-3Uc8
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 16:34:17 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso21303585e9.1
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 09:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776530052; x=1777134852; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDd2UIv043iC7kIf40D4/RY2UYV+v4l+fWgRNClaM/s=;
        b=THcdlJudVk2OfUwtj1SB0drNX2z+D+/K4VVzm0B5teyx/AiqJAKP9yPW7+GRkDbF9t
         6p0uf9DqxgWH4fE2H2lregNK8jfo0L6UxFxza2SEE18PNwfem0nlmOqir+Hw0kjp6AQe
         VXtUk2r1bRCYBo5D6hCPSA1YkPaq8fIzBp9315Ge6aqIhCAGAigj3ca/5VFZVOK0SY94
         xOLYASdqzC4Qr/o6jDw60e/9OWnPij0KUcp7EOHiG9vjZ5NsVaRCgdwoi2tBYbToBRTA
         VJxDZqRgtviclJUYZ5QXICIA1/jHo1peZbfBgYkjHrmt5UHkRh2vH0wteKK9d3RsHgxT
         tpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776530052; x=1777134852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iDd2UIv043iC7kIf40D4/RY2UYV+v4l+fWgRNClaM/s=;
        b=oa6j/fAhNdq15zCJBGZ5KX7z9RTklAmZqDQonqSpC0WBFXxDvhdzVmuKOMSnWSxifP
         m2CaXGKf1ou0/jtlaJ9jfLNu5thKXc2uddE7aoxcwPhAT5ebhQZjNxkEVG203Zlnxt1d
         T3QoapGm4SbM2ZPMdy+G9ek9mBJEAy81WZ51sAIDiQ5GX1HjcrrveEAjeqdyrgkktuyP
         VLeCizIzRukUT02u2qyAQzvNjXtbmftJGSV5BHSDjPvGUR73tQaS9BLdSgscn1jNRwaQ
         zP0Hdvuz17H7BQv1bzx6G2ptdw8bLOO+p2s0T93iien+cvuXZn7RE6vH/HpWqtU2uarU
         2fag==
X-Gm-Message-State: AOJu0Yx5h6vrZGMRtuggqHqtPZ+ck25HVFgtJuvSe4TUhSZROq4TRusY
	X25PqFUj2LlmSoqCd6XbZoyaw5HY4lVHjWRaKEfip58v1vkya6dLJnYz7VTdQA==
X-Gm-Gg: AeBDiesNE1+M3aRwZPsvkUGKfZeyga2e5QGTX9SuhDeDqCnSnprYwX9c1iQf/mRHNAc
	fBQ6JBwwX3i3pdsr4Tny0Guqpal49YI3hEp4QZ1PK4VWInQ89lMrUtADOkfFNhAZitDYm5y0ltW
	iuRMaxHnpCjAugtmMYqXoIe4IDPngVN/29884b3Lwgw/Uh3/E57nMLTolRW4FHTVBIqgexZ601+
	KA9JZaEbUhQn1/oQ2gpcPJW9oGr7uVvzV+w6SjI65GDEkNBaozmSj4SxsKdsgmRzfrrkfSodcph
	lZA7PeZc3H5rCONzFZld7ScFJ5lwVEgJdoU0Fx0VIEnos1ZdQ/q2ZdU0ZsB6kFO/I6ennczZR4n
	Kc5NN8VyAHSgCByeqtOWd6MvTBbZJ32gz6ghrBaIzdxe/Uk58F2hux8YJJVc82mNP1YNXC1+Gvk
	oJ154pYE+NHvO2spPHDET3bBGUX7H0tMS4U/hWHkp+NrMjvkIhmA==
X-Received: by 2002:a05:600c:8183:b0:488:b187:3c with SMTP id 5b1f17b1804b1-488fb765ab5mr111343235e9.14.1776530051601;
        Sat, 18 Apr 2026 09:34:11 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:e054:93f2:97bf:84c6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc1c96b4sm229038205e9.13.2026.04.18.09.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:34:11 -0700 (PDT)
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
Subject: [PATCH v8 3/6] liveupdate: add LUO_SESSION_MAGIC magic inode type
Date: Sat, 18 Apr 2026 17:28:20 +0100
Message-ID: <20260418163358.2304490-4-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418163358.2304490-1-luca.boccassi@gmail.com>
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_093416_161801_D43D8B04 
X-CRM114-Status: GOOD (  21.56  )
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
index 5e316a4c5d71..21cbe99fc819 100644
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
@@ -653,3 +710,25 @@ void luo_session_resume(void)
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



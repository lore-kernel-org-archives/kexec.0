Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA30F43689
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 09:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xd92ZSF+vA4E4hE1DpIDZAUuBJ6aFxleeIBaxyrSMhM=; b=4W3ZopYftLy+yIRY7/+FS5/gHS
	3X128ymFeZ6sfikQjQHE6Bypru2389LY03fe+om5da8FqfLZSGvPI8PUV+/K86i8yMm7g6c5BqZIU
	FBDFTWq73lLjy96x7F5/lL+MmH7dAR0OV3BQqKeuVsixTx9VphlF+eMQAH/TAL1c3xpT/1UfH/7+W
	JwJTRY/XyqCsHe7flKvynDUYlqjXTAz+bZ/jZiUw4wng07lBGzxOHZT71Zgz2OpBdb2QtWHxGta7n
	zJXpQiE+yHwA92qDX41hQpjNPM8QH6pgCO/hptwMe0y/Z/HPlFVcZ8ZKSmngjJEUDmS4xaKnFq+eQ
	VPpj3OBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDfkY-00000003qf0-0D72;
	Fri, 17 Apr 2026 09:44:34 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDfkU-00000003qee-3Wnx
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 09:44:32 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso13888485e9.1
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 02:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776419069; x=1777023869; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xd92ZSF+vA4E4hE1DpIDZAUuBJ6aFxleeIBaxyrSMhM=;
        b=QekAOTwenWOvE9fvti+vC07kWOJ3eOsWGWOIbn3jFToMGKiVsY//7Yk/SBNZGHezDx
         ENRLYmc4R9G3SQri9pKlECJAuP8EYfn0dMrau61pl5LYCXP778W40KOvgNfeCKNfjziB
         VKZqLIOkdAOM5lMehetcNsrVXVzKxDfdYD1lJdCRFF51LJuxpEOvq4YP1/3rnM9VhOai
         fpj9Xft7BMx09V6gnWCUwIDilsGkE6rztCHrpgI4P2K2OOJFTvDp7ZY/J7zUuzP/aG48
         52oo6fa/qIX/En7Z6ZMaPP8xSCcBekSiRkRed8FzujvmWecEd69kXRJjMdh1MC52x+wc
         uNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776419069; x=1777023869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xd92ZSF+vA4E4hE1DpIDZAUuBJ6aFxleeIBaxyrSMhM=;
        b=fB0nqpyjBGOhnrPjs/EbuPojadWDVFOdzuGYTJej8yqYiB5AepsravWkI8n7ekvO1a
         s8QGx67leOaMRCCh1H+k5nuTX9yvbxy6rrpwef6p5uOM44l+x3009qiMVYLlRxuiatKn
         OV/ZtHv95vJkqM2Sp51+o3OyNqrKCNLPhCk9K1IcqP6cT3NtmyCCIVdtffxCLOCKSPeF
         NKNm7CBS1V1p1Os3yEdBW6HRLK+vqrlPlVpwce4zHMelqEfV52Eab0dgmTX9IcfHIXyL
         zDdjvRoZcuAe58Wg0gUeTjWAYDaQp/C/4RjtKR2F2sMUrk9FaE7jMgTv/68nJyVPPnYI
         /0OA==
X-Gm-Message-State: AOJu0Yxjo+iZMTPcw/zTyC5CXyOvDNoO44q0T9xqm4fuVYvRqyLnUWmM
	i4j9PgOB1+jSlYBOZkxB/TeJtuYjOA2TVKhQDkYSLPqv5JowixV4QNrxLYEnrpeG
X-Gm-Gg: AeBDiev1Iddd5G9aLhGVY14yb2G3F5PGmw3qwH6Tnmmb16/OvVpyDmGz0ETmjc0t1Q5
	7tN4FXeHu4y1eFtxgZn6oRJrQAhtM9xZ7ntHpyI7cE6DVp5sVTNbOS7j47zJ3tJ6yejNpxaaG8r
	wtJND7jJIp6UwMYkmTCVrIQBFxSlNf9Cts0YhgHpNxL7Klfs36UyZbQW8bRwL+DtbhgUhLn4Kf/
	nYSlehNQVgMGI45Y6y6ofZ31AgYLU5jaXrllzmeIniUst7xuH3Xv21g/6WHOgj07UXvEDcyEDgW
	/5smRlptBh52IfbbYpVb31EkEeRrONF/ksE/JBGoWOx6hqeQ1jz6MJE0GbkKl5IwNXIVmiPUvor
	Ygfe3/DoDxiNElCmbtiVRzRRULkYc/XvWS3ZGah1hR/faqnUxorJlMRjFSGs9MK0OlvgL6WoCSZ
	Q1aZtvvp4AfQvc2iyZla+gX5zkd2mFn6UKKoLSDiY=
X-Received: by 2002:a05:600c:c112:b0:486:fe83:861c with SMTP id 5b1f17b1804b1-488fb896910mr21169615e9.7.1776419068432;
        Fri, 17 Apr 2026 02:44:28 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:9586:30a1:a0a6:f076])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc14104dsm31037365e9.13.2026.04.17.02.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 02:44:27 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	brauner@kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v2] liveupdate: add LUO_SESSION_MAGIC magic inode type
Date: Fri, 17 Apr 2026 10:44:00 +0100
Message-ID: <20260417094426.1556849-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_024430_918480_89B25FA6 
X-CRM114-Status: GOOD (  20.42  )
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

 include/uapi/linux/magic.h       |  1 +
 kernel/liveupdate/luo_core.c     | 10 ++++-
 kernel/liveupdate/luo_internal.h |  2 +
 kernel/liveupdate/luo_session.c  | 73 +++++++++++++++++++++++++++++---
 4 files changed, 80 insertions(+), 6 deletions(-)

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
-- 
2.47.3



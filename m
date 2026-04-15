Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F55F4213B
	for <kexec@archiver.kernel.org>; Wed, 15 Apr 2026 18:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sOoG9NE6Osa5/oH7LSm8JFnpzmfcQ/eAf3R+ydFAr6c=; b=S80YHZxhk+Sq1IhWUc/TO1zBPl
	fqGY03MYacRhbM/C8YVFD89C5QZBHl6mscw0BIgMVbMzJTOPtOFAFaLKNF6OMrNOh1Mz7tOvVGq+M
	L0ZV6tdDFfrikOhaAGH7Ok6dYhCerOT0Us9TDrrkb03AM0cSALPI+pMBLPncheWvKNUaDe/ZMI0Fp
	C2VrdJWOb6uAUteOvgb1K/H3cnPN2DkvxnUGh1rUDdnF5plP9e8dBlcfa6B26rqN9RB7ovKHUiU8E
	UIMy7u97iix+H+8EFynLX9Gp90C8F7vT+c+i8kmwyQvNMxI7Cgjkp82iFRL/FF8lWmim2MRPlvBVD
	uJF29v9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD5FQ-00000001W23-0Ryv;
	Wed, 15 Apr 2026 18:46:00 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD5FL-00000001W1f-0bHC
	for kexec@lists.infradead.org;
	Wed, 15 Apr 2026 18:45:56 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso57520985e9.0
        for <kexec@lists.infradead.org>; Wed, 15 Apr 2026 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278752; x=1776883552; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOoG9NE6Osa5/oH7LSm8JFnpzmfcQ/eAf3R+ydFAr6c=;
        b=hjMRkimRGAvDj5ntpdyUnM7lQdEYneVa3sPzFebUUZiiGGdfiIKbqoqCdgaC8jzu5L
         6KK13rpgPNT+5zltkdunN0H6uulEYu7/7VjVoV603L4Hmt52WF+KrfxqjzAWiYHdJB7P
         pkPEA9Z+zrvewIJJOQl94MkangHNiCEtaTC6yQApdQ3g8rGRBQB6f3RQRJZ0L9Eghwr0
         ldpypLsMhadqQ6/NiHlYDjgCKof1Jvd3rrDHw21LDYmTfMnLHxgXrLV5QdVzVZ8RPvwo
         Ug1g1bF3jUhpjRfQdELQel/vbRkYukG4Js3NtEPmyfL1lN6zzilABEHhmSMrEcDymiRx
         GwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278752; x=1776883552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOoG9NE6Osa5/oH7LSm8JFnpzmfcQ/eAf3R+ydFAr6c=;
        b=PkN1LiKBk5SkWt3PiRvhjn4ya629Ec1hSFDB6+PvN7e7Ojzq/SEHTqgdFilyT1wSd5
         aWHKxB0P/r5hdBhn/H/IaLBUX1oeP7QI+h3SwEMCvOzW7Apg7hU6COPcGn8HfbRKNBQI
         xsjqzmSDmPMpgTB3t6+PHze1SyfmfNLdzKhWkXFqwfzVowELNG735UD6rjR3apI/INQb
         1IUJgIy4/9Xzu/ltDAhnK3FnzU4rLvkjfKG3UwcRm8QKt9XRtOTMiLhIWZPn8RlfYGdn
         zHLpcXLD244mxi4UK3RSo1+IluraYQBjAjy56m4nvSnTui/+ujyhqwmdK7o3GC+idFuz
         vTbQ==
X-Gm-Message-State: AOJu0YwWb+U30np9KHsptGMpdjNSg2+S+AmWBRH1rBIxjbxs+4IQBQeY
	CRqIixn2ZMZQYCDoTgehRyF33ip/zlwFPo5XOb91ZpPVt7T1QPgOhwCyaBQ2E6CW
X-Gm-Gg: AeBDiesPwE+1fhEPzJCvAvChdFwOKMgSoC9WxP2h+NfD4Uc7CM7Mxf8p5Qk8kjPcesp
	Zs74e/XkMX/KAmTXIxy9KD3VufMc1YptCqq4Q+gzFLn2tspjQdtct6Xj0G/hkObYJl5tNoLWp29
	6P8N4xeSP7L+nuKEM8oSbkHoi3FoTVLLzY5DwPeZ/ESBDZq5h3LnktMDQqHhDUzYyI5LfOuK06O
	MSiH0vPV+Wdr7zbCOCnnG9sApf+qgq4y3XL5tAwZU5XpkKfH+4TmkPOBl1IAr87nL/hhZCi930p
	RULTOzsLu9ba/5N5857WYduBDH0Bq4R6FfskFi5P89pUe/xuzfe+yRP/XBV1JcPSSyYwdRmnmJT
	Eir/5CuQexYazBOK+ZaBLROWPLOGftiEu0v0SkgxbxLUv7MoR/1QNS33VHUbQdmroQ3Rzr+sDk6
	zson8ve3M51o4miDkrAmJgghLkNaJfdnUewLGcEFM=
X-Received: by 2002:a05:600c:8207:b0:488:7a24:9ddf with SMTP id 5b1f17b1804b1-488d688dd31mr309324205e9.28.1776278752017;
        Wed, 15 Apr 2026 11:45:52 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:1648:8c4d:e867:9ebb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488f0ec6cc6sm26153255e9.29.2026.04.15.11.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:45:51 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	brauner@kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH] liveupdate: add LUO_SESSION_MAGIC magic inode type
Date: Wed, 15 Apr 2026 19:44:57 +0100
Message-ID: <20260415184536.1155220-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_114555_237164_373FE370 
X-CRM114-Status: GOOD (  19.76  )
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

 include/uapi/linux/magic.h       |  1 +
 kernel/liveupdate/luo_core.c     |  6 +++
 kernel/liveupdate/luo_internal.h |  1 +
 kernel/liveupdate/luo_session.c  | 67 +++++++++++++++++++++++++++++---
 4 files changed, 70 insertions(+), 5 deletions(-)

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
index dda7bb57d421c..ec00c681a0f50 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -197,6 +197,12 @@ static int __init luo_late_startup(void)
 	if (!liveupdate_enabled())
 		return 0;
 
+	err = luo_session_fs_init();
+	if (err) {
+		luo_global.enabled = false;
+		return err;
+	}
+
 	err = luo_fdt_setup();
 	if (err)
 		luo_global.enabled = false;
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 8083d8739b093..223a9dc1ca29b 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -79,6 +79,7 @@ struct luo_session {
 
 int luo_session_create(const char *name, struct file **filep);
 int luo_session_retrieve(const char *name, struct file **filep);
+int __init luo_session_fs_init(void);
 int __init luo_session_setup_outgoing(void *fdt);
 int __init luo_session_setup_incoming(void *fdt);
 int luo_session_serialize(void);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index af9e498206d24..fbc4b32b39cb8 100644
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
@@ -662,3 +704,18 @@ void luo_session_resume(void)
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
-- 
2.47.3



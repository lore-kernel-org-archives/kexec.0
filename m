Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2F9C54EBE
	for <kexec@archiver.kernel.org>; Sat, 14 Jan 2023 01:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=COd6v2AByEFH8PKhgem/8rNtqFz/RSPSy5Razv+Qt0U=; b=l3bhCpRUIeRvT1
	CmW2yu+WxzydpzycZ3HuJl7Gk3hxMIIWl8z1wbnqRoZLUp1aEIytcUiw5dDISSdC59JeKFEn0NgvY
	mS2W/ec2ZI/bIJCSxwvKjA12CVq5CU1DFsHKWsBSeFEK80AEuZ/N62CjlFZtWk6Dlg5iXt54BEF0h
	3+19U70z7iH1vww+fnT7C43RwdrwprSuVbMDJs4T7WD6tLcDFSo3pYBkdvy89IWv75N/aH0QBbqFU
	AO0C2WC3vTgTh3iA7eb3FRKm/6dIiy1M6F8O6n3XXkvDuZ5kzwezAZF5XCUVaQ12jeUEXuNn3RDdd
	CCcXgmoTPCEjORSBrGaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGVcv-0050gz-Pn; Sat, 14 Jan 2023 01:46:33 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGUUt-004tw3-1e; Sat, 14 Jan 2023 00:34:11 +0000
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
Subject: [RFC v3 04/24] fs: add iterate_supers_excl() and iterate_supers_reverse_excl()
Date: Fri, 13 Jan 2023 16:33:49 -0800
Message-Id: <20230114003409.1168311-5-mcgrof@kernel.org>
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

There are use cases where we wish to traverse the superblock list
but also capture errors, and in which case we want to avoid having
our callers issue a lock themselves since we can do the locking for
the callers. Provide a iterate_supers_excl() which calls a function
with the write lock held. If an error occurs we capture it and
propagate it.

Likewise there are use cases where we wish to traverse the superblock
list but in reverse order. The new iterate_supers_reverse_excl() helpers
does this but also also captures any errors encountered.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/super.c         | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 +
 2 files changed, 93 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 0d6b4de8da88..2f77fcb6e555 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -732,6 +732,97 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 	spin_unlock(&sb_lock);
 }
 
+/**
+ *	iterate_supers_excl - exclusively call func for all active superblocks
+ *	@f: function to call
+ *	@arg: argument to pass to it
+ *
+ *	Scans the superblock list and calls given function, passing it
+ *	locked superblock and given argument. Returns 0 unless an error
+ *	occurred on calling the function on any superblock.
+ */
+int iterate_supers_excl(int (*f)(struct super_block *, void *), void *arg)
+{
+	struct super_block *sb, *p = NULL;
+	int error = 0;
+
+	spin_lock(&sb_lock);
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (hlist_unhashed(&sb->s_instances))
+			continue;
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+
+		down_write(&sb->s_umount);
+		if (sb->s_root && (sb->s_flags & SB_BORN)) {
+			error = f(sb, arg);
+			if (error) {
+				up_write(&sb->s_umount);
+				spin_lock(&sb_lock);
+				__put_super(sb);
+				break;
+			}
+		}
+		up_write(&sb->s_umount);
+
+		spin_lock(&sb_lock);
+		if (p)
+			__put_super(p);
+		p = sb;
+	}
+	if (p)
+		__put_super(p);
+	spin_unlock(&sb_lock);
+
+	return error;
+}
+
+/**
+ *	iterate_supers_reverse_excl - exclusively calls func in reverse order
+ *	@f: function to call
+ *	@arg: argument to pass to it
+ *
+ *	Scans the superblock list and calls given function, passing it
+ *	locked superblock and given argument, in reverse order, and holding
+ *	the s_umount write lock. Returns if an error occurred.
+ */
+int iterate_supers_reverse_excl(int (*f)(struct super_block *, void *),
+					 void *arg)
+{
+	struct super_block *sb, *p = NULL;
+	int error = 0;
+
+	spin_lock(&sb_lock);
+	list_for_each_entry_reverse(sb, &super_blocks, s_list) {
+		if (hlist_unhashed(&sb->s_instances))
+			continue;
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+
+		down_write(&sb->s_umount);
+		if (sb->s_root && (sb->s_flags & SB_BORN)) {
+			error = f(sb, arg);
+			if (error) {
+				up_write(&sb->s_umount);
+				spin_lock(&sb_lock);
+				__put_super(sb);
+				break;
+			}
+		}
+		up_write(&sb->s_umount);
+
+		spin_lock(&sb_lock);
+		if (p)
+			__put_super(p);
+		p = sb;
+	}
+	if (p)
+		__put_super(p);
+	spin_unlock(&sb_lock);
+
+	return error;
+}
+
 /**
  *	iterate_supers_type - call function for superblocks of given type
  *	@type: fs type
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3b2586de4364..f168e72f6ca1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2916,6 +2916,8 @@ extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
 extern void iterate_supers(void (*)(struct super_block *, void *), void *);
+extern int iterate_supers_excl(int (*f)(struct super_block *, void *), void *arg);
+extern int iterate_supers_reverse_excl(int (*)(struct super_block *, void *), void *);
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
 
-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

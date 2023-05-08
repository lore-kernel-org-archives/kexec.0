Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C821EC77B75
	for <kexec@archiver.kernel.org>; Mon,  8 May 2023 01:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SNvXEGqcYfeB4HwehtUoZe/sUS8dcUXitISkuPxvNG0=; b=izUvpkWY8xBUa8
	ooFO70xxHlc+SxMfOugWdpsSkxOU0yhCpHCbVFvC2Ome8DpZv0uepFSwOOLNWT4yzvcc/fTaMMktG
	u/cdwtarH9AT/KX4CelWlNtM/OOz0Wnv+U2dEH/NMPbAHdmcKxGryofgQaz4gB5E1L3+A5ceCIBmQ
	UNxP8utDc+j+97RhPXc1eBya3U7lN3MzuS32sWOUNks6JJnby/eZYBVeIUAjj+Fxxqg8ezoKUFa/l
	IHkv62+9f7LWn+yqG5JbkX4cle+jS4uhL60l5W+AIKGDkbVaKuCI6dk2mFJn9ewYmXGyTizvenLdi
	AvKXq8VNcWOghd7dsCLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvpVG-00GvbY-0J;
	Mon, 08 May 2023 01:17:26 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pvpV7-00GvZ6-3A;
	Mon, 08 May 2023 01:17:17 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hch@infradead.org,
	djwong@kernel.org,
	sandeen@sandeen.net,
	song@kernel.org,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	jikos@kernel.org,
	bvanassche@acm.org,
	ebiederm@xmission.com
Cc: mchehab@kernel.org,
	keescook@chromium.org,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org,
	kernel@tuxforce.de,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 5/6] fs: add iterate_supers_excl() and iterate_supers_reverse_excl()
Date: Sun,  7 May 2023 18:17:16 -0700
Message-Id: <20230508011717.4034511-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508011717.4034511-1-mcgrof@kernel.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
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
index 28c633b81f8f..d5eab6b38b03 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -753,6 +753,97 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
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
index d9b46c858103..22dd697ab703 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2935,6 +2935,8 @@ extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
 extern void iterate_supers(void (*)(struct super_block *, void *), void *);
+extern int iterate_supers_excl(int (*f)(struct super_block *, void *), void *arg);
+extern int iterate_supers_reverse_excl(int (*)(struct super_block *, void *), void *);
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
 
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYXj-009nmz-6A
 for kexec@lists.infradead.org; Sat, 17 Apr 2021 00:10:40 +0000
Received: by mail-pf1-f178.google.com with SMTP id g16so6078511pfq.5
 for <kexec@lists.infradead.org>; Fri, 16 Apr 2021 17:10:34 -0700 (PDT)
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v2 5/6] fs: add iterate_supers_excl() and
 iterate_supers_reverse_excl()
Date: Sat, 17 Apr 2021 00:10:25 +0000
Message-Id: <20210417001026.23858-6-mcgrof@kernel.org>
In-Reply-To: <20210417001026.23858-1-mcgrof@kernel.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: rafael@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org, jeyu@kernel.org, ebiederm@xmission.com
Cc: mchehab@kernel.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, kernel@tuxforce.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>

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
index 53106d4c7f56..2a6ef4ec2496 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -705,6 +705,97 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
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
index 6980e709e94a..0f4d624f0f3f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3442,6 +3442,8 @@ extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
 extern void iterate_supers(void (*)(struct super_block *, void *), void *);
+extern int iterate_supers_excl(int (*f)(struct super_block *, void *), void *arg);
+extern int iterate_supers_reverse_excl(int (*)(struct super_block *, void *), void *);
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
 
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

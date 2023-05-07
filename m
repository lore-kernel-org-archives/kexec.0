Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D413C7EE24
	for <kexec@archiver.kernel.org>; Sun,  7 May 2023 03:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZVsmaxun/t5pOpplhW7dhg8spFtNL3/eui5VtUfjhEQ=; b=a8nnumGvMAN95e
	I+Po49jCjZk1fLQdFEZ3tTYqOK9kx+Tr8258oX5ovd0SRGJdCLrY/v+MMteoz0L+6DcCixr27oNGi
	CKaH95ywtnCdSqPJ6gxgKC/NXjqjgcH6r1zlTS48Q0Fep/ArTkiKhzPfFoowUrnFekVAiw9Ia35BG
	ckh1tvBTGdnKNZmI7hxaHw7KfjIaomJJh+AzLwgD9QxSmt9ACpvnbA3GuPDuWyXvEz3ZPTwLDiDyS
	VZZKFMfNroykdF6QokCKFfNzRROVgNZ6WxoMdi1JEl+ssJIBcrnq/DNQgfgWmWweqkzoq5A5WPfo7
	IY65moZjG7ze1z4fxcNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvVMf-00F5Xt-0r;
	Sun, 07 May 2023 03:47:13 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pvVMU-00F5XF-2a;
	Sun, 07 May 2023 03:47:02 +0000
Date: Sat, 6 May 2023 20:47:02 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: hch@infradead.org, djwong@kernel.org, song@kernel.org,
	rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, bvanassche@acm.org, ebiederm@xmission.com,
	mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 01/24] fs: unify locking semantics for fs freeze / thaw
Message-ID: <ZFcfNslrktWdIpaW@bombadil.infradead.org>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-2-mcgrof@kernel.org>
 <20230116151455.lsggdn64jecwh36o@quack3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230116151455.lsggdn64jecwh36o@quack3>
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

On Mon, Jan 16, 2023 at 04:14:55PM +0100, Jan Kara wrote:
> So I  think we may need to also block attempts to unmount frozen filesystem -
> actually GFS2 needs this as well [1].
> 
> [1] lore.kernel.org/r/20221129230736.3462830-1-agruenba@redhat.com

Yes, I reviewed Andreas's patch and I think we end up just complicating
things by allowing us to continue to "support" unmounting frozen
filesystems. Instead it is easier for us to just block that insanity.

Current attempt / non-boot tested or anything.

From: Luis Chamberlain <mcgrof@kernel.org>
Date: Sat, 6 May 2023 20:13:49 -0700
Subject: [RFC] fs: prevent mount / umount of frozen filesystems

Today you can unmount a frozen filesystem. Doing that turns it into
a zombie filesystem, you cannot shut it down until first you remounting
it and then unthawing it.

Enabling this sort of behaviour is madness.

Simplify this by instead just preventing us to unmount frozen
filesystems, and likewise prevent mounting frozen filesystems.

Suggested-by: Jan Kara <jack@suse.cz>
Reported-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/namespace.c |  3 +++
 fs/super.c     | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 54847db5b819..9c21d8662fc8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1636,6 +1636,9 @@ static int do_umount(struct mount *mnt, int flags)
 	if (retval)
 		return retval;
 
+	if (!(sb_is_unfrozen(sb)))
+		return -EBUSY;
+
 	/*
 	 * Allow userspace to request a mountpoint be expired rather than
 	 * unmounting unconditionally. Unmount only happens if:
diff --git a/fs/super.c b/fs/super.c
index 34afe411cf2b..55f5728f5090 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -441,6 +441,7 @@ void retire_super(struct super_block *sb)
 {
 	WARN_ON(!sb->s_bdev);
 	down_write(&sb->s_umount);
+	WARN_ON_ONCE(!(sb_is_unfrozen(sb)));
 	if (sb->s_iflags & SB_I_PERSB_BDI) {
 		bdi_unregister(sb->s_bdi);
 		sb->s_iflags &= ~SB_I_PERSB_BDI;
@@ -468,6 +469,7 @@ void generic_shutdown_super(struct super_block *sb)
 {
 	const struct super_operations *sop = sb->s_op;
 
+	WARN_ON_ONCE(!(sb_is_unfrozen(sb)));
 	if (sb->s_root) {
 		shrink_dcache_for_umount(sb);
 		sync_filesystem(sb);
@@ -1354,6 +1356,12 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 	if (IS_ERR(s))
 		goto error_s;
 
+	if (!(sb_is_unfrozen(sb))) {
+			deactivate_locked_super(s);
+			error = -EBUSY;
+			goto error_bdev;
+	}
+
 	if (s->s_root) {
 		if ((flags ^ s->s_flags) & SB_RDONLY) {
 			deactivate_locked_super(s);
@@ -1473,6 +1481,10 @@ struct dentry *mount_single(struct file_system_type *fs_type,
 	s = sget(fs_type, compare_single, set_anon_super, flags, NULL);
 	if (IS_ERR(s))
 		return ERR_CAST(s);
+	if (!(sb_is_unfrozen(sb))) {
+		deactivate_locked_super(s);
+		return ERR_PTR(-EBUSY);
+	}
 	if (!s->s_root) {
 		error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
 		if (!error)
@@ -1522,6 +1534,8 @@ int vfs_get_tree(struct fs_context *fc)
 
 	sb = fc->root->d_sb;
 	WARN_ON(!sb->s_bdi);
+	if (!(sb_is_unfrozen(sb)))
+		return -EBUSY;
 
 	/*
 	 * Write barrier is for super_cache_count(). We place it before setting
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

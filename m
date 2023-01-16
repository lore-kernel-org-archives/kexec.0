Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F88FC46467
	for <kexec@archiver.kernel.org>; Mon, 16 Jan 2023 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OH0u5QhERO+nHZqrvGbKKSGNjD8cP1NRU+3XyFNGVvs=; b=VlzWL35UbRqS+A
	ivJbl2PLdV+aGdhpDYm3cY5LzZOiRz/N+0DdEYeVX30UoHOatcIkSdSXsrIkjUDVzRVqh3y8+Kf+b
	Ri1Q2vuDqYL+/NOHAyCSsBb7Wiv0Iw3k2/aL9daIb1VoqsU/0LT7lTz6hJkDbi23nsflZIbeairNZ
	8AvvcPBDwW8pyhUU6Ag1NBQqlc2J2DKqkgqsef0+oq7BYpfx4NT4rtw4ERoEiTIrsy1DH1ZqLpGLF
	r6idK/B7QaAswfPMmWZDVdwWjER5kGHDqYmiT+pz2ZMpPqMEUm+iAHPi/9iWopwXd++C+U7Eju6I2
	umbZa0O557u8E5p0iumA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHSFT-00BJxA-EF; Mon, 16 Jan 2023 16:22:15 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHS4w-00BFBH-4E
	for kexec@lists.infradead.org; Mon, 16 Jan 2023 16:11:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC2283787D;
	Mon, 16 Jan 2023 16:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1673885480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kO5Zu3yPwNvCAAUDZ07+m5RoPCtEo+Dj5i9lnugzX7M=;
	b=q2GGC+2raxFjqqiFYUcJq3xqTfalWgv5pF14EcEJKrxt1eKgr3xFhfv1tsnqqul22zTkwT
	zp2rqQUeV8BiAm29KUnGNy+/Hphv4I+rqdtYs7xvY0657qEP142Wqx5hOgzoQJkuYnUgSk
	Bzhyp/9PtqsyIHStvm1mLxNNDJ2pLVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1673885480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kO5Zu3yPwNvCAAUDZ07+m5RoPCtEo+Dj5i9lnugzX7M=;
	b=1QNgj9756PHrSnqUi7xrd/tDSvNe5Pv80lsWnuYV3IoyRJbQffnrH4RD95LxR1/u89jYI8
	WYSYGyNToyWslEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD0D0138FE;
	Mon, 16 Jan 2023 16:11:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LwA9Kih3xWNfJAAAMHmgww
	(envelope-from <jack@suse.cz>); Mon, 16 Jan 2023 16:11:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4B352A06AD; Mon, 16 Jan 2023 17:11:20 +0100 (CET)
Date: Mon, 16 Jan 2023 17:11:20 +0100
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@infradead.org, djwong@kernel.org, song@kernel.org,
	rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
	ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org,
	kernel@tuxforce.de, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 02/24] fs: add frozen sb state helpers
Message-ID: <20230116161120.fczsdy2vptgpb5z4@quack3>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230114003409.1168311-3-mcgrof@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_081122_449576_42B42271 
X-CRM114-Status: GOOD (  23.33  )
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

On Fri 13-01-23 16:33:47, Luis Chamberlain wrote:
> Provide helpers so that we can check a superblock frozen state.
> This will make subsequent changes easier to read. This makes
> no functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4_jbd2.c |  2 +-
>  fs/gfs2/sys.c       |  2 +-
>  fs/quota/quota.c    |  4 ++--
>  fs/super.c          |  4 ++--
>  fs/xfs/xfs_trans.c  |  3 +--
>  include/linux/fs.h  | 22 ++++++++++++++++++++++
>  6 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 77f318ec8abb..ef441f15053b 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -72,7 +72,7 @@ static int ext4_journal_check_start(struct super_block *sb)
>  
>  	if (sb_rdonly(sb))
>  		return -EROFS;
> -	WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
> +	WARN_ON(sb_is_frozen(sb));
>  	journal = EXT4_SB(sb)->s_journal;
>  	/*
>  	 * Special case here: if the journal has aborted behind our
> diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
> index d0b80552a678..b98be03d0d1e 100644
> --- a/fs/gfs2/sys.c
> +++ b/fs/gfs2/sys.c
> @@ -146,7 +146,7 @@ static ssize_t uuid_show(struct gfs2_sbd *sdp, char *buf)
>  static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
>  {
>  	struct super_block *sb = sdp->sd_vfs;
> -	int frozen = (sb->s_writers.frozen == SB_UNFROZEN) ? 0 : 1;
> +	int frozen = sb_is_unfrozen(sb) ? 0 : 1;
>  
>  	return snprintf(buf, PAGE_SIZE, "%d\n", frozen);
>  }
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 052f143e2e0e..d8147c21bf03 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -890,13 +890,13 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
>  	sb = user_get_super(dev, excl);
>  	if (!sb)
>  		return ERR_PTR(-ENODEV);
> -	if (thawed && sb->s_writers.frozen != SB_UNFROZEN) {
> +	if (thawed && sb_is_unfrozen(sb)) {
>  		if (excl)
>  			up_write(&sb->s_umount);
>  		else
>  			up_read(&sb->s_umount);
>  		wait_event(sb->s_writers.wait_unfrozen,
> -			   sb->s_writers.frozen == SB_UNFROZEN);
> +			   sb_is_unfrozen(sb));
>  		put_super(sb);
>  		goto retry;
>  	}
> diff --git a/fs/super.c b/fs/super.c
> index a31a41b313f3..fdcf5a87af0a 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -883,7 +883,7 @@ int reconfigure_super(struct fs_context *fc)
>  
>  	if (fc->sb_flags_mask & ~MS_RMT_MASK)
>  		return -EINVAL;
> -	if (sb->s_writers.frozen != SB_UNFROZEN)
> +	if (!(sb_is_unfrozen(sb)))
>  		return -EBUSY;
>  
>  	retval = security_sb_remount(sb, fc->security);
> @@ -907,7 +907,7 @@ int reconfigure_super(struct fs_context *fc)
>  			down_write(&sb->s_umount);
>  			if (!sb->s_root)
>  				return 0;
> -			if (sb->s_writers.frozen != SB_UNFROZEN)
> +			if (!sb_is_unfrozen(sb))
>  				return -EBUSY;
>  			remount_ro = !sb_rdonly(sb);
>  		}
> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index 7bd16fbff534..ceb4890a4c96 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -267,8 +267,7 @@ xfs_trans_alloc(
>  	 * Zero-reservation ("empty") transactions can't modify anything, so
>  	 * they're allowed to run while we're frozen.
>  	 */
> -	WARN_ON(resp->tr_logres > 0 &&
> -		mp->m_super->s_writers.frozen == SB_FREEZE_COMPLETE);
> +	WARN_ON(resp->tr_logres > 0 && sb_is_frozen(mp->m_super));
>  	ASSERT(!(flags & XFS_TRANS_RES_FDBLKS) ||
>  	       xfs_has_lazysbcount(mp));
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 5042f5ab74a4..c0cab61f9f9a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1604,6 +1604,28 @@ static inline bool sb_start_intwrite_trylock(struct super_block *sb)
>  	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
>  }
>  
> +/**
> + * sb_is_frozen - is superblock frozen
> + * @sb: the super to check
> + *
> + * Returns true if the super is frozen.
> + */
> +static inline bool sb_is_frozen(struct super_block *sb)
> +{
> +	return sb->s_writers.frozen == SB_FREEZE_COMPLETE;
> +}
> +
> +/**
> + * sb_is_unfrozen - is superblock unfrozen
> + * @sb: the super to check
> + *
> + * Returns true if the super is unfrozen.
> + */
> +static inline bool sb_is_unfrozen(struct super_block *sb)
> +{
> +	return sb->s_writers.frozen == SB_UNFROZEN;
> +}
> +
>  bool inode_owner_or_capable(struct user_namespace *mnt_userns,
>  			    const struct inode *inode);
>  
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

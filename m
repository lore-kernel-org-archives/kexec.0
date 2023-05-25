Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7487AC7EE29
	for <kexec@archiver.kernel.org>; Thu, 25 May 2023 12:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RBZ/e02+UyupACrIAuKp6JjKO8puYxPevdy0xDtrTcU=; b=z+Jf5V43hMSQ/t
	rK0ugteXOWNLaVogP1+18ZqZp7gIWH+hbxDAsOtjqd4fnY48vgBP4OQrQDxPRKxqSpRjg6nnpqCRS
	foJJVq0JBC3L+Zzjpjl7mH6rgYz5Mx/xESQYBAL9GuEhbnsN2MFW9bKZUx/VSKVa4mIvShaNW9Qxu
	ZJjYFmWFe3zTpYZ8/BLnEquXr+40yODHvyUBMXDOig9OBSxJuwrzBuAMCexmQ9CIuvhvo66i86pwA
	k0ZA27z78Q4K19jjU3E+PM+qbMrXbhmyAttfkshzvscxpFfU6fKd/iGsPX6UKD/Y2urLKD8ncq7q/
	sByomG4KdfahRFLCt3nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q29uW-00GbE7-23;
	Thu, 25 May 2023 12:17:40 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q29uS-00GbBq-2B
	for kexec@lists.infradead.org;
	Thu, 25 May 2023 12:17:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5942A1FE5C;
	Thu, 25 May 2023 12:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1685017051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2dzHnSkKSTY5qlRUI5cyea03h/AtEkjWPF2KHs6AMuY=;
	b=l4uwul7a9d7ai//eKop7F/76NhEFiPT+6AulP8hXlAENTeciQUq+i7qbcXAk1+56oivF8C
	KupcFrWBVM9QVfTiA154I19lFhzU2pj118AIWNUh1/XR8Y7T0T+/vXsx25cL6C0kS52H6Q
	7MQM+y+Gggsg7yzkx1ll8K5quEbaxFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1685017051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2dzHnSkKSTY5qlRUI5cyea03h/AtEkjWPF2KHs6AMuY=;
	b=eWlU1g39Km6Gwl34yMDbsZv9Xuk2mSTQtjzIJoQSXAuWzN7LROgqwncprq3x+okNgupCGq
	RknlYBd1WAe0j9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44B96134B2;
	Thu, 25 May 2023 12:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id N2C8ENtRb2QGMAAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 25 May 2023 12:17:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D5DFAA075C; Thu, 25 May 2023 14:17:30 +0200 (CEST)
Date: Thu, 25 May 2023 14:17:30 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
	song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
	bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
	keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] fs: unify locking semantics for fs freeze / thaw
Message-ID: <20230525121730.mqmdm7zp2rvnqjvi@quack3>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230508011717.4034511-2-mcgrof@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_051736_861406_5532091E 
X-CRM114-Status: GOOD (  25.96  )
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

On Sun 07-05-23 18:17:12, Luis Chamberlain wrote:
> Right now freeze_super()  and thaw_super() are called with
> different locking contexts. To expand on this is messy, so
> just unify the requirement to require grabbing an active
> reference and keep the superblock locked.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Finally got around to looking at this. Sorry for the delay. In principle I
like the direction but see below:

> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 61c5f9d26018..e31d6791d3e3 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2166,7 +2166,10 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  	if (err)
>  		return err;
>  
> +	if (!get_active_super(sbi->sb->s_bdev))
> +		return -ENOTTY;

Calling get_active_super() like this is just sick. You rather want to
provide a helper for grabbing another active sb reference and locking the
sb when you already have sb reference. Because that is what is needed in
the vast majority of the places. Something like

void grab_active_super(struct super_block *sb)
{
	down_write(sb->s_umount);
	atomic_inc(&s->s_active);
}

> @@ -851,13 +849,13 @@ struct super_block *get_active_super(struct block_device *bdev)
>  		if (sb->s_bdev == bdev) {
>  			if (!grab_super(sb))
>  				goto restart;
> -			up_write(&sb->s_umount);
>  			return sb;
>  		}
>  	}
>  	spin_unlock(&sb_lock);
>  	return NULL;
>  }
> +EXPORT_SYMBOL_GPL(get_active_super);

And I'd call this grab_bdev_super() and no need to export it when you have
grab_active_super().

> @@ -1636,10 +1634,13 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
>  }
>  
>  /**
> - * freeze_super - lock the filesystem and force it into a consistent state
> + * freeze_super - force a filesystem backed by a block device into a consistent state
>   * @sb: the super to lock
>   *
> - * Syncs the super to make sure the filesystem is consistent and calls the fs's
> + * Used by filesystems and the kernel to freeze a fileystem backed by a block
> + * device into a consistent state. Callers must use get_active_super(bdev) to
> + * lock the @sb and when done must unlock it with deactivate_locked_super().
> + * Syncs the filesystem backed by the @sb and calls the filesystem's optional
>   * freeze_fs.  Subsequent calls to this without first thawing the fs will return
>   * -EBUSY.
>   *
> @@ -1672,22 +1673,15 @@ int freeze_super(struct super_block *sb)
>  {
>  	int ret;
>  
> -	atomic_inc(&sb->s_active);
> -	down_write(&sb->s_umount);
> -	if (sb->s_writers.frozen != SB_UNFROZEN) {
> -		deactivate_locked_super(sb);

At least add a warning for s_umount not being held here?

> +	if (sb->s_writers.frozen != SB_UNFROZEN)
>  		return -EBUSY;
> -	}
>  
> -	if (!(sb->s_flags & SB_BORN)) {
> -		up_write(&sb->s_umount);
> +	if (!(sb->s_flags & SB_BORN))
>  		return 0;	/* sic - it's "nothing to do" */
> -	}
>  
>  	if (sb_rdonly(sb)) {
>  		/* Nothing to do really... */
>  		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
> -		up_write(&sb->s_umount);
>  		return 0;
>  	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

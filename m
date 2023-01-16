Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BA5C677F1
	for <kexec@archiver.kernel.org>; Mon, 16 Jan 2023 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wgwfyuMHNlyRx+t0NQ2R1jhWApPIexvZg2I0HDgU/ls=; b=21El86UNzmsxQ5
	FC1MY9yIlq6EFfYithmiasxF/0nwCiJXW5ni4ymlLRgJdZ2aWPU48LBRvdoX9JP+POttmsZ98+urZ
	qtgDIR0rmDr0r/gDZ5jFuIfGSmAtWOkXixmOVaeD/4wLNstIT/LV6Jc0Q10PullL7ideBYN/5IS5X
	87izeogNQblQz6xFVw4E5hYNHq0mXdac/RZ6zktWEf/KZ3vl7lF/E0PLdRJfdbCek6iuwqokeYBub
	WDnVEJKIgHPnVI5JTVSuTy11z2kcDEsDckPfbzflEZ/1YB0GuExwaUba4zLklyMLSLcgjsUKTOdsy
	XcpqzJ/6VrRBA7hJm4Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHSDo-00BJA6-Jn; Mon, 16 Jan 2023 16:20:32 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHS3O-00BEJX-HA
	for kexec@lists.infradead.org; Mon, 16 Jan 2023 16:09:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B60D67973;
	Mon, 16 Jan 2023 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1673885383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lEqhEm8m9g3c7Pky7UfroueEnnbYZOk7iGJcOupvfZg=;
	b=b6KYgdSaYfmtyWec91ajKPAuvjXhKI3QreOTviMD4Ie0VF/Na4ESXxhLIf2vBsugxKz9vx
	Jf7EpjE06lT+L9nEg7sXI0183s7+2lgeuZWWAnyI3/xmfEeLIkDbLgFJuGU0yyx2KUXllf
	WyaEchKJosk0r4umDMaWZdg9GM2ppck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1673885383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lEqhEm8m9g3c7Pky7UfroueEnnbYZOk7iGJcOupvfZg=;
	b=UNvozQaPwD5Pujnva3ARZxmZ0QPsZHRvFlI1XWaNk+sv3OSk43KFe1gNxLfmINLmPopZsG
	MLh10BLpod35DHAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 239E5138FE;
	Mon, 16 Jan 2023 16:09:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id PWSnCMd2xWN7IwAAMHmgww
	(envelope-from <jack@suse.cz>); Mon, 16 Jan 2023 16:09:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B3B3DA06AD; Mon, 16 Jan 2023 17:09:42 +0100 (CET)
Date: Mon, 16 Jan 2023 17:09:42 +0100
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@infradead.org, djwong@kernel.org, song@kernel.org,
	rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
	ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org,
	kernel@tuxforce.de, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 05/24] fs: add automatic kernel fs freeze / thaw and
 remove kthread freezing
Message-ID: <20230116160942.gcngdac2gee2svsy@quack3>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230114003409.1168311-6-mcgrof@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_080946_763614_441C1757 
X-CRM114-Status: GOOD (  35.75  )
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

On Fri 13-01-23 16:33:50, Luis Chamberlain wrote:
> Add support to automatically handle freezing and thawing filesystems
> during the kernel's suspend/resume cycle.
> 
> This is needed so that we properly really stop IO in flight without
> races after userspace has been frozen. Without this we rely on
> kthread freezing and its semantics are loose and error prone.
> For instance, even though a kthread may use try_to_freeze() and end
> up being frozen we have no way of being sure that everything that
> has been spawned asynchronously from it (such as timers) have also
> been stopped as well.
> 
> A long term advantage of also adding filesystem freeze / thawing
> supporting during suspend / hibernation is that long term we may
> be able to eventually drop the kernel's thread freezing completely
> as it was originally added to stop disk IO in flight as we hibernate
> or suspend.
> 
> This does not remove the superflous freezer calls on all filesystems.
> Each filesystem must remove all the kthread freezer stuff and peg
> the fs_type flags as supporting auto-freezing with the FS_AUTOFREEZE
> flag.
> 
> Subsequent patches remove the kthread freezer usage from each
> filesystem, one at a time to make all this work bisectable.
> Once all filesystems remove the usage of the kthread freezer we
> can remove the FS_AUTOFREEZE flag.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c             | 69 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h     | 14 +++++++++
>  kernel/power/process.c | 15 ++++++++-
>  3 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 2f77fcb6e555..e8af4c8269ad 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1853,3 +1853,72 @@ int thaw_super(struct super_block *sb, bool usercall)
>  	return 0;
>  }
>  EXPORT_SYMBOL(thaw_super);
> +
> +#ifdef CONFIG_PM_SLEEP
> +static bool super_should_freeze(struct super_block *sb)
> +{
> +	if (!(sb->s_type->fs_flags & FS_AUTOFREEZE))
> +		return false;
> +	/*
> +	 * We don't freeze virtual filesystems, we skip those filesystems with
> +	 * no backing device.
> +	 */
> +	if (sb->s_bdi == &noop_backing_dev_info)
> +		return false;
> +
> +	return true;
> +}
> +
> +int fs_suspend_freeze_sb(struct super_block *sb, void *priv)
> +{
> +	int error = 0;
> +
> +	if (!grab_lock_super(sb)) {
> +		pr_err("%s (%s): freezing failed to grab_super()\n",
> +		       sb->s_type->name, sb->s_id);
> +		return -ENOTTY;
> +	}
> +
> +	if (!super_should_freeze(sb))
> +		goto out;
> +
> +	pr_info("%s (%s): freezing\n", sb->s_type->name, sb->s_id);
> +
> +	error = freeze_super(sb, false);
> +	if (!error)
> +		lockdep_sb_freeze_release(sb);
> +	else if (error != -EBUSY)
> +		pr_notice("%s (%s): Unable to freeze, error=%d",
> +			  sb->s_type->name, sb->s_id, error);
> +
> +out:
> +	deactivate_locked_super(sb);
> +	return error;
> +}
> +
> +int fs_suspend_thaw_sb(struct super_block *sb, void *priv)
> +{
> +	int error = 0;
> +
> +	if (!grab_lock_super(sb)) {
> +		pr_err("%s (%s): thawing failed to grab_super()\n",
> +		       sb->s_type->name, sb->s_id);
> +		return -ENOTTY;
> +	}
> +
> +	if (!super_should_freeze(sb))
> +		goto out;
> +
> +	pr_info("%s (%s): thawing\n", sb->s_type->name, sb->s_id);
> +
> +	error = thaw_super(sb, false);
> +	if (error && error != -EBUSY)
> +		pr_notice("%s (%s): Unable to unfreeze, error=%d",
> +			  sb->s_type->name, sb->s_id, error);
> +
> +out:
> +	deactivate_locked_super(sb);
> +	return error;
> +}
> +
> +#endif
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f168e72f6ca1..e5bee359e804 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2231,6 +2231,7 @@ struct file_system_type {
>  #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
>  #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
> +#define FS_AUTOFREEZE           (1<<16)	/*  temporary as we phase kthread freezer out */
>  	int (*init_fs_context)(struct fs_context *);
>  	const struct fs_parameter_spec *parameters;
>  	struct dentry *(*mount) (struct file_system_type *, int,
> @@ -2306,6 +2307,19 @@ extern int user_statfs(const char __user *, struct kstatfs *);
>  extern int fd_statfs(int, struct kstatfs *);
>  extern int freeze_super(struct super_block *super, bool usercall);
>  extern int thaw_super(struct super_block *super, bool usercall);
> +#ifdef CONFIG_PM_SLEEP
> +int fs_suspend_freeze_sb(struct super_block *sb, void *priv);
> +int fs_suspend_thaw_sb(struct super_block *sb, void *priv);
> +#else
> +static inline int fs_suspend_freeze_sb(struct super_block *sb, void *priv)
> +{
> +	return 0;
> +}
> +static inline int fs_suspend_thaw_sb(struct super_block *sb, void *priv)
> +{
> +	return 0;
> +}
> +#endif
>  extern __printf(2, 3)
>  int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
>  extern int super_setup_bdi(struct super_block *sb);
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 6c1c7e566d35..1dd6b0b6b4e5 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -140,6 +140,16 @@ int freeze_processes(void)
>  
>  	BUG_ON(in_atomic());
>  
> +	pr_info("Freezing filesystems ... ");
> +	error = iterate_supers_reverse_excl(fs_suspend_freeze_sb, NULL);
> +	if (error) {
> +		pr_cont("failed\n");
> +		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
> +		thaw_processes();
> +		return error;
> +	}
> +	pr_cont("done.\n");
> +
>  	/*
>  	 * Now that the whole userspace is frozen we need to disable
>  	 * the OOM killer to disallow any further interference with
> @@ -149,8 +159,10 @@ int freeze_processes(void)
>  	if (!error && !oom_killer_disable(msecs_to_jiffies(freeze_timeout_msecs)))
>  		error = -EBUSY;
>  
> -	if (error)
> +	if (error) {
> +		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
>  		thaw_processes();
> +	}
>  	return error;
>  }
>  
> @@ -188,6 +200,7 @@ void thaw_processes(void)
>  	pm_nosig_freezing = false;
>  
>  	oom_killer_enable();
> +	iterate_supers_excl(fs_suspend_thaw_sb, NULL);
>  
>  	pr_info("Restarting tasks ... ");
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

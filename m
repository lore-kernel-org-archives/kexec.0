Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 20 Apr 2021 13:59:03 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC v2 6/6] fs: add automatic kernel fs freeze / thaw and
 remove kthread freezing
Message-ID: <20210420125903.GC3604224@infradead.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
 <20210417001026.23858-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210417001026.23858-7-mcgrof@kernel.org>
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
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: rafael@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org, jeyu@kernel.org, ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, kernel@tuxforce.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

> This also removes all the superflous freezer calls on all filesystems
> as they are no longer needed as the VFS now performs filesystem
> freezing/thaw if the filesystem has support for it. The filesystem
> therefore is in charge of properly dealing with quiescing of the
> filesystem through its callbacks.

Can you split that out from the main logic change?  Maybe even into one
patch per file system?

> +#ifdef CONFIG_PM_SLEEP
> +static bool super_should_freeze(struct super_block *sb)
> +{
> +	if (!sb->s_root)
> +		return false;
> +	if (!(sb->s_flags & MS_BORN))
> +		return false;

This is already done in the iterate_supers_excl and
iterate_supers_reverse_excl helpers that this helper is always called
through.

> +	/*
> +	 * We don't freeze virtual filesystems, we skip those filesystems with
> +	 * no backing device.
> +	 */
> +	if (sb->s_bdi == &noop_backing_dev_info)
> +		return false;

Why?

> +	/* No need to freeze read-only filesystems */
> +	if (sb_rdonly(sb))
> +		return false;

freeze_super/thaw_super already takes care of read-only file systems,
and IMHO in a better way.

> +	int error = 0;
> +
> +	spin_lock(&sb_lock);
> +	if (!super_should_freeze(sb))
> +		goto out;
> +
> +	pr_info("%s (%s): freezing\n", sb->s_type->name, sb->s_id);
> +
> +	spin_unlock(&sb_lock);

I don't see how super_should_freeze needs sb_lock.  But if it does
the lock should be taken in the function.

> +	atomic_inc(&sb->s_active);

Doesn't this need a atomic_inc_not_zero if we're racing with a delayed
unmount?

> +	error = freeze_locked_super(sb, false);
> +	if (error)
> +		atomic_dec(&sb->s_active);

And this really needs something like deactivate_locked_super.

> +	spin_lock(&sb_lock);
> +	if (error && error != -EBUSY)
> +		pr_notice("%s (%s): Unable to freeze, error=%d",
> +			  sb->s_type->name, sb->s_id, error);
> +
> +out:
> +	spin_unlock(&sb_lock);

Huh, what is the point of sb_lock here?

> +int fs_suspend_freeze(void)
> +{
> +	return iterate_supers_reverse_excl(fs_suspend_freeze_sb, NULL);
> +}

I'd just fold this helper into its only caller.

> +	error = __thaw_super_locked(sb, false);
> +	if (!error)
> +		atomic_dec(&sb->s_active);
> +
> +	spin_lock(&sb_lock);
> +	if (error && error != -EBUSY)
> +		pr_notice("%s (%s): Unable to unfreeze, error=%d",
> +			  sb->s_type->name, sb->s_id, error);
> +
> +out:
> +	spin_unlock(&sb_lock);
> +	return error;
> +}
> +
> +int fs_resume_unfreeze(void)
> +{
> +	return iterate_supers_excl(fs_suspend_thaw_sb, NULL);
> +}

Same comments as on the freeze side.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

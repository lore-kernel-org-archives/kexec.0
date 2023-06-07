Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6ED8C77B7A
	for <kexec@archiver.kernel.org>; Wed,  7 Jun 2023 20:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6r1W8xSPMiwvxz1dN0u3pYuU7w+5MLLI1n5kH3Kyxlg=; b=iBBollJMYHPaA3
	uaigoBTbR6aAbYL0Fj1FAYEYkKZLkREM4AxqQ+uBMQ/Y+o1IKwyrTDSbyGG+GfQAV5SHVNKBqlZEo
	oB9AUoWwhsUuI4LJoSWiCYVy4XMDBszspuSxNE4opuqhoYtHDq1RGmvqZnPPCf1JzZYYmqDsgcW2H
	zpN3lD10e8tuSGKIhq+Ddleg4K7WY7MpSejvib4hsBqYUl23G+Rne2bSqyUV1amihGMh/IgQrnuJ8
	rI7lA+BEmJY/96Nxm9Oy1ZZmV3LhaaSI2vEEkuL4SRt0CmsRk36XAbN7KWplMvkUBmvlsJBzcSd6z
	javah3MKj+N1eRl8YFqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q702r-007BAd-0e;
	Wed, 07 Jun 2023 20:46:17 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q702o-007B8c-1e
	for kexec@lists.infradead.org;
	Wed, 07 Jun 2023 20:46:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4D1D21A08;
	Wed,  7 Jun 2023 20:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1686170770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2X/4z9UYBzSMTV7e6BXpQiPPRmpVPkn6HQVqfRrAQo4=;
	b=It9MFa8lj8NbG+tYYqcdLFdgMcpVrEq1LzUE2UIXnHDDMbVAOJFiQFPM8Jhjt/2+oP5obE
	AoTbfz8sqSJjM74m+rStcDG5GUgASl5X/ii0oFzt8f0Kvt548rTHQNVJVeJNP2qTx/g/hh
	EdaWwKUKmGHhVGJE7/h/UrzyxJw1sDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1686170770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2X/4z9UYBzSMTV7e6BXpQiPPRmpVPkn6HQVqfRrAQo4=;
	b=l1IXYqHMoWJyykYWDl6Nb470g/LXhVrfw0k+jGnpjT70TqgKDizeBeMzkj92X5SLHhWIgc
	JMIe/NYsBVAnUkBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0D3A1346D;
	Wed,  7 Jun 2023 20:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id uEEhK5LsgGT2QQAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 07 Jun 2023 20:46:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3D9E5A0749; Wed,  7 Jun 2023 22:46:10 +0200 (CEST)
Date: Wed, 7 Jun 2023 22:46:10 +0200
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>,
	hch@infradead.org, sandeen@sandeen.net, song@kernel.org,
	rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jikos@kernel.org, bvanassche@acm.org,
	ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org,
	p.raghav@samsung.com, da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230607204610.5ai5cleks6qzjal7@quack3>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
 <20230525141430.slms7f2xkmesezy5@quack3>
 <20230607163110.GC72224@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230607163110.GC72224@frogsfrogsfrogs>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_134614_887229_853ED74B 
X-CRM114-Status: GOOD (  45.83  )
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

On Wed 07-06-23 09:31:10, Darrick J. Wong wrote:
> On Thu, May 25, 2023 at 04:14:30PM +0200, Jan Kara wrote:
> > On Mon 22-05-23 16:42:00, Darrick J. Wong wrote:
> > > How about this as an alternative patch?  Kernel and userspace freeze
> > > state are stored in s_writers; each type cannot block the other (though
> > > you still can't have nested kernel or userspace freezes); and the freeze
> > > is maintained until /both/ freeze types are dropped.
> > > 
> > > AFAICT this should work for the two other usecases (quiescing pagefaults
> > > for fsdax pmem pre-removal; and freezing fses during suspend) besides
> > > online fsck for xfs.
> > > 
> > > --D
> > > 
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > Subject: fs: distinguish between user initiated freeze and kernel initiated freeze
> > > 
> > > Userspace can freeze a filesystem using the FIFREEZE ioctl or by
> > > suspending the block device; this state persists until userspace thaws
> > > the filesystem with the FITHAW ioctl or resuming the block device.
> > > Since commit 18e9e5104fcd ("Introduce freeze_super and thaw_super for
> > > the fsfreeze ioctl") we only allow the first freeze command to succeed.
> > > 
> > > The kernel may decide that it is necessary to freeze a filesystem for
> > > its own internal purposes, such as suspends in progress, filesystem fsck
> > > activities, or quiescing a device prior to removal.  Userspace thaw
> > > commands must never break a kernel freeze, and kernel thaw commands
> > > shouldn't undo userspace's freeze command.
> > > 
> > > Introduce a couple of freeze holder flags and wire it into the
> > > sb_writers state.  One kernel and one userspace freeze are allowed to
> > > coexist at the same time; the filesystem will not thaw until both are
> > > lifted.
> > > 
> > > Inspired-by: Luis Chamberlain <mcgrof@kernel.org>
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > Yes, this is exactly how I'd imagine it. Thanks for writing the patch!
> > 
> > I'd just note that this would need rebasing on top of Luis' patches 1 and
> > 2. Also:
> > 
> > > +	if (sbw->frozen == SB_FREEZE_COMPLETE) {
> > > +		switch (who) {
> > > +		case FREEZE_HOLDER_KERNEL:
> > > +			if (sbw->freeze_holders & FREEZE_HOLDER_KERNEL) {
> > > +				/*
> > > +				 * Kernel freeze already in effect; caller can
> > > +				 * try again.
> > > +				 */
> > > +				deactivate_locked_super(sb);
> > > +				return -EBUSY;
> > > +			}
> > > +			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
> > > +				/*
> > > +				 * Share the freeze state with the userspace
> > > +				 * freeze already in effect.
> > > +				 */
> > > +				sbw->freeze_holders |= who;
> > > +				deactivate_locked_super(sb);
> > > +				return 0;
> > > +			}
> > > +			break;
> > > +		case FREEZE_HOLDER_USERSPACE:
> > > +			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
> > > +				/*
> > > +				 * Userspace freeze already in effect; tell
> > > +				 * the caller we're busy.
> > > +				 */
> > > +				deactivate_locked_super(sb);
> > > +				return -EBUSY;
> > > +			}
> > > +			if (sbw->freeze_holders & FREEZE_HOLDER_KERNEL) {
> > > +				/*
> > > +				 * Share the freeze state with the kernel
> > > +				 * freeze already in effect.
> > > +				 */
> > > +				sbw->freeze_holders |= who;
> > > +				deactivate_locked_super(sb);
> > > +				return 0;
> > > +			}
> > > +			break;
> > > +		default:
> > > +			BUG();
> > > +			deactivate_locked_super(sb);
> > > +			return -EINVAL;
> > > +		}
> > > +	}
> > 
> > Can't this be simplified to:
> > 
> > 	BUG_ON(who & ~(FREEZE_HOLDER_USERSPACE | FREEZE_HOLDER_KERNEL));
> > 	BUG_ON(!(!(who & FREEZE_HOLDER_USERSPACE) ^
> > 	       !(who & FREEZE_HOLDER_KERNEL)));
> > retry:
> > 	if (sb->s_writers.freeze_holders & who)
> > 		return -EBUSY;
> > 	/* Already frozen by someone else? */
> > 	if (sb->s_writers.freeze_holders & ~who) {
> > 		sb->s_writers.freeze_holders |= who;
> > 		return 0;
> > 	}
> > 
> > Now the only remaining issue with the code is that the two different
> > holders can be attempting to freeze the filesystem at once and in that case
> > one of them has to wait for the other one instead of returning -EBUSY as
> > would happen currently. This can happen because we temporarily drop
> > s_umount in freeze_super() due to lock ordering issues. I think we could
> > do something like:
> > 
> > 	if (!sb_unfrozen(sb)) {
> > 		up_write(&sb->s_umount);
> > 		wait_var_event(&sb->s_writers.frozen,
> > 			       sb_unfrozen(sb) || sb_frozen(sb));
> > 		down_write(&sb->s_umount);
> > 		goto retry;
> > 	}
> > 
> > and then sprinkle wake_up_var(&sb->s_writers.frozen) at appropriate places
> > in freeze_super().
> 
> If we implemented this behavior change, it ought to be a separate patch.
> 
> For the case where the kernel is freezing the fs and userspace wants to
> start freezing the fs, we could make userspace wait and then share the
> kernel freeze.

Yes.

> For any case where the fs is !unfrozen and the kernel wants to start
> freezing the fs, I think I'd rather return EBUSY immediately and let the
> caller decide to wait and/or call back.

Possibly, although I thought that if userspace has frozen the fs and kernel
wants to freeze, we want to return success? At least that was what I think
your patches were doing. And then I don't see the point why we should be
returning EBUSY if userspace is in the middle of the freeze. So what's the
intended semantics?
 
> For the case where one userspace thread is freezing the fs and another
> userspace thread wants to start freezing the fs, I think the current
> behavior of returning EBUSY immediately is ok.

Yes.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

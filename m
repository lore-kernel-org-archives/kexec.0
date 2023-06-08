Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC964C7EE23
	for <kexec@archiver.kernel.org>; Thu,  8 Jun 2023 18:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jAW5l8MgiScFpRdjOLBxfUIvZJgPTQzC7NBnJkm1vps=; b=okZwR8zP6JJ7fA
	t9b5w4B5BvcP6lYOPQgkKyZkcE34eDIebPCCgvAqOWCShvw+uTzPX8Tncdpl7WDEyWvZVo/G6zATR
	x2xmRjw32XTVycfumP7Ehd+ijFVTYo0jbrqg6arud2OV1jx1PcEUnWE1srBJqCxA1uJLY60zyhkXm
	zlSDvvlkWrd3NA1CJZKWTAzz1K870Ov525isTbDzdGO02UknFzyhU+eksTVbDNDanEpUVWT7X7B6G
	cFUIR6tsmOn0Sa0kma0CSK8fZwp+C/UMLnC/NUnIWkZg1HBwr4R3LMLWruPRF3lVkGD4UhTp6MfHL
	LfUKmPFVXk36eTI6wTAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7KqO-00AEYo-20;
	Thu, 08 Jun 2023 18:58:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7KqL-00AEXG-1A
	for kexec@lists.infradead.org;
	Thu, 08 Jun 2023 18:58:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DB50564036;
	Thu,  8 Jun 2023 18:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB61C433D2;
	Thu,  8 Jun 2023 18:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686250724;
	bh=uHg/XVAF9jYxWOLuWZSJJFiPg5lIJbrE91St+idXHIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EKhKb1UW9EfE4Jd6fPJD3yFCYzDbzgclfQ+S6m1GaLPl9WTUTE9UvwU06I9aXvuDD
	 1LVoU7kdg1zuwrcKMKVFTNHj/KEAuVsO4c7nDUqbi8ARYj8/Rhe3C15NJPCHc8pn7f
	 KjVuA5MvfJf0lQ1SOvJg1Q8IL8zr+FkOZ7MO3TbUN+SYQaymxhwwhPdlmiM68o+B6V
	 luutxZ/Dx9RQI6n8afEPHoTTFsM9m0v70Z7tvKOyL6AOOCXFJCX8IRXA2rH8aB2s2C
	 tubx+UYdKCdKJ2eUljIFLETZaFJXb1QnNoK9X8f3N76xJXICU9KCv7odtrESOCXY41
	 mycfZKBA2i9tw==
Date: Thu, 8 Jun 2023 11:58:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org,
	sandeen@sandeen.net, song@kernel.org, rafael@kernel.org,
	gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
	jikos@kernel.org, bvanassche@acm.org, ebiederm@xmission.com,
	mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
	da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
	kernel@tuxforce.de, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230608185843.GG72224@frogsfrogsfrogs>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
 <20230525141430.slms7f2xkmesezy5@quack3>
 <20230607163110.GC72224@frogsfrogsfrogs>
 <20230607204610.5ai5cleks6qzjal7@quack3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230607204610.5ai5cleks6qzjal7@quack3>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_115845_498214_99816E8A 
X-CRM114-Status: GOOD (  49.09  )
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

On Wed, Jun 07, 2023 at 10:46:10PM +0200, Jan Kara wrote:
> On Wed 07-06-23 09:31:10, Darrick J. Wong wrote:
> > On Thu, May 25, 2023 at 04:14:30PM +0200, Jan Kara wrote:
> > > On Mon 22-05-23 16:42:00, Darrick J. Wong wrote:
> > > > How about this as an alternative patch?  Kernel and userspace freeze
> > > > state are stored in s_writers; each type cannot block the other (though
> > > > you still can't have nested kernel or userspace freezes); and the freeze
> > > > is maintained until /both/ freeze types are dropped.
> > > > 
> > > > AFAICT this should work for the two other usecases (quiescing pagefaults
> > > > for fsdax pmem pre-removal; and freezing fses during suspend) besides
> > > > online fsck for xfs.
> > > > 
> > > > --D
> > > > 
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > Subject: fs: distinguish between user initiated freeze and kernel initiated freeze
> > > > 
> > > > Userspace can freeze a filesystem using the FIFREEZE ioctl or by
> > > > suspending the block device; this state persists until userspace thaws
> > > > the filesystem with the FITHAW ioctl or resuming the block device.
> > > > Since commit 18e9e5104fcd ("Introduce freeze_super and thaw_super for
> > > > the fsfreeze ioctl") we only allow the first freeze command to succeed.
> > > > 
> > > > The kernel may decide that it is necessary to freeze a filesystem for
> > > > its own internal purposes, such as suspends in progress, filesystem fsck
> > > > activities, or quiescing a device prior to removal.  Userspace thaw
> > > > commands must never break a kernel freeze, and kernel thaw commands
> > > > shouldn't undo userspace's freeze command.
> > > > 
> > > > Introduce a couple of freeze holder flags and wire it into the
> > > > sb_writers state.  One kernel and one userspace freeze are allowed to
> > > > coexist at the same time; the filesystem will not thaw until both are
> > > > lifted.
> > > > 
> > > > Inspired-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Yes, this is exactly how I'd imagine it. Thanks for writing the patch!
> > > 
> > > I'd just note that this would need rebasing on top of Luis' patches 1 and
> > > 2. Also:
> > > 
> > > > +	if (sbw->frozen == SB_FREEZE_COMPLETE) {
> > > > +		switch (who) {
> > > > +		case FREEZE_HOLDER_KERNEL:
> > > > +			if (sbw->freeze_holders & FREEZE_HOLDER_KERNEL) {
> > > > +				/*
> > > > +				 * Kernel freeze already in effect; caller can
> > > > +				 * try again.
> > > > +				 */
> > > > +				deactivate_locked_super(sb);
> > > > +				return -EBUSY;
> > > > +			}
> > > > +			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
> > > > +				/*
> > > > +				 * Share the freeze state with the userspace
> > > > +				 * freeze already in effect.
> > > > +				 */
> > > > +				sbw->freeze_holders |= who;
> > > > +				deactivate_locked_super(sb);
> > > > +				return 0;
> > > > +			}
> > > > +			break;
> > > > +		case FREEZE_HOLDER_USERSPACE:
> > > > +			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
> > > > +				/*
> > > > +				 * Userspace freeze already in effect; tell
> > > > +				 * the caller we're busy.
> > > > +				 */
> > > > +				deactivate_locked_super(sb);
> > > > +				return -EBUSY;
> > > > +			}
> > > > +			if (sbw->freeze_holders & FREEZE_HOLDER_KERNEL) {
> > > > +				/*
> > > > +				 * Share the freeze state with the kernel
> > > > +				 * freeze already in effect.
> > > > +				 */
> > > > +				sbw->freeze_holders |= who;
> > > > +				deactivate_locked_super(sb);
> > > > +				return 0;
> > > > +			}
> > > > +			break;
> > > > +		default:
> > > > +			BUG();
> > > > +			deactivate_locked_super(sb);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	}
> > > 
> > > Can't this be simplified to:
> > > 
> > > 	BUG_ON(who & ~(FREEZE_HOLDER_USERSPACE | FREEZE_HOLDER_KERNEL));
> > > 	BUG_ON(!(!(who & FREEZE_HOLDER_USERSPACE) ^
> > > 	       !(who & FREEZE_HOLDER_KERNEL)));
> > > retry:
> > > 	if (sb->s_writers.freeze_holders & who)
> > > 		return -EBUSY;
> > > 	/* Already frozen by someone else? */
> > > 	if (sb->s_writers.freeze_holders & ~who) {
> > > 		sb->s_writers.freeze_holders |= who;
> > > 		return 0;
> > > 	}
> > > 
> > > Now the only remaining issue with the code is that the two different
> > > holders can be attempting to freeze the filesystem at once and in that case
> > > one of them has to wait for the other one instead of returning -EBUSY as
> > > would happen currently. This can happen because we temporarily drop
> > > s_umount in freeze_super() due to lock ordering issues. I think we could
> > > do something like:
> > > 
> > > 	if (!sb_unfrozen(sb)) {
> > > 		up_write(&sb->s_umount);
> > > 		wait_var_event(&sb->s_writers.frozen,
> > > 			       sb_unfrozen(sb) || sb_frozen(sb));
> > > 		down_write(&sb->s_umount);
> > > 		goto retry;
> > > 	}
> > > 
> > > and then sprinkle wake_up_var(&sb->s_writers.frozen) at appropriate places
> > > in freeze_super().
> > 
> > If we implemented this behavior change, it ought to be a separate patch.
> > 
> > For the case where the kernel is freezing the fs and userspace wants to
> > start freezing the fs, we could make userspace wait and then share the
> > kernel freeze.
> 
> Yes.
> 
> > For any case where the fs is !unfrozen and the kernel wants to start
> > freezing the fs, I think I'd rather return EBUSY immediately and let the
> > caller decide to wait and/or call back.
> 
> Possibly, although I thought that if userspace has frozen the fs and kernel
> wants to freeze, we want to return success?

Yes.  Apologies, I tripped over the four-states-of-gray thing and forgot
that frozen != !unfrozen.

> At least that was what I think
> your patches were doing. And then I don't see the point why we should be
> returning EBUSY if userspace is in the middle of the freeze. So what's the
> intended semantics?

Let me try again:

"For the case where one kernel thread is freezing the fs and another
kernel thread wants to start freezing the fs, return -EBUSY immediately.

"For the case where userspace is freezing the fs and kernel wants to
start freezing the fs, return -EBUSY immediately.  Callers decide if
they want to sleep and/or retry the operation."

--D

> > For the case where one userspace thread is freezing the fs and another
> > userspace thread wants to start freezing the fs, I think the current
> > behavior of returning EBUSY immediately is ok.
> 
> Yes.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

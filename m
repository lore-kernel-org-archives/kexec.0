Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93172C7EE29
	for <kexec@archiver.kernel.org>; Thu,  8 Jun 2023 21:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M8sGFd5cKeQJ9JcFKzSJB8Ub+SQSq3eUHqtrYXTN4AU=; b=CoxC9N9eLfSMqq
	rVxpTXxfHQnIOhdm9MO6z/DzYVCMFr5T3+pOk1qBiz1yqrKZmEbVNrJ308WZdX2dACiqQ1bWY+GvZ
	mvpUahpM9FzJ+7ItnYVkPvhJ+KXnfnJ9XSIKoSXMXKumMg1nBZ99vsTKcKN71lc9OYH+Bz512Zou/
	k0a5tfPxZ9MG8OEl+pR3CqFp+KRHFVmoS30pnlzMjk9mYjAp+CDmAasb31Dk0Bm+ru5avDfqqgyii
	+i4SkxtWGyp22uvChqlQXFeB59ohUbaC4/Y51bVLhd0bFXzKTc+cPCJAGCJBiBvq1IWaKVJc/HPMa
	xDXR3HC4RYU4v6G4t4zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7Mtq-00Aebu-0z;
	Thu, 08 Jun 2023 21:10:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7Mtl-00AeZR-1u
	for kexec@lists.infradead.org;
	Thu, 08 Jun 2023 21:10:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D1CA6650EB;
	Thu,  8 Jun 2023 21:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F18DC433EF;
	Thu,  8 Jun 2023 21:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686258621;
	bh=XViKg2onIRHkaR3bxOXk8HIsG3cq5Z9NWQifOKWD3uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LrJNZN5vy4gUdsAb2fVJYPtTm+RrjguGIHksArF3V9UpzQ7/QYzdfe0ICwJLm7HhK
	 l/zCXRPqx9SlpEncrcdmXvVGmJuPekXlw7MZEiatQHSfHRZeNzM5Z5HhMGzyBYMjXt
	 MytLC1WfZVKClLuBonar3ZSzZnczZ6aBS+mGZ/LlaLrQW9mKPYzp92qrfGcXc+oh2s
	 dXBrugaDDr/XAhdowf3X6/pBBhA+TKsZ7WoIkAk3X7FZDzxsoRUXsOnVWPRFrn7EuL
	 v9N6ftiiqlvheEFmC56yYACeLIgbfCOnnb0MKvJNLkkVQ8K56SQISzHcVVIHOh09X0
	 Qm3Nzvz8YHyHQ==
Date: Thu, 8 Jun 2023 14:10:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@infradead.org, sandeen@sandeen.net, song@kernel.org,
	rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
	bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
	keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230608211020.GH72224@frogsfrogsfrogs>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
 <ZII5awqVCr9IUWtH@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZII5awqVCr9IUWtH@bombadil.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_141025_718595_1E351B45 
X-CRM114-Status: GOOD (  30.20  )
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

On Thu, Jun 08, 2023 at 01:26:19PM -0700, Luis Chamberlain wrote:
> On Mon, May 22, 2023 at 04:42:00PM -0700, Darrick J. Wong wrote:
> > How about this as an alternative patch?
> 
> I'm all for it, this is low hanging fruit and I try to get back to it
> as no one else does, so I'm glad someone else is looking and trying too!
> 
> Hopefully dropping patch 1 and 2 would help with this.
> 
> Comments below.
> 
> > From: Darrick J. Wong <djwong@kernel.org>
> > Subject: fs: distinguish between user initiated freeze and kernel initiated freeze
> > 
> > Userspace can freeze a filesystem using the FIFREEZE ioctl or by
> > suspending the block device; this state persists until userspace thaws
> > the filesystem with the FITHAW ioctl or resuming the block device.
> > Since commit 18e9e5104fcd ("Introduce freeze_super and thaw_super for
> > the fsfreeze ioctl") we only allow the first freeze command to succeed.
> > 
> > The kernel may decide that it is necessary to freeze a filesystem for
> > its own internal purposes, such as suspends in progress, filesystem fsck
> > activities, or quiescing a device prior to removal.  Userspace thaw
> > commands must never break a kernel freeze, and kernel thaw commands
> > shouldn't undo userspace's freeze command.
> > 
> > Introduce a couple of freeze holder flags and wire it into the
> > sb_writers state.  One kernel and one userspace freeze are allowed to
> > coexist at the same time; the filesystem will not thaw until both are
> > lifted.
> 
> This mix-match stuff is also important to document so we can get
> userspace to understand what is allowed and we get a sense of direction
> written / documented. Without this trying to navigate around this is
> all implied. We may need to adjust things with time for thing we may
> not have considered.

That's captured in the kernledoc for freeze_super, which is no longer
getting cut up into __freeze_super here.

> > -int freeze_super(struct super_block *sb)
> > +static int __freeze_super(struct super_block *sb, unsigned short who)
> >  {
> > +	struct sb_writers *sbw = &sb->s_writers;
> >  	int ret;
> >  
> >  	atomic_inc(&sb->s_active);
> >  	down_write(&sb->s_umount);
> > +
> > +	if (sbw->frozen == SB_FREEZE_COMPLETE) {
> > +		switch (who) {
> 
> <-- snip -->
> 
> > +		case FREEZE_HOLDER_USERSPACE:
> > +			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
> > +				/*
> > +				 * Userspace freeze already in effect; tell
> > +				 * the caller we're busy.
> > +				 */
> > +				deactivate_locked_super(sb);
> > +				return -EBUSY;
> 
> I'm thinking some userspace might find this OK so thought maybe
> something like -EALREADY would be better, to then allow userspace
> to decide, however, since userspace would not control the thaw it
> seems like risky business to support that.

It already has to, since we've been returning EBUSY for "fs already
frozen or being frozen" for years.

--D

> Anyway, I'm all for any alternative!
> 
>   Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

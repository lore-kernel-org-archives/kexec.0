Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07644C77B7A
	for <kexec@archiver.kernel.org>; Wed,  7 Jun 2023 09:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bSwDzLE/70t0Ot6TxaHAcP5pGhZ57Nzau5m+QR4hfl8=; b=4jL36GGQFisHBw
	KSKlqM6WOPdyNTvGBDnXh0dXoSZWn7ITJIbGFzQ2X9vI72VaoJcXlXWNt+1bSs7/6MuMbAxePHpYf
	urRsbGg8o4HYVn0ZiwOGzIS1kW+eF/6GxxQdtcZidDvcHftNpK5Ij+f8wUWc+goyn0GPbV4exodpB
	jSEXaJsfpQjnMW0ChLHqYa7YvSSoycbD33pAC0rKHPodSr1DZnR37Qa6kpwaVX+fGj/MOsHKYQM0f
	k2U1RTFsfODFhazzjIOE5nU9BzMONsGnraR/gGJ94fyfWee+kp5GCVZIzcTWreoTbDjjADniVIRR3
	H9hfAJCYVbtoO4fGNYBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pNX-005DhI-1C;
	Wed, 07 Jun 2023 09:22:55 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pNP-005De5-2q
	for kexec@lists.infradead.org;
	Wed, 07 Jun 2023 09:22:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B8B6219ED;
	Wed,  7 Jun 2023 09:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1686129763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+xmm9N3/kE9fARhRBP0LiA7CIzmRQkipEC+sYe+B3k=;
	b=y3VOJn2TRRKjjRkdSJ1iUbihKZp6Ob+x089BsmHH3+wVC55TDZyVwAUpdnSt88UVYDh4vD
	4RrPo5X9Cn7n4kFAWcrmY4QLpcPeo0OoqgJqODx/opSSeFRQgirfNtaxhHTFutiyLJ8THJ
	lqCOAXCpDis81FJyBm2BrO1zRDWzZHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1686129763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+xmm9N3/kE9fARhRBP0LiA7CIzmRQkipEC+sYe+B3k=;
	b=3yPk9TzubQ5ImsV9i/YbCe1+UZv1/xKVQNGTYhmqpXf65iVbOtvpxDOE8Jff1ovPPObgsO
	C6PtmHleNezIM3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F1FF13776;
	Wed,  7 Jun 2023 09:22:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id IMX5HmNMgGRmXAAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 07 Jun 2023 09:22:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 11A25A0754; Wed,  7 Jun 2023 11:22:43 +0200 (CEST)
Date: Wed, 7 Jun 2023 11:22:43 +0200
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
Message-ID: <20230607092243.kv5yxaq3x7kni2yf@quack3>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
 <20230525141430.slms7f2xkmesezy5@quack3>
 <20230606171956.GG72267@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606171956.GG72267@frogsfrogsfrogs>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_022248_112434_B1D9561A 
X-CRM114-Status: GOOD (  36.38  )
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

On Tue 06-06-23 10:19:56, Darrick J. Wong wrote:
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
> 
> I started doing that, but I noticed that after patch 1, freeze_super no
> longer leaves s_active elevated if the freeze is successful.  The
> callers drop the s_active ref that they themselves obtained, which
> means that we've now changed that behavior, right?  ioctl_fsfreeze now
> does:
> 
> 	if (!get_active_super(sb->s_bdev))
> 		return -ENOTTY;
> 
> (Increase ref)
> 
>         /* Freeze */
>         if (sb->s_op->freeze_super)
> 		ret = sb->s_op->freeze_super(sb);
> 	ret = freeze_super(sb);
> 
> (Not sure why we can do both here?)
> 
> 	deactivate_locked_super(sb);
> 
> (Decrease ref; net change to s_active is zero)
> 
> 	return ret;
> 
> Luis hasn't responded to my question, so I stopped.

Right. I kind of like how he's moved the locking out of freeze_super() /
thaw_super() but I agree this semantic change is problematic and needs much
more thought - e.g. with Luis' version the fs could be unmounted while
frozen which is going to spectacularly deadlock. So yeah let's just ignore
patch 1 for now.

Longer term I believe if the sb is frozen by userspace, we should refuse to
unmount it but that's a separate discussion for some other time.

> > BTW, when reading this code, I've spotted attached cleanup opportunity but
> > I'll queue that separately so that is JFYI.
> > 
> > > +#define FREEZE_HOLDER_USERSPACE	(1U << 1)	/* userspace froze fs */
> > > +#define FREEZE_HOLDER_KERNEL	(1U << 2)	/* kernel froze fs */
> > 
> > Why not start from 1U << 0? And bonus points for using BIT() macro :).
> 
> I didn't think filesystem code was supposed to be using stuff from
> vdso.h...

Hum, so BIT() macro is quite widely used in include/linux/ (from generic
headers e.g. in trace.h). include/linux/bits.h seems to be the right
include to use but I'm pretty sure include/linux/fs.h already gets this
header through something.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

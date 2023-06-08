Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFCDC7EE43
	for <kexec@archiver.kernel.org>; Thu,  8 Jun 2023 20:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+CwEmJhaBJrCw0PH4nGRn7/5RqyCjD9l7LlmzMHSVUQ=; b=w1SZc9QbkkgR7R
	sWDAvvsGaTX7beREJ5msaKAPtlvzONnwuB8RpbhFf9101n3E6D/i2EKD2Gg49Hmx4o5pSdGmDKs4i
	y5fTGxXh13t/M5FbveMTq9ide49agPG2l1weZEjOYp/YFMrunpVt+hEyQTLBAveO0LFocJird+hTx
	svpxu02SM6Ueaggrrv4sPiWdmqM4B3q4M6qTSs0lqnWNwU53ruOdWM1tIyBisshRt+mQMOsuhPsOS
	x6Ful1fMDdAApVkFAS8siCjPKU0ESulIfPLmpJc/qpYod2DqdYkS9SiJ3XWxGAJsNARddGHY512wX
	xVd1prQCoX1mAU49hD0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7MD9-00AXnZ-2Z;
	Thu, 08 Jun 2023 20:26:23 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q7MD5-00AXn7-2h;
	Thu, 08 Jun 2023 20:26:19 +0000
Date: Thu, 8 Jun 2023 13:26:19 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@infradead.org, sandeen@sandeen.net, song@kernel.org,
	rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
	bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
	keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <ZII5awqVCr9IUWtH@bombadil.infradead.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230522234200.GC11598@frogsfrogsfrogs>
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

On Mon, May 22, 2023 at 04:42:00PM -0700, Darrick J. Wong wrote:
> How about this as an alternative patch?

I'm all for it, this is low hanging fruit and I try to get back to it
as no one else does, so I'm glad someone else is looking and trying too!

Hopefully dropping patch 1 and 2 would help with this.

Comments below.

> From: Darrick J. Wong <djwong@kernel.org>
> Subject: fs: distinguish between user initiated freeze and kernel initiated freeze
> 
> Userspace can freeze a filesystem using the FIFREEZE ioctl or by
> suspending the block device; this state persists until userspace thaws
> the filesystem with the FITHAW ioctl or resuming the block device.
> Since commit 18e9e5104fcd ("Introduce freeze_super and thaw_super for
> the fsfreeze ioctl") we only allow the first freeze command to succeed.
> 
> The kernel may decide that it is necessary to freeze a filesystem for
> its own internal purposes, such as suspends in progress, filesystem fsck
> activities, or quiescing a device prior to removal.  Userspace thaw
> commands must never break a kernel freeze, and kernel thaw commands
> shouldn't undo userspace's freeze command.
> 
> Introduce a couple of freeze holder flags and wire it into the
> sb_writers state.  One kernel and one userspace freeze are allowed to
> coexist at the same time; the filesystem will not thaw until both are
> lifted.

This mix-match stuff is also important to document so we can get
userspace to understand what is allowed and we get a sense of direction
written / documented. Without this trying to navigate around this is
all implied. We may need to adjust things with time for thing we may
not have considered.

> -int freeze_super(struct super_block *sb)
> +static int __freeze_super(struct super_block *sb, unsigned short who)
>  {
> +	struct sb_writers *sbw = &sb->s_writers;
>  	int ret;
>  
>  	atomic_inc(&sb->s_active);
>  	down_write(&sb->s_umount);
> +
> +	if (sbw->frozen == SB_FREEZE_COMPLETE) {
> +		switch (who) {

<-- snip -->

> +		case FREEZE_HOLDER_USERSPACE:
> +			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
> +				/*
> +				 * Userspace freeze already in effect; tell
> +				 * the caller we're busy.
> +				 */
> +				deactivate_locked_super(sb);
> +				return -EBUSY;

I'm thinking some userspace might find this OK so thought maybe
something like -EALREADY would be better, to then allow userspace
to decide, however, since userspace would not control the thaw it
seems like risky business to support that.

Anyway, I'm all for any alternative!

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

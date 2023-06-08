Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA389C7EE23
	for <kexec@archiver.kernel.org>; Thu,  8 Jun 2023 05:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=40AOio4Qo/W25wyqUlqVf8RAVYOAUMPFX08CXNlNdEA=; b=qI4kaLifvmP8Oh
	XNWR5/It0xukYuEOxK+Aoy5OZq3mneGsOmnZ1KrSprnwNvrBVNDZtxTJvk07p3xiS5YSf/igcKt6e
	piERwrVi0EmSTlEFCL7Y/Ge3slhhfVVcN1+X9t3j0fW6siKYlImoDpNOWYXsdHtUxUk1t3u6UYLKV
	bwVx5uJohuOik5STfU0isVs4A8jVWp0jIrhkM9iPMrLvoeYhXx4ExKsIkJjTgFpRcCnQ5twbQDOqt
	qey+EU9qzGt4iQ7PKJVTQxFioYNbNfLs1371roiGJmAsO5ZTzNL+05rSBW0iflboEaFQl+aDQ7NN6
	Gloe55yDVaiy4aNbIMZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q78Cp-0089Eg-0q;
	Thu, 08 Jun 2023 05:29:07 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q78Cm-0089EH-1Y;
	Thu, 08 Jun 2023 05:29:04 +0000
Date: Wed, 7 Jun 2023 22:29:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org,
	sandeen@sandeen.net, song@kernel.org, rafael@kernel.org,
	gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
	jikos@kernel.org, bvanassche@acm.org, ebiederm@xmission.com,
	mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
	da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
	kernel@tuxforce.de, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <ZIFnID9ZNpd7zrNa@infradead.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
 <20230525141430.slms7f2xkmesezy5@quack3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230525141430.slms7f2xkmesezy5@quack3>
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

On Thu, May 25, 2023 at 04:14:30PM +0200, Jan Kara wrote:
> Yes, this is exactly how I'd imagine it. Thanks for writing the patch!
> 
> I'd just note that this would need rebasing on top of Luis' patches 1 and
> 2. Also:

I'd not do that for now.  1 needs a lot more work, and 2 seems rather
questionable.

> Now the only remaining issue with the code is that the two different
> holders can be attempting to freeze the filesystem at once and in that case
> one of them has to wait for the other one instead of returning -EBUSY as
> would happen currently. This can happen because we temporarily drop
> s_umount in freeze_super() due to lock ordering issues. I think we could
> do something like:
> 
> 	if (!sb_unfrozen(sb)) {
> 		up_write(&sb->s_umount);
> 		wait_var_event(&sb->s_writers.frozen,
> 			       sb_unfrozen(sb) || sb_frozen(sb));
> 		down_write(&sb->s_umount);
> 		goto retry;
> 	}
> 
> and then sprinkle wake_up_var(&sb->s_writers.frozen) at appropriate places
> in freeze_super().

Let's do that separately as a follow on..

> 
> BTW, when reading this code, I've spotted attached cleanup opportunity but
> I'll queue that separately so that is JFYI.
> 
> > +#define FREEZE_HOLDER_USERSPACE	(1U << 1)	/* userspace froze fs */
> > +#define FREEZE_HOLDER_KERNEL	(1U << 2)	/* kernel froze fs */
> 
> Why not start from 1U << 0? And bonus points for using BIT() macro :).

BIT() is a nasty thing and actually makes code harder to read. And it
doesn't interact very well with the __bitwise annotation that might
actually be useful here.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

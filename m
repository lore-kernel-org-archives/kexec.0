Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53413C004D4
	for <kexec@archiver.kernel.org>; Wed, 18 Jan 2023 09:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X3bZMiCHlv9zSDyu19BQK4hUzZl9B2la32VOMYOfYsw=; b=yMSr2iDzVxsEaX
	xln2GnelHUdtdWqHhzoBErY8JzPLFIJBo34AvQrJkxx7Rea85m3ZEhmh/odTdTavFRB0bMxRML5qc
	DllcSoc4gj5xJ3XBsExhn1GUGWWx+itqQOaeIYczjg4iAisvpw8xR777RJJKocg6iY+I8qq+eaLTh
	tVdCz+HbgZK7ta7ZAfB37jO+8ik/B294NACgE+yCE0LmlOEPH68aza7q68jZ8cXVCu6y/Efb1+xm/
	qcyF+bzcDo6oSj9kekgsUPXtO8/WyaAojaqT3ZWeqCPgY3jKKSm/ck1XEpG6agI4F5e//kmmFH+sy
	YGjVywXScWEBFsKpDwRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI4k0-0007Mz-SK; Wed, 18 Jan 2023 09:28:20 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI4jy-0007KR-0S
	for kexec@lists.infradead.org; Wed, 18 Jan 2023 09:28:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D114C3EC2F;
	Wed, 18 Jan 2023 09:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1674034094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUsADbHHhbF3+iRirD38aung5TJEhF+NitEiQGxyElk=;
	b=WtBb5x68i+kgdj5rIe9oOMm3j2eFxHYFTKUce3+sSYZ+e05OKTheZ0sYDkj5WVP4Hwe/8K
	QAcieeizwYHpiP2a0INYRKv2PhqYrFheMTCsNFEDwdUSBYcWvQuJL/U03Xi9USxGvFRZwH
	3KKgeJxjavOZ7ZwU7w4JczgqVqElM5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1674034094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUsADbHHhbF3+iRirD38aung5TJEhF+NitEiQGxyElk=;
	b=Fs8/sMuj8JJZsofEJTyRfdehftt6tZAP6OMz7klPmw9kb9C2wkDTvnpWKM+dUWaIC03mf8
	PpZ+6ivzv8lhBhBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70469139D2;
	Wed, 18 Jan 2023 09:28:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jj1kG667x2MMOAAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 18 Jan 2023 09:28:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3F58DA06B2; Wed, 18 Jan 2023 10:28:12 +0100 (CET)
Date: Wed, 18 Jan 2023 10:28:12 +0100
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org,
	song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
	ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org,
	kernel@tuxforce.de, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [RFC v3 03/24] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230118092812.2gl3cde6mocbngli@quack3>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-4-mcgrof@kernel.org>
 <Y8dYpOyR/jOsO267@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8dYpOyR/jOsO267@magnolia>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_012818_210855_1A74C4FA 
X-CRM114-Status: GOOD (  21.61  )
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

On Tue 17-01-23 18:25:40, Darrick J. Wong wrote:
> [add linux-xfs to cc on this one]
> 
> On Fri, Jan 13, 2023 at 04:33:48PM -0800, Luis Chamberlain wrote:
> > Userspace can initiate a freeze call using ioctls. If the kernel decides
> > to freeze a filesystem later it must be able to distinguish if userspace
> > had initiated the freeze, so that it does not unfreeze it later
> > automatically on resume.
> 
> Hm.  Zooming out a bit here, I want to think about how kernel freezes
> should behave...
> 
> > Likewise if the kernel is initiating a freeze on its own it should *not*
> > fail to freeze a filesystem if a user had already frozen it on our behalf.
> 
> ...because kernel freezes can absorb an existing userspace freeze.  Does
> that mean that userspace should be prevented from undoing a kernel
> freeze?  Even in that absorption case?
> 
> Also, should we permit multiple kernel freezes of the same fs at the
> same time?  And if we do allow that, would they nest like freeze used to
> do?
> 
> (My suggestions here are 'yes', 'yes', and '**** no'.)

Yeah, makes sense to me. So I think the mental model to make things safe
is that there are two flags - frozen_by_user, frozen_by_kernel - and the
superblock is kept frozen as long as either of these is set.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

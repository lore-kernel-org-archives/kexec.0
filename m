Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EBCC77B75
	for <kexec@archiver.kernel.org>; Sun,  7 May 2023 04:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ICbuV9DaRWqJIh0ou+SvaSppa/eyvFSib+t6ZQrVuBE=; b=4Q+5QkYa2qwUye
	hi4KQfleq8Y0Wlc5AQc2ttrG4Xn7YoN3XIR+qkfjmgxuD6KaA/7sfcanwE+vYYZvtGRMw5mpf4g7I
	tCp+gSuNlsS93Gx0p0No6WZ3D8tMaNorI5atftjGPg2KY5Qg89lCGDwxpfbAObEdcnX+uQaU8GR8F
	ywad1SgzawlkRAh7+KuFnBCqXwXLXt1jPOVbPXUz8THDCD7DDuYvFniBCu89GGqGaYcQUP0FaHl41
	ikKXJH7lQZ4l4rcijF3IkIrwDbe5np0+vl7ycFRcGRn8EPe4RPrglb4GkzJ+5NyzFEp2QjLfmPPMI
	EPtvijGnct/8DqI/H86Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvVhM-00F7aF-0k;
	Sun, 07 May 2023 04:08:36 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pvVhL-00F7Zt-0g;
	Sun, 07 May 2023 04:08:35 +0000
Date: Sat, 6 May 2023 21:08:35 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>, hch@infradead.org,
	song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, bvanassche@acm.org, ebiederm@xmission.com,
	mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: [RFC v3 03/24] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <ZFckQz3udm48kprc@bombadil.infradead.org>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-4-mcgrof@kernel.org>
 <Y8dYpOyR/jOsO267@magnolia>
 <20230118092812.2gl3cde6mocbngli@quack3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230118092812.2gl3cde6mocbngli@quack3>
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

On Wed, Jan 18, 2023 at 10:28:12AM +0100, Jan Kara wrote:
> On Tue 17-01-23 18:25:40, Darrick J. Wong wrote:
> > [add linux-xfs to cc on this one]
> > 
> > On Fri, Jan 13, 2023 at 04:33:48PM -0800, Luis Chamberlain wrote:
> > > Userspace can initiate a freeze call using ioctls. If the kernel decides
> > > to freeze a filesystem later it must be able to distinguish if userspace
> > > had initiated the freeze, so that it does not unfreeze it later
> > > automatically on resume.
> > 
> > Hm.  Zooming out a bit here, I want to think about how kernel freezes
> > should behave...
> > 
> > > Likewise if the kernel is initiating a freeze on its own it should *not*
> > > fail to freeze a filesystem if a user had already frozen it on our behalf.
> > 
> > ...because kernel freezes can absorb an existing userspace freeze.  Does
> > that mean that userspace should be prevented from undoing a kernel
> > freeze?  Even in that absorption case?
> > 
> > Also, should we permit multiple kernel freezes of the same fs at the
> > same time?  And if we do allow that, would they nest like freeze used to
> > do?
> > 
> > (My suggestions here are 'yes', 'yes', and '**** no'.)
> 
> Yeah, makes sense to me. So I think the mental model to make things safe
> is that there are two flags - frozen_by_user, frozen_by_kernel - and the
> superblock is kept frozen as long as either of these is set.

Makes sense to me.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

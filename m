Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5414EC54EBE
	for <kexec@archiver.kernel.org>; Tue, 10 Jan 2023 02:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=efekdmE7A9Z+XZKILiszgEqAPe1AeuhGFlzrpPRE3xM=; b=EfbLKk1G2vqpmG
	pmjdRiROl92a4kKyqRIYkr1WkTXITlcpcHij1AQOaGu/z4wpjpVz6aCQ6rcLlgbgKSpKjif1MDkP1
	XnPXiBcZDuLjQOPD8iCgmzP9gr9sDjiKDIOhJ+xQfA0Bwa96fotXpGFrkvfCVlxJ2UHChtxUSJebJ
	u0AxkH06Az8TLHuvwy8/1eMTn362mBi/XbQ3q1pEgzSex0E9Ql+1c3rsQAxj2sYDRe9cEKv/PazSI
	K6EihFJ5P8+DR/gvzll5RLxHbEX8mp2eOQZHsmSq3gipl4P2rgWHPyjdynzZUmkCxFXJyLiOMI5wr
	ujepio0QHzA+m3+/GFKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF47A-004wa3-23; Tue, 10 Jan 2023 02:11:48 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF473-004wY4-Su; Tue, 10 Jan 2023 02:11:41 +0000
Date: Mon, 9 Jan 2023 18:11:41 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: rafael@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, bvanassche@acm.org, jeyu@kernel.org,
	ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC v2 6/6] fs: add automatic kernel fs freeze / thaw and
 remove kthread freezing
Message-ID: <Y7zJXRw2w6c0fFzY@bombadil.infradead.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
 <20210417001026.23858-7-mcgrof@kernel.org>
 <20210420125903.GC3604224@infradead.org>
 <20210420184703.GN4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210420184703.GN4332@42.do-not-panic.com>
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

On Tue, Apr 20, 2021 at 06:47:03PM +0000, Luis Chamberlain wrote:
> On Tue, Apr 20, 2021 at 01:59:03PM +0100, Christoph Hellwig wrote:
> > > This also removes all the superflous freezer calls on all filesystems
> > > as they are no longer needed as the VFS now performs filesystem
> > > freezing/thaw if the filesystem has support for it. The filesystem
> > > therefore is in charge of properly dealing with quiescing of the
> > > filesystem through its callbacks.
> > 
> > Can you split that out from the main logic change?  Maybe even into one
> > patch per file system?
> 
> The issue with this is that once you do the changes in pm to
> freeze/suspend, if you leave the other changes in for the filesystems
> freeze / resume will stall, so all this needs to be an atomic operation
> if we want bisectable kernels.

So I'm thinking one way to split this up is to add an internal sb
flag for *if* a fs has support for this, and if so then we use the
generic fs freezer solution.

I'm not however too keen on the idea of mix and matching filesystems
on top of each other with different solutions, *but* if this makes it
easier for review / integration - it may be worth it. Let me know.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
